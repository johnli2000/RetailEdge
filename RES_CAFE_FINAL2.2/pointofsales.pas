unit PointOfsales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, StdCtrls, ExtCtrls, Buttons, Grids, UtilUnit, Db, DataUnit, ADODB,
  CommDrv, PanelButton, XiButton, MainMenu, bsSkinCtrls, bsSkinGrids,
  SUIButton;

type
  TPointOfsalesForm = class(TForm)
    Timer: TTimer;
    CategoryQuery: TADOQuery;
    Query: TADOQuery;
    MenuQuery: TADOQuery;
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
    LangurageButton: TXiButton;
    HoldOrderButton: TXiButton;
    ZoomButton: TXiButton;
    RecallOrderButton: TXiButton;
    BackPanel: TbsSkinPanel;
    TitlePanel: TbsSkinPanel;
    TotalPanel: TbsSkinPanel;
    ButtonPanel: TbsSkinPanel;
    StringGrid: TStringGrid;
    CategoryPanel: TbsSkinPanel;
    SummaryPanel: TbsSkinPanel;
    AmountLabel: TbsSkinStdLabel;
    DiscountTitleLabel: TbsSkinStdLabel;
    RewardPointsLabel: TbsSkinStdLabel;
    TotalLabel: TbsSkinStdLabel;
    GSTLabel: TbsSkinStdLabel;
    AmountEdit: TbsSkinStdLabel;
    DiscountEdit: TbsSkinStdLabel;
    RewardPointsEdit: TbsSkinStdLabel;
    TotalEdit: TbsSkinStdLabel;
    GSTEdit: TbsSkinStdLabel;
    DateLabel: TbsSkinLabel;
    CustomerNameEdit: TbsSkinLabel;
    OperatorLabel: TbsSkinLabel;
    CustomerNameButton: TbsSkinSpeedButton;
    OtherChargeLabel: TbsSkinStdLabel;
    OtherChargeEdit: TbsSkinStdLabel;
    StringGridPanel: TbsSkinPanel;
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
    PaymentPanel: TbsSkinPanel;
    XiButton1: TXiButton;
    XiButton2: TXiButton;
    XiButton3: TXiButton;
    XiButton4: TXiButton;
    XiButton5: TXiButton;
    XiButton6: TXiButton;
    XiButton7: TXiButton;
    XiButton8: TXiButton;
    XiButton9: TXiButton;
    XiButton10: TXiButton;
    XiButton11: TXiButton;
    XiButton12: TXiButton;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    PaidEdit: TbsSkinStdLabel;
    ChangeEdit: TbsSkinStdLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    XiButton13: TXiButton;
    Label1: TLabel;
    Label2: TLabel;
    TimerDisplay: TTimer;
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
    Menu45: TPanelButton;
    Menu46: TPanelButton;
    Menu47: TPanelButton;
    Menu48: TPanelButton;
    Menu43: TPanelButton;
    Menu44: TPanelButton;
    Menu49: TPanelButton;
    Menu50: TPanelButton;
    XiButton14: TXiButton;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    suiButton3: TsuiButton;
    suiButton4: TsuiButton;
    suiButton5: TsuiButton;
    suiButton6: TsuiButton;
    suiButton7: TsuiButton;
    suiButton8: TsuiButton;
    suiButton9: TsuiButton;
    suiButton10: TsuiButton;
    suiButton11: TsuiButton;
    suiButton12: TsuiButton;
    Dollar50: TsuiImageButton;
    Dollar20: TsuiImageButton;
    Dollar10: TsuiImageButton;
    Dollar5: TsuiImageButton;
    Label3: TLabel;
    tareLabel: TbsSkinStdLabel;
    XiButton15: TXiButton;
    PanelLine1: TbsSkinPanel;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinPanel2: TbsSkinPanel;
    bsSkinPanel3: TbsSkinPanel;
    bsSkinPanel4: TbsSkinPanel;
    bsSkinPanel5: TbsSkinPanel;
    procedure SetTotalPanelLabelPosition;
    procedure PostDataToSecondDisplayPro;
    procedure InitMenuPanel;
    procedure InitCategoryPanel;
    procedure InitControlButtons;
    procedure InitFixedButtons;
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
    procedure CancelButtonClick(Sender: TObject);
    function  OpenQuery(SQLStr: string): boolean;
    procedure FormShow(Sender: TObject);
    procedure MoveToNextCell;
    procedure StringGridClick(Sender: TObject);
    procedure DeleteLine;
    procedure StringGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  CheckCells(ACol, ARow: integer): boolean;
    procedure CalcAmount;
    function  TestItemCode(ItemCode: string; var PriceFlag: integer): boolean;
    function  SaveOrderHeadTable(OrderNo: string): boolean;
    function  SaveOrderItemTable(OrderNo: string): boolean;
    procedure PaymentButtonClick(Sender: TObject);
    function  SaveData(OrderNo: string): boolean;
    procedure ProcessDiscount;
    procedure ExitButtonClick(Sender: TObject);
    procedure VoidItemButtonClick(Sender: TObject);
    function  GetLastNonInstructionItem: integer;
    procedure QtyButtonClick(Sender: TObject);
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure MenuButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetDescription(ARow: integer);
    procedure PriceButtonClick(Sender: TObject);
    procedure DiscountButtonClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure CategoryPageUpButtonClick(Sender: TObject);
    procedure CategoryPageDownButtonClick(Sender: TObject);
    procedure CategoryButtonClick(Sender: TObject);
    procedure PrintInvoiceButtonClick(Sender: TObject);
    function  FindLastRow: integer;
    procedure PointOfsalesPro(AutoReturn: boolean);
    procedure ViewIngredientsButtonClick(Sender: TObject);
    procedure ConvertLangurage(FirstRow, EndRow:integer);
    procedure LangurageButtonClick(Sender: TObject);
    procedure OpenDrawerButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure InstructionButtonClick(Sender: TObject);
    procedure UpdatePoleMessage;
    procedure SpellInstructionButtonClick(Sender: TObject);
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    procedure VIPListButtonClick(Sender: TObject);
    procedure InsertLine(CurrentLine: integer);
    procedure InsertButtonClick(Sender: TObject);
    procedure ChangeUserIDButtonClick(Sender: TObject);
    procedure RewardPointsProcess;
    procedure MoreFunctionButtonClick(Sender: TObject);
    procedure WeightButtonClick(Sender: TObject);
    procedure AccountPaymentButtonClick(Sender: TObject);
    //procedure CopyMealPackage;
    function  MakeHoldNo: integer;
    function  SaveHoldHead(HoldNo: integer; CustomerName, Telephone: string): boolean;
    function  SaveHoldItem(HoldNo: integer): boolean;
    function  SaveHoldDataPro(var HoldNo: integer; CustomerName, Telephone: string;
              UpdateHoldHeadRecord, DeleteExistingItems: Boolean): boolean;
    function  ReadHoldHead(StaffName: string ;var HoldNo: integer): boolean;
    function  ReadHoldItem(HoldNo: integer): boolean;
    function  DeleteHoldSales(HoldNo: integer): boolean;
    procedure ZoomButtonClick(Sender: TObject);
    procedure MenuGroupButtonClick(Sender: TObject);
    procedure HoldOrderButtonClick(Sender: TObject);
    procedure RecallOrderButtonClick(Sender: TObject);
    procedure PrintBillButtonClick(Sender: TObject);
    procedure PrintJobListButtonClick(Sender: TObject);
    procedure PrintPickupSlipButtonClick(Sender: TObject);
    procedure CashPayOutButtonClick(Sender: TObject);
    procedure CustomerNameButtonClick(Sender: TObject);
    function  GetOtherChargeRate: double;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SendToSecurityPortPro(OperationMessage, PayBy1, PayBy2: string; Payment1, Payment2, Rounding, Change: double);
    procedure XiButton1Click(Sender: TObject);
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
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    function CalcBalance: boolean;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure XiButton13Click(Sender: TObject);
    procedure TableServiceClick(Sender: TObject);
    procedure PrintLastInvoiceClick(Sender: TObject);
    procedure TimerDisplayTimer(Sender: TObject);
    procedure SetPaymentStatus(Status: boolean);
    procedure ProcessQuickPayment(payment: string;Sender:Tobject);
    procedure MorePaymentButtonClick(Sender:TObject);
    procedure SplitBillButtonClick(Sender :TObject);
    procedure PhoneOrderAdminButtonClick(Sender :TObject);
    //procedure TPointOfSalesForm.PaymentButtonClick1(Sender: TObject);
    function  CheckOrderPaymentStatus(OrderNo: string): boolean;
    procedure XiButton15Click(Sender: TObject);

    function  SaveCancelHead(CancelOrderNo:integer): boolean;
    function  SaveCancelItem(CancelOrderNo:integer): boolean;
    function MakeCancelOrderNo : integer;
  private { Private declarations }
    Number: string;
    BalanceTotal,PaidAmount,Change,Change1,Rounding : double;
    EFTPOS : boolean;

    poleAmount,poleSubtotal : double;
    ClearSecondDisplay : boolean;
    tare : double;
    sCancelOrderNo : integer;

  public  { Public declarations }
    CurrentCol, CurrentRow, CategoryCurrentPage, MenuCurrentPage,
    CategoryRowCount, sVIPNo, MenuCount, CategoryCount, LastMenuPosition,
    DiscountKind, sHoldNo, AutoLogoutTimeCounter: integer;
    Changed, Langurage: boolean;
    DiscountFlag, OpenPrice: array [1..500] of Boolean;
    Instruction, PriceSelect: array [1..500] of integer;
    PrintedFlag, CheckListPrinted, OrderInstruction: array [1..500] of boolean;
    OriginalPrice: array [1..500] of double;
    SecondScreenDescription: array [1..500] of string;
    DiscountRate, DollarDiscount, CurrentOtherChargeRate, RewardPointsDiscount: double;
    KeyBuff, MenuGroupCode, PresetDiscountCode, DiscountOperator: string;
    DueTime: TDateTime;
    CurrentPriceIncludesGST, AutoReturn: boolean;
    sOrderNo: string;
  end;

var
  PointOfsalesForm: TPointOfsalesForm;

implementation

uses StaffList, NumPad, OrderList, PrintInvoice, POSReceipt,
     PriceSelect, EndOfDayRpt, ItemSelect, PrintJobCard, PrintOrder,
     MessageBox, InstructionList, Instruction, PrintJobCard1,
     PayOut, DispPOSReceipt, PrintInvoice1, PrintOrder1, PrintJobCard2,
     MenuItemEdit, MenuSetup, PrintPickupSlip,
     Discount, POSFunction,  TimePanel,
     SendToScreen, PrintJobCard3, Keyboard, PrintJobCard4,
      SelectDrawerNumber, MenuGroupSelect, CashFloat,
      PrintCheckList, DiscountRateSelect,
      PrintInvoice2, PrintOrder2, PrintJobCard5,
     PrintJobListControl, PrintOrder3, PrintInvoice3, SubMenu, TableOrder,
  ReadOrderNo, SplitBill, VIPList, RewardPoints, PhoneOrderAdmin,
  SaleshistoryList, Deposit, HoldModeSelect, CustomerInformation,
  HoldSalesList, HoldSales, MergeTable;

{$R *.DFM}

procedure TPointOfsalesForm.InitControlButtons;
var
 SQLStr, ButtonName: string;
 I, Position, ButtonWidth, ButtonHeight: integer;
begin
 ButtonWidth := 70;
 ButtonHeight := 55;
 for I := 1 to 20 do
  begin
   ButtonName := 'ControlButton' + IntToStr(I);
   with TXiButton(FindComponent(ButtonName)) do
     Visible := False;
  end;
 SQLStr := 'Select * From ButtonsTable Where Disable = 0 and CanRelocate <> 0 and ' +
           'Kind=' + IntToStr(sQuickServiceButton) + ' Order By ButtonName';
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
          qsQtyButtonClick: OnClick := QtyButtonClick;
          qsWeightButtonClick: OnClick := WeightButtonClick;
          qsPriceButtonClick: OnClick := PriceButtonClick;
          qsVoidItemButtonClick: OnClick := VoidItemButtonClick;
          qsInsertButtonClick: OnClick := InsertButtonClick;
          qsPaymentButtonClick: OnClick := PaymentButtonClick;
          qsViewIngredientsButtonClick: OnClick := ViewIngredientsButtonClick;
          qsSpellInstructionButtonClick: OnClick := SpellInstructionButtonClick;
          qsInstructionButtonClick: OnClick := InstructionButtonClick;
          qsPrintInvoiceButtonClick: OnClick := PrintInvoiceButtonClick;
          qsPrintBillButtonClick: OnClick := PrintBillButtonClick;
          qsCashPayOutButtonClick: OnClick := CashPayOutButtonClick;
          qsDiscountButtonClick: OnClick := DiscountButtonClick;
          qsChangeUserIDButtonClick: OnClick := ChangeUserIDButtonClick;
          qsPrintJobListButtonClick: OnClick := PrintJobListButtonClick;
          qsPrintPickupSlipButtonClick: OnClick := PrintPickupSlipButtonClick;
          qsCancelButtonClick: OnClick := CancelButtonClick;
          qsMoreFunctionButtonClick: OnClick := MoreFunctionButtonClick;
          qsOpenDrawerButtonClick: OnClick := OpenDrawerButtonClick;
          qsAccountPaymentButtonClick: OnClick := AccountPaymentButtonClick;
          qsVIPListButtonClick: OnClick := VIPListButtonClick;
          qsMenuGroupButtonClick: OnClick := MenuGroupButtonClick;
          qsExitButtonClick: OnClick := ExitButtonClick;
          qsTableServiceClick: OnClick := TableServiceClick;
          qsPrintLastInvoiceClick: OnClick := PrintLastInvoiceClick;
          qsSplitBillButtonClick : OnClick := SplitBillButtonClick;
          qsPhoneOrderAdminButtonClick : OnClick :=  PhoneOrderAdminButtonClick;
         end;
         BringToFront;
        end;
       Query.Next;
      end;
     Query.Close;
    end;
end;

procedure TPointOfSalesForm.PhoneOrderAdminButtonClick(Sender : TObject);
begin
 if MainForm.PhoneOrderMenu.Enabled then
    begin
     PhoneOrderAdminForm.PhoneOrderAdminPro;
     DataForm.OpenPoleDisplayPort;
     DataForm.SendToPoleDisp('NEXT CUSTOMER PLEASE', '');
     if FVar.SecondDisplay = 1 then SecondDisplayForm.SetWaitingStatus;
     if Password then ChangeUserIDButtonClick(Sender);
    end
   else
    MessageBoxForm.MessagePro('You have not been authorised to do phone order sale.', sErrorMsg);
end;

procedure TPointOfsalesForm.SplitBillButtonClick(Sender : TObject);

var
 OrderNo, BookingNo, TableNo: string;
 Temp: integer;
 Flag: boolean;
begin

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


function TPointOfSalesForm.CheckOrderPaymentStatus(OrderNo: string): boolean;
var
 SQLStr: string;
begin
  SQLStr := 'Select SplitBill From OrderH ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
  OpenQuery(SQLStr);
  Result := Query.FieldByName('SplitBill').AsBoolean;
  Query.Close;
end;



procedure TPointOfSalesForm.TableServiceClick(Sender: TObject);
begin
    Change := 0;
    Change1 := 0;
    try

      TableOrderForm.TableOrderPro(True);

      if not TableOrderForm.tableServiceCanceled then
        begin
          initForm;
          if Password then
            ChangeUserIdButtonClick(Sender);
        end;
    finally
         initForm;
         if Password then
         ChangeUserIdButtonClick(Sender);
    end;     
