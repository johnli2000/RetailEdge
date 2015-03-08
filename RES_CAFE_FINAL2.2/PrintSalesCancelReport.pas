unit PrintSalesCancelReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppDB, DB, TXComp, ppBands, ppVar, ppStrtch, ppMemo, ppCtrls,
  ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDBPipe;

type
  TPrintSalesCancelFormReport = class(TForm)
    ppDBPipeline: TppDBPipeline;
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
    CompanyAddress: TppDBMemo;
    ppLabel4: TppLabel;
    ppLabel7: TppLabel;
    ppLabel11: TppLabel;
    ppLabel5: TppLabel;
    ppDetailBand1: TppDetailBand;
    OrderDate: TppDBText;
    MachineID: TppDBText;
    ServicePerson: TppDBText;
    Amount: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    PrintDate: TppSystemVariable;
    PageNumber: TppSystemVariable;
    ppSummaryBand: TppSummaryBand;
    ppLine2: TppLine;
    ExtraOptions: TExtraOptions;
    CompanyDataSource: TDataSource;
    ppCompanyDBPipeline: TppDBPipeline;
    ppCompanyDBPipelineppField1: TppField;
    ppCompanyDBPipelineppField2: TppField;
    ppCompanyDBPipelineppField3: TppField;
    ppCompanyDBPipelineppField4: TppField;
    ppCompanyDBPipelineppField5: TppField;
    ppCompanyDBPipelineppField6: TppField;
    ppCompanyDBPipelineppField7: TppField;
    ppCompanyDBPipelineppField8: TppField;
    ppCompanyDBPipelineppField9: TppField;
    ppCompanyDBPipelineppField10: TppField;
    ppCompanyDBPipelineppField11: TppField;
    ppCompanyDBPipelineppField12: TppField;
    ppCompanyDBPipelineppField13: TppField;
    ppCompanyDBPipelineppField14: TppField;
    ppCompanyDBPipelineppField15: TppField;
    ppCompanyDBPipelineppField16: TppField;
    ppCompanyDBPipelineppField17: TppField;
    ppCompanyDBPipelineppField18: TppField;
    ppCompanyDBPipelineppField19: TppField;
    procedure PrintSaleCancelPro;
    procedure ReportBeforePrint(Sender: TObject);
    procedure ReportPreviewFormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintSalesCancelFormReport: TPrintSalesCancelFormReport;

implementation
uses
   SaleCancel, DataUnit;

{$R *.dfm}

procedure TPrintSalesCancelFormReport.PrintSaleCancelPro;
begin
 Application.CreateForm(TPrintSalesCancelFormReport, PrintSalesCancelFormReport);
 DataForm.OpenCompanyQuery;
 PrintSalesCancelFormReport.Report.Print;
 DataForm.CompanyQuery.Close;

 PrintSalesCancelFormReport.Free;
end;





procedure TPrintSalesCancelFormReport.ReportBeforePrint(Sender: TObject);
begin
  PrintDate.Caption := 'Report Date: ' +
  SalesCancelForm.DateEdit1.Text + ' ' + SalesCancelForm.TimeEdit1.Text + ' - ' +
  SalesCancelForm.DateEdit2.Text + ' ' + SalesCancelForm.TimeEdit2.Text;
end;

procedure TPrintSalesCancelFormReport.ReportPreviewFormCreate(
  Sender: TObject);
begin
 //ppUnRegisterDevice(TppTextFileDevice);
 //ppUnRegisterDevice(TppReportTextFileDevice);
 {TotalInvoice.DisplayFormat := sCurrency + ',0.#0';
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
 OtherChargeLabel.Caption := OtherChargeName; }

 //BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 //TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

end.
