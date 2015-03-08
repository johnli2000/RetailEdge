unit DispPOSReceipt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ExtCtrls, UtilUnit, bsSkinCtrls, XiButton;

type
  TDispPOSReceiptForm = class(TForm)
    BackPanel: TbsSkinPanel;
    TotalPanel: TbsSkinPanel;
    DataPanel1: TbsSkinPanel;
    DataPanel2: TbsSkinPanel;
    BalancePanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    bsSkinStdLabel5: TbsSkinStdLabel;
    TotalSalesEdit: TbsSkinLabel;
    ReceivableEdit: TbsSkinLabel;
    RoundingEdit: TbsSkinLabel;
    SurchargeEdit: TbsSkinLabel;
    TipsEdit: TbsSkinLabel;
    bsSkinStdLabel6: TbsSkinStdLabel;
    bsSkinStdLabel7: TbsSkinStdLabel;
    PayByEdit1: TbsSkinLabel;
    PaymentEdit1: TbsSkinLabel;
    bsSkinStdLabel8: TbsSkinStdLabel;
    bsSkinStdLabel9: TbsSkinStdLabel;
    PayByEdit2: TbsSkinLabel;
    PaymentEdit2: TbsSkinLabel;
    ChangeEdit: TbsSkinLabel;
    PrintBillButton: TXiButton;
    PrintInvoiceButton: TXiButton;
    ExitButton: TXiButton;
    BalanceLabel: TbsSkinStdLabel;
    PrintJobListBtn: TXiButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PrintBillButtonClick(Sender: TObject);
    procedure DispReceiptPro(TotalSales, Receivable, Tips, Payment1, Payment2,
              Rounding, Surcharge, Change: double; PayBy1, PayBy2, OrderNo: string);
    procedure PrintInvoiceButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PrintJobListBtnClick(Sender: TObject);
  private { Private declarations }
    OrderNo: string;
  public
    { Public declarations }
  end;

var
  DispPOSReceiptForm: TDispPOSReceiptForm;

implementation

uses MainMenu, DataUnit, PrintOrder, PrintOrder1, PrintInvoice, PrintInvoice1,
  PrintInvoice2, PrintOrder2, PrintOrder3, PrintInvoice3,
  PrintJobListControl;

{$R *.DFM}

procedure TDispPOSReceiptForm.ExitButtonClick(Sender: TObject);
begin
 DataForm.TestDrawerStatus(CurrentDrawerNumber);
 if Not DrawerIsOpen then Close
end;

procedure TDispPOSReceiptForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DataForm.SendToPoleDisp('NEXT CUSTOMER PLEASE', '');
 Action := caFree;
end;

procedure TDispPOSReceiptForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TDispPOSReceiptForm.PrintBillButtonClick(Sender: TObject);
begin
 case PrintBillMode of
  0, 1: PrintOrderForm.PrintOrderPro(OrderNo);
  2:    PrintOrderForm1.PrintOrderPro(OrderNo, True);
  3:    PrintOrderForm1.PrintOrderPro(OrderNo, False);
  4:    PrintOrderForm2.PrintOrderPro(OrderNo);
  5:    PrintOrderForm3.PrintOrderPro(OrderNo);
 end;

end;

procedure TDispPOSReceiptForm.PrintInvoiceButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := DataForm.SetInvoiceNo(OrderNo);
 finally
  if Flag then
     DataForm.CommitTransaction
    else
     DataForm.RollBack;
 end;
 if Flag then
    case PrintInvoiceMode of
     0, 1: PrintInvoiceForm.PrintInvoicePro(OrderNo);
     2:    PrintInvoiceForm1.PrintInvoicePro(OrderNo, True);
     3:    PrintInvoiceForm1.PrintInvoicePro(OrderNo, False);
     4:    PrintInvoiceForm2.PrintInvoicePro(OrderNo);
     5:    PrintInvoiceForm3.PrintInvoicePro(OrderNo);
    end;
end;

procedure TDispPOSReceiptForm.FormShow(Sender: TObject);
begin
 BackPanel.Width := 580;
 BackPanel.Height := 761;
 BackPanel.Left := 0;
 BackPanel.Top := 0;
 Width := 580;
 Height := 761;
 Top := (Screen.Height - BackPanel.Height) div 2;
 Left := 1024 - BackPanel.Width + (Screen.Width - 1024) div 2 - 3;
 PrintBillButton.Caption := 'Print' + Chr(13) + Chr(10) + 'Bill';
 PrintJobListBtn.Caption := 'Print' + Chr(13) + Chr(10) + 'JobList';
 PrintInvoiceButton.Caption := 'Print' + Chr(13) + Chr(10) + 'Invoice';
 ExitButton.Caption := 'Close';
end;

procedure TDispPOSReceiptForm.DispReceiptPro(TotalSales, Receivable, Tips, Payment1,
          Payment2, Rounding, Surcharge, Change: double; PayBy1, PayBy2, OrderNo: string);
begin
 Application.CreateForm(TDispPOSReceiptForm, DispPOSReceiptForm);
 DispPOSReceiptForm.OrderNo := OrderNo;
 DispPOSReceiptForm.TotalSalesEdit.Caption := Format('%4.2f ', [TotalSales]);
 DispPOSReceiptForm.ReceivableEdit.Caption := Format('%4.2f ', [Receivable]);
 DispPOSReceiptForm.TipsEdit.Caption := Format('%4.2f ', [Tips]);
 DispPOSReceiptForm.RoundingEdit.Caption := Format('%4.2f ', [Rounding]);
 DispPOSReceiptForm.SurchargeEdit.Caption := Format('%4.2f ', [Surcharge]);
 DispPOSReceiptForm.PayByEdit1.Caption := PayBy1;
 DispPOSReceiptForm.PayByEdit2.Caption := PayBy2;
 DispPOSReceiptForm.PaymentEdit1.Caption := Format('%4.2f ', [Payment1]);
 DispPOSReceiptForm.PaymentEdit2.Caption := Format('%4.2f ', [Payment2]);
 DispPOSReceiptForm.ChangeEdit.Caption := Format('%4.2f ', [ABS(Change)]);
 DispPOSReceiptForm.ShowModal;
 DispPOSReceiptForm.Free;
end;

procedure TDispPOSReceiptForm.PrintJobListBtnClick(Sender: TObject);
begin
  PrintJobListControlForm.PrintJobListControlPro(OrderNo, '', True, True);
end;

end.
