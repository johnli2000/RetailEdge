unit BookDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, StdCtrls, ExtCtrls, Buttons, Grids, UtilUnit, Db, DataUnit,
  ADODB, CommDrv, bsSkinCtrls, PanelButton, XiButton;

type
  TBookDetailForm = class(TForm)
    StringGrid: TStringGrid;
    MenuPanel: TbsSkinPanel;
    Category1: TPanelButton;
    Category2: TPanelButton;
    Category3: TPanelButton;
    Category4: TPanelButton;
    Category5: TPanelButton;
    Category6: TPanelButton;
    Category7: TPanelButton;
    Category8: TPanelButton;
    Category9: TPanelButton;
    Category10: TPanelButton;
    Category11: TPanelButton;
    Category12: TPanelButton;
    Category13: TPanelButton;
    Category14: TPanelButton;
    Menu1: TPanelButton;
    Menu2: TPanelButton;
    Menu3: TPanelButton;
    Menu4: TPanelButton;
    Menu5: TPanelButton;
    Menu6: TPanelButton;
    Menu7: TPanelButton;
    Menu8: TPanelButton;
    Menu9: TPanelButton;
    Menu10: TPanelButton;
    Menu11: TPanelButton;
    Menu12: TPanelButton;
    Menu13: TPanelButton;
    Menu14: TPanelButton;
    Menu15: TPanelButton;
    Menu16: TPanelButton;
    Menu17: TPanelButton;
    Menu18: TPanelButton;
    Menu19: TPanelButton;
    Menu20: TPanelButton;
    Menu21: TPanelButton;
    Menu22: TPanelButton;
    Menu25: TPanelButton;
    Menu26: TPanelButton;
    Menu23: TPanelButton;
    Menu24: TPanelButton;
    Menu27: TPanelButton;
    Menu28: TPanelButton;
    Menu29: TPanelButton;
    Menu30: TPanelButton;
    CategoryPanel: TbsSkinPanel;
    Menu31: TPanelButton;
    Query: TADOQuery;
    MenuQuery: TADOQuery;
    CategoryQuery: TADOQuery;
    PageUpButton: TPanelButton;
    PageDownButton: TPanelButton;
    CategoryPageUpButton: TPanelButton;
    CategoryPageDownButton: TPanelButton;
    Category39: TPanelButton;
    Category40: TPanelButton;
    Category41: TPanelButton;
    Category42: TPanelButton;
    Menu39: TPanelButton;
    Menu40: TPanelButton;
    Menu41: TPanelButton;
    Menu42: TPanelButton;
    BackPanel: TbsSkinPanel;
    TitlePanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    BookDateEdit: TbsSkinLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    VIPNoEdit: TbsSkinLabel;
    bsSkinStdLabel5: TbsSkinStdLabel;
    bsSkinStdLabel7: TbsSkinStdLabel;
    ServiceEdit: TbsSkinLabel;
    StringGridPanel: TbsSkinPanel;
    TotalPanel: TbsSkinPanel;
    SummaryPanel: TbsSkinPanel;
    AmountLabel: TbsSkinStdLabel;
    TotalLabel: TbsSkinStdLabel;
    GSTLabel: TbsSkinStdLabel;
    AmountEdit: TbsSkinStdLabel;
    TotalEdit: TbsSkinStdLabel;
    GSTEdit: TbsSkinStdLabel;
    LangurageButton: TXiButton;
    SplitLineButton: TXiButton;
    EditPanel: TbsSkinPanel;
    QtyButton: TXiButton;
    PriceButton: TXiButton;
    VoidItemButton: TXiButton;
    InsertItemButton: TXiButton;
    BalanceButton: TXiButton;
    DepositButton: TXiButton;
    SpellInstructionButton: TXiButton;
    InstructionButton: TXiButton;
    MealpackageButton: TXiButton;
    CancelButton: TXiButton;
    MenuGroupButton: TXiButton;
    bsSkinStdLabel2: TbsSkinStdLabel;
    CustomerNameEdit: TbsSkinLabel;
    MenuSetupButton: TXiButton;
    BookingNoEdit: TbsSkinLabel;
    procedure SetTotalPanelLabelPosition;
    procedure InitMenuPanel;
    procedure InitCategoryPanel;
    procedure InitControlButton;
    procedure OpenCategoryQuery(SQLStr: string);
    procedure OpenMenuQuery(SQLStr: string);
    procedure OpenCategory;
    procedure OpenMenu(Category: string);
    procedure ProcessCategoryButtonTouch(Position: integer);
    procedure ProcessInstruction(Buff: InstructionBuffType);
    procedure ProcessMenuButtonTouch(Position: integer);
    procedure AssignCategoryKeyBoard;
    procedure AssignMenuKeyBoard;
    procedure InitCells(ARow: integer);
    procedure InitStringGrid;
    procedure InitForm;
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CancelButtonClick(Sender: TObject);
    function  OpenQuery(SQLStr: string): boolean;
    procedure FormShow(Sender: TObject);
    procedure MoveToNextCell;
    procedure StringGridClick(Sender: TObject);
    procedure DeleteLine;
    function  FindLastRow: integer;
    procedure CopyMealPackage;
    function  CheckCells(ACol, ARow: integer): boolean;
    procedure CalcAmount;
    function  TestItemCode(ItemCode: string; var PriceFlag: integer): boolean;
    function  OpenHeadQuery(BookingNo: string): boolean;
    procedure ReadHeadData;
    function  OpenItemQuery(BookingNo: string): boolean;
    procedure ReadItemData;
    function  SaveBookDetailTable(BookingNo: string): boolean;
    procedure BalanceButtonClick(Sender: TObject);
    function  SaveData(BookingNo: string): boolean;
    function  SaveBookingDetailPro(BookingNo: string): boolean;
    procedure ServiceEditKeyPress(Sender: TObject; var Key: Char);
    procedure VoidItemButtonClick(Sender: TObject);
    procedure MealPackageButtonClick(Sender: TObject);
    function  GetLastNonInstructionItem: integer;
    procedure QtyButtonClick(Sender: TObject);
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure MenuButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetDescription(ARow: integer);
    procedure InstructionButtonClick(Sender: TObject);
    procedure PriceButtonClick(Sender: TObject);
    procedure CategoryPageUpButtonClick(Sender: TObject);
    procedure CategoryPageDownButtonClick(Sender: TObject);
    procedure CategoryButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ConvertLangurage(Firstrow, EndRow: integer);
    procedure LangurageButtonClick(Sender: TObject);
    procedure InsertLine(CurrentLine: integer);
    procedure SplitLineButtonClick(Sender: TObject);
    procedure DepositButtonClick(Sender: TObject);
    procedure InsertItemButtonClick(Sender: TObject);
    procedure SpellInstructionButtonClick(Sender: TObject);
    procedure MenuSetupPro;
    procedure MenuGroupButtonClick(Sender: TObject);
    function  BookingDetailEditPro(BookingNo: string): boolean;
  private { Private declarations }
  public  { Public declarations }
    CurrentCol, CurrentRow, CategoryCurrentPage, MenuCurrentPage,
    CategoryRowCount, MenuCount, CategoryCount, LastMenuPosition,
    sVIPNo: integer;
    Changed, Langurage, CurrentPriceIncludesGST: boolean;
    sBookingNo, KeyBuff, MenuGroupCode: string;
    Instruction, PriceSelect: array [1..500] of integer;
    OpenPrice, OrderInstruction: array [1..500] of Boolean;
    CurrentGSTRate: double;
    ReturnFlag: boolean;
  end;

