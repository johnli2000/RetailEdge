unit ReadCustomerName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainMenu, DataUnit, BusinessSkinForm, XiButton, StdCtrls,
  bsSkinCtrls;

type
  TReadCustomerNameForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    EditPanel: TbsSkinPanel;
    Label1: TLabel;
    CustomerNameEdit: TEdit;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    KeyboardButton: TXiButton;
    procedure CustomerNameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function  ReadCustomerNamePro(var CustomerName: string): boolean;
    procedure KeyboardButtonClick(Sender: TObject);
  private { Private declarations }
     CustomerName: string;
     ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  ReadCustomerNameForm: TReadCustomerNameForm;

implementation

uses MessageBox, Keyboard;

{$R *.dfm}

procedure TReadCustomerNameForm.CustomerNameEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ConfirmButtonClick(Sender);
end;

procedure TReadCustomerNameForm.ConfirmButtonClick(Sender: TObject);
begin
 if CustomerNameEdit.Text <> '' then
    begin
     ReturnFlag := True;
     CustomerName := CustomerNameEdit.Text;
     Close
    end
   else
    MessageBoxForm.MessagePro('Customer Name is invalid.', sErrorMsg)
end;

procedure TReadCustomerNameForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TReadCustomerNameForm.KeyboardButtonClick(Sender: TObject);
var
 CustomerName: string;
begin
 if KeyboardForm.KeyboardPro(CustomerName) then
    CustomerNameEdit.Text := CustomerName;
end;

procedure TReadCustomerNameForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TReadCustomerNameForm.FormShow(Sender: TObject);
begin
 CustomerNameEdit.Text := CustomerName;
 CustomerNameEdit.SetFocus;
end;

function TReadCustomerNameForm.ReadCustomerNamePro(var CustomerName: string): boolean;
begin
 Application.CreateForm(TReadCustomerNameForm, ReadCustomerNameForm);
 ReadCustomerNameForm.CustomerName := CustomerName;
 ReadCustomerNameForm.ShowModal;
 Result := ReadCustomerNameForm.ReturnFlag;
 if Result then
    CustomerName := ReadCustomerNameForm.CustomerName;
 ReadCustomerNameForm.Free;
end;

end.