end;

procedure TPointOfsalesForm.PrintLastInvoiceClick(Sender: TObject);
begin
if(sOrderNo <> '') then
    begin
      DataForm.SetInvoiceNo(sOrderNo);

      case PrintInvoiceMode of
        0, 1: PrintInvoiceForm.PrintInvoicePro(sOrderNo);
        2:    PrintInvoiceForm1.PrintInvoicePro(sOrderNo, True);
        3:    PrintInvoiceForm1.PrintInvoicePro(sOrderNo, False);
        4:    PrintInvoiceForm2.PrintInvoicePro(sOrderNo);
        5:    PrintInvoiceForm3.PrintInvoicePro(sOrderNo);
        end;
      end;

end;

{procedure TPointOfSalesForm.PrintLastInvoiceClick(Sender: TObject);
begin
if(sOrderNo <> '') then
    begin
      //DataForm.SetInvoiceNo(sOrderNo);

      case PrintBillMode of
      0, 1: PrintOrderForm.PrintOrderPro(sOrderNo);
      2:    PrintOrderForm1.PrintOrderPro(sOrderNo, True);
      3:    PrintOrderForm1.PrintOrderPro(sOrderNo, False);
      4:    PrintOrderForm2.PrintOrderPro(sOrderNo);
      5:    PrintOrderForm3.PrintOrderPro(sOrderNo);
      end;
      end;

end; }


procedure TPointOfsalesForm.InitFixedButtons;
var
 SQLStr, ButtonName: string;
begin
 SQLStr := 'Select * From ButtonsTable Where Kind=' + IntToStr(sQuickServiceButton) +
           ' and CanRelocate = 0 Order By ButtonName';
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
          bcNeoDesert: ColorScheme := csWhite;
          bcNeoSky:    ColorScheme := csWhite;
          bcNeoGrass:  ColorScheme := csWhite;
          bcNeoSilver: ColorScheme := csWhite;
          bcNeoRose:   ColorScheme := csWhite;
          bcNeoSun:    ColorScheme := csWhite;
          bcDesert:    ColorScheme := csWhite;
          bcGrass:     ColorScheme := csWhite;
          bcSky:       ColorScheme := csWhite;
          bcSun:       ColorScheme := csWhite;
          bcRose:      ColorScheme := csWhite;
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
         BringToFront;
        end;
       Query.Next;
      end;
     Query.Close;
    end;
end;

procedure TPointOfsalesForm.SetTotalPanelLabelPosition;
var
 TotalLabels, SpaceLength, LabelPosition: integer;
begin
 TotalLabels := 4;
 if LoyaltyAwardAvailible then Inc(TotalLabels);
 if OtherChargeEnable then Inc(TotalLabels);
 SpaceLength := (SummaryPanel.Height - TotalLabels * 16 - 8) div (TotalLabels + 1);
 LabelPosition := SpaceLength + 4;
 AmountLabel.Top := LabelPosition + 1;
 AmountEdit.Top := LabelPosition;
 LabelPosition := LabelPosition + SpaceLength + 16;
 DiscountTitleLabel.Top := LabelPosition + 1;
 DiscountEdit.Top := LabelPosition;
 LabelPosition := LabelPosition + SpaceLength + 16;
 if LoyaltyAwardAvailible then
    begin
     RewardPointsLabel.Top := LabelPosition + 1;
     RewardPointsEdit.Top := LabelPosition;
     LabelPosition := LabelPosition + SpaceLength + 16;
    end
   else
    begin
     RewardPointsLabel.Visible := False;
     RewardPointsEdit.Visible := False;
    end;
 if OtherChargeEnable then
    begin
     OtherChargeLabel.Top := LabelPosition + 1;
     OtherChargeEdit.Top := LabelPosition;
     LabelPosition := LabelPosition + SpaceLength + 16;
    end
   else
    begin
     OtherChargeLabel.Visible := False;
     OtherChargeEdit.Visible := False;
    end;
 if CurrentPriceIncludesGST then
    begin
     TotalLabel.Top := LabelPosition;
     TotalEdit.Top := LabelPosition;
     LabelPosition := LabelPosition + SpaceLength + 16;
     GSTLabel.Top := LabelPosition + 1;
     GSTEdit.Top := LabelPosition;
    end
   else
    begin
     GSTLabel.Top := LabelPosition + 1;
     GSTEdit.Top := LabelPosition;
     LabelPosition := LabelPosition + SpaceLength + 16;
     TotalLabel.Top := LabelPosition;
     TotalEdit.Top := LabelPosition;
    end;
end;

procedure TPointOfsalesForm.PostDataToSecondDisplayPro;
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
       SecondDisplayForm.StringGrid.Cells[3, I] := StringGrid.Cells[4, I]; // Amount
      end;
  end;
  //PaidEdit.Caption := '0'; ChangeEdit.Caption := '0';
end;

procedure TPointOfsalesForm.InitMenuPanel;
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
// MenuPanel.Left := 568;
// MenuPanel.Height := POSMenuLine * 57 + 9;
 //PageUpButton.Top := (POSMenuLine - 1) * 57 + 6;
 //PageDownButton.Top := PageUpButton.Top;
end;

procedure TPointOfsalesForm.InitCategoryPanel;
var
 I: integer;
 ButtonName: string;
begin
 for I := 1 to 8 do
  begin
   ButtonName := 'Category' + IntToStr(I);
   with TPanel(FindComponent(ButtonName)) do
    Visible := I <= CategoryCount;
  end;
 //CategoryPanel.Top := MenuPanel.Height + 5;
 //CategoryPanel.Left := 568;
 //CategoryPanel.Height := POSCategoryLine * 57 + 9;
 //CategoryPageUpButton.Top := (POSCategoryLine - 1) * 57 + 6;
// CategoryPageDownButton.Top := CategoryPageUpButton.Top;
end;

procedure TPointOfsalesForm.OpenCategoryQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with CategoryQuery do
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
   CategoryRowCount := RecordCount;
   CategoryCurrentPage := 1;
  end;
end;

procedure TPointOfsalesForm.OpenMenuQuery(SQLStr: string);
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
       LastMenuPosition := FieldByName('POSPosition').AsInteger;
      end
     else
      LastMenuPosition := 0;
  end;
end;

procedure TPointOfsalesForm.OpenCategory;
var
 SQLStr: string;
begin
 SQLStr := 'Select Code, Category, ButtonColor, FontName, FontColor, FontSize, ' +
           'FontBold, FontItalic, FontUnderline, FontStrikeout, Category1, ' +
           'ButtonColor1, FontName1, FontColor1, FontSize1, FontBold1, FontItalic1, ' +
           'FontUnderline1, FontStrikeout1 ' +
           'From Category ' +
           'Where MenuGroupCode=' + Chr(39) + CheckQuotes(MenuGroupCode) + Chr(39) +
           ' and ShowOnPOSMenu <> 0 Order By Code';
 OpenCategoryQuery(SQLStr);
end;

procedure TPointOfsalesForm.OpenMenu(Category: string);
var
 SQLStr: string;
begin
 SQLStr := 'Select MenuItem.ItemCode, Description1, Description2, ButtonColor, FontName, ' +
           'FontColor, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'ButtonColor1, FontName1, FontColor1, FontSize1, FontBold1, FontItalic1, ' +
           'FontUnderline1, FontStrikeout1, SubCategory, POSPosition,Scalable ' +
           'From MenuItem Left Join ' +
           '(Select ItemCode, SubCategory From SubMenuLinkHead) As SubMenuTable ' +
           'On MenuItem.ItemCode=SubMenuTable.ItemCode ' +
           'Where (Active <> 0) and (OnlyShowOnSubMenu = 0) and ' +
           'Category=' + Chr(39) + CheckQuotes(Category) + Chr(39) +
           ' Order By POSPosition';
 OpenMenuQuery(SQLStr);
end;

procedure TPointOfsalesForm.AssignMenuKeyBoard;
var
 I, MenuPosition: integer;
 ButtonName: string;
begin
 for I := 1 to MenuCount do
  begin
   ButtonName := 'Menu' + IntToStr(I);
   MenuPosition := (MenuCurrentPage - 1) * MenuCount + I;
   MenuQuery.Locate('POSPosition', IntToStr(MenuPosition), [loPartialKey]);
   with TPanelButton(FindComponent(ButtonName)) do
    if MenuQuery.FieldByName('POSPosition').AsInteger = MenuPosition then
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

procedure TPointOfsalesForm.AssignCategoryKeyBoard;
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
        Font.Color := clBlack;
       end;
  end;
end;

procedure TPointOfsalesForm.ProcessCategoryButtonTouch(Position: integer);
var
 Category: string;
begin
 CategoryQuery.First;
 CategoryQuery.MoveBy((CategoryCurrentPage - 1) * CategoryCount + Position - 1);
 Category := CategoryQuery.FieldByName('Category').AsString;
 OpenMenu(Category);
 AssignMenuKeyBoard;
end;

function TPointOfsalesForm.FindLastRow: integer;
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
           for K := 1 to 7 do StringGrid.Cells[K, J] := StringGrid.Cells[K, I];
           Instruction[J] := Instruction[I];
           OrderInstruction[J] := OrderInstruction[I];
           DiscountFlag[J] := DiscountFlag[I];
           OpenPrice[J] := OpenPrice[I];
           PriceSelect[J] := PriceSelect[I];
           PrintedFlag[J] := PrintedFlag[I];
           CheckListPrinted[J] := CheckListPrinted[I];
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

procedure TPointOfsalesForm.ProcessInstruction(Buff: InstructionBuffType);
var
 I, K, FirstRow, EndRow, CurRow: integer;
begin
 CurRow := CurrentRow;
 I := CurRow + 1;
 FirstRow := I;
 for K := 1 to 38 do
  if (Buff.Code[K] <> '') and (I <= 500) then
     begin
      InsertLine(I);
      StringGrid.Cells[7, I] := Buff.Code[K];
      StringGrid.Cells[1, I] := Buff.Description1[K];
      SecondScreenDescription[I] := Buff.Description2[K];
      StringGrid.Cells[2, I] := Format('%5.3f', [Buff.Qty[K]]);
      StringGrid.Cells[3, I] := Format('%4.2f', [Buff.Price[K]]);
      Instruction[I] := Buff.Condition[K];
      DiscountFlag[I] := Buff.Discount[K];
      OpenPrice[I] := True;
      PrintedFlag[I] := False;
      CheckListPrinted[I] := False;
      OrderInstruction[I] := False;
      OriginalPrice[I] := Buff.Price[K];
      if (DiscountFlag[I] or (ForceVIPDiscount and (sVIPNo > 0))) and
         (DiscountRate >= 0.01) then
         StringGrid.Cells[5, I] := Format('%4.2f', [DiscountRate]) // DiscountRate
        else
         StringGrid.Cells[5, I] := ''; // DiscountRate
      StringGrid.Cells[6, I] := Format('%4.2f', [Buff.TaxRate[K]]);
      SetDescription(I);
      I := I + 1;
     end;
 EndRow := I;
 ConvertLangurage(FirstRow, EndRow);
end;

procedure TPointOfsalesForm.ProcessMenuButtonTouch(Position: integer);
var
 ItemCode, MainItemDescription1, MainItemDescription2,ScalableItem: string;
 Buff: InstructionBuffType;
 MenuPosition: integer;
 SubMenuForm: TSubMenuForm;
 DirectLinkSubMenu: boolean;
 NumberOfChoice: Integer;
begin
 ClearSecondDisplay := True;
 TimerDisplay.Enabled := False;
 PaidAmount := 0;
 Change := 0;
 Number :='';

 PaidEdit.Caption := Format('%4.2f', [PaidAmount]);
 ChangeEdit.Caption := Format('%4.2f', [Change]);
 MenuPosition := (MenuCurrentPage - 1) * MenuCount + Position;
 MenuQuery.Locate('POSPosition', IntToStr(MenuPosition), [loPartialKey]);
 ItemCode := MenuQuery.FieldByName('ItemCode').AsString;
 ScalableItem := MenuQuery.FieldByName('Scalable').AsString;
 if Not MenuQuery.FieldByName('SubCategory').AsBoolean then
    begin
     if StringGrid.Cells[1, CurrentRow] <> '' then CurrentRow := FindLastRow;
     if (CurrentRow <= 500) and (StringGrid.Cells[1, CurrentRow] = '') then
        begin
         StringGrid.Row := CurrentRow;
         StringGrid.Cells[7, StringGrid.Row] := ItemCode;
         StringGrid.Cells[8, StringGrid.Row] := ScalableItem;

         if DataForm.CheckInstructionLink(ItemCode) and
            InstructionListForm.InstructionPro(ItemCode, Langurage, Buff) then
            ProcessInstruction(Buff);
         Changed := True;
         if CheckCells(7, CurrentRow) then
          begin
            if ScalableItem = 'True' then
              WeightButtonClick(self);
            MoveToNextCell;
          end;
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
     SubMenuForm.OwnerNumber := sQUICKSALE;
     if DirectLinkSubMenu then
        SubMenuForm.ProcessDirectLinkSubMenu
       else
        SubMenuForm.ShowModal;
     SubMenuForm.Free;
    end;
end;

procedure TPointOfsalesForm.InitCells(ARow: integer);
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
  end;
 Instruction[ARow] := 0;
 OrderInstruction[ARow] := False;
 DiscountFlag[ARow] := False;
 OpenPrice[ARow] := False;
 PrintedFlag[ARow] := False;
 CheckListPrinted[ARow] := False;
 PriceSelect[ARow] := 0;
 OriginalPrice[ARow] := 0;
 SecondScreenDescription[ARow] := '';
 
end;

procedure TPointOfsalesForm.InitStringGrid;
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
   Cells[6, 0] := 'GST%';
   Cells[7, 0] := 'Code';
   Cells[8, 0] := 'Scalable';
   for I := 1 to 500 do
    begin
     Cells[0, I] := IntToStr(I);
     InitCells(I);
    end;
   Row := 1; Col := 1; TopRow := 1; LeftCol := 1;
   CurrentRow := 1; CurrentCol := 1;
  end;
end;