var
  BookDetailForm: TBookDetailForm;

implementation

uses MealPackage, NumPad, MainMenu, Instruction, PriceSelect, MessageBox,
     InstructionList, MenuSetup, ShowIngredients, Keyboard, MenuGroupSelect,
     StaffList, Deposit, SubMenu;

{$R *.DFM}

procedure TBookDetailForm.SetTotalPanelLabelPosition;
begin
 if CurrentPriceIncludesGST then
    begin
     TotalLabel.Top := 38;
     TotalEdit.Top := 38;
     GSTLabel.Top := 64;
     GSTEdit.Top := 64;
    end
   else
    begin
     TotalLabel.Top := 64;
     TotalEdit.Top := 64;
     GSTLabel.Top := 38;
     GSTEdit.Top := 38;
    end
end;

procedure TBookDetailForm.InitMenuPanel;
var
 I: integer;
 ButtonName: string;
begin
 for I := 1 to 42 do
  begin
   ButtonName := 'Menu' + IntToStr(I);
   with TPanel(FindComponent(ButtonName)) do
    Visible := I <= MenuCount;
  end;
 MenuPanel.Top := 3;
 MenuPanel.Left := 568;
 MenuPanel.Height := MainMenuLine * 57 + 9;
 PageUpButton.Top := (MainMenuLine - 1) * 57 + 6;
 PageDownButton.Top := PageUpButton.Top;
end;

procedure TBookDetailForm.InitCategoryPanel;
var
 I: integer;
 ButtonName: string;
begin
 for I := 1 to 42 do
  begin
   ButtonName := 'Category' + IntToStr(I);
   with TPanel(FindComponent(ButtonName)) do
    Visible := I <= CategoryCount;
  end;
 CategoryPanel.Top := MenuPanel.Height + 5;
 CategoryPanel.Left := 568;
 CategoryPanel.Height := MainCategoryLine * 57 + 9;
 CategoryPageUpButton.Top := (MainCategoryLine - 1) * 57 + 6;
 CategoryPageDownButton.Top := CategoryPageUpButton.Top;
end;

procedure TBookDetailForm.InitControlButton;
begin
 QtyButton.Caption := 'Qty';
 PriceButton.Caption := 'Price';
 BalanceButton.Caption := 'Save';
 DepositButton.Caption := 'Deposit';
 VoidItemButton.Caption := 'Void' + Chr(13) + Chr(10) + 'Item';
 InsertItemButton.Caption := 'Insert' + Chr(13) + Chr(10) + 'Item';
 SpellInstructionButton.Caption := 'Spell' + Chr(13) + Chr(10) + 'Instruction';
 MealPackageButton.Caption := 'Meal' + Chr(13) + Chr(10) + 'Package';
 InstructionButton.Caption := 'Instruction';
 MenuSetupButton.Caption := 'Menu Setup';
 MenuGroupButton.Caption := 'Menu' + Chr(13) + Chr(10) + 'Group';
 LangurageButton.Caption := 'Convert';
 SplitLineButton.Caption := 'Split' + Chr(13) + Chr(10) + 'Line';
 CancelButton.Caption := 'Cancel';
end;

procedure TBookDetailForm.OpenCategoryQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with CategoryQuery do
  begin
   Active := False;
   Connection := Dataform.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
   CategoryRowCount := RecordCount;
   CategoryCurrentPage := 1;
  end;
end;

procedure TBookDetailForm.OpenMenuQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with MenuQuery do
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
   MenuCurrentPage := 1;
   if RecordCount > 0 then
      begin
       Last;
       LastMenuPosition := FieldByName('MainPosition').AsInteger;
      end
     else
      LastMenuPosition := 0;
  end;
end;

procedure TBookDetailForm.OpenCategory;
var
 SQLStr: string;
begin
 SQLStr := 'Select Code, Category, ButtonColor, ' +
           'FontName, FontColor, FontSize, FontBold, FontItalic, ' +
           'FontUnderline, FontStrikeout, Category1 ' +
           'From Category ' +
           'Where ShowOnMainMenu <> 0 and MenuGroupCode=' + Chr(39) + CheckQuotes(MenuGroupCode) + Chr(39) +
           ' Order By Code';
 OpenCategoryQuery(SQLStr);
end;

procedure TBookDetailForm.OpenMenu(Category: string);
var
 SQLStr: string;
begin
 SQLStr := 'Select MenuItem.ItemCode, Description1, Description2, ButtonColor, FontName, ' +
           'FontColor, FontSize, FontBold, FontItalic, FontUnderline, FontStrikeout, ' +
           'ButtonColor1, FontName1, FontColor1, FontSize1, FontBold1, FontItalic1, ' +
           'FontUnderline1, FontStrikeout1, SubCategory, MainPosition ' +
           'From MenuItem Left Join ' +
           '(Select ItemCode, SubCategory From SubMenuLinkHead) As SubMenuTable ' +
           'On MenuItem.ItemCode=SubMenuTable.ItemCode ' +
           'Where (Active <> 0) and (OnlyShowOnSubMenu = 0) and ' +
           'Category=' + Chr(39) + CheckQuotes(Category) + Chr(39) +
           ' Order By MainPosition';
 OpenMenuQuery(SQLStr);
end;

procedure TBookDetailForm.AssignMenuKeyBoard;
var
 I, MenuPosition: integer;
 ButtonName: string;
begin
 for I := 1 to MenuCount do
  begin
   ButtonName := 'Menu' + IntToStr(I);
   MenuPosition := (MenuCurrentPage - 1) * MenuCount + I;
   MenuQuery.Locate('MainPosition', IntToStr(MenuPosition), [loPartialKey]);
   with TPanelButton(FindComponent(ButtonName)) do
    if MenuQuery.FieldByName('MainPosition').AsInteger = MenuPosition then
       begin
        if Langurage or (MenuQuery.FieldByName('Description2').AsString = '') then
           Caption := CopyDescription(MenuQuery.FieldByName('Description1').AsString)
          else
           Caption := CopyDescription(MenuQuery.FieldByName('Description2').AsString);
        Color := MenuQuery.FieldByName('ButtonColor').AsInteger;
        Font.Size := MenuQuery.FieldByName('FontSize').AsInteger;;
        Font.Name := MenuQuery.FieldByName('FontName').AsString;
        Font.Color := MenuQuery.FieldByName('FontColor').AsInteger;
        Font.Style := [];
        if MenuQuery.FieldByName('FontBold').AsBoolean then
           Font.Style := Font.Style + [fsBold];
        if MenuQuery.FieldByName('FontItalic').AsBoolean then
           Font.Style := Font.Style + [fsItalic];
        if MenuQuery.FieldByName('FontUnderline').AsBoolean then
           Font.Style := Font.Style + [fsUnderline];
        if MenuQuery.FieldByName('FontStrikeout').AsBoolean then
           Font.Style := Font.Style + [fsStrikeout];
       end
      else
       begin
        Caption := '';
        Color := $00D9D9D9;
       end;
  end;
end;

procedure TBookDetailForm.AssignCategoryKeyBoard;
var
 I: integer;
 ButtonName: string;
