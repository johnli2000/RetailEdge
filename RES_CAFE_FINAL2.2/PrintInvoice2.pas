unit PrintInvoice2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, UtilUnit, ADODB;

type
  BillBuffType = Record
   ItemCode, Description1, Description2, SubDescription,
   SubDescription1, SubDescription2, SubDescription3: string;
   Condition, PriceSelect: Integer;
   Qty, Price, Discount, TaxRate: double;
  end;
  TPrintInvoiceForm2 = class(TDataModule)
    Query: TADOQuery;
    procedure OpenQuery(SQLStr: String);
    procedure InitBillBuff;
    procedure ReadInvoiceData;
    procedure PrintOutPro;
    procedure PrintInvoicePro(OrderNo: string);
  private { Private declarations }
    OrderNo: string;
    BillBuff: array [1..500] of BillBuffType;
  public
    { Public declarations }
  end;

var
  PrintInvoiceForm2: TPrintInvoiceForm2;

implementation

uses DataUnit;

{$R *.DFM}

procedure TPrintInvoiceForm2.OpenQuery(SQLStr: String);
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

procedure TPrintInvoiceForm2.InitBillBuff;
var
 I: integer;
begin
 for I := 1 to 500 do
  with BillBuff[I] do
   begin
    ItemCode := ''; Description1 := ''; Description2 := '';
    SubDescription := ''; SubDescription1 := '';
    SubDescription2 := ''; SubDescription3 := '';
    Condition := 0; PriceSelect := 0;
    Qty := 0; Price := 0; TaxRate := 0; Discount := 0;
   end;
end;

procedure TPrintInvoiceForm2.ReadInvoiceData;
var
 SQLStr: string;
 I: integer;
begin
 InitBillBuff;
 SQLStr := 'Select OrderI.ItemCode, Sum(Qty) As Qty, OrderI.Price, OrderI.Discount, ' +
           'Description1, Description2, OrderI.TaxRate, Condition, ' +
           'PriceSelect, SubDescription, SubDescription1, SubDescription2, ' +
           'SubDescription3, Category.Code ' +
           'From OrderI, MenuItem, Category ' +
           'Where OrderI.ItemCode = MenuItem.ItemCode and Category.Category=MenuItem.Category and ' +
           'Qty<>0 and (OrderI.Condition = 0 or (OrderI.Condition > 0 and OrderI.Price <> 0)) and ' +
           'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 if Not PrintZeroPriceItemOnInvoice then
    SQLStr := SQLStr + ' and OrderI.Price <> 0 ';

 SQLStr := SQLStr + 'Group By OrderI.ItemCode, OrderI.Price, OrderI.Discount, ' +
                    'Description1, Description2, OrderI.TaxRate, Condition, ' +
                    'PriceSelect, SubDescription, SubDescription1, SubDescription2, ' +
                    'SubDescription3, Category.Code ' +
                    'Order By Category.Code';
 OpenQuery(SQLStr);
 I := 1;
 with Query do
  begin
   while Not EOF do
    begin
     BillBuff[I].ItemCode := FieldByName('ItemCode').AsString;
     BillBuff[I].Description1 := FieldByName('Description1').AsString;
     BillBuff[I].Description2 := FieldByName('Description2').AsString;
     BillBuff[I].SubDescription := FieldByName('SubDescription').AsString;
     BillBuff[I].SubDescription1 := FieldByName('SubDescription1').AsString;
     BillBuff[I].SubDescription2 := FieldByName('SubDescription2').AsString;
     BillBuff[I].SubDescription3 := FieldByName('SubDescription3').AsString;
     BillBuff[I].Condition := FieldByName('Condition').Asinteger;
     BillBuff[I].PriceSelect := FieldByName('PriceSelect').AsInteger;
     BillBuff[I].Qty := FieldByName('Qty').AsFloat;
     BillBuff[I].Price := FieldByName('Price').AsFloat;
     BillBuff[I].TaxRate := FieldByName('TaxRate').AsFloat;
     BillBuff[I].Discount := FieldByName('Discount').AsFloat;
     Next; I := I + 1;
    end;
   Close;
  end;
end;

