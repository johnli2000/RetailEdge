unit AttendanceEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, Mask, UtilUnit, Variants,
  ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TAttendanceEditForm = class(TForm)
    NameEdit: TEdit;
    DateEdit1: TMaskEdit;
    TimeEdit1: TMaskEdit;
    DateEdit2: TMaskEdit;
    TimeEdit2: TMaskEdit;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    NamePanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    DatePanel: TbsSkinPanel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure ReadRecord;
    function  UpdateRecord: boolean;
    procedure FormShow(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure TimeEditClick(Sender: TObject);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  AttendanceEditPro(StaffName: string; IDNo: integer): boolean;
    procedure CancelButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }
    IDNo: integer;
    StaffName: string;
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  AttendanceEditForm: TAttendanceEditForm;

implementation

uses NumPad, DataUnit, DatePanel, TimePanel, MainMenu;

{$R *.DFM}

procedure TAttendanceEditForm.ReadRecord;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From Attendance Where StaffName=' +
            Chr(39) + CheckQuotes(StaffName) + Chr(39) +
           ' and IDNo=' + IntToStr(IDNo);
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
   if Active and (RecordCount <> 0) then
      begin
       DateEdit1.Text :=
        FormatDateTime('dd/mm/yyyy', FieldByName('LoginTime').AsDateTime);
       TimeEdit1.Text :=
        FormatDateTime('hh:mm:ss', FieldByName('LoginTime').AsDateTime);
      if Not VarIsNull(FieldByName('LogoutTime').AsDateTime) and
         (FieldByName('LogoutTime').AsDateTime <> 0) then
         begin
          DateEdit2.Text :=
            FormatDateTime('dd/mm/yyyy', FieldByName('LogoutTime').AsDateTime);
          TimeEdit2.Text :=
            FormatDateTime('hh:mm:ss', FieldByName('LogoutTime').AsDateTime);
         end
        else
         begin
          DateEdit2.Text := '';
          TimeEdit2.Text := '';
         end
      end;
   Active := False;
  end;
end;

procedure TAttendanceEditForm.DateEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   if Text <> '  /  /    ' then
      DateTemp := TransferDate(Text)
     else
      DateTemp := Date;
   if DateForm.ReadDatePro(DateTemp) then
      Text := FormatDateTime('dd/mm/yyyy', DateTemp);
  end;
end;

procedure TAttendanceEditForm.TimeEditClick(Sender: TObject);
var
 TimeStr: string;
begin
 with Sender As TMaskEdit do
  begin
   if Text <> '  :  :  ' then
      TimeStr := Text
     else
      TimeStr := FormatDateTime('hh:mm:ss', Time);
   if TimeForm.ReadTimePro(TimeStr) then
      Text := FormatDateTime('hh:mm:ss', StrToTime(TimeStr));
  end;
end;

procedure TAttendanceEditForm.DateEdit1Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit1.Text) then DateEdit1.SetFocus;
end;

procedure TAttendanceEditForm.DateEdit2Exit(Sender: TObject);
begin
 if (DateEdit2.Text <> '  /  /    ') and Not CheckDate(DateEdit2.Text) then
    DateEdit2.SetFocus;
end;

procedure TAttendanceEditForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit1.SetFocus;
end;

procedure TAttendanceEditForm.TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TAttendanceEditForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit2.SetFocus;
end;

procedure TAttendanceEditForm.TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ConfirmButton.SetFocus;
end;

function TAttendanceEditForm.UpdateRecord: boolean;
var
 SQLStr: string;
 LoginTime, LogoutTime: TDateTime;
begin
 LoginTime := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
 SQLStr := 'Update Attendance Set LoginTime=' +
           ConvertDateTime(LoginTime) +
           ', LogoutTime=';
 if (DateEdit2.Text = '  /  /    ') or (TimeEdit2.Text = '  :  :  ') then
    SQLStr := SQLStr + 'Null'
   else
    begin
     LogoutTime := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLSTr := SQLStr + ConvertDateTime(LogoutTime);
    end;
 SQLStr := SQLStr + ' Where IDNo=' + IntToStr(IDNo) + ' and StaffName=' +
           Chr(39) + CheckQuotes(StaffName) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
end;

procedure TAttendanceEditForm.ConfirmButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  ReturnFlag := UpdateRecord;
 finally
  if returnFlag then
     begin
      DataForm.CommitTransaction;
      Close;
     end
    else
     begin
      DataForm.Rollback;
     end; 
 end;
end;

procedure TAttendanceEditForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TAttendanceEditForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TAttendanceEditForm.FormShow(Sender: TObject);
begin
 NameEdit.Text := StaffName;
 ReadRecord;
end;

function TAttendanceEditForm.AttendanceEditPro(StaffName: string; IDNo: integer): boolean;
begin
 Application.CreateForm(TAttendanceEditForm, AttendanceEditForm);
 AttendanceEditForm.StaffName := StaffName;
 AttendanceEditForm.IDNo := IDNo;
 AttendanceEditForm.ShowModal;
 Result := AttendanceEditForm.ReturnFlag;
 AttendanceEditForm.Free;
end;

end.
