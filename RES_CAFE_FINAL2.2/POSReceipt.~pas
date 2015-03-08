unit POSReceipt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ExtCtrls, UtilUnit, Db, DBTables, ADODB,
  bsSkinCtrls, XiButton;

type
  TPOSReceiptForm = class(TForm)
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    DataPanel2: TPanel;
    Query: TADOQuery;
    BackPanel: TbsSkinPanel;
    TotalPanel: TbsSkinPanel;
    ChangePanel: TbsSkinPanel;
    DataPanel1: TPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    bsSkinStdLabel5: TbsSkinStdLabel;
    BalanceLabel: TbsSkinStdLabel;
    MoneyButton1: TXiButton;
    MoneyButton2: TXiButton;
    MoneyButton3: TXiButton;
    MoneyButton4: TXiButton;
    MoneyButton5: TXiButton;
    Method1: TXiButton;
    Method2: TXiButton;
    Method3: TXiButton;
    Method4: TXiButton;
    Method5: TXiButton;
    OtherMethod: TXiButton;
    Num7: TXiButton;
    Num8: TXiButton;
    Num9: TXiButton;
    PlusButton: TXiButton;
    Num4: TXiButton;
    Num5: TXiButton;
    Num6: TXiButton;
    StubtractButton: TXiButton;
    Num1: TXiButton;
    Num2: TXiButton;
    Num3: TXiButton;
    Decimal: TXiButton;
    Num0: TXiButton;
    ClearButton: TXiButton;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    TotalSalesEdit: TbsSkinLabel;
    ReceivableEdit: TbsSkinLabel;
    RoundingEdit: TbsSkinLabel;
    SurchargeEdit: TbsSkinLabel;
    TipsEdit: TbsSkinLabel;
    ChangeEdit: TbsSkinLabel;
    MethodEdit1: TbsSkinLabel;
    PaymentEdit1: TbsSkinLabel;
    MethodEdit2: TbsSkinLabel;
    PaymentEdit2: TbsSkinLabel;
    TipsButton: TbsSkinSpeedButton;
    PaymentPanel1: TbsSkinPanel;
    PaymentPanel2: TbsSkinPanel;
    DepositPaymentButton: TXiButton;
    procedure OpenQuery;
    procedure ReadPaymentMethodsPro;
    procedure PostToSecondDisplay;
    procedure DisplayNumber;
    function  CalcRounding(CashAmount: double): double;
    procedure InitPayment1;
    procedure InitPayment2;
    procedure CalcPayment1;
    procedure CalcPayment2;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Methods1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EFTTransactionEvent(Sender: TObject);
    procedure EFTPrintReceiptEvent(Sender: TObject; const ReceiptType: WideString);
    procedure EFTGetLastTransactionEvent(Sender: TObject);
    procedure PrintCustomerReceipt;
    procedure PrintMerthantReceiptPro(Receipt: WideString);
    procedure MethodClick(Sender: TObject);
    procedure OtherMethodClick(Sender: TObject);
    procedure MoneyButton1Click(Sender: TObject);
    procedure MoneyButton2Click(Sender: TObject);
    procedure MoneyButton3Click(Sender: TObject);
    procedure MoneyButton4Click(Sender: TObject);
    procedure MoneyButton5Click(Sender: TObject);
    procedure NumClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure StubtractButtonClick(Sender: TObject);
    procedure DecimalClick(Sender: TObject);
    procedure TipsEditClick(Sender: TObject);
    procedure DataPanel1Click(Sender: TObject);
    procedure DataPanel2Click(Sender: TObject);
    procedure PlusButtonClick(Sender: TObject);
    procedure TipsButtonClick(Sender: TObject);
    function  ReceiptPro(TotalSales, Receivable: double;
              var Tips, Payment1, Payment2, Rounding, Surcharge, Change: double;
              var PayBy1, PayBy2: string; var EFTPOSFlag: boolean; VIPNo: integer;
              var DepositID1, DepositID2: integer): boolean;
    //procedure DepositPaymentButtonClick(Sender: TObject);
  private { Private declarations }
    TotalSales, Receivable, Tips, Payment1, Payment2, Rounding1, Rounding2,
    Surcharge1, SurchargeRate1, Surcharge2, SurchargeRate2, Change: double;
    ReturnFlag, LinkToEFTPOSFlag: Boolean;
    ReceiptFlag, NumberStr: string;
    ReferenceNo, VIPNo, DepositID1, DepositID2: integer;
    LinkEFTPOS: array [1..5] of boolean;
    SurchargeRate: array [1..5] of double;
  public
    { Public declarations }
  end;