begin
 CategoryQuery.First;
 CategoryQuery.MoveBy((CategoryCurrentPage - 1) * CategoryCount);
 for I := 1 to CategoryCount do
  begin
   ButtonName := 'Category' + IntToStr(I);
   with TPanelButton(FindComponent(ButtonName)) do
    if Not CategoryQuery.EOF then
       begin
        if Langurage or (CategoryQuery.FieldByName('Category1').AsString = '') then
           Caption := CopyDescription(CategoryQuery.FieldByName('Category').AsString)
          else
           Caption := CopyDescription(CategoryQuery.FieldByName('Category1').AsString);
        Color := CategoryQuery.FieldByName('ButtonColor').AsInteger;
        Font.Size := CategoryQuery.FieldByName('FontSize').AsInteger;;
        Font.Name := CategoryQuery.FieldByName('FontName').AsString;
        Font.Color := CategoryQuery.FieldByName('FontColor').AsInteger;
        Font.Style := [];
        if CategoryQuery.FieldByName('FontBold').AsBoolean then
           Font.Style := Font.Style + [fsBold];
        if CategoryQuery.FieldByName('FontItalic').AsBoolean then
           Font.Style := Font.Style + [fsItalic];
        if CategoryQuery.FieldByName('FontUnderline').AsBoolean then
           Font.Style := Font.Style + [fsUnderline];
        if CategoryQuery.FieldByName('FontStrikeout').AsBoolean then
           Font.Style := Font.Style + [fsStrikeout];
        CategoryQuery.Next;
       end
      else
       begin
        Caption := '';
        Color := $00D9D9D9;
        Visible := True;
       end;
  end;
end;

procedure TBookDetailForm.ProcessCategoryButtonTouch(Position: integer);
var
 Category: string;
begin
 CategoryQuery.First;
 CategoryQuery.MoveBy((CategoryCurrentPage - 1) * CategoryCount + Position - 1);
 Category := CategoryQuery.FieldByName('Category').AsString;
 OpenMenu(Category);
 AssignMenuKeyBoard;
 if TitlePanel.Enabled then StringGrid.SetFocus;
end;

procedure TBookDetailForm.ProcessInstruction(Buff: InstructionBuffType);
var
 I, K, FirstRow, EndRow, CurRow: integer;
begin
 CurRow := CurrentRow;
 I := CurRow + 1;
 FirstRow := I;
 for K := 1 to 50 do
  if (Buff.Code[K] <> '') and (I <= 500) then
     begin
      InsertLine(I);
      StringGrid.Cells[1, I] := Buff.Description1[K];
      StringGrid.Cells[2, I] := Format('%4.2f', [Buff.Qty[K]]);
      StringGrid.Cells[3, I] := Format('%4.2f', [Buff.Price[K]]);
      StringGrid.Cells[6, I] := Buff.Code[K];
      Instruction[I] := Buff.Condition[K];
      StringGrid.Cells[5, I] := Format('%4.2f', [Buff.TaxRate[K]]);
      SetDescription(I);
      I := I + 1;
     end;
 EndRow := I;
 ConvertLangurage(FirstRow, EndRow);
end;

procedure TBookDetailForm.ProcessMenuButtonTouch(Position: integer);
var
 ItemCode, MainItemDescription1, MainItemDescription2: string;
 Buff: InstructionBuffType;
 MenuPosition: integer;
 SubMenuForm: TSubMenuForm;
 DirectLinkSubMenu: boolean;
 NumberOfChoice: Integer;
begin
 MenuPosition := (MenuCurrentPage - 1) * MenuCount + Position;
 MenuQuery.Locate('MainPosition', IntToStr(MenuPosition), [loPartialKey]);
 ItemCode := MenuQuery.FieldByName('ItemCode').AsString;
 if Not MenuQuery.FieldByName('SubCategory').AsBoolean then
    begin
     if StringGrid.Cells[1, CurrentRow] <> '' then CurrentRow := FindLastRow;
     if (CurrentRow <= 500) and (StringGrid.Cells[6, CurrentRow] = '') then
        begin
         StringGrid.Row := CurrentRow;
         CurrentCol := 1;
         StringGrid.Col := 1;
         StringGrid.Cells[6, CurrentRow] := ItemCode;
         if DataForm.CheckInstructionLink(ItemCode) and
            InstructionListForm.InstructionPro(ItemCode, Langurage, Buff) then
            ProcessInstruction(Buff);
         if StringGrid.Enabled then StringGrid.SetFocus;
         Changed := True;
         if CheckCells(CurrentCol, CurrentRow) then
            MoveToNextCell;
        end;
    end;
 if DataForm.CheckSubMenuLink(ItemCode, MainItemDescription1, MainItemDescription2, NumberOfChoice, DirectLinkSubMenu) then
    begin
     Application.CreateForm(TSubMenuForm, SubMenuForm);
     SubMenuForm.MainItemCode := ItemCode;
     SubMenuForm.MainItemDescription1 := MainItemDescription1;
     SubMenuForm.MainItemDescription2 := MainItemDescription2;
     SubMenuForm.Langurage := Langurage;
     SubMenuForm.NumberOfChoice := NumberOfChoice;
     SubMenuForm.OwnerNumber := sBOOKDETAIL;
     if DirectLinkSubMenu then
        SubMenuForm.ProcessDirectLinkSubMenu
       else
        SubMenuForm.ShowModal;
     SubMenuForm.Free;
    end;
end;

procedure TBookDetailForm.InitCells(ARow: integer);
begin
 with StringGrid do
  begin
   Cells[1, ARow] := '';
   Cells[2, ARow] := '';
   Cells[3, ARow] := '';
   Cells[4, ARow] := '';
   Cells[5, ARow] := '';
   Cells[6, ARow] := '';
  end;
 OpenPrice[ARow] := True;
 Instruction[ARow] := 0;
 PriceSelect[ARow] := 0;
end;

procedure TBookDetailForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   Cells[0, 0] := 'No.';
   Cells[1, 0] := 'Description';
   Cells[2, 0] := 'Qty';
   Cells[3, 0] := 'Price';
   Cells[4, 0] := 'Amount';
   Cells[5, 0] := 'GST%';
   Cells[6, 0] := 'Code';
   for I := 1 to 500 do
    begin
     Cells[0, I] := IntToStr(I);
     InitCells(I);
    end;
   Row := 1; Col := 1; TopRow := 1; LeftCol := 1;
   CurrentRow := 1; CurrentCol := 1;
  end;
end;

procedure TBookDetailForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   if (ARow > 0) and (ACol > 0) then
      begin
       Canvas.Font.Size := 10;
       Canvas.Font.Style := [];
       case ACol of
         6: begin
             SetTextAlign(Canvas.Handle, TA_CENTER);
             X := (Rect.Left + Rect.Right) div 2;
            end;
         1: begin
             SetTextAlign(Canvas.Handle, TA_LEFT);
             if Instruction[ARow] >= 1 then
                X := Rect.Left + 12
               else
                X := Rect.Left + 2;
             if OrderInstruction[ARow] then
                Canvas.Font.Color := clRed
               else
                if Instruction[ARow] >= 1 then
                   Canvas.Font.Color := clBlue
                  else
                   Canvas.Font.Color := clBlack;
            end;
        else
          begin
           SetTextAlign(Canvas.Handle, TA_RIGHT);
           X := Rect.Right - 2;
          end;
       end;
      end
     else
      begin
       Canvas.Font.Size := 8;
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
  if (State = [gdSelected]) then Canvas.Font.Color := clWhite;
  Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TBookDetailForm.InitForm;
