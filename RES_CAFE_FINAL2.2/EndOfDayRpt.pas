unit EndOfDayRpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, Buttons, DataUnit, CommDrv, Grids, DBGrids, Mask,
  UtilUnit, TeEngine, Series, TeeProcs, Chart, DBChart, MainMenu,
  ADODB, XiButton, bsSkinCtrls;

type
  TEndOfDayForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    DateEdit1: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Time1: TMaskEdit;
    Label8: TLabel;
    Time2: TMaskEdit;
    DateEdit2: TMaskEdit;
    TotalTipsEdit: TStaticText;
    RoundingEdit: TStaticText;
    CashInDrawerEdit: TStaticText;
    TotalPersonsEdit: TStaticText;
    CategoryDBGrid: TDBGrid;
    CategoryDataSource: TDataSource;
    Label9: TLabel;
    DiscountEdit: TStaticText;
    Label10: TLabel;
    totalGSTEdit: TStaticText;
    ServiceChargeEdit: TStaticText;
    SurchargeLabel: TLabel;
    OperatorCheckBox: TCheckBox;
    OperatorEdit: TEdit;
    ConsumerEdit: TStaticText;
    Label13: TLabel;
    Label14: TLabel;
    VoidQtyEdit: TStaticText;
    Label15: TLabel;
    VoidAmountEdit: TStaticText;
    Label16: TLabel;
    TotalBillEdit: TStaticText;
    Label18: TLabel;
    SurchargeEdit: TStaticText;
    Label20: TLabel;
    CashPayOutEdit: TStaticText;
    TotalSalesEdit: TStaticText;
    TotalReceiveEdit: TStaticText;
    MachineIDCheckBox: TCheckBox;
    MachineIDEdit: TEdit;
    CategoryQuery: TADOQuery;
    CategoryQueryCategory: TStringField;
    CategoryQueryTotalQty: TFloatField;
    CategoryQueryAmount: TFloatField;
    Query: TADOQuery;
    GeneralQuery: TADOQuery;
    ReceiveQuery: TADOQuery;
    ReceiveQueryPayBy: TStringField;
    ReceiveQueryAmount: TFloatField;
    Label17: TLabel;
    ReceivedAcctPaymentEdit: TStaticText;
    Label25: TLabel;
    OutstandingOrderEdit: TStaticText;
    Label26: TLabel;
    AccountPaymentEdit: TStaticText;
    Label27: TLabel;
    TotalReceivableEdit: TStaticText;
    Label28: TLabel;
    NonSalesOpenDrawerEdit: TStaticText;
    Label29: TLabel;
    AverageSalesEdit: TStaticText;
    Label30: TLabel;
    Label19: TLabel;
    CashLessTipsEdit: TStaticText;
    OtherChargeLabel: TLabel;
    OtherChargeEdit: TStaticText;
    SaveDialog: TSaveDialog;
    Label32: TLabel;
    TotalEFTPOSPaymentEdit: TStaticText;
    Label33: TLabel;
    RewardPointsEdit: TStaticText;
    ItemGroupDBGrid: TDBGrid;
    ItemGroupQuery: TADOQuery;
    ItemGroupDataSource: TDataSource;
    ItemGroupQueryAmount: TFloatField;
    ItemGroupQueryItemGroup: TStringField;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    JournalButton: TXiButton;
    ExitButton: TXiButton;
    TableOrderButton: TXiButton;
    QuickSaleButton: TXiButton;
    ListAllButton: TXiButton;
    BackPanel: TbsSkinPanel;
    AmountPanel1: TbsSkinPanel;
    DetailPanel1: TbsSkinPanel;
    SummaryPanel1: TbsSkinPanel;
    ControlPanel1: TbsSkinPanel;
    Label11: TLabel;
    Label12: TLabel;
    CashInEdit: TStaticText;
    CashOutEdit: TStaticText;
    PhoneOrderButton: TXiButton;
    Label31: TLabel;
    DepositEdit: TStaticText;
    Label34: TLabel;
    WastageAmountEdit: TStaticText;
    Label7: TLabel;
    NetSalesEdit: TStaticText;
    ItemGroupQueryQty: TFloatField;
    ReceiveQueryCode: TStringField;
    DiscountQuery: TADOQuery;
    DsicountDB: TDBGrid;
    DiscountDataSource: TDataSource;
    DiscountQueryAmount: TFloatField;
    DiscountQueryDescription: TStringField;
    ExecCommand: TADOCommand;
    procedure InitForm;
    procedure OpenQuery(SQLStr: string);
    procedure OpenReceiveQuery;
    procedure OpenCategoryQuery;
    procedure OpenItemGroupQuery;
    procedure OpenDiscountQuery;
    procedure CalcAmount;
    procedure FormShow(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PrintOutToPrinter;
    procedure PrintSimpleReport;
    procedure PrintOutToFile;
    procedure PrintButtonClick(Sender: TObject);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchButtonClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DailyReportPro(ReportKind: integer);
    procedure Time1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Time2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEditClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OperatorCheckBoxClick(Sender: TObject);
    procedure OperatorEditClick(Sender: TObject);
    procedure SetListButtonColor;
    procedure ListAllButtonClick(Sender: TObject);
    procedure QuickSaleButtonClick(Sender: TObject);
    procedure TableOrderButtonClick(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure MachineIDCheckBoxClick(Sender: TObject);
    procedure MachineIDEditClick(Sender: TObject);
    procedure OpenGeneralQuery;
    procedure JournalButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PhoneOrderButtonClick(Sender: TObject);
    procedure DropIndex;
    procedure RebuildIndex;

  private { Private declarations }
    MachineIDString: string;
    DatabaseConnection: TADOConnection;
  public  { Public declarations }
    DateTime1, DateTime2: TDateTime;
    TotalSales, NetSales, TotalDiscount, TotalRounding, TotalServiceCharge, TotalOtherCharge,
    TotalGST, TotalTips, TotalSurcharge, ReceivedAccountPayment, AccountPayment,
    OutstandingOrder, TotalReceive, CashInDrawer, CashLessTips, PPH, VoidAmount,
    VoidQty, CashPayOut, TotalReceivable, AverageSales, TotalEFTPOSPayment,
    RewardPoints, CashIn, CashOut, Deposit, WastageAmount: double;
    Persons, TotalBill, ListFlag, NonSalesOpenDrawerCounter: integer;
    DetailedDiscountAmount : double;
    DetailedDiscountName : String;
  end;

var
  EndOfDayForm: TEndOfDayForm;

implementation

uses ReceiptDetail, TimePanel, DatePanel, StaffList, MachineIDSelect, MessageBox,
     SelectDrawerNumber, PrintOption, MachineIDCollect,
     PrintDailyReportA4Paper;

{$R *.DFM}

procedure TEndOfDayForm.InitForm;
begin
 TotalSalesEdit.Caption := '';
 NetSalesEdit.Caption := '';
 DiscountEdit.Caption := '';
 RewardPointsEdit.Caption := '';
 ServiceChargeEdit.Caption := '';
 RoundingEdit.Caption := '';
 TotalTipsEdit.Caption := '';
 SurchargeEdit.Caption := '';
 OtherChargeEdit.Caption := '';
 ReceivedAcctPaymentEdit.Caption := '';
 OutstandingOrderEdit.Caption := '';
 AccountPaymentEdit.Caption := '';
 TotalReceivableEdit.Caption := '';
 TotalReceiveEdit.Caption := '';
 CashPayOutEdit.Caption := '';
 CashInEdit.Caption := '';
 CashOutEdit.Caption := '';
 CashInDrawerEdit.Caption := '';
 CashLessTipsEdit.Caption := '';
 TotalGSTEdit.Caption := '';
 TotalPersonsEdit.Caption := '';
 ConsumerEdit.Caption := '';
 AverageSalesEdit.Caption := '';
 DepositEdit.Caption := '';
 VoidQtyEdit.Caption := '';
 VoidAmountEdit.Caption := '';
 WastageAmountEdit.Caption := '';
 TotalBillEdit.Caption := '';
 NonSalesOpenDrawerEdit.Caption := '';
 TotalEFTPOSPaymentEdit.Caption := '';
 TotalSales := 0;
 TotalDiscount := 0;
 RewardPoints := 0;
 TotalServiceCharge := 0;
 TotalOtherCharge := 0;
 TotalRounding := 0;
 TotalTips := 0;
 TotalSurcharge := 0;
 TotalGST := 0;
 ReceivedAccountPayment := 0;
 AccountPayment := 0;
 OutstandingOrder := 0;
 PPH := 0;
 VoidAmount := 0;
 VoidQty := 0;
 CashPayOut := 0;
 CashIn := 0;
 CashOut := 0;
 Deposit := 0;
 Persons := 0;
 TotalBill := 0;
 ListFlag := 0;
 NonSalesOpenDrawerCounter := 0;
 AverageSales := 0;
 TotalReceivable := 0;
 TotalEFTPOSPayment := 0;
 WastageAmount := 0;
 CategoryQuery.Close;
 ReceiveQuery.Close;
 ItemGroupQuery.Close;
 DiscountQuery.Close;
end;

procedure TEndOfDayForm.DateEdit1Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit1.Text) then
    DateEdit1.SetFocus;
end;

procedure TEndOfDayForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then Time1.SetFocus;
end;

procedure TEndOfDayForm.Time1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TEndOfDayForm.DateEdit2Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit2.Text) then
    DateEdit2.SetFocus;
