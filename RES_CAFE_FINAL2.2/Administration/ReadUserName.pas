unit ReadUserName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Administration, BusinessSkinForm, XiButton, StdCtrls, Mask,
  bsSkinBoxCtrls, bsSkinCtrls, ComObj;

type
  TReadUserNameForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    UserNameEdit: TEdit;
    procedure CancelButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    function  ReadUserNamePro(var UserName: string): boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private { Private declarations }
     ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  ReadUserNameForm: TReadUserNameForm;

implementation

uses MessageBox;

{$R *.dfm}

procedure TReadUserNameForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TReadUserNameForm.ConfirmButtonClick(Sender: TObject);
begin
 if UserNameEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('User / User Group is invalid.', ErrorMsg);
     UserNameEdit.SetFocus;
    end
   else
    begin
     ReturnFlag := True;
     Close;
    end;
end;

procedure TReadUserNameForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

function TReadUserNameForm.ReadUserNamePro(var UserName: string): boolean;
begin
 Application.CreateForm(TReadUserNameForm, ReadUserNameForm);
 ReadUserNameForm.ShowModal;
 Result := ReadUserNameForm.ReturnFlag;
 if Result then UserName := ReadUserNameForm.UserNameEdit.Text;
 ReadUserNameForm.Free;
end;

end.
