unit PrintOption;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, StdCtrls, Buttons, MainMenu, XiButton, bsSkinCtrls,
  BusinessSkinForm;

type
  TPrintOptionForm = class(TForm)
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
  PrintOptionForm: TPrintOptionForm;

implementation

uses DataUnit;

{$R *.DFM}

procedure TPrintOptionForm.PrintToPOSPrinterButtonClick(Sender: TObject);
begin
 Select := 0;
 Close;
end;

procedure TPrintOptionForm.PrintSimpleReportButtonClick(Sender: TObject);
begin
 Select := 1;
 Close;
end;

procedure TPrintOptionForm.PrintToA4PrinterButtonClick(Sender: TObject);
begin
 Select := 2;
 Close;
end;

procedure TPrintOptionForm.PrintToTextFileButtonClick(Sender: TObject);
begin
 Select := 3;
 Close;
end;

procedure TPrintOptionForm.CancelButtonClick(Sender: TObject);
begin
 Select := -1;
 Close;
end;

procedure TPrintOptionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TPrintOptionForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TPrintOptionForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := WorkPanel.Height + 48;
end;

function TPrintOptionForm.OptionPro: integer;
begin
 Application.CreateForm(TPrintOptionForm, PrintOptionForm);
 PrintOptionForm.ShowModal;
 Result := PrintOptionForm.Select;
 PrintOptionForm.Free;
end;

end.
