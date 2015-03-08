unit PrintCheckList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, UtilUnit, ADODB, Variants;

type
  BuffType = Record
   Qty: double;
   Description1, Description2: string;
   IDNo: integer;
   Instruction: boolean;
   Price: double;
  end;
  TPrintCheckListForm = class(TDataModule)
    InstructionQuery: TADOQuery;
    Query: TADOQuery;
    procedure InitBuff;
    function  FindIDNo(IDNo: integer): integer;
    function  FindLinePosition(IDNo: integer): integer;
    procedure InsertLine(RecordNo: integer);
    function  PostDataToBuff: integer;
    procedure OpenQuery(SQLStr: String);
    function  GetVoidReasonPro(VoidReasonCode: string): string;
    procedure OpenInstructionQuery(SQLStr: String);
    procedure PrintConfirmedOrder;
    procedure PrintUnConfirmedOrder;
    procedure PrintCheckListPro;
    procedure PrintOutPro;
    procedure PrintCheckList(OrderNo, IDStr: string; PrintAll, ConfirmedOrder: boolean);
  private { Private declarations }
    OrderNo, IDStr, TableNo, ServicePerson, OrderDate: string;
    PrintAll, ConfirmedOrder: boolean;
    Buff: array [1..500] of BuffType;
  public
    { Public declarations }
  end;

var
  PrintCheckListForm: TPrintCheckListForm;

implementation

uses DataUnit;

{$R *.DFM}

procedure TPrintCheckListForm.InitBuff;
var
 I: integer;
begin
 for I := 1 to 500 do
  begin
   Buff[I].Qty := 0;
   Buff[I].Description1 := '';
   Buff[I].Description2 := '';
   Buff[I].IDNo := 0;
   Buff[I].Instruction := False;
   Buff[I].Price := 0;
  end;
end;

procedure TPrintCheckListForm.InsertLine(RecordNo: integer);
var
 I: integer;
begin
 for I := 500 Downto RecordNo + 1 do Buff[I] := Buff[I - 1];
 with Buff[RecordNo] do
  begin
   Qty := 0;
   Description1 := '';
   Description2 := '';
   IDNo := 0;
   Instruction := False;
   Price := 0;
  end;
end;

function TPrintCheckListForm.FindIDNo(IDNo: integer): integer;
var
 I: integer;
begin
 I := 1;
 while (I <= 500) and (IDNo <> Buff[I].IDNo) do
  I := I + 1;
 if I < 500 then Result := I else Result := -1;
end;

function TPrintCheckListForm.FindLinePosition(IDNo: integer): integer;
var
 I: integer;
begin
 I := 1;
 while (I <= 500) and (IDNo > Buff[I].IDNo) do
  I := I + 1;
 if (I = 1) or ((I > 1) and (I <= 500) and (IDNo < Buff[I].IDNo) and (IDNo > Buff[I - 1].IDNo)) then
    Result := I - 1
   else
    Result := -1;
end;

function TPrintCheckListForm.PostDataToBuff: integer;
var
 I, K, IDNo: integer;
 Description1, Description2, FieldName: string;
