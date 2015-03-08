unit Password;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, StdCtrls, Buttons, ExtCtrls, UtilUnit, bsSkinCtrls, BusinessSkinForm,
  XiButton;

type
  TPasswordEdit = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    UserNameEdit: TEdit;
    OldPasswordEdit: TEdit;
    NewPasswordEdit: TEdit;
    ConfirmPasswordEdit: TEdit;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    procedure OldPasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure NewPasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ConfirmPasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    function  CheckPassword: boolean;
    function  SetPassword: boolean;
    function  CheckEdit: boolean;
    procedure CancelButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChangePassword;
    procedure ConfirmKeyKeyPress(Sender: TObject; var Key: Char);
    procedure OldPasswordEditKeyPress(Sender: TObject; var Key: Char);
    procedure PasswordButton1Click(Sender: TObject);
    procedure PasswordButton2Click(Sender: TObject);
    procedure PasswordButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasswordEdit: TPasswordEdit;

implementation

uses DataUnit, NumPad, MainMenu, MessageBox;

{$R *.DFM}

procedure TPasswordEdit.OldPasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
    NewPasswordEdit.SetFocus;
end;

procedure TPasswordEdit.NewPasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
    ConfirmPasswordEdit.SetFocus;
end;

procedure TPasswordEdit.ConfirmPasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
    SaveButton.SetFocus;
end;

procedure TPasswordEdit.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TPasswordEdit.OldPasswordEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Not (Key In ['0'..'9', 'a'..'z', 'A'..'Z', Chr(8), Chr(13)]) then
    Key := Chr(0);
end;

function TPasswordEdit.CheckPassword: boolean;
var
 SQLStr: String;
begin
 SQLStr := 'Select Count(*) From AccessMenu where StaffName=' +
           Chr(39) + CheckQuotes(UserNameEdit.Text) + Chr(39) + ' and SecureCode=' +
            Chr(39) + CheckQuotes(OldPasswordEdit.Text) + Chr(39);
 if DataForm.CheckCodeSQLPro(SQLStr) >= 1 then
    Result := True
   else
    begin
     MessageBoxForm.MessagePro('Old password is invalid!', sErrorMsg);
     Result := False;
    end
end;

function TPasswordEdit.SetPassword: boolean;
var
 SQLStr: string;
begin
 Result := False;
 SQLStr := 'UPDATE AccessMenu Set SecureCode=' + Chr(39) + CheckQuotes(NewPasswordEdit.Text) + Chr(39) +
           ' where StaffName=' + Chr(39) + CheckQuotes(UserNameEdit.Text) + Chr(39) + ' and SecureCode=' +
            Chr(39) + CheckQuotes(OldPasswordEdit.Text) + Chr(39);
 if Not DataForm.BeginTransaction then Exit;
 try
  Result := DataForm.ExecQueryPro(SQLStr);
 finally
  if Result then
     DataForm.CommitTransaction
    else
     begin
      DataForm.RollBack;
     end;
 end;
end;

procedure TPasswordEdit.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

function TPasswordEdit.CheckEdit: boolean;
begin
 Result := False;
 if OldPasswordEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Old password is invalid!', sErrorMsg);
     OldPasswordEdit.SetFocus;
     Exit;
    end;
 if NewPasswordEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('New password is invalid!', sErrorMsg);
     NewPasswordEdit.SetFocus;
     Exit;
    end;
 if (ConfirmPasswordEdit.Text = '') or
    (NewPasswordEdit.Text <> ConfirmPasswordEdit.Text) then
    begin
     MessageBoxForm.MessagePro('The new password was not correctly confirmed. Be sure' + Chr(13) + Chr(10) +
                               'that the confirmation password exactly matches the new' + Chr(13) + Chr(10) +
                               'password.', sErrorMsg);
     ConfirmPasswordEdit.SetFocus;
     Exit;
    end;
 Result := True;
end;

procedure TPasswordEdit.ConfirmKeyKeyPress(Sender: TObject; var Key: Char);
begin
 SaveButtonClick(Sender);
end;

procedure TPasswordEdit.SaveButtonClick(Sender: TObject);
begin
 if CheckEdit and CheckPassword and SetPassword then
    Close;
end;

procedure TPasswordEdit.PasswordButton1Click(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 OldPasswordEdit.SetFocus;
 if NumberPadForm.ReadNumberPro(NumStr, True, False, 'Password', 0) then
    begin
     OldPasswordEdit.Text := NumStr;
     NewPasswordEdit.SetFocus;
    end;
end;

procedure TPasswordEdit.PasswordButton2Click(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 NewPasswordEdit.SetFocus;
 if NumberPadForm.ReadNumberPro(NumStr, True, False, 'Password', 0) then
    begin
     NewPasswordEdit.Text := NumStr;
     ConfirmPasswordEdit.SetFocus;
    end;
end;

procedure TPasswordEdit.PasswordButton3Click(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 ConfirmPasswordEdit.SetFocus;
 if NumberPadForm.ReadNumberPro(NumStr, True, False, 'Password', 0) then
    begin
     ConfirmPasswordEdit.Text := NumStr;
     SaveButton.SetFocus;
    end;
end;

procedure TPasswordEdit.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := SaveButton.Top + 86;
 UserNameEdit.Text := sUserName;
end;

procedure TPasswordEdit.ChangePassword;
begin
 Application.CreateForm(TPasswordEdit, PasswordEdit);
 PasswordEdit.ShowModal;
 PasswordEdit.Free;
end;

end.
