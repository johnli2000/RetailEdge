unit MenuLinkItemEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BusinessSkinForm, MainMenu, XiButton, StdCtrls, bsSkinCtrls;

type
  TMenuLinkItemEditForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    EditPanel: TbsSkinPanel;
    ItemCodeLabel: TStaticText;
    ItemDescriptionLabel: TStaticText;
    Label1: TLabel;
    PriceEdit: TStaticText;
    ChoiceCheckBox: TCheckBox;
    InstructionCheckBox: TCheckBox;
    OKButton: TXiButton;
    CancelButton: TXiButton;
    procedure PriceEditClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function  MenuKinkItemEditPro(ItemCode, Description: string; var Price: double;
              var Choice, Instruction: boolean): boolean;
  private { Private declarations }
     ReturnFlag: boolean;
     Price: double;
     Choice, Instruction: boolean;
     ItemCode, Description: string;
  public
    { Public declarations }
  end;

var
  MenuLinkItemEditForm: TMenuLinkItemEditForm;

implementation

uses NumPad;

{$R *.dfm}

procedure TMenuLinkItemEditForm.PriceEditClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TStaticText do
  begin
   NumStr := Caption;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Price', 0) then
      Caption := Format('%4.2f ', [StrToFloat(NumStr)])
  end;
end;

procedure TMenuLinkItemEditForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TMenuLinkItemEditForm.OKButtonClick(Sender: TObject);
begin
 Price := StrToFloat(PriceEdit.Caption);
 Choice := ChoiceCheckBox.Checked;
 Instruction := InstructionCheckBox.Checked;
 ReturnFlag := True;
 Close;
end;

procedure TMenuLinkItemEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TMenuLinkItemEditForm.FormShow(Sender: TObject);
begin
 ItemCodeLabel.Caption := ItemCode;
 ItemDescriptionLabel.Caption := Description;
 PriceEdit.Caption := Format('%4.2f ', [Price]);
 ChoiceCheckBox.Checked := Choice;
 InstructionCheckBox.Checked := Instruction;
end;

function TMenuLinkItemEditForm.MenuKinkItemEditPro(ItemCode, Description: string;
             var Price: double; var Choice, Instruction: boolean): boolean;
begin
 Application.CreateForm(TMenuLinkItemEditForm, MenuLinkItemEditForm);
 MenuLinkItemEditForm.ItemCode := ItemCode;
 MenuLinkItemEditForm.Description := Description;
 MenuLinkItemEditForm.Price := Price;
 MenuLinkItemEditForm.Choice := Choice;
 MenuLinkItemEditForm.Instruction := Instruction;
 MenuLinkItemEditForm.ShowModal;
 Result := MenuLinkItemEditForm.ReturnFlag;
 if Result then
    begin
     Price := MenuLinkItemEditForm.Price;
     Choice := MenuLinkItemEditForm.Choice;
     Instruction := MenuLinkItemEditForm.Instruction;
    end;
 MenuLinkItemEditForm.Free;
end;

end.
