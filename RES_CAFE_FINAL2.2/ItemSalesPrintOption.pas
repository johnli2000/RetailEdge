unit ItemSalesPrintOption;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, StdCtrls, Buttons, MainMenu, XiButton, bsSkinCtrls,
  BusinessSkinForm;

type
  TItemSalesPrintOptionForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    PrintToPOSPrinterButton: TXiButton;
    PrintToTextFileButton: TXiButton;
    CancelButton: TXiButton;
    PrintToA4PrinterButton: TXiButton;
    PrintSimpleReportButton: TXiButton;
    procedure PrintToPOSPrinterButtonClick(Sender: TObject);
    procedure PrintToTextFileButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    function  OptionPro: integer;
    procedure PrintToA4PrinterButtonClick(Sender: TObject);
    procedure PrintSimpleReportButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private { Private declarations }
    Select: integer;
  public
    { Public declarations }
  end;

var
  ItemSalesPrintOptionForm: TItemSalesPrintOptionForm;

implementation

uses DataUnit;

{$R *.DFM}

procedure TItemSalesPrintOptionForm.PrintToPOSPrinterButtonClick(Sender: TObject);
begin
 Select := 0;
 Close;
end;

procedure TItemSalesPrintOptionForm.PrintSimpleReportButtonClick(Sender: TObject);
begin
 Select := 1;
 Close;
end;

procedure TItemSalesPrintOptionForm.PrintToA4PrinterButtonClick(Sender: TObject);
begin
 Select := 2;
 Close;
end;

procedure TItemSalesPrintOptionForm.PrintToTextFileButtonClick(Sender: TObject);
begin
 Select := 3;
 Close;
end;

procedure TItemSalesPrintOptionForm.CancelButtonClick(Sender: TObject);
begin
 Select := -1;
 Close;
end;

procedure TItemSalesPrintOptionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TItemSalesPrintOptionForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TItemSalesPrintOptionForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := WorkPanel.Height + 48;
end;

function TItemSalesPrintOptionForm.OptionPro: integer;
begin
 Application.CreateForm(TItemSalesPrintOptionForm, ItemSalesPrintOptionForm);
 ItemSalesPrintOptionForm.ShowModal;
 Result := ItemSalesPrintOptionForm.Select;
 ItemSalesPrintOptionForm.Free;
end;

end.
