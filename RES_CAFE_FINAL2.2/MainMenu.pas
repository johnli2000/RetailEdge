unit MainMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ToolWin, ComCtrls, Menus, StdCtrls, ExtCtrls, ShellApi,
  BusinessSkinForm, bsSkinData, bsSkinCtrls, bsMessages, SecondDisplay;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    ServiceMenu: TMenuItem;
    BookingListMenu: TMenuItem;
    TableServiceMenu: TMenuItem;
    ReportsMenu: TMenuItem;
    BackOfficeMenu: TMenuItem;
    SystemsMenu: TMenuItem;
    HelpMainMenu: TMenuItem;
    N1: TMenuItem;
    ExpensesDataEntryMenu: TMenuItem;
    ExpensesReportMenu: TMenuItem;
    PaymentsReportMenu: TMenuItem;
    ReceiptsReportMenu: TMenuItem;
    N3: TMenuItem;
    StockReportMenu: TMenuItem;
    GSTPayableReportMenu: TMenuItem;
    ProfileSetupMenu: TMenuItem;
    N5: TMenuItem;
    MenuSetupMenu: TMenuItem;
    PaymentsMethodSetupMenu: TMenuItem;
    InvoiceConditionSetupMenu: TMenuItem;
    PrinterSetMenu: TMenuItem;
    CategorySetupMenu: TMenuItem;
    UserManagerMenu: TMenuItem;
    PasswordMenu: TMenuItem;
    N7: TMenuItem;
    VIPInformationMenu: TMenuItem;
    StockReceiveReportMenu: TMenuItem;
    DatabaseMaintananceMenu: TMenuItem;
    N8: TMenuItem;
    InquirySalesHistoryMenu: TMenuItem;
    ExpensesDescriptionSetupMenu: TMenuItem;
    BookingFormConditionSetupMenu: TMenuItem;
    SalesStatisticsReportMenu: TMenuItem;
    SupplierInformationSetupMenu: TMenuItem;
    SupplierInformationListMenu: TMenuItem;
    StockReceiveMenu: TMenuItem;
    N9: TMenuItem;
    QuickServiceMenu: TMenuItem;
    MealsPackageSetupMenu: TMenuItem;
    SalesStatisticsChartMenu: TMenuItem;
    DatabaseBackupMenu: TMenuItem;
    N10: TMenuItem;
    OpenCashDrawerMenu: TMenuItem;
    DailyReportMenu: TMenuItem;
    BankAccountSetupMenu: TMenuItem;
    BankReconciliationMenu: TMenuItem;
    N11: TMenuItem;
    TableInformationSetupMenu: TMenuItem;
    SalesSummaryReportMenu: TMenuItem;
    AttendanceRecordMenu: TMenuItem;
    AttendanceReportMenu: TMenuItem;
    N12: TMenuItem;
    StockItemsSetupMenu: TMenuItem;
    SalesVoidReportMenu: TMenuItem;
    PurchaseOrderMenu: TMenuItem;
    PurchasePaymentReportMenu: TMenuItem;
    PurchasePayableMenu: TMenuItem;
    N4: TMenuItem;
    DiscountReportMenu: TMenuItem;
    CashPayOutReportMenu: TMenuItem;
    BillConditionSetupMenu: TMenuItem;
    MachineIDSetupMenu: TMenuItem;
    DatabaseRestoreMenu: TMenuItem;
    TransferDatabaseMenu: TMenuItem;
    RegistLine: TMenuItem;
    RegistProgramMenu: TMenuItem;
    StockAdjustmentMenu: TMenuItem;
    StockAdjustmentReportMenu: TMenuItem;
    EFTPosUtilityMenu: TMenuItem;
    ItemVoidReasonDescriptionSetupMenu: TMenuItem;
    HelpMenu: TMenuItem;
    AboutMenu: TMenuItem;
    DailySummaryReportMenu: TMenuItem;
    MenuGroupSetupMenu: TMenuItem;
    DepartmentSetupMenu: TMenuItem;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    bsSkinData: TbsSkinData;
    bsResourceStrData: TbsResourceStrData;
    bsCompressedStoredSkin: TbsCompressedStoredSkin;
    bsSkinMainMenuBar: TbsSkinMainMenuBar;
    PhoneOrderMenu: TMenuItem;
    CashPayOutMenu: TMenuItem;
    CashFloatMenu: TMenuItem;
    CashFloatListMenu: TMenuItem;
    SummaryByItemsMenu: TMenuItem;
    SummaryByHoursMenu: TMenuItem;
    N13: TMenuItem;
    DeliveryAddressSetupMenu: TMenuItem;
    SummaryByMenuGroupMenu: TMenuItem;
    DepositMenu: TMenuItem;
    WastageMenu: TMenuItem;
    WastageReportMenu: TMenuItem;
    N15: TMenuItem;
    WastageSummaryReportMenu: TMenuItem;
    DiscountRateSetupMenu: TMenuItem;
    SummaryByCategoryMenu: TMenuItem;
    SummaryByClerks1: TMenuItem;
    SummaryByItemGroupMenu: TMenuItem;
    SalesPriceBelowFixPriceReportMenu: TMenuItem;
    ZeroQuantitysalesReportMenu: TMenuItem;
    CurrentStockSalesMarginReportMenu: TMenuItem;
    ControlButtonsSetupMenu: TMenuItem;
    NotUsed1: TMenuItem;
    N2: TMenuItem;
    ReceivableReport1: TMenuItem;
    DepositList1: TMenuItem;
    DrawerOpenDateTimeListMenu: TMenuItem;
    SalesCancelReport1: TMenuItem;
    function  AdjustPrivilege: boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ProfileSetupMenuClick(Sender: TObject);
    procedure InvoiceConditionSetupMenuClick(Sender: TObject);
    procedure CategorySetupMenuClick(Sender: TObject);
    procedure PaymentsMethodSetupMenuClick(Sender: TObject);
    procedure MenuSetupMenuClick(Sender: TObject);
    procedure PrinterSetMenuClick(Sender: TObject);
    //procedure ExpensesDescriptionSetupMenuClick(Sender: TObject);
    //procedure ExpensesDataEntryMenuClick(Sender: TObject);
    //procedure ExpensesReportMenuClick(Sender: TObject);
    //procedure PaymentsReportMenuClick(Sender: TObject);
    procedure BookingFormConditionSetupMenuClick(Sender: TObject);
    procedure ReceiptsReportMenuClick(Sender: TObject);
    procedure SalesStatisticsReportMenuClick(Sender: TObject);
    //procedure StockReportMenuClick(Sender: TObject);
    //procedure SupplierInformationSetupMenuClick(Sender: TObject);
    //procedure SupplierInformationListMenuClick(Sender: TObject);
    procedure InquirySalesHistoryMenuClick(Sender: TObject);
    //procedure BookingListMenuClick(Sender: TObject);
    procedure TableServiceMenuClick(Sender: TObject);
    procedure VIPInformationMenuClick(Sender: TObject);
    //procedure StockReceiveReportMenuClick(Sender: TObject);
    //procedure GSTPayableReportMenuClick(Sender: TObject);
    procedure DatabaseMaintananceMenuClick(Sender: TObject);
    procedure UserManagerMenuClick(Sender: TObject);
    procedure ExitMenuClick(Sender: TObject);
    procedure PasswordMenuClick(Sender: TObject);
    //procedure MealsPackageSetupMenuClick(Sender: TObject);
    procedure SalesStatisticsChartMenuClick(Sender: TObject);
    procedure OpenCashDrawerMenuClick(Sender: TObject);
    procedure DailyReportMenuClick(Sender: TObject);
    //procedure BankAccountSetupMenuClick(Sender: TObject);
    //procedure BankReconciliationMenuClick(Sender: TObject);
    procedure QuickServiceMenuClick(Sender: TObject);
    procedure TableInformationSetupMenuClick(Sender: TObject);
    procedure AttendanceRecordMenuClick(Sender: TObject);
    procedure AttendanceReportMenuClick(Sender: TObject);
   // procedure StockItemsSetupMenuClick(Sender: TObject);
    procedure SalesVoidReportMenuClick(Sender: TObject);
    procedure AboutMenuClick(Sender: TObject);
    //procedure PurchasePayableMenuClick(Sender: TObject);
    //procedure PurchasePaymentReportMenuClick(Sender: TObject);
    //procedure PurchaseOrderMenuClick(Sender: TObject);
    //procedure StockReceiveMenuClick(Sender: TObject);
    procedure DiscountReportMenuClick(Sender: TObject);
    procedure CashPayOutReportMenuClick(Sender: TObject);
    procedure BillConditionSetupMenuClick(Sender: TObject);
    procedure MachineIDSetupMenuClick(Sender: TObject);
    procedure DatabaseBackupMenuClick(Sender: TObject);
    procedure DatabaseRestoreMenuClick(Sender: TObject);
    procedure RegistSoftwareMenuClick(Sender: TObject);
    procedure TransferDatabaseMenuClick(Sender: TObject);
    procedure RegistProgramMenuClick(Sender: TObject);
    //procedure StockAdjustmentMenuClick(Sender: TObject);
    //procedure StockAdjustmentReportMenuClick(Sender: TObject);
   // procedure EFTPosUtilityMenuClick(Sender: TObject);
    procedure ItemVoidReasonDescriptionSetupMenuClick(Sender: TObject);
    procedure HelpMenuClick(Sender: TObject);
    procedure DailySummaryReportMenuClick(Sender: TObject);
    procedure MenuGroupSetupMenuClick(Sender: TObject);
    procedure DepartmentSetupMenuClick(Sender: TObject);
    //procedure PhoneOrderMenuClick(Sender: TObject);
    procedure CashPayOutMenuClick(Sender: TObject);
    procedure CashFloatMenuClick(Sender: TObject);
    procedure CashFloatListMenuClick(Sender: TObject);
    procedure SummaryByItemsMenuClick(Sender: TObject);
    procedure SummaryByHoursMenuClick(Sender: TObject);
    //procedure DeliveryAddressSetupMenuClick(Sender: TObject);
    procedure SummaryByMenuGroupMenuClick(Sender: TObject);
    //procedure DepositMenuClick(Sender: TObject);
    //procedure DepositListMenuClick(Sender: TObject);
    procedure ReceivableReportMenuClick(Sender: TObject);
   // procedure DepositReportMenuClick(Sender: TObject);
   // procedure WastageMenuClick(Sender: TObject);
    //procedure WastageReportMenuClick(Sender: TObject);
    //procedure WastageSummaryReportMenuClick(Sender: TObject);
    procedure DiscountRateSetupMenuClick(Sender: TObject);
    procedure SummaryByCategoryMenuClick(Sender: TObject);
    procedure SummaryByClerks1Click(Sender: TObject);
    procedure SummaryByItemGroupMenuClick(Sender: TObject);
    procedure SalesPriceBelowFixPriceReportMenuClick(Sender: TObject);
    procedure ZeroQuantitysalesReportMenuClick(Sender: TObject);
    //procedure CurrentStockSalesMarginReportMenuClick(Sender: TObject);
    procedure ControlButtonsSetupMenuClick(Sender: TObject);
    procedure DepositList1Click(Sender: TObject);
    procedure DrawerOpenDateTimeListMenuClick(Sender: TObject);
    procedure SalesCancelReport1Click(Sender: TObject);
    

    



  private{ Private declarations }
  public { Public declarations }
   BitMap: TBitmap;
  end;

