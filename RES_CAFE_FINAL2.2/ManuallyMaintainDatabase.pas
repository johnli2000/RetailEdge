unit ManuallyMaintainDatabase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DBCtrls, Mask, Db, Grids, DBGrids, DataUnit,
  UtilUnit, ADODB, Security, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TManuallyMaintainDatabaseForm = class(TForm)
    DataSource: TDataSource;
    OrderNoEdit: TDBEdit;
    DBGrid: TDBGrid;
    DateCheckBox: TCheckBox;
    DateEdit1: TMaskEdit;
    Label2: TLabel;
    DateEdit2: TMaskEdit;
    PaybyCheckBox: TCheckBox;
    PaybyComboBox: TComboBox;
    InvoiceComboBox: TComboBox;
    PaymentComboBox: TComboBox;
    Label1: TLabel;
    TotalSalesEdit: TStaticText;
    Label6: TLabel;
    SelectedAmountEdit: TStaticText;
    Label3: TLabel;
    BalanceEdit: TStaticText;
    TimeEdit1: TMaskEdit;
    TimeEdit2: TMaskEdit;
    TempQuery: TADOQuery;
    Query: TADOQuery;
    QueryOrderDate: TDateTimeField;
    QueryOrderNo: TStringField;
    QueryPaidAmount: TFloatField;
    QueryInvoiceNo: TStringField;
    QueryVIPNo: TIntegerField;
    QueryBalance: TFloatField;
    StockQuery: TADOQuery;
    QueryTableNo: TStringField;
    MachineIDCheckBox: TCheckBox;
    MachineIDEdit: TStaticText;
    QueryOpName: TStringField;
    QueryTotalInvoice: TFloatField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    TotalPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    bsSkinPanel1: TbsSkinPanel;
    CalcButton: TXiButton;
    SelectAllButton: TXiButton;
    SearchButton: TXiButton;
    ViewButton: TXiButton;
    ExitButton: TXiButton;
    EditPaymentButton: TXiButton;
    XiButton1: TXiButton;
    XiButton2: TXiButton;
    XiButton3: TXiButton;
    procedure OpenQuery(SQLStr: string);
    procedure OpenDatabase;
    procedure CalcAmount;
    procedure CalcSelectedAmount;
    procedure OpenTempQuery(SQLStr: string);
    procedure OpenStockQuery(SQLStr: string);
    procedure ReadPayment;
    procedure DateCheckBoxClick(Sender: TObject);
    procedure PayByCheckBoxClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ManuallyMaintainDatabasePro;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure TestOrderStatus(var Invoiced, Balance: boolean);
    function  DeleteRecord(OrderNoArray: string): boolean;
    function  DeleteRecordPro(OrderNoArray: string): boolean;
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditPayment;
    procedure DBGridDblClick(Sender: TObject);
    function  UpdateOrderNo(OldOrderNo, NewOrderno: string): boolean;
    function  ReArrangeOrderNoPro: boolean;
    function  UpdateDrawerOpenCounterPro: boolean;
    procedure IssueInvoiceNoPro;
    procedure ReArrangeIDPro;
    procedure RePrintInvoicePro;
    procedure RePrintBillPro;
    procedure ViewButtonClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure CalcButtonClick(Sender: TObject);
    procedure SelectAllButtonClick(Sender: TObject);
    procedure TimeEditClick(Sender: TObject);
    procedure MakeAdjustmentNo(var AdjustmentNo: string);
    function  SaveAdjustHeadData(AdjustNo: string): boolean;
    function  SaveAdjustItemData(AdjustNo, Code: string; Qty: double; I: integer): boolean;
    function  UpdateStockPro(OrderNoArray: string): boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MachineIDCheckBoxClick(Sender: TObject);
    procedure MachineIDEditClick(Sender: TObject);
    procedure DeleteOrderPro;
    procedure EditPaymentButtonClick(Sender: TObject);
    procedure Select1;
    procedure Select2;
    procedure Select3;
    procedure XiButton1Click(Sender: TObject);
    procedure XiButton2Click(Sender: TObject);
    procedure XiButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ManuallyMaintainDatabaseForm: TManuallyMaintainDatabaseForm;

implementation

uses MainMenu, ReceiptList, DatePanel, MessageBox, TimePanel,
     DisplayMessage, SalesHistoryDetail, PrintInvoice, PrintInvoice1,
     PrintOrder, PrintOrder1, MachineIDSelect, PrintInvoice2, PrintOrder2,
  PrintOrder3, PrintInvoice3;

{$R *.DFM}

procedure TManuallyMaintainDatabaseForm.OpenQuery(SQLStr: string);
begin
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

procedure TManuallyMaintainDatabaseForm.OpenDatabase;
var
 SQLStr: string;
 DateTime1, DateTime2: TDateTime;
