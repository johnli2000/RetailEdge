unit PrintCashFloatList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes,
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintCashFloatListForm = class(TForm)
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
    CashIn: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
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
    CashOut: TppDBText;
    ppLabel1: TppLabel;
    Description: TppDBText;
    procedure ReportBeforePrint(Sender: TObject);
    procedure PrintCashFloatListPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintCashFloatListForm: TPrintCashFloatListForm;

implementation

uses DataUnit, CashFloatList;

{$R *.dfm}

procedure TPrintCashFloatListForm.ReportBeforePrint(Sender: TObject);
begin
 if CashFloatListForm.DateCheckBox.Checked then
    DateLabel.Caption := 'Report Date: ' + CashFloatListForm.DateEdit1.Text + ' To ' +
                         CashFloatListForm.DateEdit2.Text
  else
   DateLabel.Caption := '';
end;

procedure TPrintCashFloatListForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
 CashIn.DisplayFormat := sCurrency + ',0.#0';
 CashOut.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
end;

procedure TPrintCashFloatListForm.PrintCashFloatListPro;
begin
 Application.CreateForm(TPrintCashFloatListForm, PrintCashFloatListForm);
 DataForm.OpenCompanyQuery;
 PrintCashFloatListForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintCashFloatListForm.Free;
end;

end.