var
  MainForm: TMainForm;
  SecondDisplayForm: TSecondDisplayForm;

implementation

uses ControlPanel, DataUnit, Profile, EditCondition, Category, MenuSetup,
     SysConfig,  OrderList, PaymentSetup,
     SalesStatistics,
      UserMng, ReadPSWD, SalesHistoryList,
     Password, ReceiptReport,  Statistics, EndOfDayRpt,
      TableOrder, PointOfsales,
     Close, TableSetup, SalesSummaryReport,
      Upgrade,  MessageBox, Backup,
     SalesVoidReport, AboutUnit,
      PaymentReport,
     DiscountReport, PayOutList, MachineIDSetup, Restore, Regist,
     DatabaseTransfer, UtilUnit,
      VoidReasonSetup,
      SalesDailySummaryReport, SelectDrawerNumber,
     MenuGroupSetup, ItemGroupSetup, PayOut, CashFloat,
     CashFloatList, PDATableLayout, SalesHoursSummaryReport,
     SalesMenuGroupSummaryReport,

     DiscountRateSetup, SalesCategorySummaryReport, SalesClerkSummaryReport,
     SalesItemGroupSummaryReport, PriceBelowFixPriceReport,
     ZeroQtySalesReport, ManuallyMaintainDatabase,
     ControlButtonSetup, AttendanceRpt, Security, Attendance, VIPList, ReceivableReport,
  DepositList, DrawerOpenList, SaleCancel;

