unit PrintZeroQtySalesReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes, 
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintZeroQtySalesReportForm = class(TForm)
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
    FixPrice: TppDBText;
    SalesPrice: TppDBText;
    DateLabel: TppLabel;
    ppLabel1: TppLabel;
    Operator: TppDBText;
    procedure ReportBeforePrint(Sender: TObject);
    procedure PrintZeroQtySalesReportPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintZeroQtySalesReportForm: TPrintZeroQtySalesReportForm;

implementation

uses DataUnit, ZeroQtySalesReport;

{$R *.dfm}

procedure TPrintZeroQtySalesReportForm.ReportBeforePrint(Sender: TObject);
begin
 DateLabel.Caption := 'Report Date: ' +
  ZeroQtySalesReportForm.DateEdit1.Text + ' ' +
  ZeroQtySalesReportForm.TimeEdit1.Text + ' To ' +
  ZeroQtySalesReportForm.DateEdit2.Text + ' ' +
  ZeroQtySalesReportForm.TimeEdit2.Text;
end;

procedure TPrintZeroQtySalesReportForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 FixPrice.DisplayFormat := sCurrency + ',0.#0';
 SalesPrice.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintZeroQtySalesReportForm.PrintZeroQtySalesReportPro;
begin
 Application.CreateForm(TPrintZeroQtySalesReportForm, PrintZeroQtySalesReportForm);
 DataForm.OpenCompanyQuery;
 PrintZeroQtySalesReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintZeroQtySalesReportForm.Free;
end;

end.
