unit DatabaseTransfer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Gauges, Db, UtilUnit, Variants, Mask, DataUnit,
  ADODB, BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TDatabaseTransferForm = class(TForm)
    CompanyProfileCheckBox: TCheckBox;
    CategoryCheckBox: TCheckBox;
    MenuItemCheckBox: TCheckBox;
    VIPInformationCheckBox: TCheckBox;
    ChartCheckBox: TCheckBox;
    UserCheckBox: TCheckBox;
    SupplierInformationCheckBox: TCheckBox;
    MealPackageCheckBox: TCheckBox;
    PaymentsMethodCheckBox: TCheckBox;
    Gauge: TGauge;
    Label2: TLabel;
    DateEdit1: TMaskEdit;
    DateEdit2: TMaskEdit;
    SalesCheckBox: TCheckBox;
    ExpensesCheckBox: TCheckBox;
    StockCheckBox: TCheckBox;
    BookingCheckBox: TCheckBox;
    DateCheckBox: TCheckBox;
    BankCheckBox: TCheckBox;
    TableNameLabel: TLabel;
    PurchaseCheckBox: TCheckBox;
    CashPayOutCheckBox: TCheckBox;
    TimeEdit1: TMaskEdit;
    TimeEdit2: TMaskEdit;
    TargetQuery: TADOQuery;
    SourceQuery: TADOQuery;
    TargetADOConnection: TADOConnection;
    ExecCommand: TADOCommand;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    SourceServerName: TStaticText;
    SourceDatabaseName: TStaticText;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    ServerNameEdit: TEdit;
    DatabaseNameEdit: TEdit;
    AttendanceCheckBox: TCheckBox;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    PanelDatabasePanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    DataPanel: TbsSkinPanel;
    GaugePanel: TbsSkinPanel;
    StartButton: TXiButton;
    ExitButton: TXiButton;
    CashFloatCheckBox: TCheckBox;
    DeliveryStreetCheckBox: TCheckBox;
    WastageCheckBox: TCheckBox;
    procedure ReadTargetServerName;
    procedure SaveTargetServerName;
    function  ConnectToTargetServer: boolean;
    function  OpenTargetQuery(SQLStr: string): boolean;
    function  OpenSourceQuery(SQLStr: string): boolean;
    function  ExecQueryPro(SQLStr: string): boolean;
    procedure StartButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  TransferCompanyProfile: boolean;
    function  TransferMenuGroupTable: boolean;
    function  TransferItemGroupTable: boolean;
    function  TransferLoyaltyPointsTable: boolean;
    function  TransferCategory: boolean;
    function  TransferSubMenuLinkHead: boolean;
    function  TransferSubMenuLinkDetail: boolean;
    function  TransferMenuItem: boolean;
    function  TransferIngredientsTable: boolean;
    function  TransferMealPackage: boolean;
    function  TransferChart: boolean;
    function  TransferSupplier: boolean;
    function  TransferSupplierMemo: boolean;
    function  TransferVIPInformation: boolean;
    function  TransferDeliveryStreet: boolean;
    function  TransferPaymentMethod: boolean;
    function  TransferUserInformation: boolean;
    function  TransferBankInformation: boolean;
    function  TransferOrderHead: boolean;
    function  TransferOrderItem: boolean;
    function  TransferRecvAcct: boolean;
    function  TransferSalesAndReceipts: boolean;
    function  TransferExpensesHead: boolean;
    function  TransferExpensesDetail: boolean;
    function  TransferExpensesPayment: boolean;
    function  TransferExpensesAndPayment: boolean;
    function  TransferStockHead: boolean;
    function  TransferStockItem: boolean;
    function  TransferStockTable: boolean;
    function  TransferWastageHead: boolean;
    function  TransferWastageItem: boolean;
    function  TransferWastage: boolean;
    function  TransferStockLinkTable: boolean;
    function  TransferInstructionLinkTable: boolean;
    function  TransferTableSet: boolean;
    function  TransferTablePage: boolean;
    function  TransferStockReceive: boolean;
    function  TransferPurchasePayment: boolean;
    function  TransferPurchaseHead: boolean;
    function  TransferPurchaseItem: boolean;
    function  TransferPurchaseOrder: boolean;
    function  TransferBookHead: boolean;
    function  TransferBookingInformation: boolean;
    function  TransferCashPayOut: boolean;
    function  TransferCashFloat: boolean;
    function  TRansferMachineIDTable: boolean;
    function  TransferAttendanceTable: boolean;
    function  TransferDrawerOpenTable: boolean;
    function  TransferVoidReasonTable: boolean;
    procedure DateCheckBoxClick(Sender: TObject);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure TimeEditClick(Sender: TObject);
    procedure TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DatabaseTransferPro;
    procedure ServerNameEditDblClick(Sender: TObject);
    function  GenerateSQLFieldNameStr(TableName: string): string;
    function  GenerateSQLFieldDataStr: string;
  private { Private declarations }
  public  { Public declarations }
  end;

var
  DatabaseTransferForm: TDatabaseTransferForm;

implementation

uses MainMenu, MessageBox, DatePanel, TimePanel, Upgrade, Keyboard;

{$R *.DFM}

function TDatabaseTransferForm.GenerateSQLFieldNameStr(TableName: string): string;
var
 SQLStr: string;
 I: integer;
