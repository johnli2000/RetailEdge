unit PrintInvoice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, UtilUnit, ADODB;

type
  TPrintInvoiceForm = class(TDataModule)
    Query: TADOQuery;
    procedure OpenQuery(SQLStr: String);
    procedure PrintOutPro;
    procedure PrintInvoicePro(OrderNo: string);
  private { Private declarations }
    OrderNo: string;
  public
    { Public declarations }
  end;

var
  PrintInvoiceForm: TPrintInvoiceForm;

implementation

uses DataUnit;

{$R *.DFM}

procedure TPrintInvoiceForm.OpenQuery(SQLStr: String);
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

procedure TPrintInvoiceForm.PrintOutPro;
var
 TxtFile: TextFile;
 Description, PrintStr, StrTemp, FileName, FieldName, LineStr, Category, SQLStr: string;
 Amount, TaxRate, Qty, GST, DiscountRate, Discount, Price, DollarDiscount, RewardPoints,
 TotalInvoice, RealPrice, ServiceCharge, OtherCharge, PaidAmount, Tips, Surcharge,
 CurrentGSTRate, Balance: double;
 I, CharCount, PaperWidth, RoundFlag, VIPNo: integer;
 CurrentPriceIncludesGST: boolean;
 DiscountKind: integer;
 Temp, Ch: string;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 LineStr := '';
 for I := 1 to PaperWidth do LineStr := LineStr + '=';
 DataForm.PrintLOgoToPOSPrinter;
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 DataForm.OutPutToPrinter(LineStr);
 DataForm.SetBlackFontB;
 StrTemp := 'TAX INVOICE';
 PrintStr := Format('%' + IntToStr((PaperWidth - 22) div 4) + 's%s', ['', StrTemp]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(LineStr);
 SQLStr := 'Select OrderDate, InvoiceNo, TableNo, Persons, VIPNo, DollarDiscount, ' +
           'ServiceCharge, OtherCharge, Tips, Surcharge, ServicePerson, BillKind, ' +
           'PriceIncludesGST, CurrentGSTRate, RewardPoints, DiscountKind ' +
           'From OrderH Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OpenQuery(SQLStr);
 if PrintTimeOnInvoice then
    StrTemp := FormatDateTime('dd/mm/yyyy hh:mm:ss', Query.FieldByName('OrderDate').AsDateTime)
   else
    StrTemp := FormatDateTime('dd/mm/yyyy', Query.FieldByName('OrderDate').AsDateTime);
 if PrintInvoiceNo then
    begin
     PrintStr := 'No: ' + Query.FieldByName('InvoiceNo').AsString;
     CharCount := PaperWidth - Length(StrTemp + PrintStr);
     PrintStr := Format('%s%' + IntToStr(CharCount) + 's%s', [StrTemp, '', PrintStr]);
    end
   else
    PrintStr := StrTemp;
 DataForm.OutPutToPrinter(PrintStr);
 if Query.FieldByName('Persons').AsInteger > 0 then
    StrTemp := 'People: ' + Query.FieldByName('Persons').AsString
   else
    StrTemp := '';
 PrintStr := 'Service: ' + Query.FieldByName('ServicePerson').AsString;
 CharCount := PaperWidth - Length(StrTemp + PrintStr);
 PrintStr := Format('%s%' + IntToStr(CharCount) + 's%s', [PrintStr, '', StrTemp]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontB;
 if (Query.FieldByName('BillKind').AsInteger = sTableOrder) then
    begin
     if PrintTableNo then
        begin
         PrintStr := 'Table: ' + DeleteSpace(Query.FieldByName('TableNo').AsString);
         DataForm.OutPutToPrinter(PrintStr);
        end;
    end
   else
    if (Query.FieldByName('BillKind').AsInteger = sQuickSale) then
        begin
         PrintStr := 'Quick Service';
         DataForm.OutPutToPrinter(PrintStr);
        end
       else
        begin
         PrintStr := 'Phone Order';
         DataForm.OutPutToPrinter(PrintStr);
        end;
 DataForm.SetBlackFontA;
 DiscountKind := Query.FieldByName('DiscountKind').AsInteger;
 DollarDiscount := Query.FieldByName('DollarDiscount').AsFloat;
 ServiceCharge := Query.FieldByName('ServiceCharge').AsFloat;
 OtherCharge := Query.FieldByName('OtherCharge').AsFloat;
 Tips := Query.FieldByName('Tips').AsFloat;
 Surcharge := Query.FieldByName('Surcharge').AsFloat;
 VIPNo := Query.FieldByName('VIPNo').AsInteger;
 CurrentPriceIncludesGST := Query.FieldByName('PriceIncludesGST').AsBoolean;
 CurrentGSTRate := Query.FieldByName('CurrentGSTRate').AsFloat;
 RewardPoints := Query.FieldByName('RewardPoints').AsFloat;
 Query.Close;
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := Format('DESCRIPTION%' + IntToStr(PaperWidth - 27) +
             's          AMOUNT', ['']);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 Amount := 0; GST := 0; Discount := 0;
 SQLStr := 'Select OrderI.ItemCode, Qty, OrderI.Price, OrderI.Discount, Description1, ' +
           'Description2, OrderI.TaxRate, Condition, PriceSelect, SubDescription, ' +
           'SubDescription1, SubDescription2, SubDescription3, Category.Category, ' +
           'Category1, Multiple ' +
           'From OrderI, MenuItem, Category ' +
           'Where OrderI.ItemCode = MenuItem.ItemCode and Qty <> 0 and ' +
           'Category.Category=MenuItem.Category and ' +
           '(OrderI.Condition = 0 or (OrderI.Condition > 0 and OrderI.Price <> 0)) and ' +
           'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 if Not PrintZeroPriceItemOnInvoice then
    SQLStr := SQLStr + ' and OrderI.Price <> 0 ';
 if PrintInvoiceMode = 1 then
    SQLStr := SQLStr + ' Order By Category.Code, IDNo'
   else
    SQLStr := SQLStr + ' Order By IDNo';
 OpenQuery(SQLStr);
 Category := '';
 if Query.RecordCount <> 0 then
    begin
     while Not Query.EOF do
      begin
       if (PrintInvoiceMode = 1) and (Category <> Query.FieldByName('Category').AsString) then
          begin
           Category := Query.FieldByName('Category').AsString;
           DataForm.SetBlackFontB;
           if (PrintInvoiceDescription <> 2) or (Query.FieldByName('Category1').AsString = '') then
              DataForm.OutPutToPrinter(Category)
             else
              DataForm.OutPutToPrinter(Query.FieldByName('Category1').AsString);
           if (PrintInvoiceDescription = 0) and
              (Category <> Query.FieldByName('Category1').AsString) then
              DataForm.OutPutToPrinter(Query.FieldByName('Category1').AsString);
           DataForm.SetBlackFontA;
          end;
       if (PrintInvoiceDescription <> 2) or
          (Query.FieldByName('Description2').AsString = '') then
          Description := Query.FieldByName('Description1').AsString
         else
          Description := Query.FieldByName('Description2').AsString;
       if Query.FieldByName('Multiple').AsBoolean then
          begin
           FieldName := GenerateSubDescriptionFieldName(Query.FieldByName('PriceSelect').AsInteger);
           if Query.FieldByName(FieldName).AsString <> '' then
              Description := Description + ' / ' + Query.FieldByName(FieldName).AsString;
          end;
       case Query.FieldByName('Condition').AsInteger of
        1: Description := '[*] ' + Description;
        2: Description := '[A] ' + Description;
        3: Description := '[C] ' + Description;
        4: Description := '[M] ' + Description;
        5: Description := '[L] ' + Description;
       end;
       if ABS(Query.FieldByName('TaxRate').AsFloat) > 0 then
          begin
           StrTemp := Copy(Description, 1, PaperWidth);
           CharCount := PaperWidth;
          end
         else
          begin
           StrTemp := '*' + Copy(Description, 1, PaperWidth - 1);
           CharCount := PaperWidth - 1;
          end;
       PrintStr := StrTemp;
       DataForm.OutPutToPrinter(PrintStr);
       while Length(Description) > CharCount do
        begin
         StrTemp := Copy(Description, CharCount + 1, PaperWidth);
         CharCount := CharCount + PaperWidth;
         PrintStr := Format('%s', [StrTemp]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
       CharCount := 0;
       if (PrintInvoiceDescription = 0) and
          (Query.FieldByName('Description1').AsString <>
           Query.FieldByName('Description2').AsString) then
          begin
           Description := Query.FieldByName('Description2').AsString;
           if Description <> '' then
              while Length(Description) > CharCount do
               begin
                StrTemp := Copy(Description, CharCount + 1, PaperWidth);
                CharCount := CharCount + PaperWidth;
                PrintStr := Format('%s', [StrTemp]);
                DataForm.OutPutToPrinter(PrintStr);
               end;
          end;
       Qty := Query.FieldByName('Qty').AsFloat;
       TaxRate := Query.FieldByName('TaxRate').AsFloat;
       Price := Query.FieldByName('Price').AsFloat;
       Amount := Amount + Price * Qty;
       if (DiscountKind <= 1) and (Query.FieldByName('Discount').AsFloat >= 0.01) then
          begin
           DiscountRate := StrToFloat(Format('%6.4f', [Query.FieldByName('Discount').AsFloat / 100]));
           RealPrice := Price * (1 - DiscountRate);
           Discount := Discount + (Price - RealPrice) * Qty;
           if CurrentPriceIncludesGST then
              GST := GST + RealPrice * Qty * (1 - 1 / (1 + TaxRate / 100))
             else
              GST := GST + Qty * RealPrice * (TaxRate / 100);
          end
         else
          begin
           if CurrentPriceIncludesGST then
              GST := GST + Price * Qty * (1 - 1 / (1 + TaxRate / 100))
             else
              GST := GST + Qty * Price * (TaxRate / 100);
          end;
       if (ABS(Qty) > 0) and (ABS(Price) > 0) then
          begin
           PrintStr := FloatToStr(Qty) + ' X ' + FormatCurrency(Price) + ' = ' + FormatCurrency(Price * Qty);
           PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
          end
         else
          PrintStr := ' ';
       PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
       DataForm.OutPutToPrinter(PrintStr);
       if PrintDiscountRateOnBill and (DiscountKind <= 1) and (Query.FieldByName('Discount').AsFloat >= 0.01) then
          begin
           PrintStr := 'Discount (' + FloatToStr(Query.FieldByName('Discount').AsFloat) + '%) = ' +
                       FormatCurrency(0 - Price * Qty * Query.FieldByName('Discount').AsFloat / 100);
           PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
           DataForm.OutPutToPrinter(PrintStr);
          end;
       Query.Next;
      end;
     DataForm.OutPutToPrinter(LineStr);
    end;
 Query.Close;

 if ABS(DollarDiscount) >= 0.05 then
    begin
     Discount := DollarDiscount;
     if CurrentPriceIncludesGST then
        GST := GST - DollarDiscount * (1 - 1 / (1 + CurrentGSTRate / 100))
       else
        GST := GST - DollarDiscount * CurrentGSTRate / 100;
    end;

 Discount := RoundToCurrency(Discount);

 if CurrentPriceIncludesGST then
    GST := GST + (ServiceCharge + OtherCharge) * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    GST := GST + (ServiceCharge + OtherCharge) * CurrentGSTRate / 100;

 if CurrentPriceIncludesGST then
    GST := GST - RewardPoints * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    GST := GST - RewardPoints * CurrentGSTRate / 100;

 if (Amount >= 0) and (GST <= 0) then GST := 0;
 GST := RoundToCurrency(GST);

 if CurrentPriceIncludesGST then
    TotalInvoice := Amount - Discount - RewardPoints + ServiceCharge + OtherCharge
   else
    TotalInvoice := Amount - Discount - RewardPoints + ServiceCharge + OtherCharge + GST;

 if ABS(TotalInvoice) <= 0.001 then TotalInvoice := 0;
 TotalInvoice := RoundToCurrency(TotalInvoice);

 if (ABS(ServiceCharge) >= 0.01) or (ABS(OtherCharge) >= 0.01) or
    (ABS(Discount) >= 0.01) or (ABS(RewardPoints) >= 0.01) or
    ((ABS(GST) > 0.01) and Not CurrentPriceIncludesGST) then
    begin
     PrintStr := 'Amount: ' + Format('%8s', [FormatCurrency(Amount)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if Abs(Discount) >= 0.01 then
    begin
     if DiscountKind = 0 then
        PrintStr := 'Discount( ' + FloatToStr(DiscountRate * 100) + '% ): ' + Format('%8s', [FormatCurrency(Discount)])
       else
        PrintStr := 'Discount: ' + Format('%8s', [FormatCurrency(Discount)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if Abs(RewardPoints) >= 0.01 then
    begin
     PrintStr := 'Points Redeem: ' + Format('%8s', [FormatCurrency(RewardPoints)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if Abs(ServiceCharge) >= 0.01 then
    begin
     PrintStr := SurchargeName + ': ' + Format('%8s', [FormatCurrency(ServiceCharge)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if Abs(OtherCharge) >= 0.01 then
    begin
     PrintStr := OtherChargeName + ': ' + Format('%8s', [FormatCurrency(OtherCharge)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;

 if CurrentPriceIncludesGST then
    begin
     PrintStr := 'Total: ' + FormatCurrency(TotalInvoice);
     PrintStr := Format('%20s', [PrintStr]);
     DataForm.SetBlackFontC;
     DataForm.OutPutToPrinter(PrintStr);
     DataForm.SetBlackFontA;
     if ShowTaxOnSalesSection then
        begin
         PrintStr := 'GST Included In Total: ' + Format('%8s', [FormatCurrency(GST)]);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
    end
   else
    begin
     PrintStr := 'G.S.T.: ' + Format('%8s', [FormatCurrency(GST)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     PrintStr := 'Total: ' + FormatCurrency(TotalInvoice);
     PrintStr := Format('%20s', [PrintStr]);
     DataForm.SetBlackFontC;
     DataForm.OutPutToPrinter(PrintStr);
     DataForm.SetBlackFontA;
    end;
 if ABS(Tips) >= 0.01 then
    begin
     PrintStr := 'Tips: ' + Format('%8s', [FormatCurrency(Tips)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if Abs(Surcharge) >= 0.01 then
    begin
     PrintStr := 'Bank Charge: ' + Format('%8s', [FormatCurrency(Surcharge)]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 PaidAmount := 0;
 SQLStr := 'Select * From RecvAcct Where OrderNo=' +
           Chr(39) + CheckQuotes(OrderNo) + Chr(39) + ' Order By IDNo';
 OpenQuery(SQLStr);
 with Query do
  if Active and (RecordCount > 0) then
     begin
      First;
      while Not EOF do
       begin
        if (FieldByName('PaidAmount').AsFloat < 0) and
           (FieldByName('PayBy').AsString = 'CASH') and
           (Amount > 0) then
           PrintStr := 'Change: ' + Format('%8s', [FormatCurrency(ABS(FieldByName('PaidAmount').AsFloat))])
          else
           PrintStr := FieldByName('PayBy').AsString + ': ' +
                           Format('%8s', [FormatCurrency(FieldByName('PaidAmount').AsFloat)]);
        PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
        DataForm.OutPutToPrinter(PrintStr);
        PaidAmount := PaidAmount + FieldByName('PaidAmount').AsFloat;
        Next;
       end;
      Close;
     end;
 Balance := TotalInvoice + Tips + Surcharge - PaidAmount;
 if ABS(Balance) <= 0.001 then Balance := 0;
 PrintStr := 'Balance: ' + Format('%8s', [FormatCurrency(Balance)]);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter('* GST free items');
 DataForm.OutPutToPrinter(LineStr);
 if VIPNo >= 1 then
    begin
     SQLStr := 'Select * From VIPTable Where VIPNo=' + IntToStr(VIPNo);
     OpenQuery(SQLStr);
     with Query do
      if Active and (RecordCount > 0) then
         begin
          PrintStr := 'V.I.P. Number: ' + Format('%8.8d', [VIPNo]);
          DataForm.OutPutToPrinter(PrintStr);
          PrintStr := 'Name: ' + FieldByName('VIPName').AsString;
          DataForm.OutPutToPrinter(PrintStr);
          if FieldByName('Telephone').AsString <> '' then
             begin
              PrintStr := 'Telephone: ' + FieldByName('Telephone').AsString;
              DataForm.OutPutToPrinter(PrintStr);
             end;
          if FieldByName('Mobile').AsString <> '' then
             begin
              PrintStr := 'Mobile: ' + FieldByName('Mobile').AsString;
              DataForm.OutPutToPrinter(PrintStr);
             end;
          PrintStr := 'Address: ' + FieldByName('Number').AsString + ' ' + FieldByName('Address').AsString;
          DataForm.OutPutToPrinter(PrintStr);
          PrintStr := FieldByName('Suburb').AsString + ' ' + FieldByName('State').AsString +
                      ' ' + FieldByName('PostCode').AsString;
          DataForm.OutPutToPrinter(PrintStr);
          if FieldByName('MapReference').AsString <> '' then
             begin
              PrintStr := 'Map Ref: ' + FieldByName('MapReference').AsString;
              DataForm.OutPutToPrinter(PrintStr);
             end;
          DataForm.OutPutToPrinter(LineStr);
          Close;
         end;
    end;
 if PrintOrderNoOnTaxInvoice then
    begin
     DataForm.SetBlackFontB;
     PrintStr := 'Order Number: ' + Copy(OrderNo, 7, 4);
     DataForm.OutPutToPrinter(PrintStr);
     DataForm.SetBlackFontA;
     DataForm.OutPutToPrinter(LineStr);
    end;
 FileName := StartDir + 'Invoice.CFG';
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

procedure TPrintInvoiceForm.PrintInvoicePro(OrderNo: string);
begin
 Application.CreateForm(TPrintInvoiceForm, PrintInvoiceForm);
 PrintInvoiceForm.OrderNo := OrderNo;
 PrintInvoiceForm.PrintOutPro;
 PrintInvoiceForm.Free;
end;

end.

