unit PayOutList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, Grids, DBGrids, ExtCtrls, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TPayOutListForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    DateCheckBox: TCheckBox;
    DateEdit1: TMaskEdit;
    Label1: TLabel;
    DateEdit2: TMaskEdit;
    OperatorCheckBox: TCheckBox;
    OperatorEdit: TEdit;
    Label2: TLabel;
    TotalEdit: TStaticText;
    Query: TADOQuery;
    QueryPaymentDate: TDateTimeField;
    QueryAmount: TFloatField;
    QueryOpName: TStringField;
    QueryDescription: TStringField;
    QueryMachineID: TStringField;
    QueryID: TIntegerField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    SaveDialog: TSaveDialog;
    procedure OpenQuery;
    procedure CalcAmount;
    procedure DateCheckBoxClick(Sender: TObject);
    procedure OperatorCheckBoxClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure OperatorEditClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PayOutListPro;
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditButtonClick(Sender: TObject);
    function  DeleteRecordPro: boolean;
    procedure DeleteButtonClick(Sender: TObject);
    procedure PrintToPOSPrinter;
    procedure PrintToTextFile;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PayOutListForm: TPayOutListForm;

implementation

uses DatePanel, StaffList, MainMenu, UtilUnit, DataUnit, PrintCashPayOutReport,
     EditCashPayOut, MessageBox, PrintOption, DisplayMessage;

{$R *.DFM}

procedure TPayOutListForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From PayOutTable ';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + 'Where PaymentDate>=' +
    ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0')) +
    ' and PaymentDate<=' +
    ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59'));
 if OperatorCheckBox.Checked then
    begin
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and '
       else
        SQLStr := SQLStr + ' Where ';
     SQLStr := SQLStr + 'OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
    end;
 SQLStr := SQLStr + ' Order By PaymentDate, ID';
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

procedure TPayOutListForm.CalcAmount;
var
 Total: double;
begin
 Total := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     Total := Total + FieldByName('Amount').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;
 TotalEdit.Caption := FormatCurrency(Total) + ' ';
end;

procedure TPayOutListForm.DateCheckBoxClick(Sender: TObject);
begin
 if DateCheckBox.Checked then
    begin
     DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
     DateEdit2.Text := DateEdit1.Text;
     DateEdit1.Enabled := True;
     DateEdit2.Enabled := True;
    end
   else
    begin
     DateEdit1.Text := '';
     DateEdit2.Text := '';
     DateEdit1.Enabled := False;
     DateEdit2.Enabled := False;
    end
end;

procedure TPayOutListForm.OperatorCheckBoxClick(Sender: TObject);
begin
 if OperatorCheckBox.Checked then
    OperatorEdit.Enabled := True
   else
    begin
     OperatorEdit.Text := '';
     OperatorEdit.Enabled := False;
    end;
end;

procedure TPayOutListForm.DateEditClick(Sender: TObject);
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

procedure TPayOutListForm.OperatorEditClick(Sender: TObject);
var
 StaffName: string;
begin
 if StaffListForm.ListStaffPro(StaffName) then
    OperatorEdit.Text := StaffName;
end;

procedure TPayOutListForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
 CalcAmount;
end;

procedure TPayOutListForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TPayOutListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TPayOutListForm.EditButtonClick(Sender: TObject);
var
 ID: integer;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      ID := FieldByName('ID').AsInteger;
      if EditCashPayOutForm.EditCashPayOutPro(ID) then
         begin
          SearchButtonClick(Sender);
          Locate('ID', ID, [loPartialKey]);
         end;
     end;
end;

function TPayOutListForm.DeleteRecordPro: boolean;
var
 SQLStr: string;
begin
 Result := DataForm.BeginTransaction;
 if Result then
    try
     DisplayMessageForm.DisplayMessagePro('Update database, please wait...');
     DataForm.ExecCommand.CommandTimeout := 600;
     with Query do
      begin
       First;
       while Result and Not EOF do
        begin
         if DBGrid.SelectedRows.CurrentRowSelected then
            begin
             SQLStr := 'Delete From PayOutTable Where ID=' + IntToStr(FieldByName('ID').AsInteger);
             Result := DataForm.ExecQueryPro(SQLStr);
            end;
         Next;
        end;
      end;
     finally
      if Result then
         DataForm.CommitTransaction
        else
         DataForm.RollBack;
      DataForm.ExecCommand.CommandTimeout := 30;
      DisplayMessageForm.Close;
      DisplayMessageForm.Free;
     end;
