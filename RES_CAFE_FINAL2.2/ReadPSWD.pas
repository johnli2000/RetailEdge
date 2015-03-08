unit ReadPSWD;

interface

uses
  WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DataUnit, Buttons, DB, UtilUnit,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TReadPassword = class(TForm)
    NameEdit: TEdit;
    PasswordEdit: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CancelKeyKeyPress(Sender: TObject; var Key: Char);
    procedure NameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ConfirmKeyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  ReadPasswordPro: boolean;
    procedure FormShow(Sender: TObject);
    procedure NameEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NameEditClick(Sender: TObject);
    procedure PasswordEditClick(Sender: TObject);
    procedure PasswordEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReadPassword: TReadPassword;
  ReadPasswordFlag: boolean;

implementation

uses MainMenu, StaffList, NumPad, ControlPanel;

{$R *.DFM}

procedure TReadPassword.ConfirmButtonClick(Sender: TObject);
begin
 if DataForm.TestPassword(NameEdit.Text, PasswordEdit.Text) then
    begin
     ReadDevicePortInfo;
     DataForm.OpenCompanyQuery;
     Password := DataForm.CompanyQuery.FieldByName('CheckPassword').AsBoolean;
     DataForm.CompanyQuery.Close;
     ReadPasswordFlag := True;
     Close;
    end;
end;

procedure TReadPassword.NameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) or (Key = VK_DOWN) then
     PasswordEdit.SetFocus
    else
     if (Key = VK_F5) then
         NameEditClick(Sender);
end;

procedure TReadPassword.PasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (Key = VK_RETURN) or (Key = VK_DOWN) then ConfirmButton.SetFocus;
 if (Key = VK_UP) then NameEdit.SetFocus;
end;

procedure TReadPassword.CancelButtonClick(Sender: TObject);
begin
 ReadPasswordFlag := False;
 Close;
end;

procedure TReadPassword.ConfirmKeyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ConfirmButtonClick(Sender);
 if Key = VK_UP then PasswordEdit.SetFocus;
end;

procedure TReadPassword.CancelKeyKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = char(VK_RETURN) then CancelButtonClick(Sender);
end;

procedure TReadPassword.NameEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key In ['a'..'z'] then Key := UpCase(Key)
end;

procedure TReadPassword.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TReadPassword.NameEditClick(Sender: TObject);
var
 StaffName: string;
begin
 if StaffListForm.ListStaffPro(StaffName) then
    begin
     NameEdit.Text := StaffName;
     PasswordEdit.SetFocus
    end;
end;

procedure TReadPassword.PasswordEditClick(Sender: TObject);
var
 NumStr: string;
begin
 PasswordEdit.SetFocus;
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, True, False, 'Password', 0) then
    begin
     PasswordEdit.Text := NumStr;
     ConfirmButton.SetFocus;
    end;
end;

procedure TReadPassword.FormShow(Sender: TObject);
begin
 Width := BackPanel.Width + 28;
 Height := CancelButton.Top + 86;
 NameEdit.Text := sUserName;
 NameEdit.SelectAll;
 NameEdit.SetFocus;
end;

procedure TReadPassword.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

function TReadPassword.ReadPasswordPro: boolean;
begin
 Application.CreateForm(TReadPassword, ReadPassword);
 ReadPassword.ShowModal;
 ReadPassword.Free;
 Result := ReadPasswordFlag;
end;

procedure TReadPassword.PasswordEditKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Not (Key In ['0'..'9', 'a'..'z', 'A'..'Z', Chr(8), Chr(13)]) then
    Key := Chr(0);
end;

end.
