unit VIPAccount;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Buttons, DBCtrls, Mask, Grids, DBGrids, ExtCtrls, DataUnit,
  ADODB, UtilUnit, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TVIPAccountForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    CompanyEdit: TEdit;
    TelephoneEdit: TEdit;
    FaxEdit: TEdit;
    MobileEdit: TEdit;
    VIPNoEdit: TEdit;
    VIPNameEdit: TEdit;
    EmailEdit: TEdit;
    CreateDateEdit: TMaskEdit;
    Label9: TLabel;
    DiscountEdit: TEdit;
    Label10: TLabel;
    BirthDayEdit: TMaskEdit;
    Label11: TLabel;
    AddressEdit: TEdit;
    Label12: TLabel;
    SuburbEdit: TEdit;
    Label13: TLabel;
    StateEdit: TEdit;
    Label14: TLabel;
    PostCodeEdit: TEdit;
    Query: TADOQuery;
    Label15: TLabel;
    MapEdit: TEdit;
    Label16: TLabel;
    OrderAmountLabel: TStaticText;
    Label17: TLabel;
    PaidAmountLabel: TStaticText;
    Label18: TLabel;
    BalanceLabel: TStaticText;
    StringGrid: TStringGrid;
    Label19: TLabel;
    DateTimeEdit: TStaticText;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    RemainLabel: TStaticText;
    PayAmountEdit: TStaticText;
    MethodEdit: TStaticText;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    TitlePanel: TbsSkinPanel;
    DetailPanel: TbsSkinPanel;
    PaymentPanel: TbsSkinPanel;
    EditPanel: TbsSkinPanel;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    DepositButton: TXiButton;
    MethodButton: TXiButton;
    AutoPayBtn: TXiButton;
    function  OpenQuery(SQLStr: string): boolean;
    procedure ReadVIPInformation;
    procedure InitStringGrid;
    procedure InitPayment;
    procedure GetOrderDetail;
    procedure CalcBalance;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitButtonClick(Sender: TObject);
    procedure StringGridDblClick(Sender: TObject);
    procedure StringGridClick(Sender: TObject);
    procedure StringGridEnter(Sender: TObject);
    procedure StringGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  CheckCells(ACol, ARow: integer): boolean;
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    function  FindIDNo(OrderNo: string): integer;
    function  SavePaymentData: boolean;
    procedure SaveDataPro;
    procedure SaveButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    function  VIPAccountPro(VIPNo: string): boolean;
    procedure PrintButtonClick(Sender: TObject);
    procedure EFTTransactionEvent(Sender: TObject);
    procedure EFTPrintReceiptEvent(Sender: TObject; const ReceiptType: WideString);
    procedure EFTGetLastTransactionEvent(Sender: TObject);
    procedure PrintCustomerReceipt;
    procedure PrintMerthantReceiptPro(Receipt: WideString);
    procedure PayAmountEditClick(Sender: TObject);
    procedure MethodButtonClick(Sender: TObject);
    procedure DepositButtonClick(Sender: TObject);
    procedure AutoPayBtnClick(Sender: TObject);
  private { Private declarations }
    VIPNo, ReceiptFlag: string;
    MaxRow, CurrentCol, CurrentRow, ReferenceNo, DepositID: integer;
    Changed, ReturnFlag, LinkToEFTPOSFlag: boolean;
    DueAmount: double;
  public
    { Public declarations }
  end;

var
  VIPAccountForm: TVIPAccountForm;

implementation

uses MainMenu, MessageBox, PaymentSelect, NumPad, DepositPayment;

{$R *.DFM}

function TVIPAccountForm.OpenQuery(SQLStr: string): boolean;
begin
 Result := True;
 Screen.Cursor := crHourGlass;
 with Query do
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
   Screen.Cursor := crDefault;
  end;
end;

