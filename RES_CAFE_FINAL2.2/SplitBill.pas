unit SplitBill;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, Grids, Db, DataUnit, UtilUnit, ADODB,
  bsSkinCtrls, XiButton;

type
  TSplitBillForm = class(TForm)
    SourceStringGrid: TStringGrid;
    TargetStringGrid: TStringGrid;
    Query: TADOQuery;
    BackPanel: TbsSkinPanel;
    SourceStringGridPanel: TbsSkinPanel;
    TargetStringGridPanel: TbsSkinPanel;
    OneMoveToRightButton: TXiButton;
    AllMoveToRightButton: TXiButton;
    QtyMoveToRightbutton: TXiButton;
    SplitButton: TXiButton;
    OneMoveToLeftButton: TXiButton;
    AllMoveToLeftButton: TXiButton;
    TotalPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    SourceUpButton: TXiButton;
    DownButton: TXiButton;
    ConvertButton: TXiButton;
    PrintInvoiceButton: TXiButton;
    PrintOrderButton: TXiButton;
    PaymentButton: TXiButton;
    ExitButton: TXiButton;
    TargetUpButton: TXiButton;
    TargetDownButton: TXiButton;
    TotalAmount: TbsSkinLabel;
    SubTotalAmount: TbsSkinLabel;
    procedure PostDataToSecondDisplayPro;
    procedure PostToSecondDisplay;
    procedure InitSourceStringGrid;
    procedure InitTargetStringGrid;
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure OpenQuery(SQLStr: string);
    procedure CalcBillAmount;
    procedure SourceUpButtonClick(Sender: TObject);
    procedure SourceDownButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure DeleteSourceLine(ARow: integer);
    procedure DeleteTargetLine(ARow: integer);
    function  FindSourceLastLine: integer;
    function  FindTargetLastLine: integer;
    procedure PostDataToSourceStringGrid;
    procedure OneMoveToRightButtonClick(Sender: TObject);
    procedure OneMoveToLeftButtonClick(Sender: TObject);
    procedure AllMoveToLeftButtonClick(Sender: TObject);
    procedure AllMoveToRightButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SplitBillPro(OrderNo: string);
    procedure SplitButtonClick(Sender: TObject);
    procedure QtyMoveToRightbuttonClick(Sender: TObject);
    procedure PrintInvoiceButtonClick(Sender: TObject);
    procedure PrintOrderList;
    Procedure PrintInvoice;
    procedure PrintOrderButtonClick(Sender: TObject);
    procedure PaymentButtonClick(Sender: TObject);
    function  FindIDNo: integer;
    function  UpdateItemRecord: boolean;
    procedure ConvertButtonClick(Sender: TObject);
    procedure TargetUpButtonClick(Sender: TObject);
    procedure TargetDownButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    function  CalcTotalInvoice: double;
    function  CalcSubTotal: double;
    procedure FormResize(Sender: TObject);
    procedure SendToSecurityPortPro(OrderNo, PayBy: string; Amount, PayAmount, Tips, Rounding, Surcharge, Change: double);
  private { Private declarations }
    OrderNo: string;
    Langurage: boolean;
    CurrentServiceChargeRate, CurrentOtherChargeRate, CurrentGSTRate,
    Total, SubTotal: double;
    CurrentPriceIncludesGST: boolean;
    VIPNo: integer;
  public
    { Public declarations }
  end;

var
  SplitBillForm: TSplitBillForm;

implementation

uses NumPad, SplitPayment, MessageBox, DispPayment, MainMenu;

{$R *.DFM}

procedure TSplitBillForm.PostDataToSecondDisplayPro;
var
 I: integer;
begin
 SecondDisplayForm.InitForm;
 for I := 1 to 500 do
  begin
   if (TargetStringGrid.Cells[1, I] <> '') and (TargetStringGrid.Cells[0, I] <> '____________') then
      begin
       SecondDisplayForm.StringGrid.Cells[0, I] := TargetStringGrid.Cells[1, I];
       SecondDisplayForm.StringGrid.Cells[1, I] := TargetStringGrid.Cells[0, I];
       SecondDisplayForm.StringGrid.Cells[2, I] := TargetStringGrid.Cells[4, I];
       SecondDisplayForm.StringGrid.Cells[3, I] := TargetStringGrid.Cells[2, I];
      end;
  end;
end;

procedure TSplitBillForm.PostToSecondDisplay;
var
 S1, S2: string;
begin
 S1 := 'Total:' + Format('%14s', [FormatCurrency(SubTotal)]);
 S2 := 'Balance:' + Format('%12s', [FormatCurrency(SubTotal)]);
 DataForm.SendToPoleDisp(S1, S2);
 if FVar.SecondDisplay = 1 then
    begin
     SecondDisplayForm.TotalSalesEdit.Caption := FormatCurrency(SubTotal) + ' ';
     SecondDisplayForm.ReceivableEdit.Caption := FormatCurrency(SubTotal) + ' ';
    end;
end;

procedure TSplitBillForm.InitSourceStringGrid;
var
 I: integer;
begin
 with SourceStringGrid do
  begin
   Cells[0, 0] := 'Qty';
   Cells[1, 0] := 'Description';
   Cells[2, 0] := 'Price';
   Cells[3, 0] := 'Seat';
   Cells[4, 0] := 'UnitPrice';
   Cells[5, 0] := 'Discount';
   Cells[6, 0] := 'GST';
   Cells[7, 0] := 'ID';
   Cells[8, 0] := 'Description2';
   for I := 1 to 500 do
    begin
     Cells[0, I] := ''; Cells[1, I] := '';
     Cells[2, I] := ''; Cells[3, I] := '';
     Cells[4, I] := ''; Cells[5, I] := '';
     Cells[6, I] := ''; Cells[7, I] := '';
     Cells[8, I] := '';
    end;
   Row := 1;
  end;
end;

procedure TSplitBillForm.InitTargetStringGrid;
var
 I: integer;
begin
 with TargetStringGrid do
  begin
   Cells[0, 0] := 'Qty';
   Cells[1, 0] := 'Description';
   Cells[2, 0] := 'Price';
   Cells[3, 0] := 'Seat';
   Cells[4, 0] := 'UnitPrice';
   Cells[5, 0] := 'Discount';
   Cells[6, 0] := 'GST';
   Cells[7, 0] := 'ID';
   Cells[8, 0] := 'Description2';
   for I := 1 to 500 do
    begin
     Cells[0, I] := ''; Cells[1, I] := '';
     Cells[2, I] := ''; Cells[3, I] := '';
     Cells[4, I] := ''; Cells[5, I] := '';
     Cells[6, I] := ''; Cells[7, I] := '';
     Cells[8, I] := '';
    end;
   Row := 1;
  end;
end;

procedure TSplitBillForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   Canvas.Font.Size := 10;
   if ARow > 0 then
      begin
       Canvas.Font.Style := [];
       case ACol of
         1: begin
             SetTextAlign(Canvas.Handle, TA_LEFT);
             X := Rect.Left + 2;
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
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TSplitBillForm.OpenQuery(SQLStr: string);
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
  end;
end;

function TSplitBillForm.CalcTotalInvoice: double;
var
 SQLStr: string;
