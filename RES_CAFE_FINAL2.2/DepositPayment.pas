unit DepositPayment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BusinessSkinForm, DB, ADODB, Grids, DBGrids, bsSkinCtrls,
  XiButton;

type
  TDepositPaymentForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryDepositDate: TDateTimeField;
    QueryDepositAmount: TFloatField;
    QueryPaymentMethod: TWideStringField;
    QueryID: TIntegerField;
    QueryPaidAmount: TFloatField;
    QueryBalance: TFloatField;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure OpenQuery;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure CancelButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function  DepositPaymentPro(VIPNo: Integer; var DepositBalance: double; var DepositID: Integer): boolean;
  private { Private declarations }
    VIPNo, DepositID: integer;
    ReturnFlag: boolean;
    DepositBalance: double;
  public
    { Public declarations }
  end;

var
  DepositPaymentForm: TDepositPaymentForm;

implementation

uses MainMenu, DataUnit;

{$R *.dfm}

procedure TDepositPaymentForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select DepositDate, DepositTable.Amount As DepositAmount, PaymentMethod, ' +
           'ID, Sum(RecvAcct.PaidAmount) As PaidAmount ' +
           'From DepositTable Left Join RecvAcct on DepositID=ID ' +
           'Where VIPNo=' + IntToStr(VIPNo) +
           'Group By DepositDate, DepositTable.Amount, PaymentMethod, ID ' +
           'Having (DepositTable.Amount - Sum(RecvAcct.PaidAmount) > 0) or ' +
           '(Sum(RecvAcct.PaidAmount) IS NULL) ' +
           'Order By DepositDate, DepositTable.ID';
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

procedure TDepositPaymentForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  FieldByName('Balance').AsFloat :=
   FieldByName('DepositAmount').AsFloat - FieldByName('PaidAmount').AsFloat;
end;

procedure TDepositPaymentForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TDepositPaymentForm.ConfirmButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      DepositBalance := FieldByName('Balance').AsFloat;
      DepositID := FieldByName('ID').AsInteger;
      ReturnFlag := True;
      DepositPaymentForm.Close;
     end;
end;

procedure TDepositPaymentForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TDepositPaymentForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ConfirmButton.Top + 86;
 QueryDepositAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryBalance.DisplayFormat := sCurrency + ',0.#0';
 OpenQuery;
end;

function TDepositPaymentForm.DepositPaymentPro(VIPNo: Integer; var DepositBalance: double; var DepositID: Integer): boolean;
begin
 Application.CreateForm(TDepositPaymentForm, DepositPaymentForm);
 DepositPaymentForm.VIPNo := VIPNo;
 DepositPaymentForm.ShowModal;
 Result := DepositPaymentForm.ReturnFlag;
 if Result then
    begin
     DepositBalance := DepositPaymentForm.DepositBalance;
     DepositID := DepositPaymentForm.DepositID;
    end;
 DepositPaymentForm.Free;
end;

end.