procedure TVIPAccountForm.ReadVIPInformation;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From VIPTable Where VIPNo=' + VIPNo;
 if OpenQuery(SQLStr) then
    with Query do
     begin
      VIPNameEdit.Text := FieldByName('VIPName').AsString;
      CompanyEdit.Text := FieldByName('Company').AsString;
      TelephoneEdit.Text := FieldByName('Telephone').AsString;
      FaxEdit.Text := FieldByName('Fax').asString;
      MobileEdit.Text := FieldByName('Mobile').AsString;
      EMailEdit.Text := FieldByName('EMail').AsString;
      AddressEdit.Text := FieldByName('Number').AsString + ' ' +
                          FieldByName('Address').AsString;
      SuburbEdit.Text := FieldByName('Suburb').AsString;
      StateEdit.Text := FieldByName('State').AsString;
      PostCodeEdit.Text := FieldByName('PostCode').AsString;
      VIPNoEdit.Text := Format('%8.8d', [StrToInt(VIPNo)]);
      MapEdit.Text := FieldByName('MapReference').AsString;
      CreateDateEdit.Text := FormatDateTime('dd/mm/yyyy', FieldByName('CreateDate').AsDateTime);
      BirthDayEdit.Text := FormatDateTime('dd/mm/yyyy', FieldByName('BirthDay').AsDateTime);
      DiscountEdit.Text := Format('%5.2f', [FieldByName('Discount').AsFloat]);
      Active := False;
     end;
end;

procedure TVIPAccountForm.InitStringGrid;
Var
 I: integer;
begin
 with StringGrid do
  begin
   Cells[0, 0] := 'No.';
   Cells[1, 0] := 'Date';
   Cells[2, 0] := 'Order No.';
   Cells[3, 0] := 'Amount';
   Cells[4, 0] := 'Pay Amount';
   Cells[5, 0] := 'Balance';
   for I := 1 to MaxRow do
    begin
     Cells[0, I] := Format('%1d', [I]);
     Cells[1, I] := ''; Cells[2, I] := '';
     Cells[3, I] := ''; Cells[4, I] := '';
     Cells[5, I] := '';
    end;
   Col := 1; Row := 1; TopRow := 1; LeftCol := 1;
   CurrentCol := 1; CurrentRow := 1;
  end;
end;

procedure TVIPAccountForm.InitPayment;
var
 I: integer;
begin
 with StringGrid do
  for I := 1 to MaxRow do
   if Cells[1, I] <> '' then
      begin
       Cells[5, I] := Cells[3, I];
       Cells[4, I] := '0.00';
      end;
end;

procedure TVIPAccountForm.GetOrderDetail;
var
 SQLStr: string;
 I: integer;
begin
 DueAmount := 0;
 SQLStr := 'Select OrderNo, OrderDate, Amount + ServiceCharge + OtherCharge + Tips + Surcharge As TotalSales, ' +
           'PaidAmount From OrderH ' +
           'Where (PriceIncludesGST <> 0) and ' +
           '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge - PaidAmount > 0.005) and ' +
           'VIPNo=' + VIPNo +
           'Union All ' +
           'Select OrderNo, OrderDate, Amount + ServiceCharge + OtherCharge + GST + Tips + Surcharge As TotalSales, ' +
           'PaidAmount From OrderH ' +
           'Where (PriceIncludesGST = 0) and ' +
           '(Amount + ServiceCharge + OtherCharge + GST + Tips + Surcharge - PaidAmount > 0.005) and ' +
           'VIPNo=' + VIPNo +
           ' Order By OrderDate, OrderNo';
 if Not OpenQuery(SQLStr) then Exit;
 with Query do
  begin
   if RecordCount <= 15 then
      MaxRow := 16
     else
      MaxRow := RecordCount + 1;
   StringGrid.RowCount := MaxRow;
   InitStringGrid;
   I := 1;
   while Not EOF do
    begin
     StringGrid.cells[1, I] := FormatDateTime('dd/mm/yyyy hh:mm', FieldByName('OrderDate').AsDateTime);
     StringGrid.Cells[2, I] := FieldByName('OrderNo').AsString;
     StringGrid.Cells[3, I] := Format('%4.2f', [FieldByName('TotalSales').AsFloat - FieldByName('PaidAmount').AsFloat]);
     StringGrid.Cells[4, I] := Format('%4.2f', [0.0]);
     StringGrid.Cells[5, I] := Format('%4.2f', [FieldByName('TotalSales').AsFloat - FieldByName('PaidAmount').AsFloat]);
     DueAmount := DueAmount + FieldByName('TotalSales').AsFloat - FieldByName('PaidAmount').AsFloat;
     Next; I := I + 1;
    end;
   Close;
  end;
 CalcBalance;
