unit MergeTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, ADODB, MainMenu, UtilUnit,
  BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TMergeTableForm = class(TForm)
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    SourceTableNo: TbsSkinLabel;
    TargetTableNo: TbsSkinLabel;
    SourceTableButton: TbsSkinSpeedButton;
    TargetTableButton: TbsSkinSpeedButton;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure OpenQuery(SQLStr: string);
    procedure SourceTableButtonClick(Sender: TObject);
    procedure TargetTableButtonClick(Sender: TObject);
    procedure PrintTableMergeSlip;
    procedure SetJobListPrintedFlag;
    function  CheckSplitBillStatus: boolean;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  MergeItems: boolean;
    function  CalcAmount: boolean;
    function  UpdatePayment: boolean;
    procedure MergeTablePro;
  private { Private declarations }
     SourceOrderNo, TargetOrderNo: string;
     SourceOrderLastIDNo, TargetOrderLastIDNo: integer;
  public
    { Public declarations }
  end;

var
  MergeTableForm: TMergeTableForm;

implementation

uses DataUnit, ReadOrderNo, MessageBox, PrintJobCard, PrintJobCard1,
     PrintJobCard2, PrintJobCard3, PrintJobCard4, PrintCheckList,
     PrintJobCard5, PrintJobListControl;

{$R *.dfm}

procedure TMergeTableForm.OpenQuery(SQLStr: string);
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

procedure TMergeTableForm.SourceTableButtonClick(Sender: TObject);
var
 SQLStr, BookingNo, TableNo: string;
 TableSeats: integer;
begin
 if ReadOrderNoForm.ReadOrderNoPro(SourceOrderNo, BookingNo, TableNo, TableSeats, sEditTable) then
    begin
     SQLStr := 'Select TableNo From OrderH Where OrderNo = ' + Chr(39) + CheckQuotes(SourceOrderNo) + Chr(39);
     OpenQuery(SQLStr);
     if Query.Active and (Query.RecordCount > 0) then
        SourceTableNo.Caption := Query.FieldByName('TableNo').AsString;
    end;
end;

procedure TMergeTableForm.TargetTableButtonClick(Sender: TObject);
var
 BookingNo, TableNo, SQLStr: string;
 TableSeats: integer;
begin
 if ReadOrderNoForm.ReadOrderNoPro(TargetOrderNo, BookingNo, TableNo, TableSeats, sEditTable) then
    begin
     SQLStr := 'Select TableNo From OrderH Where OrderNo = ' + Chr(39) + CheckQuotes(TargetOrderNo) + Chr(39);
     OpenQuery(SQLStr);
     if Query.Active and (Query.RecordCount > 0) then
        TargetTableNo.Caption := Query.FieldByName('TableNo').AsString;
    end;
end;

procedure TMergeTableForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

