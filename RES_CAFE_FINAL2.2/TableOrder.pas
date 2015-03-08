unit TableOrder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,                                          
  Mask, StdCtrls, ExtCtrls, Buttons, Grids, UtilUnit, Db, DataUnit,                                              
  ADODB, CommDrv, bsSkinCtrls, PanelButton, XiButton, MainMenu, SUIButton;

type
  TTableOrderForm = class(TForm)
    StringGrid: TStringGrid;
    Query: TADOQuery;
    MenuQuery: TADOQuery;
    CategoryQuery: TADOQuery;
    BackPanel: TbsSkinPanel;
    TitlePanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    OrderDateEdit: TbsSkinLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    PersonEdit: TbsSkinLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    BookingNoEdit: TbsSkinLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    VIPNameEdit: TbsSkinLabel;
    bsSkinStdLabel5: TbsSkinStdLabel;
    OrderNoEdit: TbsSkinLabel;
    bsSkinStdLabel6: TbsSkinStdLabel;
    TableNoEdit: TbsSkinLabel;
    bsSkinStdLabel7: TbsSkinStdLabel;
    ServiceEdit: TbsSkinLabel;
    StringGridPanel: TbsSkinPanel;
    TotalPanel: TbsSkinPanel;
    SummaryPanel: TbsSkinPanel;
    RewardPointsLabel: TbsSkinStdLabel;
    OtherChargeLabel: TbsSkinStdLabel;
    RewardPointsDiscountEdit: TbsSkinStdLabel;
    ServiceChargeEdit: TbsSkinStdLabel;
    OtherChargeEdit: TbsSkinStdLabel;
    ServiceChargeLabel: TbsSkinStdLabel;
    LangurageButton: TXiButton;
    SplitLineButton: TXiButton;
    ZoomButton: TXiButton;
    EditPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    MinimumChargeButton: TXiButton;
    ControlButton1: TXiButton;
    ControlButton2: TXiButton;
    ControlButton3: TXiButton;
    ControlButton4: TXiButton;
    ControlButton5: TXiButton;
    ControlButton6: TXiButton;
    ControlButton7: TXiButton;
    ControlButton8: TXiButton;
    ControlButton9: TXiButton;
    ControlButton10: TXiButton;
    ControlButton11: TXiButton;
    ControlButton12: TXiButton;
    ControlButton13: TXiButton;
    ControlButton14: TXiButton;
    ControlButton15: TXiButton;
    ControlButton16: TXiButton;
    ControlButton17: TXiButton;
    ControlButton18: TXiButton;
    ControlButton19: TXiButton;
    ControlButton20: TXiButton;
    ControlButton21: TXiButton;
    ControlButton22: TXiButton;
    ControlButton23: TXiButton;
    ControlButton24: TXiButton;
    EditButton1: TXiButton;
    EditButton2: TXiButton;
    EditButton3: TXiButton;
    EditButton4: TXiButton;
    EditButton5: TXiButton;
    EditButton6: TXiButton;
    EditButton7: TXiButton;
    EditButton8: TXiButton;
    EditButton9: TXiButton;
    EditButton10: TXiButton;
    EditButton11: TXiButton;
    EditButton12: TXiButton;
    EditButton13: TXiButton;
    EditButton14: TXiButton;
    EditButton15: TXiButton;
    EditButton16: TXiButton;
    EditButton17: TXiButton;
    EditButton18: TXiButton;
    EditButton19: TXiButton;
    EditButton20: TXiButton;
    EditButton21: TXiButton;
    EditButton22: TXiButton;
    EditButton23: TXiButton;
    EditButton24: TXiButton;
    EditButton25: TXiButton;
    EditButton26: TXiButton;
    EditButton27: TXiButton;
    EditButton28: TXiButton;
    PaymentPanel: TbsSkinPanel;
    XiButton1: TXiButton;
    XiButton2: TXiButton;
    XiButton3: TXiButton;
    XiButton6: TXiButton;
    XiButton5: TXiButton;
    XiButton4: TXiButton;
    XiButton7: TXiButton;
    XiButton8: TXiButton;
    XiButton9: TXiButton;
    XiButton10: TXiButton;
    XiButton11: TXiButton;
    XiButton12: TXiButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    XiButton13: TXiButton;
    BitBtn5: TBitBtn;
    bsSkinStdLabel9: TbsSkinStdLabel;
    ChangeEdit: TbsSkinStdLabel;
    Label2: TLabel;
    Label1: TLabel;
    Timer: TTimer;
    XiButton14: TXiButton;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    suiButton3: TsuiButton;
    suiButton6: TsuiButton;
    suiButton5: TsuiButton;
    suiButton4: TsuiButton;
    suiButton7: TsuiButton;
    suiButton8: TsuiButton;
    suiButton9: TsuiButton;
    suiButton12: TsuiButton;
    suiButton11: TsuiButton;
    suiButton10: TsuiButton;
    AmountLabel: TbsSkinStdLabel;
    AmountEdit: TbsSkinStdLabel;
    DiscountTitleLabel: TbsSkinStdLabel;
    DiscountEdit: TbsSkinStdLabel;
    TotalLabel: TbsSkinStdLabel;
    TotalEdit: TbsSkinStdLabel;
    GSTLabel: TbsSkinStdLabel;
    GSTEdit: TbsSkinStdLabel;
    bsSkinStdLabel8: TbsSkinStdLabel;
    PaidEdit: TbsSkinStdLabel;
    Balance: TbsSkinStdLabel;
    BalanceEdit: TbsSkinStdLabel;
    MenuPanel: TbsSkinPanel;
    Menu1: TPanelButton;
    Menu2: TPanelButton;
    Menu3: TPanelButton;
    Menu4: TPanelButton;
    Menu5: TPanelButton;
    Menu6: TPanelButton;
    Menu7: TPanelButton;
    Menu8: TPanelButton;
    Menu9: TPanelButton;
    Menu10: TPanelButton;
    Menu11: TPanelButton;
    Menu12: TPanelButton;
    Menu13: TPanelButton;
    Menu14: TPanelButton;
    Menu15: TPanelButton;
    Menu16: TPanelButton;
    Menu17: TPanelButton;
    Menu18: TPanelButton;
    Menu19: TPanelButton;
    Menu20: TPanelButton;
    Menu21: TPanelButton;
    Menu22: TPanelButton;
    Menu23: TPanelButton;
    Menu24: TPanelButton;
    Menu25: TPanelButton;
    Menu26: TPanelButton;
    Menu27: TPanelButton;
    Menu28: TPanelButton;
    Menu29: TPanelButton;
    Menu30: TPanelButton;
    Menu31: TPanelButton;
    Menu32: TPanelButton;
    Menu33: TPanelButton;
    Menu34: TPanelButton;
    Menu35: TPanelButton;
    Menu36: TPanelButton;
    Menu37: TPanelButton;
    Menu38: TPanelButton;
    PageUpButton: TPanelButton;
    PageDownButton: TPanelButton;
    Menu39: TPanelButton;
    Menu40: TPanelButton;
    Menu41: TPanelButton;
    Menu42: TPanelButton;
    Menu47: TPanelButton;
    Menu50: TPanelButton;
    Menu49: TPanelButton;
    Menu48: TPanelButton;
    Menu46: TPanelButton;
    Menu45: TPanelButton;
    Menu44: TPanelButton;
    Menu43: TPanelButton;
    CategoryPanel: TbsSkinPanel;
    Category1: TPanelButton;
    Category2: TPanelButton;
    Category3: TPanelButton;
    Category4: TPanelButton;
    Category5: TPanelButton;
    Category6: TPanelButton;
    Category7: TPanelButton;
    Category8: TPanelButton;
    Category9: TPanelButton;
    Category10: TPanelButton;
    Category11: TPanelButton;
    Category12: TPanelButton;
    Category13: TPanelButton;
    Category14: TPanelButton;
    Category15: TPanelButton;
    Category16: TPanelButton;
    Category17: TPanelButton;
    Category18: TPanelButton;
    Category19: TPanelButton;
    Category20: TPanelButton;
    Category21: TPanelButton;
    Category22: TPanelButton;
    Category23: TPanelButton;
    Category24: TPanelButton;
    Category25: TPanelButton;
    Category26: TPanelButton;
    Category27: TPanelButton;
    Category28: TPanelButton;
    Category29: TPanelButton;
    Category30: TPanelButton;
    Category31: TPanelButton;
    Category32: TPanelButton;
    Category33: TPanelButton;
    Category34: TPanelButton;
    Category35: TPanelButton;
    Category36: TPanelButton;
    Category37: TPanelButton;
    Category38: TPanelButton;
    Category39: TPanelButton;
    Category40: TPanelButton;
    Category41: TPanelButton;
    Category42: TPanelButton;
    CategoryPageUpButton: TPanelButton;
    CategoryPageDownButton: TPanelButton;
    bsSkinPanel3: TbsSkinPanel;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinPanel2: TbsSkinPanel;
    PanelLine1: TbsSkinPanel;
    bsSkinPanel4: TbsSkinPanel;
    bsSkinPanel5: TbsSkinPanel;
    procedure InitControlButtons;
    procedure InitEditButtons;
    procedure InitFixedButtons;
    procedure SetTotalPanelLabelPosition;
    procedure PostDataToSecondDisplayPro;
    procedure InitMenuPanel;
    procedure InitCategoryPanel;
    procedure OpenCategoryQuery(SQLStr: string);
    procedure OpenMenuQuery(SQLStr: string);
    procedure OpenCategory;
    procedure OpenMenu(Category: string);
    procedure ProcessCategoryButtonTouch(Position: integer);
    procedure ProcessInstruction(Buff: InstructionBuffType);
    procedure ProcessMenuButtonTouch(Position: integer);
    procedure AssignCategoryKeyBoard;
    procedure AssignMenuKeyBoard;
    procedure InitCells(ARow: integer);
    procedure InitStringGrid;
    procedure InitForm;
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure QuitButtonClick(Sender: TObject);
    function  OpenQuery(SQLStr: string): boolean;
    procedure FormShow(Sender: TObject);
    procedure MoveToNextCell;
    procedure StringGridClick(Sender: TObject);
    procedure DeleteLine(ARow: integer);
    function  FindLastRow: integer;
   // procedure CopyMealPackage;
    function  CheckCells(ACol, ARow: integer): boolean;
    procedure CalcAmount;
    function  TestItemCode(ItemCode: string; var PriceFlag: integer): boolean;
    function  OpenHeadQuery(OrderNo: string): boolean;
    procedure ReadHeadData;
    function  OpenItemQuery(OrderNo: string): boolean;
    procedure ReadItemData;
    function  SaveOrderHeadTable(OrderNo: string): boolean;
    function  SaveOrderItemTable(OrderNo: string): boolean;
    function  UpdateTableStatus: boolean;
    function  UpdateBookingMessage: boolean;
    function  CheckTableStatus(TableNo: string): boolean;
    function  CheckOrderStatus(OrderNo: string): boolean;
    procedure BalanceButtonClick(Sender: TObject);
    function  SaveData(OrderNo: string): boolean;
    procedure PrintJobListPro(OrderNo: string);
    function  SaveOrderPro(var OrderNo: string): boolean;
    function  OpenBookHeadQuery(BookingNo: string): boolean;
    procedure ReadBookHeadData;
    procedure ReadBookDetailData(BookingNo: string);
   // procedure ReadBookData;
    procedure ProcessDiscount;
    procedure ExitButtonClick(Sender: TObject);
    function  VoidItemPro(ARow: integer; voidReasonCode: string): integer;
    procedure VoidItemButtonClick(Sender: TObject);
    //procedure MealPackageButtonClick(Sender: TObject);
    function  GetLastNonInstructionItem: integer;
    procedure QtyButtonClick(Sender: TObject);
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure MenuButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TableOrderPro(AutoReturn: boolean);
    procedure SetDescription(ARow: integer);
    procedure InstructionButtonClick(Sender: TObject);
    procedure TableNoEditClick(Sender: TObject);
    procedure PersonEditClick(Sender: TObject);
    procedure PriceButtonClick(Sender: TObject);
    procedure DiscountButtonClick(Sender: TObject);
    procedure CategoryPageUpButtonClick(Sender: TObject);
    procedure CategoryPageDownButtonClick(Sender: TObject);
    procedure CategoryButtonClick(Sender: TObject);
    procedure SetButtonStatus;
    procedure TableOrderButtonClick(Sender: TObject);
    procedure PrintJobListButtonClick(Sender: TObject);
    procedure PrintInvoiceButtonClick(Sender: TObject);
    procedure PrintBillButtonClick(Sender: TObject);
    procedure PaymentButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    //procedure ReservationButtonClick(Sender: TObject);
    procedure OrderListButtonClick(Sender: TObject);
    procedure DailyReportButtonClick(Sender: TObject);
    function  CheckOrderPaymentStatus(OrderNo: string): boolean;
    procedure SplitBillButtonClick(Sender: TObject);
    procedure OpenDrawerButtonClick(Sender: TObject);
    procedure TableStatusButtonClick(Sender: TObject);
    procedure SeatNumberButtonClick(Sender: TObject);
    procedure ConvertLangurage(Firstrow, EndRow: integer);
    procedure LangurageButtonClick(Sender: TObject);
    procedure ServiceEditClick(Sender: TObject);
    procedure UpdatePoleMessage;
    procedure DirectPaymentPro;
    procedure DirectPaymentButtonClick(Sender: TObject);
    procedure InsertLine(CurrentLine: integer);
    procedure SplitLineButtonClick(Sender: TObject);
    procedure PayOutClick(Sender: TObject);
    procedure CashPayOutButtonClick(Sender: TObject);
    //procedure ReservationListButtonClick(Sender: TObject);
   // procedure ViewIngredientsButtonClick(Sender: TObject);
    procedure VIPListButtonClick(Sender: TObject);
    procedure InsertItemButtonClick(Sender: TObject);
    procedure DirectPrintBillButtonClick(Sender: TObject);
    procedure MenuSetupButtonClick(Sender: TObject);
    procedure QuickServiceButtonClick(Sender: TObject);
    procedure VIPManagerButtonClick(Sender: TObject);
    procedure WeightButtonClick(Sender: TObject);
   // procedure PhoneOrderAdminButtonClick(Sender: TObject);
    procedure SpellInstructionButtonClick(Sender: TObject);
    procedure ChangeMenuButtonClick(Sender: TObject);
    procedure UserIDButtonClick(Sender: TObject);
    procedure MenuSetupPro;
    procedure AccountPaymentPro;
    procedure PrintGoWithMessage(OrderNo, InstructionMsg: string);
    procedure PrintTableTransferSlip(OrderNo, OriginalTable, TargetTableNo: string);
    procedure ZoomButtonClick(Sender: TObject);
    function  GetSurchargeRate: double;
    function  GetOtherChargeRate: double;
    procedure MenuGroupButtonClick(Sender: TObject);
    procedure RewardPointsProcess;
    procedure MergeTableButtonClick(Sender: TObject);
    procedure PrintPickupSlipButtonClick(Sender: TObject);
    procedure PrintGoWithMessageButtonClick(Sender: TObject);
    procedure AccountPaymentButtonClick(Sender: TObject);
    procedure OrderDueTimeButtonClick(Sender: TObject);
    procedure SurchargeButtonClick(Sender: TObject);
    procedure RedeemPointButtonClick(Sender: TObject);
    procedure ChangeUserIDButtonClick(Sender: TObject);
    procedure OtherChargeButtonClick(Sender: TObject);
    procedure CustomerNameButtonClick(Sender: TObject);
    procedure DepositButtonClick(Sender: TObject);
    procedure VoidAllItemButtonClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    function  CalcMinimumChargeBalance(var MinimumChargeBalance: double): boolean;
    procedure MinimumChargeButtonClick(Sender: TObject);
    procedure SendToSecurityPortPro(OperationMessage, PayBy1, PayBy2: string; Payment1, Payment2, Rounding, Change: double);
    procedure StringGridDblClick(Sender: TObject);
    procedure ChangeMenuGroupButtonClick(Sender: TObject);
    procedure XiButton1Click(Sender: TObject);
    function CalcBalance: boolean;
    procedure XiButton2Click(Sender: TObject);
    procedure XiButton3Click(Sender: TObject);
    procedure XiButton4Click(Sender: TObject);
    procedure XiButton5Click(Sender: TObject);
    procedure XiButton6Click(Sender: TObject);
    procedure XiButton7Click(Sender: TObject);
    procedure XiButton8Click(Sender: TObject);
    procedure XiButton9Click(Sender: TObject);
    procedure XiButton12Click(Sender: TObject);
    procedure XiButton11Click(Sender: TObject);
    procedure XiButton10Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure XiButton13Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure QuickPaymen();
    procedure DirectPaymentButtonClick1(Sender: TObject);
    procedure SetPaymentStatus(Status: boolean);
    function ProcessQuickPayment(payment: string;Sender:Tobject):boolean;
    procedure CopyStringGrid(StringGrid1 : TStringGrid);
    //procedure PrintPickupSlipButtonClick(Sender: TObject);

  private { Private declarations }
    Number: string;
    BalanceTotal,Change,Change1,Rounding : double;
    EFTPOS,AutoReturn : boolean;
    poleAmount,poleSubtotal : double;
    sTableNo : string ;
    paymentAmount : double;

  public { Public declarations }
    CurrentCol, CurrentRow, StatusFlag, CategoryCurrentPage, MenuCurrentPage,
    CategoryRowCount, TableSeats,  MenuCount, CategoryCount, LastMenuPosition,
    sVIPNo, AutoLogoutTimeCounter: integer;
    ActiveFlag, Changed, Credit, Langurage, CurrentPriceIncludesGST, TableTransfered: boolean;
    sOrderNo, InvoiceNo, MachineName, KeyBuff, MenuGroupCode, OriginalTableNo,
    PresetDiscountCode, DiscountOperator: string;
    OrderDate, DueTime: TDateTime;
    EditFlag, VoidFlag, PrintFlag, CheckListPrinted, SentToKitchen, DiscountFlag: array [1..500] of Boolean;
    Instruction, PriceSelect: array [1..500] of integer;
    PaidQty: array [1..500] of double;
    OpenPrice, OrderInstruction: array [1..500] of Boolean;
    VoidReason: array [1..500] of string;
    OrderOperator: array [1..500] of string;
    SecondScreenDescription: array [1..500] of string;
    OriginalPrice: array [1..500] of double;
    DiscountRate, PaidAmount, Tips, Surcharge, CurrentServiceChargeRate,
    CurrentOtherChargeRate, DollarDiscount, PreAmount, CurrentGSTRate,
    RewardPointsDiscount : double;
    BillKind, DiscountKind, PreItemCount: integer;
    DeliveryFlag, CurrentSplitBillStatus: boolean;
    tableServiceCanceled : boolean;
  end;

var
  TableOrderForm: TTableOrderForm;
  

implementation

uses PrintJobCard, StaffList, ItemSelect, NumPad,
     Instruction, OrderList, PrintInvoice, PrintOrder, PriceSelect,
     EndOfDayRpt, SplitBill, MessageBox, InstructionList, ReadOrderNo,
     TableStatus, PayOut, PrintInvoice1, PrintOrder1, MenuPrintJobList,
     MenuSetup,  Discount,  TimePanel,
     SendToScreen, POSReceipt, DispPOSReceipt, PrintPickupSlip, VoidReasonSelect,
     Keyboard, MergeTable, SelectDrawerNumber, MenuGroupSelect,
     ManuallyEnterTableNo,  PointOfsales,  PrintCheckList,
     DiscountRateSelect, PrintInvoice2, PrintOrder2, ElapseTime, PrintJobListControl,
     PrintOrder3, PrintInvoice3, SubMenu, Receipt, VIPList, RewardPoints,
  Deposit;

{$R *.DFM}

procedure TTableOrderForm.InitControlButtons;
var
 SQLStr, ButtonName: string;
 I, Position, ButtonWidth, ButtonHeight: integer;
begin
 ButtonWidth := 80;
 ButtonHeight := 60;
 for I := 1 to 20 do
  begin
   ButtonName := 'ControlButton' + IntToStr(I);
   with TXiButton(FindComponent(ButtonName)) do
     Visible := False;
  end;
 SQLStr := 'Select * From ButtonsTable Where Disable = 0 and Kind=' +
           IntToStr(sTableOrderControlButton) + ' and CanRelocate <> 0 ' +
           'Order By ButtonName';
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0) then
    begin
     Query.First;
     while Not Query.EOF do
      begin
       Position := Query.FieldByName('Position').AsInteger;
       ButtonName := 'ControlButton' + IntToStr(Position);
       with TXiButton(FindComponent(ButtonName)) do
        begin
         Ctl3D := True;
         case Query.FieldByName('ButtonColor').AsInteger of
          bcNeoDesert: ColorScheme := csNeoDesert;
          bcNeoSky:    ColorScheme := csNeoSky;
          bcNeoGrass:  ColorScheme := csNeoGrass;
          bcNeoSilver: ColorScheme := csNeoSilver;
          bcNeoRose:   ColorScheme := csNeoRose;
          bcNeoSun:    ColorScheme := csNeoSun;
          bcDesert:    ColorScheme := csDesert;
          bcGrass:     ColorScheme := csGrass;
          bcSky:       ColorScheme := csSky;
          bcSun:       ColorScheme := csSun;
          bcRose:      ColorScheme := csRose;
          bcSilver:    ColorScheme := csWhite;
         end;


         Caption := Query.FieldByName('Caption').AsString;
         Font.Name := Query.FieldByName('FontName').AsString;
         Font.Size := Query.FieldByName('FontSize').AsInteger;
         Font.Color := clBlack;
         Font.Style := [];
         if Query.FieldByName('FontBold').AsBoolean then Font.Style := Font.Style + [fsBold];
         if Query.FieldByName('FontItalic').AsBoolean then Font.Style := Font.Style + [fsItalic];
         if Query.FieldByName('FontUnderline').AsBoolean then Font.Style := Font.Style + [fsUnderline];
         if Query.FieldByName('FontStrikeout').AsBoolean then Font.Style := Font.Style + [fsStrikeout];
         case Query.FieldByName('ButtonSize').AsInteger of
          sButtonNormalSize: begin Height := ButtonHeight; Width := ButtonWidth; end;
          sButtonDoubleWidth: begin Height := ButtonHeight; Width := ButtonWidth * 2 + 1; end;
          sButtonDoubleHeight: begin Height := ButtonHeight * 2 + 1; Width := ButtonWidth end;
          sButtonDoubleWidthDoubleHeight: begin Height := ButtonHeight * 2 + 1; Width := ButtonWidth * 2 + 1 end;
         end;
         Visible := True;
         case Query.FieldByName('Event').AsInteger of
          tcTableOrderButtonClick: OnClick := TableOrderButtonClick;
         //tcPhoneOrderAdminButtonClick: OnClick := PhoneOrderAdminButtonClick;
          tcQuickServiceButtonClick: OnClick := QuickServiceButtonClick;
          tcSplitBillButtonClick: OnClick := SplitBillButtonClick;
          tcMergeTableButtonClick: OnClick := MergeTableButtonClick;
          tcPaymentButtonClick: OnClick := PaymentButtonClick;
          tcPrintInvoiceButtonClick: OnClick := PrintInvoiceButtonClick;
          tcPrintBillButtonClick: OnClick := PrintBillButtonClick;
          tcPrintJobListButtonClick: OnClick := PrintJobListButtonClick;
          tcPrintPickupSlipButtonClick: OnClick := PrintPickupSlipButtonClick;
          tcPrintGoWithMessageButtonClick: OnClick := PrintGoWithMessageButtonClick;
          tcDailyReportButtonClick: OnClick := DailyReportButtonClick;
          tcTableStatusButtonClick: OnClick := TableStatusButtonClick;
          tcOrderListButtonClick: OnClick := OrderListButtonClick;
          //tcReservationListButtonClick: OnClick := ReservationListButtonClick;
          tcOpenDrawerButtonClick: OnClick := OpenDrawerButtonClick;
          tcMenuGroupButtonClick: OnClick := MenuGroupButtonClick;
          tcMenuSetupButtonClick: OnClick := MenuSetupButtonClick;
          tcDepositButtonClick: OnClick := DepositButtonClick;
          tcCashPayOutButtonClick: OnClick := CashPayOutButtonClick;
          tcUserIDButtonClick: OnClick := UserIDButtonClick;
          tcVIPManagerButtonClick: OnClick := VIPManagerButtonClick;
          tcExitButtonClick: OnClick := ExitButtonClick;
         end;
         BringToFront;
        end;
       Query.Next;
      end;
     Query.Close;
    end;
end;

procedure TTableOrderForm.InitEditButtons;
var
 SQLStr, ButtonName: string;
 I, Position, ButtonWidth, ButtonHeight: integer;
begin
 ButtonWidth := 80;
 ButtonHeight := 60;
 for I := 1 to 20 do
  begin
   ButtonName := 'EditButton' + IntToStr(I);
   with TXiButton(FindComponent(ButtonName)) do
     Visible := False;
  end;
 SQLStr := 'Select * From ButtonsTable Where Disable = 0 and CanRelocate <> 0 and ' +
           'Kind=' + IntToStr(sTableOrderEditButton) + ' ' + 'Order By ButtonName';
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0) then
    begin
     Query.First;
     while Not Query.EOF do
      begin
       Position := Query.FieldByName('Position').AsInteger;
       ButtonName := 'EditButton' + IntToStr(Position);
       with TXiButton(FindComponent(ButtonName)) do
        begin
         Ctl3D := True;
         case Query.FieldByName('ButtonColor').AsInteger of
          bcNeoDesert: ColorScheme := csNeoDesert;
          bcNeoSky:    ColorScheme := csNeoSky;
          bcNeoGrass:  ColorScheme := csNeoGrass;
          bcNeoSilver: ColorScheme := csNeoSilver;
          bcNeoRose:   ColorScheme := csNeoRose;
          bcNeoSun:    ColorScheme := csNeoSun;
          bcDesert:    ColorScheme := csDesert;
          bcGrass:     ColorScheme := csGrass;
          bcSky:       ColorScheme := csSky;
          bcSun:       ColorScheme := csSun;
          bcRose:      ColorScheme := csRose;
          bcSilver:    ColorScheme := csSilver;
         end;
         Caption := Query.FieldByName('Caption').AsString;
         Font.Name := Query.FieldByName('FontName').AsString;
         Font.Size := Query.FieldByName('FontSize').AsInteger;
         Font.Color := clBlack;
         Font.Style := [];
         if Query.FieldByName('FontBold').AsBoolean then Font.Style := Font.Style + [fsBold];
         if Query.FieldByName('FontItalic').AsBoolean then Font.Style := Font.Style + [fsItalic];
         if Query.FieldByName('FontUnderline').AsBoolean then Font.Style := Font.Style + [fsUnderline];
         if Query.FieldByName('FontStrikeout').AsBoolean then Font.Style := Font.Style + [fsStrikeout];
         case Query.FieldByName('ButtonSize').AsInteger of
          sButtonNormalSize: begin Height := ButtonHeight; Width := ButtonWidth; end;
          sButtonDoubleWidth: begin Height := ButtonHeight; Width := ButtonWidth * 2 + 1; end;
          sButtonDoubleHeight: begin Height := ButtonHeight * 2 + 1; Width := ButtonWidth end;
          sButtonDoubleWidthDoubleHeight: begin Height := ButtonHeight * 2 + 1; Width := ButtonWidth * 2 + 1 end;
         end;
         Visible := True;
         case Query.FieldByName('Event').AsInteger of
          teQtyButtonClick: OnClick := QtyButtonClick;
          tePriceButtonClick: OnClick := PriceButtonClick;
          teDiscountButtonClick: OnClick := DiscountButtonClick;
          teVoidItemButtonClick: OnClick := VoidItemButtonClick;
          teInsertItemButtonClick: OnClick := InsertItemButtonClick;
          teDirectPaymentButtonClick: OnClick := DirectPaymentButtonClick1;
          teBalanceButtonClick: OnClick := BalanceButtonClick;
          teWeightButtonClick: OnClick := WeightButtonClick;
          //teViewIngredientsButtonClick: OnClick := ViewIngredientsButtonClick;
          teSpellInstructionButtonClick: OnClick := SpellInstructionButtonClick;
          teInstructionButtonClick: OnClick := InstructionButtonClick;
          //teMealPackageButtonClick: OnClick := MealPackageButtonClick;
          teAccountPaymentButtonClick: OnClick := AccountPaymentButtonClick;
          teSurchargeButtonClick: OnClick := SurchargeButtonClick;
          teOtherChargeButtonClick: OnClick := OtherChargeButtonClick;
          teRedeemPointButtonClick: OnClick := RedeemPointButtonClick;
          teOrderDueTimeButtonClick: OnClick := OrderDueTimeButtonClick;
          teSeatNumberButtonClick: OnClick := SeatNumberButtonClick;
          teDirectPrintBillButtonClick: OnClick := DirectPrintBillButtonClick;
          teQuitButtonClick: OnClick := QuitButtonClick;
          teChangeMenuButtonClick: OnClick := ChangeMenuButtonClick;
          teVoidAllItemButtonClick: OnClick := VoidAllItemButtonClick;
          teChangeUserIDButtonClick: OnClick := ChangeUserIDButtonClick;
          //teReservationButtonClick: OnClick := ReservationButtonClick;
          teVIPListButtonClick: OnClick := VIPListButtonClick;
          teCustomerNameButtonClick: OnClick := CustomerNameButtonClick;
          teChangeMenuGroupButtonClick: OnClick := ChangeMenuGroupButtonClick;
         end;
         BringToFront;
        end;
       Query.Next;
      end;
     Query.Close;
    end;