begin
  if DateCheckBox.Checked then
     begin
      DateTime1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
      DateTime2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     end
    else
     begin
      DateTime1 := 0;
      DateTime2 := 0;
     end;
  if Not PayByCheckBox.Checked then
     begin
      SQLStr := 'Select OrderH.OrderNo, OrderDate, TableNo, ' +     // Price Includes GST
                '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge) As TotalInvoice, ' +
                'OrderH.PaidAmount, InvoiceNo, VIPNo, OpName ' +
                'From OrderH Where PriceIncludesGST <> 0';
      if DateCheckBox.Checked then
         begin
          SQLStr := SQLStr + ' and OrderDate>=' + ConvertDateTime(DateTime1) +
                  ' and OrderDate<=' + ConvertDateTime(DateTime2);
         end;
      if MachineIDCheckBox.Checked then
         SQLStr := SQLStr + ' and OrderH.MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Caption) + Chr(39);
      if InvoiceComboBox.ItemIndex <> 0 then
         begin
          if InvoiceComboBox.ItemIndex = 1 then
             SQLStr := SQLStr + ' and (InvoiceNo Is Null)'
            else
             SQLStr := SQLStr + ' and (InvoiceNo Is Not Null)';
         end;
      if PaymentComboBox.ItemIndex <> 0 then
         case PaymentComboBox.ItemIndex of
          1: SQLStr := SQLStr + ' and ((Amount + ServiceCharge + OtherCharge + Tips + Surcharge) - OrderH.PaidAmount >= 0.009)';
          2: SQLStr := SQLStr + ' and (ABS(OrderH.PaidAmount - (Amount + ServiceCharge + OtherCharge + Tips + Surcharge)) < 0.009)';
          3: SQLStr := SQLStr + ' and (OrderH.PaidAmount - (Amount + ServiceCharge + OtherCharge + Tips + Surcharge) >= 0.01)';
         end;
      SQLStr := SQLStr + ' Union All ' +
                'Select OrderH.OrderNo, OrderDate, TableNo, ' +    // Price does not include GST
                '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST) As TotalInvoice, ' +
                'OrderH.PaidAmount, InvoiceNo, VIPNo, OpName ' +
                'From OrderH Where PriceIncludesGST = 0';
      if DateCheckBox.Checked then
         begin
          SQLStr := SQLStr + ' and OrderDate>=' + ConvertDateTime(DateTime1) +
                  ' and OrderDate<=' + ConvertDateTime(DateTime2);
         end;
      if MachineIDCheckBox.Checked then
         SQLStr := SQLStr + ' and OrderH.MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Caption) + Chr(39);
      if InvoiceComboBox.ItemIndex <> 0 then
         begin
          if InvoiceComboBox.ItemIndex = 1 then
             SQLStr := SQLStr + ' and (InvoiceNo Is Null)'
            else
             SQLStr := SQLStr + ' and (InvoiceNo Is Not Null)';
         end;
      if PaymentComboBox.ItemIndex <> 0 then
         case PaymentComboBox.ItemIndex of
          1: SQLStr := SQLStr + ' and ((Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST) - OrderH.PaidAmount >= 0.009)';
          2: SQLStr := SQLStr + ' and (ABS(OrderH.PaidAmount - (Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST)) < 0.009)';
          3: SQLStr := SQLStr + ' and (OrderH.PaidAmount - (Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST) >= 0.01)';
         end;
      SQLStr := SQLStr + ' Order By OrderH.OrderNo';
     end
    else
     begin
      SQLStr := 'Select OrderH.OrderNo, OrderDate, TableNo, ' +  // Price Includes GST
                '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge) As TotalInvoice, ' +
                'OrderH.PaidAmount, InvoiceNo, VIPNo, OpName ' +
                'From OrderH, ' +
                '(Select Sum(RecvAcct.PaidAmount) As ReceiveAmount, RecvAcct.OrderNo ' +
                'From RecvAcct, OrderH ' +
                'Where OrderH.OrderNo=RecvAcct.OrderNo and (PayBy=' +
                 Chr(39) + CheckQuotes(PayByComboBox.Text) + Chr(39) +
                ' Or PayBy=' + Chr(39) + 'ROUNDING' + Chr(39) + ')';
      if DateCheckBox.Checked then
         SQLStr := SQLStr + ' and OrderH.OrderNo=RecvAcct.OrderNo and ' +
                   'OrderDate>=' + ConvertDateTime(DateTime1) +
                   ' and OrderDate<=' + ConvertDateTime(DateTime2);
      SQLStr := SQLStr + ' Group By RecvAcct.OrderNo) As TempTable ' +
                'Where OrderH.OrderNo=TempTable.OrderNo and ' +
                'PriceIncludesGST <> 0 and ' +
                'ABS(PaidAmount-TempTable.ReceiveAmount) < 0.001';
      if MachineIDCheckBox.Checked then
         SQLStr := SQLStr + ' and OrderH.MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Caption) + Chr(39);
      if InvoiceComboBox.ItemIndex <> 0 then
         begin
          if InvoiceComboBox.ItemIndex = 1 then
             SQLStr := SQLStr + ' and InvoiceNo Is Null'
            else
             SQLStr := SQLStr + ' and Not (InvoiceNo Is Null)';
         end;
      if PaymentComboBox.ItemIndex <> 0 then
         begin
          if PaymentComboBox.ItemIndex = 1 then
             SQLStr := SQLStr + ' and (Amount + ServiceCharge + OtherCharge + Tips + Surcharge - PaidAmount >=0.009)'
            else
             SQLStr := SQLStr + ' and (PaidAmount - (Amount + ServiceCharge + OtherCharge + Tips + Surcharge) >= 0)'
         end;
      SQLStr := SQLStr + ' Union All ' +
                'Select OrderH.OrderNo, OrderDate, TableNo, ' +  // Price does not Includes GST
                '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST) As TotalInvoice, ' +
                'OrderH.PaidAmount, InvoiceNo, VIPNo, OpName ' +
                'From OrderH, ' +
                '(Select Sum(RecvAcct.PaidAmount) As ReceiveAmount, RecvAcct.OrderNo ' +
                'From RecvAcct, OrderH ' +
                'Where OrderH.OrderNo=RecvAcct.OrderNo and (PayBy=' +
                 Chr(39) + CheckQuotes(PayByComboBox.Text) + Chr(39) +
                ' Or PayBy=' + Chr(39) + 'ROUNDING' + Chr(39) + ')';
      if DateCheckBox.Checked then
         SQLStr := SQLStr + ' and OrderH.OrderNo=RecvAcct.OrderNo and ' +
                   'OrderDate>=' + ConvertDateTime(DateTime1) +
                   ' and OrderDate<=' + ConvertDateTime(DateTime2);
      SQLStr := SQLStr +
                ' Group By RecvAcct.OrderNo) As TempTable ' +
                'Where OrderH.OrderNo=TempTable.OrderNo and ' +
                'PriceIncludesGST = 0 and ' +
                'ABS(PaidAmount-TempTable.ReceiveAmount) < 0.001';
      if MachineIDCheckBox.Checked then
         SQLStr := SQLStr + ' and OrderH.MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Caption) + Chr(39);
      if InvoiceComboBox.ItemIndex <> 0 then
         begin
          if InvoiceComboBox.ItemIndex = 1 then
             SQLStr := SQLStr + ' and InvoiceNo Is Null'
            else
             SQLStr := SQLStr + ' and Not (InvoiceNo Is Null)';
         end;
      if PaymentComboBox.ItemIndex <> 0 then
         begin
          if PaymentComboBox.ItemIndex = 1 then
             SQLStr := SQLStr + ' and (Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST - PaidAmount >=0.009)'
            else
             SQLStr := SQLStr + ' and (PaidAmount - (Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST) >= 0)'
         end;
      SQLStr := SQLStr + ' Order By OrderH.OrderNo';
     end;
 OpenQuery(SQLStr);
 DBGrid.SelectedRows.Clear;
 CalcAmount;
