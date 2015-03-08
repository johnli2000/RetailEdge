unit VIPList;

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
  TVIPListForm = class(TForm)
    KeyPanel: TbsSkinPanel;
    QueryVIPName: TStringField;
    QueryTelephone: TStringField;
    QueryVIPNo: TIntegerField;
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
    Query: TADOQuery;
    DataSource: TDataSource;
    BackPanel: TbsSkinPanel;
    SearchIndicator: TbsSkinStdLabel;
    SearchEdit: TbsSkinEdit;
    DBGridPanel: TbsSkinPanel;
    DBGrid: TDBGrid;
    NewButton: TXiButton;
    EditButton: TXiButton;
    PrintButton: TXiButton;
    DeleteButton: TXiButton;
    PaymentHistoryButton: TXiButton;
    PaymentButton: TXiButton;
    HistoryButton: TXiButton;
    RewardButton: TXiButton;
    PointReportButton: TXiButton;
    PrintCreditListButton: TXiButton;
    ConfirmButton: TXiButton;
    ExitButton: TXiButton;
    NonButton: TXiButton;
    SingleQouteButton: TXiButton;
    DoubleQouteButton: TXiButton;
    DepositButton: TXiButton;
    QueryCompany: TWideStringField;
    QueryFax: TWideStringField;
    QueryMobile: TWideStringField;
    QueryEMail: TWideStringField;
    QueryAddress: TWideStringField;
    QueryCreateDate: TDateTimeField;
    QueryDiscount: TFloatField;
    QueryNotes: TWideStringField;
    QueryBirthDay: TDateTimeField;
    QuerySuburb: TWideStringField;
    QueryState: TWideStringField;
    QueryPostCode: TWideStringField;
    QuerySerialNo: TWideStringField;
    QueryMapReference: TWideStringField;
    QueryCreditLimit: TFloatField;
    QueryNumber: TWideStringField;
    SearchOptionButton: TXiButton;
    PrintLabelButton: TXiButton;
    ViewVIPDetailButton: TXiButton;
    procedure OpenQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure SearchEditChange(Sender: TObject);
    procedure SearchEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchEditKeyPress(Sender: TObject; var Key: Char);
    procedure HistoryButtonClick(Sender: TObject);
    procedure SetSearchIndicator;
    procedure SearchOptionButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    function  VIPListPro(var VIPNo: integer): boolean;
    procedure PaymentButtonClick(Sender: TObject);
    procedure PaymentHistoryButtonClick(Sender: TObject);
    procedure ProcessButtonClick(Ch: Char);
    procedure ButtonClick(Sender: TObject);
    procedure SpaceButtonClick(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure ESCButtonClick(Sender: TObject);
    procedure EnterButtonClick(Sender: TObject);
    procedure SetKeyboardStatus;
    procedure ShiftButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure RewardButtonClick(Sender: TObject);
    procedure PointReportButtonClick(Sender: TObject);
    function  DeleteOldVIPRecord(OldVIPNo: integer): boolean;
    procedure PrintCreditListButtonClick(Sender: TObject);
    procedure LockKeyClick(Sender: TObject);
    procedure DepositButtonClick(Sender: TObject);
    procedure PrintLabelButtonClick(Sender: TObject);
    procedure ViewVIPDetailButtonClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
  private { Private declarations }
    SearchFlag, VIPNo: integer;
    ReturnFlag, LockFlag: boolean;
  public
    { Public declarations }
  end;

var
  VIPListForm: TVIPListForm;

implementation

uses PrintVIPList, VIPHistory, MainMenu, DatePanel, MessageBox, PrintVIPLabel,
     VIPAccount, PrintVIPStatement, AccountPaymentHistory,
     SearchOption, NumPad, AwardPoints, AwardPointsReport, StreetSearch,
     SuburbSearch, CustomerStatement, Deposit, VIPEdit, VIPCreditBalance,
  ViewVIPDetail;

{$R *.DFM}

procedure TVIPListForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From VIPTable ';
 if SearchEdit.Text <> '' then
    case SearchFlag of
     sVIPNo:     SQLStr := SQLStr + 'Where VIPTable.VIPNo =' + SearchEdit.Text;
     sVIPName:   SQLStr := SQLStr + 'Where VIPName Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
     sCompany:   SQLStr := SQLStr + 'Where Company Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
     sTelephone: SQLStr := SQLStr + 'Where Telephone Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
     sFax:       SQLStr := SQLStr + 'Where Fax Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
     sMobile:    SQLStr := SQLStr + 'Where Mobile Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
     sAddress:   SQLStr := SQLStr + 'Where Address Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
     sSuburb:    SQLStr := SQLStr + 'Where Suburb Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
     sState:     SQLStr := SQLStr + 'Where State Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
     sPostCode:  SQLStr := SQLStr + 'Where PostCode Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
     sSerialNo:  SQLStr := SQLStr + 'Where SerialNo Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
    end;
 case SearchFlag of
  sVIPNo:     SQLStr := SQLStr + ' Order By VIPTable.VIPNo';
  sVIPName:   SQLStr := SQLStr + ' Order By VIPName';
  sTelephone: SQLStr := SQLStr + ' Order By Telephone';
  else SQLStr := SQLStr + ' Order By VIPTable.VIPNo';
 end;

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
  end;
end;

procedure TVIPListForm.FormKeyPress(Sender: TObject; var Key: Char);
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
       if Key = Chr(27) then ESCButtonClick(Sender)
         else
          if Key = Chr(8) then BackButtonClick(Sender)
             else
              if Key = Chr(13) then EnterButtonClick(Sender);
end;

procedure TVIPListForm.ExitButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TVIPListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TVIPListForm.NewButtonClick(Sender: TObject);
var
 VIPNumber: integer;
 Telephone: string;
begin
 if SearchFlag = sTelephone then
    Telephone := SearchEdit.Text
   else
    Telephone := ''; 
 if VIPEditForm.VIPEditPro(VIPNumber, Telephone, sNewStatus) then
    begin
     OpenQuery;
     Query.Locate('VIPNo', VIPNumber, [loPartialKey]);
    end;
end;

procedure TVIPListForm.EditButtonClick(Sender: TObject);
var
 VIPNumber: integer;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      VIPNumber := FieldByName('VIPNo').AsInteger;
      if VIPEditForm.VIPEditPro(VIPNumber, '', sEditStatus) then
         begin
          OpenQuery;
          Locate('VIPNo', VIPNumber, [loPartialKey]);
         end;
     end;
end;

procedure TVIPListForm.DeleteButtonClick(Sender: TObject);
var
 SQLStr, CurrentVIPNo: string;
 Flag: boolean;
begin
 if Not Query.Active or (Query.RecordCount = 0) or
    (MessageBoxForm.MessagePro('Are you sure you want to delete this VIP record?', sConfirmMsg) = mrNo)
    then Exit;
 CurrentVIPNo := Query.FieldByName('VIPNo').AsString;
 if Not DataForm.BeginTransaction then Exit;
 Flag := False;
 try
  SQLStr := 'Delete From VIPTable Where VIPNo=' + CurrentVIPNo;
  Flag := DataForm.ExecQueryPro(SQLStr);
  if Flag then
     begin
      SQLStr := 'Delete From DepositTable Where VIPNo=' + CurrentVIPNo;
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag then
     begin
      SQLStr := 'Delete From LoyaltyPoints Where VIPNo=' + CurrentVIPNo;
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag then
     begin
      SQLStr := 'Update OrderH Set VIPNo=0 Where VIPNo=' + CurrentVIPNo;
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      OpenQuery;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TVIPListForm.ViewVIPDetailButtonClick(Sender: TObject);
var
 VIPNo: integer;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      VIPNo := FieldByName('VIPNo').AsInteger;
      ViewVIPDetailForm.ViewVIPDetailPro(VIPNo);
     end;
end;

procedure TVIPListForm.PrintButtonClick(Sender: TObject);
var
 SQLStr: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     SQLStr := 'Select * From VIPTable ';
     if SearchEdit.Text <> '' then
        case SearchFlag of
         sVIPNo:     SQLStr := SQLStr + 'Where VIPTable.VIPNo =' + SearchEdit.Text;
         sVIPName:   SQLStr := SQLStr + 'Where VIPName Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sCompany:   SQLStr := SQLStr + 'Where Company Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sTelephone: SQLStr := SQLStr + 'Where Telephone Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sFax:       SQLStr := SQLStr + 'Where Fax Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sMobile:    SQLStr := SQLStr + 'Where Mobile Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sAddress:   SQLStr := SQLStr + 'Where Address Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sSuburb:    SQLStr := SQLStr + 'Where Suburb Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sState:     SQLStr := SQLStr + 'Where State Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sPostcode:  SQLStr := SQLStr + 'Where PostCode Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sSerialNo:  SQLStr := SQLStr + 'Where SerialNo Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
        end;
     case SearchFlag of
      sVIPNo:     SQLStr := SQLStr + ' Order By VIPTable.VIPNo';
      sVIPName:   SQLStr := SQLStr + ' Order By VIPName';
      sCompany:   SQLStr := SQLStr + ' Order By Company';
      sTelephone: SQLStr := SQLStr + ' Order By Telephone';
      sFax:       SQLStr := SQLStr + ' Order By Fax';
      sMobile:    SQLStr := SQLStr + ' Order By Mobile';
      sAddress:   SQLStr := SQLStr + ' Order By Address';
      sSuburb:    SQLStr := SQLStr + ' Order By Suburb';
      sState:     SQLStr := SQLStr + ' Order By State';
      sPostcode:  SQLStr := SQLStr + ' Order By PostCode';
      sSerialNo:  SQLStr := SQLStr + ' Order By SerialNo';
     end;
    PrintVIPListForm.PrintVIPListPro(SQLStr);
   end;
end;

procedure TVIPListForm.SearchEditChange(Sender: TObject);
begin
 SearchEdit.SelStart := Length(SearchEdit.Text);
 SearchEdit.SelLength := 0;
 OpenQuery;
end;

procedure TVIPListForm.SearchEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key In [VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR, VK_RETURN] then
    DBGrid.SetFocus
end;

procedure TVIPListForm.SearchEditKeyPress(Sender: TObject; var Key: Char);
begin
 if (SearchFlag = 0) and Not (Key In ['0'..'9', Chr(8), Chr(13)]) then
    begin
     Key := Chr(0);
     Exit;
    end
   else
    if Key In ['a'..'z'] then Key := UpCase(Key)
end;

procedure TVIPListForm.HistoryButtonClick(Sender: TObject);
var
 CurrentVIPNo: String;
begin
  if Query.Active and (Query.RecordCount > 0) then
     begin
      CurrentVIPNo := Query.FieldByName('VIPNo').AsString;
      VIPHistoryForm.VIPHistoryPro(CurrentVIPNo);
     end
end;

procedure TVIPListForm.SetSearchIndicator;
begin
 case SearchFlag of
  sVIPNo:     SearchIndicator.Caption := 'Search by VIP Number';
  sVIPName:   SearchIndicator.Caption := 'Search by VIP Name';
  sCompany:   SearchIndicator.Caption := 'Search by Company';
  sTelephone: SearchIndicator.Caption := 'Search by Telephone';
  sFax:       SearchIndicator.Caption := 'Search by Fax Number';
  sMobile:    SearchIndicator.Caption := 'Search by Mobile Number';
  sAddress:   SearchIndicator.Caption := 'Search by Address';
  sSuburb:    SearchIndicator.Caption := 'Search by Suburb';
  sState:     SearchIndicator.Caption := 'Search by State';
  sPostcode: SearchIndicator.Caption := 'Search by Post Code';
  sSerialNo:  SearchIndicator.Caption := 'Search by Serial Number';
 end;
 SearchEdit.Text := '';
 LockFlag := LockKey.ColorScheme = csNeoSky;
 SetKeyboardStatus;
end;

procedure TVIPListForm.SearchOptionButtonClick(Sender: TObject);
var
 Flag: integer;
begin
 Flag := SearchOptionForm.SearchOptionPro;
 if Flag >= 0 then
    begin
     SearchFlag := Flag;
     SetSearchIndicator;
     OpenQuery;
     LockFlag := True;
     SetKeyboardStatus;
    end;
 DBGrid.SetFocus;
end;

procedure TVIPListForm.PaymentButtonClick(Sender: TObject);
var
 CurrentVIPNo: Integer;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      CurrentVIPNo := FieldByName('VIPNo').AsInteger;
      if VIPAccountForm.VIPAccountPro(IntToStr(CurrentVIPNo)) then
         begin
          OpenQuery;
          Locate('VIPNo', CurrentVIPNo, [loPartialKey]);
         end;
     end;
end;

procedure TVIPListForm.PaymentHistoryButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     AccountPaymentHistoryForm.PaymentHistoryPro(FieldByName('VIPNo').AsString);
end;

procedure TVIPListForm.ProcessButtonClick(CH: char);
begin
 case SearchFlag of
  sVIPNo:     if CH In ['0'..'9'] then SearchEdit.Text := SearchEdit.Text + CH;
  sVIPName:   SearchEdit.Text := SearchEdit.Text + CH;
  sCompany:   SearchEdit.Text := SearchEdit.Text + CH;
  sTelephone: if CH In ['0'..'9', '(', ')'] then SearchEdit.Text := SearchEdit.Text + CH;
  sFax:       if CH In ['0'..'9', '(', ')'] then SearchEdit.Text := SearchEdit.Text + CH;
  sMobile:    if CH In ['0'..'9', '(', ')'] then SearchEdit.Text := SearchEdit.Text + CH;
  sAddress:  SearchEdit.Text := SearchEdit.Text + CH;
  sSuburb:    SearchEdit.Text := SearchEdit.Text + CH;
  sState:     SearchEdit.Text := SearchEdit.Text + Upcase(CH);
  sPostcode:  if CH In ['0'..'9'] then SearchEdit.Text := SearchEdit.Text + CH;
  sSerialNo:  SearchEdit.Text := SearchEdit.Text + CH;
 end;
 if SearchFlag In [sVIPName, sCompany, sAddress, sSuburb, sState, sSerialNo] then
    begin
     LockFlag := LockKey.ColorScheme = csNeoSky;
     SetKeyboardStatus;
    end;
end;

procedure TVIPListForm.ButtonClick(Sender: TObject);
var
 CH: Char;
begin
 with Sender As TXiButton do
  CH := Caption[1];
 ProcessButtonClick(CH);
end;

procedure TVIPListForm.SpaceButtonClick(Sender: TObject);
begin
 if SearchFlag <> 0 then
    begin
     SearchEdit.Text := SearchEdit.Text + ' ';
     LockFlag := True;
     SetKeyboardStatus;
    end;
end;

procedure TVIPListForm.BackButtonClick(Sender: TObject);
var
 Len: integer;
begin
 Len := Length(SearchEdit.Text);
 if Len > 0 then SearchEdit.Text := Copy(SearchEdit.Text, 1, Len - 1);
 if SearchFlag In [sVIPName, sCompany, sAddress, sSuburb, sState, sSerialNo] then
    begin
     if (Length(SearchEdit.Text) = 0) or (SearchFlag = sState) or
        (Copy(SearchEdit.Text, Length(SearchEdit.Text), 1) = ' ') or
        (LockKey.ColorScheme = csNeoSky) then
         LockFlag := True
        else
         LockFlag := False;
     SetKeyboardStatus;
    end;
end;

procedure TVIPListForm.ESCButtonClick(Sender: TObject);
begin
 SearchEdit.Text := '';
end;

procedure TVIPListForm.EnterButtonClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TVIPListForm.SetKeyboardStatus;
var
 ButtonName: string;
 I: integer;
begin
 if KeyPanel.Visible then
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

procedure TVIPListForm.ShiftButtonClick(Sender: TObject);
begin
 LockFlag := Not LockFlag;
 SetKeyboardStatus;
end;

procedure TVIPListForm.ConfirmButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      VIPNo := FieldByName('VIPNo').AsInteger;
      ReturnFlag := True;
      VIPListForm.Close;
     end;
end;

procedure TVIPListForm.RewardButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount >= 1) then
     begin
      VIPNo := FieldByName('VIPNo').AsInteger;
      AwardPointsForm.ShowAwardPointsPro(VIPNo);
     end;
