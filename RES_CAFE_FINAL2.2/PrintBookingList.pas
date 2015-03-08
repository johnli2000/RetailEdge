unit PrintBookingList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppProd, ppClass, ppReport, DB, ppComm, ppRelatv, ppDB, ppDBPipe,
  ADODB, ppRichTx, ppCtrls, ppStrtch, ppPrnabl, ppBands, ppCache, ppModule,
  raCodMod, ppVar, ppRegion, ExtCtrls, ppViewr, ppEndUsr, ppMemo, ppTypes, 
  ppRptExp, ppDsgnDB, TXComp, Printers, Security, ppDevice, ppFilDev;

type
  TPrintBookingListForm = class(TForm)
    Report: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDBText1: TppDBText;
    BusinessRegistName: TppLabel;
    ppLabel2: TppLabel;
    Telephone: TppDBText;
    ppLabel3: TppLabel;
    Fax: TppDBText;
    ppDetailBand1: TppDetailBand;
    BookingDate: TppDBText;
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
    ppLabel6: TppLabel;
    BookingTime: TppDBText;
    ppLabel7: TppLabel;
    CustomerName: TppDBText;
    Kind: TppDBText;
    ppLabel8: TppLabel;
    CustomerTelephone: TppDBText;
    ppLabel9: TppLabel;
    CustomerFax: TppDBText;
    ppLabel10: TppLabel;
    CustomerMobile: TppDBText;
    ppLabel11: TppLabel;
    TableNo: TppDBText;
    ppLabel12: TppLabel;
    Persons: TppDBText;
    CustomerAddress: TppDBText;
    ppLabel13: TppLabel;
    ReserveNo: TppDBText;
    ppLabel14: TppLabel;
    RecordDate: TppDBText;
    ppLabel15: TppLabel;
    Notes: TppDBText;
    procedure ReportBeforePrint(Sender: TObject);
    procedure PrintBookingListPro;
    procedure ReportPreviewFormCreate(Sender: TObject);
    procedure CustomerAddressGetText(Sender: TObject; var Text: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintBookingListForm: TPrintBookingListForm;

implementation

uses DataUnit, BookList;

{$R *.dfm}

procedure TPrintBookingListForm.CustomerAddressGetText(Sender: TObject; var Text: String);
begin
 while (Pos(Chr(13), Text) > 0) do Text[Pos(Chr(13), Text)] := ' ';
end;

procedure TPrintBookingListForm.ReportBeforePrint(Sender: TObject);
begin
 PrintDate.Caption := FormatDateTime('dd/mm/yyyy hh:mm', Date + Time);
end;

procedure TPrintBookingListForm.ReportPreviewFormCreate(Sender: TObject);
begin
 ppUnRegisterDevice(TppTextFileDevice);
 ppUnRegisterDevice(TppReportTextFileDevice);
 Report.PreviewForm.BorderIcons := [];
 Report.PreviewForm.BorderStyle := bsNone;
 Report.PreviewForm.WindowState := wsMaximized;
 TppViewer(Report.PreviewForm.Viewer).ZoomSetting := zsPageWidth;
 BusinessRegistName.Caption := sRegistName + ' ' + DataForm.CompanyQuery.FieldByName('ABN').AsString;
end;

procedure TPrintBookingListForm.PrintBookingListPro;
begin
 Application.CreateForm(TPrintBookingListForm, PrintBookingListForm);
 DataForm.OpenCompanyQuery;
 PrintBookingListForm.Report.Print;
 DataForm.CompanyQuery.Close;
 PrintBookingListForm.Free;
end;

end.
