unit PrintReceivableReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppMemo, StdCtrls, ExtCtrls, ppViewr, ppTypes, TXComp,
  Printers, Security, ppDevice, ppFilDev, ppParameter;

type
  TPrintReceivableReportFrom = class(TForm)
    Report: TppReport;
    CompanyDataSource: TDataSource;
    CompanyDBPipeline: TppDBPipeline;
    ExtraOptions: TExtraOptions;
    ppDBPipeline: TppDBPipeline;
    ppParameterList1: TppParameterList;
    ppHeaderBand1: TppHeaderBand;
    CompanyTitle: TppDBText;
    BusinessRegistName: TppLabel;
    ppLabel2: TppLabel;
    Telephone: TppDBText;
    ppLabel3: TppLabel;
    Fax: TppDBText;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLine1: TppLine;
    CompanyAddress: TppDBMemo;
    ppLabel4: TppLabel;
    ppLine5: TppLine;
    ppLabel5: TppLabel;
    ppLabel1: TppLabel;
    ppLabel6: TppLabel;
    ppDetailBand: TppDetailBand;
    VIPNO: TppDBText;
    VIPName: TppDBText;
    CustomerTelephone: TppDBText;
    CreditLimit: TppDBText;
    ppFooterBand1: TppFooterBand;
    PrintDate: TppSystemVariable;
    ppLine3: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    Total: TppDBCalc;
    raCodeModule1: TraCodeModule;
    TotalCredit: TppDBText;
    procedure PrintReceivableReportPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintReceivableReportFrom: TPrintReceivableReportFrom;

implementation

uses DataUnit, ReceivableReport;

{$R *.dfm}

procedure TPrintReceivableReportFrom.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 TotalCredit.DisplayFormat := sCurrency + ',0.#0';
 Total.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintReceivableReportFrom.PrintReceivableReportPro;
begin
 Application.CreateForm(TPrintReceivableReportFrom, PrintReceivableReportFrom);
 DataForm.OpenCompanyQuery;
 PrintReceivableReportFrom.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintReceivableReportFrom.Free;
end;



end.
