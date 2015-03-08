unit PrintStatement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppMemo, StdCtrls, ExtCtrls, ppViewr, ppTypes, TXComp,
  Printers, DataUnit, Security, ppDevice, ppFilDev;

type
  TPrintStatementForm = class(TForm)
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
    ppDetailBand1: TppDetailBand;
    FooterBand: TppFooterBand;
    CompanyAddress: TppDBMemo;
    ppLabel4: TppLabel;
    ReportDate: TppLabel;
    ppLine5: TppLine;
    ppLabel5: TppLabel;
    ppLine6: TppLine;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    A1Label: TppLabel;
    ppShape1: TppShape;
    ppLabel9: TppLabel;
    ppShape2: TppShape;
    A2Label: TppLabel;
    ppLabel10: TppLabel;
    ppLabel18: TppLabel;
    ppShape3: TppShape;
    B1Label: TppLabel;
    ppLabel23: TppLabel;
    ppShape4: TppShape;
    B2Label: TppLabel;
    ppShape5: TppShape;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    NetAmountGST: TppLabel;
    ppShape6: TppShape;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppShape7: TppShape;
    WithHoldAmount: TppLabel;
    ppLabel17: TppLabel;
    ppLabel19: TppLabel;
    ppShape8: TppShape;
    A8Edit: TppLabel;
    ppShape9: TppShape;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppShape10: TppShape;
    NetAmountEdit: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppShape11: TppShape;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppShape12: TppShape;
    G1Label: TppLabel;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppShape13: TppShape;
    G3Label: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppShape14: TppShape;
    G6Label: TppLabel;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppShape15: TppShape;
    G9Label: TppLabel;
    ppLabel39: TppLabel;
    ppLabel40: TppLabel;
    ppShape16: TppShape;
    G10Label: TppLabel;
    ppLabel38: TppLabel;
    ppLabel41: TppLabel;
    ppShape17: TppShape;
    G14Label: TppLabel;
    ppLabel42: TppLabel;
    ppLabel43: TppLabel;
    ppShape18: TppShape;
    G17Label: TppLabel;
    ppLabel44: TppLabel;
    ppLabel45: TppLabel;
    ppLabel46: TppLabel;
    ppLabel47: TppLabel;
    ppShape19: TppShape;
    G20Label: TppLabel;
    ppShape20: TppShape;
    ppLabel48: TppLabel;
    ppLabel49: TppLabel;
    ppShape21: TppShape;
    W1Edit: TppLabel;
    ppLabel50: TppLabel;
    ppLabel51: TppLabel;
    ppLabel52: TppLabel;
    ppShape22: TppShape;
    W2Edit: TppLabel;
    ppLabel53: TppLabel;
    ppLabel54: TppLabel;
    ppLabel55: TppLabel;
    ppShape23: TppShape;
    W3Edit: TppLabel;
    ppLabel56: TppLabel;
    ppLabel57: TppLabel;
    ppLabel58: TppLabel;
    ppShape24: TppShape;
    W4Edit: TppLabel;
    ppLine3: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ExtraOptions: TExtraOptions;
    //procedure ReportBeforePrint(Sender: TObject);
    //procedure ReportPreviewFormCreate(Sender: TObject);
    //procedure PrintStatementPro;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintStatementForm: TPrintStatementForm;

implementation


{$R *.dfm}

{procedure TPrintStatementForm.ReportBeforePrint(Sender: TObject);
begin
 ReportDate.Caption := 'Period covered by this statement: From ' +
  BusinessActivityStatementForm.Date1.Text + ' To ' +
  BusinessActivityStatementForm.Date2.Text;
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 G1Label.Caption := BusinessActivityStatementForm.G1Edit.caption;
 G3Label.Caption := BusinessActivityStatementForm.G3Edit.caption;
 G6Label.Caption := BusinessActivityStatementForm.G6Edit.caption;
 G9Label.Caption := BusinessActivityStatementForm.G9Edit.caption;
 G10Label.Caption := BusinessActivityStatementForm.G10Edit.caption;
 G14Label.Caption := BusinessActivityStatementForm.G14Edit.caption;
 G17Label.Caption := BusinessActivityStatementForm.G17Edit.caption;
 G20Label.Caption := BusinessActivityStatementForm.G20Edit.caption;
 A1Label.Caption := G9Label.Caption;
 A2Label.Caption := G9Label.Caption;
 B1Label.Caption := G20Label.Caption;
 B2Label.Caption := G20Label.Caption;
 NetAmountGST.Caption := BusinessActivityStatementForm.NetGSTAmount.Caption;
 WithHoldAmount.Caption := BusinessActivityStatementForm.WithholdingEdit.Caption;
 A8Edit.Caption := BusinessActivityStatementForm.A8Edit.Caption;
 NetAmountEdit.Caption := BusinessActivityStatementForm.NetAmountEdit.Caption;
 W1Edit.Caption := BusinessActivityStatementForm.W1Edit.Text;
 W2Edit.Caption := BusinessActivityStatementForm.W2Edit.Text;
 W3Edit.Caption := BusinessActivityStatementForm.W3Edit.Text;
 W4Edit.Caption := BusinessActivityStatementForm.W4Edit.Text;
end;

procedure TPrintStatementForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintStatementForm.PrintStatementPro;
begin
 Application.CreateForm(TPrintStatementForm, PrintStatementForm);
 DataForm.OpenCompanyQuery;
 PrintStatementForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintStatementForm.Free;
end;   }


end.
