unit PrintAttendanceSummaryRpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Printers, DB, quickrpt, Qrctrls, QRExport,
  UtilUnit;

type
  TPrintAttendanceSummaryRptForm = class(TForm)
    PageTitle: TQRBand;
    PrintAttendanceSummaryReport: TQuickRep;
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
    QRShape1: TQRShape;
    procedure PrintAttendanceSummaryReportBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure PrintReportPro;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintAttendanceSummaryRptForm: TPrintAttendanceSummaryRptForm;

implementation

uses DataUnit, AttendanceRpt, MessageBox;
{$R *.DFM}

procedure TPrintAttendanceSummaryRptForm.PrintAttendanceSummaryReportBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
 Address.Lines.Clear;
 Address.Lines.Add(DataForm.CompanyQuery.FieldByName('Address').AsString);
 DateLabel.Caption := 'Report Date: ' +
   AttendanceReportForm.DateEdit1.Text + ' - ' + AttendanceReportForm.DateEdit2.Text;
 PrintDate.Caption := FormatDateTime('dd/mm/yyyy hh:mm', Date + Time);
end;

procedure TPrintAttendanceSummaryRptForm.PrintReportPro;
begin
 Application.CreateForm(TPrintAttendanceSummaryRptForm, PrintAttendanceSummaryRptForm);
 DataForm.OpenCompanyQuery;
 PrintAttendanceSummaryRptForm.PrintAttendanceSummaryReport.Preview;
 DataForm.CompanyQuery.Close;
 PrintAttendanceSummaryRptForm.Free;
end;

end.
