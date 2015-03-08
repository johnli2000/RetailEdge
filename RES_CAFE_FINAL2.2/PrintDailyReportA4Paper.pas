unit PrintDailyReportA4Paper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes,
  ppRptExp, ppDsgnDB, TXComp, Printers, ppTxPipe, Security, ppDevice, ppFilDev;

type
  TPrintDailyReportA4PaperForm = class(TForm)
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
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    DateLabel: TppLabel;
    TextPipeline: TppTextPipeline;
    ppSystemVariable1: TppSystemVariable;
    procedure CreateDataFile(aFileName: String);
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure PrintDailyReportToA4PaperPro;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintDailyReportA4PaperForm: TPrintDailyReportA4PaperForm;

implementation

uses DataUnit, EndOfDayRpt;

{$R *.dfm}

procedure TPrintDailyReportA4PaperForm.CreateDataFile(aFileName: String);
var
 lStringList: TStringList;
 Temp: string;
begin
 lStringList := TStringList.Create;
 lStringList.Clear;
 with EndOfDayForm do
  begin
   Temp := 'Category                   Qty    Amount';
   lStringList.Add(Temp);
   Temp := '----------------------------------------';
   lStringList.Add(Temp);
   with CategoryQuery do
    begin
     DisableControls;
     First;
     while Not EOF do
      begin
       Temp := Copy(FieldByName('Category').AsString, 1, 20);
       Temp := Format('%-20s%10.2f%10.2f',
               [Temp, FieldByName('TotalQty').AsFloat, FieldByName('Amount').AsFloat]);
       lStringList.Add(Temp);
       Next;
      end;
     First;
     EnableControls;
    end;
   Temp := Format('Total Sales:                %12.2f', [TotalSales]);
   lStringList.Add(Temp);
   Temp := '----------------------------------------';
   lStringList.Add(Temp);
   with ItemGroupQuery do
    begin
     DisableControls;
     First;
     while Not EOF do
      begin
       Temp := Format('%-20s%10.2f%10.2f',
         [FieldByName('ItemGroup').AsString, FieldByName('Qty').AsFloat, FieldByName('Amount').AsFloat]);
       lStringList.Add(Temp);
       Next;
      end;
     First;
     EnableControls;
    end;
   Temp := '----------------------------------------';
   lStringList.Add(Temp);
   Temp := 'Received Payment:                       ';
   lStringList.Add(Temp);
   with ReceiveQuery do
    begin
     DisableControls;
     First;
     while Not EOF do
      begin
       Temp := Format('%-28s%12.2f', [FieldByName('PayBy').AsString, FieldByName('Amount').AsFloat]);
       lStringList.Add(Temp);
       Next;
      end;
     First;
     EnableControls;
    end;
   Temp := '----------------------------------------';
   lStringList.Add(Temp);
   Temp := Format('Total Sales:                %12.2f', [TotalSales]);
   lStringList.Add(Temp);
   Temp := Format('Discount:                   %12.2f', [TotalDiscount]);
   lStringList.Add(Temp);
   Temp := Format('Total Points Redeem:        %12.2f', [RewardPoints]);
   lStringList.Add(Temp);
   Temp := Format('Net Sales:                  %12.2f', [NetSales]);
   lStringList.Add(Temp);
   Temp := Format('Rounding Benefit:           %12.2f', [0 - TotalRounding]);
   lStringList.Add(Temp);
   if ABS(TotalTips) >= 0.01 then
      begin
       Temp := Format('Total Tips:                 %12.2f', [TotalTips]);
       lStringList.Add(Temp);
      end;
   if ABS(TotalSurcharge) >= 0.01 then
      begin
       Temp := Format('Bank Charge:                %12.2f', [TotalSurcharge]);
       lStringList.Add(Temp);
      end;
   if ABS(ReceivedAccountPayment) >= 0.01 then
      begin
       Temp := Format('Account Payment:            %12.2f', [ReceivedAccountPayment]);
       lStringList.Add(Temp);
      end;

   if ABS(AccountPayment) >= 0.01 then
      begin
       Temp := Format('Account Sales:              %12.2f', [AccountPayment]);
       lStringList.Add(Temp);
      end;

   if ABS(Deposit) >= 0.01 then
      begin
       Temp := Format('Deposit:                    %12.2f', [Deposit]);
       lStringList.Add(Temp);
      end;

   Temp := Format('Total Receivable:           %12.2f', [TotalReceivable]);
   lStringList.Add(Temp);

   Temp := Format('Total Received:             %12.2f', [TotalReceive]);
   lStringList.Add(Temp);

   if ABS(OutstandingOrder) >= 0.01 then
      begin
       Temp := Format('Balance:                    %12.2f', [OutstandingOrder]);
       lStringList.Add(Temp);
      end;

   if ABS(CashPayOut) >= 0.01 then
      begin
       Temp := Format('Cash Pay Out:               %12.2f', [CashPayOut]);
       lStringList.Add(Temp);
      end;
   if ABS(Cashin) >= 0.01 then
      begin
       Temp := Format('Cash Float In:              %12.2f', [CashIn]);
       lStringList.Add(Temp);
      end;
   if ABS(CashOut) >= 0.01 then
      begin
       Temp := Format('Cash Float Out:             %12.2f', [CashOut]);
       lStringList.Add(Temp);
      end;
   if ABS(CashInDrawer) >= 0.01 then
      begin
       Temp := Format('Cash In Drawer:             %12.2f', [CashInDrawer]);
       lStringList.Add(Temp);
      end;
   if ABS(CashLessTips) >= 0.01 then
      begin
       Temp := Format('Cash Less Tips:             %12.2f', [CashLessTips]);
       lStringList.Add(Temp);
      end;
   if ABS(TotalEFTPOSPayment) >= 0.01 then
      begin
       Temp := Format('Total EFTPOS Payment:       %12.2f', [TotalEFTPOSPayment]);
       lStringList.Add(Temp);
      end;
   if ABS(TotalGST) >= 0.01 then
      begin
       Temp := Format('Total G.S.T.:               %12.2f', [TotalGST]);
       lStringList.Add(Temp);
      end;
   if ABS(TotalServiceCharge) >= 0.01 then
      begin
       Temp := Format('%-28s%12.2f', [SurchargeName + ':', TotalServiceCharge]);
       lStringList.Add(Temp);
      end;
   if ABS(TotalOtherCharge) >= 0.01 then
      begin
       Temp := Format('%-28s%12.2f', [OtherChargeName + ':', TotalOtherCharge]);
       lStringList.Add(Temp);
      end;
   if ABS(TotalDiscount) >= 0.01 then
      begin
       Temp := Format('Discount:                   %12.2f', [TotalDiscount]);
       lStringList.Add(Temp);
      end;
   if ABS(RewardPoints) >= 0.01 then
      begin
       Temp := Format('Total Points Redeem:        %12.2f', [RewardPoints]);
       lStringList.Add(Temp);
      end;
   if ABS(Persons) >= 0.01 then
      begin
       Temp := Format('Total People:               %12d', [Persons]);
       lStringList.Add(Temp);
      end;
   if ABS(PPH) >= 0.01 then
      begin
       Temp := Format('P.P.H.:                     %12.2f', [PPH]);
       lStringList.Add(Temp);
      end;

   Temp := Format('Average Sales:              %12.2f', [AverageSales]);
   lStringList.Add(Temp);

   if ABS(VoidQty) >= 0.01 then
      begin
       Temp := Format('Void Qty:                   %12.2f', [ABS(VoidQty)]);
       lStringList.Add(Temp);
      end;
   if ABS(VoidAmount) >= 0.01 then
      begin
       Temp := Format('Void Amount:                %12.2f', [ABS(VoidAmount)]);
       lStringList.Add(Temp);
      end;
   if ABS(WastageAmount) >= 0.01 then
      begin
       Temp := Format('Wastage Amount:             %12.2f', [WastageAmount]);
       lStringList.Add(Temp);
      end;

   Temp := Format('Total Transactions:         %12d', [TotalBill]);
   lStringList.Add(Temp);
   if Not OperatorCheckBox.Checked then
      begin
       Temp := Format('No Sale Drawer Opens:       %12d', [NonSalesOpenDrawerCounter]);
       lStringList.Add(Temp);
      end;
   Temp := '----------------------------------------';
   lStringList.Add(Temp);
   case ListFlag of
    0: Temp := 'All Sales                               ';
    1: Temp := 'Table Service                           ';
    2: Temp := 'Quick Service                           ';
    3: Temp := 'Phone Order                             ';
   end;
   lStringList.Add(Temp);
   Temp := '----------------------------------------';
   lStringList.Add(Temp);
   if OperatorCheckBox.Checked then
      begin
       Temp :=  'Operator: ' + OperatorEdit.Text;
       lStringList.Add(Temp);
      end;
   if MachineIDCheckBox.Checked then
      begin
       Temp :=  'Machine ID: ' + MachineIDEdit.Text;
       lStringList.Add(Temp);
      end;
  end;
 lStringList.SaveToFile(aFileName);
 lStringList.Free;
end;

procedure TPrintDailyReportA4PaperForm.ReportPreviewFormCreate(Sender: TObject);
var
  lsFileName: String;
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 DateLabel.Caption := 'Report Date: ' +
                      EndOfDayForm.DateEdit1.Text + ' ' + EndOfDayForm.Time1.Text + ' - ' +
                      EndOfDayForm.DateEdit2.Text + ' ' + EndOfDayForm.Time2.Text;
 lsFileName := StartDir + 'Report.txt';
 {create the data and save it to the file}
 CreateDataFile(lsFileName);
 {assign the file name }
 TextPipeline.FileName := lsFileName;
 {define the field's in order: FieldName, DataType, FieldLength (i.e. max length) }
 TextPipeline.DefineField('Description', dtString, 50);
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 Report.PreviewForm.FormStyle := fsNormal;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintDailyReportA4PaperForm.PrintDailyReportToA4PaperPro;
begin
 Application.CreateForm(TPrintDailyReportA4PaperForm, PrintDailyReportA4PaperForm);
 DataForm.OpenCompanyQuery;
 PrintDailyReportA4PaperForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintDailyReportA4PaperForm.Free;
 DeleteFile(StartDir + 'Report.txt');
end;

end.
