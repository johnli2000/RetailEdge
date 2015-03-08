unit CustomerLastOrderDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, DataUnit, ADODB, UtilUnit,
  MainMenu, bsSkinCtrls, BusinessSkinForm, XiButton, PhoneOrder, Mask,
  DBCtrls;

type
  TCustomerLastOrderDetailForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryItemCode: TStringField;
    QueryDescription1: TStringField;
    QueryQty: TFloatField;
    QueryPrice: TFloatField;
    QueryDiscount: TFloatField;
    QueryTaxRate: TFloatField;
    QueryPriceSelect: TSmallintField;
    QuerySubDescription: TStringField;
    QuerySubDescription1: TStringField;
    QuerySubDescription2: TStringField;
    QuerySubDescription3: TStringField;
    QueryCondition: TSmallintField;
    QueryAmount: TFloatField;
    QueryDescription: TStringField;
    TempQuery: TADOQuery;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ExitButton: TXiButton;
    PasteItemButton: TXiButton;
    QueryOpenPrice: TBooleanField;
    QueryAllowDiscount: TBooleanField;
    QueryVoidReason: TStringField;
    QuerySpecialOrder: TStringField;
    OrderHeadPanel: TbsSkinPanel;
    OrderHeadDBGrid: TDBGrid;
    OrderHeadQuery: TADOQuery;
    OrderHeadDataSource: TDataSource;
    OrderHeadQueryOrderNo: TWideStringField;
    OrderHeadQueryOrderDate: TDateTimeField;
    OrderHeadQueryAmount: TFloatField;
    DBEdit: TDBEdit;
    procedure OpenOrderHeadQuery(VIPNo: Integer);
    procedure OpenQuery(OrderNo: String);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure PasteItemButtonClick(Sender: TObject);
    procedure DBEditChange(Sender: TObject);
    procedure CustomerLastOrderDetailPro(VIPNo: Integer);
  private{ Private declarations }
    VIPNo: integer;
  public
    { Public declarations }
  end;

var
  CustomerLastOrderDetailForm: TCustomerLastOrderDetailForm;

implementation

{$R *.DFM}

procedure TCustomerLastOrderDetailForm.OpenOrderHeadQuery(VIPNo: Integer);
var
 SQLStr: string;
begin
 SQLStr := 'Select OrderNo, OrderDate, (Amount + ServiceCharge + OtherCharge + Tips + Surcharge) As Amount ' +
           'From OrderH Where (PriceIncludesGST <> 0) and VIPNo=' + IntToStr(VIPNo) +
           ' Union All ' +
           'Select OrderNo, OrderDate, (Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST) As Amount ' +
           'From OrderH Where (PriceIncludesGST = 0) and VIPNo=' + IntToStr(VIPNo) +
           ' Order By OrderDate, OrderNo';
 with OrderHeadQuery do
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

procedure TCustomerLastOrderDetailForm.OpenQuery(OrderNo: String);
var
 SQLStr: string;
begin
 Screen.Cursor := crHourGlass;
 SQLStr := 'Select OrderI.ItemCode, Description1, Qty, OrderI.Price, ' +
           'OrderI.Discount, OrderI.TaxRate, PriceSelect, SubDescription, ' +
           'SubDescription1, SubDescription2, SubDescription3, Condition, ' +
           'OpenPrice, AllowDiscount, VoidReason, SpecialOrder ' +
           'From MenuItem, OrderI ' +
           'Where MenuItem.ItemCode=OrderI.ItemCode and ' +
           'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) + ' Order By IDNo';
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

procedure TCustomerLastOrderDetailForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  begin
   FieldByName('Amount').AsFloat := FieldByName('Price').AsFloat * FieldByName('Qty').AsFloat;
   FieldByName('Description').AsString := FieldByName('Description1').AsString;
   case FieldByName('PriceSelect').AsInteger of
     0: if FieldByName('SubDescription').AsString <> '' then
           FieldByName('Description').AsString := FieldByName('Description').AsString + ' / ' + FieldByName('SubDescription').AsString;
     1: if FieldByName('SubDescription1').AsString <> '' then
           FieldByName('Description').AsString := FieldByName('Description').AsString + ' / ' + FieldByName('SubDescription1').AsString;
     2: if FieldByName('SubDescription2').AsString <> '' then
           FieldByName('Description').AsString := FieldByName('Description').AsString + ' / ' + FieldByName('SubDescription2').AsString;
     3: if FieldByName('SubDescription3').AsString <> '' then
           FieldByName('Description').AsString := FieldByName('Description').AsString + ' / ' + FieldByName('SubDescription3').AsString;
   end;
   case FieldByName('Condition').AsInteger of
    1: FieldByName('Description').AsString := ' [*] ' + FieldByName('Description').AsString;
    2: FieldByName('Description').AsString := ' [A] ' + FieldByName('Description').AsString;
    3: FieldByName('Description').AsString := ' [C] ' + FieldByName('Description').AsString;
    4: FieldByName('Description').AsString := ' [M] ' + FieldByName('Description').AsString;
    5: FieldByName('Description').AsString := ' [L] ' + FieldByName('Description').AsString;
   end;
 end;
