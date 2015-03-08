unit SecurityCamera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,dhnetsdk,StdCtrls,DateUtils,DataUnit,SecondDisplay;

type
  TSecurityCameraForm = class(TForm)
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
    procedure SecurityCameraPro(chn:integer;invoiceDate:TDateTime);
    function AddDevice:boolean;
    procedure PlayBackByTimeRES;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    di : NET_DEVICEINFO;
    devHandle : LongInt;
    fr : NET_RECORDFILE_INFO;
    chnReal : LongInt;
    chnReal1 : LongInt;
    curChn : Byte;
    channel : integer;
    startTime1,stopTime1:NET_TIME;
    tempInvoiceDate : TDateTime;

  public
    { Public declarations }
  end;

var
  SecurityCameraForm: TSecurityCameraForm;

(************************************************************************
 ** Network disconnection callback fucntion original shape
 ***********************************************************************)
procedure DisConnect (lLoginID: LongInt; strDVRIP: Pchar; nDVRPort: LongInt;  dwUser: LongWord); stdcall;
procedure DownLoadPosCallBack(lPlayHandle:LongInt;dwTotalSize:LongWord;dwDownloadSize:LongWord;dwUser: LongWord); stdcall;
(************************************************************************
 ** Network disconnection callback fucntion original shape
 ***********************************************************************)
//procedure fDownLoadPosCallBack (lPlayHandle: LongInt; dwTotalSize:LongWord;dwDownLoadSize:LongWord;dwUser:LongWord); stdcall;

(************************************************************************
 ** Alarm message callback fucntion original shape
 ***********************************************************************)
function MessCallBack (lCommand,lLoginID:LongInt; var pBuf;
			dwBufLen:LongWord; strDVRIP:Pchar; nDVRPort:LongInt; dwUser: LongWord ):LongBool;stdcall;

(************************************************************************
 ** Set screen overlay callback
 ***********************************************************************)
procedure DrawCallBack (lLoginID,lPlayHandle:LongInt; hDC: THandle; dwUser:LongInt); stdcall;


implementation

{$R *.dfm}

(************************************************************************
 ** Network disconnection callback fucntion original shape
 ***********************************************************************)
procedure DisConnect (lLoginID: LongInt; strDVRIP: Pchar; nDVRPort: LongInt;  dwUser: LongWord); stdcall;
begin

end;

procedure DownLoadPosCallBack(lPlayHandle:LongInt;dwTotalSize:LongWord;dwDownloadSize:LongWord;dwUser: LongWord); stdcall;
begin

end;

(************************************************************************
 ** Alarm message callback fucntion original shape
 ***********************************************************************)
function MessCallBack (lCommand,lLoginID:LongInt; var pBuf;
			dwBufLen:LongWord; strDVRIP:Pchar; nDVRPort:LongInt; dwUser: LongWord ):LongBool;stdcall;
begin
    Result:= True;
end;

(************************************************************************
 ** Set screen overlay callback
 ***********************************************************************)
procedure DrawCallBack (lLoginID,lPlayHandle:LongInt; hDC: THandle; dwUser:LongInt); stdcall;
begin

end;

procedure TSecurityCameraForm.FormShow(Sender: TObject);
var bRet:LongBool;
begin
        bRet:= CLIENT_Init(DisConnect,0);
        if bRet = False then
        begin
                ShowMessage('Init dhnetsdk failed');
        end
        else
        begin
                //ShowMessage('Init dhnetsdk success');
                CLIENT_SetConnectTime(3000,3);
                if AddDevice then
                  PlayBackByTimeRES
                 else
                   ShowMessage('Can not login to DVR');
        end
end;


procedure TSecurityCameraForm.SecurityCameraPro(chn:integer;InvoiceDate:TDateTime);
begin
  Application.CreateForm(TSecurityCameraForm, SecurityCameraForm);
  SecurityCameraForm.channel := chn;
  SecurityCameraForm.tempInvoiceDate := InvoiceDate;
  SecurityCameraForm.ShowModal;
  SecurityCameraForm.Free;

end;

function TSecurityCameraForm.AddDevice:boolean;
var perror:PInteger;
var error:integer;
var strIp,strUser,strPwd: array[0..254] of Char;
begin
        perror := @error;
        StrPCopy(strIp,DVRIP);
        StrPCopy(strUser,DVRUser);
        strPcopy(strPwd,DVRPWD);
        devHandle := CLIENT_Login(strIp,Word(37777),strUser,strPwd,di,perror);
        if devHandle > 0 then
          result := true
        else
          Result := False;

end;

procedure TSecurityCameraForm.PlayBackByTimeRES;
var
  year,month,day,hour,minute,second,millisecond : word;
begin
  DecodeDateTime(tempinvoiceDate,year,month,day,hour,minute,second,millisecond);
  with startTime1 do
    begin
      dwYear:=year;
      dwMonth:=month;
      dwDay:=day;
      dwHour:=hour;
      dwMinute:=minute;
      dwSecond:=second;
    end;
  with stopTime1 do
    begin
      dwYear:=year;
      dwMonth:=month;
      dwDay:=day;
      dwHour:=hour;
      dwMinute:=minute+5;
      dwSecond:=second;
    end;
  chnReal := CLIENT_PlayBackByTime(devHandle, Integer(channel), startTime1, stopTime1, Panel1.Handle, DownLoadPosCallBack,integer(0));
  if (chnReal > 0) then
    begin
                //ShowMessage('open RealPlay success');
    end
  else
    begin
      ShowMessage('open RealPlay failed');
        chnReal := 0;
    end
end;

procedure TSecurityCameraForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    CLIENT_Cleanup;
    
end;

end.
