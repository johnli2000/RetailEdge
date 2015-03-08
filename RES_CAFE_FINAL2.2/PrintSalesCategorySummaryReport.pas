unit PrintSalesCategorySummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes, 
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintSalesCategorySummaryReportForm = class(TForm)
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
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    Category: TppDBText;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    ppLabel9: TppLabel;
    SalesAmount: TppDBText;
    DateLabel: TppLabel;
    ppSummaryBand1: TppSummaryBand;
    TotalSales: TppDBCalc;
    procedure ReportBeforePrint(Sender: TObject);
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure PrintSalesCategorySummaryReportPro;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintSalesCategorySummaryReportForm: TPrintSalesCategorySummaryReportForm;

implementation

uses DataUnit, SalesCategorySummaryReport;

{$R *.dfm}

procedure TPrintSalesCategorySummaryReportForm.ReportBeforePrint(Sender: TObject);
begin
 DateLabel.Caption := 'Date: ' +
                      SalesCategorySummaryReportForm.DateEdit1.Text + ' - ' +
                      SalesCategorySummaryReportForm.DateEdit2.Text;
end;

procedure TPrintSalesCategorySummaryReportForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 SalesAmount.DisplayFormat := sCurrency + ',0.#0';
 TotalSales.DisplayFormat  := sCurrency + ',0.#0';
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintSalesCategorySummaryReportForm.PrintSalesCategorySummaryReportPro;
begin
 Application.CreateForm(TPrintSalesCategorySummaryReportForm, PrintSalesCategorySummaryReportForm);
 DataForm.OpenCompanyQuery;
 PrintSalesCategorySummaryReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintSalesCategorySummaryReportForm.Free;
end;

end.
