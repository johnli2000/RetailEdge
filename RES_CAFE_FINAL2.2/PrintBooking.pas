unit PrintBooking;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, UtilUnit, ADODB;

type
  TPrintBookingForm = class(TDataModule)
    Query: TADOQuery;
    function  OpenQuery(BookingNo: String): boolean;
    procedure PrintOutPro;
    procedure PrintBookingFormPro(BookingNo: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintBookingForm: TPrintBookingForm;

implementation

uses DataUnit;

{$R *.DFM}

function TPrintBookingForm.OpenQuery(BookingNo: String): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From BookTable Where BookingNo=' +
           Chr(39) + CheckQuotes(BookingNo) + Chr(39);
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
 if Query.RecordCount <> 0 then
    Result := True
   else
    Result := False;
end;

procedure TPrintBookingForm.PrintOutPro;
var
 PrintStr, StrTemp, FileName, Temp: string;
 TxtFile: TextFile;
 I, PaperWidth: integer;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '            RESERVATION FORM';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := 'Reserve Date: ' + FormatDateTime('dd/mm/yyyy  hh:mm',
             Query.FieldByName('BookingDate').AsDateTime);
 case Query.FieldByName('Kind').AsInteger of
  0: PrintStr := PrintStr + ' [Dinner]';
  1: PrintStr := PrintStr + ' [Lunch]';
  2: PrintStr := PrintStr + ' [Breaskfast]';
  3: PrintStr := PrintStr + ' [Others]';
 end;
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := Format('%-40s', [Query.FieldByName('CustomerName').AsString]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := 'Tel:' + Query.FieldByName('Telephone').AsString +
             '  Fax:' + Query.FieldByName('Telephone').AsString;
 PrintStr := Format('%-40s', [PrintStr]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := 'Mobile No:' + Query.FieldByName('Mobile').AsString;
 PrintStr := Format('%-40s', [PrintStr]);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 StrTemp := Query.FieldByName('Address').AsString;
 Temp := ''; I := 0;
 while I < Length(StrTemp) do
  begin
   I := I + 1;
   if (StrTemp[I] <> Chr(13)) and (StrTemp[I] <> Chr(10)) then
      Temp := Temp + StrTemp[I]
     else
      begin
       if Temp <> '' then
          begin
           PrintStr := Temp;
           PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
           DataForm.OutPutToPrinter(PrintStr);
          end;
       I := I + 1; Temp := '';
      end;
  end;
 if Temp <> '' then
    begin
     PrintStr := Temp;
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 if Query.FieldByName('Notes').AsString <> '' then
    begin
     PrintStr := 'Notes: ' + Query.FieldByName('Notes').AsString;
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
     PrintStr := '----------------------------------------';
     PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
     DataForm.OutPutToPrinter(PrintStr);
    end;
 PrintStr := 'Print Date: ' + FormatDateTime('dd/mm/yyyy  hh:mm', Date + Time);
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 FileName := StartDir + 'Booking.CFG';
 if FileExists(FileName) then
    begin
     AssignFile(TxtFile, FileName);
     Reset(TxtFile);
     While Not EOF(TxtFile) do
      begin
       Readln(TxtFile, PrintStr);
       PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2)+ 's%s', ['', PrintStr]);
       DataForm.OutPutToPrinter(PrintStr);
      end;
     CloseFile(TxtFile);
    end;
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TPrintBookingForm.PrintBookingFormPro(BookingNo: string);
begin
 Application.CreateForm(TPrintBookingForm, PrintBookingForm);
 PrintBookingForm.OpenQuery(BookingNo);
 PrintBookingForm.PrintOutPro;
 PrintBookingForm.Query.Close;
 PrintBookingForm.Free;
end;

end.
