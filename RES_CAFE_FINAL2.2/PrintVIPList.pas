unit PrintVIPList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes, 
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintVIPListForm = class(TForm)
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDBText1: TppDBText;
    BusinessRegistName: TppLabel;
    ppLabel2: TppLabel;
    Telephone: TppDBText;
    ppLabel3: TppLabel;
    Fax: TppDBText;
    ppDetailBand1: TppDetailBand;
    VIPNo: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    PrintDate: TppSystemVariable;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    ppLabel5: TppLabel;
    ppLine1: TppLine;
    ppLabel7: TppLabel;
    VIPName: TppDBText;
    Company: TppDBText;
    ppLabel8: TppLabel;
    CustomerTelephone: TppDBText;
    ppLabel9: TppLabel;
    CustomerFax: TppDBText;
    ppLabel10: TppLabel;
    CustomerMobile: TppDBText;
    ppLabel11: TppLabel;
    Email: TppDBText;
    VIPAddress: TppDBText;
    ppLabel13: TppLabel;
    Suburb: TppDBText;
    VIPState: TppDBText;
    ppLabel15: TppLabel;
    CreateDate: TppDBText;
    ppLabel6: TppLabel;
    ppLabel12: TppLabel;
    PostCode: TppDBText;
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
    procedure PrintVIPListPro(PrintSQLStr: string);
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure VIPAddressGetText(Sender: TObject; var Text: String);
    procedure QueryCalcFields(DataSet: TDataSet);
  private { Private declarations }
     SQLStr: string;
  public
    { Public declarations }
  end;

var
  PrintVIPListForm: TPrintVIPListForm;

implementation

uses DataUnit, VIPList;

{$R *.dfm}

procedure TPrintVIPListForm.OpenQuery;
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

procedure TPrintVIPListForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  FieldByName('NumberAndStreet').AsString := FieldByName('Number').AsString + ' ' +
     FieldByName('Address').AsString;
end;

procedure TPrintVIPListForm.VIPAddressGetText(Sender: TObject; var Text: String);
begin
 while (Pos(Chr(13), Text) > 0) do Text[Pos(Chr(13), Text)] := ' ';
end;

procedure TPrintVIPListForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintVIPListForm.PrintVIPListPro(PrintSQLStr: string);
begin
 Application.CreateForm(TPrintVIPListForm, PrintVIPListForm);
 PrintVIPListForm.SQLStr := PrintSQLStr;
 DataForm.OpenCompanyQuery;
 PrintVIPListForm.OpenQuery;
 PrintVIPListForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintVIPListForm.Query.Close;
 PrintVIPListForm.Free;
end;

end.
