unit PrintJobListControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, UtilUnit, ADODB, Variants;
type
  TPrintJObListControlForm = class(TDataModule)
    Query: TADOQuery;
    procedure OpenQuery(SQLStr: String);
    procedure PrintJobListPro;
    procedure PrintJobListControlPro(OrderNo, IDStr: string; PrintAll, ConfirmedOrder: boolean);
  private { Private declarations }
    sOrderNo, sIDStr: string;
    sPrintAll, sConfirmedOrder: boolean;
  public
    { Public declarations }
  end;

var
  PrintJObListControlForm: TPrintJObListControlForm;

implementation

uses DataUnit, PrintJobCard, PrintJobCard1, PrintJobCard2, PrintJobCard3,
     PrintJobCard4, PrintJobCard5, PrintJobCard6;

{$R *.dfm}

procedure TPrintJobListControlForm.OpenQuery(SQLStr: String);
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

procedure TPrintJobListControlForm.PrintJobListPro;
var
 PrinterPort: integer;
 SQLStr: string;
begin
 if sConfirmedOrder then
    SQLStr := 'Select TableNo, Persons, ServicePerson, OrderDate, DueTime, ' +
              'BillKind, Delivery, OrderH.VIPNo, OpName, CustomerName, VIPName, ' +
              'Telephone, Number, Address, Suburb, State, PostCode, MapReference ' +
              'From OrderH Left Join ' +
              '(Select VIPNo, VIPName, Telephone, Number, Address, Suburb, ' +
              'State, MapReference, PostCode From VIPTable Where VIPNo >= 1) As VIPInfo ' +
              'On OrderH.VIPNo=VIPInfo.VIPNo ' +
              'Where OrderNo = ' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39)
   else
    SQLStr := 'Select CustomerName, OpName, HoldDate, Telephone, DueTime From HoldHead ' +
              'Where HoldNo = ' + sOrderNo;
 OpenQuery(SQLStr);
 for PrinterPort := 1 to 12 do
  if String(FVar.POSPrinter[PrinterPort].Name) <> 'N/A' then
     case JobListFormatForPrinter[PrinterPort] of
      0, 1: PrintJobListForm.PrintJobList(sOrderNo, sIDStr, sPrintAll, sConfirmedOrder, PrinterPort);
         2: PrintJobListForm1.PrintJobList(sOrderNo, sIDStr, sPrintAll, sConfirmedOrder, PrinterPort);
         3: PrintJobListForm2.PrintJobList(sOrderNo, sIDStr, sPrintAll, sConfirmedOrder, PrinterPort);
         4: PrintJobListForm3.PrintJobList(sOrderNo, sIDStr, sPrintAll, sConfirmedOrder, PrinterPort);
         5: PrintJobListForm4.PrintJobList(sOrderNo, sIDStr, sPrintAll, sConfirmedOrder, PrinterPort);
         6: PrintJobListForm5.PrintJobList(sOrderNo, sIDStr, sPrintAll, sConfirmedOrder, PrinterPort);
         7: PrintJobListForm6.PrintJobList(sOrderNo, sIDStr, sPrintAll, sConfirmedOrder, PrinterPort);
     end;
 Query.Close;
 if sConfirmedOrder then
    begin
     SQLStr := 'Update OrderI Set PrintFlag=1 Where OrderNo=' + Chr(39) + CheckQuotes(sOrderNo) + Chr(39);
     if Not sPrintAll and (sIDStr <> '') then SQLStr := SQLStr + ' and IDNo In (' + sIDSTr + ')';
    end
   else
    SQLStr := 'Update HoldItem Set Printed=1 Where HoldNo=' + sOrderNo;
 DataForm.ExecQueryPro(SQLStr);
end;

procedure TPrintJobListControlForm.PrintJobListControlPro(OrderNo, IDStr: string; PrintAll, ConfirmedOrder: boolean);
begin
 Application.CreateForm(TPrintJobListControlForm, PrintJobListControlForm);
 PrintJobListControlForm.sOrderNo := OrderNo;
 PrintJobListControlForm.sIDStr := IDStr;
 PrintJobListControlForm.sPrintAll := PrintAll;
 PrintJobListControlForm.sConfirmedOrder := ConfirmedOrder;
 PrintJobListControlForm.PrintJobListPro;
 PrintJobListControlForm.Free;
end;

end.
