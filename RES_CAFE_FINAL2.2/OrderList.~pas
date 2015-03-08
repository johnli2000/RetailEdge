unit OrderList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, Grids, DBGrids, ExtCtrls, DataUnit, UtilUnit,
  ADODB, bsSkinCtrls, XiButton;

type
  TOrderListForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    DateEdit1: TMaskEdit;
    DateEdit2: TMaskEdit;
    TimeEdit1: TMaskEdit;
    TimeEdit2: TMaskEdit;
    Query: TADOQuery;
    QueryBookingNo: TStringField;
    QueryOrderPrinted: TBooleanField;
    QuerySurcharge: TFloatField;
    QueryTips: TFloatField;
    QueryOrderDate: TDateTimeField;
    QueryOrderNo: TStringField;
    QueryPersons: TIntegerField;
    QueryTableNo: TStringField;
    QueryServicePerson: TStringField;
    QueryAmount: TFloatField;
    QueryGST: TFloatField;
    QueryPaidAmount: TFloatField;
    QueryInvoiceNo: TStringField;
    QueryServiceCharge: TFloatField;
    QueryBalance: TFloatField;
    QueryTotal: TFloatField;
    QueryTableNoFlag: TStringField;
    QueryPaid: TFloatField;
    QueryPriceIncludesGST: TBooleanField;
    QueryOtherCharge: TFloatField;
    BackPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    DateTimeGroupBox: TbsSkinGroupBox;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    PaymentGroupBox: TbsSkinGroupBox;
    SortGroupBox: TbsSkinGroupBox;
    ListByDateTimeButton: TbsSkinButton;
    ListAllOrdersButton: TbsSkinButton;
    ListUnPaidButton: TbsSkinButton;
    ListAllButton: TbsSkinButton;
    DateTimeButton: TbsSkinButton;
    OrderNoButton: TbsSkinButton;
    TableNoButton: TbsSkinButton;
    ServiceButton: TbsSkinButton;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    MoveUpButton: TXiButton;
    MoveDownButton: TXiButton;
    PageUpButton: TXiButton;
    PageDownButton: TXiButton;
    DBGridPanel: TbsSkinPanel;
    procedure OpenQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DateEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DateEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure TimeEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure TimeEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure TimeEditClick(Sender: TObject);
    procedure MoveUpButtonClick(Sender: TObject);
    procedure MoveDownButtonClick(Sender: TObject);
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  OrderListPro(var OrderNo, TableNo: string): boolean;
    procedure SetListButtonColor;
    procedure SetSortButtonColor;
    procedure ListAllButtonClick(Sender: TObject);
    procedure ListUnPaidButtonClick(Sender: TObject);
    procedure DateTimeButtonClick(Sender: TObject);
    procedure OrderNoButtonClick(Sender: TObject);
    procedure TableNoButtonClick(Sender: TObject);
    procedure ServiceButtonClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListAllOrdersButtonClick(Sender: TObject);
    procedure ListByDateTimeButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DateEdit1Change(Sender: TObject);
  private { Private declarations }
    SortFlag, PaymentFlag, DateFlag: integer;
    OrderNo, TableNo: string;
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  OrderListForm: TOrderListForm;

implementation

uses DatePanel, TimePanel, MainMenu;

{$R *.DFM}

procedure TOrderListForm.OpenQuery;
var
 SQLStr, TempSQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 TempSQLStr := '';
 SQLStr := 'Select * From OrderH ';
 if DateFlag = 0 then
    begin
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     TempSQLStr := 'OrderDate>=' +
      ConvertDateTime(DateTemp1 + StrToTime(TimeEdit1.Text)) +
      ' and OrderDate<=' +
      ConvertDateTime(DateTemp2 + StrToTime(TimeEdit2.Text));
    end;
 if PaymentFlag = 0 then
    begin
     if TempSQLStr <> '' then TempSQLStr := TempSQLStr + ' and ';
     TempSQLStr := TempSQLStr + ' (Credit = 0) and ' +
       '(((Amount + Tips + ServiceCharge + OtherCharge - PaidAmount >= 0.01) and PriceIncludesGST<>0) or ' +
       '((Amount + Tips + ServiceCharge + OtherCharge + GST - PaidAmount >= 0.01) and PriceIncludesGST = 0))';
    end;
 if TempSQLStr <> '' then TempSQLStr := ' Where ' + TempSQLStr;
 SQLStr := SQLStr + TempSQLStr;
 case SortFlag of
  0:  SQLStr := SQLStr + ' Order By OrderDate';
  1:  SQLStr := SQLStr + ' Order By OrderNo';
  2:  SQLStr := SQLStr + ' Order By TableNo';
  3:  SQLStr := SQLStr + ' Order By ServicePerson';
 end;
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
    if Active then Query.Last;
   end;
  end;
end;

