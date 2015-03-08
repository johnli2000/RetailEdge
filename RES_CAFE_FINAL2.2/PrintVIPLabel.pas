unit PrintVIPLabel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, UtilUnit,
  ppTxPipe, ppTypes, ppBarCod, TXComp, Printers, DataUnit, ppDevice, ppFilDev;

type
  TPrintVIPLabelForm = class(TForm)
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    DetailBand: TppDetailBand;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppFooterBand1: TppFooterBand;
    ExtraOptions: TExtraOptions;
    ppShape1: TppShape;
    ppDBPipeline: TppDBPipeline;
    VIPName: TppDBText;
    Company: TppDBText;
    Address: TppDBText;
    Suburb: TppLabel;
    Query: TADOQuery;
    DataSource: TDataSource;
    QueryTelephone: TStringField;
    QueryVIPName: TStringField;
    QueryCompany: TStringField;
    QueryNumber: TStringField;
    QueryAddress: TStringField;
    QuerySuburb: TStringField;
    QueryFax: TStringField;
    QueryMobile: TStringField;
    QueryEmail: TStringField;
    QueryCreateDate: TDateTimeField;
    QueryDiscount: TFloatField;
    QueryNotes: TStringField;
    QueryBirthday: TDateTimeField;
    QueryState: TStringField;
    QueryPostcode: TStringField;
    QuerySerialNo: TStringField;
    QueryMapReference: TStringField;
    QueryCreditLimit: TFloatField;
    QueryVIPNo: TIntegerField;
    QueryNumberAndStreet: TStringField;
    procedure OpenQuery;
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure PrintVIPLabelPro(PrintSQLStr: string);
    procedure DetailBandBeforeGenerate(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
  private { Private declarations }
     SQLStr: string;
  public
    { Public declarations }
  end;

var
  PrintVIPLabelForm: TPrintVIPLabelForm;

implementation

uses VIPList;

{$R *.dfm}

procedure TPrintVIPLabelForm.OpenQuery;
begin
Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TPrintVIPLabelForm.DetailBandBeforeGenerate(Sender: TObject);
begin
 with Query do
  begin
   Suburb.Caption := FieldByName('Suburb').AsString + '  ' +
                     FieldByName('State').AsString + '  ' +
                     FieldByName('PostCode').AsString;
  end;
end;

procedure TPrintVIPLabelForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
   FieldByName('NumberAndStreet').AsString :=
    FieldByName('Number').AsString + ' ' + FieldByName('Address').AsString;
end;

procedure TPrintVIPLabelForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 with Report do
  begin
   Units := utMillimeters;
   Columns := 2;
   ColumnWidth := 100;
   with PrinterSetup do DetailBand.Height := 35.5;
  end;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 Report.PreviewForm.FormStyle := fsNormal;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintVIPLabelForm.PrintVIPLabelPro(PrintSQLStr: string);
begin
 Application.CreateForm(TPrintVIPLabelForm, PrintVIPLabelForm);
 PrintVIPLabelForm.SQLStr := PrintSQLStr;
 PrintVIPLabelForm.OpenQuery;
 PrintVIPLabelForm.Report.Print;
 PrintVIPLabelForm.Query.Close;
 PrintVIPLabelForm.Free;
end;

end.