end;

procedure TTableOrderForm.InitFixedButtons;
var
 SQLStr, ButtonName: string;
begin
 SQLStr := 'Select * From ButtonsTable Where CanRelocate = 0 and ' +
           'Kind=' + IntToStr(sTableOrderEditButton) +
           ' Order By ButtonName';
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0) then
    begin
     Query.First;
     while Not Query.EOF do
      begin
       ButtonName := Query.FieldByName('ButtonName').AsString;
       with TXiButton(FindComponent(ButtonName)) do
        begin
         case Query.FieldByName('ButtonColor').AsInteger of
          bcNeoDesert: ColorScheme := csNeoDesert;
          bcNeoSky:    ColorScheme := csNeoSky;
          bcNeoGrass:  ColorScheme := csNeoGrass;
          bcNeoSilver: ColorScheme := csNeoSilver;
          bcNeoRose:   ColorScheme := csNeoRose;
          bcNeoSun:    ColorScheme := csNeoSun;
          bcDesert:    ColorScheme := csDesert;
          bcGrass:     ColorScheme := csGrass;
          bcSky:       ColorScheme := csSky;
          bcSun:       ColorScheme := csSun;
          bcRose:      ColorScheme := csRose;
          bcSilver:    ColorScheme := csSilver;
         end;
         Caption := Query.FieldByName('Caption').AsString;
         Font.Name := Query.FieldByName('FontName').AsString;
         Font.Size := Query.FieldByName('FontSize').AsInteger;
         Font.Color := clBlack;
         Font.Style := [];
         if Query.FieldByName('FontBold').AsBoolean then Font.Style := Font.Style + [fsBold];
         if Query.FieldByName('FontItalic').AsBoolean then Font.Style := Font.Style + [fsItalic];
         if Query.FieldByName('FontUnderline').AsBoolean then Font.Style := Font.Style + [fsUnderline];
         if Query.FieldByName('FontStrikeout').AsBoolean then Font.Style := Font.Style + [fsStrikeout];
         BringToFront;
        end;
       Query.Next;
      end;
     Query.Close;
    end;
end;

procedure TTableOrderForm.SetTotalPanelLabelPosition;
var
 TotalLabels, SpaceLength, LabelPosition: integer;
begin
 TotalLabels := 4;
 if LoyaltyAwardAvailible then Inc(TotalLabels);
 if AutoSurcharge then Inc(TotalLabels);
 if OtherChargeEnable then Inc(TotalLabels);
 SpaceLength := (SummaryPanel.Height - TotalLabels * 17 - 4) div (TotalLabels + 1);
 if SpaceLength = 0 then
    LabelPosition := SpaceLength + 4
   else
    LabelPosition := SpaceLength + 3;
 AmountLabel.Top := LabelPosition + 4;
 AmountEdit.Top := LabelPosition;
 LabelPosition := LabelPosition + SpaceLength + 17;
 DiscountTitleLabel.Top := LabelPosition + 4;
 DiscountEdit.Top := LabelPosition;
 LabelPosition := LabelPosition + SpaceLength + 17;
 if LoyaltyAwardAvailible then
    begin
     RewardPointsLabel.Top := LabelPosition + 4;
     RewardPointsDiscountEdit.Top := LabelPosition;
     LabelPosition := LabelPosition + SpaceLength + 17;
    end
   else
    begin
     RewardPointsLabel.Visible := False;
     RewardPointsDiscountEdit.Visible := False;
    end;
 if AutoSurcharge then
    begin
     ServiceChargeLabel.Top := LabelPosition + 4;
     ServiceChargeEdit.Top := LabelPosition;
     LabelPosition := LabelPosition + SpaceLength + 17;
    end
   else
    begin
     ServiceChargeLabel.Visible := False;
     ServiceChargeEdit.Visible := False;
    end;
 if OtherChargeEnable then
    begin
     OtherChargeLabel.Top := LabelPosition + 4;
     OtherChargeEdit.Top := LabelPosition;
     LabelPosition := LabelPosition + SpaceLength + 17;
    end
   else
    begin
     OtherChargeLabel.Visible := False;
     OtherChargeEdit.Visible := False;
    end;
 TotalLabel.Top := LabelPosition + 2;
 TotalEdit.Top := LabelPosition;
 LabelPosition := LabelPosition + SpaceLength + 17;
 GSTLabel.Top := LabelPosition + 4;
 GSTEdit.Top := LabelPosition;
end;

procedure TTableOrderForm.PostDataToSecondDisplayPro;
var
 I: integer;
begin
 SecondDisplayForm.InitForm;
 for I := 1 to 500 do
  begin
   if (StringGrid.Cells[1, I] <> '') then
      begin
       SecondDisplayForm.StringGrid.Cells[0, I] := SecondScreenDescription[I];
       SecondDisplayForm.StringGrid.Cells[1, I] := StringGrid.Cells[2, I];
       SecondDisplayForm.StringGrid.Cells[2, I] := StringGrid.Cells[3, I];
       SecondDisplayForm.StringGrid.Cells[3, I] := StringGrid.Cells[4, I];
      end;
  end;
end;

procedure TTableOrderForm.InitMenuPanel;
var
 I: integer;
 ButtonName: string;
begin
 for I := 1 to 38 do
  begin
   ButtonName := 'Menu' + IntToStr(I);
   with TPanel(FindComponent(ButtonName)) do
    Visible := I <= MenuCount;
  end;
 //MenuPanel.Top := 3;
 //MenuPanel.Left := 568;
// MenuPanel.Height := MainMenuLine * 57 + 9;
 //PageUpButton.Top := (MainMenuLine - 1) * 57 + 6;
 //PageDownButton.Top := PageUpButton.Top;
end;

procedure TTableOrderForm.InitCategoryPanel;
var
 I: integer;
 ButtonName: string;
begin
 for I := 1 to 8do
  begin
   ButtonName := 'Category' + IntToStr(I);
   with TPanel(FindComponent(ButtonName)) do
    Visible := I <= CategoryCount;
  end;
 //CategoryPanel.Top := MenuPanel.Height + 5;
 //CategoryPanel.Left := 568;
 //CategoryPanel.Height := MainCategoryLine * 57 + 9;
 //CategoryPageUpButton.Top := (MainCategoryLine - 1) * 57 + 6;
// CategoryPageDownButton.Top := CategoryPageUpButton.Top;
end;

procedure TTableOrderForm.OpenCategoryQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with CategoryQuery do
  begin
   Active := False;
   Connection := Dataform.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
   CategoryRowCount := RecordCount;
   CategoryCurrentPage := 1;
  end;
end;

procedure TTableOrderForm.OpenMenuQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with MenuQuery do
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
   MenuCurrentPage := 1;
   if RecordCount > 0 then
      begin
       Last;
       LastMenuPosition := FieldByName('MainPosition').AsInteger;
      end
     else
      LastMenuPosition := 0;
  end;
end;

procedure TTableOrderForm.OpenCategory;
var
 SQLStr: string;
begin
 SQLStr := 'Select Code, Category, ButtonColor, FontName, FontColor, FontSize, ' +
           'FontBold, FontItalic, FontUnderline, FontStrikeout, Category1, ' +
           'ButtonColor1, FontName1, FontColor1, FontSize1, FontBold1, FontItalic1, ' +
           'FontUnderline1, FontStrikeout1 ' +
           'From Category ' +
           'Where ShowOnMainMenu <> 0 and MenuGroupCode=' + Chr(39) + CheckQuotes(MenuGroupCode) + Chr(39) +
           ' Order By Code';
 OpenCategoryQuery(SQLStr);
end;

procedure TTableOrderForm.OpenMenu(Category: string);
var
 SQLStr: string;
begin
 SQLStr := 'Select MenuItem.ItemCode, Description1, Description2, ButtonColor, FontName, ' +
           'FontColor, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'ButtonColor1, FontName1, FontColor1, FontSize1, FontBold1, FontItalic1, ' +
           'FontUnderline1, FontStrikeout1, SubCategory, MainPosition ' +
           'From MenuItem Left Join ' +
           '(Select ItemCode, SubCategory From SubMenuLinkHead) As SubMenuTable ' +
           'On MenuItem.ItemCode=SubMenuTable.ItemCode ' +
           'Where (Active <> 0) and (OnlyShowOnSubMenu = 0) and ' +
           'Category=' + Chr(39) + CheckQuotes(Category) + Chr(39) +
           ' Order By MainPosition';
 OpenMenuQuery(SQLStr);
end;

procedure TTableOrderForm.AssignMenuKeyBoard;
var
 I, MenuPosition: integer;
 ButtonName: string;
begin
 for I := 1 to MenuCount do
  begin
   ButtonName := 'Menu' + IntToStr(I);
   MenuPosition := (MenuCurrentPage - 1) * MenuCount + I;
   MenuQuery.Locate('MainPosition', IntToStr(MenuPosition), [loPartialKey]);
   with TPanelButton(FindComponent(ButtonName)) do
    if MenuQuery.FieldByName('MainPosition').AsInteger = MenuPosition then
       begin
        if Langurage or (MenuQuery.FieldByName('Description2').AsString = '') then
           begin
            Caption := CopyDescription(MenuQuery.FieldByName('Description1').AsString);
            Color := MenuQuery.FieldByName('ButtonColor').AsInteger;
            Font.Size := MenuQuery.FieldByName('FontSize').AsInteger;;
            Font.Name := MenuQuery.FieldByName('FontName').AsString;
            Font.Color := MenuQuery.FieldByName('FontColor').AsInteger;
            Font.Style := [];
            if MenuQuery.FieldByName('FontBold').AsBoolean then
               Font.Style := Font.Style + [fsBold];
            if MenuQuery.FieldByName('FontItalic').AsBoolean then
               Font.Style := Font.Style + [fsItalic];
            if MenuQuery.FieldByName('FontUnderline').AsBoolean then
               Font.Style := Font.Style + [fsUnderline];
            if MenuQuery.FieldByName('FontStrikeout').AsBoolean then
               Font.Style := Font.Style + [fsStrikeout];
           end
          else
           begin
            Caption := CopyDescription(MenuQuery.FieldByName('Description2').AsString);
            Color := MenuQuery.FieldByName('ButtonColor1').AsInteger;
            Font.Size := MenuQuery.FieldByName('FontSize1').AsInteger;;
            Font.Name := MenuQuery.FieldByName('FontName1').AsString;
            Font.Color := MenuQuery.FieldByName('FontColor1').AsInteger;
            Font.Style := [];
            if MenuQuery.FieldByName('FontBold1').AsBoolean then
               Font.Style := Font.Style + [fsBold];
            if MenuQuery.FieldByName('FontItalic1').AsBoolean then
               Font.Style := Font.Style + [fsItalic];
            if MenuQuery.FieldByName('FontUnderline1').AsBoolean then
               Font.Style := Font.Style + [fsUnderline];
            if MenuQuery.FieldByName('FontStrikeout1').AsBoolean then
               Font.Style := Font.Style + [fsStrikeout];
           end;
       end
      else
       begin
        Caption := '';
        Color := $00D9D9D9;
       end;
  end;
end;

procedure TTableOrderForm.AssignCategoryKeyBoard;
var
 I: integer;
 ButtonName: string;
begin
 CategoryQuery.First;
 CategoryQuery.MoveBy((CategoryCurrentPage - 1) * CategoryCount);
 for I := 1 to CategoryCount do
  begin
   ButtonName := 'Category' + IntToStr(I);
   with TPanelButton(FindComponent(ButtonName)) do
    if Not CategoryQuery.EOF then
       begin
        if Langurage or (CategoryQuery.FieldByName('Category1').AsString = '') then
           begin
            Caption := CopyDescription(CategoryQuery.FieldByName('Category').AsString);
            Color := CategoryQuery.FieldByName('ButtonColor').AsInteger;
            Font.Size := CategoryQuery.FieldByName('FontSize').AsInteger;;
            Font.Name := CategoryQuery.FieldByName('FontName').AsString;
            Font.Color := CategoryQuery.FieldByName('FontColor').AsInteger;
            Font.Style := [];
            if CategoryQuery.FieldByName('FontBold').AsBoolean then
               Font.Style := Font.Style + [fsBold];
            if CategoryQuery.FieldByName('FontItalic').AsBoolean then
               Font.Style := Font.Style + [fsItalic];
            if CategoryQuery.FieldByName('FontUnderline').AsBoolean then
               Font.Style := Font.Style + [fsUnderline];
            if CategoryQuery.FieldByName('FontStrikeout').AsBoolean then
               Font.Style := Font.Style + [fsStrikeout];
           end
          else
           begin
            Caption := CopyDescription(CategoryQuery.FieldByName('Category1').AsString);
            Color := CategoryQuery.FieldByName('ButtonColor1').AsInteger;
            Font.Size := CategoryQuery.FieldByName('FontSize1').AsInteger;;
            Font.Name := CategoryQuery.FieldByName('FontName1').AsString;
            Font.Color := CategoryQuery.FieldByName('FontColor1').AsInteger;
            Font.Style := [];
            if CategoryQuery.FieldByName('FontBold1').AsBoolean then
               Font.Style := Font.Style + [fsBold];
            if CategoryQuery.FieldByName('FontItalic1').AsBoolean then
               Font.Style := Font.Style + [fsItalic];
            if CategoryQuery.FieldByName('FontUnderline1').AsBoolean then
               Font.Style := Font.Style + [fsUnderline];
            if CategoryQuery.FieldByName('FontStrikeout1').AsBoolean then
               Font.Style := Font.Style + [fsStrikeout];
           end;
        CategoryQuery.Next;
       end
      else
       begin
        Caption := '';
        Color := $00D9D9D9;
        Visible := True;
       end;
  end;
end;

procedure TTableOrderForm.ProcessCategoryButtonTouch(Position: integer);
var
 Category: string;
begin
 CategoryQuery.First;
 CategoryQuery.MoveBy((CategoryCurrentPage - 1) * CategoryCount + Position - 1);
 Category := CategoryQuery.FieldByName('Category').AsString;
 OpenMenu(Category);
 AssignMenuKeyBoard;
 if TitlePanel.Enabled then StringGrid.SetFocus;
end;

procedure TTableOrderForm.ProcessInstruction(Buff: InstructionBuffType);
var
 I, K, FirstRow, EndRow, CurRow: integer;
begin
 CurRow := CurrentRow;
 I := CurRow + 1;
 FirstRow := I;
 for K := 1 to 50 do
  if (Buff.Code[K] <> '') and (I <= 500) then
     begin
      InsertLine(I);
      StringGrid.Cells[1, I] := Buff.Description1[K];
      StringGrid.Cells[2, I] := Format('%4.2f', [Buff.Qty[K]]);
      StringGrid.Cells[3, I] := Format('%4.2f', [Buff.Price[K]]);
      StringGrid.Cells[8, I] := Buff.Code[K];
      Instruction[I] := Buff.Condition[K];
      DiscountFlag[I] := Buff.Discount[K];
      OriginalPrice[I] := Buff.Price[K];
      if (DiscountFlag[I] or (ForceVIPDiscount and (sVIPNo > 0)))
         and (DiscountRate >= 0.01) then
         StringGrid.Cells[5, I] := Format('%4.2f', [DiscountRate])
        else
         StringGrid.Cells[5, I] := '';
      StringGrid.Cells[7, I] := Format('%4.2f', [Buff.TaxRate[K]]);
      SecondScreenDescription[I] := Buff.Description2[K];
      SetDescription(I);
      I := I + 1;
     end;
 EndRow := I;
 ConvertLangurage(FirstRow, EndRow);
end;

procedure TTableOrderForm.ProcessMenuButtonTouch(Position: integer);
var
 ItemCode, MainItemDescription1, MainItemDescription2: string;
 Buff: InstructionBuffType;
 MenuPosition: integer;
 SubMenuForm: TSubMenuForm;
 DirectLinkSubMenu: boolean;
 NumberOfChoice: Integer;
begin
 Number :='';
 Change := 0;
 change1 :=0;
 MenuPosition := (MenuCurrentPage - 1) * MenuCount + Position;
 MenuQuery.Locate('MainPosition', IntToStr(MenuPosition), [loPartialKey]);
 ItemCode := MenuQuery.FieldByName('ItemCode').AsString;
 if Not MenuQuery.FieldByName('SubCategory').AsBoolean then
    begin
     if StringGrid.Cells[1, CurrentRow] <> '' then
        CurrentRow := FindLastRow;
     if (CurrentRow <= 500) and (StringGrid.Cells[8, CurrentRow] = '') then
        begin
         StringGrid.Row := CurrentRow;
         CurrentCol := 1;
         StringGrid.Col := 1;
         StringGrid.Cells[8, CurrentRow] := ItemCode;
         if DataForm.CheckInstructionLink(ItemCode) and
            InstructionListForm.InstructionPro(ItemCode, Langurage, Buff) then
            ProcessInstruction(Buff);
         if StringGrid.Enabled then StringGrid.SetFocus;
         Changed := True;
         if CheckCells(CurrentCol, CurrentRow) then
            MoveToNextCell;
        end;
    end;
 if DataForm.CheckSubMenuLink(ItemCode, MainItemDescription1, MainItemDescription2, NumberOfChoice, DirectLinkSubMenu) then
    begin
     Application.CreateForm(TSubMenuForm, SubMenuForm);
     SubMenuForm.MainItemCode := ItemCode;
     SubMenuForm.MainItemDescription1 := MainItemDescription1;
     SubMenuForm.MainItemDescription2 := MainItemDescription2;
     SubMenuForm.Langurage := Langurage;
     SubMenuForm.NumberOfChoice := NumberOfChoice;
     SubMenuForm.OwnerNumber := sTableOrder;
     if DirectLinkSubMenu then
        SubMenuForm.ProcessDirectLinkSubMenu
       else
        SubMenuForm.ShowModal;
     SubMenuForm.Free;
    end;
end;

procedure TTableOrderForm.InitCells(ARow: integer);
begin
 with StringGrid do
  begin
   Cells[1, ARow] := '';
   Cells[2, ARow] := '';
   Cells[3, ARow] := '';
   Cells[4, ARow] := '';
   Cells[5, ARow] := '';
   Cells[6, ARow] := '';
   Cells[7, ARow] := '';
   Cells[8, ARow] := '';
  end;
 EditFlag[ARow] := True;
 VoidFlag[ARow] := False;
 OrderInstruction[ARow] := False;
 OpenPrice[ARow] := True;
 Instruction[ARow] := 0;
 DiscountFlag[ARow] := False;
 PriceSelect[ARow] := 0;
 PaidQty[ARow] := 0;
 PrintFlag[ARow] := False;
 CheckListPrinted[ARow] := False;
 SentToKitchen[ARow] := False;
 VoidReason[ARow] := '';
 OrderOperator[ARow] := '';
 OriginalPrice[ARow] := 0;
 SecondScreenDescription[ARow] := '';
end;

procedure TTableOrderForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   Cells[0, 0] := 'No.';
   Cells[1, 0] := 'Description';
   Cells[2, 0] := 'Qty';
   Cells[3, 0] := 'Price';
   Cells[4, 0] := 'Amount';
   Cells[5, 0] := 'Dis(%)';
   Cells[6, 0] := 'Seat';
   Cells[7, 0] := 'GST%';
   Cells[8, 0] := 'Code';
   for I := 1 to 500 do
    begin
     Cells[0, I] := IntToStr(I);
     InitCells(I);
    end;
   Row := 1; Col := 1; TopRow := 1; LeftCol := 1;
   CurrentRow := 1; CurrentCol := 1;
  end;
end;

