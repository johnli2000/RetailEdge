unit PrintAwardPointsreport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes, 
  ppRptExp, ppDsgnDB, TXComp, Printers, ppDevice, ppFilDev;

type
  TPrintAwardPointsReportForm = class(TForm)
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDBText1: TppDBText;
    BusinessRegistName: TppLabel;
    ppLabel2: TppLabel;
    Telephone: TppDBText;
    ppLabel3: TppLabel;
    Fax: TppDBText;
    ppDetailBand1: TppDetailBand;
    VIPNo: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    PrintDate: TppSystemVariable;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    //ExtraOptions: TExtraOptions;
    ppLabel5: TppLabel;
    ppLine1: TppLine;
    ppLabel7: TppLabel;
    VIPName: TppDBText;
    AwardPoints: TppDBText;
    ppLabel10: TppLabel;
    PaymentPoints: TppDBText;
    Balance: TppDBText;
    ppLabel13: TppLabel;
    ppLabel6: TppLabel;
    ppSummaryBand1: TppSummaryBand;
    TotalAwardPoints: TppDBCalc;
    TotalPaymentPoints: TppDBCalc;
    TotalPoints: TppDBCalc;
    ExtraOptions: TExtraOptions;
    procedure PrintAwardPointsReportPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintAwardPointsReportForm: TPrintAwardPointsReportForm;

implementation

uses DataUnit, AwardPointsReport;

{$R *.dfm}

procedure TPrintAwardPointsReportForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 //BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintAwardPointsReportForm.PrintAwardPointsReportPro;
begin
 Application.CreateForm(TPrintAwardPointsReportForm, PrintAwardPointsReportForm);
 DataForm.OpenCompanyQuery;
 PrintAwardPointsReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintAwardPointsReportForm.Free;
end;

end.