end;

procedure TManuallyMaintainDatabaseForm.CalcAmount;
var
 Amount: double;
 OrderNo: string;
begin
 Amount := 0;
 with Query do
  if Active and (RecordCount > 0) then
     begin
      OrderNo := FieldbyName('OrderNo').asString;
      DisableControls;
      First;
      while Not EOF do
       begin
        Amount := Amount + FieldByName('TotalInvoice').AsFloat;
        Next;
       end;
      First;
      Locate('Orderno', OrderNo, [loPartialKey]);
      EnableControls;
     end;
 TotalSalesEdit.Caption := Format('%4.2f ', [Amount]);
 SelectedAmountEdit.Caption := '';
 BalanceEdit.Caption := '';
end;

procedure TManuallyMaintainDatabaseForm.CalcSelectedAmount;
var
 SelectAmount, Balance: double;
 OrderNo: string;
begin
 SelectAmount := 0;
 with Query do
  if Active and (RecordCount > 0) then
     begin
      OrderNo := FieldbyName('OrderNo').asString;
      DisableControls;
      First;
      while Not EOF do
       begin
        if DBGrid.SelectedRows.CurrentRowSelected then
           SelectAmount := SelectAmount + FieldByName('TotalInvoice').AsFloat;
        Next;
       end;
      First;
      Locate('OrderNo', OrderNo, [loPartialKey]);
      EnableControls;
     end;
 if TotalSalesedit.Caption <> '' then
    Balance := StrToFloat(TotalSalesEdit.Caption)
   else
    Balance := 0;
 Balance := Balance - SelectAmount;
 SelectedAmountEdit.Caption := Format('%4.2f ', [SelectAmount]);
 BalanceEdit.Caption := Format('%4.2f ', [Balance]);
end;

procedure TManuallyMaintainDatabaseForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  FieldByName('Balance').AsFloat :=
      FieldByName('TotalInvoice').AsFloat - FieldByName('PaidAmount').AsFloat
end;

procedure TManuallyMaintainDatabaseForm.OpenTempQuery(SQLStr: string);
begin
 with TempQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
end;

procedure TManuallyMaintainDatabaseForm.OpenStockQuery(SQLStr: string);
begin
 with StockQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
end;

procedure TManuallyMaintainDatabaseForm.ReadPayment;
var
 SQLStr: string;
begin
 SQLStr := 'Select Payment From Payment Order By Code';
 OpenTempQuery(SQLStr);
 with TempQuery do
  begin
   if Active and (RecordCount > 0) then
      begin
       First;
       while Not EOF do
        begin
         PaybyComboBox.Items.Add(FieldByName('Payment').AsString);
         Next;
       end;
      end;
   Close;
  end;