begin
 InitBuff; I := 0;
 with Query do
  begin
   First;
   while Not EOF do
    begin
     Description1 := FieldByName('Description1').AsString;
     Description2 := FieldByName('Description2').AsString;
     if FieldByName('Multiple').AsBoolean then
        begin
         FieldName := GenerateSubDescriptionFieldName(FieldByName('PriceSelect').AsInteger);
         if FieldByName(FieldName).AsString <> '' then
            begin
             Description1 := Description1 + '/' + FieldByName(FieldName).AsString;
             if Description2 <> '' then
                Description2 := Description2 + '/' + FieldByName(FieldName).AsString;
            end;
        end;
     I := I + 1;
     Buff[I].Qty := FieldByName('Qty').AsFloat;
     Buff[I].Description1 := Description1;
     Buff[I].Description2 := Description2;
     Buff[I].IDNo := FieldByName('IDNo').AsInteger;
     Buff[I].Instruction := False;
     Buff[I].Price := FieldByName('Price').AsFloat;
     Next;
    end;
   Close;
  end;
 if CheckListFormat > 0 then
    with InstructionQuery do
     begin
      First;
      while Not EOF do
       begin
        Description1 := FieldByName('Description1').AsString;
        Description2 := FieldByName('Description2').AsString;
        if FieldByName('Multiple').AsBoolean then
           begin
            FieldName := GenerateSubDescriptionFieldName(FieldByName('PriceSelect').AsInteger);
            if FieldByName(FieldName).AsString <> '' then
               begin
                Description1 := Description1 + '/' + FieldByName(FieldName).AsString;
                Description2 := Description2 + '/' + FieldByName(FieldName).AsString;
               end;
           end;
        case FieldByName('Condition').AsInteger of
         1: Description1 := '* ' + Description1;
         2: Description1 := '[A] ' + Description1;
         3: Description1 := '[C] ' + Description1;
         4: Description1 := '[M] ' + Description1;
         5: Description1 := '[L] ' + Description1;
        end;
        if Description2 <> '' then
           case FieldByName('Condition').AsInteger of
            1: Description2 := '* ' + Description2;
            2: Description2 := '[A] ' + Description2;
            3: Description2 := '[C] ' + Description2;
            4: Description2 := '[M] ' + Description2;
            5: Description2 := '[L] ' + Description2;
           end;
        IDNo := FieldByName('IDNo').AsInteger - 1;
        K := FindIDNo(IDNo);
        if K > 0 then
           begin
            InsertLine(K + 1);
            Buff[K + 1].Qty := FieldByName('Qty').AsFloat;
            Buff[K + 1].Price := FieldByName('Price').AsFloat;
            Buff[K + 1].Description1 := Description1;
            Buff[K + 1].Description2 := Description2;
            Buff[K + 1].IDNo := FieldByName('IDNo').AsInteger;
            Buff[K + 1].Instruction := True;
            Buff[K + 1].Instruction := True;
            I := I + 1;
           end;
        Next;
       end;
     end;
 Result := I;
end;

procedure TPrintCheckListForm.OpenQuery(SQLStr: String);
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

procedure TPrintCheckListForm.OpenInstructionQuery(SQLStr: String);
begin
 Screen.Cursor := crHourGlass;
 with InstructionQuery do
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

function TPrintCheckListForm.GetVoidReasonPro(VoidReasonCode: string): string;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From VoidReasonTable Where Code=' + Chr(39) + CheckQuotes(VoidReasonCode) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  if Active and (RecordCount > 0) then
     Result := FieldByName('Description').AsString
    else
     Result := '';
 Query.Close;
end;

procedure TPrintCheckListForm.PrintOutPro;
var
 PrintStr, Description, LineStr, Temp: string;
 I, CharCount, PaperWidth: integer;
