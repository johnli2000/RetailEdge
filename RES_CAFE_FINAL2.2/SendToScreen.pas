unit SendToScreen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, UtilUnit, ADODB, Variants;

type
  BuffType = Record
   ItemCode: String;
   Qty: double;
   PriceSelect: integer;
   Condition: integer;
   SpecialOrder: string;
   ID: integer;
  end;
  TSendToScreenForm = class(TDataModule)
    InstructionQuery: TADOQuery;
    Query: TADOQuery;
    procedure InitBuff;
    function  FindIDNo(IDNo: integer): integer;
    procedure InsertLine(RecordNo: integer);
    function  PostDataToBuff: integer;
    procedure OpenQuery(SQLStr: String);
    procedure OpenInstructionQuery(SQLStr: String);
    function  SaveItemDataPro(KitchenScreenNumber: integer): boolean;
    function  SaveDataToTable(KitchenScreenNumber: integer): boolean;
    procedure SendOutPro;
    procedure SendToScreenPro(OrderNo, IDStr: string; PrintAll: boolean);
  private { Private declarations }
    OrderNo, IDStr: string;
    Buff: array [1..500] of BuffType;
    PrintAll: boolean;
  public
    { Public declarations }
  end;

var
  SendToScreenForm: TSendToScreenForm;

implementation

uses DataUnit;

{$R *.DFM}

procedure TSendToScreenForm.InitBuff;
var
 I: integer;
begin
 for I := 1 to 500 do
  begin
   Buff[I].ItemCode := '';
   Buff[I].Qty := 0;
   Buff[I].PriceSelect := 0;
   Buff[I].Condition := 0;
   Buff[I].SpecialOrder := '';
   Buff[I].ID := 0;
  end;
end;

procedure TSendToScreenForm.InsertLine(RecordNo: integer);
var
 I: integer;
begin
 for I := 500 Downto RecordNo + 1 do Buff[I] := Buff[I - 1];
 with Buff[RecordNo] do
  begin
   ItemCode := '';
   Qty := 0;
   PriceSelect := 0;
   Condition := 0;
   SpecialOrder := '';
   ID := 0;
  end;
end;

function TSendToScreenForm.FindIDNo(IDNo: integer): integer;
var
 I: integer;
begin
 I := 1;
 while (I <= 500) and (IDNo <> Buff[I].ID) do
  I := I + 1;
 if I < 500 then Result := I else Result := -1;
end;

function TSendToScreenForm.PostDataToBuff: integer;
var
 I, K, IDNo: integer;
begin
 InitBuff; I := 0;
 with Query do
  begin
   First;
   while Not EOF do
    begin
     I := I + 1;
     Buff[I].ItemCode := FieldByName('ItemCode').AsString;
     Buff[I].Qty := FieldByName('Qty').AsFloat;
     Buff[I].PriceSelect := FieldByName('PriceSelect').AsInteger;
     Buff[I].ID := FieldByName('IDNo').AsInteger;
     Buff[I].SpecialOrder := FieldByName('SpecialOrder').AsString;
     Buff[I].Condition := 0;
     Next;
    end;
   Close;
  end;
 with InstructionQuery do
  begin
   First;
   while Not EOF do
    begin
     IDNo := FieldByName('IDNo').AsInteger - 1;
     K := FindIDNo(IDNo);
     if K > 0 then
        begin
         InsertLine(K + 1);
         Buff[K + 1].ItemCode := FieldByName('ItemCode').AsString;
         Buff[K + 1].Qty := FieldByName('Qty').AsFloat;
         Buff[K + 1].PriceSelect := FieldByName('PriceSelect').AsInteger;
         Buff[K + 1].ID := FieldByName('IDNo').AsInteger;
         Buff[K + 1].Condition := FieldByName('Condition').AsInteger;
         Buff[K + 1].SpecialOrder := FieldByName('SpecialOrder').AsString;
         I := I + 1;
        end;
     Next;
    end;
  end;
 Result := I;
end;

procedure TSendToScreenForm.OpenQuery(SQLStr: String);
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