var
  POSReceiptForm: TPOSReceiptForm;

implementation

uses DataUnit, NumPad, MainMenu, MessageBox, PaymentSelect;

{$R *.DFM}

procedure TPOSReceiptForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select Payment, LinkToEFTPOS, SurchargeRate From Payment ' +
           'Where ShowOnList <> 0 Order By Code';
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

procedure TPOSREceiptForm.ReadPaymentMethodsPro;
var
 I: integer;
begin
 for I := 1 to 5 do
  with TPanel(FindComponent('Method' + IntToStr(I))) do
   begin
    Caption := '';
    LinkEFTPOS[I] := False;
    SurchargeRate[I] := 0;
   end;
 I := 1;
 Query.First;
 while Not Query.EOF and (I <= 5) do
  begin
   with TPanel(FindComponent('Method' + IntToStr(I))) do
    Caption := Uppercase(Query.FieldByName('Payment').AsString);
   LinkEFTPOS[I] := Query.FieldByName('LinkToEFTPOS').AsBoolean;
   SurchargeRate[I] := Query.FieldByName('SurchargeRate').AsFloat;
   I := I + 1;
   Query.Next;
  end;
 Query.Close;
end;

procedure TPOSReceiptForm.PostToSecondDisplay;
var
 S1, S2: string;
begin
 S1 := 'Total:' + Format('%14s', [FormatCurrency(Receivable + Rounding1 + Rounding2)]);
 if Change <= -0.009 then
    S2 := 'Balance:' + Format('%12s', [FormatCurrency(ABS(Change))])
   else
    S2 := 'Change:' + Format('%13s', [FormatCurrency(ABS(Change))]);
 DataForm.SendToPoleDisp(S1, S2);
 if FVar.SecondDisplay = 1 then
    begin
     SecondDisplayForm.MethodLabel1.Caption := MethodEdit1.Caption + ':';
     SecondDisplayForm.PaymentEdit1.Caption := FormatCurrency(Payment1) + ' ';
     if MethodEdit2.Caption <> '' then
       begin
         SecondDisplayForm.MethodLabel2.Caption := MethodEdit2.Caption + ':';
         SecondDisplayForm.MethodLabel2.Visible := True;
         SecondDisplayForm.PaymentEdit2.Caption := FormatCurrency(Payment2) + ' ';
         SecondDisplayForm.PaymentEdit2.Visible := True;
        end
       else
        begin
         SecondDisplayForm.MethodLabel2.Caption := '';
         SecondDisplayForm.MethodLabel2.Visible := False;
         SecondDisplayForm.PaymentEdit2.Caption := '';
         SecondDisplayForm.PaymentEdit2.Visible := False;
        end;
     if ABS(Tips) >= 0.01 then
        begin
         SecondDisplayForm.TipsEdit.Caption := FormatCurrency(Tips) + ' ';
         SecondDisplayForm.TipsEdit.Visible := True;
         SecondDisplayForm.TipsLabel.Visible := True;
        end
       else
        begin
         SecondDisplayForm.TipsEdit.Visible := False;
         SecondDisplayForm.TipsLabel.Visible := False;
        end;
     if ABS(Surcharge1 + Surcharge2) >= 0.01 then
        begin
         SecondDisplayForm.BankChargeEdit.Caption := FormatCurrency(Surcharge1 + Surcharge2) + ' ';
         SecondDisplayForm.BankChargeEdit.Visible := True;
         SecondDisplayForm.BankChargeLabel.Visible := True;
        end
       else
        begin
         SecondDisplayForm.BankChargeEdit.Visible := False;
         SecondDisplayForm.BankChargeLabel.Visible := False;
        end;
     if ABS(Rounding1 + Rounding2) >= 0.01 then
        begin
         SecondDisplayForm.RoundingEdit.Caption := FormatCurrency(ABS(Rounding1 + Rounding2)) + ' ';
         SecondDisplayForm.RoundingEdit.Visible := True;
         SecondDisplayForm.RoundingLabel.Visible := True;
        end
       else
        begin
         SecondDisplayForm.RoundingEdit.Visible := False;
         SecondDisplayForm.RoundingLabel.Visible := False;
        end;
     if Change <= -0.009 then
        SecondDisplayForm.ChangeLabel.Caption := 'Balance:'
       else
        SecondDisplayForm.ChangeLabel.Caption := 'Change:';
     SecondDisplayForm.ChangeEdit.Caption := FormatCurrency(ABS(Change)) + ' ';
    end;
