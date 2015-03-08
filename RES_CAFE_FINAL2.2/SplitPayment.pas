unit SplitPayment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ExtCtrls, UtilUnit, bsSkinCtrls,
  BusinessSkinForm, XiButton;

type
  TSplitPaymentForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    TotalPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    bsSkinStdLabel5: TbsSkinStdLabel;
    bsSkinStdLabel6: TbsSkinStdLabel;
    OrderNoEdit: TbsSkinLabel;
    AmountEdit: TbsSkinLabel;
    RoundingEdit: TbsSkinLabel;
    ReceivableEdit: TbsSkinLabel;
    SurchargeEdit: TbsSkinLabel;
    TipsEdit: TbsSkinLabel;
    TipsButton: TbsSkinSpeedButton;
    DataPanel: TbsSkinPanel;
    bsSkinStdLabel7: TbsSkinStdLabel;
    bsSkinStdLabel8: TbsSkinStdLabel;
    PayByEdit: TbsSkinLabel;
    PaymentEdit: TbsSkinLabel;
    MethodButton: TbsSkinSpeedButton;
    PaymentButton: TbsSkinSpeedButton;
    BalancePanel: TbsSkinPanel;
    BalanceLabel: TbsSkinStdLabel;
    ChangeEdit: TbsSkinLabel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure PostToSecondDisplay;
    procedure CalcAmount(CalcPayment: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PayByEditExit(Sender: TObject);
    procedure PayByEditClick(Sender: TObject);
    procedure TipsEditClick(Sender: TObject);
    procedure PaymentEditClick(Sender: TObject);
    procedure EFTTransactionEvent(Sender: TObject);
    procedure EFTPrintReceiptEvent(Sender: TObject; const ReceiptType: WideString);
    procedure EFTGetLastTransactionEvent(Sender: TObject);
    procedure PrintCustomerReceipt;
    procedure PrintMerthantReceiptPro(Receipt: WideString);
    function  SplitpaymentPro(OrderNo: string; Amount: double;
              var PayAmount, Tips, Rounding, Surcharge, Change: double;
              var Payby: string; VIPNo: integer): boolean;
  private { Private declarations }
    TotalSales, Payment, Rounding, Tips, Surcharge, SurchargeRate,
    Change: double;
    ReturnFlag, LinkToEFTPOSFlag: boolean;
    OrderNo, ReceiptFlag: string;
    ReferenceNo, VIPNo: integer;
  public
    { Public declarations }
  end;

var
  SplitPaymentForm: TSplitPaymentForm;

implementation

uses DataUnit, NumPad, PaymentSelect, MainMenu, MessageBox;

{$R *.DFM}

procedure TSplitPaymentForm.PostToSecondDisplay;
begin
 if FVar.SecondDisplay = 1 then
    begin
     SecondDisplayForm.MethodLabel1.Caption := PayByEdit.Caption + ':';
     SecondDisplayForm.PaymentEdit1.Caption := FormatCurrency(Payment) + ' ';
     SecondDisplayForm.MethodLabel2.Caption := '';
     SecondDisplayForm.MethodLabel2.Visible := False;
     SecondDisplayForm.PaymentEdit2.Caption := '';
     SecondDisplayForm.PaymentEdit2.Visible := False;
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
     if ABS(Surcharge) >= 0.01 then
        begin
         SecondDisplayForm.BankChargeEdit.Caption := FormatCurrency(Surcharge) + ' ';
         SecondDisplayForm.BankChargeEdit.Visible := True;
         SecondDisplayForm.BankChargeLabel.Visible := True;
        end
       else
        begin
         SecondDisplayForm.BankChargeEdit.Visible := False;
         SecondDisplayForm.BankChargeLabel.Visible := False;
        end;
     if ABS(Rounding) >= 0.01 then
        begin
         SecondDisplayForm.RoundingEdit.Caption := FormatCurrency(ABS(Rounding)) + ' ';
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

procedure TSplitPaymentForm.CalcAmount(CalcPayment: Boolean);
var
 RoundFlag: integer;
 Temp, Ch, S1, S2: string;
 Receivable: double;
begin
 AmountEdit.Caption := Format('%4.2f ', [TotalSales]);
 Rounding := 0;
 if (PayByEdit.Caption = 'CASH') and (RoundingFlag <= 1) then
    begin
     Temp := Format('%4.2f', [TotalSales]);
     Ch := Temp[Length(Temp)];
     RoundFlag := StrToInt(Ch);
     if RoundingFlag = 0 then
        Case ABS(RoundFlag) of
         0, 5: Rounding := 0;
         1, 6: Rounding := -0.01;
         2, 7: Rounding := -0.02;
         3, 8: Rounding := 0.02;
         4, 9: Rounding := 0.01;
        end
       else
        begin
         if ABS(RoundFlag) <= 4 then
            Rounding := -ABS(RoundFlag)/100
           else
            Rounding := (10 - ABS(RoundFlag)) / 100;
        end;
     if TotalSales < 0 then Rounding := 0 - Rounding;
    end;
 Receivable := TotalSales + Rounding;
 if TipsEdit.Caption <> '' then
    Tips := StrToFloat(TipsEdit.Caption)
   else
    Tips := 0;
 if CalcPayment then
    begin
     Surcharge := StrToFloat(Format('%4.2f', [(Receivable + Tips) * SurchargeRate / 100]));
     if PaybyEdit.Caption = 'CASH' then
        Payment := Receivable + Tips
       else
        Payment := Receivable + Tips + Surcharge;
    end
   else
    begin
     if PaymentEdit.Caption <> '' then
        begin
         Payment := StrToFloat(PaymentEdit.Caption);
         Surcharge := StrToFloat(Format('%4.2f', [Payment * SurchargeRate / 100]));
        end
       else
        begin
         Payment := 0;
         Surcharge := 0;
        end;
    end;
 Change := Payment - Receivable - Tips - Surcharge;
 if Change <= -0.009 then
    BalanceLabel.Caption := 'Balance'
   else
    BalanceLabel.Caption := 'Change';
 RoundingEdit.Caption := Format('%4.2f ', [Rounding]);
 ReceivableEdit.Caption := Format('%12.2f ', [Receivable]);
 SurchargeEdit.Caption := Format('%4.2f ', [Surcharge]);
 PaymentEdit.Caption := Format('%4.2f ', [Payment]);
 ChangeEdit.Caption := Format('%4.2f ', [Change]);
 S1 := 'Total:' + Format('%14s', [FormatCurrency(Receivable + Tips + Surcharge)]);
 S2 := 'Change:' + Format('%13s', [FormatCurrency(Change)]);
 DataForm.SendToPoleDisp(S1, S2);
 PostToSecondDisplay;
end;

procedure TSplitPaymentForm.PayByEditExit(Sender: TObject);
begin
 CalcAmount(True)
end;

procedure TSplitPaymentForm.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TSplitPaymentForm.EFTGetLastTransactionEvent(Sender: TObject);
begin
 if DataForm.EFTPOS.Success then
    ReferenceNo := StrToIntDef(DataForm.EFTPOS.TxnRef, 0);
end;

procedure TSplitPaymentForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TSplitPaymentForm.CancelButtonClick(Sender: TObject);
begin
 if FVar.SecondDisplay = 1 then SecondDisplayForm.SetSalesStatus;
 ReturnFlag := False;
 Close;
end;

procedure TSplitPaymentForm.ConfirmButtonClick(Sender: TObject);
begin
 if StrToFloat(ChangeEdit.Caption) < 0 then
    begin
     MessageBoxForm.MessagePro('Payment is not balance!', sErrorMsg);
     PaymentEdit.SetFocus;
     Exit;
    end
   else
    if LinkToEFTPOSFlag then
       begin
        if ABS(Payment) < 0.01 then
           MessageBoxForm.MessagePro('EFTPOS Payment can not be Zero!', sErrorMsg)
          else
           begin
            ConfirmButton.Enabled := False;
            CancelButton.Enabled := False;
            if Payment > 0 then
               DataForm.EFTPOS.TxnType := 'P'
              else
               DataForm.EFTPOS.TxnType := 'R';
            DataForm.EFTPOS.EnableTip := False;
            DataForm.EFTPOS.AmtTip := 0;
            DataForm.EFTPOS.AmtCash := 0;
            DataForm.EFTPOS.AmtPurchase := ABS(Payment);
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

procedure TSplitPaymentForm.PayByEditClick(Sender: TObject);
var
 PaymentMethod: string;
begin
 if PaymentSelectForm.PaymentSelectPro(PaymentMethod, SurchargeRate, LinkToEFTPOSFlag) then
    begin
     if LinkToEFTPOSFlag and (Not EFTPOSStatus or Not DataForm.EFTPOS.Installed) then
        begin
         LinkToEFTPOSFlag := False;
         MessageBoxForm.MessagePro('EFTPOS machine has not been connected.', sERRORMsg)
        end
       else
        begin
         PayByEdit.Caption := PaymentMethod;
         CalcAmount(True);
        end;
    end;
end;

procedure TSplitPaymentForm.TipsEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := TipsEdit.Caption;
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Tips Amount', 0) then
    begin
     TipsEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
     CalcAmount(True);
    end;
end;

procedure TSplitPaymentForm.PaymentEditClick(Sender: TObject);
var
 NumStr: string;
 Receivable: double;
begin
 NumStr := ReceivableEdit.Caption;
 Receivable := StrToFloat(ReceivableEdit.Caption);
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Payment Amount', Receivable) then
    begin
     PaymentEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
     CalcAmount(False);
    end;
end;

procedure TSplitPaymentForm.EFTTransactionEvent(Sender: TObject);
begin
 if DataForm.EFTPOS.Success then
    begin
     if UpperCase(DataForm.EFTPOS.AccountType) = 'SAVINGS' then
        PayByEdit.Caption := UpperCase(DataForm.EFTPOS.AccountType)
       else
        PayByEdit.Caption := UpperCase(DataForm.EFTPOS.CardType);
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

procedure TSplitPaymentForm.PrintCustomerReceipt;
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

procedure TSplitPaymentForm.PrintMerthantReceiptPro(Receipt: WideString);
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

procedure TSplitPaymentForm.EFTPrintReceiptEvent(Sender: TObject; const ReceiptType: WideString);
begin
 if ReceiptType[1] <> 'R' then
    ReceiptFlag := ReceiptType[1]
   else
    if ReceiptFlag = 'M' then
       PrintMerthantReceiptPro(DataForm.EFTPOS.Receipt);
end;

procedure TSplitPaymentForm.FormShow(Sender: TObject);
begin
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
 if FVar.SecondDisplay = 1 then SecondDisplayForm.SetPaymentStatus;
 OrderNoEdit.Caption := OrderNo;
 PayByEdit.Caption := 'CASH';
 SurchargeRate := 0;
 CalcAmount(True);
 PaybyEdit.SetFocus;
end;

function TSplitPaymentForm.SplitPaymentPro(OrderNo: string; Amount: double;
          var PayAmount, Tips, Rounding, Surcharge, Change: double;
          var Payby: string; VIPNo: integer): boolean;
begin
 Application.CreateForm(TSplitPaymentForm, SplitPaymentForm);
 SplitPaymentForm.OrderNo := OrderNo;
 SplitPaymentForm.TotalSales := Amount;
 SplitPaymentForm.VIPNo := VIPNo;
 SplitPaymentForm.ShowModal;
 Result := SplitPaymentForm.ReturnFlag;
 if Result then
    begin
     PayAmount := SplitPaymentForm.Payment;
     Tips := SplitPaymentForm.Tips;
     Rounding := SplitPaymentForm.Rounding;
     Surcharge := SplitPaymentForm.Surcharge;
     Payby := SplitPaymentForm.PayByEdit.Caption;
     Change := SplitPaymentForm.Change;
    end;
 SplitPaymentForm.Free;
end;

end.
