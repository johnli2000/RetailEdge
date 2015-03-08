unit DataUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, CommDrv, ExtCtrls, Printers, StdCtrls, ComCtrls, Variants, ADODB, Grids,
  OleCtrls, CSDEFTLib_TLB, Security, Winspool, ScktComp,ShellApi;

Const
 sAdd = 1;
 sMinus = 2;
 sMore = 3;
 sLess = 4;
 sNewStatus = 0;
 sEditStatus = 1;
 sViewStatus = 3;
 sNewTable = 1;
 sEditTable = 2;
 sChangeTable = 3;
 sErrorMsg =1;
 sInformationMsg = 2;
 sConfirmMsg = 3;
 sExpireDays = 35;
 sTABLEORDER = 0;
 sQUICKSALE = 1;
 sPHONEORDER = 2;
 sBOOKDETAIL = 3;
 sPhoneOrderDelivery = 0;
 sPhoneOrderPickup = 1;
 sTakeAway = 2;
 sConfirmedOrder = True;
 sUnConfirmedOrder = False;
 sVersion = '7.73';
 SearchMark = '%';
 sCurrency = '$';

 sTableOrderControlButton = 1;
 sTableOrderEditButton = 2;
 sQuickServiceButton = 3;
 sPhoneOrderButton = 4;
 
 sButtonNormalSize = 0;
 sButtonDoubleWidth = 1;
 sButtonDoubleHeight = 2;
 sButtonDoubleWidthDoubleHeight = 3;

 bcNeoDesert = 0;
 bcNeoSky = 1;
 bcNeoGrass = 2;
 bcNeoSilver = 3;
 bcNeoRose = 4;
 bcNeoSun = 5;
 bcDesert = 6;
 bcGrass = 7;
 bcSky = 8;
 bcSun = 9;
 bcRose = 10;
 bcSilver = 11;

 tcTableOrderButtonClick = 1;
 tcPhoneOrderAdminButtonClick = 2;
 tcQuickServiceButtonClick = 3;
 tcSplitBillButtonClick = 4;
 tcMergeTableButtonClick = 5;
 tcPaymentButtonClick = 6;
 tcPrintInvoiceButtonClick = 7;
 tcPrintBillButtonClick = 8;
 tcPrintJobListButtonClick = 9;
 //tcPrintPickupSlipButtonClick = 10;
 tcPrintGoWithMessageButtonClick = 11;
 tcDailyReportButtonClick = 12;
 tcTableStatusButtonClick = 13;
 tcOrderListButtonClick = 14;
 tcReservationListButtonClick = 15;
 tcOpenDrawerButtonClick = 16;
 tcMenuGroupButtonClick = 17;
 tcMenuSetupButtonClick = 18;
 tcDepositButtonClick = 19;
 tcCashPayOutButtonClick = 20;
 tcUserIDButtonClick = 21;
 tcVIPManagerButtonClick = 22;
 tcExitButtonClick = 23;
 tcPrintPickupSlipButtonClick = 24  ;

 teQtyButtonClick = 1;
 tePriceButtonClick = 2;
 teDiscountButtonClick = 3;
 teVoidItemButtonClick = 4;
 teInsertItemButtonClick = 5;
 teDirectPaymentButtonClick = 6;
 teBalanceButtonClick = 7;
 teWeightButtonClick = 8;
 teViewIngredientsButtonClick = 9;
 teSpellInstructionButtonClick = 10;
 teInstructionButtonClick = 11;
 teMealPackageButtonClick = 12;
 teAccountPaymentButtonClick = 13;
 teSurchargeButtonClick = 14;
 teOtherChargeButtonClick = 15;
 teRedeemPointButtonClick = 16;
 teOrderDueTimeButtonClick = 17;
 teSeatNumberButtonClick = 18;
 teDirectPrintBillButtonClick = 19;
 teQuitButtonClick = 20;
 teChangeMenuButtonClick = 21;
 teVoidAllItemButtonClick = 22;
 teChangeUserIDButtonClick = 23;
 teReservationButtonClick = 24;
 teVIPListButtonClick = 25;
 teCustomerNameButtonClick = 26;
 teChangeMenuGroupButtonClick = 27;

 qsQtyButtonClick = 1;
 qsWeightButtonClick = 2;
 qsPriceButtonClick = 3;
 qsVoidItemButtonClick = 4;
 qsInsertButtonClick = 5;
 qsPaymentButtonClick = 6;
 qsViewIngredientsButtonClick = 7;
 qsSpellInstructionButtonClick = 8;
 qsInstructionButtonClick = 9;
 qsPrintInvoiceButtonClick = 10;
 qsPrintBillButtonClick = 11;
 qsCashPayOutButtonClick = 12;
 qsDiscountButtonClick = 13;
 qsChangeUserIDButtonClick = 14;
 qsPrintJobListButtonClick = 15;
 qsPrintPickupSlipButtonClick = 16;
 qsCancelButtonClick = 17;
 qsMoreFunctionButtonClick = 18;
 qsOpenDrawerButtonClick = 19;
 qsAccountPaymentButtonClick = 20;
 qsVIPListButtonClick = 21;
 qsMenuGroupButtonClick = 22;
 qsExitButtonClick = 23;
 qsTableServiceClick = 24;
 qsPrintLastInvoiceClick = 25;
 qsSplitBillButtonClick = 26;
 qsPhoneOrderAdminButtonClick = 27;

 poQtyButtonClick = 1;
 poPriceButtonClick = 2;
 poDiscountButtonClick = 3;
 poSpellInstructionButtonClick = 4;
 poAssignDriverButtonClick = 5;
 poBalanceButtonClick = 6;
 poWeightButtonClick = 7;
 poVoidItemButtonClick = 8;
 poInsertItemButtonClick = 9;
 poInstructionButtonClick = 10;
 poMenuGroupButtonClick = 11;
 poMoreFunctionButtonClick = 12;
 poSearchCustomerButtonClick = 13;
 poPickupOrDeliveryButtonClick = 14;
 poVoidAllItemButtonClick = 15;
 poViewCustomerDetailButtonClick = 16;
 poCancelButtonClick = 17;
 poDepositButtonClick = 18;
 poCustomerOrderHistoryButtonClick = 19;

type
  InstructionBufftype = Record
   Code, Description1, Description2: array [1..50] of String;
   Qty, Price, TaxRate: array [1..50] of double;
   Discount: array [1..50] of boolean;
   Condition: array [1..50] of integer;
   MaximunCharge: array [1..50] of boolean;
  end;
  PrinterNameType = Record
   Name: array [0..255] of Char;
  end;
  JobListTitleType = Record
   TitleName: array [0..19] of Char;
  end;
  OldDevicePortType1 = Record
   POSPrinter: array [1..12] of PrinterNameType;
   PrinterSpeed: array [1..12] of Smallint;
   PrinterFlowCtrl: array [1..12] of SmallInt;
   AutoCutter: array [1..12] of SmallInt;
   JobListDuplicate: array [1..12] of SmallInt;
   Thermal: array [1..12] of SmallInt;
   CashDrawerPort: SmallInt;
   CashDrawerSpeed: SmallInt;
   DrawerFlowCtrl: SmallInt;
   CashDrawerMode: SmallInt;
   CheckTillStatus: SmallInt;
   DefaultPrinter: SmallInt;
   PDAPrinterServer: SmallInt;
   DefaultTablePage: SmallInt;
   PoleDisplayPort, PoleDisplaySpeed, PoleFlowCtrl: SmallInt;
   KitchenScreen, SendDescription: SmallInt;
   ScalePort, ScaleSpeed, ScaleFlowCtrl: SmallInt;
   SecondDisplay: SmallInt;
   LinkToEFTPOS: SmallInt;
   ScaleModel: SmallInt;
   Reserve1, Reserve2, Reserve3, Reserve4,
   Reserve5, Reserve6, Reserve7: SmallInt;
  end;
  OldDevicePortType2 = Record
   POSPrinter: array [1..12] of PrinterNameType;
   PrinterSpeed: array [1..12] of Smallint;
   PrinterFlowCtrl: array [1..12] of SmallInt;
   AutoCutter: array [1..12] of SmallInt;
   JobListDuplicate: array [1..12] of SmallInt;
   Thermal: array [1..12] of SmallInt;
   GoWithMessage: array [1..12] of SmallInt;
   CashDrawerPort: SmallInt;
   CashDrawerSpeed: SmallInt;
   DrawerFlowCtrl: SmallInt;
   CashDrawerMode: SmallInt;
   CheckTillStatus: SmallInt;
   DefaultPrinter: SmallInt;
   PDAPrinterServer: SmallInt;
   DefaultTablePage: SmallInt;
   PoleDisplayPort, PoleDisplaySpeed, PoleFlowCtrl: SmallInt;
   KitchenScreen, SendDescription: SmallInt;
   ScalePort, ScaleSpeed, ScaleFlowCtrl: SmallInt;
   SecondDisplay: SmallInt;
   LinkToEFTPOS: SmallInt;
   ScaleModel: SmallInt;
   SecondCashDrawerPort: SmallInt;
   SecondCashDrawerSpeed: SmallInt;
   SecondDrawerFlowCtrl: SmallInt;
   SecondCashDrawerMode: SmallInt;
   SecondCheckTillStatus: SmallInt;
   PrintLogoOnPOSPrinter: SmallInt;
   Reserve1: SmallInt;
  end;
  OldDevicePortType3 = Record
   POSPrinter: array [1..12] of PrinterNameType;
   PrinterSpeed: array [1..12] of Smallint;
   PrinterFlowCtrl: array [1..12] of SmallInt;
   AutoCutter: array [1..12] of SmallInt;
   JobListDuplicate: array [1..12] of SmallInt;
   Thermal: array [1..12] of SmallInt;
   GoWithMessage: array [1..12] of SmallInt;
   CashDrawerPort: SmallInt;
   CashDrawerSpeed: SmallInt;
   DrawerFlowCtrl: SmallInt;
   CashDrawerMode: SmallInt;
   CheckTillStatus: SmallInt;
   DefaultPrinter: SmallInt;
   PDAPrinterServer: SmallInt;
   DefaultTablePage: SmallInt;
   PoleDisplayPort, PoleDisplaySpeed, PoleFlowCtrl: SmallInt;
   KitchenScreen, SendDescription: SmallInt;
   ScalePort, ScaleSpeed, ScaleFlowCtrl: SmallInt;
   SecondDisplay: SmallInt;
   LinkToEFTPOS: SmallInt;
   ScaleModel: SmallInt;
   SecondCashDrawerPort: SmallInt;
   SecondCashDrawerSpeed: SmallInt;
   SecondDrawerFlowCtrl: SmallInt;
   SecondCashDrawerMode: SmallInt;
   SecondCheckTillStatus: SmallInt;
   PrintLogoOnPOSPrinter: SmallInt;
   DefaultMainMenuGroupCode: SmallInt;
   DefaultPOSMenuGroupCode: SmallInt;
   FeedLines: SmallInt;
   PoleDisplayMode: SmallInt;
   FirstFeedLines: SmallInt;
   CheckListPrinterPort: SmallInt;
   SupportChineseCharacterPrinter: SmallInt;
   DefaultPhoneOrderMenuGroupCode: SmallInt;
  end;
  OldDevicePortType4 = Record
   POSPrinter: array [1..12] of PrinterNameType;
   PrinterSpeed: array [1..12] of Smallint;
   PrinterFlowCtrl: array [1..12] of SmallInt;
   AutoCutter: array [1..12] of SmallInt;
   JobListDuplicate: array [1..12] of SmallInt;
   Thermal: array [1..12] of SmallInt;
   GoWithMessage: array [1..12] of SmallInt;
   CashDrawerPort: SmallInt;
   CashDrawerSpeed: SmallInt;
   DrawerFlowCtrl: SmallInt;
   CashDrawerMode: SmallInt;
   CheckTillStatus: SmallInt;
   DefaultPrinter: SmallInt;
   PDAPrinterServer: SmallInt;
   DefaultTablePage: SmallInt;
   PoleDisplayPort, PoleDisplaySpeed, PoleFlowCtrl: SmallInt;
   KitchenScreen, SendDescription: SmallInt;
   ScalePort, ScaleSpeed, ScaleFlowCtrl: SmallInt;
   SecondDisplay: SmallInt;
   LinkToEFTPOS: SmallInt;
   ScaleModel: SmallInt;
   SecondCashDrawerPort: SmallInt;
   SecondCashDrawerSpeed: SmallInt;
   SecondDrawerFlowCtrl: SmallInt;
   SecondCashDrawerMode: SmallInt;
   SecondCheckTillStatus: SmallInt;
   PrintLogoOnPOSPrinter: SmallInt;
   DefaultMainMenuGroupCode: SmallInt;
   DefaultPOSMenuGroupCode: SmallInt;
   FeedLines: SmallInt;
   PoleDisplayMode: SmallInt;
   FirstFeedLines: SmallInt;
   CheckListPrinterPort: SmallInt;
   SupportChineseCharacterPrinter: SmallInt;
   DefaultPhoneOrderMenuGroupCode: SmallInt;
   SecurityCameraPort: Smallint;
   SecurityCameraPortSpeed: SmallInt;
   SecurityCameraPortControl: SmallInt;
   Reserver1, Reserver2, Reserver3, Reserver4,
   Reserver5, Reserver6, Reserver7, Reserver8: Smallint;
  end;
  DevicePortType = Record
   POSPrinter: array [1..12] of PrinterNameType;
   TableOrderJobListTitle: array [1..12] of JobListTitleType;
   QuickServiceJobListTitle: array [1..12] of JobListTitleType;
   PhoneOrderJobListTitle: array [1..12] of JobListTitleType;
   PrinterSpeed: array [1..12] of Smallint;
   PrinterFlowCtrl: array [1..12] of SmallInt;
   AutoCutter: array [1..12] of SmallInt;
   JobListDuplicate: array [1..12] of SmallInt;
   Thermal: array [1..12] of SmallInt;
   GoWithMessage: array [1..12] of SmallInt;
   CashDrawerPort: SmallInt;
   CashDrawerSpeed: SmallInt;
   DrawerFlowCtrl: SmallInt;
   CashDrawerMode: SmallInt;
   CheckTillStatus: SmallInt;
   DefaultPrinter: SmallInt;
   PDAPrinterServer: SmallInt;
   DefaultTablePage: SmallInt;
   PoleDisplayPort, PoleDisplaySpeed, PoleFlowCtrl: SmallInt;
   KitchenScreen, SendDescription: SmallInt;
   ScalePort, ScaleSpeed, ScaleFlowCtrl: SmallInt;
   SecondDisplay: SmallInt;
   LinkToEFTPOS: SmallInt;
   ScaleModel: SmallInt;
   SecondCashDrawerPort: SmallInt;
   SecondCashDrawerSpeed: SmallInt;
   SecondDrawerFlowCtrl: SmallInt;
   SecondCashDrawerMode: SmallInt;
   SecondCheckTillStatus: SmallInt;
   PrintLogoOnPOSPrinter: SmallInt;
   DefaultMainMenuGroupCode: SmallInt;
   DefaultPOSMenuGroupCode: SmallInt;
   FeedLines: SmallInt;
   PoleDisplayMode: SmallInt;
   FirstFeedLines: SmallInt;
   CheckListPrinterPort: SmallInt;
   SupportChineseCharacterPrinter: SmallInt;
   DefaultPhoneOrderMenuGroupCode: SmallInt;
   SecurityCameraPort: Smallint;
   SecurityCameraPortSpeed: SmallInt;
   SecurityCameraPortControl: SmallInt;
   Reserver1, Reserver2, Reserver3, Reserver4,
   Reserver5, Reserver6, Reserver7, Reserver8: Smallint;
  end;

  ChartType = Record
   AccountNo, Description, OldAccountNo: string;
   LevelFlag: SmallInt;
   Detail: Boolean;
   Amount, GST, PaidAmount: double;
  end;
  PrinterServerBuffType = Record
   OrderNo: string;
   BillKind: integer;
  end;
  TDataForm = class(TDataModule)
    POSPrinterPort: TCommPortDriver;
    PoleDisplayComPort: TCommPortDriver;
    DrawerControlPort: TCommPortDriver;
    ADOConnection: TADOConnection;
    CompanyQuery: TADOQuery;
    LockQuery: TADOQuery;
    CheckQuery: TADOQuery;
    TempQuery: TADOQuery;
    ExecCommand: TADOCommand;
    DrawerStatusPort: TCommPortDriver;
    ScaleCommPort: TCommPortDriver;
    BackupTimer: TTimer;
    PrinterStatusCheckTimer: TTimer;
    SecurityCameraCommPort: TCommPortDriver;
    //ServerSocket: TServerSocket;
    ServerSocket1: TServerSocket;
    function  ConnectToDatabase(ServerName, DatabaseName: string): boolean;
    procedure OpenCompanyQuery;
    function  ExecQueryPro(SQLStr: widestring): boolean;
    function  OpenCheckQuery(SQLStr: string): boolean;
    procedure ReadDatabaseName;
    function  FindDatabaseName(DatabaseComboBox: TComboBox; s: string): Integer;
    procedure AssignAuthorise;
    function  TestDatabaseEdition: boolean;
    function  TestPassword(UserName, Password: string): boolean;
    function  CheckCodePro(SQLStr: string): Integer;
    function  CheckItemCode(StringVar: TStringGrid; ColumnNumber: integer): boolean;
    function  CheckInstructionLink(ItemCode: string): boolean;
    function  CheckSubMenuLink(ItemCode: string; var MainItemDescription1, MainItemDescription2: string;
                               var ChoiceOfNumber: Integer; var AutoShowSubMenu: boolean): boolean;
    function  GetDefaultMenuGroup(var Code, Description: string): boolean;
    function  VerifyPassword(var StaffName: string): boolean;
    function  CheckCodeSQLPro(SQLStr: string): integer;
    procedure GenerateOrderNo(var OrderNo: string);
    procedure GenerateInvoiceNo(OrderNo: string; var InvoiceNo: string);
    function  SaveInvoiceNo(OrderNo, InvoiceNo: string): boolean;
    function  SetInvoiceNo(OrderNo: string): boolean;
    function  BeginTransaction: boolean;
    procedure CommitTransaction;
    procedure RollBack;
    function  LockDatabasePro: boolean;
    function  CheckVIPCreditStatus(VIPNo: integer; CurrentSales: double; OrderNo: string): boolean;
    function  GetAvailableCredit(VIPNo: integer): double;
    function  GetVIPAwardPoints(VIPNo: integer; OrderNo: string): double;
    function  ReadVIPInformation(VIPNo: integer; var VIPName: string; var VIPDiscountRate: double): boolean;
    function  SaveAccountRecord(OrderNo: string; Amount: double; PayBy: string; IDNo, DepositID: integer): boolean;
    function  SaveAwardPoints(OrderNo: string; VIPNo, AwardPoints: integer): boolean;
    function  SavePointsPayment(OrderNo: string; VIPNo, PointsPayment: integer): boolean;
    function  UpdateOrderPayment(OrderNo: string; SplitBillStatus: boolean): boolean;
    function  UpdateExpensesPayment(SerialNo: integer): boolean;
    function  UpdatePurchasePayment(ReceiveNo: string): boolean;
    function  OpenTempQuery(SQLStr: string): boolean;
    procedure ConnectDrawerPort(PortNumber: integer);
    procedure OpenLPTPort;
    function  WriteDataToLPTPort(DataPtr: pointer; DataSize: DWORD ): boolean;
    function  WriteStringToLPTPort( s: string ): boolean;
    procedure OpenDrawer(SalesFlag: boolean; PortNumber: integer);
    procedure ConnectDrawerStatusPort(PortNumber: integer);
    procedure TestDrawerStatus(PortNumber: integer);
    procedure CountDrawerOpenTimes(SalesFlag: boolean);
    function  IsGenericDriver(PrinterName: string): boolean;
    procedure SetGenericePrinter;
    procedure SetBlackFontA;
    procedure SetBlackFontB;
    procedure SetBlackFontC;
    procedure SetBlackFontD;
    procedure SetRedFontA;
    procedure SetRedFontB;
    procedure SetRedFontC;
    procedure SetRedFontD;
    Procedure PrintLOgoToPOSPrinter;
    procedure TestPrinterStatus(PrinterName: string);
    procedure OpenPrinterPort(PrinterPort: integer);
    procedure OutPutToPrinter(TextStr: string);
    procedure CutPaper;
    procedure ClosePrinterPort;
    procedure OpenSecurityCameraPort;
    procedure CloseSecurityCameraPort;
    procedure SendMsgToSecurityCameraPort(Msg: string);
    procedure FeedsPaperLines;
    procedure PrintBillHead;
    procedure OpenPoleDisplayPort;
    procedure ClosePoleDisplayPort;
    procedure SendToPoleDisp(S1, S2: string);
    procedure InitToLinkEFTPOS;
    procedure ConnectToScale;
    function  ReadCASAP1WScaleData(var Weight: double): boolean;   // For CAS AP-1W
    function  ReadCASPDIIScaleData(var Weight: double): boolean;   // For CAS PD-II
    function  ReadDataFromScaleCASAP1W(var Weight: double): boolean;   // For CAS AP-1W
    function  ReadDataFromScaleCASPDII(var Weight: double): boolean;   // For CAS PD_II
    function  ReadDataFromScalePSC(var Weight: double): boolean;        // For PSC , Mettler
    function  ReadDataFromScaleWedderburn(var Weight: double): boolean; // For Wedderburn
    procedure SetDefaultPrinter(PrinterName: String);
    procedure SetSystemDateTime;
    function  RecalculateOrderAmount(OrderNo: string): boolean;
    procedure BackupDatabasePro(BackupFileName: string);
    procedure BackupTimerTimer(Sender: TObject);
    function  CheckMinimumChargeBalance(OrderNo: string; var MinimumCharge: double): boolean;
    function  GetMinimumChargeForPerTable(TableNo: string): double;
    procedure PrinterStatusCheckTimerTimer(Sender: TObject);
    procedure ActiveSocket;
    procedure ServerSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
              ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ServerSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
    function  LockTable(TableNo: string): boolean;
    function  ReleaseTable(TableNo: string): boolean;
    function  TestVIPAddress(VIPNo: integer): boolean;
    procedure RecordDrawerOpenMSG;
  private { Private declarations }
  public
    { Public declarations }
   EFTPOS: TCsdEft;
   
  end;