procedure TPointOfsalesForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
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
         7: begin
             SetTextAlign(Canvas.Handle, TA_CENTER);
             X := (Rect.Left + Rect.Right) div 2;
            end;
         1: begin
             SetTextAlign(Canvas.Handle, TA_LEFT);
             if OrderInstruction[ARow] then
                begin
                 Canvas.Font.Color := clRed;
                 X := Rect.Left + 12;
                end
               else
                if Instruction[ARow] >= 1 then
                    begin
                     Canvas.Font.Color := clBlue;
                     X := Rect.Left + 12;
                    end
                   else
                    begin
                     X := Rect.Left + 2;
                     Canvas.Font.Color := clBlack;
                    end
            end;
        else
          begin
           SetTextAlign(Canvas.Handle, TA_RIGHT);
           X := Rect.Right - 2;
          end;
       end;
      end
     else
      begin
       Canvas.Font.Size := 8;
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    if State = [gdSelected] then Canvas.Font.Color := clBlack;
    Canvas.TextRect(Rect, X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TPointOfsalesForm.InitForm;
var
  i : integer;
  
begin
 DueTime := 0;
 DiscountRate := 0;
 DollarDiscount := 0;
 DiscountKind := 0;
 sVIPNo := 0;
 sHoldNo := 0;
 CustomerNameEdit.Caption := '';
 PresetDiscountCode := '';
 CategoryPanel.Visible := True;
 MenuPanel.Visible := True;
 CurrentPriceIncludesGST := PriceIncludesGST;
 RewardPointsDiscount := 0;
 DiscountOperator := '';
 InitStringGrid;
 DiscountTitleLabel.Caption := 'DISCOUNT (' + Format('%4.2f', [DiscountRate]) + '%)';
 OtherChargeLabel.Caption := Uppercase(OtherChargeName) + ' (' + Format('%4.2f', [CurrentOtherChargeRate]) + '%)';
 if (FVar.SecondDisplay = 1) and ClearSecondDisplay then
    SecondDisplayForm.SetWaitingStatus;
 TimerDisplay.Enabled := True;

  //if (FVar.SecondDisplay = 1) then SecondDisplayForm.SetWaitingStatus;


end;

procedure TPointOfsalesForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 AutoLogoutTimeCounter := 0;
 if Key In ['0'..'9', 'a'..'z', 'A'..'Z', '-', '+', '=', '_', '[', ']', '(', ')', '@',
    '#', '$', '%', '&', '*', '<', '>', '.', ',', '?', '/', '|', '\'] then
    KeyBuff := KeyBuff + Key
   else
    if Key = Chr(13) then
       begin
        if KeyBuff <> '' then
           with StringGrid do
            begin
             Row := FindLastRow;
             if ((Copy(KeyBuff, 1, 2) = '02') and (Length(KeyBuff) = 13)) or
                ((Copy(KeyBuff, 1, 1) = '2') and (Length(KeyBuff) = 12)) then
                begin
                 if Length(KeyBuff) = 13 then
                    begin
                     if ScaleBarcode = 0 then
                        begin
                         Cells[7, Row] := Copy(KeyBuff, 3, 5);
                         Cells[2, Row] := Format('%5.3f', [StrToFloat(Copy(KeyBuff, 8, 5)) / 1000]);
                        end
                       else
                        begin
                         Cells[7, Row] := Copy(KeyBuff, 3, 5);
                         Cells[2, Row] := '1.000';
                         Cells[3, Row] := Format('%4.2f', [StrToFloat(Copy(KeyBuff, 9, 4)) / 100]);
                         OriginalPrice[Row] := StrToFloat(Copy(KeyBuff, 9, 4)) / 100;
                        end
                    end
                   else
                    begin
                     if ScaleBarcode = 0 then
                        begin
                         Cells[7, Row] := Copy(KeyBuff, 2, 5);
                         Cells[2, Row] := FloatToStr(StrToFloat(Copy(KeyBuff, 7, 5)) / 1000);
                        end
                       else
                        begin
                         Cells[7, Row] := Copy(KeyBuff, 2, 5);
                         Cells[2, Row] := '1.00';
                         Cells[3, Row] := Format('%4.2f', [StrToFloat(Copy(KeyBuff, 8, 4)) / 100]);
                         OriginalPrice[Row] := StrToFloat(Copy(KeyBuff, 8, 4)) / 100;
                        end
                    end
                end
               else
                begin
                 Cells[7, Row] := KeyBuff;
                 Cells[2, Row] := '';
                end;
             KeyBuff := '';
             Changed := True;
             if CheckCells(7, Row) then
                begin
                 CalcAmount;
                 Row := FindLastRow;
                 LeftCol := 1;
                end
            end
       end;
end;

procedure TPointOfsalesForm.CancelButtonClick(Sender: TObject);
var
  flag : boolean;
begin
 StringGrid.SetFocus;
 if (StringGrid.Cells[7, 1] = '') or
    (MessageBoxForm.MessagePro('Are you sure you want to cancel this sales?', sConfirmMsg) = mrYes) then
    begin
    sCancelOrderNo := MakeCancelOrderNo;
    Flag := SaveCancelHead(sCancelOrderNo);
    if Flag then Flag := SaveCancelItem(sCancelOrderNo);
     SendToSecurityPortPro('[Cancel] Button Clicked', '', '', 0, 0, 0, 0);
     DataForm.OpenPoleDisplayPort;
     DataForm.SendToPoleDisp('NEXT CUSTOMER PLEASE', '');
     //DataForm.SendToPoleDisp('    Grand Asian Cafe', '');
     if AutoReturn then Close
       else
        begin
         InitForm;
         CalcAmount;
         Changed := False;
         if Password then ChangeUserIDButtonClick(Sender);
        end;
    end;
end;

function TPointOfsalesForm.OpenQuery(SQLStr: string): boolean;
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

procedure TPointOfsalesForm.MoveToNextCell;
begin
 with StringGrid do
  begin
   Row := FindLastRow;
   Col := 1;
   CurrentRow := Row;
   CurrentCol := Col;
  end;
end;

procedure TPointOfsalesForm.DeleteLine;
var
 I, J: Integer;
begin
 for I := CurrentRow to 499 do
  begin
   for J := 1 to 7 do StringGrid.Cells[J, I] := StringGrid.Cells[J, I + 1];
   Instruction[I] := Instruction[I + 1];
   OrderInstruction[I] := OrderInstruction[I + 1];
   DiscountFlag[I] := DiscountFlag[I + 1];
   OpenPrice[I] := OpenPrice[I + 1];
   PrintedFlag[I] := PrintedFlag[I + 1];
   CheckListPrinted[I] := CheckListPrinted[I + 1];
   PriceSelect[I] := PriceSelect[I + 1];
   OriginalPrice[I] := OriginalPrice[I + 1];
   SecondScreenDescription[I] := SecondScreenDescription[I + 1];
  end;
 InitCells(500);
end;

procedure TPointOfsalesForm.InsertLine(CurrentLine: integer);
var
 I, J: integer;
begin
 for I := 500 Downto CurrentLine + 1 do
  begin
   for J := 1 to 7 do StringGrid.Cells[J, I] := StringGrid.Cells[J, I - 1];
   Instruction[I] := Instruction[I - 1];
   OrderInstruction[I] := OrderInstruction[I - 1];
   DiscountFlag[I] := DiscountFlag[I - 1];
   OpenPrice[I] := OpenPrice[I - 1];
   PrintedFlag[I] := PrintedFlag[I - 1];
   CheckListPrinted[I] := CheckListPrinted[I - 1];
   PriceSelect[I] := PriceSelect[I - 1];
   OriginalPrice[I] := OriginalPrice[I - 1];
   SecondScreenDescription[I] := SecondScreenDescription[I - 1];
  end;
 InitCells(CurrentLine);
end;

procedure TPointOfsalesForm.InsertButtonClick(Sender: TObject);
begin
 InsertLine(CurrentRow);
 StringGrid.Row := CurrentRow;
 CurrentCol := 1; StringGrid.Col := 1;
 StringGrid.SetFocus;
end;

procedure TPointOfsalesForm.StringGridClick(Sender: TObject);
begin
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

procedure TPointOfsalesForm.StringGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key In [VK_RETURN, VK_DELETE, VK_INSERT] then
    begin
     case Key of
       VK_INSERT: InsertButtonClick(Sender);
       VK_DELETE: VoidItemButtonClick(Sender);
       VK_Return: if (StringGrid.Cells[7, StringGrid.Row] <> '') and
                     CheckCells(CurrentCol, CurrentRow) then
                     begin
                      if StringGrid.Row < 50 then
                         StringGrid.Row := StringGrid.Row + 1;
                         StringGrid.Col := 7;
                         CurrentRow := StringGrid.Row;
                         CurrentCol := StringGrid.Col;
                     end;
      end;
     Key := 0;
    end;
end;

procedure TPointOfsalesForm.StringGridKeyPress(Sender: TObject; var Key: Char);
begin
 if Key In ['0'..'9', 'a'..'z', 'A'..'Z', Chr(8)] then Changed := True;
end;

function TPointOfsalesForm.CheckCells(ACol, ARow: integer): boolean;
var
 CellsStr, FieldName, NumStr: string;
 PriceFlag, Temp: integer;
 HappyHourPrice: Boolean;
begin
 Result := True;
 if Not Changed then Exit;
 Changed := False;
 if StringGrid.Cells[ACol, ARow] = '' then
    Exit;
 if HappyHourAvailable and CheckHappyHourTime then
    HappyHourPrice := True
   else
    HappyHourPrice := False;
 CellsStr := StringGrid.Cells[ACol, ARow];
 if (CellsStr <> '0000') and (CellsStr <> '0001') and (CellsStr <> '0002') and
    (CellsStr <> '0003') and (CellsStr <> '0004') and (CellsStr <> '0005') and
    (CellsStr <> '0006') and (CellsStr <> '0007') and (CellsStr <> '0008') and
    (CellsStr <> '0009') and (CellsStr <> '0010') and (CellsStr <> '00011')
      then
 begin
 case ACol of
  7: begin
      if Not TestItemCode(CellsStr, PriceFlag)then
         begin
          Result := False;
          InitCells(ARow);
         end
        else
         with Query do
          begin
           StringGrid.Cells[7, ARow] := FieldByName('ItemCode').AsString;
           CellsStr := StringGrid.Cells[7, ARow];
           DiscountFlag[ARow] := FieldByName('AllowDiscount').AsBoolean;
           OpenPrice[ARow] := FieldByName('OpenPrice').AsBoolean;
           PrintedFlag[ARow] := False;
           CheckListPrinted[ARow] := False;
           OrderInstruction[ARow] := False;
           if Not FieldByName('Instruction').AsBoolean then
              begin
               if StringGrid.Cells[2, ARow] = '' then
                  StringGrid.Cells[2, ARow] := Format('%5.3f', [FieldByName('DefaultQty').AsFloat]);
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
                            DeleteLine
                           until Instruction[ARow] = 0;
                           PriceSelect[ARow] := 0;
                           DiscountFlag[ARow] := False;
                           StringGrid.Col := 1; StringGrid.Row := ARow;
                           Exit;
                          end;
                      end;
                 end;
              end
             else
              begin
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
                      if (StringGrid.Cells[2, ARow] = '') and (ABS(FieldByName('DefaultQty').AsFloat) >= 0.01) then
                         StringGrid.Cells[2, ARow] := Format('%5.3f', [FieldByName('DefaultQty').AsFloat]);
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
                               DeleteLine
                              until Instruction[ARow] = 0;
                              PriceSelect[ARow] := 0;
                              DiscountFlag[ARow] := False;
                              StringGrid.Col := 1; StringGrid.Row := ARow;
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
              end;
           if (DiscountFlag[ARow] or (ForceVIPDiscount and (sVIPNo > 0)))
              and (DiscountRate >= 0.01) then
              StringGrid.Cells[5, ARow] := Format('%4.2f', [DiscountRate])  // DiscountRate
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
           StringGrid.Cells[6, ARow] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);
           SetDescription(ARow);
          end;
      if AutoPriceWindow and OpenPrice[ARow] and (Instruction[ARow] = 0) and
         ((StringGrid.Cells[3, ARow] = '') or (StrToFloat(StringGrid.Cells[3, ARow]) = 0)) then
         begin
          NumStr := '0';
          if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Price', 0) then
             StringGrid.Cells[3, ARow] := Format('%4.2f', [StrToFloat(NumStr)]);
         end;
      if Query.FieldByName('AutoPopSpellInstructionKeyboard').AsBoolean then
         SpellInstructionButtonClick(Self);
      Query.Close;
     end;
  2: if Not CheckNum(CellsStr, 7, 999.99, -999.99, 'F') then
        begin
         StringGrid.Cells[ACol, ARow] := '';
         Result := False
        end
       else
        StringGrid.Cells[ACol, ARow] := Format('%5.3f', [StrToFloat(CellsStr)]);
  3: if Not CheckNum(CellsStr, 10, 9999999.99, 0, 'F') then
        begin
         StringGrid.Cells[ACol, ARow] := '';
         Result := False
        end
       else
        StringGrid.Cells[ACol, ARow] := Format('%4.2f', [Abs(StrToFloat(CellsStr))]);
 end;
 end;
 UpdatePoleMessage;
end;




procedure TPointOfsalesForm.CalcAmount;
var
 I: integer;
 Qty, Price, RealPrice, TaxRate, DiscRate, Discount, GST,
 Amount, TotalAmount, TotalOtherCharge, TotalDiscount, TotalGST, TotalInvoice,
 Receivable: double;
begin
 TotalAmount := 0; TotalGST := 0; TotalDiscount := 0;
 Change := 0;
 //Change1 := 0;

 with StringGrid do
  for I := 1 to 500 do
   begin
    if Cells[2, I] <> '' then Qty := StrToFloat(Cells[2, I]) else Qty := 0;
    if Cells[3, I] <> '' then Price := StrToFloat(Cells[3, I]) else Price := 0;
    if ABS(Price * Qty) >= 0.01 then
       begin
        Amount := Price * Qty;
        Cells[4, I] := Format('%4.2f', [Amount]); // Amount
       end
      else
       begin
        Amount := 0;
        Cells[4, I] := '';   // Amount
       end;
    if Cells[6, I] <> '' then TaxRate:= StrToFloat(Cells[6, I]) else TaxRate := 0;
    if DiscountKind < 2 then
       begin
        if Cells[5, I] <> '' then
           DiscRate := StrToFloat(Format('%6.4f', [StrToFloat(Cells[5, I]) / 100]))
          else
           DiscRate := 0;
        RealPrice := Price * (1 - DiscRate);
        Discount := (Price - RealPrice) * Qty;
        TotalDiscount := TotalDiscount + Discount;
        if CurrentPriceIncludesGST then
           GST := (Amount - Discount) * (1 - 1 / (1 + TaxRate / 100))
          else
           GST := (Amount - Discount) * TaxRate / 100;
       end
      else
       begin
        if CurrentPriceIncludesGST then
           GST := Amount * (1 - 1 / (1 + TaxRate / 100))
          else
           GST := Amount * TaxRate / 100;
       end;
    TotalAmount := TotalAmount + Amount;
    TotalGST := TotalGST + GST;
   end;

 TotalAmount := RoundToCurrency(TotalAmount);
 //PaidAmount := StrToFloat (PaidEdit.Caption);


 if DiscountKind = 0 then
    DiscountTitleLabel.Caption := 'DISCOUNT (' + Format('%4.2f', [DiscountRate]) + '%)'
   else
    begin
     DiscountTitleLabel.Caption := 'DISCOUNT';
     if DiscountKind = 2 then
        begin
         TotalDiscount := DollarDiscount;
         if CurrentPriceIncludesGST then
            TotalGST := TotalGST - DollarDiscount * (1 - 1 / (1 + DefaultGSTRate / 100))
           else
            TotalGST := TotalGST - DollarDiscount * DefaultGSTRate / 100;
        end
    end;

 if ABS(TotalDiscount) <= 0.001 then TotalDiscount := 0;
 TotalDiscount := RoundToCurrency(TotalDiscount);

 if CurrentPriceIncludesGST then
    TotalGST := TotalGST - RewardPointsDiscount * (1 - 1 / (1 + DefaultGSTRate / 100))
   else
    TotalGST := TotalGST - RewardPointsDiscount * DefaultGSTRate / 100;

 TotalOtherCharge := (TotalAmount - TotalDiscount - RewardPointsDiscount) * CurrentOtherChargeRate / 100;
 TotalOtherCharge := RoundToCurrency(TotalOtherCharge);

 if CurrentPriceIncludesGST then
    TotalGST := TotalGST + TotalOtherCharge * (1 - 1 / (1 + DefaultGSTRate / 100))
   else
    TotalGST := TotalGST + TotalOtherCharge * DefaultGSTRate / 100;
 if (TotalAmount >= 0) and (TotalGST <= 0) then TotalGST := 0;

 TotalGST := RoundToCurrency(TotalGST);

  if CurrentPriceIncludesGST then
    begin
     TotalInvoice := TotalAmount + TotalOtherCharge;
     Receivable := TotalAmount - TotalDiscount - RewardPointsDiscount + TotalOtherCharge
    end
   else
    begin
     TotalInvoice := TotalAmount + TotalOtherCharge + TotalGST;
     Receivable := TotalAmount - TotalDiscount - RewardPointsDiscount + TotalOtherCharge + TotalGST;
    end;
 //if(PaidAmount <> 0) then
  //Change := PaidAmount- Receivable ;
 Rounding := PosReceiptForm.CalcRounding(Receivable);
 Receivable := Receivable + Rounding;
 TotalInvoice := RoundToCurrency(TotalInvoice);
 Receivable := RoundToCurrency(Receivable);

 AmountEdit.Caption := Format('%4.2f ', [TotalAmount]);
 DiscountEdit.Caption := Format('%4.2f ', [TotalDiscount]);
 RewardPointsEdit.Caption := Format('%4.2f ', [RewardPointsDiscount]);
 OtherChargeLabel.Caption := Uppercase(OtherChargeName) + ' (' + Format('%4.2f', [CurrentOtherChargeRate]) + '%)';
 OtherChargeEdit.Caption := Format('%4.2f ', [TotalOtherCharge]);
 GSTEdit.Caption := Format('%4.2f ', [TotalGST]);
 TotalEdit.Caption := Format('%4.2f ', [Receivable]);
 BalanceTotal := Receivable;
 //PaidEdit.Caption := Format('%4.2f', [PaidAmount]);
 //ChangeEdit.Caption := Format('%4.2f', [Change]);

 if (FVar.SecondDisplay = 1) and (ClearSecondDisplay) then
 //if (FVar.SecondDisplay = 1) then
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
     SecondDisplayForm.ReceivableEdit.Caption := FormatCurrency(Receivable) + ' ';
    end;
end;

function TPointOfsalesForm.TestItemCode(ItemCode: string; var PriceFlag: integer): boolean;
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

function TPointOfsalesForm.SaveOrderHeadTable(OrderNo: string): boolean;
var
 SQLStr, OrderDateTime, OrderNoStr, TableNo, Person, ServicePerson, Amount,
 GST, MachineName, DueTimeTemp, PriceIncludesGSTTemp, CustomerName,
 OtherChargeRateTemp, OtherChargeTemp, PresetDiscountCodeTemp,
 DiscountOperatorTemp: string;
 AmountTemp, GSTTemp: double;
begin
 OrderNoStr := Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OrderDateTime := ConvertDateTime(Date + Time);
 TableNo := Chr(39) + 'QuickSale' + Chr(39);
 Person := '0';
 ServicePerson := Chr(39) + CheckQuotes(OperatorLabel.Caption) + Chr(39);
 if GSTEdit.Caption <> '' then
    GSTTemp := StrToFloat(GSTEdit.Caption)
   else
    GSTTemp := 0;
 if MachineID <> '' then
    MachineName := Chr(39) + CheckQuotes(MachineID) + Chr(39)
   else
    MachineName := 'Null';
 AmountTemp := StrToFloat(AmountEdit.Caption) - StrToFloat(DiscountEdit.Caption) -
               RewardPointsDiscount;
 Amount := FloatToStr(AmountTemp);
 GST := FloatToStr(GSTTemp);
 if DueTime <> 0 then
    DueTimeTemp := ConvertDateTime(DueTime)
   else
    DueTimeTemp := 'Null';
 if CurrentPriceIncludesGST then
    PriceIncludesGSTTemp := '1'
   else
    PriceIncludesGSTTemp := '0';
 if CustomerNameEdit.Caption <> '' then
    CustomerName := Chr(39) + CheckQuotes(CustomerNameEdit.Caption) + Chr(39)
   else
    CustomerName := 'Null';
 if PresetDiscountCode <> '' then
    PresetDiscountCodeTemp := Chr(39) + CheckQuotes(PresetDiscountCode) + Chr(39)
   else
    PresetDiscountCodeTemp := 'Null';
 OtherChargeRateTemp := FloatToStr(CurrentOtherChargeRate);
 OtherChargeTemp := OtherChargeEdit.Caption;
 if DiscountOperator <> '' then
    DiscountOperatorTemp := Chr(39) + CheckQuotes(DiscountOperator) + Chr(39)
   else
    DiscountOperatorTemp := 'Null';
 SQLStr := 'Insert Into OrderH(OrderDate, OrderNo, Persons, TableNo, ' +
           'ServicePerson, Amount, GST, PaidAmount, Tips, Surcharge, ' +
           'VIPNo, OpName, InvoiceNo, OrderPrinted, Credit, ServiceCharge, ' +
           'ServiceChargeRate, MachineID, BillKind, DollarDiscount, ' +
           'DueTime, DiscountKind, Delivery, OtherCharge, OtherChargeRate, ' +
           'PriceIncludesGST, CurrentGSTRate, RewardPoints, BookingNo, ' +
           'CustomerName, SplitBill, PresetDiscountCode, DiscountOperator) ' +
           'Values(' + OrderDateTime + ',' + OrderNoStr +',' + Person + ',' +
           TableNo + ',' + ServicePerson + ',' + Amount + ',' +
           GST + ', 0, 0, 0,' + IntToStr(sVIPNo) + ',' +
           Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',Null, 0, 0, 0, 0, ' +
           MachineName + ',' + IntToStr(sQUICKSALE) + ',' +
           FloatToStr(DollarDiscount) + ',' + DueTimeTemp + ',' +
           IntToStr(DiscountKind) + ', 0, ' + OtherChargeTemp + ',' +
           OtherChargeRateTemp + ',' + PriceIncludesGSTTemp + ',' +
           FloatToStr(DefaultGSTRate) + ',' + FloatToStr(RewardPointsDiscount) +
           ', Null, ' + CustomerName + ', 0, ' + PresetDiscountCodeTemp + ',' +
           DiscountOperatorTemp + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TPointOfsalesForm.SaveOrderItemTable(OrderNo: string): boolean;
var
 I, IDNo: integer;
 OrderQty: double;
 SQLStr, OrderNoStr, ItemCode, Qty, Price, TaxRate, Discount, PrintFlag,
 CheckListPrinted, PriceSel, SpecialOrder, InstructionTemp,
 OriginalPriceTemp: string;
begin
 I := 1; IDNo := 1; Result := True;
 OrderNoStr := Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 while (I <= 500) and Result do
  begin
   if StringGrid.Cells[7, I] <> '' then
      begin
       ItemCode := StringGrid.Cells[7, I];
       if Stringgrid.Cells[2, I] <> '' then
          OrderQty := StrToFloat(StringGrid.Cells[2, I])
         else
          OrderQty := 0;
       Qty := FloatToStr(OrderQty);
       if StringGrid.Cells[6, I] <> '' then
          TaxRate := StringGrid.cells[6, I]
         else
          TaxRate := '0';
       if Stringgrid.Cells[3, I] <> '' then
          Price := StringGrid.Cells[3, I]
         else
          Price := '0';
       if Stringgrid.Cells[5, I] <> '' then  // DiscountRate
          Discount := StringGrid.Cells[5, I]
         else
          Discount := '0.0';
       if (sHoldNo > 0) and AutoPrintJobListForHoldOrder then
          PrintFlag := '1'
         else
          PrintFlag := '0';
       CheckListPrinted := PrintFlag;
       PriceSel := IntToStr(PriceSelect[I]);
       InstructionTemp := IntToStr(Instruction[I]);
       OriginalPriceTemp := FloatToStr(OriginalPrice[I]);
       if OrderInstruction[I + 1] and (StringGrid.Cells[1, I + 1] <> '') then
          begin
           I := I + 1;
           SpecialOrder := Chr(39) + CheckQuotes(StringGrid.Cells[1, I]) + Chr(39);
          end
         else
          SpecialOrder := 'Null';

       SQLStr := 'Insert Into OrderI(OrderNo, ItemCode, Qty, PaidQty, Price, ' +
                 'Discount, TaxRate, PrintFlag, Condition, PriceSelect, Seat, ' +
                 'SentToKitchen, IDNo, VoidReason, SpecialOrder, CheckListPrinted, ' +
                 'VoidFlag, OrderOperator, OriginalPrice) ' +
                 'Values(' + OrderNoStr + ',' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) + ',' +
                 Qty + ',' + Qty + ',' + Price + ',' + Discount + ',' + TaxRate + ',' +
                 PrintFlag + ',' + InstructionTemp + ',' + PriceSel + ', 0, 0,' +
                 IntToStr(IDNo) + ', Null, ' + SpecialOrder + ',' + CheckListPrinted +
                 ', 0, ' + Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' +
                 OriginalPriceTemp + ')';
       Result := DataForm.ExecQueryPro(SQLStr);
       Inc(IDNo);
      end;
   Inc(I);
  end;