end;

procedure TEndOfDayForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then Time2.SetFocus;
end;

procedure TEndOfDayForm.Time2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TEndOfDayForm.DateEditClick(Sender: TObject);
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

procedure TEndOfDayForm.TimeEditClick(Sender: TObject);
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

procedure TEndOfDayForm.OpenQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;

procedure TEndOfDayForm.OpenReceiveQuery;
var
 SQLStr: string;
 I: integer;
begin
 SQLStr := 'Select Payment.Code, TempTable.PayBy, Sum(TempTable.Amount) As Amount ' +
           'From ' +
           '(Select PayBy, RecvAcct.PaidAmount As Amount ' +
           'From RecvAcct, OrderH ' +
           'Where OrderH.OrderNo=RecvAcct.OrderNo ' +
           ' and PayBy<>' + Chr(39) + 'ROUNDING' + Chr(39) +
           ' and AccountDate>=' + ConvertDateTime(DateTime1) +
           ' and AccountDate<=' + ConvertDateTime(DateTime2) +
           ' and ((DepositID = 0) or (DepositID Is Null)) ';
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (RecvAcct.MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or RecvAcct.MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and RecvAcct.OPName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 SQLStr := SQLStr + ' Union All ' +
                    'Select PaymentMethod As PayBy, Amount From DepositTable ' +
                    'Where DepositDate>=' + ConvertDateTime(DateTime1) +
                    ' and DepositDate<=' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OPName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 SQLStr := SQLStr + ') As TempTable, Payment Where TempTable.PayBy=Payment.Payment ' +
                    'Group By TempTable.PayBy, Payment.Code Order By Payment.Code';
 Screen.Cursor := crHourGlass;
 with ReceiveQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;

procedure TEndOfDayForm.OpenDiscountQuery;
var
  SQLStr: string;
  I: integer;
begin
  SQLStr := 'Select Sum(OrderI.Price * Qty * Discount/100) as Amount,' +
            'DiscountRateTable.Description as Description  ' +
            'From OrderH, OrderI, DiscountRateTable ' +
            'Where (OrderH.OrderNo=OrderI.OrderNo) and Orderh.PresetDiscountCode = DiscountRateTable.code and ' +
            '(OrderDate>=' + ConvertDateTime(DateTime1) + ') and ' +
            '(OrderDate<=' + ConvertDateTime(DateTime2) + ')' +
            ' and DiscountRateTable.DiscountRate = OrderI.Discount ';

 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);

 end;
 SQLStr := SQLStr + 'group by DiscountRateTable.Description';
 Screen.Cursor := crHourGlass;
 with DiscountQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;


procedure TEndOfDayForm.OpenCategoryQuery;
var
 SQLStr: string;
 I: integer;
begin
 SQLStr := 'Select Category.Code, MenuItem.Category, ' +
           'Sum(OrderI.Qty) As TotalQty, ' +
           'Sum(OrderI.Price * Qty) As Amount ' +
           'From Category, MenuItem, OrderI, OrderH ' +
           'Where Category.Category=MenuItem.Category and ' +
           'MenuItem.ItemCode=OrderI.ItemCode and ' +
           'OrderI.Qty <> 0 and OrderI.Price <> 0 and ' +
           'OrderH.OrderNo = OrderI.OrderNo ' +
           'and OrderDate >= ' + ConvertDateTime(DateTime1) +
           ' and OrderDate <= ' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 SQLStr := SQLStr + ' Group By Category.Code, MenuItem.Category ' +
                    ' Order By Category.Code';
 Screen.Cursor := crHourGlass;
 with CategoryQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;

procedure TEndOfDayForm.OpenItemGroupQuery;
var
 SQLStr: string;
 I: integer;
begin
 SQLStr := 'Select ItemGroup, Sum(OrderI.Qty) As Qty, Sum(OrderI.Qty * OrderI.Price) As Amount ' +
           'From MenuItem, OrderI, OrderH ' +
           'Where MenuItem.ItemCode=OrderI.ItemCode and ' +
           'OrderI.Qty <> 0 and OrderI.Price <> 0 and ' +
           'OrderH.OrderNo = OrderI.OrderNo ' +
           'and OrderDate >= ' + ConvertDateTime(DateTime1) +
           ' and OrderDate <= ' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 SQLStr := SQLStr + ' Group By ItemGroup Order By ItemGroup';
 Screen.Cursor := crHourGlass;
 with ItemGroupQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;

procedure TEndOfDayForm.CalcAmount;
var
 SQLStr: string;
 I: integer;
