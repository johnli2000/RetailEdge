unit PrintSalesClerkSummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes, 
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintSalesClerkSummaryReportForm = class(TForm)
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDBText1: TppDBText;
    BusinessRegistName: TppLabel;
    ppLabel2: TppLabel;
    Telephone: TppDBText;
    ppLabel3: TppLabel;
    Fax: TppDBText;
    ppLine1: TppLine;
    ppDetailBand1: TppDetailBand;
    WorkHours: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    StaffName: TppDBText;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    SalesAmount: TppDBText;
    HourlySales: TppDBText;
    DateLabel: TppLabel;
    ppLabel1: TppLabel;
    procedure ReportBeforePrint(Sender: TObject);
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure PrintSalesClerkSummaryReportPro;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintSalesClerkSummaryReportForm: TPrintSalesClerkSummaryReportForm;

implementation

uses DataUnit, SalesClerkSummaryReport;

{$R *.dfm}

procedure TPrintSalesClerkSummaryReportForm.ReportBeforePrint(Sender: TObject);
begin
 DateLabel.Caption := 'Date: ' +
                      SalesClerkSummaryReportForm.DateEdit1.Text + ' ' +
                      SalesClerkSummaryReportForm.TimeEdit1.Text + ' - ' +
                      SalesClerkSummaryReportForm.DateEdit2.Text + ' ' +
                      SalesClerkSummaryReportForm.TimeEdit2.Text;
end;

procedure TPrintSalesClerkSummaryReportForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 SalesAmount.DisplayFormat := sCurrency + ',0.#0';
 HourlySales.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintSalesClerkSummaryReportForm.PrintSalesClerkSummaryReportPro;
begin
 Application.CreateForm(TPrintSalesClerkSummaryReportForm, PrintSalesClerkSummaryReportForm);
 DataForm.OpenCompanyQuery;
 PrintSalesClerkSummaryReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintSalesClerkSummaryReportForm.Free;
end;

end.
