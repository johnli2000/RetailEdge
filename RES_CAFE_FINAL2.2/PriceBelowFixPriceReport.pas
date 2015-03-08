unit PriceBelowFixPriceReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, Db, StdCtrls, Buttons, Mask, UtilUnit,
  ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TPriceBelowFixPriceReportForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Label1: TLabel;
    DateEdit1: TMaskEdit;
    Label2: TLabel;
    DateEdit2: TMaskEdit;
    TimeEdit1: TMaskEdit;
    TimeEdit2: TMaskEdit;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    QueryOrderNo: TWideStringField;
    QueryOrderDate: TDateTimeField;
    QueryDescription1: TWideStringField;
    QuerySubDescription: TWideStringField;
    QueryQty: TFloatField;
    QuerySalesPrice: TFloatField;
    QueryFixPrice: TFloatField;
    QueryOrderOperator: TWideStringField;
    QueryDescription: TStringField;
    procedure OpenQuery(SQLStr: string);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SearchButtonClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure PriceBelowFixPriceReportPro;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEditClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PriceBelowFixPriceReportForm: TPriceBelowFixPriceReportForm;

implementation

uses DatePanel, SaleshistoryDetail, MainMenu, DataUnit, PrintSalesVoidReport,
     TimePanel, PrintPriceBelowFixPriceReport;

{$R *.DFM}

procedure TPriceBelowFixPriceReportForm.OpenQuery(SQLStr: string);
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

procedure TPriceBelowFixPriceReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TPriceBelowFixPriceReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
 PriceBelowFixPriceReportForm := NIL;
end;

procedure TPriceBelowFixPriceReportForm.SearchButtonClick(Sender: TObject);
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
 DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
 SQLStr := 'Select OrderH.OrderNo, OrderDate, Description1, SubDescription, ' +
           'OrderI.Qty, OrderI.Price As SalesPrice, OriginalPrice As FixPrice, ' +
           'OrderOperator ' +
           'From OrderH, OrderI, MenuItem ' +
           'Where OrderH.OrderNo=OrderI.OrderNo and ' +
           'OrderI.ItemCode=MenuItem.ItemCode and OrderI.Qty <> 0 and ' +
           'OrderI.Price < OriginalPrice and OriginalPrice >= 0.01 and ' +
           'OrderDate>=' + ConvertDateTime(DateTemp1) + ' and ' +
           'OrderDate<=' + ConvertDateTime(DateTemp2) +
           ' Order By OrderH.OrderNo';
 OpenQuery(SQLStr);
end;

procedure TPriceBelowFixPriceReportForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  if FieldByName('SubDescription').AsString <> '' then
     FieldByName('Description').AsString :=
             FieldByName('Description1').AsString + ' / ' + FieldByName('SubDescription').AsString
    else
     FieldByName('Description').AsString := FieldByName('Description1').AsString
end;

procedure TPriceBelowFixPriceReportForm.DateEditClick(Sender: TObject);
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

procedure TPriceBelowFixPriceReportForm.TimeEditClick(Sender: TObject);
var
 TimeStr: string;
begin
 with Sender As TMaskEdit do
  begin
   TimeStr := Text;
   if TimeForm.ReadTimePro(TimeStr) then
      Text := TimeStr;
  end;
end;

procedure TPriceBelowFixPriceReportForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit1.SetFocus;
end;

procedure TPriceBelowFixPriceReportForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit2.SetFocus;
end;

procedure TPriceBelowFixPriceReportForm.TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TPriceBelowFixPriceReportForm.TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TPriceBelowFixPriceReportForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TPriceBelowFixPriceReportForm.PrintButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
    PrintPriceBelowFixPriceReportForm.PrintPriceBelowFixPriceReportPro;
end;

procedure TPriceBelowFixPriceReportForm.DBGridDblClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     OrderNo := Query.FieldByName('OrderNo').AsString;
     SalesHistoryDetailForm.SalesDetailPro(OrderNo);
    end;
end;

procedure TPriceBelowFixPriceReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 QueryFixPrice.DisplayFormat := sCurrency + ',0.#0';
 QuerySalesPrice.DisplayFormat := sCurrency + ',0.#0';
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
 TimeEdit1.Text := '00:00';
 TimeEdit2.Text := '23:59';
end;

procedure TPriceBelowFixPriceReportForm.PriceBelowFixPriceReportPro;
begin
 Application.CreateForm(TPriceBelowFixPriceReportForm, PriceBelowFixPriceReportForm);
 PriceBelowFixPriceReportForm.ShowModal;
 PriceBelowFixPriceReportForm.Free;
end;

end.
