unit SalesHistoryList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, Mask, DataUnit, UtilUnit,
  ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TSalesHistoryListForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DateEdit1: TMaskEdit;
    TimeEdit1: TMaskEdit;
    Label4: TLabel;
    DateEdit2: TMaskEdit;
    TimeEdit2: TMaskEdit;
    Label5: TLabel;
    Label6: TLabel;
    AmountEdit: TStaticText;
    GSTEdit: TStaticText;
    TotalEdit: TStaticText;
    PaidEdit: TStaticText;
    BalanceEdit: TStaticText;
    ListComboBox: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    TotalPersonsEdit: TStaticText;
    ConsumeEdit: TStaticText;
    SalesComboBox: TComboBox;
    TipsEdit: TStaticText;
    Label9: TLabel;
    PaymentComboBox: TComboBox;
    ServiceChargeEdit: TStaticText;
    SurchargeLabel: TLabel;
    SurchargeEdit: TStaticText;
    Label11: TLabel;
    Query: TADOQuery;
    QuerySurcharge: TFloatField;
    QueryTips: TFloatField;
    QueryOrderDate: TDateTimeField;
    QueryOrderNo: TStringField;
    QueryPersons: TIntegerField;
    QueryTableNo: TStringField;
    QueryServicePerson: TStringField;
    QueryAmount: TFloatField;
    QueryGST: TFloatField;
    QueryPaidAmount: TFloatField;
    QueryInvoiceNo: TStringField;
    QueryServiceCharge: TFloatField;
    QueryNetSales: TFloatField;
    QueryBalance: TFloatField;
    QueryOtherCharge: TFloatField;
    QueryPriceIncludesGST: TBooleanField;
    OtherChargeEdit: TStaticText;
    OtherChargeLabel: TLabel;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    CalcPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    DetailButton: TXiButton;
    PaymentButton: TXiButton;
    PrintReportButton: TXiButton;
    ExitButton: TXiButton;
    ElapseTimeButton: TXiButton;
    QueryOpName: TStringField;
    Label10: TLabel;
    PrintInvoiceButton: TXiButton;
    PrintBillButton: TXiButton;
    PaymentMethodComboBox: TComboBox;
    PaymentMethodQuery: TADOQuery;
    procedure GetPaymentMethod;
    procedure OpenQuery;
    procedure CalcAmount;
    procedure SearchButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SalesHistoryListPro(OrderKind: integer);
    procedure ExitButtonClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PrintReportButtonClick(Sender: TObject);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DetailButtonClick(Sender: TObject);
    procedure PaymentButtonClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure TimeEditClick(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure ElapseTimeButtonClick(Sender: TObject);
    procedure PrintInvoiceButtonClick(Sender: TObject);
    procedure PrintBillButtonClick(Sender: TObject);
  private { Private declarations }
      OrderKind: integer;
  public
    { Public declarations }
  end;

var
  SalesHistoryListForm: TSalesHistoryListForm;

implementation

uses PrintSalesHistoryList, StaffList, MainMenu, SalesHistoryDetail,
     ReceiptList, DatePanel, TimePanel, NumPad, Keyboard, ReadOrderNo,
     MachineIDSelect, ElapseTime, PrintOrder, PrintOrder1, PrintOrder2,
     PrintInvoice, PrintInvoice1, PrintInvoice2, MessageBox, PrintOrder3,
  PrintInvoice3;

{$R *.DFM}

procedure TSalesHistoryListForm.GetPaymentMethod;
var
 SQLStr: string;
begin
 PaymentMethodComboBox.Items.Clear;
 PaymentMethodComboBox.Items.Add('List all');

 SQLStr := 'Select Payment From Payment Where ShowOnList <> 0 Order By Code';
 with PaymentMethodQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    if Active and (RecordCount > 0) then
       begin
        First;
        while Not EOF do
         begin
          PaymentMethodComboBox.Items.Add(FieldByName('Payment').AsString);
          Next;
         end;
       end;
    Close;
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TSalesHistoryListForm.OpenQuery;
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
 DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
 if PaymentMethodComboBox.ItemIndex = 0 then
    begin
     SQLStr := 'Select OrderNo, OrderDate, Persons, Amount, ServiceCharge, OtherCharge,' +
               'GST, Tips, Surcharge, PaidAmount, ServicePerson, InvoiceNo, TableNo, ' +
               'PriceIncludesGST, OpName From OrderH ' +
               'Where OrderDate>=' + ConvertDateTime(DateTemp1) +
               ' and OrderDate<=' + ConvertDateTime(DateTemp2);
     if ListComboBox.ItemIndex <> 0 then
        case ListComboBox.ItemIndex of
         1: SQLStr := SQLStr + ' and (InvoiceNo IS NULL)';
         2: SQLStr := SQLStr + ' and (InvoiceNo IS NOT NULL)';
        end;
     if PaymentComboBox.ItemIndex <> 0 then
        case PaymentComboBox.ItemIndex of
         1: SQLStr := SQLStr + ' and ' +
            '((Amount + ServiceCharge + OtherCharge + Tips + Surcharge - PaidAmount >=0.009 and ' +
            'PriceIncludesGST <> 0) or ' +
            '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST - PaidAmount >=0.009 and ' +
            'PriceIncludesGST = 0)) ';
         2: SQLStr := SQLStr + ' and ' +
            '((PaidAmount - (Amount + ServiceCharge + OtherCharge + Tips + Surcharge) >= 0 and ' +
            'PriceIncludesGST <> 0) or ' +
            '(PaidAmount - (Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST) >= 0 and ' +
            'PriceIncludesGST = 0)) ';
        end;
     if SalesComboBox.ItemIndex <> 0 then
        case SalesComboBox.ItemIndex of
         1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
         2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
         3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
        end;
     SQLStr := SQLStr + ' Order By OrderNo';
    end
   else
    begin
     SQLStr := 'Select OrderH.OrderNo, OrderDate, Persons, Amount, ServiceCharge, OtherCharge,' +
               'GST, Tips, Surcharge, PaidAmount As PaidAmount, ServicePerson, ' +
               'InvoiceNo, TableNo, ' +
               'PriceIncludesGST, OpName From OrderH, ' +
               '(Select OrderNo From RecvAcct ' +
               'Where PayBy=' + Chr(39) + PaymentMethodComboBox.Text + Chr(39) +
               'Group By OrderNo) As Temp ' +
               'Where OrderDate>=' + ConvertDateTime(DateTemp1) +
               ' and OrderDate<=' + ConvertDateTime(DateTemp2) +
               ' and OrderH.OrderNo=Temp.OrderNo ';
     if PaymentComboBox.ItemIndex <> 0 then
        case PaymentComboBox.ItemIndex of
         1: SQLStr := SQLStr + ' and ' +
            '((Amount + ServiceCharge + OtherCharge + Tips + Surcharge - PaidAmount >=0.009 and ' +
            'PriceIncludesGST <> 0) or ' +
            '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST - PaidAmount >=0.009 and ' +
            'PriceIncludesGST = 0)) ';
         2: SQLStr := SQLStr + ' and ' +
            '((PaidAmount - (Amount + ServiceCharge + OtherCharge + Tips + Surcharge) >= 0 and ' +
            'PriceIncludesGST <> 0) or ' +
            '(PaidAmount - (Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST) >= 0 and ' +
            'PriceIncludesGST = 0)) ';
        end;
     if ListComboBox.ItemIndex <> 0 then
        case ListComboBox.ItemIndex of
         1: SQLStr := SQLStr + ' and (InvoiceNo IS NULL)';
         2: SQLStr := SQLStr + ' and (InvoiceNo IS NOT NULL)';
        end;

     if SalesComboBox.ItemIndex <> 0 then
        case SalesComboBox.ItemIndex of
         1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
         2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
         3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
        end;
     SQLStr := SQLStr + ' Order By OrderH.OrderNo';
    end;
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

procedure TSalesHistoryListForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  begin
   if FieldByName('PriceIncludesGST').AsBoolean then
      FieldByName('NetSales').AsFloat := FieldByName('Amount').AsFloat +
         FieldByName('ServiceCharge').AsFloat + FieldByName('OtherCharge').AsFloat
     else
      FieldByName('NetSales').AsFloat := FieldByName('Amount').AsFloat +
         FieldByName('ServiceCharge').AsFloat + FieldByName('OtherCharge').AsFloat +
         FieldByName('GST').AsFloat;
   FieldByName('Balance').AsFloat :=
      FieldByName('NetSales').AsFloat + FieldByName('Tips').AsFloat +
      FieldByName('Surcharge').AsFloat - FieldByName('PaidAmount').AsFloat;
  end;
end;

procedure TSalesHistoryListForm.CalcAmount;
var
 Amount, GST, ServiceCharge, OtherCharge, Tips, Surcharge, PaidAmount, TotalSales: double;
 Persons: integer;
begin
 Amount := 0; ServiceCharge := 0; OtherCharge := 0; TotalSales := 0;
 GST := 0; Tips := 0; Surcharge := 0;
 PaidAmount := 0; Persons := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     Amount := Amount +
       StrToFloat(Format('%4.2f', [FieldByName('Amount').AsFloat]));
     ServiceCharge := ServiceCharge +
       StrToFloat(Format('%4.2f', [FieldByName('ServiceCharge').AsFloat]));
     OtherCharge := OtherCharge +
       StrToFloat(Format('%4.2f', [FieldByName('OtherCharge').AsFloat]));
     GST := GST +
       StrToFloat(Format('%4.2f', [FieldByName('GST').AsFloat]));
    TotalSales := TotalSales + FieldByName('NetSales').AsFloat;
    Tips := Tips +
       StrToFloat(Format('%4.2f', [FieldByName('Tips').AsFloat]));
     Surcharge := Surcharge +
       StrToFloat(Format('%4.2f', [FieldByName('Surcharge').AsFloat]));
     PaidAmount := PaidAmount +
       StrToFloat(Format('%4.2f', [FieldByName('PaidAmount').AsFloat]));
     Persons := Persons + FieldByName('Persons').AsInteger;
     Next;
    end;
   First;
   EnableControls;
  end;
 AmountEdit.Caption := Format('%4.2f ', [Amount]);
 ServiceChargeEdit.Caption := Format('%4.2f ', [ServiceCharge]);
 OtherChargeEdit.Caption := Format('%4.2f ', [OtherCharge]);
 GSTEdit.Caption := Format('%4.2f ', [GST]);
 TipsEdit.Caption := Format('%4.2f ', [Tips]);
 SurchargeEdit.Caption := Format('%4.2f ', [Surcharge]);
 TotalEdit.Caption := Format('%4.2f ', [TotalSales]);
 PaidEdit.Caption :=  Format('%4.2f ', [PaidAmount]);
 BalanceEdit.Caption := Format('%4.2f ', [TotalSales + Tips + Surcharge - PaidAmount]);
 TotalPersonsEdit.Caption := Format('%1d ', [Persons]);
 if Persons >= 1 then
    ConsumeEdit.Caption := Format('%4.2f ', [(TotalSales) / Persons])
   else
    ConsumeEdit.Caption := Format('%4.2f ', [0.0]);
end;

procedure TSalesHistoryListForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
 CalcAmount;
end;

procedure TSalesHistoryListForm.DBGridDblClick(Sender: TObject);
begin
 DetailButtonClick(Sender);
end;

procedure TSalesHistoryListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TSalesHistoryListForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesHistoryListForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit1.SetFocus;
end;

procedure TSalesHistoryListForm.TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TSalesHistoryListForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit2.SetFocus;
end;

procedure TSalesHistoryListForm.TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TSalesHistoryListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TSalesHistoryListForm.PrintReportButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
    PrintSalesHistoryListForm.PrintSalesHistoryListPro;
end;

procedure TSalesHistoryListForm.PrintInvoiceButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     if Not PrintInvoiceAuthority then
        MessageBoxForm.MessagePro('You have not been authorised to print invoice.', sErrorMsg)
       else
        begin
         OrderNo := Query.FieldByName('OrderNo').AsString;
         case PrintBillMode of
         0, 1: PrintOrderForm.PrintOrderPro(OrderNo);
         2:    PrintOrderForm1.PrintOrderPro(OrderNo, True);
         3:    PrintOrderForm1.PrintOrderPro(OrderNo, False);
         4:    PrintOrderForm2.PrintOrderPro(OrderNo);
         5:    PrintOrderForm3.PrintOrderPro(OrderNo);
        end;
       end;
    end;
end;

procedure TSalesHistoryListForm.PrintBillButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     OrderNo := Query.FieldByName('OrderNo').AsString;
     case PrintInvoiceMode of
      0, 1: PrintInvoiceForm.PrintInvoicePro(OrderNo);
      2:    PrintInvoiceForm1.PrintInvoicePro(OrderNo, True);
      3:    PrintInvoiceForm1.PrintInvoicePro(OrderNo, False);
      4:    PrintInvoiceForm2.PrintInvoicePro(OrderNo);
      5:    PrintInvoiceForm3.PrintInvoicePro(OrderNo);
     end;
    end;
end;

procedure TSalesHistoryListForm.DateEdit1Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit1.Text) then
    DateEdit1.SetFocus;
