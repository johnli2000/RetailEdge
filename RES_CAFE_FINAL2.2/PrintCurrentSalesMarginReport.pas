unit PrintCurrentSalesMarginReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes,
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintCurrentStockSalesReportForm = class(TForm)
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDBText1: TppDBText;
    BusinessRegistName: TppLabel;
    ppLabel2: TppLabel;
    Telephone: TppDBText;
    ppLabel3: TppLabel;
    Fax: TppDBText;
    ppLabel13: TppLabel;
    ppLine1: TppLine;
    ppDetailBand1: TppDetailBand;
    Code: TppDBText;
    SalesPrice: TppDBText;
    Cost: TppDBText;
    Balance: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    Description: TppDBText;
    GrossProfit: TppDBText;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    SubDescription: TppDBText;
    ReportDate: TppSystemVariable;
    procedure ReportPreviewFormCreate(Sender: TObject);
    //procedure PrintCurrentStockSalesMarginReportPro;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintCurrentStockSalesReportForm: TPrintCurrentStockSalesReportForm;

implementation

uses DataUnit;

{$R *.dfm}

procedure TPrintCurrentStockSalesReportForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

{procedure TPrintCurrentStockSalesReportForm.PrintCurrentStockSalesMarginReportPro;
begin
 Application.CreateForm(TPrintCurrentStockSalesReportForm, PrintCurrentStockSalesReportForm);
 DataForm.OpenCompanyQuery;
 PrintCurrentStockSalesReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintCurrentStockSalesReportForm.Free;
end;  }

end.
