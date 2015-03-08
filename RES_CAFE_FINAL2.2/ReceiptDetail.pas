unit ReceiptDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, Grids, DBGrids, ExtCtrls, DataUnit, UtilUnit,
  ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TReceiptsDetailList = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryOrderNo: TStringField;
    QueryOrderDate: TDateTimeField;
    QueryTotalAmount: TFloatField;
    QueryPaidAmount: TFloatField;
    QueryAccountDate: TDateTimeField;
    QueryPayBy: TWideStringField;
    QueryNotes: TStringField;
    QueryMachineID: TStringField;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ExitButton: TXiButton;
    QueryOrderNoStr: TStringField;
    procedure OpenQuery;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ReceiptDetailListPro(DateTime1, DateTime2: TDateTime;
              PayBy, OpName, MachineName: string; SalesFlag: integer);
    procedure QueryCalcFields(DataSet: TDataSet);
  private { Private declarations }
    DateTime1, DateTime2: TDateTime;
    PayByStr, OpName, MachineName: string;
    SalesFlag: integer;
  public
    { Public declarations }
  end;

var
  ReceiptsDetailList: TReceiptsDetailList;

implementation

uses MainMenu;

{$R *.DFM}

procedure TReceiptsDetailList.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select OrderH.OrderNo, OrderDate, PayBy, ' +
           '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge) As TotalAmount, ' +
           'Sum(RecvAcct.PaidAmount) As PaidAmount, AccountDate, RecvAcct.MachineID ' +
           'From OrderH, RecvAcct ' +
           'Where OrderH.OrderNo=RecvAcct.OrderNo and PriceIncludesGSt <> 0 and ' +
           'PayBy=' + Chr(39) + CheckQuotes(PayByStr) + Chr(39) +
           ' and AccountDate>=' + ConvertDateTime(DateTime1) +
           ' and AccountDate<=' + ConvertDateTime(DateTime2);
 if OpName <> '' then
    SQLStr := SQLStr + ' and RecvAcct.OPName=' + Chr(39) + CheckQuotes(OpName) + Chr(39);
 if SalesFlag = 1 then
    SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTableOrder)
   else
    if SalesFlag = 2 then
       SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQuickSale)
      else
       if SalesFlag = 3 then
          SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPhoneOrder);
 if MachineName <> '' then
    SQLStr := SQLStr + ' and RecvAcct.MachineID=' + Chr(39) + CheckQuotes(MachineName) + Chr(39);
 SQLStr := SQLStr + ' Group By OrderH.OrderNo, OrderDate, ' +
          '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge), '+
          'AccountDate, PayBy, RecvAcct.MachineID ' +
          ' Union all ' +
          'Select OrderH.OrderNo, OrderDate, PayBy, ' +
          '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST) As TotalAmount, ' +
          'Sum(RecvAcct.PaidAmount) As PaidAmount, AccountDate, RecvAcct.MachineID ' +
          'From OrderH, RecvAcct ' +
          'Where OrderH.OrderNo=RecvAcct.OrderNo and PriceIncludesGSt = 0 and ' +
          'PayBy=' + Chr(39) + CheckQuotes(PayByStr) + Chr(39) +
          ' and AccountDate>=' + ConvertDateTime(DateTime1) +
          ' and AccountDate<=' + ConvertDateTime(DateTime2);
 if OpName <> '' then
    SQLStr := SQLStr + ' and RecvAcct.OPName=' + Chr(39) + CheckQuotes(OpName) + Chr(39);
 if SalesFlag = 1 then
    SQLStr := SQLStr + ' and BillKind=' + IntToStr(sTableOrder)
   else
    if SalesFlag = 2 then
       SQLStr := SQLStr + ' and BillKind=' + IntToStr(sQuickSale)
      else
       if SalesFlag = 3 then
          SQLStr := SQLStr + ' and BillKind=' + IntToStr(sPhoneOrder);
 if MachineName <> '' then
    SQLStr := SQLStr + ' and RecvAcct.MachineID=' + Chr(39) + CheckQuotes(MachineName) + Chr(39);
 SQLStr := SQLStr + ' Group By OrderH.OrderNo, OrderDate, ' +
          '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST), '+
          'AccountDate, PayBy, RecvAcct.MachineID ';
 SQLStr := SQLStr + ' Union all ' +
           'Select Convert(Char(10), VIPNo), Null As OrderDate, PaymentMethod As PayBy, ' +
           'Null As TotalAmount, ' +
           'Amount As PaidAmount, DepositDate As AccountDate, MachineID ' +
           'From DepositTable ' +
           'Where PaymentMethod=' + Chr(39) + CheckQuotes(PayByStr) + Chr(39) +
           ' and DepositDate>=' + ConvertDateTime(DateTime1) +
           ' and DepositDate<=' + ConvertDateTime(DateTime2);
 if OpName <> '' then
    SQLStr := SQLStr + ' and OPName=' + Chr(39) + CheckQuotes(OpName) + Chr(39);
 if MachineName <> '' then
    SQLStr := SQLStr + ' and MachineID=' + Chr(39) + CheckQuotes(MachineName) + Chr(39);
 SQLStr := SQLStr + ' Order By OrderH.OrderNo';
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

procedure TReceiptsDetailList.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  if FieldByName('OrderDate').AsDateTime = 0 then
     begin
      FieldByName('OrderNoStr').AsString := Format('%8.8d', [StrToInt(DeleteSpace(FieldByName('OrderNo').AsString))]);
      FieldByName('Notes').AsString := 'Deposit';
     end
    else
     begin
      FieldByName('OrderNoStr').AsString := FieldByName('OrderNo').AsString;
      if (FieldByName('PaidAmount').AsFloat < 0) then
         FieldByName('Notes').AsString := 'Change'
        else
         FieldByName('Notes').AsString := 'Payment';
     end;    
end;

procedure TReceiptsDetailList.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TReceiptsDetailList.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TReceiptsDetailList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TReceiptsDetailList.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 Caption := 'Receipts List - ' + PayByStr;
 QueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryTotalAmount.DisplayFormat := sCurrency + ',0.#0';
 OpenQuery;
end;

procedure TReceiptsDetailList.ReceiptDetailListPro(DateTime1, DateTime2: TDateTime;
          PayBy, OpName, MachineName: string; SalesFlag: integer);
begin
 Application.CreateForm(TReceiptsDetailList, ReceiptsDetailList);
 ReceiptsDetailList.DateTime1 := DateTime1;
 ReceiptsDetailList.DateTime2 := DateTime2;
 ReceiptsDetailList.PayByStr := PayBy;
 ReceiptsDetailList.OpName := OpName;
 ReceiptsDetailList.MachineName := MachineName;
 ReceiptsDetailList.SalesFlag := SalesFlag;
 ReceiptsDetailList.ShowModal;
 ReceiptsDetailList.Free;
end;

end.