end;

procedure TVIPAccountForm.CalcBalance;
var
 I: integer;
 TotalInvoice, TotalPaid, InvAmount, PaidAmount, Balance, Remain: double;
begin
 TotalInvoice := 0; TotalPaid := 0;
 if PayAmountEdit.Caption <> '' then
    Remain := StrToFloat(PayAmountEdit.Caption)
   else
    Remain := 0;
 with StringGrid do
  for I := 1 to MaxRow do
   if Cells[1, I] <> '' then
      begin
       if Cells[4, I] <> '' then
          InvAmount := StrToFloat(Cells[3, I])
         else
          InvAmount := 0;
       if Cells[4, I] <> '' then
          PaidAmount := StrToFloat(Cells[4, I])
         else
          PaidAmount := 0;
       Balance := InvAmount - PaidAmount;
       if ABS(Balance) >= 0.009 then
          Cells[5, I] := Format('%4.2f', [Balance])
         else
          Cells[5, I] := '0.00';
       TotalInvoice := TotalInvoice + InvAmount;
       TotalPaid := TotalPaid + PaidAmount;
       Remain := Remain - PaidAmount;
      end;
 RemainLabel.Caption := Format('%4.2f', [Remain]);
 OrderAmountLabel.Caption := FormatCurrency(TotalInvoice);
 PaidAmountLabel.Caption := FormatCurrency(TotalPaid);
 BalanceLabel.Caption := FormatCurrency(TotalInvoice - TotalPaid);
end;

procedure TVIPAccountForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TVIPAccountForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 if EFTPOSStatus then
    begin
     DataForm.EFTPOS.OnTransactionEvent := NIL;
     DataForm.EFTPOS.OnPrintReceiptEvent := NIL;
     DataForm.EFTPOS.OnGetLastTransactionEvent := NIL;
     DataForm.EFTPOS.ReceiptAutoPrint := False;
     DataForm.EFTPOS.CutReceipt := False;
    end;
 Action := caFree;
end;

procedure TVIPAccountForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TVIPAccountForm.StringGridDblClick(Sender: TObject);
var
 InvAmount, PaidAmount, Remain: double;
begin
 with StringGrid do
  if Cells[1, Row] <> '' then
     begin
      Remain := StrToFloat(RemainLabel.Caption);
      if Cells[3, Row] <> '' then
         InvAmount := StrToFloat(Cells[3, Row])
        else
         InvAmount := 0;
      if Cells[4, Row] <> '' then
         PaidAmount := StrToFloat(Cells[4, Row])
        else
         PaidAmount := 0;
      if InvAmount > Remain + PaidAmount then
         PaidAmount := Remain + PaidAmount
        else
         PaidAmount := InvAmount;
      Cells[4, Row] := Format('%4.2f', [PaidAmount]);
      CalcBalance;
     end;
end;

procedure TVIPAccountForm.PayAmountEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := PayAmountEdit.Caption;
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Payment Amount', 0) then
    begin
     PayAmountEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
     CalcBalance;
     MethodEdit.SetFocus;
     DepositID := 0;
    end;
end;