begin
 PaperWidth := 20;
 LineStr := '';
 for I := 1 to PaperWidth do LineStr := LineStr + '=';
 DataForm.OpenPrinterPort(FVar.CheckListPrinterPort);
 DataForm.SetBlackFontB;
 PrintStr := Format('%' + IntToStr((PaperWidth - 10) div 2) + 's%s', ['', 'CHECK LIST']);
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 DataForm.SetBlackFontA;
 if ConfirmedOrder then
    PrintStr := 'Order Number: ' + Copy(OrderNo, 7, 4) + '      Date: ' + OrderDate
   else
    PrintStr := 'Hold  Number: ' + Format('%-4s', [OrderNo]) + '      Date: ' + OrderDate;
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontB;
 if TableNo <> '' then DataForm.OutPutToPrinter(TableNo);
 PrintStr := 'Service:  ' + Format('%s', [ServicePerson]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(LineStr);
 for I := 1 to 500 do
  if Buff[I].IDNo > 0 then
     begin
      if Not Buff[I].Instruction then
         begin
          if I > 1 then DataForm.OutPutToPrinter(' ');
          PrintStr := Format('%-5s', [FloatToStr(Buff[I].Qty)]);
          if (PrintJobListDescription <> 2) or (Buff[I].Description2 = '') then
             Description := Buff[I].Description1
            else
             Description := Buff[I].Description2;
          Temp := Copy(Description, 1, 15);
          CharCount := 15;
          PrintStr := PrintStr + Temp;
          DataForm.OutPutToPrinter(PrintStr);
          while Length(Description) > CharCount do
           begin
            PrintStr := '     ' + Copy(Description, CharCount + 1, 15);
            DataForm.OutPutToPrinter(PrintStr);
            CharCount := CharCount + 15
           end;
         end
        else
         begin
          if (PrintJobListDescription <> 2) or (Buff[I].Description2 = '') then
             Description := Buff[I].Description1
            else
             Description := Buff[I].Description2;
          Temp := Copy(Description, 1, 15);
          CharCount := 15;
          PrintStr := '     ' + Temp;
          DataForm.OutPutToPrinter(PrintStr);
          while Length(Description) > CharCount do
           begin
            PrintStr := '     ' + Copy(Description, CharCount + 1, 15);
            DataForm.OutPutToPrinter(PrintStr);
            CharCount := CharCount + 15
           end;
         end;
     end;
 DataForm.OutPutToPrinter(LineStr);
 PrintStr := FormatDateTime('dd/mm/yyyy  h:mmam/pm', Date + Time);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TPrintCheckListForm.PrintConfirmedOrder;
var
 SQLStr: string;
begin
 SQLStr := 'Select TableNo, ServicePerson, OrderDate, BillKind From OrderH ' +
           'Where OrderNo = ' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   case FieldByName('BillKind').AsInteger of
    sTABLEORDER: TableNo := 'Table: ' + DeleteSpace(FieldByName('TableNo').AsString);
    sQUICKSALE: TableNo := 'Quick Service';
    sPHONEORDER: TableNo := 'Phone Order';
   end;
   ServicePerson := FieldByName('ServicePerson').AsString;
   OrderDate := FormatDateTime('dd/mm/yyyy', FieldByName('OrderDate').AsDateTime);
   Close;
  end;
 if PrintAll then
    SQLStr := 'Select OrderI.ItemCode, Description1, Description2, Condition, Qty, ' +
              'OrderI.Price, PriceSelect, SubDescription, SubDescription1, ' +
              'SubDescription2, SubDescription3, IDNo, Multiple ' +
              'From OrderI, MenuItem ' +
              'Where MenuItem.ItemCode=OrderI.ItemCode and ' +
              'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
              ' and Condition > 0'
   else
    SQLStr := 'Select OrderI.ItemCode, Description1, Description2, Condition, Qty, ' +
              'OrderI.Price, PriceSelect, SubDescription, SubDescription1, ' +
              'SubDescription2, SubDescription3, IDNo, Multiple ' +
              'From OrderI, MenuItem ' +
              'Where MenuItem.ItemCode=OrderI.ItemCode and ' +
              'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
              ' and Condition > 0 and CheckListPrinted=0 ';
 OpenInstructionQuery(SQLStr);
 if PrintAll then
    SQLStr := 'Select OrderI.ItemCode, Description1, Description2, ' +
              'Condition, Qty, OrderI.Price, PriceSelect, ' +
              'SubDescription, SubDescription1, SubDescription2, ' +
              'SubDescription3, IDNo, Multiple ' +
              'From OrderI, MenuItem ' +
              'Where MenuItem.ItemCode=OrderI.ItemCode and ' +
              'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
              ' and Condition = 0'
   else
    begin
     SQLStr := 'Select OrderI.ItemCode, Description1, Description2, ' +
               'Condition, Qty, OrderI.Price, PriceSelect, ' +
               'SubDescription, SubDescription1, SubDescription2, ' +
               'SubDescription3, IDNo, Multiple ' +
               'From OrderI, MenuItem ' +
               'Where MenuItem.ItemCode=OrderI.ItemCode and Condition=0 and ' +
               'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
     if IDStr <> '' then
        SQLStr := SQLStr + ' and IDNo In (' + IDStr + ')'
       else
        SQLStr := SQLStr + ' and CheckListPrinted = 0';
    end;
 SQLStr := SQLStr +  ' Order By IDNo';
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0)  and (PostDataToBuff > 0) then PrintOutPro;
 InstructionQuery.Close;
 SQLStr := 'Update OrderI Set CheckListPrinted=1 Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 if Not PrintAll and (IDStr <> '') then SQLStr := SQLStr + ' and IDNo In (' + IDSTr + ')';
 DataForm.ExecQueryPro(SQLStr);
