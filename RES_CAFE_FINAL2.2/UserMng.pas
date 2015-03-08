unit UserMng;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, Buttons, Db, DBGrids, ExtCtrls, UtilUnit, ComCtrls,
  Tabnotbk, Mask, ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TUserManagerForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    StringGrid: TStringGrid;
    Label1: TLabel;
    UserNameEdit: TEdit;
    Label2: TLabel;
    PasswordEdit: TEdit;
    Label3: TLabel;
    BirthdayEdit: TMaskEdit;
    Label4: TLabel;
    TelephoneEdit: TEdit;
    Label5: TLabel;
    AddressEdit: TMemo;
    Label6: TLabel;
    RateEdit: TEdit;
    Label7: TLabel;
    MobileEdit: TEdit;
    Label8: TLabel;
    FaxEdit: TEdit;
    Query: TADOQuery;
    TempQuery: TADOQuery;
    Label9: TLabel;
    DrawerPortNumberComboBox: TComboBox;
    DefaultDrawerPortNumberLabel: TLabel;
    DefaultDrawerPortNumberComboBox: TComboBox;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    EditPanel: TbsSkinPanel;
    TabbedNotebook: TbsSkinNotebook;
    GrantButton: TXiButton;
    RevokeButton: TXiButton;
    NewButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    ExitButton: TXiButton;
    DetailPanel: TbsSkinPanel;
    StringGridPanel: TbsSkinPanel;
    Label10: TLabel;
    InquirySalesRelatedReportDaysEdit: TStaticText;
    procedure SetNoEdit;
    procedure SetEdit;
    procedure OpenTempQuery;
    procedure OpenQuery;
    procedure InitStringGridTitle;
    procedure InitStringGridCells;
    procedure UserNameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGridDblClick(Sender: TObject);
    function  AppendNewUserName: boolean;
    function  UpdateField(UserName, FieldNameStr, Right: string): boolean;
    function  UpdateOperatorRight: boolean;
    procedure DeleteButtonClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  ProcessEditStatus: Boolean;
    function  ProcessNewStatus: Boolean;
    procedure SaveButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SetUserPro;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridDblClick(Sender: TObject);
    procedure PasswordEditKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure BirthdayEditExit(Sender: TObject);
    procedure RateEditEnter(Sender: TObject);
    procedure RateEditExit(Sender: TObject);
    procedure BirthdayEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TelephoneEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MobileEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FaxEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RateEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UserNameEditDblClick(Sender: TObject);
    procedure PasswordEditDblClick(Sender: TObject);
    procedure BirthdayEditClick(Sender: TObject);
    procedure EditComponentClick(Sender: TObject);
    procedure RateEditClick(Sender: TObject);
    procedure AddressEditDblClick(Sender: TObject);
    procedure DrawerPortNumberComboBoxChange(Sender: TObject);
    procedure GrantButtonClick(Sender: TObject);
    procedure RevokeButtonClick(Sender: TObject);
    procedure InquirySalesRelatedReportDaysEditClick(Sender: TObject);
  private{ Private declarations }
    FieldName: array [1..200] of String;
    StatusFlag: integer;
    OldName: string;
  public
    { Public declarations }
  end;

var
  UserManagerForm: TUserManagerForm;

implementation

uses DataUnit, MainMenu, MessageBox, Keyboard, NumPad, DatePanel;

{$R *.DFM}

procedure TUserManagerForm.SetNoEdit;
begin
 EditPanel.Enabled := False;
 TabbedNotebook.PageIndex := 0;
 TabbedNotebook.Enabled := False;
 StringGrid.TopRow := 1;
 DBGrid.Enabled := True;
 UserNameEdit.Text := '';
 PasswordEdit.Text := '';
 BirthdayEdit.Text := FormatDateTime('dd/mm/yyyy', Date);
 TelephoneEdit.Text := '';
 MobileEdit.Text := '';
 FaxEdit.Text := '';
 AddressEdit.Text := '';
 RateEdit.Text := '';
 InquirySalesRelatedReportDaysEdit.Caption := '0';
 DrawerPortNumberComboBox.ItemIndex := 0;
 DefaultDrawerPortNumberComboBox.ItemIndex := 0;
 InitStringGridCells;
 NewButton.Enabled := True;
 EditButton.Enabled := True;
 DeleteButton.Enabled := True;
 ExitButton.Enabled := True;
 SaveButton.Enabled := False;
 CancelButton.Enabled := False;
 DrawerPortNumberComboBoxChange(Self);