procedure TOrderListForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  begin
   if FieldByName('PriceIncludesGST').AsBoolean then
      FieldByName('Total').AsFloat := FieldByName('Amount').AsFloat +
                                   FieldByname('Tips').AsFloat +
                                   FieldByName('ServiceCharge').AsFloat +
                                   FieldByName('OtherCharge').AsFloat
    else
     FieldByName('Total').AsFloat := FieldByName('Amount').AsFloat +
                                   FieldByname('Tips').AsFloat +
                                   FieldByName('ServiceCharge').AsFloat +
                                   FieldByName('OtherCharge').AsFloat +
                                   FieldByName('GST').AsFloat;
   FieldByName('Paid').AsFloat := FieldByName('PaidAmount').AsFloat -
                                  FieldByName('Surcharge').AsFloat;
   FieldByName('Balance').AsFloat := FieldByName('Total').AsFloat -
                                     FieldByName('Paid').AsFloat;
   FieldByName('TableNoFlag').AsString := DeleteSpace(FieldByName('TableNo').AsString);
   if FieldByName('OrderPrinted').AsBoolean then
      FieldByName('TableNoFlag').AsString := FieldByName('TableNoFlag').AsString + ' *'
  end;
end;

procedure TOrderListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TOrderListForm.DateEdit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then TimeEdit1.SetFocus;
end;

procedure TOrderListForm.DateEdit2KeyPress(Sender: TObject; var Key: Char);
begin
if Key = Chr(13) then TimeEdit2.SetFocus;
end;

procedure TOrderListForm.TimeEdit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then DateEdit2.SetFocus;
end;

procedure TOrderListForm.TimeEdit2KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then
    begin
     OpenQuery;
     DBGrid.SetFocus;
    end;
end;

procedure TOrderListForm.DateEdit1Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit1.Text) then
    DateEdit1.SetFocus
end;

procedure TOrderListForm.DateEdit2Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit2.Text) then
    DateEdit2.SetFocus;
end;

procedure TOrderListForm.DateEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   DateTemp := TransferDate(Text);
   if DateForm.ReadDatePro(DateTemp) then
      begin
       Text := FormatDateTime('dd/mm/yyyy', DateTemp);
       OpenQuery;
       DBGrid.SetFocus;
      end;
  end;
end;

procedure TOrderListForm.TimeEditClick(Sender: TObject);
var
 TimeStr: string;
begin
 with Sender As TMaskEdit do
  begin
   TimeStr := Text;
   if TimeForm.ReadTimePro(TimeStr) then
      begin
       Text := TimeStr;
       OpenQuery;
       DBGrid.SetFocus;
      end;
  end;
end;

procedure TOrderListForm.MoveUpButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.BOF then
    Query.Prior;
 DBGrid.SetFocus;
end;

procedure TOrderListForm.MoveDownButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.EOF then
    Query.Next;
 DBGrid.SetFocus;
end;

procedure TOrderListForm.PageUpButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.BOF then
    Query.MoveBy(-16);
 DBGrid.SetFocus;
end;

procedure TOrderListForm.PageDownButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.EOF then
    Query.MoveBy(16);
 DBGrid.SetFocus;
end;

procedure TOrderListForm.DBGridDblClick(Sender: TObject);
begin
 ConfirmButtonClick(Sender);
end;

procedure TOrderListForm.ConfirmButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     OrderNo := Query.FieldByName('OrderNo').AsString;
     TableNo := Query.FieldByName('TableNo').AsString;
     ReturnFlag := True;
     Close;
    end;
end;

procedure TOrderListForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TOrderListForm.SetListButtonColor;
begin
 if PaymentFlag = 0 then
    begin
     ListAllButton.DefaultFont.Color := clBlue;
     ListUnPaidButton.DefaultFont.Color := clRed;
    end
   else
    begin
     ListAllButton.DefaultFont.Color := clRed;
     ListUnPaidButton.DefaultFont.Color := clBlue;
    end
end;

procedure TOrderListForm.SetSortButtonColor;
begin
 if SortFlag = 0 then
    DateTimeButton.DefaultFont.Color := clRed
   else
    DateTimeButton.DefaultFont.Color := clBlue;
 if SortFlag = 1 then
    OrderNoButton.DefaultFont.Color := clRed
   else
    OrderNoButton.DefaultFont.Color := clBlue;
 if SortFlag = 2 then
    TableNoButton.DefaultFont.Color := clRed
   else
    TableNoButton.DefaultFont.Color := clBlue;
 if SortFlag = 3 then
    ServiceButton.DefaultFont.Color := clRed
   else
    ServiceButton.DefaultFont.Color := clBlue;
end;

procedure TOrderListForm.ListAllButtonClick(Sender: TObject);
begin
 PaymentFlag := 1;
 SetListButtonColor;
 OpenQuery;
end;

procedure TOrderListForm.ListUnPaidButtonClick(Sender: TObject);
begin
 PaymentFlag := 0;
 SetListButtonColor;
 OpenQuery;
end;

procedure TOrderListForm.ListAllOrdersButtonClick(Sender: TObject);
begin
 DateFlag := 1;
 ListAllOrdersButton.DEfaultFont.Color := clRed;
 ListByDateTimeButton.DefaultFont.Color := clBlue;
 OpenQuery;
