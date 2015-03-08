unit Upgrade;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, UtilUnit, ADODB, XiButton;

type
  TUpgradeForm = class(TDataModule)
    Query: TADOQuery;
    ExecCommand: TADOCommand;
    TempQuery: TADOQuery;
    function  OpenQuery(SQLStr: string): boolean;
    procedure OpenTempQuery(SQLStr: string);
    function  ExecQueryPro(SQLStr: string): boolean;
    function  TestVersionPro(var CurrentVersion: double): boolean;
    procedure DropIndex;
    procedure RebuildIndex;
    procedure CreateButtonsTable;
    procedure CreateButtonsTablePro;
    procedure CreateTransactionLogTablePro;
    procedure CreateDiscountRateTablePro;
    procedure CreateStreetTablePro;
    procedure CreateDepartmentTablePro;
    procedure CreateDepositTablePro;
    procedure CreatePointsPaymentTablePro;
    procedure CreateSubMenuLinkTablePro;
    procedure CreateMenuGroupTablePro;
    procedure CreateVoidReasonTablePro;
    procedure CreateTablePagePro;
    procedure DeleteOldKitchenScreenTablePro;
    procedure CreateKitchenScreenTablePro;
    procedure CreateWastageHeadTablePro;
    procedure CreateWastageItemTablePro;
    procedure CreateHoldHeadTablePro;
    procedure CreateHoldItemTablePro;
    procedure CreateMachineIDTablePro;
    procedure CreateIngredientsTablePro;
    procedure CreateDrawerCounterTablePro;
    procedure CreatePayOutTablePro;
    procedure CreateCashFloatTablePro;
    procedure CreateStockTablePro;
    procedure CreateExpDetailTablePro;
    procedure CreatePurchaseTablePro;
    procedure CreatePurchasePayableTablePro;
    procedure CreateInstructionTablePro;
    procedure CreateBankTablePro;
    procedure DeletePrintJobListTablePro;
    procedure UpgradeTableSetPro;
    procedure CreateAttendanceTablePro;
    procedure UpgradePaymentMethodPro;
    procedure UpgradeExpAcctTablePro;
    procedure UpgradeExpensesTablePro;
    procedure UpdateInstructionLinkTable;
    procedure UpgradeAccessMenuTablePro;
    procedure UpgradeMenuTablePro;
    procedure UpgradeOrderHTablePro;
    procedure UpgradeOrderITablePro;
    procedure UpgradeMealPackageTablePro;
    procedure UpgradeBookHeadTablePro;
    procedure UpgradeBookItemTablePro;
    procedure UpgradeMenuItemTablePro;
    procedure UpgradeProfileTablePro;
    procedure UpgradeRecvAcctTablePro;
    procedure UpgradeCategoryTablePro;
    procedure UpgradeChartTablePro;
    procedure UpgradeStockHTablePro;
    procedure UpgradeStockITablePro;
    procedure UpgradeVIPTablePro;
    procedure UpgradeSupplierTablePro;
    procedure UpdateCharTonvarchar;
    procedure UpdateVersionPro;
    procedure UpgradePro(DatabaseConnection: TADOConnection);
    procedure UpgradeButtonTablePro;
  private { Private declarations }
    DatabaseConnection: TADOConnection;
  public
    { Public declarations }
  end;

var
  UpgradeForm: TUpgradeForm;

implementation

uses DataUnit, DisplayMessage;

{$R *.DFM}

function TUpgradeForm.OpenQuery(SQLStr: string): boolean;
begin
 Screen.Cursor := crHourGlass;
 Result := True;
 with Query do
  begin
   Active := False;
   Connection := DatabaseConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   except
    Result := False;
   end;
   Screen.Cursor := crDefault;
  end;
end;

procedure TUpgradeForm.OpenTempQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with TempQuery do
  begin
   Active := False;
   Connection := DatabaseConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

function TUpgradeForm.ExecQueryPro(SQLStr: string): boolean;
begin
 Screen.Cursor := crHourGlass;
 Result := True;
 with ExecCommand do
  begin
   Connection := DatabaseConnection;
   CommandText := SQLStr;
   try
    Execute;
   except
    Result := False;
   end;
  end;
 Screen.Cursor := crDefault;
end;

function TUpgradeForm.TestVersionPro(var CurrentVersion: double): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'Version' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table Version(Version Float)';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Version Set Version=' + sVersion;
     ExecQueryPro(SQLStr);
     CurrentVersion := StrToFloat(sVersion);
     Result := True;
    end
   else
    begin
     SQLStr := 'Select * From Version';
     OpenQuery(SQLStr);
     CurrentVersion := Query.FieldByName('Version').AsFloat;
     if StrToFloat(sVersion) - CurrentVersion >= 0.009 then
        Result := True
       else
        Result := False;
    end;
 Query.Close;
end;

procedure TUpgradeForm.UpdateVersionPro;
var
 SQLStr: string;
begin
 SQLStr := 'Update Version Set Version=' + sVersion;
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.DropIndex;
var
 SQLStr: string;
begin
 SQLStr := 'Select sysobjects.ID, sysobjects.Name As TableName, sysindexes.Name As IdxName ' +
           'From sysobjects, sysindexes ' +
           'Where sysobjects.xType= ' + Chr(39) + 'U' + Chr(39) + ' and ' +
           'sysobjects.ID=sysindexes.ID and sysindexes.impid=0 and ' +
           'sysindexes.Name Not Like ' + Chr(39) + '_WA_Sys_%' + Chr(39) + ' and ' +
           'sysobjects.Name <> ' + Chr(39) + 'dtproperties' + Chr(39) + ' and ' +
           'sysobjects.Name <> ' + Chr(39) + 'sysdiagrams' + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   while Not Eof do
    begin
     SQLStr := 'Drop Index ' + FieldByName('TableName').AsString + '.' + FieldByName('IdxName').AsString;
     ExecQueryPro(SQLStr);
     Next;
    end;
  end;
end;

procedure TUpgradeForm.RebuildIndex;
var
 SQLStr: string;
begin
 // AccessMenu
 SQLStr := 'Create Index StaffName On AccessMenu(StaffName)';
 ExecQueryPro(SQLStr);

 // Attendance
 SQLStr := 'Create Index IDNo On Attendance(IDNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index LoginTime On Attendance(LoginTime)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index LogoutTime On Attendance(LogoutTime)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index StaffName On Attendance(StaffName)';
 ExecQueryPro(SQLStr);

 // BankTransaction
 SQLStr := 'Create Index AccountNo On BankTransaction(AccountNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index AcctDate On BankTransaction(AcctDate)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index IDNo On BankTransaction(IDNo)';
 ExecQueryPro(SQLStr);

 // BookDetail
 SQLStr := 'Create Index BookingNo On BookDetail(BookingNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On BookDetail(ItemCode)';
 ExecQueryPro(SQLStr);

 // BookTable
 SQLStr := 'Create Index BookingNo On BookTable(BookingNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index BookingDate On BookTable(BookingDate)';
 ExecQueryPro(SQLStr);

 // CashFloatTable
 SQLStr := 'Create Index OpDate On CashFloatTable(OpDate)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OpName On CashFloatTable(OpName)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ID On CashFloatTable(ID)';
 ExecQueryPro(SQLStr);

 // Category
 SQLStr := 'Create Index Category On Category(Category)';
 ExecQueryPro(SQLStr);

 // Chart
 SQLStr := 'Create Index AccountNo On Chart(AccountNo)';
 ExecQueryPro(SQLStr);

 // DepositTable
 SQLStr := 'Create Index VIPNo On DepositTable(VIPNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index DepositDate On DepositTable(DepositDate)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ID On DepositTable(ID)';
 ExecQueryPro(SQLStr);

 // DrawerCounter
 SQLStr := 'Create Index MachineID On DrawerCounter(MachineID)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OpenDate On DrawerCounter(OpenDate)';
 ExecQueryPro(SQLStr);

 // ExpAcct
 SQLStr := 'Create Index AcctDate On ExpAcct(AcctDate)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SerialNo On ExpAcct(SerialNo)';
 ExecQueryPro(SQLStr);

 // ExpDetail
 SQLStr := 'Create Index SerialNo On ExpDetail(SerialNo)';
 ExecQueryPro(SQLStr);

 // Expenses
 SQLStr := 'Create Index AccountNo On Expenses(AccountNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index AcctDate On Expenses(AcctDate)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SupplierCode On Expenses(SupplierCode)';
 ExecQueryPro(SQLStr);

 // IngredientsTable
 SQLStr := 'Create Index ItemCode On IngredientsTable(ItemCode)';
 ExecQueryPro(SQLStr);

 // InstructionLink
 SQLStr := 'Create Index Code On InstructionLink(Code)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On InstructionLink(ItemCode)';
 ExecQueryPro(SQLStr);

 // ItemGroupTable
 SQLStr := 'Create Index GroupName On ItemGroupTable(GroupName)';
 ExecQueryPro(SQLStr);

 // KitchenScreen
 SQLStr := 'Create Index OrderNo On KitchenScreen(OrderNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On KitchenScreen(ItemCode)';
 ExecQueryPro(SQLStr);

 // LoyaltyPoints
 SQLStr := 'Create Index VIPNo On LoyaltyPoints(VIPNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OrderNo On LoyaltyPoints(OrderNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OrderDate On LoyaltyPoints(OrderDate)';
 ExecQueryPro(SQLStr);

 // MealPackage
 SQLStr := 'Create Index ID On MealPackage(ID)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On MealPackage(ItemCode)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index IDNo On MealPackage(IDNo)';
 ExecQueryPro(SQLStr);

 // MenuGroupTable
 SQLStr := 'Create Index Code On MenuGroupTable(Code)';
 ExecQueryPro(SQLStr);

 // MenuItem
 SQLStr := 'Create Index ItemCode On MenuItem(ItemCode)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index Category On MenuItem(Category)';
 ExecQueryPro(SQLStr);

 // OrderH
 SQLStr := 'Create Index OrderNo On OrderH(OrderNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OrderDate On OrderH(OrderDate)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index InvoiceNo On OrderH(InvoiceNo)';
 ExecQueryPro(SQLStr);

 // OrderI
 SQLStr := 'Create Index OrderNo On OrderI(OrderNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On OrderI(ItemCode)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index IDNo On OrderI(IDNo)';
 ExecQueryPro(SQLStr);

 // PayAcct
 SQLStr := 'Create Index ReceiveNo On PayAcct(ReceiveNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index AccountDate On PayAcct(AccountDate)';
 ExecQueryPro(SQLStr);

 // PayOutTable
 SQLStr := 'Create Index PaymentDate On PayOutTable(PaymentDate)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ID On PayOutTable(ID)';
 ExecQueryPro(SQLStr);

 // PurchaseHead
 SQLStr := 'Create Index PurchaseNo On PurchaseHead(PurchaseNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index PurchaseDate On PurchaseHead(PurchaseDate)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SupplierCode On PurchaseHead(SupplierCode)';
 ExecQueryPro(SQLStr);

 // PurchaseItem
 SQLStr := 'Create Index PurchaseNo On PurchaseItem(PurchaseNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index Code On PurchaseItem(Code)';
 ExecQueryPro(SQLStr);

 // RecvAcct
 SQLStr := 'Create Index AccountDate On RecvAcct(AccountDate)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OrderNo On RecvAcct(OrderNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index IDNo On RecvAcct(IDNo)';
 ExecQueryPro(SQLStr);

 // StockH
 SQLStr := 'Create Index ReceiveNo On StockH(ReceiveNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ReceiveDate On StockH(ReceiveDate)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SupplierCode On StockH(SupplierCode)';
 ExecQueryPro(SQLStr);

 // StockI
 SQLStr := 'Create Index ReceiveNo On StockI(ReceiveNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index Code On StockI(Code)';
 ExecQueryPro(SQLStr);

 // StockLinkTable
 SQLStr := 'Create Index ItemCode On StockLinkTable(ItemCode)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index Code On StockLinkTable(Code)';
 ExecQueryPro(SQLStr);

 // StockTable
 SQLStr := 'Create Index Code On StockTable(Code)';
 ExecQueryPro(SQLStr);

 // StreetTable
 SQLStr := 'Create Index Street On StreetTable(Street)';
 ExecQueryPro(SQLStr);

 // SubMenuLink
 SQLStr := 'Create Index ItemCode On SubMenuLinkHead(ItemCode)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On SubMenuLinkDetail(ItemCode)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SubMenuCode On SubMenuLinkDetail(SubMenuCode)';
 ExecQueryPro(SQLStr);

 // Supplier
 SQLStr := 'Create Index SupplierCode On Supplier(SupplierCode)';
 ExecQueryPro(SQLStr);

 // SupplierMemo
 SQLStr := 'Create Index SupplierCode On SupplierMemo(SupplierCode)';
 ExecQueryPro(SQLStr);

 // TablePage
 SQLStr := 'Create Index PageNo On TablePage(PageNo)';
 ExecQueryPro(SQLStr);

 // TableSet
 SQLStr := 'Create Index TableNo On TableSet(TableNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index PageFlag On TableSet(PageFlag)';
 ExecQueryPro(SQLStr);

 // VIPTable
 SQLStr := 'Create Index VIPNo On VIPTable(VIPNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index VIPName On VIPTable(VIPName)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SerialNo On VIPTable(SerialNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index Telephone On VIPTable(Telephone)';
 ExecQueryPro(SQLStr);

 // VoidReasonTable
 SQLStr := 'Create Index Code On VoidReasonTable(Code)';
 ExecQueryPro(SQLStr);

 // WastageHead
 SQLStr := 'Create Index WastageNo On WastageHead(WastageNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index WastageDate On WastageHead(WastageDate)';
 ExecQueryPro(SQLStr);

 // WastageItem
 SQLStr := 'Create Index WastageNo On WastageItem(WastageNo)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On WastageItem(ItemCode)';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.CreateButtonsTable;
var
 SQLStr: string;
begin
 SQLStr := 'Create Table ButtonsTable(' +
           'ButtonName nvarchar(255) Null, ' +
           'Position Integer Null, ' +
           'ButtonSize Integer Null, ' +
           'ButtonColor Integer Null, ' +
           'Caption nvarchar(255) Null, ' +
           'FontName nvarchar(255) Null, ' +
           'FontSize Integer Null, ' +
           'FontBold Bit Null, ' +
           'FontItalic Bit Null, ' +
           'FontUnderline Bit Null, ' +
           'FontStrikeout Bit Null, ' +
           'Event integer Null, ' +
           'Kind Integer Null, ' +
           'CanRelocate Bit Null, ' +
           'Disable Bit Null)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'TableOrderButton' + Chr(39) + ', 1, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Table' + Chr(13) + Chr(10) + 'Order' + Chr(39) + ',' +
           Chr(39) + 'Arial' + Chr(39) + ',' + '8, 1, 0, 0, 0, ' +
           IntToStr(tcTableOrderButtonClick) + ', ' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PhoneOrderAdminButton' + Chr(39) + ', 2, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Phone' + Chr(13) + Chr(10) + 'Order' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcPhoneOrderAdminButtonClick) + ', ' +
           IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'QuickServiceButton' + Chr(39) + ', 3, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Quick' + Chr(13) + Chr(10) + 'Service' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcQuickServiceButtonClick) + ', ' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SplitBillButton' + Chr(39) + ', 4, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Split' + Chr(13) + Chr(10) + 'Bill' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcSplitBillButtonClick) + ', ' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'MergeTableButton' + Chr(39) + ', 5, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Merge' + Chr(13) + Chr(10) + 'Table' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcMergeTableButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PaymentButton' + Chr(39) + ', 6, ' +
           IntToStr(sButtonDoubleHeight) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Payment' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcPaymentButtonClick) + ', ' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PrintInvoiceButton' + Chr(39) + ', 7, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Print' + Chr(13) + Chr(10) + 'Invoice' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcPrintInvoiceButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PrintBillButton' + Chr(39) + ', 8, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Print' + Chr(13) + Chr(10) + 'Bill' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcPrintBillButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PrintJobListButton' + Chr(39) + ', 9, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Print' + Chr(13) + Chr(10) + 'Job List' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcPrintJobListButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SlipBillButton' + Chr(39) + ', 10, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Print' + Chr(13) + Chr(10) + 'Pickup' + Chr(13) + Chr(10) + 'Slip' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcPrintPickupSlipButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PrintGoWithMessageButton' + Chr(39) + ', 11, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Print' + Chr(13) + Chr(10) + '"Go With"' + Chr(13) + Chr(10) + 'Message' + Chr(39) + ',' +
           Chr(39) + 'Arial' + Chr(39) + ',' + '8, 1, 0, 0, 0, ' + IntToStr(tcPrintGoWithMessageButtonClick) + ',' +
           IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'DailyReportButton' + Chr(39) + ', 13, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Daily' + Chr(13) + Chr(10) + 'Report' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcDailyReportButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'TableStatusButton' + Chr(39) + ', 14, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Table' + Chr(13) + Chr(10) + 'Status' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcTableStatusButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'OrderListButton' + Chr(39) + ', 15, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Order' + Chr(13) + Chr(10) + 'List' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcOrderListButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ReservationListButton' + Chr(39) + ', 16, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Reservation' + Chr(13) + Chr(10) + 'List' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcReservationListButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'OpenDrawerButton' + Chr(39) + ', 17, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Open' + Chr(13) + Chr(10) + 'Drawer' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcOpenDrawerButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'MenuGroupButton' + Chr(39) + ', 18, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Menu' + Chr(13) + Chr(10) + 'Group' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcMenuGroupButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'MenuSetupButton' + Chr(39) + ', 19, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Menu' + Chr(13) + Chr(10) + 'Setup' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcMenuSetupButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'DepositButton' + Chr(39) + ', 20, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Deposit' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcDepositButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'CashPayOutButton' + Chr(39) + ', 21, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Cash' + Chr(13) + Chr(10) + 'Pay Out' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcCashPayOutButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'UserIDButton' + Chr(39) + ', 22, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Change' + Chr(13) + Chr(10) + 'User ID' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcUserIDButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'VIPManagerButton' + Chr(39) + ', 23, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) +  'V.I.P.' + Chr(13) + Chr(10) + 'Manager' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcVIPManagerButtonClick) + ',' +
           IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ExitButton' + Chr(39) + ', 24, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) +  'Exit' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tcExitButtonClick) + ',' + IntToStr(sTableOrderControlButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'QtyButton' + Chr(39) + ', 1, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) +  'Qty' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teQtyButtonClick) + ',' + IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PriceButton' + Chr(39) + ', 2, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) +  'Price' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(tePriceButtonClick) + ',' + IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'DiscountButton' + Chr(39) + ', 3, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) +  'Discount' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teDiscountButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'VoidItemButton' + Chr(39) + ', 4, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) +  'Void' + Chr(13) + Chr(10) + 'Item' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teVoidItemButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'InsertItemButton' + Chr(39) + ', 5, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) +  'Insert' + Chr(13) + Chr(10) + 'Item' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teInsertItemButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'DirectPaymentButton' + Chr(39) + ', 6, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) +  'Payment' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teDirectPaymentButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'BalanceButton' + Chr(39) + ', 7, ' +
           IntToStr(sButtonDoubleHeight) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) +  'Balance' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teBalanceButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'WeightButton' + Chr(39) + ', 8, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) +  'Weight' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teWeightButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ViewIngredientsButton' + Chr(39) + ', 9, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'View' + Chr(13) + Chr(10) + 'Ingredients' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teViewIngredientsButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SpellInstructionButton' + Chr(39) + ', 10, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Spell' + Chr(13) + Chr(10) + 'Instruction' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teSpellInstructionButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'InstructionButton' + Chr(39) + ', 11, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Instruction' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teInstructionButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'MealpackageButton' + Chr(39) + ', 12, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Meal' + Chr(13) + Chr(10) + 'Package' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teMealPackageButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'AccountPaymentButton' + Chr(39) + ', 13, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Account' + Chr(13) + Chr(10) + 'Payment' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teAccountPaymentButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SurchargeButton' + Chr(39) + ', 15, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Surcharge' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teSurchargeButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'OtherChargeButton' + Chr(39) + ', 16, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Other' + Chr(13) + Chr(10) + 'Charge' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teOtherChargeButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'RedeemPointButton' + Chr(39) + ', 17, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Redeem' + Chr(13) + Chr(10) + 'Points' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teRedeemPointButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'OrderDueTimeButton' + Chr(39) + ', 18, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Order' + Chr(13) + Chr(10) + 'Due Time' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teOrderDueTimeButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SeatNumberButton' + Chr(39) + ', 19, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Seat' + Chr(13) + Chr(10) + 'Number' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teSeatNumberButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'DirectPrintBillButton' + Chr(39) + ', 20, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Print' + Chr(13) + Chr(10) + 'Bill' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teDirectPrintBillButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'QuitButton' + Chr(39) + ', 21, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Quit' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teQuitButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ChangeMenuButton' + Chr(39) + ', 22, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Menu' + Chr(13) + Chr(10) + 'Setup' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teChangeMenuButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'VoidAllItemButton' + Chr(39) + ', 23, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Cancel' + Chr(13) + Chr(10) + 'All Items' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teVoidAllItemButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ChangeUserIDButton' + Chr(39) + ', 24, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Change' + Chr(13) + Chr(10) + 'User ID' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teChangeUserIDButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ReservationButton' + Chr(39) + ', 25, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Reservation' + Chr(13) + Chr(10) + 'List' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teReservationButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'VIPListButton' + Chr(39) + ', 26, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'V.I.P.' + Chr(13) + Chr(10) + 'List' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teVIPListButtonClick) + ',' + IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'CustomerNameButton' + Chr(39) + ', 27, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Customer' + Chr(13) + Chr(10) + 'Name' + Chr(39) + ',' + Chr(39) +  'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teCustomerNameButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ChangeMenuGroupButton' + Chr(39) + ', 28, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Menu' + Chr(13) + Chr(10) + 'Group' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(teChangeMenuGroupButtonClick) + ',' +
           IntToStr(sTableOrderEditButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'LangurageButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Convert' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sTableOrderEditButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SplitLineButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Split' + Chr(13) + Chr(10) + 'Line' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sTableOrderEditButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ZoomButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Zoom' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sTableOrderEditButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'MinimumChargeButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Elapse' + Chr(13) + Chr(10) + 'Time' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sTableOrderEditButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);

 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'QtyButton' + Chr(39) + ', 1, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Qty' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsQtyButtonClick) + ',' + IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'WeightButton' + Chr(39) + ', 2, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Weight' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsWeightButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PriceButton' + Chr(39) + ', 3, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Price' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsPriceButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'VoidItemButton' + Chr(39) + ', 4, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Void' + Chr(13) + Chr(10) + 'Item' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsVoidItemButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'InsertButton' + Chr(39) + ', 5, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Insert' + Chr(13) + Chr(10) + 'Item' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsInsertButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PaymentButton' + Chr(39) + ', 6, ' +
           IntToStr(sButtonDoubleHeight) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Payment' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsPaymentButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ViewIngredientsButton' + Chr(39) + ', 7, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'View' + Chr(13) + Chr(10) + 'Ingredients' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsViewIngredientsButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SpellInstructionButton' + Chr(39) + ', 8, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) +  'Spell' + Chr(13) + Chr(10) + 'Instruction' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsSpellInstructionButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'InstructionButton' + Chr(39) + ', 9, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) +  'Instruction' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsInstructionButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PrintInvoiceButton' + Chr(39) + ', 10, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) +   'Print' + Chr(13) + Chr(10) + 'Invoice' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsPrintInvoiceButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PrintBillButton' + Chr(39) + ', 11, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Print' + Chr(13) + Chr(10) + 'Bill' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsPrintBillButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'CashPayOutButton' + Chr(39) + ', 13, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) +  'Cash' + Chr(13) + Chr(10) + 'Pay Out' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsCashPayOutButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'DiscountButton' + Chr(39) + ', 14, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Discount' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsDiscountButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ChangeUserIDButton' + Chr(39) + ', 15, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Change' + Chr(13) + Chr(10) + 'User ID' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsChangeUserIDButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PrintJobListButton' + Chr(39) + ', 16, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Print' + Chr(13) + Chr(10) + 'Job List' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsPrintJobListButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PrintPickupSlipButton' + Chr(39) + ', 17, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Print' + Chr(13) + Chr(10) + 'Pickup Slip' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsPrintPickupSlipButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'CancelButton' + Chr(39) + ', 18, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Cancel' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsCancelButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'MoreFunctionButton' + Chr(39) + ', 19, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'More' + Chr(13) + Chr(10) + 'Functions' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsMoreFunctionButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'OpenDrawerButton' + Chr(39) + ', 20, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Open' + Chr(13) + Chr(10) + 'Drawer' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsOpenDrawerButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'AccountPaymentButton' + Chr(39) + ', 21, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Account' + Chr(13) + Chr(10) + 'Payment' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsAccountPaymentButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'VIPListButton' + Chr(39) + ', 22, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'V.I.P.' + Chr(13) + Chr(10) + 'List' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsVIPListButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'MenuGroupButton' + Chr(39) + ', 23, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Menu' + Chr(13) + Chr(10) + 'Group' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsMenuGroupButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ExitButton' + Chr(39) + ', 24, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Exit' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsExitButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'LangurageButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Convert' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sQuickServiceButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ZoomButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Zoom' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sQuickServiceButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'HoldOrderButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Hold' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sQuickServiceButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'RecallOrderButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Recall' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sQuickServiceButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);

 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SplitBillButton' + Chr(39) + ', 25, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Split' + Chr(13) + Chr(10) + 'Bill' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsSplitBillButtonClick) + ',' +
           IntToStr(sQuickServiceButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);

 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'QtyButton' + Chr(39) + ', 1, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Qty' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poQtyButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PriceButton' + Chr(39) + ', 2, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Price' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poPriceButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'DiscountButton' + Chr(39) + ', 3, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Discount' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poDiscountButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SpellInstructionButton' + Chr(39) + ', 4, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Spell' + Chr(13) + Chr(10) + 'Instruction' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poSpellInstructionButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'AssignDriverButton' + Chr(39) + ', 5, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSilver) + ',' +
           Chr(39) + 'Assign' + Chr(13) + 'Driver' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poAssignDriverButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'BalanceButton' + Chr(39) + ', 6, ' +
           IntToStr(sButtonDoubleHeight) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Balance' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poBalanceButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'WeightButton' + Chr(39) + ', 7, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Weight' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poWeightButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'VoidItemButton' + Chr(39) + ', 8, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Void' + Chr(13) + Chr(10) + 'Item' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poVoidItemButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'InsertItemButton' + Chr(39) + ', 9, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Insert' + Chr(13) + Chr(10) + 'Item' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poInsertItemButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'InstructionButton' + Chr(39) + ', 10, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Instruction' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poInstructionButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'MenuGroupButton' + Chr(39) + ', 11, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoSky) + ',' +
           Chr(39) + 'Menu' + Chr(13) + Chr(10) + 'Group' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poMenuGroupButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'MoreFunctionButton' + Chr(39) + ', 13, ' +
           IntToStr(sButtonDoubleHeight) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'More' + Chr(13) + Chr(10) + 'Functions' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poMoreFunctionButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SearchCustomerButton' + Chr(39) + ', 14, ' +
           IntToStr(sButtonDoubleHeight) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Search' + Chr(13) + Chr(10) + 'Customer' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poSearchCustomerButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PickupOrDeliveryButton' + Chr(39) + ', 15, ' +
           IntToStr(sButtonDoubleHeight) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Pick Up' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poPickupOrDeliveryButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'VoidAllItemButton' + Chr(39) + ', 16, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Void' + Chr(13) + Chr(10) + 'All Item' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poVoidAllItemButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ViewCustomerDetailButton' + Chr(39) + ', 17, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'View' + Chr(13) + Chr(10) + 'Customer' + Chr(13) + Chr(10) + 'Detail' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poViewCustomerDetailButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'CancelButton' + Chr(39) + ', 18, ' +
           IntToStr(sButtonDoubleHeight) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Cancel' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poCancelButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'DepositButton' + Chr(39) + ', 22, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Deposit' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poDepositButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'CustomerOrderHistoryButton' + Chr(39) + ', 23, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Order' + Chr(13) + Chr(10) + 'History' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(poCustomerOrderHistoryButtonClick) + ',' +
           IntToStr(sPhoneOrderButton) + ', 1, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'LangurageButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Convert' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sPhoneOrderButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'SplitLineButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Split Line' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sPhoneOrderButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);
 SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'ZoomButton' + Chr(39) + ', 0, 0, ' +
           IntToStr(bcNeoGrass) + ',' +
           Chr(39) + 'Zoom' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, Null, ' + IntToStr(sPhoneOrderButton) + ', 0, 0)';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.CreateButtonsTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'ButtonsTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    CreateButtonsTable
   else
    begin
     SQLStr := 'Update ButtonsTable Set Caption = ' +
               Chr(39) + 'Menu' + Chr(13) + Chr(10) + 'Setup' + Chr(39) +
               ' Where ButtonName=' + Chr(39) + 'ChangeMenuButton' + Chr(39) +
               ' and Caption =' + Chr(39) + 'Quit' + Chr(39) +
               ' and Kind=' + IntToStr(sTableOrderEditButton);
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateDiscountRateTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'DiscountRateTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table DiscountRateTable(' +
               'Code nvarchar(3) Null, ' +
               'Description nvarchar(25) Null, ' +
               'DiscountRate float Null)';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateTransactionLogTablePro;
var SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'TransactionLog' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table TransactionLog(' +
               'LogID Integer Null, ' +
               'Status Bit Null)';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateStreetTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'StreetTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table StreetTable(' +
               'Street nvarchar(100) Null, ' +
               'Suburb nvarchar(25) Null, ' +
               'MapReference nvarchar(10) Null)';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateDepartmentTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'ItemGroupTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table ItemGroupTable(GroupName nvarchar(25) Null)';
     ExecQueryPro(SQLStr);
     SQLStr := 'Insert Into ItemGroupTable(GroupName) Values(' + Chr(39) + 'FOOD' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
     SQLStr := 'Insert Into ItemGroupTable(GroupName) Values(' + Chr(39) + 'DRINK' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
     SQLStr := 'Insert Into ItemGroupTable(GroupName) Values(' + Chr(39) + 'OTHERS' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add ItemGroup nvarchar(25) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set ItemGroup=' + Chr(39) + 'FOOD' + Chr(39) +
               'From MenuItem, Category ' +
               'Where MenuItem.Category=Category.Category and KindFlag = 0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set ItemGroup=' + Chr(39) + 'DRINK' + Chr(39) +
               'From MenuItem, Category ' +
               'Where MenuItem.Category=Category.Category and KindFlag = 1';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set ItemGroup=' + Chr(39) + 'OTHERS' + Chr(39) +
               'From MenuItem, Category ' +
               'Where MenuItem.Category=Category.Category and KindFlag = 3';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set ItemGroup=' + Chr(39) + 'OTHERS' + Chr(39) +
               'From MenuItem Where ItemGroup IS NULL';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Category Drop Column KindFlag';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table ItemGroupTable Alter COLUMN GroupName nvarchar(25) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateDepositTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'DepositTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table DepositTable(' +
               'VIPNo Integer Null, ' +
               'DepositDate DateTime Null, ' +
               'Amount Float Null, ' +
               'PaymentMethod nvarchar(25) Null, ' +
               'Notes nvarchar(50) Null, ' +
               'MachineID nvarchar(15) Null, ' +
               'OpName nvarchar(15) Null, ' +
               'ID integer Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table DepositTable Alter COLUMN PaymentMethod nvarchar(25) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table DepositTable Alter COLUMN Notes nvarchar(50) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table DepositTable Alter COLUMN MachineID nvarchar(15) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table DepositTable Alter COLUMN OpName nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreatePointsPaymentTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'LoyaltyPoints' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table LoyaltyPoints(' +
               'OrderNo nvarchar(10) Null, ' +
               'OrderDate DateTime Null, ' +
               'VIPNo Integer Null, ' +
               'AwardPoints Integer Null, ' +
               'PaymentPoints Integer Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table LoyaltyPoints Alter COLUMN OrderNo nvarchar(10) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateSubMenuLinkTablePro;
var
 SQLStr, Temp: string;
 SubCategoryFlag: boolean;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'SubMenuLinkHead' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table SubMenuLinkHead(' +
               'ItemCode nvarchar(4) Null, ' +
               'SubCategory Bit Null, ' +
               'AutoShowSubMenu Bit Null, ' +
               'NumberOfChoice Integer Null) ';
     ExecQueryPro(SQLStr);
     SQLStr := 'Create Table SubMenuLinkDetail(' +
               'ItemCode nvarchar(4) Null, ' +
               'SubMenuCode nvarchar(4) Null, ' +
               'ChoiceItem Bit Null, ' +
               'SalesPrice Float Null, ' +
               'Instruction Bit Null)';
     ExecQueryPro(SQLStr);
    end;

 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'SubMenuLinkTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount > 0 then
    begin
     SQLStr := 'Delete From SubMenuLinkHead';
     ExecQueryPro(SQLStr);
     SQLStr := 'Select * From MenuItem Where ItemCode=' + Chr(39) + Chr(39);
     OpenQuery(SQLStr);
     SubCategoryFlag := Query.FindField('SubCategory') <> NIL;
     if SubCategoryFlag then
        SQLStr := 'Select SubMenuLinkTable.ItemCode, MenuItem.SubCategory ' +
                  'From SubMenuLinkTable, MenuItem ' +
                  'Where SubMenuLinkTable.ItemCode=MenuItem.ItemCode ' +
                  'Group By SubMenuLinkTable.ItemCode, MenuItem.SubCategory'
       else
        SQLStr := 'Select SubMenuLinkTable.ItemCode ' +
                  'From SubMenuLinkTable ' +
                  'Group By SubMenuLinkTable.ItemCode';
     OpenQuery(SQLStr);
     with Query do
      begin
       While Not EOF do
        begin
         if SubCategoryFlag and FieldByName('SubCategory').AsBoolean then
            Temp := '1'
           else
            Temp := '0';
         SQLStr := 'Insert Into SubMenuLinkHead(ItemCode, SubCategory, AutoShowSubMenu, NumberOfChoice) ' +
                   'Values(' + Chr(39) + FieldByName('ItemCode').AsString + Chr(39) +
                   ',' + Temp + ',0, 0)';
         ExecQueryPro(SQLStr);
         Next;
        end;
       Close;
      end;

     SQLStr := 'Delete From SubMenuLinkDetail';
     ExecQueryPro(SQLStr);
     SQLStr := 'Select SubMenuLinkTable.ItemCode, SubMenuLinkTable.SubMenuCode, ' +
               'MenuItem.Price, MenuItem.Instruction ' +
               'From SubMenuLinkTable, MenuItem ' +
               'Where MenuItem.ItemCode=SubMenuLinkTable.SubMenuCode';
     OpenQuery(SQLStr);
     with Query do
      begin
       While Not EOF do
        begin
         if FieldByName('Instruction').AsBoolean then
            Temp := '1' else Temp := '0';
         SQLStr := 'Insert Into SubMenuLinkDetail(ItemCode, SubMenuCode, ' +
                   'ChoiceItem, SalesPrice, Instruction) ' +
                   'Values(' + Chr(39) + FieldByName('ItemCode').AsString + Chr(39) + ',' +
                   Chr(39) + FieldByName('SubMenuCode').AsString + Chr(39) + ', 1, ' +
                   FieldByName('Price').AsString + ',' + Temp + ')';
         ExecQueryPro(SQLStr);
         Next;
        end;
       Close;
      end;

     SQLStr := 'Drop Table SubMenuLinkTable';
     ExecQueryPro(SQLStr);
    end
end;

procedure TUpgradeForm.CreateMenuGroupTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'MenuGroupTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table MenuGroupTable(' +
               'Code nvarchar(2) Null, ' +
               'Description nvarchar(20) Null)';
     ExecQueryPro(SQLStr);
     SQLStr := 'Insert Into MenuGroupTable(Code, Description) ' +
               'Values(' + Chr(39) + '00' + Chr(39) + ',' +
               Chr(39) + 'Default Menu Group' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table MenuGroupTable Alter COLUMN Code nvarchar(2) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuGroupTable Alter COLUMN Description nvarchar(20) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateVoidReasonTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'VoidReasonTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table VoidReasonTable(' +
               'Code nvarchar(2) Null, ' +
               'Description nvarchar(20) Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table VoidReasonTable Alter COLUMN Code nvarchar(2) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table VoidReasonTable Alter COLUMN Description nvarchar(20) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.DeleteOldKitchenScreenTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'KitchenScreenHead' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount > 0 then
    begin
     SQLStr := 'DROP TABLE KitchenScreenHead';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'KitchenScreenItem' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount > 0 then
    begin
     SQLStr := 'DROP TABLE KitchenScreenItem';
     ExecQueryPro(SQLStr);
    end
end;

procedure TUpgradeForm.CreateKitchenScreenTablePro;
var
 SQLStr: string;
 KitchenScreenNumberFlag, SentDateTimeFlag, LockedFlag: boolean;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'KitchenScreen' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table KitchenScreen(' +
               'OrderNo nvarchar(10) Null, ' +
               'ItemCode nvarchar(4) Null, ' +
               'Qty Float Null, ' +
               'PriceSelect Integer Null, ' +
               'Condition Integer Null, ' +
               'SpecialOrder nvarchar(255) Null, ' +
               'Finished Bit Null, ' +
               'KitchenScreenNumber1 Bit Null, ' +
               'KitchenScreenNumber2 Bit Null, ' +
               'KitchenScreenNumber3 Bit Null, ' +
               'KitchenScreenNumber4 Bit Null, ' +
               'KitchenScreenNumber5 Bit Null, ' +
               'KitchenScreenNumber6 Bit Null, ' +
               'KitchenScreenNumber7 Bit Null, ' +
               'KitchenScreenNumber8 Bit Null, ' +
               'KitchenScreenNumber9 Bit Null, ' +
               'KitchenScreenNumber10 Bit Null, ' +
               'KitchenScreenNumber11 Bit Null, ' +
               'KitchenScreenNumber12 Bit Null, ' +
               'SentDateTime DateTime Null, ' +
               'Locked Bit Null, ' +
               'Resend Bit Null, ' +
               'ID Integer Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Select * From KitchenScreen Where OrderNo=' + Chr(39) + Chr(39);
     OpenQuery(SQLStr);
     KitchenScreenNumberFlag := Query.FindField('KitchenScreenNumber') <> NIL;
     SentDateTimeFlag := Query.FindField('SentDateTime') = NIL;
     LockedFlag := Query.FindField('Locked') = NIL;
     Query.Close;
     if KitchenScreenNumberFlag then
        begin
         SQLStr := 'Delete From KitchenScreen';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber1 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber2 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber3 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber4 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber5 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber6 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber7 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber8 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber9 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber10 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber11 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Add KitchenScreenNumber12 Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table KitchenScreen Drop Column KitchenScreenNumber';
         ExecQueryPro(SQLStr);
       end;
     if SentDateTimeFlag then
        begin
         SQLStr := 'Alter Table KitchenScreen Add SentDateTime DateTime Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update KitchenScreen Set SentDateTime=OrderH.OrderDate ' +
                   'From KitchenScreen, OrderH ' +
                   'Where KitchenScreen.OrderNo=OrderH.OrderNo';
         ExecQueryPro(SQLStr);
        end;
     if LockedFlag then
        begin
         SQLStr := 'Alter Table KitchenScreen Add Locked Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update KitchenScreen Set Locked=0';
         ExecQueryPro(SQLStr);
        end;
    end;
end;

procedure TUpgradeForm.CreateTablePagePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'TablePage' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table TablePage(' +
               'PageNo Integer Null, ' +
               'Description nvarchar(20) Null)';
     ExecQueryPro(SQLStr);
     SQLStr := 'Insert Into TablePage(PageNo, Description) ' +
               'Values(1, ' + Chr(39) + 'Page 1' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table TablePage Alter COLUMN Description nvarchar(20) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateWastageHeadTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'WastageHead' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table WastageHead(' +
               'WastageNo Integer Null, ' +
               'WastageDate DateTime Null, ' +
               'OpName nvarchar(15) Null, ' +
               'Amount Float Null, ' +
               'Notes nvarchar(255) Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table WastageHead Alter COLUMN OpName nvarchar(15) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table WastageHead Alter COLUMN Notes nvarchar(255) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateWastageItemTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'WastageItem' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table WastageItem(' +
               'WastageNo Integer Null, ' +
               'ItemCode nvarchar(4) Null, ' +
               'Qty Float Null, ' +
               'Price Float Null, ' +
               'PriceSelect Integer Null, ' +
               'ID Integer Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table WastageItem Alter COLUMN ItemCode nvarchar(4) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateHoldHeadTablePro;
var
 SQLStr: string;
 CustomerNameFlag, TelephoneFlag, DueTimeFlag, GSTStatusFlag,
 PresetDiscountCodeFlag, DiscountOperatorFlag: boolean;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'HoldHead' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table HoldHead(' +
               'HoldNo Integer Null, ' +
               'HoldDate DateTime Null, ' +
               'DiscountKind Integer Null, ' +
               'DiscountPercent Float Null, ' +
               'DiscountDollar Float Null, ' +
               'MachineID nvarchar(15) Null, ' +
               'OpName nvarchar(15) Null, ' +
               'CustomerName nvarchar(25) Null, ' +
               'Telephone nvarchar(15) Null, ' +
               'DueTime DateTime Null, ' +
               'GSTStatus Bit Null, ' +
               'DiscountOperator nvarchar(15) Null, ' +
               'PresetDiscountCode nvarchar(3) Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Select * From HoldHead Where HoldNo=0';
     OpenQuery(SQLStr);
     CustomerNameFlag := Query.FindField('CustomerName') = NIL;
     TelephoneFlag := Query.FindField('Telephone') = NIL;
     DueTimeFlag := Query.FindField('DueTime') = NIL;
     GSTStatusFlag := Query.FindField('GSTStatus') = NIL;
     PresetDiscountCodeFlag := Query.FindField('PresetDiscountCode') = NIL;
     DiscountOperatorFlag := Query.FindField('DiscountOperator') = NIL;
     Query.Close;
     if CustomerNameFlag then
        begin
         SQLStr := 'Alter Table HoldHead Add CustomerName nvarchar(25) Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update HoldHead Set CustomerName=Null';
         ExecQueryPro(SQLStr);
        end
       else
        begin
         SQLStr := 'Alter Table HoldHead Alter COLUMN CustomerName nvarchar(25) Null';
         ExecQueryPro(SQLStr);
        end;
     if TelephoneFlag then
        begin
         SQLStr := 'Alter Table HoldHead Add Telephone nvarchar(15) Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update HoldHead Set Telephone=Null';
         ExecQueryPro(SQLStr);
        end
       else
        begin
         SQLStr := 'Alter Table HoldHead Alter COLUMN Telephone nvarchar(15) Null';
         ExecQueryPro(SQLStr);
        end;
     if DueTimeFlag then
        begin
         SQLStr := 'Alter Table HoldHead Add DueTime DateTime Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update HoldHead Set DueTime=0';
         ExecQueryPro(SQLStr);
        end;
     if GSTStatusFlag then
        begin
         SQLStr := 'Alter Table HoldHead Add GSTStatus Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update HoldHead Set GSTStatus=0';
         ExecQueryPro(SQLStr);
        end;
     if PresetDiscountCodeFlag then
        begin
         SQLStr := 'Alter Table HoldHead Add PresetDiscountCode nvarchar(3) Null';
         ExecQueryPro(SQLStr);
        end;
     if DiscountOperatorFlag then
        begin
         SQLStr := 'Alter Table HoldHead Add DiscountOperator nvarchar(15) Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update HoldHead Set DiscountOperator=OpName';
         ExecQueryPro(SQLStr);
        end;
     SQLStr := 'Alter Table HoldHead Alter COLUMN MachineID nvarchar(15) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table HoldHead Alter COLUMN OpName nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateHoldItemTablePro;
var
 SQLStr: string;
 SpecialOrderFlag, PrintedFlag, CheckListPrintedFlag, OriginalPriceFlag: boolean;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'HoldItem' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table HoldItem(' +
               'HoldNo Integer Null, ' +
               'ItemCode nvarchar(4) Null, ' +
               'Qty Float Null, ' +
               'Price Float Null, ' +
               'Discount Float Null, ' +
               'Condition Integer Null, ' +
               'PriceSelect Integer Null, ' +
               'SpecialOrder nvarchar(255) Null, ' +
               'Printed Bit Null, ' +
               'CheckListPrinted Bit Null, ' +
               'OriginalPrice Float Null, ' +
               'ID Integer Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Select * From HoldItem Where HoldNo=0';
     OpenQuery(SQLStr);
     SpecialOrderFlag := Query.FindField('SpecialOrder') = NIL;
     PrintedFlag := Query.FindField('Printed') = NIL;
     CheckListPrintedFlag := Query.FindField('CheckListPrinted') = NIL;
     OriginalPriceFlag := Query.FindField('OriginalPrice') = NIL;
     Query.Close;
     if SpecialOrderFlag then
        begin
         SQLStr := 'Alter Table HoldItem Add SpecialOrder nvarchar(255) Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update HoldItem Set SpecialOrder=Null';
         ExecQueryPro(SQLStr);
        end
       else
        begin
         SQLStr := 'Alter Table HoldItem Alter COLUMN SpecialOrder nvarchar(255) Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table HoldItem Alter COLUMN ItemCode nvarchar(4) Null';
         ExecQueryPro(SQLStr);
        end;
     if PrintedFlag then
        begin
         SQLStr := 'Alter Table HoldItem Add Printed Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update HoldItem Set Printed=1';
         ExecQueryPro(SQLStr);
        end;
     if CheckListPrintedFlag then
        begin
         SQLStr := 'Alter Table HoldItem Add CheckListPrinted Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update HoldItem Set CheckListPrinted=1';
         ExecQueryPro(SQLStr);
        end;
     if OriginalPriceFlag then
        begin
         SQLStr := 'Alter Table HoldItem Add OriginalPrice Float Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update HoldItem Set OriginalPrice=0';
         ExecQueryPro(SQLStr);
        end;
    end;
end;

procedure TUpgradeForm.CreateDrawerCounterTablePro;
var
 SQLStr: string;
 MachineIDFlag, NonSalesOpenFlag: boolean;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'DrawerCounter' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table DrawerCounter(' +
               'OpenDate DateTime, ' +
               'Times Integer, ' +
               'NonSalesOpen Integer, ' +
               'MachineID nvarchar(15))';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Select * From DrawerCounter Where Times=-1';
     OpenQuery(SQLStr);
     MachineIDFlag := Query.FindField('MachineID') = NIL;
     NonSalesOpenFlag := Query.FindField('NonSalesOpen') = NIL;
     Query.Close;
     if MachineIDFlag then
        begin
         SQLStr := 'Alter Table DrawerCounter Add MachineID nvarchar(15) Null';
         ExecQueryPro(SQLStr);
        end;
     if NonSalesOpenFlag then
        begin
         SQLStr := 'Alter Table DrawerCounter Add NonSalesOpen Integer Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update DrawerCounter Set NonSalesOpen = 0';
         ExecQueryPro(SQLStr);
        end;
    end;
end;

procedure TUpgradeForm.CreateMachineIDTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'MachineID' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table MachineID(MachineID nvarchar(15) Null)';
     ExecQueryPro(SQLStr);
    end
end;

procedure TUpgradeForm.CreateIngredientsTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'IngredientsTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table IngredientsTable(' +
               'ItemCode nvarchar(4) Null, ' +
               'Ingredients nvarchar(255) Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table IngredientsTable Alter COLUMN ItemCode nvarchar(4) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table IngredientsTable Alter COLUMN Ingredients nvarchar(255) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreatePayOutTablePro;
var
 SQLStr: string;
 MachineIDFlag, IDFlag: boolean;
 I: integer;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'PayOutTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table PayOutTable(' +
               'PaymentDate DateTime, ' +
               'Amount Float, OpName nvarchar(15), ' +
               'Description nvarchar(200) Null, ' +
               'MachineID nvarchar(15), ' +
               'ID Integer)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Select * From PayOutTable Where OpName=' + Chr(39) + Chr(39);
     OpenQuery(SQLStr);
     MachineIDFlag := Query.FindField('MachineID') = NIL;
     IDFlag := Query.FindField('ID') = NIL;
     Query.Close;
     if MachineIDFlag then
        begin
         SQLStr := 'Alter Table PayOutTable Add MachineID nvarchar(15) Null';
         ExecQueryPro(SQLStr);
        end;
     if IDFlag then
        begin
         SQLStr := 'Alter Table PayOutTable Add ID Integer';
         ExecQueryPro(SQLStr);
         SQLStr := 'Select PaymentDate From PayoutTable Order By PaymentDate';
         OpenTempQuery(SQLStr);
         with TempQuery do
          begin
           I := 1;
           while Not EOF do
            begin
             SQLStr := 'Update PayoutTable Set ID=' + IntToStr(I) +
                       'Where PaymentDate=' + ConvertDateTime(FieldByName('PaymentDate').AsDateTime);
             ExecQueryPro(SQLStr);
             Inc(I); Next;
            end;
          end;
        end;
    end;
end;

procedure TUpgradeForm.CreateCashFloatTablePro;
var
 SQLStr: string;
 DescriptionFlag: boolean;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'CashFloatTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table CashFloatTable(' +
               'OpDate DateTime, ' +
               'CashIn Float, ' +
               'CashOut Float, ' +
               'OpName nvarchar(15), ' +
               'MachineID nvarchar(15), ' +
               'ID Integer Null, ' +
               'Description nvarchar(200) Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Select * From CashFloatTable Where OpName=' + Chr(39) + Chr(39);
     OpenQuery(SQLStr);
     DescriptionFlag := Query.FindField('Description') = NIL;
     Query.Close;
     if DescriptionFlag then
        begin
         SQLStr := 'Alter Table CashFloatTable Add Description nvarchar(200) Null';
         ExecQueryPro(SQLStr);
        end
       else
        begin
         SQLStr := 'Alter Table CashFloatTable Alter COLUMN Description nvarchar(200) Null';
         ExecQueryPro(SQLStr);
        end;
     SQLStr := 'Alter Table CashFloatTable Alter COLUMN OpName nvarchar(15) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table CashFloatTable Alter COLUMN MachineID nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreatePurchaseTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'PurchaseHead' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table PurchaseHead(' +
               'SupplierCode nvarchar(15), ' +
               'PurchaseDate DateTime, ' +
               'PurchaseNo nvarchar(8), ' +
               'ReceiveNo nvarchar(8) Null, ' +
               'Cancel Bit Null, ' +
               'GSTStatus Bit Null, ' +
               'Notes Char(200) Null, ' +
               'Delivery Bit Null, ' +
               'DeliveryAddress nvarchar(150) Null, ' +
               'OpName nvarchar(15))';
     ExecQueryPro(SQLStr);
     SQLStr := 'Create Table PurchaseItem(' +
               'PurchaseNo nvarchar(8), ' +
               'Code nvarchar(8) Null, ' +
               'Qty Float Null, ' +
               'Price Float Null, ' +
               'GSTRate Float Null, ' +
               'ArrivedQty Float Null, ' +
               'ID SmallInt)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table PurchaseItem Alter COLUMN Code nvarchar(8)';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreatePurchasePayableTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'PayAcct' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table PayAcct(' +
               'ReceiveNo nvarchar(8) Null, ' +
               'AccountDate DateTime Null, ' +
               'PaidAmount Float Null, ' +
               'PayBy nvarchar(25) Null, ' +
               'Notes nvarchar(25) Null, ' +
               'IDNo SMallInt Null, ' +
               'Transfer Bit Null, ' +
               'OpName nvarchar(15) Null)';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.DeletePrintJobListTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'PrintJobListTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount <> 0 then
    begin
     SQLStr := 'Drop Table PrintJobListTable';
     ExecQueryPro(SQLStr);
    end
end;

procedure TUpgradeForm.UpgradePaymentMethodPro;
var
 SQLStr: string;
 SurchargeFlag, LinkToEFTPOSFlag, ShowOnListFlag, CodeFlag, IDFlag,
 EFTPOSPaymentFlag: boolean;
 I: integer;
begin
 SQLStr := 'Select * From Payment';
 OpenQuery(SQLStr);
 SurchargeFlag := Query.FindField('SurchargeRate') = NIL;
 ShowOnListFlag := Query.FindField('ShowOnList') = NIL;
 LinkToEFTPOSFlag := Query.FindField('LinkToEFTPOS') = NIL;
 CodeFlag := Query.FindField('Code') = NIL;
 EFTPOSPaymentFlag := Query.FindField('EFTPOSPayment') = NIL;
 IDFlag := Query.FindField('ID') <> NIL;
 Query.Close;
 if SurchargeFlag then
    begin
     SQLStr := 'Alter Table Payment Add SurchargeRate Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Payment Set SurchargeRate = 0';
     ExecQueryPro(SQLStr);
    end;
 if ShowOnListFlag then
    begin
     SQLStr := 'Alter Table Payment Add ShowOnList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Payment Set ShowOnList = 1';
     ExecQueryPro(SQLStr);
    end;
 if LinkToEFTPOSFlag then
    begin
     SQLStr := 'Alter Table Payment Add LinkToEFTPOS Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Payment Set LinkToEFTPOS=0';
     ExecQueryPro(SQLStr);
    end;
 if EFTPOSPaymentFlag then
    begin
     SQLStr := 'Alter Table Payment Add EFTPOSPayment Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Payment Set EFTPOSPayment=0';
     ExecQueryPro(SQLStr);
    end;
 if CodeFlag then
    begin
     SQLStr := 'Alter Table Payment Add Code nvarchar(3) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Select Payment From Payment Order By Payment';
     OpenTempQuery(SQLStr);
     I := 1;
     with TempQuery do
      begin
       while Not EOF do
        begin
         SQLStr := 'Update Payment Set Code=' + Chr(39) + Format('%3.3d', [I]) + Chr(39) +
                   ' Where Payment=' + Chr(39) + FieldByName('Payment').AsString + Chr(39);
         ExecQueryPro(SQLStr);
         Inc(I); Next;
        end;
       Close;
      end;
    end
   else
    begin
     SQLStr := 'Alter Table Payment Alter COLUMN Code nvarchar(3) Null';
     ExecQueryPro(SQLStr);
    end;
 if IDFlag then
    begin
     SQLStr := 'Alter Table Payment Drop Column ID';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.UpgradeExpAcctTablePro;
var
 SQLStr: string;
 TransferFlag, PayMethodFlag, PayByFlag, OpNameFlag, SerialNoFlag: boolean;
begin
 SQLStr := 'Select * From ExpAcct Where ID=0';
 OpenQuery(SQLStr);
 TransferFlag := Query.FindField('Transfer') = NIL;
 PayMethodFlag := Query.FindField('PayMethod') <> NIL;
 PayByFlag := Query.FindField('PayBy') = NIL;
 OpNameFlag := Query.FindField('OpName') = NIL;
 SerialNoFlag := Query.FindField('SerialNo') = NIL;
 Query.Close;
 if TransferFlag then
    begin
     SQLStr := 'Alter Table ExpAcct Add Transfer Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update ExpAcct Set Transfer=False';
     ExecQueryPro(SQLStr);
    end;
 if PayMethodFlag then
    begin
     SQLStr := 'Alter Table ExpAcct Drop COLUMN PayMethod';
     ExecQueryPro(SQLStr);
    end;
 if PayByFlag then
    begin
     SQLStr := 'Alter Table ExpAcct Add PayBy nvarchar(25) Null';
     ExecQueryPro(SQLStr);
    end;
 if OpNameFlag then
    begin
     SQLStr := 'Alter Table ExpAcct Add OpName nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
 if SerialNoFlag then
    begin
     SQLStr := 'Alter Table ExpAcct Add SerialNo Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update ExpAcct Set SerialNo=IDNo';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table ExpAcct Drop Column IDNo';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Alter Table ExpAcct Alter COLUMN Notes nvarchar(25) Null';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.UpgradeExpensesTablePro;
var
 SQLStr: string;
 SerialNoFlag: boolean;
begin
 SQLStr := 'Select * From Expenses Where AccountNo=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 SerialNoFlag := Query.FindField('SerialNo') = NIL;
 Query.Close;
 if SerialNoFlag then
    begin
     SQLStr := 'Alter Table Expenses Add SerialNo Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Expenses Set SerialNo=IDNo';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Expenses Drop Column IDNo';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateExpDetailTablePro;
var
 SQLStr: string;
 SerialNoFlag: boolean;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'ExpDetail' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table ExpDetail (Description nvarchar(50), Qty Float, Price Float, GST Float, SerialNo Integer)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Select * From ExpDetail Where Description=' + Chr(39) + Chr(39);
     OpenQuery(SQLStr);
     SerialNoFlag := Query.FindField('SerialNo') = NIL;
     Query.Close;
     if SerialNoFlag then
        begin
         SQLStr := 'Alter Table Expdetail Add SerialNo Integer Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update ExpDetail Set SerialNo=IDNo';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table ExpDetail Drop Column IDNo';
         ExecQueryPro(SQLStr);
        end;
    end;
end;

procedure TUpgradeForm.CreateStockTablePro;
var
 SQLStr: string;
 StockQtyFlag, AlertQtyFlag, GSTRateFlag, LastOrderPriceFlag, LiveFlag: boolean;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'StockTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table StockTable(' +
               'Code nvarchar(8), ' +
               'Description nvarchar(100), ' +
               'Measure Float Null, ' +
               'MeasureKind SmallInt Null, ' +
               'GSTRate Float Null, ' +
               'AlertQty Float Null, ' +
               'LastOrderPrice Float Null, ' +
               'Live Bit Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Select * From StockTable Where Code=' + Chr(39) + Chr(39);
     OpenQuery(SQLStr);
     StockQtyFlag := Query.FindField('StockQty') <> NIL;
     AlertQtyFlag := Query.FindField('AlertQty') = NIL;
     GSTRateFlag := Query.FindField('GSTRate') = NIL;
     LastOrderPriceFlag := Query.FindField('LastOrderPrice') = NIL;
     LiveFlag := Query.FindField('Live') = NIL;
     Query.Close;
     if StockQtyFlag then
        begin
         SQLStr := 'Alter Table StockTable Drop Column StockQty';
         ExecQueryPro(SQLStr);
        end;
     if AlertQtyFlag then
        begin
         SQLStr := 'Alter Table StockTable Add AlertQty Float Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update StockTable Set AlertQty=0';
         ExecQueryPro(SQLStr);
        end;
     if GSTRateFlag then
        begin
         SQLStr := 'Alter Table StockTable Add GSTRate Float Null';
         ExecQueryPro(SQLStr);
        end;
     if LastOrderPriceFlag then
        begin
         SQLStr := 'Alter Table StockTable Add LastOrderPrice Float Null';
         ExecQueryPro(SQLStr);
        end;
     if LiveFlag then
        begin
         SQLStr := 'Alter Table StockTable Add Live Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update StockTable Set Live=1';
         ExecQueryPro(SQLStr);
        end;
     SQLStr := 'Alter Table StockTable Alter COLUMN Description nvarchar(100) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table StockTable Alter COLUMN Code nvarchar(8) Null';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'StockLinkTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table StockLinkTable(' +
               'Code nvarchar(8) Null, ' +
               'ItemCode nvarchar(4) Null, ' +
               'PriceSelect Integer Null, ' +
               'Measure Float Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table StockLinkTable Alter COLUMN Code nvarchar(8)';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.UpgradeStockHTablePro;
var
 SQLStr: string;
 PurchaseNoFlag, GSTStatusFlag, AmountFlag, GSTFlag,
 PaidAmountFlag, InvoiceNoFlag, KindFlag: boolean;
begin
 SQLStr := 'Select * From StockH Where SupplierCode=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 PurchaseNoFlag := Query.FindField('PurchaseNo') = NIL;
 GSTStatusFlag := Query.FindField('GSTStatus') = NIL;
 AmountFlag := Query.FindField('Amount') = NIL;
 GSTFlag := Query.FindField('GST') = NIL;
 PaidAmountFlag := Query.FindField('PaidAmount') = NIL;
 InvoiceNoFlag := Query.FindField('InvoiceNo') = NIL;
 KindFlag := Query.FindField('Kind') = NIL;
 Query.Close;
 if PurchaseNoFlag then
    begin
     SQLStr := 'Alter Table StockH Add PurchaseNo nvarchar(8) Null';
     ExecQueryPro(SQLStr);
    end;
 if GSTStatusFlag then
    begin
     SQLStr := 'Alter Table StockH Add GSTStatus Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if AmountFlag then
    begin
     SQLStr := 'Alter Table StockH Add Amount Float Null';
     ExecQueryPro(SQLStr);
    end;
 if GSTFlag then
    begin
     SQLStr := 'Alter Table StockH Add GST Float Null';
     ExecQueryPro(SQLStr);
    end;
 if PaidAmountFlag then
    begin
     SQLStr := 'Alter Table StockH Add PaidAmount Float Null';
     ExecQueryPro(SQLStr);
    end;
 if InvoiceNoFlag then
    begin
     SQLStr := 'Alter Table StockH Add InvoiceNo nvarchar(10) Null';
     ExecQueryPro(SQLStr);
    end;
 if KindFlag then
    begin
     SQLStr := 'Alter Table StockH Add Kind Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update StockH Set Kind = 0';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Alter Table StockH Alter COLUMN Notes nvarchar(255) Null';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.UpgradeStockITablePro;
var
 SQLStr: string;
 ItemCodeFlag, PriceFlag, GSTRateFlag, KindFlag: boolean;
begin
 SQLStr := 'Select * From StockI Where Qty=0';
 OpenQuery(SQLStr);
 ItemCodeFlag := Query.FindField('ItemCode') <> NIL;
 PriceFlag := Query.FindField('Price') = NIL;
 GSTRateFlag := Query.FindField('GSTRate') = NIL;
 KindFlag := Query.FindField('Kind') = NIL;
 Query.Close;
 if ItemCodeFlag then
    begin
     SQLStr := 'Alter Table StockI Add Code nvarchar(8) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update StockI Set Code=ItemCode';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table StockI Drop COLUMN ItemCode';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table StockI Alter COLUMN Code nvarchar(8) Null';
     ExecQueryPro(SQLStr);
    end;
 if PriceFlag then
    begin
     SQLStr := 'Alter Table StockI Add Price Float Null';
     ExecQueryPro(SQLStr);
    end;
 if GSTRateFlag then
    begin
     SQLStr := 'Alter Table StockI Add GSTRate Float Null';
     ExecQueryPro(SQLStr);
    end;
 if KindFlag then
    begin
     SQLStr := 'Alter Table StockI Add Kind Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update StockI Set Kind = 0';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Update StockTable Set LastOrderPrice=T.Price ' +
           'From StockTable Left Join ' +
           '(Select StockI.Code, StockI.ReceiveNo, Price ' +
           'From StockI, (Select Max(ReceiveNo) As ReceiveNo, ' +
           'Code From StockI Where Kind=0 Group By Code) As I ' +
           'Where StockI.Code=I.Code and StockI.ReceiveNo=I.ReceiveNo) As T ' +
           'On T.Code=StockTable.Code';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.CreateInstructionTablePro;
var
 SQLStr: string;
 IDFlag, MaximunChargeFlag: boolean;
 I: integer;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'InstructionLink' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table InstructionLink(' +
               'Code nvarchar(4) Null, ' +
               'ItemCode nvarchar(4) Null, ' +
               'Qty Float Null, Price Float Null, ' +
               'Condition SmallInt Null, ' +
               'Kind Integer Null, ' +
               'MaximunCharge Bit Null, ' +
               'ID Integer Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Select * From InstructionLink Where Code=' + Chr(39) + Chr(39);
     OpenQuery(SQLStr);
     IDFlag := Query.FindField('ID') = NIL;
     MaximunChargeFlag := Query.FindField('MaximunCharge') = NIL;
     if IDFlag then
        begin
         SQLStr := 'Alter Table InstructionLink Add ID Integer Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Select * From InstructionLink Order By ItemCode, Code';
         OpenQuery(SQLStr);
         with Query do
          begin
           I := 0;
           while Not EOF do
            begin
             I := I + 1;
             SQLStr := 'Update InstructionLink Set ID=' + IntToStr(I) +
                       ' Where Code=' + Chr(39) + FieldByName('Code').AsString + Chr(39) +
                       ' and ItemCode=' + Chr(39) + FieldByName('ItemCode').AsString + Chr(39);
             ExecQueryPro(SQLStr);
             Next;
            end;
          end;
        end;
     Query.Close;
     if MaximunChargeFlag then
        begin
         SQLStr := 'Alter Table InstructionLink Add MaximunCharge Bit Null';
         ExecQueryPro(SQLStr);
         SQLStr := 'Update InstructionLink Set MaximunCharge=0';
         ExecQueryPro(SQLStr);
        end;
    end;
end;

procedure TUpgradeForm.CreateBankTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'BankHead' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table BankHead (' +
               'BankName nvarchar(30) Null, ' +
               'AccountNo nvarchar(20) Null,' +
               'AccountName nvarchar(30) Null,' +
               'CreateDate DateTime Null,' +
               'OpeningBalance Float Null)';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'BankTransaction' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table BankTransaction (' +
               'AccountNo nvarchar(20) Null, ' +
               'AcctDate TimeStamp Null, ' +
               'Credit Float Null, ' +
               'Debit Float Null, ' +
               'Reference nvarchar(20) Null, ' +
               'Notes nvarchar(60) Null, ' +
               'IDNo Integer Null)';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table BankTransaction Alter COLUMN Notes nvarchar(60) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.CreateAttendanceTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'Attendance' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table Attendance(' +
               'StaffName nvarchar(15) Null, ' +
               'LoginTime DateTime Null,' +
               'LogoutTime DateTime Null,' +
               'IDNo Integer Null)';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.UpgradeTableSetPro;
var
 SQLStr: string;
 StatusFlag, FontNameFlag, FontSizeFlag, FontBoldFlag, FontItalicFlag,
 FontUnderlineFlag, FontStrikeoutFlag, ButtonShapeFlag, ButtonHeightFlag,
 ButtonWidthFlag, ButtonXFlag, ButtonYFlag, PropertyFlag, DescriptionFlag,
 PageFlag, IDFlag, PDAPositionFlag, MinimumChargePerTableFlag,
 ServiceStatusFlag, TableLockedFlag: Boolean;
 PDAPosition: integer;
begin
 SQLStr := 'Select * From TableSet Where TableNo=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 StatusFlag := Query.FindField('Status') = NIL;
 FontNameFlag := Query.FindField('FontName') = NIL;
 FontSizeFlag := Query.FindField('FontSize') = NIL;
 FontBoldFlag := Query.FindField('FontBold') = NIL;
 FontItalicFlag := Query.FindField('FontItalic') = NIL;
 FontUnderlineFlag := Query.FindField('FontUnderline') = NIL;
 FontStrikeoutFlag := Query.FindField('FontStrikeout') = NIL;
 ButtonShapeFlag := Query.FindField('ButtonShape') = NIL;
 ButtonHeightFlag := Query.FindField('ButtonHeight') = NIL;
 ButtonWidthFlag := Query.FindField('ButtonWidth') = NIL;
 ButtonXFlag := Query.FindField('ButtonX') = NIL;
 ButtonYFlag := Query.FindField('ButtonY') = NIL;
 PropertyFlag := Query.FindField('PropertyFlag') = NIL;
 DescriptionFlag := Query.FindField('Description') = NIL;
 PageFlag := Query.FindField('PageFlag') = NIL;
 PDAPositionFlag := Query.FindField('PDAPosition') = NIL;
 MinimumChargePerTableFlag := Query.FindField('MinimumChargePerTable') = NIL;
 ServiceStatusFlag := Query.FindField('ServiceStatus') = NIL;
 TableLockedFlag := Query.FindField('TableLocked') = NIL;
 IDFlag := Query.FindField('ID') <> NIL;
 Query.Close;
 if StatusFlag then
    begin
     SQLStr := 'Alter Table TableSet Add Status Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set Status=1';
     ExecQueryPro(SQLStr);
    end;
 if FontNameFlag then
    begin
     SQLStr := 'Alter Table TableSet Add FontName nvarchar(50) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set FontName=' + Chr(39) + 'MS Sans Serif' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 if FontSizeFlag then
    begin
     SQLStr := 'Alter Table TableSet Add FontSize INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set FontSize=8';
     ExecQueryPro(SQLStr);
    end;
 if FontBoldFlag then
    begin
     SQLStr := 'Alter Table TableSet Add FontBold Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set FontBold=0';
     ExecQueryPro(SQLStr);
    end;
 if FontItalicFlag then
    begin
     SQLStr := 'Alter Table TableSet Add FontItalic Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set FontItalic=0';
     ExecQueryPro(SQLStr);
    end;
 if FontUnderlineFlag then
    begin
     SQLStr := 'Alter Table TableSet Add FontUnderline Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set FontUnderline=0';
     ExecQueryPro(SQLStr);
    end;
 if FontStrikeoutFlag then
    begin
     SQLStr := 'Alter Table TableSet Add FontStrikeout Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set FontStrikeout=0';
     ExecQueryPro(SQLStr);
    end;
 if ButtonShapeFlag then
    begin
     SQLStr := 'Alter Table TableSet Add ButtonShape Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set ButtonShape=2';
     ExecQueryPro(SQLStr);
    end;
 if ButtonWidthFlag then
    begin
     SQLStr := 'Alter Table TableSet Add ButtonWidth Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set ButtonWidth=60';
     ExecQueryPro(SQLStr);
    end;
 if ButtonHeightFlag then
    begin
     SQLStr := 'Alter Table TableSet Add ButtonHeight Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set ButtonHeight=60';
     ExecQueryPro(SQLStr);
    end;
 if ButtonXFlag then
    begin
     SQLStr := 'Alter Table TableSet Add ButtonX Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set ButtonX=10';
     ExecQueryPro(SQLStr);
    end;
 if ButtonYFlag then
    begin
     SQLStr := 'Alter Table TableSet Add ButtonY Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set ButtonY=10';
     ExecQueryPro(SQLStr);
    end;
 if PropertyFlag then
    begin
     SQLStr := 'Alter Table TableSet Add PropertyFlag Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set PropertyFlag = 1';
     ExecQueryPro(SQLStr);
    end;
 if DescriptionFlag then
    begin
     SQLStr := 'Alter Table TableSet Add Description nvarchar(20) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set Description=TableNo';
     ExecQueryPro(SQLStr);
    end;
 if PageFlag then
    begin
     SQLStr := 'Alter Table TableSet Add PageFlag Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set PageFlag = 1';
     ExecQueryPro(SQLStr);
    end;
 if PDAPositionFlag then
    begin
     SQLStr := 'Alter Table TableSet Add PDAPosition Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Select TableNo From TableSet Order By TableNo';
     OpenTempQuery(SQLStr);
     PDAPosition := 1;
     while Not TempQuery.EOF do
      begin
       SQLStr := 'Update TableSet Set PDAPosition=' + IntToStr(PDAPosition) +
                 'Where TableNo=' + Chr(39) + TempQuery.FieldByName('TableNo').AsString + Chr(39);
       ExecQueryPro(SQLStr);
       Inc(PDAPosition);
       TempQuery.Next;
      end;
     TempQuery.Close;
    end;
 if MinimumChargePerTableFlag then
    begin
     SQLStr := 'Alter Table TableSet Add MinimumChargePerTable Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set MinimumChargePerTable = 0';
     ExecQueryPro(SQLStr);
    end;
 if ServiceStatusFlag then
    begin
     SQLStr := 'Alter Table TableSet Add ServiceStatus Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set ServiceStatus = 0';
     ExecQueryPro(SQLStr);
    end;
 if TableLockedFlag then
    begin
     SQLStr := 'Alter Table TableSet Add TableLocked Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update TableSet Set TableLocked = 0';
     ExecQueryPro(SQLStr);
    end;
 if IDFlag then
    begin
     SQLStr := 'Alter Table TableSet Drop Column ID';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.UpdateInstructionLinkTable;
var
 SQLStr: string;
 QtyFlag, PriceFlag, ConditionFlag: boolean;
begin
 SQLStr := 'Select * From InstructionLink Where Code=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 QtyFlag := Query.FindField('Qty') = NIL;
 PriceFlag := Query.FindField('Price') = NIL;
 ConditionFlag := Query.FindField('Condition') = NIL;
 Query.Close;
 if QtyFlag then
    begin
     SQLStr := 'Alter Table InstructionLink Add Qty Float Null';
     ExecQueryPro(SQLStr);
    end;
 if PriceFlag then
    begin
     SQLStr := 'Alter Table InstructionLink Add Price Float Null';
     ExecQueryPro(SQLStr);
    end;
 if ConditionFlag then
    begin
     SQLStr := 'Alter Table InstructionLink Add Condition SmallInt Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update InstructionLink Set Condition=1';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.UpgradeAccessMenuTablePro;
var
 SQLStr: string;
 DailyReportFlag, OpenCashDrawerFlag, BankAccountSetupFlag,
 InvoiceCondition, BookingFormCondition, DatabaseBackup,
 DatabaseRestore, DataImport, DataExport, BankReconciliationFlag,
 BankAccountManagementFlag, TableSetupFlag, AttendanceReport,
 BirthdayFlag, TelephoneFlag, MobileFlag, FaxFlag, AddressFlag, RateFlag,
 MenuListFlag, InquiryStockHistoryFlag, PrintInvoiceFlag, PaymentFlag,
 PrintJobListFlag, VoidAuthorityFlag, PurchaseOrderFlag,
 PurchasePayableFlag, InquiryStockReceiveFlag, AuthoriseDiscountFlag,
 AuthoriseCloseWindowFlag, OrderListMenuFlag, TableOrderMenuFlag,
 PointOfSalesMenuFlag, CheckDailyReportFlag, AuthoriseRefundFlag,
 UserManagerFlag, AllowEditOrderFlag, PrintDailyReportFlag,
 DrawerPortNumberFlag, DefaultDrawerPortNumberFlag,
 EditAttendanceRecordFlag, StockAdjustmentMenuFlag,
 StockAdjustmentReportMenuFlag, PhoneOrderMenuFlag,
 CashPayOutMenuFlag, CashFloatMenuFlag, AssignDriverAuthorisedFlag,
 DepositMenuFlag, WastageMenuFlag, WastageReportMenuFlag,
 AuthrisedCancelHoldOrderFlag, ManuallyEnterDiscountRateFlag,
 EditOrderPaymentFlag, InquirySalesRelatedReportDaysFlag: boolean;
begin
 SQLStr := 'Select * From AccessMenu Where StaffName=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 DailyReportFlag := Query.FindField('DailyReportMenu') = NIL;
 OpenCashDrawerFlag := Query.FindField('OpenCashDrawerMenu') = NIL;
 BankAccountSetupFlag := Query.FindField('BankAccountsetupMenu') = NIL;
 BankReconciliationFlag := Query.FindField('BankReconciliationMenu') = NIL;
 InvoiceCondition := Query.FindField('InvoiceConditionSetupMenu') = NIL;
 BookingFormCondition := Query.FindField('BookingFormConditionSetupMenu') = NIL;
 DatabaseBackup := Query.FindField('DatabaseBackupMenu') = NIL;
 DatabaseRestore := Query.FindField('DatabaseRestoreMenu') = NIL;
 BankAccountManagementFlag := Query.FindField('BankAccountManagementMenu') = NIL;
 TableSetupFlag := Query.FindField('TableInformationSetupMenu') = NIL;
 BirthdayFlag := Query.FindField('Birthday') = NIL;
 TelephoneFlag := Query.FindField('Telephone') = NIL;
 MobileFlag := Query.FindField('Mobile') = NIL;
 FaxFlag := Query.FindField('Fax') = NIL;
 AddressFlag := Query.FindField('Address') = NIL;
 RateFlag := Query.FindField('Rate') = NIL;
 AttendanceReport := Query.FindField('AttendanceReportMenu') = NIL;
 PrintInvoiceFlag := Query.FindField('PrintInvoiceAuthority') = NIL;
 PaymentFlag := Query.FindField('PaymentAuthority') = NIL;
 PrintJobListFlag := Query.FindField('PrintJobListAuthority') = NIL;
 VoidAuthorityFlag := Query.FindField('VoidItemAuthority') = NIL;
 PurchaseOrderFlag := Query.FindField('PurchaseOrderMenu') = NIL;
 PurchasePayableFlag := Query.FindField('PurchasePayableMenu') = NIL;
 AuthoriseDiscountFlag := Query.FindField('AuthoriseDiscount') = NIL;
 AuthoriseCloseWindowFlag := Query.FindField('AuthoriseCloseWindow') = NIL;
 TableOrderMenuFlag := Query.FindField('TableOrderMenu') = NIL;
 PointOfSalesMenuFlag := Query.FindField('PointOfSalesMenu') = NIL;
 CheckDailyReportFlag := Query.FindField('CheckDailyReport') = NIL;
 AuthoriseRefundFlag := Query.FindField('AuthoriseRefund') = NIL;
 UserManagerFlag := Query.FindField('UserManager') = NIL;
 PrintDailyReportFlag := Query.FindField('PrintDailyReport') = NIL;
 AllowEditOrderFlag := Query.FindField('AllowEditOrder') = NIL;
 DrawerPortNumberFlag := Query.FindField('DrawerPortNumber') = NIL;
 DefaultDrawerPortNumberFlag := Query.FindField('DefaultDrawerPortNumber') = NIL;
 EditAttendanceRecordFlag := Query.FindField('EditAttendanceRecord') = NIL;
 StockAdjustmentMenuFlag := Query.FindField('StockAdjustmentMenu') = NIL;
 StockAdjustmentReportMenuFlag := Query.FindField('StockAdjustmentReportMenu') = NIL;
 PhoneOrderMenuFlag := Query.FindField('PhoneOrderMenu') = NIL;
 CashPayOutMenuFlag := Query.FindField('CashPayOutMenu') = NIL;
 CashFloatMenuFlag := Query.FindField('CashFloatMenu') = NIL;
 AssignDriverAuthorisedFlag := Query.FindField('AssignDriverAuthorised') = NIL;
 DepositMenuFlag := Query.FindField('DepositMenu') = NIL;
 WastageMenuFlag := Query.FindField('WastageMenu') = NIL;
 WastageReportMenuFlag := Query.FindField('WastageReportMenu') = NIL;
 AuthrisedCancelHoldOrderFlag := Query.FindField('AuthrisedCancelHoldOrder') = NIL;
 ManuallyEnterDiscountRateFlag := Query.FindField('ManuallyEnterDiscountRate') = NIL;
 EditOrderPaymentFlag := Query.FindField('EditOrderPayment') = NIL;
 InquirySalesRelatedReportDaysFlag := Query.FindField('InquirySalesRelatedReportDays') = NIL;
 MenuListFlag := Query.FindField('MenuListMenu') <> NIL;
 InquiryStockHistoryFlag := Query.FindField('InquiryStockHistoryMenu') <> NIL;
 OrderListMenuFlag := Query.FindField('OrderListMenu') <> NIL;
 InquiryStockReceiveFlag := Query.FindField('InquiryStockReceiveMenu') <> NIL;
 DataImport := Query.FindField('DataImportMenu') <> NIL;
 DataExport := Query.FindField('DataExportMenu') <> NIL;
 Query.Close;
 if DailyReportFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add DailyReportMenu Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if OpenCashDrawerFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add OpenCashDrawerMenu Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if InvoiceCondition then
    begin
     SQLStr := 'Alter Table AccessMenu Add InvoiceConditionSetupMenu Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if BookingFormCondition then
    begin
     SQLStr := 'Alter Table AccessMenu Add BookingFormConditionSetupMenu Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if DatabaseBackup then
    begin
     SQLStr := 'Alter Table AccessMenu Add DatabaseBackupMenu Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if DatabaseRestore then
    begin
     SQLStr := 'Alter Table AccessMenu Add DatabaseRestoreMenu Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if BankAccountSetupFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add BankAccountSetupMenu Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if BankReconciliationFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add BankReconciliationMenu Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if Not BankAccountManagementFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Drop COLUMN BankAccountManagementMenu';
     ExecQueryPro(SQLStr);
    end;
 if TableSetupFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add TableInformationSetupMenu Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if BirthdayFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add Birthday DateTime Null';
     ExecQueryPro(SQLStr);
    end;
 if TelephoneFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add Telephone nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
 if MobileFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add Mobile nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
 if FaxFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add Fax nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
 if AddressFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add Address nvarchar(100) Null';
     ExecQueryPro(SQLStr);
    end;
 if RateFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add Rate Float Null';
     ExecQueryPro(SQLStr);
    end;
 if AttendanceReport then
    begin
     SQLStr := 'Alter Table AccessMenu Add AttendanceReportMenu Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if MenuListFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Drop COLUMN MenuListMenu';
     ExecQueryPro(SQLStr);
    end;
 if InquiryStockHistoryFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Drop COLUMN InquiryStockHistoryMenu';
     ExecQueryPro(SQLStr);
    end;
 if PrintInvoiceFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add PrintInvoiceAuthority Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set PrintInvoiceAuthority=1';
     ExecQueryPro(SQLStr);
    end;
 if PrintJobListFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add PrintJobListAuthority Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set PrintJobListAuthority=1';
     ExecQueryPro(SQLStr);
    end;
 if PaymentFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add PaymentAuthority Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set PaymentAuthority=1';
     ExecQueryPro(SQLStr);
    end;
 if VoidAuthorityFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add VoidItemAuthority Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set VoidItemAuthority=1';
     ExecQueryPro(SQLStr);
    end;
 if PurchaseOrderFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add PurchaseOrderMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set PurchaseOrderMenu=0';
     ExecQueryPro(SQLStr);
    end;
 if PurchasePayableFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add PurchasePayableMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set PurchasePayableMenu=0';
     ExecQueryPro(SQLStr);
    end;
  if AuthoriseDiscountFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add AuthoriseDiscount Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set AuthoriseDiscount=0';
     ExecQueryPro(SQLStr);
    end;
  if AuthoriseCloseWindowFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add AuthoriseCloseWindow Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set AuthoriseCloseWindow=0';
     ExecQueryPro(SQLStr);
    end;
 if TableOrderMenuFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add TableOrderMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set TableOrderMenu=OrderListMenu';
     ExecQueryPro(SQLStr);
    end;
 if PointOfSalesMenuFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add PointOfSalesMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set PointOfSalesMenu=OrderListMenu';
     ExecQueryPro(SQLStr);
    end;
 if CheckDailyReportFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add CheckDailyReport Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set CheckDailyReport=0';
     ExecQueryPro(SQLStr);
    end;
 if AuthoriseRefundFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add AuthoriseRefund Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set AuthoriseRefund=0';
     ExecQueryPro(SQLStr);
    end;
 if UserManagerFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add UserManager Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set UserManager=Supervisor';
     ExecQueryPro(SQLStr);
    end;
 if AllowEditOrderFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add AllowEditOrder Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set AllowEditOrder=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintDailyReportFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add PrintDailyReport Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set PrintDailyReport=1';
     ExecQueryPro(SQLStr);
    end;
 if DrawerPortNumberFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add DrawerPortNumber Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set DrawerPortNumber=0';
     ExecQueryPro(SQLStr);
    end;
 if DefaultDrawerPortNumberFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add DefaultDrawerPortNumber Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set DefaultDrawerPortNumber=0';
     ExecQueryPro(SQLStr);
    end;
 if EditAttendanceRecordFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add EditAttendanceRecord Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set EditAttendanceRecord=0';
     ExecQueryPro(SQLStr);
    end;
 if StockAdjustmentMenuFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add StockAdjustmentMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set StockAdjustmentMenu=0';
     ExecQueryPro(SQLStr);
    end;
 if StockAdjustmentReportMenuFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add StockAdjustmentReportMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set StockAdjustmentReportMenu=0';
     ExecQueryPro(SQLStr);
    end;
 if PhoneOrderMenuFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add PhoneOrderMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set PhoneOrderMenu=1';
     ExecQueryPro(SQLStr);
    end;
 if CashPayOutMenuFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add CashPayOutMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set CashPayOutMenu=1';
     ExecQueryPro(SQLStr);
    end;
 if CashFloatMenuFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add CashFloatMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set CashFloatMenu=1';
     ExecQueryPro(SQLStr);
    end;
 if AssignDriverAuthorisedFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add AssignDriverAuthorised Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set AssignDriverAuthorised=1';
     ExecQueryPro(SQLStr);
    end;
 if DepositMenuFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add DepositMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set DepositMenu=0';
     ExecQueryPro(SQLStr);
    end;
 if WastageMenuFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add WastageMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set WastageMenu=0';
     ExecQueryPro(SQLStr);
    end;
 if WastageReportMenuFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add WastageReportMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set WastageReportMenu=0';
     ExecQueryPro(SQLStr);
    end;
 if AuthrisedCancelHoldOrderFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add AuthrisedCancelHoldOrder Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set AuthrisedCancelHoldOrder=0';
     ExecQueryPro(SQLStr);
    end;
 if ManuallyEnterDiscountRateFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add ManuallyEnterDiscountRate Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set ManuallyEnterDiscountRate=0';
     ExecQueryPro(SQLStr);
    end;
 if EditOrderPaymentFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add EditOrderPayment Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set EditOrderPayment=0';
     ExecQueryPro(SQLStr);
    end;
 if InquirySalesRelatedReportDaysFlag then
    begin
     SQLStr := 'Alter Table AccessMenu Add InquirySalesRelatedReportDays Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update AccessMenu Set InquirySalesRelatedReportDays=0';
     ExecQueryPro(SQLStr);
    end;
 if OrderListMenuFlag then
     begin
      SQLStr := 'Alter Table AccessMenu Drop COLUMN OrderListMenu';
      ExecQueryPro(SQLStr);
     end;
 if InquiryStockReceiveFlag then
     begin
      SQLStr := 'Alter Table AccessMenu Drop COLUMN InquiryStockReceiveMenu';
      ExecQueryPro(SQLStr);
     end;
 if DataImport then
    begin
     SQLStr := 'Alter Table AccessMenu Drop Column DataImportMenu';
     ExecQueryPro(SQLStr);
    end;
 if DataExport then
    begin
     SQLStr := 'Alter Table AccessMenu Drop Column DataExportMenu';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Alter Table AccessMenu Alter COLUMN SecureCode nvarchar(16)';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.UpgradeMenuTablePro;
var
 SQLStr: string;
begin
 // Menu
 SQLStr := 'Alter Table Menu Alter Column MenuName nvarchar(100) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Menu Set MenuName=RTRIM(MenuName) Where MenuName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Menu Alter Column FieldName nvarchar(40) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Menu Set FieldName=RTRIM(FieldName) Where FieldName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'DailyReportMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Inquiry Individual Daily Report' + Chr(39) + ',' +
               Chr(39) + 'DailyReportMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Inquiry Individual Daily Report' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'DailyReportMenu' + Chr(39);
     ExecQueryPro(SQLStr);
    end;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'OpenCashDrawerMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Open Cash Drawer' + Chr(39) + ',' +
               Chr(39) + 'OpenCashDrawerMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Open Cash Drawer' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'OpenCashDrawerMenu' + Chr(39);
     ExecQueryPro(SQLStr);
    end;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'InvoiceConditionSetupMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Invoice Condition Setup' + Chr(39) + ',' +
               Chr(39) + 'InvoiceConditionSetupMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'BookingFormConditionSetupMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Booking Form Condition Setup' + Chr(39) + ',' +
               Chr(39) + 'BookingFormConditionSetupMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'DatabaseBackupMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Database Backup' + Chr(39) + ',' +
               Chr(39) + 'DatabaseBackupMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'DatabaseRestoreMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Database Restore' + Chr(39) + ',' +
               Chr(39) + 'DatabaseRestoreMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'BankAccountSetupMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Bank Account Setup' + Chr(39) + ',' +
               Chr(39) + 'BankAccountSetupMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'BankReconciliationMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Bank Reconciliation' + Chr(39) + ',' +
               Chr(39) + 'BankReconciliationMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'TableInformationSetupMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Table Information Setup' + Chr(39) + ',' +
               Chr(39) + 'TableInformationSetupMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'AttendanceReportMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Inquiry Attendance Report' + Chr(39) + ',' +
               Chr(39) + 'AttendanceReportMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Inquiry Attendance Report' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'AttendanceReportMenu' + Chr(39);
     ExecQueryPro(SQLStr);
    end;

 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'PaymentAuthority' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to do Payment Receive' + Chr(39) + ',' +
               Chr(39) + 'PaymentAuthority' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to do Payment Receive' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'PaymentAuthority' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'PrintInvoiceAuthority' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to Print Invoice' + Chr(39) + ',' +
               Chr(39) + 'PrintInvoiceAuthority' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to Print Invoice' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'PrintInvoiceAuthority' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'PrintJobListAuthority' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to Print Job List' + Chr(39) + ',' +
               Chr(39) + 'PrintJobListAuthority' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to Print Job List' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'PrintJobListAuthority' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'VoidItemAuthority' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to Void Sales Item' + Chr(39) + ',' +
               Chr(39) + 'VoidItemAuthority' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to Void Sales Item' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'VoidItemAuthority' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'PurchaseOrderMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Purchase Order' + Chr(39) + ',' +
               Chr(39) + 'PurchaseOrderMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'PurchasePayableMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Purchase Payable' + Chr(39) + ',' +
               Chr(39) + 'PurchasePayableMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'AuthoriseDiscount' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to do Customer Discount ' + Chr(39) + ',' +
               Chr(39) + 'AuthoriseDiscount' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to do Customer Discount' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'AuthoriseDiscount' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'AuthoriseCloseWindow' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to Close Sales Window' + Chr(39) + ',' +
               Chr(39) + 'AuthoriseCloseWindow' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to Close Sales Window' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'AuthoriseCloseWindow' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'TableOrderMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Table Service' + Chr(39) + ',' +
               Chr(39) + 'TableOrderMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Table Service' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'TableOrderMenu' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'PointOfSalesMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Quick Service' + Chr(39) + ',' +
               Chr(39) + 'PointOfSalesMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Quick Service' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'PointOfSalesMenu' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'CheckDailyReport' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Inquiry Daily Report' + Chr(39) + ',' +
               Chr(39) + 'CheckDailyReport' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Inquiry Daily Report' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'CheckDailyReport' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'AuthoriseRefund' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to do Sales Refund' + Chr(39) + ',' +
               Chr(39) + 'AuthoriseRefund' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to do Sales Refund' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'AuthoriseRefund' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'UserManager' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'User Manager' + Chr(39) + ',' +
               Chr(39) + 'UserManager' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'AllowEditOrder' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to Edit Paid in Full Order' + Chr(39) + ',' +
               Chr(39) + 'AllowEditOrder' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to Edit Paid in Full Order' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'AllowEditOrder' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'PrintDailyReport' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Print Daily Report' + Chr(39) + ',' +
               Chr(39) + 'PrintDailyReport' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'EditAttendanceRecord' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Edit Attendance Record' + Chr(39) + ',' +
               Chr(39) + 'EditAttendanceRecord' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'StockAdjustmentMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Stock Adjustment' + Chr(39) + ',' +
               Chr(39) + 'StockAdjustmentMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'StockAdjustmentReportMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Stock Adjustment Report' + Chr(39) + ',' +
               Chr(39) + 'StockAdjustmentReportMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'PhoneOrderMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Phone Order' + Chr(39) + ',' +
               Chr(39) + 'PhoneOrderMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'CashPayOutMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Cash Pay Out' + Chr(39) + ',' +
               Chr(39) + 'CashPayOutMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'CashFloatMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Cash Float (Cash In / Out)' + Chr(39) + ',' +
               Chr(39) + 'CashFloatMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'AssignDriverAuthorised' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to Assign Phone Order Delivery Driver' + Chr(39) + ',' +
               Chr(39) + 'AssignDriverAuthorised' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to Assign Phone Order Delivery Driver' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'AssignDriverAuthorised' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'DepositMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to Receive Deposit' + Chr(39) + ',' +
               Chr(39) + 'DepositMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to Receive Deposit' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'DepositMenu' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'WastageMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to do Wastage' + Chr(39) + ',' +
               Chr(39) + 'WastageMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to do Wastage' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'WastageMenu' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'WastageReportMenu' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Inquiry Wastage Report' + Chr(39) + ',' +
               Chr(39) + 'WastageReportMenu' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Inquiry Wastage Report' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'WastageReportMenu' + Chr(39);
     ExecQueryPro(SQLStr);
    end;

 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'AuthrisedCancelHoldOrder' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to Cancel Hold Order' + Chr(39) + ',' +
               Chr(39) + 'AuthrisedCancelHoldOrder' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to Cancel Hold Order' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'AuthrisedCancelHoldOrder' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'ManuallyEnterDiscountRate' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Authorize to Manually Enter Sales Discount Rate' + Chr(39) + ',' +
               Chr(39) + 'ManuallyEnterDiscountRate' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end
   else 
    begin
     SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to Manually Enter Sales Discount Rate' + Chr(39) +
               ' Where FieldName=' + Chr(39) + 'ManuallyEnterDiscountRate' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Select * From Menu Where FieldName=' + Chr(39) + 'EditOrderPayment' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into Menu(MenuName, FieldName) ' +
               'Values(' + Chr(39) + 'Edit Order Payment' + Chr(39) + ',' +
               Chr(39) + 'EditOrderPayment' + Chr(39) + ')';
     ExecQueryPro(SQLStr);
    end;
 Query.Close;

 SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Authorize to do Local System Configuration' + Chr(39) +
           'Where FieldName=' + Chr(39) + 'PrinterSetupMenu' + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Update Menu Set MenuName=' + Chr(39) + 'Inquiry Sales Related Reports' + Chr(39) +
           'Where FieldName=' + Chr(39) + 'SalesReportMenu' + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Delete From Menu Where FieldName=' + Chr(39) + 'MenuListMenu' + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Delete From Menu Where FieldName=' + Chr(39) + 'InquiryStockHistoryMenu' + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Delete From Menu Where FieldName=' + Chr(39) + 'InquiryStockReceiveMenu' + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Delete From Menu Where FieldName= ' + Chr(39) + 'OrderListMenu' + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Delete From Menu Where FieldName=' + Chr(39) + 'DataImportMenu' + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Delete From Menu Where FieldName= ' + Chr(39) + 'DataExportMenu' + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Delete From Menu Where FieldName=' + Chr(39) + 'BankAccountManagementMenu' + Chr(39);
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.UpgradeOrderHTablePro;
var
 SQLStr: string;
 OrderPrintFlag, TipsFlag, NotesFlag, BookingNoFlag, CreditFlag,
 ServiceChargeFlag, ServiceChargeRateFlag, SurchargeFlag, MachineIDFlag,
 BillKindFlag, DollarDiscountFlag, DueTimeFlag, DiscountKindFlag, DeliveryFlag,
 OtherChargeFlag, OtherChargeRateFlag, PriceIncludesGSTFlag, CurrentGSTRateFlag,
 RewardPointsFlag, CustomerNameFlag, SplitBillFlag, PresetDiscountCodeFlag,
 DiscountOperatorFlag: boolean;
begin
 SQLStr := 'Select * From OrderH Where OrderNo=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 OrderPrintFlag := Query.FindField('OrderPrinted') = NIL;
 TipsFlag := Query.FindField('Tips') = NIL;
 NotesFlag := Query.FindField('Notes') = NIL;
 BookingNoFlag := Query.FindField('BookingNo') = NIL;
 CreditFlag := Query.FindField('Credit') = NIL;
 ServiceChargeFlag := Query.FindField('ServiceCharge') = NIL;
 ServiceChargeRateFlag := Query.FindField('ServiceChargeRate') = NIL;
 SurchargeFlag := Query.FindField('Surcharge') = NIL;
 MachineIDFlag := Query.FindField('MachineID') = NIL;
 BillKindFlag := Query.FindField('BillKind') = NIL;
 DollarDiscountFlag := Query.FindField('DollarDiscount') = NIL;
 DueTimeFlag := Query.FindField('DueTime') = NIL;
 DiscountKindFlag := Query.FindField('DiscountKind') = NIL;
 DeliveryFlag := Query.FindField('Delivery') = NIL;
 OtherChargeFlag := Query.FindField('OtherCharge') = NIL;
 OtherChargeRateFlag := Query.FindField('OtherChargeRate') = NIL;
 PriceIncludesGSTFlag := Query.FindField('PriceIncludesGST') = NIL;
 CurrentGSTRateFlag := Query.FindField('CurrentGSTRate') = NIL;
 RewardPointsFlag := Query.FindField('RewardPoints') = NIL;
 CustomerNameFlag := Query.FindField('CustomerName') = NIL;
 SplitBillFlag := Query.FindField('SplitBill') = NIL;
 PresetDiscountCodeFlag := Query.FindField('PresetDiscountCode') = NIL;
 DiscountOperatorFlag := Query.FindField('DiscountOperator') = NIL;
 Query.Close;
 if OrderPrintFlag then
    begin
     SQLStr := 'Alter Table OrderH Add OrderPrinted Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set OrderPrinted=1 Where PaidAmount>=Amount';
     ExecQueryPro(SQLStr);
    end;
 if TipsFlag then
    begin
     SQLStr := 'Alter Table OrderH Add Tips Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set Tips=0';
     ExecQueryPro(SQLStr);
    end;
 if Not NotesFlag then
    begin
     SQLStr := 'Alter Table OrderH Drop COLUMN Notes';
     ExecQueryPro(SQLStr);
    end;
 if BookingNoFlag then
    begin
     SQLStr := 'Alter Table OrderH Add BookingNo nvarchar(8) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set BookingNo=Null';
     ExecQueryPro(SQLStr);
    end;
 if CreditFlag then
    begin
     SQLStr := 'Alter Table OrderH Add Credit Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set Credit=False';
     ExecQueryPro(SQLStr);
    end;
 if ServiceChargeFlag then
    begin
     SQLStr := 'Alter Table OrderH Add ServiceCharge Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set ServiceCharge=0';
     ExecQueryPro(SQLStr);
    end;
 if ServiceChargeRateFlag then
    begin
     SQLStr := 'Alter Table OrderH Add ServiceChargeRate Float';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set ServiceChargeRate=0';
     ExecQueryPro(SQLStr);
    end;
 if SurchargeFlag then
    begin
     SQLStr := 'Alter Table OrderH Add Surcharge Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set Surcharge = 0';
     ExecQueryPro(SQLStr);
    end;
 if MachineIDFlag then
    begin
     SQLStr := 'Alter Table OrderH Add MachineID nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Alter Table OrderH Alter COLUMN OrderNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Alter Table OrderH Alter COLUMN InvoiceNo nvarchar(11) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderH Set TableNo=' + Chr(39) + 'QuickSale' + Chr(39) +
           ' Where TableNo=' + Chr(39) + 'POS' + Chr(39);
 ExecQueryPro(SQLStr);
 if BillKindFlag then
    begin
     SQLStr := 'Alter Table OrderH Add BillKind Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set BillKind=0 ' +
               'Where TableNo<>' + Chr(39) + 'QuickSale' + Chr(39);
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set BillKind=1 ' +
               'Where TableNo=' + Chr(39) + 'QuickSale' + Chr(39);
     ExecQueryPro(SQLStr);
    end;
 if DollarDiscountFlag then
    begin
     SQLStr := 'Alter Table OrderH Add DollarDiscount Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set DollarDiscount=0 ';
     ExecQueryPro(SQLStr);
    end;
 if DueTimeFlag then
    begin
     SQLStr := 'Alter Table OrderH Add DueTime DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set DueTime=0';
     ExecQueryPro(SQLStr);
    end;
 if DiscountKindFlag then
    begin
     SQLStr := 'Alter Table OrderH Add DiscountKind Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set DiscountKind=0 Where DollarDiscount=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set DiscountKind=2 Where DollarDiscount>=0.01';
     ExecQueryPro(SQLStr);
    end;
 if DeliveryFlag then
    begin
     SQLStr := 'Alter Table OrderH Add Delivery Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set Delivery=0';
     ExecQueryPro(SQLStr);
    end;
 if OtherChargeFlag then
    begin
     SQLStr := 'Alter Table OrderH Add OtherCharge Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set OtherCharge=0';
     ExecQueryPro(SQLStr);
    end;
 if OtherChargeRateFlag then
    begin
     SQLStr := 'Alter Table OrderH Add OtherChargeRate Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set OtherChargeRate=0';
     ExecQueryPro(SQLStr);
    end;
 if PriceIncludesGSTFlag then
    begin
     SQLStr := 'Alter Table OrderH Add PriceIncludesGST Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set PriceIncludesGST=1';
     ExecQueryPro(SQLStr);
    end;
 if CurrentGSTRateFlag then
    begin
     SQLStr := 'Alter Table OrderH Add CurrentGSTRate Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set OrderH.CurrentGSTRate=Profile.DefaultGSTRate ' +
               'From OrderH, Profile';
     ExecQueryPro(SQLStr);
    end;
 if RewardPointsFlag then
    begin
     SQLStr := 'Alter Table OrderH Add RewardPoints Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set OrderH.RewardPoints=0';
     ExecQueryPro(SQLStr);
    end;
 if SplitBillFlag then
    begin
     SQLStr := 'Alter Table OrderH Add SplitBill Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set SplitBill = 0';
     ExecQueryPro(SQLStr);
    end;
 if PresetDiscountCodeFlag then
    begin
     SQLStr := 'Alter Table OrderH Add PresetDiscountCode nvarchar(3) Null';
     ExecQueryPro(SQLStr);
    end;
 if CustomerNameFlag then
    begin
     SQLStr := 'Alter Table OrderH Add CustomerName nvarchar(30) Null';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table OrderH Alter COLUMN CustomerName nvarchar(30) Null';
     ExecQueryPro(SQLStr);
    end;
 if DiscountOperatorFlag then
    begin
     SQLStr := 'Alter Table OrderH Add DiscountOperator nvarchar(15) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderH Set DiscountOperator = OpName';
     ExecQueryPro(SQLStr);
    end;

end;

procedure TUpgradeForm.UpgradeOrderITablePro;
var
 SQLStr: string;
 ConditionFlag, PriceSelectFlag, PaidQtyFlag, SeatFlag, SentToKitchenFlag,
 VoidReasonFlag, SpecialOrderFlag, CheckListPrintedFlag, VoidFlag,
 VoidOperatorFlag, OrderOperatorFlag, OriginalPriceFlag: boolean;
begin
 SQLStr := 'Select * From OrderI Where OrderNo=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 ConditionFlag := Query.FindField('Condition') = NIL;
 PriceSelectFlag := Query.FindField('PriceSelect') = NIL;
 PaidQtyFlag := Query.FindField('PaidQty') = NIL;
 SeatFlag := Query.FindField('Seat') = NIL;
 SentToKitchenFlag := Query.FindField('SentToKitchen') = NIL;
 VoidReasonFlag := Query.FindField('VoidReason') = NIL;
 SpecialOrderFlag := Query.FindField('SpecialOrder') = NIL;
 CheckListPrintedFlag := Query.FindField('CheckListPrinted') = NIL;
 VoidFlag := Query.FindField('VoidFlag') = NIL;
 OrderOperatorFlag := Query.FindField('OrderOperator') = NIL;
 OriginalPriceFlag := Query.FindField('OriginalPrice') = NIL;
 VoidOperatorFlag := Query.FindField('VoidOperator') <> NIL;
 Query.Close;
 if ConditionFlag then
    begin
     SQLStr := 'Alter Table OrderI Add Condition SMALLINT Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set Condition=0';
     ExecQueryPro(SQLStr);
    end;
 if PriceSelectFlag then
    begin
     SQLStr := 'Alter Table OrderI Add PriceSelect SMALLINT Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set PriceSelect=0';
     ExecQueryPro(SQLStr);
    end;
 if PaidQtyFlag then
    begin
     SQLStr := 'Alter Table OrderI Add PaidQty Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set PaidQty=0';
     ExecQueryPro(SQLStr);
    end;
 if SeatFlag then
    begin
     SQLStr := 'Alter Table OrderI Add Seat SMALLINT Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set Seat=0';
     ExecQueryPro(SQLStr);
    end;
 if SentToKitchenFlag then
    begin
     SQLStr := 'Alter Table OrderI Add SentToKitchen Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set SentToKitchen=1';
     ExecQueryPro(SQLStr);
    end;
 if VoidReasonFlag then
    begin
     SQLStr := 'Alter Table OrderI Add VoidReason nvarchar(2) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set VoidReason=Null';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table OrderI Alter COLUMN VoidReason nvarchar(2) Null';
     ExecQueryPro(SQLStr);
    end;
 if SpecialOrderFlag then
    begin
     SQLStr := 'Alter Table OrderI Add SpecialOrder nvarchar(255) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set SpecialOrder=Null';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table OrderI Alter COLUMN SpecialOrder nvarchar(255) Null';
     ExecQueryPro(SQLStr);
    end;
 if CheckListPrintedFlag then
    begin
     SQLStr := 'Alter Table OrderI Add CheckListPrinted Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set CheckListPrinted=1';
     ExecQueryPro(SQLStr);
    end;
 if VoidFlag then
    begin
     SQLStr := 'Alter Table OrderI Add VoidFlag Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set VoidFlag=0';
     ExecQueryPro(SQLStr);
    end;
 if OriginalPriceFlag then
    begin
     SQLStr := 'Alter Table OrderI Add OriginalPrice float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set OriginalPrice=MenuItem.Price ' +
               'From OrderI, MenuItem ' +
               'Where OrderI.ItemCode=MenuItem.ItemCode and OrderI.PriceSelect=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set OriginalPrice=MenuItem.Price1 ' +
               'From OrderI, MenuItem ' +
               'Where OrderI.ItemCode=MenuItem.ItemCode and OrderI.PriceSelect=1';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set OriginalPrice=MenuItem.Price2 ' +
               'From OrderI, MenuItem ' +
               'Where OrderI.ItemCode=MenuItem.ItemCode and OrderI.PriceSelect=2 ';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set OriginalPrice=MenuItem.Price3 ' +
               'From OrderI, MenuItem ' +
               'Where OrderI.ItemCode=MenuItem.ItemCode and OrderI.PriceSelect=3 ';
     ExecQueryPro(SQLStr);
    end;
 if OrderOperatorFlag then
    begin
     SQLStr := 'Alter Table OrderI Add OrderOperator nvarchar(15) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update OrderI Set OrderOperator=OrderH.OpName ' +
               'From OrderH, OrderI ' +
               'Where OrderH.OrderNo=OrderI.OrderNo';
     ExecQueryPro(SQLStr);
     if VoidOperatorFlag then
        begin
         SQLStr := 'Update OrderI Set OrderOperator=VoidOperator';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table OrderI Drop COLUMN VoidOperator';
         ExecQueryPro(SQLStr);
        end;
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Alter Table OrderI Alter COLUMN OrderNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.UpgradeMealPackageTablePro;
var
 SQLStr: string;
 ConditionFlag, PriceSelectFlag, IDFlag: boolean;
begin
 SQLStr := 'Select * From MealPackage Where ItemCode=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 ConditionFlag := Query.FindField('Condition') = NIL;
 PriceSelectFlag := Query.FindField('PriceSelect') = NIL;
 IDFlag := Query.FindField('ID') = NIL;
 Query.Close;
 if ConditionFlag then
    begin
     SQLStr := 'Alter Table MealPackage Add Condition SMALLINT Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MealPackage Set Condition=0';
     ExecQueryPro(SQLStr);
    end;
 if PriceSelectFlag then
    begin
     SQLStr := 'Alter Table MealPackage Add PriceSelect SMALLINT Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MealPackage Set PriceSelect=0';
     ExecQueryPro(SQLStr);
    end;
 if IDFlag then
    begin
     SQLStr := 'Alter Table MealPackage Add ID SMALLINT Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MealPackage Set ID=0';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.UpgradeBookHeadTablePro;
var
 SQLStr: string;
 KindFlag, ExpireTimeFlag: boolean;
begin
 SQLStr := 'Select * From BookTable Where BookingNo=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 KindFlag := Query.FindField('Kind') = NIL;
 ExpireTimeFlag := Query.FindField('ExpireTime') = NIL;
 Query.Close;
 if KindFlag then
    begin
     SQLStr := 'Alter Table BookTable Add Kind SMALLINT Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update BookTable Set Kind=0';
     ExecQueryPro(SQLStr);
    end;
 if ExpireTimeFlag then
    begin
     SQLStr := 'Alter Table BookTable Add ExpireTime DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update BookTable Set ExpireTime=0';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Alter Table BookTable Alter COLUMN TableNo nvarchar(50) Null';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.UpgradeBookItemTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'BookItemTable' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount <> 0 then
    begin
     SQLStr := 'DROP TABLE BookItemTable';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'BookDetail' + Chr(39);
 OpenQuery(SQLStr);
  if Query.RecordCount = 0 then
     begin
      SQLStr := 'Create Table BookDetail(' +
                'BookingNo nvarchar(8) Null, ' +
                'ItemCode nvarchar(4) Null, ' +
                'Qty Float Null, ' +
                'Price Float Null, ' +
                'PriceSelect SmallInt Null, ' +
                'Condition SmallInt Null, ' +
                'TaxRate Float Null, ' +
                'SpecialOrder nvarchar(255) Null, ' +
                'IDNo SmallInt Null)';
      ExecQueryPro(SQLStr);
     end
    else
     begin
      SQLStr := 'Alter Table BookDetail Alter COLUMN BookingNo nvarchar(8) Null';
      ExecQueryPro(SQLStr);
      SQLStr := 'Alter Table BookDetail Alter COLUMN ItemCode nvarchar(4) Null';
      ExecQueryPro(SQLStr);
      SQLStr := 'Alter Table BookDetail Alter COLUMN SpecialOrder nvarchar(255) Null';
      ExecQueryPro(SQLStr);
     end;
end;

procedure TUpgradeForm.UpgradeMenuItemTablePro;
var
 SQLStr: string;
 InstructionFlag, DiscountFlag, AllowDiscountFlag, MultipleFlag,
 AlertQtyFlag, StockQtyFlag, MeasureFlag, ButtonColorFlag, FontNameFlag,
 FontSizeFlag, FontColorFlag, FontBoldFlag, FontItalicFlag,
 FontUnderlineFlag, FontStrikeoutFlag, ButtonColor1Flag, FontName1Flag,
 FontSize1Flag, FontColor1Flag, FontBold1Flag, FontItalic1Flag,
 FontUnderline1Flag, FontStrikeout1Flag, JobListColorFlag, OnlyShowOnSubMenuFlag,
 OpenPriceFlag, ShowImage, ImageLoadPath, PrinterPort1, PrinterPort2,
 PrinterPort3, HappyHourPriceFlag1, HappyHourPriceFlag2, HappyHourPriceFlag3,
 HappyHourPriceFlag4, DefaultQtyFlag, MenuPosition, SendToKitchenScreen,
 SubDescriptionSwap, KitchenScreenFontColorFlag, SubCategoryFlag,
 PhoneOrderPositionFlag, AutoPopSpellInstructionKeyboardFlag,
 KitchenScreenFlag, StockControlFlag,ScalableItemFlag: boolean;
 Position: integer;
begin
 SQLStr := 'Select * From MenuItem Where ItemCode=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 InstructionFlag := Query.FindField('Instruction') = NIL;
 DiscountFlag := Query.FindField('Discount') <> NIL;
 AllowDiscountFlag := Query.FindField('AllowDiscount') = NIL;
 MultipleFlag := Query.FindField('Multiple') = NIL;
 ButtonColorFlag := Query.FindField('ButtonColor') = NIL;
 FontNameFlag := Query.FindField('FontName') = NIL;
 FontColorFlag := Query.FindField('FontColor') = NIL;
 FontSizeFlag := Query.FindField('FontSize') = NIL;
 FontBoldFlag := Query.FindField('FontBold') = NIL;
 FontItalicFlag := Query.FindField('FontItalic') = NIL;
 FontUnderlineFlag := Query.FindField('FontUnderline') = NIL;
 FontStrikeoutFlag := Query.FindField('FontStrikeout') = NIL;

 ButtonColor1Flag := Query.FindField('ButtonColor1') = NIL;
 FontName1Flag := Query.FindField('FontName1') = NIL;
 FontColor1Flag := Query.FindField('FontColor1') = NIL;
 FontSize1Flag := Query.FindField('FontSize1') = NIL;
 FontBold1Flag := Query.FindField('FontBold1') = NIL;
 FontItalic1Flag := Query.FindField('FontItalic1') = NIL;
 FontUnderline1Flag := Query.FindField('FontUnderline1') = NIL;
 FontStrikeout1Flag := Query.FindField('FontStrikeout1') = NIL;

 JobListColorFlag := Query.FindField('JobListColor') = NIL;
 OpenPriceFlag := Query.FindField('OpenPrice') = NIL;
 ShowImage := Query.FindField('ShowImage') <> NIL;
 ImageLoadPath := Query.FindField('ImageLoadPath') <> NIL;
 PrinterPort1 := Query.FindField('PrinterPort1') = NIL;
 PrinterPort2 := Query.FindField('PrinterPort2') = NIL;
 PrinterPort3 := Query.FindField('PrinterPort3') = NIL;
 HappyHourPriceFlag1 := Query.FindField('HappyHourPrice1') = NIL;
 HappyHourPriceFlag2 := Query.FindField('HappyHourPrice2') = NIL;
 HappyHourPriceFlag3 := Query.FindField('HappyHourPrice3') = NIL;
 HappyHourPriceFlag4 := Query.FindField('HappyHourPrice4') = NIL;
 DefaultQtyFlag := Query.FindField('DefaultQty') = NIL;
 MenuPosition := Query.FindField('MainPosition') = NIL;
 SubDescriptionSwap := Query.FindField('SubDescriptionSwap') = NIL;
 KitchenScreenFontColorFlag := Query.FindField('KitchenScreenFontColor') = NIL;
 OnlyShowOnSubMenuFlag := Query.FindField('OnlyShowOnSubMenu') = NIL;
 PhoneOrderPositionFlag := Query.FindField('PhoneOrderPosition') = NIL;
 AutoPopSpellInstructionKeyboardFlag := Query.FindField('AutoPopSpellInstructionKeyboard') = NIL;
 KitchenScreenFlag := Query.FindField('KitchenScreen1') = NIL;
 StockControlFlag :=  Query.FindField('StockControl') <> NIL;
 AlertQtyFlag := Query.FindField('AlertQty') <> NIL;
 StockQtyFlag := Query.FindField('StockQty') <> NIL;
 MeasureFlag :=  Query.FindField('Measure1') <> NIL;
 SendToKitchenScreen := Query.FindField('SendToKitchenScreen') <> NIL;
 SubCategoryFlag := Query.FindField('SubCategory') = NIL;
 ScalableItemFlag := Query.FindField('Scalable') = NIL;
 Query.Close;
 IF ScalableItemFlag then
    begin
      SQLStr := 'Alter Table MenuItem Add Scalable Bit Null';
      ExecQueryPro(SQLStr);
      SQLStr := 'Update Menuitem Set Scalable = 0';
      ExecQueryPro(SQLStr);
    end;   
 if InstructionFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add Instruction Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set Instruction=False';
     ExecQueryPro(SQLStr);
    end;
 if AllowDiscountFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add AllowDiscount Bit Null';
     ExecQueryPro(SQLStr);
     if DiscountFlag then
        begin
         SQLStr := 'Update MenuItem Set AllowDiscount=Discount';
         ExecQueryPro(SQLStr);
         SQLStr := 'Alter Table MenuItem Drop Column Discount';
         ExecQueryPro(SQLStr);
        end
       else
        begin
         SQLStr := 'Update MenuItem Set AllowDiscount=1';
         ExecQueryPro(SQLStr);
        end;
    end;
 if StockControlFlag then
    begin
     SQLStr := 'Alter Table MenuItem Drop COLUMN StockControl';
     ExecQueryPro(SQLStr);
    end;
 if AlertQtyFlag then
    begin
     SQLStr := 'Alter Table MenuItem Drop COLUMN AlertQty';
     ExecQueryPro(SQLStr);
    end;
 if StockQtyFlag then
    begin
     SQLStr := 'Alter Table MenuItem Drop COLUMN StockQty';
     ExecQueryPro(SQLStr);
    end;
 if MeasureFlag then
    begin
     SQLStr := 'Alter Table MenuItem Drop COLUMN Measure1';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Drop COLUMN Measure2';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Drop COLUMN Measure3';
     ExecQueryPro(SQLStr);
    end;
 if MultipleFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add Multiple Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set Multiple=False';
     ExecQueryPro(SQLStr);

     SQLStr := 'Alter Table MenuItem Add Price1 Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set Price1=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add Price2 Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set Price2=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add Price3 Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set Price3=0';
     ExecQueryPro(SQLStr);

     SQLStr := 'Alter Table MenuItem Add SubDescription nvarchar(10) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set SubDescription=Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add SubDescription1 nvarchar(10) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set SubDescription1=Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add SubDescription2 nvarchar(10) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set SubDescription2=Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add SubDescription3 nvarchar(10) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set SubDescription3=Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add BarCode nvarchar(30) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set BarCode=Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add BarCode1 nvarchar(30) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set BarCode1=Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add BarCode2 nvarchar(30) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set BarCode2=Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add BarCode3 nvarchar(30) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set BarCode3=Null';
     ExecQueryPro(SQLStr);
    end;
 if ButtonColorFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add ButtonColor INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set ButtonColor=' + IntToStr(clLime);
     ExecQueryPro(SQLStr);
    end;
 if FontNameFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontName nvarchar(50) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontName=' + Chr(39) + 'MS Sans Serif' + Chr(39);
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table MenuItem Alter Column FontName nvarchar(50) Null';
     ExecQueryPro(SQLStr);
    end;
 if FontColorFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontColor INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontColor=' + IntToStr(clBlack);
     ExecQueryPro(SQLStr);
    end;
 if FontSizeFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontSize INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontSize=8';
     ExecQueryPro(SQLStr);
    end;
 if FontBoldFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontBold Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontBold=0';
     ExecQueryPro(SQLStr);
    end;
 if FontItalicFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontItalic Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontItalic=0';
     ExecQueryPro(SQLStr);
    end;
 if FontUnderlineFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontUnderline Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontUnderline=0';
     ExecQueryPro(SQLStr);
    end;
 if FontStrikeoutFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontStrikeout Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontStrikeout=0';
     ExecQueryPro(SQLStr);
    end;

 if ButtonColor1Flag then
    begin
     SQLStr := 'Alter Table MenuItem Add ButtonColor1 INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set ButtonColor1=ButtonColor';
     ExecQueryPro(SQLStr);
    end;
 if FontName1Flag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontName1 nvarchar(50) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontName1=FontName';
     ExecQueryPro(SQLStr);
    end;
 if FontColor1Flag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontColor1 INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontColor1=FontColor';
     ExecQueryPro(SQLStr);
    end;
 if FontSize1Flag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontSize1 INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontSize1=FontSize';
     ExecQueryPro(SQLStr);
    end;
 if FontBold1Flag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontBold1 Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontBold1=FontBold';
     ExecQueryPro(SQLStr);
    end;
 if FontItalic1Flag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontItalic1 Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontItalic1=FontItalic';
     ExecQueryPro(SQLStr);
    end;
 if FontUnderline1Flag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontUnderline1 Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontUnderline1=FontUnderline';
     ExecQueryPro(SQLStr);
    end;
 if FontStrikeout1Flag then
    begin
     SQLStr := 'Alter Table MenuItem Add FontStrikeout1 Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set FontStrikeout1=FontStrikeout';
     ExecQueryPro(SQLStr);
    end;

 if JobListColorFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add JobListColor SmallInt Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set JobListColor=0';
     ExecQueryPro(SQLStr);
    end;
 if OpenPriceFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add OpenPrice Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set OpenPrice=1';
     ExecQueryPro(SQLStr);
    end;
 if ShowImage then
    begin
     SQLStr := 'Alter Table MenuItem Drop Column ShowImage';
     ExecQueryPro(SQLStr);
    end;
 if ImageLoadPath then
    begin
     SQLStr := 'Alter Table MenuItem Drop Column ImageLoadPath';
     ExecQueryPro(SQLStr);
    end;
 if PrinterPort1 then
    begin
     SQLStr := 'Alter Table MenuItem Add PrinterPort1 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set PrinterPort1=0';
     ExecQueryPro(SQLStr);
    end;
 if PrinterPort2 then
    begin
     SQLStr := 'Alter Table MenuItem Add PrinterPort2 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set PrinterPort2=0';
     ExecQueryPro(SQLStr);
    end;
 if PrinterPort3 then
    begin
     SQLStr := 'Alter Table MenuItem Add PrinterPort3 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set PrinterPort3=0';
     ExecQueryPro(SQLStr);
    end;
 if HappyHourPriceFlag1 then
    begin
     SQLStr := 'Alter Table MenuItem Add HappyHourPrice1 Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set HappyHourPrice1=0';
     ExecQueryPro(SQLStr);
    end;
 if HappyHourPriceFlag2 then
    begin
     SQLStr := 'Alter Table MenuItem Add HappyHourPrice2 Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set HappyHourPrice2=0';
     ExecQueryPro(SQLStr);
    end;
 if HappyHourPriceFlag3 then
    begin
     SQLStr := 'Alter Table MenuItem Add HappyHourPrice3 Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set HappyHourPrice3=0';
     ExecQueryPro(SQLStr);
    end;
 if HappyHourPriceFlag4 then
    begin
     SQLStr := 'Alter Table MenuItem Add HappyHourPrice4 Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set HappyHourPrice4=0';
     ExecQueryPro(SQLStr);
    end;
 if DefaultQtyFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add DefaultQty Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set DefaultQty=1';
     ExecQueryPro(SQLStr);
    end;
 if SubDescriptionSwap then
    begin
     SQLStr := 'Alter Table MenuItem Add SubDescriptionSwap Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set SubDescriptionSwap=0';
     ExecQueryPro(SQLStr);
    end;
 if KitchenScreenFontColorFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add KitchenScreenFontColor INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set KitchenScreenFontColor=' + IntToStr(clBlue);
     ExecQueryPro(SQLStr);
    end;
 if MenuPosition then
    begin
     SQLStr := 'Alter Table MenuItem Add MainPosition Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add POSPosition Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Select Category From Category Order By Category';
     OpenTempQuery(SQLStr);
     while Not TempQuery.EOF do
      begin
       SQLStr := 'Select ItemCode From MenuItem Where Category=' +
                 Chr(39) + TempQuery.FieldByName('Category').AsString + Chr(39) +
                 ' Order By ItemCode';
       OpenQuery(SQLStr);
       Position := 1;
       While Not Query.EOF do
        begin
         SQLStr := 'Update MenuItem Set MainPosition=' + IntToStr(Position) +
                   ', POSPosition=' + IntToStr(Position) +
                   ' Where ItemCode=' + Chr(39) + Query.FieldByName('ItemCode').AsString + Chr(39);
         ExecQueryPro(SQLStr);
         Inc(Position);
         Query.Next;
        end;
       TempQuery.Next;
      end;
    end;
 if PhoneOrderPositionFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add PhoneOrderPosition Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set PhoneOrderPosition = MainPosition';
     ExecQueryPro(SQLStr);
    end;
 if OnlyShowOnSubMenuFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add OnlyShowOnSubMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set OnlyShowOnSubMenu=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoPopSpellInstructionKeyboardFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add AutoPopSpellInstructionKeyboard Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set AutoPopSpellInstructionKeyboard=0';
     ExecQueryPro(SQLStr);
    end;
 if KitchenScreenFlag then
    begin
     SQLStr := 'Alter Table MenuItem Add KitchenScreen1 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set KitchenScreen1=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add KitchenScreen2 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set KitchenScreen2=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add KitchenScreen3 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set KitchenScreen3=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Add KitchenScreen4 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update MenuItem Set KitchenScreen4=0';
     ExecQueryPro(SQLStr);
    end;
 if SendToKitchenScreen then
    begin
     SQLStr := 'Update MenuItem Set KitchenScreen1 = 1 Where SendToKitchenScreen <> 0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table MenuItem Drop COLUMN SendToKitchenScreen';
     ExecQueryPro(SQLStr);
    end;
 if SubCategoryFlag then
    begin
     SQLStr := 'Alter Table MenuItem add COLUMN SubCategory bit Null';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Alter Table MenuItem Alter COLUMN ItemGroup nvarchar(25) Null';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.UpgradeProfileTablePro;
var
 SQLStr: string;
 PasswordFlag, BusinessHourFlag, ButtonLayOutFlag, MenuPanelStatusFlag,
 MainMenuLineFlag, MainCategoryLineFlag, POSMenuLineFlag, POSCategoryLineFlag,
 PhoneOrderMenuLineFlag, PhoneOrderCategoryLineFlag, ServiceChargeRateFlag,
 TableTrackFlag, ManuallyEnterTableNumberFlag,
 CheckTableStatusFlag, PersonCountFlag, PriceFlag, DiscountFlag, VIPFlag,
 InstructionFlag, PackageFlag, SeatNoFlag, ServiceChargeFlag, ReserveListFlag,
 PrintBillNoFlag, PrintInvoiceNoFlag, PayOutFlag, RoundingFlag,
 ForceVIPDiscountFlag, NotAllowModifyFlag, NotAllowChangeQtyFlag,
 AutoOpenTillFlag, AutoPrintJobListFlag, ManuallyPrintJobListFlag,
 PrintServiceOnJobListFlag, PrintPersonsOnJobListFlag,
 PrintPriceOnJobListFlag, PrintDateOnInvoiceFlag,
 PrintTimeOnInvoiceFlag, HappyHourFlag, ShowTaxOnSalesSectionFlag,
 POSJobListFlag, POSOrderListFlag, POSInvoiceFlag, PrintCategoryColorFlag,
 JobListDescriptionFlag, OrderListDescriptionFlag, InvoiceDescriptionFlag,
 TableOrderJobListFormatFlag, PrintJobListCategoryFlag, PrintBillCategoryFlag,
 PrintInvoiceCategoryFlag, VIPDefaultSearchFlag, PrintPickupSlipFlag,
 AutoPrintPhoneOrderJobListFlag, AutoInstructionSelectionFlag,
 PrintTableNoFlag, PrintDateOnDailyReportFlag, AutoPrintBillFlag,
 AutoPrintInvoiceFlag, AutoPriceWindowFlag, PrintZeroPriceItemOnInvoiceFlag,
 AutoPopVoidReasonFlag, AutoSaveOrderFlag, ScaleBarcodeFlag,
 PrintGoWithInstructionFlag, PrintOpNameOnJobListFlag,
 AutoPrintMergedOrderFlag, AutoPrintJobListForHoldOrderFlag,
 AutoSurchargeFlag, SurchargeNameFlag, OtherChargeFlag, OtherChargeNameFlag,
 OtherChargeRateFlag, PriceIncludesGSTFlag, DefaultGSTRateFlag,
 DefaultVIPStateFlag, HappyHour1Flag, PrintIngredientsOnJobListFlag,
 LoyaltyAwardFlag, ReachPointsFlag, MaxDiscountPercentageFlag,
 MaxDollarDiscountFlag, JobListFontSizeFlag, DefaultBackupPathFlag,
 ShowPrintInvoiceWindowFlag, ChangeQtyWithCondimentFlag,
 CompulsoryEnterCustomerNameFlag, AutoPrintCheckListFlag,
 PrintOrderNoOnJobListFlag, AutoBackupFlag, BackupTimeFlag,
 PhoneOrderMenuFlag, FrequencyFlag, BackupOnceTimeFlag,
 DiscountRateEnterModeFlag, ShowNegativeQtyFlag,
 PrintOrderNoOnTaxInvoiceFlag, CheckListFormatFlag,
 EnablePrintJobListButtonFlag, EnablePrintPickupSlipButtonFlag,
 AutoLogoutFlag, AutoLogoutTimeOutFlag, PrintRedColorQtyOnJobListFlag,
 MinimumChargeKindFlag, MinimumChargeItemCodeFlag,
 MinimumChargePerPersonFlag, OnlyOpenDrawerForCashPaymentFlag,
 PrintDiscountRateOnBillFlag, OnlyPrintSimpleFormatDailyReportFlag,
 OnlyPrintLastTwoDigitalOrderNoFlag, CheckPrinterStatusFlag,
 AutoPrintBillWhenPhoneOrderSavedFlag, AutoAddDeliveryChargeForPhoneOrderFlag,
 DeliveryChargeItemCodeFlag, TableLockFunctionEnabledFlag,
 PrintZeroQtyItemsOnJobListFlag, JobListFormatForPrinterFlag,
 SecondDisplayDescriptionFlag: Boolean;
 MainMenuLineCounter, MainCategoryLineCounter, POSMenuLineCounter,
 POSCategoryLineCounter: integer;
begin
 SQLStr := 'Select * From Profile';
 OpenQuery(SQLStr);
 PasswordFlag := Query.FindField('CheckPassword') = NIL;
 BusinessHourFlag := Query.FindField('BeginTime') = NIL;
 ButtonLayOutFlag := Query.FindField('ButtonLayOut') = NIL;
 MainMenuLineFlag := Query.FindField('MainMenuLine') = NIL;
 MainCategoryLineFlag := Query.FindField('MainCategoryLine') = NIL;
 POSMenuLineFlag := Query.FindField('POSMenuLine') = NIL;
 POSCategoryLineFlag := Query.FindField('POSCategoryLine') = NIL;
 PhoneOrderMenuLineFlag := Query.FindField('PhoneOrderMenuLine') = NIL;
 PhoneOrderCategoryLineFlag := Query.FindField('PhoneOrderCategoryLine') = NIL;
 ServiceChargeRateFlag := Query.FindField('ServiceChargeRate') = NIL;
 TableTrackFlag := Query.FindField('TableTracking') = NIL;
 ManuallyEnterTableNumberFlag := Query.FindField('ManuallyEnterTableNumber') = NIL;
 CheckTableStatusFlag := Query.FindField('CheckTableStatus') = NIL;
 PersonCountFlag := Query.FindField('PersonCount') = NIL;
 PrintBillNoFlag := Query.FindField('PrintBillNo') = Nil;
 PrintInvoiceNoFlag := Query.FindField('PrintInvoiceNo') = Nil;
 RoundingFlag := Query.FindField('RoundingFlag') = Nil;
 ForceVIPDiscountFlag := Query.FindField('ForceVIPDiscount') = NIL;
 NotAllowModifyFlag := Query.FindField('NotAllowModify') = NIL;
 NotAllowChangeQtyFlag := Query.FindField('NotAllowChangeQty') = NIL;
 AutoOpenTillFlag := Query.FindField('AutoOpenTill') = NIL;
 AutoPrintJobListFlag := Query.FindField('AutoPrintJobList') = NIL;
 ManuallyPrintJobListFlag := Query.FindField('ManuallyPrintJobList') = NIL;
 PrintServiceOnJobListFlag := Query.FindField('PrintServiceOnJobList') = NIL;
 PrintPersonsOnJobListFlag := Query.FindField('PrintPersonsOnJobList') = NIL;
 PrintPriceOnJobListFlag := Query.FindField('PrintPriceOnJobList') = NIL;
 PrintTimeOnInvoiceFlag := Query.FindField('PrintTimeOnInvoice') = NIL;
 HappyHourFlag := Query.FindField('HappyHour') = NIL;
 ShowTaxOnSalesSectionFlag := Query.FindField('ShowTaxOnSalesSection') = NIL;
 POSJobListFlag := Query.FindField('POSJobList') = NIL;
 POSOrderListFlag := Query.FindField('POSOrderList') = NIL;
 POSInvoiceFlag := Query.FindField('POSInvoice') = NIL;
 PrintCategoryColorFlag := Query.FindField('PrintCategoryColor') = NIL;
 JobListDescriptionFlag := Query.FindField('JobListDescription') = NIL;
 OrderListDescriptionFlag := Query.FindField('OrderListDescription') = NIL;
 InvoiceDescriptionFlag := Query.FindField('InvoiceDescription') = NIL;
 PrintBillCategoryFlag := Query.FindField('PrintBillCategory') = NIL;
 PrintInvoiceCategoryFlag  := Query.FindField('PrintInvoiceCategory') = NIL;
 VIPDefaultSearchFlag  := Query.FindField('VIPDefaultSearch') = NIL;
 PrintPickupSlipFlag := Query.FindField('PrintPickupSlip') = NIL;
 AutoPrintPhoneOrderJobListFlag := Query.FindField('AutoPrintPhoneOrderJobList') = NIL;
 AutoInstructionSelectionFlag := Query.FindField('AutoInstructionSelection') = NIL;
 PrintTableNoFlag := Query.FindField('PrintTableNo') = NIL;
 PrintDateOnDailyReportFlag := Query.FindField('PrintDateOnDailyReport') = NIL;
 AutoPrintBillFlag := Query.FindField('AutoPrintBill') = NIL;
 AutoPrintInvoiceFlag := Query.FindField('AutoPrintInvoice') = NIL;
 AutoPriceWindowFlag := Query.FindField('AutoPriceWindow') = NIL;
 PrintZeroPriceItemOnInvoiceFlag := Query.FindField('PrintZeroPriceItemOnInvoice') = NIL;
 AutoPopVoidReasonFlag := Query.FindField('AutoPopVoidReason') = NIL;
 AutoSaveOrderFlag := Query.FindField('AutoSaveOrder') = NIL;
 ScaleBarcodeFlag := Query.FindField('ScaleBarcode') = NIL;
 PrintGoWithInstructionFlag := Query.FindField('PrintGoWithInstruction') = NIL;
 PrintOpNameOnJobListFlag := Query.FindField('PrintOpNameOnJobList') = NIL;
 AutoPrintMergedOrderFlag := Query.FindField('AutoPrintMergedOrder') = NIL;
 AutoPrintJobListForHoldOrderFlag := Query.FindField('AutoPrintJobListForHoldOrder') = NIL;
 AutoSurchargeFlag := Query.FindField('AutoSurcharge') = NIL;
 SurchargeNameFlag := Query.FindField('SurchargeName') = NIL;
 OtherChargeFlag := Query.FindField('OtherCharge') = NIL;
 OtherChargeNameFlag := Query.FindField('OtherChargeName') = NIL;
 OtherChargeRateFlag := Query.FindField('OtherChargeRate') = NIL;
 PriceIncludesGSTFlag := Query.FindField('PriceIncludesGST') = NIL;
 DefaultGSTRateFlag := Query.FindField('DefaultGSTRate') = NIL;
 DefaultVIPStateFlag := Query.FindField('DefaultVIPState') = Nil;
 HappyHour1Flag := Query.FindField('HappyHourStartTime1') = NIL;
 PrintIngredientsOnJobListFlag := Query.FindField('PrintIngredientsOnJobList') = NIL;
 LoyaltyAwardFlag := Query.FindField('LoyaltyAward') = NIL;
 ReachPointsFlag := Query.FindField('ReachPoints') = NIL;
 MaxDiscountPercentageFlag := Query.FindField('MaxDiscountPercentage') = NIL;
 MaxDollarDiscountFlag := Query.FindField('MaxDollarDiscount') = NIL;
 JobListFontSizeFlag := Query.FindField('JobListFontSize') = NIL;
 DefaultBackupPathFlag := Query.FindField('DefaultBackupPath') = NIL;
 ShowPrintInvoiceWindowFlag := Query.FindField('ShowPrintInvoiceWindow') = NIL;
 ChangeQtyWithCondimentFlag := Query.FindField('ChangeQtyWithCondiment') = NIL;
 CompulsoryEnterCustomerNameFlag := Query.FindField('CompulsoryEnterCustomerName') = NIL;
 AutoPrintCheckListFlag := Query.FindField('AutoPrintCheckList') = NIL;
 PrintOrderNoOnJobListFlag := Query.FindField('PrintOrderNoOnJobList') = NIL;
 AutoBackupFlag := Query.FindField('AutoBackup') = NIL;
 BackupTimeFlag := Query.FindField('BackupTime') = NIL;
 FrequencyFlag := Query.FindField('BackupFrequency') = NIL;
 BackupOnceTimeFlag := Query.FindField('BackupOnceTime') = NIL;
 DiscountRateEnterModeFlag := Query.FindField('DiscountRateEnterMode') = NIL;
 ShowNegativeQtyFlag := Query.FindField('ShowNegativeQty') = NIL;
 PrintOrderNoOnTaxInvoiceFlag := Query.FindField('PrintOrderNoOnTaxInvoice') = NIL;
 CheckListFormatFlag := Query.FindField('CheckListFormat') = NIL;
 AutoLogoutFlag := Query.FindField('AutoLogout') = NIL;
 AutoLogoutTimeOutFlag := Query.FindField('AutoLogoutTimeOut') = NIL;
 PrintRedColorQtyOnJobListFlag := Query.FindField('PrintRedColorQtyOnJobList') = NIL;
 MinimumChargeKindFlag := Query.FindField('MinimumChargeKind') = NIL;
 MinimumChargeItemCodeFlag := Query.FindField('MinimumChargeItemCode') = NIL;
 MinimumChargePerPersonFlag := Query.FindField('MinimumChargePerPerson') = NIL;
 OnlyOpenDrawerForCashPaymentFlag := Query.FindField('OnlyOpenDrawerForCashPayment') = NIL;
 PrintDiscountRateOnBillFlag := Query.FindField('PrintDiscountRateOnBill') = NIL;
 OnlyPrintSimpleFormatDailyReportFlag := Query.FindField('OnlyPrintSimpleFormatDailyReport') = NIL;
 OnlyPrintLastTwoDigitalOrderNoFlag := Query.FindField('OnlyPrintLastTwoDigitalOrderNo') = NIL;
 CheckPrinterStatusFlag := Query.FindField('CheckPrinterStatus') = NIL;
 AutoPrintBillWhenPhoneOrderSavedFlag := Query.FindField('AutoPrintBillWhenPhoneOrderSaved') = NIL;
 AutoAddDeliveryChargeForPhoneOrderFlag := Query.FindField('AutoAddDeliveryChargeForPhoneOrder') = NIL;
 DeliveryChargeItemCodeFlag := Query.FindField('DeliveryChargeItemCode') = NIL;
 TableLockFunctionEnabledFlag := Query.FindField('TableLockFunctionEnabled') = NIL;
 PrintZeroQtyItemsOnJobListFlag := Query.FindField('PrintZeroQtyItemsOnJobList') = NIL;
 JobListFormatForPrinterFlag := Query.FindField('JobListFormatForPrinter1') = NIL;
 SecondDisplayDescriptionFlag := Query.FindField('SecondDisplayDescription') = NIL;
 TableOrderJobListFormatFlag  := Query.FindField('TableOrderJobListFormat') <> NIL;
 PrintJobListCategoryFlag := Query.FindField('PrintJobListCategory') <> NIL;
 if Not MainMenuLineFlag then
    MainMenuLineCounter := Query.FieldByName('MainMenuLine').AsInteger
   else
    MainMenuLineCounter := 9;
 if Not MainCategoryLineFlag then
    MainCategoryLineCounter := Query.FieldByName('MainCategoryLine').AsInteger
   else
    MainCategoryLineCounter := 4;
 if Not POSMenuLineFlag then
    POSMenuLineCounter := Query.FieldByName('POSMenuLine').AsInteger
   else
    POSMenuLineCounter := 9;
 if Not POSCategoryLineFlag then
    POSCategoryLineCounter := Query.FieldByName('POSCategoryLine').AsInteger
   else
    POSCategoryLineCounter := 4;

 DiscountFlag := Query.FindField('DiscountEnable') <> Nil;
 VIPFlag := Query.FindField('VIPEnable') <> Nil;
 MenuPanelStatusFlag := Query.FindField('MenuPanelStatus') <> NIL;
 ServiceChargeFlag := Query.FindField('ServiceChargeEnable') <> Nil;
 PriceFlag := Query.FindField('PriceEnable') <> Nil;
 PrintDateOnInvoiceFlag := Query.FindField('PrintDateOnInvoice') <> NIL;
 EnablePrintJobListButtonFlag := Query.FindField('EnablePrintJobListButton') <> NIL;
 PayOutFlag := Query.FindField('PayOutEnable') <> Nil;
 PhoneOrderMenuFlag := Query.FindField('PhoneOrderMenu') <> NIL;

 InstructionFlag := Query.FindField('InstructionEnable') <> Nil;
 SeatNoFlag := Query.FindField('SeatNoEnable') <> Nil;
 PackageFlag := Query.FindField('PackageEnable') <> Nil;
 ReserveListFlag := Query.FindField('ReserveListEnable') <> Nil;
 EnablePrintPickupSlipButtonFlag := Query.FindField('EnablePrintPickupSlipButton') <> NIL;

 Query.Close;
 if PasswordFlag then
    begin
     SQLStr := 'Alter Table Profile Add CheckPassword Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set CheckPassword=False';
     ExecQueryPro(SQLStr);
    end;
 if BusinessHourFlag then
    begin
     SQLStr := 'Alter Table Profile Add BeginTime DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set BeingTime=' +
               ConvertDateTime(StrToTime('0:0:0'));
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add EndTime DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set EndTime=' +
               ConvertDateTime(StrToTime('23:59:59'));
     ExecQueryPro(SQLStr);
    end;
 if ButtonLayOutFlag then
    begin
     SQLStr := 'Alter Table Profile Add ButtonLayOut Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ButtonLayOut=0';
     ExecQueryPro(SQLStr);
    end;
 if MainMenuLineFlag then
    begin
     SQLStr := 'Alter Table Profile Add MainMenuLine Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set MainMenuLine=9';
     ExecQueryPro(SQLStr);
    end;
 if MainCategoryLineFlag then
    begin
     SQLStr := 'Alter Table Profile Add MainCategoryLine Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set MainCategoryLine=4';
     ExecQueryPro(SQLStr);
    end;
 if POSMenuLineFlag then
    begin
     SQLStr := 'Alter Table Profile Add POSMenuLine Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set POSMenuLine=9';
     ExecQueryPro(SQLStr);
    end;
 if POSCategoryLineFlag then
    begin
     SQLStr := 'Alter Table Profile Add POSCategoryLine Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set POSCategoryLine=4';
     ExecQueryPro(SQLStr);
    end;

 if PhoneOrderMenuLineFlag then
    begin
     SQLStr := 'Alter Table Profile Add PhoneOrderMenuLine Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PhoneOrderMenuLine=MainMenuLine';
     ExecQueryPro(SQLStr);
    end;
 if PhoneOrderCategoryLineFlag then
    begin
     SQLStr := 'Alter Table Profile Add PhoneOrderCategoryLine Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PhoneOrderCategoryLine=MainCategoryLine';
     ExecQueryPro(SQLStr);
    end;
 if ServiceChargeRateFlag then
    begin
     SQLStr := 'Alter Table Profile Add ServiceChargeRate Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ServiceChargeRate=0';
     ExecQueryPro(SQLStr);
    end;
 if TableTrackFlag then
    begin
     SQLStr := 'Alter Table Profile Add TableTracking Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set TableTracking=1';
     ExecQueryPro(SQLStr);
    end;
 if ManuallyEnterTableNumberFlag then
    begin
     SQLStr := 'Alter Table Profile Add ManuallyEnterTableNumber Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ManuallyEnterTableNumber=0';
     ExecQueryPro(SQLStr);
    end;
 if CheckTableStatusFlag then
    begin
     SQLStr := 'Alter Table Profile Add CheckTableStatus Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set CheckTableStatus=1';
     ExecQueryPro(SQLStr);
    end;
 if PersonCountFlag then
    begin
     SQLStr := 'Alter Table Profile Add PersonCount Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PersonCount=1';
     ExecQueryPro(SQLStr);
    end;
 if PrintBillNoFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintBillNo Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintBillNo=1';
     ExecQueryPro(SQLStr);
    end;
 if PrintInvoiceNoFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintInvoiceNo Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintInvoiceNo=PrintBillNo';
     ExecQueryPro(SQLStr);
    end;
 if ForceVIPDiscountFlag then
    begin
     SQLStr := 'Alter Table Profile Add ForceVIPDiscount Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ForceVIPDiscount=1';
     ExecQueryPro(SQLStr);
    end;
 if RoundingFlag then
    begin
     SQLStr := 'Alter Table Profile Add RoundingFlag SmallInt Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set RoundingFlag=0';
     ExecQueryPro(SQLStr);
    end;
 if NotAllowModifyFlag then
    begin
     SQLStr := 'Alter Table Profile Add NotAllowModify Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set NotAllowModify=0';
     ExecQueryPro(SQLStr);
    end;
 if NotAllowChangeQtyFlag then
    begin
     SQLStr := 'Alter Table Profile Add NotAllowChangeQty Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set NotAllowChangeQty=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoOpenTillFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoOpenTill Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoOpenTill=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoPrintJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoPrintJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoPrintJobList=1';
     ExecQueryPro(SQLStr);
    end;
 if ManuallyPrintJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add ManuallyPrintJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ManuallyPrintJobList=1';
     ExecQueryPro(SQLStr);
    end;
 if PrintServiceOnJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintServiceOnJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintServiceOnJobList=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintPersonsOnJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintPersonsOnJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintPersonsOnJobList=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintPriceOnJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintPriceOnJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintPriceOnJobList=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintDateOnInvoiceFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintTimeOnInvoice Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintTimeOnInvoice=PrintDateOnInvoice';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Drop COLUMN PrintDateOnInvoice';
     ExecQueryPro(SQLStr);
    end
   else
    if PrintTimeOnInvoiceFlag then
       begin
        SQLStr := 'Alter Table Profile Add PrintTimeOnInvoice Bit Null';
        ExecQueryPro(SQLStr);
        SQLStr := 'Update Profile Set PrintTimeOnInvoice=0';
        ExecQueryPro(SQLStr);
       end;
 if HappyHourFlag then
    begin
     SQLStr := 'Alter Table Profile Add HappyHour Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHour=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourStartTime DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourStartTime=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourEndTime DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourEndTime=0';
     ExecQueryPro(SQLStr);
    end;
 if HappyHour1Flag then
    begin
     SQLStr := 'Alter Table Profile Add HappyHourStartTime1 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourStartTime1=HappyHourStartTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourEndTime1 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourEndTime1=HappyHourEndTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourStartTime2 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourStartTime2=HappyHourStartTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourEndTime2 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourEndTime2=HappyHourEndTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourStartTime3 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourStartTime3=HappyHourStartTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourEndTime3 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourEndTime3=HappyHourEndTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourStartTime4 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourStartTime4=HappyHourStartTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourEndTime4 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourEndTime4=HappyHourEndTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourStartTime5 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourStartTime5=HappyHourStartTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourEndTime5 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourEndTime5=HappyHourEndTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourStartTime6 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourStartTime6=HappyHourStartTime';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add HappyHourEndTime6 DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set HappyHourEndTime6=HappyHourEndTime';
     ExecQueryPro(SQLStr);
    end;
 if ShowTaxOnSalesSectionFlag then
    begin
     SQLStr := 'Alter Table Profile Add ShowTaxOnSalesSection Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ShowTaxOnSalesSection=1';
     ExecQueryPro(SQLStr);
    end;
 if POSJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add POSJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set POSJobList=0';
     ExecQueryPro(SQLStr);
    end;
 if POSOrderListFlag then
    begin
     SQLStr := 'Alter Table Profile Add POSOrderList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set POSOrderList=0';
     ExecQueryPro(SQLStr);
    end;
 if POSInvoiceFlag then
    begin
     SQLStr := 'Alter Table Profile Add POSInvoice Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set POSInvoice=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintPickupSlipFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintPickupSlip Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintPickupSlip=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintCategoryColorFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintCategoryColor Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintCategoryColor=0';
     ExecQueryPro(SQLStr);
    end;
 if JobListDescriptionFlag then
    begin
     SQLStr := 'Alter Table Profile Add JobListDescription Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set JobListDescription=1';
     ExecQueryPro(SQLStr);
    end;
 if OrderListDescriptionFlag then
    begin
     SQLStr := 'Alter Table Profile Add OrderListDescription Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set OrderListDescription=1';
     ExecQueryPro(SQLStr);
    end;
 if InvoiceDescriptionFlag then
    begin
     SQLStr := 'Alter Table Profile Add InvoiceDescription Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set InvoiceDescription=1';
     ExecQueryPro(SQLStr);
    end;
 if JobListFormatForPrinterFlag then
    begin
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter1 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter2 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter3 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter4 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter5 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter6 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter7 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter8 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter9 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter10 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter11 Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add JobListFormatForPrinter12 Integer Null';
     ExecQueryPro(SQLStr);
     if TableOrderJobListFormatFlag then
        SQLStr := 'Update Profile Set ' +
                  'JobListFormatForPrinter1 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter2 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter3 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter4 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter5 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter6 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter7 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter8 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter9 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter10 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter11 = TableOrderJobListFormat, ' +
                  'JobListFormatForPrinter12 = TableOrderJobListFormat'
       else
        if PrintJobListCategoryFlag then
           SQLStr := 'Update Profile Set ' +
                     'JobListFormatForPrinter1 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter2 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter3 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter4 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter5 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter6 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter7 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter8 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter9 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter10 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter11 = PrintJobListCategory, ' +
                     'JobListFormatForPrinter12 = PrintJobListCategory'
          else
           SQLStr := 'Update Profile Set ' +
                     'JobListFormatForPrinter1 = 0, ' +
                     'JobListFormatForPrinter2 = 0, ' +
                     'JobListFormatForPrinter3 = 0, ' +
                     'JobListFormatForPrinter4 = 0, ' +
                     'JobListFormatForPrinter5 = 0, ' +
                     'JobListFormatForPrinter6 = 0, ' +
                     'JobListFormatForPrinter7 = 0, ' +
                     'JobListFormatForPrinter8 = 0, ' +
                     'JobListFormatForPrinter9 = 0, ' +
                     'JobListFormatForPrinter10 = 0, ' +
                     'JobListFormatForPrinter11 = 0, ' +
                     'JobListFormatForPrinter12 = 0';
         ExecQueryPro(SQLStr);
    end;
 if TableOrderJobListFormatFlag then
    begin
     SQLStr := 'Alter Table Profile Drop COLUMN TableOrderJobListFormat';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Drop COLUMN PhoneOrderJobListFormat';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Drop COLUMN QuickSalesJobListFormat';
     ExecQueryPro(SQLStr);
    end;
 if PrintJobListCategoryFlag then
    begin
     SQLStr := 'Alter Table Profile Drop COLUMN PrintJobListCategory';
     ExecQueryPro(SQLStr);
    end;
 if PrintBillCategoryFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintBillCategory Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintBillCategory=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintInvoiceCategoryFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintInvoiceCategory Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintInvoiceCategory=0';
     ExecQueryPro(SQLStr);
    end;
 if VIPDefaultSearchFlag then
    begin
     SQLStr := 'Alter Table Profile Add VIPDefaultSearch Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set VIPDefaultSearch=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoPrintPhoneOrderJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoPrintPhoneOrderJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoPrintPhoneOrderJobList=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoInstructionSelectionFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoInstructionSelection Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoInstructionSelection=1';
     ExecQueryPro(SQLStr);
    end;
 if PrintTableNoFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintTableNo Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintTableNo=1';
     ExecQueryPro(SQLStr);
    end;
 if PrintDateOnDailyReportFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintDateOnDailyReport Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintDateOnDailyReport=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoPrintBillFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoPrintBill Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoPrintBill=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoPrintInvoiceFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoPrintInvoice Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoPrintInvoice=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoPriceWindowFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoPriceWindow Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoPriceWindow=1';
     ExecQueryPro(SQLStr);
    end;
 if PrintZeroPriceItemOnInvoiceFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintZeroPriceItemOnInvoice Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintZeroPriceItemOnInvoice=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoPopVoidReasonFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoPopVoidReason Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoPopVoidReason=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoSaveOrderFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoSaveOrder Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoSaveOrder=0';
     ExecQueryPro(SQLStr);
    end;
 if ScaleBarcodeFlag then
    begin
     SQLStr := 'Alter Table Profile Add ScaleBarcode Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ScaleBarcode=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintGoWithInstructionFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintGoWithInstruction Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintGoWithInstruction=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintOpNameOnJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintOpNameOnJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintOpNameOnJobList=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoPrintMergedOrderFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoPrintMergedOrder Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoPrintMergedOrder=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoPrintJobListForHoldOrderFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoPrintJobListForHoldOrder Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoPrintJobListForHoldOrder=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoSurchargeFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoSurcharge Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoSurcharge=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add SurchargeStartTime DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set SurchargeStartTime=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add SurchargeEndTime DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set SurchargeEndTime=0';
     ExecQueryPro(SQLStr);
    end;
 if SurchargeNameFlag then
    begin
     SQLStr := 'Alter Table Profile Add SurchargeName nvarchar(15) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set SurchargeName=' + Chr(39) + 'Surcharge' + Chr(39);
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table Profile Alter COLUMN SurchargeName nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
 if OtherChargeFlag then
    begin
     SQLStr := 'Alter Table Profile Add OtherCharge Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set OtherCharge=0';
     ExecQueryPro(SQLStr);
    end;
 if OtherChargeNameFlag then
    begin
     SQLStr := 'Alter Table Profile Add OtherChargeName nvarchar(15) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set OtherChargeName=' + Chr(39) + 'Other Charge' + Chr(39);
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table Profile Alter COLUMN OtherChargeName nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
 if OtherChargeRateFlag then
    begin
     SQLStr := 'Alter Table Profile Add OtherChargeRate Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set OtherChargeRate=0';
     ExecQueryPro(SQLStr);
    end;
 if PriceIncludesGSTFlag then
    begin
     SQLStr := 'Alter Table Profile Add PriceIncludesGST Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PriceIncludesGST=1';
     ExecQueryPro(SQLStr);
    end;
 if DefaultGSTRateFlag then
    begin
     SQLStr := 'Alter Table Profile Add DefaultGSTRate Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set DefaultGSTRate=10';
     ExecQueryPro(SQLStr);
    end;
 if DefaultVIPStateFlag then
    begin
     SQLStr := 'Alter Table Profile Add DefaultVIPState nvarchar(5) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set DefaultVIPState=' + Chr(39) + 'VIC' + Chr(39);
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table Profile Alter COLUMN DefaultVIPState nvarchar(5) Null';
     ExecQueryPro(SQLStr);
    end;
 if PrintIngredientsOnJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintIngredientsOnJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintIngredientsOnJobList=0';
     ExecQueryPro(SQLStr);
    end;
 if LoyaltyAwardFlag then
    begin
     SQLStr := 'Alter Table Profile Add LoyaltyAward Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set LoyaltyAward=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add SalesPoints integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set SalesPoints=0';
     ExecQueryPro(SQLStr);
     SQLStr := 'Alter Table Profile Add PaymentPoints Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PaymentPoints=0';
     ExecQueryPro(SQLStr);
    end;
 if ReachPointsFlag then
    begin
     SQLStr := 'Alter Table Profile Add ReachPoints Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ReachPoints=0';
     ExecQueryPro(SQLStr);
    end;
 if MaxDiscountPercentageFlag then
    begin
     SQLStr := 'Alter Table Profile Add MaxDiscountPercentage Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set MaxDiscountPercentage=100';
     ExecQueryPro(SQLStr);
    end;
 if MaxDollarDiscountFlag then
    begin
     SQLStr := 'Alter Table Profile Add MaxDollarDiscount Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set MaxDollarDiscount=0';
     ExecQueryPro(SQLStr);
    end;
 if JobListFontSizeFlag then
    begin
     SQLStr := 'Alter Table Profile Add JobListFontSize Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set JobListFontSize=0';
     ExecQueryPro(SQLStr);
    end;
 if DefaultBackupPathFlag then
    begin
     SQLStr := 'Alter Table Profile Add DefaultBackupPath nvarchar(255) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set DefaultBackupPath=Null';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table Profile Alter COLUMN DefaultBackupPath nvarchar(255) Null';
     ExecQueryPro(SQLStr);
    end;
 if ShowPrintInvoiceWindowFlag then
    begin
     SQLStr := 'Alter Table Profile Add ShowPrintInvoiceWindow Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ShowPrintInvoiceWindow=1';
     ExecQueryPro(SQLStr);
    end;
 if ChangeQtyWithCondimentFlag then
    begin
     SQLStr := 'Alter Table Profile Add ChangeQtyWithCondiment Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ChangeQtyWithCondiment=0';
     ExecQueryPro(SQLStr);
    end;
 if CompulsoryEnterCustomerNameFlag then
    begin
     SQLStr := 'Alter Table Profile Add CompulsoryEnterCustomerName Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set CompulsoryEnterCustomerName=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoPrintCheckListFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoPrintCheckList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoPrintCheckList=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintOrderNoOnJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintOrderNoOnJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintOrderNoOnJobList=1';
     ExecQueryPro(SQLStr);
    end;
 if AutoBackupFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoBackup Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoBackup=0';
     ExecQueryPro(SQLStr);
    end;
 if BackupTimeFlag then
    begin
     SQLStr := 'Alter Table Profile Add BackupTime Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set BackupTime=0';
     ExecQueryPro(SQLStr);
    end;
 if FrequencyFlag then
    begin
     SQLStr := 'Alter Table Profile Add BackupFrequency Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set BackupFrequency=0';
     ExecQueryPro(SQLStr);
    end;
 if BackupOnceTimeFlag then
    begin
     SQLStr := 'Alter Table Profile Add BackupOnceTime DateTime Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set BackupOnceTime=0';
     ExecQueryPro(SQLStr);
    end;
 if DiscountRateEnterModeFlag then
    begin
     SQLStr := 'Alter Table Profile Add DiscountRateEnterMode Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set DiscountRateEnterMode=0';
     ExecQueryPro(SQLStr);
    end;
 if ShowNegativeQtyFlag then
    begin
     SQLStr := 'Alter Table Profile Add ShowNegativeQty Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set ShowNegativeQty=1';
     ExecQueryPro(SQLStr);
    end;
 if PrintOrderNoOnTaxInvoiceFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintOrderNoOnTaxInvoice Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintOrderNoOnTaxInvoice=1';
     ExecQueryPro(SQLStr);
    end;
 if CheckListFormatFlag then
    begin
     SQLStr := 'Alter Table Profile Add CheckListFormat Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set CheckListFormat=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoLogoutFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoLogout Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoLogout=0';
     ExecQueryPro(SQLStr);
    end;
 if AutoLogoutTimeOutFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoLogoutTimeOut Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoLogoutTimeOut=0';
     ExecQueryPro(SQLStr);
    end;
 if PrintRedColorQtyOnJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintRedColorQtyOnJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintRedColorQtyOnJobList = 0';
     ExecQueryPro(SQLStr);
    end;
 if MinimumChargeKindFlag then
    begin
     SQLStr := 'Alter Table Profile Add MinimumChargeKind Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set MinimumChargeKind = 0';
     ExecQueryPro(SQLStr);
    end;
 if OnlyOpenDrawerForCashPaymentFlag then
    begin
     SQLStr := 'Alter Table Profile Add OnlyOpenDrawerForCashPayment Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set OnlyOpenDrawerForCashPayment = 0';
     ExecQueryPro(SQLStr);
    end;
 if MinimumChargeItemCodeFlag then
    begin
     SQLStr := 'Alter Table Profile Add MinimumChargeItemCode nvarchar(4) Null';
     ExecQueryPro(SQLStr);
    end;
 if MinimumChargePerPersonFlag then
    begin
     SQLStr := 'Alter Table Profile Add MinimumChargePerPerson Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set MinimumChargePerPerson = 0';
     ExecQueryPro(SQLStr);
    end;
 if PrintDiscountRateOnBillFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintDiscountRateOnBill Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintDiscountRateOnBill = 0';
     ExecQueryPro(SQLStr);
    end;
 if OnlyPrintSimpleFormatDailyReportFlag then
    begin
     SQLStr := 'Alter Table Profile Add OnlyPrintSimpleFormatDailyReport Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set OnlyPrintSimpleFormatDailyReport = 0';
     ExecQueryPro(SQLStr);
    end;
 if OnlyPrintLastTwoDigitalOrderNoFlag then
    begin
     SQLStr := 'Alter Table Profile Add OnlyPrintLastTwoDigitalOrderNo Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set OnlyPrintLastTwoDigitalOrderNo = 0';
     ExecQueryPro(SQLStr);
    end;
 if CheckPrinterStatusFlag then
    begin
     SQLStr := 'Alter Table Profile Add CheckPrinterStatus Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set CheckPrinterStatus = 0';
     ExecQueryPro(SQLStr);
    end;
 if MainMenuLineCounter + MainCategoryLineCounter < 13 then
    begin
     SQLStr := 'Update Profile Set MainMenuLine = MainMenuLine + 1';
     ExecQueryPro(SQLStr);
    end;
 if POSMenuLineCounter + POSCategoryLineCounter < 13 then
    begin
     SQLStr := 'Update Profile Set POSMenuLine = POSMenuLine + 1';
     ExecQueryPro(SQLStr);
    end;
 if AutoPrintBillWhenPhoneOrderSavedFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoPrintBillWhenPhoneOrderSaved Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoPrintBillWhenPhoneOrderSaved = 0';
     ExecQueryPro(SQLStr);
    end;
 if AutoAddDeliveryChargeForPhoneOrderFlag then
    begin
     SQLStr := 'Alter Table Profile Add AutoAddDeliveryChargeForPhoneOrder Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set AutoAddDeliveryChargeForPhoneOrder = 0';
     ExecQueryPro(SQLStr);
    end;
 if DeliveryChargeItemCodeFlag then
    begin
     SQLStr := 'Alter Table Profile Add DeliveryChargeItemCode nvarchar(4) Null';
     ExecQueryPro(SQLStr);
    end;
 if TableLockFunctionEnabledFlag then
    begin
     SQLStr := 'Alter Table Profile Add TableLockFunctionEnabled Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set TableLockFunctionEnabled = 0';
     ExecQueryPro(SQLStr);
    end;
 if PrintZeroQtyItemsOnJobListFlag then
    begin
     SQLStr := 'Alter Table Profile Add PrintZeroQtyItemsOnJobList Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set PrintZeroQtyItemsOnJobList = 0';
     ExecQueryPro(SQLStr);
    end;
 if SecondDisplayDescriptionFlag then
    begin
     SQLStr := 'Alter Table Profile Add SecondDisplayDescription Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Profile Set SecondDisplayDescription = 0';
     ExecQueryPro(SQLStr);
    end;
 if DiscountFlag then
    begin
     SQLStr := 'Alter Table Profile Drop COLUMN DiscountEnable';
     ExecQueryPro(SQLStr);
    end;
 if VIPFlag then
    begin
     SQLStr := 'Alter Table Profile Drop COLUMN VIPEnable';
     ExecQueryPro(SQLStr);
    end;
 if MenuPanelStatusFlag then
    begin
     SQLStr := 'Alter Table Profile Drop COLUMN MenuPanelStatus';
     ExecQueryPro(SQLStr);
    end;
 if ServiceChargeFlag then
    begin
     SQLStr := 'Alter Table Profile Drop COLUMN ServiceChargeEnable';
     ExecQueryPro(SQLStr);
    end;
 if PriceFlag then
    begin
     SQLStr := 'Alter Table Profile Drop COLUMN PriceEnable';
     ExecQueryPro(SQLStr);
    end;
 if EnablePrintJobListButtonFlag then
    begin
     SQLStr := 'Alter Table Profile Drop COLUMN EnablePrintJobListButton';
     ExecQueryPro(SQLStr);
    end;
 if PayOutFlag then
    begin
     SQLStr := 'Alter Table Profile Drop Column PayOutEnable';
     ExecQueryPro(SQLStr);
    end;
 if PhoneOrderMenuFlag then
    begin
     SQLStr := 'Alter Table Profile Drop Column PhoneOrderMenu';
     ExecQueryPro(SQLStr);
    end;
 if InstructionFlag then
    begin
     SQLStr := 'Alter Table Profile Drop Column InstructionEnable';
     ExecQueryPro(SQLStr);
    end;
 if SeatNoFlag then
    begin
     SQLStr := 'Alter Table Profile Drop Column SeatNoEnable';
     ExecQueryPro(SQLStr);
    end;
 if PackageFlag then
    begin
     SQLStr := 'Alter Table Profile Drop Column PackageEnable';
     ExecQueryPro(SQLStr);
    end;
 if ReserveListFlag then
    begin
     SQLStr := 'Alter Table Profile Drop Column ReserveListEnable';
     ExecQueryPro(SQLStr);
    end;
 if EnablePrintPickupSlipButtonFlag then
    begin
     SQLStr := 'Alter Table Profile Drop Column EnablePrintPickupSlipButton';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.UpgradeRecvAcctTablePro;
var
 SQLStr: string;
 TransferFlag, MachineIDFlag, DepositIDFlag: boolean;
begin
 SQLStr := 'Select * From RecvAcct Where OrderNo=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 TransferFlag := Query.FindField('Transfer') = NIL;
 MachineIDFlag := Query.FindField('MachineID') = NIL;
 DepositIDFlag := Query.FindField('DepositID') = NIL;
 Query.Close;
 if TransferFlag then
    begin
     SQLStr := 'Alter Table RecvAcct Add Transfer Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update RecvAcct Set Transfer=0';
     ExecQueryPro(SQLStr);
    end;
 if MachineIDFlag then
    begin
     SQLStr := 'Alter Table RecvAcct Add MachineID nvarchar(15) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update RecvAcct Set RecvAcct.MachineID=OrderH.MachineID ' +
               'From RecvAcct, OrderH ' +
               ' Where RecvAcct.OrderNo=OrderH.OrderNo';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table RecvAcct Alter COLUMN MachineID nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
 if DepositIDFlag then
    begin
     SQLStr := 'Alter Table RecvAcct Add DepositID Integer Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update RecvAcct Set DepositID = 0';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Alter Table RecvAcct Alter COLUMN OrderNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.UpgradeCategoryTablePro;
var
 SQLStr: string;
 CodeFlag, ButtonColorFlag, FontNameFlag, FontColorFlag, FontSizeFlag,
 FontBoldFlag, FontItalicFlag, FontUnderlineFlag, FontStrikeoutFlag,
 ButtonColor1Flag, FontName1Flag, FontColor1Flag, FontSize1Flag,
 FontBold1Flag, FontItalic1Flag, FontUnderline1Flag, FontStrikeout1Flag,
 ShowOnMainMenuFlag, ShowOnPOSMenuFlag, ShowImage, ImageLoadPath,
 Category1Flag, MenuGroupFlag, ShowOnPhoneOrderMenuFlag: boolean;
 I: Integer;
begin
 SQLStr := 'Select * From Category Where Category=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 CodeFlag := Query.FindField('Code') = NIL;

 ButtonColorFlag := Query.FindField('ButtonColor') = NIL;
 FontNameFlag := Query.FindField('FontName') = NIL;
 FontColorFlag := Query.FindField('FontColor') = NIL;
 FontSizeFlag := Query.FindField('FontSize') = NIL;
 FontBoldFlag := Query.FindField('FontBold') = NIL;
 FontItalicFlag := Query.FindField('FontItalic') = NIL;
 FontUnderlineFlag := Query.FindField('FontUnderline') = NIL;
 FontStrikeoutFlag := Query.FindField('FontStrikeout') = NIL;

 ButtonColor1Flag := Query.FindField('ButtonColor1') = NIL;
 FontName1Flag := Query.FindField('FontName1') = NIL;
 FontColor1Flag := Query.FindField('FontColor1') = NIL;
 FontSize1Flag := Query.FindField('FontSize1') = NIL;
 FontBold1Flag := Query.FindField('FontBold1') = NIL;
 FontItalic1Flag := Query.FindField('FontItalic1') = NIL;
 FontUnderline1Flag := Query.FindField('FontUnderline1') = NIL;
 FontStrikeout1Flag := Query.FindField('FontStrikeout1') = NIL;

 ShowOnMainMenuFlag := Query.FindField('ShowOnMainMenu') = NIL;
 ShowOnPOSMenuFlag := Query.FindField('ShowOnPOSMenu') = NIL;
 ShowImage := Query.FindField('ShowImage') <> NIL;
 ImageLoadPath := Query.FindField('ImageLoadPath') <> NIL;
 Category1Flag := Query.FindField('Category1') = NIL;
 MenuGroupFlag := Query.FindField('MenuGroupCode') = NIL;
 ShowOnPhoneOrderMenuFlag := Query.FindField('ShowOnPhoneOrderMenu') = NIL;
 Query.Close;
 if CodeFlag then
    begin
     SQLStr := 'Alter Table Category Add Code nvarchar(3)';
     ExecQueryPro(SQLStr);
     SQLStr := 'Select * from Category Order By Category';
     OpenQuery(SQLStr);
     I := 1;
     with Query do
      begin
       while Not EOF do
        begin
         SQLStr := 'Update Category Set Code=' + Chr(39) + Format('%3.3d', [I]) + Chr(39) +
                   ' Where Category=' + Chr(39) + FieldByName('Category').AsString + Chr(39);
         ExecQueryPro(SQLStr);
         Next; I := I + 1;
        end;
       Close;
      end;
    end;
 if ButtonColorFlag then
    begin
     SQLStr := 'Alter Table Category Add ButtonColor INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set ButtonColor=' + IntToStr(clLime);
     ExecQueryPro(SQLStr);
    end;
 if FontNameFlag then
    begin
     SQLStr := 'Alter Table Category Add FontName nvarchar(50) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontName=' + Chr(39) + 'MS Sans Serif' + Chr(39);
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table Category Alter Column FontName nvarchar(50) Null';
     ExecQueryPro(SQLStr);
    end;
 if FontColorFlag then
    begin
     SQLStr := 'Alter Table Category Add FontColor INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontColor=' + IntToStr(clYellow);
     ExecQueryPro(SQLStr);
    end;
 if FontSizeFlag then
    begin
     SQLStr := 'Alter Table Category Add FontSize INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontSize=8';
     ExecQueryPro(SQLStr);
    end;
 if FontBoldFlag then
    begin
     SQLStr := 'Alter Table Category Add FontBold Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontBold=0';
     ExecQueryPro(SQLStr);
    end;
 if FontItalicFlag then
    begin
     SQLStr := 'Alter Table Category Add FontItalic Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontItalic=0';
     ExecQueryPro(SQLStr);
    end;
 if FontUnderlineFlag then
    begin
     SQLStr := 'Alter Table Category Add FontUnderline Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontUnderline=0';
     ExecQueryPro(SQLStr);
    end;
 if FontStrikeoutFlag then
    begin
     SQLStr := 'Alter Table Category Add FontStrikeout Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontStrikeout=0';
     ExecQueryPro(SQLStr);
    end;

 if ButtonColor1Flag then
    begin
     SQLStr := 'Alter Table Category Add ButtonColor1 INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set ButtonColor1=ButtonColor';
     ExecQueryPro(SQLStr);
    end;
 if FontName1Flag then
    begin
     SQLStr := 'Alter Table Category Add FontName1 nvarchar(50) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontName1=FontName';
     ExecQueryPro(SQLStr);
    end;
 if FontColor1Flag then
    begin
     SQLStr := 'Alter Table Category Add FontColor1 INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontColor1=FontColor';
     ExecQueryPro(SQLStr);
    end;
 if FontSize1Flag then
    begin
     SQLStr := 'Alter Table Category Add FontSize1 INTEGER Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontSize1=FontSize';
     ExecQueryPro(SQLStr);
    end;
 if FontBold1Flag then
    begin
     SQLStr := 'Alter Table Category Add FontBold1 Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontBold1=FontBold';
     ExecQueryPro(SQLStr);
    end;
 if FontItalic1Flag then
    begin
     SQLStr := 'Alter Table Category Add FontItalic1 Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontItalic1=FontItalic';
     ExecQueryPro(SQLStr);
    end;
 if FontUnderline1Flag then
    begin
     SQLStr := 'Alter Table Category Add FontUnderline1 Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontUnderline1=FontUnderline';
     ExecQueryPro(SQLStr);
    end;
 if FontStrikeout1Flag then
    begin
     SQLStr := 'Alter Table Category Add FontStrikeout1 Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set FontStrikeout1=FontStrikeout';
     ExecQueryPro(SQLStr);
    end;

 if ShowOnMainMenuFlag then
    begin
     SQLStr := 'Alter Table Category Add ShowOnMainMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set ShowOnMainMenu=1';
     ExecQueryPro(SQLStr);
    end;
 if ShowOnPOSMenuFlag then
    begin
     SQLStr := 'Alter Table Category Add ShowOnPOSMenu Bit';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set ShowOnPOSMenu=1';
     ExecQueryPro(SQLStr);
    end;
 if Category1Flag then
    begin
     SQLStr := 'Alter Table Category Add Category1 nvarchar(25) Null';
     ExecQueryPro(SQLStr);
    end;
 if MenuGroupFlag then
    begin
     SQLStr := 'Alter Table Category Add MenuGroupCode nvarchar(2) Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set MenuGroupCode=' + Chr(39) + '00' + Chr(39);
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table Category Alter COLUMN MenuGroupCode nvarchar(2) Null';
     ExecQueryPro(SQLStr);
    end;
 if ShowOnPhoneOrderMenuFlag then
    begin
     SQLStr := 'Alter Table Category Add ShowOnPhoneOrderMenu Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Category Set ShowOnPhoneOrderMenu=ShowOnMainMenu';
     ExecQueryPro(SQLStr);
    end;
 if ShowImage then
    begin
     SQLStr := 'Alter Table Category Drop Column ShowImage';
     ExecQueryPro(SQLStr);
    end;
 if ImageLoadPath then
    begin
     SQLStr := 'Alter Table Category Drop Column ImageLoadPath';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.UpgradeChartTablePro;
var
 SQLStr: string;
 LevelFlag, DetailFlag: boolean;
begin
 SQLStr := 'Select * From Chart Where AccountNo=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 LevelFlag := Query.FindField('LevelFlag') = NIL;
 DetailFlag := Query.FindField('Detail') = NIL;
 Query.Close;
 if LevelFlag then
    begin
     SQLStr := 'Alter Table Chart Add LevelFlag SMALLINT Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Chart Set LevelFlag=0';
     ExecQueryPro(SQLStr);
    end;
 if DetailFlag then
    begin
     SQLStr := 'Alter Table Chart Add Detail Bit Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update Chart Set Detail=1';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.UpgradeVIPTablePro;
var
 SQLStr: string;
 SuburbFlag, StateFlag, PostCodeFlag, SerialNoFlag, MapReferenceFlag,
 CreditLimitFlag, NumberFlag,SmartCardFlag: boolean;
begin
 SQLStr := 'Select * From VIPTable Where VIPNo=0';
 OpenQuery(SQLStr);
 SuburbFlag := Query.FindField('Suburb') = NIL;
 StateFlag := Query.FindField('State') = NIL;
 PostCodeFlag := Query.FindField('PostCode') = NIL;
 SerialNoFlag := Query.FindField('SerialNo') = NIL;
 MapReferenceFlag := Query.FindField('MapReference') = NIL;
 CreditLimitFlag := Query.FindField('CreditLimit') = NIL;
 NumberFlag := Query.FindField('Number') = NIL;
 SmartCardFlag := Query.FindField('SmartCard') = NIL;
 Query.Close;
 if SmartCardFlag then
    begin
     SQLStr := 'Alter Table VIPTable Add SmartCard Bit Null';
     ExecQueryPro(SQLStr);
    end;
 if SuburbFlag then
    begin
     SQLStr := 'Alter Table VIPTable Add Suburb nvarchar(25) Null';
     ExecQueryPro(SQLStr);
    end;
 if StateFlag then
    begin
     SQLStr := 'Alter Table VIPTable Add State nvarchar(5) Null';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table VIPTable Alter Column State nvarchar(5) Null';
     ExecQueryPro(SQLStr);
    end;
 if PostCodeFlag then
    begin
     SQLStr := 'Alter Table VIPTable Add PostCode nvarchar(6) Null';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table VIPTable Alter Column PostCode nvarchar(6) Null';
     ExecQueryPro(SQLStr);
    end;
 if SerialNoFlag then
    begin
     SQLStr := 'Alter Table VIPTable Add SerialNo nvarchar(16) Null';
     ExecQueryPro(SQLStr);
    end;
 if MapReferenceFlag then
    begin
     SQLStr := 'Alter Table VIPTable Add MapReference nvarchar(15) Null';
     ExecQueryPro(SQLStr);
    end;
 if CreditLimitFlag then
    begin
     SQLStr := 'Alter Table VIPTable Add CreditLimit Float Null';
     ExecQueryPro(SQLStr);
     SQLStr := 'Update VIPTable Set CreditLimit = 0';
     ExecQueryPro(SQLStr);
    end;
 if NumberFlag then
    begin
     SQLStr := 'Alter Table VIPTable Add Number nvarchar(10) Null';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table VIPTable Alter COLUMN Number nvarchar(10) Null';
     ExecQueryPro(SQLStr);
    end;
end;

procedure TUpgradeForm.UpgradeButtonTablePro;
var
SQLStr: string;
begin
    SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PrintLastInvoice' + Chr(39) + ', 19, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Print' + Chr(13) + Chr(10) + 'Invoice' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsPrintLastInvoiceClick) + ',' + IntToStr(tcQuickServiceButtonClick) + ', 1, 0)';
    ExecQueryPro(SQLStr);
    SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'TableService' + Chr(39) + ', 19, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Table' + Chr(13) + Chr(10) + 'Serive' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsTableServiceClick) + ',' + IntToStr(tcQuickServiceButtonClick) + ', 1, 0)';
    ExecQueryPro(SQLStr);
    SQLStr := 'Insert Into ButtonsTable(ButtonName, Position, ButtonSize, ButtonColor, Caption, ' +
           'FontName, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'Event, Kind, CanRelocate, Disable) ' +
           'Values(' + Chr(39) + 'PhoneOrder' + Chr(39) + ', 20, ' +
           IntToStr(sButtonNormalSize) + ', ' + IntToStr(bcNeoRose) + ',' +
           Chr(39) + 'Phone' + Chr(13) + Chr(10) + 'Order' + Chr(39) + ',' + Chr(39) + 'Arial' + Chr(39) + ',' +
           '8, 1, 0, 0, 0, ' + IntToStr(qsPhoneOrderAdminButtonClick) + ',' + IntToStr(tcQuickServiceButtonClick) + ', 1, 0)';
    ExecQueryPro(SQLStr);


end;

procedure TUpgradeForm.UpgradeSupplierTablePro;
var
 SQLStr: string;
 SuburbFlag, StateFlag, PostCodeFlag: boolean;
begin
 SQLStr := 'Select * From Supplier Where SupplierCode=' + Chr(39) + Chr(39);
 OpenQuery(SQLStr);
 SuburbFlag := Query.FindField('Suburb') = NIL;
 StateFlag := Query.FindField('State') = NIL;
 PostCodeFlag := Query.FindField('PostCode') = NIL;
 Query.Close;
 if SuburbFlag then
    begin
     SQLStr := 'Alter Table Supplier Add Suburb nvarchar(25) Null';
     ExecQueryPro(SQLStr);
    end;
 if StateFlag then
    begin
     SQLStr := 'Alter Table Supplier Add State nvarchar(5) Null';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table Supplier Alter Column State nvarchar(5) Null';
     ExecQueryPro(SQLStr);
    end;
 if PostCodeFlag then
    begin
     SQLStr := 'Alter Table Supplier Add PostCode nvarchar(4) Null';
     ExecQueryPro(SQLStr);
    end
   else
    begin
     SQLStr := 'Alter Table Supplier Alter Column PostCode nvarchar(6) Null';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'SupplierMemo' + Chr(39);
 OpenQuery(SQLStr);
 if Query.RecordCount = 0 then
    begin
     SQLStr := 'Create Table SupplierMemo(' +
               'SupplierCode nvarchar(15), ' +
               'Memo nvarchar(200))';
     ExecQueryPro(SQLStr);
    end;
 SQLStr := 'Alter Table SupplierMemo Alter COLUMN SupplierCode nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Alter Table SupplierMemo Alter COLUMN Memo nvarchar(200) Null';
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.UpdateCharTonvarchar;
var
 SQLStr: string;
begin
 // AccessMenu
 SQLStr := 'Alter Table AccessMenu Alter Column Address nvarchar(100) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update AccessMenu Set Address=RTRIM(Address) Where Address <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table AccessMenu Alter Column Fax nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update AccessMenu Set Fax=RTRIM(Fax) Where Fax <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table AccessMenu Alter Column Telephone nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update AccessMenu Set Telephone=RTRIM(Telephone) Where Telephone <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table AccessMenu Alter Column Mobile nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update AccessMenu Set Mobile=RTRIM(Mobile) Where Mobile <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table AccessMenu Alter Column StaffName nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update AccessMenu Set StaffName=RTRIM(StaffName) Where StaffName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table AccessMenu Alter Column SecureCode nvarchar(16) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update AccessMenu Set SecureCode=RTRIM(SecureCode) Where SecureCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // Attendance
 SQLStr := 'Alter Table Attendance Alter Column StaffName nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update AccessMenu Set StaffName=RTRIM(StaffName) Where StaffName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // BankHead
 SQLStr := 'Alter Table BankHead Alter Column BankName nvarchar(30) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BankHead Set BankName=RTRIM(BankName) Where BankName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BankHead Alter Column AccountNo nvarchar(20) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BankHead Set AccountNo=RTRIM(AccountNo) Where AccountNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BankHead Alter Column AccountName nvarchar(30) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BankHead Set AccountName=RTRIM(AccountName) Where AccountName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // BankTransaction
 SQLStr := 'Alter Table BankTransaction Alter Column AccountNo nvarchar(20) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BankTransaction Set AccountNo=RTRIM(AccountNo) Where AccountNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BankTransaction Alter Column Reference nvarchar(20) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BankTransaction Set Reference=RTRIM(Reference) Where Reference <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BankTransaction Alter Column Notes nvarchar(40) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BankTransaction Set Notes=RTRIM(Notes) Where Notes <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // BookTable
 SQLStr := 'Alter Table BookTable Alter Column CustomerName nvarchar(30) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BookTable Set CustomerName=RTRIM(CustomerName) Where CustomerName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BookTable Alter Column Company nvarchar(40) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BookTable Set Company=RTRIM(Company) Where Company <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BookTable Alter Column Telephone nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BookTable Set Telephone=RTRIM(Telephone) Where Telephone <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BookTable Alter Column Fax nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BookTable Set Fax=RTRIM(Fax) Where Fax <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BookTable Alter Column Mobile nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BookTable Set Mobile=RTRIM(Mobile) Where Mobile <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BookTable Alter Column Address nvarchar(60) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BookTable Set Address=RTRIM(Address) Where Address <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BookTable Alter Column TableNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BookTable Set TableNo=RTRIM(TableNo) Where TableNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BookTable Alter Column Notes nvarchar(255) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BookTable Set Notes=RTRIM(Notes) Where Notes <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BookTable Alter Column BookingNo nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BookTable Set BookingNo=RTRIM(BookingNo) Where BookingNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table BookTable Alter Column OpName nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update BookTable Set OpName=RTRIM(OpName) Where OpName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // Category
 SQLStr := 'Alter Table Category Alter Column Category nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Category Set Category=RTRIM(Category) Where Category <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Category Alter Column Code nvarchar(3) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Category Set Code=RTRIM(Code) Where Code <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Category Alter Column FontName nvarchar(50) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Category Set FontName=RTRIM(FontName) Where FontName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Category Alter Column Category1 nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Category Set Category1=RTRIM(Category1) Where Category1 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // Chart
 SQLStr := 'Alter Table Chart Alter Column AccountNo nvarchar(4) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Chart Set AccountNo=RTRIM(AccountNo) Where AccountNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Chart Alter Column Description nvarchar(50) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Chart Set Description=RTRIM(Description) Where Description <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // DrawerCounter
 SQLStr := 'Alter Table DrawerCounter Alter Column MachineID nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update DrawerCounter Set MachineID=RTRIM(MachineID) Where MachineID <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // ExpAcct
 SQLStr := 'Alter Table ExpAcct Alter Column Notes nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update ExpAcct Set Notes=RTRIM(Notes) Where Notes <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table ExpAcct Alter Column PayBy nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update ExpAcct Set PayBy=RTRIM(PayBy) Where PayBy <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table ExpAcct Alter Column OpName nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update ExpAcct Set OpName=RTRIM(OpName) Where OpName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // ExpDetail
 SQLStr := 'Alter Table ExpDetail Alter Column Description nvarchar(50) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update ExpDetail Set Description=RTRIM(Description) Where Description <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // Expenses
 SQLStr := 'Alter Table Expenses Alter Column AccountNo nvarchar(4) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Expenses Set AccountNo=RTRIM(AccountNo) Where AccountNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Expenses Alter Column InvoiceNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Expenses Set InvoiceNo=RTRIM(InvoiceNo) Where InvoiceNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Expenses Alter Column Memorandum nvarchar(100) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Expenses Set Memorandum=RTRIM(Memorandum) Where Memorandum <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Expenses Alter Column SupplierCode nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Expenses Set SupplierCode=RTRIM(SupplierCode) Where SupplierCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // InstructionLink
 SQLStr := 'Alter Table InstructionLink Alter Column Code nvarchar(4) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update InstructionLink Set Code=RTRIM(Code) Where Code <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table InstructionLink Alter Column ItemCode nvarchar(4) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update InstructionLink Set ItemCode=RTRIM(ItemCode) Where ItemCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // MachineID
 SQLStr := 'Alter Table MachineID Alter Column MachineID nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MachineID Set MachineID=RTRIM(MachineID) Where MachineID <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // MealPackage
 SQLStr := 'Alter Table MealPackage Alter Column ItemCode nvarchar(4) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MealPackage Set ItemCode=RTRIM(ItemCode) Where ItemCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // MenuItem
 SQLStr := 'Alter Table MenuItem Alter Column BarCode nvarchar(30) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set BarCode=RTRIM(BarCode) Where BarCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column BarCode1 nvarchar(30) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set BarCode1=RTRIM(BarCode1) Where BarCode1 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column BarCode2 nvarchar(30) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set BarCode2=RTRIM(BarCode2) Where BarCode2 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column BarCode3 nvarchar(30) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set BarCode3=RTRIM(BarCode3) Where BarCode3 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column SubDescription nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set SubDescription=RTRIM(SubDescription) Where SubDescription <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column SubDescription1 nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set SubDescription1=RTRIM(SubDescription1) Where SubDescription1 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column SubDescription2 nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set SubDescription2=RTRIM(SubDescription2) Where SubDescription2 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column SubDescription3 nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set SubDescription3=RTRIM(SubDescription3) Where SubDescription3 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column ItemCode nvarchar(4) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set ItemCode=RTRIM(ItemCode) Where ItemCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column Description1 nvarchar(100) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set Description1=RTRIM(Description1) Where Description1 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column Description2 nvarchar(100) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set Description2=RTRIM(Description2) Where Description2 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column Category nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set Category=RTRIM(Category) Where Category <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column FontName nvarchar(50) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set FontName=RTRIM(FontName) Where FontName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column SubDescription nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set FontName=RTRIM(SubDescription) Where SubDescription <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column SubDescription1 nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set FontName=RTRIM(SubDescription1) Where SubDescription1 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column SubDescription2 nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set FontName=RTRIM(SubDescription2) Where SubDescription2 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table MenuItem Alter Column SubDescription3 nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update MenuItem Set FontName=RTRIM(SubDescription3) Where SubDescription3 <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // OrderH
 SQLStr := 'Alter Table OrderH Alter Column BookingNo nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderH Set BookingNo=RTRIM(BookingNo) Where BookingNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table OrderH Alter Column OrderNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderH Set OrderNo=RTRIM(OrderNo) Where OrderNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table OrderH Alter Column TableNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderH Set TableNo=RTRIM(TableNo) Where TableNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table OrderH Alter Column ServicePerson nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderH Set ServicePerson=RTRIM(ServicePerson) Where ServicePerson <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table OrderH Alter Column InvoiceNo nvarchar(11) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderH Set InvoiceNo=RTRIM(InvoiceNo) Where InvoiceNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table OrderH Alter Column OpName nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderH Set OpName=RTRIM(OpName) Where OpName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table OrderH Alter Column MachineID nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderH Set MachineID=RTRIM(MachineID) Where MachineID <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // OrderI
 SQLStr := 'Alter Table OrderI Alter Column OrderNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderI Set OrderNo=RTRIM(OrderNo) Where OrderNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table OrderI Alter Column ItemCode nvarchar(4) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderI Set ItemCode=RTRIM(ItemCode) Where ItemCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // PayAcct
 SQLStr := 'Alter Table PayAcct Alter Column ReceiveNo nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PayAcct Set ReceiveNo=RTRIM(ReceiveNo) Where ReceiveNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PayAcct Alter Column PayBy nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PayAcct Set PayBy=RTRIM(PayBy) Where PayBy <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PayAcct Alter Column Notes nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PayAcct Set Notes=RTRIM(Notes) Where Notes <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PayAcct Alter Column OpName nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PayAcct Set OpName=RTRIM(OpName) Where OpName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // Payment
 SQLStr := 'Alter Table Payment Alter Column Payment nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Payment Set Payment=RTRIM(Payment) Where Payment <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // PayoutTable
 SQLStr := 'Alter Table PayoutTable Alter Column OpName nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PayoutTable Set OpName=RTRIM(OpName) Where OpName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PayoutTable Alter Column Description nvarchar(200) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PayoutTable Set Description=RTRIM(Description) Where Description <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PayoutTable Alter Column MachineID nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PayoutTable Set MachineID=RTRIM(MachineID) Where MachineID <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // Profile
 SQLStr := 'Alter Table Profile Alter Column CompanyName nvarchar(40) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Profile Set CompanyName=RTRIM(CompanyName) Where CompanyName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Profile Alter Column Telephone nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Profile Set Telephone=RTRIM(Telephone) Where Telephone <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Profile Alter Column Fax nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Profile Set Fax=RTRIM(Fax) Where Fax <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Profile Alter Column ABN nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Profile Set ABN=RTRIM(ABN) Where ABN <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Profile Alter Column Address nvarchar(100) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Profile Set Address=RTRIM(Address) Where Address <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // PurchaseHead
 SQLStr := 'Alter Table PurchaseHead Alter Column SupplierCode nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PurchaseHead Set SupplierCode=RTRIM(SupplierCode) Where SupplierCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PurchaseHead Alter Column PurchaseNo nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PurchaseHead Set PurchaseNo=RTRIM(PurchaseNo) Where PurchaseNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PurchaseHead Alter Column ReceiveNo nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PurchaseHead Set ReceiveNo=RTRIM(ReceiveNo) Where ReceiveNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PurchaseHead Alter Column Notes nvarchar(200) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PurchaseHead Set Notes=RTRIM(Notes) Where Notes <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PurchaseHead Alter Column DeliveryAddress nvarchar(150) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PurchaseHead Set DeliveryAddress=RTRIM(DeliveryAddress) Where DeliveryAddress <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PurchaseHead Alter Column OpName nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PurchaseHead Set OpName=RTRIM(OpName) Where OpName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // PurchaseItem
 SQLStr := 'Alter Table PurchaseItem Alter Column Code nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PurchaseItem Set Code=RTRIM(Code) Where Code <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table PurchaseItem Alter Column PurchaseNo nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update PurchaseItem Set PurchaseNo=RTRIM(PurchaseNo) Where PurchaseNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // RecvAcct
 SQLStr := 'Alter Table RecvAcct Alter Column OrderNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update RecvAcct Set OrderNo=RTRIM(OrderNo) Where OrderNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table RecvAcct Alter Column Payby nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update RecvAcct Set Payby=RTRIM(Payby) Where Payby <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table RecvAcct Alter Column OpName nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update RecvAcct Set OpName=RTRIM(OpName) Where OpName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // StockH
 SQLStr := 'Alter Table StockH Alter Column ReceiveNo nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockH Set ReceiveNo=RTRIM(ReceiveNo) Where ReceiveNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table StockH Alter Column Notes nvarchar(200) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockH Set Notes=RTRIM(Notes) Where Notes <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table StockH Alter Column OpName nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockH Set OpName=RTRIM(OpName) Where OpName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table StockH Alter Column SupplierCode nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockH Set SupplierCode=RTRIM(SupplierCode) Where SupplierCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table StockH Alter Column PurchaseNo nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockH Set PurchaseNo=RTRIM(PurchaseNo) Where PurchaseNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table StockH Alter Column InvoiceNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockH Set InvoiceNo=RTRIM(InvoiceNo) Where InvoiceNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // StockI
 SQLStr := 'Alter Table StockI Alter Column Code nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockI Set Code=RTRIM(Code) Where Code <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table StockI Alter Column ReceiveNo nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockI Set ReceiveNo=RTRIM(ReceiveNo) Where ReceiveNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // StockLinkTable
 SQLStr := 'Alter Table StockLinkTable Alter Column Code nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockLinkTable Set Code=RTRIM(Code) Where Code <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table StockLinkTable Alter Column ItemCode nvarchar(4) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockLinkTable Set ItemCode=RTRIM(ItemCode) Where ItemCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // StockTable
 SQLStr := 'Alter Table StockTable Alter Column Code nvarchar(8) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockTable Set Code=RTRIM(Code) Where Code <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table StockTable Alter Column Description nvarchar(100) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update StockTable Set Description=RTRIM(Description) Where Description <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // Supplier
 SQLStr := 'Alter Table Supplier Alter Column RegistNo nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Supplier Set RegistNo=RTRIM(RegistNo) Where RegistNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Supplier Alter Column SupplierCode nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Supplier Set SupplierCode=RTRIM(SupplierCode) Where SupplierCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Supplier Alter Column SupplierName nvarchar(40) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Supplier Set SupplierName=RTRIM(SupplierName) Where SupplierName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Supplier Alter Column Contact nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Supplier Set Contact=RTRIM(Contact) Where Contact <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Supplier Alter Column Telephone nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Supplier Set Telephone=RTRIM(Telephone) Where Telephone <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Supplier Alter Column Fax nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Supplier Set Fax=RTRIM(Fax) Where Fax <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Supplier Alter Column Address nvarchar(60) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Supplier Set Address=RTRIM(Address) Where Address <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Supplier Alter Column Suburb nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Supplier Set Suburb=RTRIM(Suburb) Where Suburb <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Supplier Alter Column State nvarchar(3) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Supplier Set State=RTRIM(State) Where State <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table Supplier Alter Column PostCode nvarchar(4) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update Supplier Set PostCode=RTRIM(PostCode) Where PostCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // TableSet
 SQLStr := 'Alter Table TableSet Alter Column TableNo nvarchar(10) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update TableSet Set TableNo=RTRIM(TableNo) Where TableNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table TableSet Alter Column FontName nvarchar(50) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update TableSet Set FontName=RTRIM(FontName) Where FontName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table TableSet Alter Column Description nvarchar(20) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update TableSet Set Description=RTRIM(Description) Where Description <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 // VIPTable
 SQLStr := 'Alter Table VIPTable Alter Column VIPName nvarchar(30) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set VIPName=RTRIM(VIPName) Where VIPName <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column Company nvarchar(40) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set Company=RTRIM(Company) Where Company <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column Telephone nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set Telephone=RTRIM(Telephone) Where Telephone <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column Fax nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set Fax=RTRIM(Fax) Where Fax <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column Mobile nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set Mobile=RTRIM(Mobile) Where Mobile <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column EMail nvarchar(40) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set EMail=RTRIM(EMail) Where EMail <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column Address nvarchar(100) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set Address=RTRIM(Address) Where Address <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column Notes nvarchar(255) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set Notes=RTRIM(Notes) Where Notes <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column Suburb nvarchar(25) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set Suburb=RTRIM(Suburb) Where Suburb <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column State nvarchar(3) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set State=RTRIM(State) Where State <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column PostCode nvarchar(4) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set PostCode=RTRIM(PostCode) Where PostCode <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column SerialNo nvarchar(16) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set SerialNo=RTRIM(SerialNo) Where SerialNo <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);

 SQLStr := 'Alter Table VIPTable Alter Column MapReference nvarchar(15) Null';
 ExecQueryPro(SQLStr);
 SQLStr := 'Update VIPTable Set MapReference=RTRIM(MapReference) Where MapReference <> ' + Chr(39) + Chr(39);
 ExecQueryPro(SQLStr);
end;

procedure TUpgradeForm.UpgradePro(DatabaseConnection: TADOConnection);
var
 CurrentDatabaseVersion: double;
begin
 Application.CreateForm(TUpgradeForm, UpgradeForm);
 UpgradeForm.DatabaseConnection := DatabaseConnection;
 with UpgradeForm do
  if TestVersionPro(CurrentDatabaseVersion) then
     try
      DisplayMessageForm.DisplayMessagePro('Update System, please wait...');
      DataForm.ExecCommand.CommandTimeout := 300;
      Application.ProcessMessages;
      DropIndex;
      UpdateCharTonvarchar;
      CreateButtonsTablePro;
      CreateDiscountRateTablePro;
      CreateTransactionLogTablePro;
      CreateStreetTablePro;
      CreateDepartmentTablePro;
      CreateDepositTablePro;
      CreatePointsPaymentTablePro;
      CreateSubMenuLinkTablePro;
      CreateMenuGroupTablePro;
      CreateVoidReasonTablePro;
      CreateTablePagePro;
      DeleteOldKitchenScreenTablePro;
      CreateKitchenScreenTablePro;
      CreateWastageHeadTablePro;
      CreateWastageItemTablePro;
      CreateHoldHeadTablePro;
      CreateHoldItemTablePro;
      CreateMachineIDTablePro;
      CreateIngredientsTablePro;
      CreateDrawerCounterTablePro;
      CreatePayOutTablePro;
      CreateCashFloatTablePro;
      CreateStockTablePro;
      CreateExpDetailTablePro;
      CreatePurchaseTablePro;
      CreatePurchasePayableTablePro;
      CreateInstructionTablePro;
      CreateBankTablePro;
      CreateAttendanceTablePro;
      DeletePrintJobListTablePro;
      UpgradeTableSetPro;
      UpgradeProfileTablePro;
      UpgradeExpAcctTablePro;
      UpgradeExpensesTablePro;
      UpgradePaymentMethodPro;
      UpdateInstructionLinkTable;
      UpgradeAccessMenuTablePro;
      UpgradeMenuTablePro;
      UpgradeOrderHTablePro;
      UpgradeOrderITablePro;
      UpgradeMealPackageTablePro;
      UpgradeBookHeadTablePro;
      UpgradeBookItemTablePro;
      UpgradeMenuItemTablePro;
      UpgradeRecvAcctTablePro;
      UpgradeCategoryTablePro;
      UpgradeChartTablePro;
      UpgradeStockHTablePro;
      UpgradeStockITablePro;
      UpgradeVIPTablePro;
      UpgradeSupplierTablePro;
      UpdateCharTonvarchar;
      //UpgradeButtonTablePro;
      RebuildIndex;

      UpdateVersionPro;
     finally
      DataForm.ExecCommand.CommandTimeout := 30;
      DisplayMessageForm.Close;
      DisplayMessageForm.Free;
     end;
 UpgradeForm.Free;
end;

end.