begin
 SQLStr := 'Insert Into ' + TableName + '(' + SourceQuery.Fields[0].FieldName;
 for I := 1 to SourceQuery.Fields.Count - 1 do
  SQLStr := SQLStr + ',' + SourceQuery.Fields[I].FieldName;
 SQLStr := SQLStr + ') ';
 Result := SQLStr;
end;

function TDatabaseTransferForm.GenerateSQLFieldDataStr: string;
var
 SQLStr: string;
 I: integer;
begin
 SQLStr := 'Values(';

 case SourceQuery.Fields[0].DataType of
  ftString, ftWidestring:
              if SourceQuery.Fields[0].AsString <> '' then
                 SQLStr := SQLStr + Chr(39) + CheckQuotes(SourceQuery.Fields[0].AsString) + Chr(39)
                else
                 SQLStr := SQLStr + 'Null';
  ftSmallint, ftInteger, ftWord:
              SQLStr := SQLStr + IntToStr(SourceQuery.Fields[0].AsInteger);
  ftBoolean: if SourceQuery.Fields[0].AsBoolean then
                SQLStr := SQLStr + '1'
               else
                SQLStr := SQLStr + '0';
  ftFloat:   SQLStr := SQLStr + FloatToStr(SourceQuery.Fields[0].AsFloat);
  ftDateTime: SQLStr := SQLStr + ConvertDateTime(SourceQuery.Fields[0].AsDateTime);
 end;

 for I := 1 to SourceQuery.Fields.Count - 1 do
  case SourceQuery.Fields[I].DataType of
   ftString, ftWidestring: if SourceQuery.Fields[I].AsString <> '' then
                SQLStr := SQLStr + ',' + Chr(39) + CheckQuotes(SourceQuery.Fields[I].AsString) + Chr(39)
               else
                SQLStr := SQLStr + ', Null';
   ftSmallint, ftInteger, ftWord:
               SQLStr := SQLStr + ',' + IntToStr(SourceQuery.Fields[I].AsInteger);
   ftBoolean: if SourceQuery.Fields[I].AsBoolean then
                 SQLStr := SQLStr + ', 1'
                else
                 SQLStr := SQLStr + ', 0';
   ftFloat:   SQLStr := SQLStr + ',' + FloatToStr(SourceQuery.Fields[I].AsFloat);
   ftDateTime: SQLStr := SQLStr + ',' + ConvertDateTime(SourceQuery.Fields[I].AsDateTime);
  end;
 SQLStr := SQLStr + ')';
 Result := SQLStr;
end;

procedure TDatabaseTransferForm.ReadTargetServerName;
var
 FileName, Temp: string;
 F: TextFile;
begin
 FileName := StartDir + 'Target.CFG';
 if Not FileExists(FileName) then
    begin
     ServerNameEdit.Text := '';
     DatabaseNameEdit.Text := '';
    end
   else
    begin
     AssignFile(F, FileName);
     Reset(F);
     Readln(F, Temp);
     ServerNameEdit.Text := Temp;
     Readln(F, Temp);
     DatabaseNameEdit.Text := Temp;
     CloseFile(F);
    end;
end;

procedure TDatabaseTransferForm.SaveTargetServerName;
var
 FileName: string;
 F: TextFile;
begin
 FileName := StartDir + 'Target.CFG';
 AssignFile(F, FileName);
 Rewrite(F);
 Writeln(F, ServerNameEdit.Text);
 Writeln(F, DatabaseNameEdit.Text);
 CloseFile(F);
end;

function TDatabaseTransferForm.ConnectToTargetServer: boolean;
var
 LocalMachineName: string;
begin
 GetLocalMachineName(LocalMachineName);
 Result := True;
 with TargetADOConnection do
  begin
   ConnectionString := 'Provider=SQLOLEDB.1;' +
                       'Integrated Security=SSPI; ' +
                       'Persist Security Info=False; ' +
                       'Initial Catalog=' + DatabaseNameEdit.Text +
                       ';Data Source=' + ServerNameEdit.Text +
                       ';Use Procedure for Prepare=1; ' +
                       'Auto Translate=False; ' +
                       'Packet Size=16384; ' +
                       'Workstation ID=' + LocalMachineName;
   LoginPrompt := False;
   KeepConnection := True;
   try
    Open;
   except
    Result := False;
    MessageBoxForm.MessagePro('Can not find database server, network connection error.', sErrorMsg);
   end;
  end;
end;

function TDatabaseTransferForm.OpenSourceQuery(SQLStr: string): boolean;
begin
 Result := True;
 Screen.Cursor := crHourGlass;
 with SourceQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   except
    Result := False;
   end;
  end;
 Screen.Cursor := crDefault;
end;

function TDatabaseTransferForm.OpenTargetQuery(SQLStr: string): boolean;
begin
 Result := True;
 Screen.Cursor := crHourGlass;
 with TargetQuery do
  begin
   Active := False;
   Connection := TargetADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   except
    Result := False;
   end;
  end;
 Screen.Cursor := crDefault;
end;

