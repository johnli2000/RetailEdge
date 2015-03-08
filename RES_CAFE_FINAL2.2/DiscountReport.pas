unit DiscountReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, Db, StdCtrls, Buttons, Mask, UtilUnit, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TDiscountReportForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    DateEdit1: TMaskEdit;
    Label2: TLabel;
    DateEdit2: TMaskEdit;
    Label3: TLabel;
    DiscountEdit: TStaticText;
    TimeEdit1: TMaskEdit;
    TimeEdit2: TMaskEdit;
    DateCheckBox: TCheckBox;
    Query: TADOQuery;
    QueryOrderNo: TStringField;
    QueryOrderDate: TDateTimeField;
    QueryAmount: TFloatField;
    QueryDiscount: TFloatField;
    QueryVIPNo: TIntegerField;
    QueryVIPTemp: TStringField;
    QueryDiscountAmount: TFloatField;
    QueryDiscountPercentage: TFloatField;
    VIPCheckBox: TCheckBox;
    VIPNumberEdit: TStaticText;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    Label1: TLabel;
    TotalTransactionEdit: TStaticText;
    QueryDescription: TStringField;
    QueryDiscountOperator: TStringField;
    procedure OpenQuery(SQLStr: string);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SearchButtonClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure CalcAmount;
    procedure TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEditClick(Sender: TObject);
    procedure DiscountReportPro;
    procedure DateCheckBoxClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure VIPCheckBoxClick(Sender: TObject);
    //procedure VIPNumberEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DiscountReportForm: TDiscountReportForm;

implementation

uses DatePanel, SalesHistoryDetail, MainMenu, DataUnit, TimePanel, PrintDiscountReport;

{$R *.DFM}

procedure TDiscountReportForm.OpenQuery(SQLStr: string);
begin
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

procedure TDiscountReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TDiscountReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
 DiscountReportForm := NIL;
end;

procedure TDiscountReportForm.SearchButtonClick(Sender: TObject);
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 SQLStr := 'Select OrderI.OrderNo, OrderDate, OrderI.Discount, VIPNo, ' +
           'DiscountOperator, Sum(OrderI.Qty * OrderI.Price) As Amount, ' +
           'Sum(OrderI.Qty * OrderI.Price * Discount / 100) As DiscountAmount, ' +
           'Description ' +
           'From OrderI, OrderH Left Join DiscountRateTable ' +
           ' On OrderH.PresetDiscountCode = DiscountRateTable.Code ' +
           'Where OrderH.OrderNo=OrderI.OrderNo and Discount > 0 ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr +  ' and OrderDate >= ' + ConvertDateTime(DateTemp1) +
           ' and OrderDate<=' + ConvertDateTime(DateTemp2);
    end;
 if VIPCheckBox.Checked and (VIPNumberEdit.Caption <> '') then
    SQLStr := SQLStr + ' and VIPNo=' + VIPNumberEdit.Caption;
 SQLStr := SQLStr +
           ' Group By OrderI.OrderNo, OrderDate, VIPNo, DiscountOperator, Discount, Description ' +
           ' Union All ' +
           'Select OrderI.OrderNo, OrderDate, 0 As Discount, VIPNo, ' +
           'DiscountOperator, Sum(OrderI.Qty * OrderI.Price) As Amount, ' +
           'DollarDiscount As DiscountAmount, ' + Chr(39) + 'Dollar Discount' + Chr(39) + ' As Description ' +
           'From OrderH, OrderI ' +
           'Where OrderH.OrderNo=OrderI.OrderNo and DollarDiscount > 0 and ' +
           'Discount = 0 ';
 if DateCheckBox.Checked then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
     SQLStr := SQLStr +  ' and OrderDate >= ' + ConvertDateTime(DateTemp1) +
           ' and OrderDate<=' + ConvertDateTime(DateTemp2);
    end;
 if VIPCheckBox.Checked and (VIPNumberEdit.Caption <> '') then
    SQLStr := SQLStr + ' and VIPNo=' + VIPNumberEdit.Caption;
 SQLStr := SQLStr + ' Group By OrderI.OrderNo, OrderDate, VIPNo, DiscountOperator, Discount, ' +
                    'DollarDiscount ';
 SQLStr := SQLStr + 'Order By OrderI.OrderNo ';
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0) then
    CalcAmount
   else
    begin
     DiscountEdit.Caption := Format(sCurrency + '%4.2f ', [0.0]);
     TotalTransactionEdit.Caption := Format('%1d ', [0]);
    end;
