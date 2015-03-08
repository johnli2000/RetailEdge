unit Security;

interface

uses Windows, Messages, SysUtils, Classes, Controls, ExtCtrls, StdCtrls, OleCtrls,
     Variants, Registry;
     //, Security1;

Const
 sInvalidActivationKey = 'yek noitavitca dilavni';

 sLocalSetting = 'Australia';
 // sLocalSetting = 'Singapore';

 MAX_HOSTNAME_LEN               = 128; { from IPTYPES.H }
 MAX_DOMAIN_NAME_LEN            = 128;
 MAX_SCOPE_ID_LEN               = 256;
 MAX_ADAPTER_NAME_LENGTH        = 256;
 MAX_ADAPTER_DESCRIPTION_LENGTH = 128;
 MAX_ADAPTER_ADDRESS_LENGTH     = 8;
 sExpireDays = 15;
 ID_BIT = $200000;                    // EFLAGS ID bit

type

  TIPAddressString = array[0..4 * 4 - 1] of Char;
  PIPAddrString = ^TIPAddrString;

  TIPAddrString = Record
    Next      : PIPAddrString;
    IPAddress : TIPAddressString;
    IPMask    : TIPAddressString;
    Context   : Integer;
  end;

  PFixedInfo = ^TFixedInfo;

  TFixedInfo = Record { FIXED_INFO }
    HostName         : array[0..MAX_HOSTNAME_LEN + 3] of Char;
    DomainName       : array[0..MAX_DOMAIN_NAME_LEN + 3] of Char;
    CurrentDNSServer : PIPAddrString;
    DNSServerList    : TIPAddrString;
    NodeType         : Integer;
    ScopeId          : array[0..MAX_SCOPE_ID_LEN + 3] of Char;
    EnableRouting    : Integer;
    EnableProxy      : Integer;
    EnableDNS        : Integer;
  end;

  PIPAdapterInfo = ^TIPAdapterInfo;

  TIPAdapterInfo = Record { IP_ADAPTER_INFO }
    Next                : PIPAdapterInfo;
    ComboIndex          : Integer;
    AdapterName         : Array[0..MAX_ADAPTER_NAME_LENGTH + 3] of Char;
    Description         : Array[0..MAX_ADAPTER_DESCRIPTION_LENGTH + 3] of Char;
    AddressLength       : Integer;
    Address             : Array[1..MAX_ADAPTER_ADDRESS_LENGTH] of Byte;
    Index               : Integer;
    _Type               : Integer;
    DHCPEnabled         : Integer;
    CurrentIPAddress    : PIPAddrString;
    IPAddressList       : TIPAddrString;
    GatewayList         : TIPAddrString;
    DHCPServer          : TIPAddrString;
    HaveWINS            : Bool;
    PrimaryWINSServer   : TIPAddrString;
    SecondaryWINSServer : TIPAddrString;
    LeaseObtained       : Integer;
    LeaseExpires        : Integer;
  end;

  MacAddressType = Record
   MacAddr: array [1..16] of integer;
  end;

  RegistryInfoType = Record
    Date1, Date2: double;
    SerialNo: Integer;
  end;

  TSecurityForm = class(TDataModule)
    SecurityTimer: TTimer;
    procedure InitSystemConst;
    function  GetNetWorkAdapters: boolean;
    function  TestOldDongle: boolean;
    //function  TestNewDongle: boolean;
    function  TestSoftDog: boolean;
    function  ReadRegistryRecord: boolean;
    function  SaveRegistryRecord: boolean;
    function  TestSerialNo: boolean;
    procedure SaveRegistFile(SerialNo: integer);
    function  GetExpireDate: Integer;
    function  GenerateSecureCode(SystemID: integer): integer;
    function  DecodeSecurityCode(OriginalCode: Integer): string;
    function  GetActiveCode: string;
    procedure SecurityTimerTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
//    function  ReadRegistKey: boolean;
//    function  WriteRegistKey: boolean;
    function  AdjustPrivilege: boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SecurityForm: TSecurityForm;
  DogAddr: integer;
  DogBytes: integer;
  DogData: ^byte;
  RegistryRec: RegistryInfoType;
  IsMasterKey: boolean;
  sRegistName: string;
  sRegistFileName, sOldRegistFileName: string;
  SystemSecureCode: integer;
  MasterDongleSecureCode: string;
  SlaveDongleSecureCode: string;
  TheReg: TRegistry;
  KeyName: string;
  DefaultMacAddress: integer;
  MacAddrList: MacAddressType;

