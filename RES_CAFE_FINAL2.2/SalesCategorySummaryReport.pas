unit SalesCategorySummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataUnit, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls, utilUnit,
  Buttons, Mask, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TSalesCategorySummaryReportForm = class(TForm)
    DBGrid: TDBGrid;
    Query: TADOQuery;
    DataSource: TDataSource;
    Label1: TLabel;
    DateEdit1: TMaskEdit;
    Label2: TLabel;
    DateEdit2: TMaskEdit;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    SearchPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    QueryCategory: TStringField;
    QueryAmount: TFloatField;
    SortComboBox: TComboBox;
    AscendingComboBox: TComboBox;
    procedure OpenQuery;
    procedure DateEditClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SalesCategorySummaryReportPro;
    procedure PrintButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SalesCategorySummaryReportForm: TSalesCategorySummaryReportForm;

implementation

uses DatePanel, MainMenu, PrintSalesCategorySummaryReport;

{$R *.dfm}

procedure TSalesCategorySummaryReportForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select Category.Category, Sum(OrderI.Price * (1 - OrderI.Discount / 100) * Qty) As Amount ' +
           'From Category, MenuItem, OrderH, OrderI  ' +
           'Where Category.Category=MenuItem.Category and ' +
           'MenuItem.ItemCode=OrderI.ItemCode and OrderI.OrderNo=OrderH.OrderNo and ' +
           '(OrderDate >=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0')) + ') and ' +
           '(OrderDate <= ' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59:59')) + ') ' +
           'Group By Category.Category';
 case SortComboBox.ItemIndex of
  0: SQLStr := SQLStr + ' Order By Category.Category';
  1: SQLStr := SQLStr + ' Order By Amount ';
 end;

 case AscendingComboBox.ItemIndex of
  0: SQLStr := SQLStr + ' ASC';
  1: SQLStr := SQLStr + ' DESC';
 end;
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

procedure TSalesCategorySummaryReportForm.DateEditClick(Sender: TObject);
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

procedure TSalesCategorySummaryReportForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PrintSalesCategorySummaryReportForm.PrintSalesCategorySummaryReportPro;
end;

procedure TSalesCategorySummaryReportForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TSalesCategorySummaryReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesCategorySummaryReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TSalesCategorySummaryReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := SearchPanel.Top + SearchPanel.Height + 46;
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := DateEdit1.Text;
end;

procedure TSalesCategorySummaryReportForm.SalesCategorySummaryReportPro;
begin
 Application.CreateForm(TSalesCategorySummaryReportForm, SalesCategorySummaryReportForm);
 SalesCategorySummaryReportForm.ShowModal;
 SalesCategorySummaryReportForm.Free;
end;

end.