var
  FVar: DevicePortType;
  Supervisor, UserManager, Password, PrintInvoiceAuthority, PaymentAuthority,
  PrintJobListAuthority, VoidItemAuthority, TableTracking, CheckTableStatus,
  PersonCount, DiscountEnable, NotAllowModify,
  PrintBillNo, PrintInvoiceNo, NotAllowChangeQty,
  AuthoriseCloseMainWindow, ForceVIPDiscount, AutoOpenTill,
  AutoPrintJobList, ManuallyPrintJobList, PrintServiceOnJobList, PrintPersonsOnJobList,
  DrawerIsOpen, PrintPriceOnJobList, PrintTimeOnInvoice, HappyHourAvailable, PrintTableNo,
  ShowTaxOnSalesSection, CheckDailyReport, AutoPrintPOSJobList, PriceIncludesGST,
  AutoPrintPOSOrderList, AutoPrintPOSInvoice, AutoPrintPickupSlip,
  AuthoriseRefund, VIPManagerAuthorise, AutoPrintPhoneOrderJobList,
  AutoInstructionSelection, AllowEditOrder, PrintDateOnDailyReport,
  AutoPrintBill, AutoPrintInvoice, AutoPriceWindow, PrintZeroPriceItemOnInvoice,
  EFTPOSStatus, AutoPopVoidReason, AutoSaveOrder, PrintDailyReport, AutoPrintMergedOrder,
  ManuallyEnterTableNumber, PrintGoWithInstruction, PrintOpNameOnJobList,
  AutoPrintJobListForHoldOrder, AutoSurcharge, OtherChargeEnable, EditAttendanceRecord,
  PrintIngredientsOnJobList, CurrentPrinterIsGeneric, LoyaltyAwardAvailible,
  ShowPrintInvoiceWindow, AssignDriverAuthorised, ChangeQtyWithCondiment,
  CompulsoryEnterCustomerName, AutoPrintCheckList, PrintOrderNoOnJobList,
  AuthrisedCancelHoldOrder, ShowNegativeQty, PrintOrderNoOnTaxInvoice,
  AutoLogOut, PrintRedColorQtyOnJobList,
  OnlyOpenDrawerForCashPayment, PrintDiscountRateOnBill, ManuallyEnterDiscountRate,
  OnlyPrintSimpleFormatDailyReport, OnlyPrintLastTwoDigitalOrderNo,
  CheckPrinterStatus, EditOrderPayment, AutoPrintBillWhenPhoneOrderSaved,
  AutoAddDeliveryChargeForPhoneOrder, TableLockFunctionEnabled, PrintZeroQtyItemsOnJobList: boolean;
  sDatabaseName, sServerName, sUserName, StartDir, sAliasName, MachineID,
  CompanyTitle, DistributorMsg, ScaleDataBuff, SurchargeName, OtherChargeName,
  DefaultVIPState, DefaultBackupPath, MinimumChargeItemCode, DeliveryChargeItemCode: string;
  HMar, VMar, CharHeight, CurrentPrinterIndex, CurrentPrinterPort,
  ButtonLayOut, RoundingFlag, MainMenuLine, VIPDefaultSearch, AuthoriseDrawerPortNumber,
  DefaultDrawerPortNumber, CurrentDrawerNumber, MainCategoryLine, POSMenuLine,
  POSCategoryLine, PhoneOrderMenuLine, PhoneOrderCategoryLine, PrintCategoryColor,
  PrintJobListDescription, PrintOrderListDescription, PrintInvoiceDescription,
  PrintBillMode, PrintInvoiceMode, ScaleBarcode, SalesPoints, PaymentPoints, ReachPoints,
  JobListFontSize, PhoneOrderMenu, BackupFrequency, DiscountRateEnterMode, AutoLogoutTimeOut,
  MinimumChargeKind, CheckListFormat,InquirySalesRelatedReportDays,
  SecondDisplayDescription: integer;
  BeginTime, EndTime, SurchargeStartTime, SurchargeEndTime,
  HappyHourStartTime, HappyHourEndTime, HappyHourStartTime1, HappyHourEndTime1,
  HappyHourStartTime2, HappyHourEndTime2, HappyHourStartTime3, HappyHourEndTime3,
  HappyHourStartTime4, HappyHourEndTime4, HappyHourStartTime5, HappyHourEndTime5,
  HappyHourStartTime6, HappyHourEndTime6, BackupOnceTime: TDateTime;
  ServiceChargeRate, OtherChargeRate, DefaultGSTRate, MaxDiscountPercentage,
  MaxDollarDiscount, MinimumChargePerPerson: double;
  JobListFormatForPrinter: array [1..12] of integer;
  LPTPortHandle: THANDLE;
  DVRNo,DVRIP,DVRUser,DVRPWD : string;
  {$A-}
   sAlias: array [1..100, 1..3] of string;
  {$A+}
  DataForm: TDataForm;

implementation

uses UtilUnit, NumPad, MainMenu, ControlPanel, MessageBox, PrintJobCard,
     PrintJobCard1, PrintJobCard2, PrintJobCard3, PrintJobCard4, PrintOrder,
     PrintOrder1, PrintCheckList, DisplayMessage, Regist, PrintOrder2,
     PrintJobCard5, SendToScreen, PrintJobListControl, PrintOrder3;

{$R *.DFM}



procedure TDataForm.OpenCompanyQuery;
begin
 with CompanyQuery do
  begin
   Active := False;
   Connection := ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From Profile');
   Active := True;
  end;
end;

function TDataForm.ExecQueryPro(SQLStr: widestring): boolean;
begin
 Result := True;
 with ExecCommand do
  begin
   Connection := ADOConnection;
   CommandText := SQLStr;
   try
    Execute;
   except
    Result := False;
   end;
  end;
end;

function TDataForm.OpenCheckQuery(SQLStr: string): boolean;
begin
 Result := True;
 Screen.Cursor := crHourGlass;
 with CheckQuery do
  begin
   Active := False;
   Connection := ADOConnection;
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

function TDataForm.OpenTempQuery(SQLStr: string): boolean;
begin
 Result := True;
 Screen.Cursor := crHourGlass;
 with TempQuery do
  begin
   Active := False;
   Connection := ADOConnection;
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

function TDataForm.ConnectToDatabase(ServerName, DatabaseName: string): boolean;
var
 LocalMachineName: string;
begin
 GetLocalMachineName(LocalMachineName);
 if (Uppercase(LocalMachineName) = UpperCase(ServerName)) and Not IsMasterKey then
    begin
     Result := False;
     MessageBoxForm.MessagePro('You must use master key to logon this machine.', sErrorMsg);
     Exit;
    end;
 Result := True;
 with ADOConnection do
  begin
   Connected := False;
   ConnectionString := 'Provider=SQLOLEDB;' +
                       //'Integrated Security=SSPI; ' +
                       'User Id=Eric;Password=0875;' +
                       'Persist Security Info=False; ' +
                       'Initial Catalog=' + DatabaseName +
                       ';Data Source=' + ServerName +
                       ';Use Procedure for Prepare=1; ' +
                       'Auto Translate=False; ' +
                       'Packet Size=32767; ' +
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

function TDataForm.LockDatabasePro: boolean;
begin
 Result := True;
 with LockQuery do
  begin
   Active := False;
   Connection := ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From Version (TabLockX)');
   try
    Active := True;
   except
    Result := False;
   end;
  end;
end;

function TDataForm.BeginTransaction: boolean;
begin
 ExecQueryPro('SET TRANSACTION ISOLATION LEVEL SERIALIZABLE');
 ExecQueryPro('Begin Transaction');
 repeat
  Result := LockDatabasePro;
 until Result or (MessageBoxForm.MessagePro('Database has been used by another user, ' +
                 Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                  'Do you want to try again? ', sConfirmMsg) = mrNo);
 if Not Result then RollBack;
end;