end;

procedure TCustomerLastOrderDetailForm.PasteItemButtonClick(Sender: TObject);
var
 I: integer;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      First;
      I := PhoneOrderForm.FindLastRow;
      While Not EOF do
       begin
        PhoneOrderForm.Instruction[I] := FieldByName('Condition').AsInteger;
        PhoneOrderForm.EditFlag[I] := True;
        PhoneOrderForm.VoidFlag[I] := False;
        PhoneOrderForm.PrintFlag[I] := False;
        PhoneOrderForm.CheckListPrinted[I] := False;
        PhoneOrderForm.SentToKitchen[I] := False;
        PhoneOrderForm.OpenPrice[I] := FieldByName('OpenPrice').AsBoolean;
        PhoneOrderForm.DiscountFlag[I] := FieldByName('AllowDiscount').AsBoolean;
        PhoneOrderForm.PriceSelect[I] := FieldByName('PriceSelect').AsInteger;
        PhoneOrderForm.PaidQty[I] := 0;
        PhoneOrderForm.VoidReason[I] := '';
        PhoneOrderForm.OrderOperator[I] := sUserName;
        PhoneOrderForm.OrderInstruction[I] := False;
        PhoneOrderForm.StringGrid.Cells[1, I] := FieldByName('Description').AsString;
        PhoneOrderForm.StringGrid.Cells[2, I] := Format('%4.2f', [FieldByName('Qty').AsFloat]);
        PhoneOrderForm.StringGrid.Cells[3, I] := Format('%4.2f', [FieldByName('Price').AsFloat]);
        PhoneOrderForm.StringGrid.Cells[5, I] := Format('%4.2f', [0.0]);
        PhoneOrderForm.StringGrid.Cells[6, I] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);
        PhoneOrderForm.StringGrid.Cells[7, I] := FieldByName('ItemCode').AsString;
        PhoneOrderForm.SetDescription(I);
        if FieldByName('SpecialOrder').AsString <> '' then
           begin
            I := I + 1;
            PhoneOrderForm.StringGrid.Cells[1, I] := FieldByName('SpecialOrder').AsString;
            PhoneOrderForm.Instruction[I] := 1;
            PhoneOrderForm.OrderInstruction[I] := True;
            PhoneOrderForm.EditFlag[I] := True;
            PhoneOrderForm.VoidFlag[I] := False;
            PhoneOrderForm.PrintFlag[I] := False;
            PhoneOrderForm.CheckListPrinted[I] := False;
            PhoneOrderForm.SentToKitchen[I] := False;
            PhoneOrderForm.OpenPrice[I] := False;
            PhoneOrderForm.DiscountFlag[I] := False;
            PhoneOrderForm.PriceSelect[I] := 0;
            PhoneOrderForm.PaidQty[I] := 0;
           end;
        I := I + 1;
        Next;
       end;
      PhoneOrderForm.StringGrid.Row := PhoneOrderForm.FindLastRow;
      PhoneOrderForm.CalcAmount;
     end;
end;

procedure TCustomerLastOrderDetailForm.DBEditChange(Sender: TObject);
var
 OrderNo: string;
begin
 with OrderHeadQuery do
  if Active and (RecordCount > 0) and (FieldByName('OrderNo').AsString <> '') then
     begin
      OrderNo := FieldByName('OrderNo').AsString;
      OpenQuery(OrderNo);
     end;
end;

procedure TCustomerLastOrderDetailForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TCustomerLastOrderDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 OrderHeadQuery.Close;
 Query.Close;
 Action := caFree;
end;

procedure TCustomerLastOrderDetailForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then ExitButtonClick(Sender);
end;

procedure TCustomerLastOrderDetailForm.FormShow(Sender: TObject);
begin
 QueryPrice.DisplayFormat := sCurrency + ',0.#0';
 QueryDiscount.DisplayFormat := '0.#0';
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 OrderHeadQueryAmount.DisplayFormat := sCurrency + ',0.#0';
 OpenOrderHeadQuery(VIPNo);
end;

procedure TCustomerLastOrderDetailForm.CustomerLastOrderDetailPro(VIPNo: integer);
begin
 Application.CreateForm(TCustomerLastOrderDetailForm, CustomerLastOrderDetailForm);
 CustomerLastOrderDetailForm.VIPNo := VIPNo;
 CustomerLastOrderDetailForm.ShowModal;
 CustomerLastOrderDetailForm.Free;
end;

end.
