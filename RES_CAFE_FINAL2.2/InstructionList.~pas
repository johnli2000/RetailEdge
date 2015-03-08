unit InstructionList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Grids, StdCtrls, Buttons, Db, DataUnit, UtilUnit,
  ADODB, bsSkinCtrls, XiButton, PanelButton, bsSkinTabs, BusinessSkinForm;

type
  TInstructionListForm = class(TForm)
    StringGrid: TStringGrid;
    Query: TADOQuery;
    //Query1 : TADOQuery;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    TabControl: TbsSkinTabControl;
    ConvertButton: TXiButton;
    UpButton: TXiButton;
    DownButton: TXiButton;
    StringGridPanel: TbsSkinPanel;
    InstructionButton: TXiButton;
    DeleteButton: TXiButton;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    Button1: TPanelButton;
    Button2: TPanelButton;
    Button3: TPanelButton;
    Button4: TPanelButton;
    Button5: TPanelButton;
    Button6: TPanelButton;
    Button7: TPanelButton;
    Button8: TPanelButton;
    Button9: TPanelButton;
    Button10: TPanelButton;
    Button11: TPanelButton;
    Button12: TPanelButton;
    Button13: TPanelButton;
    Button14: TPanelButton;
    Button15: TPanelButton;
    Button16: TPanelButton;
    Button17: TPanelButton;
    Button18: TPanelButton;
    Button19: TPanelButton;
    Button20: TPanelButton;
    Button21: TPanelButton;
    Button22: TPanelButton;
    Button23: TPanelButton;
    Button24: TPanelButton;
    Button25: TPanelButton;
    Button31: TPanelButton;
    Button26: TPanelButton;
    Button32: TPanelButton;
    Button33: TPanelButton;
    Button27: TPanelButton;
    Button28: TPanelButton;
    Button29: TPanelButton;
    Button30: TPanelButton;
    Button34: TPanelButton;
    Button35: TPanelButton;
    Button36: TPanelButton;
    Query1: TADOQuery;
    procedure OpenQuery;
    procedure AssignKeyBoard;
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure InitStringGrid;
    procedure SelectMaximunChargePro;
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure DeleteButtonClick(Sender: TObject);
    function  FindLastRow: integer;
    procedure ButtonClick(Sender: TObject);
    procedure ProcessButtonTouch(Position: integer);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure ConvertButtonClick(Sender: TObject);
    procedure SetDescription(ARow: integer);
    function  InstructionPro(ItemCode: string; Langurage: boolean;
              var InstructionBuff: InstructionBuffType): boolean;
    procedure InstructionButtonClick(Sender: TObject);
    procedure StringGridDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    //procedure CheckHalfPizza;
  private { Private declarations }
    CurrentPage, CurrentPosition, InstructionRowCount: integer;
    ReturnFlag, Langurage, InitLangurage: boolean;
    ItemCode: string;
    Instruction: InstructionBuffType;
  public
    { Public declarations }
  end;

var
  InstructionListForm: TInstructionListForm;

implementation

uses MainMenu, Instruction;

{$R *.DFM}

{procedure TInstructionListForm.CheckHalfPizza;
var
  SQLStr : string;
begin
  SQLStr := 'Select HalfPizza From MenuItem Where ItemCode = ' +
          Chr(39) + ItemCode + Chr(39);
  with Query1 do
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
end; }


procedure TInstructionListForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select Code, Description1, Description2, Qty, Condition, ' +
           'InstructionLink.Price, MaximunCharge, AllowDiscount, TaxRate, ' +
           'ButtonColor, FontSize, FontName, FontColor, FontBold, ' +
           'FontItalic, FontUnderline, FontStrikeout ' +
           'From InstructionLink, MenuItem ' +
           'Where InstructionLink.Code=MenuItem.ItemCode and ' +
           'InstructionLink.ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
           ' and Kind=' + InttoStr(TabControl.TabIndex) +
           ' Order By InstructionLink.ID';
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
 CurrentPage := 1;
 InstructionRowCount := Query.RecordCount;
end;

procedure TInstructionListForm.AssignKeyBoard;
var
 I: integer;
 ButtonName: string;