implementation

uses Regist, MessageBox, DataUnit;

function WriteDog: longint; external;
function ReadDog: longint; external;

function sendarp(ipaddr:ulong; temp:dword; ulmacaddr:pointer;
         ulmacaddrleng:pointer) : DWord; StdCall; External 'Iphlpapi.dll' Name 'SendARP';
function GetAdaptersInfo(AI : PIPAdapterInfo; Var BufLen : Integer) : Integer;
         StdCall; External 'iphlpapi.dll' Name 'GetAdaptersInfo';

{$L rgdlw32d.obj}
{$R *.dfm}

procedure TSecurityForm.InitSystemConst;
var
 SysDir: array[0..$FF] of Char;
begin
 GetSystemDirectory(SysDir, SizeOf(SysDir));
 if sLocalSetting = 'Australia' then
    begin // For Australia
     sRegistName := 'ABN';
     //sRegistFileName := SysDir + '\HHSPTLT.SYS';
     sRegistFileName :=SysDir + '\PosVision.Sys';
     sOldRegistFileName := SysDir + '\HSPTLT.SYS';
     //SystemSecureCode := 25096;
     SystemSecureCode := 59180875;
     MasterDongleSecureCode := 'charles15096';
     SlaveDongleSecureCode := 'charles25096';
    end
   else
    begin // For Singapure
     sRegistName := 'Biz. Reg No.';
     sRegistFileName := SysDir + '\HSPTLTPS.SYS';
     sOldRegistFileName := SysDir + '\HSPTLTPS.SYS';
     SystemSecureCode := 69052;
     MasterDongleSecureCode := 'charles55096';
     SlaveDongleSecureCode := 'charles55096';
    end;
end;

function TSecurityForm.TestOldDongle: boolean;
var
 StatusFlag: integer;
 DogSerialNumber: Longint;
 DogDataBuffer: array [1..12] of char;
begin
 Result := False;
 DogBytes := 0; {if you want to Read SerialNo DogBytes must be 0}
 DogAddr := 0;
 DogData := @ DogSerialNumber;
 StatusFlag := ReadDog();
 if (StatusFlag = 0) and (DogSerialNumber = 204664) then
    begin
     DogData := @DogDataBuffer[1];
     DogAddr := 0;
     DogBytes := 12;
     StatusFlag := ReadDog();
     if (StatusFlag = 0) and
        ((DogDataBuffer = MasterDongleSecureCode ) or (DogDataBuffer = SlaveDongleSecureCode)) then
        begin
         IsMasterKey := DogDataBuffer = MasterDongleSecureCode;
         Result := True;
        end;
    end;
end;

{function TSecurityForm.TestNewDongle: boolean;
var
 initdata : SKI;
 UserID: DWORD;
 hKey: THandle;
 rc: BOOL;
 Index: Integer;
 Length: Integer;
 Buffer: array[1..512] of Char;
 szOUT: string;
 i: Integer;
begin
 Result := False;
 //初始化
 initdata.cbSize := sizeof(SKI);
 initdata.KeyMode := KM_HID;  //模式 HID = KM_HID; 有驱 = KM_DRIVER;
 initdata.sdkVersion := 1;  //SDK版本
 initdata.bUseSessionKey := true;
 SK_Init(@initdata);
    //打开
 UserID := 20061; //用户ID
 hKey := SK_Open(UserID, nil);
 if (hKey <> INVALID_HANDLE_VALUE) then
    begin //读公共区
     Index := 0;  //索引值
     Length := 12;  //长度
     rc := SK_ReadPublicMemory(hKey, Index, @Buffer, Length);
     if (rc <> false) then
        begin  //关闭
         SK_Close(hKey);
         szOUT := '';
         for i := 1 to Length do szOUT := szOUT + Buffer[i];
         if ((szOUT = MasterDongleSecureCode ) or (szOUT = SlaveDongleSecureCode)) then
            begin
             IsMasterKey := szOUT = MasterDongleSecureCode;
             Result := True;
            end;
        end;
    end;
end;

}
function TSecurityForm.TestSoftDog: boolean;
begin
 Result := TestOldDongle; //or TestNewDongle;
end;