procedure TTableOrderForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   if (ARow > 0) and (ACol > 0) then
      begin
       Canvas.Font.Size := 10;
       Canvas.Font.Style := [];
       case ACol of
        1:    begin
               SetTextAlign(Canvas.Handle, TA_LEFT);
               if Instruction[ARow] >= 1 then
                  X := Rect.Left + 12
                 else
                  X := Rect.Left + 2;
               if VoidFlag[ARow] then
                  Canvas.Font.Color := clGray
                 else
                  if OrderInstruction[ARow] then
                     Canvas.Font.Color := clRed
                    else
                     if Instruction[ARow] >= 1 then
                        Canvas.Font.Color := clBlue
                       else
                        Canvas.Font.Color := clBlack;
              end;
        6, 8: begin
               if VoidFlag[ARow] then Canvas.Font.Color := clGray;
               SetTextAlign(Canvas.Handle, TA_CENTER);
               X := (Rect.Left + Rect.Right) div 2;
              end;
        else
         begin
          if VoidFlag[ARow] then Canvas.Font.Color := clGray;
          SetTextAlign(Canvas.Handle, TA_RIGHT);
          X := Rect.Right - 2;
         end;
       end;
      if EditFlag[ARow] then
         Canvas.Brush.Color := clWhite
        else
         Canvas.Brush.Color := $00D9FFD9;
       Canvas.FillRect(Rect);
      end
     else
      begin
       Canvas.Font.Size := 8;
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
  Canvas.TextRect(Rect, X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TTableOrderForm.InitForm;
begin
 DataForm.SendToPoleDisp('NEXT CUSTOMER PLEASE', '');
 if FVar.SecondDisplay = 1 then SecondDisplayForm.SetWaitingStatus;
 PaidAmount := 0;
 Tips := 0;
 Surcharge := 0;
 DiscountKind := 0;
 DollarDiscount := 0;
 DiscountRate := 0;
 CurrentServiceChargeRate := 0;
 CurrentOtherChargeRate := 0;
 DueTime := 0;
 PreAmount := 0;
 PreItemCount := 0;
 DeliveryFlag := False;
 OrderDateEdit.Caption := '';
 OrderNoEdit.Caption := '';
 TableNoEdit.Caption := '';
 OriginalTableNo := '';
 PersonEdit.Caption := '';
 ServiceEdit.Caption := '';
 VIPNameEdit.Caption := '';
 BookingNoEdit.Caption := '';
 PresetDiscountCode := '';
 CategoryPanel.Visible := True;
 MenuPanel.Visible := True;
 CurrentPriceIncludesGST := PriceIncludesGST;
 CurrentSplitBillStatus := True;
 CurrentGSTRate := DefaultGSTRate;
 RewardPointsDiscount := 0;
 sVIPNo := 0;
 DiscountOperator := '';
 DiscountTitleLabel.Caption := 'DISCOUNT (' + Format('%4.2f', [DiscountRate]) + '%)';
 ServiceChargeLabel.Caption := Uppercase(SurchargeName) + ' (' + Format('%4.2f', [CurrentServiceChargeRate]) + '%)';
 OtherChargeLabel.Caption := Uppercase(OtherChargeName) + ' (' + Format('%4.2f', [CurrentOtherChargeRate]) + '%)';
 InitStringGrid;
end;

procedure TTableOrderForm.FormKeyPress(Sender: TObject; var Key: Char);
var
 CurRow: integer;
begin
 AutoLogoutTimeCounter := 0;
 if Not StringGrid.Enabled then
    Key := Chr(0)
   else
    if Key In ['0'..'9', 'a'..'z', 'A'..'Z'] then
       KeyBuff := KeyBuff + Key
      else
       if Key = Chr(13) then
          begin
           if KeyBuff <> '' then
              with StringGrid do
               begin
                CurRow := FindLastRow;
                if ((Copy(KeyBuff, 1, 2) = '02') and (Length(KeyBuff) = 13)) or
                   ((Copy(KeyBuff, 1, 1) = '2') and (Length(KeyBuff) = 12)) then
                   begin
                    if Length(KeyBuff) = 13 then
                       begin
                        if ScaleBarcode = 0 then
                           begin
                            Cells[8, CurRow] := Copy(KeyBuff, 3, 5);
                            Cells[2, CurRow] := Format('%4.2f', [StrToFloat(Copy(KeyBuff, 8, 5)) / 1000]);
                           end
                          else
                           begin
                            Cells[8, CurRow] := Copy(KeyBuff, 3, 5);
                            Cells[2, CurRow] := '1.00';
                            Cells[3, CurRow] := Format('%4.2f', [StrToFloat(Copy(KeyBuff, 9, 4)) / 100]);
                            OriginalPrice[CurRow] := StrToFloat(Copy(KeyBuff, 9, 4)) / 100;
                           end
                       end
                      else
                       begin
                        if ScaleBarcode = 0 then
                           begin
                            Cells[8, CurRow] := Copy(KeyBuff, 2, 5);
                            Cells[2, CurRow] := FloatToStr(StrToFloat(Copy(KeyBuff, 7, 5)) / 1000);
                           end
                          else
                           begin
                            Cells[8, CurRow] := Copy(KeyBuff, 2, 5);
                            Cells[2, CurRow] := '1.00';
                            Cells[3, CurRow] := Format('%4.2f', [StrToFloat(Copy(KeyBuff, 8, 4)) / 100]);
                            OriginalPrice[CurRow] := StrToFloat(Copy(KeyBuff, 8, 4)) / 100;
                           end
                       end
                   end
                  else
                   begin
                    Cells[8, CurRow] := KeyBuff;
                    Cells[2, CurRow] := '';
                   end;
                KeyBuff := '';
                Changed := True;
                if CheckCells(1, CurRow) then
                   begin
                    Row := FindLastRow;
                    CurrentRow := Row;
                    LeftCol := 1;
                   end
                  else
                   Cells[8, CurRow] := '';
               end;
          end
           else Key := Chr(0);
end;

procedure TTableOrderForm.QuitButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 if MessageBoxForm.MessagePro('Are you sure you want to quit this operation?', sConfirmMsg) = mrYes then
    begin
     Flag := True;
     if TableLockFunctionEnabled then
        begin
         if OriginalTableNo <> '' then Flag := DataForm.ReleaseTable(OriginalTableNo);
         if Flag and (TableNoEdit.Caption <> '') and (TableNoEdit.Caption <> OriginalTableNo) then
            Flag := DataForm.ReleaseTable(TableNoEdit.Caption);
        end;
     if Flag then
        begin
         SendToSecurityPortPro('[Cancel] Button Clicked', '', '', 0, 0, 0, 0);
         OpenCategory;
         AssignCategoryKeyBoard;
         ProcessCategoryButtonTouch(1);
         AssignMenuKeyBoard;
         InitForm;
         ActiveFlag := False;
         //SetButtonStatus;
         BackPanel.SetFocus;
        end
    end
   else
    StringGrid.SetFocus;
    ExitButtonClick(Sender);

end;

function TTableOrderForm.OpenQuery(SQLStr: string): boolean;
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
   if RecordCount = 0 then
      Result := False
     else
      Result := True;
  end;

end;

procedure TTableOrderForm.MoveToNextCell;
begin
 with StringGrid do
  begin
   Col := 1;
   Row := FindLastRow;
   CurrentRow := Row;
   CurrentCol := Col;
  end;
end;

procedure TTableOrderForm.DeleteLine(ARow: integer);
var
 I, J: Integer;
begin
 for I := ARow to 499 do
  begin
   for J := 1 to 8 do
    StringGrid.Cells[J, I] := StringGrid.Cells[J, I + 1];
   EditFlag[I] := EditFlag[I + 1];
   VoidFlag[I] := VoidFlag[I + 1];
   OrderInstruction[I] := OrderInstruction[I + 1];
   PrintFlag[I] := PrintFlag[I + 1];
   CheckListPrinted[I] := CheckListPrinted[I + 1];
   SentToKitchen[I] := SentToKitchen[I + 1];
   OpenPrice[I] := OpenPrice[I + 1];
   Instruction[I] := Instruction[I + 1];
   DiscountFlag[I] := DiscountFlag[I + 1];
   PriceSelect[I] := PriceSelect[I + 1];
   PaidQty[I] := PaidQty[I + 1];
   VoidReason[I] := VoidReason[I + 1];
   OrderOperator[I] := OrderOperator[I + 1];
   OriginalPrice[I] := OriginalPrice[I + 1];
   SecondScreenDescription[I] := SecondScreenDescription[I + 1];
  end;
 InitCells(500);
end;

procedure TTableOrderForm.StringGridClick(Sender: TObject);
begin
 AutoLogoutTimeCounter := 0;
 if (StringGrid.Row = CurrentRow) and (StringGrid.Col = CurrentCol) then
    Exit;
 if CheckCells(CurrentCol, CurrentRow) then
    begin
     CurrentCol := StringGrid.Col;
     CurrentRow := StringGrid.Row;
    end
   else
    begin
     StringGrid.Col := CurrentCol;
     StringGrid.Row := CurrentRow;
    end;
 CalcAmount;
end;

procedure TTableOrderForm.StringGridDblClick(Sender: TObject);
var
 I, LastRow, CurRow: integer;
begin
 CurRow := StringGrid.Row;
 if Not VoidFlag[CurRow] and Not OrderInstruction[CurRow] and (Instruction[CurRow] = 0) and
   (StringGrid.Cells[8, CurRow] <> '----') and (StringGrid.Cells[8, CurRow] <> '') and
    (MessageBoxForm.MessagePro('Are you sure you want to re-order this item?', sConfirmMsg) = mrYes) then
    begin
     LastRow := FindLastRow;
     for I := 1 to 8 do StringGrid.Cells[I, LastRow] := StringGrid.Cells[I, CurRow];
     EditFlag[LastRow] := True;
     VoidFlag[LastRow] := False;
     OrderInstruction[LastRow] := False;
     OrderOperator[LastRow] := sUserName;
     PrintFlag[LastRow] := False;
     CheckListPrinted[LastRow] := False;
     SentToKitchen[LastRow] := False;
     OpenPrice[LastRow] := OpenPrice[CurRow];
     DiscountFlag[LastRow] := DiscountFlag[CurRow];
     PriceSelect[LastRow] := PriceSelect[CurRow];
     OriginalPrice[LastRow] := OriginalPrice[CurRow];
     PaidQty[LastRow] := 0;
     SecondScreenDescription[LastRow] := SecondScreenDescription[CurRow];
     StringGrid.Row := FindLastRow;
     CalcAmount;
    end;
end;

function TTableOrderForm.FindLastRow: integer;
var
 I, J, K: integer;
begin
 J := 1;
 for I := 1 to 500 do
  begin
   if (StringGrid.Cells[1, I] <> '') then
      begin
       if (J <> I) then
          begin
           for K := 1 to 8 do StringGrid.Cells[K, J] := StringGrid.Cells[K, I];
           EditFlag[J] := EditFlag[I];
           VoidFlag[J] := VoidFlag[I];
           OrderInstruction[J] := OrderInstruction[I];
           PrintFlag[J] := PrintFlag[I];
           CheckListPrinted[J] := CheckListPrinted[I];
           SentToKitchen[J] := SentToKitchen[I];
           OpenPrice[J] := OpenPrice[I];
           Instruction[J] := Instruction[I];
           DiscountFlag[J] := DiscountFlag[I];
           PriceSelect[J] := PriceSelect[I];
           PaidQty[J] := PaidQty[I];
           VoidReason[J] := VoidReason[I];
           OrderOperator[J] := OrderOperator[I];
           OriginalPrice[J] := OriginalPrice[I];
           SecondScreenDescription[J] := SecondScreenDescription[I];
           InitCells(I);
          end;
       J := J + 1;
      end;
  end;
 if J <= 500 then
    Result := J
   else
    Result := 500;
end;

{procedure TTableOrderForm.CopyMealPackage;
var
 I: integer;
 SQLStr, FieldName: string;
 Qty: double;
begin
 if Not PackageSetup.SetupMealPackagePro(Qty, False) then Exit;
 SQLStr := 'Select MealPackage.ItemCode, Description1, Description2, ' +
           'MealPackage.Qty, MealPackage.Price, TaxRate, AllowDiscount, ' +
           'MealPackage.Condition, Multiple, PriceSelect, ' +
           'SubDescription, SubDescription1, SubDescription2, ' +
           'SubDescription3, OpenPrice ' +
           'From MealPackage, MenuItem ' +
           'Where MenuItem.ItemCode=MealPackage.ItemCode and ' +
           'MealPackage.IDNo>=20 Order By ID';
 Screen.Cursor := crHourGlass;
 if OpenQuery(SQLStr) then
    with Query do
     begin
      First; I := FindLastRow;
      while Not EOF and (I <= 500) do
        begin
         Instruction[I] := FieldByName('Condition').AsInteger;
         DiscountFlag[I] := FieldByName('AllowDiscount').AsBoolean;
         OpenPrice[I] := FieldByName('OpenPrice').AsBoolean;
         PriceSelect[I] := FieldByName('PriceSelect').AsInteger;
         EditFlag[I] := True;
         PrintFlag[I] := False;
         VoidFlag[I] := False;
         OrderInstruction[I] := False;
         SentToKitchen[I] := False; CheckListPrinted[I] := False;
         PaidQty[I] := 0;
         VoidReason[I] := '';
         OrderOperator[I] := sUserName;
         OriginalPrice[I] := FieldByName('Price').AsFloat;
         StringGrid.Cells[8, I] := FieldByName('ItemCode').AsString;
         if Langurage or (FieldByName('Description2').AsString = '') then
            StringGrid.Cells[1, I] := FieldByName('Description1').AsString
           else
            StringGrid.Cells[1, I] := FieldByName('Description2').AsString;
         if FieldByName('Multiple').AsBoolean then
            begin
             FieldName := GenerateSubDescriptionFieldName(PriceSelect[I]);
             if FieldByName(FieldName).AsString <> '' then
                StringGrid.Cells[1, I] :=
                 StringGrid.Cells[1, I] + ' / ' + FieldByName(FieldName).AsString;
            end;
         if (SecondDisplayDescription = 1) and (FieldByName('Description2').AsString <> '') then
            SecondScreenDescription[I] := FieldByName('Description2').AsString
           else
            SecondScreenDescription[I] := FieldByName('Description1').AsString;

         if ABS(FieldByName('Qty').AsFloat) >= 0.01 then
            StringGrid.Cells[2, I] := Format('%4.2f', [Qty * FieldByName('Qty').AsFloat]);
         if ABS(FieldByName('Price').AsFloat) >= 0.01 then
            StringGrid.Cells[3, I] := Format('%4.2f', [FieldByName('Price').AsFloat]);

         if (FieldByName('AllowDiscount').AsBoolean or
            (ForceVIPDiscount and (sVIPNo > 0))) then
            StringGrid.Cells[5, I] := Format('%4.2f', [DiscountRate]);
         StringGrid.Cells[4, I] := '';
         StringGrid.Cells[7, I] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);
         SetDescription(I);
         Next; I := I + 1;
        end;
      Close;
     end;
 CalcAmount;
end;
   }
function TTableOrderForm.CheckCells(ACol, ARow: integer): boolean;
var
 CellsStr, FieldName, NumStr: string;
 Temp, PriceFlag: integer;
 HappyHourPrice: boolean;
begin
 Result := True;
 if Not Changed then Exit;
 Changed := False;
 if HappyHourAvailable and CheckHappyHourTime then
    HappyHourPrice := True
   else
    HappyHourPrice := False;
 if ACol = 1 then
    CellsStr := StringGrid.Cells[8, ARow]
   else
    CellsStr := StringGrid.Cells[ACol, ARow];
 if (CellsStr = '') or (StringGrid.Cells[8, ARow] = '----') then
    Exit;
 if (CellsStr <> '0000') and (CellsStr <> '0001') and (CellsStr <> '0002') and
    (CellsStr <> '0003') and (CellsStr <> '0004') and (CellsStr <> '0005') and
    (CellsStr <> '0006') and (CellsStr <> '0007') and (CellsStr <> '0008') and
    (CellsStr <> '0009') and (CellsStr <> '0010') and (CellsStr <> '00011')
      then
 begin
 case ACol of
  1: begin
      if Not TestItemCode(CellsStr, PriceFlag) then
         begin
          Result := False;
          InitCells(ARow);
         end
        else
         with Query do
          begin
           StringGrid.Cells[8, ARow] := FieldByName('ItemCode').AsString;
           DiscountFlag[ARow] := FieldByName('AllowDiscount').AsBoolean;
           OpenPrice[ARow] := FieldByName('OpenPrice').AsBoolean;
           VoidReason[ARow] := '';
           OrderOperator[ARow] := sUserName;
           if Not FieldByName('Instruction').AsBoolean then
              begin
               if StringGrid.Cells[2, ARow] = '' then
                  StringGrid.Cells[2, ARow] := Format('%4.2f', [FieldByName('DefaultQty').AsFloat]);
               if StringGrid.Cells[3, ARow] = '' then
                  begin
                   if Not FieldByName('Multiple').AsBoolean then
                      begin
                       if HappyHourPrice and (ABS(FieldByName('HappyHourPrice1').AsFloat) >= 0.01) then
                          begin
                           StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName('HappyHourPrice1').AsFloat]);
                           OriginalPrice[ARow] := FieldByName('HappyHourPrice1').AsFloat;
                           DiscountFlag[ARow] := False;
                          end
                         else
                          begin
                           StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName('Price').AsFloat]);
                           OriginalPrice[ARow] := FieldByName('Price').AsFloat;
                          end;
                      end
                     else
                      begin
                       if PriceFlag = 0 then
                          PriceSelectForm.ReadPricePro(CellsStr, PriceSelect[ARow], HappyHourPrice)
                         else
                          PriceSelect[ARow] := PriceFlag - 1;
                       if PriceSelect[ARow] >= 0 then
                          begin
                           FieldName := GeneratePriceFieldName(PriceSelect[ARow], HappyHourPrice);
                           StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName(FieldName).AsFloat]);
                           OriginalPrice[ARow] := FieldByName(FieldName).AsFloat;
                          end
                        else
                         begin
                          repeat
                           DeleteLine(ARow);
                          until Instruction[ARow] = 0;
                          Exit;
                         end;
                      end;
                  end;
              end
             else
              if Instruction[ARow] = 0 then
                 begin
                  if AutoInstructionSelection then
                     Temp := InstructionForm.InstructionPro
                    else
                     Temp := 1;
                  if Temp >= 0 then Instruction[ARow] := Temp
                    else
                     begin
                      InitCells(ARow);
                      StringGrid.Col := 1; StringGrid.Row := ARow;
                      Exit;
                     end;
                  if (Temp = 2) or (Temp = 0) or Not AutoInstructionSelection then
                     begin
                      if ABS(FieldByName('DefaultQty').AsFloat) >= 0.01 then
                         StringGrid.Cells[2, ARow] := Format('%4.2f', [FieldByName('DefaultQty').AsFloat])
                        else
                         StringGrid.Cells[2, ARow] := '';
                      if Not FieldByName('Multiple').AsBoolean then
                         begin
                          if HappyHourPrice and (ABS(FieldByName('HappyHourPrice1').AsFloat) >= 0.01) then
                             begin
                              StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName('HappyHourPrice1').AsFloat]);
                              OriginalPrice[ARow] := FieldByName('HappyHourPrice1').AsFloat;
                             end
                            else
                             if ABS(FieldByName('Price').AsFloat) >= 0.01 then
                                begin
                                 StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName('Price').AsFloat]);
                                 OriginalPrice[ARow] := FieldByName('Price').AsFloat;
                                end;
                         end
                        else
                         begin
                          if PriceFlag = 0 then
                             PriceSelectForm.ReadPricePro(CellsStr, PriceSelect[ARow], HappyHourPrice)
                            else
                             PriceSelect[ARow] := PriceFlag - 1;
                          if PriceSelect[ARow] >= 0 then
                             begin
                              FieldName := GeneratePriceFieldName(PriceSelect[ARow], HappyHourPrice);
                              StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName(FieldName).AsFloat]);
                              OriginalPrice[ARow] := FieldByName(FieldName).AsFloat;
                             end
                           else
                            begin
                             repeat
                              DeleteLine(ARow);
                             until Instruction[ARow] = 0;
                             Exit;
                            end;
                         end;
                     end
                    else
                     begin
                      StringGrid.Cells[2, ARow] := '';
                      StringGrid.Cells[3, ARow] := '';
                     end;
                 end;
           if (DiscountFlag[ARow] or (ForceVIPDiscount and (sVIPNo > 0))) and (DiscountRate >= 0.01) then
              StringGrid.Cells[5, ARow] := Format('%4.2f', [DiscountRate])
             else
              StringGrid.Cells[5, ARow] := '';
           if Langurage or (FieldByName('Description2').AsString = '') then
              StringGrid.Cells[1, ARow] := FieldByName('Description1').AsString
             else
              StringGrid.Cells[1, ARow] := FieldByName('Description2').AsString;
           if (SecondDisplayDescription = 1) and (FieldByName('Description2').AsString <> '') then
              SecondScreenDescription[ARow] := FieldByName('Description2').AsString
             else
              SecondScreenDescription[ARow] := FieldByName('Description1').AsString;

           if FieldByName('Multiple').AsBoolean then
              begin
               FieldName := GenerateSubDescriptionFieldName(PriceSelect[ARow]);
               if FieldByName(FieldName).AsString <> '' then
                  begin
                   StringGrid.Cells[1, ARow] := StringGrid.Cells[1, ARow] + ' / ' + FieldByName(FieldName).AsString;
                   SecondScreenDescription[ARow] := SecondScreenDescription[ARow] + ' / ' + FieldByName(FieldName).AsString;
                  end;
              end;
           StringGrid.Cells[7, ARow] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);
           SetDescription(ARow);
           if AutoPriceWindow and OpenPrice[ARow] and (Instruction[ARow] = 0) and
              ((StringGrid.Cells[3, ARow] = '') or (StrToFloat(StringGrid.Cells[3, ARow]) = 0)) then
              begin
               NumStr := '0';
               if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Price', 0) then
                  StringGrid.Cells[3, ARow] := Format('%4.2f', [StrToFloat(NumStr)]);
             end;
           if FieldByName('AutoPopSpellInstructionKeyboard').AsBoolean then
              SpellInstructionButtonClick(Self);
          end;
      Query.Close;
     end;
  2: if Not CheckNum(CellsStr, 7, 999.99, -999.99, 'F') then
        begin
         StringGrid.Cells[ACol, ARow] := '';
         Result := False
        end
       else
        StringGrid.Cells[ACol, ARow] := Format('%4.2f', [StrToFloat(CellsStr)]);
  3: if Not CheckNum(CellsStr, 10, 9999999.99, 0, 'F') then
        begin
         StringGrid.Cells[ACol, ARow] := '';
         Result := False
        end
       else
        StringGrid.Cells[ACol, ARow] := Format('%4.2f', [Abs(StrToFloat(CellsStr))]);
 end;
 end;
 //UpdatePoleMessage;
end;

procedure TTableOrderForm.CalcAmount;
var
 I: integer;
 Qty, Price, RealPrice, TaxRate, DiscRate, Amount, GST, Discount,
 TotalAmount, TotalGST, TotalDiscount, TotalServiceCharge,
 TotalOtherCharge, TotalInvoice, Receivable: double;
 LabelPosition1, LabelPosition2: integer;
begin
 if CurrentPriceIncludesGST then
    begin
     if TotalEdit.Top > GSTEdit.Top then
        begin
         LabelPosition1 := TotalEdit.Top;
         LabelPosition2 := GSTEdit.Top;
         TotalLabel.Top := LabelPosition2 + 2;
         TotalEdit.Top := LabelPosition2;
         GSTLabel.Top := LabelPosition1 + 4;
         GSTEdit.Top := LabelPosition1;
        end;
    end
   else
    begin
     if TotalEdit.Top < GSTEdit.Top then
        begin
         LabelPosition1 := TotalEdit.Top;
         LabelPosition2 := GSTEdit.Top;
         TotalLabel.Top := LabelPosition2;
         TotalEdit.Top := LabelPosition2;
         GSTLabel.Top := LabelPosition1 + 2;
         GSTEdit.Top := LabelPosition1;
        end;
    end;
 TotalAmount := 0; TotalGST := 0; TotalDiscount := 0;
 with StringGrid do
  for I := 1 to 500 do
   if (Cells[8, I] <> '----') and (Cells[8, I] <> '') then
      begin
       if Cells[2, I] <> '' then Qty := StrToFloat(Cells[2, I]) else Qty := 0;
       if Cells[3, I] <> '' then Price := StrToFloat(Cells[3, I]) else Price := 0;
       if ABS(Price * Qty) >= 0.01 then
          begin
           Amount := Price * Qty;
           Cells[4, I] := Format('%4.2f', [Amount]);
          end
         else
          begin
           Amount := 0;
           Cells[4, I] := '';
          end;
       if Cells[5, I] <> '' then
          DiscRate := StrToFloat(Format('%6.4f', [StrToFloat(Cells[5, I]) / 100]))
         else
          DiscRate := 0;
       if Cells[7, I] <> '' then
          TaxRate:= StrToFloat(Cells[7, I])
         else
          TaxRate := 0;
       RealPrice := Price * (1 - DiscRate);
       Discount := (Price - RealPrice) * Qty;
       if CurrentPriceIncludesGST then
          GST := (Amount - Discount) * (1 - 1 / (1 + TaxRate / 100))
         else
          GST := (Amount - Discount) * TaxRate / 100;
       TotalAmount := TotalAmount + Amount;
       TotalDiscount := TotalDiscount + Discount;
       TotalGST := TotalGST + GST;
      end;

 TotalAmount := RoundToCurrency(TotalAmount);

 if DiscountKind = 0 then
    DiscountTitleLabel.Caption := 'DISCOUNT (' + Format('%4.2f', [DiscountRate]) + '%)'
   else
    begin
     DiscountTitleLabel.Caption := 'DISCOUNT';
     if DiscountKind = 2 then
        begin
         TotalDiscount := DollarDiscount;
         if CurrentPriceIncludesGST then
            TotalGST := TotalGST - DollarDiscount * (1 - 1 / (1 + CurrentGSTRate / 100))
           else
            TotalGST := TotalGST - DollarDiscount * CurrentGSTRate / 100;
        end
    end;

 if ABS(TotalDiscount) <= 0.001 then TotalDiscount := 0;
 TotalDiscount := RoundToCurrency(TotalDiscount);

 if CurrentPriceIncludesGST then
    TotalGST := TotalGST - RewardPointsDiscount * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    TotalGST := TotalGST - RewardPointsDiscount * CurrentGSTRate / 100;

 TotalServiceCharge := (TotalAmount - TotalDiscount - RewardPointsDiscount) * CurrentServiceChargeRate / 100;
 TotalServiceCharge := RoundToCurrency(TotalServiceCharge);
 TotalOtherCharge := (TotalAmount - TotalDiscount - RewardPointsDiscount) * CurrentOtherChargeRate / 100;
 TotalOtherCharge := RoundToCurrency(TotalOtherCharge);

 if CurrentPriceIncludesGST then
    TotalGST := TotalGST + (TotalServiceCharge + TotalOtherCharge) * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    TotalGST := TotalGST + (TotalServiceCharge + TotalOtherCharge) * CurrentGSTRate / 100;

 if (TotalAmount >= 0) and (TotalGST <= 0) then TotalGST := 0;

 TotalGST := RoundToCurrency(TotalGST);

 if CurrentPriceIncludesGST then
    begin
     TotalInvoice := TotalAmount + TotalServiceCharge + TotalOtherCharge;
     Receivable := TotalAmount - TotalDiscount - RewardPointsDiscount + TotalServiceCharge + TotalOtherCharge;
    end
   else
    begin
     TotalInvoice := TotalAmount + TotalServiceCharge + TotalOtherCharge + TotalGST;
     Receivable := TotalAmount - TotalDiscount - RewardPointsDiscount + TotalServiceCharge + TotalOtherCharge + TotalGST;
    end;
 Rounding := PosReceiptForm.CalcRounding(Receivable);
 Receivable := Receivable + Rounding;
 TotalInvoice := RoundToCurrency(TotalInvoice);
 Receivable := RoundToCurrency(Receivable);

 AmountEdit.Caption := Format('%4.2f ', [TotalAmount]);
 DiscountEdit.Caption := Format('%4.2f ', [TotalDiscount]);
 RewardPointsDiscountEdit.Caption := Format('%4.2f ', [RewardPointsDiscount]);
 ServiceChargeLabel.Caption := Uppercase(SurchargeName) + ' (' + Format('%4.2f', [CurrentServiceChargeRate]) + '%)';
 ServiceChargeEdit.Caption := Format('%4.2f ', [TotalServiceCharge]);
 OtherChargeLabel.Caption := Uppercase(OtherChargeName) + ' (' + Format('%4.2f', [CurrentOtherChargeRate]) + '%)';
 OtherChargeEdit.Caption := Format('%4.2f ', [TotalOtherCharge]);
 GSTEdit.Caption := Format('%4.2f ', [TotalGST]);
 TotalEdit.Caption := Format('%4.2f ', [Receivable]);
 BalanceTotal := Receivable;
 if FVar.SecondDisplay = 1 then
    begin
     PostDataToSecondDisplayPro;
     SecondDisplayForm.GotoCurrentRow;
     SecondDisplayForm.TotalSalesEdit.Caption := FormatCurrency(TotalInvoice) + ' ';
     if ABS(TotalDiscount + RewardPointsDiscount) >= 0.01 then
        begin
         SecondDisplayForm.DiscountLabel.Visible := True;
         SecondDisplayForm.DiscountEdit.Visible := True;
         SecondDisplayForm.DiscountEdit.Caption := FormatCurrency(TotalDiscount + RewardPointsDiscount) + ' ';
        end
       else
        begin
         SecondDisplayForm.DiscountLabel.Visible := False;
         SecondDisplayForm.DiscountEdit.Visible := False;
        end;
     SecondDisplayForm.ReceivableEdit.Caption := FormatCurrency(Receivable - PaidAmount) + ' ';
    end;
end;

function TTableOrderForm.TestItemCode(ItemCode: string; var PriceFlag: integer): boolean;
var
 SQLStr: string;
begin
 PriceFlag := -1;
 SQLStr := 'Select * From MenuItem Where ItemCode=' +
           Chr(39) + CheckQuotes(UpperCase(ItemCode)) + Chr(39);
 Result := OpenQuery(SQLStr);
 if Not Result then
    begin
     SQLStr := 'Select * From MenuItem Where BarCode=' +
               Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
               ' Or BarCode1=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
               ' Or BarCode2=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
               ' Or BarCode3=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
     Result := OpenQuery(SQLStr);
    end;
 if Not Result then
    MessageBoxForm.MessagePro('Invalid item code!', sErrorMsg)
   else
    with Query do
     begin
      if Uppercase(ItemCode) = FieldByName('ItemCode').AsString then PriceFlag := 0;
      if ItemCode = FieldByName('BarCode').AsString then PriceFlag := 1;
      if ItemCode = FieldByName('BarCode1').AsString then PriceFlag := 2;
      if ItemCode = FieldByName('BarCode2').AsString then PriceFlag := 3;
      if ItemCode = FieldByName('BarCode3').AsString then PriceFlag := 4;
     end;
end;

