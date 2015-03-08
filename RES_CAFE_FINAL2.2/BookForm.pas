unit BookForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, StdCtrls, ExtCtrls, Buttons, Grids, UtilUnit, Db, DataUnit, ADODB,
  bsSkinCtrls, XiButton;

type
  TBookingForm = class(TForm)
    EditPanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label16: TLabel;
    Query: TADOQuery;
    ArrivedCheckBox: TCheckBox;
    CustomerNameEdit: TPanel;
    CompanyEdit: TPanel;
    TelephoneEdit: TPanel;
    FaxEdit: TPanel;
    MobileEdit: TPanel;
    BookingDateEdit: TPanel;
    TimeEdit: TPanel;
    KindEdit: TPanel;
    Label12: TLabel;
    TableNoEdit: TPanel;
    PersonEdit: TPanel;
    AddressEdit: TPanel;
    NotesEdit: TPanel;
    VIPNoEdit: TPanel;
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
    BackButton: TXiButton;
    ButtonQ: TXiButton;
    CharButton1: TXiButton;
    CharButton2: TXiButton;
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
    ESCButton: TXiButton;
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
    CharButton10: TXiButton;
    CharButton11: TXiButton;
    CharButton12: TXiButton;
    NonKey: TXiButton;
    SpaceButton: TXiButton;
    CharButton13: TXiButton;
    CharButton14: TXiButton;
    CharButton15: TXiButton;
    CharButton16: TXiButton;
    CharButton17: TXiButton;
    CharButton18: TXiButton;
    CharButton19: TXiButton;
    CharButton20: TXiButton;
    CustomerNameEditLabel: TLabel;
    CompanyEditLabel: TLabel;
    TelephoneEditLabel: TLabel;
    FaxEditLabel: TLabel;
    MobileEditLabel: TLabel;
    BookingDateEditLabel: TLabel;
    TimeEditLabel: TLabel;
    KindEditLabel: TLabel;
    TableNoEditLabel: TLabel;
    PersonEditLabel: TLabel;
    AddressEditLabel: TLabel;
    VIPNoEditLabel: TLabel;
    NotesEditLabel: TLabel;
    Label13: TLabel;
    ExpireTimeEdit: TPanel;
    ExpireTimeEditLabel: TLabel;
    BackPanel: TbsSkinPanel;
    bsSkinPanel1: TbsSkinPanel;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    StatusButton: TXiButton;
    LockKey: TXiButton;
    SingleQouteButton: TXiButton;
    DoubleQouteButton: TXiButton;
    DepositButton: TXiButton;
    procedure InitForm;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CancelButtonClick(Sender: TObject);
    function  OpenQuery(SQLStr: string): boolean;
    procedure FormShow(Sender: TObject);
    function  OpenBookTable(BookingNo: string): boolean;
    procedure ReadBookData;
    function  SaveBookTable(BookingNo: string): boolean;
    function  TestTableNo(TableNo: string): boolean;
    procedure SaveButtonClick(Sender: TObject);
    procedure MakeBookingNo(var BookingNo: string);
    function  SaveData(BookingNo: string): boolean;
    procedure PasteVIPInformation(VIPNo: integer);
    procedure StatusButtonClick(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure SpaceButtonClick(Sender: TObject);
    procedure EnterButtonClick(Sender: TObject);
    procedure ShiftButtonClick(Sender: TObject);
    procedure EditLabelClick(Sender: TObject);
    function  GetKind(TempStr: string): integer;
    procedure ProcessButtonClick(CH: char);
    procedure SetKeyboardStatus;
    function  BookingPro(var BookingNo: string; OpStatus, KindFlag: integer): boolean;
    procedure FormResize(Sender: TObject);
    procedure LockKeyClick(Sender: TObject);
    procedure DepositButtonClick(Sender: TObject);
  private { Private declarations }
    ReturnFlag, LockFlag: boolean;
    sBookingNo, OldTableNo: string;
    StatusFlag, EditFlag, KindFlag: integer;
    RecordDateTime: double;
    CurrentEditObject: TLabel;
  public
    { Public declarations }
  end;

var
  BookingForm: TBookingForm;

implementation

uses PrintBooking, MainMenu, NumPad, BookStatus, DatePanel, TimePanel, Keyboard, MessageBox,
     VIPList, KindSelect, Deposit;

{$R *.DFM}

procedure TBookingForm.InitForm;
begin
 OldTableNo := '';
 CustomerNameEditLabel.Caption := '';
 TelephoneEditLabel.Caption := '';
 FaxEditLabel.Caption := '';
 MobileEditLabel.Caption := '';
 AddressEditLabel.Caption := '';
 BookingDateEditLabel.Caption := FormatDateTime('dd/mm/yyyy', Date);
 TableNoEditLabel.Caption := '';
 PersonEditLabel.Caption := '';
 NotesEditLabel.Caption := '';
 VIPNoEditLabel.Caption := '';
 case KindFlag of
  0: begin
      KindEditLabel.Caption := 'Dinner';
      TimeEditLabel.Caption := '17:00';
     end;
  1: begin
      KindEditLabel.Caption := 'Lunch';
      TimeEditLabel.Caption := '11:00';
     end;
  2: begin
      KindEditLabel.Caption := 'Breakfast';
      TimeEditLabel.Caption := '06:00';
     end;
  3: begin
      KindEditLabel.Caption := 'Others';
      TimeEditLabel.Caption := '00:00';
     end;
 end;
 ExpireTimeEditLabel.Caption := '00:00';
 ArrivedCheckBox.Checked := False;
end;

procedure TBookingForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key In ['a'..'z', 'A'..'Z', '0'..'9', '@', '#', '(', ')', '*', '+', '-',
           '[', ']', '\', '/', '$', '?', ',', ';', ':', '_', '=', '.', '&'] then
    ProcessButtonClick(Key)
   else
    if Key = Chr(32) then SpaceButtonClick(Sender)
      else
       if Key = Chr(8) then BackButtonClick(Sender)
          else
           if Key = Chr(13) then EnterButtonClick(Sender)
end;

procedure TBookingForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TBookingForm.DepositButtonClick(Sender: TObject);
begin
 if (VIPNoEditLabel.Caption <> '') and (StrToInt(VIPNoEditLabel.Caption) >= 1) then
    DepositForm.DepositPro(StrToInt(VIPNoEditLabel.Caption))
   else
    MessageBoxForm.MessagePro('This order has not been entered the VIP Number.', sErrorMsg);
end;

procedure TBookingForm.PasteVIPInformation(VIPNo: integer);
var
 SQLStr: string;
begin
 SQLStr := 'Select * From VIPTable Where VIPNo=' + IntToStr(VIPNo);
 OpenQuery(SQLStr);
 with Query do
  begin
   CustomerNameEditLabel.Caption := FieldByName('VIPName').AsString;
   CompanyEditLabel.Caption := FieldByName('Company').AsString;
   TelephoneEditLabel.Caption := FieldByName('Telephone').AsString;
   FaxEditLabel.Caption := FieldByName('Fax').AsString;
   MobileEditLabel.Caption := FieldByName('Mobile').AsString;
   AddressEditLabel.Caption := FieldByName('Number').AsString + ' ' +
      FieldByName('Address').AsString + ' ' + FieldByName('Suburb').AsString + ' ' +
      FieldByName('State').AsString + ' ' + FieldByName('PostCode').AsString;
   if FieldByName('MapReference').AsString <> '' then
      AddressEditLabel.Caption := AddressEditLabel.Caption  +
         ' [' + FieldByName('MapReference').AsString + ']';
   Close;
  end;
end;

function TBookingForm.OpenQuery(SQLStr: string): boolean;
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
    Screen.Cursor := crDefault;
   end;
   if RecordCount = 0 then
      Result := False
     else
      Result := True;
  end;
end;

function TBookingForm.OpenBookTable(BookingNo: string): boolean;
var
 SQLStr: string;
 CurrentYearStr: string;
 Year, Month, Day: word;
begin
 if BookingNo <> '' then
    SQLStr := 'Select * From BookTable Where BookingNo=' +
              Chr(39) + CheckQuotes(BookingNo) + Chr(39)
   else
    begin
     DecodeDate(Date, Year, Month, Day);
     CurrentYearStr := Copy(Format('%4.4d', [Year]), 3, 2);
     SQLStr := 'Select Max(BookingNo) From BookTable ' +
               'Where BookingNo Like ' + Chr(39) + CurrentYearStr + SearchMark + Chr(39);
    end;
 Screen.Cursor := crHourGlass;
 Result := OpenQuery(SQLStr);
end;

procedure TBookingForm.ReadBookData;
begin
 with Query do
  begin
   RecordDateTime := FieldByName('RecordDate').AsDateTime;
   CustomerNameEditLabel.Caption := FieldByName('CustomerName').AsString;
   CompanyEditLabel.Caption := FieldByName('Company').AsString;
   TelephoneEditLabel.Caption := FieldByName('Telephone').AsString;
   FaxEditLabel.Caption := FieldByName('Fax').AsString;
   MobileEditLabel.Caption := FieldByName('Mobile').AsString;
   OldTableNo := DeleteSpace(FieldByName('TableNo').AsString);
   TableNoEditLabel.Caption := DeleteSpace(FieldByName('TableNo').AsString);
   PersonEditLabel.Caption := Format('%d', [FieldByName('Persons').AsInteger]);
   if FieldByName('VIPNo').AsInteger > 0 then
      VIPNoEditLabel.Caption := Format('%8.8d', [FieldByName('VIPNo').AsInteger])
     else
      VIPNoEditLabel.Caption := '';
   BookingDateEditLabel.Caption := FormatDateTime('dd/mm/yyyy', FieldByName('BookingDate').AsDateTime);
   TimeEditLabel.Caption := FormatDateTime('hh:mm', FieldByName('BookingDate').AsDateTime);
   ExpireTimeEditLabel.Caption := FormatDateTime('hh:mm', FieldByName('ExpireTime').AsDateTime);
   case FieldByName('Kind').AsInteger of
    0: KindEditLabel.Caption := 'Dinner';
    1: KindEditLabel.Caption := 'Lunch';
    2: KindEditLabel.Caption := 'Breakfast';
   else
    KindEditLabel.Caption := 'Others';
   end;
   AddressEditLabel.Caption := FieldByName('Address').AsString;
   NotesEditLabel.Caption := FieldByName('Notes').AsString;
   ArrivedCheckBox.Checked := FieldByName('Arrived').AsBoolean;
  end;
end;

function TBookingForm.GetKind(TempStr: string): integer;
begin
 if TempStr = 'Dinner' then
    Result := 0
   else
     if TempStr = 'Lunch' then
        Result := 1
       else
        if TempStr = 'Breakfast' then
           Result := 2
          else
           Result := 3;
end;

function TBookingForm.SaveBookTable(BookingNo: string): boolean;
var
 SQLStr, CustomerName, Company, VIPNo, Telephone, Fax, Mobile, TableNo,
 BookDateTime, Person, Address, Notes, RecordDateTimeStr, Kind, Arrived,
 ExpireTime: string;
 DateTemp, TimeTemp, ExpireTimeTemp: double;
begin
 if CustomerNameEditLabel.Caption <> '' then
    CustomerName := Chr(39) + CheckQuotes(CustomerNameEditLabel.Caption) + Chr(39)
   else
    CustomerName := 'Null';
 if CompanyEditLabel.Caption <> '' then
    Company := Chr(39) + CheckQuotes(CompanyEditLabel.Caption) + Chr(39)
   else
    Company := 'Null';
 if TelephoneEditLabel.Caption <> '' then
    Telephone := Chr(39) + CheckQuotes(TelephoneEditLabel.Caption) + Chr(39)
   else
    Telephone := 'Null';
 if FaxEditLabel.Caption <> '' then
    Fax := Chr(39) + CheckQuotes(FaxEditLabel.Caption) + chr(39)
   else
    Fax := 'Null';
 if MobileEditLabel.Caption <> '' then
    Mobile := Chr(39) + CheckQuotes(MobileeditLabel.Caption) + Chr(39)
   else
    Mobile := 'Null';
 if TableNoEditLabel.Caption <> '' then
    TableNo := Chr(39) + CheckQuotes(TableNoEditLabel.Caption) + Chr(39)
   else
    TableNo := 'Null';
 if PersonEditLabel.Caption <> '' then
    Person := PersonEditLabel.Caption
   else
    Person := '0';
 if VIPNoEditLabel.Caption <> '' then
    VIPNo := VIPNoEditLabel.Caption
   else
    VIPNo := '0';
 if AddressEditLabel.Caption <> '' then
    Address := Chr(39) + CheckQuotes(AddressEditLabel.Caption) + Chr(39)
   else
    Address := 'Null';
 if NotesEditLabel.Caption <> '' then
    Notes := Chr(39) + CheckQuotes(NotesEditLabel.Caption) + Chr(39)
   else
    Notes := 'Null';
 Kind := IntToStr(GetKind(KindEditLabel.Caption));
 if ArrivedCheckBox.Checked then
    Arrived := '1'
   else
    Arrived := '0';
 RecordDateTimeStr := ConvertDateTime(RecordDateTime);
 DateTemp := TransferDate(BookingDateEditLabel.Caption);
 TimeTemp := StrToTime(TimeEditLabel.Caption);
 ExpireTimeTemp := StrToTime(ExpireTimeEditLabel.Caption);
 if (ExpireTimeTemp < TimeTemp) then
    ExpireTime := ConvertDateTime(DateTemp + 1 + ExpireTimeTemp)
   else
    ExpireTime := ConvertDateTime(DateTemp + ExpireTimeTemp);
 BookDateTime := ConvertDateTime(DateTemp + TimeTemp);
 SQLStr := 'Insert Into BookTable(RecordDate, CustomerName, Company, Telephone, ' +
           'Fax, Mobile, Address, Notes, BookingDate, Kind, Persons, TableNo, VIPNo, ' +
           'BookingNo, Arrived, OpName, ExpireTime) ' +
           'Values(' + RecordDateTimeStr + ',' + CustomerName +',' + Company + ',' +
           Telephone + ',' + Fax + ',' + Mobile +',' + Address + ',' + Notes + ',' +
           BookDateTime + ',' + Kind + ',' + Person + ',' + TableNo +',' + VIPNo + ',' +
           Chr(39) + CheckQuotes(BookingNo) + Chr(39) + ',' + Arrived + ',' +
           Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' + ExpireTime + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TBookingForm.SaveData(BookingNo: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From BookTable Where BookingNo=' + Chr(39) + CheckQuotes(BookingNo) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then Result := SaveBookTable(BookingNo);
end;

procedure TBookingForm.MakeBookingNo(var BookingNo: string);
var
 CurYearStr: string;
 NewBookingNo: Integer;
 Year, Month, Day: word;
begin
 if OpenBookTable('')  and (Query.Fields[0].AsString <> '') then
    NewBookingNo := StrToInt(Copy(Query.Fields[0].AsString, 3, 6))
   else
    NewBookingNo := 0;
 Query.Close;
 DecodeDate(Date, Year, Month, Day);
 CurYearStr := Copy(Format('%4.4d', [Year]), 3, 2);
 Inc(NewBookingNo);
 BookingNo := CurYearStr + Format('%6.6d', [NewBookingNo]);
end;

function TBookingForm.TestTableNo(TableNo: string): boolean;
var
 SQLStr: string;
 DateTemp: TDateTime;
 Temp: integer;
begin
 Result := True;
 if (TableNoEditLabel.Caption = '') then Exit;
 DateTemp := TransferDate(BookingDateEditLabel.Caption);
 SQLStr := 'Select TableNo From BookTable ' +
           'Where BookingDate>=' + ConvertDateTime(DateTemp + StrToTime('0:0:0')) +
           ' and BookingDate<=' + ConvertDateTime(DateTemp + StrToTime('23:59:0')) +
           ' and TableNo=' + Chr(39) + CheckQuotes(TableNo) + Chr(39) +
           ' and Kind=' + IntToStr(GetKind(KindEditLabel.Caption));
 OpenQuery(SQLStr);
 Temp := Query.RecordCount;
 Query.Close;
 if (Temp > 0) and
    (MessageBoxForm.MessagePro('This table has been reserved.' +
     Chr(13) + Chr(10) + Chr(13) + Chr(10) +
     'Are you sure you still want to reserve this table?', sConfirmMsg) = mrNo) then
    begin
     Result := False;
     Exit;
    end;
end;

procedure TBookingForm.SaveButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 if CustomerNameEditLabel.Caption = '' then
    begin
     MessageBoxForm.MessagePro('Customer name is invalid!', sErrorMsg);
     Exit;
    end;
 if ((StatusFlag = sNewStatus) or (TableNoEditLabel.Caption <> OldTableNo)) and
     Not TestTableNo(TableNoEditLabel.Caption) then Exit;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  if StatusFlag = sNewStatus  then MakeBookingNo(sBookingNo);
  Flag := SaveData(sBookingNo);
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

procedure TBookingForm.StatusButtonClick(Sender: TObject);
var
 TempStr: string;
 DateTemp: TDateTime;
 KindTemp: integer;
begin
 if BookingDateEditLabel.Caption <> '' then
    DateTemp := TransferDate(BookingDateEditLabel.Caption)
   else
    DateTemp := Date + Time;
 if KindEditLabel.Caption <> '' then
    KindTemp := GetKind(KindEditLabel.Caption)
   else
    KindTemp := 0;
 BookStatusForm.ListBookingStatus(TempStr, True, KindTemp, DateTemp);
end;

procedure TBookingForm.ProcessButtonClick(CH: char);
begin
 case EditFlag of
  0: if Length(CurrentEditObject.Caption) < 30 then
        CurrentEditObject.Caption := CurrentEditObject.Caption + CH; // CustomerName
  1: if Length(CurrentEditObject.Caption) < 40 then
        CurrentEditObject.Caption := CurrentEditObject.Caption + CH; // Company
  2: if (CH In ['0'..'9', '(', ')']) and (Length(CurrentEditObject.Caption) < 15) then
        CurrentEditObject.Caption := CurrentEditObject.Caption + CH; // Telephone
  3: if (CH In ['0'..'9', '(', ')']) and (Length(CurrentEditObject.Caption) < 15) then
        CurrentEditObject.Caption := CurrentEditObject.Caption + CH; // Fax
  4: if (CH In ['0'..'9', '(', ')']) and (Length(CurrentEditObject.Caption) < 15) then
        CurrentEditObject.Caption := CurrentEditObject.Caption + CH; // Mobile
 11: if (Length(CurrentEditObject.Caption) < 60) then
        CurrentEditObject.Caption := CurrentEditObject.Caption + CH; // Address
 13: if Length(CurrentEditObject.Caption) < 255 then
        CurrentEditObject.Caption := CurrentEditObject.Caption + CH; // Notes
 end;
 if EditFlag In [0, 1, 11, 13] then
    begin
     LockFlag := LockKey.ColorScheme = csNeoSky;
     SetKeyboardStatus;
    end;
end;

procedure TBookingForm.ButtonClick(Sender: TObject);
var
 CH: Char;
begin
 with Sender As TXiButton do
  CH := Caption[1];
 ProcessButtonClick(CH);
end;

procedure TBookingForm.BackButtonClick(Sender: TObject);
var
 Len: integer;
begin
 if EditFlag In [0, 1, 2, 3, 4, 11, 13] then
    begin
     Len := Length(CurrentEditObject.Caption);
     if Len > 0 then CurrentEditObject.Caption := Copy(CurrentEditObject.Caption, 1, Len - 1);
    end
   else
    CurrentEditObject.Caption := '';
 if EditFlag In [0, 1, 11, 13] then
    begin
     if (LockKey.ColorScheme = csNeoSky) or (Length(CurrentEditObject.Caption) = 0) or
        (Copy(CurrentEditObject.Caption, Length(CurrentEditObject.Caption), 1) = ' ') then
         LockFlag := True
        else
         LockFlag := False;
     SetKeyboardStatus;
    end;
end;

procedure TBookingForm.SpaceButtonClick(Sender: TObject);
begin
 if EditFlag In [0, 1, 2, 3, 4, 11, 13] then
    begin
     CurrentEditObject.Caption := CurrentEditObject.Caption + ' ';
     LockFlag := True;
     SetKeyboardStatus;
    end;
end;

procedure TBookingForm.EnterButtonClick(Sender: TObject);
var
 DateTemp: TDateTime;
 Temp, NumStr: string;
 KindTemp, VIPNo: integer;
begin
 NumStr := '';
 if CurrentEditObject <> Nil then
    begin
     CurrentEditObject.Color := $00EAD2BF;
     CurrentEditObject.Font.Color := clBlack;
    end;
 case EditFlag of
  0: CurrentEditObject := CompanyEditLabel;
  1: CurrentEditObject := TelephoneEditLabel;
  2: CurrentEditObject := FaxEditLabel;
  3: CurrentEditObject := MobileEditLabel;
  4: CurrentEditObject := BookingDateEditLabel;
  5: CurrentEditObject := KindEditLabel;
  6: CurrentEditObject := TimeEditLabel;
  7: CurrentEditObject := ExpireTimeEditLabel;
  8: CurrentEditObject := TableNoEditLabel;
  9: CurrentEditObject := PersonEditLabel;
  10: CurrentEditObject := AddressEditLabel;
  11: CurrentEditObject := VIPNoEditLabel;
  12: CurrentEditObject := NotesEditLabel;
  13: CurrentEditObject := CustomerNameEditLabel;
  end;
 if EditFlag < 13 then EditFlag := EditFlag + 1
   else
    EditFlag := 0;
 with CurrentEditObject As TLabel do
  begin
   Color := clBlue;
   Font.Color := clWhite;
   if EditFlag = 5 then
      begin
       if Caption = '' then DateTemp := Date
         else
          DateTemp := TransferDate(Caption);
       if DateForm.ReadDatePro(DateTemp) then
          Caption := FormatDateTime('dd/mm/yyyy', DateTemp);
      end
     else
      if EditFlag = 6 then
         begin
          KindTemp := KindSelectForm.KindSelectPro;
          if KindTemp >= 0 then
             case KindTemp of
              0: begin
                  CurrentEditObject.Caption := 'Dinner';
                  TimeEditLabel.Caption := '17:00';
                 end;
              1: begin
                  CurrentEditObject.Caption := 'Lunch';
                  TimeEditLabel.Caption := '11:00';
                 end;
              2: begin
                  CurrentEditObject.Caption := 'Breakfast';
                  TimeEditLabel.Caption := '6:00';
                 end;
              3: begin
                  CurrentEditObject.Caption := 'Others';
                  TimeEditLabel.Caption := '20:00';
                 end;
             end;
          end
         else
          if (EditFlag = 7) or (EditFlag = 8) then
             begin
              if Caption <> '' then
                 Temp := Caption
                else
                 Temp := '0:0';
              if TimeForm.ReadTimePro(Temp) then
                 Caption := Temp;
             end
            else
             if EditFlag = 9 then
                begin
                 if BookingDateEditLabel.Caption <> '' then
                    DateTemp := TransferDate(BookingDateEditLabel.Caption)
                   else
                    DateTemp := Date + Time;
                 if KindEditLabel.Caption <> '' then
                    KindTemp := GetKind(KindEditLabel.Caption)
                   else
                    KindTemp := 0;
                 if BookStatusForm.ListBookingStatus(Temp, False, KindTemp, DateTemp) then
                    TableNoEditLabel.Caption := Temp
                end
               else
                if (EditFlag = 10) and NumberPadForm.ReadNumberPro(NumStr, False, False, 'People', 0) then
                   PersonEditLabel.Caption := NumStr
                 else
                  if (EditFlag = 12) and VIPListForm.VIPListPro(VIPNo) then
                     begin
                      VIPNoEditLabel.Caption := Format('%8.8d', [VIPNo]);
                      PasteVIPInformation(VIPNo);
                     end;
  end;
 if EditFlag In [0, 1, 2, 3, 4, 11, 13] then
    begin
     if (Length(CurrentEditObject.Caption) = 0) or (Copy(CurrentEditObject.Caption, Length(CurrentEditObject.Caption), 1) = ' ') then
        LockFlag := True
       else
        LockFlag := False;
     SetKeyboardStatus;
    end
end;

procedure TBookingForm.SetKeyboardStatus;
var
 ButtonName: string;
 I: integer;
begin
 for I := 1 to 26 do
  begin
   ButtonName := 'Button' + Chr(I + 64);
   with TXiButton(FindComponent(ButtonName)) do
    if LockFlag then
       Caption := Uppercase(Caption)
      else
       Caption := LowerCase(Caption);
  end;
end;

procedure TBookingForm.ShiftButtonClick(Sender: TObject);
begin
 LockFlag := Not LockFlag;
 SetKeyboardStatus;
end;

procedure TBookingForm.EditLabelClick(Sender: TObject);
var
 DateTemp: TDateTime;
 Temp, NumStr: string;
 VIPNo, KindTemp: integer;
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
   if Name = 'CustomerNameEditLabel' then EditFlag := 0;
   if Name = 'CompanyEditLabel' then EditFlag := 1;
   if Name = 'TelephoneEditLabel' then EditFlag := 2;
   if Name = 'FaxEditLabel' then EditFlag := 3;
   if Name = 'MobileEditLabel' then EditFlag := 4;
   if Name = 'BookingDateEditLabel' then EditFlag := 5;
   if Name = 'KindEditLabel' then EditFlag := 6;
   if Name = 'TimeEditLabel' then EditFlag := 7;
   if Name = 'ExpireTimeEditLabel' then EditFlag := 8;
   if Name = 'TableNoEditLabel' then EditFlag := 9;
   if Name = 'PersonEditLabel' then EditFlag := 10;
   if Name = 'AddressEditLabel' then EditFlag := 11;
   if Name = 'VIPNoEditLabel' then EditFlag := 12;
   if Name = 'NotesEditLabel' then EditFlag := 13;
   Color := clBlue;
   Font.Color := clWhite;
   if EditFlag = 5 then
      begin
       if Caption = '' then DateTemp := Date
         else
          DateTemp := TransferDate(Caption);
       if DateForm.ReadDatePro(DateTemp) then
          Caption := FormatDateTime('dd/mm/yyyy', DateTemp);
      end
     else
      if EditFlag = 6 then
         begin
          KindTemp := KindSelectForm.KindSelectPro;
          if KindTemp >= 0 then
             case KindTemp of
              0: begin
                  CurrentEditObject.Caption := 'Dinner';
                  TimeEditLabel.Caption := '17:00';
                 end;
              1: begin
                  CurrentEditObject.Caption := 'Lunch';
                  TimeEditLabel.Caption := '11:00';
                 end;
              2: begin
                  CurrentEditObject.Caption := 'Breakfast';
                  TimeEditLabel.Caption := '6:00';
                 end;
              3: begin
                  CurrentEditObject.Caption := 'Others';
                  TimeEditLabel.Caption := '20:00';
                 end;
             end;
          end
        else
         if (EditFlag = 7) or (EditFlag = 8) then
            begin
             if Caption <> '' then
                Temp := Caption
               else
                Temp := '0:0';
              if TimeForm.ReadTimePro(Temp) then
                 Caption := Temp;
            end
           else
             if EditFlag = 9 then
                begin
                 if BookingDateEditLabel.Caption <> '' then
                    DateTemp := TransferDate(BookingDateEditLabel.Caption)
                   else
                    DateTemp := Date + Time;
                 if KindEditLabel.Caption <> '' then
                    KindTemp := GetKind(KindEditLabel.Caption)
                   else
                    KindTemp := 0;
                 if BookStatusForm.ListBookingStatus(Temp, False, KindTemp, DateTemp) then
                    begin
                     if TableNoEditLabel.Caption <> '' then
                        begin
                         if Length(TableNoEditLabel.Caption) + Length(',' + Temp) <= 50 then
                            TableNoEditLabel.Caption := TableNoEditLabel.Caption + ',' + Temp;
                        end
                       else
                        TableNoEditLabel.Caption := Temp
                    end;
                end
              else
               if (EditFlag = 10) and NumberPadForm.ReadNumberPro(NumStr, False, False, 'People', 0) then
                  PersonEditLabel.Caption := NumStr
                else
                 if (EditFlag = 12) and VIPListForm.VIPListPro(VIPNo) then
                    begin
                     VIPNoEditLabel.Caption := Format('%8.8d', [VIPNo]);
                     PasteVIPInformation(VIPNo);
                    end;
   if EditFlag In [0, 1, 2, 3, 4, 11, 13] then
      begin
       if (LockKey.ColorScheme = csNeoSky) or (Length(CurrentEditObject.Caption) = 0) or
          (Copy(CurrentEditObject.Caption, Length(CurrentEditObject.Caption), 1) = ' ') then
          LockFlag := True
         else
          LockFlag := False;
       SetKeyboardStatus;
      end
  end;
end;

procedure TBookingForm.LockKeyClick(Sender: TObject);
begin
 if LockKey.ColorScheme = csNeoSilver then
    LockKey.ColorScheme := csNeoSky
   else
    LockKey.ColorScheme := csNeoSilver;
 LockFlag := LockKey.ColorScheme = csNeoSky;
 SetKeyboardStatus;
 KeyPanel.SetFocus;
end;

procedure TBookingForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TBookingForm.FormShow(Sender: TObject);
begin
 InitForm;
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
 KeyPanel.Top := BackPanel.Height - KeyPanel.Height - 6;
 KeyPanel.Left := (BackPanel.Width - KeyPanel.Width) div 2;
 EditPanel.Top := 4;
 EditPanel.Left := KeyPanel.Left;
 if StatusFlag = sNewStatus then
    begin
     RecordDateTime := Date + Time;
     CustomerNameEdit.SetFocus;
    end
   else
    begin
     if OpenBookTable(sBookingNo) then ReadBookData;
    end;
 EditLabelClick(CustomerNameEditLabel);
end;

function TBookingForm.BookingPro(var BookingNo: string; OpStatus, KindFlag: integer): boolean;
begin
 Application.CreateForm(TBookingForm, BookingForm);
 BookingForm.sBookingNo := BookingNo;
 BookingForm.StatusFlag := OpStatus;
 BookingForm.KindFlag := KindFlag;
 BookingForm.ShowModal;
 Result := BookingForm.ReturnFlag;
 BookingNo := BookingForm.sBookingNo;
 BookingForm.Free;
end;

end.