function TSecurityForm.GetNetworkAdapters: boolean;
var
 AI, Work : PIPAdapterInfo;
 Size, Res, I, Temp: Integer;
 function MACToStr(ByteArr : PByte; Len : Integer) : integer;
  var
   DD: array [0..7] of Byte;
   J: Integer;
  begin
   J := 2;
   while (Len > 0) do
    begin
     DD[J] := ByteArr^;
     Inc(J);
     ByteArr := Pointer(Integer(ByteArr) + SizeOf(Byte));
     Dec(Len);
    end;
   if sLocalSetting = 'Australia' then  // For Australia
      {Result := (DD[7] + 1) * 1111111 +
                (DD[6] + 2) * 2222222 +
                (DD[5] + 3) * 333333 +
                (DD[4] + 4) * 44444 +
                (DD[3]) }
      Result := (DD[7] + 1 ) * 2222222 +
                (DD[6] + 1 ) * 444444 +
                (DD[5] + 1 ) * 66666 +
                (DD[4] + 1 ) * 8888 +
                (DD[3])
     else // For Singapore
      Result := (DD[7] + 1) * 1111111 +
                (DD[6] + 2) * 333333 +
                (DD[5] + 3) * 55555 +
                (DD[4] + 4) * 7777 +
                (DD[3]);
  end;

begin
 for I := 1 to 16 do MacAddrList.MacAddr[I] := 0;
 Size := 5120;
 GetMem(AI, Size);
 Res := GetAdaptersInfo(AI, Size);
 if (Res <> ERROR_SUCCESS) then
    Result := False
   else
    begin
     Work := AI;
     I := 0;
     while Work <> nil do
      begin
       Temp := MACToStr(@Work^.Address, Work^.AddressLength);
       if Temp > 0 then
          begin
           I := I + 1;
           MacAddrList.MacAddr[I] := Temp;
          end;
       Work := Work^.Next;
      end;
     if I >= 1 then
        DefaultMacAddress := MacAddrList.MacAddr[1]
       else
        DefaultMacAddress := 0;
     Result := I >= 1;
    end;
 FreeMem(AI);
end;

function TSecurityForm.AdjustPrivilege: boolean;
var
 hToken: THANDLE;
 tkp: TOKEN_PRIVILEGES;
 lpSystemName,lpName: array[0..256] of char;
 buffLen: DWord;
begin
  StrPCopy(lpSystemName,'');
  StrPCopy(lpName, 'SeTakeOwnershipPrivilege');
  if ( not OpenProcessToken(GetCurrentProcess(),
     TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken)) then
    Result := FALSE
  else
  begin
    LookupPrivilegeValue(lpSystemName, lpName, tkp.Privileges[0].Luid);
    tkp.PrivilegeCount := 1;  // one privilege to set
    tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
    bufflen := 0;
    Result := AdjustTokenPrivileges(hToken, FALSE, tkp, 0, nil, bufflen);
  end
end;

function TSecurityForm.ReadRegistryRecord: boolean;
var
 ByteF: File Of Byte;
 F: File Of RegistryInfoType;
 Size: integer;
begin
 { $I- }
 try
  Result := FileExists(sRegistFileName);
  if Not Result and (sOldRegistFileName <> sRegistFileName) then
     begin
      Result := FileExists(sOldRegistFileName);
      if Result then Result := RenameFile(sOldRegistFileName, sRegistFileName);
     end;
  if Result then
     begin
      AssignFile(ByteF, sRegistFileName);
      Reset(ByteF);
      Size := FileSize(ByteF);
      CloseFile(ByteF);
      if Size = Sizeof(RegistryInfoType) then
         begin
          AssignFile(F, sRegistFileName);
          Reset(F);
          Read(F, RegistryRec);
          CloseFile(F);
         end
        else
         Result := False;
     end
 finally
 end;
 { $I+ }
end;

function TSecurityForm.SaveRegistryRecord: boolean;
var
 F: File Of RegistryInfoType;
begin
 { $I- }
 try
  AssignFile(F, sRegistFileName);
  Rewrite(F);
  Write(F, RegistryRec);
  CloseFile(F);
  Result := True;
 finally
 end;
 { $I+ }
end;

function TSecurityForm.TestSerialNo: boolean;
var
 I: integer;
begin
 Result := False;
 if AdjustPrivilege then
    begin
     IsMasterkey := True;
     if ReadRegistryRecord then
        begin
         I := 0;
         repeat
          I := I + 1;
         until (I > 16) or ((MacAddrList.MacAddr[I] <> 0) and (GenerateSecureCode(MacAddrList.MacAddr[I]) = RegistryRec.SerialNo));
         if (I <= 16) and (MacAddrList.MacAddr[I] <> 0) and (GenerateSecureCode(MacAddrList.MacAddr[I]) = RegistryRec.SerialNo) then
            begin
             DefaultMacAddress := MacAddrList.MacAddr[I];
             Result := True;
            end
           else
            begin
             RegistryRec.Date2 := Date;
             SaveRegistryRecord;
            end;
        end
       else
        begin
         RegistryRec.Date1 := Date;
         RegistryRec.Date2 := Date;
         RegistryRec.SerialNo := 0;
         SaveRegistryRecord;
        end;
    end;