end;

procedure TPrintCheckListForm.PrintUnConfirmedOrder;
var
 SQLStr: string;
begin
 SQLStr := 'Select CustomerName, OpName, HoldDate From HoldHead ' +
           'Where HoldNo = ' + OrderNo;
 OpenQuery(SQLStr);
 with Query do
  begin
   TableNo := FieldByName('CustomerName').AsString;
   ServicePerson := FieldByName('OpName').AsString;
   OrderDate := FormatDateTime('dd/mm/yyyy', FieldByName('HoldDate').AsDateTime);
   Close;
  end;
 SQLStr := 'Select HoldItem.ItemCode, Description1, Description2, Condition, Qty, ' +
           'HoldItem.Price, HoldItem.PriceSelect, SubDescription, SubDescription1, ' +
           'SubDescription2, SubDescription3, ID AS IDNo, Multiple ' +
           'From HoldItem, MenuItem ' +
           'Where MenuItem.ItemCode=HoldItem.ItemCode and ' +
           'HoldNo=' + OrderNo + ' and Condition > 0 Order By ID';
 OpenInstructionQuery(SQLStr);
 if PrintAll then
    SQLStr := 'Select HoldItem.ItemCode, Description1, Description2, ' +
              'Condition, Qty, HoldItem.Price, PriceSelect, ' +
              'SubDescription, SubDescription1, SubDescription2, ' +
              'SubDescription3, ID As IDNo, Multiple ' +
              'From HoldItem, MenuItem ' +
              'Where MenuItem.ItemCode=HoldItem.ItemCode and ' +
              'HoldNo=' + OrderNo + ' and Condition = 0 Order By ID'
   else
    SQLStr := 'Select HoldItem.ItemCode, Description1, Description2, ' +
              'Condition, Qty, HoldItem.Price, PriceSelect, ' +
              'SubDescription, SubDescription1, SubDescription2, ' +
              'SubDescription3, ID As IDNo, Multiple ' +
              'From HoldItem, MenuItem ' +
              'Where MenuItem.ItemCode=HoldItem.ItemCode and ' +
              'HoldNo=' + OrderNo + ' and Condition = 0 and ' +
              'CheckListPrinted=0 Order By ID';
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0) and (PostDataToBuff > 0) then
    PrintOutPro;
 InstructionQuery.Close;
 SQLStr := 'Update HoldItem Set CheckListPrinted=1 Where HoldNo=' + OrderNo;
 DataForm.ExecQueryPro(SQLStr);
end;

procedure TPrintCheckListForm.PrintCheckListPro;
begin
 if ConfirmedOrder then
    PrintConfirmedOrder
   else
    PrintUnConfirmedOrder;
end;

procedure TPrintCheckListForm.PrintCheckList(OrderNo, IDStr: string; PrintAll, ConfirmedOrder: boolean);
begin
 if (FVar.CheckListPrinterPort > 0) and (String(FVar.POSPrinter[FVar.CheckListPrinterPort].Name) <> 'N/A') then
    begin
     Application.CreateForm(TPrintCheckListForm, PrintCheckListForm);
     PrintCheckListForm.PrintAll := PrintAll;
     PrintCheckListForm.OrderNo := OrderNo;
     PrintCheckListForm.IDStr := IDStr;
     PrintCheckListForm.ConfirmedOrder := ConfirmedOrder;
     PrintCheckListForm.PrintCheckListPro;
     PrintCheckListForm.Free;
    end;
end;

end.