end;

procedure TPOSReceiptForm.DisplayNumber;
begin
 if DataPanel2.Color = $00FFFF80 then
    PaymentEdit2.Caption := Format('%4.2f ', [StrToFloat(NumberStr)])
   else
    PaymentEdit1.Caption := Format('%4.2f ', [StrToFloat(NumberStr)]);
end;

function TPOSReceiptForm.CalcRounding(CashAmount: double): double;
var
 RoundFlag: integer;
 Temp, Ch: string;
 Rounding: double;
begin
 Temp := Format('%4.2f', [CashAmount]);
 Ch := Temp[Length(Temp)];
 RoundFlag := StrToInt(Ch);
 Rounding := 0;
 if RoundingFlag = 0 then
    begin
     RoundFlag := StrToInt(Ch);
     Case ABS(RoundFlag) of
      0, 5: Rounding := 0;
      1, 6: Rounding := -0.01;
      2, 7: Rounding := -0.02;
      3, 8: Rounding := 0.02;
      4, 9: Rounding := 0.01;
     end
    end
   else
    if RoundingFlag = 1 then
       begin
        if ABS(RoundFlag) <= 4 then
           Rounding := -ABS(RoundFlag)/100
          else
           Rounding := (10 - ABS(RoundFlag)) / 100;
       end;
 if CashAmount < 0 then Rounding := 0 - Rounding;
 if ABS(Rounding) < 0.005 then Rounding := 0;
 Result := Rounding;
end;

procedure TPOSReceiptForm.InitPayment1;
begin
 TotalSalesEdit.Caption := Format('%4.2f ', [TotalSales]);
 ReceivableEdit.Caption := Format('%4.2f ', [Receivable]);
 if TipsEdit.Caption <> '' then
    Tips := StrToFloat(TipsEdit.Caption)
   else
    Tips := 0;
 if MethodEdit1.Caption = 'CASH' then
    begin
     Rounding1 := CalcRounding(Receivable + Tips);
     Surcharge1 := 0;
     SurchargeRate1 := 0;
     Payment1 := Receivable + Tips + Rounding1;
    end
   else
    begin
     Rounding1 := 0;
     Surcharge1 := RoundToCurrency(Receivable * SurchargeRate1 / 100);
     Payment1 := Receivable + Tips + Rounding1 + Surcharge1;
    end;
 DataPanel1.Color := $00FFFF80;
 DataPanel2.Color := $00EAD2BF;
 MethodEdit2.Caption := '';
 PaymentEdit2.Caption := '';
 Payment2 := 0;
 Surcharge2 := 0;
 SurchargeRate2 := 0;
 Rounding2 := 0;
 DepositID1 := 0;
 DepositID2 := 0;
 NumberStr := '0';
 Change := Payment1 + Payment2 - Tips - Receivable - Rounding1 - Rounding2 - Surcharge1 - Surcharge2;
 if Change <= -0.009 then
    BalanceLabel.Caption := 'Balance'
   else
    BalanceLabel.Caption := 'Change';
 RoundingEdit.Caption := Format('%4.2f ', [Rounding1 + Rounding2]);
 SurchargeEdit.Caption := Format('%4.2f ', [Surcharge1 + Surcharge2]);
 PaymentEdit1.Caption := Format('%4.2f ', [Payment1]);
 PaymentEdit2.Caption := Format('%4.2f ', [Payment2]);
 ChangeEdit.Caption := Format('%4.2f ', [ABS(Change)]);
 PostToSecondDisplay;
end;

procedure TPOSReceiptForm.InitPayment2;
begin
 if MethodEdit2.Caption = '' then MethodEdit2.Caption := 'CASH';
 if MethodEdit2.Caption = 'CASH' then
    begin
     Payment2 := Receivable + Surcharge1 + Tips + Rounding1 - Payment1;
     Rounding2 := CalcRounding(Payment2);
     Payment2 := Receivable + Surcharge1 + Tips + Rounding1 + Rounding2 - Payment1;
     Surcharge2 := 0;
     SurchargeRate2 := 0;
    end
   else
    begin
     Rounding2 := 0;
     Surcharge2 := RoundToCurrency((Receivable + Surcharge1 - Payment1) * SurchargeRate2 / 100);
     Payment2 := Receivable + Surcharge1 + Surcharge2 + Tips + Rounding1 - Payment1;
    end;
 NumberStr := '0';
 DataPanel2.Color := $00FFFF80;
 DataPanel1.Color := $00EAD2BF;
 Change := Payment1 + Payment2 - Tips - Receivable - Rounding1 - Rounding2 - Surcharge1 - Surcharge2;
 if Change <= -0.009 then
    BalanceLabel.Caption := 'Balance'
   else
    BalanceLabel.Caption := 'Change';
 RoundingEdit.Caption := Format('%4.2f ', [Rounding1 + Rounding2]);
 SurchargeEdit.Caption := Format('%4.2f ', [Surcharge1 + Surcharge2]);
 PaymentEdit1.Caption := Format('%4.2f ', [Payment1]);
 PaymentEdit2.Caption := Format('%4.2f ', [Payment2]);
 ChangeEdit.Caption := Format('%4.2f ', [ABS(Change)]);
 PostToSecondDisplay;