end;

procedure TOrderListForm.ListByDateTimeButtonClick(Sender: TObject);
begin
 DateFlag := 0;
 ListAllOrdersButton.DefaultFont.Color := clBlue;
 ListByDateTimeButton.DefaultFont.Color := clRed;
 OpenQuery;
end;

procedure TOrderListForm.DateTimeButtonClick(Sender: TObject);
begin
 SortFlag := 0;
 SetSortButtonColor;
 OpenQuery;
end;

procedure TOrderListForm.OrderNoButtonClick(Sender: TObject);
begin
 SortFlag := 1;
 SetSortButtonColor;
 OpenQuery;
end;

procedure TOrderListForm.TableNoButtonClick(Sender: TObject);
begin
 SortFlag := 2;
 SetSortButtonColor;
 OpenQuery;
end;

procedure TOrderListForm.ServiceButtonClick(Sender: TObject);
begin
 SortFlag := 3;
 SetSortButtonColor;
 OpenQuery;
end;

procedure TOrderListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TOrderListForm.DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ConfirmButtonClick(Sender);
end;

procedure TOrderListForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TOrderListForm.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
 X: integer;
 S: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
 with Sender As TDBGrid do
  begin
   if Column.FieldName = 'OrderDate' then
      begin
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
       S := FormatDateTime('dd/mm/yyyy hh:mm', Column.Field.AsDateTime);
      end
     else
      if (Column.FieldName = 'OrderNo') or
         (Column.FieldName = 'TableNoFlag') or
         (Column.FieldName = 'InvoiceNo') then
         begin
          SetTextAlign(Canvas.Handle, TA_CENTER);
          X := (Rect.Left + Rect.Right) div 2;
          S := Column.Field.AsString;
         end
       else
        if Column.FieldName = 'ServicePerson' then
           begin
            SetTextAlign(Canvas.Handle, TA_LEFT);
            X := Rect.Left + 2;
            S := Column.Field.AsString;
           end
          else
           if Column.FieldName = 'Persons' then
              begin
               SetTextAlign(Canvas.Handle, TA_CENTER);
               X := (Rect.Left + Rect.Right) div 2;
               S := Format('%1d', [Column.Field.AsInteger]);
              end
             else
              begin
               SetTextAlign(Canvas.Handle, TA_RIGHT);
               X := Rect.Right - 2;
               S := FormatCurrency(Column.Field.AsFloat)
              end;
   if State = [] then
      begin
       if Column.FieldName = 'TableNoFlag' then
          Canvas.Font.Color := clRed
         else
          if Query.FieldByName('Balance').AsFloat <= 0 then
             Canvas.Font.Color := clGray
            else
             Canvas.Font.Color := clBlack;
      end;
    Canvas.TextRect(Rect, X, Rect.Top + 2, S);
  end;
end;

procedure TOrderListForm.DateEdit1Change(Sender: TObject);
begin
// if Not Supervisor and Not CheckDailyReport and (Date - TransferDate(DateEdit1.Text) > 3) then
//    DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date - 3);

  if Not Supervisor then
      DateEdit1.Text := FormatDateTime('dd/mm/yyy',Date);
end;

procedure TOrderListForm.FormShow(Sender: TObject);
begin
 ListAllOrdersButton.Enabled := Supervisor;
 if (Time < EndTime) and (EndTime < BeginTime) then
    begin
     DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date - 1);
     DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
    end
   else
    if (Time > BeginTime) and (EndTime < BeginTime) then
       begin
        DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
        DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date + 1);
       end
      else
       begin
        DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
        DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
       end;
 TimeEdit1.Text := FormatDateTime('hh:mm', BeginTime);
 TimeEdit2.Text := FormatDateTime('hh:mm', EndTime);
 SortFlag := 0;
 PaymentFlag := 0;
 DateFlag := 0;
 SetListButtonColor;
 SetSortButtonColor;
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryBalance.DisplayFormat := sCurrency + ',0.#0';
 QueryGST.DisplayFormat := sCurrency + ',0.#0';
 QueryTotal.DisplayFormat := sCurrency + ',0.#0';
 QueryTips.DisplayFormat := sCurrency + ',0.#0';
 QueryServiceCharge.DisplayFormat := sCurrency + ',0.#0';
 QuerySurcharge.DisplayFormat := sCurrency + ',0.#0';
 QueryPaid.DisplayFormat := sCurrency + ',0.#0';
 OpenQuery;
 DBGrid.SetFocus;
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
end;

function TOrderListForm.OrderListPro(var OrderNo, TableNo: string): boolean;
begin
 Application.CreateForm(TOrderListForm, OrderListForm);
 OrderListForm.ShowModal;
 Result := OrderListForm.ReturnFlag;
 if Result then
    begin
     OrderNo := OrderListForm.OrderNo;
     TableNo := OrderListForm.TableNo;
    end; 
 OrderListForm.Free;
end;

end.