function TTableOrderForm.OpenHeadQuery(OrderNo: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From OrderH Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 Result := OpenQuery(SQLStr);
end;

procedure TTableOrderForm.ReadHeadData;
var
 AvailableCredit, Temp: double;
 VIPName: string;
begin
 with Query do
  begin
   PaidAmount := FieldByName('PaidAmount').AsFloat;
   //AlreadyPaid.Caption := Format('%4.2m', [PaidAmount]);
   //BalanceEdit.Caption := Format('%4.2m', [StrToFloat(AmountEdit.Caption)-PaidAmount]);
   Tips := FieldByName('Tips').AsFloat;
   Surcharge := FieldByName('Surcharge').AsFloat;
   OrderDate := FieldByName('OrderDate').AsDateTime;
   DueTime := FieldByName('DueTime').AsDateTime;
   OrderDateEdit.Caption := FormatDateTime('dd/mm/yyyy', OrderDate);
   OrderNoEdit.Caption := FieldByName('OrderNo').AsString;
   TableNoEdit.Caption := DeleteSpace(FieldByName('TableNo').AsString);
   OriginalTableNo := TableNoEdit.Caption;
   CurrentPriceIncludesGST := FieldByName('PriceIncludesGST').AsBoolean;
   CurrentSplitBillStatus := FieldByName('SplitBill').AsBoolean;
   CurrentGSTRate := FieldByName('CurrentGSTRate').AsFloat;
   if FieldByName('Persons').AsInteger > 0 then
      PersonEdit.Caption := Format('%1d', [FieldByName('Persons').AsInteger]);
   ServiceEdit.Caption := FieldByName('ServicePerson').AsString;
   BookingNoEdit.Caption := FieldByName('BookingNo').AsString;
   VIPNameEdit.Caption := FieldByName('CustomerName').AsString;
   if FieldByName('VIPNo').AsInteger > 0 then
      sVIPNo := FieldByName('VIPNo').AsInteger
     else
      sVIPNo := 0;
   InvoiceNo := FieldByName('InvoiceNo').AsString;
   Credit := FieldByName('Credit').AsBoolean;
   CurrentServiceChargeRate := FieldByName('ServiceChargeRate').AsFloat;
   CurrentOtherChargeRate := FieldByName('OtherChargeRate').AsFloat;
   MachineName := FieldByName('MachineID').AsString;
   BillKind := FieldByName('BillKind').AsInteger;
   DollarDiscount := FieldByName('DollarDiscount').AsFloat;
   DiscountKind := FieldByName('DiscountKind').AsInteger;
   RewardPointsDiscount := FieldByName('RewardPoints').AsFloat;
   DeliveryFlag := FieldByName('Delivery').AsBoolean;
   PresetDiscountCode := FieldByName('PresetDiscountCode').AsString;
   DiscountOperator := FieldByName('DiscountOperator').AsString;
   if CurrentPriceIncludesGST then
      PreAmount := FieldByName('Amount').AsFloat + FieldByName('ServiceCharge').AsFloat +
                   FieldByName('Tips').AsFloat + FieldByName('Surcharge').AsFloat +
                   FieldByName('OtherCharge').AsFloat
    else
      PreAmount := FieldByName('Amount').AsFloat + FieldByName('ServiceCharge').AsFloat +
                   FieldByName('Tips').AsFloat + FieldByName('Surcharge').AsFloat +
                   FieldByName('OtherCharge').AsFloat + FieldByName('GST').AsFloat;

   Close;
  end;

  if sVIPNo > 0 then
     begin
      if DataForm.ReadVIPInformation(sVIPNo, VIPName, Temp) then
         VIPNameEdit.Caption := VIPName;
     end;
  if (FVar.SecondDisplay = 1) then
     begin
      SecondDisplayForm.AvailableCreditLabel.Visible := False;
      SecondDisplayForm.AvailableCreditEdit.Visible := False;
      if (sVIPNo > 0) then
         AvailableCredit := DataForm.GetAvailableCredit(sVIPNo)
        else
         AvailableCredit := 0;
      if AvailableCredit >= 0.01 then
         begin
          SecondDisplayForm.AvailableCreditLabel.Visible := True;
          SecondDisplayForm.AvailableCreditEdit.Visible := True;
          SecondDisplayForm.AvailableCreditEdit.Caption := Format('%4.2m', [AvailableCredit]);
         end;
     end;
end;

function TTableOrderForm.OpenItemQuery(OrderNo: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select OrderI.ItemCode, Qty, PaidQty, OrderI.Price, OriginalPrice, ' +
           'Description1, Description2, OrderI.TaxRate, OpenPrice, ' +
           'OrderI.Discount, AllowDiscount, Condition, Multiple, ' +
           'PriceSelect, SubDescription, SubDescription1, ' +
           'SubDescription2, SubDescription3, Seat, IDNo, ' +
           'PrintFlag, CheckListPrinted, SentToKitchen, ' +
           'VoidReason, SpecialOrder, VoidFlag, OrderOperator ' +
           'From OrderI, MenuItem ' +
           'Where OrderI.ItemCode = MenuItem.ItemCode and ' +
           'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           ' Union All ' +
           'Select OrderI.ItemCode, 0, 0, 0, 0, Null, Null, 0, 0, 0, ' +
           '0 As AllowDiscount, 0, CAST(0 As Bit), 0, Null, Null, Null, Null, 0, IDNo, ' +
           'PrintFlag, CheckListPrinted, SentToKitchen, VoidReason, SpecialOrder, ' +
           'CAST(0 As Bit), Null ' +
           'From OrderI ' +
           'Where OrderI.ItemCode = ' + Chr(39) + '----' + Chr(39) +
           ' and OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           ' Order By IDNo';
 Result := OpenQuery(SQLStr);
end;

procedure TTableOrderForm.ReadItemData;
var
 Loop, I, J: integer;
 FieldName: string;
begin
 Loop := 1; PreItemCount := 0;
 with Query do
  begin
   First;
   while Not EOF do
    begin
     if FieldByName('ItemCode').AsString <> '----' then
        begin
         Instruction[Loop] := FieldByName('Condition').AsInteger;
         EditFlag[Loop] := False;
         VoidFlag[Loop] := FieldByName('VoidFlag').AsBoolean;
         OrderInstruction[Loop] := False;
         PrintFlag[Loop] := FieldByName('PrintFlag').AsBoolean;
         CheckListPrinted[Loop] := FieldByName('CheckListPrinted').AsBoolean;
         SentToKitchen[Loop] := FieldByName('SentToKitchen').AsBoolean;
         OpenPrice[Loop] := FieldByName('OpenPrice').AsInteger <> 0;
         DiscountFlag[Loop] := FieldByName('AllowDiscount').AsInteger <> 0;
         PriceSelect[Loop] := FieldByName('PriceSelect').AsInteger;
         PaidQty[Loop] := FieldByName('PaidQty').AsFloat;
         StringGrid.Cells[8, Loop] := FieldByName('ItemCode').AsString;
         VoidReason[Loop] := FieldByName('VoidReason').AsString;
         OrderOperator[Loop] := FieldByName('OrderOperator').AsString;
         OriginalPrice[Loop] := FieldByName('OriginalPrice').AsFloat;
         if Langurage or (FieldByName('Description2').AsString = '') then
            StringGrid.Cells[1, Loop] := FieldByName('Description1').AsString
           else
            StringGrid.Cells[1, Loop] := FieldByName('Description2').AsString;
         if (SecondDisplayDescription = 1) and (FieldByName('Description2').AsString <> '') then
            SecondScreenDescription[Loop] := FieldByName('Description2').AsString
           else
            SecondScreenDescription[Loop] := FieldByName('Description1').AsString;
         if FieldByName('Multiple').AsBoolean then
            begin
             FieldName := GenerateSubDescriptionFieldName(PriceSelect[Loop]);
             if FieldByName(FieldName).AsString <> '' then
                StringGrid.Cells[1, Loop] :=
                 StringGrid.Cells[1, Loop] + ' / ' + FieldByName(FieldName).AsString;
            end;
         if ABS(FieldByName('Qty').AsFloat) >= 0.01 then
            StringGrid.Cells[2, Loop] := Format('%4.2f', [FieldByName('Qty').AsFloat])
           else
            StringGrid.Cells[2, Loop] := '';
         if ABS(FieldByName('Price').AsFloat) >= 0.01 then
            StringGrid.Cells[3, Loop] := Format('%4.2f', [FieldByName('Price').AsFloat])
           else
            StringGrid.Cells[3, Loop] := '';
         if FieldByName('Seat').AsInteger > 0 then
            StringGrid.Cells[6, Loop] := IntToStr(FieldByName('Seat').AsInteger)
           else
            StringGrid.Cells[6, Loop] := '';
         StringGrid.Cells[5, Loop] := Format('%4.2f', [FieldByName('Discount').AsFloat]);
         if (DiscountKind = 0) and (Abs(FieldByName('Discount').AsFloat) >= 0.01) then
            DiscountRate := FieldByName('Discount').AsFloat;
         StringGrid.Cells[7, Loop] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);
         SetDescription(Loop);
         if FieldByName('SpecialOrder').AsString <> '' then
            begin
             Loop := Loop + 1;
             StringGrid.Cells[1, Loop] := FieldByName('SpecialOrder').AsString;
             StringGrid.Cells[2, Loop] := '';
             StringGrid.Cells[3, Loop] := '';
             StringGrid.Cells[4, Loop] := '';
             StringGrid.Cells[5, Loop] := '';
             StringGrid.Cells[6, Loop] := '';
             StringGrid.Cells[7, Loop] := '';
             StringGrid.Cells[8, Loop] := '';
             OrderInstruction[Loop] := True;
             Instruction[Loop] := 1;
             EditFlag[Loop] := False;
             VoidFlag[Loop] := FieldByName('VoidFlag').AsBoolean;
             PrintFlag[Loop] := FieldByName('PrintFlag').AsBoolean;
             CheckListPrinted[Loop] := FieldByName('CheckListPrinted').AsBoolean;
             SentToKitchen[Loop] := FieldByName('SentToKitchen').AsBoolean;
             OpenPrice[Loop] := FieldByName('OpenPrice').AsInteger <> 0;
             DiscountFlag[Loop] := False;
             PriceSelect[Loop] := 0;
             PaidQty[Loop] := 0;
             VoidReason[Loop] := '';
             OriginalPrice[Loop] := 0;
             SecondScreenDescription[Loop] := FieldByName('SpecialOrder').AsString;
             OrderOperator[Loop] := sUserName;
            end;
        end
       else
        begin
         StringGrid.cells[8, Loop] := '----';
         EditFlag[Loop] := False;
         PrintFlag[Loop] := FieldByName('PrintFlag').AsBoolean;
         CheckListPrinted[Loop] := FieldByName('CheckListPrinted').AsBoolean;
         for J := 1 to 7 do
           for I := 1 to 85 do
            StringGrid.Cells[J, Loop] := StringGrid.Cells[J, Loop] + '-';
        end;
      Next; PreItemCount := PreItemCount + 1; Loop := Loop + 1;
    end;
   Close;
  end;
 if Loop < 500 then
    StringGrid.Row := Loop
   else
    StringGrid.Row := 500;
 CurrentRow := StringGrid.Row;
end;

function TTableOrderForm.SaveOrderHeadTable(OrderNo: string): boolean;
var
 SQLStr, OrderDateTime, OrderNoStr, TableNo, Person, ServicePerson,
 Amount, GST, VIPNo, InvoiceNoStr, BookingNo, CreditFlag, DueTimeTemp,
 ServiceChargeRateTemp, ServiceChargeTemp, MachineNameTemp, DeliveryTemp,
 OtherChargeRateTemp, OtherChargeTemp, PriceIncludesGSTTemp,
 CustomerNameTemp, CurrentSplitBillStatusTemp, PresetDiscountCodeTemp,
 DiscountOperatorTemp: string;
begin
 OrderNoStr := Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OrderDateTime := ConvertDateTime(OrderDate);
 if DueTime <> 0 then
    DueTimeTemp := ConvertDateTime(DueTime)
   else
    DueTimeTemp := 'Null';
 if TableNoEdit.Caption <> '' then
    TableNo := Chr(39) + CheckQuotes(TableNoEdit.Caption) + Chr(39)
   else
    TableNo := 'Null';
 if PersonEdit.Caption <> '' then
    Person := PersonEdit.Caption
   else
    Person := '0';
 if ServiceEdit.Caption <> '' then
    ServicePerson := Chr(39) + CheckQuotes(ServiceEdit.Caption) + Chr(39)
   else
    ServicePerson := 'Null';
 VIPNo := IntToStr(sVIPNo);
 if InvoiceNo <> '' then
    InvoiceNoStr := Chr(39) + CheckQuotes(InvoiceNo) + Chr(39)
   else
    InvoiceNoStr := 'Null';
 if BookingNoEdit.Caption <> '' then
    BookingNo := Chr(39) + CheckQuotes(BookingNoEdit.Caption) + Chr(39)
   else
    BookingNo := 'Null';
 if Credit then
    CreditFlag := '1'
   else
    CreditFlag := '0';
 if MachineName <> '' then
    MachineNameTemp := Chr(39) + CheckQuotes(MachineName) + Chr(39)
   else
    MachineNameTemp := 'Null';
 if VIPNameEdit.Caption <> '' then
    CustomerNameTemp := Chr(39) + CheckQuotes(VIPNameEdit.Caption) + Chr(39)
   else
    CustomerNameTemp := 'Null';
 Amount := FloatToStr(StrToFloat(AmountEdit.Caption) -
           StrToFloat(DiscountEdit.Caption) - RewardPointsDiscount);
 GST := FloatToStr(StrToFloat(GSTEdit.Caption));
 ServiceChargeRateTemp := FloatToStr(CurrentServiceChargeRate);
 ServiceChargeTemp := ServiceChargeEdit.Caption;
 OtherChargeRateTemp := FloatToStr(CurrentOtherChargeRate);
 OtherChargeTemp := OtherChargeEdit.Caption;
 if DeliveryFlag then
    DeliveryTemp := '1'
   else
    DeliveryTemp := '0';
 if CurrentPriceIncludesGST then
    PriceIncludesGSTTemp := '1'
   else
    PriceIncludesGSTTemp := '0';
 if CurrentSplitBillStatus then
    CurrentSplitBillStatusTemp := '1'
   else
    CurrentSplitBillStatusTemp := '0';
 if PresetDiscountCode <> '' then
    PresetDiscountCodeTemp := Chr(39) + CheckQuotes(PresetDiscountCode) + Chr(39)
   else
    PresetDiscountCodeTemp := 'Null';
 if DiscountOperator <> '' then
    DiscountOperatorTemp := Chr(39) + CheckQuotes(DiscountOperator) + Chr(39)
   else
    DiscountOperatorTemp := 'Null';
 SQLStr := 'Insert Into OrderH(OrderDate, OrderNo, Persons, TableNo, ' +
           'ServicePerson, Amount, GST, PaidAmount, Tips, Surcharge, ' +
           'VIPNo, OpName, InvoiceNo, BookingNo, Credit, ServiceChargeRate, ' +
           'ServiceCharge, OrderPrinted, MachineID, BillKind, DollarDiscount, ' +
           'DueTime, DiscountKind, Delivery, OtherChargeRate, OtherCharge, ' +
           'PriceIncludesGST, CurrentGSTRate, RewardPoints, CustomerName, ' +
           'SplitBill, PresetDiscountCode, DiscountOperator) ' +
           'Values(' + OrderDateTime + ',' + OrderNoStr + ',' +
           Person + ',' + TableNo + ',' + ServicePerson + ',' + Amount +
           ',' + GST + ',' + FloatToStr(PaidAmount) + ',' +
           FloatToStr(Tips) + ',' + FloatToStr(Surcharge) + ',' +
           VIPNo + ',' + Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' +
           InvoiceNoStr + ',' + BookingNo + ',' + CreditFlag + ',' +
           ServiceChargeRateTemp + ',' + ServiceChargeTemp + ', 0,' +
           MachineNameTemp + ',' + IntToStr(BillKind) + ',' +
           FloatToStr(DollarDiscount) + ',' + DueTimeTemp + ',' +
           IntToStr(DiscountKind) + ',' + DeliveryTemp + ',' +
           OtherChargeRateTemp + ',' + OtherChargeTemp + ',' +
           PriceIncludesGSTTemp + ',' + FloatToStr(CurrentGSTRate) + ',' +
           FloatToStr(RewardPointsDiscount) + ',' + CustomerNameTemp + ',' +
           CurrentSplitBillStatusTemp + ',' + PresetDiscountCodeTemp + ',' +
           DiscountOperatorTemp + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TTableOrderForm.UpdateTableStatus: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Update TableSet Set Status=0, ServiceStatus = 0 ' +
           'Where TableNo=' + Chr(39) + CheckQuotes(TableNoEdit.Caption) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TTableOrderForm.SaveOrderItemTable(OrderNo: string): boolean;
var
 I, IDNo: integer;
 OrderQty: double;
 SQLStr, OrderNoStr, ItemCode, Qty, Price, TaxRate, Discount, OriginalPriceTemp,
 PrintFlagTemp, SentToKitchenTemp, PriceSel, Seat, VoidReasonTemp,
 SpecialOrderTemp, CheckListPrintedTemp, VoidFlagTemp, OrderOperatorTemp,
 InstructionTemp: string;
begin
 I := 1; IDNo := 1; Result := True;
 OrderNoStr := Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 while (I <= 500) and Result do
  begin
   ItemCode := StringGrid.Cells[8, I];
   if ItemCode <> '' then
      begin
       if ItemCode <> '----' then
          begin
           if Stringgrid.Cells[2, I] <> '' then
              OrderQty := StrToFloat(StringGrid.Cells[2, I])
             else
              OrderQty := 0;
           Qty := FloatToStr(OrderQty);
           if Stringgrid.Cells[3, I] <> '' then
              Price := StringGrid.Cells[3, I]
             else
              Price := '0';
           if Stringgrid.Cells[6, I] <> '' then
              Seat := StringGrid.Cells[6, I]
             else
              Seat := '0';
           if Stringgrid.Cells[5, I] <> '' then
              Discount := StringGrid.Cells[5, I]
             else
              Discount := '0.0';
           if StringGrid.Cells[7, I] <> '' then
              TaxRate := StringGrid.cells[7, I]
             else
              TaxRate := '0';
           PriceSel := IntToStr(PriceSelect[I]);
          end
         else
          begin
           Qty := '0'; Price := '0'; Seat := '0';
           Discount := '0.0'; TaxRate := '0';
           PriceSel := '0';
          end;
       if PrintFlag[I] then
          PrintFlagTemp := '1'
         else
          PrintFlagTemp := '0';
       if CheckListPrinted[I] then
          CheckListPrintedTemp := '1'
         else
          CheckListPrintedTemp := '0';
       if SentToKitchen[I] then SentToKitchenTemp := '1' else SentToKitchenTemp := '0';
       if VoidReason[I] <> '' then
          VoidReasonTemp := Chr(39) + CheckQuotes(VoidReason[I]) + Chr(39)
         else
          VoidReasonTemp := 'Null';
       if OrderOperator[I] <> '' then
          OrderOperatorTemp := Chr(39) + OrderOperator[I] + Chr(39)
         else
          OrderOperatorTemp := 'Null';
       if VoidFlag[I] then
          VoidFlagTemp := '1'
         else
          VoidFlagTemp := '0';
       InstructionTemp := IntToStr(Instruction[I]);
       OriginalPriceTemp := FloatToStr(OriginalPrice[I]);
       if OrderInstruction[I + 1] and (StringGrid.Cells[1, I + 1] <> '') then
          begin
           I := I + 1;
           SpecialOrderTemp := Chr(39) + CheckQuotes(StringGrid.Cells[1, I]) + Chr(39);
          end
         else
          SpecialOrderTemp := 'Null';
       SQLStr := 'Insert Into OrderI(OrderNo, ItemCode, Qty, PaidQty, ' +
                 'Price, Discount, TaxRate, PrintFlag, Condition, ' +
                 'PriceSelect, Seat, SentToKitchen, IDNo, VoidReason, ' +
                 'SpecialOrder, CheckListPrinted, VoidFlag, OrderOperator, ' +
                 'OriginalPrice) ' +
                 'Values(' + OrderNoStr + ',' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) + ',' +
                 Qty + ',' + FloatToStr(PaidQty[I]) + ',' + Price + ',' +
                 Discount + ',' + TaxRate + ',' + PrintFlagTemp + ',' +
                 InstructionTemp + ',' + PriceSel + ',' + Seat + ',' +
                 SentToKitchenTemp + ',' + IntToStr(IDNo) + ',' + VoidReasonTemp + ',' +
                 SpecialOrderTemp + ',' + CheckListPrintedTemp + ',' +
                 VoidFlagTemp + ',' + OrderOperatorTemp + ',' + OriginalPriceTemp + ')';
       Result := DataForm.ExecQueryPro(SQLStr);
       Inc(IDNo);
      end;
   Inc(I);
 end;
end;

