unit MealPackage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, ExtCtrls, DB, DataUnit, UtilUnit, ComCtrls,
  Tabnotbk, ADODB, MainMenu, BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TPackageSetup = class(TForm)
    Label2: TLabel;
    TabControl: TTabControl;
    StringGrid: TStringGrid;
    AmountEdit: TStaticText;
    Label1: TLabel;
    QtyEdit: TEdit;
    Query: TADOQuery;
    SkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    QtyPanel: TbsSkinPanel;
    AmountPanel: TbsSkinPanel;
    ConvertButton: TXiButton;
    PasteButton: TXiButton;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    procedure SetDescription(ARow: integer);
    procedure InitStringGridTitle;
    procedure InitStringGridCell;
    procedure InitModelVar;
    function  TestProductCode(Code: string): boolean;
    function  CheckCells(ACol, ARow: integer): boolean;
    procedure CalcAmount;
    procedure MoveToNextCell;
    procedure StringGridSelectCell(Sender: TObject; Col, Row: Longint; var CanSelect: Boolean);
    procedure StringGridClick(Sender: TObject);
    procedure StringGridEnter(Sender: TObject);
    procedure InsertLine;
    procedure DeleteLine;
    procedure StringGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TabControlChange(Sender: TObject);
    procedure OpenQuery(SQLStr: string);
    procedure ReadData;
    function  SavePageData(PageNo: integer): boolean;
    function  SaveData: boolean;
    function  SavePasteDataItem(PageNo: integer): boolean;
    function  SavePasteData: boolean;
    procedure PostDataToModelVar;
    procedure PostDataToStringGrid;
    procedure FormShow(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure ConvertButtonClick(Sender: TObject);
    procedure QtyEditEnter(Sender: TObject);
    procedure QtyEditExit(Sender: TObject);
    procedure QtyEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  SetupMealPackagePro(var Qty: double; OpFlag: boolean): boolean;
    procedure QtyEditClick(Sender: TObject);
  private { Private declarations }
   ModelVar: array [0..19, 0..5, 1..50] of String;
   Instruction, PriceSelect: array [0..19, 1..50] of integer;
   CurrentRow, CurrentCol: integer;
   ReturnFlag, SetupFlag, Changed: boolean;
   CurrentPage: Integer;
   Qty: double;
  public
    { Public declarations }
  end;

var
  PackageSetup: TPackageSetup;

implementation

uses ItemSelect, PriceSelect, MessageBox, NumPad, Instruction;

{$R *.DFM}

procedure TPackageSetup.SetDescription(ARow: integer);
var
 Temp: string;
begin
 with StringGrid do
  begin
   Temp := Copy(Cells[1, ARow], 1, 4);
   if (Temp = '[*] ') or (Temp = '[A] ') or (Temp = '[C] ') or (Temp = '[M] ') or (Temp = '[L] ') then
      Temp := Copy(Cells[1, ARow], 5, Length(Cells[1, ARow]) - 4)
    else
      Temp := Cells[1, ARow];
   case Instruction[Currentpage, ARow] of
    0: Cells[1, ARow] := Temp;
    1: Cells[1, ARow] := '[*] ' + Temp;
    2: Cells[1, ARow] := '[A] ' + Temp;
    3: Cells[1, ARow] := '[C] ' + Temp;
    4: Cells[1, ARow] := '[M] ' + Temp;
    5: Cells[1, ARow] := '[L] ' + Temp;
  end;
 end;
end;

procedure TPackageSetup.InitStringGridTitle;
begin
 with StringGrid do
  begin
    Cells[0, 0] := 'Code';
    Cells[1, 0] := 'Description';
    Cells[2, 0] := 'Qty';
    Cells[3, 0] := 'Price';
    Cells[4, 0] := 'GST(%)';
    Cells[5, 0] := 'Description2';
  end;
end;

procedure TPackageSetup.InitStringGridCell;
Var
 I, J: integer;
begin
 with StringGrid do
  for I := 1 to 50 do
   for J := 0 to 5 do Cells[J, I] := '';
end;

procedure TPackageSetup.InitModelVar;
Var
 I, J, K: integer;
begin
 for I := 0 to 19 do
  begin
   for J := 0 to 5 do
    for K := 1 to 50 do ModelVar[I, J, K] := '';
   for K := 1 to 50 do
    begin
     Instruction[I, K] := 0;
     PriceSelect[I, K] := 0;
    end;
  end;
end;

function TPackageSetup.TestProductCode(Code: string): boolean;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From MenuItem Where ItemCode=' +
           Chr(39) + CheckQuotes(Code) + Chr(39));
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
   if RecordCount = 0 then
      begin
       Result := False;
       MessageBoxForm.MessagePro('Invalid item code!', sErrorMsg);
      end
     else
      Result := True;
  end;