end;

procedure TManuallyMaintainDatabaseForm.DateCheckBoxClick(Sender: TObject);
begin
 if DateCheckBox.Checked then
    begin
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
     DateEdit1.Enabled := True; DateEdit2.Enabled := True;
     TimeEdit1.Enabled := True; TimeEdit2.Enabled := True;
    end
   else
    begin
     DateEdit1.Text := ''; DateEdit2.Text := '';
     TimeEdit1.Text := ''; TimeEdit2.Text := '';
     DateEdit1.Enabled := False; DateEdit2.Enabled := False;
     TimeEdit1.Enabled := False; TimeEdit2.Enabled := False;
    end
end;

procedure TManuallyMaintainDatabaseForm.PayByCheckBoxClick(Sender: TObject);
begin
 if PayByCheckBox.Checked then
    begin
     PayByComboBox.Enabled := True;
     if PaybyComboBox.Items.Count > 0 then
        begin
         PaybyComboBox.ItemIndex := 0;
         PaybyComboBox.Text := PaybyComboBox.Items[0];
        end
    end
   else
    begin
     PayByComboBox.Enabled := False;
     PaybyComboBox.ItemIndex := -1;
     PaybyComboBox.Text := '';
    end;
end;

procedure TManuallyMaintainDatabaseForm.SearchButtonClick(Sender: TObject);
begin
 OpenDatabase;
 DBGrid.SetFocus;
end;

procedure TManuallyMaintainDatabaseForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TManuallyMaintainDatabaseForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TManuallyMaintainDatabaseForm.CalcButtonClick(Sender: TObject);
begin
 CalcSelectedAmount;
 DBGrid.SetFocus;
end;

procedure TManuallyMaintainDatabaseForm.DateEdit1Exit(Sender: TObject);
begin
 if DateCheckBox.Checked and Not CheckDate(DateEdit1.Text) then
    DateEdit1.SetFocus;
end;

procedure TManuallyMaintainDatabaseForm.DateEdit2Exit(Sender: TObject);
begin
 if DateCheckBox.Checked and Not CheckDate(DateEdit2.Text) then
    DateEdit2.SetFocus;
end;

procedure TManuallyMaintainDatabaseForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TManuallyMaintainDatabaseForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TManuallyMaintainDatabaseForm.IssueInvoiceNoPro;
var
 OrderNo: string;
 Flag: boolean;
begin
 if Not Query.Active or (Query.RecordCount = 0) or
   (MessageBoxForm.MessagePro('Do you want to issue the invoice number?', sConfirmMsg) = mrNo) then Exit;
 OrderNo := Query.FieldByName('OrderNo').AsString;
 if Not DataForm.BeginTransaction then Exit;
 Flag := False;
 try
  Flag := DataForm.SetInvoiceNo(OrderNo);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      OpenDatabase;
      Query.Locate('OrderNo', OrderNo, [loPartialKey]);
     end
    else
     begin
      DataForm.RollBack;
     end;
 end;
 DBGrid.SetFocus;
end;

procedure TManuallyMaintainDatabaseForm.ViewButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     OrderNo := Query.FieldByName('OrderNo').AsString;
     SalesHistoryDetailForm.SalesDetailPro(OrderNo);
    end;
end;

procedure TManuallyMaintainDatabaseForm.EditPayment;
var
 OrderNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     OrderNo := Query.FieldByName('OrderNo').AsString;
     if ReceiptListForm.ReceiptListPro(OrderNo, EditOrderPayment) then
        begin
         SearchButtonClick(Self);
         Query.Locate('OrderNo', OrderNo, [loPartialKey]);
        end;
    end;
end;

procedure TManuallyMaintainDatabaseForm.DBGridDblClick(Sender: TObject);
begin
 ViewButtonClick(Sender);
end;

function TManuallyMaintainDatabaseForm.UpdateOrderNo(OldOrderNo, NewOrderNo: string): boolean;
var
 SQLStr: string;
begin
 if OldOrderNo <> NewOrderNo then
    begin
     SQLStr := 'Delete From OrderH Where OrderNo=' + Chr(39) + CheckQuotes(NewOrderNo) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
     if Result then
        begin
         SQLStr := 'Delete From OrderI Where OrderNo=' + Chr(39) + CheckQuotes(NewOrderNo) + Chr(39);
         Result := DataForm.ExecQueryPro(SQLStr);
        end;
     if Result then
        begin
         SQLStr := 'Delete From RecvAcct Where OrderNo=' + Chr(39) + CheckQuotes(NewOrderNo) + Chr(39);
         Result := DataForm.ExecQueryPro(SQLStr);
        end;
     if Result then
        begin
         SQLStr := 'Update OrderH Set OrderNo=' + Chr(39) + CheckQuotes(NewOrderNo) + Chr(39) +
                   ' Where OrderNo=' + Chr(39) + CheckQuotes(OldOrderNo) + Chr(39);
         Result := DataForm.ExecQueryPro(SQLStr);
        end;
     if Result then
        begin
         SQLStr := 'Update OrderI Set OrderNo=' + Chr(39) + CheckQuotes(NewOrderNo) + Chr(39) +
                   ' Where OrderNo=' + Chr(39) + CheckQuotes(OldOrderNo) + Chr(39);
         Result := DataForm.ExecQueryPro(SQLStr);
        end;
     if Result then
        begin
         SQLStr := 'Update RecvAcct Set OrderNo=' + Chr(39) + CheckQuotes(NewOrderNo) + Chr(39) +
                   ' Where OrderNo=' + Chr(39) + CheckQuotes(OldOrderNo) + Chr(39);
         Result := DataForm.ExecQueryPro(SQLStr);
        end;
    end
   else
    Result := True;
