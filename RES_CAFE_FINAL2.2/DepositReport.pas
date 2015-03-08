unit DepositReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, Grids, DBGrids, ExtCtrls, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TDepositReportForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Label2: TLabel;
    TotalEdit: TStaticText;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    DetailButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    QueryVIPNo: TIntegerField;
    QueryVIPName: TStringField;
    QueryBalance: TFloatField;
    QueryTotalDeposit: TFloatField;
    QueryTotalSales: TFloatField;
    QueryTotalPaidAmount: TFloatField;
    procedure OpenQuery;
    procedure CalcAmount;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DepositReportPro;
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DetailButtonClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DepositReportForm: TDepositReportForm;

implementation

uses DatePanel, MainMenu, UtilUnit, DataUnit, MessageBox, CustomerStatement,
     PrintDepositReport;

{$R *.DFM}

procedure TDepositReportForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select VIPTable.VIPNo, VIPName, TotalDeposit, TotalSales, TotalPaidAmount ' +
           'From VIPTable Inner Join (Select VIPNo, Sum(Amount) As TotalDeposit ' +
           'From DepositTable Group By VIPNo) As DepositTable1 On ' +
           'VIPTable.VIPNo=DepositTable1.VIPNo Left Join ' +
           '(Select VIPNo, Sum(TotalSales) As TotalSales ' +
           'From (Select VIPNo, Amount + ServiceCharge + OtherCharge + Tips + Surcharge As TotalSales ' +
           'From OrderH Where PriceIncludesGST <> 0 ' +
           'Union All ' +
           'Select VIPNo, Amount + ServiceCharge + OtherCharge + Tips + GST + Surcharge As TotalSales ' +
           'From OrderH Where PriceIncludesGST = 0) As SalesTable ' +
           'Group By VIPNo) As OrderTable On VIPTable.VIPNo = OrderTable.VIPNo ' +
           'Left Join (Select VIPNo, Sum(RecvAcct.PaidAmount) As TotalPaidAmount From OrderH, RecvAcct ' +
           'Where OrderH.OrderNo=RecvAcct.OrderNo and DepositID=0 Group By VIPNo) As PaymentTable ' +
           'On VIPTable.VIPNo = PaymentTable.VIPNo ' +
           'Where (TotalDeposit + TotalPaidAmount - TotalSales > 0.01) or ' +
           '(TotalSales Is Null) Or (TotalPaidAmount Is Null) ' +
           'Order By VIPTable.VIPNo';
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

procedure TDepositReportForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  FieldByName('Balance').AsFloat := FieldByName('TotalDeposit').AsFloat +
      FieldByName('TotalPaidAmount').AsFloat - FieldByName('TotalSales').AsFloat;
end;

procedure TDepositReportForm.CalcAmount;
var
 Total: double;
begin
 Total := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     Total := Total + FieldByName('Balance').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;
 TotalEdit.Caption := FormatCurrency(Total) + ' ';
end;

procedure TDepositReportForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
 CalcAmount;
end;

procedure TDepositReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TDepositReportForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TDepositReportForm.DetailButtonClick(Sender: TObject);
var
 VIPNo: integer;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      VIPNo := FieldByName('VIPNo').AsInteger;
      CustomerStatementForm.CustomerStatementPro(VIPNo);
     end;
end;

procedure TDepositReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
 DepositReportForm := NIL;
end;

procedure TDepositReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 QueryBalance.DisplayFormat := sCurrency + ',0.#0';
end;

procedure TDepositReportForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PrintDepositReportFrom.PrintDepositReportPro;
end;

procedure TDepositReportForm.DepositReportPro;
begin
 if DepositReportForm = NIL then
    DepositReportForm := TDepositReportForm.Create(Self)
   else
    bsBusinessSkinForm.WindowState := wsNormal;
end;

end.