procedure TDataForm.CommitTransaction;
begin
 LockQuery.Close;
 ExecQueryPro('Commit Transaction');
 ExecQueryPro('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
end;

procedure TDataForm.RollBack;
begin
 LockQuery.Close;
 ExecQueryPro('RollBack Transaction');
 ExecQueryPro('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
end;

procedure TDataForm.ReadDatabaseName;
var
 {$A-}
 TxtFile: TextFile;
 I, J: integer;
 TextStr, FileName: string;
 TempStr: string;
 {$A+}
begin
 for I := 1 to 100 do
  begin
   sAlias[I, 1] := '';
   sAlias[I, 2] := '';
   sAlias[I, 3] := '';
  end;
 FileName := StartDir + 'Database.CFG';
 if Not FileExists(FileName) then Exit;
 AssignFile(TxtFile, FileName);
 Reset(TxtFile); I := 1;
 While Not EOF(TxtFile) and (I <= 100) do
  begin
   Readln(TxtFile, TextStr);
   J := 1; TempStr := '';
   while (J <= Length(TextStr)) and Not (TextStr[J] in [Chr(9), Chr(20), ',']) do
    begin TempStr := TempStr + TextStr[J]; J := J + 1 end;
   sAlias[I, 1] := TempStr;
   while (J <= Length(TextStr)) and (TextStr[J] in [Chr(9), Chr(20), ',']) do
     J := J + 1;
   TempStr := '';
   while (J <= Length(TextStr)) and Not (TextStr[J] in [Chr(9), Chr(20), ',']) do
    begin TempStr := TempStr + TextStr[J]; J := J + 1 end;
   sAlias[I, 2] := TempStr;
   while (J <= Length(TextStr)) and (TextStr[J] in [Chr(9), Chr(20), ',']) do
    J := J + 1;
   TempStr := '';
   while (J <= Length(TextStr)) and Not (TextStr[J] in [Chr(9), Chr(20), ',']) do
    begin TempStr := TempStr + TextStr[J]; J := J + 1 end;
   sAlias[I, 3] := TempStr;
   I := I + 1;
  end;
 CloseFile(TxtFile);
end;

function TdataForm.FindDatabaseName(DatabaseComboBox: TComboBox; s: string): Integer;
var
  i: Integer;
begin
  i := 0;
  while (i < DatabaseComboBox.Items.Count) and (DatabaseComboBox.Items[i] <> s) do
    inc(i);
  if (DatabaseComboBox.Items[i] <> s) then
     Result := -1
    else
     Result := i;
end;

procedure TDataForm.AssignAuthorise;
begin
 with MainForm do
  begin
   Supervisor := CheckQuery.FieldByName('Supervisor').AsBoolean;
   //ControlPanelForm.Supervisor := Supervisor;
   //ControlPanelForm.BookButton.Enabled := CheckQuery.FieldByName('BookingListMenu').AsBoolean or Supervisor;
   ControlPanelForm.TableServiceButton.Enabled := CheckQuery.FieldByName('TableOrderMenu').AsBoolean Or Supervisor;
   SalesCancelReport1.Enabled := supervisor;
   DrawerOpenDateTimeListMenu.Enabled := supervisor;
   ControlPanelForm.QuickServiceButton.Enabled := CheckQuery.FieldByName('PointOfSalesMenu').AsBoolean Or Supervisor;
   VIPManagerAuthorise := CheckQuery.FieldByName('VIPInformationMenu').AsBoolean or Supervisor;
   VIPInformationMenu.Enabled := VIPManagerAuthorise;
   DeliveryAddressSetupMenu.Enabled := VIPManagerAuthorise;
   //PhoneOrderMenu.Enabled := CheckQuery.FieldByName('PhoneOrderMenu').AsBoolean or Supervisor;
   //ControlPanelForm.PhoneOrderButton.Enabled := CheckQuery.FieldByName('PhoneOrderMenu').AsBoolean or Supervisor;
   ControlPanelForm.MenuSetupButton.Enabled := CheckQuery.FieldByName('MenuSetupMenu').AsBoolean or Supervisor;
   //ControlPanelForm.SpeedButton3.Enabled :=  ControlPanelForm.MenuSetupButton.Enabled ;
   CashPayOutMenu.Enabled := CheckQuery.FieldByName('CashPayOutMenu').AsBoolean or Supervisor;
   //DepositMenu.Enabled := CheckQuery.FieldByName('DepositMenu').AsBoolean or Supervisor;
   //WastageMenu.Enabled := CheckQuery.FieldByName('WastageMenu').AsBoolean or Supervisor;

   CashFloatMenu.Enabled := CheckQuery.FieldByName('CashFloatMenu').AsBoolean or Supervisor;
   ControlPanelForm.DailyReportButton.Enabled := CheckQuery.FieldByName('DailyReportMenu').AsBoolean or
                                                 CheckQuery.FieldByName('CheckDailyReport').AsBoolean or Supervisor;
   DailyReportMenu.Enabled := CheckQuery.FieldByName('DailyReportMenu').AsBoolean or
                              CheckQuery.FieldByName('CheckDailyReport').AsBoolean or Supervisor;
   CheckDailyReport := CheckQuery.FieldByName('CheckDailyReport').AsBoolean;
   //ControlPanelForm.SpeedButton4.Visible := CheckQuery.FieldByName('DailyReportMenu').AsBoolean or
                              //CheckQuery.FieldByName('CheckDailyReport').AsBoolean or Supervisor;
   CashPayOutReportMenu.Enabled := DailyReportMenu.Enabled;
   CashFloatListMenu.Enabled := DailyReportMenu.Enabled;
   //DepositListMenu.Enabled := DailyReportMenu.Enabled;
   //BookingListMenu.Enabled := CheckQuery.FieldByName('BookingListMenu').AsBoolean or Supervisor;
   TableServiceMenu.Enabled := CheckQuery.FieldByName('TableOrderMenu').AsBoolean Or Supervisor;
   QuickServiceMenu.Enabled := CheckQuery.FieldByName('PointOfSalesMenu').AsBoolean Or Supervisor;
   //ExpensesDataEntryMenu.Enabled := CheckQuery.FieldByName('ExpensesDataEntryMenu').AsBoolean or Supervisor;
   //ExpensesReportMenu.Enabled := CheckQuery.FieldByName('ExpensesReportMenu').AsBoolean or Supervisor;
   PaymentsReportMenu.Enabled := CheckQuery.FieldByName('PaymentsReportMenu').AsBoolean or Supervisor;
   //ReceiptsReportMenu.Enabled := CheckQuery.FieldByName('ReceiptsReportMenu').AsBoolean or Supervisor;
   //DepositReportMenu.Enabled := ReceiptsReportMenu.Enabled;
   //ReceivableReportMenu.Enabled := ReceiptsReportMenu.Enabled;

   SalesSummaryReportMenu.Enabled := CheckQuery.FieldByName('SalesReportMenu').AsBoolean or Supervisor;
   DiscountReportMenu.Enabled := SalesSummaryReportMenu.Enabled;
   SalesPriceBelowFixPriceReportMenu.Enabled := SalesSummaryReportMenu.Enabled;
   ZeroQuantitySalesReportMenu.Enabled := SalesSummaryReportMenu.Enabled;
   SalesVoidReportMenu.Enabled := SalesSummaryReportMenu.Enabled;

   SalesStatisticsChartMenu.Enabled := CheckQuery.FieldByName('StatisticsChartMenu').AsBoolean or Supervisor;
   //StockReportMenu.Enabled := CheckQuery.FieldByName('StockReportMenu').AsBoolean or Supervisor;
   //CurrentStockSalesMarginReportMenu.Enabled := StockReportMenu.Enabled;
   //WastageReportMenu.Enabled := CheckQuery.FieldByName('WastageReportMenu').AsBoolean or Supervisor;
  // WastageSummaryReportMenu.Enabled := CheckQuery.FieldByName('WastageReportMenu').AsBoolean or Supervisor;
   //GSTPayableReportMenu.Enabled := CheckQuery.FieldByName('GSTPayableReportMenu').AsBoolean or Supervisor;
   ProfileSetupMenu.Enabled := CheckQuery.FieldByName('ProfileSetupMenu').AsBoolean or Supervisor;
   CategorySetupMenu.Enabled := CheckQuery.FieldByName('CategorySetupMenu').AsBoolean or Supervisor;
   MenuGroupSetupMenu.Enabled := CategorySetupMenu.Enabled;
   MenuSetupMenu.Enabled := CheckQuery.FieldByName('MenuSetupMenu').AsBoolean or Supervisor;
   //StockItemsSetupMenu.Enabled := MenuSetupMenu.Enabled;
   MealsPackageSetupMenu.Enabled := MenuSetupMenu.Enabled;
   PaymentsMethodSetupMenu.Enabled := CheckQuery.FieldByName('PaymentsMethodSetupMenu').AsBoolean or Supervisor;
   InvoiceConditionSetupMenu.Enabled := CheckQuery.FieldByName('InvoiceConditionSetupMenu').AsBoolean or Supervisor;
   BillConditionSetupMenu.Enabled := InvoiceConditionSetupMenu.Enabled;
   PrinterSetMenu.Enabled := CheckQuery.FieldByName('PrinterSetupMenu').AsBoolean or Supervisor;
   UserManager := CheckQuery.FieldByName('UserManager').AsBoolean;
   UserManagerMenu.Visible := UserManager or Supervisor;
   DiscountRateSetupMenu.Enabled := Supervisor;
   MachineIDSetupMenu.Enabled := PrinterSetMenu.Enabled;
   EFTPosUtilityMenu.Enabled := Supervisor;
   ItemVoidReasonDescriptionSetupMenu.Enabled := Supervisor;
   //StockReceiveReportMenu.Enabled := CheckQuery.FieldByName('StockReceiveReportMenu').AsBoolean or Supervisor;
   InquirySalesHistoryMenu.Enabled := CheckQuery.FieldByName('InquirySalesHistoryMenu').AsBoolean or Supervisor;
   //ExpensesDescriptionSetupMenu.Enabled := CheckQuery.FieldByName('ExpensesDescriptionSetupMenu').AsBoolean or Supervisor;
   //BookingFormConditionSetupMenu.Enabled := CheckQuery.FieldByName('BookingFormConditionSetupMenu').AsBoolean or Supervisor;
   SalesStatisticsReportMenu.Enabled := CheckQuery.FieldByName('SalesStatisticsReportMenu').AsBoolean or Supervisor;
   //SupplierInformationSetupMenu.Enabled := CheckQuery.FieldByName('SupplierInformationSetupMenu').AsBoolean or Supervisor;
   //SupplierInformationListMenu.Enabled := CheckQuery.FieldByName('SupplierInformationListMenu').AsBoolean or Supervisor;
   //StockReceiveMenu.Enabled := CheckQuery.FieldByName('StockReceiveMenu').AsBoolean or Supervisor;
   //StockAdjustmentMenu.Enabled := CheckQuery.FieldByName('StockAdjustmentMenu').AsBoolean or Supervisor;
   //StockAdjustmentReportMenu.Enabled := CheckQuery.FieldByName('StockAdjustmentReportMenu').AsBoolean or Supervisor;
   DatabaseMaintananceMenu.Visible := Supervisor;
   DatabaseBackupMenu.Enabled := CheckQuery.FieldByName('DatabaseBackupMenu').AsBoolean or Supervisor;
   DatabaseRestoreMenu.Enabled := CheckQuery.FieldByName('DatabaseRestoreMenu').AsBoolean or Supervisor;
   TransferDatabaseMenu.Enabled := CheckQuery.FieldByName('DatabaseBackupMenu').AsBoolean or Supervisor;
   OpenCashDrawerMenu.Enabled := CheckQuery.FieldByName('OpenCashDrawerMenu').AsBoolean or Supervisor;
   //BankAccountSetupMenu.Enabled := CheckQuery.FieldByName('BankAccountSetupMenu').AsBoolean or Supervisor;
   //BankReconciliationMenu.Enabled := CheckQuery.FieldByName('BankReconciliationMenu').AsBoolean or Supervisor;
   TableInformationSetupMenu.Enabled := CheckQuery.FieldByName('TableInformationSetupMenu').AsBoolean or Supervisor;
   AttendanceReportMenu.Enabled := CheckQuery.FieldByName('AttendanceReportMenu').AsBoolean or Supervisor;
   EditAttendanceRecord := CheckQuery.FieldByName('EditAttendanceRecord').AsBoolean or Supervisor;
   //PurchaseOrderMenu.Enabled := CheckQuery.FieldByName('PurchaseOrderMenu').AsBoolean or Supervisor;
  // PurchasePayableMenu.Enabled := CheckQuery.FieldByName('PurchasePayableMenu').AsBoolean or Supervisor;
   //PurchasePaymentReportMenu.Enabled := PurchasePayableMenu.Enabled;
   PaymentAuthority := CheckQuery.FieldByName('PaymentAuthority').AsBoolean or Supervisor;
   PrintInvoiceAuthority := CheckQuery.FieldByName('PrintInvoiceAuthority').AsBoolean or Supervisor;
   PrintJobListAuthority := CheckQuery.FieldByName('PrintJobListAuthority').AsBoolean or Supervisor;
   VoidItemAuthority := CheckQuery.FieldByName('VoidItemAuthority').AsBoolean or Supervisor;
   DiscountEnable := CheckQuery.FieldByName('AuthoriseDiscount').AsBoolean or Supervisor;
   AuthoriseCloseMainWindow := CheckQuery.FieldByName('AuthoriseCloseWindow').AsBoolean or Supervisor;
   AuthoriseRefund := CheckQuery.FieldByName('AuthoriseRefund').AsBoolean or Supervisor;
   AllowEditOrder := CheckQuery.FieldByName('AllowEditOrder').AsBoolean or Supervisor;
   PrintDailyReport := CheckQuery.FieldByName('PrintDailyReport').AsBoolean or Supervisor;
   AuthoriseDrawerPortNumber := CheckQuery.FieldByName('DrawerPortNumber').AsInteger;
   AssignDriverAuthorised := CheckQuery.FieldByName('AssignDriverAuthorised').AsBoolean;
   AuthrisedCancelHoldOrder := CheckQuery.FieldByName('AuthrisedCancelHoldOrder').AsBoolean or Supervisor;
   ManuallyEnterDiscountRate := CheckQuery.FieldByName('ManuallyEnterDiscountRate').AsBoolean or Supervisor;
   ManuallyEnterDiscountRate := True;
   EditOrderPayment := CheckQuery.FieldByName('EditOrderPayment').AsBoolean or Supervisor;
   ControlButtonsSetupMenu.Enabled := Supervisor;
   InquirySalesRelatedReportDays := CheckQuery.FieldByName('InquirySalesRelatedReportDays').AsInteger;
   if AuthoriseDrawerPortNumber <= 1 then
      DefaultDrawerPortNumber := AuthoriseDrawerPortNumber
     else
      DefaultDrawerPortNumber := CheckQuery.FieldByName('DefaultDrawerPortNumber').AsInteger;
  end;
end;

function TDataForm.TestDatabaseEdition: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From SysObjects Where Name=' + Chr(39) + 'VIPTable' + Chr(39);
 OpenCheckQuery(SQLStr);
 Result := CheckQuery.RecordCount >= 1;
 CheckQuery.Close;
 if Not Result then
    MessageBoxForm.MessagePro('The edition of the database is different from this program.', sErrorMsg);
end;

function TDataForm.TestPassword(UserName, Password: string): boolean;
var
 SQLStr,SQLName: string;
begin
 SQLStr := 'Select * From AccessMenu where StaffName=' +
           Chr(39) + CheckQuotes(UserName) + Chr(39) + ' and SecureCode=' +
           Chr(39) + CheckQuotes(Password) + Chr(39);
 {SQLStr := 'Select * From AccessMenu where SecureCode='+
           Chr(39) + CheckQuotes(Password) + Chr(39);}

 //SQLName := 'Select * From AccessMenu Where SecureCode=' +
            //Chr(39) + CheckQuotes(Password) + Chr(39);
 //Result := OpenCheckQuery(SQLStr);
 Result := OpenCheckQuery(SQLStr);
 if Not Result then
    begin
     MessageBoxForm.MessagePro('Not set password, please setup password first!', sErrorMsg);
     Exit;
    end;
 if CheckQuery.RecordCount > 0 then
    begin
     sUserName := UserName;
     //sUserName :=  CheckQuery.FieldByName('StaffName').AsString;
     AssignAuthorise;
     Result := True;
    end
   else
    begin
     MessageBoxForm.MessagePro('User name or password invalid, please try again.', sErrorMsg);
     Result := False;
    end;
 CheckQuery.Close;
end;



function TDataForm.GetDefaultMenuGroup(var Code, Description: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From MenuGroupTable Order By Code';
 if Not OpenCheckQuery(SQLStr) or (CheckQuery.RecordCount = 0) then
    Result := False
   else
    begin
     Code := CheckQuery.FieldByName('Code').AsString;
     Description := CheckQuery.FieldByName('Description').AsString;
     Result := True;
    end;
 CheckQuery.Close;
end;

function TDataForm.CheckInstructionLink(ItemCode: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select Count(*) From InstructionLink ' +
           'Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
 if Not OpenCheckQuery(SQLStr) or (CheckQuery.Fields[0].AsInteger = 0) then
    Result := False
   else
    Result := True;
 CheckQuery.Close;
end;

function TDataForm.CheckCodePro(SQLStr: string): Integer;
begin
 if OpenCheckQuery(SQLStr) then
    Result := CheckQuery.Fields[0].AsInteger
   else
    Result := 0;
  CheckQuery.Close;
end;

function TDataForm.CheckItemCode(StringVar: TStringGrid; ColumnNumber: integer): boolean;
var
 SQLStr: string;
 I: integer;
begin
 I := 1;
 Result := True;
 while Result and (I <= 300) do
  begin
   if (StringVar.Cells[ColumnNumber, I] <> '') and (StringVar.Cells[ColumnNumber, I] <> '----') then
      begin
       SQLStr := 'Select Count(*) From MenuItem Where ItemCode=' +
                 Chr(39) + CheckQuotes(StringVar.Cells[ColumnNumber, I]) + Chr(39);
       Result := DataForm.CheckCodePro(SQLStr) >= 1;
      end;
   if Not Result then
      MessageBoxForm.MessagePro('Can not find item code: ' + StringVar.Cells[ColumnNumber, I], sErrorMsg)
     else
      I := I + 1;
  end;
end;

function TDataForm.CheckSubMenuLink(ItemCode: string; var MainItemDescription1, MainItemDescription2: string;
          var ChoiceOfNumber: integer; var AutoShowSubMenu: boolean): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select SubMenuLinkHead.ItemCode, Description1, Description2, NumberOfChoice, AutoShowSubMenu ' +
           'From MenuItem, SubMenuLinkHead ' +
           'Where MenuItem.ItemCode=SubMenuLinkHead.ItemCode and ' +
           'SubMenuLinkHead.ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
 if Not OpenCheckQuery(SQLStr) or (CheckQuery.RecordCount = 0) then
    Result := False
   else
    begin
     MainItemDescription1 := CheckQuery.FieldByName('Description1').AsString;
     MainItemDescription2 := CheckQuery.FieldByName('Description2').AsString;
     ChoiceOfNumber := CheckQuery.FieldByName('NumberOfChoice').AsInteger;
     AutoShowSubMenu := CheckQuery.FieldByName('AutoShowSubMenu').AsBoolean;
     Result := True;
    end;
 CheckQuery.Close;
end;

function TDataForm.VerifyPassword(var StaffName: string): boolean;
var
 SQLStr, PasswordStr: string;
begin
 Result := False;
 if Not NumberPadForm.ReadNumberPro(PasswordStr, True, False, 'Password', 0) then Exit;
 SQLStr := 'Select * From AccessMenu Where SecureCode=' +
           Chr(39) + CheckQuotes(PasswordStr) + Chr(39);
 if OpenCheckQuery(SQLStr) and (CheckQuery.RecordCount > 0) then
    begin
     StaffName := CheckQuery.FieldByName('StaffName').AsString;
     sUserName := StaffName;
     AssignAuthorise;
     Result := True;
    end;
 CheckQuery.Close;
 if Not Result then MessageBoxForm.MessagePro('Password error or not be authorized!', sErrorMsg);
end;

function TDataForm.CheckCodeSQLPro(SQLStr: string): Integer;
begin
 if OpenCheckQuery(SQLStr) then
    Result := CheckQuery.Fields[0].AsInteger
   else
    Result := 0;
  CheckQuery.Close;
end;

procedure TDataForm.GenerateOrderNo(var OrderNo: string);
var
 SQLStr, sYear, sMonth, sDay, Temp: string;
 NewOrderNo: Integer;
 Year, Month, Day: word;
begin
 DecodeDate(Date, Year, Month, Day);
 sYear := Copy(Format('%4.4d', [Year]), 3, 2);
 sMonth := Format('%2.2d', [Month]);
 sDay := Format('%2.2d', [Day]);
 SQLStr := 'Select Max(OrderNo) From OrderH Where OrderNo Like ' +
           Chr(39) + sYear + sMonth + sDay + SearchMark + Chr(39);
 if OpenCheckQuery(SQLStr) and (CheckQuery.Fields[0].AsString <> '') then
    begin
     Temp := Copy(CheckQuery.Fields[0].AsString, 7, 4);
     NewOrderNo := StrToInt(Temp) + 1;
    end
   else
    NewOrderNo := 1;
 CheckQuery.Close;
 OrderNo := sYear + sMonth + sDay + Format('%4.4d', [NewOrderNo]);
end;

procedure TDataForm.GenerateInvoiceNo(OrderNo: string; var InvoiceNo: string);
var
 SQLStr, DateStr, InvoiceNoInitial, Temp, Ch: string;
 NewInvoiceNo: Integer;
begin
 OpenCompanyQuery;
 InvoiceNoInitial := CompanyQuery.FieldByName('Initial').AsString;
 CompanyQuery.Close;
 DateStr := Copy(OrderNo, 1, 6);
 SQLStr := 'Select Max(InvoiceNo) From OrderH Where InvoiceNo Like ' +
           Chr(39) + InvoiceNoInitial + DateStr + SearchMark + Chr(39);
 if OpenCheckQuery(SQLStr) and (CheckQuery.Fields[0].AsString <> '') and
    (Not VarIsNull(CheckQuery.Fields[0].AsString)) then
    begin
     Temp := CheckQuery.Fields[0].AsString;
     if InvoiceNoInitial = '' then
        Temp := Copy(Temp, 7, 4)
       else
        Temp := Copy(Temp, 8, 4);
     if Length(Temp) = 3 then
        begin
         Ch := Copy(Temp, 1, 1);
         Temp := IntToStr(StrToInt(Ch) + 1) + Temp;
        end;
     NewInvoiceNo := StrToInt(Temp) + 1;
    end
   else
    NewInvoiceNo := 1;
 CheckQuery.Close;
 InvoiceNo := InvoiceNoInitial + DateStr + Format('%4.4d', [NewInvoiceNo]);
end;

function TDataForm.SaveInvoiceNo(OrderNo, InvoiceNo: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Update OrderH Set InvoiceNo=' + Chr(39) + CheckQuotes(InvoiceNo) + Chr(39) +
           ' Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TDataForm.SetInvoiceNo(OrderNo: string): boolean;
var
 SQLStr, InvoiceNo: string;
begin
 SQLStr := 'Select InvoiceNo From OrderH Where Orderno=' +
           Chr(39) + CheckQuotes(Orderno) + Chr(39);
 Result := OpenCheckQuery(SQLStr);
 if Result and ((CheckQuery.Fields[0].AsString = '') or VarIsNull(CheckQuery.Fields[0].AsString)) then
    begin
     GenerateInvoiceNo(OrderNo, InvoiceNo);
     Result := SaveInvoiceNo(OrderNo, InvoiceNo);
    end;
 CheckQuery.Close;
end;

function TDataForm.CheckVIPCreditStatus(VIPNo: integer; CurrentSales: double; OrderNo: string): boolean;
var
 SQLStr: string;
 TotalCredit, CreditLimit, TotalDeposit: double;
begin
 SQLStr := 'Select Sum(TempTable.Credit) As TotalCredit From ' +
           '(Select (Amount + Tips + ServiceCharge + OtherCharge) As Credit ' +
           'From OrderH ' +
           'Where (PriceIncludesGST <> 0) and (VIPNo=' + IntToStr(VIPNo) + ')' +
           ' and OrderNo <> ' + Chr(39) + OrderNo + Chr(39) +
           ' Union All ' +
           'Select (Amount + Tips + ServiceCharge + OtherCharge + GST) As Credit ' +
           'From OrderH ' +
           'Where (PriceIncludesGST = 0) and (VIPNo=' + IntToStr(VIPNo) + ')' +
           ' and OrderNo <> ' + Chr(39) + OrderNo + Chr(39) + ') As TempTable';
 Result := OpenCheckQuery(SQLStr);
 if Result then
    begin
     TotalCredit := CheckQuery.FieldByName('TotalCredit').AsFloat;
     SQLStr := 'Select Sum(Amount) As TotalDebit ' +
               'From OrderH, RecvAcct ' +
               'Where OrderH.OrderNo=RecvAcct.OrderNo and DepositID = 0 and ' +
               'VIPNo=' + IntToStr(VIPNo);
     Result := OpenCheckQuery(SQLStr);
     if Result then
        TotalCredit := TotalCredit - CheckQuery.FieldByName('TotalDebit').AsFloat;
        SQLStr := 'Select Sum(Amount) As TotalDeposit From DepositTable Where VIPNo=' + IntToStr(VIPNo);
        Result := OpenCheckQuery(SQLStr);
        if Result then
           begin
            TotalDeposit := CheckQuery.FieldByName('TotalDeposit').AsFloat;
            SQLStr := 'Select CreditLimit From VIPTable Where VIPNo = ' + IntToStr(VIPNo);
            Result := OpenCheckQuery(SQLStr);
            if Result then
               begin
                CreditLimit := CheckQuery.FieldByName('CreditLimit').AsFloat + TotalDeposit;
                TotalCredit := TotalCredit + CurrentSales;
                Result := TotalCredit <= CreditLimit;
               end;
        end;
    end;
 CheckQuery.Close;
end;

function TDataForm.GetAvailableCredit(VIPNo: integer): double;
var
 SQLStr: string;
 TotalCredit, TotalDebit, TotalDeposit, CreditLimit: double;
 Flag: boolean;
begin
 SQLStr := 'Select Sum(TempTable.Credit) As TotalCredit From ' +
           '(Select (Amount + Tips + ServiceCharge + OtherCharge + Surcharge) As Credit ' +
           'From OrderH Where (PriceIncludesGST <> 0) and (VIPNo=' + IntToStr(VIPNo) + ') ' +
           'Union All ' +
           'Select (Amount + Tips + ServiceCharge + OtherCharge + GST + Surcharge) As Credit ' +
           'From OrderH Where (PriceIncludesGST = 0) and (VIPNo=' + IntToStr(VIPNo) + ')) As TempTable';
 Flag := OpenCheckQuery(SQLStr);
 Result := 0;
 if Flag then
    begin
     TotalCredit := CheckQuery.FieldByName('TotalCredit').AsFloat;

     SQLStr := 'Select Sum(RecvAcct.PaidAmount) As TotalDebit ' +
               'From OrderH, RecvAcct ' +
               'Where OrderH.OrderNo=RecvAcct.OrderNo and DepositID = 0 and ' +
               'VIPNo=' + IntToStr(VIPNo);
     Flag := OpenCheckQuery(SQLStr);
     if Flag then
        begin
         TotalDebit := CheckQuery.FieldByName('TotalDebit').AsFloat;
         TotalCredit := TotalCredit - TotalDebit;
         SQLStr := 'Select Sum(Amount) As TotalDeposit From DepositTable Where VIPNo=' + IntToStr(VIPNo);
         Flag := OpenCheckQuery(SQLStr);
         if Flag then
            begin
             TotalDeposit := CheckQuery.FieldByName('TotalDeposit').AsFloat;
             SQLStr := 'Select CreditLimit From VIPTable Where VIPNo = ' + IntToStr(VIPNo);
             Flag := OpenCheckQuery(SQLStr);
             if Flag then
                begin
                 CreditLimit := CheckQuery.FieldByName('CreditLimit').AsFloat + TotalDeposit;
                 Result := CreditLimit - TotalCredit;
                end;
            end;
        end;
    end;
 CheckQuery.Close;
end;

function TDataForm.GetVIPAwardPoints(VIPNo: integer; OrderNo: string): double;
var
 SQLStr: string;
begin
 SQLStr := 'Select Sum(AwardPoints - PaymentPoints) As TotalPoints From ' +
           '(Select Sum(AwardPoints) As AwardPoints, 0 As PaymentPoints ' +
           'From LoyaltyPoints Where VIPNo=' + IntToStr(VIPNo) +
           ' Union All ' +
           'Select 0 As AwardPoint, Sum(PaymentPoints) As PaymentPoints ' +
           'From LoyaltyPoints Where (VIPNo=' + IntToStr(VIPNo) + ') and ' +
           '(OrderNo <> ' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) + ')) As TempTable';
 if OpenCheckQuery(SQLStr) then
    Result := CheckQuery.FieldByName('TotalPoints').AsInteger
   else
    Result := 0;
 CheckQuery.Close;
end;

function TDataForm.ReadVIPInformation(VIPNo: integer; var VIPName: string; var VIPDiscountRate: double): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select VIPName, Discount From VIPTable Where VIPNo=' + IntToStr(VIPNo);
 if OpenCheckQuery(SQLStr) then
    begin
     VIPDiscountRate := CheckQuery.FieldByName('Discount').AsFloat;
     VIPName := CheckQuery.FieldByName('VIPName').AsString;
     Result := True;
    end
   else
    Result := False;
 CheckQuery.Close;
end;

function TDataForm.SaveAwardPoints(OrderNo: string; VIPNo, AwardPoints: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From LoyaltyPoints Where AwardPoints <> 0 and OrderNo=' +
           Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 Result := ExecQueryPro(SQLStr);
 if Result and (AwardPoints >= 1) then
    begin
     SQLStr := 'Insert Into LoyaltyPoints(OrderNo, OrderDate, VIPNo, AwardPoints, PaymentPoints) ' +
               'Values(' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) + ',' +
               ConvertDateTime(Date + Time) + ',' + IntToStr(VIPNo) + ',' +
               IntToStr(AwardPoints) + ', 0)';
     Result := ExecQueryPro(SQLStr);
    end;
end;

function TDataForm.SavePointsPayment(OrderNo: string; VIPNo, PointsPayment: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From LoyaltyPoints Where PaymentPoints <> 0 and OrderNo=' +
           Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 Result := ExecQueryPro(SQLStr);
 if Result and (PointsPayment >= 1) then
    begin
     SQLStr := 'Insert Into LoyaltyPoints(OrderNo, OrderDate, VIPNo, AwardPoints, PaymentPoints) ' +
               'Values(' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) + ',' + ConvertDateTime(Date + Time) + ',' +
               IntToStr(VIPNo) + ', 0,' + IntToStr(PointsPayment) + ')';
     Result := ExecQueryPro(SQLStr);
    end;
end;

function TDataForm.SaveAccountRecord(OrderNo: string; Amount: double; PayBy: string; IDNo, DepositID: integer): boolean;
var
 SQLStr, PaymentTemp, MachineIDStr: string;
begin
 PaymentTemp := Format('%4.2f', [Amount]);
 if MachineID <> '' then
    MachineIDStr := Chr(39) + CheckQuotes(MachineID) + Chr(39)
   else
    MachineIDStr := 'Null';
 SQLStr := 'Insert Into RecvAcct(OrderNo, AccountDate, PaidAmount, ' +
           'PayBy, Transfer, IDNo, OpName, MachineID, DepositID) ' +
           'Values(' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) + ',' +
           ConvertDateTime(Date + Time) + ',' +
           FloatToStr(Amount) + ',' + Chr(39) + CheckQuotes(PayBy) + Chr(39) + ', 0,' +
           IntToStr(IDNo) + ',' + Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' +
           MachineIDStr + ',' + IntToStr(DepositID) + ')';
 Result := ExecQueryPro(SQLStr);
end;

function TDataForm.UpdateOrderPayment(OrderNo: string; SplitBillStatus: boolean): boolean;
var
 SQLStr, CurrentSplitBillStatus: string;
 TotalPayment: double;
begin
 SQLStr := 'Select Sum(PaidAmount) From RecvAcct Where OrderNo=' +
           Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 Result := OpenCheckQuery(SQLStr);
 if Result then
    begin
     if SplitBillStatus then
        CurrentSplitBillStatus := '1'
       else
        CurrentSplitBillStatus := '0';
     TotalPayment := CheckQuery.Fields[0].AsFloat;
     SQLStr := 'Update OrderH Set PaidAmount=' + FloatToStr(TotalPayment) +
               ', SplitBill=' + CurrentSplitBillStatus +
               ' Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
     Result := ExecQueryPro(SQLStr);
    end;
 CheckQuery.Close;
end;

function TDataForm.UpdateExpensesPayment(SerialNo: integer): boolean;
var
 SQLStr: string;
 TotalPayment: double;
begin
 SQLStr := 'Select Sum(PaidAmount) From ExpAcct Where SerialNo=' +
            IntToStr(SerialNo);
 Result := OpenCheckQuery(SQLStr);
 if Result then
    begin
     TotalPayment := CheckQuery.Fields[0].AsFloat;
     SQLStr := 'Update Expenses Set PaidAmount=' + FloatToStr(TotalPayment) +
               ' Where SerialNo=' + IntToStr(SerialNo);
     Result := ExecQueryPro(SQLStr);
    end;
 CheckQuery.Close;
end;

function TDataForm.UpdatePurchasePayment(ReceiveNo: string): boolean;
var
 SQLStr: string;
 TotalPayment: double;
begin
 SQLStr := 'Select Sum(PaidAmount) From PayAcct Where ReceiveNo=' +
           Chr(39) + CheckQuotes(ReceiveNo) + Chr(39);
 Result := OpenCheckQuery(SQLStr);
 if Result then
    begin
     TotalPayment := CheckQuery.Fields[0].AsFloat;
     SQLStr := 'Update StockH Set PaidAmount=' + FloatToStr(TotalPayment) +
               ' Where ReceiveNo=' + Chr(39) + CheckQuotes(ReceiveNo) + Chr(39);
     Result := ExecQueryPro(SQLStr);
    end;
 CheckQuery.Close;
end;

procedure TDataForm.ConnectDrawerPort(PortNumber: integer);
begin
 with DrawerControlPort do
  if PortNumber = 0 then
     begin
      if FVar.CashDrawerPort > 0 then
         begin
          case Fvar.DrawerFlowCtrl of
           0: begin
               ComportSwHandshaking := shXONXOFF;
               ComportHwHandshaking := hhNONE;
              end;
           1: begin
               ComportSwHandshaking := shNONE;
               ComportHwHandshaking := hhRTSCTS;
              end;
           2: begin
               ComportSwHandshaking := shNONE;
               ComportHwHandshaking := hhNONE;
              end;
          end;
          case FVar.CashDrawerPort of
           1: ComPort := pnCOM1;
           2: ComPort := pnCOM2;
           3: ComPort := pnCOM3;
           4: ComPort := pnCOM4;
           5: ComPort := pnCOM5;
           6: ComPort := pnCOM6;
           7: ComPort := pnCOM7;
           8: ComPort := pnCOM8;
          end;
          case FVar.CashDrawerSpeed of
           0: ComPortSpeed := br300;
           1: ComPortSpeed := br600;
           2: ComPortSpeed := br1200;
           3: ComPortSpeed := br2400;
           4: ComPortSpeed := br4800;
           5: ComPortSpeed := br9600;
           6: ComPortSpeed := br19200;
           7: ComPortSpeed := br38400;
           8: ComPortSpeed := br57600;
           9: ComPortSpeed := br115200;
          end;
          Connect;
         end
        else
         Disconnect;
     end
    else
     begin
      if FVar.SecondCashDrawerPort > 0 then
         begin
          case Fvar.SecondDrawerFlowCtrl of
           0: begin
               ComportSwHandshaking := shXONXOFF;
               ComportHwHandshaking := hhNONE;
              end;
           1: begin
               ComportSwHandshaking := shNONE;
               ComportHwHandshaking := hhRTSCTS;
              end;
           2: begin
               ComportSwHandshaking := shNONE;
               ComportHwHandshaking := hhNONE;
              end;
          end;
          case FVar.SecondCashDrawerPort of
           1: ComPort := pnCOM1;
           2: ComPort := pnCOM2;
           3: ComPort := pnCOM3;
           4: ComPort := pnCOM4;
           5: ComPort := pnCOM5;
           6: ComPort := pnCOM6;
           7: ComPort := pnCOM7;
           8: ComPort := pnCOM8;
          end;
          case FVar.SecondCashDrawerSpeed of
           0: ComPortSpeed := br300;
           1: ComPortSpeed := br600;
           2: ComPortSpeed := br1200;
           3: ComPortSpeed := br2400;
           4: ComPortSpeed := br4800;
           5: ComPortSpeed := br9600;
           6: ComPortSpeed := br19200;
           7: ComPortSpeed := br38400;
           8: ComPortSpeed := br57600;
           9: ComPortSpeed := br115200;
          end;
          Connect;
         end
        else
         Disconnect;
     end
end;

procedure TDataForm.OpenDrawer(SalesFlag: boolean; PortNumber: integer);
var
 CommandStr: string;

 SysDir: array[0..$FF] of Char;
begin
GetSystemDirectory(SysDir, SizeOf(SysDir));
 if ((PortNumber = 0) and (FVar.CashDrawerPort = 0)) or
    ((PortNumber = 1) and (FVar.SecondCashDrawerPort = 0)) then Exit;
 if PortNumber = 0 then
    case FVar.CashDrawerMode of
     0:  // Direct connect to PC Serial Port
         CommandStr := Chr(13) + Chr(10) + Chr(13) + Chr(10);
     1:  // Connect to EPSON TM-U200 Series Printer
         CommandStr := Chr(27) + '@' + Chr(27) + 'p0' + Chr(100) + Chr(250);
     2:  // Connect to CITIZEN IDP-3420 Series Printer
         CommandStr := Chr(27) + 'p' + Chr(0) + Chr(100) + Chr(250);
     3:  // Connect to CITIZEN IDP 3221 Series Printer
         CommandStr := Chr(27) + 'p' + Chr(0) + Chr(100) + Chr(250);
     4:  // Connect to CITIZEN CBM 1000 Series Printer
         CommandStr := Chr(27) + 'p' + Chr(0) + Chr(100) + Chr(250);
     5:  // Connect to STAR DP8340 Series Printer
         CommandStr := Chr(07) + Chr(07) + Chr(07);
     6:  // Connect to POSIFLEX PP-1200 Serial Printer
         CommandStr := Chr(28);
     7:  // Connect to POSIFLEX PP-4000 Serial Printer
         CommandStr := Chr(27) + 'p' + Chr(0) + Chr(100) + Chr(250);
     8:  // Connect to POSIFLEX PP-7000 Serial Printer
         CommandStr := Chr(27) + 'p0' + Chr(100) + Chr(250);
    end
   else
    case FVar.SecondCashDrawerMode of
     0:  // Direct connect to PC Serial Port
         CommandStr := Chr(13) + Chr(10);
     1:  // Connect to EPSON TM-U200 Series Printer
         CommandStr := Chr(27) + '@' + Chr(27) + 'p0' + Chr(100) + Chr(250);
     2:  // Connect to CITIZEN IDP-3420 Series Printer
         CommandStr := Chr(27) + 'p' + Chr(0) + Chr(100) + Chr(250);
     3:  // Connect to CITIZEN IDP 3221 Series Printer
         CommandStr := Chr(27) + 'p' + Chr(0) + Chr(100) + Chr(250);
     4:  // Connect to CITIZEN CBM 1000 Series Printer
         CommandStr := Chr(27) + 'p' + Chr(0) + Chr(100) + Chr(250);
     5:  // Connect to STAR DP8340 Series Printer
         CommandStr := Chr(07);
     6:  // Connect to POSIFLEX PP-1200 Serial Printer
         CommandStr := Chr(28);
     7:  // Connect to POSIFLEX PP-4000 Serial Printer
         CommandStr := Chr(27) + 'p' + Chr(0) + Chr(100) + Chr(250);
     8:  // Connect to POSIFLEX PP-7000 Serial Printer
         CommandStr := Chr(27) + 'p0' + Chr(100) + Chr(250);
    end;
 if PortNumber = 0 then
    begin
     if FVar.CashDrawerPort < 9 then
        begin
         ConnectDrawerPort(PortNumber);
         if DrawerControlPort.Connected then
            begin
             DrawerControlPort.SendString(CommandStr);
             DrawerControlPort.Disconnect;
             DrawerIsOpen := Fvar.CheckTillStatus = 1;
            end
        end
       else
        if FVar.CashDrawerPort = 9 then
           begin
            OpenLPTPort;
            WriteStringToLPTPort(CommandStr);
            CloseHandle( LPTPortHandle );
            DrawerIsOpen := False;
           end
          else
           begin
            {WritePort($48F, $40);
            Sleep(100);
            WritePort($48F, $02);}
            //z335 open drawer
            ShellExecute(Application.Handle, 'Open', PChar(SysDir + '\CD.exe'), nil, nil, SW_SHOWMAXIMIZED);
           end
    end
   else
    begin
     if FVar.SecondCashDrawerPort < 9 then
        begin
         ConnectDrawerPort(PortNumber);
         if DrawerControlPort.Connected then
            begin
             DrawerControlPort.SendString(CommandStr);
             DrawerControlPort.Disconnect;
             DrawerIsOpen := Fvar.CheckTillStatus = 1;
            end
        end
       else
        if FVar.SecondCashDrawerPort = 9 then
           begin
            OpenLPTPort;
            WriteStringToLPTPort(CommandStr);
            CloseHandle( LPTPortHandle );
            DrawerIsOpen := False;
           end
          else
           begin
            {WritePort($48F, $40);
            Sleep(100);
            WritePort($48F, $02);}
           end;
    end;
 CountDrawerOpenTimes(SalesFlag);
 if not salesFlag then
    RecordDrawerOpenMSG;
end;

procedure TDataForm.RecordDrawerOpenMSG;
var
 SQLStr, MachineName, ReasonStr: string;
begin
 if MachineID <> '' then
    MachineName := Chr(39) + CheckQuotes(MachineID) + Chr(39)
   else
    MachineName := 'Null';

 ReasonStr := 'Null';
 SQLStr := 'Insert Into DrawerOpenRecordTable(OpenDateTime, MachineID, ' +
           'OpName, Reasons) Values(' + ConvertDateTime(Date + Time) + ',' +
           MachineName + ',' + Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' +
           ReasonStr + ')';
 ExecQueryPro(SQLStr);
end;

procedure TDataForm.ConnectDrawerStatusPort(PortNumber: integer);
begin
 with DrawerStatusPort do
  if PortNumber = 0 then
     begin
      if FVar.CashDrawerPort > 0 then
         begin
          case Fvar.DrawerFlowCtrl of
           0: begin
               ComportSwHandshaking := shXONXOFF;
               ComportHwHandshaking := hhNONE;
              end;
           1: begin
               ComportSwHandshaking := shNONE;
               ComportHwHandshaking := hhRTSCTS;
              end;
           2: begin
               ComportSwHandshaking := shNONE;
               ComportHwHandshaking := hhNONE;
              end;
          end;
          case FVar.CashDrawerPort of
           1: ComPort := pnCOM1;
           2: ComPort := pnCOM2;
           3: ComPort := pnCOM3;
           4: ComPort := pnCOM4;
           5: ComPort := pnCOM5;
           6: ComPort := pnCOM6;
           7: ComPort := pnCOM7;
           8: ComPort := pnCOM8;
          end;
          case FVar.CashDrawerSpeed of
           0: ComPortSpeed := br300;
           1: ComPortSpeed := br600;
           2: ComPortSpeed := br1200;
           3: ComPortSpeed := br2400;
           4: ComPortSpeed := br4800;
           5: ComPortSpeed := br9600;
           6: ComPortSpeed := br19200;
           7: ComPortSpeed := br38400;
           8: ComPortSpeed := br57600;
           9: ComPortSpeed := br115200;
          end;
          Connect;
         end
        else
         Disconnect;
     end
    else
     begin
      if FVar.SecondCashDrawerPort > 0 then
         begin
          case Fvar.SecondDrawerFlowCtrl of
           0: begin
               ComportSwHandshaking := shXONXOFF;
               ComportHwHandshaking := hhNONE;
              end;
           1: begin
               ComportSwHandshaking := shNONE;
               ComportHwHandshaking := hhRTSCTS;
              end;
           2: begin
               ComportSwHandshaking := shNONE;
               ComportHwHandshaking := hhNONE;
              end;
          end;
          case FVar.SecondCashDrawerPort of
           1: ComPort := pnCOM1;
           2: ComPort := pnCOM2;
           3: ComPort := pnCOM3;
           4: ComPort := pnCOM4;
           5: ComPort := pnCOM5;
           6: ComPort := pnCOM6;
           7: ComPort := pnCOM7;
           8: ComPort := pnCOM8;
          end;
          case FVar.SecondCashDrawerSpeed of
           0: ComPortSpeed := br300;
           1: ComPortSpeed := br600;
           2: ComPortSpeed := br1200;
           3: ComPortSpeed := br2400;
           4: ComPortSpeed := br4800;
           5: ComPortSpeed := br9600;
           6: ComPortSpeed := br19200;
           7: ComPortSpeed := br38400;
           8: ComPortSpeed := br57600;
           9: ComPortSpeed := br115200;
          end;
          Connect;
         end
        else
         Disconnect;
     end
end;

procedure TDataForm.TestDrawerStatus(PortNumber: integer);
var
 DataPtr: Pointer;
 DataSize: Integer;
 P: PChar;
 Ch: Char;
begin
 if DrawerIsOpen then
    begin
     ConnectDrawerStatusPort(PortNumber);
     if DrawerStatusPort.Connected then
        DrawerStatusPort.SendString(Chr(29) + 'r2');
     Sleep(50);
     if DrawerStatusPort.ReadFromPort(DataPtr, DataSize) then
        begin
         P := DataPtr;
         Ch := P^;
         if Ord(Ch) and 1 = 1 then
            DrawerIsOpen := False;
        end;
    end;
 DrawerStatusPort.Disconnect;
end;

procedure TDataForm.CountDrawerOpenTimes(SalesFlag: boolean);
var
 SQLStr: string;
 DateTemp: TDateTime;
 Flag: boolean;
begin
 DateTemp := Date;
 SQLStr := 'Select * From DrawerCounter ' +
           'Where OpenDate=' + ConvertDateTime(DateTemp);
 if MachineID <> '' then
    SQLStr := SQLStr + ' and MachineID=' + Chr(39) + CheckQuotes(MachineID) + Chr(39)
   else
    SQLStr := SQLStr + ' and MachineID Is Null';
 if Not OpenCheckQuery(SQLStr) then Exit;
 if CheckQuery.RecordCount = 0 then
    begin
     SQLStr := 'Insert Into DrawerCounter(OpenDate, Times, NonSalesOpen, MachineID) ' +
               'Values(' + ConvertDateTime(DateTemp) + ', ';
     if SalesFlag then
        SQLStr := SQLStr + '1, 0, '
       else
        SQLStr := SQLStr + '0, 1, ';
     if MachineID <> '' then
        SQLStr := SQLStr + Chr(39) + CheckQuotes(MachineID) + Chr(39) + ')'
       else
        SQLStr := SQLStr + 'Null)';
    end
   else
    begin
     SQLStr := 'Update DrawerCounter Set ';
     if SalesFlag then
        SQLStr := SQLStr + 'Times=Times + 1 '
       else
        SQLStr := SQLStr + 'NonSalesOpen = NonSalesOpen + 1 ';
     SQLStr := SQLStr + 'Where OpenDate=' + ConvertDateTime(DateTemp);
     if MachineID <> '' then
        SQLStr := SQLStr + ' and MachineID=' + Chr(39) + CheckQuotes(MachineID) + Chr(39)
      else
        SQLStr := SQLStr + ' and MachineID Is Null';
    end;
 CheckQuery.Close;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := ExecQueryPro(SQLStr);
 finally
  if Flag then
     DataForm.CommitTransaction
    else
     DataForm.RollBack;
 end;
end;

procedure TDataForm.SetBlackFontA;
var
 CommandStr: string;
 Len: Word;
begin
 if CurrentPrinterPort > 9 then
    begin
     if CurrentPrinterIsGeneric then
        begin
         if FVar.Thermal[CurrentPrinterIndex] = 1 then
            begin
             CommandStr := Chr(27) + '!' + Chr(0) + Chr(29) + 'B' + Chr(0);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(29) + '!' + Chr(0)
            end
           else
            begin
             CommandStr := Chr(27) + '!' + Chr(1) + Chr(27) + 'r' + Chr(0);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(0);
            end;
         CommandStr := '  ' + CommandStr;
         Len:= Length(CommandStr) - 2;
         Move(Len, CommandStr[1], 2);
         Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
        end
       else
        with Printer.Canvas do
         begin
          Font.Style := [];
          if FVar.Thermal[CurrentPrinterIndex] = 1 then
             begin
              Font.Name := 'Courier New';
              Font.Style := [fsBold];
              Font.Size := 8;
             end
            else
             begin
              Font.Name := '16 cpi';
              Font.Size := 10;
             end;
          CharHeight := TextHeight('X');
         end
     end
    else
     begin
      if FVar.Thermal[CurrentPrinterIndex] = 1 then
         begin
          CommandStr := Chr(27) + '!' + Chr(0) + Chr(29) + 'B' + Chr(0);
          if FVar.SupportChineseCharacterPrinter = 1 then
             CommandStr := CommandStr + Chr(29) + '!' + Chr(0)
         end
        else
         begin
          CommandStr := Chr(27) + '!' + Chr(1) + Chr(27) + 'r' + Chr(0);
          if FVar.SupportChineseCharacterPrinter = 1 then
             CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(0);
         end;
      if CurrentPrinterPort = 9 then
         WriteStringToLPTPort(CommandStr)
        else
         if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
            POSPrinterPort.SendString(CommandStr);
     end;
end;

procedure TDataForm.SetBlackFontB;
var
 CommandStr: string;
 Len: Word;
begin
 if CurrentPrinterPort > 9 then
    begin
     if CurrentPrinterIsGeneric then
        begin
         if FVar.Thermal[CurrentPrinterIndex] = 1 then
            begin
             CommandStr := Chr(27) + '!' + Chr(32) + Chr(29) + 'B' + Chr(0);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(29) + '!' + Chr(16)
            end
           else
            begin
             CommandStr := Chr(27) + '!' + Chr(33) + Chr(27) + 'r' + Chr(0);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(4);
            end;
         CommandStr := '  ' + CommandStr;
         Len:= Length(CommandStr) - 2;
         Move(Len, CommandStr[1], 2);
         Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
        end
       else
        with Printer.Canvas do
         begin
          Font.Style := [fsBold];
          if FVar.Thermal[CurrentPrinterIndex] = 1 then
             begin
              Font.Name := 'Courier New';
              Font.Style := [fsBold];
              Font.Size := 16;
             end
            else
             begin
              Font.Name := '8 cpi';
              Font.Size := 10;
             end;
          CharHeight := TextHeight('X');
         end
    end
   else
    begin
     if FVar.Thermal[CurrentPrinterIndex] = 1 then
        begin
         CommandStr := Chr(27) + '!' + Chr(32) + Chr(29) + 'B' + Chr(0);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(29) + '!' + Chr(16)
        end
       else
        begin
         CommandStr := Chr(27) + '!' + Chr(33) + Chr(27) + 'r' + Chr(0);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(4);
        end;
     if CurrentPrinterPort = 9 then
        WriteStringToLPTPort(CommandStr)
       else
        if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
           POSPrinterPort.SendString(CommandStr);
    end;
end;

procedure TDataForm.SetBlackFontC;
var
 CommandStr: string;
 Len: Word;
begin
 if CurrentPrinterPort > 9 then
    begin
     if CurrentPrinterIsGeneric then
        begin
         if FVar.Thermal[CurrentPrinterIndex] = 1 then
            begin
             CommandStr := Chr(27) + '!' + Chr(48) + Chr(29) + 'B' + Chr(0);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(29) + '!' + Chr(17)
            end
           else
            begin
             CommandStr := Chr(27) + '!' + Chr(49) + Chr(27) + 'r' + Chr(0);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(12);
            end;
         CommandStr := '  ' + CommandStr;
         Len:= Length(CommandStr) - 2;
         Move(Len, CommandStr[1], 2);
         Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
        end
       else
        with Printer.Canvas do
         begin
          Font.Style := [fsBold];
          if FVar.Thermal[CurrentPrinterIndex] = 1 then
             begin
              Font.Name := 'Courier New';
              Font.Style := [fsBold];
              Font.Size := 16;
             end
            else
             begin
              Font.Name := '8 cpi';
              Font.Size := 20;
             end;
          CharHeight := TextHeight('X');
         end
    end
   else
    begin
     if FVar.Thermal[CurrentPrinterIndex] = 1 then
        begin
         CommandStr := Chr(27) + '!' + Chr(48) + Chr(29) + 'B' + Chr(0);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(29) + '!' + Chr(17)
        end
       else
        begin
         CommandStr := Chr(27) + '!' + Chr(49) + Chr(27) + 'r' + Chr(0);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(12);
        end;
     if CurrentPrinterPort = 9 then
        WriteStringToLPTPort(CommandStr)
       else
        if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
           POSPrinterPort.SendString(CommandStr);
    end;
end;

procedure TDataForm.SetBlackFontD;
var
 CommandStr: string;
 Len: Word;
begin
 if CurrentPrinterPort > 9 then
    begin
     if CurrentPrinterIsGeneric then
        begin
         if FVar.Thermal[CurrentPrinterIndex] = 1 then
            begin
             CommandStr := Chr(27) + '!' + Chr(33) + Chr(29) + 'B' + Chr(0);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(29) + '!' + Chr(17)
            end
           else
            begin
             CommandStr := Chr(27) + '!' + Chr(33) + Chr(27) + 'r' + Chr(0);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(4);
            end;
         CommandStr := '  ' + CommandStr;
         Len:= Length(CommandStr) - 2;
         Move(Len, CommandStr[1], 2);
         Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
        end
       else
        with Printer.Canvas do
         begin
          Font.Style := [fsBold];
          if FVar.Thermal[CurrentPrinterIndex] = 1 then
             begin
              Font.Name := 'Courier New';
              Font.Style := [fsBold];
              Font.Size := 16;
             end
            else
             begin
              Font.Name := '8 cpi';
              Font.Size := 10;
             end;
          CharHeight := TextHeight('X');
         end
    end
   else
    begin
     if FVar.Thermal[CurrentPrinterIndex] = 1 then
        begin
         CommandStr := Chr(27) + '!' + Chr(33) + Chr(29) + 'B' + Chr(0);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(29) + '!' + Chr(17)
        end
       else
        begin
         CommandStr := Chr(27) + '!' + Chr(33) + Chr(27) + 'r' + Chr(0);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(4);
        end;
     if CurrentPrinterPort = 9 then
        WriteStringToLPTPort(CommandStr)
       else
        if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
           POSPrinterPort.SendString(CommandStr);
    end;
end;

procedure TDataForm.SetRedFontA;
var
 CommandStr: string;
 Len: Word;
begin
 if CurrentPrinterPort > 9 then
    begin
     if CurrentPrinterIsGeneric then
        begin
         if FVar.Thermal[CurrentPrinterIndex] = 1 then
            begin
             CommandStr := Chr(27) + '!' + Chr(0) + Chr(29) + 'B' + Chr(1);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(29) + '!' + Chr(0)
             end
           else
            begin
             CommandStr := Chr(27) + '!' + Chr(1) + Chr(27) + 'r' + Chr(1);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(0);
            end;
         CommandStr := '  ' + CommandStr;
         Len:= Length(CommandStr) - 2;
         Move(Len, CommandStr[1], 2);
         Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
        end
       else
        with Printer.Canvas do
         begin
          Font.Style := [];
          if FVar.Thermal[CurrentPrinterIndex] = 1 then
             begin
              Font.Name := 'Courier New';
              Font.Style := [fsBold];
              Font.Size := 8;
             end
            else
             begin
              Font.Name := '16 cpi (RED)';
              Font.Size := 10;
             end;
          CharHeight := TextHeight('X');
         end
    end
   else
    begin
     if FVar.Thermal[CurrentPrinterIndex] = 1 then
        begin
         CommandStr := Chr(27) + '!' + Chr(0) + Chr(29) + 'B' + Chr(1);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(29) + '!' + Chr(0)
        end
       else
        begin
         CommandStr := Chr(27) + '!' + Chr(1) + Chr(27) + 'r' + Chr(1);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(0);
        end;
     if CurrentPrinterPort = 9 then
        WriteStringToLPTPort(CommandStr)
       else
        if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
           POSPrinterPort.SendString(CommandStr);
    end;
end;

procedure TDataForm.SetRedFontB;
var
 CommandStr: string;
 Len: Word;
begin
 if CurrentPrinterPort > 9 then
    begin
     if CurrentPrinterIsGeneric then
        begin
         if FVar.Thermal[CurrentPrinterIndex] = 1 then
            begin
             CommandStr := Chr(27) + '!' + Chr(32) + Chr(29) + 'B' + Chr(1);
             if FVar.SupportChineseCharacterPrinter= 1 then
                CommandStr := CommandStr + Chr(29) + '!' + Chr(16)
            end
           else
            begin
             CommandStr := Chr(27) + '!' + Chr(33) + Chr(27) + 'r' + Chr(1);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(4);
            end;
         CommandStr := '  ' + CommandStr;
         Len:= Length(CommandStr) - 2;
         Move(Len, CommandStr[1], 2);
         Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
        end
       else
        with Printer.Canvas do
         begin
          Font.Style := [fsBold];
          if FVar.Thermal[CurrentPrinterIndex] = 1 then
             begin
              Font.Name := 'Courier New';
              Font.Style := [fsBold];
              Font.Size := 16;
             end
            else
             begin
              Font.Name := '8 cpi (RED)';
              Font.Size := 10;
             end;
          CharHeight := TextHeight('X');
         end
    end
   else
    begin
     if FVar.Thermal[CurrentPrinterIndex] = 1 then
        begin
         CommandStr := Chr(27) + '!' + Chr(32) + Chr(29) + 'B' + Chr(1);
         if FVar.SupportChineseCharacterPrinter= 1 then
            CommandStr := CommandStr + Chr(29) + '!' + Chr(16)
        end
       else
        begin
         CommandStr := Chr(27) + '!' + Chr(33) + Chr(27) + 'r' + Chr(1);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(4);
        end;
     if CurrentPrinterPort = 9 then
        WriteStringToLPTPort(CommandStr)
       else
        if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
           POSPrinterPort.SendString(CommandStr);
    end;
end;

procedure TDataForm.SetRedFontC;
var
 CommandStr: string;
 Len: Word;
begin
 if CurrentPrinterPort > 9 then
    begin
     if CurrentPrinterIsGeneric then
        begin
         if FVar.Thermal[CurrentPrinterIndex] = 1 then
            begin
             CommandStr := Chr(27) + '!' + Chr(48) + Chr(29) + 'B' + Chr(1);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(29) + '!' + Chr(17)
            end
           else
            begin
             CommandStr := Chr(27) + '!' + Chr(49) + Chr(27) + 'r' + Chr(1);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(12);
            end;
         CommandStr := '  ' + CommandStr;
         Len:= Length(CommandStr) - 2;
         Move(Len, CommandStr[1], 2);
         Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
        end
       else
        with Printer.Canvas do
         begin
          Font.Style := [fsBold];
          if FVar.Thermal[CurrentPrinterIndex] = 1 then
             begin
              Font.Name := 'Courier New';
              Font.Style := [fsBold];
              Font.Size := 16;
             end
            else
             begin
              Font.Name := '8 cpi (RED)';
              Font.Size := 20;
             end;
          CharHeight := TextHeight('X');
         end
    end
   else
    begin
     if FVar.Thermal[CurrentPrinterIndex] = 1 then
        begin
         CommandStr := Chr(27) + '!' + Chr(48) + Chr(29) + 'B' + Chr(1);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(29) + '!' + Chr(17)
        end
       else
        begin
         CommandStr := Chr(27) + '!' + Chr(49) + Chr(27) + 'r' + Chr(1);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(12);
        end;
     if CurrentPrinterPort = 9 then
        WriteStringToLPTPort(CommandStr)
       else
        if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
           POSPrinterPort.SendString(CommandStr);
    end;
end;

procedure TDataForm.SetRedFontD;
var
 CommandStr: string;
 Len: Word;
begin
 if CurrentPrinterPort > 9 then
    begin
     if CurrentPrinterIsGeneric then
        begin
         if FVar.Thermal[CurrentPrinterIndex] = 1 then
            begin
             CommandStr := Chr(27) + '!' + Chr(33) + Chr(29) + 'B' + Chr(1);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(29) + '!' + Chr(17)
            end
           else
            begin
             CommandStr := Chr(27) + '!' + Chr(33) + Chr(27) + 'r' + Chr(1);
             if FVar.SupportChineseCharacterPrinter = 1 then
                CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(4);
            end;
         CommandStr := '  ' + CommandStr;
         Len:= Length(CommandStr) - 2;
         Move(Len, CommandStr[1], 2);
         Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
        end
       else
        with Printer.Canvas do
         begin
          Font.Style := [fsBold];
          if FVar.Thermal[CurrentPrinterIndex] = 1 then
             begin
              Font.Name := 'Courier New';
              Font.Style := [fsBold];
              Font.Size := 16;
             end
            else
             begin
              Font.Name := '8 cpi';
              Font.Size := 10;
             end;
          CharHeight := TextHeight('X');
         end
    end
   else
    begin
     if FVar.Thermal[CurrentPrinterIndex] = 1 then
        begin
         CommandStr := Chr(27) + '!' + Chr(33) + Chr(29) + 'B' + Chr(1);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(29) + '!' + Chr(17)
        end
       else
        begin
         CommandStr := Chr(27) + '!' + Chr(33) + Chr(27) + 'r' + Chr(1);
         if FVar.SupportChineseCharacterPrinter = 1 then
            CommandStr := CommandStr + Chr(28) + Chr(38) + Chr(28) + '!' + Chr(4);
        end;
     if CurrentPrinterPort = 9 then
        WriteStringToLPTPort(CommandStr)
       else
        if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
           POSPrinterPort.SendString(CommandStr);
    end;
end;

procedure TDataForm.PrintLogoToPOSPrinter;
var
 CommandStr: string;
 Len: Word;
begin
 CommandStr := Chr(28) + 'p' + Chr(1) + Chr(0);
 if (FVar.PrintLogoOnPOSPrinter = 1) and (FVar.Thermal[CurrentPrinterIndex] = 1) then
    begin
     if CurrentPrinterPort <= 9 then
        begin
         if CurrentPrinterPort = 9 then
            begin
             WriteStringToLPTPort(CommandStr);
             WriteStringToLPTPort(Chr(13) + Chr(10));
            end
           else
            if POSPrinterPort.Connected then
               begin
                POSPrinterPort.SendString(CommandStr);
                POSPrinterPort.SendString(Chr(13) + Chr(10));
               end;
        end
       else
        if CurrentPrinterIsGeneric then
           begin
            CommandStr := '  ' + CommandStr + Chr(13) + Chr(10);
            Len:= Length(CommandStr) - 2;
            Move(Len, CommandStr[1], 2);
            Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
           end;
    end;
end;

procedure TDataForm.OpenLPTPort;
var
 PortName: array[0..4] of char;
begin
  StrPCopy( PortName, 'LPT1' );
  PortName[4] := #0;
  LPTPortHandle := CreateFile(
                           PortName,
                           GENERIC_WRITE,
                           0, // Not shared
                           nil, // No security attributes
                           OPEN_EXISTING,
                           FILE_ATTRIBUTE_NORMAL,
                           0 // No template
                           ) ;
end;

function TDataForm.WriteDataToLPTPort(DataPtr: pointer; DataSize: DWORD ): boolean;
var nsent: DWORD;
begin
  Result := WriteFile( LPTPortHandle, DataPtr^, DataSize, nsent, nil );
  Result := Result and (nsent=DataSize);
end;

function TDataForm.WriteStringToLPTPort( s: string ): boolean;
begin
 Result := WriteDataToLPTPort( pchar(s), length(s) );
end;

function TDataForm.IsGenericDriver(PrinterName: string): boolean;
var
 hPrinter: THandle;
 DriverInfo: PDriverInfo2;
 dwNeeded: DWORD;
begin
 OpenPrinter(PChar(PrinterName), hPrinter, nil);
 GetMem(DriverInfo, dwNeeded);
 Result := GetPrinterDriver(hPrinter, nil, 2, DriverInfo, dwNeeded, dwNeeded) and
    (StrPas(DriverInfo.pName) = 'Generic / Text Only');
 ClosePrinter(hPrinter);
 FreeMem(DriverInfo);
end;

procedure TDataForm.SetDefaultPrinter(PrinterName: String);
var
 s2 : string;
 dum1 : Pchar;
 xx, qq : integer;
const
 cs1 : pchar = 'Windows';
 cs2 : pchar = 'Device';
 cs3 : pchar = 'Devices';
 cs4 : pchar = #0;
begin
 xx := 254;
 GetMem( dum1, xx);
 try
  qq := GetProfileString( cs3, pchar( printerName ), #0, dum1, xx);
  if (qq > 0) and (trim( strpas( dum1 )) <> '') then
     begin
      s2 := PrinterName + ',' + strpas( dum1 );
      while GetProfileString( cs1, cs2, cs4, dum1, xx) > 0 do
       WriteProfileString( cs1, cs2, #0);
      WriteProfileString( cs1, cs2, pchar( s2 ));
     end;
 finally
  FreeMem( dum1 );
 end;
end;

procedure TDataForm.SetGenericePrinter;
var
 Device, Driver, Port: array[0..80] of Char;
 DevMode: THandle;
 pDevmode: PDeviceMode;
begin
 // Get printer device mode handle.
 Printer.GetPrinter(Device, Driver, Port, DevMode);
 if Devmode <> 0 then
    begin // lock it to get pointer to DEVMODE record
     pDevMode := GlobalLock(DevMode);
     if pDevMode <> nil then
        try
         with pDevMode^ do
          begin
           dmPaperSize := DMPAPER_FOLIO;
           dmFields := dmFields or DM_PAPERSIZE;
           dmDefaultSource := 258;
           dmFields := dmFields or DM_DEFAULTSOURCE;
          end;
        finally    // unlock devmode handle.
         GlobalUnlock(Devmode);
        end;
    end;
end;

procedure TDataForm.PrinterStatusCheckTimerTimer(Sender: TObject);
var
 PrinterName: string;
 I: integer;
begin
 PrinterStatusCheckTimer.Enabled := False;
 for I := 1 to 12 do
  begin
   if (String(FVar.POSPrinter[I].Name) <> 'COM1') and
      (String(FVar.POSPrinter[I].Name) <> 'COM2') and
      (String(FVar.POSPrinter[I].Name) <> 'COM3') and
      (String(FVar.POSPrinter[I].Name) <> 'COM4') and
      (String(FVar.POSPrinter[I].Name) <> 'COM5') and
      (String(FVar.POSPrinter[I].Name) <> 'COM6') and
      (String(FVar.POSPrinter[I].Name) <> 'COM7') and
      (String(FVar.POSPrinter[I].Name) <> 'COM8') and
      (String(FVar.POSPrinter[I].Name) <> 'LPT1') and
      (String(FVar.POSPrinter[I].Name) <> 'N/A') then
      begin
       PrinterName := String(FVar.POSPrinter[I].Name);
       TestPrinterStatus(PrinterName);
      end;
  end;
 PrinterStatusCheckTimer.Enabled := True;
end;

procedure TDataForm.TestPrinterStatus(PrinterName: string);
const
  InfoLevel = 1;
  FirstJob = 0;
  LastJob = 19;
var
 Jobs: array [FirstJob..LastJob] of TJobInfo1;
 PrinterHandle: THandle;
 NumJobs, BytesNeeded: DWORD;
 sMsg: string;
begin
 sMsg := '';
 if OpenPrinter(PChar(PrinterName), PrinterHandle, nil) then
    begin
     if EnumJobs(PrinterHandle, FirstJob, LastJob + 1, InfoLevel, @Jobs, SizeOf(Jobs), BytesNeeded, NumJobs) then
        begin
         if (Jobs[0].Status <> 0) and
            (Jobs[0].Status <> JOB_STATUS_PRINTED) and
            (Jobs[0].Status <> JOB_STATUS_PRINTING) and
            (Jobs[0].Status <> JOB_STATUS_SPOOLING) then
            begin
             case Jobs[0].Status of
              JOB_STATUS_DELETING:  sMsg := 'Deleting job';
              JOB_STATUS_ERROR:     sMsg := 'Printing error';
              JOB_STATUS_OFFLINE:   sMsg := 'Printer offline';
              JOB_STATUS_PAPEROUT:  sMsg := 'Paper out';
              JOB_STATUS_PAUSED:    sMsg := 'Printer paused';
             else
              sMsg := 'PRINTING ERROR';
             end;
             MessageBoxForm.MessagePro(sMsg + Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                                      'Please check the printer: ' + PrinterName, sErrorMsg);
            end;
        end;
     ClosePrinter(PrinterHandle);
    end;
end;

procedure TDataForm.OpenPrinterPort(PrinterPort: integer);
var
 PrinterName, CommandStr: string;
 DefaultPrinterIsGeneric: boolean;
begin
 CurrentPrinterIndex := PrinterPort;
 PrinterName := String(FVar.POSPrinter[PrinterPort].Name);
 if (PrinterName <> 'COM1') and (PrinterName <> 'COM2') and (PrinterName <> 'COM3') and
    (PrinterName <> 'COM4') and (PrinterName <> 'COM5') and (PrinterName <> 'COM6') and
    (PrinterName <> 'COM7') and (PrinterName <> 'COM8') and (PrinterName <> 'LPT1') then
    CurrentPrinterPort := SearchString(Printer.Printers, PrinterName) + 10
   else
    if PrinterName = 'LPT1' then CurrentPrinterPort := 9
      else
       if PrinterName = 'COM1' then CurrentPrinterPort := 1
         else
          if PrinterName = 'COM2' then CurrentPrinterPort := 2
            else
             if PrinterName = 'COM3' then CurrentPrinterPort := 3
               else
                if PrinterName = 'COM4' then CurrentPrinterPort := 4
                  else
                   if PrinterName = 'COM5' then CurrentPrinterPort := 5
                     else
                      if PrinterName = 'COM6' then CurrentPrinterPort := 6
                        else
                         if PrinterName = 'COM7' then CurrentPrinterPort := 7
                           else
                            if PrinterName = 'COM8' then CurrentPrinterPort := 8;
 if CurrentPrinterPort > 9 then
    begin
     DefaultPrinterIsGeneric := IsGenericDriver(Printer.Printers[Printer.PrinterIndex]);
     CurrentPrinterIsGeneric := IsGenericDriver(PrinterName);
     if (Printer.Printers[Printer.PrinterIndex] <> PrinterName) and
        ((DefaultPrinterIsGeneric and Not CurrentPrinterIsGeneric) or
        (Not DefaultPrinterIsGeneric and CurrentPrinterIsGeneric)) then
        SetDefaultPrinter(PrinterName);
     Printer.PrinterIndex := SearchString(Printer.Printers, PrinterName);
     if CurrentPrinterIsGeneric then SetGenericePrinter;
     Printer.Refresh;
     Printer.BeginDoc;
     VMar := 0;
    end
   else
    if CurrentPrinterPort = 9 then
       begin
        OpenLPTPort;
        CommandStr := Chr(27) + '@';
        WriteStringToLPTPort(CommandStr);
       end
      else
       with POSPrinterPort do
        if CurrentPrinterIndex > 0 then
           begin
            case FVar.PrinterFlowCtrl[CurrentPrinterIndex] of
             0: begin
                 ComportSwHandshaking := shXONXOFF;
                 ComportHwHandshaking := hhNONE;
                end;
             1: begin
                 ComportSwHandshaking := shNONE;
                 ComportHwHandshaking := hhRTSCTS;
                end;
             2: begin
                 ComportSwHandshaking := shNONE;
                 ComportHwHandshaking := hhNONE;
                end;
            end;
            case CurrentPrinterPort of
             1: ComPort := pnCOM1;
             2: ComPort := pnCOM2;
             3: ComPort := pnCOM3;
             4: ComPort := pnCOM4;
             5: ComPort := pnCOM5;
             6: ComPort := pnCOM6;
             7: ComPort := pnCOM7;
             8: ComPort := pnCOM8;
            end;
            case FVar.PrinterSpeed[CurrentPrinterIndex] of
             0: ComPortSpeed := br300;
             1: ComPortSpeed := br600;
             2: ComPortSpeed := br1200;
             3: ComPortSpeed := br2400;
             4: ComPortSpeed := br4800;
             5: ComPortSpeed := br9600;
             6: ComPortSpeed := br19200;
             7: ComPortSpeed := br38400;
             8: ComPortSpeed := br57600;
             9: ComPortSpeed := br115200;
            end;
            Connect;
            if Connected then SendString(Chr(27) + '@');
           end
          else
           Disconnect;
end;

procedure TDataForm.OutPutToPrinter(TextStr: string);
var
 CommandStr: string;
 Len: Word;
begin
 CommandStr := Chr(27) + 'a' + Chr(0) + TextStr + Chr(13) + Chr(10);
 if CurrentPrinterPort > 9 then
    begin
     if CurrentPrinterIsGeneric then
        begin
         CommandStr := '  ' + CommandStr;
         Len:= Length(CommandStr) - 2;
         Move(Len, CommandStr[1], 2);
         Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
        end
       else
        begin
         if (FVar.Thermal[CurrentPrinterIndex] = 1) and (VMar + CharHeight >= Printer.PageHeight) then
            begin
             Printer.NewPage;
             VMar := 0;
            end;
         Printer.Canvas.TextOut(0, VMar, TextStr);
         VMar := VMar + CharHeight;
        end
    end
   else
    begin
     if CurrentPrinterPort = 9 then
        WriteStringToLPTPort(CommandStr)
       else
        if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
           POSPrinterPort.SendString(CommandStr);
    end;
end;

procedure TDataForm.CutPaper;
var
 CommandStr: string;
 I, Len: Word;
begin
 SetBlackFontA;
 if FVar.Thermal[CurrentPrinterIndex] = 1 then
    CommandStr := Chr(27) + 'd' + Chr(FVar.FeedLines) + Chr(29) + 'V' + Chr(1)
   else
    CommandStr := Chr(27) + 'd' + Chr(FVar.FeedLines * 2 + 1) + Chr(29) + 'V' + Chr(1);
 if FVar.AutoCutter[CurrentPrinterIndex] = 1 then
    begin
     if (CurrentPrinterPort <= 9) then
        begin
         if CurrentPrinterPort = 9 then
            WriteStringToLPTPort(CommandStr)
           else
            if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
               POSPrinterPort.SendString(CommandStr);
        end
       else
        if CurrentPrinterIsGeneric then
           begin
            CommandStr := '  ' + CommandStr;
            Len:= Length(CommandStr) - 2;
            Move(Len, CommandStr[1], 2);
            Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
           end
          else
           for I := 1 to FVar.FeedLines do OutPutToPrinter(' ');
    end
   else
    for I := 1 to FVar.FeedLines do OutPutToPrinter(' ');
end;

procedure TDataForm.ClosePrinterPort;
begin
 if CurrentPrinterPort > 9 then
    begin
     if Not CurrentPrinterIsGeneric then
        Printer.Canvas.TextOut(0, VMar, ' ');
     Printer.EndDoc;
    end
   else
    if CurrentPrinterPort = 9 then
       CloseHandle( LPTPortHandle )
      else
       if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
          POSPrinterPort.Disconnect;
end;

procedure TDataForm.OpenSecurityCameraPort;
begin
 if FVar.SecurityCameraPort >= 1 then
    with SecurityCameraCommPort do
     begin
      case FVar.SecurityCameraPort of
       1: ComPort := pnCOM1;
       2: ComPort := pnCOM2;
       3: ComPort := pnCOM3;
       4: ComPort := pnCOM4;
       5: ComPort := pnCOM5;
       6: ComPort := pnCOM6;
       7: ComPort := pnCOM7;
       8: ComPort := pnCOM8;
      end;
      case FVar.SecurityCameraPortControl of
        0: begin
            ComportSwHandshaking := shXONXOFF;
            ComportHwHandshaking := hhNONE;
           end;
        1: begin
            ComportSwHandshaking := shNONE;
            ComportHwHandshaking := hhRTSCTS;
           end;
        2: begin
            ComportSwHandshaking := shNONE;
            ComportHwHandshaking := hhNONE;
           end;
      end;
      case FVar.SecurityCameraPortSpeed of
       0: ComPortSpeed := br300;
       1: ComPortSpeed := br600;
       2: ComPortSpeed := br1200;
       3: ComPortSpeed := br2400;
       4: ComPortSpeed := br4800;
       5: ComPortSpeed := br9600;
       6: ComPortSpeed := br19200;
       7: ComPortSpeed := br38400;
       8: ComPortSpeed := br57600;
       9: ComPortSpeed := br115200;
      end;
     Connect;
    end
end;

procedure TDataForm.SendMsgToSecurityCameraPort(Msg: string);
var
 CommandStr: string;
begin
 if (FVar.SecurityCameraPort >= 1) and SecurityCameraCommPort.Connected then
    begin
     CommandStr := Msg + Chr(13) + Chr(10);
     SecurityCameraCommPort.SendString(CommandStr);
    end;
end;

procedure TDataForm.CloseSecurityCameraPort;
begin
if SecurityCameraCommPort.Connected then
   SecurityCameraCommPort.Disconnect;
end;

procedure TDataForm.FeedsPaperLines;
var
 CommandStr: string;
 Len: word;
begin
 SetBlackFontA;
 CommandStr := Chr(27) + 'd' + Chr(FVar.FirstFeedLines);
 if (FVar.AutoCutter[CurrentPrinterIndex] = 1) and (CurrentPrinterPort <= 9) then
    begin
     if CurrentPrinterPort = 9 then
        WriteStringToLPTPort(CommandStr)
       else
        if (CurrentPrinterPort > 0) and POSPrinterPort.Connected then
           POSPrinterPort.SendString(CommandStr);
    end
   else
    if CurrentPrinterIsGeneric then
       begin
        CommandStr := '  ' + CommandStr;
        Len:= Length(CommandStr) - 2;
        Move(Len, CommandStr[1], 2);
        Escape(Printer.Canvas.Handle, Passthrough, 0, PChar(CommandStr), nil);
       end;
end;

procedure TDataForm.PrintBillHead;
var
 StrLength, I, PaperWidth: integer;
 PrintStr, StrTemp, CodeTemp: string;
begin
 PaperWidth := 40;
 OpenCompanyQuery;
 StrLength := Length(CompanyQuery.FieldByName('CompanyName').AsString);
 if StrLength <= 20 then
    begin
     SetBlackFontB;
     StrLength := (20 - StrLength) div 2;
     StrTemp := '%' + IntToStr(StrLength) + 's%s';
     PrintStr := Format(StrTemp, ['', CompanyQuery.FieldByName('CompanyName').AsString]);
     OutPutToPrinter(PrintStr);
     SetBlackFontA;
    end
   else
    begin
     SetBlackFontA;
     if StrLength < PaperWidth then
        StrLength := (PaperWidth - StrLength) div 2
       else
        StrLength := 0;
     StrTemp := '%' + IntToStr(StrLength) + 's%s';
     PrintStr := Format(StrTemp, ['', CompanyQuery.FieldByName('CompanyName').AsString]);
     OutPutToPrinter(PrintStr);
    end;
 StrTemp := sRegistName + ' ' + CompanyQuery.FieldByName('ABN').AsString;
 StrLength := Length(StrTemp);
 StrLength := (PaperWidth - StrLength) div 2;
 PrintStr := Format('%' + IntToStr(StrLength) + 's%s', ['', StrTemp]);
 OutPutToPrinter(PrintStr);
 StrTemp := '';
 if CompanyQuery.FieldByName('Telephone').AsString <> '' then
    StrTemp := 'Tel: ' + CompanyQuery.FieldByName('Telephone').AsString;
 if CompanyQuery.FieldByName('Fax').AsString <> '' then
    begin
     if StrTemp <> '' then StrTemp := StrTemp + '  ';
     StrTemp := StrTemp + 'Fax: ' + CompanyQuery.FieldByName('Fax').AsString;
    end;
 StrLength := Length(StrTemp);
 if StrLength > 0 then
    begin
     if StrLength < PaperWidth then
        StrLength := (PaperWidth - StrLength) div 2
       else
        StrLength := 0;
     PrintStr := Format('%' + IntToStr(StrLength) + 's%s', ['', StrTemp]);
     OutPutToPrinter(PrintStr);
    end;
 StrTemp := CompanyQuery.FieldByName('Address').AsString;
 CodeTemp := ''; I := 0;
 while I < Length(StrTemp) do
  begin
   I := I + 1;
   if (StrTemp[I] <> Chr(13)) and (StrTemp[I] <> Chr(10)) then
      CodeTemp := CodeTemp + StrTemp[I]
     else
      begin
       if CodeTemp <> '' then
          begin
           StrLength := Length(CodeTemp);
           if StrLength < PaperWidth then
              StrLength := (PaperWidth - StrLength) div 2
             else
              StrLength := 0;
           PrintStr := Format('%' + IntToStr(StrLength) + 's%s', ['', CodeTemp]);
           OutPutToPrinter(PrintStr);
          end;
       I := I + 1; CodeTemp := '';
      end;
  end;
 if CodeTemp <> '' then
    begin
       StrLength := Length(CodeTemp);
       if StrLength < PaperWidth then
          StrLength := (PaperWidth - StrLength) div 2
         else
          StrLength := 0;
       PrintStr := Format('%' + IntToStr(StrLength) + 's%s', ['', CodeTemp]);
       OutPutToPrinter(PrintStr);
    end;
 CompanyQuery.Close;
end;

procedure TDataForm.OpenPoleDisplayPort;
begin
 if FVar.PoleDisplayPort = 0 then Exit;
 with PoleDisplayComPort do
  begin
   case Fvar.PoleFlowCtrl of
    0: begin
        ComportSwHandshaking := shXONXOFF;
        ComportHwHandshaking := hhNONE;
       end;
    1: begin
        ComportSwHandshaking := shNONE;
        ComportHwHandshaking := hhRTSCTS;
       end;
    2: begin
        ComportSwHandshaking := shNONE;
        ComportHwHandshaking := hhNONE;
       end;
   end;
   case FVar.PoleDisplayMode of
    0, 1: ComPortParity := ptNone; // Epson and IBM
    2: ComPortParity := ptODD;     // Toshiba
   end;
   case FVar.PoleDisplayPort of
    1: ComPort := pnCOM1;
    2: ComPort := pnCOM2;
    3: ComPort := pnCOM3;
    4: ComPort := pnCOM4;
    5: ComPort := pnCOM5;
    6: ComPort := pnCOM6;
    7: ComPort := pnCOM7;
    8: ComPort := pnCOM8;
   end;
   case FVar.PoleDisplaySpeed of
    0: ComPortSpeed := br300;
    1: ComPortSpeed := br600;
    2: ComPortSpeed := br1200;
    3: ComPortSpeed := br2400;
    4: ComPortSpeed := br4800;
    5: ComPortSpeed := br9600;
    6: ComPortSpeed := br19200;
    7: ComPortSpeed := br38400;
    8: ComPortSpeed := br57600;
    9: ComPortSpeed := br115200;
   end;
   Connect;
  end;
end;

procedure TDataForm.ClosePoleDisplayPort;
begin
 if PoleDisplayComPort.Connected then
    PoleDisplayComPort.Disconnect;
end;

procedure TDataForm.SendToPoleDisp(S1, S2: string);
begin
 with PoleDisplayComPort do
  if Connected then
     case FVar.PoleDisplayMode of
      0: begin   // Epson Mode
          SendString(Chr(31) + Chr(01) + Chr(12)); // Set Overwrite Mode and clear screen
          SendString(Format('%20s', ['']) + Chr(13) + Format('%20s', ['']));
          SendString(Uppercase(S1) + Chr(13) + Uppercase(S2));
          SendString(Chr(31) + Chr(67) + Chr(00)); // Hides Cursor
         end;
      1: begin  // IBM Mode
          SendString(Chr(17)); // Set Normal Mode
          SendString(Chr(16) + Chr(0) + Format('%20s', ['']) + Format('%20s', ['']));
          SendString(Chr(16) + Chr(0) + Uppercase(S1));
          SendString(Chr(16) + Chr(20) + Uppercase(S2));
          SendString(Chr(20));
         end;
      2:  begin  // Toshiba Mode
          SendString(Chr(27) + Chr(91) + Chr(50) + Chr(74)); // Clear Screen   1B 5B 32 4A
          SendString(Chr(27) + Chr(82) + Chr(0)); // Set country code
          SendString(Chr(27) + Chr(92) + Chr(63) + Chr(76) + Chr(67) + '0');  // Course Off (1B 5C 3F 4C 43 Ps)
          SendString(Chr(27) + '[1;1H'); // Move Cursor X=1 Y=1
          SendString(Uppercase(S1));
          SendString(Chr(27) + '[2;1H'); // Move Cursor X=1 Y=2
          SendString(Uppercase(S2));
         end;
     end;
end;

procedure TDataForm.InitToLinkEFTPOS;
begin
 EFTPOSStatus := True;
 try
  EFTPOS := TCsdEft.Create(Self);
 except
  EFTPOS := Nil;
  EFTPOSStatus := False;
 end;
end;

procedure TDataForm.ConnectToScale;
begin
 if FVar.ScalePort > 0 then
    with ScaleCommPort do
     begin
      case Fvar.ScaleFlowCtrl of
       0: begin
           ComportSwHandshaking := shXONXOFF;
           ComportHwHandshaking := hhNONE;
          end;
       1: begin
           ComportSwHandshaking := shNONE;
           ComportHwHandshaking := hhRTSCTS;
          end;
       2: begin
           ComportSwHandshaking := shNONE;
           ComportHwHandshaking := hhNONE;
          end;
      end;
      case FVar.ScaleModel of
       0: begin  // CAS AP1
           ComPortDataBits := db8BITS;
           ComPortParity := ptNone;
          end;
       1, 2, 3, 4, 5:
          begin  // PSC, Mettler
           ComPortDataBits := db7BITS;
           ComPortParity := ptEVEN;
          end;
      end;
      case FVar.ScalePort of
       1: ComPort := pnCOM1;
       2: ComPort := pnCOM2;
       3: ComPort := pnCOM3;
       4: ComPort := pnCOM4;
       5: ComPort := pnCOM5;
       6: ComPort := pnCOM6;
       7: ComPort := pnCOM7;
       8: ComPort := pnCOM8;
      end;
      case FVar.ScaleSpeed of
       0: ComPortSpeed := br300;
       1: ComPortSpeed := br600;
       2: ComPortSpeed := br1200;
       3: ComPortSpeed := br2400;
       4: ComPortSpeed := br4800;
       5: ComPortSpeed := br9600;
       6: ComPortSpeed := br19200;
       7: ComPortSpeed := br38400;
       8: ComPortSpeed := br57600;
       9: ComPortSpeed := br115200;
      end;
      Connect;
     end;
end;

function TDataForm.ReadCASAP1WScaleData(var Weight: double): boolean;   // For CAS AP-1W
var
 Key, PP: Char;
 P: pchar;
 Temp: string;
 DataSize: integer;
 DataPtr: Pointer;
begin
 Result := False;
 ScaleDataBuff := '';
 ConnectToScale;
 Key := Chr(05);
 if ScaleCommPort.Connected then
    begin
     ScaleCommPort.SendData(@Key, 1);
     Sleep(50);
     if ScaleCommPort.ReadFromPort(DataPtr, DataSize) then
        begin
         P := DataPtr;
         PP := P^;
         if PP = Chr(6) then
            begin
             Key := Chr(17);
             ScaleCommPort.SendData( @Key, 1 );
             Sleep(50);
             if ScaleCommPort.ReadFromPort(DataPtr, Datasize) then
                begin
                 P := DataPtr;
                 while DataSize > 0 do
                  begin
                   ScaleDataBuff := ScaleDataBuff + P^;
                   Dec( DataSize );
                   Inc( P );
                  end;
                 if (Length(ScaleDataBuff) = 15) and (ScaleDataBuff[4] = ' ') then
                    begin
                     Temp := Copy(ScaleDataBuff, 5, 6);
                     Weight := StrToFloat(Temp);
                     Result := True;
                    end;
                end;
            end;
        end;
    end;
 ScaleCommPort.Disconnect;
end;

{function TDataForm.ReadCASPDIIScaleData(var Weight: double): boolean;   // For CAS PD-II
var
 Key: Char;
 P: pchar;
 DataSize, I: integer;
 DataPtr: Pointer;
 Temp: string;
begin
 Result := False;
 ScaleDataBuff := '';
 ConnectToScale;
 Key := 'W';
 if ScaleCommPort.Connected then
    begin
     ScaleCommPort.SendData(@Key, 1);
     Sleep(200);
     if ScaleCommPort.ReadFromPort(DataPtr, DataSize) then
        begin
         p := DataPtr;
         while (DataSize > 0) and (P^ <> Chr(13)) do
          begin
           ScaleDataBuff := ScaleDataBuff + p^;
           Dec( DataSize );
           Inc( p );
          end;
         if (Length(ScaleDataBuff) = 6) and (ScaleDataBuff[1] = Chr(2)) then
            begin
             Temp := '';
             for I := 2 to 6 do
              if ScaleDataBuff[I] In ['0'..'9', '.'] then
                 Temp := Temp + ScaleDataBuff[I];
             if Length(Temp) = 5 then
                begin
                  Weight := StrToFloat(Temp) / 1000;
                  if ABS(Weight) >= 0.005 then
                     Result := True;
                 end;
             end;
        end;
    end;
  Key := Chr(13);
  ScaleCommPort.SendData(@Key, 1);
  ScaleCommPort.Disconnect;
end;}

function TDataForm.ReadCASPDIIScaleData(var Weight: double): boolean;   // For CAS PD-II
var
 Key,key1: Char;
 P: pchar;
 DataSize, I: integer;
 DataPtr: Pointer;
 Temp: string;
begin
 Result := False;
 ScaleDataBuff := '';
 ConnectToScale;
 Key := 'W';
 Key1 := Chr(13);
 if ScaleCommPort.Connected then
    begin
     ScaleCommPort.SendData(@Key, 1);
     ScaleCommPort.SendData(@key1,1);
     Sleep(500);
     if ScaleCommPort.ReadFromPort(DataPtr, DataSize) then
        begin
         p := DataPtr;
         while (DataSize > 0) and (P^ <> Chr(13)) do
          begin
           ScaleDataBuff := ScaleDataBuff + p^;
           Dec( DataSize );
           Inc( p );
          end;
         Temp := copy(ScaleDataBuff,3,5);
         Weight := StrToFloat(Temp);
         Result := True;
        end;
    end;
  //Key := Chr(13);
  //ScaleCommPort.SendData(@Key, 1);
  ScaleCommPort.Disconnect;
end;

function TDataForm.ReadDataFromScaleCASAP1W(var Weight: double): boolean;   // For CAS AP-1W
var
 CurrentWeight: double;
 RetryCount: integer;
begin
 RetryCount := 0;
 repeat
  Result := ReadCASAP1WScaleData(CurrentWeight);
  RetryCount := RetryCount + 1;
 until (Result and (CurrentWeight >= 0.005)) or (RetryCount >= 3);
 if Not Result then
    begin
     Weight := 0;
     MessageBoxForm.MessagePro('Data Transaction Error.', sErrorMsg);
    end
   else
    begin
     Weight := CurrentWeight;
     if ABS(Weight) < 0.005 then
        MessageBoxForm.MessagePro('Weight can not be Zero.', sErrorMsg)
    end;
end;

function TDataForm.ReadDataFromScaleCASPDII(var Weight: double): boolean;   // For CAS PD_II
var
 CurrentWeight: double;
 RetryCount: integer;
begin
 RetryCount := 0;
 repeat
  Result := ReadCASPDIIScaleData(CurrentWeight);
  RetryCount := RetryCount + 1;
 until (Result and (CurrentWeight >= 0.005)) or (RetryCount >= 3);
 if Not Result then
    begin
     Weight := 0;
     MessageBoxForm.MessagePro('Data Transaction Error.', sErrorMsg);
    end
   else
    begin
     Weight := CurrentWeight;
     if ABS(Weight) < 0.005 then
        MessageBoxForm.MessagePro('Weight is Zero.', sErrorMsg)
    end;
end;

function TDataForm.ReadDataFromScalePSC(var Weight: double): boolean;  // For PSC , Mettler
var
 Key: Char;
 P: pchar;
 DataSize, I: integer;
 DataPtr: Pointer;
 Temp: string;
begin
 Result := False;
 ScaleDataBuff := '';
 ConnectToScale;
 Key := 'W';
 if ScaleCommPort.Connected then
    begin
     ScaleCommPort.SendData(@Key, 1);
     Sleep(250);
     if ScaleCommPort.ReadFromPort(DataPtr, DataSize) then
        begin
         p := DataPtr;
         while DataSize > 0 do
          begin
           ScaleDataBuff := ScaleDataBuff + p^;
           Dec( DataSize );
           Inc( p );
          end;
         if (Length(ScaleDataBuff) <> 8) or (ScaleDataBuff[1] <> Chr(2)) or (ScaleDataBuff[8] <> Chr(13)) then
            MessageBoxForm.MessagePro('Scale Data Transaction Error.', sErrorMsg)
           else
            begin
             Temp := '';
             for I := 2 to 7 do
              if ScaleDataBuff[I] In ['0'..'9', '.'] then
                 Temp := Temp + ScaleDataBuff[I];
             if Length(Temp) <> 6 then
                MessageBoxForm.MessagePro('Scale Data Transaction Error!', sErrorMsg)
               else
                begin
                  Weight := StrToFloat(Temp);
                  if ABS(Weight) < 0.001 then
                     MessageBoxForm.MessagePro('Weight can not be Zero!', sErrorMsg)
                    else
                     Result := True;
                 end;
             end;
        end;
    end;
  ScaleCommPort.Disconnect;
end;

function TDataForm.ReadDataFromScaleWedderburn(var Weight: double): boolean;   // For Wedderburn
var
 Key: Char;
 P: pchar;
 Temp: string;
 DataSize: integer;
 DataPtr: Pointer;
begin
 Result := False;
 ScaleDataBuff := '';
 ConnectToScale;
 Key := Chr(05);
 if ScaleCommPort.Connected then
    begin
     ScaleCommPort.SendData(@Key, 1);
     Sleep(150);
     if ScaleCommPort.ReadFromPort(DataPtr, DataSize) then
        begin
         P := DataPtr;
         if P^ = Chr(6) then
            begin
             Key := Chr(17);
             ScaleCommPort.SendData( @Key, 1 );
             Sleep(150);
             if ScaleCommPort.ReadFromPort(DataPtr, Datasize) then
                begin
                 P := DataPtr;
                 while DataSize > 0 do
                  begin
                   ScaleDataBuff := ScaleDataBuff + P^;
                   Dec( DataSize );
                   Inc( P );
                  end;
                 if (Length(ScaleDataBuff) <> 9) or (ScaleDataBuff[1] <> Chr(2)) or
                    (ScaleDataBuff[9] <> Chr(3)) then
                    MessageBoxForm.MessagePro('Scale Data Transaction Error.', sErrorMsg)
                   else
                     begin
                      Temp := Copy(ScaleDataBuff, 3, 5);
                      Weight := StrToFloat(Temp) / 1000;
                      if ABS(Weight) < 0.001 then
                         MessageBoxForm.MessagePro('Weight can not be Zero!', sErrorMsg)
                        else
                         Result := True;
                     end;
                end;
            end
           else
            MessageBoxForm.MessagePro('Scale Data Transaction Error.', sErrorMsg);
        end;
    end;
 Key := Chr(04);
 ScaleCommPort.SendData( @Key, 1 );
 ScaleCommPort.Disconnect;
end;

procedure TDataForm.SetSystemDateTime;
var
 SQLStr: string;
 CurrentDateTime: TDateTime;
 SysDateTime: SYSTEMTIME;
 Year, Month, Day, Hour, Min, Sec, MSec: word;
begin
 SQLStr := 'Select GETDATE()';
 OpenTempQuery(SQLStr);
 CurrentDateTIme := TempQuery.Fields[0].AsDateTime;
 TempQuery.Close;
 DecodeDate(CurrentDateTime, Year, Month, Day);
 DecodeTime(CurrentDateTime, Hour, Min, Sec, MSec);
 with SysDateTime do
  begin
   wYear := Year;
   wMonth := Month;
   wDayOfWeek := DayOfWeek(CurrentDateTime);
   wDay := Day;
   wHour := Hour;
   wMinute := Min;
   wSecond := Sec;
   wMilliseconds := MSec;
  end;
 SetLocalTime(SysDateTime);
end;

function TDataForm.RecalculateOrderAmount(OrderNo: string): boolean;
var
 SQLStr: string;
 DiscountRate, CurrentOtherChargeRate, CurrentServiceChargeRate, OtherCharge,
 ServiceCharge, Discount, Price, RealPrice, Amount, Qty, GST, DollarDiscount,
 CurrentGSTRate, RewardPointsDiscount: double;
 CurrentPriceIncludesGST: boolean;
begin
 SQLStr := 'Select * From OrderH Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 Result := OpenTempQuery(SQLStr);
 if Not TempQuery.Active or (TempQuery.RecordCount = 0) then
    begin
     TempQuery.Close;
     Exit;
    end;
 with TempQuery do
  begin
   CurrentPriceIncludesGST := FieldByName('PriceIncludesGST').AsBoolean;
   CurrentOtherChargeRate := FieldByName('OtherChargeRate').AsFloat;
   CurrentServiceChargeRate := FieldByName('ServiceChargeRate').AsFloat;
   DollarDiscount := FieldByName('DollarDiscount').AsFloat;
   CurrentGSTRate := FieldByName('CurrentGSTRate').AsFloat;
   RewardPointsDiscount := FieldByName('RewardPoints').AsFloat;
   Close;
  end;
 SQLStr := 'Select * From OrderI Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 Amount := 0; Discount := 0; GST := 0;
 OpenTempQuery(SQLStr);
 with TempQuery do
  if Active and (RecordCount > 0) then
     begin
      First;
      while Not EOF do
       begin
        Qty := FieldByName('Qty').AsFloat;
        Price := FieldByName('Price').AsFloat;
        Amount := Amount + Price * Qty;
        if ABS(DollarDiscount) < 0.005 then
           begin
            DiscountRate := StrToFloat(Format('%6.4f', [FieldByName('Discount').AsFloat / 100]));
            RealPrice := Price * (1 - DiscountRate);
            Discount := Discount + (Price - RealPrice) * Qty;
            if CurrentPriceIncludesGST then
               GST := GST + RealPrice * Qty * (1 - 1 / (1 + FieldByName('TaxRate').AsFloat / 100))
              else
               GST := GST + RealPrice * Qty * FieldByName('TaxRate').AsFloat / 100;
           end
          else
           begin
            if CurrentPriceIncludesGST then
               GST := GST + Price * Qty * (1 - 1 / (1 + FieldByName('TaxRate').AsFloat / 100))
              else
               GST := GST + Price * Qty * FieldByName('TaxRate').AsFloat / 100;
           end;
        Next;
       end;
     end;
 TempQuery.Close;
 if ABS(DollarDiscount) >= 0.005 then
    begin
     Discount := DollarDiscount;
     if CurrentPriceIncludesGST then
        GST := GST - DollarDiscount * (1 - 1 / (1 + CurrentGSTRate / 100))
       else
        GST := GST - DollarDiscount * CurrentGSTRate / 100;
    end
   else
    Discount := RoundToCurrency(Discount);
 if CurrentPriceIncludesGST then
    GST := GST - RewardPointsDiscount * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    GST := GST - RewardPointsDiscount * CurrentGSTRate / 100;
 if ABS(Discount) <= 0.001 then Discount := 0;

 Amount := Amount - Discount - RewardPointsDiscount;
 ServiceCharge := Amount * CurrentServiceChargeRate / 100;
 ServiceCharge := RoundToCurrency(ServiceCharge);
 OtherCharge := Amount * CurrentOtherChargeRate / 100;
 OtherCharge := RoundToCurrency(OtherCharge);
 if CurrentPriceIncludesGST then
    GST := GST + (ServiceCharge + OtherCharge) * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    GST := GST + (ServiceCharge + OtherCharge) * CurrentGSTRate / 100;
 if (Amount >= 0) and (GST <= 0) then GST := 0;
 SQLStr := 'Update OrderH Set Amount=' + FloatToStr(Amount) + ',' +
           'GST=' + FloatToStr(GST) + ',' +
           'ServiceCharge=' + FloatToStr(ServiceCharge) + ',' +
           'OtherCharge=' + FloatToStr(OtherCharge) +
           ' Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 Result := ExecQueryPro(SQLStr);
end;

procedure TDataForm.BackupDatabasePro(BackupFileName: string);
var
 SQLStr, TargetDir, TargetFileName, LocalMachineName: string;
 Flag: boolean;
begin
 GetLocalMachineName(LocalMachineName);
 Flag := True;
 DisplayMessageForm.DisplayMessagePro('Backup database, please wait...');
 try
  if UpperCase(LocalMachineName) = UpperCase(Copy(sServerName, 1, Length(LocalMachineName))) then  // Only master terminal can do Backup
     begin
      if BackupFileName <> '' then
         TargetFileName := BackupFileName
        else
         TargetFileName := StartDir + 'Backup\' + sDatabaseName + FormatDateTime('yyyymmddhhmmss', Date + Time) + '.Dat';
      TargetDir := ExtractFilePath(TargetFileName);
      if TargetDir = '' then
         begin
          TargetDir := StartDir + 'Backup\';
          TargetFileName := TargetDir + TargetFileName;
         end;
      if ExtractFileName(TargetFileName) = '' then
         TargetFileName := TargetFileName + sDatabaseName + FormatDateTime('yyyymmddhhmmss', Date + Time) + '.Dat';
      if Not DirectoryExists(TargetDir) then Flag := CreateDir(TargetDir);
      if Flag and FileExists(TargetFileName) then Flag := DeleteFile(TargetFileName);
      if Flag then
         begin
          SQLStr := 'BACKUP DATABASE ' + sDatabaseName +
                    ' TO DISK=' + Chr(39) + CheckQuotes(TargetFileName) + Chr(39);
          ExecCommand.CommandTimeout := 300;
          Flag := DataForm.ExecQueryPro(SQLStr);
         end;
     end;
 finally
  DisplayMessageForm.Close;
  DisplayMessageForm.Free;
  if Not Flag then MessageBoxForm.MessagePro('Database backup failure!', sErrorMsg);
 end;
end;

procedure TDataForm.BackupTimerTimer(Sender: TObject);
var
 t: TDateTime;
begin
 t := Time;
 if (BackupFrequency = 0) or ((t >= BackupOnceTime) and (t <= BackupOnceTime + StrToTime('00:00:02'))) then
    begin
     BackupTimer.Enabled := False;
     BackupDatabasePro(DefaultBackupPath);
     ExecCommand.CommandTimeout := 60;
     BackupTimer.Enabled := True;
    end;
end;

function TDataForm.CheckMinimumChargeBalance(OrderNo: string; var MinimumCharge: double): boolean;
var
 SQLStr: string;
begin
 MinimumCharge := 0; 
 SQLStr := 'Select OrderNo, OrderH.TableNo, Amount, Persons, MinimumChargePerTable ' +
           'From OrderH, TableSet ' +
           'Where OrderH.TableNo=TableSet.TableNo and ' +
           'OrderNo=' + Chr(39) + OrderNo + Chr(39);
 if OpenTempQuery(SQLStr) then
    with TempQuery do
     begin
      if MinimumChargeKind = 1 then
         begin
          if FieldByName('Persons').AsInteger = 0 then
             begin
              MessageBoxForm.MessagePro('People = 0, can not calculate minimum charge.', sErrorMsg);
              Result := False;
             end
            else
             begin
              MinimumCharge := FieldByName('Persons').AsInteger * MinimumChargePerPerson - FieldByName('Amount').AsFloat;
              Result := True;
             end;
         end
        else
         begin
          MinimumCharge := FieldByName('MinimumChargePerTable').AsFloat - FieldByName('Amount').AsFloat;
          Result := True;
         end;
      Close;
     end
    else
     Result := False;
end;

function TDataForm.GetMinimumChargeForPerTable(TableNo: string): double;
var
 SQLStr: string;
begin
 SQLStr := 'Select MinimumChargePerTable From TableSet ' +
           'Where TableNo=' + Chr(39) + CheckQuotes(TableNo) + Chr(39);
 if OpenTempQuery(SQLStr) and TempQuery.Active and (TempQuery.RecordCount > 0) then
    Result := TempQuery.FieldByName('MinimumChargePerTable').AsFloat
   else
    Result := 0;
end;

procedure TDataForm.ActiveSocket;
begin
 with ServerSocket1 do
  begin
   Active := False;
   Port := 60607;
   ServerType := stNonBlocking;
   Active := True;
  end;
end;

procedure TDataForm.ServerSocketClientError(Sender: TObject; Socket: TCustomWinSocket;
          ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
 ErrorCode := 0;
end;

procedure TDataForm.ServerSocketClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
 CommandStr, OrderNo, IDString: string;
 Operation: char;
begin
 CommandStr := Socket.ReceiveText;
 OrderNo := Copy(CommandStr, 1, 10);
 Operation := CommandStr[12];
 IDString := Copy(CommandStr, 14, Length(CommandStr) - 13);
 case Operation of
  '0': begin
        PrintJobListControlForm.PrintJobListControlPro(OrderNo, '', False, sConfirmedOrder);
        if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(OrderNo, '', False);
       end;
  '1': case PrintBillMode of
        0, 1: PrintOrderForm.PrintOrderPro(OrderNo);
        2:    PrintOrderForm1.PrintOrderPro(OrderNo, True);
        3:    PrintOrderForm1.PrintOrderPro(OrderNo, False);
        4:    PrintOrderForm2.PrintOrderPro(OrderNo);
        5:    PrintOrderForm3.PrintOrderPro(OrderNo);
       end;
  '2': if IDString <> '' then
          begin
           PrintJobListControlForm.PrintJobListControlPro(OrderNo, IDString, False, sConfirmedOrder);
            if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(OrderNo, IDString, False);
          end;
  '3': begin
        PrintJobListControlForm.PrintJobListControlPro(OrderNo, '', True, sConfirmedOrder);
        if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(OrderNo, '', True);
       end;
 end;
end;


function TDataForm.LockTable(TableNo: string): boolean;
var
 SQLStr: string;
begin
 if TableLockFunctionEnabled then
    begin
     Result := DataForm.BeginTransaction;
     if Result then
        try
         SQLStr := 'Select TableLocked From TableSet Where TableNo=' + Chr(39) + TableNo + Chr(39);
         Result := OpenTempQuery(SQLStr);
         with TempQuery do
          if Result and Active and (RecordCount > 0) then
             begin
              if Not FieldByName('TableLocked').AsBoolean then
                 begin
                  SQLStr := 'Update TableSet Set TableLocked = 1 Where TableNo=' + Chr(39) + TableNo + Chr(39);
                  Result := ExecQueryPro(SQLStr);
                 end
                else
                 Result := False;
             end;
        finally
         if Result then
            CommitTransaction
           else
            begin
             RollBack;
             MessageBoxForm.MessagePro('This Table has been used by another user.' , sErrorMsg);
            end;
        end
    end
   else
    Result := True;
end;

function TDataForm.ReleaseTable(TableNo: string): boolean;
var
 SQLStr: string;
begin
 if (TableNo = '') or Not TableLockFunctionEnabled then Result := True
   else
    begin
     Result := DataForm.BeginTransaction;
     if Result then
        try
         SQLStr := 'Update TableSet Set TableLocked = 0 Where TableNo=' + Chr(39) + CheckQuotes(TableNo) + Chr(39) + '';
         Result := ExecQueryPro(SQLStr);
        finally
         if Result then
            CommitTransaction
           else
            Rollback;
        end;
    end;
end;

function TDataForm.TestVIPAddress(VIPNo: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From VIPTable Where VIPNo=' + IntToStr(VIPNo);
 Result := OpenTempQuery(SQLStr);
 if Result then
    with TempQuery do
     begin
      Result := (FieldByName('Number').AsString <> '') and
                (FieldByName('Address').AsString <> '') and
                (FieldByName('Suburb').AsString <> '');
      Close;
     end;
end;

end.