end;

function TPackageSetup.CheckCells(ACol, ARow: integer): boolean;
var
 CellsStr, FieldName: string;
 Temp: boolean;
begin
 Result := True; Temp := False;
 if StringGrid.Cells[ACol, ARow] = '' then
    begin
     Changed := False;
     Exit;
    end;
 CellsStr := StringGrid.Cells[ACol, ARow];
 case ACol of
  0: if Changed then
        begin
         StringGrid.Cells[ACol, ARow] := Uppercase(StringGrid.Cells[ACol, ARow]);
         CellsStr := Uppercase(CellsStr);
         if Not TestProductCode(CellsStr) then
            begin
             Result := False;
             StringGrid.Cells[1, ARow] := '';
             StringGrid.Cells[2, ARow] := '';
             StringGrid.Cells[3, ARow] := '';
             StringGrid.Cells[4, ARow] := '';
            end
          else
           with Query do
            begin
             if FieldByName('Instruction').AsBoolean and (Instruction[Currentpage, ARow] = 0) then
                Instruction[CurrentPage, ARow] := 1;
             if (StringGrid.Cells[2, ARow] = '') and (FieldByName('Price').AsFloat > 0) then
                StringGrid.Cells[2, ARow] := Format('%4.2f', [1.0]);
             if (StringGrid.Cells[3, ARow] = '' ) then
                 begin
                  if Not FieldByName('Multiple').AsBoolean then
                     StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName('Price').AsFloat])
                    else
                     begin
                      PriceSelectForm.ReadPricePro(CellsStr, PriceSelect[CurrentPage, ARow], Temp);
                      if PriceSelect[CurrentPage, ARow] >= 0 then
                         begin
                          FieldName := GeneratePricefieldName(PriceSelect[Currentpage, ARow], False);
                          StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName(FieldName).AsFloat]);
                         end
                        else
                         begin
                          StringGrid.Cells[1, ARow] := '';
                          StringGrid.Cells[2, ARow] := '';
                          StringGrid.Cells[3, ARow] := '';
                          StringGrid.Cells[4, ARow] := '';
                          PriceSelect[CurrentPage, ARow] := 0;
                          StringGrid.Col := 0;
                          Exit;
                         end
                     end;
                 end;
             StringGrid.Cells[1, ARow] := FieldByName('Description1').AsString;
             if FieldByName('Multiple').AsBoolean then
                begin
                 FieldName := GenerateSubDescriptionFieldName(PriceSelect[CurrentPage, ARow]);
                 if FieldByName(FieldName).AsString <> '' then
                    StringGrid.Cells[1, ARow] := StringGrid.Cells[1, ARow] + ' / ' + FieldByName(FieldName).AsString;
                end;
             StringGrid.Cells[4, ARow] := Format('%4.2f',[FieldByName('TaxRate').AsFloat]);
             Changed := False;
             SetDescription(ARow);
            end;
         Query.Close;
        end;
  2: if Not CheckNum(CellsStr, 7, 999.99, -999.99, 'F') then
        Result := False
       else
        StringGrid.Cells[ACol, ARow] := Format('%4.2f', [StrToFloat(CellsStr)]);
  3: if Not CheckNum(CellsStr, 10, 9999999.99, 0, 'F') then
        Result := False
       else
        StringGrid.Cells[ACol, ARow] := Format('%4.2f', [StrToFloat(CellsStr)]);
 end;
end;

procedure TPackageSetup.CalcAmount;
var
 Amount: double;
 I: integer;
