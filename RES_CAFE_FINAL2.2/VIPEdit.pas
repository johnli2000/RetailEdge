unit VIPEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, Grids, DBGrids, ExtCtrls, DataUnit, Variants,
  UtilUnit, DBCtrls, ADODB, bsSkinCtrls, XiButton, bsSkinGrids, bsDBGrids,
  bsSkinBoxCtrls;

Const
 eVIPName = 1;
 eTelephone = 2;
 eMobile = 3;
 eNumber = 4;
 eStreet = 5;
 eSuburb = 6;
 eState = 7;
 ePostCode = 8;
 eMapReference = 9;
 eEMail = 10;
 eDiscount = 11;
 eCompany = 12;
 eFax = 13;
 eCreditLimit = 14;
 eSerialNo = 15;
 eBirthday = 16;
 eVIPNo = 17;
 eNote = 18;

 sVIPNo = 0;
 sVIPName = 1;
 sCompany = 2;
 sTelephone = 3;
 sFax = 4;
 sMobile = 5;
 sAddress = 6;
 sSuburb = 7;
 sState = 8;
 sPostcode = 9;
 sSerialNo =10;

type
  TVIPEditForm = class(TForm)
    KeyPanel: TbsSkinPanel;
    Button1: TXiButton;
    Button2: TXiButton;
    Button3: TXiButton;
    Button4: TXiButton;
    Button5: TXiButton;
    Button6: TXiButton;
    Button7: TXiButton;
    Button8: TXiButton;
    Button9: TXiButton;
    Button0: TXiButton;
    CharButton1: TXiButton;
    CharButton2: TXiButton;
    BackButton: TXiButton;
    LockKey: TXiButton;
    ButtonQ: TXiButton;
    ButtonW: TXiButton;
    ButtonE: TXiButton;
    ButtonR: TXiButton;
    ButtonT: TXiButton;
    ButtonY: TXiButton;
    ButtonU: TXiButton;
    ButtonI: TXiButton;
    ButtonO: TXiButton;
    ButtonP: TXiButton;
    CharButton3: TXiButton;
    CharButton4: TXiButton;
    CharButton5: TXiButton;
    ESCButton: TXiButton;
    ButtonA: TXiButton;
    ButtonS: TXiButton;
    ButtonD: TXiButton;
    ButtonF: TXiButton;
    ButtonG: TXiButton;
    ButtonH: TXiButton;
    ButtonJ: TXiButton;
    ButtonK: TXiButton;
    ButtonL: TXiButton;
    CharButton6: TXiButton;
    CharButton7: TXiButton;
    EnterButton: TXiButton;
    ShiftButton: TXiButton;
    ButtonZ: TXiButton;
    ButtonX: TXiButton;
    ButtonC: TXiButton;
    ButtonV: TXiButton;
    ButtonB: TXiButton;
    ButtonN: TXiButton;
    ButtonM: TXiButton;
    CharButton8: TXiButton;
    CharButton9: TXiButton;
    CharButton11: TXiButton;
    CharButton10: TXiButton;
    CharButton12: TXiButton;
    CharButton13: TXiButton;
    CharButton14: TXiButton;
    CharButton15: TXiButton;
    CharButton16: TXiButton;
    CharButton20: TXiButton;
    SpaceButton: TXiButton;
    CharButton17: TXiButton;
    CharButton18: TXiButton;
    CharButton19: TXiButton;
    VIPEditPanel: TPanel;
    CompanyLabel: TLabel;
    TelephoneLabel: TLabel;
    FaxNoLabel: TLabel;
    MobileNoLabel: TLabel;
    AddressLabel: TLabel;
    VIPNOLabel: TLabel;
    NameLabel: TLabel;
    EmailLabel: TLabel;
    CreateLabel: TLabel;
    DiscountLabel: TLabel;
    BirthDayLabel: TLabel;
    SuburbLabel: TLabel;
    StateLabel: TLabel;
    PostCodeLabel: TLabel;
    SerialNumberLabel: TLabel;
    MapLabel: TLabel;
    VIPNameEdit: TPanel;
    CompanyEdit: TPanel;
    TelephoneEdit: TPanel;
    FaxEdit: TPanel;
    MobileEdit: TPanel;
    EMailEdit: TPanel;
    AddressEdit: TPanel;
    SuburbEdit: TPanel;
    StateEdit: TPanel;
    PostCodeEdit: TPanel;
    MapEdit: TPanel;
    SerialNoEdit: TPanel;
    BirthDayEdit: TPanel;
    VIPNoEdit: TPanel;
    DiscountEdit: TPanel;
    CreateDateEdit: TPanel;
    Label3: TLabel;
    VIPNameEditLabel: TLabel;
    CompanyEditLabel: TLabel;
    TelephoneEditLabel: TLabel;
    FaxEditLabel: TLabel;
    MobileEditLabel: TLabel;
    BirthDayEditLabel: TLabel;
    EMailEditLabel: TLabel;
    AddressEditLabel: TLabel;
    SuburbEditLabel: TLabel;
    StateEditLabel: TLabel;
    PostCodeEditLabel: TLabel;
    SerialNoEditLabel: TLabel;
    MapEditLabel: TLabel;
    VIPNoEditLabel: TLabel;
    DiscountEditLabel: TLabel;
    CreateDateEditLabel: TLabel;
    NotesEdit: TPanel;
    NotesEditLabel: TLabel;
    Label1: TLabel;
    CreditLimitEdit: TPanel;
    CreditLimitEditLabel: TLabel;
    Query: TADOQuery;
    DataSource: TDataSource;
    BackPanel: TbsSkinPanel;
    EditPanel: TbsSkinPanel;
    VIPEditPanel1: TbsSkinPanel;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    ReturnButton: TXiButton;
    NumberEdit: TPanel;
    NumberEditLabel: TLabel;
    Label2: TLabel;
    StreetButton: TbsSkinSpeedButton;
    SuburbButton: TbsSkinSpeedButton;
    NonButton: TXiButton;
    SingleQouteButton: TXiButton;
    DoubleQouteButton: TXiButton;
    SmartCard: TCheckBox;
    function  OpenQuery(SQLStr: string): boolean;
    procedure ReadVIPData;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    function  VIPEditPro(var VIPNo: integer; Telephone: string; OpStatus: integer): boolean;
    procedure ProcessButtonClick(Ch: Char);
    procedure ButtonClick(Sender: TObject);
    procedure SpaceButtonClick(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure EnterButtonClick(Sender: TObject);
    procedure SetKeyboardStatus;
    procedure ShiftButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure InitEditPanel;
    procedure EditLabelClick(Sender: TObject);
    procedure CreateVIPNo(var VIPNo: integer);
    function  CheckVIPNo(NewVIPNo: integer): boolean;
    function  DeleteOldVIPRecord(OldVIPNo: integer): boolean;
    function  UpdateSalesHistoryVIPNo(VIPNo, NewVIPNo: integer): boolean;
    function  SaveVIPData(VIPNo: Integer): boolean;
    procedure SaveButtonClick(Sender: TObject);
    procedure StreetButtonClick(Sender: TObject);
    procedure SuburbButtonClick(Sender: TObject);
    procedure LockKeyClick(Sender: TObject);
  private { Private declarations }
    EditFlag, VIPNo, OPStatus: integer;
    ReturnFlag, LockFlag: boolean;
    CurrentEditObject: TLabel;
    Telephone: string;
  public
    { Public declarations }
  end;

var
  VIPEditForm: TVIPEditForm;

implementation

uses MainMenu, DatePanel, MessageBox, NumPad, StreetSearch, SuburbSearch,
  CustomerStatement;

{$R *.DFM}

function TVIPEditForm.OpenQuery(SQLStr: string): boolean;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    Result := Active;
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TVIPEditForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key In ['a'..'z', 'A'..'Z', '0'..'9', '@', '#', '(', ')', '*', '+', '-',
           '[', ']', '\', '/', '$', '?', ',', ';', ':', '_', '=', '.', '&'] then
    begin
     if Key In ['a'..'z', 'A'..'Z'] then
        begin
         if (ButtonA.Caption = 'A') and (Key in ['a'..'z']) then
            Key := Upcase(Key)
           else
            if (ButtonA.Caption = 'a') and (Key in ['A'..'Z'])
               then Key := Chr(Ord(Key) + 32);
        end;
     ProcessButtonClick(Key);
     Key := Chr(0);
    end
   else
    if Key = Chr(32) then SpaceButtonClick(Sender)
      else
       if Key = Chr(8) then BackButtonClick(Sender)
          else
           if Key = Chr(13) then EnterButtonClick(Sender);
 EditPanel.SetFocus;
end;

procedure TVIPEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TVIPEditForm.ProcessButtonClick(CH: char);
begin
 case EditFlag of
  eVIPName:
             if Length(CurrentEditObject.Caption) < 30 then                                      // VIPName
                CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eTelephone:
            if (CH In ['0'..'9', '(', ')']) and (Length(CurrentEditObject.Caption) < 15) then   // Telephone
               CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eMobile:
            if (CH In ['0'..'9', '(', ')']) and (Length(CurrentEditObject.Caption) < 15) then   // Mobile
               CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eNumber:
            if Length(CurrentEditObject.Caption) < 10 then                                      // Number
               CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eStreet:
            if Length(CurrentEditObject.Caption) < 100 then                                     // Address
               CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eSuburb:
            if Length(CurrentEditObject.Caption) < 25 then                                      // Suburb
               CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eState:
            if Length(CurrentEditObject.Caption) < 5 then                                       // State
               CurrentEditObject.Caption := CurrentEditObject.Caption + Upcase(CH);
  ePostcode:
            if (CH In ['0'..'9']) and (Length(CurrentEditObject.Caption) < 6) then              // PostCode
               CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eMapReference:
            if Length(CurrentEditObject.Caption) < 15 then                                      // Map
               CurrentEditObject.Caption := CurrentEditObject.Caption + Upcase(CH);
  eEmail:
            if Length(CurrentEditObject.Caption) < 40 then                                      // EMail
               CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eCompany:
            if Length(CurrentEditObject.Caption) < 40 then                                     // Company
                CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eFax:
            if (CH In ['0'..'9', '(', ')']) and (Length(CurrentEditObject.Caption) < 15) then  // Fax
                CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eSerialNo:
            if Length(CurrentEditObject.Caption) < 16 then                                     // SerialNo
               CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
  eNote:
            if Length(CurrentEditObject.Caption) < 255 then                                     // Notes
               CurrentEditObject.Caption := CurrentEditObject.Caption + CH;
 end;
 if EditFlag In [eVIPName, eCompany, eStreet, eSuburb, eState, eMapReference, eEMail, eNote] then
    begin
     LockFlag := LockKey.ColorScheme = csNeoSky;
     SetKeyboardStatus;
    end;
end;

procedure TVIPEditForm.ButtonClick(Sender: TObject);
var
 CH: Char;
begin
 with Sender As TXiButton do
  CH := Caption[1];
 ProcessButtonClick(CH);
end;

procedure TVIPEditForm.SpaceButtonClick(Sender: TObject);
begin
 if Not (EditFlag In [ePostCode, eDiscount, eVIPNo, eCreditLimit]) then
    begin
     CurrentEditObject.Caption := CurrentEditObject.Caption + ' ';
     LockFlag := True;
     SetKeyboardStatus;
    end;
end;

procedure TVIPEditForm.BackButtonClick(Sender: TObject);
var
 Len: integer;
begin
 if EditFlag In [eBirthday, eDiscount, eVIPNo, eCreditLimit] then
    CurrentEditObject.Caption := ''
   else
    begin
     Len := Length(CurrentEditObject.Caption);
     if Len > 0 then CurrentEditObject.Caption := Copy(CurrentEditObject.Caption, 1, Len - 1);
     if EditFlag In [eVIPName, eCompany, eStreet, eSuburb, eState, eMapReference, eSerialNo, eNote] then
        begin
         if (Length(CurrentEditObject.Caption) = 0) or (EditFlag = eState) or (EditFlag = eMapReference) or
            (Copy(CurrentEditObject.Caption, Length(CurrentEditObject.Caption), 1) = ' ') or
            (LockKey.ColorScheme = csNeoSky) then
            LockFlag := True
           else
            LockFlag := False;
         SetKeyboardStatus;
        end
    end;
end;

procedure TVIPEditForm.EnterButtonClick(Sender: TObject);
var
 DateTemp: TDateTime;
 Temp, NumStr: string;
begin
 if CurrentEditObject <> Nil then
    begin
     CurrentEditObject.Color := $00EAD2BF;
     CurrentEditObject.Font.Color := clBlack;
    end;
 case EditFlag of
  eVIPName:
     begin
      CurrentEditObject := TelephoneEditLabel;
      EditFlag := eTelephone;
     end;
  eTelephone:
     begin
      CurrentEditObject := MobileEditLabel;
      EditFlag := eMobile;
     end;
   eMobile:
     begin
      CurrentEditObject := NumberEditLabel;
      EditFlag := eNumber;
     end;
  eNumber:
     begin
      CurrentEditObject := AddressEditLabel;
      EditFlag := eStreet;
     end;
  eStreet:
     begin
      CurrentEditObject := SuburbEditLabel;
      EditFlag := eSuburb;
     end;
  eSuburb:
     begin
      CurrentEditObject := StateEditLabel;
      EditFlag := eState;
     end;
  eState:
     begin
      CurrentEditObject := PostCodeEditLabel;
      EditFlag := ePostCode;
     end;
  ePostCode:
     begin
      CurrentEditObject := MapEditLabel;
      EditFlag := eMapReference;
     end;
  eMapReference:
     begin
      CurrentEditObject := EMailEditLabel;
      EditFlag := eEmail;
     end;
  eEMail:
     begin
      CurrentEditObject := DiscountEditLabel;
      EditFlag := eDiscount;
     end;
  eDiscount:
     begin
      CurrentEditObject := CompanyEditLabel;
      EditFlag := eCompany;
     end;
  eCompany:
     begin
      CurrentEditObject := FaxEditLabel;
      EditFlag := eFax;
     end;
  eFax:
     begin
      CurrentEditObject := CreditLimitEditLabel;
      EditFlag := eCreditLimit;
     end;
  eCreditLimit:
     begin
       CurrentEditObject := SerialNoEditLabel;
       EditFlag := eSerialNo;
      end;
  eSerialNo:
     begin
      CurrentEditObject := BirthDayEditLabel;
      EditFlag := eBirthday;
     end;
  eBirthday, eVIPNo:
     begin
      CurrentEditObject := NotesEditLabel;
      EditFlag := eNote;
     end;
  eNote:
     begin
      CurrentEditObject := NotesEditLabel;
      NotesEditLabel.Caption := NotesEditLabel.Caption + #13#10;
     end;
 end;
 with CurrentEditObject As TLabel do
  begin
   Color := clBlue;
   Font.Color := clWhite;
   case EditFlag of
    eBirthday:
       begin
        if Caption = '' then DateTemp := Date
          else
           DateTemp := TransferDate(Caption);
        if DateForm.ReadDatePro(DateTemp) then
           Caption := FormatDateTime('dd/mm/yyyy', DateTemp);
       end;
    eDiscount:
       begin
        NumStr := DiscountEditLabel.Caption;
        if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Discount Rate', 0) then
           DiscountEditLabel.Caption := Format('%4.2f', [StrToFloat(NumStr)]);
       end;
    eVIPNo:
       begin
        NumStr := VIPNoEditLabel.Caption;
        if NumberPadForm.ReadNumberPro(NumStr, False, False, 'VIP Number', 0) and
           CheckNum(Temp, 8, 9000000, 1, 'D')then
           VIPNoEditLabel.Caption := Format('%8.8d', [StrToInt(NumStr)]);
       end;
    eCreditLimit:
       begin
        NumStr := CreditLimitEditLabel.Caption;
        if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Credit Limit', 0) then
           CreditLimitEditLabel.Caption := Format('%4.2f', [StrToFloat(NumStr)]);
       end
   else
    begin
     if (Length(CurrentEditObject.Caption) = 0) or (EditFlag = sState) or (EditFlag = eMapReference) or
        (Copy(CurrentEditObject.Caption, Length(CurrentEditObject.Caption), 1) = ' ') or
        (LockKey.ColorScheme = csNeoSky) then
        LockFlag := True
       else
        LockFlag := False;
     SetKeyboardStatus;
    end;
  end;
 end;
end;

procedure TVIPEditForm.SetKeyboardStatus;
var
 ButtonName: string;
 I: integer;
begin
 for I := 1 to 26 do
   begin
    ButtonName := 'Button' + Chr(I + 64);
    with TSpeedButton(FindComponent(ButtonName)) do
     if LockFlag then
        Caption := Uppercase(Caption)
       else
        Caption := LowerCase(Caption);
   end;
end;

procedure TVIPEditForm.ShiftButtonClick(Sender: TObject);
begin
 LockFlag := Not LockFlag;
 SetKeyboardStatus;
end;

procedure TVIPEditForm.ReadVIPData;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From VIPTable Where VIPNo =' + IntToStr(VIPNo);
 if OpenQuery(SQLStr) then
    with Query do
     begin
      VIPNo := FieldByName('VIPNo').AsInteger;
      VIPNoEditLabel.Caption := Format('%8.8d', [VIPNo]);
      VIPNameEditLabel.Caption := FieldByName('VIPName').AsString;
      CompanyEditLabel.Caption := FieldByName('Company').AsString;
      TelephoneEditLabel.Caption := FieldByName('Telephone').AsString;
      FaxEditLabel.Caption := FieldByName('Fax').AsString;
      MobileEditLabel.Caption := FieldByName('Mobile').AsString;
      EMailEditLabel.Caption := FieldByName('EMail').AsString;
      NumberEditLabel.Caption := FieldByName('Number').AsString;
      AddressEditLabel.Caption := FieldByName('Address').AsString;
      SuburbEditLabel.Caption := FieldByName('Suburb').AsString;
      StateEditLabel.Caption := FieldByName('State').AsString;
      PostCodeEditLabel.Caption := FieldByName('PostCode').AsString;
      SerialNoEditLabel.Caption := FieldByName('SerialNo').AsString;
      NotesEditLabel.Caption := FieldByName('Notes').AsString;
      MapEditLabel.Caption := FieldByName('MapReference').AsString;
      SmartCard.Checked := FieldByName('SmartCard').AsBoolean;
      CreateDateEditLabel.Caption := FormatDateTime('dd/mm/yyyy', FieldByName('CreateDate').AsDateTime);
      if Not VarIsNull(FieldByName('BirthDay').AsDateTime) and (FieldByName('BirthDay').AsDateTime <> 0) then
         BirthDayEditLabel.Caption := FormatDateTime('dd/mm/yyyy', FieldByName('BirthDay').AsDateTime)
        else
         BirthDayEditLabel.Caption := '';
      DiscountEditLabel.Caption := Format('%4.2f', [FieldByName('Discount').AsFloat]);
      CreditLimitEditLabel.Caption := Format('%4.2f', [FieldByName('CreditLimit').AsFloat]);
     end;
end;

procedure TVIPEditForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TVIPEditForm.InitEditPanel;
begin
 VIPNameEditLabel.Caption := '';
 CompanyEditLabel.Caption := '';
 TelephoneEditLabel.Caption := Telephone;
 FaxEditLabel.Caption := '';
 MobileEditLabel.Caption := '';
 EmailEditLabel.Caption := '';
 NumberEditLabel.Caption := '';
 AddressEditLabel.Caption := '';
 SuburbEditLabel.Caption := '';
 StateEditLabel.Caption := DefaultVIPState;
 PostCodeEditLabel.Caption := '';
 BirthDayEditLabel.Caption := '';
 VIPNoEditLabel.Caption := '';
 SerialNoEditLabel.Caption := '';
 NotesEditLabel.Caption := '';
 DiscountEditLabel.Caption := Format('%4.2f', [0.0]);
 CreditLimitEditLabel.Caption := Format('%4.2f', [0.0]);
 CreateDateEditLabel.Caption := FormatDateTime('dd/mm/yyyy', Date);
 EditLabelClick(VIPNameEditLabel);
end;

procedure TVIPEditForm.EditLabelClick(Sender: TObject);
var
 DateTemp: TDateTime;
 NumStr: string;
begin
 NumStr := '';
 if CurrentEditObject <> Nil then
    begin
     CurrentEditObject.Color := $00EAD2BF;
     CurrentEditObject.Font.Color := clBlack;
    end;
 CurrentEditObject := Sender As TLabel;
 with Sender As TLabel do
  begin
   if Name = 'VIPNameEditLabel' then EditFlag := eVIPName;
   if Name = 'CompanyEditLabel' then EditFlag := eCompany;
   if Name = 'TelephoneEditLabel' then EditFlag := eTelephone;
   if Name = 'FaxEditLabel' then EditFlag := eFax;
   if Name = 'MobileEditLabel' then EditFlag := eMobile;
   if Name = 'BirthDayEditLabel' then EditFlag := eBirthday;
   if Name = 'EMailEditLabel' then EditFlag := eEMail;
   if Name = 'NumberEditLabel' then EditFlag := eNumber;
   if Name = 'AddressEditLabel' then EditFlag := eStreet;
   if Name = 'SuburbEditLabel' then EditFlag := eSuburb;
   if Name = 'StateEditLabel' then EditFlag := eState;
   if Name = 'PostCodeEditLabel' then EditFlag := ePostCode;
   if Name = 'MapEditLabel' then EditFlag := eMapReference;
   if Name = 'SerialNoEditLabel' then EditFlag := eSerialNo;
   if Name = 'DiscountEditLabel' then EditFlag := eDiscount;
   if Name = 'VIPNoEditLabel' then EditFlag := eVIPNo;
   if Name = 'CreditLimitEditLabel' then EditFlag := eCreditLimit;
   if Name = 'NotesEditLabel' then EditFlag := eNote;
   Color := clBlue;
   Font.Color := clWhite;
   case EditFlag of
    eBirthday:
        begin
         if Caption = '' then DateTemp := Date
           else
            DateTemp := TransferDate(Caption);
         if DateForm.ReadDatePro(DateTemp) then
            Caption := FormatDateTime('dd/mm/yyyy', DateTemp);
        end;
    eDiscount:
        begin
         NumStr := Caption;
         if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Discount Rate', 0) then
           begin
            if StrToFloat(NumStr) > MaxDiscountPercentage then
               MessageBoxForm.MessagePro('Discount rate is over ' +
                Format('%4.2f', [MaxDiscountPercentage]) + '.', sErrorMsg)
              else
               Caption := Format('%4.2f', [StrToFloat(NumStr)]);
           end;
        end;
    eVIPNo:
        begin
         NumStr := Caption;
         if NumberPadForm.ReadNumberPro(NumStr, False, False, 'VIP Number', 0) and
            CheckNum(NumStr, 8, 9000000, 1, 'D') then
            Caption := Format('%8.8d', [StrToInt(NumStr)]);
        end;
    eCreditLimit:
        begin
         NumStr := Caption;
         if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Credit Limit', 0) then
            Caption := Format('%4.2f', [StrToFloat(NumStr)]);
        end;
    else
     begin
      if (Length(CurrentEditObject.Caption) = 0) or (LockKey.ColorScheme = csNeoSky) or
         (Copy(CurrentEditObject.Caption, Length(CurrentEditObject.Caption), 1) = ' ') then
          LockFlag := True
         else
          LockFlag := False;
       SetKeyboardStatus;
     end
    end
  end;
 EditPanel.SetFocus;
end;

procedure TVIPEditForm.CreateVIPNo(var VIPNo: integer);
var
 SQLStr: string;
begin
 SQLStr := 'Select Max(VIPNo) From VIPTable';
 OpenQuery(SQLStr);
 if Query.Active and Not VarIsNull(Query.Fields[0].AsInteger) then
    VIPNo := Query.Fields[0].AsInteger + 1
   else
    VIPNo := 1;
 Query.Close;
end;

function TVIPEditForm.SaveVIPData(VIPNo: Integer): boolean;
var
 VIPName, Company, Telephone, Fax, Mobile, EMail, Number, Address, CreateDate, Discount,
 Notes, BirthDay, SuburbTemp, StateTemp, PostCodeTemp, SerialNo, Map, CreditLimit,
 SQLStr: string;
 SmartCardTemp : integer;
begin
 if(SmartCard.Checked) then SmartCardTemp := 1
 else SmartCardTemp := 0;
 VIPName := Chr(39) + CheckQuotes(VIPNameEditLabel.Caption) + Chr(39);
 if CompanyEditLabel.Caption <> '' then
    Company := Chr(39) + CheckQuotes(CompanyEditLabel.Caption) + Chr(39)
   else
    Company := 'Null';
 if TelephoneEditLabel.Caption <> '' then
    Telephone := Chr(39) + CheckQuotes(TelephoneEditLabel.Caption) + Chr(39)
   else
    Telephone := 'Null';
 if FaxEditLabel.Caption <> '' then
    Fax := Chr(39) + CheckQuotes(FaxEditLabel.Caption) + Chr(39)
   else
    Fax := 'Null';
 if MobileEditLabel.Caption <> '' then
    Mobile := Chr(39) + CheckQuotes(MobileEditLabel.Caption) + Chr(39)
   else
    Mobile := 'Null';
 if EMailEditLabel.Caption <> '' then
    EMail := Chr(39) + CheckQuotes(EMailEditLabel.Caption) + Chr(39)
   else
    EMail := 'Null';
 if DiscountEditLabel.Caption <> '' then
    Discount := DiscountEditLabel.Caption
   else
    Discount := '0';
 if NumberEditLabel.Caption <> '' then
    Number := Chr(39) + CheckQuotes(NumberEditLabel.Caption) + Chr(39)
   else
    Number := 'Null';
 if AddressEditLabel.Caption <> '' then
    Address := Chr(39) + CheckQuotes(AddressEditLabel.Caption) + Chr(39)
   else
    Address := 'Null';
 if SuburbEditLabel.Caption <> '' then
    SuburbTemp := Chr(39) + CheckQuotes(SuburbEditLabel.Caption) + Chr(39)
   else
    SuburbTemp := 'Null';
 if StateEditLabel.Caption <> '' then
    StateTemp := Chr(39) + CheckQuotes(StateEditLabel.Caption) + Chr(39)
   else
    StateTemp := 'Null';
 if PostCodeEditLabel.Caption <> '' then
    PostCodeTemp := Chr(39) + CheckQuotes(PostCodeEditLabel.Caption) + Chr(39)
   else
    PostCodeTemp := 'Null';
 if SerialNoEditLabel.Caption <> '' then
    SerialNo := Chr(39) + CheckQuotes(SerialNoEditLabel.Caption) + Chr(39)
   else
    SerialNo := 'Null';
 if NotesEditLabel.Caption <> '' then
    Notes := Chr(39) + CheckQuotes(NotesEditLabel.Caption) + Chr(39)
   else
    Notes := 'Null';
 if MapEditLabel.Caption <> '' then
    Map := Chr(39) + CheckQuotes(MapEditLabel.Caption) + Chr(39)
   else
    Map := 'Null';
 CreateDate := ConvertDateTime(TransferDate(CreateDateEditLabel.Caption));
 if (BirthDayEditLabel.Caption <> '') then
    BirthDay := ConvertDateTime(TransferDate(BirthDayEditLabel.Caption))
   else
    BirthDay := 'Null';
 if CreditLimitEditLabel.Caption <> '' then
    CreditLimit := CreditLimitEditLabel.Caption
   else
    CreditLimit := '0';
 SQLStr := 'Insert Into VIPTable(VIPNo, VIPName, Company, Telephone, ' +
           'Fax, Mobile, EMail, Number, Address, Suburb, State, PostCode, ' +
           'CreateDate, Discount, Notes, BirthDay, SerialNo, MapReference, ' +
           'CreditLimit,SmartCard) ' +
           'Values(' + IntToStr(VIPNo) + ',' + VIPName + ',' + Company + ',' +
           Telephone + ',' + Fax + ',' + Mobile + ',' + EMail + ',' +
           Number + ',' + Address + ',' + SuburbTemp + ',' + StateTemp + ',' +
           PostCodeTemp + ',' + CreateDate + ',' + Discount + ',' + Notes + ',' +
           BirthDay + ',' + SerialNo + ',' + Map + ',' + CreditLimit + ',' + inttoStr(SmartCardTemp) + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result and (Address <> '') and (SuburbTemp <> '') then
    begin
     SQLStr := 'Select Count(*) From StreetTable ' +
               'Where Street=' + Address + ' and Suburb=' + SuburbTemp;
     OpenQuery(SQLStr);
     if Query.Fields[0].AsInteger = 0 then
        begin
         SQLStr := 'Insert Into StreetTable(Street, Suburb, MapReference) ' +
                   'Values(' + Address + ',' + SuburbTemp + ',' + Map + ')';
         Result := DataForm.ExecQueryPro(SQLStr);
        end;
     Query.Close;
    end; 
end;

function TVIPEditForm.CheckVIPNo(NewVIPNo: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select Count(*) From VIPTable Where VIPNo=' + IntToStr(NewVIPNo);
 OpenQuery(SQLStr);
 Result := Query.Fields[0].AsInteger = 0;
 Query.Close;
end;

function TVIPEditForm.DeleteOldVIPRecord(OldVIPNo: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From VIPTable Where VIPNo=' + IntToStr(OldVIPNo);
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TVIPEditForm.UpdateSalesHistoryVIPNo(VIPNo, NewVIPNo: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Update OrderH Set VIPNo=' + IntToStr(NewVIPNo) +
           ' Where VIPNo=' + IntToStr(VIPNo);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Update BookTable Set VIPNo=' + IntToStr(NewVIPNo) +
               ' Where VIPNo=' + IntToStr(VIPNo);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Update LoyaltyPoints Set VIPNo=' + IntToStr(NewVIPNo) +
               ' Where VIPNo=' + IntToStr(VIPNo);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

procedure TVIPEditForm.SaveButtonClick(Sender: TObject);
var
 Flag: boolean;
 NewVIPNo: integer;
begin
 if VIPNameEditLabel.Caption = '' then
    begin
     MessageBoxForm.MessagePro('VIP name error!', sErrorMsg);
     Exit;
    end;
 if (OpStatus = sEditStatus) and (VIPNoEditLabel.Caption = '') then
    begin
     MessageBoxForm.MessagePro('VIP number error!', sErrorMsg);
     Exit;
    end;
 if Not DataForm.BeginTransaction then Exit;
 if OpStatus = sNewStatus then
    CreateVIPNo(NewVIPNo)
   else
    begin
     NewVIPNo := StrToInt(VIPNoEditLabel.Caption);
     if (VIPNo <> NewVIPNo) and Not CheckVIPNo(NewVIPNo) and
        (MessageBoxForm.MessagePro('The VIP number: ' + Format('%8.8d', [NewVIPNo]) +
         ' exists already. ' + Chr(13) + Chr(10) + Chr(13) + Chr(10) +
         'Do you want to replace it.', sConfirmMsg) = mrNo) then
        begin
         DataForm.RollBack;
         Exit;
        end;
    end;
 Flag := True;
 try
  if OpStatus = sEditStatus then
     begin
      Flag := UpdateSalesHistoryVIPNo(VIPNo, NewVIPNo);
      if Flag then Flag := DeleteOldVIPRecord(NewVIPNo);
      if Flag then Flag := DeleteOldVIPRecord(VIPNo);
     end;
  if Flag then
     begin
      VIPNo := NewVIPNo;
      Flag := SaveVIPData(VIPNo);
     end;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      ReturnFlag := True;
      Close;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TVIPEditForm.StreetButtonClick(Sender: TObject);
var
 Street, Suburb, MapRef: string;
begin
 Street := AddressEditLabel.Caption;
 if StreetSearchForm.StreetSearchPro(Street, Suburb, MapRef) then
    begin
     AddressEditLabel.Caption := Street;
     SuburbEditLabel.Caption := Suburb;
     MapEditLabel.Caption := MapRef;
    end;
end;

procedure TVIPEditForm.SuburbButtonClick(Sender: TObject);
var
 Suburb: string;
begin
 if SuburbSearchForm.SuburbSearchPro(Suburb) then
    SuburbEditLabel.Caption := Suburb;
end;

procedure TVIPEditForm.LockKeyClick(Sender: TObject);
begin
 if LockKey.ColorScheme = csNeoSilver then
    LockKey.ColorScheme := csNeoSky
   else
    LockKey.ColorScheme := csNeoSilver;
 LockFlag := LockKey.ColorScheme = csNeoSky;
 SetKeyboardStatus;
 KeyPanel.SetFocus;
end;

procedure TVIPEditForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TVIPEditForm.FormShow(Sender: TObject);
begin
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 KeyPanel.Top := BackPanel.Height - KeyPanel.Height - 6;
 KeyPanel.Left := (BackPanel.Width - KeyPanel.Width) div 2;
 EditPanel.Width := KeyPanel.Width;
 EditPanel.Height := BackPanel.Height - KeyPanel.Height - 12;
 EditPanel.Top := 4;
 EditPanel.Left := KeyPanel.Left;
 InitEditPanel;
 if OpStatus = sNewStatus then
    begin
     CreateDateEditLabel.Caption := FormatDateTime('dd/mm/yyyy', Date);
     VIPNoEditLabel.Caption := '';
     VIPNoEdit.Enabled := True;
     LockFlag := True;
     SetKeyboardStatus;
   end
  else
   begin
    ReadVIPData;
    VIPEditPanel.Enabled := True;
    VIPNoEdit.Enabled := True;
   end;
end;

function TVIPEditForm.VIPEditPro(var VIPNo: integer; Telephone: string; OpStatus: integer): boolean;
begin
 Application.CreateForm(TVIPEditForm, VIPEditForm);
 VIPEditForm.VIPNo := VIPNo;
 VIPEditForm.OPStatus := OpStatus;
 if Telephone <> '' then VIPEditForm.Telephone := Telephone;
 VIPEditForm.ShowModal;
 Result := VIPEditForm.ReturnFlag;
 if Result then VIPNo := VIPEditForm.VIPNo;
 VIPEditForm.Free;
end;

end.