begin
 // Calc total current received payment amount
 TotalReceive := 0; CashInDrawer := 0;
 with ReceiveQuery do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     TotalReceive := TotalReceive + FieldByName('Amount').AsFloat;
     if FieldByName('PayBy').AsString = 'CASH' then
        CashInDrawer := FieldByname('Amount').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;

 // Calc Total EFTPOS Payment
 SQLStr := 'Select Sum(RecvAcct.PaidAmount) As Amount ' +
           'From RecvAcct, Payment ';
 if ListFlag > 0 then SQLStr := SQLStr + ', OrderH ';
 SQLStr := SQLStr +
           'Where RecvAcct.PayBy=Payment.Payment and EFTPOSPayment=1 ' +
           ' and PayBy<>' + Chr(39) + 'Rounding' + Chr(39) +
           ' and ((DepositID = 0) or (DepositID Is Null)) ' +
           ' and AccountDate>=' + ConvertDateTime(DateTime1) +
           ' and AccountDate<=' + ConvertDateTime(DateTime2);
 if ListFlag > 0 then
    SQLStr := SQLStr + ' and RecvAcct.OrderNo=OrderH.OrderNo ';
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (RecvAcct.MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or RecvAcct.MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and RecvAcct.OPName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   TotalEFTPOSPayment := Fields[0].AsFloat;
   Close;
  end;

 // Calc total rounding amount
 SQLStr := 'Select Sum(RecvAcct.PaidAmount) From RecvAcct, OrderH ' +
           'Where RecvAcct.OrderNo=OrderH.OrderNo and ' +
           'PayBy=' + Chr(39) + 'ROUNDING' + Chr(39) +
           ' and AccountDate>=' + ConvertDateTime(DateTime1) +
           ' and AccountDate<=' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (RecvAcct.MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or RecvAcct.MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and RecvAcct.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   TotalRounding := Fields[0].AsFloat;
   Close;
  end;

  // Calc total Cash Pay Out
 SQLStr := 'Select Sum(Amount) From PayOutTable ' +
           'Where PaymentDate>=' + ConvertDateTime(DateTime1) +
           ' and PaymentDate<=' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OPName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   CashPayOut := Fields[0].AsFloat;
   Close;
  end;

 // Calc Cash Float
 SQLStr := 'Select Sum(CashIn) As CashIn, Sum(CashOut) As CashOut From CashFloatTable ' +
           'Where OpDate>=' + ConvertDateTime(DateTime1) +
           ' and OpDate<=' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OPName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   CashIn := FieldByName('CashIn').AsFloat;
   CashOut := FieldByName('CashOut').AsFloat;
   Close;
  end;

 // Calc Deposit
 SQLStr := 'Select Sum(Amount) As TotalDeposit From DepositTable ' +
           'Where DepositDate>=' + ConvertDateTime(DateTime1) +
           ' and DepositDate<=' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OPName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   Deposit := FieldByName('TotalDeposit').AsFloat;
   Close;
  end;

 // Calc Current Sales, GST, ServiceCharge, OtherCharge, Tips and Persons
 // Price Includes GST
 SQLStr := 'Select Sum(Amount) As Amount, Sum(GST) As GST, Sum(Tips) As Tips, ' +
           'Sum(Persons) As Persons, Sum(ServiceCharge) As ServiceCharge, ' +
           'Sum(OtherCharge) As OtherCharge, Sum(Surcharge) As Surcharge ' +
           'From OrderH ' +
           'Where (PriceIncludesGST <> 0) and ' +
           '(OrderDate>=' + ConvertDateTime(DateTime1) + ') and ' +
           '(OrderDate<=' + ConvertDateTime(DateTime2) + ')';
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   NetSales := FieldByName('Amount').AsFloat +
               FieldByName('ServiceCharge').AsFloat +
               FieldByName('OtherCharge').AsFloat;
   TotalGST := FieldByName('GST').AsFloat;
   TotalTips := FieldByName('Tips').AsFloat;
   Persons := FieldByName('Persons').AsInteger;
   TotalServiceCharge := FieldByName('ServiceCharge').AsFloat;
   TotalOtherCharge := FieldByName('OtherCharge').AsFloat;
   TotalSurcharge := FieldByName('Surcharge').AsFloat;
   Close;
  end;

 // Calc Current Sales, GST, ServiceCharge, OtherCharge, Tips and Persons
 // Price does not Include GST
 SQLStr := 'Select Sum(Amount) As Amount, Sum(GST) As GST, Sum(Tips) As Tips, ' +
           'Sum(Persons) As Persons, Sum(ServiceCharge) As ServiceCharge, ' +
           'Sum(OtherCharge) As OtherCharge, Sum(Surcharge) As Surcharge ' +
           'From OrderH ' +
           'Where (PriceIncludesGST = 0) and ' +
           '(OrderDate>=' + ConvertDateTime(DateTime1) + ') and ' +
           '(OrderDate<=' + ConvertDateTime(DateTime2) + ')';
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   NetSales := NetSales + FieldByName('Amount').AsFloat +
               FieldByName('ServiceCharge').AsFloat +
               FieldByName('OtherCharge').AsFloat +
               FieldByName('GST').AsFloat;
   TotalGST := TotalGST + FieldByName('GST').AsFloat;
   TotalTips := TotalTips + FieldByName('Tips').AsFloat;
   Persons := Persons + FieldByName('Persons').AsInteger;
   TotalServiceCharge := TotalServiceCharge + FieldByName('ServiceCharge').AsFloat;
   TotalOtherCharge := TotalOtherCharge + FieldByName('OtherCharge').AsFloat;
   TotalSurcharge := TotalSurcharge + FieldByName('Surcharge').AsFloat;
   Close;
  end;

 // Calc Discount Amount
 SQLStr := 'Select Sum(OrderI.Price * Qty) From OrderH, OrderI ' +
           'Where (OrderH.OrderNo=OrderI.OrderNo) and ' +
           '(OrderDate>=' + ConvertDateTime(DateTime1) + ') and ' +
           '(OrderDate<=' + ConvertDateTime(DateTime2) + ')';
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   TotalDiscount := Fields[0].AsFloat;
   Close;
  end;

 // Calc discount
 SQLStr := 'Select Sum(Amount) From OrderH ' +
           'Where (OrderDate>=' + ConvertDateTime(DateTime1) + ') and ' +
           '(OrderDate<=' + ConvertDateTime(DateTime2) + ')';
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   TotalDiscount := TotalDiscount - Fields[0].AsFloat;
   Close;
  end;

 // Calc Reward points
 SQLStr := 'Select Sum(RewardPoints) From OrderH ' +
           'Where OrderDate>=' + ConvertDateTime(DateTime1) + ' and ' +
           'OrderDate <=' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (OrderH.MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or OrderH.MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   RewardPoints := Fields[0].AsFloat;
   Close;
  end;

 TotalDiscount := TotalDiscount - RewardPoints;

 TotalSales := NetSales + TotalDiscount + RewardPoints;




 // Calc Received Account Payment
 SQLStr := 'Select Sum(RecvAcct.PaidAmount) As PaidAmount From RecvAcct, OrderH ' +
           'Where (OrderH.OrderNo=RecvAcct.OrderNo) and ' +
           '((DepositID = 0) or (DepositID Is Null)) and ' +
           '(OrderDate<' + ConvertDateTime(DateTime1) + ') and ' +
           '(AccountDate>=' + ConvertDateTime(DateTime1) + ') and ' +
           '(AccountDate<=' + ConvertDateTime(DateTime2) + ') ';
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (RecvAcct.MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or RecvAcct.MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and RecvAcct.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   ReceivedAccountPayment := Fields[0].AsFloat;
   Close;
  end;

 // Calc Account Payment Sales (Price Includes GST)
 SQLStr := 'Select Sum(Amount + ServiceCharge + OtherCharge + Tips + Surcharge) ' +
           'From OrderH ' +
           'Where (Credit <> 0) and (PriceIncludesGST <> 0) and ' +
           '(OrderDate>=' + ConvertDateTime(DateTime1) + ') and ' +
           '(OrderDate<=' + ConvertDateTime(DateTime2) + ')';
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   AccountPayment := Fields[0].AsFloat;
   Close;
  end;

 // Calc Account Payment Sales (Price does not Include GST)
 SQLStr := 'Select Sum(Amount + ServiceCharge + OtherCharge + GST + Tips + Surcharge) ' +
           'From OrderH ' +
           'Where (Credit <> 0) and (PriceIncludesGSt = 0) ' +
           'and (OrderDate>=' + ConvertDateTime(DateTime1) + ') ' +
           'and (OrderDate<=' + ConvertDateTime(DateTime2) + ')';
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   AccountPayment := AccountPayment + Fields[0].AsFloat;
   Close;
  end;

 // Calc Account Payment Sales
 SQLStr := 'Select Sum(RecvAcct.PaidAmount) From RecvAcct, OrderH ' +
           'Where RecvAcct.OrderNo=OrderH.OrderNo and ' +
           '(Credit <> 0) and ((DepositID = 0) or (DepositID Is Null)) and ' +
           '(OrderDate>=' + ConvertDateTime(DateTime1) + ') and ' +
           '(OrderDate<=' + ConvertDateTime(DateTime2) + ') and ' +
           '(AccountDate>=' + ConvertDateTime(DateTime1) + ') and ' +
           '(AccountDate<=' + ConvertDateTime(DateTime2) + ')';
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (OrderH.MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or OrderH.MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   AccountPayment := AccountPayment - Fields[0].AsFloat;
   Close;
  end;

 // Calc total Void Amount and Void Qty
 SQLStr := 'Select Sum(Price * Qty) As VoidAmount, Sum(Qty) As VoidQty ' +
           'From OrderH, OrderI ' +
           'Where OrderH.OrderNo=OrderI.OrderNo and OrderI.Qty < 0 ' +
           ' and (SpecialOrder NOT Like ' + Chr(39) + 'Merge to table' + SearchMark + Chr(39) +
           ' Or SpecialOrder IS NULL) ' +
           ' and OrderDate >= ' + ConvertDateTime(DateTime1) +
           ' and OrderDate<=' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   VoidAmount := FieldByName('VoidAmount').AsFloat;
   VoidQty := FieldByName('VoidQty').AsFloat;
   Close;
  end;

 // Calc wastage Amount
 SQLStr := 'Select Sum(Amount) From WastageHead ' +
           'Where WastageDate >= ' + ConvertDateTime(DateTime1) +
           ' and WastageDate<=' + ConvertDateTime(DateTime2);
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   WastageAmount := Fields[0].AsFloat;
   Close;
  end;

 // Calc total bills
 SQLStr := 'Select Count(*) From OrderH ' +
           'Where OrderDate >= ' + ConvertDateTime(DateTime1) +
           ' and OrderDate<=' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 OpenQuery(SQLStr);
 with Query do
  begin
   TotalBill := Fields[0].AsInteger;
   Close;
  end;

 if Persons >= 1 then
    PPH := TotalSales / Persons
   else
    PPH := 0;

 SQLStr := 'Select Sum(Times), Sum(NonSalesOpen) From DrawerCounter ' +
           'Where OpenDate >= ' + ConvertDateTime(TransferDate(DateEdit1.Text)) +
           ' and OpenDate<=' + ConvertDateTime(TransferDate(DateEdit2.Text));
 if MachineIDCheckBox.Checked then
    begin
     MachineIDString := ' (MachineID =' + Chr(39);
     for I := 1 to Length(MachineIDEdit.Text) do
      if MachineIDEdit.Text[I] = ',' then
         MachineIDString := MachineIDString + Chr(39) + ' or MachineID=' + Chr(39)
        else
         MachineIDString := MachineIDString + MachineIDEdit.Text[I];
     MachineIDString := MachineIDString + Chr(39) + ')';
     SQLStr := SQLStr + ' and ' + MachineIDString;
    end;
 OpenQuery(SQLStr);
 NonSalesOpenDrawerCounter := Query.Fields[1].AsInteger;
 Query.Close;

 CashInDrawer := CashInDrawer + CashIn - CashOut - CashPayout;
 CashLessTips := CashInDrawer - TotalTips;

 if ABS(TotalBill) > 0 then
    AverageSales := TotalSales / TotalBill
   else
    AverageSales := 0;
 TotalSalesEdit.Caption := FormatCurrency(TotalSales) + ' ';
 NetSalesEdit.Caption := FormatCurrency(NetSales) + ' ';
 RoundingEdit.Caption := FormatCurrency(0 - TotalRounding) + ' ';
 TotalTipsEdit.Caption := FormatCurrency(TotalTips) + ' ';
 SurchargeEdit.Caption := FormatCurrency(TotalSurcharge) + ' ';
 ReceivedAcctPaymentEdit.Caption := FormatCurrency(ReceivedAccountPayment) + ' ';
 AccountPaymentEdit.Caption := FormatCurrency(AccountPayment) + ' ';
 DepositEdit.Caption := FormatCurrency(Deposit) + ' ';

 TotalReceivable := NetSales - TotalRounding + TotalTips + TotalSurcharge +
                    ReceivedAccountPayment + Deposit - AccountPayment;
 TotalReceivableEdit.Caption := FormatCurrency(TotalReceivable) + ' ';
 TotalReceiveEdit.Caption := FormatCurrency(TotalReceive) + ' ';

 OutstandingOrder := TotalReceivable - TotalReceive;
 OutstandingOrderEdit.Caption := FormatCurrency(OutstandingOrder) + ' ';

 CashPayOutEdit.Caption := FormatCurrency(CashPayOut) + ' ';
 CashInEdit.Caption := FormatCurrency(CashIn) + ' ';
 CashOutEdit.Caption := FormatCurrency(CashOut) + ' ';
 CashInDrawerEdit.Caption := FormatCurrency(CashInDrawer) + ' ';
 CashLessTipsEdit.Caption := FormatCurrency(CashLessTips) + ' ';
 TotalEFTPOSPaymentEdit.Caption := FormatCurrency(TotalEFTPOSPayment) + ' ';
 TotalGSTEdit.Caption := FormatCurrency(TotalGST) + ' ';
 ServiceChargeEdit.Caption := FormatCurrency(TotalServiceCharge) + ' ';
 OtherChargeEdit.Caption := FormatCurrency(TotalOtherCharge) + ' ';
 DiscountEdit.Caption := FormatCurrency(TotalDiscount) + ' ';
 RewardPointsEdit.Caption := FormatCurrency(RewardPoints) + ' ';
 TotalPersonsEdit.Caption := Format('%1d ', [Persons]);
 ConsumerEdit.Caption := FormatCurrency(PPH) + ' ';
 AverageSalesEdit.Caption := FormatCurrency(AverageSales) + ' ';
 VoidQtyEdit.Caption := Format('%4.2f ', [ABS(VoidQty)]);
 VoidAmountEdit.Caption := FormatCurrency(ABS(VoidAmount)) + ' ';
 WastageAmountEdit.Caption := FormatCurrency(WastageAmount) + ' ';
 TotalBillEdit.Caption := Format('%1d ', [TotalBill]);
 NonSalesOpenDrawerEdit.Caption := Format('%1d ', [NonSalesOpenDrawerCounter]);
end;

procedure TEndOfDayForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TEndOfDayForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TEndOfDayForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 ReceiveQuery.Close;
 Action := caFree;
end;

procedure TEndOfDayForm.PrintOutToPrinter;
var
 PaperWidth: integer;
 PrintStr, TempStr: string;
 Amount: double;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '              DAILY REPORT';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Category                   Qty    Amount';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 Amount := 0;
 with CategoryQuery do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     TempStr := Copy(FieldByName('Category').AsString, 1, 20);
     PrintStr := Format('%-20s%10.2f%10.2f',
      [TempStr, FieldByName('TotalQty').AsFloat, FieldByName('Amount').AsFloat]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     Amount := Amount + FieldByName('Amount').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;
 PrintStr := Format('Total Sales:                %12.2f', [Amount]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 with ItemGroupQuery do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     PrintStr := Format('%-20s%10.2f%10.2f',
       [FieldByName('ItemGroup').AsString, FieldByName('Qty').AsFloat, FieldByName('Amount').AsFloat]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     Next;
    end;
   First;
   EnableControls;
  end;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 with ReceiveQuery do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     PrintStr := Format('%-28s%12.2f', [FieldByName('PayBy').AsString, FieldByName('Amount').AsFloat]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     Next;
    end;
   First;
   EnableControls;
  end;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := Format('Total Sales:                %12.2f', [TotalSales]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 with DiscountQuery do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     PrintStr := Format('%-20s%10.2f',
       [FieldByName('Description').AsString, FieldByName('Amount').AsFloat]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     Next;
    end;
   First;
   EnableControls;
  end;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);


 if ABS(TotalDiscount) >= 0.01 then
    begin
     PrintStr := Format('Discount:                   %12.2f', [TotalDiscount]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(RewardPoints) >= 0.01 then
    begin
     PrintStr := Format('Total Points Redeem:        %12.2f', [RewardPoints]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 PrintStr := Format('Net Sales:                  %12.2f', [NetSales]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 if ABS(TotalRounding) >= 0.01 then
    begin
     PrintStr := Format('Rounding Benefit:           %12.2f', [0 - TotalRounding]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(TotalTips) >= 0.01 then
    begin
     PrintStr := Format('Total Tips:                 %12.2f', [TotalTips]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(TotalSurcharge) >= 0.01 then
    begin
     PrintStr := Format('Bank Charge:                %12.2f', [TotalSurcharge]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(ReceivedAccountPayment) >= 0.01 then
    begin
     PrintStr := Format('Account Payment:            %12.2f', [ReceivedAccountPayment]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(AccountPayment) >= 0.01 then
    begin
     PrintStr := Format('Outstanding Account Sales:  %12.2f', [AccountPayment]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(Deposit) >= 0.01 then
    begin
     PrintStr := Format('Deposit:                    %12.2f', [Deposit]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 PrintStr := Format('Total Receivable:           %12.2f', [TotalReceivable]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := Format('Total Received:             %12.2f', [TotalReceive]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 if ABS(OutstandingOrder) >= 0.01 then
    begin
     PrintStr := Format('Balance:                    %12.2f', [OutstandingOrder]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(CashPayOut) >= 0.01 then
    begin
     PrintStr := Format('Cash Pay Out:               %12.2f', [CashPayOut]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(CashIn) >= 0.01 then
    begin
     PrintStr := Format('Cash Float In:              %12.2f', [CashIn]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if ABS(CashOut) >= 0.01 then
    begin
     PrintStr := Format('Cash Float Out:             %12.2f', [CashOut]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(CashInDrawer) >= 0.01 then
    begin
     PrintStr := Format('Cash In Drawer:             %12.2f', [CashInDrawer]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.SetRedFontA;
     DataForm.OutPutToPrinter(PrintStr);
     DataForm.SetBlackFontA;
    end;

 if ABS(CashLessTips) >= 0.01 then
    begin
     PrintStr := Format('Cash Less Tips:             %12.2f', [CashLessTips]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.SetRedFontA;
     DataForm.OutPutToPrinter(PrintStr);
     DataForm.SetBlackFontA;
    end;

 if ABS(TotalEFTPOSPayment) >= 0.01 then
    begin
     PrintStr := Format('Total EFTPOS Payment:       %12.2f', [TotalEFTPOSPayment]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.SetRedFontA;
     DataForm.OutPutToPrinter(PrintStr);
     DataForm.SetBlackFontA;
    end;

 if ABS(TotalGST) >= 0.01 then
    begin
     PrintStr := Format('Total G.S.T.:               %12.2f', [TotalGST]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(TotalServiceCharge) >= 0.01 then
    begin
     PrintStr := Format('%-28s%12.2f', [SurchargeName + ':', TotalServiceCharge]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(TotalOtherCharge) >= 0.01 then
    begin
     PrintStr := Format('%-28s%12.2f', [OtherChargeName + ':', TotalOtherCharge]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(Persons) >= 0.01 then
    begin
     PrintStr := Format('Total People:               %12d', [Persons]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(PPH) >= 0.01 then
    begin
     PrintStr := Format('P.P.H.:                     %12.2f', [PPH]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 PrintStr := Format('Average Sales:              %12.2f', [AverageSales]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 if ABS(VoidQty) >= 0.01 then
    begin
     PrintStr := Format('Void Qty:                   %12.2f', [ABS(VoidQty)]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(VoidAmount) >= 0.01 then
    begin
     PrintStr := Format('Void Amount:                %12.2f', [ABS(VoidAmount)]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(WastageAmount) >= 0.01 then
    begin
     PrintStr := Format('Wastage Amount:             %12.2f', [WastageAmount]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 PrintStr := Format('Total Transactions:         %12d', [TotalBill]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 if Not OperatorCheckBox.Checked then
    begin
     PrintStr := Format('No Sale Drawer Opens:       %12d', [NonSalesOpenDrawerCounter]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := 'Report Date:';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := DateEdit1.Text + ':' + Time1.Text + ' - ' + DateEdit2.Text + ':' + Time2.Text;
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 case ListFlag of
  0: PrintStr := 'All Sales';
  1: PrintStr := 'Table Order';
  2: PrintStr := 'Quick Sale';
  3: PrintStr := 'Phone Order';
 end;
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 if OperatorCheckBox.Checked then
    begin
     PrintStr :=  'Operator: ' + OperatorEdit.Text;
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if MachineIDCheckBox.Checked then
    begin
     PrintStr :=  'Machine ID: ' + MachineIDEdit.Text;
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if PrintDateOnDailyReport then
    begin
     PrintStr := 'Print Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TEndOfDayForm.PrintSimpleReport;
var
 PaperWidth: integer;
 PrintStr: string;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '              DAILY REPORT';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 with ReceiveQuery do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     PrintStr := Format('%-28s%12.2f', [FieldByName('PayBy').AsString, FieldByName('Amount').AsFloat]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     Next;
    end;
   First;
   EnableControls;
  end;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := Format('Total Sales:                %12.2f', [TotalSales]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 if ABS(TotalDiscount) >= 0.01 then
    begin
     PrintStr := Format('Discount:                   %12.2f', [TotalDiscount]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(RewardPoints) >= 0.01 then
    begin
     PrintStr := Format('Points Redeem:              %12.2f', [RewardPoints]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;


 if ABS(TotalRounding) >= 0.01 then
    begin
     PrintStr := Format('Rounding Benefit:           %12.2f', [0 - TotalRounding]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(TotalTips) >= 0.01 then
    begin
     PrintStr := Format('Total Tips:                 %12.2f', [TotalTips]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(TotalSurcharge) >= 0.01 then
    begin
     PrintStr := Format('Bank Charge:                %12.2f', [TotalSurcharge]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(ReceivedAccountPayment) >= 0.01 then
    begin
     PrintStr := Format('Account Payment:            %12.2f', [ReceivedAccountPayment]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(AccountPayment) >= 0.01 then
    begin
     PrintStr := Format('Outstanding Account Sales:  %12.2f', [AccountPayment]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(Deposit) >= 0.01 then
    begin
     PrintStr := Format('Deposit:                    %12.2f', [Deposit]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 PrintStr := Format('Total Receivable:           %12.2f', [TotalReceivable]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := Format('Total Received:             %12.2f', [TotalReceive]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 if ABS(OutstandingOrder) >= 0.01 then
    begin
     PrintStr := Format('Balance:                    %12.2f', [OutstandingOrder]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(TotalGST) >= 0.01 then
    begin
     PrintStr := Format('Total G.S.T.:               %12.2f', [TotalGST]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(VoidQty) >= 0.01 then
    begin
     PrintStr := Format('Void Qty:                   %12.2f', [ABS(VoidQty)]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if ABS(VoidAmount) >= 0.01 then
    begin
     PrintStr := Format('Void Amount:                %12.2f', [ABS(VoidAmount)]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := 'Report Date:';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := DateEdit1.Text + ':' + Time1.Text + ' - ' + DateEdit2.Text + ':' + Time2.Text;
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 if OperatorCheckBox.Checked then
    begin
     PrintStr :=  'Operator: ' + OperatorEdit.Text;
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if MachineIDCheckBox.Checked then
    begin
     PrintStr :=  'Machine ID: ' + MachineIDEdit.Text;
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if PrintDateOnDailyReport then
    begin
     PrintStr := 'Print Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TEndOfDayForm.PrintOutToFile;
var
 PrintStr, TempStr, FileName: string;
 F: TextFile;
begin
 SaveDialog.InitialDir := StartDir + 'Data';
 SaveDialog.FileName := FormatDateTime('yyyymmdd', TransferDate(DateEdit1.Text)) +
                        FormatDateTime('yyyymmdd', TransferDate(DateEdit2.Text)) + '.TXT';
 if Not SaveDialog.Execute then Exit;
 FileName := SaveDialog.FileName;
 AssignFile(F, FileName);
 Rewrite(F);
 PrintStr := '              DAILY REPORT';
 Writeln(F, PrintStr);
 PrintStr := '----------------------------------------';
 Writeln(F, PrintStr);
 PrintStr := 'Category                   Qty    Amount';
 Writeln(F, PrintStr);
 with CategoryQuery do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     TempStr := Copy(FieldByName('Category').AsString, 1, 20);
     PrintStr := Format('%-20s%10.2f%10.2f',
      [TempStr, FieldByName('TotalQty').AsFloat, FieldByName('Amount').AsFloat]);
     Writeln(F, PrintStr);
     Next;
    end;
   First;
   EnableControls;
  end;
 PrintStr := Format('Total Sales:                %12.2f', [TotalSales]);
 Writeln(F, PrintStr);
 PrintStr := '----------------------------------------';
 Writeln(F, PrintStr);
 with ItemGroupQuery do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     PrintStr := Format('%-20s%10.2f%10.2f',
      [FieldByName('ItemGroup').AsString, FieldByName('Qty').AsFloat, FieldByName('Amount').AsFloat]);
     Writeln(F, PrintStr);
     Next;
    end;
   First;
   EnableControls;
  end;
 PrintStr := '----------------------------------------';
 Writeln(F, PrintStr);
 with ReceiveQuery do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     PrintStr := Format('%-28s%12.2f', [FieldByName('PayBy').AsString, FieldByName('Amount').AsFloat]);
     Writeln(F, PrintStr);
     Next;
    end;
   First;
   EnableControls;
  end;
 PrintStr := '----------------------------------------';
 Writeln(F, PrintStr);
 PrintStr := Format('Total Sales:                %12.2f', [TotalSales]);
 Writeln(F, PrintStr);
 PrintStr := Format('Discount:                   %12.2f', [TotalDiscount]);
 Writeln(F, PrintStr);
 PrintStr := Format('Total Points Redeem:        %12.2f', [RewardPoints]);
 Writeln(F, PrintStr);
 PrintStr := Format('Net Sales:                  %12.2f', [NetSales]);
 Writeln(F, PrintStr);
 PrintStr := Format('Rounding Benefit:           %12.2f', [0 - TotalRounding]);
 Writeln(F, PrintStr);
 PrintStr := Format('Total Tips:                 %12.2f', [TotalTips]);
 Writeln(F, PrintStr);
 PrintStr := Format('Bank Charge:                %12.2f', [TotalSurcharge]);
 Writeln(F, PrintStr);
 PrintStr := Format('Account Payment:            %12.2f', [ReceivedAccountPayment]);
 Writeln(F, PrintStr);
 PrintStr := Format('Outstanding Account Sales:  %12.2f', [AccountPayment]);
 Writeln(F, PrintStr);
 PrintStr := Format('Deposit:                    %12.2f', [Deposit]);
 Writeln(F, PrintStr);
 PrintStr := Format('Total Receivable:           %12.2f', [TotalReceivable]);
 Writeln(F, PrintStr);
 PrintStr := Format('Total Received:             %12.2f', [TotalReceive]);
 Writeln(F, PrintStr);
 PrintStr := Format('Balance:                    %12.2f', [OutstandingOrder]);
 Writeln(F, PrintStr);
 PrintStr := Format('Cash Pay Out:               %12.2f', [CashPayOut]);
 Writeln(F, PrintStr);
 PrintStr := Format('Cash Float In:              %12.2f', [CashIn]);
 Writeln(F, PrintStr);
 PrintStr := Format('Cash Float Out:             %12.2f', [CashOut]);
 Writeln(F, PrintStr);
 PrintStr := Format('Cash In Drawer:             %12.2f', [CashInDrawer]);
 Writeln(F, PrintStr);
 PrintStr := Format('Cash Less Tips:             %12.2f', [CashLessTips]);
 Writeln(F, PrintStr);
 PrintStr := Format('Total EFTPOS Payment:       %12.2f', [TotalEFTPOSPayment]);
 Writeln(F, PrintStr);
 PrintStr := Format('Total G.S.T.:               %12.2f', [TotalGST]);
 Writeln(F, PrintStr);
 PrintStr := Format('%-28s%12.2f', [SurchargeName + ':', TotalServiceCharge]);
 Writeln(F, PrintStr);
 PrintStr := Format('%-28s%12.2f', [OtherChargeName + ':', TotalOtherCharge]);
 Writeln(F, PrintStr);
 PrintStr := Format('Total People:               %12d', [Persons]);
 Writeln(F, PrintStr);
 PrintStr := Format('P.P.H.:                     %12.2f', [PPH]);
 Writeln(F, PrintStr);
 PrintStr := Format('Average Sales:              %12.2f', [AverageSales]);
 Writeln(F, PrintStr);
 PrintStr := Format('Void Qty:                   %12.2f', [ABS(VoidQty)]);
 Writeln(F, PrintStr);
 PrintStr := Format('Void Amount:                %12.2f', [ABS(VoidAmount)]);
 Writeln(F, PrintStr);
 PrintStr := Format('Wastage Amount:             %12.2f', [WastageAmount]);
 Writeln(F, PrintStr);
 PrintStr := Format('Total Transactions:         %12d', [TotalBill]);
 Writeln(F, PrintStr);
 if Not OperatorCheckBox.Checked then
    begin
     PrintStr := Format('No Sale Drawer Opens:       %12d', [NonSalesOpenDrawerCounter]);
     Writeln(F, PrintStr);
    end;
 PrintStr := '----------------------------------------';
 Writeln(F, PrintStr);
 PrintStr := 'Report Date:';
 Writeln(F, PrintStr);
 PrintStr := DateEdit1.Text + ':' + Time1.Text + ' - ' + DateEdit2.Text + ':' + Time2.Text;
 Writeln(F, PrintStr);
 case ListFlag of
  0: PrintStr := 'All Sales';
  1: PrintStr := 'Table Service';
  2: PrintStr := 'Quick Service';
  3: PrintStr := 'Phone Order';
 end;
 Writeln(F, PrintStr);
 PrintStr := '----------------------------------------';
 Writeln(F, PrintStr);
 if OperatorCheckBox.Checked then
    begin
     PrintStr :=  'Operator: ' + OperatorEdit.Text;
     Writeln(F, PrintStr);
    end;
 if MachineIDCheckBox.Checked then
    begin
     PrintStr :=  'Machine ID: ' + MachineIDEdit.Text;
     Writeln(F, PrintStr);
    end;
 if PrintDateOnDailyReport then
    begin
     PrintStr := 'Print Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
     Writeln(F, PrintStr);
    end;
 CloseFile(F);
end;

procedure TEndOfDayForm.SearchButtonClick(Sender: TObject);
begin
 DropIndex;
 RebuildIndex;
 DateTime1 := TransferDate(DateEdit1.Text) + StrToTime(Time1.Text);
 DateTime2 := TransferDate(DateEdit2.Text) + StrToTime(Time2.Text);
 OpenCategoryQuery;
 OpenReceiveQuery;
 OpenItemGroupQuery;
 OpenDiscountQuery;
 CalcAmount;
 if AutoOpenTill then
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
               if FVar.SecondCashDrawerPort >= 0 then
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
end;

procedure TEndOfDayForm.PrintButtonClick(Sender: TObject);
begin
 if CategoryQuery.Active and ReceiveQuery.Active then
    begin
     if OnlyPrintSimpleFormatDailyReport and Not Supervisor then
        PrintSimpleReport
       else
        begin
         case PrintOptionForm.OptionPro of
          0: PrintOutToPrinter;
          1: PrintSimpleReport;
          2: PrintDailyReportA4PaperForm.PrintDailyReportToA4PaperPro;
          3: PrintOutToFile;
         end;
        end;
    end;
end;

procedure TEndOfDayForm.DBGridDblClick(Sender: TObject);
var
 MachineName, Operator: string;
begin
 if ReceiveQuery.Active and (ReceiveQuery.RecordCount > 0) then
    begin
     if MachineIDCheckBox.Checked then
        MachineName := MachineIDEdit.Text
       else
        MachineName := '';
     if OperatorCheckBox.Checked then
        Operator := OperatorEdit.Text
       else
        Operator := '';
     ReceiptsDetailList.ReceiptDetailListPro(DateTime1, DateTime2,
                        ReceiveQuery.FieldByName('PayBy').AsString,
                        Operator, MachineName, ListFlag);
    end;
end;

procedure TEndOfDayForm.OperatorCheckBoxClick(Sender: TObject);
begin
 if OperatorCheckBox.Checked then
    begin
     OperatorEdit.Text := sUserName;
     OperatorEdit.Enabled := True;
    end
   else
    begin
     OperatorEdit.Text := '';
     OperatorEdit.Enabled := False;
    end;
 InitForm;
end;

procedure TEndOfDayForm.OperatorEditClick(Sender: TObject);
var
 StaffName: string;
begin
 if StaffListForm.ListStaffPro(StaffName) then
    OperatorEdit.Text := StaffName;
end;

procedure TEndOfDayForm.SetListButtonColor;
begin
 if ListFlag = 0 then
    begin
     ListAllButton.ColorText := clRed;
     ListAllButton.DownColorText := clRed;
     ListAllButton.OverColorText := clRed;
    end
   else
    begin
     ListAllButton.ColorText := clBlue;
     ListAllButton.DownColorText := clBlue;
     ListAllButton.OverColorText := clBlue;
    end;
 if ListFlag = 1 then
    begin
     TableOrderButton.ColorText := clRed;
     TableOrderButton.DownColorText := clRed;
     TableOrderButton.OverColorText := clRed;
    end
   else
    begin
     TableOrderButton.ColorText := clBlue;
     TableOrderButton.DownColorText := clBlue;
     TableOrderButton.OverColorText := clBlue;
    end;
 if ListFlag = 2 then
    begin
     QuickSaleButton.ColorText := clRed;
     QuickSaleButton.DownColorText := clRed;
     QuickSaleButton.OverColorText := clRed;
    end
   else
    begin
     QuickSaleButton.ColorText := clBlue;
     QuickSaleButton.DownColorText := clBlue;
     QuickSaleButton.OverColorText := clBlue;
    end;
 if ListFlag = 3 then
    begin
     PhoneOrderButton.ColorText := clRed;
     PhoneOrderButton.DownColorText := clRed;
     PhoneOrderButton.OverColorText := clRed;
    end
   else
    begin
     PhoneOrderButton.ColorText := clBlue;
     PhoneOrderButton.DownColorText := clBlue;
     PhoneOrderButton.OverColorText := clBlue;
    end
end;

procedure TEndOfDayForm.ListAllButtonClick(Sender: TObject);
begin
 ListFlag := 0;
 SetListButtonColor;
 SearchButtonClick(Sender);
end;

procedure TEndOfDayForm.TableOrderButtonClick(Sender: TObject);
begin
 ListFlag := 1;
 SetListButtonColor;
 SearchButtonClick(Sender);
end;

procedure TEndOfDayForm.QuickSaleButtonClick(Sender: TObject);
begin
 ListFlag := 2;
 SetListButtonColor;
 SearchButtonClick(Sender);
end;

procedure TEndOfDayForm.PhoneOrderButtonClick(Sender: TObject);
begin
 ListFlag := 3;
 SetListButtonColor;
 SearchButtonClick(Sender);
end;

procedure TEndOfDayForm.EditChange(Sender: TObject);
begin
 if Not Supervisor and Not CheckDailyReport and (Date - TransferDate(DateEdit1.Text) > InquirySalesRelatedReportDays) then
    DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date - InquirySalesRelatedReportDays);
 InitForm;
end;

procedure TEndOfDayForm.MachineIDCheckBoxClick(Sender: TObject);
begin
 if MachineIDCheckBox.Checked then
    begin
     MachineIDEdit.Text := MachineID;
     MachineIDEdit.Enabled := True;
    end
   else
    begin
     MachineIDEdit.Text := '';
     MachineIDEdit.Enabled := False;
    end;
 InitForm;
end;

procedure TEndOfDayForm.MachineIDEditClick(Sender: TObject);
var
 MachineName: string;
begin
 if MachineIDCollectForm.MachineIDPro(MachineName) then
    begin
     MachineIDEdit.Text := MachineName;
     InitForm;
    end;
end;

procedure TEndOfDayForm.OpenGeneralQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select OrderNo, OrderDate, (Amount + ServiceCharge + OtherCharge) As SalesAmount ' +
           'From OrderH ' +
           'Where (PriceIncludesGST <> 0) and ' +
           '(OrderDate>=' + ConvertDateTime(DateTime1) + ') and ' +
           '(OrderDate<=' + ConvertDateTime(DateTime2) + ')';
 if MachineIDCheckBox.Checked then
    SQLStr := SQLStr + ' and MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and ServicePerson=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 SQLStr := SQLStr + ' Union All ' +
           'Select OrderNo, OrderDate, (Amount + ServiceCharge + OtherCharge + GST) As SalesAmount ' +
           'From OrderH ' +
           'Where (PriceIncludesGST = 0) and ' +
           '(OrderDate>=' + ConvertDateTime(DateTime1) + ') and ' +
           '(OrderDate<=' + ConvertDateTime(DateTime2) + ')';
 if MachineIDCheckBox.Checked then
    SQLStr := SQLStr + ' and MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39);
 case ListFlag of
  1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER);
  2: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
  3: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and ServicePerson=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
 SQLStr := SQLStr + ' Order By OrderNo';
 Screen.Cursor := crHourGlass;
 with GeneralQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;

procedure TEndOfDayForm.JournalButtonClick(Sender: TObject);
var
 PaperWidth: integer;
 PrintStr: string;
 TotalSales: double;
begin
 OpenGeneralQuery;
 if Not GeneralQuery.Active or (GeneralQuery.RecordCount = 0) then Exit;
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '             JOURNAL REPORT';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Order No.    Date                 Amount';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 TotalSales := 0;
 with GeneralQuery do
  begin
   First;
   while Not EOF do
    begin
     PrintStr := FieldByName('OrderNo').AsString + '   ' +
      FormatDateTime('dd/mm/yyyy hh:mm', FieldByName('OrderDate').AsDateTime) +
      Format('%11.2f', [FieldByName('SalesAmount').AsFloat]);
     DataForm.OutPutToPrinter(PrintStr);
     TotalSales := TotalSales + FieldByName('SalesAmount').AsFloat;
     Next;
    end;
   Close;
  end;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 PrintStr := Format('                 Total Sales: %10.2f', [TotalSales]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Report Date:';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := DateEdit1.Text + ':' + Time1.Text + ' - ' + DateEdit2.Text + ':' + Time2.Text;
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 if OperatorCheckBox.Checked then
    begin
     PrintStr :=  'Operator: ' + OperatorEdit.Text;
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if MachineIDCheckBox.Checked then
    begin
     PrintStr :=  'Machine ID: ' + MachineIDEdit.Text;
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if PrintDateOnDailyReport then
    begin
     PrintStr := 'Print Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
     DataForm.OutPutToPrinter(PrintStr);
     PrintStr := '----------------------------------------';
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TEndOfDayForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TEndOfDayForm.FormShow(Sender: TObject);
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
 Time1.Text := FormatDateTime('hh:mm', BeginTime);
 Time2.Text := FormatDateTime('hh:mm', EndTime);
 OperatorCheckBox.Checked := False;
 OperatorEdit.Enabled := False;
 if Supervisor or CheckDailyReport then
    begin
     OperatorCheckBox.Enabled := True;
     OperatorEdit.Text := '';
    end
   else
    begin
     OperatorCheckBox.Enabled := False;
     OperatorEdit.Text := sUserName;
    end;
 ListFlag := 0;
 SetListButtonColor;
 InitForm;
 PrintButton.Enabled := PrintDailyReport;
 JournalButton.Enabled := PrintDailyReport;
 ReceiveQueryAmount.DisplayFormat := sCurrency + ',0.#0';
 CategoryQueryAmount.DisplayFormat  := sCurrency + ',0.#0';
 ItemGroupQueryAmount.DisplayFormat := sCurrency + ',0.#0';
 SurchargeLabel.Caption := SurchargeName;
 OtherChargeLabel.Caption := OtherChargeName;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
end;

procedure TEndOfDayForm.DailyReportPro(ReportKind: integer);
begin
 Application.CreateForm(TEndOfdayForm, EndOfdayForm);
 EndOfdayForm.ListFlag := ReportKind;
 EndOfdayForm.ShowModal;
 EndOfdayForm.Free;
end;

procedure TEndOfDayForm.DropIndex;
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
     DataForm.ExecQueryPro(SQLStr);
     Next;
    end;
  end;
end;

procedure TEndOfDayForm.RebuildIndex;
var
 SQLStr: string;
begin
 // AccessMenu
 SQLStr := 'Create Index StaffName On AccessMenu(StaffName)';
 DataForm.ExecQueryPro(SQLStr);

 // Attendance
 SQLStr := 'Create Index IDNo On Attendance(IDNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index LoginTime On Attendance(LoginTime)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index LogoutTime On Attendance(LogoutTime)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index StaffName On Attendance(StaffName)';
 DataForm.ExecQueryPro(SQLStr);

 // BankTransaction
 SQLStr := 'Create Index AccountNo On BankTransaction(AccountNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index AcctDate On BankTransaction(AcctDate)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index IDNo On BankTransaction(IDNo)';
 DataForm.ExecQueryPro(SQLStr);

 // BookDetail
 SQLStr := 'Create Index BookingNo On BookDetail(BookingNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On BookDetail(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);

 // BookTable
 SQLStr := 'Create Index BookingNo On BookTable(BookingNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index BookingDate On BookTable(BookingDate)';
 DataForm.ExecQueryPro(SQLStr);

 // CashFloatTable
 SQLStr := 'Create Index OpDate On CashFloatTable(OpDate)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OpName On CashFloatTable(OpName)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ID On CashFloatTable(ID)';
 DataForm.ExecQueryPro(SQLStr);

 // Category
 SQLStr := 'Create Index Category On Category(Category)';
 DataForm.ExecQueryPro(SQLStr);

 // Chart
 SQLStr := 'Create Index AccountNo On Chart(AccountNo)';
 DataForm.ExecQueryPro(SQLStr);

 // DepositTable
 SQLStr := 'Create Index VIPNo On DepositTable(VIPNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index DepositDate On DepositTable(DepositDate)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ID On DepositTable(ID)';
 DataForm.ExecQueryPro(SQLStr);

 // DrawerCounter
 SQLStr := 'Create Index MachineID On DrawerCounter(MachineID)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OpenDate On DrawerCounter(OpenDate)';
 DataForm.ExecQueryPro(SQLStr);

 // ExpAcct
 SQLStr := 'Create Index AcctDate On ExpAcct(AcctDate)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SerialNo On ExpAcct(SerialNo)';
 DataForm.ExecQueryPro(SQLStr);

 // ExpDetail
 SQLStr := 'Create Index SerialNo On ExpDetail(SerialNo)';
 DataForm.ExecQueryPro(SQLStr);

 // Expenses
 SQLStr := 'Create Index AccountNo On Expenses(AccountNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index AcctDate On Expenses(AcctDate)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SupplierCode On Expenses(SupplierCode)';
 DataForm.ExecQueryPro(SQLStr);

 // IngredientsTable
 SQLStr := 'Create Index ItemCode On IngredientsTable(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);

 // InstructionLink
 SQLStr := 'Create Index Code On InstructionLink(Code)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On InstructionLink(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);

 // ItemGroupTable
 SQLStr := 'Create Index GroupName On ItemGroupTable(GroupName)';
 DataForm.ExecQueryPro(SQLStr);

 // KitchenScreen
 SQLStr := 'Create Index OrderNo On KitchenScreen(OrderNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On KitchenScreen(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);

 // LoyaltyPoints
 SQLStr := 'Create Index VIPNo On LoyaltyPoints(VIPNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OrderNo On LoyaltyPoints(OrderNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OrderDate On LoyaltyPoints(OrderDate)';
 DataForm.ExecQueryPro(SQLStr);

 // MealPackage
 SQLStr := 'Create Index ID On MealPackage(ID)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On MealPackage(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index IDNo On MealPackage(IDNo)';
 DataForm.ExecQueryPro(SQLStr);

 // MenuGroupTable
 SQLStr := 'Create Index Code On MenuGroupTable(Code)';
 DataForm.ExecQueryPro(SQLStr);

 // MenuItem
 SQLStr := 'Create Index ItemCode On MenuItem(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index Category On MenuItem(Category)';
 DataForm.ExecQueryPro(SQLStr);

 // OrderH
 SQLStr := 'Create Index OrderNo On OrderH(OrderNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OrderDate On OrderH(OrderDate)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index InvoiceNo On OrderH(InvoiceNo)';
 DataForm.ExecQueryPro(SQLStr);

 // OrderI
 SQLStr := 'Create Index OrderNo On OrderI(OrderNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On OrderI(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index IDNo On OrderI(IDNo)';
 DataForm.ExecQueryPro(SQLStr);

 // PayAcct
 SQLStr := 'Create Index ReceiveNo On PayAcct(ReceiveNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index AccountDate On PayAcct(AccountDate)';
 DataForm.ExecQueryPro(SQLStr);

 // PayOutTable
 SQLStr := 'Create Index PaymentDate On PayOutTable(PaymentDate)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ID On PayOutTable(ID)';
 DataForm.ExecQueryPro(SQLStr);

 // PurchaseHead
 SQLStr := 'Create Index PurchaseNo On PurchaseHead(PurchaseNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index PurchaseDate On PurchaseHead(PurchaseDate)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SupplierCode On PurchaseHead(SupplierCode)';
 DataForm.ExecQueryPro(SQLStr);

 // PurchaseItem
 SQLStr := 'Create Index PurchaseNo On PurchaseItem(PurchaseNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index Code On PurchaseItem(Code)';
 DataForm.ExecQueryPro(SQLStr);

 // RecvAcct
 SQLStr := 'Create Index AccountDate On RecvAcct(AccountDate)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index OrderNo On RecvAcct(OrderNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index IDNo On RecvAcct(IDNo)';
 DataForm.ExecQueryPro(SQLStr);

 // StockH
 SQLStr := 'Create Index ReceiveNo On StockH(ReceiveNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ReceiveDate On StockH(ReceiveDate)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SupplierCode On StockH(SupplierCode)';
 DataForm.ExecQueryPro(SQLStr);

 // StockI
 SQLStr := 'Create Index ReceiveNo On StockI(ReceiveNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index Code On StockI(Code)';
 DataForm.ExecQueryPro(SQLStr);

 // StockLinkTable
 SQLStr := 'Create Index ItemCode On StockLinkTable(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index Code On StockLinkTable(Code)';
 DataForm.ExecQueryPro(SQLStr);

 // StockTable
 SQLStr := 'Create Index Code On StockTable(Code)';
 DataForm.ExecQueryPro(SQLStr);

 // StreetTable
 SQLStr := 'Create Index Street On StreetTable(Street)';
 DataForm.ExecQueryPro(SQLStr);

 // SubMenuLink
 SQLStr := 'Create Index ItemCode On SubMenuLinkHead(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On SubMenuLinkDetail(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SubMenuCode On SubMenuLinkDetail(SubMenuCode)';
 DataForm.ExecQueryPro(SQLStr);

 // Supplier
 SQLStr := 'Create Index SupplierCode On Supplier(SupplierCode)';
 DataForm.ExecQueryPro(SQLStr);

 // SupplierMemo
 SQLStr := 'Create Index SupplierCode On SupplierMemo(SupplierCode)';
 DataForm.ExecQueryPro(SQLStr);

 // TablePage
 SQLStr := 'Create Index PageNo On TablePage(PageNo)';
 DataForm.ExecQueryPro(SQLStr);

 // TableSet
 SQLStr := 'Create Index TableNo On TableSet(TableNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index PageFlag On TableSet(PageFlag)';
 DataForm.ExecQueryPro(SQLStr);

 // VIPTable
 SQLStr := 'Create Index VIPNo On VIPTable(VIPNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index VIPName On VIPTable(VIPName)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index SerialNo On VIPTable(SerialNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index Telephone On VIPTable(Telephone)';
 DataForm.ExecQueryPro(SQLStr);

 // VoidReasonTable
 SQLStr := 'Create Index Code On VoidReasonTable(Code)';
 DataForm.ExecQueryPro(SQLStr);

 // WastageHead
 SQLStr := 'Create Index WastageNo On WastageHead(WastageNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index WastageDate On WastageHead(WastageDate)';
 DataForm.ExecQueryPro(SQLStr);

 // WastageItem
 SQLStr := 'Create Index WastageNo On WastageItem(WastageNo)';
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Create Index ItemCode On WastageItem(ItemCode)';
 DataForm.ExecQueryPro(SQLStr);
end;



end.