end;

procedure TManuallyMaintainDatabaseForm.SelectAllButtonClick(Sender: TObject);
begin
 with Query do
  begin
   DisableControls;
   if Active and (RecordCount > 0) then
      begin
       First;
       while Not EOF do
        begin
         DBGrid.SelectedRows.CurrentRowSelected := True;
         Next;
        end;
      end;
   EnableControls;
  end;
 DBGrid.SetFocus;
end;

function TManuallyMaintainDatabaseForm.ReArrangeOrderNoPro: boolean;
var
 SQLStr, DateStr, Temp, NewOrderNo: string;
 I: integer;
 DateTemp1, DateTemp2: TDateTime;
begin
 DateTemp1 := TransferDate(DateEdit1.Text);
 DateTemp2 := TransferDate(DateEdit2.Text);
 SQLStr := 'Select OrderNo From OrderH ' +
           'Where OrderDate>=' + ConvertDateTime(DateTemp1 + StrToTime('0:0')) +
           ' and OrderDate<=' + ConvertDateTime(DateTemp2 + StrToTime('23:59:59')) +
           ' Order By OrderNo';
 Result := True; I := 0; DateStr := '';
 OpenTempQuery(SQLStr);
 with TempQuery do
  begin
   if Active and (RecordCount > 0) then
       begin
        First;
        while Result and Not EOF do
         begin
          Temp := Copy(FieldByName('OrderNo').AsString, 1, 6);
          if Temp <> DateStr then begin DateStr := Temp; I := 0 end;
          I := I + 1;
          NewOrderNo := DateStr + Format('%4.4d', [I]);
          Result := UpdateOrderNo(FieldByName('OrderNo').AsString, NewOrderNo);
          Next;
         end;
       end;
   Close;
  end
end;

function TManuallyMaintainDatabaseForm.UpdateDrawerOpenCounterPro: boolean;
var
 SQLStr, DateStr, OrderDateStr, DrawerCounterStr, MachineIDStr: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 DateTemp1 := TransferDate(DateEdit1.Text);
 DateTemp2 := TransferDate(DateEdit2.Text);
 SQLStr := 'Select Count(*) As TotalOrder, MachineID, ' +
           ' DATEPART(Day, OrderDate) As OrderDay, ' +
           ' DATEPART(Month, OrderDate) As OrderMonth, ' +
           ' DATEPART(Year, OrderDate) As OrderYear ' +
           ' From OrderH ' +
           ' Where OrderDate>=' + ConvertDateTime(DateTemp1 + StrToTime('0:0')) +
           ' and OrderDate<=' + ConvertDateTime(DateTemp2 + StrToTime('23:59:59')) +
           ' Group By DATEPART(Day, OrderDate), DATEPART(Month, OrderDate), ' +
           ' DATEPART(Year, OrderDate), MachineID ' +
           ' Order By DATEPART(Year, OrderDate), DATEPART(Month, OrderDate), ' +
           ' DATEPART(Day, OrderDate), MachineID ';
 Result := True; DateStr := '';
 OpenTempQuery(SQLStr);
 with TempQuery do
  begin
   if Active and (RecordCount > 0) then
       begin
        First;
        while Result and Not EOF do
         begin
          OrderDateStr := ConvertDateTime(EncodeDate(FieldByName('OrderYear').AsInteger,
                          FieldByName('OrderMonth').AsInteger,
                          FieldByName('OrderDay').AsInteger));
          DrawerCounterStr := FieldByName('TotalOrder').AsString;
          if FieldByName('MachineID').AsString <> '' then
             MachineIDStr := '=' + Chr(39) + CheckQuotes(FieldByName('MachineID').AsString) + Chr(39)
            else
             MachineIDStr := ' IS Null';
          SQLStr := 'Update DrawerCounter Set Times=' + DrawerCounterStr +
                    ' Where OpenDate=' + OrderDateStr +
                    ' and MachineID' + MachineIDStr;
          Result := DataForm.ExecQueryPro(SQLStr);
          Next;
         end;
       end;
   Close;
  end
end;

procedure TManuallyMaintainDatabaseForm.ReArrangeIDPro;
var
 DateTemp1, DateTemp2: TDateTime;
 Flag: boolean;
