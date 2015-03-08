unit ReceiptReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, Buttons, DataUnit, CommDrv, Grids, DBGrids, Mask,
  UtilUnit, TeeProcs, TeEngine, Chart, DBChart, Series, ADODB, bsSkinCtrls,
  BusinessSkinForm, XiButton;

type
  TReceiptReportForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    DateEdit1: TMaskEdit;
    TimeEdit1: TMaskEdit;
    Label6: TLabel;
    DateEdit2: TMaskEdit;
    TimeEdit2: TMaskEdit;
    OperatorCheckBox: TCheckBox;
    ComboBox: TComboBox;
    SalesComboBox: TComboBox;
    ReceiveEdit: TStaticText;
    RoundingEdit: TStaticText;
    Query: TADOQuery;
    ReceiveQuery: TADOQuery;
    ReceiveQueryPayBy: TStringField;
    ReceiveQueryAmount: TFloatField;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DetailPanel: TbsSkinPanel;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    procedure OpenQuery(SQLStr: string);
    procedure OpenReceiveQuery;
    procedure CalcAmount;
    procedure FormShow(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PrintOutPro;
    procedure PrintButtonClick(Sender: TObject);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SearchButtonClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure ReceiptReportPro;
    procedure OperatorCheckBoxClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure TimeEditClick(Sender: TObject);
  private { Private declarations }
    DateTime1, DateTime2: TDateTime;
    TotalReceive, TotalRounding: double;
  public
    { Public declarations }
  end;

var
  ReceiptReportForm: TReceiptReportForm;

implementation

uses ReceiptDetail, MainMenu, DatePanel, TimePanel;

{$R *.DFM}

procedure TReceiptReportForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit1.SetFocus;
end;

procedure TReceiptReportForm.TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TReceiptReportForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit2.SetFocus;
end;

procedure TReceiptReportForm.TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TReceiptReportForm.DateEditClick(Sender: TObject);
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

procedure TReceiptReportForm.TimeEditClick(Sender: TObject);
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

procedure TReceiptReportForm.OpenQuery(SQLStr: string);
begin
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

procedure TReceiptReportForm.OpenReceiveQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select TempTable.PayBy, Sum(TempTable.Amount) As Amount ' +
           'From ' +
           '(Select PayBy, RecvAcct.PaidAmount As Amount ' +
           'From RecvAcct, OrderH ' +
           'Where PayBy<>' + Chr(39) + 'Rounding' + Chr(39) +
           ' and AccountDate>=' + ConvertDateTime(DateTime1) +
           ' and AccountDate<=' + ConvertDateTime(DateTime2) +
           ' and OrderH.OrderNo=RecvAcct.OrderNo ';
 if SalesComboBox.ItemIndex = 1 then
    SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTABLEORDER)
   else
    if SalesComboBox.ItemIndex = 2 then
       SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE)
      else
       if SalesComboBox.ItemIndex = 3 then
          SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPHONEORDER);
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and RecvAcct.OPName=' + Chr(39) + CheckQuotes(ComboBox.Text) + Chr(39);
 SQLStr := SQLStr + ' Union All ' +
                    'Select PaymentMethod As PayBy, Amount From DepositTable ' +
                    'Where DepositDate>=' + ConvertDateTime(DateTime1) +
                    ' and DepositDate<=' + ConvertDateTime(DateTime2);
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and OPName=' + Chr(39) + CheckQuotes(ComboBox.Text) + Chr(39);
 SQLStr := SQLStr + ') As TempTable Group By TempTable.PayBy Order By TempTable.PayBy';
 Screen.Cursor := crHourGlass;
 with ReceiveQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;

procedure TReceiptReportForm.CalcAmount;
var
 SQLStr: string;
