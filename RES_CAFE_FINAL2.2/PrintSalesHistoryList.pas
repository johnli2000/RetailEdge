unit PrintSalesHistoryList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes,
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintSalesHistoryListForm = class(TForm)
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
    OrderDate: TppDBText;
    TotalInvoice: TppDBText;
    Tips: TppDBText;
    PaidAmount: TppDBText;
    Balance: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    ppSummaryBand: TppSummaryBand;
    ppLine2: TppLine;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    Memo: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    InvoiceNo: TppDBText;
    BankCharge: TppDBText;
    PrintDate: TppSystemVariable;
    PageNumber: TppSystemVariable;
    TotalNetSales: TppDBCalc;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    ppLabel5: TppLabel;
    ServicePerson: TppDBText;
    SurchargeLabel: TppLabel;
    Surcharge: TppDBText;
    ppLabel14: TppLabel;
    NetSales: TppDBText;
    ppLabel15: TppLabel;
    GST: TppDBText;
    ppLabel16: TppLabel;
    TotalAmount: TppDBCalc;
    TotalServiceCharge: TppDBCalc;
    TotalTips: TppDBCalc;
    TotalSurcharge: TppDBCalc;
    TotalPaidAmount: TppDBCalc;
    TotalBalance: TppDBCalc;
    TotalGST: TppDBCalc;
    OtherChargeLabel: TppLabel;
    OtherCharge: TppDBText;
    TotalOtherCharge: TppDBCalc;
    procedure ReportBeforePrint(Sender: TObject);
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure PrintSalesHistoryListPro;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintSalesHistoryListForm: TPrintSalesHistoryListForm;

implementation

uses DataUnit, SalesHistoryList;

{$R *.dfm}

procedure TPrintSalesHistoryListForm.ReportBeforePrint(Sender: TObject);
begin
 PrintDate.Caption := 'Report Date: ' +
  SalesHistoryListForm.DateEdit1.Text + ' ' + SalesHistoryListForm.TimeEdit1.Text + ' - ' +
  SalesHistoryListForm.DateEdit2.Text + ' ' + SalesHistoryListForm.TimeEdit2.Text;
end;

procedure TPrintSalesHistoryListForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 TotalInvoice.DisplayFormat := sCurrency + ',0.#0';
 Surcharge.DisplayFormat := sCurrency + ',0.#0';
 OtherCharge.DisplayFormat := sCurrency + ',0.#0';
 NetSales.DisplayFormat := sCurrency + ',0.#0';
 Tips.DisplayFormat := sCurrency + ',0.#0';
 BankCharge.DisplayFormat := sCurrency + ',0.#0';
 PaidAmount.DisplayFormat := sCurrency + ',0.#0';
 Balance.DisplayFormat := sCurrency + ',0.#0';
 GST.DisplayFormat := sCurrency + ',0.#0';
 TotalAmount.DisplayFormat := sCurrency + ',0.#0';
 TotalServiceCharge.DisplayFormat := sCurrency + ',0.#0';
 TotalOtherCharge.DisplayFormat := sCurrency + ',0.#0';
 TotalNetSales.DisplayFormat := sCurrency + ',0.#0';
 TotalTips.DisplayFormat := sCurrency + ',0.#0';
 TotalSurcharge.DisplayFormat := sCurrency + ',0.#0';
 TotalPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 TotalBalance.DisplayFormat := sCurrency + ',0.#0';
 TotalGST.DisplayFormat := sCurrency + ',0.#0';
 SurchargeLabel.Caption := SurchargeName;
 OtherChargeLabel.Caption := OtherChargeName;
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintSalesHistoryListForm.PrintSalesHistoryListPro;
begin
 Application.CreateForm(TPrintSalesHistoryListForm, PrintSalesHistoryListForm);
 DataForm.OpenCompanyQuery;
 PrintSalesHistoryListForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintSalesHistoryListForm.Free;
end;

end.
