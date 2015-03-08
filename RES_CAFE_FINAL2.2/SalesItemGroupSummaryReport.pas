unit SalesItemGroupSummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataUnit, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls, utilUnit,
  Buttons, Mask, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TSalesItemGroupSummaryReportForm = class(TForm)
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
    QueryItemGroup: TStringField;
    QueryAmount: TFloatField;
    SortComboBox: TComboBox;
    AscendingComboBox: TComboBox;
    procedure OpenQuery;
    procedure DateEditClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SalesItemGroupSummaryReportPro;
    procedure PrintButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SalesItemGroupSummaryReportForm: TSalesItemGroupSummaryReportForm;

implementation

uses DatePanel, MainMenu, PrintSalesItemGroupSummaryReport;

{$R *.dfm}

procedure TSalesItemGroupSummaryReportForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select MenuItem.ItemGroup, Sum(OrderI.Price * (1 - OrderI.Discount / 100) * Qty) As Amount ' +
           'From MenuItem, OrderI, OrderH  ' +
           'Where MenuItem.ItemCode = OrderI.ItemCode and ' +
           'OrderH.OrderNo = OrderI.OrderNo and ' +
           '(OrderDate >=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0')) + ') and ' +
           '(OrderDate <= ' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59:59')) + ') ' +
           'Group By MenuItem.ItemGroup';
 case SortComboBox.ItemIndex of
  0: SQLStr := SQLStr + ' Order By MenuItem.ItemGroup';
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

procedure TSalesItemGroupSummaryReportForm.DateEditClick(Sender: TObject);
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

procedure TSalesItemGroupSummaryReportForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PrintSalesItemGroupSummaryReportForm.PrintSalesItemGroupSummaryReportPro;
end;

procedure TSalesItemGroupSummaryReportForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TSalesItemGroupSummaryReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesItemGroupSummaryReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TSalesItemGroupSummaryReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridpanel.Width + 28;
 Height := SearchPanel.Height + SearchPanel.Top + 46;
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := DateEdit1.Text;
end;

procedure TSalesItemGroupSummaryReportForm.SalesItemGroupSummaryReportPro;
begin
 Application.CreateForm(TSalesItemGroupSummaryReportForm, SalesItemGroupSummaryReportForm);
 SalesItemGroupSummaryReportForm.ShowModal;
 SalesItemGroupSummaryReportForm.Free;
end;

end.
