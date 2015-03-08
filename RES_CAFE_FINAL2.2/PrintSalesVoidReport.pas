unit PrintSalesVoidReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes, 
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintSalesVoidReportForm = class(TForm)
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
    OrderNo: TppDBText;
    Description: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    ppSummaryBand: TppSummaryBand;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    OrderDate: TppDBText;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    ppLabel7: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    Qty: TppDBText;
    Price: TppDBText;
    Amount: TppDBText;
    DateLabel: TppLabel;
    TotalAmount: TppDBCalc;
    ppLabel1: TppLabel;
    Operator: TppDBText;
    procedure ReportBeforePrint(Sender: TObject);
    procedure PrintSalesVoidReportPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintSalesVoidReportForm: TPrintSalesVoidReportForm;

implementation

uses DataUnit, SalesVoidReport;

{$R *.dfm}

procedure TPrintSalesVoidReportForm.ReportBeforePrint(Sender: TObject);
begin
 DateLabel.Caption := 'Report Date: ' +
  SalesVoidReportForm.DateEdit1.Text + ' ' +
  SalesVoidReportForm.TimeEdit1.Text + ' To ' +
  SalesVoidReportForm.DateEdit2.Text + ' ' +
  SalesVoidReportForm.TimeEdit2.Text;
end;

procedure TPrintSalesVoidReportForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 Price.DisplayFormat := sCurrency + ',0.#0';
 Amount.DisplayFormat := sCurrency + ',0.#0';
 TotalAmount.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintSalesVoidReportForm.PrintSalesVoidReportPro;
begin
 Application.CreateForm(TPrintSalesVoidReportForm, PrintSalesVoidReportForm);
 DataForm.OpenCompanyQuery;
 PrintSalesVoidReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintSalesVoidReportForm.Free;
end;

end.