procedure TPrintInvoiceForm2.PrintOutPro;
var
 TxtFile: TextFile;
 Description, PrintStr, StrTemp, FileName, FieldName, LineStr, SQLStr: string;
 Amount, TaxRate, Qty, GST, DiscountRate, Discount, Price, DollarDiscount,
 RealPrice, ServiceCharge, OtherCharge, PaidAmount, Tips, Surcharge,
 TotalInvoice, CurrentGSTRate, RewardPoints, Balance: double;
 Loop, I, CharCount, PaperWidth, RoundFlag, VIPNo, DiscountKind: integer;
 Temp, Ch: string;
 CurrentPriceIncludesGST: boolean;
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
 DollarDiscount := Query.FieldByName('DollarDiscount').AsFloat;
 ServiceCharge := Query.FieldByName('ServiceCharge').AsFloat;
 OtherCharge := Query.FieldByName('OtherCharge').AsFloat;
 Tips := Query.FieldByName('Tips').AsFloat;
 Surcharge := Query.FieldByName('Surcharge').AsFloat;
 VIPNo := Query.FieldByName('VIPNo').AsInteger;
 CurrentPriceIncludesGST := Query.FieldByName('PriceIncludesGST').AsBoolean;
 CurrentGSTRate := Query.FieldByName('CurrentGSTRate').AsFloat;
 RewardPoints := Query.FieldByName('RewardPoints').AsFloat;
 DiscountKind := Query.FieldByName('DiscountKind').AsInteger;
 Query.Close;
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Qty    DESCRIPTION                AMOUNT';
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 ReadInvoiceData;
 Amount := 0; GST := 0; Discount := 0;
 for Loop := 1 to 500 do
  if (BillBuff[Loop].ItemCode <> '') and (BillBuff[Loop].Qty <> 0) then
     begin
      Qty := BillBuff[Loop].Qty;
      Price := BillBuff[Loop].Price;
      Amount := Amount + Price * Qty;
      TaxRate := BillBuff[Loop].TaxRate;
      if (DiscountKind <= 1) and (BillBuff[Loop].Discount>= 0.01) then
         begin
          DiscountRate := StrToFloat(Format('%6.4f', [BillBuff[Loop].Discount / 100]));
          RealPrice := Price * (1 - DiscountRate);
          Discount := Discount + (Price - RealPrice) * Qty;
          if CurrentPriceIncludesGST then
             GST := GST + RealPrice * Qty * (1 - 1 / (1 + TaxRate / 100))
            else
             GST := GST + RealPrice * Qty * TaxRate / 100;
         end
        else
         begin
          if CurrentPriceIncludesGST then
             GST := GST + Price * Qty * (1 - 1 / (1 + TaxRate / 100))
            else
             GST := GST + Price * Qty * TaxRate / 100;
         end;
      if (PrintInvoiceDescription <> 2) or (BillBuff[Loop].Description2 = '') then
         Description := BillBuff[Loop].Description1
        else
         Description := BillBuff[Loop].Description2;
      case BillBuff[Loop].PriceSelect of
       0: if BillBuff[Loop].SubDescription <> '' then
             Description := Description + ' / ' + BillBuff[Loop].SubDescription;
       1: if BillBuff[Loop].SubDescription1 <> '' then
             Description := Description + ' / ' + BillBuff[Loop].SubDescription1;
       2: if BillBuff[Loop].SubDescription2 <> '' then
             Description := Description + ' / ' + BillBuff[Loop].SubDescription2;
       3: if BillBuff[Loop].SubDescription3 <> '' then
             Description := Description + ' / ' + BillBuff[Loop].SubDescription3;
      end;
      case BillBuff[Loop].Condition of
       1: Description := '[*] ' + Description;
       2: Description := '[A] ' + Description;
       3: Description := '[C] ' + Description;
       4: Description := '[M] ' + Description;
       5: Description := '[L] ' + Description;
      end;
       if ABS(BillBuff[Loop].TaxRate) > 0 then
          Description := Copy(Description, 1, 25)
         else
          Description := '*' + Copy(Description, 1, 24);
      PrintStr := Format('%-7s', [FloatToStr(Qty)]) + Format('%-25s ', [Description]) + Format('%7.2m', [Price * Qty]);
      DataForm.OutPutToPrinter(PrintStr);
      if (PrintInvoiceDescription = 0) and (BillBuff[Loop].Description2 <> '') and
         (BillBuff[Loop].Description1 <> BillBuff[Loop].Description2) then
         begin
          Description := '       ' + Copy(BillBuff[Loop].Description2, 1, 25);
          DataForm.OutPutToPrinter(Description);
         end;
     if PrintDiscountRateOnBill and (DiscountKind <= 1) and (BillBuff[Loop].Discount >= 0.01) then
        begin
         PrintStr := 'Discount (' + FloatToStr(BillBuff[Loop].Discount) + '%) = ' +
                      FormatCurrency(0 - Price * Qty * BillBuff[Loop].Discount / 100);
         PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
         DataForm.OutPutToPrinter(PrintStr);
        end;
     end;
 DataForm.OutPutToPrinter(LineStr);
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
    GST := GST - RewardPoints * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    GST := GST - RewardPoints * CurrentGSTRate / 100;
 if CurrentPriceIncludesGST then
    GST := GST + (ServiceCharge + OtherCharge) * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    GST := GST + (ServiceCharge + OtherCharge) * CurrentGSTRate / 100;

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

procedure TPrintInvoiceForm2.PrintInvoicePro(OrderNo: string);
begin
 Application.CreateForm(TPrintInvoiceForm2, PrintInvoiceForm2);
 PrintInvoiceForm2.OrderNo := OrderNo;
 PrintInvoiceForm2.PrintOutPro;
 PrintInvoiceForm2.Free;
end;

end.