end;

procedure TPayOutListForm.DeleteButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      if DBGrid.SelectedRows.Count = 0 then
         MessageBoxForm.MessagePro('There are no data has been selected.', sErrorMsg)
        else
         if MessageBoxForm.MessagePro('Are you sure you want to delete selected record(s)?', sConfirmMsg) = mrYes then
            begin
             DisableControls;
             if DeleteRecordPro then SearchButtonClick(Sender);
             EnableControls;
            end;
     end;
end;

procedure TPayOutListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
 PayOutListForm := NIL;
end;

procedure TPayOutListForm.PrintToPOSPrinter;
var
 PaperWidth, I: integer;
 PrintStr: string;
 TotalPayOut: double;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '           CASH PAYOUT REPORT';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 TotalPayOut := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     PrintStr := FormatDateTime('dd/mm/yyyy hh:mm:ss', FieldByName('PaymentDate').AsDateTime) +
                Format('%21s', [FieldByName('OpName').AsString]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     I := Length(FieldByName('MachineID').AsString + Format('%4.2m', [FieldByName('Amount').AsFloat]));
     PrintStr := FieldByName('MachineID').AsString + Format('%' + IntToStr(PaperWidth - I) + 's', ['']) +
                 Format('%4.2m', [FieldByName('Amount').AsFloat]);
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     PrintStr := FieldByName('Description').AsString;
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     DataForm.OutPutToPrinter(' ');
     TotalPayOut := TotalPayOut + FieldByName('Amount').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := Format('Total Payout:               %12.2m', [TotalPayOut]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := 'Print Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TPayOutListForm.PrintToTextFile;
var
 PrintStr, FileName: string;
 F: TextFile;
 TotalPayOut: double;
 PaperWidth: integer;
begin
 if Not SaveDialog.Execute then Exit;
 FileName := SaveDialog.FileName;
 AssignFile(F, FileName);
 Rewrite(F);
 PaperWidth := 109;
 PrintStr := 'CASH PAYOUT REPORT';
 PrintStr := Format('%' + IntToStr((PaperWidth - 18) div 2) + 's%s', ['', PrintStr]);
 Writeln(F, PrintStr);
 PrintStr := '-------------------------------------------------------------------------------------------------------------';
 Writeln(F, PrintStr);
 TotalPayOut := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     PrintStr := Format('%-20s %-15s %-10s %-50s %10s',
                 [FormatDateTime('dd/mm/yyyy hh:mm:ss', FieldByName('PaymentDate').AsDateTime),
                  FieldByName('OpName').AsString,
                  FieldByName('MachineID').AsString,
                  FieldByName('Description').AsString,
                  Format('%4.2m', [FieldByName('Amount').AsFloat])]);
     Writeln(F, PrintStr);
     TotalPayOut := TotalPayOut + FieldByName('Amount').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;
 PrintStr := '-------------------------------------------------------------------------------------------------------------';
 Writeln(F, PrintStr);
 PrintStr := Format('%109s', [Format('Total Payout: %4.2m', [TotalPayOut])]);
 Writeln(F, PrintStr);
 PrintStr := '-------------------------------------------------------------------------------------------------------------';
 Writeln(F, PrintStr);
 PrintStr := 'Print Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
 Writeln(F, PrintStr);
 CloseFile(F);
end;

procedure TPayOutListForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     case PrintOptionForm.OptionPro of
      0: PrintToPOSPrinter;
      1: PrintCashPayOutReportForm.PrintCashPayOutReportPro;
      2: PrintToTextFile;
     end;
end;

procedure TPayOutListForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 DateCheckBox.Checked := False;
 DateEdit1.Enabled := False;
 DateEdit2.Enabled := False;
 OperatorCheckBox.Checked := False;
 OperatorEdit.Enabled := False;
 EditButton.Enabled := Supervisor;
 DeleteButton.Enabled := Supervisor;
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
end;

procedure TPayOutListForm.PayOutListPro;
begin
 Application.CreateForm(TPayOutListForm, PayOutListForm);
 PayOutListForm.ShowModal;
 PayOutListForm.Free;
end;

end.
