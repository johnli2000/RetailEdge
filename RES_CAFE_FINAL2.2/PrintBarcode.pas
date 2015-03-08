unit PrintBarcode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, UtilUnit,
  ppTxPipe, ppTypes, ppBarCod, ppDevice, ppFilDev;

type
  TPrintBarcodeForm = class(TForm)
    TextPipeline: TppTextPipeline;
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    DetailBand: TppDetailBand;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppFooterBand1: TppFooterBand;
    TextLabel: TppDBText;
    BarcodeLabel: TppDBBarCode;
    ppDBText1: TppDBText;
    procedure CreateDataFile(aFileName: String);
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure PrintBarcodePro(PriceFlag, BarcodeFlag, FirstPosition, Quantity: integer);
    procedure ppDBText1GetText(Sender: TObject; var Text: String);
  private { Private declarations }
    FirstPosition, Quantity: integer;
    RecordString: string;
  public
    { Public declarations }
  end;

var
  PrintBarcodeForm: TPrintBarcodeForm;

implementation

uses MenuSetup, DataUnit;

{$R *.dfm}

procedure TPrintBarcodeForm.ppDBText1GetText(Sender: TObject; var Text: String);
begin
 if Text = '0' then Text := '';
end;

procedure TPrintBarcodeForm.CreateDataFile(aFileName: String);
var
 lStringList: TStringList;
 I: integer;
 Temp: string;
begin
  lStringList := TStringList.Create;
  lStringList.Clear;
  for I := 1 to FirstPosition - 1 do
   begin
    Temp := ' ,0,';
    lStringList.Add(Temp);
   end;
  for I := 1 to Quantity do
   lStringList.Add(RecordString);
  {save the data to a text file}
 lStringList.SaveToFile(aFileName);
 lStringList.Free;
end;

procedure TPrintBarcodeForm.ReportPreviewFormCreate(Sender: TObject);
var
  lsFileName: String;
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 lsFileName := StartDir + 'Barcode.txt';
 {create the data and save it to the file}
 CreateDataFile(lsFileName);
 {assign the file name }
 TextPipeline.FileName := lsFileName;
 {define the field's in order: FieldName, DataType, FieldLength (i.e. max length) }
 TextPipeline.DefineField('Description', dtString, 200);
 TextPipeline.DefineField('Price',       dtString,  20);
 TextPipeline.DefineField('Barcode',     dtString,  25);
 with Report do
  begin
   Units := utMillimeters;
   Columns := 3;
   ColumnWidth := 67;
   with PrinterSetup do DetailBand.Height := 24.4;
  end;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintBarcodeForm.PrintBarcodePro(PriceFlag, BarcodeFlag, FirstPosition, Quantity: integer);
var
 PriceFieldName, SubDescriptionFieldName, BarcodeFieldName: string;
begin
 Application.CreateForm(TPrintBarcodeForm, PrintBarcodeForm);
 case PriceFlag of
  0: begin
      PriceFieldName := 'Price';
      SubDescriptionFieldName := 'SubDescription';
     end;
  1: begin
      PriceFieldName := 'Price1';
      SubDescriptionFieldName := 'SubDescription1';
     end;
  2: begin
      PriceFieldName := 'Price2';
      SubDescriptionFieldName := 'SubDescription2';
     end;
  3: begin
      PriceFieldName := 'Price3';
      SubDescriptionFieldName := 'SubDescription3';
     end;
 end;
 case BarcodeFlag of
  0: BarcodeFieldName := 'Barcode';
  1: BarcodeFieldName := 'Barcode1';
  2: BarcodeFieldName := 'Barcode2';
  3: BarcodeFieldName := 'Barcode3';
 end;
 with MenuItemForm.Query do
  begin
   PrintBarcodeForm.RecordString := FieldByName('Description1').AsString;
   if FieldByName(SubDescriptionFieldName).AsString <> '' then
      PrintBarcodeForm.RecordString := PrintBarcodeForm.RecordString +
           ' (' + FieldByName(SubDescriptionFieldName).AsString + ')';
   PrintBarcodeForm.RecordString := PrintBarcodeForm.RecordString + ',';
   if ABS(FieldByName(PriceFieldName).AsFloat) > 0.005 then
      PrintBarcodeForm.RecordString := PrintBarcodeForm.RecordString +
       FormatCurrency(FieldByName(PriceFieldName).AsFloat)
     else
      PrintBarcodeForm.RecordString := PrintBarcodeForm.RecordString + '0';
   PrintBarcodeForm.RecordString := PrintBarcodeForm.RecordString + ',' + FieldByName(BarcodeFieldName).AsString;
  end;
 PrintBarcodeForm.FirstPosition := FirstPosition;
 PrintBarcodeForm.Quantity := Quantity;
 PrintBarcodeForm.Report.Print;
 PrintBarcodeForm.Free;
 DeleteFile(StartDir + 'Barcode.txt');
end;

end.