begin
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 36);
 for I := 1 to 36 do
  begin
   ButtonName := 'Button' + IntToStr(I);
   with TPanelButton(FindComponent(ButtonName)) do
    begin
     case TabControl.TabIndex of
      0: begin Color := $00FFE4CA; Font.Color := clBlack end;
      1: begin Color := $00FFB0D8; Font.Color := clBlack end;
      2: begin Color := $00C6E2FF; Font.Color := clBlack end;
     end;
     if Not Query.EOF then
        begin
         if Langurage or (Query.FieldByName('Description2').AsString = '') then
           Caption := CopyDescription(Query.FieldByName('Description1').AsString)
          else
           Caption := CopyDescription(Query.FieldByName('Description2').AsString);
         Color := Query.FieldByName('ButtonColor').AsInteger;
         Font.Size := Query.FieldByName('FontSize').AsInteger;;
         Font.Name := Query.FieldByName('FontName').AsString;
         Font.Color := Query.FieldByName('FontColor').AsInteger;
         Font.Style := [];
         if Query.FieldByName('FontBold').AsBoolean then
            Font.Style := Font.Style + [fsBold];
         if Query.FieldByName('FontItalic').AsBoolean then
            Font.Style := Font.Style + [fsItalic];
         if Query.FieldByName('FontUnderline').AsBoolean then
            Font.Style := Font.Style + [fsUnderline];
         if Query.FieldByName('FontStrikeout').AsBoolean then
            Font.Style := Font.Style + [fsStrikeout];
         Query.Next;
        end
       else
        Caption := '';
    end;
  end;
end;

procedure TInstructionListForm.UpButtonClick(Sender: TObject);
begin
 if CurrentPage >= 2 then
    begin
     CurrentPage := CurrentPage - 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
 TabControl.SetFocus;
end;

procedure TInstructionListForm.DownButtonClick(Sender: TObject);
begin
 if (CurrentPage * 36) < InstructionRowCount then
    begin
     CurrentPage := CurrentPage + 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
 TabControl.SetFocus;
end;

procedure TInstructionListForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   Cells[0, 0] := 'Code';
   Cells[1, 0] := 'Description';
   Cells[2, 0] := 'Qty';
   Cells[3, 0] := 'Price';
   Cells[4, 0] := 'Condition';
   Cells[5, 0] := 'Description2';
   Cells[6, 0] := 'Discount';
   Cells[7, 0] := 'GST';
   Cells[8, 0] := 'MaximunCharge';
   for I := 1 to 50 do
    begin
     Cells[0, I] := ''; Cells[1, I] := '';
     Cells[2, I] := ''; Cells[3, I] := '';
     Cells[4, I] := ''; Cells[5, I] := '';
     Cells[6, I] := ''; Cells[7, I] := '';
     Cells[8, I] := '';
    end;
   Row := 1; Col := 0;
  end;
end;

procedure TInstructionListForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   X := (Rect.Left + Rect.Right) div 2;
   if ARow > 0 then
      case ACol of
        0, 8: begin
            SetTextAlign(Canvas.Handle, TA_CENTER);
            X := (Rect.Left + Rect.Right) div 2;
           end;
        1: begin
            SetTextAlign(Canvas.Handle, TA_LEFT);
            X := Rect.Left + 2;
           end;
       else
           begin
            SetTextAlign(Canvas.Handle, TA_RIGHT);
            X := Rect.Right - 2;
           end;
      end
     else
      begin
       Canvas.Font.Name := 'Arial';
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TInstructionListForm.DeleteButtonClick(Sender: TObject);
var
 I: Integer;
 CurrentRow: integer;
begin
 CurrentRow := StringGrid.Row;
 with StringGrid do
  begin
   for I := CurrentRow to 49 do
    begin
     Cells[0, I] := Cells[0, I + 1];
     Cells[1, I] := Cells[1, I + 1];
     Cells[2, I] := Cells[2, I + 1];
     Cells[3, I] := Cells[3, I + 1];
     Cells[4, I] := Cells[4, I + 1];
     Cells[5, I] := Cells[5, I + 1];
     Cells[6, I] := Cells[6, I + 1];
     Cells[7, I] := Cells[7, I + 1];
     Cells[8, I] := Cells[8, I + 1];
    end;
   Cells[0, 50] := ''; Cells[1, 50] := '';
   Cells[2, 50] := ''; Cells[3, 50] := '';
   Cells[4, 50] := ''; Cells[5, 50] := '';
   Cells[6, 50] := ''; Cells[7, 50] := '';
   Cells[8, 50] := '';
  end;