end;

procedure TDiscountReportForm.CalcAmount;
var
 DiscountAmount: double;
 TotalTransaction: Integer;
begin
 DiscountAmount := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     DiscountAmount := DiscountAmount +
       StrToFloat(Format('%4.2f', [FieldByname('DiscountAmount').AsFloat]));
     Next;
    end;
   First;
   TotalTransaction := RecordCount;
   EnableControls;
  end;
 DiscountEdit.Caption := Format(sCurrency + '%4.2f ', [DiscountAmount]);
 TotalTransactionEdit.Caption := Format('%1d ', [TotalTransaction]);
end;

procedure TDiscountReportForm.DateEditClick(Sender: TObject);
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

procedure TDiscountReportForm.TimeEditClick(Sender: TObject);
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

procedure TDiscountReportForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit1.SetFocus;
end;

procedure TDiscountReportForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit2.SetFocus;
end;

procedure TDiscountReportForm.TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TDiscountReportForm.TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TDiscountReportForm.PrintButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
    PrintDiscountReportForm.PrintDiscountReportPro;
end;

procedure TDiscountReportForm.DBGridDblClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     OrderNo := Query.FieldByName('OrderNo').AsString;
     SalesHistoryDetailForm.SalesDetailPro(OrderNo);
    end;
end;

procedure TDiscountReportForm.DateCheckBoxClick(Sender: TObject);
begin
 if DateCheckBox.Checked then
    begin
     DateEdit1.Enabled := True;
     DateEdit2.Enabled := True;
     TimeEdit1.Enabled := True;
     TimeEdit2.Enabled := True;
     DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
     DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
     TimeEdit1.Text := '00:00';
     TimeEdit2.Text := '23:59';
     end
    else
    begin
     DateEdit1.Enabled := False;
     DateEdit2.Enabled := False;
     TimeEdit1.Enabled := False;
     TimeEdit2.Enabled := False;
     DateEdit1.Text := '';
     DateEdit2.Text := '';
     TimeEdit1.Text := '';
     TimeEdit2.Text := '';
     end
end;
procedure TDiscountReportForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  begin
   if FieldByName('VIPNo').AsInteger > 0 then
      FieldByName('VIPTemp').AsString := Format('%8.8d', [FieldByName('VIPNo').AsInteger])
     else
      FieldByName('VIPTemp').AsString := '';
   if FieldByName('Discount').AsFloat >= 0.01 then
      FieldByName('DiscountPercentage').AsFloat := FieldByName('Discount').AsFloat;
  end;
end;

procedure TDiscountReportForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TDiscountReportForm.VIPCheckBoxClick(Sender: TObject);
begin
 if VIPCheckBox.Checked then
    VIPNumberEdit.Enabled := True
   else
    begin
     VIPNumberEdit.Enabled := False;
     VIPNumberEdit.Caption := '';
    end;
end;

{procedure TDiscountReportForm.VIPNumberEditClick(Sender: TObject);
var
 VIPNo: integer;
begin
 if VIPListForm.VIPListPro(VIPNo) then
    VIPNumberEdit.Caption := Format('%8.8d', [VIPNo]);
end; }

procedure TDiscountReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 DateCheckBox.Checked := True;
 VIPCheckBox.Checked := False;
 VIPNumberEdit.Enabled := False;
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
 TimeEdit1.Text := '00:00';
 TimeEdit2.Text := '23:59';
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryDiscountAmount.DisplayFormat := sCurrency + ',0.#0';
 DiscountEdit.Caption := Format(sCurrency + '%4.2f ', [0.0]);
 TotalTransactionEdit.Caption := Format('%1d ', [0]);
end;

procedure TDiscountReportForm.DiscountReportPro;
begin
 Application.CreateForm(TDiscountReportForm, DiscountReportForm);
 DiscountReportForm.ShowModal;
 DiscountReportForm.Free;
end;

end.