end;

procedure TSecurityForm.SaveRegistFile(SerialNo: integer);
begin
 RegistryRec.Date2 := Date;
 RegistryRec.SerialNo := SerialNo;
 SaveRegistryRecord;
end;

function TSecurityForm.GetExpireDate: Integer;
begin
 if (RegistryRec.Date1 <= RegistryRec.Date2) and
    (RegistryRec.Date1 + sExpireDays >= Date) and
    (Date >= RegistryRec.Date2) then
    Result := Trunc(RegistryRec.Date1 + sExpireDays - Date)
   else
    Result := 0;
end;

function TSecurityForm.GenerateSecureCode(SystemID: integer): integer;
begin
 Result := SystemID + SystemSecureCode;
end;

function TSecurityForm.DecodeSecurityCode(OriginalCode: Integer): string;
var
 I: integer;
 CodeTemp, SerialNo: string;
begin
 SerialNo := Format('%1X', [OriginalCode]);
 I := 1; CodeTemp := '';
 while I <= Length(SerialNo) do
  begin
   if I + 1 <= Length(SerialNo) then
      CodeTemp := CodeTemp + SerialNo[I + 1];
   CodeTemp := CodeTemp + SerialNo[I];
   I := I + 2;
  end;
 Result := CodeTemp;
end;

function TSecurityForm.GetActiveCode: string;
begin
 if TestSoftDog then
    Result := 'USB Key'
   else
    begin
     if ReadRegistryRecord and (RegistryRec.SerialNo <> 0) and
        (GenerateSecureCode(DefaultMacAddress) = RegistryRec.SerialNo) then
        Result := DecodeSecurityCode(RegistryRec.SerialNo)
       else
        Result := 'Unregisted';
    end;
end;

procedure TSecurityForm.SecurityTimerTimer(Sender: TObject);
begin
 SecurityTimer.Enabled := False;
 while Not TestSoftDog and Not RegistryForm.RegistyPro do;
 SecurityTimer.Enabled := True;
end;

{
function TSecurityForm.ReadRegistKey: boolean;
var
 ValueStr, tempStr: string;
begin
 Result := False;
 TheReg := TRegistry.Create;
 RegistryRec.Date1 := Date;
 RegistryRec.Date2 := Date;
 RegistryRec.SerialNo := 0;
 try
    TheReg.RootKey := HKEY_LOCAL_MACHINE;
    KeyName := 'SOFTWARE\Applied Software\Digital Data Assist';
    Result := TheReg.KeyExists(KeyName);
    if Result then
       begin
        Result := TheReg.OpenKey(KeyName, False);
        if Result then
           begin
            tempStr := 'ID1';
            RegistryRec.Date1 := TheReg.ReadFloat(tempStr);
            tempStr := 'ID2';
            RegistryRec.Date2 := TheReg.ReadFloat(tempStr);
            tempStr := 'ID';
            RegistryRec.SerialNo := TheReg.ReadInteger(tempStr);
           end
          else
           Result := False;
       end;
     TheReg.CloseKey;
  finally
   TheReg.Free;
  end;
end;

function TSecurityForm.WriteRegistKey: boolean;
var
 ValueStr, tempStr: string;
begin
  TheReg := TRegistry.Create;
  try
    TheReg.RootKey := HKEY_LOCAL_MACHINE;
    KeyName := 'SOFTWARE\Applied Software\Digital Data Assist';
    if TheReg.OpenKey(KeyName, True) then
       begin
        tempStr := 'ID1';
        TheReg.WriteFloat(tempStr, RegistryRec.Date1);
        tempStr := 'ID2';
        TheReg.WriteFloat(tempStr, RegistryRec.Date2);
        tempStr := 'ID';
        TheReg.WriteInteger(tempStr, RegistryRec.SerialNo);
       end;
     TheReg.CloseKey;
  finally
   TheReg.Free;
  end;
end;
}

procedure TSecurityForm.DataModuleCreate(Sender: TObject);
begin
 InitSystemConst;
end;

end.
