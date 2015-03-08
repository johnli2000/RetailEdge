unit PrintDiscountReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes,
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintDiscountReportForm = class(TForm)
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
    VIPNo: TppDBText;
    DiscountOperator: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    ppSummaryBand: TppSummaryBand;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel8: TppLabel;
    OrderDate: TppDBText;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    ppLabel7: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    DiscountPercentage: TppDBText;
    Amount: TppDBText;
    DiscounAmount: TppDBText;
    DateLabel: TppLabel;
    TotalDiscountLabel: TppLabel;
    ppLabel1: TppLabel;
    Description: TppDBText;
    procedure ReportBeforePrint(Sender: TObject);
    procedure PrintDiscountReportPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintDiscountReportForm: TPrintDiscountReportForm;

implementation

uses DataUnit, DiscountReport;

{$R *.dfm}

procedure TPrintDiscountReportForm.ReportBeforePrint(Sender: TObject);
begin
 if DiscountReportForm.DateCheckBox.Checked then
    DateLabel.Caption := 'Report Date: ' +
        DiscountReportForm.DateEdit1.Text + ' ' +
        DiscountReportForm.TimeEdit1.Text + ' To ' +
        DiscountReportForm.DateEdit2.Text + ' ' +
        DiscountReportForm.TimeEdit2.Text
  else
   DateLabel.Caption := '';
 TotalDiscountLabel.Caption :=
  'Total Transaction: ' + DiscountReportForm.TotalTransactionEdit.Caption +
  ' / Total Discount: ' + DiscountReportForm.DiscountEdit.Caption;
end;

procedure TPrintDiscountReportForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 Amount.DisplayFormat := sCurrency + ',0.#0';
 DiscounAmount.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintDiscountReportForm.PrintDiscountReportPro;
begin
 Application.CreateForm(TPrintDiscountReportForm, PrintDiscountReportForm);
 DataForm.OpenCompanyQuery;
 PrintDiscountReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintDiscountReportForm.Free;
end;

end.