function TTableOrderForm.UpdateBookingMessage: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Update BookTable Set Arrived = 1 Where BookingNo=' +
           Chr(39) + CheckQuotes(BookingNoEdit.Caption) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TTableOrderForm.SaveData(OrderNo: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From OrderH Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From OrderI Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then Result := SaveOrderHeadTable(OrderNo);
 if Result then Result := SaveOrderItemTable(OrderNo);
 if Result and (BookingNoEdit.Caption <> '') then Result := UpdateBookingMessage;
 if Result then Result := DataForm.UpdateOrderPayment(OrderNo, CurrentSplitBillStatus);
end;

function TTableOrderForm.CheckOrderStatus(OrderNo: string): boolean;
var
 SQLStr: string;
 OrderAmount, PrePaidAmount: double;
 OrderItemCount: integer;
begin
 SQLStr := 'Select Amount, ServiceCharge, OtherCharge, Tips, Surcharge, ' +
           'GST, PaidAmount, PriceIncludesGST ' +
           'From OrderH Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   if FieldByName('PriceIncludesGST').AsBoolean then
      OrderAmount := FieldByName('Amount').AsFloat + FieldByName('ServiceCharge').AsFloat +
                     FieldByName('OtherCharge').AsFloat + FieldByName('Tips').AsFloat +
                     FieldByName('Surcharge').AsFloat
     else
      OrderAmount := FieldByName('Amount').AsFloat + FieldByName('ServiceCharge').AsFloat +
                     FieldByName('OtherCharge').AsFloat + FieldByName('Tips').AsFloat +
                     FieldByName('Surcharge').AsFloat + FieldByName('GST').AsFloat;
   PrePaidAmount := Query.FieldByName('PaidAmount').AsFloat;
   Close;
  end;
 Result := (ABS(PreAmount - OrderAmount) <= 0.005) and (ABS(PrePaidAmount - PaidAmount) < 0.005);
 if Result then
    begin
     SQLStr := 'Select Count(*) As ItemCount ' +
               'From OrderI Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
     OpenQuery(SQLStr);
     OrderItemCount := Query.FieldByName('ItemCount').AsInteger;
     Query.Close;
     Result := OrderItemCount = PreItemCount;
    end;
end;

function TTableOrderForm.CheckTableStatus(TableNo: string): boolean;
var
 SQLStr: string;
 CurrentDateTime: TDateTime;
begin
 CurrentDateTime := Date;
 if (Time < EndTime) and (EndTime < BeginTime) then
    CurrentDateTime := Date - 1;
 SQLStr := 'Select TableNo From OrderH Where Credit=0 and ' +
           'OrderDate>=' + ConvertDateTime(CurrentDateTime + BeginTime) + ' and ' +
           'TableNo=' + Chr(39) + CheckQuotes(TableNo) + Chr(39) + ' and ' +
           '(((PriceIncludesGST <> 0) and ' +
           '(Amount + ServiceCharge + Tips + Surcharge + OtherCharge - PaidAmount >= 0.01)) or ' +
           '((PriceIncludesGST = 0) and ' +
           '(Amount + ServiceCharge + Tips + Surcharge + OtherCharge + GST - PaidAmount >= 0.01)))';
 OpenQuery(SQLStr);
 Result := Query.RecordCount = 0;
 Query.Close;
end;

function TTableOrderForm.SaveOrderPro(var OrderNo: string): boolean;
var
 SQLStr: string;
begin
 BackPanel.SetFocus;
 Result := False;
 if (BillKind = sTableOrder) and TableTracking and (TableNoEdit.Caption = '') then
    begin
     MessageBoxForm.MessagePro('Table No. is invalid!', sErrorMsg);
     Exit;
    end;
 if Not DataForm.BeginTransaction then Exit;
 if StatusFlag = sNewStatus then
    begin
     DataForm.GenerateOrderNo(sOrderNo);
     MachineName := MachineID;
    end
   else
    sOrderNo := OrderNoEdit.Caption;
 if (BillKind = sTableOrder) and (StatusFlag = sNewStatus) and
    TableTracking and Not CheckTableStatus(TableNoEdit.Caption) then
    begin
     DataForm.RollBack;
     MessageBoxForm.MessagePro('Table: ' + TableNoEdit.Caption + ' is unavaible.', sErrorMsg);
     Exit;
    end;
 if (StatusFlag = sEditStatus) and Not CheckOrderStatus(sOrderNo) then
    begin
     DataForm.RollBack;
     MessageBoxForm.MessagePro('This order has been changed by another user.' +
                               Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                               'You can not save this order.', sErrorMsg);
     Exit;
    end;
 try
  Result := SaveData(sOrderNo);
  if Result and LoyaltyAwardAvailible and (sVIPNo > 0) and (RewardPointsDiscount >= 0.01) then
     Result := DataForm.SavePointsPayment(sOrderNo, sVIPNo, Round(RewardPointsDiscount * PaymentPoints));
  if Result and (StatusFlag = sNewStatus) then Result := UpdateTableStatus;

  if Result and TableLockFunctionEnabled then
     begin
      if TableNoEdit.Caption <> '' then
         begin
          SQLStr := 'Update TableSet Set TableLocked = 0 Where TableNo=' + Chr(39) + CheckQuotes(TableNoEdit.Caption) + Chr(39);
          Result := DataForm.ExecQueryPro(SQLStr);
         end;
      if Result and (OriginalTableNo <> '') and (OriginalTableNo <> TableNoEdit.Caption) then
         begin
          SQLStr := 'Update TableSet Set TableLocked = 0 Where TableNo=' + Chr(39) + CheckQuotes(OriginalTableNo) + Chr(39);
          Result := DataForm.ExecQueryPro(SQLStr);
         end;
     end;

 finally
  if Result then
     begin
      DataForm.CommitTransaction;
      OpenCategory;
      AssignCategoryKeyBoard;
      Application.ProcessMessages;
      ProcessCategoryButtonTouch(1);
      AssignMenuKeyBoard;
      OrderNo := sOrderNo;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TTableOrderForm.PrintJobListPro(OrderNo: string);
begin
 case BillKind of
  sTableOrder: if AutoPrintJobList then
                  begin
                   PrintJobListControlForm.PrintJobListControlPro(OrderNo, '', False, sConfirmedOrder);
                   if AutoPrintCheckList then PrintCheckListForm.PrintCheckList(OrderNo, '', False, sConfirmedOrder);
                   if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(OrderNo, '', False);
                  end
                 else
                  if ManuallyPrintJobList then
                     MenuPrintJobListForm.PrintJobList(OrderNo);
  sQuickSale: begin
                PrintJobListControlForm.PrintJobListControlPro(OrderNo, '', False, sConfirmedOrder);
                if AutoPrintCheckList then PrintCheckListForm.PrintCheckList(OrderNo, '', False, sConfirmedOrder);
                if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(OrderNo, '', False);
               end;
  sPhoneOrder: if AutoPrintPhoneOrderJobList then
                  begin
                   PrintJobListControlForm.PrintJobListControlPro(OrderNo, '', False, sConfirmedOrder);
                   if AutoPrintCheckList then PrintCheckListForm.PrintCheckList(OrderNo, '', False, sConfirmedOrder);
                   if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(OrderNo, '', False);
                  end;
  end;
 Application.ProcessMessages;
end;

procedure TTableOrderForm.BalanceButtonClick(Sender: TObject);
var
 OrderNo: string;
 TotalSales, Amount, Discount: double;
begin
 EditPanel.Enabled := False;
 if ((StatusFlag <> sEditStatus) and (FindLastRow = 1)) or Not DataForm.CheckItemCode(StringGrid, 8) then
    begin
     EditPanel.Enabled := True;
     Exit;
    end;
 CalcAmount;
 if (MaxDollarDiscount >= 0.01) and (DiscountEdit.Caption <> '') and
    (StrToFloat(DiscountEdit.Caption) > MaxDollarDiscount) then
    begin
     MessageBoxForm.MessagePro('Discount is over ' + FormatCurrency(MaxDollarDiscount) + '.' +
     Chr(13) + Chr(10) + Chr(13) + Chr(10) +
     'System will auto change discount to ' + FormatCurrency(MaxDollarDiscount) + '.',
     sErrorMsg);
     DiscountRate := 0;
     DollarDiscount := MaxDollarDiscount;
     DiscountKind := 2;
     ProcessDiscount;
    end;
 Amount := StrToFloat(AmountEdit.Caption);
 Discount := StrToFloat(DiscountEdit.Caption);
 TotalSales := StrToFloat(TotalEdit.Caption);
 if (ABS(Amount) <= 0.005) and (ABS(Discount) >= 0.01) then
    begin
     MessageBoxForm.MessagePro('Can not do discount for zero amount order.', sErrorMsg);
     EditPanel.Enabled := True;
     Exit;
    end;
 if (TotalSales < 0) and Not AuthoriseRefund then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to do sales refund.', sErrorMsg);
     EditPanel.Enabled := True;
     Exit;
    end;
 TableTransfered := (OriginalTableNo <> TableNoEdit.Caption) and (StatusFlag = sEditStatus);
 if ((StatusFlag = sEditStatus) or (FindLastRow > 1)) and SaveOrderPro(OrderNo) then
    begin
     SendToSecurityPortPro('[Balance] Button Clicked', '', '', 0, 0, 0, 0);
     PrintJobListPro(OrderNo);
     if TableTransfered then PrintTableTransferSlip(OrderNo, OriginalTableNo, TableNoEdit.Caption);
     InitForm;
     ActiveFlag := False;
     //SetButtonStatus;
     Application.ProcessMessages;
    end
   else
    EditPanel.Enabled := True;
  ExitButtonClick(Sender);  
end;

function TTableOrderForm.OpenBookHeadQuery(BookingNo: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From BookTable Where BookingNo=' +
           Chr(39) + CheckQuotes(BookingNo) + Chr(39);
 Result := OpenQuery(SQLStr);
end;

procedure TTableOrderForm.ReadBookHeadData;
var
 Temp, VIPName: string;
 I: integer;
 VIPDiscountRate: double;
begin
 with Query do
  begin
   Temp := DeleteSpace(FieldByName('TableNo').AsString);
   I := 1;
   TableNoEdit.Caption := '';
   while (I <= Length(Temp)) and (Temp[I] <> ',') do
    begin
     TableNoEdit.Caption := TableNoEdit.Caption + Temp[I];
     I := I + 1;
    end;
   if FieldByName('Persons').AsInteger > 0 then
      PersonEdit.Caption := Format('%1d', [FieldByName('Persons').AsInteger])
     else
      PersonEdit.Caption := '';
   BookingNoEdit.Caption := FieldByName('BookingNo').AsString;
   if FieldByName('VIPNo').AsInteger > 0 then
      begin
       sVIPNo := FieldByName('VIPNo').AsInteger;
       if DataForm.ReadVIPInformation(sVIPNo, VIPName, VIPDiscountRate) then
          begin
           DiscountRate := VIPDiscountRate;
           VIPNameEdit.Caption := VIPName;
           DiscountOperator := sUserName;
          end
         else
          begin
           DiscountRate := 0;
           VIPNameEdit.Caption := '';
          end
      end
     else
      begin
       VIPNameEdit.Caption := '';
       DiscountRate := 0;
       sVIPNo := 0;
      end;
   Close;
  end;
 DiscountKind := 0;
 DollarDiscount := 0;
end;

procedure TTableOrderForm.ReadBookDetailData(BookingNo: string);
var
 SQLStr, FieldName: string;
 I: integer;
begin
 SQLStr := 'Select BookDetail.ItemCode, Qty, BookDetail.Price, ' +
           'Description1, Description2, BookDetail.TaxRate, OpenPrice, ' +
           'AllowDiscount, BookDetail.Condition, Multiple, ' +
           'BookDetail.PriceSelect, SubDescription, ' +
           'SubDescription1, SubDescription2, SubDescription3, ' +
           'SpecialOrder, IDNo ' +
           'From BookDetail, MenuItem ' +
           'Where BookDetail.ItemCode = MenuItem.ItemCode and ' +
           'BookingNo=' + Chr(39) + CheckQuotes(BookingNo) + Chr(39) +
           ' Order By IDNo';
 OpenQuery(SQLStr);
 I := FindLastRow;
 with Query do
  begin
   First;
   while Not EOF and (I <= 500) do
    begin
     StringGrid.Cells[8, I] := FieldByName('ItemCode').AsString;
     Instruction[I] := FieldByName('Condition').AsInteger;
     OrderInstruction[I] := False;
     EditFlag[I] := True;
     VoidFlag[I] := False;
     OrderInstruction[I] := False;
     PrintFlag[I] := False;
     CheckListPrinted[I] := False;
     SentToKitchen[I] := False;
     OpenPrice[I] := FieldByName('OpenPrice').AsBoolean;
     DiscountFlag[I] := FieldByName('AllowDiscount').AsBoolean;
     PriceSelect[I] := FieldByName('PriceSelect').AsInteger;
     PaidQty[I] := 0;
     OrderOperator[I] := sUserName;
     if Langurage or (FieldByName('Description2').AsString = '') then
        StringGrid.Cells[1, I] := FieldByName('Description1').AsString
       else
        StringGrid.Cells[1, I] := FieldByName('Description2').AsString;
     if (SecondDisplayDescription = 1) and (FieldByName('Description2').AsString <> '') then
        SecondScreenDescription[I] := FieldByName('Description2').AsString
       else
        SecondScreenDescription[I] := FieldByName('Description1').AsString;
     if FieldByName('Multiple').AsBoolean then
        begin
         FieldName := GenerateSubDescriptionFieldName(PriceSelect[I]);
         if FieldByName(FieldName).AsString <> '' then
            StringGrid.Cells[1, I] :=
             StringGrid.Cells[1, I] + ' / ' + FieldByName(FieldName).AsString;
        end;
     if ABS(FieldByName('Qty').AsFloat) >= 0.01 then
        StringGrid.Cells[2, I] := Format('%4.2f', [FieldByName('Qty').AsFloat]);
     if ABS(FieldByName('Price').AsFloat) >= 0.01 then
        begin
         StringGrid.Cells[3, I] := Format('%4.2f', [FieldByName('Price').AsFloat]);
         OriginalPrice[I] := FieldByName('Price').AsFloat;
        end;
     if (DiscountKind = 0) then
        StringGrid.Cells[5, I] := Format('%4.2f', [DiscountRate]);
     StringGrid.Cells[7, I] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);
     SetDescription(I);
     if FieldByName('SpecialOrder').AsString <> '' then
        begin
         I := I + 1;
         StringGrid.Cells[1, I] := FieldByName('SpecialOrder').AsString;
         Instruction[I] := 1;
         EditFlag[I] := True;
         VoidFlag[I] := False;
         OrderInstruction[I] := True;
         PrintFlag[I] := False;
         CheckListPrinted[I] := False;
         SentToKitchen[I] := False;
         OpenPrice[I] := False;
         DiscountFlag[I] := False;
         PriceSelect[I] := 0;
         PaidQty[I] := 0;
         OrderOperator[I] := '';
         OriginalPrice[I] := 0;
         SecondScreenDescription[I] := FieldByName('SpecialOrder').AsString;
        end;
     Next; I := I + 1;
    end;
   Close;
  end;
 if I < 500 then
    StringGrid.Row := I
   else
    StringGrid.Row := 500;
 CurrentRow := StringGrid.Row;
 ProcessDiscount;
 CalcAmount;
end;

{procedure TTableOrderForm.ReadBookData;
var
 BookingNo: string;
 Temp: integer;
begin
 if BookingSearchForm.SearchPro(BookingNo, Temp) and OpenBookHeadQuery(BookingNo) then
    begin
     ReadBookHeadData;
     ReadBookDetailData(BookingNo);
    end;
end;  }

procedure TTableOrderForm.ExitButtonClick(Sender: TObject);
begin

 {if Not Password then Close
   else
    if DataForm.VerifyPassword(sUserName) then
       begin
        if AuthoriseCloseMainWindow then Close
          else
           MessageBoxForm.MessagePro('you have not been authorised to close this window.', sErrorMsg);
       end;}
   Close;
end;

function TTableOrderForm.VoidItemPro(ARow: integer; voidReasonCode: string): integer;
var
 Code, Description, Qty, Price, TaxRate, DiscountRateTemp, SeatNoTemp, SecondScreenDescriptionTemp: string;
 CurRow, InstructionTemp, PriceSelectTemp: integer;
 PaidQtyTemp, OriginalPriceTemp: double;
 DiscountFlagTemp, OpenPriceTemp: boolean;
begin
 CurRow := ARow;
 if (StringGrid.Cells[8, CurRow] <> '') then
    repeat
     if  Not VoidFlag[CurRow] and Not OrderInstruction[CurRow] then
         begin
          InstructionTemp := Instruction[CurRow];
          DiscountFlagTemp := DiscountFlag[CurRow];
          OpenPriceTemp := OpenPrice[CurRow];
          PriceSelectTemp := PriceSelect[CurRow];
          PaidQtyTemp := PaidQty[CurRow];
          Code := StringGrid.Cells[8, CurRow];
          Description := StringGrid.Cells[1, CurRow];
          Qty := StringGrid.Cells[2, CurRow];
          Price := StringGrid.Cells[3, CurRow];
          if DiscountFlagTemp then
             DiscountRateTemp := StringGrid.Cells[5, CurRow]
            else
             DiscountRateTemp := '0.00';
          TaxRate := StringGrid.Cells[7, CurRow];
          SeatNoTemp := StringGrid.Cells[6, CurRow];
          OriginalPriceTemp := OriginalPrice[CurRow];
          EditFlag[CurRow] := False;
          VoidFlag[CurRow] := True;
          SecondScreenDescriptionTemp := SecondScreenDescription[CurRow];
          CurrentRow := FindLastRow;
          StringGrid.Cells[8, CurrentRow] := Code;
          StringGrid.Cells[1, CurrentRow] := Description;
          if Qty <> '' then
             Qty := FloatToStr( 0 - StrToFloat(Qty))
            else
             Qty := '0';
          StringGrid.Cells[2, CurrentRow] := Format('%4.2f', [StrToFloat(Qty)]);
          StringGrid.Cells[3, CurrentRow] := Price;
          StringGrid.Cells[5, CurrentRow] := DiscountRateTemp;
          StringGrid.Cells[6, CurrentRow] := SeatNoTemp;
          StringGrid.Cells[7, CurrentRow] := TaxRate;
          Instruction[CurrentRow] := InstructionTemp;
          if Instruction[CurrentRow] = 0 then VoidReason[CurrentRow] := VoidReasonCode;
          EditFlag[CurrentRow] := False;
          VoidFlag[CurrentRow] := True;
          OrderInstruction[CurrentRow] := False;
          OrderOperator[CurrentRow] := sUserName;
          PrintFlag[CurrentRow] := False;
          CheckListPrinted[CurrentRow] := False;
          SentToKitchen[CurrentRow] := False;
          OpenPrice[CurrentRow] := OpenPriceTemp;
          DiscountFlag[CurrentRow] := DiscountFlagTemp;
          PriceSelect[CurrentRow] := PriceSelectTemp;
          PaidQty[CurrentRow] := PaidQtyTemp;
          OriginalPrice[CurrentRow] := OriginalPriceTemp;
          SecondScreenDescription[CurrentRow] := SecondScreenDescriptionTemp;
         end;
     CurRow := CurRow + 1;
    until Instruction[CurRow] = 0;
 StringGrid.Row := CurrentRow;
 Result := CurRow;
end;

procedure TTableOrderForm.InsertItemButtonClick(Sender: TObject);
begin
 StringGrid.SetFocus;
 InsertLine(CurrentRow);
 StringGrid.Row := CurrentRow;
 CurrentCol := 1; StringGrid.Col := 1;
end;

procedure TTableOrderForm.VoidItemButtonClick(Sender: TObject);
var
 VoidReasonCode: string;
begin
 StringGrid.SetFocus;
 if Not VoidFlag[CurrentRow] then
    begin
     if Not ShowNegativeQty or EditFlag[CurrentRow] or
        (StringGrid.Cells[8, CurrentRow] = '----') or
        OrderInstruction[CurrentRow] then
        begin
         if (Instruction[CurrentRow] <> 0) or (StringGrid.Cells[8, CurrentRow] = '----') then
            DeleteLine(CurrentRow)
           else
            repeat
             DeleteLine(CurrentRow);
            until (Instruction[CurrentRow] = 0) and (Not OrderInstruction[CurrentRow]);
        end
       else
        if Not VoidItemAuthority then
           MessageBoxForm.MessagePro('You have not been authrised to do void item.', sErrorMsg)
          else
           begin
            if Instruction[CurrentRow] <> 0 then
               DeleteLine(CurrentRow)
              else
               begin
                VoidReasonCode := '';
                if AutoPopVoidReason then
                   VoidReasonSelectForm.VoidReasonSelectPro(VoidReasonCode);
                VoidItemPro(CurrentRow, VoidReasonCode);
               end;
           end;
     StringGrid.Refresh;
     CalcAmount;
    end;
    CalcBalance;
end;

procedure TTableOrderForm.VoidAllItemButtonClick(Sender: TObject);
var
 I, LastRow: integer;
 VoidReasonCode: string;
begin
 StringGrid.SetFocus;
 if Not VoidItemAuthority and Not Supervisor then
    MessageBoxForm.MessagePro('You have not been authrised to do void item.', sErrorMsg)
   else
    if MessageBoxForm.MessagePro('Are you sure you want to void all items?', sConfirmMsg) = mrYes then
       begin
        LastRow := FindLastRow;
        if Not ShowNegativeQty or (StatusFlag = sNewStatus) then
           for I := 1 to LastRow do DeleteLine(1)
          else
           begin
            if AutoPopVoidReason then VoidReasonSelectForm.VoidReasonSelectPro(VoidReasonCode);
            I := 1;
            while I < LastRow do
             if (StringGrid.Cells[8, I] <> '') and (StringGrid.Cells[8, I] <> '----') then
                I := VoidItemPro(I, '')
               else
                I := I + 1;
            StringGrid.Refresh;
           end;
        CalcAmount;
       end;
end;

{procedure TTableOrderForm.MealPackageButtonClick(Sender: TObject);
begin
 CopyMealPackage;
 StringGrid.SetFocus;
end;
}

function TTableOrderForm.GetLastNonInstructionItem: integer;
var
 I: integer;
begin
 I := FindLastRow;
 if I > 1 then Dec(I);
 while (I > 1) and (Instruction[I] = 1) do
  I := I - 1;
 Result := I;
end;

procedure TTableOrderForm.QtyButtonClick(Sender: TObject);
var
 NumStr: string;
begin
 with StringGrid do
  begin
   SetFocus;
   if (Cells[1, Row] = '') or OrderInstruction[Row] then Row := GetLastNonInstructionItem;
   if (Row > 0) and (Cells[1, Row] <> '') and (Cells[8, Row] <> '----') and
      Not VoidFlag[Row] and (EditFlag[Row] or Supervisor or Not NotAllowChangeQty) then
      begin
       if (Cells[2, Row] <> '') and (StrToFloat(Cells[2, Row]) <> 0) then
          NumStr := Cells[2, Row]
         else
          NumStr := '1';
       if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Qty', 0) then
          begin
           if (StrToFloat(NumStr) < 0) and Not VoidItemAuthority then
              MessageBoxForm.MessagePro('You have not been authrised to do void item.', sErrorMsg)
             else
              begin
               Col := 2; CurrentCol := 2;
               if Not ChangeQtyWithCondiment or (Instruction[Row] <> 0) then
                  Cells[Col, Row] := Format('%4.2f', [StrToFloat(NumStr)])
                 else
                  repeat
                   Cells[Col, Row] := Format('%4.2f', [StrToFloat(NumStr)]);
                   Row := Row + 1;
                  until Instruction[Row] = 0;
               CurrentRow := Row;
               Changed := True;
               MoveToNextCell;
              end;
          end;
      end;
  end;
  CalcBalance;
end;

procedure TTableOrderForm.PriceButtonClick(Sender: TObject);
var
 NumStr: string;
begin
 with StringGrid do
  begin
   SetFocus;
   if (Cells[1, Row] = '') or OrderInstruction[Row] then Row := GetLastNonInstructionItem;
   if (Row > 0) and (Cells[1, Row] <> '') and (Cells[8, Row] <> '----') and Not VoidFlag[Row] and
     (Supervisor or (OpenPrice[Row] and (EditFlag[Row] or Not NotAllowChangeQty))) then
      begin
       if (Cells[3, Row] <> '') and (StrToFloat(Cells[3, Row]) <> 0) then
          NumStr := Cells[3, Row]
         else
          NumStr := '0';
       if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Price', 0) then
          begin
           Col := 3; CurrentCol := 3;
           Cells[Col, Row] := NumStr;
           Changed := True;
           MoveToNextCell;
          end;
      end;
  end;
  CalcBalance;
end;

procedure TTableOrderForm.DiscountButtonClick(Sender: TObject);
var
 NumStr: string;
 NewDiscountKind: integer;
 Temp: double;
begin
 StringGrid.SetFocus;
 if Not DiscountEnable then
    begin
     MessageBoxForm.MessagePro('You have not been authrised to do discount.', sErrorMsg);
     Exit;
    end;
 NewDiscountKind := DiscountKind;
 if DiscountRateEnterMode = 0 then
    begin
     if Not DiscountForm.ReadDiscountPro(NumStr, NewDiscountKind) then
        Exit
       else
        PresetDiscountCode := '';
    end
   else
    begin
     if Not DiscountRateSelectForm.DiscountRateSelectPro(Temp, NewDiscountKind, PresetDiscountCode) then Exit
       else
        NumStr := FloatToStr(Temp);
    end;
 if (NewDiscountKind <= 1) and (StrToFloat(NumStr) > MaxDiscountPercentage) then
    begin
     MessageBoxForm.MessagePro('Discount rate is over ' + Format('%4.2f', [MaxDiscountPercentage]) + ' %.', sErrorMsg);
     Exit;
    end
   else
    if (NewDiscountKind = 2) and (MaxDollarDiscount >= 0.01) and (StrToFloat(NumStr) > MaxDollarDiscount) then
       begin
        MessageBoxForm.MessagePro('Discount is over ' + FormatCurrency(MaxDollarDiscount) + '.', sErrorMsg);
        Exit;
       end;
 case NewDiscountKind of
  0:  begin
       DiscountRate := StrToFloat(NumStr);
       DollarDiscount := 0;
       DiscountKind := NewDiscountKind;
       ProcessDiscount;
      end;
  1:  begin
       if DiscountKind <> 1 then
          begin
           DiscountRate := 0;
           DollarDiscount := 0;
           DiscountKind := 0;
           ProcessDiscount;
          end;
       with StringGrid do
        begin
         if Cells[1, Row] = '' then
            begin
             Row := GetLastNonInstructionItem;
             CurrentRow := Row;
            end;
         if Not VoidFlag[Row] and (Row > 0) and (Cells[1, Row] <> '') and
            Not OrderInstruction[Row] and (Supervisor Or DiscountFlag[Row]) then
            begin
             Col := 5; CurrentCol := 5;
             Cells[Col, Row] := Format('%4.2f', [StrToFloat(NumStr)]);
             Changed := True;
             MoveToNextCell;
            end;
        end;
       DiscountKind := NewDiscountKind;
      end;
  2:  begin
       DiscountRate := 0;
       DollarDiscount := StrToFloat(NumStr);
       DiscountKind := NewDiscountKind;
       ProcessDiscount;
      end;
 end;
 if (MaxDollarDiscount >= 0.01) and (DiscountEdit.Caption <> '') and
    (StrToFloat(DiscountEdit.Caption) > MaxDollarDiscount) then
    begin
     MessageBoxForm.MessagePro('Discount is over ' + FormatCurrency(MaxDollarDiscount) + '.' +
     Chr(13) + Chr(10) + Chr(13) + Chr(10) +
     'System will auto change discount to ' + FormatCurrency(MaxDollarDiscount) + '.',
     sErrorMsg);
     DiscountRate := 0;
     DollarDiscount := MaxDollarDiscount;
     DiscountKind := 2;
     ProcessDiscount;
    end;
 DiscountOperator := sUserName;
 CalcBalance;
end;

procedure TTableOrderForm.CategoryPageUpButtonClick(Sender: TObject);
begin
 AutoLogoutTimeCounter := 0;
 if CategoryCurrentPage >= 2 then
    begin
     CategoryCurrentPage := CategoryCurrentPage - 1;
     AssignCategoryKeyBoard;
    end;
 BackPanel.SetFocus;
end;

procedure TTableOrderForm.CategoryPageDownButtonClick(Sender: TObject);
begin
 AutoLogoutTimeCounter := 0;
 if (CategoryCurrentPage * CategoryCount) < CategoryRowCount then
    begin
     CategoryCurrentPage := CategoryCurrentPage + 1;
     AssignCategoryKeyBoard;
    end;
 BackPanel.SetFocus;
end;

procedure TTableOrderForm.PageUpButtonClick(Sender: TObject);
begin
 AutoLogoutTimeCounter := 0;
 if MenuCurrentPage >= 2 then
    begin
     MenuCurrentPage := MenuCurrentPage - 1;
     AssignMenuKeyBoard;
    end;
 BackPanel.SetFocus;
end;

procedure TTableOrderForm.PageDownButtonClick(Sender: TObject);
begin
 AutoLogoutTimeCounter := 0;
 if (MenuCurrentPage * MenuCount) < LastMenuPosition then
    begin
     MenuCurrentPage := MenuCurrentPage + 1;
     AssignMenuKeyBoard;
    end;
 BackPanel.SetFocus;
end;

procedure TTableOrderForm.MenuButtonClick(Sender: TObject);
var
 Num: string;
begin
 AutoLogoutTimeCounter := 0;
 if TitlePanel.Enabled then
    with Sender As TPanelButton do
     begin
      Num := Copy(Name, 5, 2);
      if Caption <>'' then ProcessMenuButtonTouch(StrToInt(Num));
      CalcBalance;
     end;
end;

procedure TTableOrderForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Not ActiveFlag then
    begin
     DataForm.SendToPoleDisp('       Closed', '');
     if FVar.SecondDisplay = 1 then SecondDisplayForm.SetCounterCloseStatus;
     MenuQuery.Close;
     CategoryQuery.Close;
     DataForm.ClosePoleDisplayPort;
     Action := caFree;
    end
   else
    //Action := caNone;
    Action := caFree;
end;

procedure TTableOrderForm.SetDescription(ARow: integer);
var
 Temp, SecondScreenDescriptionTemp: string;
begin
 with StringGrid do
  begin
   Temp := Copy(Cells[1, ARow], 1, 4);
   if (Temp = '[*] ') or (Temp = '[A] ') or (Temp = '[C] ') or (Temp = '[M] ') or (Temp = '[L] ') then
      Temp := Copy(Cells[1, ARow], 5, Length(Cells[1, ARow]) - 4)
    else
      Temp := Cells[1, ARow];
   case Instruction[ARow] of
     0: Cells[1, ARow] := Temp;
     1: Cells[1, ARow] := '[*] ' + Temp;
     2: Cells[1, ARow] := '[A] ' + Temp;
     3: Cells[1, ARow] := '[C] ' + Temp;
     4: Cells[1, ARow] := '[M] ' + Temp;
     5: Cells[1, ARow] := '[L] ' + Temp;
   end;
  end;
  SecondScreenDescriptionTemp := Copy(SecondScreenDescription[ARow], 1, 4);
  if (SecondScreenDescriptionTemp = '[*] ') or (SecondScreenDescriptionTemp = '[A] ') or
     (SecondScreenDescriptionTemp = '[C] ') or (SecondScreenDescriptionTemp = '[M] ') or
     (SecondScreenDescriptionTemp = '[L] ') then
     SecondScreenDescriptionTemp := Copy(SecondScreenDescription[ARow], 5, Length(SecondScreenDescription[ARow]) - 4)
    else
     SecondScreenDescriptionTemp := SecondScreenDescription[ARow];
  case Instruction[ARow] of
   0: SecondScreenDescription[ARow] := SecondScreenDescriptionTemp;
   1: SecondScreenDescription[ARow] := '[*] ' + SecondScreenDescriptionTemp;
   2: SecondScreenDescription[ARow] := '[A] ' + SecondScreenDescriptionTemp;
   3: SecondScreenDescription[ARow] := '[C] ' + SecondScreenDescriptionTemp;
   4: SecondScreenDescription[ARow] := '[M] ' + SecondScreenDescriptionTemp;
   5: SecondScreenDescription[ARow] := '[L] ' + SecondScreenDescriptionTemp;
  end;
end;

procedure TTableOrderForm.InstructionButtonClick(Sender: TObject);
var
 Temp, CurRow: integer;
 ItemCode: string;
 Buff: InstructionBuffType;
begin
 StringGrid.SetFocus;
 CurRow := StringGrid.Row;
 if (StringGrid.Cells[8, CurRow] <> '') and (Instruction[CurRow] > 0) and
    (StringGrid.Cells[8, CurRow] <> '----') and Not OrderInstruction[CurRow] and
    Not VoidFlag[CurRow] then
    begin
     Temp := InstructionForm.InstructionPro;
     if Temp >= 0 then
        begin
         Instruction[CurRow] := Temp;
         SetDescription(CurRow);
        end;
    end
   else
    if (StringGrid.Cells[8, CurRow] <> '') and Not VoidFlag[CurRow] and
       (StringGrid.Cells[8, CurRow] <> '----') and Not OrderInstruction[CurRow] then
       begin
        ItemCode := StringGrid.Cells[8, CurRow];
        if DataForm.CheckInstructionLink(ItemCode) and
           InstructionListForm.InstructionPro(ItemCode, Langurage, Buff) then
           ProcessInstruction(Buff);
       end;
 if StringGrid.Enabled then StringGrid.SetFocus;
end;

procedure TTableOrderForm.TableNoEditClick(Sender: TObject);
var
 TableNo, OrderNo, BookingNo: string;
 Flag: boolean;
begin
 TableNo := TableNoEdit.Caption;
 if BillKind = sTableOrder then
    begin
     if Not ManuallyEnterTableNumber then
        begin
         if ReadOrderNoForm.ReadOrderNoPro(OrderNo, BookingNo, TableNo, TableSeats, sChangeTable) then
            begin
             Flag := True;
             if TableLockFunctionEnabled and ((StatusFlag = sNewStatus) or (OriginalTableNo <> TableNoEdit.Caption)) then
                Flag := DataForm.ReleaseTable(TableNoEdit.Caption);
             if Flag and DataForm.LockTable(TableNo) then
                TableNoEdit.Caption := TableNo;
            end
        end
       else
        begin
         if NumberPadForm.ReadNumberPro(TableNo, False, False, 'Table No.', 0) then
            TableNoEdit.Caption := TableNo;
        end;
    end;
 StringGrid.SetFocus;
end;

procedure TTableOrderForm.PersonEditClick(Sender: TObject);
var
 NumStr: string;
 Flag: boolean;
begin
 NumStr := PersonEdit.Caption;
 repeat
  if Not NumberPadForm.ReadNumberPro(NumStr, False, False, 'People', 0) then Exit;
  Flag := CheckNum(NumStr, 6, 999999, 0, 'D');
  if Flag and TableTracking and (TableSeats >= 1) then
     Flag := (StrToInt(NumStr) <= TableSeats) or
          (MessageBoxForm.MessagePro('This table has ' + IntToStr(TableSeats) +
          ' Seats only, do you request addtional seats?', sConfirmMsg) = mrYes);
 until Flag;
 if Flag then PersonEdit.Caption := NumStr;
 StringGrid.SetFocus;
end;

procedure TTableOrderForm.ProcessDiscount;
var
 I, J: integer;
begin
 if DiscountKind = 0 then
    DiscountTitleLabel.Caption := 'DISCOUNT (' + Format('%4.2f', [DiscountRate]) + '%)'
   else
    DiscountTitleLabel.Caption := 'DISCOUNT';
 for I := 1 to 500 do
  with StringGrid do
   if (Cells[8, I] <> '----') then
      begin
       if (Cells[1, I] <> '') and (DiscountKind < 2) and Not VoidFlag[I] and
          Not OrderInstruction[I] and (DiscountFlag[I] or (ForceVIPDiscount and (sVIPNo > 0))) then
          Cells[5, I] := Format('%4.2f', [DiscountRate])
         else
          Cells[5, I] := '';
      end
     else
      for J := 1 to 85 do Cells[5, I] := Cells[5, I] + '-';
 CalcAmount;
end;

procedure TTableOrderForm.CategoryButtonClick(Sender: TObject);
var
 Num: string;
begin
 AutoLogoutTimeCounter := 0;
 with Sender As TPanelButton do
  begin
   Num := Copy(Name, 9, 2);
   if Caption <>'' then ProcessCategoryButtonTouch(StrToInt(Num));
  end;
end;

function  TTableOrderForm.GetSurchargeRate: double;
var
 CurrentDateTime, SurchargeStartDateTime, SurchargeEndDateTime: TDateTime;
begin
 CurrentDateTime := Date + Time;
 if (Time < SurchargeEndTime) and (SurchargeEndTime < SurchargeStartTime) then
    begin
     SurchargeStartDateTime := Date - 1 + SurchargeStartTime;
     SurchargeEndDateTime := Date + SurchargeEndTime;
    end
   else
    if (Time > SurchargeStartTime) and (SurchargeEndTime < SurchargeStartTime) then
       begin
        SurchargeStartDateTime := Date + SurchargeStartTime;
        SurchargeEndDateTime := Date + 1 + SurchargeEndTime;
       end
      else
       begin
        SurchargeStartDateTime := Date + SurchargeStartTime;
        SurchargeEndDateTime := Date + SurchargeEndTime;
       end;
 if (CurrentDateTime >= SurchargeStartDateTime) and (CurrentDateTime <= SurchargeEndDateTime) then
    Result := ServiceChargeRate
   else
    Result := 0;
end;

function  TTableOrderForm.GetOtherChargeRate: double;
begin
 if OtherChargeEnable then
    Result := OtherChargeRate
   else
    Result := 0;
end;

procedure TTableOrderForm.TableOrderButtonClick(Sender: TObject);
var
 TableNo, BookingNo: string;
 OrderPaymentStatus: boolean;
begin
 PaidEdit.Caption := '0.00';
 ChangeEdit.Caption :='0.00';
 {if Password then
    begin
     if Not DataForm.VerifyPassword(sUserName) then Exit
       else
        //SetButtonStatus;
    end; }
 BackPanel.SetFocus;
 if ManuallyEnterTableNumber then
    begin
     if Not ManuallyEnterTableNoForm.ReadTableNumberPro(TableNo, sOrderNo) then
      begin
        tableServiceCanceled := True;
        Exit;
      end;  
    end
   else
    begin
     if Not ReadOrderNoForm.ReadOrderNoPro(sOrderNo, BookingNo, TableNo, TableSeats, sNewTable) then
      begin
        tableServiceCanceled := True;
        Exit;
      end;  
    end;
 if sOrderNo <> '' then
    begin
     if OpenHeadQuery(sOrderNo) then
        begin
         with Query do
          begin
           TableNo := FieldByName('TableNo').AsString;
           if FieldByName('PriceIncludesGST').AsBoolean then
              OrderPaymentStatus :=
               (FieldByName('Amount').AsFloat +
                FieldByName('Tips').AsFloat +
                FieldByName('Surcharge').AsFloat +
                FieldByName('OtherCharge').AsFloat +
                FieldByName('ServiceCharge').AsFloat -
                FieldByName('PaidAmount').AsFloat) <= 0
             else
              OrderPaymentStatus :=
               (FieldByName('Amount').AsFloat +
               FieldByName('Tips').AsFloat +
               FieldByName('Surcharge').AsFloat +
               FieldByName('OtherCharge').AsFloat +
               FieldByName('ServiceCharge').AsFloat +
               FieldByName('GST').AsFloat -
               FieldByName('PaidAmount').AsFloat) <= 0;
           if OrderPaymentStatus and Not Supervisor and Not AllowEditOrder then
              begin
               Close;
               MessageBoxForm.MessagePro('This bill has been paid in full.' +
                Chr(13) + Chr(10) + Chr(13) + Chr(10) +
               'If you want to modify this bill, please contact your manager.', sErrorMsg);
               Exit;
              end
             else
              if Not Supervisor and NotAllowModify and Not AllowEditOrder and
                 (FieldByName('OrderPrinted').AsBoolean or (FieldByName('InvoiceNo').AsString <> '')) then
                 begin
                  Close;
                  MessageBoxForm.MessagePro('This bill has been printed.' +
                   Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                   'If you want to modify this bill, please contact your manager.', sErrorMsg);
                  Exit;
                 end
                else
                 begin
                  if Not DataForm.LockTable(TableNo) then Exit;
                  ReadHeadData;
                 end
          end;
         if OpenItemQuery(sOrderNo) then ReadItemData;
         ActiveFlag := True;
         Changed := False;
         StatusFlag := sEditStatus;
         //SetButtonStatus;
         TableSeats := 0;
         CalcAmount;
         BalanceEdit.Caption := Format('%4.2m', [StrToFloat(AmountEdit.Caption) - PaidAmount]);
        end
    end
   else
    if TableNo <> '' then
       begin
        if Not DataForm.LockTable(TableNo) then Exit;
        StatusFlag := sNewStatus;
        OriginalTableNo := '';
        CurrentPriceIncludesGST := PriceIncludesGST;
        CurrentGSTRate := DefaultGSTRate;
        ActiveFlag := True;
        Changed := False;
        //SetButtonStatus;
        OrderDateEdit.Caption := FormatDateTime('dd/mm/yyyy', Date);
        OrderDate := Date + Time;
        ServiceEdit.Caption := sUserName;
        TableNoEdit.Caption := TableNo;
        BookingNoEdit.Caption := BookingNo;
        if BookingNo <> '' then
           begin
            OpenBookHeadQuery(BookingNo);
            ReadBookHeadData;
            ReadBookDetailData(BookingNo);
           end;
        InvoiceNo := '';
        Credit := False;
        BillKind := sTABLEORDER;
        CurrentServiceChargeRate := 0;
        if AutoSurcharge then
           CurrentServiceChargeRate := GetSurchargeRate
          else
           CurrentServiceChargeRate := 0;
        CurrentOtherChargeRate := GetOtherChargeRate;
        if PersonCount or (MinimumChargeKind = 1) then PersonEditClick(Sender);
        CalcAmount;
       end;
 if FVar.SecondDisplay = 1 then SecondDisplayForm.SetSalesStatus;
end;

{procedure TTableOrderForm.PhoneOrderAdminButtonClick(Sender: TObject);
begin
 if MainForm.PhoneOrderMenu.Enabled then
    begin
     PhoneOrderAdminForm.PhoneOrderAdminPro;
     DataForm.OpenPoleDisplayPort;
     DataForm.SendToPoleDisp('NEXT CUSTOMER PLEASE', '');
     if FVar.SecondDisplay = 1 then SecondDisplayForm.SetWaitingStatus;
    end
   else
    MessageBoxForm.MessagePro('You have not been authorised to do phone order sale.', sErrorMsg);
end;}

procedure TTableOrderForm.QuickServiceButtonClick(Sender: TObject);
begin
 if MainForm.QuickServiceMenu.Enabled then
    PointOfSalesForm.PointOfsalesPro(True)
   else
    MessageBoxForm.MessagePro('You have not been authorised to do quick service.', sErrorMsg);
end;

procedure TTableOrderForm.PaymentButtonClick(Sender: TObject);
var
 OrderNo, TableNo, BookingNo: string;
 Temp: integer;
 Flag: boolean;
 MinimumCharge: double;
begin
 BackPanel.SetFocus;
 if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not PaymentAuthority then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to do payment.', sErrorMsg);
     Exit;
    end;
 if TableTracking and Not ManuallyEnterTableNumber then
    Flag := ReadOrderNoForm.ReadOrderNoPro(OrderNo, BookingNo, TableNo, Temp, sEditTable)
   else
    Flag := OrderListForm.OrderListPro(OrderNo, TableNo);
 if Flag then
    begin
     if MinimumChargeKind >= 1 then
        begin
         if Not DataForm.CheckMinimumChargeBalance(OrderNo, MinimumCharge) then Exit;
         if MinimumCharge >= 0.01 then
            begin
             if Supervisor then
                begin
                 if (MessageBoxForm.MessagePro('This bill has not reached the minimum charge.' +
                    Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                    'Do you want to pass through?' , sConfirmMsg) = mrNo) then Exit
                end
               else
                begin
                 MessageBoxForm.MessagePro('This bill has not reached minimum charge.', sErrorMsg);
                 Exit;
                end;
            end;
        end;
     ReceiptForm.ReceiptPro(OrderNo);
    end;
end;

procedure TTableOrderForm.PrintJobListButtonClick(Sender: TObject);
var
 OrderNo, TableNo, BookingNo: string;
 Temp: integer;
 Flag: boolean;
begin
 BackPanel.SetFocus;
 if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not PrintJobListAuthority then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to print job list.', sErrorMsg);
     Exit;
    end;
 if TableTracking and Not ManuallyEnterTableNumber then
    Flag := ReadOrderNoForm.ReadOrderNoPro(OrderNo, BookingNo, TableNo, Temp, sEditTable)
   else
    Flag := OrderListForm.OrderListPro(OrderNo, TableNo);
 Application.ProcessMessages;
 if Flag then
    begin
     if Not AutoPrintJobList and ManuallyPrintJobList then
        MenuPrintJobListForm.PrintJobList(OrderNo)
       else
        begin
         PrintJobListControlForm.PrintJobListControlPro(OrderNo, '', True, sConfirmedOrder);
         if AutoPrintCheckList then
            PrintCheckListForm.PrintCheckList(OrderNo, '', True, sConfirmedOrder);
         if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(OrderNo, '', True);
        end
    end;
end;

procedure TTableOrderForm.PrintInvoiceButtonClick(Sender: TObject);
var
 OrderNo, BookingNo, TableNo: string;
 Temp: integer;
 Flag: boolean;
begin
 BackPanel.SetFocus;
 if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not PrintInvoiceAuthority then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to print invoice.', sErrorMsg);
     Exit;
    end;
 if TableTracking and Not ManuallyEnterTableNumber then
    Flag := ReadOrderNoForm.ReadOrderNoPro(OrderNo, BookingNo, TableNo, Temp, sEditTable)
   else
    Flag := OrderListForm.OrderListPro(OrderNo, TableNo);
 Application.ProcessMessages;
 if Not Flag then Exit;
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

procedure TTableOrderForm.PrintBillButtonClick(Sender: TObject);
var
 OrderNo, BookingNo, TableNo: string;
 Temp: integer;
 Flag: boolean;
begin
 BackPanel.SetFocus;
 if TableTracking and Not ManuallyEnterTableNumber then
    Flag := ReadOrderNoForm.ReadOrderNoPro(OrderNo, BookingNo, TableNo, Temp, sEditTable)
   else
    Flag := OrderListForm.OrderListPro(OrderNo, TableNo);
 Application.ProcessMessages;
 if Flag then
    case PrintBillMode of
     0, 1: PrintOrderForm.PrintOrderPro(OrderNo);
     2:    PrintOrderForm1.PrintOrderPro(OrderNo, True);
     3:    PrintOrderForm1.PrintOrderPro(OrderNo, False);
     4:    PrintOrderForm2.PrintOrderPro(OrderNo);
     5:    PrintOrderForm3.PrintOrderPro(OrderNo);
    end;
end;

{procedure TTableOrderForm.ReservationButtonClick(Sender: TObject);
begin
 ReadBookData;
 StringGrid.SetFocus;
end;
}

procedure TTableOrderForm.ServiceEditClick(Sender: TObject);
var
 StaffName: string;
begin
 if Password then
    begin
     if Not DataForm.VerifyPassword(StaffName) then Exit
       else
        begin
         ServiceEdit.Caption := StaffName;
         //SetButtonStatus;
        end
    end
   else
    if StaffListForm.ListStaffPro(StaffName) then
       ServiceEdit.Caption := StaffName;
 StringGrid.SetFocus;
end;

procedure TTableOrderForm.OrderListButtonClick(Sender: TObject);
var
 OrderNo, TableNo: string;
begin
 BackPanel.SetFocus;
 OrderListForm.OrderListPro(OrderNo, TableNo);
end;

procedure TTableOrderForm.DailyReportButtonClick(Sender: TObject);
begin
 BackPanel.SetFocus;
 if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not MainForm.DailyReportMenu.Enabled then
    MessageBoxForm.MessagePro('You have not been authorised to do Daily Report.', sErrorMsg)
   else
    EndOfdayForm.DailyReportPro(0);
end;

function TTableOrderForm.CheckOrderPaymentStatus(OrderNo: string): boolean;
var
 SQLStr: string;
begin
  SQLStr := 'Select SplitBill From OrderH ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
  OpenQuery(SQLStr);
  Result := Query.FieldByName('SplitBill').AsBoolean;
  Query.Close;
end;

procedure TTableOrderForm.SplitBillButtonClick(Sender: TObject);
var
 OrderNo, BookingNo, TableNo: string;
 Temp: integer;
 Flag: boolean;
begin

 BackPanel.SetFocus;
 if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not PaymentAuthority then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to do payment.', sErrorMsg);
     Exit;
    end;
 if TableTracking and Not ManuallyEnterTableNumber then
    Flag := ReadOrderNoForm.ReadOrderNoPro(OrderNo, BookingNo, TableNo, Temp, sEditTable)
   else
    Flag := OrderListForm.OrderListPro(OrderNo, TableNo);
 if Flag then
    begin
     if CheckOrderPaymentStatus(OrderNo) then
        SplitBillForm.SplitBillPro(OrderNo)
       else
        MessageBoxForm.MessagePro('This order can not do split payment.', sErrorMsg);
    end;
end;

procedure TTableOrderForm.OpenDrawerButtonClick(Sender: TObject);
begin
 if Not DataForm.VerifyPassword(sUserName) then Exit
   else
    begin
     //SetButtonStatus;
     if MainForm.OpenCashDrawerMenu.Enabled then
        begin
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
                 if CurrentDrawerNumber >= 0 then
                    DataForm.OpenDrawer(False, CurrentDrawerNumber);
                end
             end
            else
             begin
              CurrentDrawerNumber := DefaultDrawerPortNumber;
              DataForm.OpenDrawer(False, CurrentDrawerNumber);
             end;
        end
       else
        MessageBoxForm.MessagePro('You have not been authorised to open the drawer.', sErrorMsg);
    end;
end;

procedure TTableOrderForm.TableStatusButtonClick(Sender: TObject);
var
 OrderDate: string;
begin
 if TableTracking then
    begin
     OrderDate := FormatDateTime('dd/mm/yyyy', Date);
     TableStatusForm.TableStatusPro(OrderDate);
    end
   else
    MessageBoxForm.MessagePro('System has not been setup for table tracking.', sErrorMsg);
end;

procedure TTableOrderForm.PayOutClick(Sender: TObject);
begin
 CashPayOutButtonClick(Sender);
end;

procedure TTableOrderForm.CashPayOutButtonClick(Sender: TObject);
begin
 if Password then
    begin
     if Not DataForm.VerifyPassword(sUserName) then Exit
       else
        //SetButtonStatus;
    end;
 if MainForm.CashPayOutMenu.Enabled then
    PayOutForm.PayOutPro
   else
    MessageBoxForm.MessagePro('You have not been authorised to do Cash Payout.', sErrorMsg);
 BackPanel.SetFocus;
end;

procedure TTableOrderForm.SeatNumberButtonClick(Sender: TObject);
var
 NumStr: string;
begin
 with StringGrid do
  begin
   SetFocus;
   if (Cells[1, Row] = '') or OrderInstruction[Row] then Row := GetLastNonInstructionItem;
   if (Row > 0) and (Cells[1, Row] <> '') and (Cells[8, Row] <> '----') and Not VoidFlag[Row] then
      begin
        NumStr := Cells[6, Row];
        if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Customer Seat No', 0) then
           begin
            Col := 6; CurrentCol := 6;
            Cells[Col, Row] := NumStr;
          end;
      end;
  end;
end;

procedure TTableOrderForm.ConvertLangurage(FirstRow, EndRow: integer);
var
 SQLStr, Description, FieldName: string;
 I: integer;
begin
 for I := FirstRow to EndRow do
  with StringGrid do
   begin
    if (Cells[8, I] <> '') and (Cells[8, I] <> '----') then
       begin
        SQLStr := 'Select Description1, Description2, SubDescription, ' +
           'SubDescription1, SubDescription2, SubDescription3, Multiple ' +
           'From MenuItem ' +
           'Where ItemCode=' + Chr(39) + CheckQuotes(Cells[8, I]) + Chr(39);
        if OpenQuery(SQLStr) then
           begin
            if Langurage or (Query.FieldByName('Description2').AsString = '') then
               Description := Query.FieldByName('Description1').AsString
              else
               Description := Query.FieldByName('Description2').AsString;
            Cells[1, I] := Description;
            if Query.FieldByName('Multiple').AsBoolean then
               begin
                FieldName := GenerateSubDescriptionFieldName(PriceSelect[I]);
                if Query.FieldByName(FieldName).AsString <> '' then
                   Cells[1, I] := Cells[1, I] + ' / ' + Query.FieldByName(FieldName).AsString;
               end;
            SetDescription(I);
           end;
       Query.Close;
     end;
   end;
end;

procedure TTableOrderForm.LangurageButtonClick(Sender: TObject);
begin
 AutoLogoutTimeCounter := 0;
 Langurage := Not Langurage;
 AssignCategoryKeyBoard;
 AssignMenuKeyBoard;
 ConvertLangurage(1, 500);
 BackPanel.SetFocus;
end;

procedure TTableOrderForm.UpdatePoleMessage;
var
 I: integer;
 Price, Qty: double;
 S1, S2: string;
begin
 with StringGrid do
  begin
   I := Row;
   if (Cells[1, I] = '') Or OrderInstruction[I] then
      begin
       if (Row > 1) and (Cells[1, I - 1] <> '') then
          I := I - 1;
      end;
   if (Cells[1, I] <> '') and (Cells[8, I] <> '----') then
      begin
       S1 := Cells[1, I];
       if Cells[2, I] <> '' then
          Qty := StrToFloat(Cells[2, I])
         else
          Qty := 0;
       if Cells[3, I] <> '' then
          Price := StrToFloat(Cells[3, I])
         else
          Price := 0;
       poleAmount := Price * Qty;
       poleSubtotal := poleSubtotal + poleAmount;
       if FVar.SendDescription = 0 then
          begin
           S1 := FormatCurrency(Price) + ' X ' + Format('%4.2f', [Qty]);
           S1 := Format('%20s', [S1]);
           //S2 := 'Amount' + Format('%14s', [FormatCurrency(Qty * Price)]);
           S2 := 'Subtotal' + Format('%12s', [FormatCurrency(poleSubtotal)]);
          end
         else
          begin
           S1 := Copy(Cells[1, I], 1, 20);
           if Length(S1) < 20 then
              S1 := S1 + Format('%' + IntToStr(20 - Length(S1)) + 's', [' ']);
           S2 := FormatCurrency(Price) + ' X ' + Format('%4.2f', [Qty]);
           S2 := Format('%20s', [S2]);
          end;
       if FVar.PoleDisplayPort > 0 then DataForm.SendToPoleDisp(S1, S2);
       if FVar.SecondDisplay = 1 then SecondDisplayForm.SetSalesStatus;
      end;
  end;
end;

procedure TTableOrderForm.DirectPaymentPro;
var
 OrderNo, PayBy1, PayBy2, SQLStr: string;
 TotalSales, Receivable, CurrentTips, Payment1, Payment2, Rounding,
 CurrentSurcharge, Change: double;
 ID, AwardPoints, DepositID1, DepositID2: integer;
 Flag, LinkToEFTPOS: boolean;
begin
 EditPanel.Enabled := False;
 TableTransfered := (OriginalTableNo <> TableNoEdit.Caption) and (StatusFlag = sEditStatus);
 TotalSales := StrToFloat(TotalEdit.Caption);
 if (StatusFlag = sEditStatus) and (sOrderNo <> '') then
    begin
     SQLStr := 'Select Sum(PaidAmount) From RecvAcct ' +
               'Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
     OpenQuery(SQLStr);
     Receivable := TotalSales + Tips + Surcharge - Query.Fields[0].AsFloat;
     SQLStr := 'Select Max(IDNo) From RecvAcct ' +
               'Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
     OpenQuery(SQLStr);
     if Query.Active and (Query.RecordCount <> 0) then
        ID := Query.Fields[0].AsInteger + 1
       else
        ID := 1;
     Query.Close;
    end
   else
    begin
     Receivable := TotalSales;
     ID := 1;
    end;
 {if Not POSReceiptForm.ReceiptPro(TotalSales, Receivable, CurrentTips, Payment1, Payment2,
    Rounding, CurrentSurcharge, Change, PayBy1, PayBy2, LinkToEFTPOS, sVIPNo, DepositID1, DepositID2) or
    Not SaveOrderPro(OrderNo) then
    begin
     CalcAmount;
     EditPanel.Enabled := True;
     Exit;
    end;}

 //Payment1 := PaidAmount;
 //Payby1 := 'CASH';
 if Not POSReceiptForm.ReceiptPro(TotalSales, Receivable, CurrentTips, Payment1, Payment2,
    Rounding, CurrentSurcharge, Change, PayBy1, PayBy2, LinkToEFTPOS, sVIPNo, DepositID1, DepositID2) or
    Not SaveOrderPro(OrderNo) then
    begin
     CalcAmount;
     EditPanel.Enabled := True;
     Exit;
    end;
 //ChangeEdit.Caption := Format('%4.2f', [Change]);
 Application.ProcessMessages;
 PaidAmount := Payment1;
 if Not OnlyOpenDrawerForCashPayment or
    ((Uppercase(PayBy1) = 'CASH') and (ABS(Payment1) >= 0.01)) or
    ((Uppercase(PayBy2) = 'CASH') and (ABS(Payment2) >= 0.01)) or
    (ABS(Change) >= 0.01) then
    begin
     CurrentDrawerNumber := DefaultDrawerPortNumber;
     DataForm.OpenDrawer(True, CurrentDrawerNumber);
    end;
 Flag := True;
 ChangeEdit.Caption := Format('%4.2f', [Change]);
 if Not DataForm.BeginTransaction then
    begin
     EditPanel.Enabled := True;
     Exit;
    end;
 try
  if ABS(Payment1) > 0.005 then
     Flag := DataForm.SaveAccountRecord(OrderNo, Payment1, PayBy1, ID, DepositID1);
  if Flag and (ABS(Payment2) > 0.005) then
     Flag := DataForm.SaveAccountRecord(OrderNo, Payment2, PayBy2, ID + 1, DepositID2);
  if Flag and (Change >= -0.001) and (ABS(Rounding) > 0.005) then
     Flag := DataForm.SaveAccountRecord(OrderNo, -Rounding, 'ROUNDING', ID + 2, 0);
  if Flag and (Change >= 0.009) then
     Flag := DataForm.SaveAccountRecord(OrderNo, -Change, 'CASH', ID + 3, 0);
  if Flag then
     Flag := DataForm.UpdateOrderPayment(OrderNo, False);
  if Flag and LoyaltyAwardAvailible and (sVIPNo >= 1) and (TotalSales > 0) then
     begin
      AwardPoints := Round(TotalSales * SalesPoints);
      Flag := DataForm.SaveAwardPoints(OrderNo, sVIPNo, AwardPoints);
     end;
  if Flag and ((DepositID1 >= 1) or (DepositID2 >= 1)) then
     begin
      SQLStr := 'Update OrderH Set Credit = 1 Where OrderNo = '+ Chr(39) + CheckQuotes(OrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag and (ABS(CurrentTips + Tips) >= 0.01) then
     begin
      SQLStr := 'Update OrderH Set Tips = Tips + ' + FloatToStr(CurrentTips) +
                ' Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag and (ABS(Surcharge + CurrentSurcharge) >= 0.01) then
     begin
      SQLStr := 'Update OrderH Set Surcharge = Surcharge + ' + FloatToStr(CurrentSurcharge) +
                ' Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if AutoPrintInvoice then Flag := DataForm.SetInvoiceNo(OrderNo);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      SendToSecurityPortPro('[Payment] Button Clicked', PayBy1, PayBy2, Payment1, Payment2, Rounding, Change);
      if (AutoPrintBill and (BillKind <> sQuickSale)) or
         (AutoPrintPOSOrderList and (BillKind = sQuickSale)) then
         case PrintBillMode of
          0, 1: PrintOrderForm.PrintOrderPro(OrderNo);
          2:    PrintOrderForm1.PrintOrderPro(OrderNo, True);
          3:    PrintOrderForm1.PrintOrderPro(OrderNo, False);
          4:    PrintOrderForm2.PrintOrderPro(OrderNo);
          5:    PrintOrderForm3.PrintOrderPro(OrderNo);
         end;
      if (AutoPrintInvoice and (BillKind <> sQuickSale)) or
         (AutoPrintPOSInvoice and (BillKind = sQuickSale)) then
         case PrintInvoiceMode of
          0, 1: PrintInvoiceForm.PrintInvoicePro(OrderNo);
          2:    PrintInvoiceForm1.PrintInvoicePro(OrderNo, True);
          3:    PrintInvoiceForm1.PrintInvoicePro(OrderNo, False);
          4:    PrintInvoiceForm2.PrintInvoicePro(OrderNo);
          5:    PrintInvoiceForm3.PrintInvoicePro(OrderNo);
         end;
      if (BillKind <> sQUICKSALE) or AutoPrintPOSJobList then
         PrintJobListPro(OrderNo);
      if TableTransfered then
         PrintTableTransferSlip(OrderNo, OriginalTableNo, TableNoEdit.Caption);
      //if ShowPrintInvoiceWindow then
         DispPOSReceiptForm.DispReceiptPro(TotalSales, Receivable, CurrentTips, Payment1,
         Payment2, Rounding, CurrentSurcharge, Change, PayBy1, PayBy2, OrderNo);
      InitForm;
      ActiveFlag := False;
      //SetButtonStatus;
      Application.ProcessMessages;
     end
    else
     begin
      DataForm.RollBack;
      EditPanel.Enabled := True;
     end;
 end;

end;


procedure TTableOrderForm.DirectPaymentButtonClick1(Sender: TObject);
var
 OrderNo: string;
 TotalSales, MinimumCharge: double;
begin
 if Not PaymentAuthority then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to do payment.', sErrorMsg);
     Exit;
    end;
 EditPanel.Enabled := False;
 if (StatusFlag <> sEditStatus) and (FindLastRow = 1) then
    begin
     EditPanel.Enabled := True;
     Exit;
    end;
 CalcAmount;
 if (MaxDollarDiscount >= 0.01) and (DiscountEdit.Caption <> '') and
    (StrToFloat(DiscountEdit.Caption) > MaxDollarDiscount) then
    begin
     MessageBoxForm.MessagePro('Discount is over ' + FormatCurrency(MaxDollarDiscount) + '.' +
     Chr(13) + Chr(10) + Chr(13) + Chr(10) +
     'System will auto change discount to ' + FormatCurrency(MaxDollarDiscount) + '.',
     sErrorMsg);
     DiscountRate := 0;
     DollarDiscount := MaxDollarDiscount;
     DiscountKind := 2;
     ProcessDiscount;
    end;
 TotalSales := StrToFloat(TotalEdit.Caption);
 if (TotalSales < 0) and Not AuthoriseRefund then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to do sales refund.', sErrorMsg);
     EditPanel.Enabled := True;
     StringGrid.SetFocus;
     Exit;
    end
   else
    begin
     if (MinimumChargeKind >= 1) and CalcMinimumChargeBalance(MinimumCharge) then
        begin
         if MinimumCharge >= 0.01 then
            begin
             if Supervisor then
                begin
                 if (MessageBoxForm.MessagePro('This bill has not reached the minimum charge.' +
                    Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                    'Do you want to pass through?' , sConfirmMsg) = mrNo) then
                    begin
                     EditPanel.Enabled := True;
                     Exit;
                    end;
                end
               else
                begin
                 MessageBoxForm.MessagePro('This bill has not reached minimum charge.', sErrorMsg);
                 EditPanel.Enabled := True;
                 Exit;
                end;
            end;
        end;
     if Not AutoSaveOrder then
        DirectPaymentPro
        //QuickPaymen()
       else
        begin
         TableTransfered := (OriginalTableNo <> TableNoEdit.Caption) and (StatusFlag = sEditStatus);
         if SaveOrderPro(OrderNo) then
           begin
            SendToSecurityPortPro('[Payment] Button Clicked', '', '', 0, 0, 0, 0);
            if AutoPrintPOSJobList then PrintJobListPro(OrderNo);
            if TableTransfered then PrintTableTransferSlip(OrderNo, OriginalTableNo, TableNoEdit.Caption);
            Application.ProcessMessages;
            ReceiptForm.ReceiptPro(OrderNo);
            InitForm;
            ActiveFlag := False;
            //SetButtonStatus;
            Application.ProcessMessages;
           end
          else
           EditPanel.Enabled := True;
        end;
    end;
    ExitButtonClick(sender);

end;

procedure TTableOrderForm.DirectPaymentButtonClick(Sender: TObject);
var
 OrderNo: string;
 TotalSales, MinimumCharge: double;
begin
 if Not PaymentAuthority then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to do payment.', sErrorMsg);
     Exit;
    end;
 EditPanel.Enabled := False;
 if (StatusFlag <> sEditStatus) and (FindLastRow = 1) then
    begin
     EditPanel.Enabled := True;
     Exit;
    end;
 CalcAmount;
 if (MaxDollarDiscount >= 0.01) and (DiscountEdit.Caption <> '') and
    (StrToFloat(DiscountEdit.Caption) > MaxDollarDiscount) then
    begin
     MessageBoxForm.MessagePro('Discount is over ' + FormatCurrency(MaxDollarDiscount) + '.' +
     Chr(13) + Chr(10) + Chr(13) + Chr(10) +
     'System will auto change discount to ' + FormatCurrency(MaxDollarDiscount) + '.',
     sErrorMsg);
     DiscountRate := 0;
     DollarDiscount := MaxDollarDiscount;
     DiscountKind := 2;
     ProcessDiscount;
    end;
 TotalSales := StrToFloat(TotalEdit.Caption) - PaidAmount;
 if (TotalSales < 0) and Not AuthoriseRefund then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to do sales refund.', sErrorMsg);
     EditPanel.Enabled := True;
     StringGrid.SetFocus;
     Exit;
    end
   else
    begin
     if (MinimumChargeKind >= 1) and CalcMinimumChargeBalance(MinimumCharge) then
        begin
         if MinimumCharge >= 0.01 then
            begin
             if Supervisor then
                begin
                 if (MessageBoxForm.MessagePro('This bill has not reached the minimum charge.' +
                    Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                    'Do you want to pass through?' , sConfirmMsg) = mrNo) then
                    begin
                     EditPanel.Enabled := True;
                     Exit;
                    end;
                end
               else
                begin
                 MessageBoxForm.MessagePro('This bill has not reached minimum charge.', sErrorMsg);
                 EditPanel.Enabled := True;
                 Exit;
                end;
            end;
        end;
     if Not AutoSaveOrder then
        //DirectPaymentPro
        QuickPaymen()
       else
        begin
         TableTransfered := (OriginalTableNo <> TableNoEdit.Caption) and (StatusFlag = sEditStatus);
         if SaveOrderPro(OrderNo) then
           begin
            SendToSecurityPortPro('[Payment] Button Clicked', '', '', 0, 0, 0, 0);
            if AutoPrintPOSJobList then PrintJobListPro(OrderNo);
            if TableTransfered then PrintTableTransferSlip(OrderNo, OriginalTableNo, TableNoEdit.Caption);
            Application.ProcessMessages;
            ReceiptForm.ReceiptPro(OrderNo);
            InitForm;
            ActiveFlag := False;
            //SetButtonStatus;
            Application.ProcessMessages;
           end
          else
           EditPanel.Enabled := True;
        end;
    end;
   ExitButtonClick(Sender);  

end;

procedure TTableOrderForm.InsertLine(CurrentLine: integer);
var
 I, J: integer;
begin
 for I := 500 Downto CurrentLine + 1 do
  begin
   for J := 1 to 8 do StringGrid.Cells[J, I] := StringGrid.Cells[J, I - 1];
   EditFlag[I] := EditFlag[I - 1];
   VoidFlag[I] := VoidFlag[I - 1];
   OrderInstruction[I] := OrderInstruction[I - 1];
   PrintFlag[I] := PrintFlag[I - 1];
   CheckListPrinted[I] := CheckListPrinted[I - 1];
   SentToKitchen[I] := SentToKitchen[I - 1];
   OpenPrice[I] := OpenPrice[I - 1];
   DiscountFlag[I] := DiscountFlag[I - 1];
   Instruction[I] := Instruction[I - 1];
   PriceSelect[I] := PriceSelect[I - 1];
   PaidQty[I] := PaidQty[I - 1];
   VoidReason[I] := VoidReason[I - 1];
   OrderOperator[I] := OrderOperator[I - 1];
   OriginalPrice[I] := OriginalPrice[I - 1];
   SecondScreenDescription[I] := SecondScreenDescription[I - 1];
  end;
 InitCells(CurrentLine);
end;

procedure TTableOrderForm.SplitLineButtonClick(Sender: TObject);
var
 I, J: integer;
begin
 AutoLogoutTimeCounter := 0;
 if ActiveFlag and StringGrid.Enabled and Not OrderInstruction[CurrentRow] and
   (StringGrid.Cells[8, CurrentRow] <> '----') and
   ((CurrentRow > 1) and (StringGrid.Cells[8, CurrentRow - 1] <> '----')) and
   ((CurrentRow < 500) and (StringGrid.Cells[8, CurrentRow + 1] <> '----')) then
    begin
     if StringGrid.Cells[1, CurrentRow] <> '' then InsertLine(CurrentRow);
     StringGrid.Row := CurrentRow;
     CurrentCol := 1; StringGrid.Col := 1;
     StringGrid.Cells[8, CurrentRow] := '----';
     for J := 1 to 7 do
       for I := 1 to 85 do
         StringGrid.Cells[J, CurrentRow] := StringGrid.Cells[J, CurrentRow] + '-';
     for I := 1 to 100 do
      SecondScreenDescription[CurrentRow] := SecondScreenDescription[CurrentRow] + '-';
     StringGrid.SetFocus;
     if FVar.SecondDisplay = 1 then PostDataToSecondDisplayPro;
    end
   else
    BackPanel.SetFocus;
end;

{procedure TTableOrderForm.ReservationListButtonClick(Sender: TObject);
var
 BookingNo: string;
 Temp: integer;
begin
 BookingSearchForm.SearchPro(BookingNo, Temp)
end;  }

{procedure TTableOrderForm.ViewIngredientsButtonClick(Sender: TObject);
var
 ItemCode: string;
begin
 if (StringGrid.Cells[8, CurrentRow] <> '') and (StringGrid.Cells[8, CurrentRow] <> '----') then
    begin
     ItemCode := StringGrid.Cells[8, CurrentRow];
     ShowIngredientsForm.ShowIngredientsPro(ItemCode);
    end;
end;}

procedure TTableOrderForm.VIPListButtonClick(Sender: TObject);
var
 OldVIPNo, VIPPoints: integer;
 AvailableCredit, VIPDiscountRate: double;
 VIPName: string;
begin
 OldVIPNo := sVIPNo;
 if VIPListForm.VIPListPro(sVIPNo) then
    begin
     if DataForm.ReadVIPInformation(sVIPNo, VIPName, VIPDiscountRate) then
        begin
         DiscountRate := VIPDiscountRate;
         if VIPDiscountRate > 0 then DiscountOperator := sUserName;
         VIPNameEdit.Caption := VIPName;
        end
       else
        begin
         DiscountRate := 0;
         DiscountOperator := '';
         VIPNameEdit.Caption := '';
        end
    end
   else
    begin
     DiscountRate := 0;
     VIPNameEdit.Caption := '';
     RewardPointsDiscount := 0;
     if (sOrderNo <> '') and (OldVIPNo >= 1) and (RewardPointsDiscount > 0.01) then
        DataForm.SavePointsPayment(sOrderNo, OldVIPNo, 0);
     RewardPointsDiscount := 0;
     sVIPNo := 0;
    end;
 DiscountKind := 0;
 ProcessDiscount;
 if LoyaltyAwardAvailible and (ReachPoints >= 1) and (sVIPNo > 0) then
    begin
     VIPPoints := Trunc(DataForm.GetVIPAwardPoints(sVIPNo, ''));
     if VIPPoints >= ReachPoints then
        MessageBoxForm.MessagePro('This V.I.P. customer points has reached ' +
         Format('%1d', [VIPPoints]) + ' Points.', sInformationMsg);
    end;
 if (FVar.SecondDisplay = 1) then
    begin
     SecondDisplayForm.AvailableCreditLabel.Visible := False;
     SecondDisplayForm.AvailableCreditEdit.Visible := False;
     if (sVIPNo > 0) then
        AvailableCredit := DataForm.GetAvailableCredit(sVIPNo)
       else
        AvailableCredit := 0;
     if AvailableCredit >= 0.01 then
        begin
         SecondDisplayForm.AvailableCreditLabel.Visible := True;
         SecondDisplayForm.AvailableCreditEdit.Visible := True;
         SecondDisplayForm.AvailableCreditEdit.Caption := Format('%4.2m', [AvailableCredit]);
        end;
    end;
 StringGrid.SetFocus;
end;
       
procedure TTableOrderForm.CustomerNameButtonClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    begin
     VIPNameEdit.Caption := Copy(Str, 1, 30);
     if sVIPNo >= 1 then
        begin
         sVIPNo := 0;
         DiscountRate := 0;
         DiscountKind := 0;
         ProcessDiscount;
        end;
    end;
end;    

procedure TTableOrderForm.DirectPrintBillButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 EditPanel.Enabled := False;
 if ((StatusFlag = sEditStatus) or (FindLastRow > 1)) and SaveOrderPro(OrderNo) then
    begin
     InitForm;
     ActiveFlag := False;
     //SetButtonStatus;
     Application.ProcessMessages;
     case PrintBillMode of
      0, 1: PrintOrderForm.PrintOrderPro(OrderNo);
      2:    PrintOrderForm1.PrintOrderPro(OrderNo, True);
      3:    PrintOrderForm1.PrintOrderPro(OrderNo, False);
      4:    PrintOrderForm2.PrintOrderPro(OrderNo);
      5:    PrintOrderForm3.PrintOrderPro(OrderNo);
     end;
     PrintJobListPro(OrderNo);
    end
   else
    EditPanel.Enabled := True; 
end;

procedure TTableOrderForm.VIPManagerButtonClick(Sender: TObject);
var
 Temp: integer;
begin
 BackPanel.SetFocus;
 if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not MainForm.VIPInformationMenu.Enabled then
    MessageBoxForm.MessagePro('You have not been authorised to do VIP Manager.', sErrorMsg)
   else
    VIPListForm.VIPListPro(Temp);
end;

procedure TTableOrderForm.MenuSetupPro;
begin
 if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not MainForm.MenuSetupMenu.Enabled then
    MessageBoxForm.MessagePro('You have not been authorised to do menu setup.', sErrorMsg)
   else
    if MenuItemForm.MenuSetup(0) then
       begin
        OpenCategory;
        AssignCategoryKeyBoard;
        ProcessCategoryButtonTouch(1);
        AssignMenuKeyBoard;
       end;
end;

procedure TTableOrderForm.PrintGoWithMessage(OrderNo, InstructionMsg: string);
var
 I: integer;
 SQLStr, TableNo, Lines: string;
begin
 if Not OpenHeadQuery(OrderNo) then Exit;
 with Query do
  begin
   if Active and (RecordCount > 0) then
      TableNo := FieldByName('TableNo').AsString
     else
      TableNo := '';
   Close;
  end;
 if TableNo = '' then Exit;
 SQLStr := 'Select PrinterPort From ' +
           '( Select PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           'Union ' +
           'Select PrinterPort1 As PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           'Union ' +
           'Select PrinterPort2 PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           'Union ' +
           'Select PrinterPort3 PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           ') As TempTable Group By PrinterPort Order By PrinterPort';
 OpenQuery(SQLStr);
 Lines := '';
 for I := 1 to 20 do Lines := Lines + '=';
 with Query do
  begin
   First;
   while Not EOF do
    begin
     I := FieldByName('PrinterPort').AsInteger;
     if (I > 0) and (String(FVar.POSPrinter[I].Name) <> 'N/A') and (FVar.GoWithMessage[I] > 0) then
         begin
          DataForm.OpenPrinterPort(I);
          DataForm.SetBlackFontB;
          DataForm.OutPutToPrinter(Lines);
          DataForm.OutPutToPrinter('GO WITH TABLE: ' + TableNo);
          if InstructionMsg <> '' then DataForm.OutPutToPrinter(InstructionMsg);
          DataForm.OutPutToPrinter(FormatDateTime('dd/mm/yyyy hh:mmAM/PM', Date + Time));
          DataForm.OutPutToPrinter(Lines);
          DataForm.OutPutToPrinter(' ');
          DataForm.OutPutToPrinter(' ');
          DataForm.CutPaper;
          DataForm.ClosePrinterPort;
         end;
     Next;
    end;
   Close;
  end;
end;

procedure TTableOrderForm.PrintTableTransferSlip(OrderNo, OriginalTable, TargetTableNo: string);
var
 I: integer;
 SQLStr, Lines, Temp: string;
begin
 SQLStr := 'Select PrinterPort From ' +
           '( Select PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           'Union ' +
           'Select PrinterPort1 As PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           'Union ' +
           'Select PrinterPort2 PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           'Union ' +
           'Select PrinterPort3 PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           ') As TempTable Group By PrinterPort Order By PrinterPort';
 OpenQuery(SQLStr);
 Lines := '';
 for I := 1 to 20 do Lines := Lines + '=';
 with Query do
  begin
   First;
   while Not EOF do
    begin
     I := FieldByName('PrinterPort').AsInteger;
     if (I > 0) and (String(FVar.POSPrinter[I].Name) <> 'N/A') then
         begin
          DataForm.OpenPrinterPort(I);
          DataForm.SetBlackFontB;
          DataForm.OutPutToPrinter(Lines);
          DataForm.OutPutToPrinter('TABLE TRANSFER:');
          Temp := OriginalTableNo + ' Move To ' + TargetTableNo;
          Temp := Format('%' + IntToStr((20 - Length(Temp)) div 2) + 's%s', [' ', Temp]);
          DataForm.OutPutToPrinter(Temp);
          DataForm.OutPutToPrinter(FormatDateTime('dd/mm/yyyy hh:mmAM/PM', Date + Time));
          DataForm.OutPutToPrinter(Lines);
          DataForm.OutPutToPrinter(' ');
          DataForm.OutPutToPrinter(' ');
          DataForm.CutPaper;
          DataForm.ClosePrinterPort;
         end;
     Next;
    end;
   Close;
  end;