begin
 Amount := 0;
 with StringGrid do
  for I := 1 to 50 do
   if (Cells[2, I] <> '') and (Cells[3, I] <> '') then
      Amount := Amount + StrToFloat(Cells[2, I]) * StrToFloat(Cells[3, I]);
 AmountEdit.Caption := Format('%4.2n ', [Amount]);
end;

procedure TPackageSetup.MoveToNextCell;
begin
 with StringGrid do
  begin
   Case Col of
    0: Col := 2;
    2: Col := 3;
    3: begin
        Col := 0;
        if Row < 50 then Row := Row + 1;
       end;
   end;
   CurrentRow := Row; CurrentCol := Col;
  end;
end;

procedure TPackageSetup.StringGridSelectCell(Sender: TObject; Col, Row: Longint; var CanSelect: Boolean);
begin
 CanSelect := (Col In [0, 2, 3])
end;

procedure TPackageSetup.StringGridClick(Sender: TObject);
begin
 if (StringGrid.Col = CurrentCol) and (StringGrid.Row = CurrentRow) then
    Exit;
 if CheckCells(CurrentCol, CurrentRow) then
     begin
      CalcAmount;
      CurrentCol := StringGrid.Col;
      CurrentRow := StringGrid.Row;
     end
    else
     begin
      StringGrid.Col := CurrentCol;
      StringGrid.Row := CurrentRow;
     end;
end;

procedure TPackageSetup.StringGridEnter(Sender: TObject);
begin
 StringGrid.Col := 0;
 CurrentCol := 0;
end;

procedure TPackageSetup.InsertLine;
var
 I, J: Integer;
begin
 if Not CheckCells(CurrentCol, CurrentRow) then
    begin
     StringGrid.SetFocus;
     Exit;
    end;
 if CurrentRow = 0 then CurrentRow := 1;
 for I := 50 Downto CurrentRow + 1 do
  begin
   for J := 0 to 5 do StringGrid.Cells[J, I] := StringGrid.Cells[J, I - 1];
   Instruction[CurrentPage, I] := Instruction[Currentpage, I - 1];
   PriceSelect[CurrentPage, I] := PriceSelect[Currentpage, I - 1];
  end;
 for J := 0 to 5 do StringGrid.Cells[J, CurrentRow] := '';
 Instruction[CurrentPage, CurrentRow] := 0;
 PriceSelect[CurrentPage, CurrentRow] := 0;
 CalcAmount;
end;

procedure TPackageSetup.DeleteLine;
var
 I, J: Integer;
begin
 if (MessageBoxForm.MessagePro('Are you sure you want to delete this line?', sConfirmMsg) = mrNo) then
    Exit;
 for I := CurrentRow to 49 do
  begin
   for J := 0 to 5 do StringGrid.Cells[J, I] := StringGrid.Cells[J, I + 1];
   Instruction[CurrentPage, I] := Instruction[CurrentPage, I + 1];
   PriceSelect[CurrentPage, I] := PriceSelect[CurrentPage, I + 1];
  end;
 for J := 0 to 5 do StringGrid.Cells[J, 50] := '';
 Instruction[CurrentPage, 50] := 0;
 PriceSelect[CurrentPage, 50] := 0;
 CalcAmount;
end;

procedure TPackageSetup.StringGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
 CellsStr: string;
 Temp: integer;
begin
 if Not (Key In [VK_F5, VK_F10, VK_RETURN, VK_LEFT, VK_RIGHT, VK_DELETE, VK_INSERT]) then
    Exit;
 if (Key = VK_F5) and (CurrentCol = 0) then
    begin
     CellsStr := StringGrid.Cells[0, CurrentRow];
     if ItemSelectForm.ItemSelectPro(CellsStr) then
        begin
         if StringGrid.Cells[0, CurrentRow] <> CellsStr then
            StringGrid.Cells[3, CurrentRow] := '';
         StringGrid.Cells[0, CurrentRow] := CellsStr;
         Changed := True;
        end;
     Exit;
    end;
 if Key = VK_F10 then
    begin
     with StringGrid do
      if Cells[1, Row] <> '' then
         begin
          Temp := InstructionForm.InstructionPro;
          if Temp >= 0 then
             begin
              Instruction[CurrentPage, StringGrid.Row] := Temp;
              SetDescription(StringGrid.Row);
             end;
          end;
     Exit;
    end;
 case Key of
   VK_RETURN: MoveToNextCell;
   VK_LEFT:   case CurrentCol of
               3: StringGrid.Col := 2;
               2: StringGrid.Col := 0;
              end;
   VK_RIGHT:  MoveToNextCell;
   VK_DELETE: DeleteLine;
   VK_INSERT: InsertLine;
  end;
 Key := 0;