end;

function TPointOfsalesForm.SaveData(OrderNo: string): boolean;
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
 if Result and (sHoldNo >= 0) then Result := DeleteHoldSales(sHoldNo);
end;



procedure TPointOfsalesForm.PaymentButtonClick(Sender: TObject);
var
 PayBy1, PayBy2, SQLStr: string;
 TotalSales, Discount, Amount, Receivable, Tips, Payment1, Payment2, Surcharge: double;
 Flag, LinkToEFTPOS: boolean;
 PayPoints, AwardPoints, DepositID1, DepositID2: integer;
begin
 ClearSecondDisplay := false;
 StringGrid.SetFocus;
 sOrderNo := '';
 if (FindLastRow = 1) or Not DataForm.CheckItemCode(StringGrid, 7) then Exit;
 if CompulsoryEnterCustomerName and (CustomerNameEdit.Caption = '') then
    begin
     MessageBoxForm.MessagePro('Please enter customer name.', sErrorMsg);
     CustomerNameButtonClick(Sender);
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
 Receivable := TotalSales;
 //Rounding := POSReceiptForm.CalcRounding(Receivable);


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
 //if (TotalSales = 0) then
    //exit;
 //if Not POSReceiptForm.ReceiptPro(TotalSales, Receivable, Tips, Payment1, Payment2, Rounding,
        //Surcharge, Change, PayBy1, PayBy2, LinkToEFTPOS, sVIPNo, DepositID1, DepositID2) then
    //begin
     //CalcAmount;
     //Exit;
    //end;
 //Payment1 := Receivable + Rounding;
 Payment1 := PaidAmount;
 //Payment1 := Receivable;
 Change := Change1;
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
    PayBy1 := 'CASH';
 DepositID1 := 0;
 DepositID2 :=0;
 Application.ProcessMessages;
 //POSReceiptForm.PostToSecondDisplay;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 DataForm.GenerateOrderNo(sOrderNo);
 try
  Flag := SaveData(sOrderNo);
  if Flag and LoyaltyAwardAvailible and (sVIPNo >= 1) and (RewardPointsDiscount >= 0.01) then
     begin
      PayPoints := Round(RewardPointsDiscount * PaymentPoints);
      Flag := DataForm.SavePointsPayment(sOrderNo, sVIPNo, PayPoints);
     end;
  if Flag and LoyaltyAwardAvailible and (sVIPNo >= 1) and (TotalSales > 0) then
     begin
      AwardPoints := Round(TotalSales * SalesPoints);
      //AwardPoints := Round(TotalRewardSales * SalesPoints);
      Flag := DataForm.SaveAwardPoints(sOrderNo, sVIPNo, AwardPoints);
     end;
  if Flag and  (ABS(Payment1)>0.005) then
     Flag := DataForm.SaveAccountRecord(sOrderNo,Payment1,PayBy1,1,DepositID1);

  if Flag and (Change1 >= -0.001) and (ABS(Rounding) > 0.005) then
     Flag := DataForm.SaveAccountRecord(sOrderNo, -Rounding, 'ROUNDING', 3, 0);
  if Flag and (Change1 >= 0.009) then
     Flag := DataForm.SaveAccountRecord(sOrderNo, -Change1, 'CASH', 4, 0)
    else
      begin
      SQLStr := 'Update OrderH Set Credit = 1 Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
      end;
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
  {if Flag and (ABS(Surcharge) >= 0.01) then
     begin
      SQLStr := 'Update OrderH Set Surcharge=Surcharge + ' + FloatToStr(Surcharge) +
                ' Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;}
  if (AutoPrintPOSInvoice and EFTPOS) then
    Flag := DataForm.SetInvoiceNo(sOrderNo);
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
      if (AutoPrintPOSOrderList) then
         case PrintBillMode of
           0, 1: PrintOrderForm.PrintOrderPro(sOrderNo);
           2:    PrintOrderForm1.PrintOrderPro(sOrderNo, True);
           3:    PrintOrderForm1.PrintOrderPro(sOrderNo, False);
           4:    PrintOrderForm2.PrintOrderPro(sOrderNo);
           5:    PrintOrderForm3.PrintOrderPro(sOrderNo);
         end;
      if (AutoPrintPOSInvoice and EFTPOS) then
         case PrintInvoiceMode of
          0, 1: PrintInvoiceForm.PrintInvoicePro(sOrderNo);
          2:    PrintInvoiceForm1.PrintInvoicePro(sOrderNo, True);
          3:    PrintInvoiceForm1.PrintInvoicePro(sOrderNo, False);
          4:    PrintInvoiceForm2.PrintInvoicePro(sOrderNo);
          5:    PrintInvoiceForm3.PrintInvoicePro(sOrderNo);
         end;
      if AutoPrintPOSJobList then
         begin
          PrintJobListControlForm.PrintJobListControlPro(sOrderNo, '', False, sConfirmedOrder);
          if AutoPrintCheckList then
             PrintCheckListForm.PrintCheckList(sOrderNo, '', False, sConfirmedOrder);
         end;
      if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(sOrderNo, '', False);
      if ShowPrintInvoiceWindow then
         DispPOSReceiptForm.DispReceiptPro(TotalSales, Receivable, Tips, Payment1,
                  Payment2, Rounding, Surcharge, Change, PayBy1, PayBy2, sOrderNo);
      if AutoReturn then Close
        else
         begin
          InitForm;
          CalcAmount;
          Changed := False;
          if Password then ChangeUserIDButtonClick(Sender);
         end;
     end
    else
     DataForm.RollBack;
 end;
 Number:='0';
 Change1:=0;
 Change:=0;

end;



procedure TPointOfsalesForm.ExitButtonClick(Sender: TObject);
begin
 StringGrid.SetFocus;
 if AuthoriseCloseMainWindow then
    begin
     if (StringGrid.Cells[7, 1] = '') or
        (MessageBoxForm.MessagePro('Are you sure you want to cancel this sales?', sConfirmMsg) = mrYes) then
     Close;
    end;
end;

procedure TPointOfsalesForm.VoidItemButtonClick(Sender: TObject);
begin
 if Instruction[CurrentRow] <> 0 then
    DeleteLine
   else
    repeat
     DeleteLine;
    until (Instruction[CurrentRow] = 0) and Not OrderInstruction[CurrentRow];
 CalcAmount;
 StringGrid.SetFocus;
 CalcBalance
end;

function TPointOfsalesForm.GetLastNonInstructionItem: integer;
var
 I: integer;
begin
 I := FindLastRow;
 if I > 1 then Dec(I);
 while (I > 1) and (Instruction[I] = 1) do
  I := I - 1;
 Result := I;
end;

procedure TPointOfsalesForm.QtyButtonClick(Sender: TObject);
var
 NumStr,test: string;
 I : integer;
begin
 with StringGrid do
  begin
   SetFocus;
   if (Cells[7, Row] = '') or OrderInstruction[Row] then Row := GetLastNonInstructionItem;
   if (Row > 0) and (Cells[7, Row] <> '') then
      begin
       if (Cells[2, Row] <> '') and (StrToFloat(Cells[2, Row]) <> 0) then
          NumStr := Cells[2, Row]
         else
          NumStr := '1';
       if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Qty', 0) then
          begin
           Col := 2; CurrentCol := 2;
           if Not ChangeQtyWithCondiment or (Instruction[Row] <> 0) then
            begin
                I := POS('.', NumStr);
                test := Format('%5.3f', [StrToFloat(NumStr)]);
                //Cells[Col,Row] := test;
                Cells[Col,Row] := Copy(test, 1, I+3);
                
            end
              //Cells[Col, Row] := Format('%5.3f', [StrToFloat(NumStr)])
             else
              repeat
               Cells[Col, Row] := Format('%5.3f', [StrToFloat(NumStr)]);
               Row := Row + 1;
              until Instruction[Row] = 0;
           CurrentRow := Row;
           Changed := True;
           UpdatePoleMessage;
           MoveToNextCell;
          end;
      end;
  end;
  CalcBalance;
end;

procedure TPointOfsalesForm.PriceButtonClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 with StringGrid do
  begin
   SetFocus;
   if (Cells[7, Row] = '') or OrderInstruction[Row] then
      begin
       Row := GetLastNonInstructionItem;
       CurrentRow := Row;
      end;
   if Cells[7, Row] <> '' then
      begin
       if (Cells[3, Row] <> '') and (StrToFloat(Cells[3, Row]) <> 0) then
          NumStr := Cells[3, Row]
         else
          NumStr := '0';
       if (OpenPrice[Row] or Supervisor) and NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Price', 0) then
          begin
           Col := 3; CurrentCol := 3;
           Cells[Col, Row] := Format('%4.2f', [StrToFloat(NumStr)]);

           MoveToNextCell;
          end;
      end;
  end;
  CalcBalance;

end;

procedure TPointOfsalesForm.DiscountButtonClick(Sender: TObject);
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
  0: begin
      DiscountRate := StrToFloat(NumStr);
      DollarDiscount := 0;
      DiscountKind := NewDiscountKind;
      ProcessDiscount;
     end;
  1: begin
      if DiscountKind <> 1 then
         begin
          DiscountRate := 0;;
          DollarDiscount := 0;
          DiscountKind := 0;
          ProcessDiscount;
         end;
      with StringGrid do
       begin
        if Cells[7, Row] = '' then
           begin
            Row := GetLastNonInstructionItem;
            CurrentRow := Row;
           end;
        if (Row > 0) and (Cells[7, Row] <> '') and (Supervisor Or DiscountFlag[Row]) then
           begin
            Col := 5; CurrentCol := 5;
            Cells[Col, Row] := Format('%4.2f', [StrToFloat(NumStr)]);
            Changed := True;
            MoveToNextCell;
           end;
       end;
      DiscountKind := NewDiscountKind;
     end;
  2: begin
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

procedure TPointOfsalesForm.CategoryPageUpButtonClick(Sender: TObject);
begin
 AutoLogoutTimeCounter := 0;
 if CategoryCurrentPage >= 2 then
    begin
     CategoryCurrentPage := CategoryCurrentPage - 1;
     AssignCategoryKeyBoard;
    end;
end;

procedure TPointOfsalesForm.CategoryPageDownButtonClick(Sender: TObject);
begin
 AutoLogoutTimeCounter := 0;
 if (CategoryCurrentPage * CategoryCount) < CategoryRowCount then
    begin
     CategoryCurrentPage := CategoryCurrentPage + 1;
     AssignCategoryKeyBoard;
    end;
end;

procedure TPointOfsalesForm.PageUpButtonClick(Sender: TObject);
begin
 AutoLogoutTimeCounter := 0;
 if MenuCurrentPage >= 2 then
    begin
     MenuCurrentPage := MenuCurrentPage - 1;
     AssignMenuKeyBoard;
    end;
end;

procedure TPointOfsalesForm.PageDownButtonClick(Sender: TObject);
begin
 AutoLogoutTimeCounter := 0;
 if (MenuCurrentPage * MenuCount) < LastMenuPosition then
    begin
     MenuCurrentPage := MenuCurrentPage + 1;
     AssignMenuKeyBoard;
    end;
end;

procedure TPointOfsalesForm.MenuButtonClick(Sender: TObject);
var
 Num: string;
begin
 AutoLogoutTimeCounter := 0;
 with Sender As TPanelButton do
  begin
   Num := Copy(Name, 5, 2);

   if Caption <> '' then ProcessMenuButtonTouch(StrToInt(Num));
   CalcBalance;
  end;
end;

procedure TPointOfsalesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if Not AutoReturn then
    begin
     //DataForm.SendToPoleDisp('       Closed', '');
     DataForm.SendToPoleDisp(' Sorry Closed' ,'');
     DataForm.ClosePoleDisplayPort;
     if FVar.SecondDisplay = 1 then SecondDisplayForm.SetCounterCloseStatus;
    end
   else
    begin
     DataForm.SendToPoleDisp('NEXT CUSTOMER PLEASE', '');
     //DataForm.SendToPoleDisp('    Grand Asian Cafe', '');
     if FVar.SecondDisplay = 1 then SecondDisplayForm.SetWaitingStatus;
    end;
 MenuQuery.Close;
 CategoryQuery.Close;
 Timer.Enabled := False;
 Action := caFree;
end;

procedure TPointOfsalesForm.SetDescription(ARow: integer);
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
    2: Cells[1, ARow] := '[+] ' + Temp;
    3: Cells[1, ARow] := '[-] ' + Temp;
    4: Cells[1, ARow] := '[++] ' + Temp;
    5: Cells[1, ARow] := '[L] ' + Temp;
   end;
  end;
  SecondScreenDescriptionTemp := Copy(SecondScreenDescription[ARow], 1, 4);
  if (SecondScreenDescriptionTemp = '[*] ') or (SecondScreenDescriptionTemp = '[+] ') or
     (SecondScreenDescriptionTemp = '[-] ') or (SecondScreenDescriptionTemp = '[++] ') or
     (SecondScreenDescriptionTemp = '[L] ') then
     SecondScreenDescriptionTemp := Copy(SecondScreenDescription[ARow], 5, Length(SecondScreenDescription[ARow]) - 4)
    else
     SecondScreenDescriptionTemp := SecondScreenDescription[ARow];
  case Instruction[ARow] of
   0: SecondScreenDescription[ARow] := SecondScreenDescriptionTemp;
   1: SecondScreenDescription[ARow] := '[*] ' + SecondScreenDescriptionTemp;
   2: SecondScreenDescription[ARow] := '[+] ' + SecondScreenDescriptionTemp;
   3: SecondScreenDescription[ARow] := '[-] ' + SecondScreenDescriptionTemp;
   4: SecondScreenDescription[ARow] := '[++] ' + SecondScreenDescriptionTemp;
   5: SecondScreenDescription[ARow] := '[L] ' + SecondScreenDescriptionTemp;
  end;
end;

procedure TPointOfsalesForm.ProcessDiscount;
var
 I: integer;
begin
 if DiscountKind = 0 then
    DiscountTitleLabel.Caption := 'DISCOUNT (' + Format('%4.2f', [DiscountRate]) + '%)'
   else
    DiscountTitleLabel.Caption := 'DISCOUNT';
 for I := 1 to 500 do
  with StringGrid do
   if (Cells[7, I] <> '') and (DiscountKind < 2) and
      (DiscountFlag[I] or (ForceVIPDiscount and (sVIPNo > 0))) then
      Cells[5, I] := Format('%4.2f', [DiscountRate])
     else
      Cells[5, I] := '';
 CalcAmount;
end;

procedure TPointOfsalesForm.TimerTimer(Sender: TObject);
begin
 DateLabel.Caption := FormatDateTime('hh:mm', Time);
 if Not Password and AutoLogout then
    begin
     AutoLogoutTimeCounter := AutoLogoutTimeCounter + 1;
     if AutoLogoutTimeCounter >= AutoLogoutTimeout * 60 + 60 then
        begin
         Timer.Enabled := False;
         ChangeUserIDButtonClick(Sender);
         AutoLogoutTimeCounter := 0;
         Timer.Enabled := True;
        end;
    end;
end;

procedure TPointOfsalesForm.CategoryButtonClick(Sender: TObject);
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

procedure TPointOfsalesForm.PrintInvoiceButtonClick(Sender: TObject);
var
 sOrderNo, TableNo: string;
 Flag: boolean;
begin
 StringGrid.SetFocus;
 //if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not PrintInvoiceAuthority then
    begin
     MessageBoxForm.MessagePro('Sorry, you can not print invoice.', sErrorMsg);
     Exit;
    end;
 if Not OrderListForm.OrderListPro(sOrderNo, TableNo) then Exit;
 Flag := True;
 Application.ProcessMessages;
 if DataForm.BeginTransaction then
    try
     Flag := DataForm.SetInvoiceNo(sOrderNo);
    finally
     if Flag then
        begin
         DataForm.CommitTransaction;
         case PrintInvoiceMode of
          0, 1: PrintInvoiceForm.PrintInvoicePro(sOrderNo);
          2:    PrintInvoiceForm1.PrintInvoicePro(sOrderNo, True);
          3:    PrintInvoiceForm1.PrintInvoicePro(sOrderNo, False);
          4:    PrintInvoiceForm2.PrintInvoicePro(sOrderNo);
          5:    PrintInvoiceForm3.PrintInvoicePro(sOrderNo);
         end;
        end
       else
        DataForm.RollBack;
    end;
end;

procedure TPointOfsalesForm.PrintBillButtonClick(Sender: TObject);
var
 sOrderNo, TableNo: string;
begin
 StringGrid.SetFocus;
 if OrderListForm.OrderListPro(sOrderNo, TableNo) then
    case PrintBillMode of
     0, 1: PrintOrderForm.PrintOrderPro(sOrderNo);
     2:    PrintOrderForm1.PrintOrderPro(sOrderNo, True);
     3:    PrintOrderForm1.PrintOrderPro(sOrderNo, False);
     4:    PrintOrderForm2.PrintOrderPro(sOrderNo);
     5:    PrintOrderForm3.PrintOrderPro(sOrderNo);
    end;
end;

procedure TPointOfsalesForm.PrintJobListButtonClick(Sender: TObject);
var
 sOrderNo, TableNo: string;
begin
 StringGrid.SetFocus;
 //if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not PrintJobListAuthority then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to print job list.', sErrorMsg);
     Exit;
    end;
 if OrderListForm.OrderListPro(sOrderNo, TableNo) then
    begin
     Application.ProcessMessages;
     PrintJobListControlForm.PrintJobListControlPro(sOrderNo, '', True, sConfirmedOrder);
     if AutoPrintCheckList then
        PrintCheckListForm.PrintCheckList(sOrderNo, '', True, sConfirmedOrder);
     if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(sOrderNo, '', True);
    end;
end;

{procedure TPointOfsalesForm.PrintJobListButtonClick(Sender: TObject);
begin
if(sOrderNo <> '') then
    begin
      Application.ProcessMessages;
      PrintJobListControlForm.PrintJobListControlPro(sOrderNo, '', True, sConfirmedOrder);
    end;

end;  }


procedure TPointOfsalesForm.PrintPickupSlipButtonClick(Sender: TObject);
begin
if(sOrderNo <> '') then
    begin
      Application.ProcessMessages;
      PrintPickupSlipForm.PrintPickupSlipPro(sOrderNo);
    end;

end;
{var
 sOrderNo, TableNo: string;
begin
 StringGrid.SetFocus;
 if OrderListForm.OrderListPro(sOrderNo, TableNo) then
    begin
     Application.ProcessMessages;
     PrintPickupSlipForm.PrintPickupSlipPro(sOrderNo);
    end;
end; }

procedure TPointOfsalesForm.ViewIngredientsButtonClick(Sender: TObject);
var
 ItemCode: string;
begin
 if StringGrid.Cells[7, CurrentRow] <> '' then
    begin
     ItemCode := StringGrid.Cells[7, CurrentRow];
     //ShowIngredientsForm.ShowIngredientsPro(ItemCode);
    end;
 StringGrid.SetFocus;
end;

procedure TPointOfsalesForm.ConvertLangurage(Firstrow, EndRow: integer);
var
 SQLStr, Description, FieldName: string;
 I: integer;
begin
 for I := FirstRow to EndRow do
  with StringGrid do
   begin
    if Cells[7, I] <> '' then
       begin
        SQLStr := 'Select Description1, Description2, SubDescription, ' +
           'SubDescription1, SubDescription2, SubDescription3, Multiple ' +
           'From MenuItem ' +
           'Where ItemCode=' + Chr(39) + CheckQuotes(Cells[7, I]) + Chr(39);
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
                   Cells[1, I] :=
                     Cells[1, I] + ' / ' + Query.FieldByName(FieldName).AsString;
               end;
            SetDescription(I);
           end;
       Query.Close;
     end;
   end;
end;

procedure TPointOfsalesForm.LangurageButtonClick(Sender: TObject);
begin
 StringGrid.SetFocus;
 Langurage := Not Langurage;
 AssignCategoryKeyBoard;
 AssignMenuKeyBoard;
 ConvertLangurage(1, 500);
end;

procedure TPointOfsalesForm.OpenDrawerButtonClick(Sender: TObject);
begin
 if FindLastRow > 1 then
    MessageBoxForm.MessagePro('Transaction has not been finished, can not open the Drawer.', sErrorMsg)
   else
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
                 if FVar.CashDrawerPort > 0 then CurrentDrawerNumber := 0
                   else
                    if FVar.SecondCashDrawerPort > 0 then CurrentDrawerNumber := 1
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
       end
      else
       MessageBoxForm.MessagePro('You have not been authorised to open the drawer.', sErrorMsg);
 StringGrid.SetFocus;
end;

{procedure TPointOfsalesForm.InstructionButtonClick(Sender: TObject);
var
 Temp, CurRow: integer;
 ItemCode: string;
 Buff: InstructionBuffType;
begin
 StringGrid.SetFocus;
 CurRow := StringGrid.Row;
 if (StringGrid.Cells[7, CurRow] <> '') and (Instruction[CurRow] > 0) then
    begin
     Temp := InstructionForm.InstructionPro;
     if Temp >= 0 then
        begin
         Instruction[CurRow] := Temp;
         SetDescription(CurRow);
        end;
    end
   else
    if StringGrid.Cells[7, CurrentRow] <> '' then
       begin
        ItemCode := StringGrid.Cells[7, CurrentRow];
        if DataForm.CheckInstructionLink(ItemCode) and
           InstructionListForm.InstructionPro(ItemCode, Langurage, Buff) then
           ProcessInstruction(Buff);
       end;
 if StringGrid.Enabled then StringGrid.SetFocus;
end; }


procedure TPointOfsalesForm.UpdatePoleMessage;
var
 I: integer;
 Price, Qty: double;
 S1, S2: string;
begin
 with StringGrid do
  begin
   I := Row;
   if Cells[7, I] = '' then
      begin
       if (Row > 1) and (Cells[1, I - 1] <> '') then
          I := I - 1;
      end;
   if Cells[7, I] <> '' then
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
           S1 := FormatCurrency(Price) + ' X ' + Format('%5.3f', [Qty]);
           S1 := Format('%20s', [S1]);
           //S2 := 'Amount' + Format('%14s', [FormatCurrency(Qty * Price)]);
           S2 := 'Subtotal' + Format('%12s', [FormatCurrency(poleSubtotal)]);
          end
         else
          begin
           S1 := Copy(Cells[1, I], 1, 20);
           if Length(S1) < 20 then
              S1 := S1 + Format('%' + IntToStr(20 - Length(S1)) + 's', [' ']);
           S2 := FormatCurrency(Price) + ' X ' + Format('%5.3f', [Qty]);
           S2 := Format('%20s', [S2]);
          end;
       if FVar.PoleDisplayPort > 0 then DataForm.SendToPoleDisp(S1, S2);
       //if FVar.PoleDisplayPort > 0 then DataForm.SendToPoleDisp('Item Price',S2);
       if FVar.SecondDisplay = 1 then SecondDisplayForm.SetSalesStatus;
      end;
  end;
end;

procedure TPointOfsalesForm.SpellInstructionButtonClick(Sender: TObject);
var
 Temp: string;
 CurRow: integer;
begin
 with StringGrid do
  begin
   CurRow := Row;
   if ((CurRow > 1) and OrderInstruction[CurRow - 1]) or
      ((Cells[1, CurRow] = '') and (CurRow > 1) and (Cells[1, CurRow - 1] = '')) then Exit;
   if (CurRow > 0) and (Cells[1, CurRow] <> '') and Not OrderInstruction[CurRow] then
      CurRow := FindLastRow;
   if (KeyboardForm.KeyboardPro(Temp)) and (Temp <> '') then
      begin
       Cells[1, CurRow] := Temp;
       OrderInstruction[CurRow] := True;
       Instruction[CurRow] := 1;
      end;
   SetFocus;   
  end;
end;

procedure TPointOfsalesForm.CustomerNameButtonClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    begin
     CustomerNameEdit.Caption := Copy(Str, 1, 30);
     if sVIPNo >= 1 then
        begin
         sVIPNo := 0;
         DiscountRate := 0;
         DiscountKind := 0;
         ProcessDiscount;
        end;
    end;
end;

procedure TPointOfSalesForm.VIPListButtonClick(Sender: TObject);
var
 VIPPoints: integer;
 AvailableCredit, VIPDiscountRate: double;
 VIPName: string;
begin
 StringGrid.SetFocus;
 if VIPListForm.VIPListPro(sVIPNo) then
    begin
     if DataForm.ReadVIPInformation(sVIPNo, VIPName, VIPDiscountRate) then
        begin
         CustomerNameEdit.Caption := VIPName;
         DiscountRate := VIPDiscountRate;
         if VIPDiscountRate > 0 then
            DiscountOperator := sUserName;
        end
       else
        begin
         CustomerNameEdit.Caption := '';
         DiscountOperator := '';
         DiscountRate := 0;
        end;
    end
   else
    begin
     CustomerNameEdit.Caption := '';
     DiscountRate := 0;
     DiscountOperator := '';
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
end;


procedure TPointOfsalesForm.ChangeUserIDButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 Repeat
  Flag := DataForm.VerifyPassword(sUserName);
  if Flag and Not MainForm.QuickServiceMenu.Enabled then
     begin
      MessageBoxForm.MessagePro('You have not been authorised to do quick servie.', sErrorMsg);
      Flag := False;
     end;
 Until Flag;
 ReadHoldHead(sUserName, sHoldNo);
 ReadHoldItem(sHoldNo);
 OperatorLabel.Caption := sUserName;

 StringGrid.SetFocus;
end;

procedure TPointOfSalesForm.RewardPointsProcess;
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
         if RewardPointsForm.GetRewardPointsPro(AsDollars, sVIPNo, CurrentSalesAmount, '') then
            begin
             RewardPointsDiscount := AsDollars;
             CalcAmount;
            end;
        end;
    end;
end;


procedure TPointOfsalesForm.MoreFunctionButtonClick(Sender: TObject);
var
 Operation: integer;
 Temp, NumStr: string;
begin
 StringGrid.SetFocus;
 if POSFunctionForm.FunctionPro(Operation) then
    case Operation of
     1: if MainForm.MenuSetupMenu.Enabled then
           begin
            if MenuItemForm.MenuSetup(1) then
               begin
                OpenCategory;
                AssignCategoryKeyBoard;
                ProcessCategoryButtonTouch(1);
                AssignMenuKeyBoard;
               end
           end
          else
           MessageBoxForm.MessagePro('You have not been authorised to do menu setup.', sErrorMsg);
     2: if DataForm.VerifyPassword(sUserName) then
           begin
            if MainForm.DailyReportMenu.Enabled then
               EndOfdayForm.DailyReportPro(1)
              else
               MessageBoxForm.MessagePro('You have not been authorised to do Daily Report.', sErrorMsg);
           end;
     3: if MainForm.CashFloatMenu.Enabled then
           CashFloatForm.CashFloatPro
          else
           MessageBoxForm.MessagePro('You have not been authorised to do cash in / cash out.', sErrorMsg);
     4: begin
         if DueTime <> 0 then
            Temp := FormatDateTime('hh:mm', DueTime)
           else
            Temp := FormatDateTime('hh:mm', Time);
         if TimeForm.ReadTimePro(Temp) then
            DueTime := StrToTime(Temp);
        end;
     5: begin
         //CopyMealPackage;
         //StringGrid.SetFocus;
        end;
     6: RewardPointsProcess;
     7: begin
         if MainForm.DepositMenu.Enabled then
            DepositForm.DepositPro(0)
           else
            MessageBoxForm.MessagePro('You have not been authorised to receive deposit.', sErrorMsg);
        end;
     8: begin
         if OtherChargeEnable then
            begin
             NumStr := FloatToStr(CurrentOtherChargeRate);
             if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Other Charge Rate', 0) then
                begin
                 CurrentOtherChargeRate := Round(StrToFloat(NumStr));
                 CalcAmount;
                end;
            end
           else
            MessageBoxForm.MessagePro('Other Charge function is inactive.', sErrorMsg);
        end;
    end;
end;

{procedure TPointOfsalesForm.WeightButtonClick(Sender: TObject);
begin
  SalesHistoryListForm.SalesHistoryListPro(0);
end; }


procedure TPointOfsalesForm.WeightButtonClick(Sender: TObject);
var
 Flag: boolean;
 Weight: double;
begin
 if FVar.ScalePort = 0 then Exit;
 with StringGrid do
  begin
   SetFocus;
   if Cells[7, Row] = '' then
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
   if Flag and (Row > 0) and (Cells[7, Row] <> '') then
      begin
       Weight := Weight - tare;
       Col := 2; CurrentCol := 2;
       Cells[Col, Row] := FloatToStr(Weight);
       Changed := True;
       UpdatePoleMessage;
       MoveToNextCell;
      end;
  end;
end;


//tare button
procedure TPointOfsalesForm.InstructionButtonClick(Sender: TObject);
var
 Flag: boolean;
 Weight: double;
begin
 if FVar.ScalePort = 0 then Exit;
 with StringGrid do
  begin
   SetFocus;
   if Cells[7, Row] = '' then
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
   //flag := true;
   if Flag then
      begin
       //Col := 2; CurrentCol := 2;
       //Cells[Col, Row] := FloatToStr(Weight);
       //weight := 0.050;
       tare := weight;
       tareLabel.Caption := FloatToStr(tare);
       Changed := True;
       //UpdatePoleMessage;
       //MoveToNextCell;
      end;
  end;
end;

procedure TPointOfsalesForm.AccountPaymentButtonClick(Sender: TObject);
var
 SQLStr, sOrderNo: string;
 Flag: boolean;
 CurrentSales: double;
begin
 StringGrid.SetFocus;
 if FindLastRow = 1 then Exit;
 if sVIPNo = 0 then
    begin
     MessageBoxForm.MessagePro('This order has not been entered the V.I.P. number!', sErrorMsg);
     Exit;
    end;
 CalcAmount;
 CurrentSales := StrToFloat(TotalEdit.Caption);
 if Not DataForm.CheckVIPCreditStatus(sVIPNo, CurrentSales, '') then
    begin
     MessageBoxForm.MessagePro('This customer credit is over.', sErrorMsg );
     Exit;
    end;
 if MessageBoxForm.MessagePro('Are you sure you want to put this order to account payment?', sConfirmMsg) = mrNo then
    Exit;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 DataForm.GenerateOrderNo(sOrderNo);
 try
  Flag := SaveData(sOrderNo);
  if Flag then
     begin
      SQLStr := 'Update OrderH Set Credit = 1 Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag and AutoPrintPOSInvoice then Flag := DataForm.SetInvoiceNo(sOrderNo);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      InitForm;
      CalcAmount;
      Changed := False;
      if Not OnlyOpenDrawerForCashPayment then
         begin
          CurrentDrawerNumber := DefaultDrawerPortNumber;
          DataForm.OpenDrawer(True, CurrentDrawerNumber);
         end; 
      if AutoPrintPOSJobList then
         begin
          PrintJobListControlForm.PrintJobListControlPro(sOrderNo, '', False, sConfirmedOrder);
          if AutoPrintCheckList then
             PrintCheckListForm.PrintCheckList(sOrderNo, '', True, sConfirmedOrder);
         end;
      {case PrintBillMode of
       0, 1: PrintOrderForm.PrintOrderPro(sOrderNo);
       2:    PrintOrderForm1.PrintOrderPro(sOrderNo, True);
       3:    PrintOrderForm1.PrintOrderPro(sOrderNo, False);
       4:    PrintOrderForm2.PrintOrderPro(sOrderNo);
       5:    PrintOrderForm3.PrintOrderPro(sOrderNo);
      end;}
      if AutoPrintPOSInvoice then
         case PrintInvoiceMode of
          0, 1: PrintInvoiceForm.PrintInvoicePro(sOrderNo);
          2:    PrintInvoiceForm1.PrintInvoicePro(sOrderNo, True);
          3:    PrintInvoiceForm1.PrintInvoicePro(sOrderNo, False);
          4:    PrintInvoiceForm2.PrintInvoicePro(sOrderNo);
          5:    PrintInvoiceForm3.PrintInvoicePro(sOrderNo);
         end;
      if AutoPrintPickupSlip then PrintPickupSlipForm.PrintPickupSlipPro(sOrderNo);
      if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(sOrderNo, '', True);
      if Password then ChangeUserIDButtonClick(Sender);
     end
    else
     DataForm.RollBack;
 end;
end;

{procedure TPointOfSalesForm.CopyMealPackage;
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
         PrintedFlag[I] := False;
         CheckListPrinted[I]:= False;
         PriceSelect[I] := FieldByName('PriceSelect').AsInteger;
         OriginalPrice[I] := FieldByName('Price').AsFloat;
         StringGrid.Cells[7, I] := FieldByName('ItemCode').AsString;
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
            StringGrid.Cells[2, I] := Format('%4.2f', [Qty * FieldByName('Qty').AsFloat]);
         if ABS(FieldByName('Price').AsFloat) >= 0.01 then
            StringGrid.Cells[3, I] := Format('%4.2f', [FieldByName('Price').AsFloat]);
         if (FieldByName('AllowDiscount').AsBoolean or
            (ForceVIPDiscount and (sVIPName > 0))) then
            StringGrid.Cells[5, I] := Format('%4.2f', [DiscountRate]);  // DiscountRate
         StringGrid.Cells[4, I] := ''; // Amount
         StringGrid.Cells[6, I] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);
         SetDescription(I);
         Next; I := I + 1;
        end;
      Close;
     end;
 CalcAmount;
end;
}