{$R *.DFM}

function TMainForm.AdjustPrivilege: boolean;
var
 hToken : THANDLE ;
 tkp : TOKEN_PRIVILEGES ;
 lpSystemName,lpName : array[0..256] of char;
 buffLen : DWord;
begin
  StrPCopy(lpSystemName,'');
  StrPCopy(lpName,'SeShutdownPrivilege');
  if ( not OpenProcessToken(GetCurrentProcess(),
     TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken)) then
    Result := FALSE
  else
  begin
    LookupPrivilegeValue(lpSystemName, lpName, tkp.Privileges[0].Luid);
    tkp.PrivilegeCount := 1;  // one privilege to set
    tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
    bufflen := 0;
    Result := AdjustTokenPrivileges(hToken, FALSE, tkp, 0, nil, bufflen);
  end
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
 CloseMode: integer;
begin
 Action := caNone;
 if MDIChildCount > 1 then
    begin
     MessageBoxForm.MessagePro('You should close all windows first.', sErrorMsg);
     Exit;
    end
   else
    if ExitSystemForm.ExitSystemPro(CloseMode) then
       begin
        if CloseMode <> 0 then
           case CloseMode of
            1: if MessageBoxForm.MessagePro('Are you sure you want to restart this machine?', sConfirmMsg) = mrNo then Exit;
            2: if MessageBoxForm.MessagePro('Are you sure you want to shut down this machine?', sConfirmMsg) = mrNo then Exit;
           end;
        with DataForm.ADOConnection do
         if Connected then Connected := False;
        ControlPanelForm.Close;
        if SecondDisplayForm <> Nil then
           begin
            SecondDisplayForm.PictureTimer.Enabled := False;
            SecondDisplayForm.Close;
            SecondDisplayForm.Free;
            SecondDisplayForm := Nil;
           end;
        DataForm.Free;
        SecurityForm.Free;
        if (CloseMode <> 0) and AdjustPrivilege then
           case CloseMode of
             1:  ExitWindowsEx(EWX_REBOOT or EWX_FORCE, 0);
             2:  ExitWindowsEx(EWX_SHUTDOWN or EWX_FORCE or EWX_POWEROFF, 0);
            end;
        Action := caFree;
       end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 Top := 0;
 Left := 0;
 bsBusinessSkinForm.WindowState := wsMaximized;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
 Height := Screen.Height;
 Width := Screen.Width;
 
 RegistProgramMenu.Visible := Not SecurityForm.TestSoftDog and Not SecurityForm.TestSerialNo;
 RegistLine.Visible := RegistProgramMenu.Visible;
 ControlPanelForm.ControlPanelPro;