end;

procedure TPackageSetup.OpenQuery(SQLStr: string);
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

procedure TPackageSetup.ReadData;
var
 I, J: integer;
 SQLStr, FieldName: string;
begin
 InitModelVar;
 for I := 0 to 19 do
  begin
   SQLStr := 'Select MealPackage.ItemCode, Description1, Description2, ' +
             'MealPackage.Qty, MealPackage.Price, TaxRate, Multiple, ' +
             'MealPackage.Condition, PriceSelect, SubDescription, ' +
             'SubDescription1, SubDescription2, SubDescription3 ' +
             'From MealPackage, MenuItem ' +
             'Where MenuItem.ItemCode=MealPackage.ItemCode ' +
             'and MealPackage.IDNo=' + IntToStr(I) +
             ' Order By ID';
   OpenQuery(SQLStr);
   if Query.RecordCount > 0 then
      begin
       Query.First; J := 1;
       while Not Query.EOF do
        begin
         Instruction[I, J] := Query.FieldByName('Condition').AsInteger;
         PriceSelect[I, J] := Query.FieldByName('PriceSelect').AsInteger;
         ModelVar[I, 0, J] := Query.FieldByName('ItemCode').AsString;
         ModelVar[I, 1, J] := Query.FieldByName('Description1').AsString;
         if Query.FieldByName('Multiple').AsBoolean then
            begin
             FieldName := GenerateSubDescriptionFieldName(PriceSelect[I, J]);
             if Query.FieldByName(FieldName).AsString <> '' then
                ModelVar[I, 1, J] := ModelVar[I, 1, J] + ' / ' + Query.FieldByName(FieldName).AsString;
            end;
         ModelVar[I, 2, J] := Format('%4.2f', [Query.FieldByName('Qty').AsFloat]);
         ModelVar[I, 3, J] := Format('%4.2f', [Query.FieldByName('Price').AsFloat]);
         ModelVar[I, 4, J] := Format('%4.2f', [Query.FieldByName('TaxRate').AsFloat]);
         ModelVar[I, 5, J] := Query.FieldByName('Description2').AsString;
         Query.Next; J := J + 1;
        end;
      end;
  end;
 Query.Close;
 CalcAmount;
end;

function TPackageSetup.SavePageData(PageNo: integer): boolean;
var
 I, J: integer;
 SQLStr, QtyStr, PriceStr, ItemCode, PriceSel: string;
begin
 J := 1; I := 1; Result := True;
 while (J <= 50) and Result do
  begin
   if ModelVar[PageNo, 0, J] <> '' then
      begin
       ItemCode := Chr(39) + CheckQuotes(ModelVar[PageNo, 0, J]) + Chr(39);
       if ModelVar[PageNo, 2, J] <> '' then
          QtyStr := ModelVar[PageNo, 2, J]
         else
          QtyStr := '0';
       if ModelVar[PageNo, 3, J] <> '' then
          PriceStr := ModelVar[PageNo, 3, J]
         else
          PriceStr := '0.0';
       PriceSel := IntToStr(PriceSelect[PageNo, J]);
       SQLStr := 'Insert Into MealPackage(ItemCode, Qty, Price, Condition,' +
                 'PriceSelect, IDNo, ID) ' +
                 'Values(' + ItemCode + ',' + QtyStr + ',' + PriceStr + ',' +
                 IntToStr(Instruction[PageNo, J]) + ',' + PriceSel + ',' +
                 IntToStr(PageNo) + ',' + IntToStr(I) + ')';
       Result := DataForm.ExecQueryPro(SQLStr);
       I := I + 1;
      end;
   J := J + 1;
  end;
