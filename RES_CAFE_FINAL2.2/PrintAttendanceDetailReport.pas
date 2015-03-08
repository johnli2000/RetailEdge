unit PrintAttendanceDetailReport;

interface

uses DataUnit, AttendanceRpt, SysUtils, Variants;

procedure PrintAttendanceDetailReportPro;

implementation

procedure PrintAttendanceDetailReportPro;
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
 PrintStr := 'Attendance Detail Report';
 PrintStr := Format('%' + IntToStr((PaperWidth - Length(PrintStr)) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 with AttendanceReportForm do
  begin
   PrintStr := 'Staff Name: ' + AttendanceReportForm.SummaryQuery.FieldByName('StaffName').AsString;
   DataForm.OutPutToPrinter(PrintStr);
   PrintStr := DateEdit1.Text + ' ' + TimeEdit1.Text + ' - ' + DateEdit2.Text + ' ' + TimeEdit2.Text;
   DataForm.OutPutToPrinter(PrintStr);
  end;
 DataForm.OutPutToPrinter(LineStr);
 with AttendanceReportForm.DetailQuery do
  begin
   First;
   while Not EOF do
    begin
     PrintStr := FormatDateTime('dd/mm/yyyy hh:mm', FieldByName('LoginTime').AsDateTime);
     if Not VarIsNull(FieldByName('LogoutTime').AsDateTime) and (FieldByName('LogoutTime').AsDateTime <> 0) then
        PrintStr := PrintStr + ' - ' + FormatDateTime('dd/mm/yyyy hh:mm', FieldByName('LogoutTime').AsDateTime);
     DataForm.OutPutToPrinter(PrintStr);
     PrintStr := Format('%4.2f Hours', [FieldByName('WorkHours').AsFloat]);
     PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     Total := Total + FieldByName('WorkHours').AsFloat;
     Next;
    end;
  end;
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := Format('Total Hours: %4.2f Hours', [Total]);
 PrintStr := Format('%' + IntToStr(PaperWidth) + 's', [PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 for I := 1 to 4 do DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

end.
