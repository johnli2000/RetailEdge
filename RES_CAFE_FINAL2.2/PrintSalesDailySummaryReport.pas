unit PrintSalesDailySummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes, 
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintSalesDailySummaryReportForm = class(TForm)
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
    StaffDate: TppDBText;
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
    procedure PrintSalesDailySummaryReportPro;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintSalesDailySummaryReportForm: TPrintSalesDailySummaryReportForm;

implementation

uses DataUnit, SalesDailySummaryReport;

{$R *.dfm}

procedure TPrintSalesDailySummaryReportForm.ReportBeforePrint(Sender: TObject);
begin
 DateLabel.Caption := 'Date: ' +
                      SalesDailySummaryReportForm.DateEdit1.Text + ' - ' +
                      SalesDailySummaryReportForm.DateEdit2.Text;
end;

procedure TPrintSalesDailySummaryReportForm.ReportPreviewFormCreate(Sender: TObject);
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

procedure TPrintSalesDailySummaryReportForm.PrintSalesDailySummaryReportPro;
begin
 Application.CreateForm(TPrintSalesDailySummaryReportForm, PrintSalesDailySummaryReportForm);
 DataForm.OpenCompanyQuery;
 PrintSalesDailySummaryReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintSalesDailySummaryReportForm.Free;
end;

end.