procedure TSendToScreenForm.OpenInstructionQuery(SQLStr: String);
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

function TSendToScreenForm.SaveItemDataPro(KitchenScreenNumber: integer): boolean;
var
 SQLStr, SpecialOrder: string;
 I: Integer;
 KitchenNumber: array [1..12] of string;
begin
 for I := 1 to 12 do
  if I = KitchenScreenNumber then
     KitchenNumber[I] := '1'
    else
     KitchenNumber[I] := '0';

 I := 1;
 Result := True;
 while (I <= 500) and Result do
  begin
   if Buff[I].ItemCode <> '' then
      begin
       if Buff[I].SpecialOrder <> '' then
          SpecialOrder := Chr(39) + CheckQuotes(Buff[I].SpecialOrder) + Chr(39)
         else
          SpecialOrder := 'Null';
       SQLStr := 'IF (SELECT COUNT(*) FROM KitchenScreen ' +
                 'Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
                 ' and ItemCode=' + Chr(39) + CheckQuotes(Buff[I].ItemCode) + Chr(39) +
                 ' and ID=' + IntToStr(Buff[I].ID) + ') = 0 ' +
                 ' BEGIN ' +
                 '  Insert Into KitchenScreen(OrderNo, ItemCode, Qty, PriceSelect, ' +
                 '  Condition, SpecialOrder, Finished, SentDateTime, KitchenScreenNumber1, ' +
                 '  KitchenScreenNumber2, KitchenScreenNumber3, KitchenScreenNumber4, ' +
                 '  KitchenScreenNumber5, KitchenScreenNumber6, KitchenScreenNumber7, ' +
                 '  KitchenScreenNumber8, KitchenScreenNumber9, KitchenScreenNumber10, ' +
                 '  KitchenScreenNumber11, KitchenScreenNumber12, Resend, Locked, ID) ' +
                 '  Values(' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) + ',' +
                    Chr(39) + CheckQuotes(Buff[I].ItemCode) + Chr(39) + ',' +
                    FloatToStr(Buff[I].Qty) + ',' + IntToStr(Buff[I].PriceSelect) + ',' +
                    IntToStr(Buff[I].Condition) + ',' + SpecialOrder + ', 0, ' +
                    ConvertDateTime(Date + Time) + ',' +
                    KitchenNumber[1] + ',' + KitchenNumber[2] + ',' + KitchenNumber[3] + ',' +
                    KitchenNumber[4] + ',' + KitchenNumber[5] + ',' + KitchenNumber[6] + ',' +
                    KitchenNumber[7] + ',' + KitchenNumber[8] + ',' + KitchenNumber[9] + ',' +
                    KitchenNumber[10] + ',' + KitchenNumber[11] + ',' + KitchenNumber[12] + ',' +
                 '  0, 0, ' + IntToStr(Buff[I].ID) + ') ' +
                 ' END '+
                 'ELSE ' +
                 ' BEGIN ' +
                 '  Declare @KitchenScreenNumber Bit ' +
                 '  Select @KitchenScreenNumber=KitchenScreenNumber' + IntToStr(KitchenScreenNumber) +
                 '  From KitchenScreen ' +
                 '  Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
                 '  and ItemCode=' + Chr(39) + CheckQuotes(Buff[I].ItemCode) + Chr(39) +
                 '  and ID=' + IntToStr(Buff[I].ID) +
                 '  if @KitchenScreenNumber <> 0 ' +
                 '     BEGIN ' +
                 '      Update KitchenScreen Set ReSend=1, Finished = 0 ' +
                 '      Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
                 '      and ItemCode=' + Chr(39) + CheckQuotes(Buff[I].ItemCode) + Chr(39) +
                 '      and ID=' + IntToStr(Buff[I].ID) +
                 '     END ' +
                 '    ELSE ' +
                 '     BEGIN ' +
                 '      Update KitchenScreen Set KitchenScreenNumber' + IntToStr(KitchenScreenNumber) + '=1 ' +
                 '      Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
                 '      and ItemCode=' + Chr(39) + CheckQuotes(Buff[I].ItemCode) + Chr(39) +
                 '      and ID=' + IntToStr(Buff[I].ID) +
                 '     END ' +
                 '  END ';
       Result := DataForm.ExecQueryPro(SQLStr);
      end;
   I := I + 1;
  end;