begin
 if Not DateCheckBox.Checked then
    begin
     MessageBoxForm.MessagePro('You have to set the date period then' +
      Chr(13) + Chr(10) + Chr(13) + Chr(10) +
      'you can re-arrange order number!', sInformationMsg);
     Exit;
    end;
 DateTemp1 := TransferDate(DateEdit1.Text);
 DateTemp2 := TransferDate(DateEdit2.Text);
 if DateTemp1 > DateTemp2 then
    begin
     MessageBoxForm.MessagePro('Date error!', sErrorMsg);
     Exit;
    end;
 if MessageBoxForm.MessagePro('Are you sure you want to re-arrange order number?', sConfirmMsg) = mrNo then Exit;
 if Not DataForm.BeginTransaction then Exit;
 DataForm.ExecCommand.CommandTimeout := 600;
 DisplayMessageForm.DisplayMessagePro('Update database, please wait...');
 Application.ProcessMessages;
 Flag := True;
 try
  Flag := ReArrangeOrderNoPro;
  if Flag then Flag := UpdateDrawerOpenCounterPro;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      OpenDatabase;
     end
    else
     DataForm.RollBack;
  DisplayMessageForm.Close;
  DisplayMessageForm.Free;
  if Flag then MessageBoxForm.MessagePro('Re-arrange order number are successful', sInformationMsg);
  DataForm.ExecCommand.CommandTimeout := 30;
 end;
end;

procedure TManuallyMaintainDatabaseForm.RePrintInvoicePro;
var
 OrderNo, PrintOrderNo: string;
begin
 if MessageBoxForm.MessagePro('Do you want to re-print invoice?', sConfirmMsg) = mrYes then
    with Query do
     if Active and (RecordCount > 0) then
        begin
         OrderNo := FieldbyName('OrderNo').asString;
         DisableControls;
         First;
         while Not EOF do
          begin
           if FieldByName('InvoiceNo').AsString <> '' then
              begin
               PrintOrderNo := FieldbyName('OrderNo').asString;
               case PrintInvoiceMode of
                0, 1: PrintInvoiceForm.PrintInvoicePro(PrintOrderNo);
                2:    PrintInvoiceForm1.PrintInvoicePro(PrintOrderNo, True);
                3:    PrintInvoiceForm1.PrintInvoicePro(PrintOrderNo, False);
                4:    PrintInvoiceForm2.PrintInvoicePro(PrintOrderNo);
                5:    PrintInvoiceForm3.PrintInvoicePro(PrintOrderNo);
               end; 
              end;
           Next;
          end;
         First;
         Locate('OrderNo', OrderNo, [loPartialKey]);
         EnableControls;
        end;
end;

procedure TManuallyMaintainDatabaseForm.RePrintBillPro;
var
 OrderNo, PrintOrderNo: string;
begin
 if MessageBoxForm.MessagePro('Do you want to re-print invoice?', sConfirmMsg) = mrYes then
    with Query do
     if Active and (RecordCount > 0) then
        begin
         OrderNo := FieldbyName('OrderNo').asString;
         DisableControls;
         First;
         while Not EOF do
          begin
           PrintOrderNo := FieldbyName('OrderNo').asString;
           case PrintBillMode of
            0, 1: PrintOrderForm.PrintOrderPro(PrintOrderNo);
            2:    PrintOrderForm1.PrintOrderPro(PrintOrderNo, True);
            3:    PrintOrderForm1.PrintOrderPro(PrintOrderNo, False);
            4:    PrintOrderForm2.PrintOrderPro(PrintOrderNo);
            5:    PrintOrderForm3.PrintOrderPro(PrintOrderNo);
           end; 
           Next;
          end;
         First;
         Locate('OrderNo', OrderNo, [loPartialKey]);
         EnableControls;
        end;
end;

procedure TManuallyMaintainDatabaseForm.DateEditClick(Sender: TObject);
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

procedure TManuallyMaintainDatabaseForm.TimeEditClick(Sender: TObject);
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

procedure TManuallyMaintainDatabaseForm.MakeAdjustmentNo(var AdjustmentNo: string);
var
 CurrentYear, SQLStr: string;
 NewNo: Integer;
 Year, Month, Day: word;
begin
 DecodeDate(Date, Year, Month, Day);
 CurrentYear := Copy(Format('%4.4d', [Year]), 3, 2);
 SQLStr := 'Select Max(ReceiveNo) From StockH ' +
           'Where Kind=1 and ReceiveNo Like ' +
           Chr(39) + 'J' + CurrentYear + SearchMark + Chr(39);
 OpenTempQuery(SQLStr);
 with TempQuery do
  begin
   if Active and (Fields[0].AsString <> '') then
      NewNo := StrToInt(Copy(Fields[0].AsString, 4, 5))
     else
      NewNo := 0;
   Close;
  end;
 Inc(NewNo);
 AdjustmentNo := 'J' + CurrentYear + Format('%5.5d', [NewNo]);
end;