begin
 SQLStr := 'Select Amount, ServiceCharge, OtherCharge, Tips, Surcharge, GST, ' +
           'PriceIncludesGST, PaidAmount From OrderH ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   if FieldByName('PriceIncludesGST').AsBoolean then
      Result := FieldByName('Amount').AsFloat +
                FieldByName('ServiceCharge').AsFloat +
                FieldByName('OtherCharge').AsFloat +
                FieldByName('Tips').AsFloat +
                FieldByName('Surcharge').AsFloat -
                FieldByName('PaidAmount').AsFloat
     else
      Result := FieldByName('Amount').AsFloat +
                FieldByName('ServiceCharge').AsFloat +
                FieldByName('OtherCharge').AsFloat +
                FieldByName('Tips').AsFloat +
                FieldByName('Surcharge').AsFloat +
                FieldByName('GST').AsFloat -
                FieldByName('PaidAmount').AsFloat;
   Close;
  end;
end;

function TSplitBillForm.CalcSubTotal: double;
var
 I: integer;
 Amount, Qty, Price, GSTRate, RealPrice, Discount, DiscountRate, ServiceCharge,
 OtherCharge, GST: double;
begin
 Amount := 0; GST := 0; Discount := 0;
 for I := 1 to 500 do
  with TargetStringGrid do
   if (Cells[2, I] <> '') and (Cells[2, I] <> '____________') then
      begin
       Amount := Amount + StrToFloat(Cells[2, I]);
       if Cells[5, I] <> '' then
          DiscountRate := StrToFloat(Cells[5, I])
         else
          DiscountRate := 0;
       if Cells[6, I] <> '' then
          GSTRate := StrToFloat(Cells[6, I]) / 100
         else
          GSTRate := 0;
       Qty := StrToFloat(Cells[0, I]);
       Price := StrToFloat(Cells[4, I]);
       RealPrice := Price * (1 - DiscountRate);
       Discount := Discount + (Price - RealPrice) * Qty;
       if CurrentPriceIncludesGST then
          GST := GST + RealPrice * Qty * (1 - 1 / (1 + GSTRate))
         else
          GST := GST + RealPrice * Qty * GSTRate;
      end;
 Amount := Amount - Discount;
 ServiceCharge := Amount * CurrentServiceChargeRate / 100;
 ServiceCharge := RoundToCurrency(ServiceCharge);
 OtherCharge := Amount * CurrentOtherChargeRate / 100;
 OtherCharge := RoundToCurrency(OtherCharge);
 if CurrentPriceIncludesGST then
    GST := GST + (ServiceCharge + OtherCharge) * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    GST := GST + (ServiceCharge + OtherCharge) * CurrentGSTRate / 100;
 if (Amount > 0) and (GST <= 0) then GST := 0;
 if CurrentPriceIncludesGST then
    Result := StrToFloat(Format('%4.2f', [Amount + ServiceCharge + OtherCharge]))
   else
    Result := StrToFloat(Format('%4.2f', [Amount + ServiceCharge + OtherCharge + GST])) ;
end;

procedure TSplitBillForm.CalcBillAmount;
var
 SourceRow, TargetRow: integer;
begin
 SourceRow := FindSourceLastLine;
 TargetRow := FindTargetLastLine;
 Total := CalcTotalInvoice;
 if (TargetRow > 1) and (SourceRow > 1) then
    SubTotal := CalcSubTotal
   else
    if (TargetRow > 1) and (SourceRow = 1) then
       SubTotal := Total
   else
    SubTotal := 0;
 TotalAmount.Caption := Format('%4.2f ', [Total - SubTotal]);
 SubTotalAmount.Caption := Format('%4.2f ', [SubTotal]);
end;

procedure TSplitBillForm.SourceUpButtonClick(Sender: TObject);
begin
 BackPanel.SetFocus;
 if SourceStringGrid.Row > 1 then
    SourceStringGrid.Row := SourceStringGrid.Row - 1;
end;

procedure TSplitBillForm.SourceDownButtonClick(Sender: TObject);
var
 LastRow: integer;
begin
 BackPanel.SetFocus;
 LastRow := FindSourceLastLine;
 if SourceStringGrid.Row < LastRow - 1 then
    SourceStringGrid.Row := SourceStringGrid.Row + 1;
end;

procedure TSplitBillForm.TargetUpButtonClick(Sender: TObject);
begin
 BackPanel.SetFocus;
 if TargetStringGrid.Row > 1 then
    TargetStringGrid.Row := TargetStringGrid.Row - 1;
end;

procedure TSplitBillForm.TargetDownButtonClick(Sender: TObject);
var
 LastRow: integer;
begin
 BackPanel.SetFocus;
 LastRow := FindTargetLastLine;
 if TargetStringGrid.Row < LastRow - 1 then
    TargetStringGrid.Row := TargetStringGrid.Row + 1;
end;

procedure TSplitBillForm.ExitButtonClick(Sender: TObject);
begin
 DataForm.OpenPoleDisplayPort;
 DataForm.SendToPoleDisp('NEXT CUSTOMER PLEASE', '');
 if FVar.SecondDisplay = 1 then SecondDisplayForm.SetWaitingStatus;
 Close;
end;

procedure TSplitBillForm.DeleteSourceLine(ARow: integer);
var
 I, J: Integer;
begin
 with SourceStringGrid do
  begin
   for I := ARow to 499 do
    for J := 0 to 8 do
     Cells[J, I] := Cells[J, I + 1];
   for J := 0 to 8 do Cells[J, 50] := '';
  end;
end;

procedure TSplitBillForm.DeleteTargetLine(ARow: integer);
var
 I, J: Integer;
begin
 with TargetStringGrid do
  begin
   for I := ARow to 499 do
    for J := 0 to 8 do
     Cells[J, I] := Cells[J, I + 1];
   for J := 0 to 8 do Cells[J, 99] := '';
  end;
end;

function  TSplitBillForm.FindSourceLastLine: integer;
var
 I, J, K: integer;
begin
 J := 1;
 with SourceStringGrid do
  for I := 1 to 500 do
   begin
    if Cells[0, I] <> '' then
       begin
        if J <> I then
           for K := 0 to 8 do
            Cells[K, J] := Cells[K, I];
        J := J + 1;
       end;
   end;
 if J <= 500 then
    Result := J
   else
    Result := 500;
end;

function  TSplitBillForm.FindTargetLastLine: integer;
var
 I, J, K: integer;
begin
 J := 1;
 with TargetStringGrid do
   for I := 1 to 500 do
    begin
     if Cells[0, I] <> '' then
        begin
         if J <> I then
            for K := 0 to 8 do
             Cells[K, J] := Cells[K, I];
         J := J + 1;
        end;
    end;
 if J <= 500 then
    Result := J
   else
    Result := 500;
end;

procedure TSplitBillForm.PostDataToSourceStringGrid;
var
 I: integer;
 Price, Qty, PaidQty, Discount: double;
 SQLStr: string;