function TPointOfsalesForm.MakeHoldNo: integer;
var
 SQLStr: string;
begin
 SQLStr := 'Select Max(HoldNo) From HoldHead';
 OpenQuery(SQLStr);
 with Query do
  begin
   if Active and (RecordCount <> 0) and (Fields[0].AsInteger <> 0) then
      Result := Fields[0].AsInteger + 1
     else
      Result := 1;
   Close;
  end;
end;

function TPointOfsalesForm.SaveHoldHead(HoldNo: integer; CustomerName, Telephone: string): boolean;
var
 SQLStr, MachineName, CustomerTemp, TelephoneTemp, DueTimeTemp, GSTStatusFlag,
 PresetDiscountCodeTemp, DiscountOperatorTemp: string;
begin
 if MachineID <> '' then
    MachineName := Chr(39) + CheckQuotes(MachineID) + Chr(39)
   else
    MachineName := 'Null';
 if CustomerName <> '' then
    CustomerTemp := Chr(39) + CheckQuotes(CustomerName) + Chr(39)
   else
    CustomerTemp := 'Null';
 if Telephone <> '' then
    TelephoneTemp := Chr(39) + CheckQuotes(Telephone) + Chr(39)
   else
    TelephoneTemp := 'Null';
 if DueTime <> 0 then
    DueTimeTemp := ConvertDateTime(DueTime)
   else
    DueTimeTemp := 'Null';
 if CurrentPriceIncludesGST then
    GSTStatusFlag := '1'
   else
    GSTStatusFlag := '0';
 if PresetDiscountCode <> '' then
    PresetDiscountCodeTemp := Chr(39) + CheckQuotes(PresetDiscountCode) + Chr(39)
   else
    PresetDiscountCodeTemp := 'Null';
 if DiscountOperator <> '' then
    DiscountOperatorTemp := Chr(39) + CheckQuotes(DiscountOperator) + Chr(39)
   else
    DiscountOperatorTemp := 'Null';
 SQLStr := 'Insert Into HoldHead(HoldNo, HoldDate, DiscountKind, DiscountPercent, ' +
           'DiscountDollar, MachineID, OpName, CustomerName, Telephone, DueTime, ' +
           'GSTStatus, PresetDiscountCode, DiscountOperator) ' +
           'Values(' + IntToStr(HoldNo) + ',' + ConvertDateTime(Date + Time) + ',' +
           IntToStr(DiscountKind) + ',' + FloatToStr(DiscountRate) + ',' +
           FloatToStr(DollarDiscount) + ',' + MachineName + ',' +
           Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' + CustomerTemp + ',' +
           TelephoneTemp + ',' + DueTimeTemp + ',' + GSTStatusFlag + ',' +
           PresetDiscountCodeTemp + ',' + DiscountOperatorTemp + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TPointOfsalesForm.SaveHoldItem(HoldNo: integer): boolean;