end;

function TPackageSetup.SaveData: boolean;
var
 I: integer;
begin
 Result := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Result := DataForm.ExecQueryPro('Delete From MealPackage');
  I := 0;
  while (I <= 19) and Result do
   begin
    Result := SavePageData(I);
    I := I + 1;
   end;
 finally
  if Result then
     DataForm.CommitTransaction
    else
     begin
      DataForm.RollBack;
     end;
 end;
end;

procedure TPackageSetup.PostDataToModelVar;
var
 I, J, K: integer;
begin
 K :=  CurrentPage;
 for I := 1 to 50 do
  for J := 0 to 5 do
   ModelVar[K, J, I] := StringGrid.Cells[J, I];
end;

procedure TPackageSetup.PostDataToStringGrid;
var
 I, J, K: integer;
begin
 K :=  CurrentPage;
 for I := 1 to 50 do
  begin
   for J := 0 to 5 do
    StringGrid.Cells[J, I] := ModelVar[K, J, I];
    SetDescription(I);
  end;
 CalcAmount;
 StringGrid.Row := 1; CurrentRow := 1;
 StringGrid.TopRow := 1;
 StringGrid.Col := 0; CurrentCol := 0;
 Changed := False;
end;

procedure TPackageSetup.TabControlChange(Sender: TObject);
begin
 PostDataToModelVar;
 CurrentPage := TabControl.TabIndex;
 PostDataToStringGrid;
end;

procedure TPackageSetup.SaveButtonClick(Sender: TObject);
begin
 PostDataToModelVar;
 ReturnFlag := True;
 if SaveData then Close;
end;

procedure TPackageSetup.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 if (MessageBoxForm.MessagePro('Are you sure you want to cancel?', sConfirmMsg) = mrYes) then
    Close;
end;

function TPackageSetup.SavePasteDataItem(PageNo: integer): boolean;
var
 I, J: integer;
 SQLStr, QtyStr, PriceStr, ItemCode: string;
begin
 J := 1; I := 1; Result := True;
 while (J <= 50) and Result do
  begin
   if ModelVar[PageNo, 0, J] <> '' then
      begin
       ItemCode := Chr(39) + CheckQuotes(ModelVar[PageNo, 0, J]) + Chr(39);
       if ModelVar[PageNo, 2, J] <> '' then
          QtyStr := ModelVar[PageNo, 2, J]
         else
          QtyStr := '0.0';
       if ModelVar[PageNo, 3, J] <> '' then
          PriceStr := ModelVar[PageNo, 3, J]
         else
          PriceStr := '0.0';
       SQLStr := 'Insert Into MealPackage(ItemCode, Qty, Price, Condition, PriceSelect, IDNo, ID) ' +
                 'Values(' + ItemCode + ',' + QtyStr + ',' +
                 PriceStr + ',' + IntToStr(Instruction[PageNo, J]) + ',' +
                 IntToStr(PriceSelect[PageNo, J]) + ',' +
                 IntToStr(J+20) + ',' + IntToStr(I) + ')';
       Result := DataForm.ExecQueryPro(SQLStr);
       I := I + 1;
      end;
   J := J + 1;
  end;
end;

function TPackageSetup.SavePasteData: boolean;
begin
 Result := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Result := DataForm.ExecQueryPro('Delete From MealPackage Where IDNo>=20');
  if Result then
     Result := SavePasteDataItem(CurrentPage);
 finally
  if Result then
     DataForm.CommitTransaction
    else
     begin
      DataForm.RollBack;
     end;
 end
end;

procedure TPackageSetup.PasteButtonClick(Sender: TObject);
begin
 PostDataToModelVar;
 if QtyEdit.Text <> '' then
    Qty := StrToFloat(QtyEdit.Text)
   else
    Qty := 1;
 ReturnFlag := SavePasteData;
 if ReturnFlag then Close;
end;

procedure TPackageSetup.StringGridKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key in ['0'..'9', 'a'..'z', 'A'..'Z']) and (StringGrid.Col = 0)then
    Changed := True;