end;

procedure TTableOrderForm.MenuSetupButtonClick(Sender: TObject);
begin
 MenuSetupPro;
end;

procedure TTableOrderForm.DepositButtonClick(Sender: TObject);
begin
 if Password then
    begin
     if Not DataForm.VerifyPassword(sUserName) then Exit
       else
        //SetButtonStatus;
    end;
 if MainForm.DepositMenu.Enabled then
    DepositForm.DepositPro(0)
   else
    MessageBoxForm.MessagePro('You have not been authorised to receive deposit.', sErrorMsg);
 BackPanel.SetFocus;
end;


procedure TTableOrderForm.WeightButtonClick(Sender: TObject);
var
 Flag: boolean;
 Weight: double;
begin
 if FVar.ScalePort = 0 then Exit;
 with StringGrid do
  begin
   SetFocus;
   if Cells[1, Row] = '' then
      begin
       Row := GetLastNonInstructionItem;
       CurrentRow := Row;
     end;
   Flag := False;
   case FVar.ScaleModel of
    0, 5:    Flag := DataForm.ReadDataFromScaleCASAP1W(Weight);  // CAS AP-1W, ACom
    1, 2: Flag := DataForm.ReadDataFromScalePSC(Weight);  // PSC Mettler
    3:    Flag := DataForm.ReadDataFromScaleWedderburn(Weight); // Wedderburn
    4:    Flag := DataForm.ReadDataFromScaleCASPDII(Weight);  // CAS PD-II
   end;
   if Flag and (Row > 0) and (Cells[1, Row] <> '') and (Cells[8, Row] <> '----') and
      Not VoidFlag[Row] and (EditFlag[Row] or Supervisor or Not NotAllowChangeQty) then
      begin
       Col := 2; CurrentCol := 2;
       Cells[Col, Row] := FloatToStr(Weight);
       Changed := True;
       MoveToNextCell;
      end;
  end;
