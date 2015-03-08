unit CustomerInformation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, MainMenu, bsSkinCtrls,
  BusinessSkinForm, XiButton;

type
  TCustomerInformationForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    NameEdit: TStaticText;
    TelephoneEdit: TStaticText;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    NameButton: TbsSkinButton;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    TelephoneButton: TbsSkinButton;
    EditPanel: TbsSkinPanel;
    procedure NameButtonClick(Sender: TObject);
    procedure TelephoneButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  ReadCustomerInfo(var Name, Telephone: string): boolean;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private { Private declarations }
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  CustomerInformationForm: TCustomerInformationForm;

implementation

uses Keyboard;

{$R *.dfm}

procedure TCustomerInformationForm.NameButtonClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    NameEdit.Caption := Copy(Str, 1, 25);
end;

procedure TCustomerInformationForm.TelephoneButtonClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    TelephoneEdit.Caption := Copy(Str, 1, 15);
end;

procedure TCustomerInformationForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TCustomerInformationForm.ConfirmButtonClick(Sender: TObject);
begin
 ReturnFlag := True;
 Close;
end;

procedure TCustomerInformationForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TCustomerInformationForm.FormShow(Sender: TObject);
begin
 Width := EditPanel.Width + 28;
 Height := ConfirmButton.Top + 86;
end;

function TCustomerInformationForm.ReadCustomerInfo(var Name, Telephone: string): boolean;
begin
 Application.CreateForm(TCustomerInformationForm, CustomerInformationForm);
 CustomerInformationForm.ShowModal;
 Result := CustomerInformationForm.ReturnFlag;
 if Result then
    begin
     Name := CustomerInformationForm.NameEdit.Caption;
     Telephone := CustomerInformationForm.TelephoneEdit.Caption;
    end;
 CustomerInformationForm.Free;
end;

end.