begin
 BookDateEdit.Caption := '';
 BookingNoEdit.Caption := '';
 ServiceEdit.Caption := '';
 VIPNoEdit.Caption := '';
 CategoryPanel.Visible := True;
 MenuPanel.Visible := True;
 CurrentPriceIncludesGST := PriceIncludesGST;
 CurrentGSTRate := DefaultGSTRate;
 InitStringGrid;
end;

procedure TBookDetailForm.FormKeyPress(Sender: TObject; var Key: Char);
var
 CurRow: integer;
begin
 if Not StringGrid.Enabled then
    Key := Chr(0)
   else
    if Key In ['0'..'9', 'a'..'z', 'A'..'Z'] then
       KeyBuff := KeyBuff + Key
      else
       if Key = Chr(13) then
          begin
           if KeyBuff <> '' then
              with StringGrid do
               begin
                CurRow := FindLastRow;
                if ((Copy(KeyBuff, 1, 2) = '02') and (Length(KeyBuff) = 13)) or
                   ((Copy(KeyBuff, 1, 1) = '2') and (Length(KeyBuff) = 12)) then
                   begin
                    if Length(KeyBuff) = 13 then
                       begin
                        if ScaleBarcode = 0 then
                           begin
                            Cells[6, CurRow] := Copy(KeyBuff, 3, 5);
                            Cells[2, CurRow] := Format('%4.2f', [StrToFloat(Copy(KeyBuff, 8, 5)) / 1000]);
                           end
                          else
                           begin
                            Cells[6, CurRow] := Copy(KeyBuff, 3, 5);
                            Cells[2, CurRow] := '1.00';
                            Cells[3, CurRow] := Format('%4.2f', [StrToFloat(Copy(KeyBuff, 9, 4)) / 100]);
                           end
                       end
                      else
                       begin
                        if ScaleBarcode = 0 then
                           begin
                            Cells[6, CurRow] := Copy(KeyBuff, 2, 5);
                            Cells[2, CurRow] := FloatToStr(StrToFloat(Copy(KeyBuff, 7, 5)) / 1000);
                           end
                          else
                           begin
                            Cells[6, CurRow] := Copy(KeyBuff, 2, 5);
                            Cells[2, CurRow] := '1.00';
                            Cells[3, CurRow] := Format('%4.2f', [StrToFloat(Copy(KeyBuff, 8, 4)) / 100]);
                           end
                       end
                   end
                  else
                   begin
                    Cells[6, CurRow] := KeyBuff;
                    Cells[2, CurRow] := '';
                   end;
                KeyBuff := '';
                Changed := True;
                if CheckCells(1, CurRow) then
                   begin
                    Row := FindLastRow;
                    CurrentRow := Row;
                    LeftCol := 1;
                   end
                  else
                   Cells[7, CurRow] := '';
               end;
          end
           else Key := Chr(0);
end;

procedure TBookDetailForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TBookDetailForm.ServiceEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then StringGrid.SetFocus;
end;

function TBookDetailForm.OpenQuery(SQLStr: string): boolean;
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
   if RecordCount = 0 then
      Result := False
     else
      Result := True;
  end;
end;

procedure TBookDetailForm.MoveToNextCell;
begin
 with StringGrid do
  begin
   Col := 1;
   Row := FindLastRow;
   CurrentRow := Row;
   CurrentCol := Col;
  end;
end;

procedure TBookDetailForm.DeleteLine;
var
 I, J: Integer;
begin
 for I := CurrentRow to 499 do
  begin
   for J := 1 to 6 do
    StringGrid.Cells[J, I] := StringGrid.Cells[J, I + 1];
   OpenPrice[I] := OpenPrice[I + 1];
   Instruction[I] := Instruction[I + 1];
   PriceSelect[I] := PriceSelect[I + 1];
  end;
 InitCells(500);
end;

procedure TBookDetailForm.StringGridClick(Sender: TObject);
begin
 if (StringGrid.Row = CurrentRow) and (StringGrid.Col = CurrentCol) then
    Exit;
 if CheckCells(CurrentCol, CurrentRow) then
    begin
     CurrentCol := StringGrid.Col;
     CurrentRow := StringGrid.Row;
    end
   else
    begin
     StringGrid.Col := CurrentCol;
     StringGrid.Row := CurrentRow;
    end;
 CalcAmount;
end;

function TBookDetailForm.FindLastRow: integer;
var
 I, J, K: integer;
begin
 J := 1;
 for I := 1 to 500 do
  begin
   if (StringGrid.Cells[1, I] <> '') then
      begin
       if (J <> I) then
          begin
           for K := 1 to 6 do StringGrid.Cells[K, J] := StringGrid.Cells[K, I];
           OpenPrice[J] := OpenPrice[I];
           Instruction[J] := Instruction[I];
           OrderInstruction[J] := OrderInstruction[I];
           PriceSelect[J] := PriceSelect[I];
           InitCells(I);
          end;
       J := J + 1;
      end;
  end;
 if J <= 500 then
    Result := J
   else
    Result := 500;
end;

procedure TBookDetailForm.CopyMealPackage;
var
 I: integer;
 SQLStr, FieldName: string;
 Qty: double;
begin
 if Not PackageSetup.SetupMealPackagePro(Qty, False) then Exit;
 SQLStr := 'Select MealPackage.ItemCode, Description1, Description2, ' +
           'MealPackage.Qty, MealPackage.Price, TaxRate, ' +
           'MealPackage.Condition, Multiple, PriceSelect, ' +
           'SubDescription, SubDescription1, SubDescription2, ' +
           'SubDescription3, OpenPrice ' +
           'From MealPackage, MenuItem ' +
           'Where MenuItem.ItemCode=MealPackage.ItemCode and ' +
           'MealPackage.IDNo>=20 Order By ID';
 Screen.Cursor := crHourGlass;
 if OpenQuery(SQLStr) then
    with Query do
     begin
      First; I := FindLastRow;
      while Not EOF and (I <= 500) do
        begin
         Instruction[I] := FieldByName('Condition').AsInteger;
         OrderInstruction[I] := False;
         OpenPrice[I] := FieldByName('OpenPrice').AsBoolean;
         PriceSelect[I] := FieldByName('PriceSelect').AsInteger;
         StringGrid.Cells[6, I] := FieldByName('ItemCode').AsString;
         if Langurage or (FieldByName('Description2').AsString = '') then
            StringGrid.Cells[1, I] := FieldByName('Description1').AsString
           else
            StringGrid.Cells[1, I] := FieldByName('Description2').AsString;
         if FieldByName('Multiple').AsBoolean then
            begin
             FieldName := GenerateSubDescriptionFieldName(PriceSelect[I]);
             if FieldByName(FieldName).AsString <> '' then
                StringGrid.Cells[1, I] := StringGrid.Cells[1, I] + ' / ' +
                                          FieldByName(FieldName).AsString;
            end;
         if ABS(FieldByName('Qty').AsFloat) >= 0.01 then
            StringGrid.Cells[2, I] := Format('%4.2f', [Qty * FieldByName('Qty').AsFloat]);
         if ABS(FieldByName('Price').AsFloat) >= 0.01 then
            StringGrid.Cells[3, I] := Format('%4.2f', [FieldByName('Price').AsFloat]);
         StringGrid.Cells[5, I] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);
         StringGrid.Cells[7, I] := '';
         SetDescription(I);
         Next; I := I + 1;
        end;
      Close;
     end;
 CalcAmount;
end;