end;


procedure TTableOrderForm.SpellInstructionButtonClick(Sender: TObject);
var
 Temp: string;
 CurRow: integer;
begin
 with StringGrid do
  begin
   CurRow := Row;
   if Not EditFlag[CurRow] or
      ((CurRow > 1) and OrderInstruction[CurRow - 1]) or
      ((Cells[1, CurRow] = '') and (CurRow > 1) and (Cells[1, CurRow - 1] = '')) or
      (Cells[8, CurRow] = '----') or
      ((CurRow > 1) and (Cells[8, CurRow - 1] = '----')) then Exit;
   if (CurRow > 0) and (Cells[1, CurRow] <> '') and Not OrderInstruction[CurRow] then
      CurRow := FindLastRow;
   if (KeyboardForm.KeyboardPro(Temp)) and (Temp <> '') then
      begin
       Cells[1, CurRow] := Temp;
       OrderInstruction[CurRow] := True;
       Instruction[CurRow] := 1;
       SecondScreenDescription[CurRow] := Temp;
      end;
   SetFocus;
  end;
end;

procedure TTableOrderForm.RewardPointsProcess;
var
 CurrentSalesAmount, AsDollars: double;
begin
 if Not LoyaltyAwardAvailible then
    MessageBoxForm.MessagePro('Loyalty function is inactive.', sErrorMsg)
   else
    begin
     if sVIPNo = 0 then VIPListButtonClick(Self);
     if sVIPNo = 0 then
        MessageBoxForm.MessagePro('This order has not been entered the V.I.P. number!', sErrorMsg)
      else
       begin
        CurrentSalesAmount := StrToFloat(AmountEdit.Caption) - StrToFloat(DiscountEdit.Caption);
        if RewardPointsForm.GetRewardPointsPro(AsDollars, sVIPNo, CurrentSalesAmount, OrderNoEdit.Caption) then
           begin
            RewardPointsDiscount := AsDollars;
            CalcAmount;
           end;
       end;
    end;
end;

procedure TTableOrderForm.AccountPaymentPro;
var
 SQLStr, OrderNo: string;
 CurrentSalesAmount: double;
 Flag: boolean;
begin
 EditPanel.Enabled := False;
 if sVIPNo = 0 then
    begin
     MessageBoxForm.MessagePro('This order has not been entered the V.I.P. number!', sErrorMsg);
     EditPanel.Enabled := True;
     Exit;
    end;
 CurrentSalesAmount := StrToFloat(TotalEdit.Caption);
 if StatusFlag = sEditStatus then
    OrderNo := OrderNoEdit.Caption
   else
    OrderNo := '';
 if Not DataForm.CheckVIPCreditStatus(sVIPNo, CurrentSalesAmount, OrderNo) then
    begin
     MessageBoxForm.MessagePro('This customer credit is over.', sErrorMsg);
     EditPanel.Enabled := True;
     Exit;
    end;
 if MessageBoxForm.MessagePro('Are you sure you want to put this order to account payment?', sConfirmMsg) = mrNo then
    begin
     EditPanel.Enabled := True;
     Exit;
    end;
 if SaveOrderPro(OrderNo) then
    begin
     InitForm;
     ActiveFlag := False;
     //SetButtonStatus;
     Application.ProcessMessages;
     SQLStr := 'Update OrderH Set Credit = 1 Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
     Flag := False;
     if DataForm.BeginTransaction then
        try
         Flag := DataForm.ExecQueryPro(SQLStr);
        finally
         if Flag then
            begin
             DataForm.CommitTransaction;
             if (BillKind <> sQUICKSALE) or AutoPrintPOSJobList then
                PrintJobListPro(OrderNo);
            end
           else
            DataForm.RollBack;
        end;
    end
   else
    EditPanel.Enabled := True;
end;

procedure TTableOrderForm.ChangeMenuButtonClick(Sender: TObject);
begin
 MenuSetupPro;
end;

procedure TTableOrderForm.SetButtonStatus;
begin
 EditPanel.Visible := ActiveFlag;
 EditPanel.Enabled := ActiveFlag;
 ControlPanel.Visible := Not ActiveFlag;
 ControlPanel.Enabled := Not ActiveFlag;
 StringGrid.Enabled := ActiveFlag;
 TitlePanel.Enabled := ActiveFlag;
end;

procedure TTableOrderForm.ZoomButtonClick(Sender: TObject);
var
 CurrentRow: integer;
begin
 AutoLogoutTimeCounter := 0;
 if ActiveFlag then
    begin
     CurrentRow := FindLastRow;
     EditPanel.Visible := Not EditPanel.Visible;
     if EditPanel.Visible then
        begin
         TotalPanel.Top := BackPanel.Height - TotalPanel.Height - EditPanel.Height - 6;
         StringGridPanel.Height := BackPanel.Height - TotalPanel.Height - EditPanel.Height - TitlePanel.Height - 12;
         if CurrentRow > 12 then
            StringGrid.TopRow := CurrentRow - 11
           else
            StringGrid.TopRow := 1;
        end
       else
        begin
         TotalPanel.Top := BackPanel.Height - TotalPanel.Height - 4;
         StringGridPanel.Height := BackPanel.Height - TotalPanel.Height - TitlePanel.Height - 10;
         if CurrentRow > 22 then
            StringGrid.TopRow := CurrentRow - 21
           else
            StringGrid.TopRow := 1;
        end;
     StringGrid.SetFocus;   
    end
   else
    BackPanel.SetFocus;
end;

procedure TTableOrderForm.MenuGroupButtonClick(Sender: TObject);
var
 Temp: string;
begin
 if MenuGroupSelectForm.MenuGroupSelectPro(MenuGroupCode, Temp) then
    begin
     OpenCategory;
     AssignCategoryKeyBoard;
     ProcessCategoryButtonTouch(1);
     AssignMenuKeyBoard;
    end;
end;

procedure TTableOrderForm.ChangeMenuGroupButtonClick(Sender: TObject);
var
 Temp: string;
begin
 if MenuGroupSelectForm.MenuGroupSelectPro(MenuGroupCode, Temp) then
    begin
     OpenCategory;
     AssignCategoryKeyBoard;
     ProcessCategoryButtonTouch(1);
     AssignMenuKeyBoard;
    end;
end;

procedure TTableOrderForm.MergeTableButtonClick(Sender: TObject);
begin
 MergeTableForm.MergeTablePro;
end;

procedure TTableOrderForm.PrintPickupSlipButtonClick(Sender: TObject);
var
 Temp: integer;
 Flag: boolean;
 OrderNo, BookingNo, TableNo: string;
begin
 {if TableTracking then
    Flag := ReadOrderNoForm.ReadOrderNoPro(OrderNo, BookingNo, TableNo, Temp, sEditTable)
   else
    Flag := OrderListForm.OrderListPro(OrderNo, TableNo);
 Application.ProcessMessages;
 if Flag then PrintPickupSlipForm.PrintPickupSlipPro(OrderNo);}

      if(sOrderNo <> '') then
      begin
        DataForm.SetInvoiceNo(sOrderNo);
        case PrintBillMode of
        0, 1: PrintOrderForm.PrintOrderPro(sOrderNo);
        2:    PrintOrderForm1.PrintOrderPro(sOrderNo, True);
        3:    PrintOrderForm1.PrintOrderPro(sOrderNo, False);
        4:    PrintOrderForm2.PrintOrderPro(sOrderNo);
        5:    PrintOrderForm3.PrintOrderPro(sOrderNo);
        end;
      end;


end;

procedure TTableOrderForm.PrintGoWithMessageButtonClick(Sender: TObject);
var
 Temp: integer;
 Flag: boolean;
 OrderNo, BookingNo, TableNo, InstructionMsg: string;
begin
 InstructionMsg := '';
 if TableTracking then
    Flag := ReadOrderNoForm.ReadOrderNoPro(OrderNo, BookingNo, TableNo, Temp, sEditTable)
   else
    Flag := OrderListForm.OrderListPro(OrderNo, TableNo);
 if Flag and PrintGoWithInstruction then
    Flag := KeyboardForm.KeyboardPro(InstructionMsg);
 if Flag then PrintGoWithMessage(OrderNo, InstructionMsg);
end;

procedure TTableOrderForm.AccountPaymentButtonClick(Sender: TObject);
begin
 StringGrid.SetFocus;
 AccountPaymentPro;
end;

procedure TTableOrderForm.OrderDueTimeButtonClick(Sender: TObject);
var
 Temp: string;
begin
 StringGrid.SetFocus;
 if DueTime <> 0 then
    Temp := FormatDateTime('hh:mm', DueTime)
   else
    Temp := FormatDateTime('hh:mm', Time);
 if TimeForm.ReadTimePro(Temp) then
    DueTime := StrToTime(Temp);
end;

procedure TTableOrderForm.SurchargeButtonClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := FloatToStr(CurrentServiceChargeRate);
 StringGrid.SetFocus;
 if AutoSurcharge then
    begin
     if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Surcharge Rate (%)', 0) then
        begin
         CurrentServiceChargeRate := Round(StrToFloat(NumStr));
         CalcAmount;
        end;
    end
   else
    MessageBoxForm.MessagePro('Surcharge function is inactive.', sErrorMsg);
end;

