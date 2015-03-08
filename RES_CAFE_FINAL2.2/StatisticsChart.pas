unit StatisticsChart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, TeeProcs, TeEngine, Chart, DBChart, StdCtrls, Buttons, Mask,
  Series, Db, DataUnit, UtilUnit, ADODB, XiButton, bsSkinCtrls,
  BusinessSkinForm;

type
  TStatisticsChartForm = class(TForm)
    DBChart: TDBChart;
    Series: TBarSeries;
    ComboBox: TComboBox;
    Label1: TLabel;
    DateEdit1: TMaskEdit;
    Label2: TLabel;
    DateEdit2: TMaskEdit;
    Label3: TLabel;
    Query: TADOQuery;
    CalcButton: TXiButton;
    ExitButton: TXiButton;
    bsSkinPanel1: TbsSkinPanel;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    procedure OpenQuery(SQLStr: string);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CalcButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DateEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StatisticsPro;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StatisticsChartForm: TStatisticsChartForm;

implementation

uses MainMenu, DatePanel;

{$R *.DFM}

procedure TStatisticsChartForm.OpenQuery(SQLStr: string);
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

procedure TStatisticsChartForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TStatisticsChartForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then CalcButton.SetFocus;
end;

procedure TStatisticsChartForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TStatisticsChartForm.DateEditClick(Sender: TObject);
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

procedure TStatisticsChartForm.ComboBoxChange(Sender: TObject);
begin
 case ComboBox.ItemIndex of
  0: DBChart.BottomAxis.Title.Caption := 'Time';
  1: DBChart.BottomAxis.Title.Caption := 'Day';
  2: DBChart.BottomAxis.Title.Caption := 'Month';
 end;
end;

procedure TStatisticsChartForm.CalcButtonClick(Sender: TObject);
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime('00:00:01');
 DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime('23:59:59');
 case ComboBox.ItemIndex of
  0: SQLStr := 'Select Sum(Amount) As Y, DATEPART(Hour, TransferDateTime) As X From InvoiceHead ' +
               'Where TransferDateTime>=' + ConvertDateTime(DateTemp1) +
               ' and TransferDateTime<=' + ConvertDateTime(DateTemp2) +
               ' and KindFlag <> ' + sStockTransferOutFlag +
               ' Group By DATEPART(Hour, TransferDateTime)';
  1: SQLStr := 'Select Sum(Amount) As Y, DATEPART(Day, InvoiceDate) As X From InvoiceHead ' +
               'Where TransferDateTime>=' + ConvertDateTime(DateTemp1 ) +
               ' and TransferDateTime<=' + ConvertDateTime(DateTemp2) +
               ' and KindFlag <> ' + sStockTransferOutFlag +
               ' Group By DATEPART(Day, InvoiceDate)';
  2: SQLStr := 'Select Sum(Amount) As Y, DATEPART(Month, InvoiceDate) As X From InvoiceHead ' +
               'Where TransferDateTime>=' + ConvertDateTime(DateTemp1) +
               ' and TransferDateTime<=' + ConvertDateTime(DateTemp2) +
               ' and KindFlag <> ' + sStockTransferOutFlag +
               ' Group By DATEPART(Month, InvoiceDate)';
 end;
 OpenQuery(SQLStr);
end;

procedure TStatisticsChartForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TStatisticsChartForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TStatisticsChartForm.FormShow(Sender: TObject);
begin
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
 ComboBox.ItemIndex := 0;
 ComboBox.Text := ComboBox.Items[0];
end;

procedure TStatisticsChartForm.StatisticsPro;
begin
 Application.CreateForm(TStatisticsChartForm, StatisticsChartForm);
 StatisticsChartForm.ShowModal;
 StatisticsChartForm.Free;
end;

end.