end;

procedure TSalesHistoryListForm.DateEdit2Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit2.Text) then
    DateEdit2.SetFocus;
end;

procedure TSalesHistoryListForm.DetailButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     OrderNo := Query.FieldByName('OrderNo').AsString;
     SalesHistoryDetailForm.SalesDetailPro(OrderNo);
    end;
end;

procedure TSalesHistoryListForm.ElapseTimeButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     OrderNo := Query.FieldByName('OrderNo').AsString;
     ElapseTimeForm.ShowElapseDateTimePro(OrderNo);
    end;
end;

procedure TSalesHistoryListForm.PaymentButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     OrderNo := Query.FieldByName('OrderNo').AsString;
     ReceiptListForm.ReceiptListPro(OrderNo, EditOrderPayment);
    end;
end;

procedure TSalesHistoryListForm.DateEdit1Change(Sender: TObject);
begin
 if Not Supervisor and Not CheckDailyReport and (Date - TransferDate(DateEdit1.Text) > InquirySalesRelatedReportDays) then
    DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date - InquirySalesRelatedReportDays);
end;

procedure TSalesHistoryListForm.DateEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   DateTemp := TransferDate(Text);
   if DateForm.ReadDatePro(DateTemp) then
      Text := FormatDateTime('dd/mm/yyyy', DateTemp);
  end;