begin
 TotalReceive := 0;
 with ReceiveQuery do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     TotalReceive := TotalReceive + FieldByName('Amount').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;

 SQLStr := 'Select Sum(RecvAcct.PaidAmount) From RecvAcct ';
 if SalesComboBox.ItemIndex <> 0 then SQLStr := SQLStr + ', OrderH ';
 SQLStr := SQLStr + 'Where PayBy=' + Chr(39) + 'Rounding' + Chr(39) +
           ' and AccountDate>=' + ConvertDateTime(DateTime1) +
           ' and AccountDate<=' + ConvertDateTime(DateTime2);
 if SalesComboBox.ItemIndex > 0 then
    begin
     SQLStr := SQLStr + ' and RecvAcct.OrderNo=OrderH.OrderNo ';
     case SalesComboBox.ItemIndex of
      1: SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQUICKSALE);
      2: SQLStr := SQLStr + ' and BillKind<>' + IntToStr(sQUICKSALE);
     end;
    end;
 if OperatorCheckBox.Checked then
    SQLStr := SQLStr + ' and RecvAcct.OPName=' + Chr(39) + CheckQuotes(ComboBox.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   TotalRounding := Fields[0].AsFloat;
   Close;
  end;
 ReceiveEdit.Caption := FormatCurrency(TotalReceive) + ' ';
 RoundingEdit.Caption := FormatCurrency(0 - TotalRounding) + ' ';
end;

procedure TReceiptReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TReceiptReportForm.FormShow(Sender: TObject);
var
 SQLStr: string;
begin
 ReceiveQueryAmount.DisplayFormat := sCurrency + ',0.#0';
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
 TimeEdit1.Text := FormatDateTime('hh:mm', StrToTime('0:0'));
 TimeEdit2.Text := FormatDateTime('hh:mm', StrToTime('23:59'));
 SQLStr := 'Select StaffName From AccessMenu Order By StaffName';
 OpenQuery(SQLStr);
 while Not Query.EOF do
  begin
   ComboBox.Items.Add(Query.FieldByName('StaffName').AsString);
   Query.Next;
  end;
 Query.Close;
 OperatorCheckBox.Checked := False;
 ComboBox.Enabled := False;
 SalesComboBox.ItemIndex := 0;
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
end;

procedure TReceiptReportForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TReceiptReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 ReceiveQuery.Close;
 Action := caFree;
end;

procedure TReceiptReportForm.PrintOutPro;
var
 I, PaperWidth: integer;
 PrintStr: string;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '            Receipts  Report';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 with ReceiveQuery do
  begin
   First;
   while Not EOF do
    begin
     PrintStr := Format('%-28s%12.2f', [FieldByName('PayBy').AsString, FieldByName('Amount').AsFloat]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     Next;
    end;
  end;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := Format('Total Receive:              %12.2f', [TotalReceive]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := Format('Rounding Benefit:           %12.2f', [0 - TotalRounding]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Date:' +
     FormatdateTime('dd/mm/yyyy hh:mm', DateTime1) + '-' +
     FormatdateTime('dd/mm/yyyy hh:mm', DateTime2);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 if OperatorCheckBox.Checked then
    begin
     PrintStr := 'Operator: ' + ComboBox.Text;
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 for I :=1 to 2 do DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TReceiptReportForm.SearchButtonClick(Sender: TObject);
begin
 DateTime1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
 DateTime2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
 OpenReceiveQuery;
 CalcAmount;
end;

procedure TReceiptReportForm.PrintButtonClick(Sender: TObject);
begin
 PrintOutPro;
end;

procedure TReceiptReportForm.ReceiptReportPro;
begin
 Application.CreateForm(TReceiptReportForm, ReceiptReportForm);
 ReceiptReportForm.ShowModal;
 ReceiptReportForm.Free;
end;

procedure TReceiptReportForm.DBGridDblClick(Sender: TObject);
var
 OPName: string;
begin
 if OperatorCheckBox.Checked then
    OpName := ComboBox.Text
   else
    OpName := '';
 if ReceiveQuery.Active and (ReceiveQuery.RecordCount > 0) then
    ReceiptsDetailList.ReceiptDetailListPro(DateTime1, DateTime2,
                       ReceiveQuery.FieldByName('PayBy').AsString,
                       OpName, '', SalesComboBox.ItemIndex);
end;

procedure TReceiptReportForm.DateEdit1Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit1.Text) then
    DateEdit1.SetFocus;
end;

procedure TReceiptReportForm.DateEdit2Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit2.Text) then
    DateEdit2.SetFocus;
end;

procedure TReceiptReportForm.OperatorCheckBoxClick(Sender: TObject);
begin
 if OperatorCheckBox.Checked then
    begin
     ComboBox.ItemIndex := 0;
     ComboBox.Text := ComboBox.Items[0];
     ComboBox.Enabled := True
    end
   else
    begin
     ComboBox.ItemIndex := -1;
     ComboBox.Text := '';
     ComboBox.Enabled := False;
    end;
end;

end.
