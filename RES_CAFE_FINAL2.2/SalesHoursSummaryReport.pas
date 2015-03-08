unit SalesHoursSummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataUnit, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls, utilUnit,
  Buttons, Mask, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TSalesHoursSummaryReportForm = class(TForm)
    DBGrid: TDBGrid;
    Query: TADOQuery;
    DataSource: TDataSource;
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
    QuerySales: TFloatField;
    QueryHours: TIntegerField;
    QueryHoursString: TStringField;
    QueryDateString: TStringField;
    QueryYear: TIntegerField;
    QueryMonth: TIntegerField;
    QueryDay: TIntegerField;
    procedure OpenQuery;
    procedure DateEditClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SalesHoursSummaryReportPro;
    procedure PrintButtonClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SalesHoursSummaryReportForm: TSalesHoursSummaryReportForm;

implementation

uses DatePanel, MainMenu, PrintSalesHoursSummaryReport;

{$R *.dfm}

procedure TSalesHoursSummaryReportForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select DATEPART(Year, OrderDate) As Year, DATEPART(Month, OrderDate) As Month, ' +
           'DATEPART(Day, OrderDate) As Day, DATEPART(Hour, OrderDate) As Hours,  ' +
           'Sum(SalesAmount) As Sales ' +
           'From ' +
           '(Select OrderDate, Amount + ServiceCharge + OtherCharge As SalesAmount ' +
           'From OrderH Where (PriceIncludesGST <> 0) and ' +
           '(OrderDate >=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0')) + ') and ' +
           '(OrderDate <= ' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59:59')) + ') ' +
           'Union All ' +
           'Select OrderDate, Amount + ServiceCharge + OtherCharge + GST As SalesAmount ' +
           'From OrderH Where (PriceIncludesGST = 0) and ' +
           '(OrderDate >=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0')) + ') and ' +
           '(OrderDate <= ' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59:59')) + ') ' +
           ') As TempTable ' +
           ' Group By DATEPART(Year, OrderDate), DATEPART(Month, OrderDate), ' +
           ' DATEPART(Day, OrderDate), DATEPART(Hour, OrderDate)' +
           ' Order By DATEPART(Year, OrderDate), DATEPART(Month, OrderDate), ' +
           ' DATEPART(Day, OrderDate), DATEPART(Hour, OrderDate)';
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

procedure TSalesHoursSummaryReportForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  begin
   FieldByName('DateString').AsString :=
    Format('%2.2d', [FieldByName('Day').AsInteger]) + '/' +
    Format('%2.2d', [FieldByName('Month').AsInteger]) + '/' +
    Format('%4.4d', [FieldByName('Year').AsInteger]);
   FieldByName('HoursString').AsString :=
    FormatDateTime('hh:mm', StrToTime(FieldByName('Hours').AsString + ':00')) + ' - ' +
    FormatDateTime('hh:mm', StrToTime(FieldByName('Hours').AsString + ':59'));
  end;  
end;

procedure TSalesHoursSummaryReportForm.DateEditClick(Sender: TObject);
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

procedure TSalesHoursSummaryReportForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PrintSalesHoursSummaryReportForm.PrintSalesHoursSummaryReportPro;
end;

procedure TSalesHoursSummaryReportForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TSalesHoursSummaryReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesHoursSummaryReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TSalesHoursSummaryReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := DateEdit1.Text;
end;

procedure TSalesHoursSummaryReportForm.SalesHoursSummaryReportPro;
begin
 Application.CreateForm(TSalesHoursSummaryReportForm, SalesHoursSummaryReportForm);
 SalesHoursSummaryReportForm.ShowModal;
 SalesHoursSummaryReportForm.Free;
end;

end.
