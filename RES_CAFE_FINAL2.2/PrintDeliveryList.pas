unit PrintDeliveryList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, UtilUnit, ADODB;

type
  TPrintDeliveryListForm = class(TDataModule)
    Query: TADOQuery;
    procedure OpenQuery(DriverName: String);
    procedure PrintOutPro(DriverName: string);
    procedure PrintDeliveryListPro(DriverName: string);
  private { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintDeliveryListForm: TPrintDeliveryListForm;

implementation

uses DataUnit, MessageBox;

{$R *.DFM}

procedure TPrintDeliveryListForm.OpenQuery(DriverName: string);
var
 SQLStr: string;
begin
 SQLStr := 'Select VIPName, Telephone, OrderNo, Notes, ' +
           '(Amount + Tips + ServiceCharge + OtherCharge) As TotalAmount, ' +
           'Number, Address, Suburb, Postcode, State, MapReference ' +
           'From OrderH, VIPTable ' +
           'Where OrderH.VIPNo=VIPTable.VIPNo and Delivery=1 and ' +
           'OrderH.BillKind=' + IntToStr(sPHONEORDER) + ' and ' +
           'Amount + Tips + ServiceCharge + OtherCharge - PaidAmount >= 0.01 and ' +
           'Credit = 0 and PriceIncludesGST <> 0 and ' +
           'ServicePerson=' + Chr(39) + CheckQuotes(DriverName) + Chr(39) +
           ' Union All ' +
           'Select VIPName, Telephone, OrderNo, Notes, ' +
           '(Amount + Tips + ServiceCharge + OtherCharge + GST) As TotalAmount, ' +
           'Number, Address, Suburb, Postcode, State, MapReference ' +
           'From OrderH, VIPTable ' +
           'Where OrderH.VIPNo=VIPTable.VIPNo and Delivery=1 and ' +
           'OrderH.BillKind=' + IntToStr(sPHONEORDER) + ' and ' +
           'Amount + Tips + ServiceCharge + OtherCharge + GST - PaidAmount >= 0.01 and ' +
           'Credit = 0 and PriceIncludesGST = 0 and ' +
           'ServicePerson=' + Chr(39) + CheckQuotes(DriverName) + Chr(39) +
           ' Order By VIPName';
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

procedure TPrintDeliveryListForm.PrintOutPro(DriverName: string);
var
 PrintStr, LineStr, VIPAddress: string;
 Amount: double;
 I, PaperWidth: integer;
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
 PrintStr := 'DELIVERY LIST';
 PrintStr := Format('%' + IntToStr((PaperWidth - 26) div 4) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Deliver: ' + DriverName;
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Date / Time: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 Amount := 0;
 with Query do
  while Not EOF do
   begin
    PrintStr := FieldByName('OrderNo').AsString +
                Format('%30s', [FormatCurrency(FieldByName('TotalAmount').AsFloat)]);
    DataForm.OutPutToPrinter(PrintStr);
    PrintStr := FieldByName('VIPName').AsString;
    if Query.FieldByName('Telephone').AsString <> '' then
       PrintStr := PrintStr + ' (' + Query.FieldByName('Telephone').AsString + ')';
    DataForm.OutPutToPrinter(PrintStr);
    VIPAddress := '';
    if FieldByName('Number').AsString <> '' then
       VIPAddress := FieldByName('Number').AsString;
    if FieldByName('Address').AsString <> '' then
       begin
        if VIPAddress <> '' then VIPAddress := VIPAddress + ' ';
        VIPAddress := VIPAddress + FieldByName('Address').AsString;
       end; 
    if (FieldByName('Suburb').AsString <> '') or (FieldByName('State').AsString <> '') or
       (FieldByName('PostCode').AsString <> '') then
       begin
        if VIPAddress <> '' then VIPAddress := VIPAddress + Chr(13) + Chr(10);
        VIPAddress := VIPAddress + Query.FieldByName('Suburb').AsString + ' ' +
        FieldByName('State').AsString + ' ' + Query.FieldByName('PostCode').AsString;
       end;
    if Query.FieldByName('MapReference').AsString <> '' then
       begin
        if VIPAddress <> '' then VIPAddress := VIPAddress + Chr(13) + Chr(10);
        VIPAddress := VIPAddress + 'Map Ref: ' + Query.FieldByName('MapReference').AsString;
       end;
    if VIPAddress <> '' then
       begin
        DataForm.OutPutToPrinter('Address:');
        DataForm.OutPutToPrinter(VIPAddress);
       end;
    if Query.FieldByName('Notes').AsString <> '' then
       DataForm.OutPutToPrinter(Query.FieldByName('Notes').AsString);
    DataForm.OutPutToPrinter(' ');
    Amount := Amount + FieldByName('TotalAmount').AsFloat;
    Next;
   end;
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Total: ' + FormatCurrency(Amount);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TPrintDeliveryListForm.PrintDeliveryListPro(DriverName: string);
begin
 Application.CreateForm(TPrintDeliveryListForm, PrintDeliveryListForm);
 PrintDeliveryListForm.OpenQuery(DriverName);
 with PrintDeliveryListForm.Query do
  if Active and (RecordCount > 0) then
     PrintDeliveryListForm.PrintOutPro(DriverName)
    else
     MessageBoxForm.MessagePro('There are no any record be found!', sErrorMsg);
 PrintDeliveryListForm.Query.Close;
 PrintDeliveryListForm.Free;
end;

end.