function TMergeTableForm.MergeItems: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select Count(*) From OrderI ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(TargetOrderNo) + Chr(39);
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0) then
    TargetOrderLastIDNo := Query.Fields[0].AsInteger
   else
    TargetOrderLastIDNo := 0;
 Query.Close;

 SQLStr := 'Select Count(*) From OrderI ' +
           'Where VoidFlag = 0 and OrderNo=' + Chr(39) + CheckQuotes(SourceOrderNo) + Chr(39);
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0) then
    SourceOrderLastIDNo := Query.Fields[0].AsInteger
   else
    SourceOrderLastIDNo := 0;
 Query.Close;

 SQLStr := 'Select * From OrderI Where VoidFlag = 0 and ' +
           'OrderNo=' + Chr(39) + CheckQuotes(SourceOrderNo) + Chr(39) +
           ' Order By IDNo';
 OpenQuery(SQLStr);

 Result := True;
 with Query do
  While Not EOF and Result do
   begin
    Inc(TargetOrderLastIDNo);
    SQLStr := 'Insert Into OrderI(OrderNo, ItemCode, Qty, PaidQty, ' +
              'Price, Discount, TaxRate, PrintFlag, Condition, ' +
              'PriceSelect, Seat, SentToKitchen, IDNo, VoidReason, ' +
              'SpecialOrder, CheckListPrinted, VoidFlag, OrderOperator) ' +
               'Values(' + Chr(39) + CheckQuotes(TargetOrderNo) + Chr(39) + ',' +
              Chr(39) + CheckQuotes(FieldByName('ItemCode').AsString) + Chr(39) + ',' +
              FieldByName('Qty').AsString + ',' +
              FieldByName('PaidQty').AsString + ',' +
              FieldByName('Price').AsString + ', 0, ' +
              FieldByName('TaxRate').AsString + ', 0, ' +
              FieldByName('Condition').AsString + ',' +
              FieldByName('PriceSelect').AsString + ',' +
              FieldByName('Seat').AsString + ', 0, ' +
              IntToStr(TargetOrderLastIDNo) + ', Null, ' +
              Chr(39) + 'Merge from table: ' +
              CheckQuotes(SourceTableNo.Caption) + Chr(39) +
              ', 0, 0, ' + Chr(39) + CheckQuotes(sUserName) + Chr(39) + ')';
    Result := DataForm.ExecQueryPro(SQLStr);
    if Result then
       begin
        Inc(SourceOrderLastIDNo);
        SQLStr := 'Insert Into OrderI(OrderNo, ItemCode, Qty, PaidQty, ' +
                  'Price, Discount, TaxRate, PrintFlag, Condition, ' +
                  'PriceSelect, Seat, SentToKitchen, IDNo, VoidReason, ' +
                  'SpecialOrder, CheckListPrinted, VoidFlag, OrderOperator) ' +
                  'Values(' + Chr(39) + CheckQuotes(SourceOrderNo) + Chr(39) + ',' +
                  Chr(39) + CheckQuotes(FieldByName('ItemCode').AsString) + Chr(39) + ',' +
                  FloatToStr(0 - FieldByName('Qty').AsFloat) + ',' +
                  FloatToStr(0 - FieldByName('PaidQty').AsFloat) + ',' +
                  FieldByName('Price').AsString + ',' +
                  FieldByName('Discount').AsString + ',' +
                  FieldByName('TaxRate').AsString + ', 0, ' +
                  FieldByName('Condition').AsString + ',' +
                  FieldByName('PriceSelect').AsString + ',' +
                  FieldByName('Seat').AsString + ', 0, ' +
                  IntToStr(TargetOrderLastIDNo) + ', Null, ' +
                  Chr(39) + 'Merge to table: ' +
                  CheckQuotes(TargetTableNo.Caption) + Chr(39) + ', 0, 1, ' +
                  Chr(39) + CheckQuotes(sUserName) + Chr(39) + ')';
        Result := DataForm.ExecQueryPro(SQLStr);
       end;
     Next;
    end;
end;

function TMergeTableForm.CalcAmount: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Update OrderH Set Amount = 0, Tips = 0, DollarDiscount = 0, ' +
           'Surcharge = 0, ServiceCharge = 0, OtherCharge = 0, ' +
           'RewardPoints = 0, GST = 0 ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(SourceOrderNo) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Update OrderI Set VoidFlag=1 Where OrderNo=' +
               Chr(39) + CheckQuotes(SourceOrderNo) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    Result := DataForm.RecalculateOrderAmount(TargetOrderNo);
end;

function TMergeTableForm.UpdatePayment: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select Count(*) From RecvAcct Where OrderNo=' + Chr(39) + CheckQuotes(SourceOrderNo) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  if Active and (Fields[0].AsInteger >= 1) then
     begin
      SQLStr := 'Update RecvAcct Set OrderNo=' + Chr(39) + CheckQuotes(TargetOrderNo) + Chr(39) +
                ' Where OrderNo=' + Chr(39) + CheckQuotes(SourceOrderNo) + Chr(39);
      Result := DataForm.ExecQueryPro(SQLStr);
     end
    else
     Result := True;
end;
 
procedure TMergeTableForm.SetJobListPrintedFlag;
var
 SQLStr: string;
begin
 SQLStr := 'Update OrderI Set PrintFlag = 1 Where OrderNo=' + Chr(39) + CheckQuotes(TargetOrderNo) + Chr(39);
 DataForm.ExecQueryPro(SQLStr);
 SQLStr := 'Update OrderI Set PrintFlag = 1 Where OrderNo=' + Chr(39) + CheckQuotes(SourceOrderNo) + Chr(39);
 DataForm.ExecQueryPro(SQLStr);
end;

procedure TMergeTableForm.PrintTableMergeSlip;
var
 I: integer;
 SQLStr, Lines, Temp: string;