procedure TVIPAccountForm.StringGridClick(Sender: TObject);
begin
 if (StringGrid.Col = CurrentCol) and (StringGrid.Row = CurrentRow) then
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
 if StringGrid.Col <> 4 then
    StringGrid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goTabs]
   else
    StringGrid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goTabs, goEditing];
 CalcBalance;
end;

procedure TVIPAccountForm.StringGridEnter(Sender: TObject);
begin
 StringGrid.Col := 1;
end;

procedure TVIPAccountForm.StringGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
    Case StringGrid.Col of
     1: StringGrid.Col := 2;
     2: StringGrid.Col := 3;
     3: StringGrid.Col := 4;
     4: StringGrid.Col := 5;
     5: begin
         if StringGrid.Row < MaxRow then
            StringGrid.Row := StringGrid.Row + 1;
         StringGrid.Col := 1;
       end;
    end;
 CurrentRow := StringGrid.Row; CurrentCol := StringGrid.Col;
end;

function TVIPAccountForm.CheckCells(ACol, ARow: integer): boolean;
var
 CellsStr: string;
begin
 Result := True;
 if Not Changed or (ACol <> 4) or (StringGrid.Cells[ACol, ARow] = '') then Exit;
 CellsStr := StringGrid.Cells[ACol, ARow];
 if Not CheckNum(CellsStr, 12, 999999999.99, 0, 'F') then
    begin
     StringGrid.Cells[ACol, ARow] := '';
     Result := False
    end
   else
    StringGrid.Cells[ACol, ARow] := Format('%4.2f', [StrToFloat(CellsStr)]);
 Changed := False;
end;

procedure TVIPAccountForm.StringGridKeyPress(Sender: TObject; var Key: Char);
begin
 if Key In ['0'..'9', '+', '-'] then Changed := True;
end;

function TVIPAccountForm.FindIDNo(OrderNo: string): integer;
var
 SQLStr: String;
begin
 SQLStr := 'Select Max(IDNo) From RecvAcct ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount <> 0) then
    Result := Query.Fields[0].AsInteger + 1
   else
    Result := 1;
 Query.Close;
end;

function TVIPAccountForm.SavePaymentData: boolean;
var
 I, IDNo, AwardPoints: integer;
 OrderNo, SQLStr: string;
 PaidAmount, TotalSales, Balance: double;
begin
  with StringGrid do
  begin
   Result := True; I := 1;
   while (I <= MaxRow) and Result do
    begin
     if (Cells[1, I] <> '') and (Cells[4, I] <>'') and (StrToFloat(Cells[4, I]) <> 0) then
        begin
         OrderNo := Cells[2, I];
         if Cells[3, I] <> '' then
            TotalSales := StrToFloat(Cells[3, I])
           else
            TotalSales := 0;
         PaidAmount := StrToFloat(Cells[4, I]);
         if Cells[5, I] <> '' then
            Balance := StrToFloat(Cells[5, I])
           else
            Balance := 0;
         IDNo := FindIDNo(OrderNo);
         Result := DataForm.SaveAccountRecord(OrderNo, PaidAmount, MethodEdit.Caption, IDNo, DepositID);
         if Result then Result := DataForm.UpdateOrderPayment(OrderNo, False);
         if Result and (DepositID >= 1) then
            begin
             SQLStr := 'Update OrderH Set Credit = 1 Where OrderNo = '+ Chr(39) + CheckQuotes(OrderNo) + Chr(39);
             Result := DataForm.ExecQueryPro(SQLStr);
             SQLStr := 'Update OrderH Set Flag = 1 Where VIPNo = ' + VIPNo;
             Result := DataForm.ExecQueryPro(SQLStr);
             SQLStr := 'Update DepositTable Set Flag = 1 where ID = ' + Chr(39) + IntToStr(DepositID) + Chr(39);
             Result := DataForm.ExecQueryPro(SQLStr);
            end;
         if Result and LoyaltyAwardAvailible and (ABS(TotalSales) > 0) and (Balance = 0) then
            begin
             AwardPoints := Round(TotalSales * SalesPoints);
             Result := DataForm.SaveAwardPoints(OrderNo, StrToInt(VIPNo), AwardPoints);
            end;
        end;
     I := I + 1;
    end;
  end;