function TBookDetailForm.CheckCells(ACol, ARow: integer): boolean;
var
 CellsStr, FieldName, NumStr: string;
 Temp, PriceFlag: integer;
 HappyHourPrice: boolean;
begin
 Result := True;
 if Not Changed then Exit;
 Changed := False;
 HappyHourPrice := False;
 if ACol = 1 then
    CellsStr := StringGrid.Cells[6, ARow]
   else
    CellsStr := StringGrid.Cells[ACol, ARow];
 if (CellsStr = '') or (StringGrid.Cells[6, ARow] = '----') then
    Exit;
 case ACol of
  1: begin
      if Not TestItemCode(CellsStr, PriceFlag) then
         begin
          Result := False;
          InitCells(ARow);
         end
        else
         with Query do
          begin
           StringGrid.Cells[6, ARow] := FieldByName('ItemCode').AsString;
           OpenPrice[ARow] := FieldByName('OpenPrice').AsBoolean;
           OrderInstruction[ARow] := False;
           if Not FieldByName('Instruction').AsBoolean then
              begin
               if StringGrid.Cells[2, ARow] = '' then
                  StringGrid.Cells[2, ARow] := Format('%4.2f', [FieldByName('DefaultQty').AsFloat]);
               if StringGrid.Cells[3, ARow] = '' then
                  begin
                   if Not FieldByName('Multiple').AsBoolean then
                      StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName('Price').AsFloat])
                     else
                      begin
                       if PriceFlag = 0 then
                          PriceSelectForm.ReadPricePro(CellsStr, PriceSelect[ARow], HappyHourPrice)
                         else
                          PriceSelect[ARow] := PriceFlag - 1;
                       if PriceSelect[ARow] >= 0 then
                          begin
                           FieldName := GeneratePriceFieldName(PriceSelect[ARow], False);
                           StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName(FieldName).AsFloat]);
                          end
                        else
                         begin
                          repeat
                           DeleteLine
                          until Instruction[ARow] = 0;
                          PriceSelect[ARow] := 0;
                          Exit;
                         end;
                      end;
                  end;
              end
             else
              if Instruction[ARow] = 0 then
                 begin
                  if AutoInstructionSelection then
                     Temp := InstructionForm.InstructionPro
                    else
                     Temp := 1;
                  if Temp >= 0 then Instruction[ARow] := Temp
                    else
                     begin
                      InitCells(ARow);
                      StringGrid.Col := 1; StringGrid.Row := ARow;
                      Exit;
                     end;
                  if (Temp = 2) or (Temp = 0) or Not AutoInstructionSelection then
                     begin
                      if ABS(FieldByName('DefaultQty').AsFloat) >= 0.01 then
                         StringGrid.Cells[2, ARow] := Format('%4.2f', [FieldByName('DefaultQty').AsFloat])
                        else
                         StringGrid.Cells[2, ARow] := '';
                      if Not FieldByName('Multiple').AsBoolean then
                         StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName('Price').AsFloat])
                        else
                         begin
                          if PriceFlag = 0 then
                             PriceSelectForm.ReadPricePro(CellsStr, PriceSelect[ARow], HappyHourPrice)
                            else
                             PriceSelect[ARow] := PriceFlag - 1;
                          if PriceSelect[ARow] >= 0 then
                             begin
                              FieldName := GeneratePriceFieldName(PriceSelect[ARow], False);
                              StringGrid.Cells[3, ARow] := Format('%4.2f', [FieldByName(FieldName).AsFloat]);
                             end
                           else
                            begin
                             repeat
                              DeleteLine
                             until Instruction[ARow] = 0;
                             PriceSelect[ARow] := 0;
                             Exit;
                            end;
                         end;
                     end
                    else
                     begin
                      StringGrid.Cells[2, ARow] := '';
                      StringGrid.Cells[3, ARow] := '';
                     end;
                 end;
           if Langurage or (FieldByName('Description2').AsString = '') then
              StringGrid.Cells[1, ARow] := FieldByName('Description1').AsString
             else
              StringGrid.Cells[1, ARow] := FieldByName('Description2').AsString;
           if FieldByName('Multiple').AsBoolean then
              begin
               FieldName := GenerateSubDescriptionFieldName(PriceSelect[ARow]);
               if FieldByName(FieldName).AsString <> '' then
                  StringGrid.Cells[1, ARow] := StringGrid.Cells[1, ARow] +
                              ' / ' + FieldByName(FieldName).AsString;
              end;
           StringGrid.Cells[5, ARow] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);
           SetDescription(ARow);
           if AutoPriceWindow and OpenPrice[ARow] and (Instruction[ARow] = 0) and
              ((StringGrid.Cells[3, ARow] = '') or (StrToFloat(StringGrid.Cells[3, ARow]) = 0)) then
              begin
               NumStr := '';
               if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Price', 0) then
                  StringGrid.Cells[3, ARow] := Format('%4.2f', [StrToFloat(NumStr)]);
              end;
          end;
      Query.Close;
     end;
  2: if Not CheckNum(CellsStr, 7, 999.99, -999.99, 'F') then
        begin
         StringGrid.Cells[ACol, ARow] := '';
         Result := False
        end
       else
        StringGrid.Cells[ACol, ARow] := Format('%4.2f', [StrToFloat(CellsStr)]);
  3: if Not CheckNum(CellsStr, 10, 9999999.99, 0, 'F') then
        begin
         StringGrid.Cells[ACol, ARow] := '';
         Result := False
        end
       else
        StringGrid.Cells[ACol, ARow] := Format('%4.2f', [Abs(StrToFloat(CellsStr))]);
 end;
end;

procedure TBookDetailForm.CalcAmount;
var
 I: integer;
 Qty, Price, TaxRate, Amount, GST,
 TotalAmount, TotalGST, TotalInvoice: double;
begin
 if CurrentPriceIncludesGST then
    begin
     TotalLabel.Top := 38;
     TotalEdit.Top := 38;
     GSTLabel.Top := 64;
     GSTEdit.Top := 64;
    end
   else
    begin
     TotalLabel.Top := 64;
     TotalEdit.Top := 64;
     GSTLabel.Top := 38;
     GSTEdit.Top := 38;
    end;
 TotalAmount := 0; TotalGST := 0;
 with StringGrid do
  for I := 1 to 500 do
   if (Cells[6, I] <> '----') and Not OrderInstruction[I] then
      begin
       if Cells[2, I] <> '' then Qty := StrToFloat(Cells[2, I]) else Qty := 0;
       if Cells[3, I] <> '' then Price := StrToFloat(Cells[3, I]) else Price := 0;
       if ABS(Price * Qty) >= 0.01 then
          begin
           Amount := Price * Qty;
           Cells[4, I] := Format('%4.2f', [Amount]);
          end
         else
          begin
           Amount := 0;
           Cells[4, I] := '';
          end;
       if Cells[5, I] <> '' then
          TaxRate:= StrToFloat(Cells[5, I])
         else
          TaxRate := 0;
       if CurrentPriceIncludesGST then
          GST := Amount * (1 - 1 / (1 + TaxRate / 100))
         else
          GST := Amount * TaxRate / 100;
       TotalAmount := TotalAmount + Amount;
       TotalGST := TotalGST + GST;
      end;
 if (TotalAmount >= 0) and (TotalGST <= 0) then TotalGST := 0;
 AmountEdit.Caption := Format('%4.2f ', [TotalAmount]);
 GSTEdit.Caption := Format('%4.2f ', [TotalGST]);
 if CurrentPriceIncludesGST then
    TotalInvoice := TotalAmount
   else
    TotalInvoice := TotalAmount + TotalGST;
 TotalEdit.Caption := Format('%4.2f ', [TotalInvoice]);
