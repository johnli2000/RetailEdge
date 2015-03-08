unit PaymentDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, Grids, DBGrids, ExtCtrls, DataUnit, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton, UtilUnit;

type
  TPaymentDetailList = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryReceiveNo: TStringField;
    QueryAccountDate: TDateTimeField;
    QueryPaidAmount: TFloatField;
    QueryPayby: TStringField;
    QueryNotes: TStringField;
    QueryOpName: TStringField;
    QueryIDNo: TSmallintField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    DeleteButton: TXiButton;
    ExitButton: TXiButton;
    procedure OpenQuery;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function  PaymentDetailListPro(ReceiveNo: string): boolean;
    procedure DeleteButtonClick(Sender: TObject);
  private  { Private declarations }
    ReceiveNo: string;
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  PaymentDetailList: TPaymentDetailList;

implementation

uses MainMenu, MessageBox;

{$R *.DFM}

procedure TPaymentDetailList.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select ReceiveNo, AccountDate, PaidAmount, Payby, Notes, OpName, IDNo ' +
           'From PayAcct ' +
           'Where ReceiveNo=' + Chr(39) + CheckQuotes(ReceiveNo) + Chr(39) +
           ' Order By IDNo';
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

procedure TPaymentDetailList.DeleteButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 with Query do
  if Active and (RecordCount > 0) and
     (MessageBoxForm.MessagePro('Do you want to delete this payment?', sConfirmMsg) = mrYes) then
     begin
      Flag := False;
      if DataForm.BeginTransaction then
         try
          SQLStr := 'Delete From PayAcct Where ReceiveNo=' +
                    Chr(39) + CheckQuotes(FieldByName('ReceiveNo').AsString) + Chr(39) +
                    ' and IDNo=' + FieldByName('IDNo').AsString;
          Flag := DataForm.ExecQueryPro(SQLStr);
          if Flag then Flag := DataForm.UpdatePurchasePayment(ReceiveNo);
         finally
          if Flag then
             begin
              DataForm.CommitTransaction;
              OpenQuery;
              ReturnFlag := True;
             end
           else
            DataForm.RollBack;
         end;
     end;
end;

procedure TPaymentDetailList.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TPaymentDetailList.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TPaymentDetailList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TPaymentDetailList.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 QueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 OpenQuery;
 ReturnFlag := False;
end;

function TPaymentDetailList.PaymentDetailListPro(ReceiveNo: string): boolean;
begin
 Application.CreateForm(TPaymentDetailList, PaymentDetailList);
 PaymentDetailList.ReceiveNo := ReceiveNo;
 PaymentDetailList.ShowModal;
 Result := PaymentDetailList.ReturnFlag;
 PaymentDetailList.Free;
end;

end.
