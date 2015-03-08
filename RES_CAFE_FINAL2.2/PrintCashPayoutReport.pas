unit PrintCashPayoutReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes,
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintCashPayoutReportForm = class(TForm)
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
    PaymentDate: TppDBText;
    MachineID: TppDBText;
    Description: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    ppSummaryBand: TppSummaryBand;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel8: TppLabel;
    OpName: TppDBText;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    DateLabel: TppLabel;
    ppLabel7: TppLabel;
    AmountEdit: TppDBText;
    TotalCashPayOut: TppDBCalc;
    procedure ReportBeforePrint(Sender: TObject);
    procedure PrintCashPayOutReportPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintCashPayoutReportForm: TPrintCashPayoutReportForm;

implementation

uses DataUnit, PayoutList;

{$R *.dfm}

procedure TPrintCashPayoutReportForm.ReportBeforePrint(Sender: TObject);
begin
 DateLabel.Caption := 'Report Date: ' + PayOutListForm.DateEdit1.Text + ' To ' +
                       PayOutListForm.DateEdit2.Text
end;

procedure TPrintCashPayoutReportForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
 AmountEdit.DisplayFormat := sCurrency + ',0.#0';
 TotalCashPayOut.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
end;

procedure TPrintCashPayoutReportForm.PrintCashPayoutReportPro;
begin
 Application.CreateForm(TPrintCashPayoutReportForm, PrintCashPayoutReportForm);
 DataForm.OpenCompanyQuery;
 PrintCashPayoutReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintCashPayoutReportForm.Free;
end;

end.
