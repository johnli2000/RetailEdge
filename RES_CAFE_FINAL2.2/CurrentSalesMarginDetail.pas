unit CurrentSalesMarginDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinCtrls, DB, ADODB, Grids, DBGrids, MainMenu, UtilUnit,
  BusinessSkinForm, XiButton, StdCtrls;

type
  TCurrentSalesMarginDetailForm = class(TForm)
    DBGridPanel: TbsSkinPanel;
    DBGrid: TDBGrid;
    Query: TADOQuery;
    DataSource: TDataSource;
    QueryCode: TWideStringField;
    QueryDescription: TWideStringField;
    QueryStockMeasure: TFloatField;
    QueryMeasureKind: TSmallintField;
    QueryMeasure: TFloatField;
    QueryLastOrderPrice: TFloatField;
    QuerySalesCost: TFloatField;
    QueryStockMeasureDescription: TStringField;
    QuerySalesMeasureDescription: TStringField;
    ExitButton: TXiButton;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    SalesCostLabel: TbsSkinStdLabel;
    procedure OpenQuery(SQLStr: string);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CurrentSalesMarginDetailPro(PriceSelect: integer; ItemCode: string);
  private { Private declarations }
     PriceSelect: integer;
     ItemCode: string;
  public
    { Public declarations }
  end;

var
  CurrentSalesMarginDetailForm: TCurrentSalesMarginDetailForm;

implementation

uses DataUnit;

{$R *.dfm}

procedure TCurrentSalesMarginDetailForm.OpenQuery(SQLStr: string);
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

procedure TCurrentSalesMarginDetailForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  case FieldByName('MeasureKind').AsInteger of
   0: begin
       FieldByName('StockMeasureDescription').AsString := FieldByName('StockMeasure').AsString + ' Bottle';;
       FieldByName('SalesMeasureDescription').AsString := FieldByName('Measure').AsString + ' Bottle';
      end;
   1: begin
       FieldByName('StockMeasureDescription').AsString := FieldByName('StockMeasure').AsString + ' Box';
       FieldByName('SalesMeasureDescription').AsString := FieldByName('Measure').AsString + ' Box';
      end;
   2: begin
       FieldByName('StockMeasureDescription').AsString := FieldByName('StockMeasure').AsString + ' Glass';
       FieldByName('SalesMeasureDescription').AsString := FieldByName('Measure').AsString + ' Glass';
      end;
   3: begin
       FieldByName('StockMeasureDescription').AsString := FieldByName('StockMeasure').AsString + ' Piece';
       FieldByName('SalesMeasureDescription').AsString := FieldByName('Measure').AsString + ' Piece';
      end;
   4: begin
       FieldByName('StockMeasureDescription').AsString := FieldByName('StockMeasure').AsString + ' Gramme';
       FieldByName('SalesMeasureDescription').AsString := FieldByName('Measure').AsString + ' Gramme';
      end;
   5: begin
       FieldByName('StockMeasureDescription').AsString := FieldByName('StockMeasure').AsString + ' Kilogram';
       FieldByName('SalesMeasureDescription').AsString := FieldByName('Measure').AsString + ' Kilogram';
      end;
   6: begin
       FieldByName('StockMeasureDescription').AsString := FieldByName('StockMeasure').AsString + ' Millilitre';
       FieldByName('SalesMeasureDescription').AsString := FieldByName('Measure').AsString + ' Millilitre';
      end;
   7: begin
       FieldByName('StockMeasureDescription').AsString := FieldByName('StockMeasure').AsString + ' Litre';
       FieldByName('SalesMeasureDescription').AsString := FieldByName('Measure').AsString + ' Litre';
      end;
   8: begin
       FieldByName('StockMeasureDescription').AsString := FieldByName('StockMeasure').AsString + ' Others';
       FieldByName('SalesMeasureDescription').AsString := FieldByName('Measure').AsString + ' Other';
      end;
  end;
end;

procedure TCurrentSalesMarginDetailForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TCurrentSalesMarginDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TCurrentSalesMarginDetailForm.FormShow(Sender: TObject);
var
 SQLStr: string;
 TotalCost: double;
begin
 SQLStr := 'Select StockTable.Code, Description, StockTable.Measure As StockMeasure, ' +
           'StockTable.MeasureKind,StockLinkTable.Measure, LastOrderPrice, ' +
           'StockLinkTable.Measure * (LastOrderPrice / StockTable.Measure) As SalesCost ' +
           'From StockLinkTable, StockTable ' +
           'Where StockLinkTable.Code=StockTable.Code and PriceSelect = ' + IntToStr(PriceSelect) + ' and ' +
           'StockLinkTable.ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
           ' Order By StockTable.Code';
 OpenQuery(SQLStr);
 TotalCost := 0;
 with Query do
  begin
   First;
   while Not EOF do
    begin
     TotalCost := TotalCost + FieldByName('SalesCost').AsFloat;
     Next;
    end;
  end;
 SalesCostLabel.Caption := Format('Total Cost: %6.4m', [TotalCost]);
end;

procedure TCurrentSalesMarginDetailForm.CurrentSalesMarginDetailPro(PriceSelect: integer; ItemCode: string);
begin
 Application.CreateForm(TCurrentSalesMarginDetailForm, CurrentSalesMarginDetailForm);
 CurrentSalesMarginDetailForm.PriceSelect := PriceSelect;
 CurrentSalesMarginDetailForm.ItemCode := ItemCode;
 CurrentSalesMarginDetailForm.ShowModal;
 CurrentSalesMarginDetailForm.Free;
end;

end.