end;

procedure TPOSReceiptForm.CalcPayment1;
begin
 if PaymentEdit1.Caption <> '' then
    Payment1 := StrToFloat(PaymentEdit1.Caption)
   else
    Payment1 := 0;
 if MethodEdit1.Caption <> 'CASH' then
    begin
     Rounding1 := 0;
     Surcharge1 := RoundToCurrency(Receivable * SurchargeRate1 / 100);
     if (Payment1 > Receivable + Surcharge1 + Tips) then
         Payment1 := Receivable + Tips + Surcharge1
        else
         Surcharge1 := RoundToCurrency(Payment1 * SurchargeRate1 / 100);
    end
   else
    begin
     Surcharge1 := 0; SurchargeRate1 := 0;
     Rounding1 := CalcRounding(Receivable + Tips);
    end;
 Rounding2 := 0;
 MethodEdit2.Caption := '';
 PaymentEdit2.Caption := '';
 Payment2 := 0;
 Surcharge2 := 0;
 SurchargeRate2 := 0;
 DataPanel1.Color := $00FFFF80;
 DataPanel2.Color := $00EAD2BF;
 Change := Payment1 + Payment2 - Tips - Receivable - Rounding1 - Rounding2 - Surcharge1 - Surcharge2;
 if Change <= -0.009 then
    BalanceLabel.Caption := 'Balance'
   else
    BalanceLabel.Caption := 'Change';
 RoundingEdit.Caption := Format('%4.2f ', [Rounding1 + Rounding2]);
 SurchargeEdit.Caption := Format('%4.2f ', [Surcharge1 + Surcharge2]);
 PaymentEdit1.Caption := Format('%4.2f ', [Payment1]);
 PaymentEdit2.Caption := Format('%4.2f ', [Payment2]);
 ChangeEdit.Caption := Format('%4.2f ', [ABS(Change)]);
 PostToSecondDisplay;
end;

procedure TPOSReceiptForm.CalcPayment2;
begin
 if PaymentEdit2.Caption <> '' then
    Payment2 := StrToFloat(PaymentEdit2.Caption)
   else
    Payment2 := 0;
 if MethodEdit2.Caption = 'CASH' then
    begin
     Rounding2 := CalcRounding(Payment2);
     Surcharge2 := 0; SurchargeRate2 := 0;
    end
   else
    begin
     Rounding2 := 0;
     Surcharge2 := RoundToCurrency((Receivable + Surcharge1 - Payment1) * SurchargeRate2 / 100);
     Payment2 := Receivable + Surcharge1 + Surcharge2 + Tips + Rounding1 - Payment1;
    end;
 DataPanel2.Color := $00FFFF80;
 DataPanel1.Color := $00EAD2BF;
 Change := Payment1 + Payment2 - Tips - Receivable - Rounding1 - Rounding2 - Surcharge1 - Surcharge2;
 if Change <= -0.009 then
    BalanceLabel.Caption := 'Balance'
   else
    BalanceLabel.Caption := 'Change';
 RoundingEdit.Caption := Format('%4.2f ', [Rounding1 + Rounding2]);
 SurchargeEdit.Caption := Format('%4.2f ', [Surcharge1 + Surcharge2]);
 PaymentEdit1.Caption := Format('%4.2f ', [Payment1]);
 PaymentEdit2.Caption := Format('%4.2f ', [Payment2]);
 ChangeEdit.Caption := Format('%4.2f ', [ABS(Change)]);
 PostToSecondDisplay;
end;

procedure TPOSReceiptForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
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

procedure TPOSReceiptForm.CancelButtonClick(Sender: TObject);
begin
 if FVar.SecondDisplay = 1 then SecondDisplayForm.SetSalesStatus;
 ReturnFlag := False;
 Close;
end;

