unit BackOrderList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, ExtCtrls, DataUnit, UtilUnit, StdCtrls, Buttons, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TBackOrderListForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryPurchaseNo: TStringField;
    QueryDescription: TStringField;
    QueryQty: TFloatField;
    QueryPrice: TFloatField;
    QueryArrivedQty: TFloatField;
    QueryBackOrderQty: TFloatField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ExitButton: TXiButton;
    procedure OpenQuery;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BackOrderListPro(Code: string);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }
    Code: string;
  public
    { Public declarations }
  end;

var
  BackOrderListForm: TBackOrderListForm;

implementation

uses PurchaseDetail, MainMenu;

{$R *.DFM}

procedure TBackOrderListForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select PurchaseItem.PurchaseNo, Description, Qty, Price, ' +
           'ArrivedQty From PurchaseHead, PurchaseItem, StockTable ' +
           'Where PurchaseHead.PurchaseNo=PurchaseItem.PurchaseNo and ' +
           'Cancel=0 and Qty > ArrivedQty and ' +
           'PurchaseItem.Code=StockTable.Code and ' +
           'PurchaseItem.Code=' + Chr(39) + CheckQuotes(Code) + Chr(39) +
           ' Order By PurchaseItem.PurchaseNo, PurchaseItem.Code ';
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

procedure TBackOrderListForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  FieldByname('BackOrderQty').AsFloat :=
   FieldByName('Qty').AsFloat - FieldByName('ArrivedQty').AsFloat;
end;

procedure TBackOrderListForm.DBGridDblClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PurchaseDetailForm.PurchaseDetailPro(FieldByName('PurchaseNo').AsString);
end;

procedure TBackOrderListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TBackOrderListForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TBackOrderListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TBackOrderListForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 QueryPrice.DisplayFormat := sCurrency + '0.#0';
 OpenQuery;
end;

procedure TBackOrderListForm.BackOrderListPro(Code: string);
begin
 Application.CreateForm(TBackOrderListForm, BackOrderListForm);
 BackOrderListForm.Code := Code;
 BackOrderListForm.ShowModal;
 BackOrderListForm.Free;
end;

end.
