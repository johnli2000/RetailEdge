unit Maintenance;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, DBTables, Grids, DBGrids, ExtCtrls, UtilUnit,
  DataUnit, ADODB, ComCtrls, Gauges, bsSkinCtrls, BusinessSkinForm,
  XiButton;

type
  TMaintenanceForm = class(TForm)
    DateCheckBox: TCheckBox;
    DateEdit1: TMaskEdit;
    Label1: TLabel;
    DateEdit2: TMaskEdit;
    SalesandReceiptsBox: TCheckBox;
    ExemptTaxInvoiceCheckBox: TCheckBox;
    PointOfSalesInvoiceCheckBox: TCheckBox;
    Query: TADOQuery;
    TempQuery: TADOQuery;
    Gauge: TGauge;
    StockValueCheckBox: TCheckBox;
    DeleteAllCheckBox: TCheckBox;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    ControlPanel: TbsSkinPanel;
    DatePanel: TbsSkinPanel;
    IndicatePanel: TbsSkinPanel;
    IndividualButton: TXiButton;
    StartButton: TXiButton;
    ExitButton: TXiButton;
    TableGroupBox: TbsSkinGroupBox;
    procedure OpenQuery(SQLStr: string);
    procedure OpenTempQuery(SQLStr: string);
    procedure DateCheckBoxClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    function  ProcessTaxInvoice: boolean;
    function  ProcessPointOfSalesInvoice: boolean;
    function  ProcessExemptTaxInvoice: boolean;
    function  ProcessInternalOrder: boolean;
    function  ProcessStockReceive: boolean;
    function  ProcessStockAdjustment: boolean;
    function  ProcessStockTransferIn: boolean;
    function  ProcessStockTransferOut: boolean;
    function  ProcessStockTake: boolean;
    function  ProcessAttendanceRecord: boolean;
    function  ProcessPurchaseOrder: boolean;
    function  ProcessCreditNotes: boolean;
    function  ProcessDebitNotes: boolean;
    function  ProcessExpenses: boolean;
    function  ProcessStockToWarranty: boolean;
    function  ProcessWarrantyBackToStock: boolean;
    function  ProcessCategory: boolean;
    function  ProcessProduct: boolean;
    function  ProcessCustomer: boolean;
    function  ProcessSupplier: boolean;
    function  ProcessLayByCustomer: boolean;
    function  ProcessDrawerOpenRecord: boolean;
    procedure MakeAdjustmentNo(var AdjustmentNo: string);
    function  SaveAdjustHeadData(AdjustNo, WarehouseCode: string; TotalCost: double): boolean;
    function  SaveAdjustItemData(AdjustNo, ProductCode, WarehouseCode: string;
              AdjustQty, AdjustCost: double; I: integer): boolean;
    function  ProcessStockBalance: boolean;
    function  ClearStockValue: boolean;
    procedure StartButtonClick(Sender: TObject);
    procedure DeleteAllCheckBoxClick(Sender: TObject);
    procedure IndividualButtonClick(Sender: TObject);
    procedure MaintenancePro;
  private { Private declarations }
     Date1, Date2: TDateTime;
     WarehouseCodeTemp: WarehouseCodeArrayType;
  public
    { Public declarations }
  end;

var
  MaintenanceForm: TMaintenanceForm;

implementation

uses DatePanel, MainMenu, MessageBox, InvoiceMaintenance;

{$R *.DFM}

procedure TMaintenanceForm.OpenQuery(SQLStr: string);
begin
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
   end;
  end;
end;

procedure TMaintenanceForm.OpenTempQuery(SQLStr: string);
begin
 with TempQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
   end;
  end;
end;