procedure TPOSReceiptForm.ConfirmButtonClick(Sender: TObject);
begin
 if Change <= -0.009 then
    begin
     if VIPNo = 0 then
        begin
         MessageBoxForm.MessagePro('Payment is not balance!', sErrorMsg);
         PaymentEdit1.SetFocus;
         Exit;
        end
       else
        if MessageBoxForm.MessagePro('Payment is not balance.' + Chr(13) + Chr(10) + Chr(13) + Chr(10) +
           'Do you want to put the balance to account payment', sConfirmMsg) = mrNo then
           begin
            PaymentEdit1.SetFocus;
            Exit;
           end;
    end;
 if LinkToEFTPOSFlag then
    begin
     if ABS(Payment1) < 0.01 then
        MessageBoxForm.MessagePro('EFTPOS Payment can not be Zero!', sErrorMsg)
       else
        begin
         ConfirmButton.Enabled := False;
         CancelButton.Enabled := False;
         if Payment1 > 0 then
            DataForm.EFTPOS.TxnType := 'P'
           else
            DataForm.EFTPOS.TxnType := 'R';
         DataForm.EFTPOS.EnableTip := False;
         DataForm.EFTPOS.AmtTip := 0;
         DataForm.EFTPOS.AmtCash := 0;
         DataForm.EFTPOS.AmtPurchase := ABS(Payment1);
         DataForm.EFTPOS.ReceiptAutoPrint := False;
         DataForm.EFTPOS.CutReceipt := False;
         DataForm.EFTPOS.TxnRef := IntToStr(ReferenceNo + 1);
         DataForm.EFTPOS.DoTransaction();
        end;
    end
   else
    begin
     ReturnFlag := True;
     Close;
    end;
end;

procedure TPOSReceiptForm.EFTTransactionEvent(Sender: TObject);
begin
 if DataForm.EFTPOS.Success then
    begin
     if UpperCase(DataForm.EFTPOS.AccountType) = 'SAVINGS' then
        MethodEdit1.Caption := UpperCase(DataForm.EFTPOS.AccountType)
       else
        MethodEdit1.Caption := UpperCase(DataForm.EFTPOS.CardType);
     PrintCustomerReceipt;
     ReturnFlag := True;
     Close;
     Application.ProcessMessages;
    end
   else
    begin
     ReturnFlag := False;
     ConfirmButton.Enabled := True;
     CancelButton.Enabled := True;
    end;
end;

procedure TPOSReceiptForm.PrintCustomerReceipt;
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

procedure TPOSReceiptForm.PrintMerthantReceiptPro(Receipt: WideString);
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

procedure TPOSReceiptForm.EFTPrintReceiptEvent(Sender: TObject; const ReceiptType: WideString);
begin
 if ReceiptType[1] <> 'R' then
    ReceiptFlag := ReceiptType[1]
   else
    if ReceiptFlag = 'M' then
       PrintMerthantReceiptPro(DataForm.EFTPOS.Receipt);
end;

procedure TPOSReceiptForm.Methods1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PaymentEdit1.SetFocus;
end;

procedure TPOSReceiptForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TPOSReceiptForm.EFTGetLastTransactionEvent(Sender: TObject);
begin
 if DataForm.EFTPOS.Success then
    ReferenceNo := StrToIntDef(DataForm.EFTPOS.TxnRef, 0);
end;

procedure TPOSReceiptForm.MethodClick(Sender: TObject);
var
 Temp: string;
begin
 with Sender As TXiButton do
  if Caption <> '' then
     begin
      Temp := Copy(Name, 7, 1);
      if LinkEFTPOS[StrToInt(Temp)] and (Not EFTPOSStatus or Not DataForm.EFTPOS.Installed) then
         MessageBoxForm.MessagePro('EFTPOS machine has not been connected.', sERRORMsg)
        else
         begin
          if DataPanel1.Color = $00FFFF80 then
             begin
              MethodEdit1.Caption := Caption;
              LinkToEFTPOSFlag := LinkEFTPOS[StrToInt(Temp)];
              SurchargeRate1 := SurchargeRate[StrToInt(Temp)];
              InitPayment1;
              DepositID1 := 0;
             end
            else
             begin
              if LinkEFTPOS[StrToInt(Temp)] then
                 MessageBoxForm.MessagePro('Can not use EFTPOS do second payment.', sERRORMsg)
                else
                 begin
                  MethodEdit2.Caption := Caption;
                  SurchargeRate2 := SurchargeRate[StrToInt(Temp)];
                  InitPayment2;
                  DepositID2 := 0;
                 end;
             end;
         end;
     end;
    //ConfirmButtonClick(sender);
