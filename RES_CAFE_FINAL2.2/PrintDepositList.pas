unit PrintDepositList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes,
  ppRptExp, ppDsgnDB, TXComp, Printers, ppDevice, ppFilDev;

type
  TPrintDepositListForm = class(TForm)
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
    Balance: TppDBText;
    VIPName: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    ppSummaryBand: TppSummaryBand;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel8: TppLabel;
    PaidAmount: TppDBText;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    DateLabel: TppLabel;
    ppLabel7: TppLabel;
    AmountEdit: TppDBText;
    VIPNo: TppDBText;
    ppLabel1: TppLabel;
    Method: TppDBText;
    ppLabel9: TppLabel;
    TotalDeposit: TppDBCalc;
    TotalPaidAmount: TppDBCalc;
    TotalBalance: TppDBCalc;
    procedure ReportBeforePrint(Sender: TObject);
    procedure PrintDepositListPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintDepositListForm: TPrintDepositListForm;

implementation

uses DataUnit, DepositList;

{$R *.dfm}

procedure TPrintDepositListForm.ReportBeforePrint(Sender: TObject);
begin
 if DepositListForm.DateCheckBox.Checked then
    DateLabel.Caption := 'Date: ' + DepositListForm.DateEdit1.Text + ' To ' +
                         DepositListForm.DateEdit2.Text
  else
   DateLabel.Caption := '';
end;

procedure TPrintDepositListForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
 AmountEdit.DisplayFormat := sCurrency + ',0.#0';
 PaidAmount.DisplayFormat := sCurrency + ',0.#0';
 Balance.DisplayFormat := sCurrency + ',0.#0';
 TotalDeposit.DisplayFormat := sCurrency + ',0.#0';
 TotalPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 TotalBalance.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := DataForm.CompanyQuery.FieldByName('ABN').AsString;
end;

procedure TPrintDepositListForm.PrintDepositListPro;
begin
 Application.CreateForm(TPrintDepositListForm, PrintDepositListForm);
 DataForm.OpenCompanyQuery;
 PrintDepositListForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintDepositListForm.Free;
end;

end.