begin
 InitSourceStringGrid;
 InitTargetStringGrid;
 SQLStr := 'Select Qty, PaidQty, OrderI.Price, Description1, ' +
           'Description2, OrderI.TaxRate, OrderI.Discount, Seat, ' +
           'AllowDiscount, IDNo ' +
           'From OrderI, MenuItem ' +
           'Where OrderI.ItemCode = MenuItem.ItemCode and ' +
           '(ABS(Qty-PaidQty)>=0.005 or (PaidQty Is Null)) and OrderNo=' +
            Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           ' and Qty <> 0 and OrderI.Price<>0 Order By IDNo';
 OpenQuery(SQLStr);
 I := 1;
 with SourceStringGrid do
  begin
   Query.First;
   while Not Query.EOF do
    begin
     Qty := Query.FieldByName('Qty').AsFloat;
     PaidQty := Query.FieldByName('PaidQty').AsFloat;
     Price := Query.FieldByName('Price').AsFloat;
     if Query.FieldByName('AllowDiscount').AsBoolean then
        Discount := Query.FieldByName('Discount').AsFloat
       else
        Discount := 0;
     Cells[0, I] := Format('%4.2f', [Qty - PaidQty]);
     if Langurage or (Query.FieldByName('Description2').AsString = '') then
        begin
         Cells[1, I] := Query.FieldByName('Description1').AsString;
         Cells[8, I] := Query.FieldByName('Description2').AsString;
        end
       else
        begin
         Cells[8, I] := Query.FieldByName('Description1').AsString;
         Cells[1, I] := Query.FieldByName('Description2').AsString;
        end;
     Cells[2, I] := Format('%4.2f', [(Qty - PaidQty) * Price]);
     Cells[3, I] := Query.FieldByName('Seat').AsString;
     Cells[4, I] := Format('%4.2f', [Price]);
     Cells[5, I] := Format('%4.2f', [Discount / 100]);
     Cells[6, I] := Format('%4.2f', [Query.FieldByName('TaxRate').AsFloat]);
     Cells[7, I] := IntToStr(Query.FieldByName('IDNo').AsInteger);
     Query.Next;
     I := I + 1;
    end;
   Query.Close;
  end;
 SourceStringGrid.Row := 1;
 TargetStringGrid.Row := 1;
 CalcBillAmount;
end;

procedure TSplitBillForm.OneMoveToRightButtonClick(Sender: TObject);
var
 SourceRow, TargetRow, LastRow: integer;
begin
 SourceRow := SourceStringGrid.Row;
 TargetRow := FindTargetLastLine;
 if SourceStringGrid.Cells[0, SourceRow] <> '' then
    begin
     TargetStringGrid.Cells[0, TargetRow] := SourceStringGrid.Cells[0, SourceRow];
     TargetStringGrid.Cells[1, TargetRow] := SourceStringGrid.Cells[1, SourceRow];
     TargetStringGrid.Cells[2, TargetRow] := SourceStringGrid.Cells[2, SourceRow];
     TargetStringGrid.Cells[3, TargetRow] := SourceStringGrid.Cells[3, SourceRow];
     TargetStringGrid.Cells[4, TargetRow] := SourceStringGrid.Cells[4, SourceRow];
     TargetStringGrid.Cells[5, TargetRow] := SourceStringGrid.Cells[5, SourceRow];
     TargetStringGrid.Cells[6, TargetRow] := SourceStringGrid.Cells[6, SourceRow];
     TargetStringGrid.Cells[7, TargetRow] := SourceStringGrid.Cells[7, SourceRow];
     TargetStringGrid.Cells[8, TargetRow] := SourceStringGrid.Cells[8, SourceRow];
     DeleteSourceLine(SourceRow);
     TargetStringGrid.Row := TargetRow;
     LastRow := FindSourceLastLine;
     if (SourceRow >= LastRow) then
        begin
         if LastRow > 1 then SourceStringGrid.Row := LastRow - 1
           else
            SourceStringGrid.Row := 1;
        end;
    end;
 CalcBillAmount;
 if FVar.SecondDisplay = 1 then
    begin
     PostDataToSecondDisplayPro;
     PostToSecondDisplay;
    end; 
end;

procedure TSplitBillForm.QtyMoveToRightbuttonClick(Sender: TObject);
var
 SourceRow, TargetRow: integer;
 NumStr: string;
 TotalQty, Qty, TotalPrice, Price, Amount: double;
begin
 SourceRow := SourceStringGrid.Row;
 TargetRow := FindTargetLastLine;
 if SourceStringGrid.Cells[0, SourceRow] <> '' then
    begin
     NumStr := SourceStringGrid.Cells[0, SourceRow];
     if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Item Qty', 0) then
        begin
         Qty := StrToFloat(Format('%4.2f', [StrToFloat(NumStr)]));
         TotalQty := StrToFloat(SourceStringGrid.Cells[0, SourceRow]);
         if (((TotalQty - Qty) >= 0) and (Qty > 0)) or (((TotalQty - Qty) <= 0) and (Qty < 0)) then
            begin
             TotalQty := TotalQty - Qty;
             Price := StrToFloat(SourceStringGrid.Cells[4, SourceRow]);
             TotalPrice := StrToFloat(SourceStringGrid.Cells[2, SourceRow]);
             TargetStringGrid.Cells[0, TargetRow] := Format('%4.2f', [Qty]);
             TargetStringGrid.Cells[1, TargetRow] := SourceStringGrid.Cells[1, SourceRow];
             TargetStringGrid.Cells[2, TargetRow] := Format('%4.2f', [Qty * Price]);
             TargetStringGrid.Cells[3, TargetRow] := SourceStringGrid.Cells[3, SourceRow];
             TargetStringGrid.Cells[4, TargetRow] := SourceStringGrid.Cells[4, SourceRow];
             TargetStringGrid.Cells[5, TargetRow] := SourceStringGrid.Cells[5, SourceRow];
             if Abs(TotalQty) >= 0.01 then
                begin
                 Amount := StrToFloat(Format('%4.2f', [Qty * Price]));
                 SourceStringGrid.Cells[0, SourceRow] := Format('%4.2f', [TotalQty]);
                 SourceStringGrid.Cells[2, SourceRow] := Format('%4.2f', [TotalPrice - Amount]);
                end
               else
                DeleteSourceLine(SourceRow);
             TargetStringGrid.Cells[6, TargetRow] := SourceStringGrid.Cells[6, SourceRow];
             TargetStringGrid.Cells[7, TargetRow] := SourceStringGrid.Cells[7, SourceRow];
             TargetStringGrid.Cells[8, TargetRow] := SourceStringGrid.Cells[8, SourceRow];
             TargetStringGrid.Row := TargetRow;
           end;
        end;
    end;
 CalcBillAmount;
 if FVar.SecondDisplay = 1 then
    begin
     PostDataToSecondDisplayPro;
     PostToSecondDisplay;
    end;
end;

procedure TSplitBillForm.OneMoveToLeftButtonClick(Sender: TObject);
var
 SourceRow, TargetRow, LastRow: integer;