var
 I, IDNo: Integer;
 SQLStr, ItemCode, Qty, Price, ItemDiscountRate, Condition, PriceSelectTemp,
 SpecialOrder, Printed, CheckListPrintedFlag, OriginalPriceTemp: string;
begin
 SQLStr := 'Select Max(ID) From HoldItem Where HoldNo=' + IntToStr(HoldNo);
 OpenQuery(SQLStr);
 with Query do
  begin
   if Active and (Fields[0].AsInteger >= 1) then
    IDNo := Fields[0].AsInteger + 1
   else
    IDNo := 1;
   Close;
  end;
 I := 1; Result := True;
 with StringGrid do
  while (I <= 500) and Result do
   begin
    if Cells[7, I] <> '' then
       begin
        ItemCode := Chr(39) + CheckQuotes(Cells[7, I]) + Chr(39);
        if Cells[2, I] <> '' then
           Qty := Format('%5.3f', [StrToFloat(Cells[2, I])])
          else
           Qty := Format('%5.3f', [0.0]);
        if Cells[3, I] <> '' then
           Price := Format('%4.2f', [StrToFloat(Cells[3, I])])
          else
           Price := '0.0';
        if Cells[5, I] <> '' then
           ItemDiscountRate := Format('%5.2f', [StrToFloat(Cells[5, I])])   // DiscountRate
          else
           ItemDiscountRate := '0.0';
        Condition := IntToStr(Instruction[I]);
        PriceSelectTemp := IntToStr(PriceSelect[I]);
        if PrintedFlag[I] then Printed := '1' else Printed := '0';
        if CheckListPrinted[I] then CheckListPrintedFlag := '1' else CheckListPrintedFlag := '0';
        if OrderInstruction[I + 1] and (StringGrid.Cells[1, I + 1] <> '') then
          begin
           I := I + 1;
           SpecialOrder := Chr(39) + CheckQuotes(StringGrid.Cells[1, I]) + Chr(39);
          end
         else
          SpecialOrder := 'Null';
        OriginalPriceTemp := FloatToStr(OriginalPrice[I]);
        SQLStr := 'Insert Into HoldItem(HoldNo, ItemCode, Qty, Price, ' +
                  'Discount, Condition, PriceSelect, SpecialOrder, ' +
                  'Printed, CheckListPrinted, OriginalPrice, ID) ' +
                  'Values(' + IntToStr(HoldNo) + ',' + ItemCode + ',' +
                  Qty + ',' + Price + ',' + ItemDiscountRate + ',' +
                  Condition + ',' + PriceSelectTemp + ',' + SpecialOrder + ',' +
                  Printed + ',' + CheckListPrintedFlag + ',' + OriginalPriceTemp +
                  ',' + IntToStr(IDNo) + ')';
        Result := DataForm.ExecQueryPro(SQLStr);
        IDNo := IDNo + 1;
       end;
    I := I + 1;
   end;