end;

function TInstructionListForm.FindLastRow: integer;
var
 I, J: integer;
begin
 J := 1;
 with StringGrid do
  for I := 1 to 50 do
   begin
    if Cells[0, I] <> '' then
       begin
        if J <> I then
           begin
            Cells[0, J] := Cells[0, I]; Cells[1, J] := Cells[1, I];
            Cells[2, J] := Cells[2, I]; Cells[3, J] := Cells[3, I];
            Cells[4, J] := Cells[4, I]; Cells[5, J] := Cells[5, I];
            Cells[6, J] := Cells[6, I]; Cells[7, J] := Cells[7, I];
            Cells[8, J] := Cells[8, I];
           end;
        J := J + 1;
       end;
   end;
 if J <= 50 then
    Result := J
   else
    Result := 50;
end;

procedure TInstructionListForm.ButtonClick(Sender: TObject);
var
 Num: string;
begin
 with Sender As TPanelButton do
  begin
   Num := Copy(Name, 7, 2);
   CurrentPosition := StrToInt(Num);
   if Caption <>'' then ProcessButtonTouch(CurrentPosition);
  end;
end;

procedure TInstructionListForm.ProcessButtonTouch(Position: integer);
var
 Code: string;
 CurrentRow: integer;
begin
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 36 + Position - 1);
 Code := Query.FieldByName('Code').AsString;
 CurrentRow := FindLastRow;
 with StringGrid do
  begin
   Row := CurrentRow;
   Cells[0, CurrentRow] := Query.FieldByName('Code').AsString;
   if Langurage or (Query.FieldByName('Description2').AsString = '') then
      begin
       Cells[1, CurrentRow] := Query.FieldByName('Description1').AsString;
       Cells[5, CurrentRow] := Query.FieldByName('Description2').AsString;
      end
     else
      begin
       Cells[1, CurrentRow] := Query.FieldByName('Description2').AsString;
       Cells[5, CurrentRow] := Query.FieldByName('Description1').AsString;
      end;
   Cells[2, CurrentRow] := Query.FieldByName('Qty').AsString;
   Cells[3, CurrentRow] := Query.FieldByName('Price').AsString;
   Cells[4, CurrentRow] := IntToStr(Query.FieldByName('Condition').AsInteger);
   if Query.FieldByName('AllowDiscount').AsBoolean then
      Cells[6, CurrentRow] := '1'
     else
      Cells[6, CurrentRow] := '0';
   Cells[7, CurrentRow] := Query.FieldByName('TaxRate').AsString;
   if Query.FieldByName('MaximunCharge').AsBoolean then
      Cells[8, CurrentRow] := '*'
     else
      Cells[8, CurrentRow] := '';
   SetDescription(CurrentRow);
  end;
end;

procedure TInstructionListForm.SelectMaximunChargePro;
var
 I, J: integer;
begin
 J := -1;
 for I := 1 to 50 do
  if Instruction.MaximunCharge[I] then
     begin
      if J < 0 then
         J := I
        else
         begin
          if Instruction.Price[I] > Instruction.Price[J] then
             Instruction.Price[J] := Instruction.Price[I];
          Instruction.Price[I] := 0;
         end
     end;
end;

procedure TInstructionListForm.ConfirmButtonClick(Sender: TObject);
var
 I, J: integer;
