unit ReceiptList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, Grids, DBGrids, ExtCtrls, DataUnit, UtilUnit,
  ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TReceiptListForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryOrderNo: TStringField;
    QueryAccountDate: TDateTimeField;
    QueryPaidAmount: TFloatField;
    QueryPayby: TStringField;
    QueryIDNo: TIntegerField;
    QueryOpName: TStringField;
    QueryMachineID: TStringField;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    ExitButton: TXiButton;
    DVRBtn: TXiButton;
    procedure OpenQuery;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    function  ReceiptListPro(OrderNo: string; CanEdit: boolean): boolean;
    procedure DVRBtnClick(Sender: TObject);
  private { Private declarations }
    OrderNo: string;
    EditStatus: Boolean;
    ReturnFlag: boolean;
    InvoiceDate: TDateTime;
  public
    { Public declarations }
  end;

var
  ReceiptListForm: TReceiptListForm;

implementation

uses MainMenu, EditReceipt, SecurityCamera;

{$R *.DFM}

procedure TReceiptListForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From RecvAcct ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
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

procedure TReceiptListForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TReceiptListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TReceiptListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if key = Chr(27) then Close;
end;

procedure TReceiptListForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 QueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 OpenQuery;
 ReturnFlag := False;
 if EditStatus then
    begin
     EditButton.Visible := True;
     DeleteButton.Visible := True
    end
   else
    begin
     EditButton.Visible := False;
     DeleteButton.Visible := False
    end;
end;

procedure TReceiptListForm.DeleteButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if Query.RecordCount = 0 then Exit;
 SQLStr := 'Delete From RecvAcct Where Orderno=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           ' and IDNo=' + IntToStr(Query.FieldByName('IDNo').AsInteger);
 if Not DataForm.BeginTransaction then Exit;
 Flag := True;
 try
  Flag := DataForm.ExecQueryPro(SQLStr);
  if Flag then
     Flag := DataForm.UpdateOrderPayment(OrderNo, False);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      OpenQuery;
      ReturnFlag := True;
     end
    else
     begin
      DataForm.RollBack;
     end; 
 end;
end;

procedure TReceiptListForm.EditButtonClick(Sender: TObject);
var
 IDNo: Integer;
begin
 if Query.RecordCount = 0 then Exit;
 IDNo := Query.FieldByname('IDNo').AsInteger;
 if EditReceiptForm.PaymentEditPro(OrderNo) then
    begin
     OpenQuery;
     Query.Locate('IDNo', IDNo, [loPartialKey]);
     ReturnFlag := True;
    end;
end;

procedure TReceiptListForm.DBGridDblClick(Sender: TObject);
begin
 if EditStatus then EditButtonClick(Sender);
end;

function TReceiptListForm.ReceiptListPro(OrderNo: string; CanEdit: boolean): boolean;
begin
 Application.CreateForm(TReceiptListForm, ReceiptListForm);
 ReceiptListForm.OrderNo := OrderNo;
 ReceiptListForm.EditStatus := CanEdit;
 ReceiptListForm.ShowModal;
 Result := ReceiptListForm.ReturnFlag;
 ReceiptListForm.Free;
end;

procedure TReceiptListForm.DVRBtnClick(Sender: TObject);
begin
 with Query do
  InvoiceDate := Query.FieldByname('AccountDate').AsDateTime;
  SecurityCameraForm.SecurityCameraPro(integer(StrToInt(DVRNo)),invoiceDate);


end;

end.
