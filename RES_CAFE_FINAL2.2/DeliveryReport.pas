unit DeliveryReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainMenu, DB, ADODB, Grids, DBGrids, bsSkinCtrls, UtilUnit,
  BusinessSkinForm, XiButton, StdCtrls, Mask;

type
  TDeliveryReportForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    DBGrid1: TDBGrid;
    Query: TADOQuery;
    DataSource: TDataSource;
    QueryOrderNo: TWideStringField;
    QueryOrderDate: TDateTimeField;
    QueryServicePerson: TWideStringField;
    QueryTotalAmount: TFloatField;
    bsSkinPanel1: TbsSkinPanel;
    Label1: TLabel;
    DateEdit1: TMaskEdit;
    TimeEdit1: TMaskEdit;
    Label2: TLabel;
    DateEdit2: TMaskEdit;
    TimeEdit2: TMaskEdit;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    procedure OpenQuery;
    procedure DateEditClick(Sender: TObject);
    procedure TimeEditClick(Sender: TObject);
    procedure EditChange(Sender: TObject);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimeEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TimeEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DeliveryReportPro;
    procedure PrintButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DeliveryReportForm: TDeliveryReportForm;

implementation

uses DataUnit, DatePanel, TimePanel;

{$R *.dfm}

procedure TDeliveryReportForm.OpenQuery;
var
 SQLStr: string;
 DateTime1, DateTime2: TDateTime;
begin
 DateTime1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
 DateTime2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
 SQLStr := 'Select OrderNo, OrderDate, ServicePerson, Amount + ServiceCharge + OtherCharge As TotalAmount ' +
           'From OrderH ' +
           'Where BillKind=' + IntToStr(sPHONEORDER) + ' and Delivery <> 0 and PriceIncludesGST <> 0 and ' +
           'OrderDate >=' + ConvertDateTime(DateTime1) + ' and OrderDate <=' + ConvertDateTime(DateTime2) +
           ' Union All ' +
           'Select OrderNo, OrderDate, ServicePerson, Amount + ServiceCharge + OtherCharge + GST As TotalAmount ' +
           'From OrderH ' +
           'Where BillKind=' + IntToStr(sPHONEORDER) + ' and Delivery <> 0 and PriceIncludesGST = 0 and ' +
           'OrderDate >=' + ConvertDateTime(DateTime1) + ' and OrderDate <=' + ConvertDateTime(DateTime2) +
           'Order By ServicePerson, OrderNo';
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;


procedure TDeliveryReportForm.DateEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   DateTemp := TransferDate(Text);
   if DateForm.ReadDatePro(DateTemp) then
      Text := FormatDateTime('dd/mm/yyyy', DateTemp);
  end;
end;

procedure TDeliveryReportForm.TimeEditClick(Sender: TObject);
var
 TimeStr: string;
begin
 with Sender As TMaskEdit do
  begin
   TimeStr := Text;
   if TimeForm.ReadTimePro(TimeStr) then
      Text := TimeStr;
  end;
end;

procedure TDeliveryReportForm.EditChange(Sender: TObject);
begin
 Query.Close;
end;

procedure TDeliveryReportForm.DateEdit1Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit1.Text) then
    DateEdit1.SetFocus;
end;

procedure TDeliveryReportForm.DateEdit2Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit2.Text) then
    DateEdit2.SetFocus;
end;

procedure TDeliveryReportForm.DateEdit1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit1.SetFocus;
end;

procedure TDeliveryReportForm.TimeEdit1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TDeliveryReportForm.DateEdit2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit2.SetFocus;
end;

procedure TDeliveryReportForm.TimeEdit2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TDeliveryReportForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TDeliveryReportForm.PrintButtonClick(Sender: TObject);
var
 PaperWidth, OrderCounter: integer;
 OrderAmount, Total: double;
 PrintStr, DriverName: string;
begin
 if Not Query.Active or (Query.RecordCount = 0) or (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 PrintStr := '----------------------------------------';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '             DELIVERY REPORT';
 PrintStr := Format('%' + IntToStr((PaperWidth - 40) div 2) + 's%s', ['', PrintStr]);
 DataForm.OutPutToPrinter(PrintStr);
 PrintStr := '----------------------------------------';
 DataForm.OutPutToPrinter(PrintStr);
 DriverName := '';
 Total := 0;
 OrderCounter := 0; OrderAmount := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     if FieldByName('ServicePerson').AsString <> DriverName then
        begin
         if DriverName <> '' then
            begin
             PrintStr := 'Order(s): ' + Format('%1d', [OrderCounter]) + '    Amount: ' + Format('%4.2m', [OrderAmount]);
             PrintStr := Format('%40s', [PrintStr]);
             DataForm.OutPutToPrinter(PrintStr);
             OrderCounter := 0; OrderAmount := 0;
             DataForm.OutPutToPrinter(' ');
            end;
         DriverName := FieldByName('ServicePerson').AsString;
         DataForm.OutPutToPrinter(DriverName);
        end;
     OrderCounter := OrderCounter + 1;
     OrderAmount := OrderAmount + FieldByName('TotalAmount').AsFloat;
     Total := Total + FieldByName('TotalAmount').AsFloat;
     PrintStr := FormatDateTime('dd/mm/yyyy', FieldByName('OrderDate').AsDateTime) + '     ' +
                 FieldByName('OrderNo').AsString + Format('%15.2m', [FieldByName('TotalAmount').AsFloat]);
     DataForm.OutPutToPrinter(PrintStr);
     Next;
    end;
   EnableControls;
   PrintStr := 'Order(s): ' + Format('%1d', [OrderCounter]) + '    Amount: ' + Format('%4.2m', [OrderAmount]);
   PrintStr := Format('%40s', [PrintStr]);
   DataForm.OutPutToPrinter(PrintStr);

   DataForm.OutPutToPrinter(' ');
   PrintStr := 'Total Order(s):' + Format('%1d', [RecordCount]) +  '    Total: ' + Format('%4.2m', [Total]);
   PrintStr := Format('%40s', [PrintStr]);
   DataForm.OutPutToPrinter(PrintStr);
   PrintStr := '----------------------------------------';
   DataForm.OutPutToPrinter(PrintStr);
   PrintStr := 'Report Date:';
   DataForm.OutPutToPrinter(PrintStr);
   PrintStr := DateEdit1.Text + ' ' + TimeEdit1.Text + ' - ' + DateEdit2.Text + ' ' + TimeEdit2.Text;
   DataForm.OutPutToPrinter(PrintStr);
  end;
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TDeliveryReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TDeliveryReportForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TDeliveryReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86; 
 if (Time < EndTime) and (EndTime < BeginTime) then
    begin
     DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date - 1);
     DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
    end
   else
    if (Time > BeginTime) and (EndTime < BeginTime) then
       begin
        DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
        DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date + 1);
       end
      else
       begin
        DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
        DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
       end;
 TimeEdit1.Text := FormatDateTime('hh:mm', BeginTime);
 TimeEdit2.Text := FormatDateTime('hh:mm', EndTime);
 QueryTotalAmount.DisplayFormat := sCurrency + ',0.#0';
 SearchButton.SetFocus;
end;

procedure TDeliveryReportForm.DeliveryReportPro;
begin
 Application.CreateForm(TDeliveryReportForm, DeliveryReportForm);
 DeliveryReportForm.ShowModal;
 DeliveryReportForm.Free;
end;

end.