procedure TMaintenanceForm.DateCheckBoxClick(Sender: TObject);
begin
 if DateCheckBox.Checked then
    begin
     DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
     DateEdit2.Text := DateEdit1.Text;
     DateEdit1.Enabled := True;
     DateEdit2.Enabled := True;
    end
   else
    begin
     DateEdit1.Text := '';
     DateEdit2.Text := '';
     DateEdit1.Enabled := False;
     DateEdit2.Enabled := False;
    end;
 StockValueCheckBox.Checked := True;
 if Not DateCheckBox.Checked and DeleteAllCheckBox.Checked then
    StockValueCheckBox.Enabled := True
   else
    StockValueCheckBox.Enabled := False;
end;

procedure TMaintenanceForm.DeleteAllCheckBoxClick(Sender: TObject);
begin
 if DeleteAllCheckBox.Checked then
    begin
     TaxInvoiceCheckBox.Checked := True;
     ExemptTaxInvoiceCheckBox.Checked := True;
     PointOfSalesInvoiceCheckBox.Checked := True;
     InternalOrderCheckBox.Checked := True;
     StockReceiveCheckBox.Checked := True;
     StockTransferInCheckBox.Checked := True;
     StockTransferOutCheckBox.Checked := True;
     PurchaseOrderCheckBox.Checked := True;
     CreditNotesCheckBox.Checked := True;
     DebitNotesCheckBox.Checked := True;
     ExpensesCheckBox.Checked := True;
     StockAdjustmentCheckBox.Checked := True;
     StockToWarrantyCheckBox.Checked := True;
     WarrantyBackToStockCheckBox.Checked := True;
     StockTakeCheckBox.Checked := True;
    end;
 StockValueCheckBox.Checked := True;
 if Not DateCheckBox.Checked and DeleteAllCheckBox.Checked then
    StockValueCheckBox.Enabled := True
   else
    StockValueCheckBox.Enabled := False;
end;

procedure TMaintenanceForm.DateEditClick(Sender: TObject);
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

procedure TMaintenanceForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TMaintenanceForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TMaintenanceForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TMaintenanceForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