end;

{procedure TPOSReceiptForm.DepositPaymentButtonClick(Sender: TObject);
var
 DepositBalance, Remain: double;
 DepositID: integer;
begin
 if DepositPaymentForm.DepositPaymentPro(VIPNo, DepositBalance, DepositID) then
    begin
     if DataPanel1.Color = $00FFFF80 then
        begin
         LinkToEFTPOSFlag := False;
         SurchargeRate1 := 0;
         DepositID1 := DepositID;
         MethodEdit1.Caption := 'Deposit';
         Rounding1 := 0;
         if DepositBalance >= Receivable then
            PaymentEdit1.Caption := Format('%4.2f ', [Receivable])
           else
            PaymentEdit1.Caption := Format('%4.2f ', [DepositBalance]);
         CalcPayment1;
        end
       else
        begin
         if DepositID = DepositID1 then
            MessageBoxForm.MessagePro('Can not use this deposit to do the payment.', sERRORMsg)
           else
            begin
             SurchargeRate2 := 0;
             DepositID2 := DepositID;
             MethodEdit2.Caption := 'Deposit';
             Rounding2 := 0;
             Remain := Receivable + Rounding1 + Surcharge1 + Tips - Payment1;
             if DepositBalance >= Remain then
                PaymentEdit2.Caption := Format('%4.2f ', [Remain])
               else
                PaymentEdit2.Caption := Format('%4.2f ', [DepositBalance]);
             CalcPayment2;
            end;
        end;
    end;
end;}

procedure TPOSReceiptForm.OtherMethodClick(Sender: TObject);
var
 PaymentMethod: string;
 LinkToEFTPOS: boolean;
 BankChargeRate: double;
begin
 if PaymentSelectForm.PaymentSelectPro(PaymentMethod, BankChargeRate, LinkToEFTPOS) then
    begin
     if LinkToEFTPOS and (Not EFTPOSStatus or Not DataForm.EFTPOS.Installed) then
        MessageBoxForm.MessagePro('EFTPOS machine has not been connected.', sERRORMsg)
       else
        begin
         if DataPanel1.Color = $00FFFF80 then
            begin
             MethodEdit1.Caption := PaymentMethod;
             LinkToEFTPOSFlag := LinkToEFTPOS;
             SurchargeRate1 := BankChargeRate;
             InitPayment1;
             DepositID1 := 0;
            end
           else
            begin
             if LinkToEFTPOS then
                MessageBoxForm.MessagePro('Can not use EFTPOS do second payment.', sERRORMsg)
               else
                begin
                 MethodEdit2.Caption := PaymentMethod;
                 SurchargeRate2 := BankChargeRate;
                 InitPayment2;
                 DepositID2 := 0;
                end;
             end;
        end;
    end;
end;

procedure TPOSReceiptForm.MoneyButton1Click(Sender: TObject);
begin
 if ((DataPanel1.Color = $00FFFF80) and (DepositID1 <> 0)) or
    ((DataPanel2.Color = $00FFFF80) and (DepositID2 <> 0)) then Exit;
 if (Length(NumberStr) < 16) then
    begin
     if NumberStr <> '0' then
        NumberStr := FloatToStr(StrToFloat(NumberStr) + 5)
       else
        NumberStr := '5';
    end;
 DisplayNumber;
 if (DataPanel2.Color = $00FFFF80) then
    CalcPayment2
   else
    CalcPayment1;
end;

procedure TPOSReceiptForm.MoneyButton2Click(Sender: TObject);
begin
 if ((DataPanel1.Color = $00FFFF80) and (DepositID1 <> 0)) or
    ((DataPanel2.Color = $00FFFF80) and (DepositID2 <> 0)) then Exit;
 if (Length(NumberStr) < 16) then
    begin
     if NumberStr <> '0' then
        NumberStr := FloatToStr(StrToFloat(NumberStr) + 10)
       else
        NumberStr := '10';
    end;
 DisplayNumber;
 if (DataPanel2.Color = $00FFFF80) then
    CalcPayment2
   else
    CalcPayment1;
end;

procedure TPOSReceiptForm.MoneyButton3Click(Sender: TObject);
begin
 if ((DataPanel1.Color = $00FFFF80) and (DepositID1 <> 0)) or
    ((DataPanel2.Color = $00FFFF80) and (DepositID2 <> 0)) then Exit;
 if (Length(NumberStr) < 16) then
    begin
     if NumberStr <> '0' then
        NumberStr := FloatToStr(StrToFloat(NumberStr) + 20)
       else
        NumberStr := '20';
    end;
 DisplayNumber;
 if (DataPanel2.Color = $00FFFF80) then
    CalcPayment2
   else
    CalcPayment1;