begin
 SourceRow := FindSourceLastLine;
 TargetRow := TargetStringGrid.Row;
 if (TargetStringGrid.Cells[0, TargetRow] <> '') and
    (TargetStringGrid.Cells[0, TargetRow] <> '____________') then
    begin
     SourceStringGrid.Cells[0, SourceRow] := TargetStringGrid.Cells[0, TargetRow];
     SourceStringGrid.Cells[1, SourceRow] := TargetStringGrid.Cells[1, TargetRow];
     SourceStringGrid.Cells[2, SourceRow] := TargetStringGrid.Cells[2, TargetRow];
     SourceStringGrid.Cells[3, SourceRow] := TargetStringGrid.Cells[3, TargetRow];
     SourceStringGrid.Cells[4, SourceRow] := TargetStringGrid.Cells[4, TargetRow];
     SourceStringGrid.Cells[5, SourceRow] := TargetStringGrid.Cells[5, TargetRow];
     SourceStringGrid.Cells[6, SourceRow] := TargetStringGrid.Cells[6, TargetRow];
     SourceStringGrid.Cells[7, SourceRow] := TargetStringGrid.Cells[7, TargetRow];
     SourceStringGrid.Cells[8, SourceRow] := TargetStringGrid.Cells[8, TargetRow];
     SourceStringgrid.Row := SourceRow;
    end;
 DeleteTargetLine(TargetRow);
 LastRow := FindTargetLastLine;
 if TargetRow >= LastRow then
    begin
     if LastRow > 1 then TargetStringGrid.Row := LastRow - 1
       else
        TargetStringGrid.Row := 1;
    end;
 CalcBillAmount;
 if FVar.SecondDisplay = 1 then
    begin
     PostDataToSecondDisplayPro;
     PostToSecondDisplay;
    end;
end;

procedure TSplitBillForm.AllMoveToLeftButtonClick(Sender: TObject);
begin
 PostDataToSourceStringGrid;
 CalcBillAmount;
 if FVar.SecondDisplay = 1 then
    begin
     PostDataToSecondDisplayPro;
     PostToSecondDisplay;
    end;
end;

procedure TSplitBillForm.AllMoveToRightButtonClick(Sender: TObject);
var
 SourceRow, TargetRow: integer;
begin
 SourceRow := 1;
 TargetRow := FindTargetLastLine;
 while SourceRow <= 500 do
  begin
   if SourceStringGrid.Cells[0, SourceRow] <> '' then
      begin
       TargetStringGrid.Cells[0, TargetRow] := SourceStringGrid.Cells[0, SourceRow];
       TargetStringGrid.Cells[1, TargetRow] := SourceStringGrid.Cells[1, SourceRow];
       TargetStringGrid.Cells[2, TargetRow] := SourceStringGrid.Cells[2, SourceRow];
       TargetStringGrid.Cells[3, TargetRow] := SourceStringGrid.Cells[3, SourceRow];
       TargetStringGrid.Cells[4, TargetRow] := SourceStringGrid.Cells[4, SourceRow];
       TargetStringGrid.Cells[5, TargetRow] := SourceStringGrid.Cells[5, SourceRow];
       TargetStringGrid.Cells[6, TargetRow] := SourceStringGrid.Cells[6, SourceRow];
       TargetStringGrid.Cells[7, TargetRow] := SourceStringGrid.Cells[7, SourceRow];
       TargetStringGrid.Cells[8, TargetRow] := SourceStringGrid.Cells[8, SourceRow];
       TargetStringGrid.Row := TargetRow;
       TargetRow := TargetRow + 1;
      end;
   SourceRow := SourceRow + 1;
  end;
 InitSourceStringGrid;
 CalcBillAmount;
 if FVar.SecondDisplay = 1 then
    begin
     PostDataToSecondDisplayPro;
     PostToSecondDisplay;
    end;
end;

procedure TSplitBillForm.SplitButtonClick(Sender: TObject);
var
 TargetRow: integer;
begin
 TargetRow := FindTargetLastLine;
 TargetStringGrid.Cells[0, TargetRow] := '____________';
 TargetStringGrid.Cells[1, TargetRow] := '_______________________________________';
 TargetStringGrid.Cells[2, TargetRow] := '____________';
 TargetStringGrid.Cells[3, TargetRow] := '____________';
 TargetStringGrid.Cells[4, TargetRow] := '';
 TargetStringGrid.Cells[5, TargetRow] := '';
 TargetStringGrid.Cells[6, TargetRow] := '';
 TargetStringGrid.Cells[7, TargetRow] := '';
 TargetStringGrid.Cells[8, TargetRow] := '';
 TargetStringGrid.Row := TargetRow;
 CalcBillAmount;
end;

procedure TSplitBillForm.PrintInvoiceButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 BackPanel.SetFocus;
 if MessageBoxForm.MessagePro('Are you sure you want to print the invoice?', sConfirmMsg) = mrNo then Exit;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := DataForm.SetInvoiceNo(OrderNo);
 finally
  if Flag then
     DataForm.CommitTransaction
    else
     begin
      DataForm.RollBack;
     end;
 end;
 if Flag then PrintInvoice;
end;