end;

function TSendToScreenForm.SaveDataToTable(KitchenScreenNumber: Integer): boolean;
begin
 Result := SaveItemDataPro(KitchenScreenNumber);
end;

procedure TSendToScreenForm.SendOutPro;
var
 SQLStr: string;
 I: Integer;
 Flag: boolean;
begin
 SQLStr := 'Select OrderI.ItemCode, Condition, Qty, PriceSelect, SpecialOrder, IDNo ' +
           'From MenuItem, OrderI ' +
           'Where MenuItem.ItemCode=OrderI.ItemCode and ' +
           'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           ' and Condition > 0 Order By IDNo';
 OpenInstructionQuery(SQLStr);
 Flag := True;
 if DataForm.BeginTransaction then
    try
     I := 1;
     while Flag and (I <= 12) do
      begin
       if PrintAll then
          begin
           SQLStr := 'Select OrderI.ItemCode, Condition, Qty, PriceSelect, SpecialOrder, IDNo ' +
                     'From MenuItem, OrderI ' +
                     'Where MenuItem.ItemCode=OrderI.ItemCode and ' +
                     'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) + ' and ' +
                     'Condition = 0 and (' +
                     'KitchenScreen1 = ' + IntToStr(I) + ' or ' +
                     'KitchenScreen2 = ' + IntToStr(I) + ' or ' +
                     'KitchenScreen3 = ' + IntToStr(I) + ' or ' +
                     'KitchenScreen4 = ' + IntToStr(I) + ')';
           if Not PrintZeroQtyItemsOnJobList then SQLStr := SQLStr + ' and ABS(Qty) >= 0.01 ';
           SQLStr := SQLStr + ' Order By IDNo';
          end
         else
          begin
           SQLStr := 'Select OrderI.ItemCode, Condition, Qty, PriceSelect, SpecialOrder, IDNo ' +
                     'From MenuItem, OrderI ' +
                     'Where MenuItem.ItemCode=OrderI.ItemCode and ' +
                     'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) + ' and ' +
                     'Condition = 0 and (' +
                     'KitchenScreen1 = ' + IntToStr(I) + ' or ' +
                     'KitchenScreen2 = ' + IntToStr(I) + ' or ' +
                     'KitchenScreen3 = ' + IntToStr(I) + ' or ' +
                     'KitchenScreen4 = ' + IntToStr(I) + ')';
           if Not PrintZeroQtyItemsOnJobList then SQLStr := SQLStr + ' and ABS(Qty) >= 0.01 ';
           if IDStr <> '' then
              SQLStr := SQLStr + ' and IDNo In (' + IDStr + ')'
             else
              SQLStr := SQLStr + ' and SentToKitchen = 0';
           SQLStr := SQLStr + ' Order By IDNo';
          end;
       OpenQuery(SQLStr);
       if Query.Active and (Query.RecordCount > 0) and (PostDataToBuff > 0) then
          Flag := SaveDataToTable(I);
       I := I + 1;
      end;
     SQLStr := 'Update OrderI Set SentToKitchen=1 Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
     if Not PrintAll and (IDStr <> '') then SQLStr := SQLStr + ' and IDNo In (' + IDStr + ')';
     Flag := DataForm.ExecQueryPro(SQLStr);
    finally
     if Flag then
        DataForm.CommitTransaction
       else
        DataForm.RollBack;
    end;
end;

procedure TSendToScreenForm.SendToScreenPro(OrderNo, IDStr: string; PrintAll: boolean);
begin
 Application.CreateForm(TSendToScreenForm, SendToScreenForm);
 SendToScreenForm.OrderNo := OrderNo;
 SendToScreenForm.IDStr := IDStr;
 SendToScreenForm.PrintAll := PrintAll;
 SendToScreenForm.SendOutPro;
 SendToScreenForm.Free;
end;

end.
