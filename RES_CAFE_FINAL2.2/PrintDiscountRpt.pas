unit PrintDiscountRpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Printers, DB, quickrpt, Qrctrls, QRExport;

type
  TPrintDiscountReportForm = class(TForm)
    PageTitle: TQRBand;
    PrintReport: TQuickRep;
    MainItemBand: TQRBand;
    OrderNo: TQRDBText;
    Amount: TQRDBText;
    QRLabel5: TQRLabel;
    QRShape3: TQRShape;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRShape4: TQRShape;
    PageFootQRBand: TQRBand;
    QRSysData2: TQRSysData;
    QRShape5: TQRShape;
    QRLabel1: TQRLabel;
    DiscountAmount: TQRDBText;
    CompanyName: TQRDBText;
    QRLabel2: TQRLabel;
    Telephone: TQRDBText;
    QRLabel3: TQRLabel;
    Fax: TQRDBText;
    Address: TQRRichText;
    QRLabel8: TQRLabel;
    RegistNo: TQRDBText;
    DateLabel: TQRLabel;
    SummaryQRBand: TQRBand;
    Total: TQRExpr;
    QRLabel4: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    Price: TQRDBText;
    QRLabel11: TQRLabel;
    OrderDate: TQRDBText;
    VIPNo: TQRDBText;
    QRLabel12: TQRLabel;
    ServicdPerson: TQRDBText;
    procedure PageTitleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure PrintDiscountReportPro;
    procedure OrderDatePrint(sender: TObject; var Value: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintDiscountReportForm: TPrintDiscountReportForm;

implementation

uses DataUnit, DiscountReport;
{$R *.DFM}

procedure TPrintDiscountReportForm.PageTitleBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
 Address.Lines.Clear;
 Address.Lines.Add(DataForm.CompanyQuery.FieldByName('Address').AsString);
 if DiscountReportForm.DateCheckBox.Checked then
    DateLabel.Caption := 'Report Date: ' +
        DiscountReportForm.DateEdit1.Text + ' ' +
        DiscountReportForm.TimeEdit1.Text + ' To ' +
        DiscountReportForm.DateEdit2.Text + ' ' +
        DiscountReportForm.TimeEdit2.Text
  else
   DateLabel.Caption := '';
end;

procedure TPrintDiscountReportForm.PrintDiscountReportPro;
begin
 Application.CreateForm(TPrintDiscountReportForm, PrintDiscountReportForm);
 DataForm.OpenCompanyQuery;
 PrintDiscountReportForm.PrintReport.Preview;
 DataForm.CompanyQuery.Close;
 PrintDiscountReportForm.Free;
end;

procedure TPrintDiscountReportForm.OrderDatePrint(sender: TObject; var Value: String);
begin
 Value := FormatdateTime('dd/mm/yyyy hh:mm:ss',
          DiscountReportForm.Query.FieldByName('OrderDate').AsDateTime);
end;

end.
