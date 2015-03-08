unit SalesVoidReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, Db, StdCtrls, Buttons, Mask, UtilUnit,
  ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TSalesVoidReportForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Label1: TLabel;
    DateEdit1: TMaskEdit;
    Label2: TLabel;
    DateEdit2: TMaskEdit;
    Label3: TLabel;
    AmountEdit: TStaticText;
    TimeEdit1: TMaskEdit;
    TimeEdit2: TMaskEdit;
    Query: TADOQuery;
    QueryOrderNo: TStringField;
    QueryOrderDate: TDateTimeField;
    QueryDescription1: TStringField;
    QueryDescription2: TStringField;
    QueryQty: TFloatField;
    QueryPrice: TFloatField;
    QueryAmount: TFloatField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    QueryOrderOperator: TStringField;
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
    procedure SalesVoidReportPro;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure CalcAmount;
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
  SalesVoidReportForm: TSalesVoidReportForm;

implementation

uses DatePanel, SaleshistoryDetail, MainMenu, DataUnit, PrintSalesVoidReport,
     TimePanel;

{$R *.DFM}

procedure TSalesVoidReportForm.OpenQuery(SQLStr: string);
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

procedure TSalesVoidReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesVoidReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
 SalesVoidReportForm := NIL;
end;

procedure TSalesVoidReportForm.SearchButtonClick(Sender: TObject);
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
 DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
 SQLStr := 'Select OrderH.OrderNo, OrderDate, Description1, Description2, ' +
           'ABS(OrderI.Qty) As Qty, OrderI.Price, OrderOperator ' +
           'From OrderH, OrderI, MenuItem ' +
           'Where OrderH.OrderNo=OrderI.OrderNo and ' +
           'OrderI.ItemCode=MenuItem.ItemCode and OrderI.Qty < 0 ' +
           ' and (SpecialOrder NOT Like ' + Chr(39) + 'Merge' + SearchMark + Chr(39) +
           ' Or SpecialOrder IS NULL) ' +
           ' and OrderDate>=' + ConvertDateTime(DateTemp1) +
           ' and OrderDate<=' + ConvertDateTime(DateTemp2) +
           ' Order By OrderH.OrderNo';
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0) then
    CalcAmount
   else
    AmountEdit.Caption := FormatCurrency(0.0) + ' ';
end;

procedure TSalesVoidReportForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  FieldByName('Amount').AsFloat :=
   FieldByName('Qty').AsFloat * FieldByName('Price').AsFloat;
end;

procedure TSalesVoidReportForm.CalcAmount;
var
 Amount: double;
begin
 Amount := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     Amount := Amount + FieldByname('Amount').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;
 AmountEdit.Caption := FormatCurrency(Amount) + ' ';
end;

procedure TSalesVoidReportForm.DateEditClick(Sender: TObject);
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

procedure TSalesVoidReportForm.TimeEditClick(Sender: TObject);
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

procedure TSalesVoidReportForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit1.SetFocus;
end;

procedure TSalesVoidReportForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit2.SetFocus;
end;

procedure TSalesVoidReportForm.TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TSalesVoidReportForm.TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TSalesVoidReportForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TSalesVoidReportForm.PrintButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
    PrintSalesVoidReportForm.PrintSalesVoidReportPro;
end;

procedure TSalesVoidReportForm.DBGridDblClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     OrderNo := Query.FieldByName('OrderNo').AsString;
     SalesHistoryDetailForm.SalesDetailPro(OrderNo);
    end;
end;

procedure TSalesVoidReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 QueryPrice.DisplayFormat := sCurrency + ',0.#0';
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
 TimeEdit1.Text := '00:00';
 TimeEdit2.Text := '23:59';
 AmountEdit.Caption := FormatCurrency(0.0) + ' ';
end;

procedure TSalesVoidReportForm.SalesVoidReportPro;
begin
 Application.CreateForm(TSalesVoidReportForm, SalesVoidReportForm);
 SalesVoidReportForm.ShowModal;
 SalesVoidReportForm.Free;
end;

end.