function TMaintenanceForm.ProcessTaxInvoice: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From InvoiceItem Where InvoiceNo In (' +
           'Select InvoiceNo From InvoiceHead ' +
           'Where KindFlag=' + sTaxInvoiceFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
              ' and InvoiceDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From RecvAcct Where InvoiceNo In (' +
               'Select InvoiceNo From InvoiceHead Where KindFlag=' +
               sTaxInvoiceFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
                ' and InvoiceDate <=' + ConvertDateTime(Date2);
     SQLStr := SQLStr + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Delete From InvoiceHead Where KindFlag =' + sTaxInvoiceFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
                ' and InvoiceDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessPointOfSalesInvoice: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From InvoiceItem Where InvoiceNo In (' +
           'Select InvoiceNo From InvoiceHead ' +
           'Where KindFlag=' + sPointOfSalesFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
              ' and InvoiceDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From RecvAcct Where InvoiceNo In (' +
               'Select InvoiceNo From InvoiceHead Where KindFlag=' +
               sPointOfSalesFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
                ' and InvoiceDate <=' + ConvertDateTime(Date2);
     SQLStr := SQLStr + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Delete From InvoiceHead Where KindFlag =' + sPointOfSalesFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
                ' and InvoiceDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessExemptTaxInvoice: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From InvoiceItem Where InvoiceNo In (' +
           'Select InvoiceNo From InvoiceHead ' +
           'Where KindFlag=' + sExemptTaxInvoiceFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
              ' and InvoiceDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From RecvAcct Where InvoiceNo In (' +
               'Select InvoiceNo From InvoiceHead Where KindFlag=' +
               sExemptTaxInvoiceFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
                ' and InvoiceDate <=' + ConvertDateTime(Date2);
     SQLStr := SQLStr + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Delete From InvoiceHead Where KindFlag =' +
               sExemptTaxInvoiceFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
                ' and InvoiceDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessInternalOrder: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From CustomerOrderItem Where OrderNo In (' +
           'Select OrderNo From CustomerOrderHead ';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' Where OrderDate >= '+ ConvertDateTime(Date1) +
              ' and OrderDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From CustomerOrderHead';
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' Where OrderDate >= '+ ConvertDateTime(Date1) +
                ' and OrderDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessStockReceive: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From StockReceiveItem Where ReceiveNo In (' +
           'Select ReceiveNo From StockReceiveHead ' +
           'Where KindFlag=' + sStockReceiveFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
              ' and ReceiveDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From PayAcct Where ReceiveNo In (' +
               'Select ReceiveNo From StockReceiveHead Where KindFlag=' +
               sStockReceiveFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
                ' and ReceiveDate <=' + ConvertDateTime(Date2);
     SQLStr := SQLStr + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Delete From StockReceiveHead Where KindFlag =' + sStockReceiveFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
                ' and ReceiveDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessStockAdjustment: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From StockReceiveItem Where ReceiveNo In (' +
           'Select ReceiveNo From StockReceiveHead ' +
           'Where KindFlag=' + sStockAdjustmentFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
              ' and ReceiveDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From StockReceiveHead Where KindFlag =' + sStockAdjustmentFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
                ' and ReceiveDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessStockTransferIn: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From StockReceiveItem Where ReceiveNo In (' +
           'Select ReceiveNo From StockReceiveHead ' +
           'Where KindFlag=' + sStockTransferInFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
              ' and ReceiveDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From StockReceiveHead Where KindFlag =' +
               sStockTransferInFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
                ' and ReceiveDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessStockTransferOut: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From InvoiceItem Where InvoiceNo In (' +
           'Select InvoiceNo From InvoiceHead ' +
           'Where KindFlag=' + sStockTransferOutFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
              ' and InvoiceDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From InvoiceHead Where KindFlag =' +
               sStockTransferOutFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
                ' and InvoiceDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessPurchaseOrder: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From PurchaseItem Where PurchaseNo In (' +
           'Select PurchaseNo From PurchaseHead ';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' Where PurchaseDate >= '+ ConvertDateTime(Date1) +
              ' and PurchaseDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From PurchaseHead';
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' Where PurchaseDate >= '+ ConvertDateTime(Date1) +
                ' and PurchaseDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessCreditNotes: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From InvoiceItem Where InvoiceNo In (' +
           'Select InvoiceNo From InvoiceHead ' +
           'Where KindFlag=' + sCreditNotesFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
              ' and InvoiceDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From RecvAcct Where InvoiceNo In (' +
               'Select InvoiceNo From InvoiceHead Where KindFlag=' +
               sCreditNotesFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
                ' and InvoiceDate <=' + ConvertDateTime(Date2);
     SQLStr := SQLStr + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Delete From InvoiceHead Where KindFlag =' + sCreditNotesFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and InvoiceDate >= '+ ConvertDateTime(Date1) +
                ' and InvoiceDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessDebitNotes: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From StockReceiveItem Where ReceiveNo In (' +
           'Select ReceiveNo From StockReceiveHead ' +
           'Where KindFlag=' + sDebitNotesFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
              ' and ReceiveDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From PayAcct Where ReceiveNo In (' +
               'Select ReceiveNo From StockReceiveHead Where KindFlag=' +
               sDebitNotesFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
                ' and ReceiveDate <=' + ConvertDateTime(Date2);
     SQLStr := SQLStr + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Delete From StockReceiveHead Where KindFlag =' + sDebitNotesFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
                ' and ReceiveDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessExpenses: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From ExpDetail Where SerialNo In (' +
           'Select SerialNo From Expenses';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' where AcctDate >= '+ ConvertDateTime(Date1) +
              ' and AcctDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From ExpAcct Where SerialNo In (' +
               'Select SerialNo From Expenses';
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' Where AcctDate >= '+ ConvertDateTime(Date1) +
                ' and AcctDate <=' + ConvertDateTime(Date2);
     SQLStr := SQLStr + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Delete From Expenses';
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' Where AcctDate >= '+ ConvertDateTime(Date1) +
                ' and AcctDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessStockToWarranty: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From StockReceiveItem Where ReceiveNo In (' +
           'Select ReceiveNo From StockReceiveHead ' +
           'Where KindFlag=' + sStockToWarrantyFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
              ' and ReceiveDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From StockReceiveHead Where KindFlag =' + sStockToWarrantyFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
                ' and ReceiveDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessWarrantyBackToStock: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From StockReceiveItem Where ReceiveNo In (' +
           'Select ReceiveNo From StockReceiveHead ' +
           'Where KindFlag=' + sWarrantyBackToStockFlag;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
              ' and ReceiveDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From StockReceiveHead Where KindFlag =' + sWarrantyBackToStockFlag;
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and ReceiveDate >= '+ ConvertDateTime(Date1) +
                ' and ReceiveDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessStockTake: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From StockTakeItem Where StockTakeNo In (' +
           'Select StockTakeNo From StockTakeHead ';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' Where StockTakeDate >= '+ ConvertDateTime(Date1) +
              ' and StockTakeDate <=' + ConvertDateTime(Date2);
 SQLStr := SQLStr + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From StockTakeHead ';
     if DateCheckBox.Checked then
        SQLStr := SQLStr + 'Where StockTakeDate >= '+ ConvertDateTime(Date1) +
                ' and StockTakeDate <=' + ConvertDateTime(Date2);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessAttendanceRecord: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From Attendance ';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' Where LoginTime >= '+ ConvertDateTime(Date1 + StrToTime('00:00:00')) +
              ' and LogOutTime <=' + ConvertDateTime(Date2 + StrToTime('23:59:59'));
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TMaintenanceForm.ProcessDrawerOpenRecord: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From DrawerOpenRecordTable ';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + 'Where OpenDateTime>=' + ConvertDateTime(Date1 + StrToTime('00:00:00')) +
                       ' and OpenDateTime <=' + ConvertDateTime(Date2 + StrToTime('23:59:59'));
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TMaintenanceForm.ProcessCategory: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From Category';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TMaintenanceForm.ProcessProduct: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From Product';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From ConsolidatePriceTable';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Delete From Department';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Delete From ProductFamily';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessCustomer: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From Customer';
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From CustomerGroup';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMaintenanceForm.ProcessSupplier: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From Supplier';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TMaintenanceForm.ProcessLayByCustomer: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From LayByCustomer';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

procedure TMaintenanceForm.MakeAdjustmentNo(var AdjustmentNo: string);
var
 CurrentYear, SQLStr: string;
 NewNo: Integer;
 Year, Month, Day: word;
begin
 DecodeDate(Date, Year, Month, Day);
 CurrentYear := Copy(Format('%4.4d', [Year]), 3, 2);
 SQLStr := 'Select Max(ReceiveNo) From StockReceiveHead ' +
           'Where ReceiveNo Like ' + Chr(39) + 'J' + CurrentYear + sSearchMark + Chr(39) +
           ' and KindFlag=' + sStockAdjustmentFlag;
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

function TMaintenanceForm.SaveAdjustHeadData(AdjustNo, WarehouseCode: string; TotalCost: double): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Insert Into StockReceiveHead(ReceiveNo, ReferenceNo, ' +
           'ReceiveDate, SupplierCode, Amount, GST, GSTStatus, ' +
           'PaidAmount, Notes, OpName, InvoiceNo, InvoiceDate, Freight, ' +
           'FreightGSTRate, OtherCharge, OtherChargeGSTRate, ' +
           'OtherChargeDescription, KindFlag, Confirmed, ' +
           'WarehouseCode, TransferDateTime) ' +
           'Values(' + Chr(39) + CheckQuotes(AdjustNo) + Chr(39) + ',' +
           'Null' + ',' + ConvertDateTime(Date) + ',' +
           'Null' + ',' + FloatToStr(TotalCost) + ',0,0,0, Null,' +
           Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' + 'Null, Null, 0,0,0,0,Null,' +
           sStockAdjustmentFlag + ', 1, ' + Chr(39) + CheckQuotes(WarehouseCode) + Chr(39) + ',' +
           ConvertDateTime(Date + Time ) + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TMaintenanceForm.SaveAdjustItemData(AdjustNo, ProductCode, WarehouseCode: string;
         AdjustQty, AdjustCost: double; I: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Insert Into StockReceiveItem(ReceiveNo, ProductCode, Qty, Units, Price, ' +
           'Discount, Cost, GSTRate, KindFlag, ID, WarehouseCode, ExpireDate) ' +
           'Values(' + Chr(39) + CheckQuotes(AdjustNo) + Chr(39) + ',' +
           Chr(39) + CheckQuotes(ProductCode) + Chr(39) + ',' +
           FloatToStr(AdjustQty) + ', 0, ' + FloatToStr(AdjustCost) + ', 0.0, ' +
           FloatToStr(AdjustCost) + ', 0.0 ,' + sStockAdjustmentFlag + ',' +
           IntToStr(I) + ',' + Chr(39) + CheckQuotes(WarehouseCode) + Chr(39) + ', Null)';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TMaintenanceForm.ProcessStockBalance: boolean;
var
 SQLStr, FirstAdjustNo, AdjustNo, ProductCode, WarehouseCode: string;
 StockQty, StockValue, StockInQty, StockOutQty, StockInValue,
 StockOutValue, StockTakeQty, StockTakeValue, AdjustQty, AdjustValue,
 AdjustCost, TotalCost: double;
 I, WarehouseCount: integer;
begin
 DataForm.GetWarehouseCode(WarehouseCodeTemp);
 Result := True; WarehouseCount := 1;
 while Result and (WarehouseCount <= 50) do
  begin
   if WarehouseCodeTemp.Code[WarehouseCount] <> '' then
      begin
       WarehouseCode := WarehouseCodeTemp.Code[WarehouseCount];
       Gauge.Progress := 0;
       MakeAdjustmentNo(AdjustNo);
       FirstAdjustNo := AdjustNo;
       SQLStr := 'Select ProductCode, StockQty' + WarehouseCode +
                 ', StockValue' + WarehouseCode + ' From Product ' +
                 'Order By ProductCode';
       OpenQuery(SQLStr);
       with Query do
        begin
         First; I := 1; TotalCost := 0;
         Gauge.MaxValue := RecordCount;
         while Result and NOT EOF do
          begin
           Gauge.Progress := Gauge.Progress + 1;
           ProductCode := FieldByName('ProductCode').AsString;
           StockQty := FieldByName('StockQty' + WarehouseCode).AsFloat;
           StockValue := FieldByName('StockValue' + WarehouseCode).AsFloat;
           SQLStr := 'Select Sum(Qty) As StockOutQty, ' +
                     'Sum(Qty * DeductStockQty * UnitCost) As StockOutValue ' +
                     'From InvoiceItem ' +
                     'Where ProductCode=' + Chr(39) + CheckQuotes(ProductCode) + Chr(39) +
                     ' and WarehouseCode=' + Chr(39) + CheckQuotes(WarehouseCode) + Chr(39) +
                     ' Group By ProductCode';
           OpenTempQuery(SQLStr);
           StockOutQty := TempQuery.FieldByName('StockOutQty').AsFloat;
           StockOutValue := TempQuery.FieldByName('StockOutValue').AsFloat;

           SQLStr := 'Select Sum(Qty + Units / MeasureQty) As StockInQty, ' +
                     'Sum((Qty + Units / MeasureQty) * Cost) As StockInValue ' +
                     'From StockReceiveItem, Product ' +
                     'Where StockReceiveItem.ProductCode=Product.ProductCode and ' +
                     'StockReceiveItem.ProductCode=' + Chr(39) + CheckQuotes(ProductCode) + Chr(39) +
                     ' and (KindFlag<>' + sStockAdjustmentFlag +
                     ' or ReceiveNo < ' + Chr(39) + CheckQuotes(FirstAdjustNo) + Chr(39) +
                     ') and WarehouseCode=' + Chr(39) + CheckQuotes(WarehouseCode) + Chr(39) +
                     ' Group By StockReceiveItem.ProductCode';
           OpenTempQuery(SQLStr);
           StockInQty := TempQuery.FieldByName('StockInQty').AsFloat;
           StockInValue := TempQuery.FieldByName('StockInValue').AsFloat;

           SQLStr := 'Select (Qty + Units / MeasureQty) As Qty, Price, ' +
                     'SysQty, SysPrice ' +
                     'From StockTakeItem, Product ' +
                     'Where StockTakeItem.ProductCode=Product.ProductCode and ' +
                     'StockTakeItem.ProductCode=' + Chr(39) + CheckQuotes(ProductCode) + Chr(39) + ' and ' +
                     'WarehouseCode=' + Chr(39) + CheckQuotes(WarehouseCode) + Chr(39);
           OpenTempQuery(SQLStr);
           StockTakeQty := 0;
           StockTakeValue := 0;
           with TempQuery do
            while Not EOF do
             begin
              StockTakeQty := StockTakeQty + FieldByName('Qty').AsFloat -
                              FieldByName('SysQty').AsFloat;
              StockTakeValue := StockTakeValue +
                FieldByName('Qty').AsFloat * FieldByName('Price').AsFloat -
                FieldByName('SysQty').AsFloat * FieldByName('SysPrice').AsFloat;
              Next;
             end;

           AdjustQty := StockQty + StockOutQty - (StockInQty + StockTakeQty);
           AdjustValue := StockValue + StockOutValue - (StockInValue + StockTakeValue);
           if ABS(AdjustQty) > 0.001 then
               begin
                AdjustCost := Abs(StrToFloat(Format('%4.3f', [AdjustValue / AdjustQty])));
                TotalCost := TotalCost + AdjustQty * AdjustCost;
                Result := SaveAdjustItemData(AdjustNo, ProductCode, WarehouseCode, AdjustQty, AdjustCost, I);
                I := I + 1;
               end;
               
           if I > 300 then
              begin
               Result := SaveAdjustHeadData(AdjustNo, WarehouseCode, TotalCost);
               MakeAdjustmentNo(AdjustNo);
               TotalCost := 0;
               I := 1;
              end;
           if Result and PurchaseOrderCheckBox.Checked then
              Result := DataForm.SetStockOnOrderPro(ProductCode);
           if Result and InternalOrderCheckBox.Checked then
              Result := DataForm.SetStockCommittedPro(ProductCode);
           Next;
          end;
          if Result and (I > 1) then
             Result := SaveAdjustHeadData(AdjustNo, WarehouseCode, TotalCost);
        end;
      end;
    Inc(WarehouseCount);
  end;
end;

function TMaintenanceForm.ClearStockValue: boolean;
var
 SQLStr: string;
 I: integer;
begin
 SQLStr := 'Update Product Set StockOnOrder=0, StockCommitted=0 ';
 DataForm.GetWarehouseCode(WarehouseCodeTemp);
 for I := 1 to 50 do
  if WarehouseCodeTemp.Code[I] <> '' then
     SQLStr := SQLStr + ', StockQty' + WarehouseCodeTemp.Code[I] +
               '=0, StockValue' + WarehouseCodeTemp.Code[I] + '=0';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

procedure TMaintenanceForm.StartButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 if CategoryCheckBox.Checked and Not ProductCheckBox.Checked then
    begin
     MessageBoxForm.MessagePro('Can not delete category because that links to product item table.', sErrorMsg, True);
     Exit;
    end;
 if MessageBoxForm.MessagePro('Are you sure you want to delete the records?', sConfirmMsg, True) = mrNo then
    Exit;
 StartButton.Enabled := False;
 ExitButton.Enabled := False;
 Flag := True;
 if DateCheckBox.Checked then
    begin
     Date1 := TransferDate(DateEdit1.Text);
     Date2 := TransferDate(DateEdit2.Text);
    end;
 Application.ProcessMessages;
 if Not DataForm.BeginTransaction then Exit;
 try
  DataForm.ExecCommand.CommandTimeout := 1800;
  Gauge.MaxValue := 22;
  if TaxInvoiceCheckBox.Checked then
     Flag := ProcessTaxInvoice;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and PointOfSalesInvoiceCheckBox.Checked then
     Flag := ProcessPointOfSalesInvoice;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and ExemptTaxInvoiceCheckBox.Checked then
     Flag := ProcessExemptTaxInvoice;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and InternalOrderCheckBox.Checked then
     Flag := ProcessInternalOrder;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and StockReceiveCheckBox.Checked then
     Flag := ProcessStockReceive;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and StockAdjustmentCheckBox.Checked then
     Flag := ProcessStockAdjustment;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and StockTransferInCheckBox.Checked then
     Flag := ProcessStockTransferIn;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and StockTransferOutCheckBox.Checked then
     Flag := ProcessStockTransferOut;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and PurchaseOrderCheckBox.Checked then
     Flag := ProcessPurchaseOrder;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and CreditNotesCheckBox.Checked then
     Flag := ProcessCreditNotes;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and DebitNotesCheckBox.Checked then
     Flag := ProcessDebitNotes;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and ExpensesCheckBox.Checked then
     Flag := ProcessExpenses;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and StockToWarrantyCheckBox.Checked then
     Flag := ProcessStockToWarranty;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and WarrantyBackToStockCheckBox.Checked then
     Flag := ProcessWarrantyBackToStock;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and StockTakeCheckBox.Checked then
     Flag := ProcessStockTake;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and CategoryCheckBox.Checked then
     Flag := ProcessCategory;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and ProductCheckBox.Checked then
     Flag := ProcessProduct;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and CustomerCheckBox.Checked then
     Flag := ProcessCustomer;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and SupplierCheckBox.Checked then
     Flag := ProcessSupplier;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and LayByCustomerCheckBox.Checked then
     Flag := ProcessLayByCustomer;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and DrawerOpenRecordCheckBox.Checked then
     Flag := ProcessDrawerOpenRecord;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and AttendanceRecordCheckBox.Checked then
     Flag := ProcessAttendanceRecord;
  Gauge.Progress := Gauge.Progress + 1;
  if Flag and StockValueCheckBox.Checked then
     Flag := ProcessStockBalance
    else
     Flag := ClearStockValue;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      StartButton.Visible := False;
      MessageBoxForm.MessagePro('Process successful.', sInformationMsg, True);
     end
    else
     begin
      DataForm.RollBack;
      StartButton.Enabled := True;
      MessageBoxForm.MessagePro('Process Error.', sERRORMsg, True);
     end;
  DataForm.ExecCommand.CommandTimeout := 30;
 end;
 ExitButton.Enabled := True;
 Gauge.Progress := 0;
end;

procedure TMaintenanceForm.IndividualButtonClick(Sender: TObject);
begin
 InvoiceMaintenanceForm.InvoiceMaintenancePro;
end;

procedure TMaintenanceForm.FormShow(Sender: TObject);
begin
 DateCheckBox.Checked := True;
 DeleteAllCheckBox.Checked := False;
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit1.Enabled := True;
 DateEdit2.Enabled := True;
 StockValueCheckBox.Checked := True;
 StockValueCheckBox.Enabled := False;
end;

procedure TMaintenanceForm.MaintenancePro;
begin
 Application.CreateForm(TMaintenanceForm, MaintenanceForm);
 MaintenanceForm.ShowModal;
 MaintenanceForm.Free;
end;

end.
