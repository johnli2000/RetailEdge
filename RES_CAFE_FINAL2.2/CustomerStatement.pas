unit CustomerStatement;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, StdCtrls, Buttons, DBTables, Grids, DBGrids, DataUnit,
  ADODB, UtilUnit, Mask, DateUtils, MainMenu, BusinessSkinForm, bsSkinCtrls,
  XiButton;

type
  TCustomerStatementForm = class(TForm)
    Query: TADOQuery;
    Label5: TLabel;
    DateEdit1: TMaskEdit;
    Label6: TLabel;
    DateEdit2: TMaskEdit;
    StringGrid: TStringGrid;
    Label1: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    TotalSalesEdit: TStaticText;
    TotalPaymentEdit: TStaticText;
    BalanceEdit: TStaticText;
    TempQuery: TADOQuery;
    TempQueryInvoiceNo: TStringField;
    TempQueryInvoiceDate: TDateTimeField;
    TempQueryTotal: TFloatField;
    TempQueryPaidAmount: TFloatField;
    TempQueryBalance: TFloatField;
    TempQueryAge: TIntegerField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    StringGridPanel: TbsSkinPanel;
    TotalPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    CustomerNameEdit: TStaticText;
    Label2: TLabel;
    OpenningEdit: TStaticText;
    procedure InitStringGridHead;
    procedure InitCells;
    procedure CalcForwardBalance;
    procedure OpenQuery(SQLStr: string);
    Procedure RetrieveData;
    procedure PostData;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure DateEditClick(Sender: TObject);
    procedure CustomerStatementPro(VIPNo: Integer);
  private { Private declarations }
    Opening: double;
    sVIPNo: Integer;
  public{ Public declarations }
   StatementRecordCount: integer;
  end;

var
  CustomerStatementForm: TCustomerStatementForm;

implementation

uses MessageBox, DatePanel, PrintCustomerStatement;

{$R *.DFM}