end;

procedure TMainForm.ProfileSetupMenuClick(Sender: TObject);
begin
 ProfileSetupForm.ProfileSetupPro;
end;

procedure TMainForm.BillConditionSetupMenuClick(Sender: TObject);
begin
 EditConditionForm.EditConditionPro(0);
end;

procedure TMainForm.InvoiceConditionSetupMenuClick(Sender: TObject);
begin
 EditConditionForm.EditConditionPro(1);
end;

procedure TMainForm.BookingFormConditionSetupMenuClick(Sender: TObject);
begin
 EditConditionForm.EditConditionPro(2);
end;

procedure TMainForm.CategorySetupMenuClick(Sender: TObject);
begin
 CategoryForm.CategorySetup;
end;

procedure TMainForm.PaymentsMethodSetupMenuClick(Sender: TObject);
begin
 PaymentSetupForm.PaymentSetup;
end;

procedure TMainForm.MenuSetupMenuClick(Sender: TObject);
begin
 MenuItemForm.MenuSetup(0);
end;

procedure TMainForm.PrinterSetMenuClick(Sender: TObject);
begin
 ConfigurationForm.SetupPro;
 if SecondDisplayForm <> Nil then
    begin
     SecondDisplayForm.PictureTimer.Enabled := False;
     SecondDisplayForm.Close;
     SecondDisplayForm := Nil;
    end;
 if Fvar.SecondDisplay = 1 then
    begin
     SecondDisplayForm := TSecondDisplayForm.Create(Self);
     SecondDisplayForm.Left := Screen.Width;
     SecondDisplayForm.Top := 0;
     SecondDisplayForm.SetWaitingStatus;
    end;
 if DataForm.EFTPOS <> NIL then
    begin
     DataForm.EFTPOS.Free;
     DataForm.EFTPOS := NIL;
    end; 
 if FVar.LinkToEFTPOS = 1 then DataForm.InitToLinkEFTPOS;