begin
 SQLStr := 'Select PrinterPort From ' +
           '( Select PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(TargetOrderNo) + Chr(39) +
           'Union ' +
           'Select PrinterPort1 As PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(TargetOrderNo) + Chr(39) +
           'Union ' +
           'Select PrinterPort2 PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(TargetOrderNo) + Chr(39) +
           'Union ' +
           'Select PrinterPort3 PrinterPort From OrderI, MenuItem ' +
           'Where OrderI.ItemCode=MenuItem.ItemCode and OrderNo=' + Chr(39) + CheckQuotes(TargetOrderNo) + Chr(39) +
           ') As TempTable Group By PrinterPort Order By PrinterPort';
 OpenQuery(SQLStr);
 Lines := '';
 for I := 1 to 20 do Lines := Lines + '=';
 with Query do
  begin
   First;
   while Not EOF do
    begin
     I := FieldByName('PrinterPort').AsInteger;
     if (I > 0) and (String(FVar.POSPrinter[I].Name) <> 'N/A') then
         begin
          DataForm.OpenPrinterPort(I);
          DataForm.SetBlackFontB;
          DataForm.OutPutToPrinter(Lines);
          DataForm.OutPutToPrinter('TABLE Merge:');
          Temp := SourceTableNo.Caption + ' Merged To ' + TargetTableNo.Caption;
          Temp := Format('%' + IntToStr((20 - Length(Temp)) div 2) + 's%s', [' ', Temp]);
          DataForm.OutPutToPrinter(Temp);
          DataForm.OutPutToPrinter(FormatDateTime('dd/mm/yyyy hh:mmAM/PM', Date + Time));
          DataForm.OutPutToPrinter(Lines);
          DataForm.OutPutToPrinter(' ');
          DataForm.OutPutToPrinter(' ');
          DataForm.CutPaper;
          DataForm.ClosePrinterPort;
         end;
     Next;
    end;
   Close;
  end;
end;

function TMergetableForm.CheckSplitBillStatus: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select SplitBill From OrderH ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(SourceOrderNo) + Chr(39);
 OpenQuery(SQLStr);
 Result := Query.Fields[0].AsBoolean;
 SQLStr := 'Select SplitBill From OrderH ' +
           'Where OrderNo=' + Chr(39) + CheckQuotes(TargetOrderNo) + Chr(39);
 OpenQuery(SQLStr);
 Result := Result and Query.Fields[0].AsBoolean;
 Query.Close;
end;

procedure TMergeTableForm.ConfirmButtonClick(Sender: TObject);
var
 Flag: boolean;
 SplitBillStatus: boolean;
begin
 if (SourceTableNo.Caption = '') or (TargetTableNo.Caption = '') or
    (SourceTableNo.Caption = TargetTableNo.Caption) or
    (SourceOrderno = TargetOrderNo) then
    begin
     MessageBoxForm.MessagePro('Table number is invalid.', sInformationMsg);
     Exit;
    end;
 if Not DataForm.BeginTransaction then Exit;
 Flag := True;
 try
  Flag := MergeItems;
  if Flag then Flag := CalcAmount;
  if Flag then Flag := UpdatePayment;
  if Flag then
     begin
      SplitBillStatus := CheckSplitBillStatus;
      Flag := DataForm.UpdateOrderPayment(TargetOrderNo, SplitBillStatus);
     end; 
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      if AutoPrintMergedOrder then
         begin
          PrintJobListControlForm.PrintJobListControlPro(SourceOrderNo, '', False, sConfirmedOrder);
          PrintJobListControlForm.PrintJobListControlPro(TargetOrderNo, '', False, sConfirmedOrder);
          if AutoPrintCheckList then
             begin
              PrintCheckListForm.PrintCheckList(SourceOrderNo, '', False, sConfirmedOrder);
              PrintCheckListForm.PrintCheckList(TargetOrderNo, '', False, sConfirmedOrder);
             end;
         end
        else
         begin
          SetJobListPrintedFlag;
          PrintTableMergeSlip;
         end;
      MessageBoxForm.MessagePro('Table merged successful.' + Chr(13) + Chr(10) + Chr(13) + Chr(10) +
      'You must use Table Order function to check this order.', sInformationMsg);
      Close;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TMergeTableForm.MergeTablePro;
begin
 Application.CreateForm(TMergeTableForm, MergeTableForm);
 MergeTableForm.ShowModal;
 MergeTableForm.Free;
end;

end.