end;

function TBookDetailForm.TestItemCode(ItemCode: string; var PriceFlag: integer): boolean;
var
 SQLStr: string;
begin
 PriceFlag := -1;
 SQLStr := 'Select * From MenuItem Where ItemCode=' +
           Chr(39) + CheckQuotes(UpperCase(ItemCode)) + Chr(39);
 Result := OpenQuery(SQLStr);
 if Not Result then
    begin
     SQLStr := 'Select * From MenuItem Where BarCode=' +
               Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
               ' Or BarCode1=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
               ' Or BarCode2=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
               ' Or BarCode3=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
     Result := OpenQuery(SQLStr);
    end;
 if Not Result then
    MessageBoxForm.MessagePro('Invalid item code!', sErrorMsg)
   else
    with Query do
     begin
      if Uppercase(ItemCode) = FieldByName('ItemCode').AsString then PriceFlag := 0;
      if ItemCode = FieldByName('BarCode').AsString then PriceFlag := 1;
      if ItemCode = FieldByName('BarCode1').AsString then PriceFlag := 2;
      if ItemCode = FieldByName('BarCode2').AsString then PriceFlag := 3;
      if ItemCode = FieldByName('BarCode3').AsString then PriceFlag := 4;
     end;
end;

function TBookDetailForm.SaveBookDetailTable(BookingNo: string): boolean;
var
 I, IDNo: integer;
 SQLStr, ItemCode, Qty, Price, TaxRate, PriceSel, SpecialOrderTemp,
 InstructionTemp: string;
 OrderQty: double;
begin
 I := 1; IDNo := 1; Result := True;
 while (I <= 500) and Result do
  begin
   ItemCode := StringGrid.Cells[6, I];
   if ItemCode <> '' then
      begin
       if ItemCode <> '----' then
          begin
           if Stringgrid.Cells[2, I] <> '' then
              OrderQty := StrToFloat(StringGrid.Cells[2, I])
             else
              OrderQty := 0;
           Qty := FloatToStr(OrderQty);
           if Stringgrid.Cells[3, I] <> '' then
              Price := StringGrid.Cells[3, I]
             else
              Price := '0';
           if StringGrid.Cells[5, I] <> '' then
              TaxRate := StringGrid.cells[5, I]
             else
              TaxRate := '0';
           PriceSel := IntToStr(PriceSelect[I]);
          end
         else
          begin
           Qty := '0'; Price := '0';
           TaxRate := '0'; PriceSel := '0';
          end;
       InstructionTemp := IntToStr(Instruction[I]);
       if OrderInstruction[I + 1] and (StringGrid.Cells[1, I + 1] <> '') then
          begin
           I := I + 1;
           SpecialOrderTemp := Chr(39) + CheckQuotes(StringGrid.Cells[1, I]) + Chr(39)
          end
         else
          SpecialOrderTemp := 'Null';
       SQLStr := 'Insert Into BookDetail(BookingNo, ItemCode, Qty, Price, ' +
                 'TaxRate, Condition, PriceSelect, SpecialOrder, IDNo) ' +
                 'Values(' + Chr(39) + CheckQuotes(BookingNo) + Chr(39) + ',' +
                 Chr(39) + CheckQuotes(ItemCode) + Chr(39) + ',' +
                 Qty + ',' + Price + ',' + TaxRate + ',' + InstructionTemp + ',' +
                 PriceSel + ',' + SpecialOrderTemp + ',' + IntToStr(IDNo) + ')';
       Result := DataForm.ExecQueryPro(SQLStr);
       Inc(IDNo);
      end;
   Inc(I);
 end;
end;