end;

procedure TUserManagerForm.SetEdit;
begin
 EditPanel.Enabled := True;
 TabbedNotebook.Enabled := True;
 DBGrid.Enabled := False;
 NewButton.Enabled := False;
 EditButton.Enabled := False;
 DeleteButton.Enabled := False;
 ExitButton.Enabled := False;
 SaveButton.Enabled := True;
 CancelButton.Enabled := True;
end;

procedure TUserManagerForm.OpenTempQuery;
begin
 Screen.Cursor := crHourGlass;
 with TempQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From Menu Order By MenuName');
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TUserManagerForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From AccessMenu Order By StaffName');
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TUserManagerForm.InitStringGridTitle;
var
 I, Count: integer;
begin
 OpenTempQuery;
 Count := TempQuery.RecordCount;
 StringGrid.RowCount := Count + 1;
 TempQuery.First;
 StringGrid.Cells[0, 0] := 'No.';
 StringGrid.Cells[1, 0] := 'Operating Description';
 StringGrid.Cells[2, 0] := 'OP';
 I := 1;
 while Not TempQuery.EOF do
  begin
   StringGrid.Cells[0, I] := Format('%1d', [I]);
   StringGrid.Cells[1, I] := TempQuery.FieldByName('MenuName').AsString;
   StringGrid.Cells[2, I] := '';
   FieldName[I] := TempQuery.FieldByName('FieldName').AsString;
   I := I + 1;
   TempQuery.Next;
  end;
 TempQuery.Close;
end;

procedure TUserManagerForm.InitStringGridCells;
var
 I: integer;
begin
 with StringGrid do
  begin
   for I := 1 to RowCount do
    Cells[2, I] := '';
   Col := 1; Row := 1;
  end;
end;

procedure TUserManagerForm.UserNameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
    PasswordEdit.SetFocus;
end;

procedure TUserManagerForm.PasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
    UserNameEdit.SetFocus;
end;

procedure TUserManagerForm.StringGridDblClick(Sender: TObject);
begin
 with StringGrid do
  if (Cells[1, Row] = 'Supervisor') and Not Supervisor then
     Exit
    else
     if Cells[2, Row] = '' then
        Cells[2, Row] := 'Y'
       else
        Cells[2, Row] := '';
end;

function TUserManagerForm.AppendNewUserName: boolean;
var
 SQLStr, Telephone, Mobile, Fax, Address, Rate, DrawerPortNumber,
 DefaultDrawerPortNumber, InquirySalesRelatedReportDays: string;
 I: integer;