end;



procedure TMainForm.ReceiptsReportMenuClick(Sender: TObject);
begin
 ReceiptReportForm.ReceiptReportPro;
end;

procedure TMainForm.SalesStatisticsReportMenuClick(Sender: TObject);
begin
 SalesSummaryReportForm.SalesReportPro;
end;



procedure TMainForm.InquirySalesHistoryMenuClick(Sender: TObject);
begin
 SalesHistoryListForm.SalesHistoryListPro(0);
end;


procedure TMainForm.TableServiceMenuClick(Sender: TObject);
begin
 TableOrderForm.TableOrderPro(False);
end;



procedure TMainForm.DatabaseMaintananceMenuClick(Sender: TObject);
begin
 ManuallyMaintainDatabaseForm.ManuallyMaintainDatabasePro;
end;

procedure TMainForm.UserManagerMenuClick(Sender: TObject);
begin
 if ReadPassword.ReadPasswordPro and (UserManager or Supervisor) then
    UserManagerForm.SetUserPro;
end;

procedure TMainForm.ExitMenuClick(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.PasswordMenuClick(Sender: TObject);
begin
 PasswordEdit.ChangePassword;
end;


procedure TMainForm.SalesStatisticsChartMenuClick(Sender: TObject);
begin
 StatisticsForm.StatisticsPro;
end;

procedure TMainForm.OpenCashDrawerMenuClick(Sender: TObject);
var
 StaffName: string;
begin
 if Not DataForm.VerifyPassword(StaffName) then Exit;
 if AuthoriseDrawerPortNumber >= 2 then
    begin
     if (FVar.CashDrawerPort > 0) and (FVar.SecondCashDrawerPort > 0) then
        begin
         if SelectDrawerNumberForm.SelectDrawerNumber(CurrentDrawerNumber) then
            DataForm.OpenDrawer(False, CurrentDrawerNumber)
        end
       else
        begin
         if FVar.CashDrawerPort > 0 then
            CurrentDrawerNumber := 0
           else
            if FVar.SecondCashDrawerPort > 0 then
               CurrentDrawerNumber := 1
              else
               CurrentDrawerNumber := -1;
         if CurrentDrawerNumber >= 0 then DataForm.OpenDrawer(False, CurrentDrawerNumber);
        end
     end
    else
     begin
      CurrentDrawerNumber := DefaultDrawerPortNumber;
      DataForm.OpenDrawer(False, CurrentDrawerNumber);
     end;
end;

procedure TMainForm.DailyReportMenuClick(Sender: TObject);
begin
 EndOfdayForm.DailyReportPro(0);
end;



procedure TMainForm.QuickServiceMenuClick(Sender: TObject);
begin
 PointOfSalesForm.PointOfsalesPro(False);
end;

procedure TMainForm.TableInformationSetupMenuClick(Sender: TObject);
begin
 TableSetupForm.TableSetupPro;
end;

procedure TMainForm.AttendanceRecordMenuClick(Sender: TObject);
begin
 AttendanceForm.AttendancePro;
end;

procedure TMainForm.AttendanceReportMenuClick(Sender: TObject);
begin
 AttendanceReportForm.AttendanceReportPro;
end;

procedure TMainForm.SalesVoidReportMenuClick(Sender: TObject);
begin
 SalesVoidReportForm.SalesVoidReportPro;
end;

procedure TMainForm.AboutMenuClick(Sender: TObject);
begin
 AboutForm.ShowAboutBox;
end;




procedure TMainForm.DiscountReportMenuClick(Sender: TObject);
begin
 DiscountReportForm.DiscountReportPro;
end;

procedure TMainForm.CashPayOutReportMenuClick(Sender: TObject);
begin
 PayOutListForm.PayOutListPro;
end;

procedure TMainForm.MachineIDSetupMenuClick(Sender: TObject);
begin
 MachineIDSetupForm.MachineIDSetupPro;
end;

procedure TMainForm.DatabaseBackupMenuClick(Sender: TObject);
begin
 BackupForm.BackupPro;
end;

procedure TMainForm.DatabaseRestoreMenuClick(Sender: TObject);
begin
 if RestoreForm.RestorePro then
    ControlPanelForm.LogoutPro;
end;

procedure TMainForm.RegistSoftwareMenuClick(Sender: TObject);
begin
 RegistryForm.RegistyPro
end;

procedure TMainForm.TransferDatabaseMenuClick(Sender: TObject);
begin
 DatabaseTransferForm.DatabaseTransferPro;
end;

procedure TMainForm.RegistProgramMenuClick(Sender: TObject);
begin
 RegistryForm.RegistyPro;
end;




procedure TMainForm.ItemVoidReasonDescriptionSetupMenuClick(Sender: TObject);
begin
 VoidReasonSetupForm.VoidReasonSetupPro;
end;

procedure TMainForm.HelpMenuClick(Sender: TObject);
var
 HelpFileName: string;
begin
 HelpFileName := StartDir + 'HospitalityHelp.PDF';
 if Not FileExists(HelpFileName) then
    MessageBoxForm.MessagePro('Can not find help file (HospitalityHelp.PDF).', sErrorMsg)
   else
    ShellExecute(Application.Handle, 'Open', PChar(HelpFileName), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TMainForm.DailySummaryReportMenuClick(Sender: TObject);
begin
 SalesDailySummaryReportForm.SalesDailySummaryReportPro;
end;

procedure TMainForm.MenuGroupSetupMenuClick(Sender: TObject);
begin
 MenuGroupSetupForm.MenuGroupSetupPro;
end;

procedure TMainForm.DepartmentSetupMenuClick(Sender: TObject);
begin
 ItemGroupSetupForm.ItemGroupSetupPro;
end;


procedure TMainForm.CashPayOutMenuClick(Sender: TObject);
begin
 PayOutForm.PayOutPro;
end;

procedure TMainForm.CashFloatMenuClick(Sender: TObject);
begin
 CashFloatForm.CashFloatPro;
end;

procedure TMainForm.CashFloatListMenuClick(Sender: TObject);
begin
 CashFloatListForm.CashFloatListPro;
end;

procedure TMainForm.SummaryByItemsMenuClick(Sender: TObject);
begin
 SalesStatisticsForm.SalesStatisticsPro;
end;

procedure TMainForm.SummaryByHoursMenuClick(Sender: TObject);
begin
 SalesHoursSummaryReportForm.SalesHoursSummaryReportPro;
end;


procedure TMainForm.SummaryByMenuGroupMenuClick(Sender: TObject);
begin
 SalesMenuGroupSummaryReportForm.SalesMenuGroupSummaryReportPro;
end;


procedure TMainForm.DiscountRateSetupMenuClick(Sender: TObject);
begin
 DiscountRateSetupForm.DiscountRateSetupPro;
end;

procedure TMainForm.SummaryByCategoryMenuClick(Sender: TObject);
begin
 SalesCategorySummaryReportForm.SalesCategorySummaryReportPro;
end;

procedure TMainForm.SummaryByClerks1Click(Sender: TObject);
begin
 SalesClerkSummaryReportForm.SalesClerkSummaryReportPro;
end;

procedure TMainForm.SummaryByItemGroupMenuClick(Sender: TObject);
begin
 SalesItemGroupSummaryReportForm.SalesItemGroupSummaryReportPro;
end;

procedure TMainForm.SalesPriceBelowFixPriceReportMenuClick(Sender: TObject);
begin
 PriceBelowFixPriceReportForm.PriceBelowFixPriceReportPro;
end;

procedure TMainForm.ZeroQuantitysalesReportMenuClick(Sender: TObject);
begin
 ZeroQtySalesReportForm.ZeroQtySalesReportPro;
end;



procedure TMainForm.ControlButtonsSetupMenuClick(Sender: TObject);
begin
 ControlButtonSetupForm.ControlButtonSetupPro;
end;







procedure TMainForm.VIPInformationMenuClick(Sender: TObject);
var
 Temp: integer;
begin
 Temp := 0;
 VIPListForm.VIPListPro(Temp);
end;

procedure TMainForm.ReceivableReportMenuClick(Sender: TObject);
begin
 ReceivableReportForm.ReceivableReportPro;
end;



procedure TMainForm.DepositList1Click(Sender: TObject);
begin
  DepositListForm.DepositListPro;
end;

procedure TMainForm.DrawerOpenDateTimeListMenuClick(Sender: TObject);
begin
 DrawerOpenListForm.DrawerOpenListPro;
end;

procedure TMainForm.SalesCancelReport1Click(Sender: TObject);
begin
  SalesCancelForm.SalesCancelReportPro;
end;

end.