begin
 J := 1;
 for I := 1 to 50 do
  begin
   Instruction.Code[J] := StringGrid.Cells[0, I];
   if (Langurage = InitLangurage) or (StringGrid.Cells[5, I] = '') then
      Instruction.Description1[J] := StringGrid.Cells[1, I]
     else
      Instruction.Description1[J] := StringGrid.Cells[5, I];
   if (SecondDisplayDescription = 1) and Langurage and (StringGrid.Cells[5, I] <> '') then
      Instruction.Description2[J] := StringGrid.Cells[5, I]
     else
      Instruction.Description2[J] := StringGrid.Cells[1, I];
   if (StringGrid.Cells[2, I] <> '') and (Instruction.Condition[J] <> 3) then
      Instruction.Qty[J] := StrToFloat(StringGrid.Cells[2, I])
     else
      Instruction.Qty[J] := 0;
   if (StringGrid.Cells[3, I] <> '') and (Instruction.Condition[J] <> 3) then
      Instruction.Price[J] := StrToFloat(StringGrid.Cells[3, I])
     else
      Instruction.Price[J] := 0;
   if StringGrid.Cells[4, I] <> '' then
      Instruction.Condition[J] := StrToInt(StringGrid.Cells[4, I])
     else
      Instruction.Condition[J] := 0;
   if StringGrid.Cells[6, I] = '1' then
      Instruction.Discount[J] := True
     else
      Instruction.Discount[J] := False;
   if StringGrid.Cells[7, I] <> '' then
      Instruction.TaxRate[J] := StrToFloat(StringGrid.Cells[7, I])
     else
      Instruction.TaxRate[J] := 0;
   Instruction.MaximunCharge[J] := StringGrid.Cells[8, J] = '*';
   J := J + 1;
  end;
 SelectMaximunChargePro; 
 ReturnFlag := True;
 Close;
end;

procedure TInstructionListForm.TabControlChange(Sender: TObject);
begin
 OpenQuery;
 AssignKeyBoard;
 TabControl.SetFocus;
end;

procedure TInstructionListForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TInstructionListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TInstructionListForm.ConvertButtonClick(Sender: TObject);
var
 I: integer;
 Temp: string;
begin
 Langurage := Not Langurage;
 AssignKeyBoard;
 for I := 1 to 50 do
  if StringGrid.Cells[5, I] <> '' then
     begin
      Temp := StringGrid.Cells[5, I];
      StringGrid.cells[5, I] := StringGrid.Cells[1, I];
      StringGrid.Cells[1, I] := Temp;
     end;
end;

procedure TInstructionListForm.SetDescription(ARow: integer);
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
   if Cells[4, ARow] <> '' then
      case StrToInt(Cells[4, ARow]) of
       0: Cells[1, ARow] := Temp;
       1: Cells[1, ARow] := '[*] ' + Temp;
       2: Cells[1, ARow] := '[+] ' + Temp;
       3: Cells[1, ARow] := '[-] ' + Temp;
       4: Cells[1, ARow] := '[M] ' + Temp;
       5: Cells[1, ARow] := '[L] ' + Temp;
      end;
  end;
end;

procedure TInstructionListForm.InstructionButtonClick(Sender: TObject);
var
 Temp: integer;
begin
 with StringGrid do
  begin
   SetFocus;
   if Cells[0, Row] <> '' then
      begin
       Temp := InstructionForm.InstructionPro;
       if Temp >= 0 then
          begin
           Cells[4, Row] := IntToStr(Temp);
           SetDescription(Row);
          end;
      end;
  end;
end;

procedure TInstructionListForm.StringGridDblClick(Sender: TObject);
begin
 InstructionButtonClick(Sender);
end;

procedure TInstructionListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TInstructionListForm.FormShow(Sender: TObject);
begin
 Width := StringGridPanel.Left + StringGridPanel.Width + 22;
 Height := TabControl.Height + 50;
 TabControl.TabIndex := 0;
 OpenQuery;
 //CheckHalfPizza;
 AssignKeyBoard;
 {if Query1.FieldByName('HalfPizza').AsBoolean then
  begin
    TabControl.Tabs.Strings[0] := 'Medium';
    TabControl.Tabs.Strings[1] := 'Large';
    TabControl.Tabs.Strings[2] := 'Family';
  end;}
 TabControl.SetFocus;
 InitStringGrid;
end;

function TInstructionListForm.InstructionPro(ItemCode: string; Langurage: boolean;
         var InstructionBuff: InstructionBuffType): boolean;
begin
 Application.CreateForm(TInstructionListForm, InstructionListForm);
 InstructionListForm.ItemCode := Itemcode;
 InstructionListForm.Langurage := Langurage;
 InstructionListForm.InitLangurage := Langurage;
 InstructionListForm.ShowModal;
 Result := InstructionListForm.ReturnFlag;
 if Result then InstructionBuff := InstructionListForm.Instruction;
 InstructionListForm.Free;
end;

end.
