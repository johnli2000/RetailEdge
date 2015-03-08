unit PrintAttendanceSummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppMemo, StdCtrls, ExtCtrls, ppViewr, ppTypes, TXComp,
  ppParameter, jpeg, Printers, daDataModule, UtilUnit, Security, ppDevice, ppFilDev;

type
  TPrintAttendanceSummaryReportForm = class(TForm)
    ppDBPipeline: TppDBPipeline;
    DataSource: TDataSource;
    Report: TppReport;
    CompanyDataSource: TDataSource;
    CompanyDBPipeline: TppDBPipeline;
    ExtraOptions: TExtraOptions;
    ppParameterList1: TppParameterList;
    Query: TADOQuery;
    ppHeaderBand1: TppHeaderBand;
    CompanyTitle: TppDBText;
    BusinessRegistNameLabel: TppLabel;
    ppLabel4: TppLabel;
    ppLine1: TppLine;
    CompanyAddress: TppDBMemo;
    ReportDateLabel: TppLabel;
    ppDetailBand1: TppDetailBand;
    LoginTime: TppDBText;
    FooterBand: TppFooterBand;
    QueryStaffName: TStringField;
    QueryLoginTime: TDateTimeField;
    QueryLogoutTime: TDateTimeField;
    QueryIDNo: TIntegerField;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    StaffName: TppDBText;
    ppLine2: TppLine;
    ppDBText1: TppDBText;
    WorkHours: TppDBText;
    HoursSummary: TppDBCalc;
    ppLabel5: TppLabel;
    ppLine3: TppLine;
    PrintDateTime: TppSystemVariable;
    ppLine4: TppLine;
    QueryWorkHours: TFloatField;
    ReportPage: TppSystemVariable;
    procedure OpenQuery;
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure PrintAttendanceSummaryReportPro(Date1, Date2: TDateTime);
  private
    Date1, Date2: TDateTime;
  public
    { Public declarations }
  end;

var
  PrintAttendanceSummaryReportForm: TPrintAttendanceSummaryReportForm;

implementation

uses DataUnit;

{$R *.dfm}

procedure TPrintAttendanceSummaryReportForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select StaffName, LoginTime, LogoutTime, IDNo, ' +
           '(24 * (CAST(LogoutTime AS Float)-CAST(LoginTime As Float))) As WorkHours ' +
           'From Attendance ' +
           'Where LoginTime>=' + ConvertDateTime(Date1) +
           ' and LoginTime<=' + ConvertDateTime(Date2) +
           ' Order By StaffName, LoginTime';
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
end;

procedure TPrintAttendanceSummaryReportForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 BusinessRegistNameLabel.AutoSize := True;
 BusinessRegistNameLabel.Caption :=
  Format('%s %s      Tel: %s      Fax: %s', [sRegistName,
         DataForm.CompanyQuery.FieldByName('ABN').AsString,
         DataForm.CompanyQuery.FieldByName('Telephone').AsString,
         DataForm.CompanyQuery.FieldByName('Fax').AsString]);
 ReportDateLabel.Caption := 'Report Date: ' +
   FormatDateTime('dd/mm/yyyy hh:mm', Date1) + ' - ' +
   FormatDateTime('dd/mm/yyyy hh:mm', Date2);
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintAttendanceSummaryReportForm.
          PrintAttendanceSummaryReportPro(Date1, Date2: TDateTime);
begin
 Application.CreateForm(TPrintAttendanceSummaryReportForm, PrintAttendanceSummaryReportForm);
 PrintAttendanceSummaryReportForm.Date1 := Date1;
 PrintAttendanceSummaryReportForm.Date2 := Date2;
 PrintAttendanceSummaryReportForm.OpenQuery;
 DataForm.OpenCompanyQuery;
 PrintAttendanceSummaryReportForm.Report.Print;
 PrintAttendanceSummaryReportForm.Query.Close;
 DataForm.CompanyQuery.Close;
 PrintAttendanceSummaryReportForm.Free;
end;

end.