procedure TSplitBillForm.PrintOrderList;
var
 TxtFile: TextFile;
 Description, PrintStr, StrTemp, FileName, LineStr, SQLStr: string;
 Amount, Qty, DiscountRate, Price, GST, RealPrice, Discount, SubTotal, SubDiscount,
 TotalAmount, TotalDiscount, SubServiceCharge, TotalServiceCharge,
 SubOtherCharge, TotalOtherCharge, SubGST, TotalGST, TaxRate: double;
 I, CharCount, PaperWidth: integer;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 LineStr := '';
 for I := 1 to PaperWidth do LineStr := LineStr + '-';
 DataForm.SetBlackFontB;
 PrintStr := Format('%' + IntToStr((PaperWidth - 8) div 4) + 's%s', ['', 'BILL']);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(LineStr);
 SQLStr := 'Select OrderDate, OrderNo, TableNo, Persons ' +
           'From OrderH Where OrderNo=' +
           Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OpenQuery(SQLStr);
 if PrintTimeOnInvoice then
    StrTemp := FormatDateTime('dd/mm/yyyy hh:mm:ss', Query.FieldByName('OrderDate').AsDateTime)
   else
    StrTemp := FormatDateTime('dd/mm/yyyy', Query.FieldByName('OrderDate').AsDateTime);
 if PrintBillNo then
    begin
     PrintStr := 'No: ' + OrderNo;
     CharCount := PaperWidth - Length(StrTemp + PrintStr);
     PrintStr := Format('%s%' + IntToStr(CharCount) + 's%s', [StrTemp, '', PrintStr]);
    end
   else
    PrintStr := StrTemp;
 DataForm.OutPutToPrinter(PrintStr);
 if DeleteSpace(Query.FieldByName('TableNo').AsString) <> 'QuickSale' then
    begin
     StrTemp := 'Table No: ' + DeleteSpace(Query.FieldByName('TableNo').AsString);
     PrintStr := 'Peoples: ' + Query.FieldByName('Persons').AsString;
     CharCount := PaperWidth - Length(StrTemp + PrintStr);
     PrintStr := Format('%s%' + IntToStr(CharCount) + 's%s', [StrTemp, '', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 Query.Close;
 DataForm.OutPutToPrinter(LineStr);
 TotalAmount := 0; TotalDiscount := 0; TotalServiceCharge := 0; TotalOtherCharge := 0;
 SubTotal := 0; SubDiscount := 0;
 SubGST := 0; TotalGST := 0;
 with TargetStringGrid do
 for I := 1 to 500 do
  if Cells[0, I] <> '' then
     begin
      if Cells[0, I] = '____________' then
         begin
          if ABS(SubTotal) > 0.01 then
             begin
              SubServiceCharge := (SubTotal - SubDiscount) * CurrentServiceChargeRate / 100;
              SubServiceCharge := RoundToCurrency(SubServiceCharge);
              SubOtherCharge := (SubTotal - SubDiscount) * CurrentOtherChargeRate / 100;
              SubOtherCharge := RoundToCurrency(SubOtherCharge);
              if CurrentPriceIncludesGST then
                 SubGST := SubGST + (SubServiceCharge + SubOtherCharge) * (1 - 1 / (1 + CurrentGSTRate / 100))
                else
                 SubGST := SubGST + (SubServiceCharge + SubOtherCharge) * CurrentGSTRate / 100;
              TotalServiceCharge := TotalServiceCharge + SubServiceCharge;
              TotalOtherCharge := TotalOtherCharge + SubOtherCharge;
              TotalGST := TotalGST + SubGST;
              TotalAmount := TotalAmount + SubTotal;
              TotalDiscount := TotalDiscount + SubDiscount;
              if (ABS(SubServiceCharge) >= 0.01) or (ABS(SubOtherCharge) >= 0.01) or
                 (ABS(SubDiscount) >= 0.01) then
                 begin
                  PrintStr := 'Amount: ' + Format('%8s', [FormatCurrency(SubTotal)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                 end;
              if Abs(SubDiscount) >= 0.01 then
                 begin
                  PrintStr := 'Discount: ' + Format('%8s', [FormatCurrency(SubDiscount)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                 end;
              if Abs(SubServiceCharge) >= 0.01 then
                 begin
                  PrintStr := SurchargeName + ': ' + Format('%8s', [FormatCurrency(SubServiceCharge)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                 end;
              if Abs(SubOtherCharge) >= 0.01 then
                 begin
                  PrintStr := OtherChargeName + ': ' + Format('%8s', [FormatCurrency(SubOtherCharge)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                 end;
              if CurrentPriceIncludesGST then
                 begin
                  PrintStr := 'Sub-Total: ' + Format('%8s',
                   [FormatCurrency(SubTotal + SubServiceCharge + SubOtherCharge - SubDiscount)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                  if ShowTaxOnSalesSection then
                     begin
                      PrintStr := 'GST Included In Total: ' + Format('%8s', [FormatCurrency(SubGST)]);
                      PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                      DataForm.OutPutToPrinter(PrintStr);
                     end;
                 end
                else
                 begin
                  PrintStr := 'G.S.T.: ' + Format('%8s', [FormatCurrency(SubGST)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                  PrintStr := 'Sub-Total: ' + Format('%8s',
                   [FormatCurrency(SubTotal + SubServiceCharge + SubOtherCharge + SubGST - SubDiscount)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                 end;
              DataForm.OutPutToPrinter(LineStr);
             end;
          SubTotal := 0; SubDiscount := 0; SubGST := 0;
         end
        else
         begin
          Description := Cells[1, I];
          StrTemp := Copy(Description, 1, PaperWidth);
          CharCount := PaperWidth;
          PrintStr := Format('%s', [StrTemp]);
          DataForm.OutPutToPrinter(PrintStr);
          while Length(Description) > CharCount do
           begin
            StrTemp := Copy(Description, CharCount + 1, PaperWidth);
            CharCount := CharCount + PaperWidth;
            PrintStr := Format('%s', [StrTemp]);
            DataForm.OutPutToPrinter(PrintStr);
           end;
          Qty := StrToFloat(Cells[0, I]);
          Price := StrToFloat(Cells[4, I]);
          TaxRate := StrToFloat(Cells[6, I]);
          if Cells[5, I] <> '' then
             DiscountRate := StrToFloat(Cells[5, I]) / 100
            else
             DiscountRate := 0;
          Amount := Price * Qty;
          RealPrice := Price * (1 - DiscountRate);
          Discount := (Price - RealPrice) * Qty;
          if CurrentPriceIncludesGST then
             GST := RealPrice * Qty * (1 - 1 / (1 + TaxRate / 100))
            else
             GST := Qty * RealPrice * (TaxRate / 100);
          SubTotal := SubTotal + Amount;
          SubDiscount := SubDiscount + Discount;
          SubGST := SubGST + GST;
          PrintStr := FloatToStr(Qty) + ' X ' + Format('%4.2f', [Price]) +
                      ' = ' + Format('%4.2f', [Amount]);
          PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
          DataForm.OutPutToPrinter(PrintStr);
         end;
     end;
 if ABS(SubTotal) >= 0.01 then
    begin
     SubServiceCharge := (SubTotal - SubDiscount) * CurrentServiceChargeRate / 100;
     SubServiceCharge := RoundToCurrency(SubServiceCharge);
     SubOtherCharge := (SubTotal - SubDiscount) * CurrentOtherChargeRate / 100;
     SubOtherCharge := RoundToCurrency(SubOtherCharge);
     if CurrentPriceIncludesGST then
        SubGST := SubGST + (SubServiceCharge + SubOtherCharge) * (1 - 1 / (1 + CurrentGSTRate / 100))
       else
        SubGST := SubGST + (SubServiceCharge + SubOtherCharge) * CurrentGSTRate / 100;
     TotalServiceCharge := TotalServiceCharge + SubServiceCharge;
     TotalOtherCharge := TotalOtherCharge + SubOtherCharge;
     TotalAmount := TotalAmount + SubTotal;
     TotalDiscount := TotalDiscount + SubDiscount;
     TotalGST := TotalGST + SubGST;
     if (ABS(SubServiceCharge) >= 0.01) or (ABS(SubOtherCharge) >= 0.01) or
        (ABS(SubDiscount) >= 0.01) then
        begin
         PrintStr := 'Amount: ' + Format('%8s', [FormatCurrency(SubTotal)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     if Abs(SubDiscount) >= 0.01 then
        begin
         PrintStr := 'Discount: ' + Format('%8s', [FormatCurrency(SubDiscount)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     if Abs(SubServiceCharge) >= 0.01 then
        begin
         PrintStr := SurchargeName + ': ' + Format('%8s', [FormatCurrency(SubServiceCharge)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     if Abs(SubOtherCharge) >= 0.01 then
        begin
         PrintStr := OtherChargeName + ': ' + Format('%8s', [FormatCurrency(SubOtherCharge)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     if CurrentPriceIncludesGST then
        begin
         PrintStr := 'Sub-Total: ' + Format('%8s',
          [FormatCurrency(SubTotal + SubServiceCharge + SubOtherCharge - SubDiscount)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
         if ShowTaxOnSalesSection then
            begin
             PrintStr := 'GST Included In Total: ' + Format('%8s', [FormatCurrency(SubGST)]);
             PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
             DataForm.OutPutToPrinter(PrintStr);
            end;
        end
       else
        begin
         PrintStr := 'G.S.T.: ' + Format('%8s', [FormatCurrency(SubGST)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
         PrintStr := 'Sub-Total: ' + Format('%8s',
           [FormatCurrency(SubTotal + SubServiceCharge + SubOtherCharge + SubGST - SubDiscount)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     DataForm.OutPutToPrinter(LineStr);
    end;
 if (ABS(TotalServiceCharge) >= 0.01) or (ABS(TotalOtherCharge) >= 0.01) or
    (ABS(TotalDiscount) >= 0.01) then
    begin
     PrintStr := 'Amount: ' + Format('%8s', [FormatCurrency(TotalAmount)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if Abs(TotalDiscount) >= 0.01 then
    begin
     PrintStr := 'Discount: ' + Format('%8s', [FormatCurrency(TotalDiscount)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if Abs(TotalServiceCharge) >= 0.01 then
    begin
     PrintStr := SurchargeName + ': ' + Format('%8s', [FormatCurrency(TotalServiceCharge)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if Abs(TotalOtherCharge) >= 0.01 then
    begin
     PrintStr := OtherChargeName + ': ' + Format('%8s', [FormatCurrency(TotalOtherCharge)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if CurrentPriceIncludesGST then
    begin
     PrintStr := 'Total: ' + Format('%8s',
      [FormatCurrency(TotalAmount + TotalServiceCharge + TotalOtherCharge - TotalDiscount)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     if ShowTaxOnSalesSection then
        begin
         PrintStr := 'GST Included In Total: ' + Format('%8s', [FormatCurrency(TotalGST)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
    end
   else
    begin
     PrintStr := 'G.S.T.: ' + Format('%8s', [FormatCurrency(TotalGST)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     PrintStr := 'Total: ' + Format('%8s',
       [FormatCurrency(TotalAmount + TotalServiceCharge + TotalOtherCharge + TotalGST - TotalDiscount)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 DataForm.OutPutToPrinter(LineStr);
 FileName := StartDir + 'Bill.CFG';
 if FileExists(FileName) then
    begin
     AssignFile(TxtFile, FileName);
     Reset(TxtFile);
     While Not EOF(TxtFile) do
      begin
       Readln(TxtFile, PrintStr);
       PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
       DataForm.OutPutToPrinter(PrintStr);
      end;
     CloseFile(TxtFile);
    end;
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TSplitBillForm.PrintInvoice;
var
 TxtFile: TextFile;
 Description, PrintStr, StrTemp, FileName, LineStr, SQLStr: string;
 Amount, Qty, DiscountRate, Price, GST, RealPrice, Discount, SubTotal, SubDiscount,
 TotalAmount, TotalDiscount, SubServiceCharge, TotalServiceCharge,
 SubOtherCharge, TotalOtherCharge, SubGST, TotalGST, TaxRate: double;
 I, CharCount, PaperWidth: integer;
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
 PrintStr := Format('%' + IntToStr((PaperWidth - 22) div 4) + 's%s', ['', 'TAX INVOICE']);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(LineStr);
 SQLStr := 'Select OrderDate, InvoiceNo, TableNo, Persons ' +
           'From OrderH Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OpenQuery(SQLStr);
 if PrintTimeOnInvoice then
    StrTemp := FormatDateTime('dd/mm/yyyy hh:mm:ss', Query.FieldByName('OrderDate').AsDateTime)
   else
    StrTemp := FormatDateTime('dd/mm/yyyy', Query.FieldByName('OrderDate').AsDateTime);
 if PrintOrderNoOnTaxInvoice then
    begin
     PrintStr := 'No: ' + OrderNo;
     CharCount := PaperWidth - Length(StrTemp + PrintStr);
     PrintStr := Format('%s%' + IntToStr(CharCount) + 's%s', [StrTemp, '', PrintStr]);
    end
   else
    PrintStr := StrTemp;
 DataForm.OutPutToPrinter(PrintStr);
 if DeleteSpace(Query.FieldByName('TableNo').AsString) <> 'QuickSale' then
    begin
     StrTemp := 'Table No: ' + DeleteSpace(Query.FieldByName('TableNo').AsString);
     if Query.FieldByName('Persons').AsInteger >= 1 then
        begin
         PrintStr := 'People: ' + Query.FieldByName('Persons').AsString;
         CharCount := PaperWidth - Length(StrTemp + PrintStr);
         PrintStr := Format('%s%' + IntToStr(CharCount) + 's%s', [StrTemp, '', PrintStr]);
        end
       else
        PrintStr := StrTemp;  
     DataForm.OutPutToPrinter(PrintStr);
    end;
 Query.Close;
 DataForm.OutPutToPrinter(LineStr);
 TotalAmount := 0; TotalDiscount := 0; TotalServiceCharge := 0; TotalOtherCharge := 0;
 SubTotal := 0; SubDiscount := 0; SubGST := 0; TotalGST := 0;
 with TargetStringGrid do
 for I := 1 to 500 do
  if Cells[0, I] <> '' then
     begin
      if Cells[0, I] = '____________' then
         begin
          if ABS(SubTotal) > 0.01 then
             begin
              SubServiceCharge := (SubTotal - SubDiscount) * CurrentServiceChargeRate / 100;
              SubServiceCharge := RoundToCurrency(SubServiceCharge);
              SubOtherCharge := (SubTotal - SubDiscount) * CurrentOtherChargeRate / 100;
              SubOtherCharge := RoundToCurrency(SubOtherCharge);
              if CurrentPriceIncludesGST then
                 SubGST := SubGST + (SubServiceCharge + SubOtherCharge) * (1 - 1 / (1 + CurrentGSTRate / 100))
                else
                 SubGST := SubGST + (SubServiceCharge + SubOtherCharge) * CurrentGSTRate / 100;
              TotalServiceCharge := TotalServiceCharge + SubServiceCharge;
              TotalOtherCharge := TotalOtherCharge + SubOtherCharge;
              TotalGST := TotalGST + SubGST;
              TotalAmount := TotalAmount + SubTotal;
              TotalDiscount := TotalDiscount + SubDiscount;
              if (ABS(SubServiceCharge) >= 0.01) or (ABS(SubOtherCharge) >= 0.01) or
                 (ABS(SubDiscount) >= 0.01) then
                 begin
                  PrintStr := 'Amount: ' + Format('%8s', [FormatCurrency(SubTotal)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                 end;
              if Abs(SubDiscount) >= 0.01 then
                 begin
                  PrintStr := 'Discount: ' + Format('%8s', [FormatCurrency(SubDiscount)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                 end;
              if Abs(SubServiceCharge) >= 0.01 then
                 begin
                  PrintStr := SurchargeName + ': ' + Format('%8s', [FormatCurrency(SubServiceCharge)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                 end;
              if Abs(SubOtherCharge) >= 0.01 then
                 begin
                  PrintStr := OtherChargeName + ': ' + Format('%8s', [FormatCurrency(SubOtherCharge)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                 end;
              if CurrentPriceIncludesGST then
                 begin
                  PrintStr := 'Sub-Total: ' + Format('%8s',
                   [FormatCurrency(SubTotal + SubServiceCharge + SubOtherCharge - SubDiscount)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                  if ShowTaxOnSalesSection then
                     begin
                      PrintStr := 'GST Included In Total: ' + Format('%8s', [FormatCurrency(SubGST)]);
                      PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                      DataForm.OutPutToPrinter(PrintStr);
                     end;
                 end
                else
                 begin
                  PrintStr := 'G.S.T.: ' + Format('%8s', [FormatCurrency(SubGST)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                  PrintStr := 'Sub-Total: ' + Format('%8s',
                   [FormatCurrency(SubTotal + SubServiceCharge + SubOtherCharge + SubGST - SubDiscount)]);
                  PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
                  DataForm.OutPutToPrinter(PrintStr);
                 end;
              DataForm.OutPutToPrinter(LineStr);
             end;
          SubTotal := 0; SubDiscount := 0; SubGST := 0;
         end
        else
         begin
          Description := Cells[1, I];
          StrTemp := Copy(Description, 1, PaperWidth);
          CharCount := PaperWidth;
          PrintStr := Format('%s', [StrTemp]);
          DataForm.OutPutToPrinter(PrintStr);
          while Length(Description) > CharCount do
           begin
            StrTemp := Copy(Description, CharCount + 1, PaperWidth);
            CharCount := CharCount + PaperWidth;
            PrintStr := Format('%s', [StrTemp]);
            DataForm.OutPutToPrinter(PrintStr);
           end;
          Qty := StrToFloat(Cells[0, I]);
          Price := StrToFloat(Cells[4, I]);
          TaxRate := StrToFloat(Cells[6, I]);
          if Cells[5, I] <> '' then
             DiscountRate := StrToFloat(Cells[5, I]) / 100
            else
             DiscountRate := 0;
          Amount := Price * Qty;
          RealPrice := Price * (1 - DiscountRate);
          Discount := (Price - RealPrice) * Qty;
          if CurrentPriceIncludesGST then
             GST := RealPrice * Qty * (1 - 1 / (1 + TaxRate / 100))
            else
             GST := Qty * RealPrice * (TaxRate / 100);
          SubTotal := SubTotal + Amount;
          SubDiscount := SubDiscount + Discount;
          SubGST := SubGST + GST;
          PrintStr := FloatToStr(Qty) + ' X ' + Format('%4.2f', [Price]) +
                      ' = ' + Format('%4.2f', [Amount]);
          PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
          DataForm.OutPutToPrinter(PrintStr);
         end;
     end;
 if ABS(SubTotal) > 0.01 then
    begin
     SubServiceCharge := (SubTotal - SubDiscount) * CurrentServiceChargeRate / 100;
     SubServiceCharge := RoundToCurrency(SubServiceCharge);
     SubOtherCharge := (SubTotal - SubDiscount) * CurrentOtherChargeRate / 100;
     SubOtherCharge := RoundToCurrency(SubOtherCharge);
     if CurrentPriceIncludesGST then
        SubGST := SubGST + (SubServiceCharge + SubOtherCharge) * (1 - 1 / (1 + CurrentGSTRate / 100))
       else
        SubGST := SubGST + (SubServiceCharge + SubOtherCharge) * CurrentGSTRate / 100;
     TotalServiceCharge := TotalServiceCharge + SubServiceCharge;
     TotalOtherCharge := TotalOtherCharge + SubOtherCharge;
     TotalAmount := TotalAmount + SubTotal;
     TotalDiscount := TotalDiscount + SubDiscount;
     TotalGST := TotalGST + SubGST;
     if (ABS(SubServiceCharge) >= 0.01) or (ABS(SubOtherCharge) >= 0.01) or
        (ABS(SubDiscount) >= 0.01) then
        begin
         PrintStr := 'Amount: ' + Format('%8s', [FormatCurrency(SubTotal)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     if Abs(SubDiscount) >= 0.01 then
        begin
         PrintStr := 'Discount: ' + Format('%8s', [FormatCurrency(SubDiscount)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     if Abs(SubServiceCharge) >= 0.01 then
        begin
         PrintStr := SurchargeName + ': ' + Format('%8s', [FormatCurrency(SubServiceCharge)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     if Abs(SubOtherCharge) >= 0.01 then
        begin
         PrintStr := OtherChargeName + ': ' + Format('%8s', [FormatCurrency(SubOtherCharge)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     if CurrentPriceIncludesGST then
        begin
         PrintStr := 'Sub-Total: ' + Format('%8s',
          [FormatCurrency(SubTotal + SubServiceCharge + SubOtherCharge - SubDiscount)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
         if ShowTaxOnSalesSection then
            begin
             PrintStr := 'GST Included In Total: ' + Format('%8s', [FormatCurrency(SubGST)]);
             PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
             DataForm.OutPutToPrinter(PrintStr);
            end;
        end
       else
        begin
         PrintStr := 'G.S.T.: ' + Format('%8s', [FormatCurrency(SubGST)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
         PrintStr := 'Sub-Total: ' + Format('%8s',
          [FormatCurrency(SubTotal + SubServiceCharge + SubOtherCharge + SubGST - SubDiscount)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     DataForm.OutPutToPrinter(LineStr);
    end;
 if (ABS(TotalServiceCharge) >= 0.01) or (ABS(TotalOtherCharge) >= 0.01) or
    (ABS(TotalDiscount) >= 0.01) then
    begin
     PrintStr := 'Amount: ' + Format('%8s', [FormatCurrency(TotalAmount)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if Abs(TotalDiscount) >= 0.01 then
    begin
     PrintStr := 'Discount: ' + Format('%8s', [FormatCurrency(TotalDiscount)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if Abs(TotalServiceCharge) >= 0.01 then
    begin
     PrintStr := SurchargeName + ': ' + Format('%8s', [FormatCurrency(TotalServiceCharge)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if Abs(TotalOtherCharge) >= 0.01 then
    begin
     PrintStr := OtherChargeName + ': ' + Format('%8s', [FormatCurrency(TotalOtherCharge)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if CurrentPriceIncludesGST then
    begin
     PrintStr := 'Total: ' + Format('%8s',
      [FormatCurrency(TotalAmount + TotalServiceCharge + TotalOtherCharge - TotalDiscount)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     if ShowTaxOnSalesSection then
        begin
         PrintStr := 'GST Included In Total: ' + Format('%8s', [FormatCurrency(TotalGST)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
    end
   else
    begin
     PrintStr := 'G.S.T.: ' + Format('%8s', [FormatCurrency(TotalGST)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     PrintStr := 'Total: ' + Format('%8s',
       [FormatCurrency(TotalAmount + TotalServiceCharge + TotalOtherCharge + TotalGST - TotalDiscount)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 DataForm.OutPutToPrinter(LineStr);
 FileName := StartDir + 'Invoice.CFG';
 if FileExists(FileName) then
    begin
     AssignFile(TxtFile, FileName);
     Reset(TxtFile);
     While Not EOF(TxtFile) do
      begin
       Readln(TxtFile, PrintStr);
       DataForm.OutPutToPrinter(PrintStr);
      end;
     CloseFile(TxtFile);
    end;
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TSplitBillForm.PrintOrderButtonClick(Sender: TObject);
begin
 BackPanel.SetFocus;
 PrintOrderList;
end;

function TSplitBillForm.FindIDNo: integer;
var
 SQLStr: String;
begin
 SQLStr := 'Select Max(IDNo) From RecvAcct Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount <> 0) then
    Result := Query.Fields[0].AsInteger + 1
   else
    Result := 1;
 Query.Close;
end;

function TSplitBillForm.UpdateItemRecord: boolean;
var
 I: integer;
 SQLStr: string;
begin
 Result := True;
 I := 1;
 while (I < 500) and Result do
  begin
   with TargetStringGrid do
     if (Cells[2, I] <> '') and (Cells[2, I] <> '____________') then
        begin
         SQLStr := 'Update OrderI Set PaidQty=PaidQty+' + Cells[0, I] +
                   ' Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
                   ' and IDNo=' + Cells[7, I];
         Result := DataForm.ExecQueryPro(SQLStr);
        end;
   I := I + 1;
  end;
end;

procedure TSplitBillForm.SendToSecurityPortPro(OrderNo, PayBy: string; Amount, PayAmount, Tips, Rounding, Surcharge, Change: double);
var
 PrintStr, Temp: string;
begin
 if FVar.SecurityCameraPort = 0 then Exit;
 DataForm.OpenSecurityCameraPort;
 PrintStr := '*** Split Bill Payment ***';
 PrintStr := Format('%' + IntToStr((40 - Length(PrintStr)) div 2) + 's%s', ['', PrintStr]);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 PrintStr := 'Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 PrintStr := 'Operator: ' + sUserName;
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 PrintStr := 'Order No.:';
 PrintStr := Format('%s%' + IntToStr(40 - (Length(PrintStr) + Length(OrderNo))) + 's%s', [PrintStr, '', OrderNo]);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 if ABS(Amount) >= 0.01 then
    begin
     PrintStr := 'Amount:';
     Temp := Format('%8s', [FormatCurrency(Amount)]);
     PrintStr := Format('%s%' + IntToStr(40 - (Length(PrintStr) + Length(Temp))) + 's%s', [PrintStr, '', Temp]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if ABS(Surcharge) >= 0.01 then
    begin
     PrintStr := 'Surcharge:';
     Temp := Format('%8s', [FormatCurrency(Surcharge)]);
     PrintStr := Format('%s%' + IntToStr(40 - (Length(PrintStr) + Length(Temp))) + 's%s', [PrintStr, '', Temp]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if ABS(Tips) >= 0.01 then
    begin
     PrintStr := 'Tips:';
     Temp := Format('%8s', [FormatCurrency(Tips)]);
     PrintStr := Format('%s%' + IntToStr(40 - (Length(PrintStr) + Length(Temp))) + 's%s', [PrintStr, '', Temp]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 if ABS(Rounding) >= 0.01 then
    begin
     PrintStr := 'Rounding:';
     Temp := Format('%8s', [FormatCurrency(Rounding)]);
     PrintStr := Format('%s%' + IntToStr(40 - (Length(PrintStr) + Length(Temp))) + 's%s', [PrintStr, '', Temp]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;

 PrintStr := PayBy;
 Temp := Format('%8s', [FormatCurrency(PayAmount)]);
 PrintStr := Format('%s%' + IntToStr(40 - (Length(PrintStr) + Length(Temp))) + 's%s', [PrintStr, '', Temp]);
 DataForm.SendMsgToSecurityCameraPort(PrintStr);

 if ABS(Change) >= 0.01 then
    begin
     PrintStr := 'Change:';
     Temp := Format('%8s', [FormatCurrency(Change)]);
     PrintStr := Format('%s%' + IntToStr(40 - (Length(PrintStr) + Length(Temp))) + 's%s', [PrintStr, '', Temp]);
     DataForm.SendMsgToSecurityCameraPort(PrintStr);
    end;
 DataForm.CloseSecurityCameraPort;
end;

procedure TSplitBillForm.PaymentButtonClick(Sender: TObject);
var
 Amount, PayAmount, Tips, Rounding, Surcharge, Change: double;
 Flag: boolean;
 IDNo, SourceRow, TargetRow: integer;
 SQLStr, Payby: string;
begin
 SourceRow := FindSourceLastLine;
 TargetRow := FindTargetLastLine;
 if (TargetRow > 1) and (SourceRow > 1) then
    Amount := CalcSubTotal
   else
    if (TargetRow > 1) and (SourceRow = 1) then
       Amount := CalcTotalInvoice
   else
    Amount := 0;
 if ABS(Amount) < 0.005 then Exit;
 Flag := SplitPaymentForm.SplitPaymentPro(OrderNo, Amount, PayAmount,
         Tips, Rounding, Surcharge, Change, PayBy, VIPNo);
 if Not Flag then Exit;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  IDNo := FindIDNo;
  Flag := DataForm.SaveAccountRecord(OrderNo, PayAmount, PayBy, IDNo, 0);
  if Flag and (Abs(Rounding) > 0.009) then
     begin
      IDNo := IDNo + 1;
      Flag := DataForm.SaveAccountRecord(OrderNo, -Rounding, 'ROUNDING', IDNo, 0);
     end;
  if Flag and (Change > 0) then
     begin
      IDNo := IDNo + 1;
      Flag := DataForm.SaveAccountRecord(OrderNo, -Change, 'CASH', IDNo, 0);
     end;
  if Flag then Flag := DataForm.UpdateOrderPayment(OrderNo, True);
  if Flag then
     begin
      SQLStr := 'Update OrderH Set Tips=Tips + ' + FloatToStr(Tips) +
                ', Surcharge=Surcharge +' + FloatToStr(Surcharge) +
                ' Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag then Flag := UpdateItemRecord;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      SendToSecurityPortPro(OrderNo, PayBy, Amount, PayAmount, Tips, Rounding, Surcharge, Change);
      InitTargetStringGrid;
      if Not OnlyOpenDrawerForCashPayment or (ABS(Change) >= 0.01) or
        ((Uppercase(PayBy) = 'CASH') and (ABS(PayAmount) >= 0.01)) then
         begin
          CurrentDrawerNumber := DefaultDrawerPortNumber;
          DataForm.OpenDrawer(True, CurrentDrawerNumber);
         end; 
      DispPaymentForm.DispPaymentPro(OrderNo, Amount, PayAmount, Tips, Rounding, Surcharge, Change, Payby);
     end
    else
     begin
      DataForm.RollBack;
     end;
 end;
 CalcBillAmount;
 if FVar.SecondDisplay = 1 then
    begin
     SecondDisplayForm.SetSalesStatus;
     PostDataToSecondDisplayPro;
     PostToSecondDisplay;
    end;
end;

procedure TSplitBillForm.ConvertButtonClick(Sender: TObject);
var
 I: integer;
 StrTemp: string;
begin
 Langurage := Not Langurage;
 for I := 1 to 500 do
  with SourceStringGrid do
   if Cells[8, I] <> '' then
      begin
       StrTemp := Cells[8, I];
       Cells[8, I] := Cells[1, I];
       Cells[1, I] := StrTemp;
      end;
 for I := 1 to 500 do
  with TargetStringGrid do
   if Cells[8, I] <> '' then
      begin
       StrTemp := Cells[8, I];
       Cells[8, I] := Cells[1, I];
       Cells[1, I] := StrTemp;
      end;
end;

procedure TSplitBillForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TSplitBillForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
end;

procedure TSplitBillForm.FormShow(Sender: TObject);
var
 SQLStr: string;
begin
 SQLStr := 'Select ServiceChargeRate, OtherChargeRate, PriceIncludesGST, ' +
           'CurrentGSTRate, VIPNo From OrderH ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OpenQuery(SQLStr);
 CurrentServiceChargeRate := Query.FieldByName('ServiceChargeRate').AsFloat;
 CurrentOtherChargeRate := Query.FieldByName('OtherChargeRate').AsFloat;
 CurrentPriceIncludesGST := Query.FieldByName('PriceIncludesGST').AsBoolean;
 VIPNo := Query.FieldByName('VIPNo').AsInteger;
 CurrentGSTRate := Query.FieldByName('CurrentGSTRate').AsFloat;
 Langurage := True;
 PostDataToSourceStringGrid;
 if FVar.SecondDisplay = 1 then
    begin
     SecondDisplayForm.SetSalesStatus;
     PostDataToSecondDisplayPro;
     PostToSecondDisplay;
    end;
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
end;

procedure TSplitBillForm.SplitBillPro(OrderNo: string);
begin
 Application.CreateForm(TSplitBillForm, SplitBillForm);
 SplitBillForm.OrderNo := OrderNo;
 SplitBillForm.ShowModal;
 SplitBillForm.Free;
end;

end.
