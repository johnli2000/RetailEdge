unit PrintSalesStatisticsReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes, 
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintSalesStatisticsReportForm = class(TForm)
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
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    OrderDate: TppDBText;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    Qty: TppDBText;
    Amount: TppDBText;
    MachineID: TppLabel;
    DateLabel: TppLabel;
    procedure ReportBeforePrint(Sender: TObject);
    procedure PrintSalesStatisticsReportPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintSalesStatisticsReportForm: TPrintSalesStatisticsReportForm;

implementation

uses DataUnit, SalesStatistics;

{$R *.dfm}

procedure TPrintSalesStatisticsReportForm.ReportBeforePrint(Sender: TObject);
begin
 DateLabel.Caption := 'Date: ' + SalesStatisticsForm.DateEdit1.Text + '  ' +
                      SalesStatisticsForm.TimeEdit1.Text + ' - ' +
                      SalesStatisticsForm.DateEdit2.Text + '  ' +
                      SalesStatisticsForm.TimeEdit2.Text;
 if SalesStatisticsForm.MachineIDCheckBox.Checked then
    MachineID.Caption := 'Machine ID: ' + SalesStatisticsForm.MachineIDEdit.Text
   else
    MachineID.Caption := '';
end;

procedure TPrintSalesStatisticsReportForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 Amount.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintSalesStatisticsReportForm.PrintSalesStatisticsReportPro;
begin
 Application.CreateForm(TPrintSalesStatisticsReportForm, PrintSalesStatisticsReportForm);
 DataForm.OpenCompanyQuery;
 PrintSalesStatisticsReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintSalesStatisticsReportForm.Free;
end;

end.