end;

procedure TVIPAccountForm.SaveDataPro;
var
 Flag: boolean;
begin
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := SavePaymentData;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      SaveButton.Enabled := False;
      CancelButton.Enabled := False;
      EditPanel.Enabled := False;
      PrintButtonClick(Self);
      ReturnFlag := True;
      if Not OnlyOpenDrawerForCashPayment or (Uppercase(MethodEdit.Caption) = 'CASH') then
         begin
          CurrentDrawerNumber := DefaultDrawerPortNumber;
          DataForm.OpenDrawer(True, CurrentDrawerNumber);
         end
     end
    else
     begin
      DataForm.RollBack;
      SaveButton.Enabled := True;
      CancelButton.Enabled := True;
      EditPanel.Enabled := True;
     end;
  ExitButton.Enabled := True;
  PrintButton.Enabled := True;
 end;
end;

procedure TVIPAccountForm.SaveButtonClick(Sender: TObject);
begin
 if StrToFloat(RemainLabel.Caption) <> 0 then
    begin
     MessageBoxForm.MessagePro('Payment does not complete!', sErrorMsg);
     Exit;
    end;
 if LinkToEFTPOSFlag then
    begin
     if ABS(StrToFloat(PayAmountEdit.Caption)) < 0.01 then
        MessageBoxForm.MessagePro('EFTPOS Payment can not be Zero!', sErrorMsg)
       else
        begin
         SaveButton.Enabled := False;
         CancelButton.Enabled := False;
         ExitButton.Enabled := False;
         PrintButton.Enabled := False;
         MethodButton.Enabled := False;
         DepositButton.Enabled := False;
         if StrToFloat(PayAmountEdit.Caption) > 0 then
            DataForm.EFTPOS.TxnType := 'P'
           else
            DataForm.EFTPOS.TxnType := 'R';
         DataForm.EFTPOS.EnableTip := False;
         DataForm.EFTPOS.AmtTip := 0;
         DataForm.EFTPOS.AmtPurchase := ABS(StrToFloat(PayAmountEdit.Caption));
         DataForm.EFTPOS.AmtCash := 0;
         DataForm.EFTPOS.ReceiptAutoPrint := False;
         DataForm.EFTPOS.CutReceipt := False;
         DataForm.EFTPOS.TxnRef := IntToStr(ReferenceNo + 1);
         DataForm.EFTPOS.DoTransaction();
        end;
    end
   else
    SaveDataPro;
end;

procedure TVIPAccountForm.CancelButtonClick(Sender: TObject);
begin
 InitPayment;
 PayAmountEdit.Caption := Format('%4.2f', [DueAmount]);
 MethodEdit.Caption := 'CASH';
 LinkToEFTPOSFlag := False;
 DepositID := 0;
 CalcBalance;
end;

procedure TVIPAccountForm.DepositButtonClick(Sender: TObject);
var
 DepositBalance: double;
begin
 if DepositPaymentForm.DepositPaymentPro(StrToInt(VIPNo), DepositBalance, DepositID) then
    begin
     InitPayment;
     PayAmountEdit.Enabled := False;
     MethodEdit.Enabled := False;
     LinkToEFTPOSFlag := False;
     MethodEdit.Caption := 'Deposit';
     if DepositBalance >= DueAmount then
        PayAmountEdit.Caption := Format('%4.2f ', [DueAmount])
       else
        PayAmountEdit.Caption := Format('%4.2f ', [DepositBalance]);
     CalcBalance;
    end
end;

procedure TVIPAccountForm.MethodButtonClick(Sender: TObject);
var
 PaymentMehtod: string;
 SurchargeRate: double;
