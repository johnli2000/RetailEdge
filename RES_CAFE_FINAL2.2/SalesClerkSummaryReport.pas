unit SalesClerkSummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DataUnit, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls, utilUnit,
  Buttons, Mask, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TSalesClerkSummaryReportForm = class(TForm)
    DBGrid: TDBGrid;
    Query: TADOQuery;
    DataSource: TDataSource;
    Label1: TLabel;
    DateEdit1: TMaskEdit;
    Label2: TLabel;
    DateEdit2: TMaskEdit;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    bsSkinPanel1: TbsSkinPanel;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    QueryOpName: TStringField;
    QueryAmount: TFloatField;
    SortComboBox: TComboBox;
    AscendingComboBox: TComboBox;
    QueryWorkHours: TFloatField;
    QueryHourlySales: TFloatField;
    TimeEdit1: TMaskEdit;
    TimeEdit2: TMaskEdit;
    procedure OpenQuery;
    procedure DateEditClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SalesClerkSummaryReportPro;
    procedure PrintButtonClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SalesClerkSummaryReportForm: TSalesClerkSummaryReportForm;

implementation

uses DatePanel, MainMenu, PrintSalesClerkSummaryReport;

{$R *.dfm}

procedure TSalesClerkSummaryReportForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select OpName, Sum(OrderI.Price * (1 - OrderI.Discount / 100) * Qty) As Amount, ' +
           'TempTable.WorkTime As WorkHours ' +
           'From OrderI, OrderH Left Join ' +
           '(Select Attendance.StaffName, ' +
           'Sum(24 * (CAST(LogoutTime AS Float) - CAST(LoginTime As Float))) As WorkTime ' +
           'From Attendance ' +
           'Where LoginTime>=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text)) +
           ' and LoginTime<=' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text)) +
           ' Group By Attendance.StaffName) As TempTable On OrderH.OpName=TempTable.StaffName ' +
           'Where OrderI.OrderNo=OrderH.OrderNo and ' +
           '(OrderDate >=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text)) + ') and ' +
           '(OrderDate <= ' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text)) + ') ' +
           ' Group By OpName, TempTable.WorkTime';
 case SortComboBox.ItemIndex of
  0: SQLStr := SQLStr + ' Order By OpName';
  1: SQLStr := SQLStr + ' Order By Amount';
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

procedure TSalesClerkSummaryReportForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  if FieldByName('WorkHours').AsFloat >= 0.01 then
     FieldByName('HourlySales').AsFloat :=
      FieldByName('Amount').AsFloat / FieldByName('WorkHours').AsFloat;
end;

procedure TSalesClerkSummaryReportForm.DateEditClick(Sender: TObject);
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

procedure TSalesClerkSummaryReportForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PrintSalesClerkSummaryReportForm.PrintSalesClerkSummaryReportPro;
end;

procedure TSalesClerkSummaryReportForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TSalesClerkSummaryReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesClerkSummaryReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TSalesClerkSummaryReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryHourlySales.DisplayFormat := sCurrency + ',0.#0';
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := DateEdit1.Text;
 TimeEdit1.Text := FormatDateTime('hh:mm', BeginTime);
 TimeEdit2.Text := FormatDateTime('hh:mm', EndTime);
end;

procedure TSalesClerkSummaryReportForm.SalesClerkSummaryReportPro;
begin
 Application.CreateForm(TSalesClerkSummaryReportForm, SalesClerkSummaryReportForm);
 SalesClerkSummaryReportForm.ShowModal;
 SalesClerkSummaryReportForm.Free;
end;

end.
