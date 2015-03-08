unit AccountPaymentHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, DataUnit, DB, ADODB, StdCtrls, Buttons,
  Mask, UtilUnit, MainMenu, BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TAccountPaymentHistoryForm = class(TForm)
    DBGrid: TDBGrid;
    Query: TADOQuery;
    DataSource: TDataSource;
    QueryOrderNo: TStringField;
    QueryOrderDate: TDateTimeField;
    QueryOrderAmount: TFloatField;
    QueryPaidAmount: TFloatField;
    QueryAccountDate: TDateTimeField;
    QueryPayBy: TStringField;
    DateCheckBox: TCheckBox;
    DateEdit: TMaskEdit;
    VIPQuery: TADOQuery;
    QueryIDNo: TIntegerField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    procedure OpenQuery;
    procedure OpenVIPQuery;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PaymentHistoryPro(VIPNo: string);
    procedure DateCheckBoxClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
  private { Private declarations }
    VIPNo: string;
  public
    { Public declarations }
  end;

var
  AccountPaymentHistoryForm: TAccountPaymentHistoryForm;

implementation

uses DatePanel;

{$R *.dfm}

procedure TAccountPaymentHistoryForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select OrderH.OrderNo, OrderDate, ' +
           'Amount + ServiceCharge + OtherCharge + Tips + Surcharge As OrderAmount, ' +
           'RecvAcct.PaidAmount, AccountDate, PayBy, IDNo ' +
           'From OrderH, RecvAcct ' +
           'Where (PriceIncludesGST <> 0) and OrderH.OrderNo=RecvAcct.OrderNo and ' +
           'VIPNo=' + VIPNo;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and AccountDate >= ' + ConvertDateTime(TransferDate(DateEdit.Text) + StrToTime('0:0')) +
              ' and AccountDate <= ' + ConvertDateTime(TransferDate(DateEdit.Text) + StrToTime('23:59'));

 SQLStr := SQLStr + ' Union All ' +
           'Select OrderH.OrderNo, OrderDate, ' +
           'Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST As OrderAmount, ' +
           'RecvAcct.PaidAmount, AccountDate, PayBy, IDNo ' +
           'From OrderH, RecvAcct ' +
           'Where (PriceIncludesGST = 0) and OrderH.OrderNo=RecvAcct.OrderNo and ' +
           'VIPNo=' + VIPNo;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and AccountDate >= ' + ConvertDateTime(TransferDate(DateEdit.Text) + StrToTime('0:0')) +
              ' and AccountDate <= ' + ConvertDateTime(TransferDate(DateEdit.Text) + StrToTime('23:59'));
 SQLStr := SQLStr + ' Order By OrderH.OrderNo, IDNo';
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TAccountPaymentHistoryForm.OpenVIPQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From VIPTable Where VIPNo=' + VIPNo;
 Screen.Cursor := crHourGlass;
 with VIPQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TAccountPaymentHistoryForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TAccountPaymentHistoryForm.DateCheckBoxClick(Sender: TObject);
begin
 if DateCheckBox.Checked then
    begin
     DateEdit.Enabled := True;
     DateEdit.Text := FormatDateTime('dd/mm/yyyy', Date);
    end
   else
    begin
     DateEdit.Enabled := False;
     DateEdit.Text := '';
    end;
 OpenQuery;
end;

procedure TAccountPaymentHistoryForm.DateEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   DateTemp := TransferDate(Text);
   if DateForm.ReadDatePro(DateTemp) then
      begin
       Text := FormatDateTime('dd/mm/yyyy', DateTemp);
       OpenQuery;
      end;
  end;
end;

procedure TAccountPaymentHistoryForm.PrintButtonClick(Sender: TObject);
var
 PrintStr, LineStr, LastOrderNo: string;
 PaperWidth, I: integer;
 OrderAmount, PaidAmount: double;
begin
 if Not Query.Active or (Query.RecordCount = 0) or
   (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 LineStr := '';
 for I := 1 to PaperWidth do LineStr := LineStr + '-';
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 DataForm.OutPutToPrinter(LineStr);
 DataForm.SetBlackFontB;
 PrintStr := 'Statement';
 PrintStr := Format('%' + IntToStr((PaperWidth - 18) div 4) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(LineStr);
 OpenVIPQuery;
 with VIPQuery do
  begin
   PrintStr := 'Name: ' + FieldByName('VIPName').AsString;
   DataForm.OutPutToPrinter(PrintStr);
   if FieldByName('Telephone').AsString <> '' then
    begin
     PrintStr := 'Telephone: ' + FieldByName('Telephone').AsString;
     DataForm.OutPutToPrinter(PrintStr);
    end;
   if FieldByName('Fax').AsString <> '' then
      begin
       PrintStr := 'Fax: ' + FieldByName('Fax').AsString;
       DataForm.OutPutToPrinter(PrintStr);
      end;
   if FieldByName('Mobile').AsString <> '' then
      begin
       PrintStr := 'Mobile: ' + FieldByName('Mobile').AsString;
       DataForm.OutPutToPrinter(PrintStr);
      end;
   PrintStr := 'Address: ' + FieldByName('Number').AsString + ' ' +
                             FieldByName('Address').AsString;
   DataForm.OutPutToPrinter(PrintStr);
   PrintStr := FieldByName('Suburb').AsString + ' ' +
               FieldByName('State').AsString + ' ' + FieldByName('PostCode').AsString;
   DataForm.OutPutToPrinter(PrintStr);
   Close;
  end;
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Date       Order No.     AMOUNT     PAID';
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 OrderAmount := 0; PaidAmount := 0; LastOrderNo := '';
 with Query do
  begin
   First;
   while Not EOF do
    begin
     PrintStr := FormatDateTime('dd/mm/yyyy', FieldByName('OrderDate').AsDateTime) + ' ' +
                 Format('%-10s', [FieldByName('OrderNo').AsString]) +
                 ' ' + Format('%9s', [FormatCurrency(FieldByName('OrderAmount').AsFloat)]) +
                 Format('%9s', [FormatCurrency(FieldByName('PaidAmount').AsFloat)]);
     DataForm.OutPutToPrinter(PrintStr);
     if LastOrderNo <> FieldByName('OrderNo').AsString then
        OrderAmount := OrderAmount + FieldByName('OrderAmount').AsFloat;
     LastOrderNo := FieldByName('OrderNo').AsString;
     PaidAmount := PaidAmount + FieldByName('PaidAmount').AsFloat;
     Next;
    end;
  end;
 PrintStr := 'Total Amount:  ' + Format('%8s', [FormatCurrency(OrderAmount)]);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Total Pyament: ' + Format('%8s', [FormatCurrency(PaidAmount)]);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Balance:       ' + Format('%8s', [FormatCurrency(OrderAmount - PaidAmount)]);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 if DateCheckBox.Checked then
    begin
     PrintStr := 'Payment Date: ' + DateEdit.Text;
     DataForm.OutPutToPrinter(PrintStr);
    end;
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TAccountPaymentHistoryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TAccountPaymentHistoryForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 QueryOrderAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 OpenQuery;
end;

procedure TAccountPaymentHistoryForm.PaymentHistoryPro(VIPNo: string);
begin
 Application.CreateForm(TAccountPaymentHistoryForm, AccountPaymentHistoryForm);
 AccountPaymentHistoryForm.VIPNo := VIPNo;
 AccountPaymentHistoryForm.ShowModal;
 AccountPaymentHistoryForm.Free;
end;

end.