function TDatabaseTransferForm.ExecQueryPro(SQLStr: string): boolean;
begin
 Screen.Cursor := crHourGlass;
 Result := True;
 with ExecCommand do
  begin
   Connection := TargetADOConnection;
   CommandText := SQLStr;
   try
    Execute;
   except
    Result := False;
   end;
  end;
 Screen.Cursor := crDefault;
end;

procedure TDatabaseTransferForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TDatabaseTransferForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then ExitButtonClick(Sender);
end;

procedure TDatabaseTransferForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_F3 then StartButtonClick(Sender)
end;

function TDatabaseTransferForm.TransferCompanyProfile: boolean;
var
 SQLStr: string;
begin
 Result := True;
 if Not CompanyProfileCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From Profile');
 if Not Result then Exit;
 Gauge.MaxValue := 1;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLStr := 'Select * From Profile';
 Result := OpenSourceQuery(SQLStr);
 if Result then
    begin
     SQLStr := GenerateSQLFieldNameStr('Profile') + GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
    end;
end;

function TDatabaseTransferForm.TransferMenuGroupTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := ExecQueryPro('Delete From MenuGroupTable');
 if Not Result then Exit;
 SQLStr := 'Select * From MenuGroupTable Order By Code';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('MenuGroupTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferItemGroupTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not MenuItemCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From ItemGroupTable');
 if Not Result then Exit;
 SQLStr := 'Select GroupName From ItemGroupTable Order By GroupName';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('ItemGroupTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferLoyaltyPointsTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 SQLStr := 'Delete From LoyaltyPoints';
 Result := ExecQueryPro(SQLStr);
 if Not Result then Exit;
 SQLStr := 'Select * From LoyaltyPoints';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('LoyaltyPoints');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferCategory: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not CategoryCheckBox.Checked and Not MenuItemCheckBox.Checked and
    Not SalesCheckBox.Checked and Not StockCheckBox.Checked then Exit;
 Result := TransferMenuGroupTable;
 if Result then
    Result := ExecQueryPro('Delete From Category');
 if Not Result then Exit;
 SQLStr := 'Select * From Category';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('Category');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead + GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferSubMenuLinkHead: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not MenuItemCheckBox.Checked and Not SalesCheckBox.Checked and
    Not StockCheckBox.Checked and Not MealPackageCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From SubMenuLinkHead');
 if Not Result then Exit;
 SQLStr := 'Select * From SubMenuLinkHead';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('SubMenuLinkHead');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferSubMenuLinkDetail: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not MenuItemCheckBox.Checked and Not SalesCheckBox.Checked and
    Not StockCheckBox.Checked and Not MealPackageCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From SubMenuLinkDetail');
 if Not Result then Exit;
 SQLStr := 'Select * From SubMenuLinkDetail';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('SubMenuLinkDetail');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferMenuItem: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not MenuItemCheckBox.Checked and Not SalesCheckBox.Checked and
    Not StockCheckBox.Checked and Not MealPackageCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From MenuItem');
 if Not Result then Exit;
 SQLStr := 'Select * From MenuItem';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('MenuItem');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead + GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferIngredientsTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not MenuItemCheckBox.Checked and Not SalesCheckBox.Checked and
    Not StockCheckBox.Checked and Not MealPackageCheckBox.Checked then Exit;

 Result := ExecQueryPro('Delete From IngredientsTable');
 if Not Result then Exit;
 SQLStr := 'Select * From IngredientsTable';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('IngredientsTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferMealPackage: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not MealPackageCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From MealPackage');
 if Not Result then Exit;
 SQLStr := 'Select * From MealPackage';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('MealPackage');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferChart: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not ChartCheckBox.Checked and Not ExpensesCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From Chart');
 if Not Result then Exit;
 SQLStr := 'Select * From Chart';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('Chart');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferSupplier: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not SupplierInformationCheckBox.Checked and Not ExpensesCheckBox.Checked and
    Not PurchaseCheckBox.Checked and Not StockCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From Supplier');
 if Not Result then Exit;
 SQLStr := 'Select * From Supplier';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('Supplier');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferSupplierMemo: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not SupplierInformationCheckBox.Checked and Not ExpensesCheckBox.Checked and
    Not StockCheckBox.Checked and Not PurchaseCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From SupplierMemo');
 if Not Result then Exit;
 SQLStr := 'Select * From SupplierMemo';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('SupplierMemo');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferVIPInformation: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not VIPInformationCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From VIPTable');
 if Not Result then Exit;
 SQLStr := 'Select * From VIPTable';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('VIPTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferDeliveryStreet: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not DeliveryStreetCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From StreetTable');
 if Not Result then Exit;
 SQLStr := 'Select * From StreetTable Order By Street';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('StreetTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferPaymentMethod: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not PaymentsMethodCheckBox.Checked and Not SalesCheckBox.Checked and
    Not StockCheckBox.Checked and Not ExpensesCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From Payment');
 if Not Result then Exit;
 SQLStr := 'Select * From Payment Order By Code';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('Payment');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferBankInformation: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not BankCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From BankHead');
 if Not Result then Exit;
 SQLStr := 'Select * From BankHead';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('BankHead');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferUserInformation: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not UserCheckBox.Checked and Not SalesCheckBox.Checked and
    Not ExpensesCheckBox.Checked and Not PurchaseCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From AccessMenu');
 if Not Result then Exit;
 SQLStr := 'Select * From AccessMenu';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.Progress := 0;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('AccessMenu');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferOrderHead: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From OrderH ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where OrderDate>=' +
               ConvertDateTime(DateTemp1 + StrToTime(TimeEdit1.Text)) +
               ' and OrderDate<=' +
               ConvertDateTime(DateTemp2 + StrToTime(TimeEdit2.Text));
    end;
 SQLStr := SQLStr + ' Order By OrderNo';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('OrderH');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferOrderItem: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From OrderI ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where OrderNo In (Select OrderNo From OrderH Where ' +
               'OrderDate>=' + ConvertDateTime(DateTemp1 + StrToTime(TimeEdit1.Text)) +
               ' and OrderDate<=' + ConvertDateTime(DateTemp2 + StrToTime(TimeEdit2.Text)) + ')';
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('OrderI');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferRecvAcct: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From RecvAcct ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where OrderNo In (Select OrderNo From OrderH ' +
               'Where OrderDate>=' + ConvertDateTime(DateTemp1 + StrToTime(TimeEdit1.Text)) +
               ' and OrderDate<=' + ConvertDateTime(DateTemp2 + StrToTime(TimeEdit2.Text)) + ')';
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('RecvAcct');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferSalesAndReceipts: boolean;
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
 Temp: integer;
begin
 Result := True;
 if Not SalesCheckBox.Checked then Exit;
 SQLStr := 'Select Count(*) From OrderH ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr + 'Where OrderDate>=' + ConvertDateTime(DateTemp1) +
               ' and OrderDate<=' + ConvertDateTime(DateTemp2);
     Result := OpenTargetQuery(SQLStr);
     if Not Result then Exit;
     Temp := TargetQuery.Fields[0].AsInteger;
     TargetQuery.Close;
     if Temp > 0 then
        begin
         SQLStr := 'Delete OrderI From OrderI Inner Join OrderH ' +
                   'On OrderI.OrderNo=OrderH.OrderNo ' +
                   'Where OrderH.OrderDate>=' + ConvertDateTime(DateTemp1) +
                   ' and OrderH.OrderDate<=' + ConvertDateTime(DateTemp2);
         Result := ExecQueryPro(SQLStr);
         if Result then
            begin
             SQLStr := 'Delete RecvAcct From RecvAcct Inner Join OrderH ' +
                       'On RecvAcct.OrderNo=OrderH.OrderNo ' +
                       'Where OrderH.OrderDate>=' + ConvertDateTime(DateTemp1) +
                       ' and OrderH.OrderDate<=' + ConvertDateTime(DateTemp2);
             Result := ExecQueryPro(SQLStr);
            end;
         if Result then
            begin
             SQLStr := 'Delete From OrderH Where OrderDate>=' + ConvertDateTime(DateTemp1) +
                       ' and OrderDate<=' + ConvertDateTime(DateTemp2);
             Result := ExecQueryPro(SQLStr);
            end;
        end;
    end
   else
    begin
     SQLStr := 'Delete From OrderH';
     Result := ExecQueryPro(SQLStr);
     if Result then
        begin
         SQLStr := 'Delete From OrderI';
         Result := ExecQueryPro(SQLStr);
        end;
     if Result then
        begin
         SQLStr := 'Delete From RecvAcct';
         Result := ExecQueryPro(SQLStr);
        end;
    end;
 if Result then Result := TransferOrderHead;
 if Result then Result := TransferOrderItem;
 if Result then Result := TransferRecvAcct;
end;

function TDatabaseTransferForm.TransferExpensesHead: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From Expenses ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where AcctDate>=' + ConvertDateTime(DateTemp1) +
                        ' and AcctDate<=' + ConvertDateTime(DateTemp2);
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('Expenses');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferExpensesDetail: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From ExpDetail ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where SerialNo In (Select SerialNo From Expenses Where AcctDate>=' +
               ConvertDateTime(DateTemp1) +
               ' and AcctDate<=' + ConvertDateTime(DateTemp2) + ')';
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('ExpDetail');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferExpensesPayment: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From ExpAcct ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where SerialNo In (Select SerialNo From Expenses Where AcctDate>=' +
               ConvertDateTime(DateTemp1) +
               ' and AcctDate<=' + ConvertDateTime(DateTemp2) + ')';
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('ExpAcct');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferExpensesAndPayment: boolean;
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
 Temp: integer;
begin
 Result := True;
 if Not ExpensesCheckBox.Checked then Exit;
 SQLStr := 'Select Count(*) From Expenses ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where AcctDate>=' + ConvertDateTime(DateTemp1) +
                        ' and AcctDate<=' + ConvertDateTime(DateTemp2);
     Result := OpenTargetQuery(SQLStr);
     if Not Result then Exit;
     Temp := TargetQuery.Fields[0].AsInteger;
     TargetQuery.Close;
     if Temp > 0 then
        begin
         SQLStr := 'Delete ExpDetail From ExpDetail Inner Join Expenses ' +
                   'On ExpDetail.SerialNo=Expenses.SerialNo ' +
                   'Where Expenses.AcctDate>=' + ConvertDateTime(DateTemp1) +
                   ' and Expenses.AcctDate<=' + ConvertDateTime(DateTemp2);
         Result := ExecQueryPro(SQLStr);
         if Result then
            begin
             SQLStr := 'Delete ExpAcct From ExpAcct Inner Join Expenses ' +
                       'On Expenses.SerialNo=ExpAcct.SerialNo ' +
                       'Where Expenses.AcctDate>=' + ConvertDateTime(DateTemp1) +
                       ' and Expenses.AcctDate<=' + ConvertDateTime(DateTemp2);
             Result := ExecQueryPro(SQLStr);
            end;
         if Result then
            begin
             SQLStr := 'Delete From Expenses Where AcctDate>=' + ConvertDateTime(DateTemp1) +
                       ' and AcctDate<=' + ConvertDateTime(DateTemp2);
             Result := ExecQueryPro(SQLStr);
            end;
        end;
    end
   else
    begin
     SQLStr := 'Delete From Expenses';
     Result := ExecQueryPro(SQLStr);
     if Result then
        begin
         SQLStr := 'Delete From ExpDetail';
         Result := ExecQueryPro(SQLStr);
        end;
     if Result then
        begin
         SQLStr := 'Delete From ExpAcct';
         Result := ExecQueryPro(SQLStr);
        end;
    end;
 if Result then Result := TransferExpensesHead;
 if Result then Result := TransferExpensesDetail;
 if Result then Result := TransferExpensesPayment;
end;

function TDatabaseTransferForm.TransferStockHead: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From StockH ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where ReceiveDate>=' + ConvertDateTime(DateTemp1) +
                        ' and ReceiveDate<=' + ConvertDateTime(DateTemp2);
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('StockH');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferStockItem: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From StockI ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where ReceiveNo In (Select ReceiveNo From StockH Where ReceiveDate>=' +
               ConvertDateTime(DateTemp1) +
               ' and ReceiveDate<=' +
               ConvertDateTime(DateTemp2) + ')';
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('StockI');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferPurchasePayment: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From PayAcct ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where ReceiveNo In (Select ReceiveNo From StockH Where ReceiveDate>=' +
               ConvertDateTime(DateTemp1) +
               ' and ReceiveDate<=' + ConvertDateTime(DateTemp2) + ')';
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('PayAcct');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferStockReceive: boolean;
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
 Temp: integer;
begin
 Result := True;
 if Not StockCheckBox.Checked then Exit;
 SQLStr := 'Select Count(*) From StockH ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where ReceiveDate>=' + ConvertDateTime(DateTemp1) +
                        ' and ReceiveDate<=' + ConvertDateTime(DateTemp2);
     Result := OpenTargetQuery(SQLStr);
     if Not Result then Exit;
     Temp := TargetQuery.Fields[0].ASInteger;
     TargetQuery.Close;
     if Temp > 0 then
        begin
         SQLStr := 'Delete StockI From StockI Inner Join StockH On StockH.ReceiveNo=StockI.ReceiveNo ' +
                   'Where ReceiveDate>=' + ConvertDateTime(DateTemp1) +
                   ' and ReceiveDate<=' + ConvertDateTime(DateTemp2);
         Result := ExecQueryPro(SQLStr);
         if Result then
            begin
             SQLStr := 'Delete PayAcct From PayAcct Inner Join StockH On StockH.ReceiveNo=PayAcct.ReceiveNo ' +
                       'Where ReceiveDate>=' + ConvertDateTime(DateTemp1) +
                       ' and ReceiveDate<=' + ConvertDateTime(DateTemp2);
             Result := ExecQueryPro(SQLStr);
            end;
         if Result then
            begin
             SQLStr := 'Delete From StockH Where ReceiveDate>=' + ConvertDateTime(DateTemp1) +
                       ' and ReceiveDate<=' + ConvertDateTime(DateTemp2);
             Result := ExecQueryPro(SQLStr);
            end;
        end;
    end
   else
    begin
     SQLStr := 'Delete From StockH';
     Result := ExecQueryPro(SQLStr);
     if Result then
        begin
         SQLStr := 'Delete From StockI';
         Result := ExecQueryPro(SQLStr);
        end;
     if Result then
        begin
         SQLStr := 'Delete From PayAcct';
         Result := ExecQueryPro(SQLStr);
        end;
    end;
 if Result then Result := TransferStockHead;
 if Result then Result := TransferStockItem;
 if Result then Result := TransferPurchasePayment;
end;

function TDatabaseTransferForm.TransferWastageHead: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From WastageHead ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr + 'Where WastageDate>=' + ConvertDateTime(DateTemp1) +
                        ' and WastageDate<=' + ConvertDateTime(DateTemp2);
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('WastageHead');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferWastageItem: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From WastageItem ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr + 'Where WastageNo In (Select WastageNo From WastageHead ' +
                        'Where WastageDate>=' + ConvertDateTime(DateTemp1) +
                        ' and WastageDate<=' + ConvertDateTime(DateTemp2) + ')';
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('WastageItem');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferWastage: boolean;
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
 Temp: integer;
begin
 Result := True;
 if Not WastageCheckBox.Checked then Exit;
 SQLStr := 'Select Count(*) From WastageHead ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr + 'Where WastageDate>=' + ConvertDateTime(DateTemp1) +
                        ' and WastageDate<=' + ConvertDateTime(DateTemp2);
     Result := OpenTargetQuery(SQLStr);
     if Not Result then Exit;
     Temp := TargetQuery.Fields[0].ASInteger;
     TargetQuery.Close;
     if Temp > 0 then
        begin
         SQLStr := 'Delete WastageItem From WastageItem Inner Join WastageHead On ' +
                   'WastageHead.WastageNo=WastageItem.WastageNo ' +
                   'Where WastageDate>=' + ConvertDateTime(DateTemp1) +
                   ' and WastageDate<=' + ConvertDateTime(DateTemp2);
         Result := ExecQueryPro(SQLStr);
         if Result then
            begin
             SQLStr := 'Delete From StockH Where WastageDate>=' + ConvertDateTime(DateTemp1) +
                       ' and WastageDate<=' + ConvertDateTime(DateTemp2);
             Result := ExecQueryPro(SQLStr);
            end;
        end;
    end
   else
    begin
     SQLStr := 'Delete From WastageHead';
     Result := ExecQueryPro(SQLStr);
     if Result then
        begin
         SQLStr := 'Delete From WastageItem';
         Result := ExecQueryPro(SQLStr);
        end;
    end;
 if Result then Result := TransferWastageHead;
 if Result then Result := TransferWastageItem;
end;

function TDatabaseTransferForm.TransferStockTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not MenuItemCheckBox.Checked and Not SalesCheckBox.Checked and
    Not StockCheckBox.Checked and Not BookingCheckBox.Checked and
    Not MealPackageCheckBox.Checked and PurchaseCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From StockTable');
 if Not Result then Exit;
 SQLStr := 'Select * From StockTable';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('StockTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferStockLinkTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not MenuItemCheckBox.Checked and Not SalesCheckBox.Checked and
    Not StockCheckBox.Checked and Not MealPackageCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From StockLinkTable');
 if Not Result then Exit;
 SQLStr := 'Select * From StockLinkTable';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('StockLinkTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferTableSet: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := ExecQueryPro('Delete From TableSet');
 if Not Result then Exit;
 SQLStr := 'Select * From TableSet';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('TableSet');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferTablePage: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := ExecQueryPro('Delete From TablePage');
 if Not Result then Exit;
 SQLStr := 'Select * From TablePage';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('TablePage');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferInstructionLinkTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not MenuItemCheckBox.Checked then Exit;
 Result := ExecQueryPro('Delete From InstructionLink');
 if Not Result then Exit;
 SQLStr := 'Select * From InstructionLink';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('InstructionLink');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferBookHead: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From BookTable ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where RecordDate>=' + ConvertDateTime(DateTemp1 + StrToTime(TimeEdit1.Text)) +
                        ' and RecordDate<=' + ConvertDateTime(DateTemp2 + StrToTime(TimeEdit2.Text));
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('BookTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferBookingInformation: boolean;
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
 Temp: integer;
begin
 Result := True;
 if Not BookingCheckBox.Checked then Exit;
 SQLStr := 'Select Count(*) From BookTable ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr + 'Where RecordDate>=' + ConvertDateTime(DateTemp1) +
                        ' and RecordDate<=' + ConvertDateTime(DateTemp2);
     Result := OpenTargetQuery(SQLStr);
     if Not Result then Exit;
     Temp := TargetQuery.Fields[0].AsInteger;
     TargetQuery.Close;
     if Temp > 0 then
        begin
         SQLStr := 'Delete From BookTable Where RecordDate>=' + ConvertDateTime(DateTemp1) +
                   ' and RecordDate<=' + ConvertDateTime(DateTemp2);
         Result := ExecQueryPro(SQLStr);
        end;
    end
   else
    begin
     SQLStr := 'Delete From BookTable';
     Result := ExecQueryPro(SQLStr);
    end;
 if Result then Result := TransferBookHead;
end;

function TDatabaseTransferForm.TransferPurchaseHead: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From PurchaseHead ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where PurchaseDate>=' + ConvertDateTime(DateTemp1) +
                        ' and PurchaseDate<=' + ConvertDateTime(DateTemp2);
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('PurchaseHead');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferPurchaseItem: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select * From PurchaseItem ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where PurchaseNo In (Select PurchaseNo ' +
               'From PurchaseHead Where PurchaseDate>=' +
               ConvertDateTime(DateTemp1) +
               ' and PurchaseDate<=' +
               ConvertDateTime(DateTemp2) + ')';
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('PurchaseItem');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferPurchaseOrder: boolean;
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
 Temp: integer;
begin
 Result := True;
 if Not PurchaseCheckBox.Checked then Exit;
 SQLStr := 'Select Count(*) From PurchaseHead ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     SQLStr := SQLStr + 'Where PurchaseDate>=' + ConvertDateTime(DateTemp1) +
                        ' and PurchaseDate<=' + ConvertDateTime(DateTemp2);
     Result := OpenTargetQuery(SQLStr);
     if Not Result then Exit;
     Temp := TargetQuery.Fields[0].AsInteger;
     TargetQuery.Close;
     if Temp > 0 then
        begin
         SQLStr := 'Delete PurchaseItem From PurchaseItem Inner Join PurchaseHead ' +
                   'On PurchaseHead.PurchaseNo=PurchaseItem.PurchaseNo ' +
                   'Where PurchaseDate>=' + ConvertDateTime(DateTemp1) +
                    ' and PurchaseDate<=' + ConvertDateTime(DateTemp2);
         Result := ExecQueryPro(SQLStr);
         if Result then
            begin
             SQLStr := 'Delete From PurchaseHead ' +
                       'Where PurchaseDate>=' + ConvertDateTime(DateTemp1) +
                       ' and PurchaseDate<=' + ConvertDateTime(DateTemp2);
             Result := ExecQueryPro(SQLStr);
            end;
        end;
    end
   else
    begin
     SQLStr := 'Delete From PurchaseHead';
     Result := ExecQueryPro(SQLStr);
     if Result then
        begin
         SQLStr := 'Delete From PurchaseItem';
         Result := ExecQueryPro(SQLStr);
        end;
    end;
 if Result then Result := TransferPurchaseHead;
 if Result then Result := TransferPurchaseItem;
end;

function TDatabaseTransferForm.TransferCashPayOut: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
 Temp: integer;
begin
 Result := True;
 if Not CashPayOutCheckBox.Checked then Exit;
 SQLStr := 'Select Count(*) From PayOutTable ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr + 'Where PaymentDate>=' + ConvertDateTime(DateTemp1) +
                        ' and PaymentDate<=' + FloatToStr(DateTemp2);
     Result := OpenTargetQuery(SQLStr);
     if Not Result then Exit;
     Temp := TargetQuery.Fields[0].AsInteger;
     TargetQuery.Close;
     if Temp > 0 then
        begin
         SQLStr := 'Delete From PayOutTable ' +
                   'Where PaymentDate>=' + ConvertDateTime(DateTemp1) +
                   ' and PaymentDate<=' + ConvertDateTime(DateTemp2);
         Result := ExecQueryPro(SQLStr);
        end;
    end
   else
    begin
     SQLStr := 'Delete From PayOutTable';
     Result := ExecQueryPro(SQLStr);
    end;
 if Not Result then Exit;
 SQLStr := 'Select * From PayOutTable ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr + 'Where PaymentDate>=' + ConvertDateTime(DateTemp1) +
                        ' and PaymentDate<=' + ConvertDateTime(DateTemp2);
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('PayOutTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferCashFloat: boolean;
var
 SQLStr, SQLHead: string;
 DateTemp1, DateTemp2: TDateTime;
 Temp: integer;
begin
 Result := True;
 if Not CashFloatCheckBox.Checked then Exit;
 SQLStr := 'Select Count(*) From CashFloatTable ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr + 'Where OpDate>=' + ConvertDateTime(DateTemp1) +
                        ' and OpDate<=' + FloatToStr(DateTemp2);
     Result := OpenTargetQuery(SQLStr);
     if Not Result then Exit;
     Temp := TargetQuery.Fields[0].AsInteger;
     TargetQuery.Close;
     if Temp > 0 then
        begin
         SQLStr := 'Delete From CashFloatTable ' +
                   'Where OpDate>=' + ConvertDateTime(DateTemp1) +
                   ' and OpDate<=' + ConvertDateTime(DateTemp2);
         Result := ExecQueryPro(SQLStr);
        end;
    end
   else
    begin
     SQLStr := 'Delete From CashFloatTable';
     Result := ExecQueryPro(SQLStr);
    end;
 if Not Result then Exit;
 SQLStr := 'Select * From CashFloatTable ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr + 'Where OpDate>=' + ConvertDateTime(DateTemp1) +
                        ' and OpDate<=' + ConvertDateTime(DateTemp2);
    end;
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('CashFloatTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferMachineIDTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 SQLStr := 'Delete From MachineID';
 Result := ExecQueryPro(SQLStr);
 if Not Result then Exit;
 SQLStr := 'Select * From MachineID';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('MachineID');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferAttendanceTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 Result := True;
 if Not AttendanceCheckBox.Checked then Exit;
 SQLStr := 'Delete From Attendance';
 Result := ExecQueryPro(SQLStr);
 if Not Result then Exit;
 SQLStr := 'Select * From Attendance ';
 Result := OpenSourceQuery(SQLStr);
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('Attendance');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferDrawerOpenTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 SQLStr := 'Delete From DrawerCounter';
 Result := ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Select * From DrawerCounter Order By OpenDate';
     Result := OpenSourceQuery(SQLStr);
    end;
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('DrawerCounter');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

function TDatabaseTransferForm.TransferVoidReasonTable: boolean;
var
 SQLStr, SQLHead: string;
begin
 SQLStr := 'Delete From VoidReasonTable';
 Result := ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Select * From VoidReasonTable';
     Result := OpenSourceQuery(SQLStr);
    end;
 if Not Result then Exit;
 Gauge.MaxValue := SourceQuery.RecordCount;
 Gauge.Progress := 0;
 Application.ProcessMessages;
 SQLHead := GenerateSQLFieldNameStr('VoidReasonTable');
 with SourceQuery do
  begin
   while Not EOF and Result do
    begin
     SQLStr := SQLHead +  GenerateSQLFieldDataStr;
     Result := ExecQueryPro(SQLStr);
     Gauge.Progress := Gauge.Progress + 1;
     Next;
    end;
   Close;
  end;
end;

procedure TDatabaseTransferForm.StartButtonClick(Sender: TObject);
var
 Flag : Boolean;
begin
 if ServerNameEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Server Name is invalid.', sErrorMsg);
     Exit;
    end;
 if DatabaseNameEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Database Name is invalid.', sErrorMsg);
     Exit;
    end;
 if (Uppercase(sDatabaseName) = Uppercase(DatabaseNameEdit.Text)) and
    (Uppercase(sServerName) = UpperCase(ServerNameEdit.Text)) then
    begin
     MessageBoxForm.MessagePro('Database Name or Server Name is invalid.', sErrorMsg);
     Exit;
    end;
 if Not ConnectToTargetServer then
    begin
     MessageBoxForm.MessagePro('Can not find Server or Database.', sErrorMsg);
     Exit;
    end;
 UpgradeForm.UpgradePro(TargetADOConnection);
 Flag := True;
 try
  TableNameLabel.Caption := 'Table: Profile';
  Flag := TransferCompanyProfile;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: MachineID';
      Flag := TransferMachineIDTable;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Attendance';
      Flag := TransferAttendanceTable;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Category';
      Flag := TransferCategory;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Menu Items';
      Flag := TransferMenuItem;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Item Group';
      Flag := TransferItemGroupTable;
     end; 
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Ingredients';
      Flag := TransferIngredientsTable;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Stock Items';
      Flag := TransferStockTable;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Stock Wastage';
      Flag := TransferWastage;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Stock Link';
      Flag := TransferStockLinkTable;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Instruction Link';
      Flag := TransferInstructionLinkTable;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Sub Menu Link';
      Flag := TransferSubMenuLinkHead;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Sub Menu Link';
      Flag := TransferSubMenuLinkDetail;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Table Set';
      Flag := TransferTableSet;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Table Page';
      Flag := TransferTablePage;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Meal Package';
      Flag := TransferMealPackage;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Chart Of Account';
      Flag := TransferChart;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Supplier';
      Flag := TransferSupplier;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Supplier';
      Flag := TransferSupplierMemo;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: VIP Information';
      Flag := TransferVIPInformation;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Delivery Street Database';
      Flag := TransferDeliveryStreet;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Payment Methods';
      Flag := TransferPaymentMethod;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: User Information';
      Flag := TransferUserInformation;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Bank Information';
      Flag := TransferBankInformation;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Sales and Receipts';
      Flag := TransferSalesAndReceipts;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Expenses and Payments';
      Flag := TransferExpensesAndPayment;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Stock Receive';
      Flag := TransferStockReceive;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Purchase Order';
      Flag := TransferPurchaseOrder;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Reservation';
      Flag := TransferBookingInformation;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Cash Pay Out';
      Flag := TransferCashPayOut;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Cash Float';
      Flag := TransferCashFloat;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Drawer Counter';
      Flag := TransferDrawerOpenTable;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Void Reason Table';
      Flag := TransferVoidReasonTable;
     end;
  if Flag then
     begin
      TableNameLabel.Caption := 'Table: Loyalty Points Table';
      Flag := TransferLoyaltyPointsTable;
     end;
 finally
  if Flag then
    begin
     TableNameLabel.Caption := '';
     MessageBoxForm.MessagePro('Data has been transfered successfully.', sInformationMsg);
     Gauge.Progress := 0;
     SaveTargetServerName;
    end
   else
    MessageBoxForm.MessagePro('Data transfer failure.', sInformationMsg);
  TargetADOConnection.Close;
 end;
end;

procedure TDatabaseTransferForm.DateCheckBoxClick(Sender: TObject);
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

procedure TDatabaseTransferForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit1.SetFocus
end;

procedure TDatabaseTransferForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit2.SetFocus;
end;

procedure TDatabaseTransferForm.DateEdit1Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit1.Text) then DateEdit1.SetFocus;
end;

procedure TDatabaseTransferForm.DateEdit2Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit2.Text) then DateEdit2.SetFocus;
end;

procedure TDatabaseTransferForm.DateEditClick(Sender: TObject);
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

procedure TDatabaseTransferForm.TimeEditClick(Sender: TObject);
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

procedure TDatabaseTransferForm.TimeEdit1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TDatabaseTransferForm.TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SalesCheckBox.SetFocus;
end;

procedure TDatabaseTransferForm.ServerNameEditDblClick(Sender: TObject);
var
 Temp: string;
begin
 if KeyboardForm.KeyboardPro(Temp) then
    with Sender As TEdit do
     Text := Uppercase(Temp);
end;

procedure TDatabaseTransferForm.FormShow(Sender: TObject);
begin
 Width := PanelDatabasePanel.Width + 28;
 Height := StartButton.Top + 86;
 SourceServerName.Caption := sServerName;
 SourceDatabaseName.Caption := sDatabaseName;
 ReadTargetServerName;
 DateCheckBox.Checked := True;
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
 TableNameLabel.Caption := '';
end;

procedure TDatabaseTransferForm.DatabaseTransferPro;
begin
 Application.CreateForm(TDatabaseTransferForm, DatabaseTransferForm);
 DatabaseTransferForm.ShowModal;
 DatabaseTransferForm.Free;
end;

end.
