unit CurrentStockSalesMarginReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinCtrls, BusinessSkinForm, MainMenu, XiButton, DB, ADODB,
  Grids, DBGrids, DataUnit;

type
  TCurrentStockSalesMarginReportForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    DBGrid: TDBGrid;
    Query: TADOQuery;
    DataSource: TDataSource;
    QueryDescription1: TWideStringField;
    QuerySalesPrice: TFloatField;
    QuerySubDescription: TWideStringField;
    QueryPriceSelect: TIntegerField;
    QueryItemCode: TWideStringField;
    QueryCost: TFloatField;
    QueryMargin: TFloatField;
    QueryMarginPercentage: TFloatField;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    DetailButton: TXiButton;
    SearchButton: TXiButton;
    procedure OpenQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitButtonClick(Sender: TObject);
    procedure CurrentStockSalesMarginReportPro;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure PrintButtonClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure DetailButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CurrentStockSalesMarginReportForm: TCurrentStockSalesMarginReportForm;

implementation

uses PrintCurrentSalesMarginReport, CurrentSalesMarginDetail;

{$R *.dfm}

procedure TCurrentStockSalesMarginReportForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select Description1, SalesPrice, SubDescription, PriceSelect, ItemCode, ' +
           'Sum(SalesCost) As Cost ' +
           'From ' +
           '( ' +
           'Select MenuItem.ItemCode, Description1, Price As SalesPrice, PriceSelect, ' +
           'SubDescription, StockLinkTable.Measure, LastOrderPrice, ' +
           'StockLinkTable.Measure * (LastOrderPrice / StockTable.Measure) As SalesCost ' +
           'From StockLinkTable, StockTable, MenuItem ' +
           'Where  StockLinkTable.Code=StockTable.Code and StockLinkTable.ItemCode=MenuItem.ItemCode and ' +
           'PriceSelect = 0 ' +
           'Union All ' +
           'Select MenuItem.ItemCode, Description1, Price1 As SalesPrice, PriceSelect, ' +
           'SubDescription1 As SubDescription, StockLinkTable.Measure, LastOrderPrice, ' +
           'StockLinkTable.Measure * (LastOrderPrice / StockTable.Measure) As SalesCost ' +
           'From StockLinkTable, StockTable, MenuItem ' +
           'Where  StockLinkTable.Code=StockTable.Code and StockLinkTable.ItemCode=MenuItem.ItemCode and ' +
           'PriceSelect = 1 ' +
           'Union All ' +
           'Select MenuItem.ItemCode, Description1, Price2 As SalesPrice, PriceSelect, ' +
           'SubDescription2 As SubDescription, StockLinkTable.Measure, LastOrderPrice, ' +
           'StockLinkTable.Measure * (LastOrderPrice / StockTable.Measure) As SalesCost ' +
           'From StockLinkTable, StockTable, MenuItem ' +
           'Where  StockLinkTable.Code=StockTable.Code and StockLinkTable.ItemCode=MenuItem.ItemCode and ' +
           'PriceSelect = 2 ' +
           'Union All ' +
           'Select MenuItem.ItemCode, Description1, Price3 As SalesPrice, PriceSelect, ' +
           'SubDescription3 As SubDescription, StockLinkTable.Measure, LastOrderPrice, ' +
           'StockLinkTable.Measure * (LastOrderPrice / StockTable.Measure) As SalesCost ' +
           'From StockLinkTable, StockTable, MenuItem ' +
           'Where  StockLinkTable.Code=StockTable.Code and StockLinkTable.ItemCode=MenuItem.ItemCode and ' +
           'PriceSelect = 3 ' +
           ') As TempTable ' +
           'Group By Description1, PriceSelect, ItemCode, SubDescription, SalesPrice ' +
           'Order By ItemCode';
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

procedure TCurrentStockSalesMarginReportForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  begin
   FieldByName('Margin').AsFloat := FieldByName('SalesPrice').AsFloat - FieldByName('Cost').AsFloat;
   if FieldByName('SalesPrice').AsFloat >= 0.01 then
      FieldByName('MarginPercentage').AsFloat :=
       FieldByName('Margin').AsFloat / FieldByName('SalesPrice').AsFloat * 100
     else
       FieldByName('MarginPercentage').AsFloat := 0;
  end;
end;

procedure TCurrentStockSalesMarginReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 CurrentStockSalesMarginReportForm := Nil;
 Action := caFree;
end;

procedure TCurrentStockSalesMarginReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TCurrentStockSalesMarginReportForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PrintCurrentStockSalesReportForm.PrintCurrentStockSalesMarginReportPro;
end;

procedure TCurrentStockSalesMarginReportForm.DBGridDblClick(Sender: TObject);
begin
 DetailButtonClick(Sender);
end;

procedure TCurrentStockSalesMarginReportForm.DetailButtonClick(Sender: TObject);
var
 ItemCode: string;
 PriceSelect: integer;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      ItemCode := FieldByName('ItemCode').AsString;
      PriceSelect := FieldByName('PriceSelect').AsInteger;
      CurrentSalesMarginDetailForm.CurrentSalesMarginDetailPro(PriceSelect, ItemCode);
     end;
end;

procedure TCurrentStockSalesMarginReportForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TCurrentStockSalesMarginReportForm.CurrentStockSalesMarginReportPro;
begin
 if CurrentStockSalesMarginReportForm = NIL then
    CurrentStockSalesMarginReportForm := TCurrentStockSalesMarginReportForm.Create(Self)
   else
    bsBusinessSkinForm.WindowState := wsNormal;
end;

end.