end;

procedure TSalesHistoryListForm.TimeEditClick(Sender: TObject);
var
 TimeStr: string;
begin
 with Sender As TMaskEdit do
  begin
   TimeStr := Text;
   if TimeForm.ReadTimePro(TimeStr) then
      Text := TimeStr;
  end;
end;

procedure TSalesHistoryListForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryGST.DisplayFormat := sCurrency + ',0.#0';
 QueryNetSales.DisplayFormat := sCurrency + ',0.#0';
 QueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryBalance.DisplayFormat := sCurrency + ',0.#0';
 QueryTips.DisplayFormat := sCurrency + ',0.#0';
 QueryServiceCharge.DisplayFormat := sCurrency + ',0.#0';
 QueryOtherCharge.DisplayFormat := sCurrency + ',0.#0';
 QuerySurcharge.DisplayFormat := sCurrency + ',0.#0';
 DBGrid.Columns[4].Title.Caption := SurchargeName;
 DBGrid.Columns[5].Title.Caption := OtherChargeName;
 if (Time < EndTime) and (EndTime < BeginTime) then
    begin
     DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date - 1);
     DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
    end
   else
    if (Time > BeginTime) and (EndTime < BeginTime) then
       begin
        DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
        DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date + 1);
       end
      else
       begin
        DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
        DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
       end;
 TimeEdit1.Text := FormatDateTime('hh:mm', BeginTime);
 TimeEdit2.Text := FormatDateTime('hh:mm', EndTime);
 SurchargeLabel.Caption := SurchargeName;
 OtherChargeLabel.Caption := OtherChargeName;
 GetPaymentMethod;
 SalesComboBox.ItemIndex := 0;
 ListComboBox.ItemIndex := 0;
 PaymentComboBox.ItemIndex := 0;
 PaymentMethodComboBox.ItemIndex := 0;
end;

procedure TSalesHistoryListForm.SalesHistoryListPro(OrderKind: integer);
begin
 Application.CreateForm(TSalesHistoryListForm, SalesHistoryListForm);
 SalesHistoryListForm.OrderKind := OrderKind;
 SalesHistoryListForm.ShowModal;
 SalesHistoryListForm.Free;
end;

end.