begin
 if PaymentSelectForm.PaymentSelectPro(PaymentMehtod, SurchargeRate, LinkToEFTPOSFlag) then
    begin
     if LinkToEFTPOSFlag and (Not EFTPOSStatus or Not DataForm.EFTPOS.Installed) then
        begin
         LinkToEFTPOSFlag := False;
         MessageBoxForm.MessagePro('EFTPOS machine has not been connected.', sERRORMsg)
        end
       else
        begin
         InitPayment;
         MethodEdit.Caption := PaymentMehtod;
         MethodEdit.Enabled := True;
         DepositID := 0;
         PayAmountEdit.Enabled := True;
         PayAmountEdit.Caption := Format('%4.2f ', [DueAmount]);
        end;
    end;
end;

procedure TVIPAccountForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   if (ARow > 0) and (ACol > 0) then
      case ACol of
        1, 2: begin
               SetTextAlign(Canvas.Handle, TA_CENTER);
               X := (Rect.Left + Rect.Right) div 2;
              end;
       else
         begin
          SetTextAlign(Canvas.Handle, TA_RIGHT);
          X := Rect.Right - 2;
         end;
      end
     else
      begin
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TVIPAccountForm.PrintButtonClick(Sender: TObject);
var
 PrintStr, LineStr: string;
 PaperWidth, I: integer;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 LineStr := '';
 for I := 1 to PaperWidth do LineStr := LineStr + '-';
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 DataForm.OutPutToPrinter(LineStr);
 DataForm.SetBlackFontB;
 PrintStr := 'Statement';
 PrintStr := Format('%' + IntToStr((PaperWidth - 18) div 4) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Name: ' + VIPNameEdit.Text;
 DataForm.OutPutToPrinter(PrintStr);
 if TelephoneEdit.Text <> '' then
    begin
     PrintStr := 'Telephone: ' + TelephoneEdit.Text;
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if FaxEdit.Text <> '' then
    begin
     PrintStr := 'Fax: ' + FaxEdit.Text;
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if MobileEdit.Text <> '' then
    begin
     PrintStr := 'Mobile: ' + MobileEdit.Text;
     DataForm.OutPutToPrinter(PrintStr);
    end;
 PrintStr := 'Address: ' + AddressEdit.Text;
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := SuburbEdit.Text + ' ' + StateEdit.Text + ' ' + PostCodeEdit.Text;
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Date       Order No.     AMOUNT     PAID';
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 with StringGrid do
  for I := 1 to MaxRow do
   if Cells[1, I] <> '' then
      begin
       PrintStr := Copy(Cells[1, I], 1, 10) + ' ' + Cells[2, I] +
                   ' ' + Format('%9s%9s', [Cells[3, I], Cells[4, I]]);
       DataForm.OutPutToPrinter(PrintStr);
      end;
 PrintStr := 'Total Amount:  ' + Format('%8s', [OrderAmountLabel.Caption]);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Total Payment: ' + Format('%8s', [PaidAmountLabel.Caption]);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Balance:       ' + Format('%8s', [BalanceLabel.Caption]);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Payment Method: ' + MethodEdit.Caption;
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Payment Date: ' + DateTimeEdit.Caption;
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TVIPAccountForm.EFTTransactionEvent(Sender: TObject);
begin
 if DataForm.EFTPOS.Success then
    begin
     if UpperCase(DataForm.EFTPOS.AccountType) = 'SAVINGS' then
        MethodEdit.Caption := UpperCase(DataForm.EFTPOS.AccountType)
       else
        MethodEdit.Caption := UpperCase(DataForm.EFTPOS.CardType);
     SaveDataPro;
     PrintCustomerReceipt;
     Application.ProcessMessages;
    end
   else
    begin
     CancelButton.Enabled := True;
     SaveButton.Enabled := True;
     PrintButton.Enabled := True;
     ExitButton.Enabled := True;
     ReturnFlag := False;
    end;
end;

procedure TVIPAccountForm.PrintCustomerReceipt;
var
 ReceiptStr: string;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 DataForm.PrintBillHead;
 DataForm.SetBlackFontB;
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter('  CUSTOMER RECEIPT  ' );
 DataForm.SetBlackFontA;
 ReceiptStr := '========================================';
 DataForm.OutPutToPrinter(ReceiptStr);
 ReceiptStr := 'MERCHANT ID: ' + DataForm.EFTPOS.Caid;
 DataForm.OutPutToPrinter(ReceiptStr);
 ReceiptStr := 'TERMINAL ID: ' + DataForm.EFTPOS.Catid;
 DataForm.OutPutToPrinter(ReceiptStr);
 ReceiptStr := 'CARD NUMBER: ' + Copy(DataForm.EFTPOS.Pan, 1, 6) + '-' +
               Copy(DataForm.EFTPOS.Pan, Length(DataForm.EFTPOS.Pan) - 2, 3);
 DataForm.OutPutToPrinter(ReceiptStr);
 ReceiptStr:= 'ACCOUNT TYPE: ' + UpperCase(DataForm.EFTPOS.AccountType) + '  ' +
               UpperCase(DataForm.EFTPOS.CardType);
 DataForm.OutPutToPrinter(ReceiptStr);
 ReceiptStr := 'EXPIRE DATE: ' + Copy(DataForm.EFTPOS.DateExpiry, 1, 2) + '/' +
               Copy(DataForm.EFTPOS.DateExpiry, 3, 2);
 DataForm.OutPutToPrinter(ReceiptStr);
 DataForm.OutPutToPrinter(' ');
 if DataForm.EFTPOS.TxnType = 'P' then
    begin
     ReceiptStr := 'PURCHASE:     ' + Format('%10s', [FormatCurrency(DataForm.EFTPOS.AmtPurchase)]);
     DataForm.OutPutToPrinter(ReceiptStr);
     if DataForm.EFTPOS.AmtCash >= 0.01 then
        begin
         ReceiptStr := 'CASH OUT:     ' + Format('%10s', [FormatCurrency(DataForm.EFTPOS.AmtCash)]);
         DataForm.OutPutToPrinter(ReceiptStr);
        end;
    end
   else
    if DataForm.EFTPOS.TxnType = 'R' then
       begin
        ReceiptStr := 'REFUND:       ' + Format('%10s', [FormatCurrency(DataForm.EFTPOS.AmtPurchase)]);
        DataForm.OutPutToPrinter(ReceiptStr);
       end;
 ReceiptStr := Format('%24s', ['----------']);
 DataForm.OutPutToPrinter(ReceiptStr);
 ReceiptStr := 'TOTAL:        ' + Format('%10s', [FormatCurrency(DataForm.EFTPOS.AmtPurchase + DataForm.EFTPOS.AmtCash)]);
 DataForm.OutPutToPrinter(ReceiptStr);
 ReceiptStr := DataForm.EFTPOS.ResponseText + '         AUTH NO: ' + DataForm.EFTPOS.AuthCode;
 DataForm.OutPutToPrinter(ReceiptStr);
 DataForm.OutPutToPrinter(' ');
 ReceiptStr := 'DATE: ' + Copy(DataForm.EFTPOS.Date, 1, 2) + '/' +  Copy(DataForm.EFTPOS.Date, 3, 2) + '/' +
               Copy(DataForm.EFTPOS.Date, 5, 2) +
               '  TIME: ' + Copy(DataForm.EFTPOS.Time, 1, 2) + ':' + Copy(DataForm.EFTPOS.Time, 3, 2) + '  ' +
               Format('%6.6d', [DataForm.EFTPOS.Stan]);
 DataForm.OutPutToPrinter(ReceiptStr);
 ReceiptStr := '========================================';
 DataForm.OutPutToPrinter( ReceiptStr );
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TVIPAccountForm.PrintMerthantReceiptPro(Receipt: WideString);
var
 ReceiptList: TStringList;
 TempStr: string;
 I, J: integer;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 ReceiptList := TStringList.Create;
 ReceiptList.Clear;
 ReceiptList.Add('MERCHANT RECEIPT');
 ReceiptList.Add('');
 J := 1;
 for I := 1 to Length(Receipt) do
  begin
   if (Receipt[I] <> #13) and (Receipt[I] <> #10) then
      ReceiptList[J] := ReceiptList[J] + Receipt[I]
     else
      if Receipt[I] = #13 then
         begin
          ReceiptList.Add('');
          J := J + 1;
         end;
  end;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 DataForm.SetBlackFontA;
 for I := 0 to ReceiptList.Count - 1 do
  begin
   TempStr := ReceiptList[I];
   TempStr := Format('%' + IntToStr((40 - Length(TempStr)) div 2) + 's%s', ['', TempStr]);
   DataForm.OutPutToPrinter(TempStr);
  end;
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TVIPAccountForm.EFTPrintReceiptEvent(Sender: TObject; const ReceiptType: WideString);
begin
 if ReceiptType[1] <> 'R' then
    ReceiptFlag := ReceiptType[1]
   else
    if ReceiptFlag = 'M' then
       PrintMerthantReceiptPro(DataForm.EFTPOS.Receipt);
end;

procedure TVIPAccountForm.EFTGetLastTransactionEvent(Sender: TObject);
begin
 if DataForm.EFTPOS.Success then
    ReferenceNo := StrToIntDef(DataForm.EFTPOS.TxnRef, 0);
end;

procedure TVIPAccountForm.FormShow(Sender: TObject);
begin
 Width := TitlePanel.Width + 28;
 Height := DetailPanel.Top + DetailPanel.Height + 44;
 DateTimeEdit.Caption := FormatDateTime('dd/mm/yyyy hh:mm', Date + Time);
 ReadVIPInformation;
 GetOrderDetail;
 PayAmountEdit.Caption := Format('%4.2f', [DueAmount]);
 MethodEdit.Caption := 'CASH';
 CalcBalance;
 ReturnFlag := False;
 LinkToEFTPOSFlag := False;
 DepositID := 0;
 ReferenceNo := 0;
 if EFTPOSStatus then
    begin
     DataForm.EFTPOS.OnTransactionEvent := EFTTransactionEvent;
     DataForm.EFTPOS.OnPrintReceiptEvent := EFTPrintReceiptEvent;
     DataForm.EFTPOS.OnGetLastTransactionEvent := EFTGetLastTransactionEvent;
     DataForm.EFTPOS.ReceiptAutoPrint := False;
     DataForm.EFTPOS.CutReceipt := False;
     if DataForm.EFTPOS.Installed then DataForm.EFTPOS.DoGetLastTransaction;
    end;
end;

function TVIPAccountForm.VIPAccountPro(VIPNo: string): boolean;
begin
 Application.CreateForm(TVIPAccountForm, VIPAccountForm);
 VIPAccountForm.VIPNo := VIPNo;
 VIPAccountForm.ShowModal;
 Result := VIPAccountForm.ReturnFlag;
 VIPAccountForm.Free;
end;

procedure TVIPAccountForm.AutoPayBtnClick(Sender: TObject);
var
  i : integer;
  InvAmount, PaidAmount, Remain: double;
begin

  with StringGrid do
  for i := 1 to MaxRow do
    begin
      if Cells[1, i] <> '' then
        begin
          Remain := StrToFloat(RemainLabel.Caption);
          if Cells[3, i] <> '' then
            InvAmount := StrToFloat(Cells[3, i])
          else
            InvAmount := 0;
          if Cells[4, i] <> '' then
            PaidAmount := StrToFloat(Cells[4, i])
            else
            PaidAmount := 0;
          if InvAmount > Remain + PaidAmount then
            PaidAmount := Remain + PaidAmount
            else
            PaidAmount := InvAmount;
          Cells[4, i] := Format('%4.2f', [PaidAmount]);
          CalcBalance;
        end;
   
  end;

end;

end.