end;

function TPointOfsalesForm.SaveHoldDataPro(var HoldNo: integer; CustomerName, Telephone: string;
         UpdateHoldHeadRecord, DeleteExistingItems: Boolean): boolean;
var
 SQLStr: string;
 CurrentHoldNo: integer;
begin
 Result := False;
 if Not DataForm.BeginTransaction then Exit
   else
    Result := True;
 if HoldNo = 0 then
    CurrentHoldNo := MakeHoldNo
   else
    CurrentHoldNo := HoldNo;
 try
  if UpdateHoldHeadRecord then
     begin
      SQLStr := 'Delete From HoldHead Where HoldNo=' + IntToStr(CurrentHoldNo);
      Result := DataForm.ExecQueryPro(SQLStr);
     end;
  if Result and DeleteExistingItems then
     begin
      SQLStr := 'Delete From HoldItem Where HoldNo=' + IntToStr(CurrentHoldNo);
      Result := DataForm.ExecQueryPro(SQLStr);
     end;
  if Result and UpdateHoldHeadRecord then Result := SaveHoldHead(CurrentHoldNo, CustomerName, Telephone);
  if Result then Result := SaveHoldItem(CurrentHoldNo);
 finally
  if Result then
     begin
      DataForm.CommitTransaction;
      HoldNo := CurrentHoldNo;
      InitForm;
      CalcAmount;
     end
    else
     DataForm.RollBack;
 end;
end;

{function TPointOfsalesForm.ReadHoldHead(HoldNo: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From HoldHead Where HoldNo=' + IntToStr(HoldNo);
 Result := OpenQuery(SQLStr);
 with Query do
  begin
   DiscountRate := FieldByName('DiscountPercent').AsFloat;
   DollarDiscount := FieldByName('DiscountDollar').AsFloat;
   DiscountKind := FieldByName('DiscountKind').AsInteger;
   DueTime := FieldByName('DueTime').AsDateTime;
   CurrentPriceIncludesGST := FieldByName('GSTStatus').AsBoolean;
   CustomerNameEdit.Caption := FieldByName('CustomerName').AsString;
   PresetDiscountCode := FieldByName('PresetDiscountCode').AsString;
   DiscountOperator := FieldByName('DiscountOperator').AsString;
   Close;
  end;
end; }


function TPointOfsalesForm.ReadHoldHead(StaffName: string ;var HoldNo: integer): boolean;
var
 SQLStr: string;
begin
 //SQLStr := 'Select * From HoldHead Where OpName=' + Chr(39) + StaffName + Chr(39);
 SQLStr := 'Select * From HoldHead Where HoldNo=' + IntToStr(HoldNo);
 Result := OpenQuery(SQLStr);
 if Query.RecordCount > 0 then
 begin
  with Query do
    begin
      DiscountRate := FieldByName('DiscountPercent').AsFloat;
      DollarDiscount := FieldByName('DiscountDollar').AsFloat;
      DiscountKind := FieldByName('DiscountKind').AsInteger;
      DueTime := FieldByName('DueTime').AsDateTime;
      CurrentPriceIncludesGST := FieldByName('GSTStatus').AsBoolean;
      CustomerNameEdit.Caption := FieldByName('CustomerName').AsString;
      PresetDiscountCode := FieldByName('PresetDiscountCode').AsString;
      DiscountOperator := FieldByName('DiscountOperator').AsString;
      HoldNo := FieldByName('HoldNo').AsInteger;
      Close;
      end;
  end;    
 PaidAmount := 0;
 Change := 0;
 PaidEdit.Caption := Format('%4.2f', [PaidAmount]);
 ChangeEdit.Caption := Format('%4.2f', [Change]);
end;

function TPointOfsalesForm.ReadHoldItem(HoldNo: integer): boolean;
var
 SQLStr, FieldName: string;
 I: integer;
begin
 SQLStr := 'Select HoldItem.ItemCode, Qty, HoldItem.Price, Description1, ' +
           'Description2, TaxRate, OpenPrice, HoldItem.Discount, ' +
           'AllowDiscount, HoldItem.Condition, Multiple, ' +
           'HoldItem.PriceSelect, SubDescription, SubDescription1, ' +
           'SubDescription2, SubDescription3, SpecialOrder, Printed, ' +
           'CheckListPrinted, OriginalPrice, ID ' +
           'From HoldItem, MenuItem ' +
           'Where HoldItem.ItemCode = MenuItem.ItemCode and ' +
           'HoldNo=' + IntToStr(HoldNo) +
           ' Order By ID';
 Result := OpenQuery(SQLStr);
 with Query do
  begin
   First; I := 1;
   while Not EOF do
    begin
     StringGrid.Cells[7, I] := FieldByName('ItemCode').AsString;
     Instruction[I] := FieldByName('Condition').AsInteger;
     OrderInstruction[I] := False;
     OpenPrice[I] := FieldByName('OpenPrice').AsBoolean;
     DiscountFlag[I] := FieldByName('AllowDiscount').AsBoolean;
     PriceSelect[I] := FieldByName('PriceSelect').AsInteger;
     PrintedFlag[I] := FieldByName('Printed').AsBoolean;
     CheckListPrinted[I] := FieldByName('CheckListPrinted').AsBoolean;
     OriginalPrice[I] := FieldByName('OriginalPrice').AsFloat;
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
        StringGrid.Cells[2, I] := Format('%5.3f', [FieldByName('Qty').AsFloat]);
     if ABS(FieldByName('Price').AsFloat) >= 0.01 then
        StringGrid.Cells[3, I] := Format('%4.2f', [FieldByName('Price').AsFloat]);
     StringGrid.Cells[5, I] := Format('%4.2f', [FieldByName('Discount').AsFloat]); // DiscountRate
     if (DiscountKind = 0) and (Abs(FieldByName('Discount').AsFloat) >= 0.01) then
         DiscountRate := FieldByName('Discount').AsFloat;
     StringGrid.Cells[6, I] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);

     SetDescription(I);
     if FieldByName('SpecialOrder').AsString <> '' then
        begin
         I := I + 1;
         StringGrid.Cells[1, I] := FieldByName('SpecialOrder').AsString;
         Instruction[I] := 1;
         OrderInstruction[I] := True;
         OpenPrice[I] := False;
         DiscountFlag[I] := False;
         PriceSelect[I] := 0;
         PrintedFlag[I] := False;
         CheckListPrinted[I] := False;
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
end;