end;

procedure TPOSReceiptForm.MoneyButton4Click(Sender: TObject);
begin
 if ((DataPanel1.Color = $00FFFF80) and (DepositID1 <> 0)) or
    ((DataPanel2.Color = $00FFFF80) and (DepositID2 <> 0)) then Exit;
 if (Length(NumberStr) < 16) then
    begin
     if NumberStr <> '0' then
        NumberStr := FloatToStr(StrToFloat(NumberStr) + 50)
       else
        NumberStr := '50';
    end;
 DisplayNumber;
 if (DataPanel2.Color = $00FFFF80) then
    CalcPayment2
   else
    CalcPayment1;
end;

procedure TPOSReceiptForm.MoneyButton5Click(Sender: TObject);
begin
 if ((DataPanel1.Color = $00FFFF80) and (DepositID1 <> 0)) or
    ((DataPanel2.Color = $00FFFF80) and (DepositID2 <> 0)) then Exit;
 if (Length(NumberStr) < 16) then
    begin
     if NumberStr <> '0' then
        NumberStr := FloatToStr(StrToFloat(NumberStr) + 100)
       else
        NumberStr := '100';
    end;
 DisplayNumber;
 if (DataPanel2.Color = $00FFFF80) then
    CalcPayment2
   else
    CalcPayment1;
end;

procedure TPOSReceiptForm.NumClick(Sender: TObject);
var
 Temp: string;
begin
 if ((DataPanel1.Color = $00FFFF80) and (DepositID1 <> 0)) or
    ((DataPanel2.Color = $00FFFF80) and (DepositID2 <> 0)) then Exit;
 with Sender As TXiButton do
  Temp := Caption;
 if Length(NumberStr) < 16 then
    begin
     if NumberStr <> '0'  then
        NumberStr := NumberStr + Temp
       else
        NumberStr := Temp;
    end;
 DisplayNumber;
 if (DataPanel2.Color = $00FFFF80) then
    CalcPayment2
   else
    CalcPayment1;
end;

procedure TPOSReceiptForm.ClearButtonClick(Sender: TObject);
begin
 if ((DataPanel1.Color = $00FFFF80) and (DepositID1 <> 0)) or
    ((DataPanel2.Color = $00FFFF80) and (DepositID2 <> 0)) then Exit;
 NumberStr := '0';
 DisplayNumber;
 if (DataPanel2.Color = $00FFFF80) then
    CalcPayment2
   else
    CalcPayment1;
end;

procedure TPOSReceiptForm.StubtractButtonClick(Sender: TObject);
var
 Temp: double;
begin
 if ((DataPanel1.Color = $00FFFF80) and (DepositID1 <> 0)) or
    ((DataPanel2.Color = $00FFFF80) and (DepositID2 <> 0)) then Exit;
 Temp := StrToFloat(NumberStr);
 if Temp > 0 then
    begin
     Temp := 0 - Temp;
     NumberStr := FloatToStr(Temp);
     DisplayNumber;
     if (DataPanel2.Color = $00FFFF80) then
        CalcPayment2
       else
        CalcPayment1;
    end;
end;

procedure TPOSReceiptForm.PlusButtonClick(Sender: TObject);
var
 Temp: double;
begin
 if ((DataPanel1.Color = $00FFFF80) and (DepositID1 <> 0)) or
    ((DataPanel2.Color = $00FFFF80) and (DepositID2 <> 0)) then Exit;
 Temp := StrToFloat(NumberStr);
 if Temp < 0 then
    begin
     Temp := ABS(Temp);
     NumberStr := FloatToStr(Temp);
     DisplayNumber;
     if (DataPanel2.Color = $00FFFF80) then
        CalcPayment2
       else
        CalcPayment1;
    end;
end;

procedure TPOSReceiptForm.DecimalClick(Sender: TObject);
begin
 if ((DataPanel1.Color = $00FFFF80) and (DepositID1 <> 0)) or
    ((DataPanel2.Color = $00FFFF80) and (DepositID2 <> 0)) then Exit;
 if POS('.', NumberStr) = 0 then
    begin
     NumberStr := NumberStr + '.';
     DisplayNumber;
     if (DataPanel2.Color = $00FFFF80) then
        CalcPayment2
       else
        CalcPayment1;
    end;
