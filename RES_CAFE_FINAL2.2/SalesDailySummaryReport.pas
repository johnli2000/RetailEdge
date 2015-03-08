unit SalesDailySummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataUnit, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls, utilUnit,
  Buttons, Mask, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TSalesDailySummaryReportForm = class(TForm)
    DBGrid: TDBGrid;
    Query: TADOQuery;
    DataSource: TDataSource;
    QuerySalesDate: TDateTimeField;
    QueryTotal: TFloatField;
    Label1: TLabel;
    DateEdit1: TMaskEdit;
    Label2: TLabel;
    DateEdit2: TMaskEdit;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    DatePanel: TbsSkinPanel;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    procedure OpenQuery;
    procedure DateEditClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SalesDailySummaryReportPro;
    procedure PrintButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SalesDailySummaryReportForm: TSalesDailySummaryReportForm;

implementation

uses DatePanel, MainMenu, PrintSalesDailySummaryReport;

{$R *.dfm}

procedure TSalesDailySummaryReportForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select Convert(DateTime, Convert(Char(12), OrderDate)) as SalesDate, ' +
           'Sum(SalesAmount) As Total ' +
           'From (Select OrderDate, Amount + ServiceCharge + OtherCharge As SalesAmount ' +
           'From OrderH Where (PriceIncludesGST <> 0) and ' +
           '(OrderDate >=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0')) + ') and ' +
           '(OrderDate <= ' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59:59')) + ') ' +
           'Union All ' +
           'Select OrderDate, Amount + ServiceCharge + OtherCharge + GST As SalesAmount ' +
           'From OrderH Where (PriceIncludesGST=0) and ' +
           '(OrderDate >=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0')) + ') and ' +
           '(OrderDate <= ' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59:59')) + ') ' +
           ') As TempTable ' +
           'Group By Convert(DateTime, Convert(Char(12), OrderDate)) ' +
           'Order By Convert(DateTime, Convert(Char(12), OrderDate))';
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;

procedure TSalesDailySummaryReportForm.DateEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   DateTemp := TransferDate(Text);
   if DateForm.ReadDatePro(DateTemp) then
      Text := FormatDateTime('dd/mm/yyyy', DateTemp);
  end;
end;

procedure TSalesDailySummaryReportForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PrintSalesDailySummaryReportForm.PrintSalesDailySummaryReportPro;
end;

procedure TSalesDailySummaryReportForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TSalesDailySummaryReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesDailySummaryReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TSalesDailySummaryReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + DatePanel.Width + 32;
 Height := DBGrid.Height + 54;
 QueryTotal.DisplayFormat := sCurrency + ',0.#0';
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := DateEdit1.Text;
end;

procedure TSalesDailySummaryReportForm.SalesDailySummaryReportPro;
begin
 Application.CreateForm(TSalesDailySummaryReportForm, SalesDailySummaryReportForm);
 SalesDailySummaryReportForm.ShowModal;
 SalesDailySummaryReportForm.Free;
end;

end.
