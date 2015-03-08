unit SalesStatistics;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, Mask, DataUnit,
  UtilUnit, DBCtrls, ADODB, bsSkinCtrls, BusinessSkinForm, XiButton,
  SUIDBCtrls;

type
  TSalesStatisticsForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    DateEdit1: TMaskEdit;
    TimeEdit1: TMaskEdit;
    Label1: TLabel;
    DateEdit2: TMaskEdit;
    TimeEdit2: TMaskEdit;
    SortComboBox: TComboBox;
    CategoryCheckBox: TCheckBox;
    DBLookupBox: TDBLookupComboBox;
    CategoryDataSource: TDataSource;
    Label2: TLabel;
    MachineIDCheckBox: TCheckBox;
    MachineIDEdit: TEdit;
    Query: TADOQuery;
    QueryItemCode: TStringField;
    QueryDescription1: TStringField;
    QueryDescription2: TStringField;
    QueryTotalQty: TFloatField;
    QueryAmount: TFloatField;
    CategoryQuery: TADOQuery;
    CategoryQueryCategory: TStringField;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    ChartButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    AscendingComboBox: TComboBox;
    presetDCcheckBox: TCheckBox;
    DiscountQuery: TADOQuery;
    DBLookupComboBox1: TDBLookupComboBox;
    DiscountDataSource: TDataSource;
    procedure OpenCategoryQuery;
    procedure OpenQuery;
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DateEditClick(Sender: TObject);
    procedure TimeEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SalesStatisticsPro;
    procedure PrintButtonClick(Sender: TObject);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure ChartButtonClick(Sender: TObject);
    procedure CategoryCheckBoxClick(Sender: TObject);
    procedure MachineIDCheckBoxClick(Sender: TObject);
    procedure MachineIDEditClick(Sender: TObject);
    procedure PrintOutToPrinter;
    procedure OpenDiscountQuery;
    procedure presetDCcheckBoxClick(Sender: TObject);
  private { Private declarations }
    DateTime1, DateTime2: TDateTime;
    presetCode : string;
  public
    { Public declarations }
  end;

var
  SalesStatisticsForm: TSalesStatisticsForm;

implementation

uses PrintSalesStatisticsReport, ItemStatistics, MainMenu, TimePanel, DatePanel,
     MachineIDSelect, ItemSalesPrintOption;

{$R *.DFM}

procedure TSalesStatisticsForm.OpenCategoryQuery;
var
 SQLStr: string;
begin
 Screen.Cursor := crHourGlass;
 SQLStr := 'Select * From Category Order By Category';
 with CategoryQuery do
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

procedure TSalesStatisticsForm.OpenDiscountQuery;
var
  SQLStr : string;
begin
   Screen.Cursor := crHourGlass;
 SQLStr := 'Select Code,Description From DiscountRateTable Order By Description';
 with DiscountQuery do
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

procedure TSalesStatisticsForm.OpenQuery;
var
 SQLStr: string;
begin
 Screen.Cursor := crHourGlass;
 DateTime1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
 DateTime2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
 SQLStr := 'Select OrderI.ItemCode, Description1, Description2, Sum(Qty) As TotalQty, ' +
           'Sum(OrderI.Price * (1 - OrderI.Discount / 100) * Qty) As Amount ' +
           'From MenuItem, OrderI, OrderH ' +
           'Where MenuItem.ItemCode=OrderI.ItemCode ' +
           'and OrderH.OrderNo=OrderI.OrderNo and Instruction=0 ' +
           ' and OrderDate>=' + ConvertDateTime(DateTime1) +
           ' and OrderDate <=' + ConvertDateTime(DateTime2);
 if MachineIDCheckBox.Checked then
    SQLStr := SQLStr + ' and MachineID=' +
              Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39);
 if CategoryCheckBox.Checked then
    SQLStr := SQLStr + ' and MenuItem.Category=' +  Chr(39) + CheckQuotes(DBLookupBox.Text) + Chr(39);
 if presetDCcheckBox.Checked then
    SQLStr := SQLStr + ' and OrderH.presetDiscountCode = ' + Chr(39) + DBLookupComboBox1.Text + Chr(39);
 SQLStr := SQLStr + ' Group By OrderI.ItemCode, Description1, Description2 having Sum(Qty) > 0';
 case SortComboBox.ItemIndex of
  0: SQLStr := SQLStr + ' Order By OrderI.ItemCode';
  1: SQLStr := SQLStr + ' Order By Sum(Qty)';
  2: SQLStr := SQLStr + ' Order By Sum(OrderI.Price * (1 - OrderI.Discount / 100) * Qty)';
 end;

 case AscendingComboBox.ItemIndex of
  0: SQLStr := SQLStr + ' ASC';
  1: SQLStr := SQLStr + ' DESC';
 end;

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

