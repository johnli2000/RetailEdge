unit PrintPickupSlip;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, UtilUnit, ADODB;

type
  TPrintPickupSlipForm = class(TDataModule)
    Query: TADOQuery;
    procedure OpenQuery(SQLStr: String);
    procedure PrintOutPro;
    procedure PrintPickupSlipPro(OrderNo: string);
  private { Private declarations }
    OrderNo: string;
  public
    { Public declarations }
  end;

var
  PrintPickupSlipForm: TPrintPickupSlipForm;

implementation

uses DataUnit;

{$R *.DFM}

procedure TPrintPickupSlipForm.OpenQuery(SQLStr: String);
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

procedure TPrintPickupSlipForm.PrintOutPro;
var
 PrintStr, SQLStr, CustomerName, Telephone, CompanyName: string;
 OrderDate: TDateTime;
 StrLength, PaperWidth: integer;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);

 PaperWidth := 40;
 DataForm.OpenCompanyQuery;
 CompanyName := DataForm.CompanyQuery.FieldByName('CompanyName').AsString;
 DataForm.CompanyQuery.Close;

 SQLStr := 'Select OrderDate, CustomerName, Telephone ' +
           'From OrderH Left Join VIPTable ' +
           'On OrderH.VIPNo = VIPTable.VIPNo ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   OrderDate := FieldByName('OrderDate').AsDateTime;
   CustomerName := FieldByName('CustomerName').AsString;
   Telephone := FieldByName('Telephone').AsString;
   Close;
  end;

 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter('========================================');
 DataForm.OutPutToPrinter(' ');

 StrLength := Length(CompanyName);
 if StrLength <= 20 then
    begin
     DataForm.SetBlackFontB;
     StrLength := (20 - StrLength) div 2;
     PrintStr := Format('%' + IntToStr(StrLength) + 's%s', ['', CompanyName]);
     DataForm.OutPutToPrinter(PrintStr);
    end
   else
    begin
     DataForm.SetBlackFontA;
     if StrLength < PaperWidth then
        StrLength := (PaperWidth - StrLength) div 2
       else
        StrLength := 0;
     PrintStr := Format('%' + IntToStr(StrLength) + 's%s', ['', CompanyName]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(' ');
 PrintStr := FormatDateTime('dd/mm/yyyy hh:mmAM/PM', OrderDate);
 PrintStr := Format('%' + IntToStr((PaperWidth - Length(PrintStr)) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(' ');

 if Not OnlyPrintLastTwoDigitalOrderNo then
    PrintStr := '# ' + Copy(OrderNo, 7, 4)
   else
    PrintStr := '# ' + Copy(OrderNo, 9, 2);
 PrintStr := Format('%' + IntToStr((20 - Length(PrintStr) div 2) div 2) + 's%s', ['', PrintStr]);
 DataForm.SetBlackFontC;
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontB;
 if CustomerName <> '' then
    begin
     DataForm.OutPutToPrinter(' ');
     PrintStr := CustomerName;
     PrintStr := Format('%' + IntToStr((20 - Length(PrintStr) div 2) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 if Telephone <> '' then
    begin
     DataForm.OutPutToPrinter(' ');
     PrintStr := 'Tel: ' + Telephone;
     PrintStr := Format('%' + IntToStr((20 - Length(PrintStr) div 2) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter('========================================');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TPrintPickupSlipForm.PrintPickupSlipPro(OrderNo: string);
begin
 Application.CreateForm(TPrintPickupSlipForm, PrintPickupSlipForm);
 PrintPickupSlipForm.OrderNo := OrderNo;
 PrintPickupSlipForm.PrintOutPro;
 PrintPickupSlipForm.Free;
end;

end.

