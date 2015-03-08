unit PrintAttendanceReport;

interface

uses DataUnit, AttendanceRpt, SysUtils, UtilUnit;

procedure PrintAttendanceReportPro;

implementation

procedure PrintAttendanceReportPro;
var
 PrintStr, LineStr: string;
 Total: double;
 I, PaperWidth: integer;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40; Total := 0;
 LineStr := '';
 for I := 1 to PaperWidth do LineStr := LineStr + '-';
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Attendance Report';
 PrintStr := Format('%' + IntToStr((PaperWidth - Length(PrintStr)) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Staff Name               Hours      Wage';
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 with AttendanceReportForm.SummaryQuery do
  begin
   First;
   while Not EOF do
    begin
     PrintStr := Format('%-20s', [FieldByName('StaffName').AsString]) +
                 Format('%10.2f', [FieldByName('WorkHours').AsFloat]) +
                 Format('%10s', [FormatCurrency(FieldByName('Wage').AsFloat)]);
     DataForm.OutPutToPrinter(PrintStr);
     Total := Total + FieldByName('Wage').AsFloat;
     Next;
    end;
  end;
 PrintStr := 'Total Wage: ' + FormatCurrency(Total);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := 'Report Date:';
 DataForm.OutPutToPrinter(PrintStr);
 with AttendanceReportForm do
  PrintStr := DateEdit1.Text + ' ' + TimeEdit1.Text + ' - ' +
              DateEdit2.Text + ' ' + TimeEdit2.Text;
 DataForm.OutPutToPrinter(PrintStr);
 for I := 1 to 4 do DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

end.