function TBookDetailForm.SaveData(BookingNo: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From BookDetail Where BookingNo=' + Chr(39) + CheckQuotes(BookingNo) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then Result := SaveBookDetailTable(BookingNo);
end;

function TBookDetailForm.SaveBookingDetailPro(BookingNo: string): boolean;
begin
 BackPanel.SetFocus;
 Result := False;
 if DataForm.BeginTransaction then
    try
     Result := SaveData(BookingNo);
    finally
     if Result then
        DataForm.CommitTransaction
       else
        DataForm.RollBack;
    end;
end;

procedure TBookDetailForm.BalanceButtonClick(Sender: TObject);
begin
 if SaveBookingDetailPro(sBookingNo) then
    begin
     ReturnFlag := True;
     Close;
    end;
end;

procedure TBookDetailForm.InsertItemButtonClick(Sender: TObject);
begin
 StringGrid.SetFocus;
 InsertLine(CurrentRow);
 StringGrid.Row := CurrentRow;
 CurrentCol := 1; StringGrid.Col := 1;
end;

procedure TBookDetailForm.VoidItemButtonClick(Sender: TObject);
begin
 StringGrid.SetFocus;
 if (Instruction[CurrentRow] <> 0) or (StringGrid.Cells[6, CurrentRow] = '----') then
     DeleteLine
    else
     repeat
      DeleteLine
     until (Instruction[CurrentRow] = 0) and Not OrderInstruction[CurrentRow];
 CalcAmount;
end;

procedure TBookDetailForm.MealPackageButtonClick(Sender: TObject);
begin
 CopyMealPackage;
 StringGrid.SetFocus;
end;

function TBookDetailForm.GetLastNonInstructionItem: integer;
var
 I: integer;
begin
 I := FindLastRow;
 if I > 1 then Dec(I);
 while (I > 1) and (Instruction[I] = 1) do
  I := I - 1;
 Result := I;
end;

procedure TBookDetailForm.QtyButtonClick(Sender: TObject);
var
 NumStr: string;
begin
 with StringGrid do
  begin
   SetFocus;
   if (Cells[1, Row] = '') or OrderInstruction[Row] then Row := GetLastNonInstructionItem;
   if (Row > 0) and (Cells[1, Row] <> '') and (Cells[6, Row] <> '----') then
      begin
       if (Cells[2, Row] <> '') and (StrToFloat(Cells[2, Row]) <> 0) then
          NumStr := Cells[2, Row]
         else
          NumStr := '1';
       if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Qty', 0) then
          begin
           Col := 2; CurrentCol := 2;
           if Not ChangeQtyWithCondiment or (Instruction[Row] <> 0) then
              Cells[Col, Row] := Format('%4.2f', [StrToFloat(NumStr)])
             else
              repeat
               Cells[Col, Row] := Format('%4.2f', [StrToFloat(NumStr)]);
               Row := Row + 1;
              until Instruction[Row] = 0;
           CurrentRow := Row;
           Changed := True;
           MoveToNextCell;
          end;
      end;
  end;
end;

procedure TBookDetailForm.PriceButtonClick(Sender: TObject);
var
 NumStr: string;
begin
 with StringGrid do
  begin
   SetFocus;
   if (Cells[1, Row] = '') or OrderInstruction[Row] then Row := GetLastNonInstructionItem;
   if (Row > 0) and (Cells[1, Row] <> '') and (Cells[6, Row] <> '----') and
      (Supervisor or OpenPrice[Row]) then
      begin
       if (Cells[3, Row] <> '') and (StrToFloat(Cells[3, Row]) <> 0) then
          NumStr := Cells[3, Row]
         else
          NumStr := '1';
       if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Price', 0) then
          begin
           Col := 3; CurrentCol := 3;
           Cells[Col, Row] := NumStr;
           Changed := True;
           MoveToNextCell;
          end;
      end;
  end;
end;

procedure TBookDetailForm.CategoryPageUpButtonClick(Sender: TObject);
begin
 if CategoryCurrentPage >= 2 then
    begin
     CategoryCurrentPage := CategoryCurrentPage - 1;
     AssignCategoryKeyBoard;
    end;
 BackPanel.SetFocus;
end;

procedure TBookDetailForm.CategoryPageDownButtonClick(Sender: TObject);
begin
 if (CategoryCurrentPage * CategoryCount) < CategoryRowCount then
    begin
     CategoryCurrentPage := CategoryCurrentPage + 1;
     AssignCategoryKeyBoard;
    end;
 BackPanel.SetFocus;
end;

procedure TBookDetailForm.PageUpButtonClick(Sender: TObject);
begin
 if MenuCurrentPage >= 2 then
    begin
     MenuCurrentPage := MenuCurrentPage - 1;
     AssignMenuKeyBoard;
    end;
 BackPanel.SetFocus;
end;

procedure TBookDetailForm.PageDownButtonClick(Sender: TObject);
begin
 if (MenuCurrentPage * MenuCount) < LastMenuPosition then
    begin
     MenuCurrentPage := MenuCurrentPage + 1;
     AssignMenuKeyBoard;
    end;
 BackPanel.SetFocus;
end;

procedure TBookDetailForm.MenuButtonClick(Sender: TObject);
var
 Num: string;
begin
 if TitlePanel.Enabled then
    with Sender As TPanelButton do
     begin
      Num := Copy(Name, 5, 2);
      if Caption <>'' then ProcessMenuButtonTouch(StrToInt(Num));
     end;
end;

procedure TBookDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 MenuQuery.Close;
 CategoryQuery.Close;
 DataForm.ClosePoleDisplayPort;
 Action := caFree;
end;

procedure TBookDetailForm.SetDescription(ARow: integer);
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
   case Instruction[ARow] of
     0: Cells[1, ARow] := Temp;
     1: Cells[1, ARow] := '[*] ' + Temp;
     2: Cells[1, ARow] := '[A] ' + Temp;
     3: Cells[1, ARow] := '[C] ' + Temp;
     4: Cells[1, ARow] := '[M] ' + Temp;
     5: Cells[1, ARow] := '[L] ' + Temp;
   end;
  end;
end;

procedure TBookDetailForm.InstructionButtonClick(Sender: TObject);
var
 Temp, CurRow: integer;
 ItemCode: string;
 Buff: InstructionBuffType;
begin
 StringGrid.SetFocus;
 CurRow := StringGrid.Row;
 if (StringGrid.Cells[6, CurRow] <> '') and (Instruction[CurRow] > 0) and
    (StringGrid.Cells[6, CurRow] <> '----') then
    begin
     Temp := InstructionForm.InstructionPro;
     if Temp >= 0 then
        begin
         Instruction[CurRow] := Temp;
         SetDescription(CurRow);
        end;
    end
   else
    if (StringGrid.Cells[6, CurrentRow] <> '') and (StringGrid.Cells[6, CurrentRow] <> '----') then
       begin
        ItemCode := StringGrid.Cells[6, CurrentRow];
        if DataForm.CheckInstructionLink(ItemCode) and
           InstructionListForm.InstructionPro(ItemCode, Langurage, Buff) then
           ProcessInstruction(Buff);
       end;
end;

procedure TBookDetailForm.CategoryButtonClick(Sender: TObject);
var
 Num: string;
begin
 with Sender As TPanelButton do
  begin
   Num := Copy(Name, 9, 2);
   if Caption <>'' then ProcessCategoryButtonTouch(StrToInt(Num));
  end;
end;

procedure TBookDetailForm.ConvertLangurage(FirstRow, EndRow: integer);
var
 SQLStr, Description, FieldName: string;
 I: integer;
begin
 for I := FirstRow to EndRow do
  with StringGrid do
   begin
    if (Cells[6, I] <> '') and (Cells[6, I] <> '----') then
       begin
        SQLStr := 'Select Description1, Description2, SubDescription, ' +
           'SubDescription1, SubDescription2, SubDescription3, Multiple ' +
           'From MenuItem ' +
           'Where ItemCode=' + Chr(39) + CheckQuotes(Cells[6, I]) + Chr(39);
        if OpenQuery(SQLStr) then
           begin
            if Langurage or (Query.FieldByName('Description2').AsString = '') then
               Description := Query.FieldByName('Description1').AsString
              else
               Description := Query.FieldByName('Description2').AsString;
            Cells[1, I] := Description;
            if Query.FieldByName('Multiple').AsBoolean then
               begin
                FieldName := GenerateSubDescriptionFieldName(PriceSelect[I]);
                if Query.FieldByName(FieldName).AsString <> '' then
                   Cells[1, I] := Cells[1, I] + ' / ' + Query.FieldByName(FieldName).AsString;
               end;
            SetDescription(I);
           end;
       Query.Close;
     end;
   end;
end;

procedure TBookDetailForm.LangurageButtonClick(Sender: TObject);
begin
 Langurage := Not Langurage;
 AssignCategoryKeyBoard;
 AssignMenuKeyBoard;
 ConvertLangurage(1, 500);
end;

procedure TBookDetailForm.InsertLine(CurrentLine: integer);
var
 I, J: integer;
begin
 for I := 500 Downto CurrentLine + 1 do
  begin
   for J := 1 to 6 do StringGrid.Cells[J, I] := StringGrid.Cells[J, I - 1];
   OpenPrice[I] := OpenPrice[I - 1];
   Instruction[I] := Instruction[I - 1];
   OrderInstruction[I] := OrderINstruction[I - 1];
   PriceSelect[I] := PriceSelect[I - 1];
  end;
 InitCells(CurrentLine);
end;

procedure TBookDetailForm.SplitLineButtonClick(Sender: TObject);
var
 I, J: integer;
begin
 if (StringGrid.Cells[6, CurrentRow] <> '----') and Not OrderInstruction[CurrentRow] and
    ((CurrentRow > 1) and (StringGrid.Cells[6, CurrentRow - 1] <> '----')) and
    ((CurrentRow < 500) and (StringGrid.Cells[6, CurrentRow + 1] <> '----')) then
    begin
     if StringGrid.Cells[1, CurrentRow] <> '' then InsertLine(CurrentRow);
     StringGrid.Row := CurrentRow;
     CurrentCol := 1; StringGrid.Col := 1;
     for J := 1 to 5 do
       for I := 1 to 85 do
         StringGrid.Cells[J, CurrentRow] := StringGrid.Cells[J, CurrentRow] + '-';
     StringGrid.Cells[6, CurrentRow] := '----';
     StringGrid.SetFocus;
    end;
end;

procedure TBookDetailForm.DepositButtonClick(Sender: TObject);
begin
 if sVIPNo >= 1 then
    DepositForm.DepositPro(sVIPNo)
   else
    MessageBoxForm.MessagePro('This order has not been entered the VIP Number.', sErrorMsg);
end;

procedure TBookDetailForm.MenuSetupPro;
begin
 if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not MainForm.MenuSetupMenu.Enabled then
    MessageBoxForm.MessagePro('You have not been authorised to do menu setup.', sErrorMsg)
   else
    if MenuItemForm.MenuSetup(0) then
       begin
        OpenCategory;
        AssignCategoryKeyBoard;
        ProcessCategoryButtonTouch(1);
        AssignMenuKeyBoard;
       end;
end;

procedure TBookDetailForm.SpellInstructionButtonClick(Sender: TObject);
var
 Temp: string;
 CurRow: integer;
begin
 with StringGrid do
  begin
   CurRow := Row;
   if ((CurRow > 1) and OrderInstruction[CurRow - 1]) or
      ((Cells[1, CurRow] = '') and (CurRow > 1) and (Cells[1, CurRow - 1] = '')) or
      (Cells[6, CurRow] = '----') or
      ((CurRow > 1) and (Cells[6, CurRow - 1] = '----')) then Exit;
   if (CurRow > 0) and (Cells[1, CurRow] <> '') and Not OrderInstruction[CurRow] then
      CurRow := FindLastRow;
   if KeyboardForm.KeyboardPro(Temp) then
      begin
       Cells[1, CurRow] := Temp;
       OrderInstruction[CurRow] := True;
       Instruction[CurRow] := 1;
      end;
   SetFocus;
  end;
end;

procedure TBookDetailForm.MenuGroupButtonClick(Sender: TObject);
var
 Temp: string;
begin
 if MenuGroupSelectForm.MenuGroupSelectPro(MenuGroupCode, Temp) then
    begin
     OpenCategory;
     AssignCategoryKeyBoard;
     ProcessCategoryButtonTouch(1);
     AssignMenuKeyBoard;
    end;
end;

function TBookDetailForm.OpenHeadQuery(BookingNo: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From BookTable Where BookingNo=' + Chr(39) + CheckQuotes(BookingNo) + Chr(39);
 Result := OpenQuery(SQLStr);
end;

procedure TBookDetailForm.ReadHeadData;
begin
 with Query do
  begin
   BookDateEdit.Caption := FormatDateTime('dd/mm/yyyy', FieldByName('BookingDate').AsDateTime);
   BookingNoEdit.Caption := FieldByName('BookingNo').AsString;
   ServiceEdit.Caption := FieldByName('OpName').AsString;
   CustomerNameEdit.Caption := FieldByName('CustomerName').AsString;
   sVIPNo := FieldByName('VIPNo').AsInteger;
   if sVIPNo > 0 then VIPNoEdit.Caption := Format('%8.8d', [FieldByName('VIPNO').AsInteger]);
   Close;
  end;
end;

function TBookDetailForm.OpenItemQuery(BookingNo: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select BookDetail.ItemCode, Qty, BookDetail.Price, ' +
           'Description1, Description2, BookDetail.TaxRate, OpenPrice, ' +
           'Condition, Multiple, PriceSelect, SubDescription, ' +
           'SubDescription1, SubDescription2, SubDescription3, IDNo, ' +
           'SpecialOrder ' +
           'From BookDetail, MenuItem ' +
           'Where BookDetail.ItemCode = MenuItem.ItemCode and ' +
           'BookingNo=' + Chr(39) + CheckQuotes(BookingNo) + Chr(39) +
           ' Union All ' +
           'Select BookDetail.ItemCode, 0, 0, Null, Null, 0, 0, ' +
           '0, CAST(0 AS Bit), 0, Null, Null, Null, Null, IDNo, Null ' +
           'From BookDetail ' +
           'Where BookDetail.ItemCode = ' + Chr(39) + '----' + Chr(39) +
           ' and BookingNo=' + Chr(39) + CheckQuotes(BookingNo) + Chr(39) +
           ' Order By IDNo';
 Result := OpenQuery(SQLStr);
end;

procedure TBookDetailForm.ReadItemData;
var
 Loop, I, J: integer;
 FieldName: string;
begin
 Loop := 1;
 with Query do
  begin
   First;
   while Not EOF do
    begin
     if FieldByName('ItemCode').AsString <> '----' then
        begin
         Instruction[Loop] := FieldByName('Condition').AsInteger;
         OpenPrice[Loop] := FieldByName('OpenPrice').AsInteger <> 0;
         PriceSelect[Loop] := FieldByName('PriceSelect').AsInteger;
         StringGrid.Cells[6, Loop] := FieldByName('ItemCode').AsString;
         if Langurage or (FieldByName('Description2').AsString = '') then
            StringGrid.Cells[1, Loop] := FieldByName('Description1').AsString
           else
            StringGrid.Cells[1, Loop] := FieldByName('Description2').AsString;
         if FieldByName('Multiple').AsBoolean then
            begin
             FieldName := GenerateSubDescriptionFieldName(PriceSelect[Loop]);
             if FieldByName(FieldName).AsString <> '' then
                StringGrid.Cells[1, Loop] := StringGrid.Cells[1, Loop] + ' / ' +
                                             FieldByName(FieldName).AsString;
            end;
         if ABS(FieldByName('Qty').AsFloat) >= 0.01 then
            StringGrid.Cells[2, Loop] := Format('%4.2f', [FieldByName('Qty').AsFloat]);
         if ABS(FieldByName('Price').AsFloat) >= 0.01 then
            StringGrid.Cells[3, Loop] := Format('%4.2f', [FieldByName('Price').AsFloat]);
         StringGrid.Cells[5, Loop] := Format('%4.2f', [FieldByName('TaxRate').AsFloat]);
         SetDescription(Loop);
         if FieldByName('SpecialOrder').AsString <> '' then
            begin
             Loop := Loop + 1;
             StringGrid.Cells[1, Loop] := FieldByName('SpecialOrder').AsString;
             Instruction[Loop] := 1;
             OrderInstruction[Loop] := True;
            end; 
        end
       else
        begin
         for J := 1 to 5 do
           for I := 1 to 85 do
            StringGrid.Cells[J, Loop] := StringGrid.Cells[J, Loop] + '-';
         StringGrid.cells[6, Loop] := '----';
        end;
      Next; Loop := Loop + 1;
    end;
   Close;
  end;
 if Loop < 500 then
    StringGrid.Row := Loop
   else
    StringGrid.Row := 500;
 CurrentRow := StringGrid.Row;
end;

procedure TBookDetailForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
end;

procedure TBookDetailForm.FormShow(Sender: TObject);
begin
 MenuCount := (MainMenuLine - 1) * 4 + 2;
 CategoryCount := (MainCategoryLine - 1) * 4 + 2;
 MenuGroupCode := Format('%2.2d', [FVar.DefaultMainMenuGroupCode]);
 if Not ShowTaxOnsalesSection and PriceIncludesGST then
    begin
     GSTLabel.Caption := 'Total price includes GST';
     GSTEdit.Visible := False;
    end;
 InitForm;
 InitMenuPanel;
 InitCategoryPanel;
 InitControlButton;
 SetTotalPanelLabelPosition;
 Langurage := True;
 OpenCategory;
 AssignCategoryKeyBoard;
 ProcessCategoryButtonTouch(1);
 AssignMenuKeyBoard;
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
 if OpenHeadQuery(sBookingNo) then
    begin
     ReadHeadData;
     if OpenItemQuery(sBookingNo) then ReadItemData;
     Changed := False;
    end;
 CalcAmount;
end;

function TBookDetailForm.BookingDetailEditPro(BookingNo: string): boolean;
begin
 Application.CreateForm(TBookDetailForm, BookDetailForm);
 BookDetailForm.sBookingNo := BookingNo;
 BookDetailForm.ShowModal;
 Result := BookDetailForm.ReturnFlag;
 BookDetailForm.Free;
end;

end.