procedure TTableOrderForm.OtherChargeButtonClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := FloatToStr(CurrentOtherChargeRate);
 StringGrid.SetFocus;
 if OtherChargeEnable then
    begin
     if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Other Charge Rate (%)', 0) then
        begin
         CurrentOtherChargeRate := Round(StrToFloat(NumStr));
         CalcAmount;
        end;
    end
   else
    MessageBoxForm.MessagePro('Other Charge function is inactive.', sErrorMsg);
end;

procedure TTableOrderForm.RedeemPointButtonClick(Sender: TObject);
begin
 StringGrid.SetFocus;
 RewardPointsProcess;
end;

procedure TTableOrderForm.UserIDButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 repeat
  Flag := DataForm.VerifyPassword(sUserName);
  if Flag and Not MainForm.TableServiceMenu.Enabled then
     begin
      MessageBoxForm.MessagePro('You have not been authorised to do table service.', sErrorMsg);
      Flag := False;
     end;
 until Flag;
 //SetButtonStatus;
 if StringGrid.Enabled then
    StringGrid.SetFocus
   else
    BackPanel.SetFocus;
end;

procedure TTableOrderForm.ChangeUserIDButtonClick(Sender: TObject);
begin
 UserIDButtonClick(Sender);
end;

procedure TTableOrderForm.TimerTimer(Sender: TObject);
begin
 if Not Password and AutoLogout then
    begin
     AutoLogoutTimeCounter := AutoLogoutTimeCounter + 1;
     if AutoLogoutTimeCounter >= AutoLogoutTimeout * 60 + 60 then
        begin
         Timer.Enabled := False;
         UserIDButtonClick(Sender);
         AutoLogoutTimeCounter := 0;
         Timer.Enabled := True;
        end;
    end;
end;

procedure TTableOrderForm.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 AutoLogoutTimeCounter := 0;
end;

procedure TTableOrderForm.FormMouseMove(Sender: TObject; Shift: TShiftState;  X, Y: Integer);
begin
 AutoLogoutTimeCounter := 0;
end;

function TTableOrderForm.CalcMinimumChargeBalance(var MinimumChargeBalance: double): boolean;
var
 CurrentBillAmount: double;
 TotalPersons: integer;
begin
 CurrentBillAmount := StrToFloat(AmountEdit.Caption);
 MinimumChargeBalance := 0;
 Result := False;
 case MinimumChargeKind of
  1: if (PersonEdit.Caption = '') or (StrToInt(PersonEdit.Caption) <= 0) then // Process Per Person Minimumu Charge;
        MessageBoxForm.MessagePro('People = 0, can not calculate minimum charge.', sErrorMsg)
       else
        begin
         TotalPersons := StrToInt(PersonEdit.Caption);
         MinimumChargeBalance := TotalPersons * MinimumChargePerPerson - CurrentBillAmount;
         Result := True;
        end;
  2: if TableNoEdit.Caption = '' then  // ProcessTableMinimumCharge;
        MessageBoxForm.MessagePro('This bill has not been entered the table number, ' +
                                  Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                                  'Can not calculate minimum charge.', sErrorMsg)
       else
        begin
         MinimumChargeBalance := DataForm.GetMinimumChargeForPerTable(TableNoEdit.Caption) - CurrentBillAmount;
         Result := True;
        end;
 end;
end;

procedure TTableOrderForm.MinimumChargeButtonClick(Sender: TObject);
var
 MinimumCharge: double;
begin
 if ActiveFlag and StringGrid.Enabled then
    begin
     if MinimumChargeKind >= 1 then
        begin
         if CalcMinimumChargeBalance(MinimumCharge) then
            begin
             if MinimumCharge <= 0 then
                MessageBoxForm.MessagePro('This bill has reached the minimum charge.', sInformationMsg)
               else
                with StringGrid do
                 begin
                  Row := FindLastRow;
                  CurrentRow := Row;
                  CurrentCol := 1;
                  Cells[8, Row] := MinimumChargeItemCode;
                  Cells[2, Row] := '1.00';
                  Cells[3, Row] := Format('%4.2f', [MinimumCharge]);
                  Changed := True;
                  if CheckCells(CurrentCol, CurrentRow) then MoveToNextCell;
                 end;
            end;
        end
       else
        begin
         if (StatusFlag = sEditStatus) and (sOrderNo <> '') then
            ElapseTimeForm.ShowElapseDateTimePro(sOrderNo);
        end;
     StringGrid.SetFocus;
    end
   else
    BackPanel.SetFocus;
end;

procedure TTableOrderForm.SendToSecurityPortPro(OperationMessage, PayBy1, PayBy2: string;
          Payment1, Payment2, Rounding, Change: double);
var
 Description, PrintStr: string;
 I, CharCount: integer;
 Qty, Price, Amount: double;
begin
 if FVar.SecurityCameraPort = 0 then Exit;
 DataForm.OpenSecurityCameraPort;

 PrintStr := 'Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 PrintStr := 'Operator: ' + sUserName;
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 for I := 1 to 500 do
  with StringGrid do
   if Cells[1, I] <> '' then
      begin
       Description := Cells[1, I];
       PrintStr := Copy(Description, 1, 40);
       CharCount := 40;
       DataForm.SendMsgToSecurityCameraPort(PrintStr);
       while Length(Description) > CharCount do
        begin
         PrintStr := Copy(Description, CharCount + 1, 40);
         CharCount := CharCount + 40;
         DataForm.SendMsgToSecurityCameraPort(PrintStr);
        end;
       if Cells[2, I] <> '' then
          Qty := StrToFloat(Cells[2, I])
         else
          Qty := 0;
       if Cells[3, I] <> '' then
          Price := StrToFloat(Cells[3, I])
         else
          Price := 0;
       if Cells[4, I] <> '' then
          Amount := StrToFloat(Cells[4, I])
         else
          Amount := 0;
       if (ABS(Qty) >= 0.01) or (ABS(Price) >= 0.01) then
          begin
           PrintStr := Format('%3.2f X %3.2m = %3.2m', [Qty, Price, Amount]);
           PrintStr := Format('%40s', [PrintStr]);
           DataForm.SendMsgToSecurityCameraPort(PrintStr);
          end;
      end;
 PrintStr := 'Amount: ' + Format('%8s', [FormatCurrency(StrToFloat(AmountEdit.Caption))]);
 PrintStr := Format('%40s', [PrintStr]);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 PrintStr := DiscountTitleLabel.Caption + Format('%8s', [FormatCurrency(StrToFloat(DiscountEdit.Caption))]);
 PrintStr := Format('%40s', [PrintStr]);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 if RewardPointsDiscountEdit.Visible then
    begin
     PrintStr := 'POINTS REDEEM: ' + Format('%8s', [FormatCurrency(StrToFloat(RewardPointsDiscountEdit.Caption))]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if ServiceChargeEdit.Visible then
    begin
     PrintStr := ServiceChargeLabel.Caption + ':' + Format('%8s', [FormatCurrency(StrToFloat(ServiceChargeEdit.Caption))]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if OtherChargeEdit.Visible then
    begin
     PrintStr := OtherChargeLabel.Caption + ':' + Format('%8s', [FormatCurrency(StrToFloat(OtherChargeEdit.Caption))]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;
 PrintStr := 'Total: ' + Format('%8s', [FormatCurrency(StrToFloat(TotalEdit.Caption))]);
 PrintStr := Format('%40s', [PrintStr]);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 if ABS(Payment1) > 0.01 then
    begin
     PrintStr := PayBy1 + ':' + Format('%8s', [FormatCurrency(Payment1)]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if ABS(Payment2) > 0.01 then
    begin
     PrintStr := PayBy2 + ':' + Format('%8s', [FormatCurrency(Payment1)]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if ABS(Rounding) > 0.01 then
    begin
     PrintStr := 'Rounding:' + Format('%8s', [FormatCurrency(Rounding)]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if ABS(Change) > 0.01 then
    begin
     PrintStr := 'Change:' + Format('%8s', [FormatCurrency(Change)]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 PrintStr := '*** ' + OperationMessage + ' ***';
 PrintStr := Format('%' + IntToStr((40 - Length(PrintStr)) div 2) + 's%s', ['', PrintStr]);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);
 DataForm.CloseSecurityCameraPort;
end;

procedure TTableOrderForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
end;

procedure TTableOrderForm.FormShow(Sender: TObject);
var
  i,CurrentRow : integer;
begin
 //MenuCount := (MainMenuLine - 1) * 4 + 2;
 MenuCount := 38;
 //CategoryCount := (MainCategoryLine - 1) * 4 + 2;
 CategoryCount := 8 ;
 MenuGroupCode := Format('%2.2d', [FVar.DefaultMainMenuGroupCode]);
 if Not ShowTaxOnsalesSection and PriceIncludesGST then
    begin
     GSTLabel.Caption := 'Total price includes GST';
     GSTEdit.Visible := False;
    end;
 InitMenuPanel;
 InitCategoryPanel;
 //SetTotalPanelLabelPosition;
 InitControlButtons;
 InitEditButtons;
 InitFixedButtons;
 DataForm.OpenPoleDisplayPort;
 Langurage := True;
 OpenCategory;
 AssignCategoryKeyBoard;
 ProcessCategoryButtonTouch(1);
 AssignMenuKeyBoard;
 InitForm;
 CalcAmount;
 ActiveFlag := False;
 //SetButtonStatus;
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
 ServiceChargeLabel.Caption := Uppercase(SurchargeName);
 OtherChargeLabel.Caption := Uppercase(OtherChargeName);
 AutoLogoutTimeCounter := 0;
 Timer.Enabled := Not Password and AutoLogout;
 tableServiceCanceled := false;
 TableOrderButtonClick(Sender);
 if not tableServiceCanceled then
  begin
    CurrentRow := FindLastRow-1;
    if StatusFlag = sNewStatus then
      begin
        for i:=0 to 500 do
          begin
            priceSelect[i] := PointOfSalesForm.priceSelect[i];
            Instruction[i] := PointOfSalesForm.instruction[i];
            orderInstruction[i] := PointOfSalesForm.OrderInstruction[i];
            DiscountFlag[i] := PointOfSalesForm.DiscountFlag[i];
          end;
        CopyStringGrid(PointOfSalesForm.StringGrid);
      end
   end
  else
    PostMessage(TableOrderForm.Handle,WM_CLOSE,0,0)




end;

procedure TTableOrderForm.TableOrderPro(AutoReturn: boolean);
begin
 Application.CreateForm(TTableOrderForm, TableOrderForm);
 TableOrderForm.AutoReturn := AutoReturn;
 TableOrderForm.ShowModal;
 TableOrderForm.Free;



end;

procedure TTableOrderForm.XiButton1Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '1'
else
  Number := '1';
PaidEdit.Caption := Number;
CalcBalance;
end;


function TTableOrderForm.CalcBalance : boolean;
begin

   PaymentAmount := StrToFloat (PaidEdit.Caption);
   if(PaymentAmount <> 0) then
     begin
      Change := PaymentAmount + PaidAmount - BalanceTotal  ;
      Change1 := Change;
      if (Change < 0) then
        Result := false
      else
        Result := true;
      PaidEdit.Caption := Format('%4.2f', [PaymentAmount]);
      ChangeEdit.Caption := Format('%4.2f', [Change]);
      end;
end;

procedure TTableOrderForm.XiButton2Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '2'
else
  Number := '2';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TTableOrderForm.XiButton3Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '3'
else
  Number := '3';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TTableOrderForm.XiButton4Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '4'
else
  Number := '4';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TTableOrderForm.XiButton5Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '5'
else
  Number := '5';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TTableOrderForm.XiButton6Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '6'
else
  Number := '6';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TTableOrderForm.XiButton7Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '7'
else
  Number := '7';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TTableOrderForm.XiButton8Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '8'
else
  Number := '8';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TTableOrderForm.XiButton9Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '9'
else
  Number := '9';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TTableOrderForm.XiButton12Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '0'
else
  Number := '0';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TTableOrderForm.XiButton11Click(Sender: TObject);
var
  dot : boolean;
begin
 dot := false;
 if Not dot and (POS('.', Number) = 0) then
    Number := Number + '.';
 if Not dot and (POS('.', Number) = 0) then
    Number := Number + '.';
end;

procedure TTableOrderForm.XiButton10Click(Sender: TObject);
begin
    //Number := TotalEdit.Caption;
    Number := '0';

    //PaidEdit.Caption := Number;
    ChangeEdit.Caption := '0.00';
    PaidEdit.Caption := '0.00';
    Change :=0;
    Change1 := 0;
   CalcBalance;
end;

procedure TTableOrderForm.BitBtn1Click(Sender: TObject);
begin
  SetPaymentStatus(False);

  if ProcessQuickPayment('5',Sender) then
    begin
      SetPaymentStatus(True);
      ProcessCategoryButtonTouch(1);
      PointOfSalesForm.PaidEdit.Caption := PaidEdit.Caption;
      PointOfSalesForm.ChangeEdit.Caption := ChangeEdit.Caption;
      PointOfSalesForm.Label2.Caption := Label2.Caption;
      PointOfSalesForm.sOrderNo :=  sOrderNo;
      ExitButtonClick(Sender);

    end
  else
    SetPaymentStatus(true);
end;

procedure TTableOrderForm.BitBtn2Click(Sender: TObject);
begin
   SetPaymentStatus(False);

  if ProcessQuickPayment('10',Sender) then
    begin
      SetPaymentStatus(True);
      ProcessCategoryButtonTouch(1);
      PointOfSalesForm.PaidEdit.Caption := PaidEdit.Caption;
      PointOfSalesForm.ChangeEdit.Caption := ChangeEdit.Caption;
      PointOfSalesForm.Label2.Caption := Label2.Caption;
      PointOfSalesForm.sOrderNo :=  sOrderNo;
      ExitButtonClick(Sender);

    end
  else
    SetPaymentStatus(true);
end;

procedure TTableOrderForm.BitBtn3Click(Sender: TObject);
begin
   SetPaymentStatus(False);

  if ProcessQuickPayment('20',Sender) then
    begin
      SetPaymentStatus(True);
      ProcessCategoryButtonTouch(1);
      PointOfSalesForm.PaidEdit.Caption := PaidEdit.Caption;
      PointOfSalesForm.ChangeEdit.Caption := ChangeEdit.Caption;
      PointOfSalesForm.Label2.Caption := Label2.Caption;
      PointOfSalesForm.sOrderNo :=  sOrderNo;
      ExitButtonClick(Sender);

    end
  else
    SetPaymentStatus(true);
end;

procedure TTableOrderForm.BitBtn4Click(Sender: TObject);
begin
  SetPaymentStatus(False);

  if ProcessQuickPayment('50',Sender) then
    begin
      SetPaymentStatus(True);
      ProcessCategoryButtonTouch(1);
      PointOfSalesForm.PaidEdit.Caption := PaidEdit.Caption;
      PointOfSalesForm.ChangeEdit.Caption := ChangeEdit.Caption;
      PointOfSalesForm.Label2.Caption := Label2.Caption;
      PointOfSalesForm.sOrderNo :=  sOrderNo;
      ExitButtonClick(Sender);

    end
  else
    SetPaymentStatus(true);

end;

procedure TTableOrderForm.BitBtn5Click(Sender: TObject);
begin
   SetPaymentStatus(False);

  if ProcessQuickPayment('100',Sender) then
    begin
      SetPaymentStatus(True);
      ProcessCategoryButtonTouch(1);
      PointOfSalesForm.PaidEdit.Caption := PaidEdit.Caption;
      PointOfSalesForm.ChangeEdit.Caption := ChangeEdit.Caption;
      PointOfSalesForm.Label2.Caption := Label2.Caption;
      PointOfSalesForm.sOrderNo :=  sOrderNo;
      ExitButtonClick(Sender);

    end
  else
    SetPaymentStatus(true);
end;


procedure TTableOrderForm.XiButton13Click(Sender: TObject);
begin
 PaymentPanel.Enabled := False;
 Number := '0';
 PaidEdit.Caption := Number;
 MenuPanel.Enabled := False;
 EFTPOS := true;
 poleSubtotal :=0;
  PaidEdit.Caption := FloatToStr(BalanceTotal - PaidAmount);
  PaymentAmount := BalanceTotal - PaidAmount;

  Label2.Caption := 'EFTPOS';
  DirectPaymentButtonClick(Sender);
  PaymentPanel.Enabled := True;
  MenuPanel.Enabled := True;
  PointOfSalesForm.PaidEdit.Caption := PaidEdit.Caption;
  PointOfSalesForm.Label2.Caption := Label2.Caption;
    PointOfSalesForm.ChangeEdit.Caption := ChangeEdit.Caption;
    PointOfSalesForm.sOrderNo :=  sOrderNo;
    ExitButtonClick(Sender);
end;

procedure TTableOrderForm.BitBtn6Click(Sender: TObject);
begin
    PaymentPanel.Enabled := False;
    MenuPanel.Enabled := False;
    poleSubtotal :=0;
    if (StrToFloat(ChangeEdit.Caption)>=0) then
      begin
        EFTPOS := false;
    if (PaidEdit.Caption = '0.00') or (PaidEdit.Caption = '0') then
      begin
        PaidEdit.Caption := FloatToStr(BalanceTotal - PaidAmount);
        PaymentAmount := StrToFloat(PaidEdit.Caption);
         Change :=0;
         Change1 := 0;
      end
    else
      PaymentAmount :=  StrToFloat(PaidEdit.Caption);
    PaidEdit.Caption := Format('%4.2f', [PaidAmount]);
    //PaidAmount :=  BalanceTotal;
    Label2.Caption := 'CASH';
    DirectPaymentButtonClick(Sender);


    PointOfSalesForm.PaidEdit.Caption := PaidEdit.Caption;
    PointOfSalesForm.ChangeEdit.Caption := ChangeEdit.Caption;
    PointOfSalesForm.Label2.Caption := Label2.Caption;
    PointOfSalesForm.sOrderNo :=  sOrderNo;
    ExitButtonClick(Sender);
    end

    else
      MessageBoxForm.MessagePro('Payment is not balance!', sErrorMsg);
    PaymentPanel.Enabled := True;
    MenuPanel.Enabled := True;

end;

procedure TTableOrderForm.QuickPaymen();
var
 PayBy1, PayBy2, SQLStr: string;
 TotalSales, Discount, Amount, Receivable, Tips, Payment1, Payment2, Surcharge: double;
 Flag, LinkToEFTPOS: boolean;
 PayPoints,ID, AwardPoints, DepositID1, DepositID2: integer;
 PaidAmount : double;
begin
StringGrid.SetFocus;
 if (FindLastRow = 1) or Not DataForm.CheckItemCode(StringGrid, 8) then Exit;

 CalcAmount;
 if (MaxDollarDiscount >= 0.01) and (DiscountEdit.Caption <> '') and
    (StrToFloat(DiscountEdit.Caption) > MaxDollarDiscount) then
    begin
     MessageBoxForm.MessagePro('Discount is over ' + FormatCurrency(MaxDollarDiscount) + '.' +
     Chr(13) + Chr(10) + Chr(13) + Chr(10) +
     'System will auto change discount to ' + FormatCurrency(MaxDollarDiscount) + '.',
     sErrorMsg);
     DiscountRate := 0;
     DollarDiscount := MaxDollarDiscount;
     DiscountKind := 2;
     ProcessDiscount;
    end;
 if (StatusFlag = sEditStatus) and (sOrderNo <> '') then
    begin
     SQLStr := 'Select Sum(PaidAmount) as PaidAmount From RecvAcct ' +
               'Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
     OpenQuery(SQLStr);
     PaidAmount :=  Query.FieldByName('PaidAmount').AsFloat;
     Receivable := TotalSales + Tips + Surcharge - Query.FieldByName('PaidAmount').AsFloat;
     SQLStr := 'Select Max(IDNo) From RecvAcct ' +
               'Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
     OpenQuery(SQLStr);
     if Query.Active and (Query.RecordCount <> 0) then
        ID := Query.Fields[0].AsInteger + 1
       else
        ID := 1;
     Query.Close;
    end
   else
    begin
     Receivable := TotalSales;
     ID := 1;
    end;


 Amount := StrToFloat(AmountEdit.Caption);
 Discount := StrToFloat(DiscountEdit.Caption);
 TotalSales := StrToFloat(TotalEdit.Caption);
 Receivable := TotalSales - PaidAmount;
 //Rounding := POSReceiptForm.CalcRounding(Receivable);
 //BalanceTotal := Receivable;

 if (ABS(Amount) <= 0.005) and (ABS(Discount) >= 0.01) then
    begin
     MessageBoxForm.MessagePro('Can not do discount for zero amount order.', sErrorMsg);
     Exit;
    end;
 if (TotalSales < 0) and Not AuthoriseRefund then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to do sales refund.', sErrorMsg);
     Exit;
    end;
 if (TotalSales = 0) then
    exit;
 //if Not POSReceiptForm.ReceiptPro(TotalSales, Receivable, Tips, Payment1, Payment2, Rounding,
        //Surcharge, Change, PayBy1, PayBy2, LinkToEFTPOS, sVIPNo, DepositID1, DepositID2) then
    //begin
     //CalcAmount;
     //Exit;
    //end;
 //Payment1 := Receivable + Rounding;
 Payment1 := PaymentAmount;
 //Payment1 := Receivable;
 if(EFTPOS) then
 begin
    PayBy1 := 'EFTPOS';
    ChangeEdit.Caption := '0.00';
    Change1 :=0;
    Change :=0;
    //PaidEdit.Caption := FloatToStr(Payment1);
    ChangeEdit.Caption := Format('%4.2f', [Change]);
    PaidEdit.Caption := Format('%4.2f', [Payment1]);

 end
 else
 begin
    PayBy1 := 'CASH';
    ChangeEdit.Caption := Format('%4.2f', [Change]);
    PaidEdit.Caption := Format('%4.2f', [Payment1]);
 end;
 DepositID1 := 0;
 DepositID2 :=0;
 Application.ProcessMessages;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 if (sOrderNo = '') then
    DataForm.GenerateOrderNo(sOrderNo);
 try
  Flag := SaveData(sOrderNo);
  if Flag and  (ABS(Payment1)>0.005) then
     Flag := DataForm.SaveAccountRecord(sOrderNo,Payment1,PayBy1,1,DepositID1);

  if Flag and (Change1 >= -0.001) and (ABS(Rounding) > 0.005) then
     Flag := DataForm.SaveAccountRecord(sOrderNo, -Rounding, 'ROUNDING', 3, 0);
  if Flag and (Change1 >= 0.009) then
     Flag := DataForm.SaveAccountRecord(sOrderNo, -Change1, 'CASH', 4, 0);
    //else
     //begin
  SQLStr := 'Update OrderH Set Credit = 1 Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
  Flag := DataForm.ExecQueryPro(SQLStr);
     //end;
  if Flag then
     Flag := DataForm.UpdateOrderPayment(sOrderNo, False);
  if Flag and ((DepositID1 >= 1) or (DepositID2 >= 1)) then
     begin
      SQLStr := 'Update OrderH Set Credit = 1 Where OrderNo = '+ Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag and (ABS(Tips) >= 0.01) then
     begin
      SQLStr := 'Update OrderH Set Tips= + ' + FloatToStr(Tips) +
                ' Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag and (ABS(Surcharge) >= 0.01) then
     begin
      SQLStr := 'Update OrderH Set Surcharge=Surcharge + ' + FloatToStr(Surcharge) +
                ' Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if AutoPrintPOSInvoice then Flag := DataForm.SetInvoiceNo(sOrderNo);
  sTableNo := TableNoEdit.Caption;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      SendToSecurityPortPro('[Payment] Buttin Clicked', PayBy1, PayBy2, Payment1, Payment2, Rounding, Change);
      if Not OnlyOpenDrawerForCashPayment or
        ((Uppercase(PayBy1) = 'CASH') and (ABS(Payment1) >= 0.01)) or
        ((Uppercase(PayBy2) = 'CASH') and (ABS(Payment2) >= 0.01)) or
        (ABS(Change) >= 0.01) then
         begin
          CurrentDrawerNumber := DefaultDrawerPortNumber;
          DataForm.OpenDrawer(True, CurrentDrawerNumber);
         end;
      if AutoPrintPickupSlip then
         PrintPickupSlipForm.PrintPickupSlipPro(sOrderNo);
      if AutoPrintPOSOrderList then
         case PrintBillMode of
           0, 1: PrintOrderForm.PrintOrderPro(sOrderNo);
           2:    PrintOrderForm1.PrintOrderPro(sOrderNo, True);
           3:    PrintOrderForm1.PrintOrderPro(sOrderNo, False);
           4:    PrintOrderForm2.PrintOrderPro(sOrderNo);
           5:    PrintOrderForm3.PrintOrderPro(sOrderNo);
         end;
      if AutoPrintPOSInvoice then
         case PrintInvoiceMode of
          0, 1: PrintInvoiceForm.PrintInvoicePro(sOrderNo);
          2:    PrintInvoiceForm1.PrintInvoicePro(sOrderNo, True);
          3:    PrintInvoiceForm1.PrintInvoicePro(sOrderNo, False);
          4:    PrintInvoiceForm2.PrintInvoicePro(sOrderNo);
          5:    PrintInvoiceForm3.PrintInvoicePro(sOrderNo);
         end;
      {if AutoPrintPOSJobList then
         begin
          PrintJobListControlForm.PrintJobListControlPro(sOrderNo, '', False, sConfirmedOrder);
          if AutoPrintCheckList then
             PrintCheckListForm.PrintCheckList(sOrderNo, '', False, sConfirmedOrder);
         end; }
      if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(sOrderNo, '', False);
      if ShowPrintInvoiceWindow then
         DispPOSReceiptForm.DispReceiptPro(TotalSales, Receivable, Tips, Payment1,
                  Payment2, Rounding, Surcharge, Change, PayBy1, PayBy2, sOrderNo);
     PrintJobListControlForm.PrintJobListControlPro(sOrderNo, '', False, sConfirmedOrder);
     if AutoPrintCheckList then
             PrintCheckListForm.PrintCheckList(sOrderNo, '', False, sConfirmedOrder);
     InitForm;
     ActiveFlag := False;
     //SetButtonStatus;
     Application.ProcessMessages;
     end
    else
     DataForm.RollBack;

 end;
 Number := '0';
 Change :=0;
 Change1 :=0;



end;

procedure TTableOrderForm.SetPaymentStatus(Status:boolean);
begin
  PaymentPanel.Enabled := Status;
  MenuPanel.Enabled := Status;
end;

function TTableOrderForm.ProcessQuickPayment(payment: string;Sender:Tobject):boolean;
begin

  EFTPOS := False;
  Number := payment;
  PaidEdit.Caption := Number;
  Label2.Caption := 'CASH';
  if(CalcBalance) then
    begin
      DirectPaymentButtonClick(Sender);
      result := true;
    end
  else
    begin
      MessageBoxForm.MessagePro('Payment is not balance!', sErrorMsg);
      result := false;
    end;
end;

procedure TTableOrderForm.CopyStringGrid(StringGrid1 : TStringGrid);
var
  R,C,CurrentRow : integer;
  S : string;
begin
  S := '';
  CurrentRow := FindLastRow;
  for R := 1 to StringGrid1.RowCount-1 do
    begin
      for C := 1 to StringGrid1.ColCount-1 do
        begin
          S := StringGrid1.Cells[C,R];

          if C >= 6  then
            StringGrid.Cells[C+1,CurrentRow] := S
          else
            StringGrid.Cells[C,CurrentRow] := S;


        end;
        CurrentRow := CurrentRow + 1;
    end;

  CalcAmount;

end;


end.

