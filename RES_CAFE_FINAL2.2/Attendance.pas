unit Attendance;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, UtilUnit, ADODB, bsSkinCtrls,
  BusinessSkinForm, XiButton, bsSkinBoxCtrls, Mask;

type
  TAttendanceForm = class(TForm)
    Timer1: TTimer;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    NameEdit: TbsSkinEdit;
    PasswordEdit: TbsSkinPasswordEdit;
    bsSkinStdLabel3: TbsSkinStdLabel;
    DateTimeEdit: TbsSkinStdLabel;
    NameButton: TbsSkinSpeedButton;
    PasswordButton: TbsSkinSpeedButton;
    LoginButton: TXiButton;
    LogoutButton: TXiButton;
    CancelButton: TXiButton;
    procedure OpenQuery(SQLStr: string);
    function  CheckPassword(StaffName, Password: string): boolean;
    procedure SearchLastRecord;
    function  SaveRecord: boolean;
    function  UpdateRecord: boolean;
    procedure FormShow(Sender: TObject);
    procedure AttendancePro;
    procedure NameEditClick(Sender: TObject);
    procedure PasswordEditClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure LoginButtonClick(Sender: TObject);
    procedure LogoutButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PasswordEditKeyPress(Sender: TObject; var Key: Char);
    procedure CancelButtonClick(Sender: TObject);
  private { Private declarations }
    RecordDate: TDateTime;
    IDNo: integer;
  public
    { Public declarations }
  end;

var
  AttendanceForm: TAttendanceForm;

implementation

uses MainMenu, StaffList, NumPad, DataUnit, MessageBox;

{$R *.DFM}

procedure TAttendanceForm.OpenQuery(SQLStr: string);
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
  end;
end;

function TAttendanceForm.CheckPassword(StaffName, Password: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select StaffName From AccessMenu Where ' +
           'StaffName=' + Chr(39) + CheckQuotes(StaffName) + Chr(39) +
           ' and SecureCode=' + Chr(39) + CheckQuotes(Password) + Chr(39);
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0) then
    Result := True
   else
    Result := False;
 Query.Close;
 if Not Result then MessageBoxForm.MessagePro('Password error!', sErrorMsg);
end;

procedure TAttendanceForm.SearchLastRecord;
var
 SQLStr: string;
begin
 SQLStr := 'Select StaffName, LoginTime, LogoutTime, IDNo ' +
           'From Attendance Where StaffName=' + Chr(39) + CheckQuotes(NameEdit.Text) + Chr(39) +
           ' and IDNo=(Select Max(IDNo) From Attendance Where StaffName=' +
           Chr(39) + CheckQuotes(NameEdit.Text) + Chr(39) + ')';
 OpenQuery(SQLStr);
end;

function TAttendanceForm.SaveRecord: boolean;
var
 SQLStr: string;
begin
 Result := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  SQLStr := 'Insert Into Attendance(StaffName, LoginTime, LogoutTime, IDNo) ' +
            'Values(' + Chr(39) + CheckQuotes(NameEdit.Text) + Chr(39) + ',' +
            ConvertDateTime(RecordDate) +
            ', Null,' + IntToStr(IDNo) + ')';
  Result := DataForm.ExecQueryPro(SQLStr);
 finally
  if Result then
     DataForm.CommitTransaction
    else
     begin
      DataForm.Rollback;
     end;
 end;
end;

function TAttendanceForm.UpdateRecord: boolean;
var
 SQLStr: string;
begin
 Result := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  SQLStr := 'Update Attendance Set LogoutTime=' +
            ConvertDateTime(RecordDate) +
           ' Where IDNo=' + IntToStr(IDNo) + ' and StaffName=' +
           Chr(39) + CheckQuotes(NameEdit.Text) + Chr(39);
  Result := DataForm.ExecQueryPro(SQLStr);
 finally
  if Result then
     DataForm.CommitTransaction
    else
     begin
      DataForm.Rollback;
     end;
 end;
end;

procedure TAttendanceForm.NameEditClick(Sender: TObject);
var
 StaffName: string;
begin
 if StaffListForm.ListStaffPro(StaffName) then
    begin
     NameEdit.Text := StaffName;
     PasswordEdit.SetFocus
    end;
end;

procedure TAttendanceForm.PasswordEditClick(Sender: TObject);
var
 NumStr: string;
begin
 PasswordEdit.SetFocus;
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, True, False, 'Password', 0) then
    PasswordEdit.Text := NumStr;
end;

procedure TAttendanceForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TAttendanceForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TAttendanceForm.PasswordEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Not (Key In ['0'..'9', 'a'..'z', 'A'..'Z', Chr(8), Chr(13)]) then
    Key := Chr(0);
end;

procedure TAttendanceForm.Timer1Timer(Sender: TObject);
begin
 RecordDate := Date + Time;
 DateTimeEdit.Caption := FormatdateTime('ddd, d mmm yyyy hh:mm:ss', RecordDate);
end;

procedure TAttendanceForm.LoginButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 if Not CheckPassword(NameEdit.Text, PasswordEdit.Text) then Exit;
 SearchLastRecord;
 if Query.RecordCount = 0 then
    begin
     Flag := True;
     IDNo := 1;
    end
   else
    if Query.FieldByName('LogoutTime').AsDateTime <> 0 then
       begin
        IDNo := Query.FieldByName('IDNo').AsInteger + 1;
        Flag := True;
       end
      else
       Flag := False;
 Query.Close;
 if Flag then
    begin
     if SaveRecord then Close;
    end
   else
    MessageBoxForm.MessagePro('Your last clock out record can not be found, ' +
     Chr(13) + Chr(10) +  Chr(13) + Chr(10) +
     'please contact your manager.', sInformationMsg);
end;

procedure TAttendanceForm.LogoutButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 if Not CheckPassword(NameEdit.Text, PasswordEdit.Text) then Exit;
 SearchLastRecord;
 if (Query.RecordCount = 0) or
    (Query.FieldByName('LogoutTime').AsDateTime <> 0) then
    Flag := False
   else
    begin
     IDNo := Query.FieldByName('IDNo').AsInteger;
     Flag := True;
    end;
 Query.Close;
 if Flag then
    begin
     if UpdateRecord then Close;
    end
   else
    MessageBoxForm.MessagePro(
      'Your last clock in record can not be found,' +
       Chr(13) + Chr(10) +  Chr(13) + Chr(10) +
      'please contact your manager.', sInformationMsg)
end;

procedure TAttendanceForm.FormShow(Sender: TObject);
begin
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
 RecordDate := Date + Time;
 DateTimeEdit.Caption := FormatDateTime('ddd, d mmm yyyy hh:mm:ss', RecordDate);
 NameEdit.SetFocus;
end;

procedure TAttendanceForm.AttendancePro;
begin
 Application.CreateForm(TAttendanceForm, AttendanceForm);
 AttendanceForm.ShowModal;
 AttendanceForm.Free;
end;

end.
