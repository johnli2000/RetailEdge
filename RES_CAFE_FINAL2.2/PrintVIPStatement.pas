unit PrintVIPStatement;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, UtilUnit, ADODB;

type
  TPrintVIPStatementForm = class(TDataModule)
    Query: TADOQuery;
    procedure OpenQuery(SQLStr: String);
    procedure PrintOutPro;
    procedure PrintVIPStatementPro(VIPNo: integer; Date1, Date2: string; NonBalance: boolean);
  private { Private declarations }
    VIPNo: Integer;
    Date1, Date2: string;
    NonBalance: boolean;
  public
    { Public declarations }
  end;

var
  PrintVIPStatementForm: TPrintVIPStatementForm;

implementation

uses DataUnit;

{$R *.DFM}

procedure TPrintVIPStatementForm.OpenQuery(SQLStr: String);
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

procedure TPrintVIPStatementForm.PrintOutPro;
var
 TxtFile: TextFile;
 PrintStr, FileName, LineStr, SQLStr: string;
 PaperWidth, I: integer;
 Total: double;
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
 SQLStr := 'Select * From VIPTable Where VIPNo=' + IntToStr(VIPNo);
 OpenQuery(SQLStr);
 with Query do
  begin
   PrintStr := 'Name: ' + FieldByName('VIPName').AsString;
   DataForm.OutPutToPrinter(PrintStr);
   if FieldByName('Telephone').AsString <> '' then
      begin
       PrintStr := 'Telephone: ' + FieldByName('Telephone').AsString;
       DataForm.OutPutToPrinter(PrintStr);
      end;
   if FieldByName('Fax').AsString <> '' then
      begin
       PrintStr := 'Fax: ' + FieldByName('Fax').AsString;
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
   DataForm.OutPutToPrinter(LineStr);
   Close;
  end;
 SQLStr := 'Select OrderDate, OrderNo, ' +
           '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge - PaidAmount) As Credit ' +
           'From OrderH Where (PriceIncludesGST <> 0) and VIPNo=' + IntToStr(VIPNo);
 if (Date1 <> '') and (Date2 <>'') then
     SQLStr := SQLStr + ' and OrderDate>=' +
              ConvertDateTime(TransferDate(Date1) + StrToTime('0:0:0')) +
              ' and OrderDate <=' +
              ConvertDateTime(TransferDate(Date2) + StrToTime('23:59:59'));
 if NonBalance then
    SQLStr := SQLStr + ' and (Amount + ServiceCharge + OtherCharge + Tips + Surcharge - PaidAmount) >= 0.01';
 SQLStr := SQLStr + ' Union All ' +
           'Select OrderDate, OrderNo, ' +
           '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST - PaidAmount) As Credit ' +
           'From OrderH Where (PriceIncludesGST = 0) and VIPNo=' + IntToStr(VIPNo);
 if (Date1 <> '') and (Date2 <>'') then
     SQLStr := SQLStr + ' and OrderDate>=' +
              ConvertDateTime(TransferDate(Date1) + StrToTime('0:0:0')) +
              ' and OrderDate <=' +
              ConvertDateTime(TransferDate(Date2) + StrToTime('23:59:59'));
 if NonBalance then
    SQLStr := SQLStr + ' and (Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST - PaidAmount) >= 0.01';
 SQLStr := SQLStr + ' Order By OrderDate, OrderNo';
 OpenQuery(SQLStr);
 PrintStr := 'Date          Order No.          BALANCE';
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 Total := 0;
 while Not Query.EOF do
  begin
   PrintStr := FormatDateTime('dd/mm/yyyy', Query.FieldByName('OrderDate').AsDateTime) +
               '    ' + Format('%-10s', [Query.FieldByName('OrderNo').AsString]) +
               Format('%16s', [FormatCurrency(Query.FieldByName('Credit').AsFloat)]);
   DataForm.OutPutToPrinter(PrintStr);
   Total := Total + Query.FieldByName('Credit').AsFloat;
   Query.Next;
   end;
 PrintStr := 'Total: ' + FormatCurrency(Total);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Print Date: ' + FormatDateTime('dd/mm/yyyy  hh:mm', Date + Time);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
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

procedure TPrintVIPStatementForm.PrintVIPStatementPro(VIPNo: Integer;
          Date1, Date2: string; NonBalance: boolean);
begin
 Application.CreateForm(TPrintVIPStatementForm, PrintVIPStatementForm);
 PrintVIPStatementForm.VIPNo := VIPNo;
 PrintVIPStatementForm.Date1 := Date1;
 PrintVIPStatementForm.Date2 := Date2;
 PrintVIPStatementForm.NonBalance := NonBalance;
 PrintVIPStatementForm.PrintOutPro;
 PrintVIPStatementForm.Free;
end;

end.

