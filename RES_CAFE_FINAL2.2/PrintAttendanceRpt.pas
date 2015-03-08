unit PrintAttendanceRpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Printers, DB, Quickrpt, Qrctrls, UtilUnit, ADODB,
  QRExport;

type
  TPrintAttendanceRptForm = class(TForm)
    PageTitle: TQRBand;
    PrintAttendanceReport: TQuickRep;
    DetailBand: TQRBand;
    PriceTitleLabel: TQRLabel;
    QRShape3: TQRShape;
    QRLabel7: TQRLabel;
    QRShape4: TQRShape;
    PageFootQRBand: TQRBand;
    QRSysData2: TQRSysData;
    QRShape5: TQRShape;
    CompanyName: TQRDBText;
    QRLabel2: TQRLabel;
    Telephone: TQRDBText;
    QRLabel3: TQRLabel;
    Fax: TQRDBText;
    Address: TQRRichText;
    DateLabel: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel11: TQRLabel;
    RegistNo: TQRDBText;
    PrintDate: TQRLabel;
    QRLabel4: TQRLabel;
    StaffName: TQRDBText;
    TotalWorkTime: TQRDBText;
    Wages: TQRDBText;
    QRTextFilter: TQRTextFilter;
    QRCSVFilter: TQRCSVFilter;
    QRSubDetail: TQRSubDetail;
    LogInTime: TQRLabel;
    LogOutTime: TQRLabel;
    WorkTime: TQRLabel;
    QRShape1: TQRShape;
    DetailQuery: TADOQuery;
    DetailQueryLoginTime: TDateTimeField;
    DetailQueryLogoutTime: TDateTimeField;
    DetailQueryWorkTime: TFloatField;
    procedure OpenDetailQuery(StaffName: string);
    procedure DetailQueryCalcFields(DataSet: TDataSet);
    procedure PrintAttendanceReportBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRSubDetailNeedData(Sender: TObject; var MoreData: Boolean);
    procedure PrintReportPro(DateTime1, DateTime2: TDateTime);
    procedure LogoutTimePrint(sender: TObject; var Value: String);
    procedure DetailBandBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRSubDetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private { Private declarations }
    DateTemp1, DateTemp2: TDateTime;
  public
    { Public declarations }
  end;

var
  PrintAttendanceRptForm: TPrintAttendanceRptForm;

implementation

uses DataUnit, AttendanceRpt, MessageBox;
{$R *.DFM}

procedure TPrintAttendanceRptForm.OpenDetailQuery(StaffName: string);
var
 SQLStr: string;
begin
 SQLStr := 'Select LoginTime, LogoutTime ' +
           'From Attendance Where StaffName=' +
            Chr(39) + StaffName + Chr(39) +
           ' and LoginTime>=' + ConvertDateTime(DateTemp1) +
           ' and LoginTime<=' + ConvertDateTime(DateTemp2) +
           ' Order By LoginTime';
 Screen.Cursor := crHourGlass;
 with DetailQuery do
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

procedure TPrintAttendanceRptForm.DetailQueryCalcFields(DataSet: TDataSet);
begin
 with DetailQuery do
  if FieldByName('LogoutTime').AsDateTime <> 0 then
     FieldByName('WorkTime').AsFloat :=
           24 * (FieldByName('LogoutTime').AsDateTime -
           FieldByName('LoginTime').AsDateTime);
end;

procedure TPrintAttendanceRptForm.LogoutTimePrint(sender: TObject; var Value: String);
begin
 with DetailQuery do
  if FieldByName('LogoutTime').AsDateTime = 0 then
     Value := '';
end;

procedure TPrintAttendanceRptForm.PrintAttendanceReportBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
 Address.Lines.Clear;
 Address.Lines.Add(DataForm.CompanyQuery.FieldByName('Address').AsString);
 DateLabel.Caption := 'Report Date: ' +
   AttendanceReportForm.DateEdit1.Text + ' - ' + AttendanceReportForm.DateEdit2.Text;
 PrintDate.Caption := FormatDateTime('dd/mm/yyyy hh:mm', Date + Time);
end;

procedure TPrintAttendanceRptForm.QRSubDetailBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
 with DetailQuery do
  begin
   LoginTime.Caption :=
    FormatDateTime('dd/mm/yyyy hh:mm:ss', FieldByName('LoginTime').AsDateTime);
   LogOutTime.Caption :=
    FormatDateTime('dd/mm/yyyy hh:mm:ss', FieldByName('LogOutTime').AsDateTime);
   WorkTime.Caption := Format('%4.2f', [FieldByName('WorkTime').AsFloat]);
   Next;
  end;
end;

procedure TPrintAttendanceRptForm.QRSubDetailNeedData(Sender: TObject; var MoreData: Boolean);
begin
 if DetailQuery.Active and Not DetailQuery.EOF then
    MoreData := DetailQuery.Active and Not DetailQuery.EOF
end;

procedure TPrintAttendanceRptForm.DetailBandBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
 StaffName: string;
begin
 if AttendanceReportForm.SummaryDBGrid.SelectedRows.CurrentRowSelected then
    begin
     StaffName := AttendanceReportForm.SummaryQuery.FieldByName('StaffName').AsString;
     OpenDetailQuery(StaffName);
     QRSubDetail.Enabled := True;
     PrintBand := True;
    end
   else
    begin
     PrintBand := False;
     QRSubDetail.Enabled := False;
    end;
end;

procedure TPrintAttendanceRptForm.PrintReportPro(DateTime1, DateTime2: TDateTime);
begin
 Application.CreateForm(TPrintAttendanceRptForm, PrintAttendanceRptForm);
 DataForm.OpenCompanyQuery;
 PrintAttendanceRptForm.DateTemp1 := DateTime1;
 PrintAttendanceRptForm.DateTemp2 := DateTime2;
 PrintAttendanceRptForm.PrintAttendanceReport.Preview;
 DataForm.CompanyQuery.Close;
 PrintAttendanceRptForm.Free;
end;

end.