procedure TSalesStatisticsForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit1.SetFocus;
end;

procedure TSalesStatisticsForm.TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TSalesStatisticsForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit2.SetFocus;
end;

procedure TSalesStatisticsForm.TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TSalesStatisticsForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TSalesStatisticsForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TSalesStatisticsForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesStatisticsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 CategoryQuery.Close;
 Action := caFree;
end;

procedure TSalesStatisticsForm.PrintButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
  begin
    case ItemSalesPrintOptionForm.OptionPro of
          0: PrintOutToPrinter;
          //1: PrintSimpleReport;
          //2: PrintDailyReportA4PaperForm.PrintDailyReportToA4PaperPro;
          2: PrintSalesStatisticsReportForm.PrintSalesStatisticsReportPro;
          //3: PrintOutToFile;
  end;       end;

end;

procedure TSalesStatisticsForm.DateEdit1Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit1.Text) then
    DateEdit1.SetFocus;
end;

procedure TSalesStatisticsForm.DateEdit2Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit2.Text) then
    DateEdit2.SetFocus;
end;

procedure TSalesStatisticsForm.ChartButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
    ItemStatisticsForm.StatisticsPro;
end;

procedure TSalesStatisticsForm.DateEditClick(Sender: TObject);
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

procedure TSalesStatisticsForm.TimeEditClick(Sender: TObject);
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

procedure TSalesStatisticsForm.CategoryCheckBoxClick(Sender: TObject);
begin
 if CategoryCheckBox.Checked then
    begin
     OpenCategoryQuery;
     DBLookupBox.KeyValue := CategoryQuery.FieldByName('Category').AsString;
    end
   else
    CategoryQuery.Close;
end;

procedure TSalesStatisticsForm.MachineIDCheckBoxClick(Sender: TObject);
begin
 if MachineIDCheckBox.Checked then
    begin
     MachineIDEdit.Enabled := True;
     MachineIDEdit.SetFocus;
    end
   else
    begin
     MachineIDEdit.Text := '';
     MachineIDEdit.Enabled := False;
    end;
end;

procedure TSalesStatisticsForm.MachineIDEditClick(Sender: TObject);
var
 MachineName: string;
begin
 if MachineIDSelectForm.MachineIDSelectPro(MachineName) then
    MachineIDEdit.Text := MachineName;
end;

procedure TSalesStatisticsForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
 TimeEdit1.Text := '00:00'; TimeEdit2.Text := '23:59';
 SortComboBox.ItemIndex := 0;
 SortComboBox.Text := SortComboBox.Items[0];
 CategoryCheckBox.Checked := False;
end;

procedure TSalesStatisticsForm.SalesStatisticsPro;
begin
 Application.CreateForm(TSalesStatisticsForm, SalesStatisticsForm);
 SalesStatisticsForm.ShowModal;
 SalesStatisticsForm.Free;
end;

procedure TSalesStatisticsForm.PrintOutToPrinter;
var
 PaperWidth: integer;
 PrintStr, TempStr: string;
 //Amount: double;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '           Item Sales Summary Report';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Description                         Qty';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 //Amount := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     TempStr := Copy(FieldByName('Description1').AsString, 1, 20);
     PrintStr := Format('%-30s%10.2f',
      [TempStr, FieldByName('TotalQty').AsFloat]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     //Amount := Amount + FieldByName('Amount').AsFloat;
     Next;
    end;
 end;

 PrintStr := '                                        ';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := 'Report Date:';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := DateEdit1.Text +  ' - ' + DateEdit2.Text ;
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 if PrintDateOnDailyReport then
    begin
     PrintStr := 'Print Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TSalesStatisticsForm.presetDCcheckBoxClick(Sender: TObject);
begin
 if presetDCcheckBox.Checked then
    begin
     OpenDiscountQuery;
     DBLookupComboBox1.KeyValue := DiscountQuery.FieldByName('Description').AsString;
    end
   else
    DiscountQuery.Close;
end;


end.