procedure TCustomerStatementForm.StringGridDrawCell(Sender: TObject; ACol,
          ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 X := 0;
 with Sender As TStringGrid do
  begin
   if ARow > 0 then
      case ACol of
        0: begin
            SetTextAlign(Canvas.Handle, TA_CENTER);
            X := (Rect.Left + Rect.Right) div 2;
           end;
        1: begin
            SetTextAlign(Canvas.Handle, TA_LEFT);
            X := Rect.Left + 2;
           end;
        2, 3, 4: begin
            SetTextAlign(Canvas.Handle, TA_RIGHT);
            X := Rect.Right - 2;
           end;
      end
     else
      begin
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TCustomerStatementForm.InitStringGridHead;
begin
 with StringGrid do
  begin
    Cells[0, 0] := 'Date';
    Cells[1, 0] := 'Description';
    Cells[2, 0] := 'Sales';
    Cells[3, 0] := 'Payment';
    Cells[4, 0] := 'Balance';
  end;
end;

procedure TCustomerStatementForm.InitCells;
var
 I, J: integer;
begin
 StatementRecordCount := Query.RecordCount + 1;
 if Query.RecordCount < 16 then
    StringGrid.RowCount := 17
   else
    StringGrid.RowCount := Query.RecordCount + 2;
 for I := 1 to StringGrid.RowCount do
  for J := 0 to 4 do StringGrid.Cells[J, I] := '';
end;

procedure TCustomerStatementForm.OpenQuery(SQLStr: string);
begin
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

procedure TCustomerStatementForm.CalcForwardBalance;
var
 SQLStr: string;
begin
 SQLStr := 'Select Sum(Credit) As Credit, Sum(PaidAmount) As PaidAmount From ' +
           '(Select (Amount + Tips + ServiceCharge + OtherCharge + Surcharge) As Credit, ' +
           'TempTable.PaidAmount ' +
           'From OrderH Left Join (Select OrderNo, Sum(PaidAmount) As PaidAmount ' +
           'From RecvAcct Where DepositID = 0 Group By OrderNo) As TempTable ' +
           'On OrderH.OrderNo=TempTable.OrderNo ' +
           'Where (PriceIncludesGST <> 0) and VIPNo=' + IntToStr(sVIPNo) +
           ' and OrderDate<' + ConvertDateTime(TransferDate(DateEdit1.Text)) + ') As TempTable1';
 OpenQuery(SQLStr);
 Opening := Query.FieldByName('Credit').AsFloat - Query.FieldByName('PaidAmount').AsFloat;

 SQLStr := 'Select Sum(Credit) As Credit, Sum(PaidAmount) As PaidAmount From ' +
           '(Select (Amount + Tips + ServiceCharge + OtherCharge + GST + Surcharge) As Credit, ' +
           'TempTable.PaidAmount ' +
           'From OrderH Left Join (Select OrderNo, Sum(PaidAmount) As PaidAmount ' +
           'From RecvAcct Where DepositID = 0 Group By OrderNo) As TempTable ' +
           'On OrderH.OrderNo=TempTable.OrderNo ' +
           'Where (PriceIncludesGST = 0) and VIPNo=' + IntToStr(sVIPNo) +
           ' and OrderDate < ' + ConvertDateTime(TransferDate(DateEdit1.Text)) + ') As TempTable1';
 OpenQuery(SQLStr);
 Opening := Opening + Query.FieldByName('Credit').AsFloat - Query.FieldByName('PaidAmount').AsFloat;

 SQLStr := 'Select Sum(Amount) As Deposit From DepositTable ' +
           'Where DepositDate < ' + ConvertDateTime(TransferDate(DateEdit1.Text)) +
           ' and VIPNo=' + IntToStr(sVIPNo);
 OpenQuery(SQLStr);
 Opening := Opening - Query.Fields[0].AsFloat;
 Query.Close;
end;

procedure TCustomerStatementForm.PostData;
var
 TotalSales, TotalPayment, Balance, Temp: double;
 I: integer;
begin
 Balance := Opening;
 TotalSales := 0; TotalPayment := 0;
 I := 1;
 with StringGrid do
  begin
   Cells[1, I] := 'Openning';
   Cells[4, I] := Format('%4.2m', [Balance]);
   I := I + 1;
   Query.First;
   while Not Query.EOF do
    begin
     Cells[0, I] := FormatDateTime('dd/mm/yyyy hh:mm', Query.FieldByName('OrderDate').AsDateTime);
     if Query.FieldByName('KindFlag').AsInteger = 0 then
         begin
          Temp := Query.FieldByName('Debit').AsFloat - Query.FieldByName('PaidAmount').AsFloat;
          Cells[1, I] := 'Order: #' + Query.FieldByName('OrderNo').AsString;
          Cells[2, I] := Format('%4.2f', [Temp]);
          TotalSales := TotalSales + Temp;
          Balance := Balance + Temp;
         end
        else
         begin
          Cells[1, I] := 'Payment: ' + Query.FieldByName('Notes').AsString;
          Cells[3, I] := Format('%4.2f', [Query.FieldByName('Credit').AsFloat]);
          TotalPayment := TotalPayment + Query.FieldByName('Credit').AsFloat;
          Balance := Balance - Query.FieldByName('Credit').AsFloat;
         end;
     Cells[4, I] := Format('%4.2f', [Balance]);
     I := I + 1;
     Query.Next;
    end;
  end;
 OpenningEdit.Caption := FormatCurrency(Opening) + ' ';
 TotalSalesEdit.Caption := FormatCurrency(TotalSales) + ' ';
 TotalPaymentEdit.Caption := FormatCurrency(TotalPayment) + ' ';
 BalanceEdit.Caption := FormatCurrency(Balance) + ' ';
end;

procedure TCustomerStatementForm.RetrieveData;
var
 SQLStr: string;
begin
 SQLStr := 'Select OrderH.OrderNo, OrderDate, (Amount + Tips + ServiceCharge + OtherCharge + Surcharge) As Debit, ' +
           '0 As Credit, 0 As ID, 0 As KindFlag, Null As Notes, TempTable.PaidAmount ' +
           'From OrderH Left Join (Select OrderNo, Sum(PaidAmount) As PaidAmount From RecvAcct ' +
           'Where DepositID = 0 Group By OrderNo) As TempTable ' +
           'On OrderH.OrderNo=TempTable.OrderNo ' +
           'Where (PriceIncludesGST <> 0) and VIPNo=' + IntToStr(sVIPNo) +
           ' and ((Amount + Tips + ServiceCharge + OtherCharge + Surcharge - TempTable.PaidAmount) >= 0.01 ' +
           ' Or TempTable.PaidAmount Is Null) ' +
           ' and OrderDate>=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('00:00')) +
           ' and OrderDate<=' + ConvertDateTime(TransferDate(DateEdit2.Text)+ StrToTime('23:59')) +
           ' Union all ' +
           'Select OrderH.OrderNo, OrderDate, (Amount + Tips + ServiceCharge + OtherCharge + GST + Surcharge) As Debit, ' +
           '0 As Credit, 0 As ID, 0 As KindFlag, Null As Notes, TempTable.PaidAmount ' +
           'From OrderH Left Join (Select OrderNo, Sum(PaidAmount) As PaidAmount From RecvAcct ' +
           'Where DepositID = 0 Group By OrderNo) As TempTable ' +
           'On OrderH.OrderNo=TempTable.OrderNo ' +
           'Where (PriceIncludesGST = 0) and VIPNo=' + IntToStr(sVIPNo) +
           ' and ((Amount + Tips + ServiceCharge + OtherCharge + GST + Surcharge - TempTable.PaidAmount) >= 0.01 ' +
           ' Or TempTable.PaidAmount Is Null) ' +
           ' and OrderDate>=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('00:00')) +
           ' and OrderDate<=' + ConvertDateTime(TransferDate(DateEdit2.Text)+ StrToTime('23:59')) +
           ' Union all ' +
           'Select Null As OrderNo, DepositDate, 0 As Debit, Amount As Credit, ' +
           'ID, 1 As KindFlag, PaymentMethod As Notes, 0 As PaidAmount From DepositTable ' +
           'Where VIPNo=' + IntToStr(sVIPNo) +
           ' and DepositDate>=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('00:00')) +
           ' and DepositDate<=' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59')) +
           ' Order By OrderDate, OrderH.OrderNo';
 OpenQuery(SQLStr);
end;

procedure TCustomerStatementForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TCustomerStatementForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TCustomerStatementForm.PrintButtonClick(Sender: TObject);
begin
 PrintCustomerStatementForm.PrintCustomerStatementPro(sVIPNo);
end;

procedure TCustomerStatementForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.close;
 Action := caFree;
end;

procedure TCustomerStatementForm.SearchButtonClick(Sender: TObject);
begin
 CalcForwardBalance;
 RetrieveData;
 InitCells;
 PostData;
 Query.Close;
end;

procedure TCustomerStatementForm.DateEditClick(Sender: TObject);
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

procedure TCustomerStatementForm.FormShow(Sender: TObject);
var
 Year, Month, Day, LastDayOfMonth: word;
 VIPName: string;
 Temp: double;
begin
 Width := StringGridPanel.Width + 28;
 Height := PrintButton.Top + 86;
 DecodeDate(Date, Year, Month, Day);
 LastDayOfMonth := DayOf(Date);
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', EncodeDate(Year, Month, 1));
 DateEdit2.Text := FormatDateTime('dd/mm/yyyy', EncodeDate(Year, Month, LastDayOfMonth));
 InitStringGridHead;
 if DataForm.ReadVIPInformation(sVIPNo, VIPName, Temp) then
    CustomerNameEdit.Caption := VIPName;
end;

procedure TCustomerStatementForm.CustomerStatementPro(VIPNo: Integer);
begin
 Application.CreateForm(TCustomerStatementForm, CustomerStatementForm);
 CustomerStatementForm.sVIPNo := VIPNo;
 CustomerStatementForm.ShowModal;
 CustomerStatementForm.Free;
end;

end.
