unit PrintSalesSummaryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes,
  ppRptExp, ppDsgnDB, TXComp, Printers, ppTxPipe, Security, ppDevice, ppFilDev;

type
  TPrintSalesSummaryReportForm = class(TForm)
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDBText1: TppDBText;
    BusinessRegistName: TppLabel;
    ppLabel2: TppLabel;
    Telephone: TppDBText;
    ppLabel3: TppLabel;
    Fax: TppDBText;
    ppLine1: TppLine;
    ppDetailBand1: TppDetailBand;
    Description: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    CompanyAddress: TppDBMemo;
    ppLabel4: TppLabel;
    ppLabel6: TppLabel;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    ppLabel7: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    Qty: TppDBText;
    Percentage: TppDBText;
    Amount: TppDBText;
    DateLabel: TppLabel;
    TextPipeline: TppTextPipeline;
    ppLabel1: TppLabel;
    ppDBText2: TppDBText;
    procedure CreateDataFile(aFileName: String);
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure PrintSalesSummaryReportPro;
    procedure ppDetailBand1BeforePrint(Sender: TObject);
    procedure AmountGetText(Sender: TObject; var Text: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintSalesSummaryReportForm: TPrintSalesSummaryReportForm;

implementation

uses DataUnit, SalesSummaryReport;

{$R *.dfm}

procedure TPrintSalesSummaryReportForm.ppDetailBand1BeforePrint(Sender: TObject);
begin
 if TextPipeline.Fields[1].AsString = '' then
    begin
     Description.Font.Style := [fsBold];
     Qty.Font.Style := [fsBold];
     Amount.Font.Style := [fsBold, fsUnderline];
     Percentage.Font.Style := [fsBold, fsUnderline];
    end
   else
    begin
     Description.Font.Style := [];
     Qty.Font.Style := [];
     Amount.Font.Style := [];
     Percentage.Font.Style := [];
    end
end;

procedure TPrintSalesSummaryReportForm.AmountGetText(Sender: TObject; var Text: String);
begin
 Text := '$' + Text;
end;

procedure TPrintSalesSummaryReportForm.CreateDataFile(aFileName: String);
var
  lStringList: TStringList;
  lcDelimiter: Char;
  I: integer;
  Temp: string;
begin
 lcDelimiter := ','; {comma delimiter }
 lStringList := TStringList.Create;
 lStringList.Clear;
 with SalesSummaryReportForm.StringGrid do
  for I := 1 to RowCount do
   if Cells[0, I] <> '' then
      begin
       Temp := Cells[0, I] + lcDelimiter + Cells[1, I] + lcDelimiter +
               Cells[2, I] + lcDelimiter + Cells[3, I] + lcDelimiter + Cells[4, I];
       lStringList.Add(Temp);
      end;
  {save the data to a text file}
 lStringList.SaveToFile(aFileName);
 lStringList.Free;
end;

procedure TPrintSalesSummaryReportForm.ReportPreviewFormCreate(Sender: TObject);
var
  lsFileName: String;
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 DateLabel.Caption := 'Report Date: ' + SalesSummaryReportForm.DateEdit1.Text + ' ' +
   SalesSummaryReportForm.TimeEdit1.Text + ' - ' + SalesSummaryReportForm.DateEdit2.Text + ' ' +
   SalesSummaryReportForm.TimeEdit2.Text;
 lsFileName := StartDir + 'Report.txt';
 {create the data and save it to the file}
 CreateDataFile(lsFileName);
 {assign the file name }
 TextPipeline.FileName := lsFileName;
 {define the field's in order: FieldName, DataType, FieldLength (i.e. max length) }
 TextPipeline.DefineField('Description', dtString, 150);
 TextPipeline.DefineField('Qty',         dtString,  15);
 TextPipeline.DefineField('AmountInc',   dtString,  15);
 TextPipeline.DefineField('AmountEx',    dtString,  15);
 TextPipeline.DefineField('Percentage',  dtString,  15);
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 Report.PreviewForm.FormStyle := fsNormal;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintSalesSummaryReportForm.PrintSalesSummaryReportPro;
begin
 Application.CreateForm(TPrintSalesSummaryReportForm, PrintSalesSummaryReportForm);
 DataForm.OpenCompanyQuery;
 PrintSalesSummaryReportForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintSalesSummaryReportForm.Free;
 DeleteFile(StartDir + 'Report.txt');
end;

end.