end;

procedure TPOSReceiptForm.TipsEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := TipsEdit.Caption;
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Tips Amount',  0) then
    begin
     TipsEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
     InitPayment1;
    end;
end;

procedure TPOSReceiptForm.TipsButtonClick(Sender: TObject);
begin
 TipsEditClick(Sender);
end;

procedure TPOSReceiptForm.DataPanel1Click(Sender: TObject);
begin
 MethodEdit1.Caption := 'CASH';
 InitPayment1;
end;

procedure TPOSReceiptForm.DataPanel2Click(Sender: TObject);
begin
 if (MethodEdit1.Caption <> 'CASH') and
    (Payment1 - Receivable - Rounding1 - Rounding2 - Surcharge1 - Tips <= -0.01) then
 InitPayment2;
end;

procedure TPOSReceiptForm.FormShow(Sender: TObject);
begin
 BackPanel.Width := 572;
 BackPanel.Height := 761;
 BackPanel.Left := 0;
 BackPanel.Top := 0;
 Width := 572;
 Height := 761;
 Top := (Screen.Height - BackPanel.Height) div 2;
 Left := 1024 - BackPanel.Width + (Screen.Width - 1024) div 2 - 3;
 ReferenceNo := 0;
 if EFTPOSStatus then
    begin
     DataForm.EFTPOS.OnTransactionEvent := EFTTransactionEvent;
     DataForm.EFTPOS.OnPrintReceiptEvent := EFTPrintReceiptEvent;
     DataForm.EFTPOS.OnGetLastTransactionEvent := EFTGetLastTransactionEvent;
     DataForm.EFTPOS.ReceiptAutoPrint := False;
     DataForm.EFTPOS.CutReceipt := False;
    end;
 if EFTPOSStatus and DataForm.EFTPOS.Installed then
    DataForm.EFTPOS.DoGetLastTransaction;
 MethodEdit1.Caption := 'CASH';
 Surcharge1 := 0;
 Surcharge2 := 0;
 SurchargeRate1 := 0;
 SurchargeRate2 := 0;
 DepositID1 := 0;
 DepositID2 := 0;
 LinkToEFTPOSFlag := False;
 MoneyButton1.Caption := sCurrency + '5';
 MoneyButton2.Caption := sCurrency + '10';
 MoneyButton3.Caption := sCurrency + '20';
 MoneyButton4.Caption := sCurrency + '50';
 MoneyButton5.Caption := sCurrency + '100';
 CancelButton.Caption := 'Cancel' + Chr(13) + Chr(10) + 'Payment';
 DepositPaymentButton.Caption := 'Deposit' + Chr(13) + Chr(10) + 'Payment';
 DepositPaymentButton.Enabled := VIPNO >= 1;
 OpenQuery;
 ReadPaymentMethodsPro;
 MethodEdit2.Caption := '';
 if FVar.SecondDisplay = 1 then SecondDisplayForm.SetPaymentStatus;
 InitPayment1;
 MethodEdit1.SetFocus;
end;

function TPOSReceiptForm.ReceiptPro(TotalSales, Receivable: double;
         var Tips, Payment1, Payment2, Rounding, Surcharge, Change: double;
         var PayBy1, PayBy2: string; var EFTPOSFlag: boolean;
         VIPNo: integer; var DepositID1, DepositID2: integer): boolean;
begin
 Application.CreateForm(TPOSReceiptForm, POSReceiptForm);
 POSReceiptForm.TotalSales := TotalSales;
 POSReceiptForm.Receivable := Receivable;
 POSReceiptForm.VIPNo := VIPNo;
 POSReceiptForm.ShowModal;
 Result := POSReceiptForm.ReturnFlag;
 if Result then
    begin
     Tips := POSReceiptForm.Tips;
     Payment1 := POSReceiptForm.Payment1;
     Payment2 := POSReceiptForm.Payment2;
     Rounding := POSReceiptForm.Rounding1 + POSReceiptForm.Rounding2;
     Surcharge := POSReceiptForm.Surcharge1 + POSReceiptForm.Surcharge2;
     Change := POSReceiptForm.Change;
     PayBy1 := POSReceiptForm.MethodEdit1.Caption;
     PayBy2 := POSReceiptForm.MethodEdit2.Caption;
     EFTPOSFlag := POSReceiptForm.LinkToEFTPOSFlag;
     DepositID1 := POSReceiptForm.DepositID1;
     DepositID2 := POSReceiptForm.DepositID2;
    end;
 POSReceiptForm.Free;
end;

end.
