unit ReadPassword;

interface

uses
  WinTypes, WinProcs, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Buttons, Administration, bsSkinCtrls,
  BusinessSkinForm, XiButton;

type
  TReadPasswordForm = class(TForm)
    NameEdit: TEdit;
    PasswordEdit: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure NameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  ReadPasswordPro(var UserName, Password: string): boolean;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PasswordEditKeyPress(Sender: TObject; var Key: Char);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private { Private declarations }
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  ReadPasswordForm: TReadPasswordForm;

implementation

{$R *.DFM}

procedure TReadPasswordForm.NameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) or (Key = VK_DOWN) then PasswordEdit.SetFocus
end;

procedure TReadPasswordForm.PasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (Key = VK_RETURN) or (Key = VK_DOWN) then ConfirmButton.SetFocus
    else
     if Key = VK_UP then NameEdit.SetFocus;
end;

procedure TReadPasswordForm.PasswordEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Not (Key In ['0'..'9', 'a'..'z', 'A'..'Z', Chr(8), Chr(13)]) then
    Key := Chr(0);
end;

procedure TReadPasswordForm.ConfirmButtonClick(Sender: TObject);
begin
 ReturnFlag := True;
 Close;
end;

procedure TReadPasswordForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TReadPasswordForm.FormShow(Sender: TObject);
begin
 NameEdit.SetFocus;
end;

procedure TReadPasswordForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

function TReadPasswordForm.ReadPasswordPro(var UserName, Password: string): boolean;
begin
 Application.CreateForm(TReadPasswordForm, ReadPasswordForm);
 ReadPasswordForm.ShowModal;
 Result := ReadPasswordForm.ReturnFlag;
 if Result then
    begin
     UserName := ReadPasswordForm.NameEdit.Text;
     Password := ReadPasswordForm.PasswordEdit.Text;
    end;
 ReadPasswordForm.Free;
end;

end.