end;

procedure TPackageSetup.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   if ARow > 0 then
      begin
       Canvas.Font.Name := 'MS Sans Serif';
       Canvas.Font.Style := [];
       case ACol of
         0: begin
             SetTextAlign(Canvas.Handle, TA_CENTER);
             X := (Rect.Left + Rect.Right) div 2;
            end;
         1: begin
             SetTextAlign(Canvas.Handle, TA_LEFT);
             if Instruction[CurrentPage, ARow] > 1 then
                begin
                 Canvas.Font.Color := clRed;
                 X := Rect.Left + 12;
                end
               else
                if Instruction[CurrentPage, ARow] = 1 then
                   begin
                    Canvas.Font.Color := clBlue;
                    X := Rect.Left + 12;
                   end
                  else
                   begin
                    X := Rect.Left + 2;
                    Canvas.Font.Color := clBlack;
                   end
            end
        else
         begin
          SetTextAlign(Canvas.Handle, TA_RIGHT);
          X := Rect.Right - 2;
         end;
       end
      end
     else
      begin
       Canvas.Font.Name := 'Arial';
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    if State = [gdSelected] then Canvas.Font.Color := clWhite;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;


procedure TPackageSetup.ConvertButtonClick(Sender: TObject);
var
 I, J: integer;
 Temp: string;
begin
 for I := 0 to 19 do
  for J := 1 to 50 do
   if ModelVar[I, 5, J] <> '' then
      begin
       Temp := ModelVar[I, 5, J];
       ModelVar[I, 5, J] := ModelVar[I, 1, J];
       ModelVar[I, 1, J] := Temp;
      end;
 for I := 1 to 50 do
  if StringGrid.Cells[5, I] <> '' then
      begin
       Temp := StringGrid.Cells[5, I];
       StringGrid.cells[5, I] := StringGrid.Cells[1, I];
       StringGrid.Cells[1, I] := Temp;
       SetDescription(I);
      end;
end;

procedure TPackageSetup.QtyEditEnter(Sender: TObject);
begin
 if QtyEdit.Text <> '' then
    QtyEdit.Text := FloatToStr(StrToFloat(QtyEdit.Text));
 QtyEdit.SelectAll;
end;

procedure TPackageSetup.QtyEditExit(Sender: TObject);
begin
 if (QtyEdit.Text <> '') and CheckNum(QtyEdit.Text, 9, 999999.99, 0, 'F') then
    QtyEdit.Text := Format('%9.2f', [StrToFloat(QtyEdit.Text)])
   else
    QtyEdit.Text := Format('%9.2f', [1.00]);
end;

procedure TPackageSetup.QtyEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_RETURN then PasteButton.SetFocus
end;

procedure TPackageSetup.QtyEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := QtyEdit.Text;
 if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Qty', 0) then
    QtyEdit.Text := Format('%9.2f', [StrToFloat(NumStr)]);
end;

procedure TPackageSetup.FormShow(Sender: TObject);
var
 I: integer;
begin
 Width := WorkPanel.Width + 28;
 Height := SaveButton.Top + 86;
 InitStringGridTitle;
 ReadData;
 for I := 19 downto 0 do TabControl.TabIndex := I;
 CurrentPage := 0;
 QtyEdit.Text := Format('%9.2f', [1.00]);
 PostDataToStringGrid;
 if SetupFlag then
    begin
     PasteButton.Visible := False;
     QtyPanel.Visible := False;
     SaveButton.Visible := True;
     AmountPanel.Visible := True;
    end
   else
    begin
     PasteButton.Visible := True;
     QtyPanel.Visible := True;
     SaveButton.Visible := False;
     AmountPanel.Visible := False;
    end;
end;

function TPackageSetup.SetupMealPackagePro(var Qty: double; OpFlag: boolean): boolean;
begin
 Application.CreateForm(TPackageSetup, PackageSetup);
 PackageSetup.SetupFlag := OpFlag;
 PackageSetup.ShowModal;
 Result := PackageSetup.ReturnFlag;
 if Result then Qty := PackageSetup.Qty;
 PackageSetup.Free;
end;

end.