function TManuallyMaintainDatabaseForm.SaveAdjustHeadData(AdjustNo: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Insert Into StockH(ReceiveNo, PurchaseNo, ReceiveDate, ' +
           'SupplierCode, Amount, GST, GSTStatus, PaidAmount, ' +
           'Notes, OpName, InvoiceNo, Kind)' +
           'Values(' + Chr(39) + CheckQuotes(AdjustNo) + Chr(39) + ',' +
           'Null, ' + ConvertDateTime(Date) +
           ', Null, 0, 0, 0, 0,' + Chr(39) + 'Stock Take' + Chr(39) + ',' +
           Chr(39) + sUserName + Chr(39) + ', Null, 1)';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TManuallyMaintainDatabaseForm.SaveAdjustItemData(AdjustNo, Code: string; Qty: double; I: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Insert Into StockI(ReceiveNo, Code, Qty, Price, GSTRate, Kind, ID) ' +
           'Values(' + Chr(39) + CheckQuotes(AdjustNo) + Chr(39) + ',' +
           Chr(39) + CheckQuotes(Code) + Chr(39) + ',' + FloatToStr(0 - Qty) + ', 0, 0, 1, ' +
           IntToStr(I) + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TManuallyMaintainDatabaseForm.UpdateStockPro(OrderNoArray: string): boolean;
var
 SQLStr, AdjustNo, Code: string;
 Qty: double;
 I: integer;
begin
 MakeAdjustmentNo(AdjustNo);
 SQLStr := 'Select StockTable.Code, ' +
           'Sum(OrderI.Qty * (StockLinkTable.Measure / StockTable.Measure)) As SalesQty ' +
           'From StockTable, StockLinkTable, OrderI ' +
           'Where StockTable.Code=StockLinkTable.Code and ' +
           'StockLinkTable.ItemCode=OrderI.ItemCode and ' +
           'OrderI.PriceSelect=StockLinkTable.Priceselect and ' +
           'StockTable.Measure > 0 and ' +
           'OrderI.OrderNo In (' + OrderNoArray + ')' +
           ' Group By StockTable.Code Order by StockTable.Code';
 OpenStockQuery(SQLStr);
 Result := True; I := 1;
 with StockQuery do
  begin
   while Not EOF and Result do
    begin
     Code := FieldByName('Code').AsString;
     Qty := FieldByName('SalesQty').AsFloat;
     Result := SaveAdjustItemData(AdjustNo, Code, Qty, I);
     I := I + 1;
     if (I > 300) and Result then
        begin
         I := 1;
         Result := SaveAdjustHeadData(AdjustNo);
         MakeAdjustmentNo(AdjustNo);
        end;
     Next;
   end;
  end;
 if (I > 0) and Result then
    Result := SaveAdjustHeadData(AdjustNo);
end;

procedure TManuallyMaintainDatabaseForm.TestOrderStatus(var Invoiced, Balance: boolean);
begin
 Invoiced := False;
 Balance := True;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     if DBGrid.SelectedRows.CurrentRowSelected then
        begin
         if FieldByName('Balance').AsFloat >= 0.01 then
            Balance := False;
         if FieldByName('InvoiceNo').AsString <> '' then
            Invoiced := True;
        end;
     Next;
    end;
   EnableControls;
  end;
end;

function TManuallyMaintainDatabaseForm.DeleteRecord(OrderNoArray: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From OrderH Where OrderNo In (' + OrderNoArray + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From OrderI Where OrderNo In (' + OrderNoArray + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Delete From RecvAcct Where OrderNo In (' + OrderNoArray + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TManuallyMaintainDatabaseForm.DeleteRecordPro(OrderNoArray: string): boolean;
begin
 Result := False;
 if DataForm.BeginTransaction then
    begin
     DataForm.ExecCommand.CommandTimeout := 600;
     try
      Result := UpdateStockPro(OrderNoArray);
      if Result then Result := DeleteRecord(OrderNoArray);
     finally
      if Result then
         DataForm.CommitTransaction
        else
         DataForm.RollBack;
     end;
     DataForm.ExecCommand.CommandTimeout := 30;
    end;
end;

procedure TManuallyMaintainDatabaseForm.DeleteOrderPro;
var
 OrderNoArray: string;
 Flag, Invoiced, Balance: boolean;
 I: integer;
begin
 if Not Query.Active or (Query.RecordCount = 0) then Exit;
 if (DBGrid.SelectedRows.Count = 0) or
    (MessageBoxForm.MessagePro('Are you sure you want to delete the records?', sConfirmMsg) = mrNo) then Exit;
 TestOrderStatus(Invoiced, Balance);
 if (Not Balance and
    (MessageBoxForm.MessagePro('Some orders are not paid in full.' +
    Chr(13) + Chr(10) + Chr(13) + Chr(10) +
    'Do you want to delete?', sConfirmMsg) = mrNo)) or
    (Invoiced and
    (MessageBoxForm.MessagePro('Some orders are invoiced.' +
    Chr(13) + Chr(10) + Chr(13) + Chr(10) +
    'Do you want to delete?', sConfirmMsg) = mrNo)) then Exit;
 DisplayMessageForm.DisplayMessagePro('Update database, please wait...');
 Application.ProcessMessages;
 Flag := True;
 try
  with Query do
   begin
    DisableControls;
    First; I := 0; OrderNoArray := '';
    while Flag and Not EOF do
     begin
      if DBGrid.SelectedRows.CurrentRowSelected then
         begin
          if I >= 1 then OrderNoArray := OrderNoArray + ',';
          OrderNoArray := OrdernoArray + Chr(39) + CheckQuotes(FieldByName('OrderNo').AsString) + Chr(39);
          I := I + 1;
          if I >= 100 then
             begin
              Flag := DeleteRecordPro(OrderNoArray);
              I := 0; OrderNoArray := '';
             end;
         end;
      Next;
     end;
    EnableControls;
   end;
  if Flag and (I >= 1) and (OrderNoArray <> '') then
     Flag := DeleteRecordPro(OrderNoArray);
  if Flag then OpenDatabase;
 finally
  DisplayMessageForm.Close;
  DisplayMessageForm.Free;
 end;
end;

procedure TManuallyMaintainDatabaseForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Shift = [ssCtrl] then
    case Key of
     VK_F7:  IssueInvoiceNoPro;
     VK_F8:  RePrintInvoicePro;
     VK_F9:  RePrintBillPro;
     VK_F10: ReArrangeIDPro;
     VK_DELETE: DeleteOrderPro;
    end
   else
    if Key = VK_ESCAPE then Close;
end;

procedure TManuallyMaintainDatabaseForm.EditPaymentButtonClick(Sender: TObject);
begin
 EditPayment;
end;

procedure TManuallyMaintainDatabaseForm.MachineIDCheckBoxClick(Sender: TObject);
begin
 if MachineIDCheckBox.Checked then
    MachineIDEdit.Enabled := True
   else
    begin
     MachineIDEdit.Enabled := False;
     MachineIDEdit.Caption := '';
    end;
end;

procedure TManuallyMaintainDatabaseForm.MachineIDEditClick(Sender: TObject);
var
 MachineName: string;
begin
 if MachineIDSelectForm.MachineIDSelectPro(MachineName) then
    MachineIDEdit.Caption := MachineName;
end;

procedure TManuallyMaintainDatabaseForm.FormShow(Sender: TObject);
begin
 //Width := DBGridPanel.Width + 28;
 //Height := ExitButton.Top + 86;
 Top := (Screen.Height - Height) div 2;
 //Left := 1024 - BackPanel.Width + (Screen.Width - 1024) div 2 -3  ;
 Left := (MainForm.ClientWidth - Width) div 2;
 DateCheckBox.Checked := False;
 DateEdit1.Enabled := False;
 DateEdit2.Enabled := False;
 TimeEdit1.Enabled := False;
 TimeEdit2.Enabled := False;
 PaybyCheckBox.Checked := False;
 PayByComboBox.Enabled := False;
 MachineIDCheckBox.Checked := False;
 MachineIDEdit.Enabled := False;
 InvoiceComboBox.Text := InvoiceComboBox.Items[0];
 InvoiceComboBox.ItemIndex := 0;
 PaymentComboBox.Text := PaymentComboBox.Items[0];
 PaymentComboBox.ItemIndex := 0;
 ReadPayment;
 QueryTotalInvoice.DisplayFormat := sCurrency + ',0.#0';
 QueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryBalance.DisplayFormat := sCurrency + ',0.#0';
end;

procedure TManuallyMaintainDatabaseForm.ManuallyMaintainDatabasePro;
begin
 Application.CreateForm(TManuallyMaintainDatabaseForm, ManuallyMaintainDatabaseForm);
 ManuallyMaintainDatabaseForm.ShowModal;
 ManuallyMaintainDatabaseForm.Free;
end;

procedure TManuallyMaintainDatabaseForm.Select1;
var
  i : integer;
begin
  i := 0;
  with Query do
  begin
  if Active and (RecordCount > 0) then
  begin
    First;
    while Not EOF do
    begin
      if (i mod 2) =0 then
      begin
        DBGrid.SelectedRows.CurrentRowSelected := True;

      end;
    i :=  i + 1;
    Next;
    end;
  end;
  end;
end;

procedure TManuallyMaintainDatabaseForm.XiButton1Click(Sender: TObject);
begin
  Select1;
end;


procedure TManuallyMaintainDatabaseForm.Select2;
var
  i : integer;
begin
  i := 0;
  with Query do
  begin
  if Active and (RecordCount > 0) then
  begin
    First;
    while Not EOF do
    begin
      if (i mod 3) =0 then
      begin
        DBGrid.SelectedRows.CurrentRowSelected := True;

      end;
    i :=  i + 1;
    Next;
    end;
  end;
  end;
end;

procedure TManuallyMaintainDatabaseForm.Select3;
var
  i : integer;
begin
  i := 0;
  with Query do
  begin
  if Active and (RecordCount > 0) then
  begin
    First;
    while Not EOF do
    begin
      if (i mod 5) =0 then
      begin
        DBGrid.SelectedRows.CurrentRowSelected := True;

      end;
    i :=  i + 1;
    Next;
    end;
  end;
  end;
end;


procedure TManuallyMaintainDatabaseForm.XiButton2Click(Sender: TObject);
begin
  Select2;
end;

procedure TManuallyMaintainDatabaseForm.XiButton3Click(Sender: TObject);
begin
  Select3;
end;

end.

