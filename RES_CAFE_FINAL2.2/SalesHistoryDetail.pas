unit SalesHistoryDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, DataUnit, ADODB, UtilUnit,
  MainMenu, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TSalesHistoryDetailForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    AmountEdit: TStaticText;
    DiscountEdit: TStaticText;
    TotalEdit: TStaticText;
    GSTEdit: TStaticText;
    SurchargeLabel: TLabel;
    ServiceChargeEdit: TStaticText;
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
    OtherChargeLabel: TLabel;
    OtherChargeEdit: TStaticText;
    NoteLabel: TLabel;
    Label5: TLabel;
    RewardPointsEdit: TStaticText;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    TotalPanel: TbsSkinPanel;
    ExitButton: TXiButton;
    QueryOrderOperator: TStringField;
    procedure OpenQuery(OrderNo: String);
    procedure OpenTempQuery(OrderNo: String);
    procedure CalcAmount;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure SalesDetailPro(OrderNo: string);
  private{ Private declarations }
    OrderNo: string;
  public
    { Public declarations }
  end;

var
  SalesHistoryDetailForm: TSalesHistoryDetailForm;

implementation

{$R *.DFM}

procedure TSalesHistoryDetailForm.OpenQuery(OrderNo: String);
var
 SQLStr: string;
begin
 Screen.Cursor := crHourGlass;
 SQLStr := 'Select OrderI.ItemCode, Description1, Qty, OrderI.Price, ' +
           'OrderI.Discount, OrderI.TaxRate, PriceSelect, SubDescription, ' +
           'SubDescription1, SubDescription2, SubDescription3, Condition, ' +
           'OrderOperator ' +
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

procedure TSalesHistoryDetailForm.OpenTempQuery(OrderNo: String);
var
 SQLStr: string;
begin
 Screen.Cursor := crHourGlass;
 SQLStr := 'Select ServiceCharge, OtherCharge, DollarDiscount, RewardPoints, PriceIncludesGST, ' +
           'CurrentGSTRate From OrderH Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 with TempQuery do
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

procedure TSalesHistoryDetailForm.QueryCalcFields(DataSet: TDataSet);
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

procedure TSalesHistoryDetailForm.CalcAmount;
var
 DiscountRate, Discount, Price, RealPrice, Amount, Qty, GST, RewardPoints,
 ServiceCharge, OtherCharge, DollarDiscount, CurrentGSTRate: double;
 CurrentPriceIncludesGST: boolean;
begin
 OpenTempQuery(OrderNo);
 RewardPoints := TempQuery.FieldByName('RewardPoints').AsFloat;
 ServiceCharge := TempQuery.FieldByName('ServiceCharge').AsFloat;
 DollarDiscount := TempQuery.FieldByName('DollarDiscount').AsFloat;
 OtherCharge := TempQuery.FieldByName('OtherCharge').AsFloat;
 CurrentPriceIncludesGST := TempQuery.FieldByName('PriceIncludesGST').AsBoolean;
 CurrentGSTRate := TempQuery.FieldByName('CurrentGSTRate').AsFloat;
 TempQuery.Close;
 Amount := 0; Discount := 0; GST := 0;
 if Query.Active and (Query.RecordCount > 0) then
    with Query do
     begin
      DisableControls;
      First;
      while Not EOF do
       begin
        Qty := FieldByName('Qty').AsFloat;
        Price := FieldByName('Price').AsFloat;
        Amount := Amount + Price * Qty;
        if ABS(DollarDiscount) < 0.005 then
           begin
            DiscountRate := StrToFloat(Format('%6.4f', [FieldByName('Discount').AsFloat / 100]));
            RealPrice := Price * (1 - DiscountRate);
            Discount := Discount + (Price - RealPrice) * Qty;
            if CurrentPriceIncludesGST then
               GST := GST + RealPrice * Qty * (1 - 1 / (1 + FieldByName('TaxRate').AsFloat / 100))
              else
               GST := GST + RealPrice * (FieldByName('TaxRate').AsFloat / 100);
           end
          else
           begin
            if CurrentPriceIncludesGST then
               GST := GST + Price * Qty * (1 - 1 / (1 + FieldByName('TaxRate').AsFloat / 100))
              else
               GST := GST + Price * (FieldByName('TaxRate').AsFloat / 100);
           end;
        Next;
       end;
      First;
      EnableControls;
     end;
 if ABS(DollarDiscount) >= 0.005 then
    begin
     Discount := DollarDiscount;
     if CurrentPriceIncludesGST then
        GST := GST - DollarDiscount * (1 - 1 / (1 + CurrentGSTRate / 100))
       else
        GST := GST - DollarDiscount * CurrentGSTRate / 100;
     if GST < 0 then GST := 0;
    end
   else
    Discount := RoundToCurrency(Discount);
 if CurrentPriceIncludesGST then
    GST := GST - RewardPoints * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    GST := GST - RewardPoints * CurrentGSTRate / 100;
 if CurrentPriceIncludesGST then
    GST := GST + (ServiceCharge + OtherCharge) * (1 - 1 / (1 + CurrentGSTRate / 100))
   else
    GST := GST + (ServiceCharge + OtherCharge) * CurrentGSTRate / 100;
 if (Amount >= 0) and (GST <=0) then GST := 0;
 AmountEdit.Caption := FormatCurrency(Amount) + ' ';
 DiscountEdit.Caption := FormatCurrency(Discount) + ' ';
 RewardPointsEdit.Caption := FormatCurrency(RewardPoints) + ' ';
 ServiceChargeEdit.Caption := FormatCurrency(ServiceCharge) + ' ';
 OtherChargeEdit.Caption := FormatCurrency(OtherCharge) + ' ';
 GSTEdit.Caption := FormatCurrency(GST) + ' ';
 if CurrentPriceIncludesGST then
    begin
     TotalEdit.Caption := FormatCurrency(Amount - Discount - RewardPoints + ServiceCharge + OtherCharge) + ' ';
     NoteLabel.Caption := 'The sales price includes GST';
    end
   else
    begin
     TotalEdit.Caption := FormatCurrency(Amount - Discount - RewardPoints + ServiceCharge + OtherCharge + GST) + ' ';
     NoteLabel.Caption := 'The sales price does not include GST';
    end
end;

procedure TSalesHistoryDetailForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesHistoryDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TSalesHistoryDetailForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then ExitButtonClick(Sender);
end;

procedure TSalesHistoryDetailForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 SurchargeLabel.Caption := SurchargeName;
 OtherChargeLabel.Caption := OtherChargeName;
 QueryPrice.DisplayFormat := sCurrency + ',0.#0';
 QueryDiscount.DisplayFormat := '0.#0';
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 OpenQuery(OrderNo);
 CalcAmount;
end;

procedure TSalesHistoryDetailForm.SalesDetailPro(OrderNo: string);
begin
 Application.CreateForm(TSalesHistoryDetailForm, SalesHistoryDetailForm);
 SalesHistoryDetailForm.OrderNo := OrderNo;
 SalesHistoryDetailForm.ShowModal;
 SalesHistoryDetailForm.Free;
end;

end.
