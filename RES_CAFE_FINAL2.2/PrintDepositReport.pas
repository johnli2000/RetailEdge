unit PrintDepositReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppMemo, StdCtrls, ExtCtrls, ppViewr, ppTypes, TXComp,
  Printers, ppDevice, ppFilDev;

type
  TPrintDepositReportFrom = class(TForm)
    Report: TppReport;
    CompanyDataSource: TDataSource;
    CompanyDBPipeline: TppDBPipeline;
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
    ppDetailBand: TppDetailBand;
    VIPNO: TppDBText;
    CompanyAddress: TppDBMemo;
    ppLabel4: TppLabel;
    ExtraOptions: TExtraOptions;
    VIPName: TppDBText;
    ppLine5: TppLine;
    ppFooterBand1: TppFooterBand;
    PrintDate: TppSystemVariable;
    ppLine3: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    TotalDepositBalance: TppDBCalc;
    ppLabel7: TppLabel;
    Balance: TppDBText;
    ppDBPipeline: TppDBPipeline;
    procedure PrintDepositReportPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintDepositReportFrom: TPrintDepositReportFrom;

implementation

uses DataUnit, DepositReport;

{$R *.dfm}

procedure TPrintDepositReportFrom.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 Balance.DisplayFormat := sCurrency + ',0.#0';
 TotalDepositBalance.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintDepositReportFrom.PrintDepositReportPro;
begin
 Application.CreateForm(TPrintDepositReportFrom, PrintDepositReportFrom);
 DataForm.OpenCompanyQuery;
 PrintDepositReportFrom.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintDepositReportFrom.Free;
end;

end.