begin
 if TelephoneEdit.Text <> '' then
    Telephone := Chr(39) + CheckQuotes(TelephoneEdit.Text) + Chr(39)
   else
    Telephone := 'Null';
 if MobileEdit.Text <> '' then
    Mobile := Chr(39) + CheckQuotes(MobileEdit.Text) + Chr(39)
   else
    Mobile := 'Null';
 if FaxEdit.Text <> '' then
    Fax := Chr(39) + CheckQuotes(FaxEdit.Text) + Chr(39)
   else
    Fax := 'Null';
 if AddressEdit.Text <> '' then
    Address := Chr(39) + CheckQuotes(AddressEdit.Text) + Chr(39)
   else
    Address := 'Null';
 if RateEdit.Text <> '' then
    Rate := RateEdit.Text
   else
    Rate := '0';
 if InquirySalesRelatedReportDaysEdit.Caption <> '' then
    InquirySalesRelatedReportDays := InquirySalesRelatedReportDaysEdit.Caption
   else
    InquirySalesRelatedReportDays := '0';
 DrawerPortNumber := IntToStr(DrawerPortNumberComboBox.ItemIndex);
 DefaultDrawerPortNumber := IntToStr(DefaultDrawerPortNumberComboBox.ItemIndex);
 SQLStr := 'Insert Into AccessMenu(StaffName, SecureCode, Birthday, Telephone, ' +
           'Mobile, Fax, Address, Rate, DrawerPortNumber, DefaultDrawerPortNumber, ' +
           'InquirySalesRelatedReportDays';
 for I := 1 to StringGrid.RowCount - 1 do
  SQLStr := SQLStr + ',' + FieldName[I];
 SQLStr := SQLStr + ') Values('+ Chr(39) + CheckQuotes(UserNameEdit.Text) + Chr(39) + ',' +
           Chr(39) + CheckQuotes(PasswordEdit.Text) + Chr(39) +
           ',' + ConvertDateTime(TransferDate(BirthdayEdit.Text)) + ',' +
           Telephone + ',' + Mobile + ',' + Fax + ',' + Address + ',' + Rate + ',' +
           DrawerPortNumber + ',' + DefaultDrawerPortNumber + ',' +
           InquirySalesRelatedReportDays;
 for I := 1 to StringGrid.RowCount - 1 do SQLStr := SQLStr + ', 0';
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TUserManagerForm.UpdateField(UserName, FieldNameStr, Right: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Update AccessMenu Set ' + FieldNameStr + '=' + Right +
           ' Where StaffName=' + Chr(39) + CheckQuotes(UserName) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TUserManagerForm.UpdateOperatorRight: boolean;
var
 I: integer;
 UserName, FieldNameStr, Right: string;
begin
 UserName := UserNameEdit.Text;
 I := 1; Result := True;
 while (I < StringGrid.RowCount) and Result do
  begin
   FieldNameStr := FieldName[I];
   if StringGrid.Cells[2, I] = '' then
      Right := '0'
     else
      Right := '1';
      Result := UpdateField(UserName, FieldNameStr, Right);
   I := I + 1;
  end;
end;

procedure TUserManagerForm.DeleteButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if (MessageBoxForm.MessagePro('Are you sure you want to delete this record?', sConfirmMsg)
     = mrNo) then Exit;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  SQLStr := 'Delete From AccessMenu where StaffName=' +
            Chr(39) + CheckQuotes(Query.FieldByName('StaffName').AsString) + Chr(39);
  Flag := DataForm.ExecQueryPro(SQLStr);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      OpenQuery;
     end
    else
     begin
      DataForm.RollBack;
     end;
 end;
end;

procedure TUserManagerForm.NewButtonClick(Sender: TObject);
begin
 SetEdit;
 StatusFlag := sNewStatus;
 UserNameEdit.SetFocus;
end;

procedure TUserManagerForm.DBGridDblClick(Sender: TObject);
begin
 if Query.RecordCount > 0 then
    EditButtonClick(Sender);
end;

procedure TUserManagerForm.EditButtonClick(Sender: TObject);
var
 I: integer;
begin
 with Query do
  if Not Supervisor and FieldByName('Supervisor').AsBoolean then
     MessageBoxForm.MessagePro('You have not been authorised to edit supervisor account.', sErrorMsg)
    else
     begin
      UserNameEdit.Text := FieldByName('StaffName').AsString;
      OldName := FieldByName('StaffName').AsString;
      PasswordEdit.Text := FieldByName('SecureCode').AsString;
      BirthdayEdit.Text := FormatDateTime('dd/mm/yyyy', FieldByName('Birthday').AsDateTime);
      TelephoneEdit.Text := FieldByName('Telephone').AsString;
      MobileEdit.Text := FieldByName('Mobile').AsString;
      FaxEdit.Text := FieldByName('Fax').AsString;
      AddressEdit.Text := FieldByName('Address').AsString;
      RateEdit.Text := Format('%10.2f', [FieldByName('Rate').AsFloat]);
      DrawerPortNumberComboBox.ItemIndex := FieldByName('DrawerPortNumber').AsInteger;
      DefaultDrawerPortNumberComboBox.ItemIndex := FieldByName('DefaultDrawerPortNumber').AsInteger;
      InquirySalesRelatedReportDaysEdit.Caption := IntToStr(FieldByName('InquirySalesRelatedReportDays').AsInteger);
      DrawerPortNumberComboBoxChange(Sender);
      for I := 1 to StringGrid.RowCount - 1 do
       begin
        if FieldByName(FieldName[I]).AsBoolean then
           StringGrid.Cells[2, I] := 'Y'
          else
           StringGrid.Cells[2, I] := '';
       end;
      SetEdit;
      StatusFlag := sEditStatus;
      UserNameEdit.SetFocus;
     end;
end;

procedure TUserManagerForm.CancelButtonClick(Sender: TObject);
begin
 if MessageBoxForm.MessagePro('Are you sure you want to cancel?', sConfirmMsg) = mrNo then
    Exit;
 SetNoEdit;
end;

function TUserManagerForm.ProcessEditStatus: Boolean;
var
 Flag: integer;
begin
 Result := TRUE;
 if OldName <> UserNameEdit.Text then
    begin
     Flag := DataForm.CheckCodeSQLPro('Select Count(*) From AccessMenu where StaffName=' + Chr(39) + CheckQuotes(UserNameEdit.Text) + Chr(39));
     if (Flag > 0) and
      (MessageBoxForm.MessagePro(UserNameEdit.Text + ' is already exist, do you want to replace?', sConfirmMsg) = mrNo) then
        begin
         Result := False;
         Exit;
        end;
     Result := DataForm.ExecQueryPro('Delete From AccessMenu Where StaffName=' + Chr(39) + CheckQuotes(UserNameEdit.Text) + Chr(39));
    end;
 if Result then
    DataForm.ExecQueryPro('Delete From AccessMenu Where StaffName=' + Chr(39) + CheckQuotes(OldName) + Chr(39));
 if Result then
    Result := AppendNewUserName;
 if Result then
    Result := UpdateOperatorRight;
end;

function TUserManagerForm.ProcessNewStatus: boolean;
var
 Flag: integer;
begin
 Flag := DataForm.CheckCodeSQLPro('Select Count(*) From AccessMenu where StaffName=' +
         Chr(39) + CheckQuotes(UserNameEdit.Text) + Chr(39));
 if Flag > 0 then
    begin
     MessageBoxForm.MessagePro(UserNameEdit.Text + ' is already exist.', sErrorMsg);
     Result := False;
    end
   else
    Result := AppendNewUserName;
 if Result then
    Result := UpdateOperatorRight;
end;

procedure TUserManagerForm.SaveButtonClick(Sender: TObject);
var
 Flag: boolean;
 UserName: string;
begin
 if (UserNameEdit.Text = '') or (PasswordEdit.Text = '') then
    MessageBoxForm.MessagePro('Some fields error!', sErrorMsg)
   else
    begin
     Flag := False;
     if Not DataForm.BeginTransaction then Exit;
     try
      if StatusFlag = sNewStatus then
         Flag := ProcessNewStatus
        else
         Flag := ProcessEditStatus;
     finally
      if Flag then
         begin
          DataForm.CommitTransaction;
          UserName := UserNameEdit.Text;
          SetNoEdit;
          OpenQuery;
          Query.Locate('StaffName', UserName, [loPartialKey]);
         end
        else
         begin
          DataForm.RollBack;
         end;
     end;
    end;
end;

procedure TUserManagerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if ExitButton.Enabled then
    begin
     Query.Close;
     Action := caFree;
    end
   else
    Action := caNone;
end;

procedure TUserManagerForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TUserManagerForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TUserManagerForm.DrawerPortNumberComboBoxChange(Sender: TObject);
begin
 DefaultDrawerPortNumberLabel.Visible := DrawerPortNumberComboBox.ItemIndex = 2;
 DefaultDrawerPortNumberComboBox.Visible := DefaultDrawerPortNumberLabel.Visible;
end;

procedure TUserManagerForm.PasswordEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Not (Key In ['0'..'9', 'a'..'z', 'A'..'Z', Chr(8), Chr(13)]) then
    Key := Chr(0);
end;

procedure TUserManagerForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   if (ARow > 0) and (ACol > 0) then
      case ACol of
        1: begin
               SetTextAlign(Canvas.Handle, TA_LEFT);
               X := Rect.Left + 2;
           end;
       else
         begin
          SetTextAlign(Canvas.Handle, TA_CENTER);
          X := (Rect.Left + Rect.Right) div 2;
         end;
      end
     else
      begin
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TUserManagerForm.BirthdayEditExit(Sender: TObject);
begin
 if Not CheckDate(BirthdayEdit.Text) then
    BirthdayEdit.SetFocus;
end;

procedure TUserManagerForm.RateEditEnter(Sender: TObject);
begin
 if RateEdit.Text = '' then
    RateEdit.Text := '0.00'
   else
    RateEdit.Text := Format('%4.2f', [StrToFloat(RateEdit.Text)]);
 RateEdit.SelectAll;
end;

procedure TUserManagerForm.RateEditExit(Sender: TObject);
begin
 if (RateEdit.Text = '') or Not CheckNum(RateEdit.Text, 10, 999999.99, 0.0, 'F') then
    begin
     RateEdit.Text := '0.00';
     RateEdit.SetFocus;
    end
   else
    RateEdit.Text := Format('%10.2f', [StrToFloat(RateEdit.Text)]);
end;

procedure TUserManagerForm.BirthdayEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TelephoneEdit.SetFocus;
end;

procedure TUserManagerForm.TelephoneEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then MobileEdit.SetFocus;
end;

procedure TUserManagerForm.MobileEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then FaxEdit.SetFocus;
end;

procedure TUserManagerForm.FaxEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then AddressEdit.SetFocus;
end;

procedure TUserManagerForm.RateEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then BirthdayEdit.SetFocus;
end;

procedure TUserManagerForm.UserNameEditDblClick(Sender: TObject);
var
 Temp: string;
begin
 if KeyboardForm.KeyboardPro(Temp) then
    with Sender As TEdit do
     Text := Uppercase(Temp);
end;

procedure TUserManagerForm.PasswordEditDblClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, True, False, 'Password', 0) then
    with Sender As TEdit do Text := NumStr;
