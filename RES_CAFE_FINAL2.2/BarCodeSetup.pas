unit BarcodeSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ExtCtrls, UtilUnit, ADODB, bsSkinCtrls,
  MainMenu, BusinessSkinForm, XiButton;

type
  TBarcodeSetupForm = class(TForm)
    Label2: TLabel;
    PositionEdit: TEdit;
    PriceComboBox: TComboBox;
    BarCodeComboBox: TComboBox;
    Label1: TLabel;
    BarcodeQuantityEdit: TEdit;
    WorkPanel: TbsSkinPanel;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    procedure PrintButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure BarcodeSetupPro;
    procedure PositionEditEnter(Sender: TObject);
    procedure PositionEditExit(Sender: TObject);
    procedure PositionEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PositionEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure PriceComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BarcodeQuantityEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BarcodeSetupForm: TBarcodeSetupForm;

implementation

uses DataUnit, PrintBarcode;

{$R *.DFM}

procedure TBarcodeSetupForm.PriceComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PositionEdit.SetFocus;
end;

procedure TBarcodeSetupForm.PositionEditEnter(Sender: TObject);
begin
 with Sender As TEdit do
  begin
   if Text <> '' then Text := IntToStr(StrToInt(Text));
   SelectAll;
  end;
end;

procedure TBarcodeSetupForm.PositionEditExit(Sender: TObject);
begin
 with Sender As TEdit do
  begin
   if Text = '' then Text := '   1'
   else
    if Not CheckNum(Text, 4, 9999, 1, 'D') or (StrToInt(Text) = 0) then
       Text := '   1'
      else
       Text := Format('%4d', [StrToInt(Text)]);
  end;
end;

procedure TBarcodeSetupForm.PositionEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then BarCodeQuantityEdit.SetFocus;
end;

procedure TBarcodeSetupForm.BarcodeQuantityEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PrintButton.SetFocus;
end;

procedure TBarcodeSetupForm.PositionEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Not (Key In ['0'..'9', CHR(8)]) then
    Key := Chr(0);
end;

procedure TBarcodeSetupForm.PrintButtonClick(Sender: TObject);
var
 PriceFlag, BarcodeFlag, FirstPosition, Quantity: integer;
begin
 PriceFlag := PriceComboBox.ItemIndex;
 BarcodeFlag := BarcodeComboBox.ItemIndex;
 FirstPosition := StrToInt(PositionEdit.Text);
 Quantity := StrToInt(BarcodeQuantityEdit.Text);
 PrintBarcodeForm.PrintBarcodePro(PriceFlag, BarcodeFlag, FirstPosition, Quantity);
end;

procedure TBarcodeSetupForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TBarcodeSetupForm.FormShow(Sender: TObject);
begin
 PriceComboBox.ItemIndex := 0;
 BarCodeComboBox.ItemIndex := 0;
 PositionEdit.Text := '   1';
 BarcodeQuantityEdit.Text := '   1';
end;

procedure TBarcodeSetupForm.BarcodeSetupPro;
begin
 Application.CreateForm(TBarcodeSetupForm, BarcodeSetupForm);
 BarcodeSetupForm.ShowModal;
 BarcodeSetupForm.Free;
end;

end.