end;

procedure TVIPListForm.PrintCreditListButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount >= 1) then
     begin
      VIPNo := FieldByName('VIPNo').AsInteger;
      CustomerStatementForm.CustomerStatementPro(VIPNo);
     end;
end;

procedure TVIPListForm.PointReportButtonClick(Sender: TObject);
begin
 AwardPointsReportForm.ShowAwardPointsReportPro;
end;

function TVIPListForm.DeleteOldVIPRecord(OldVIPNo: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From VIPTable Where VIPNo=' + IntToStr(OldVIPNo);
 Result := DataForm.ExecQueryPro(SQLStr);
end;

procedure TVIPListForm.LockKeyClick(Sender: TObject);
begin
 if LockKey.ColorScheme = csNeoSilver then
    LockKey.ColorScheme := csNeoSky
   else
    LockKey.ColorScheme := csNeoSilver;
 LockFlag := LockKey.ColorScheme = csNeoSky;
 SetKeyboardStatus;
 KeyPanel.SetFocus;
end;

procedure TVIPListForm.DepositButtonClick(Sender: TObject);
var
 VIPNo: integer;
begin
 if Query.Active and (Query.RecordCount > 0) then
    VIPNo := Query.FieldByName('VIPNo').AsInteger
   else
    VIPNo := 0;
 DepositForm.DepositPro(VIPNo);
end;

procedure TVIPListForm.PrintLabelButtonClick(Sender: TObject);
var
 SQLStr: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     SQLStr := 'Select * From VIPTable ';
     if SearchEdit.Text <> '' then
        case SearchFlag of
         sVIPNo:     SQLStr := SQLStr + 'Where VIPTable.VIPNo =' + SearchEdit.Text;
         sVIPName:   SQLStr := SQLStr + 'Where VIPName Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sCompany:   SQLStr := SQLStr + 'Where Company Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sTelephone: SQLStr := SQLStr + 'Where Telephone Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sFax:       SQLStr := SQLStr + 'Where Fax Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sMobile:    SQLStr := SQLStr + 'Where Mobile Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sAddress:   SQLStr := SQLStr + 'Where Address Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sSuburb:    SQLStr := SQLStr + 'Where Suburb Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sState:     SQLStr := SQLStr + 'Where State Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sPostcode:  SQLStr := SQLStr + 'Where PostCode Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
         sSerialNo:  SQLStr := SQLStr + 'Where SerialNo Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
        end;
     case SearchFlag of
      sVIPNo:     SQLStr := SQLStr + ' Order By VIPTable.VIPNo';
      sVIPName:   SQLStr := SQLStr + ' Order By VIPName';
      sCompany:   SQLStr := SQLStr + ' Order By Company';
      sTelephone: SQLStr := SQLStr + ' Order By Telephone';
      sFax:       SQLStr := SQLStr + ' Order By Fax';
      sMobile:    SQLStr := SQLStr + ' Order By Mobile';
      sAddress:   SQLStr := SQLStr + ' Order By Address';
      sSuburb:    SQLStr := SQLStr + ' Order By Suburb';
      sState:     SQLStr := SQLStr + ' Order By State';
      sPostcode:  SQLStr := SQLStr + ' Order By PostCode';
      sSerialNo:  SQLStr := SQLStr + ' Order By SerialNo';
     end;
    PrintVIPLabelForm.PrintVIPLabelPro(SQLStr);
   end;
end;

procedure TVIPListForm.DBGridDblClick(Sender: TObject);
begin
 ViewVIPDetailButtonClick(Sender);
end;

procedure TVIPListForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TVIPListForm.FormShow(Sender: TObject);
begin
 HistoryButton.Caption := 'Visits' + Chr(13) + Chr(10) + 'History';
 PaymentHistoryButton.Caption := 'Payment' + Chr(13) + Chr(10) + 'History';
 RewardButton.Caption := 'Reward' + Chr(13) + Chr(10) + 'Points';
 PointReportButton.Caption := 'Points' + Chr(13) + Chr(10) + 'Report';
 NewButton.Enabled := VIPManagerAuthorise;
 EditButton.Enabled := VIPManagerAuthorise;
 DeleteButton.Enabled := VIPManagerAuthorise;
 PrintButton.Enabled := VIPManagerAuthorise;
 HistoryButton.Enabled := VIPManagerAuthorise;
 PaymentHistoryButton.Enabled := VIPManagerAuthorise;
 PaymentButton.Enabled := VIPManagerAuthorise;
 PrintCreditListButton.Enabled := VIPManagerAuthorise;
 SearchFlag := VIPDefaultSearch;
 SetSearchIndicator;
 OpenQuery;
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 LockFlag := False;
 LockKey.ColorScheme := csNeoSilver;
 DBgrid.SetFocus;
end;

function TVIPListForm.VIPListPro(var VIPNo: integer): boolean;
begin
 Application.CreateForm(TVIPListForm, VIPListForm);
 VIPListForm.VIPNo := VIPNo;
 VIPListForm.ShowModal;
 Result := VIPListForm.ReturnFlag;
 if Result then VIPNo := VIPListForm.VIPNo;
 VIPListForm.Free;
end;

end.