end;

procedure TUserManagerForm.BirthdayEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   DateTemp := Date;
   if DateForm.ReadDatePro(DateTemp) then
      Text := FormatDateTime('dd/mm/yyyy', DateTemp);
  end;
end;

procedure TUserManagerForm.EditComponentClick(Sender: TObject);
var
 Temp: string;
begin
 if KeyboardForm.KeyboardPro(Temp) then
    with Sender As TEdit do
     Text := Temp;
end;

procedure TUserManagerForm.RateEditClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TEdit do
  begin
   NumStr := Text;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Discount Rate', 0) then
      Text := NumStr;
  end;
end;

procedure TUserManagerForm.AddressEditDblClick(Sender: TObject);
var
 Temp: string;
begin
 if KeyboardForm.KeyboardPro(Temp) then
    with Sender As TMemo do Text := Temp;
end;

procedure TUserManagerForm.GrantButtonClick(Sender: TObject);
var
 I: integer;
begin
 with StringGrid do
  for I := 1 to RowCount do
   if (Cells[1, I] <> 'Supervisor') or Supervisor then
      Cells[2, I] := 'Y'
end;

procedure TUserManagerForm.RevokeButtonClick(Sender: TObject);
var
 I: integer;
begin
 with StringGrid do
  for I := 1 to RowCount do
   if (Cells[1, I] <> 'Supervisor') or Supervisor then
       Cells[2, I] := ''
end;

procedure TUserManagerForm.InquirySalesRelatedReportDaysEditClick(Sender: TObject);
var
 NumStr: string;
begin
 if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Inquiry Sales Related Repory Days', 0) and
    CheckNum(NumStr, 8, 99999999, 0, 'D') then
    InquirySalesRelatedReportDaysEdit.Caption := NumStr;
end;

procedure TUserManagerForm.FormShow(Sender: TObject);
begin
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
 InitStringGridTitle;
 OpenQuery;
 SetNoEdit;
end;

procedure TUserManagerForm.SetUserPro;
begin
 Application.CreateForm(TUserManagerForm, UserManagerForm);
 UserManagerForm.ShowModal;
 UserManagerForm.Free;
end;

end.