function TPointOfsalesForm.DeleteHoldSales(HoldNo: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From HoldHead Where HoldNo=' + IntToStr(HoldNo);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From HoldItem Where HoldNo=' + IntToStr(HoldNo);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

procedure TPointOfsalesForm.ZoomButtonClick(Sender: TObject);
var
 CurrentRow: integer;
begin
 CurrentRow := FindLastRow;
 ButtonPanel.Visible := Not ButtonPanel.Visible;
 if ButtonPanel.Visible then
    begin
     TotalPanel.Top := BackPanel.Height - TotalPanel.Height - ButtonPanel.Height - 6;
     StringGridPanel.Height := BackPanel.Height - TotalPanel.Height -
                          ButtonPanel.Height - TitlePanel.Height - 13;
     if CurrentRow > 15 then
        StringGrid.TopRow := CurrentRow - 14
       else
        StringGrid.TopRow := 1;
    end
   else
    begin
     TotalPanel.Top := BackPanel.Height - TotalPanel.Height - 4;
     StringGridPanel.Height := BackPanel.Height - TotalPanel.Height - TitlePanel.Height - 11;
     if CurrentRow > 27 then
        StringGrid.TopRow := CurrentRow - 26
       else
        StringGrid.TopRow := 1;
    end
end;

{procedure TPointOfSalesForm.HoldOrderButtonClick(Sender: TObject);
var
 CurrentHoldNo, ModeSelected: integer;
 CustomerName, Telephone: string;
 Flag: Boolean;
begin
 if FindLastRow <= 1 then Exit;
 CustomerName := ''; Telephone := '';
 Flag := False;
 if sHoldNo = 0 then  // Not Edit Hold Order Mode
    begin
     if Not HoldModeSelectForm.HoldModeSelectPro(ModeSelected) then Exit; // Read Save Mode
     case ModeSelected of
      0: begin // Create Now Hold Order
          if CustomerNameEdit.Caption = '' then
             begin
              if Not CustomerInformationForm.ReadCustomerInfo(CustomerName, Telephone) then Exit
             end
            else
             CustomerName := CustomerNameEdit.Caption;
          Flag := SaveHoldDataPro(CurrentHoldNo, CustomerName, Telephone, True, True);
         end;
      1: begin // Save to existing Hold Order, Read Hold Order No
          if Not HoldOrderListForm.HoldOrderListPro(CurrentHoldNo) then Exit;
          Flag := SaveHoldDataPro(CurrentHoldNo, CustomerName, Telephone, False, False);
         end;
     end
    end
   else
    begin
     CurrentHoldNo := sHoldNo;
     Flag := SaveHoldDataPro(CurrentHoldNo, CustomerName, Telephone, False, True);
    end;
 if Flag then
    begin
     if AutoPrintJobListForHoldOrder then
        PrintJobListControlForm.PrintJobListControlPro(IntToStr(CurrentHoldNo), '', False, sUnConfirmedOrder);
     if AutoPrintCheckList then
        PrintCheckListForm.PrintCheckList(IntToStr(CurrentHoldNo), '', False, sUnConfirmedOrder);
     if AutoReturn then Close
    end;
end; }

procedure TPointOfSalesForm.HoldOrderButtonClick(Sender: TObject);
var
 CurrentHoldNo, ModeSelected: integer;
 CustomerName, Telephone: string;
 Flag: Boolean;
begin
 if FindLastRow <= 1 then Exit;
 //CustomerName := ''; Telephone := '';
 Flag := False;
 {if sHoldNo = 0 then  // Not Edit Hold Order Mode
    begin
     if Not HoldModeSelectForm.HoldModeSelectPro(ModeSelected) then Exit; // Read Save Mode
     case ModeSelected of
      0: begin // Create Now Hold Order
          if CustomerNameEdit.Caption = '' then
             begin
              if Not CustomerInformationForm.ReadCustomerInfo(CustomerName, Telephone) then Exit
             end
            else
             CustomerName := CustomerNameEdit.Caption;
          Flag := SaveHoldDataPro(CurrentHoldNo, CustomerName, Telephone, True, True);
         end;
      1: begin // Save to existing Hold Order, Read Hold Order No
          if Not HoldOrderListForm.HoldOrderListPro(CurrentHoldNo) then Exit;
          Flag := SaveHoldDataPro(CurrentHoldNo, CustomerName, Telephone, False, False);
         end;
     end
    end
   else
    begin
     CurrentHoldNo := sHoldNo;
     Flag := SaveHoldDataPro(CurrentHoldNo, CustomerName, Telephone, False, True);
    end; }
 if sHoldNo = 0 then
  begin
    if (CustomerNameEdit.Caption = '') AND CompulsoryEnterCustomerName then
      begin
        CustomerNameButtonClick(Sender);
        CustomerName := CustomerNameEdit.Caption;
      end
    else if  CustomerNameEdit.Caption <> '' then
        CustomerName := CustomerNameEdit.Caption
    else
        CustomerName := 'HoldOrder' + IntToStr(CurrentHoldNo);
    Flag := SaveHoldDataPro(CurrentHoldNo, CustomerName, Telephone, True, True);
  end
 else
  begin
    CurrentHoldNo := sHoldNo;
    Flag := SaveHoldDataPro(CurrentHoldNo,CustomerName,Telephone,False,True);
  end;


 if Flag then
    begin
     if AutoPrintJobListForHoldOrder then
        PrintJobListControlForm.PrintJobListControlPro(IntToStr(CurrentHoldNo), '', False, sUnConfirmedOrder);
     if AutoPrintCheckList then
        PrintCheckListForm.PrintCheckList(IntToStr(CurrentHoldNo), '', False, sUnConfirmedOrder);
     //if AutoReturn then Close
     if Password then ChangeUserIDButtonClick(Sender);
    end;
end;

procedure TPointOfSalesForm.RecallOrderButtonClick(Sender: TObject);
begin
 PaidAmount := 0;
 Change := 0;
 PaidEdit.Caption := Format('%4.2f', [PaidAmount]);
 ChangeEdit.Caption := Format('%4.2f', [Change]);
 if (FindLastRow = 1) or (MessageBoxForm.MessagePro('Are you sure you want to cancel current sales?', sConfirmMsg) = mrYes) then
    begin
     InitForm;
     if HoldAdminForm.HoldAdminPro(sHoldNo) then
        begin
         if ReadHoldHead(sUserName,sHoldNo) and ReadHoldItem(sHoldNo) then
            ProcessDiscount;
        end;
    end;
end;


procedure TPointOfsalesForm.MenuGroupButtonClick(Sender: TObject);
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

procedure TPointOfsalesForm.CashPayOutButtonClick(Sender: TObject);
begin
 if MainForm.CashPayOutMenu.Enabled then
    PayOutForm.PayOutPro
end;

function  TPointOfsalesForm.GetOtherChargeRate: double;
begin
 if OtherChargeEnable then
    Result := OtherChargeRate
   else
    Result := 0;
end;

procedure TPointOfsalesForm.SendToSecurityPortPro(OperationMessage, PayBy1, PayBy2: string; Payment1, Payment2, Rounding, Change: double);
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

 PrintStr := DiscountTitleLabel.Caption + ': ' + Format('%8s', [FormatCurrency(StrToFloat(DiscountEdit.Caption))]);
 PrintStr := Format('%40s', [PrintStr]);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 if RewardPointsEdit.Visible then
    begin
     PrintStr := 'POINTS REDEEM: ' + Format('%8s', [FormatCurrency(StrToFloat(RewardPointsEdit.Caption))]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if OtherChargeEdit.Visible then
    begin
     PrintStr := OtherChargeLabel.Caption + ': ' + Format('%8s', [FormatCurrency(StrToFloat(OtherChargeEdit.Caption))]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 PrintStr := 'Total: ' + Format('%8s', [FormatCurrency(StrToFloat(TotalEdit.Caption))]);
 PrintStr := Format('%40s', [PrintStr]);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

  if ABS(Payment1) > 0.01 then
    begin
     PrintStr := PayBy1 + ': ' + Format('%8s', [FormatCurrency(Payment1)]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if ABS(Payment2) > 0.01 then
    begin
     PrintStr := PayBy2 + ': ' + Format('%8s', [FormatCurrency(Payment2)]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if ABS(Rounding) > 0.01 then
    begin
     PrintStr := 'Rounding: ' + Format('%8s', [FormatCurrency(Rounding)]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if ABS(Change) > 0.01 then
    begin
     PrintStr := 'Change: ' + Format('%8s', [FormatCurrency(Change)]);
     PrintStr := Format('%40s', [PrintStr]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 PrintStr := '*** ' + OperationMessage + ' ***';
 PrintStr := Format('%' + IntToStr((40 - Length(PrintStr)) div 2) + 's%s', ['', PrintStr]);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);
 DataForm.CloseSecurityCameraPort;
end;

procedure TPointOfsalesForm.FormShow(Sender: TObject);
begin
 //MenuCount := (POSMenuLine - 1) * 4 + 2;
 //CategoryCount := (POSCategoryLine - 1) * 4 + 2;
 MenuCount := 38;
 CategoryCount := 8;
 CurrentPriceIncludesGST := PriceIncludesGST;
 if Not ShowTaxOnsalesSection and CurrentPriceIncludesGST then
    begin
     GSTLabel.Caption := 'Total price includes GST';
     GSTEdit.Visible := False;
    end;
 MenuGroupCode := Format('%2.2d', [FVar.DefaultPOSMenuGroupCode]);
 OtherChargeLabel.Caption := Uppercase(OtherChargeName);
 CurrentOtherChargeRate := GetOtherChargeRate;
 InitMenuPanel;
 InitCategoryPanel;
 InitControlButtons;
 InitFixedButtons;
 if Not AutoReturn then
    begin
     DataForm.OpenPoleDisplayPort;
     DataForm.SendToPoleDisp('NEXT CUSTOMER PLEASE', '');
     //DataForm.SendToPoleDisp('    Grand Asian Cafe', '');
    end;
 Langurage := True;
 OpenCategory;
 AssignCategoryKeyBoard;
 ProcessCategoryButtonTouch(1);
 AssignMenuKeyBoard;
 InitForm;
 CalcAmount;
 Changed := False;
 OperatorLabel.Caption := sUserName;
 //SetTotalPanelLabelPosition;
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
 Timer.Enabled := True;
 DateLabel.Caption := FormatDateTime('hh:mm', Time);
 if Password then ChangeUserIDButtonClick(Sender);
 StringGrid.SetFocus;
end;

procedure TPointOfsalesForm.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 AutoLogoutTimeCounter := 0;
end;

procedure TPointOfsalesForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
 AutoLogoutTimeCounter := 0;
end;

procedure TPointOfsalesForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
end;

procedure TPointOfsalesForm.PointOfsalesPro(AutoReturn: boolean);
begin
 Application.CreateForm(TPointOfSalesForm, PointOfSalesForm);
 PointOfSalesForm.AutoReturn := AutoReturn;

 PointOfSalesForm.ShowModal;
 PointOfSalesForm.Free;
end;


procedure TPointOfsalesForm.XiButton1Click(Sender: TObject);
begin


if Number <> '0' then
  Number := Number + '1'
else
  Number := '1';

PaidEdit.Caption := Number;
CalcBalance;

end;

procedure TPointOfsalesForm.XiButton2Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '2'
else
  Number := '2';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TPointOfsalesForm.XiButton3Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '3'
else
  Number := '3';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TPointOfsalesForm.XiButton4Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '4'
else
  Number := '4';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TPointOfsalesForm.XiButton5Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '5'
else
  Number := '5';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TPointOfsalesForm.XiButton6Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '6'
else
  Number := '6';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TPointOfsalesForm.XiButton7Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '7'
else
  Number := '7';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TPointOfsalesForm.XiButton8Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '8'
else
  Number := '8';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TPointOfsalesForm.XiButton9Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '9'
else
  Number := '9';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TPointOfsalesForm.XiButton12Click(Sender: TObject);
begin
if Number <> '0' then
  Number := Number + '0'
else
  Number := '0';
PaidEdit.Caption := Number;
CalcBalance;
end;

procedure TPointOfsalesForm.XiButton11Click(Sender: TObject);
var
  dot : boolean;
begin
 dot := false;
 if Not dot and (POS('.', Number) = 0) then
    Number := Number + '.';
 if Not dot and (POS('.', Number) = 0) then
    Number := Number + '.';
end;

procedure TPointOfsalesForm.XiButton10Click(Sender: TObject);
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

procedure TPointOfsalesForm.BitBtn6Click(Sender: TObject);
begin

    if (StrToFloat(ChangeEdit.Caption)>=0) then
    begin
    PaymentPanel.Enabled := false;
    MenuPanel.Enabled := False;
    EFTPOS := false;
    poleSubtotal :=0;
    if (PaidEdit.Caption = '0.00') or (PaidEdit.Caption = '0') then
    begin
      PaidEdit.Caption := FloatToStr(BalanceTotal);
      PaidAmount := StrToFloat(PaidEdit.Caption);
      Change :=0;
      Change1 := 0;
    end
    else 
      PaidAmount :=  StrToFloat(PaidEdit.Caption);

    PaidEdit.Caption := Format('%4.2f', [PaidAmount]);
    //PaidAmount :=  BalanceTotal;
    Label2.Caption := 'CASH';
    PaymentButtonClick(Sender);
    PaymentPanel.Enabled := True;
    MenuPanel.Enabled := True;
    end

    else
      MessageBoxForm.MessagePro('Payment is not balance!', sErrorMsg);
    ProcessCategoryButtonTouch(1);
end;

procedure TPointOfsalesForm.BitBtn1Click(Sender: TObject);
begin


  SetPaymentStatus(False);
  ProcessQuickPayment('5',Sender);

  SetPaymentStatus(True);

  ProcessCategoryButtonTouch(1);
end;


function TPointOfsalesForm.CalcBalance : boolean;
begin

   PaidAmount := StrToFloat (PaidEdit.Caption);
   if(PaidAmount <> 0) then
     begin
      Change := PaidAmount- BalanceTotal ;
      Change1 := Change;
      if (Change < 0) then
        Result := false
      else
        Result := true;
      PaidEdit.Caption := Format('%4.2f', [PaidAmount]);
      ChangeEdit.Caption := Format('%4.2f', [Change]);
      end;
end;

procedure TPointOfsalesForm.BitBtn2Click(Sender: TObject);
begin

  SetPaymentStatus(False);
  ProcessQuickPayment('10',Sender);

  SetPaymentStatus(True);


  ProcessCategoryButtonTouch(1);
end;


procedure TPointOfsalesForm.BitBtn3Click(Sender: TObject);
begin
  SetPaymentStatus(False);
  ProcessQuickPayment('20',Sender);

  SetPaymentStatus(True);


  ProcessCategoryButtonTouch(1);
end;


procedure TPointOfsalesForm.BitBtn4Click(Sender: TObject);
begin
  SetPaymentStatus(False);
  ProcessQuickPayment('50',Sender);

  SetPaymentStatus(True);


  ProcessCategoryButtonTouch(1);
end;


procedure TPointOfsalesForm.BitBtn5Click(Sender: TObject);
begin

  SetPaymentStatus(False);
  ProcessQuickPayment('100',Sender);

  SetPaymentStatus(True);


  ProcessCategoryButtonTouch(1);


end;

procedure TPointOfsalesForm.XiButton13Click(Sender: TObject);
begin
PaymentPanel.Enabled := False;
MenuPanel.Enabled := False;
  Number := '0';
  PaidEdit.Caption := Number;
  EFTPOS := true;
  //poleSubtotal :=0;
  PaidEdit.Caption := FloatToStr(BalanceTotal);
  PaidAmount := BalanceTotal;
  Label2.Caption := 'EFTPOS';
  PaymentButtonClick(Sender);
  PaymentPanel.Enabled := True;
  MenuPanel.Enabled := True;
  ProcessCategoryButtonTouch(1);
end;

procedure TPointOfsalesForm.TimerDisplayTimer(Sender: TObject);
begin
  if FVar.SecondDisplay = 1 then
    SecondDisplayForm.SetWaitingStatus;
end;

procedure TPointOfsalesForm.SetPaymentStatus(Status: boolean);
begin

  PaymentPanel.Enabled := Status;
  MenuPanel.Enabled := Status;
  ButtonPanel.Enabled := Status;

end;

procedure TPointOfsalesForm.ProcessQuickPayment(payment: string;Sender:Tobject);
begin

  EFTPOS := False;
  Number := payment;
  PaidEdit.Caption := Number;
  Label2.Caption := 'CASH';

  if(CalcBalance) then
    PaymentButtonClick(Sender)
  else
    MessageBoxForm.MessagePro('Payment is not balance!', sErrorMsg);

end;


procedure TPointOfsalesForm.MorePaymentButtonClick(Sender: TObject);
var
 sOrderNo, PayBy1, PayBy2, SQLStr: string;
 TotalSales, Discount, Amount, Receivable, Tips, Payment1, Payment2, Rounding, Surcharge,
 Change: double;
 Flag, LinkToEFTPOS: boolean;
 PayPoints, AwardPoints, DepositID1, DepositID2: integer;
begin
 StringGrid.SetFocus;
 if (FindLastRow = 1) or Not DataForm.CheckItemCode(StringGrid, 7) then Exit;
 if CompulsoryEnterCustomerName and (CustomerNameEdit.Caption = '') then
    begin
     //MessageBoxForm.MessagePro('Please enter customer name.', sErrorMsg);
     CustomerNameButtonClick(Sender);
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
 Receivable := TotalSales;
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
 //if (StringGrid.Cells[1, I] = '') then
    //exit;

 if Not POSReceiptForm.ReceiptPro(TotalSales, Receivable, Tips, Payment1, Payment2, Rounding,
        Surcharge, Change, PayBy1, PayBy2, LinkToEFTPOS, sVIPNo, DepositID1, DepositID2) then
    begin
     CalcAmount;
     Exit;
    end;
 Application.ProcessMessages;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 DataForm.GenerateOrderNo(sOrderNo);
 try
  Flag := SaveData(sOrderNo);
  if Flag and LoyaltyAwardAvailible and (sVIPNo >= 1) and (RewardPointsDiscount >= 0.01) then
     begin
      PayPoints := Round(RewardPointsDiscount * PaymentPoints);
      Flag := DataForm.SavePointsPayment(sOrderNo, sVIPNo, PayPoints);
     end;
  if Flag and LoyaltyAwardAvailible and (sVIPNo >= 1) and (TotalSales > 0) then
     begin
      AwardPoints := Round(TotalSales * SalesPoints);
      //AwardPoints := Round(TotalRewardSales * SalesPoints);
      Flag := DataForm.SaveAwardPoints(sOrderNo, sVIPNo, AwardPoints);
     end;
  if Flag and (ABS(Payment1) > 0.005) then
     Flag := DataForm.SaveAccountRecord(sOrderNo, Payment1, PayBy1, 1, DepositID1);
  if Flag and (ABS(Payment2) > 0.005) then
     Flag := DataForm.SaveAccountRecord(sOrderNo, Payment2, PayBy2, 2, DepositID2);
  if Flag and (Change >= -0.001) and (ABS(Rounding) > 0.005) then
     Flag := DataForm.SaveAccountRecord(sOrderNo, -Rounding, 'ROUNDING', 3, 0);
  if Flag and (Change >= 0.009) then
     Flag := DataForm.SaveAccountRecord(sOrderNo, -Change, 'CASH', 4, 0)
    else
     begin
      SQLStr := 'Update OrderH Set Credit = 1 Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
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
      if AutoPrintPOSJobList then
         begin
          PrintJobListControlForm.PrintJobListControlPro(sOrderNo, '', False, sConfirmedOrder);
          if AutoPrintCheckList then
             PrintCheckListForm.PrintCheckList(sOrderNo, '', False, sConfirmedOrder);
         end;
      if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(sOrderNo, '', False);
      //if ShowPrintInvoiceWindow then
         DispPOSReceiptForm.DispReceiptPro(TotalSales, Receivable, Tips, Payment1,
                  Payment2, Rounding, Surcharge, Change, PayBy1, PayBy2, sOrderNo);
      if AutoReturn then Close
        else
         begin
          InitForm;
          CalcAmount;
          Changed := False;
          if Password then ChangeUserIDButtonClick(Sender);
         end;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TPointOfsalesForm.XiButton15Click(Sender: TObject);
begin
   MergeTableForm.MergeTablePro;
end;

function TPointOfSalesForm.SaveCancelHead(CancelOrderNo:integer): boolean;
var
 SQLStr, MachineName, DiscountRateTemp: string;
 customerCode : string;
begin
 if MachineID <> '' then
    MachineName := Chr(39) + CheckQuotes(MachineID) + Chr(39)
   else
    MachineName := 'Null';
 DiscountRateTemp := FloatToStr(DiscountRate);
 if CustomerCode = '' then CustomerCode := 'QuickService';
 SQLStr := 'Insert Into CancelHead(HoldNo, HoldDate, TotalAmount, DiscountPercent, ' +
           'DiscountDollar, MachineID, OpName, Notes, CustomerCode, DiscountKind) ' +
           'Values(' + IntToStr(cancelorderno) + ',' +
           ConvertDateTime(Date + Time) + ',' +
           TotalEdit.Caption + ',' + DiscountRateTemp + ',0,' +
           MachineName + ',' + Chr(39) + CheckQuotes(sUserName) + Chr(39) + ', Null, ' +
           Chr(39) + CheckQuotes(CustomerCode) + Chr(39) + ',' +
           IntToStr(0) + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TPointOfSalesForm.SaveCancelItem(CancelOrderNo:integer) : boolean;
var
 I, IDNo: Integer;
 SQLStr, ProductCode, Qty,Qty1, Price, DisRate, VoidStatus,
 SpecialKindTemp, FamilyCodeTemp, OriginalPriceTemp: string;
begin


 I := 1; IDNo := 1; Result := True;
 while (I <= 300) and Result do
  begin
   if StringGrid.Cells[1, I] <> '' then
      begin
       ProductCode := Chr(39) + CheckQuotes(StringGrid.Cells[7, I]) + Chr(39);
       if StringGrid.Cells[2, I] <> '' then
        begin
          Qty1 := Copy(StringGrid.Cells[2,I],1,5);
          Qty := Format('%5.3f', [StrToFloat(Qty1)]);
        end
         else
          Qty := Format('%5.3f', [0.0]);
       if StringGrid.Cells[3, I] <> '' then
          Price := Format('%3.2f', [StrToFloat(StringGrid.Cells[3, I])])
         else
          Price := '0.0';
       if StringGrid.Cells[5, I] <> '' then
          DisRate := StringGrid.Cells[5, I]
         else
          DisRate := '0';

       SQLStr := 'Insert Into CancelItem(HoldNo, ProductCode, Qty, Price, ' +
                 'PriceKind, PriceLocked, CurrentDiscountRate, VoidFlag, ' +
                 'SpecialKind, FamilyCode, OriginalPrice, ID,Staff) ' +
                 'Values(' + IntToStr(cancelorderno) + ',' + ProductCode + ',' +
                 Qty + ',' + Price + ',' + IntToStr(0) + ', 0, ' +
                 DisRate + ',' + '0' + ',' + '0' + ',' +
                 'null' + ',' + 'null' + ',' +
                 IntToStr(IDNo) + ','+ Chr(39) + CheckQuotes(sUserName) + Chr(39) + ')';
       Result := DataForm.ExecQueryPro(SQLStr);
       IDNo := IDNo + 1;
      end;
   I := I + 1;
  end;
end;

function  TPointOfSalesForm.MakeCancelOrderNo:integer;
var
 SQLStr: string;
begin
 SQLStr := 'Select Max(HoldNo) From CancelHead';
 OpenQuery(SQLStr);
 with Query do
  begin
   if Active and (RecordCount <> 0) and (Fields[0].AsInteger <> 0) then
      Result := Fields[0].AsInteger + 1
     else
      Result := 1;
   Close;
  end;
end;



end.

