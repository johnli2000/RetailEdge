unit PrintMenuList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes,
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, UtilUnit, ppDevice, ppFilDev;

type
  TPrintMenuListForm = class(TForm)
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
    ItemCode: TppDBText;
    Price1: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLine5: TppLine;
    CompanyAddress: TppDBMemo;
    ppDBPipeline: TppDBPipeline;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel8: TppLabel;
    Description1: TppDBText;
    PageNumber: TppSystemVariable;
    ppCompanyDBPipeline: TppDBPipeline;
    CompanyDataSource: TDataSource;
    ExtraOptions: TExtraOptions;
    ppLabel7: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    Price2: TppDBText;
    Price3: TppDBText;
    Price4: TppDBText;
    DateLabel: TppLabel;
    Query: TADOQuery;
    DataSource: TDataSource;
    QueryCode: TStringField;
    QueryCategory: TStringField;
    QueryItemCode: TStringField;
    QueryDescription1: TStringField;
    QueryDescription2: TStringField;
    QueryPrice: TFloatField;
    QueryPrice1: TFloatField;
    QueryPrice2: TFloatField;
    QueryPrice3: TFloatField;
    Description2: TppDBText;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    Category: TppDBText;
    procedure OpenQuery(SelectedCategory: string);
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure PrintMenuListPro(SelectedCategory: string);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintMenuListForm: TPrintMenuListForm;

implementation

uses DataUnit, DiscountReport;

{$R *.dfm}

procedure TPrintMenuListForm.OpenQuery(SelectedCategory: string);
var
 SQLStr: string;
begin
 SQLStr := 'Select Category.Code, MenuItem.Category, ItemCode, Description1, Description2, ' +
           'Price, Price1, Price2, Price3 From MenuItem, Category ' +
           'Where Category.Category=MenuItem.Category ';
 if SelectedCategory <> '' then
    SQLStr := SQLStr + 'and Category.Category=' + Chr(39) + CheckQuotes(SelectedCategory) + Chr(39);
 SQLStr := SQLStr + ' Order By Code, ItemCode';
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

procedure TPrintMenuListForm.ppDetailBand1BeforePrint(Sender: TObject);
begin
 Description2.Visible := Query.FieldByName('Description2').AsString <> '';
end;

procedure TPrintMenuListForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 Price1.DisplayFormat := sCurrency + ',0.#0';
 Price2.DisplayFormat := sCurrency + ',0.#0';
 Price3.DisplayFormat := sCurrency + ',0.#0';
 Price4.DisplayFormat := sCurrency + ',0.#0';
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
end;

procedure TPrintMenuListForm.PrintMenuListPro(SelectedCategory: string);
begin
 Application.CreateForm(TPrintMenuListForm, PrintMenuListForm);
 PrintMenuListForm.OpenQuery(SelectedCategory);
 DataForm.OpenCompanyQuery;
 PrintMenuListForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintMenuListForm.Query.Close;
 PrintMenuListForm.Free;
end;

end.
