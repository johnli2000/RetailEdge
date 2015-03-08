unit Regist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DataUnit, UtilUnit, Security, bsSkinCtrls,
  BusinessSkinForm, XiButton;

type
  TRegistryForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ActivationKeyEdit: TEdit;
    WarningLabel: TLabel;
    Memo: TMemo;
    IDEdit: TStaticText;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    WarningPanel: TbsSkinPanel;
    RegistPanel: TbsSkinPanel;
    RegistryButton: TXiButton;
    EvaluateButton: TXiButton;
    ExitButton: TXiButton;
    function  TestActivationKey: boolean;
    procedure EvaluateButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure RegistryButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function  RegistyPro: boolean;
    procedure ActivationKeyEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActivationKeyEditClick(Sender: TObject);
  private{ Private declarations }
   ReturnFlag: boolean;
   MessageConst: string;
  public
    { Public declarations }
  end;

var
  RegistryForm: TRegistryForm;

implementation

uses MainMenu, ControlPanel, MessageBox, Keyboard;

{$R *.DFM}

procedure TRegistryForm.EvaluateButtonClick(Sender: TObject);
begin
 SecurityForm.SaveRegistFile(0);
 ReturnFlag := True;
 Close;
end;

procedure TRegistryForm.ExitButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

function TRegistryForm.TestActivationKey: boolean;
begin
 Result := SecurityForm.DecodeSecurityCode(SecurityForm.GenerateSecureCode(StrToInt(IDEdit.Caption))) = ActivationKeyEdit.Text;
end;

procedure TRegistryForm.RegistryButtonClick(Sender: TObject);
begin
 if (ActivationKeyEdit.Text = '') or (Not TestActivationKey) then
    MessageDlg(MessageConst, mtError, [mbOk], 0)
   else
    begin
     SecurityForm.SaveRegistFile(SecurityForm.GenerateSecureCode(StrToInt(IDEdit.Caption)));
     ReturnFlag := True;
     MainForm.RegistProgramMenu.Visible := False;
     MainForm.RegistLine.Visible := False;
     Close;
    end;
end;

procedure TRegistryForm.ActivationKeyEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then ExitButtonClick(Sender)
   else Key := Upcase(Key);
end;

procedure TRegistryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TRegistryForm.FormShow(Sender: TObject);
var
 DayTemp: double;
 I: integer;
begin
 for I := Length(sInvalidActivationKey) downto 1 do
  MessageConst := MessageConst + sInvalidActivationKey[I];

 IDEdit.Caption := Format('%d', [DefaultMacAddress]);
 DayTemp := SecurityForm.GetExpireDate;
 EvaluateButton.Visible := DayTemp > 0;
 if EvaluateButton.Visible then
    begin
     RegistryButton.Left := 34;
     EvaluateButton.Left := 138;
     ExitButton.Left := 242;
    end
   else
    begin
     RegistryButton.Left := 54;
     EvaluateButton.Left := 138;
     ExitButton.Left := 222;
    end;
 WarningLabel.Caption := 'You have ' + Format('%1.0f', [DayTemp]) + ' day(s) left to evaluate this program';
end;

procedure TRegistryForm.ActivationKeyEditClick(Sender: TObject);
var
 KeyNumber: string;
begin
 if KeyboardForm.KeyboardPro(KeyNumber) then
    with Sender As TEdit do
     Text := Uppercase(KeyNumber);
end;

function TRegistryForm.RegistyPro: boolean;
begin
 Application.CreateForm(TRegistryForm, RegistryForm);
 RegistryForm.ShowModal;
 Result := RegistryForm.ReturnFlag;
 RegistryForm.Free;
 RegistryForm := Nil;
end;

end.
