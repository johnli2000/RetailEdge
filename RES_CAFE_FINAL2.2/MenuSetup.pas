unit MenuSetup;

interface
{ $H+}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, DB, Grids, DBGrids, UtilUnit,
  ADODB, Variants, Menus, bsSkinCtrls, PanelButton, XiButton;

type
  TMenuItemForm = class(TForm)
    DBGrid: TDBGrid;
    CategoryLookupBox: TDBLookupComboBox;
    DataSource: TDataSource;
    ListCheckBox: TCheckBox;
    CategoryDataSource: TDataSource;
    InstructionCheckBox: TCheckBox;
    Query: TADOQuery;
    QueryInstruction: TBooleanField;
    QueryPrice1: TFloatField;
    QueryPrice2: TFloatField;
    QueryPrice3: TFloatField;
    QueryItemCode: TStringField;
    QueryDescription1: TStringField;
    QueryDescription2: TStringField;
    QueryPrice: TFloatField;
    QueryTaxRate: TFloatField;
    QueryCategory: TStringField;
    QueryAllowDiscount: TBooleanField;
    QueryControl: TStringField;
    QueryDisc: TStringField;
    CategoryQuery: TADOQuery;
    CategoryPanel: TbsSkinPanel;
    QueryBarCode: TStringField;
    QueryBarCode1: TStringField;
    QueryBarCode2: TStringField;
    QueryBarCode3: TStringField;
    QueryButtonColor: TIntegerField;
    QueryFontColor: TIntegerField;
    QueryJobListColor: TSmallintField;
    QueryMultiple: TBooleanField;
    QuerySubDescription: TStringField;
    QuerySubDescription1: TStringField;
    QuerySubDescription2: TStringField;
    QuerySubDescription3: TStringField;
    QueryActive: TBooleanField;
    QueryPrinterPort: TSmallintField;
    QueryFontName: TStringField;
    QueryFontSize: TIntegerField;
    QueryFontBold: TBooleanField;
    QueryFontItalic: TBooleanField;
    QueryFontUnderline: TBooleanField;
    QueryFontStrikeout: TBooleanField;
    QueryOpenPrice: TBooleanField;
    QueryPrinterPort1: TIntegerField;
    QueryPrinterPort2: TIntegerField;
    QueryHappyHourPrice1: TFloatField;
    QueryHappyHourPrice2: TFloatField;
    QueryHappyHourPrice3: TFloatField;
    QueryHappyHourPrice4: TFloatField;
    QueryDefaultQty: TFloatField;
    ShowComboBox: TComboBox;
    QueryMainPosition: TIntegerField;
    QueryPOSPosition: TIntegerField;
    SearchComboBox: TComboBox;
    Category39: TPanelButton;
    Category40: TPanelButton;
    Category41: TPanelButton;
    Category42: TPanelButton;
    CategoryPageUpButton: TPanelButton;
    CategoryPageDownButton: TPanelButton;
    MenuGroupDescriptionEdit: TStaticText;
    BackPanel: TbsSkinPanel;
    DBGridPanel: TbsSkinPanel;
    bsSkinPanel1: TbsSkinPanel;
    NewButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    InstructionButton: TXiButton;
    SubMenuLinkButton: TXiButton;
    StockLinkButton: TXiButton;
    CategorySetupButton: TXiButton;
    ItemGroupSetupButton: TXiButton;
    ButtonLayoutButton: TXiButton;
    PrintButton: TXiButton;
    PrintBarcodeButton: TXiButton;
    MenuGroupButton: TXiButton;
    ReArrangeButton: TXiButton;
    ExitButton: TXiButton;
    DescriptionComboBox: TComboBox;
    QueryPhoneOrderPosition: TIntegerField;
    QueryFontSize1: TIntegerField;
    QueryButtonColor1: TIntegerField;
    QueryFontName1: TWideStringField;
    QueryFontColor1: TIntegerField;
    QueryFontBold1: TBooleanField;
    QueryFontItalic1: TBooleanField;
    QueryFontUnderline1: TBooleanField;
    QueryFontStrikeout1: TBooleanField;
    MenuPanel: TbsSkinPanel;
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
    Menu23: TPanelButton;
    Menu24: TPanelButton;
    Menu25: TPanelButton;
    Menu26: TPanelButton;
    Menu27: TPanelButton;
    Menu28: TPanelButton;
    Menu29: TPanelButton;
    Menu30: TPanelButton;
    Menu31: TPanelButton;
    Menu32: TPanelButton;
    Menu33: TPanelButton;
    Menu34: TPanelButton;
    Menu35: TPanelButton;
    Menu36: TPanelButton;
    Menu37: TPanelButton;
    Menu38: TPanelButton;
    PageUpButton: TPanelButton;
    PageDownButton: TPanelButton;
    Menu39: TPanelButton;
    Menu40: TPanelButton;
    Menu41: TPanelButton;
    Menu42: TPanelButton;
    Menu47: TPanelButton;
    Menu50: TPanelButton;
    Menu49: TPanelButton;
    Menu48: TPanelButton;
    Menu46: TPanelButton;
    Menu45: TPanelButton;
    Menu44: TPanelButton;
    Menu43: TPanelButton;
    procedure InitMenuPanel;
    procedure InitCategoryPanel;
    procedure OpenCategoryQuery;
    procedure OpenQuery;
    procedure AssignMenuKeyBoard;
    procedure AssignCategoryKeyBoard;
    procedure ProcessCategoryButtonTouch(Position: integer);
    procedure ProcessMenuButtonTouch(Position: integer);
    procedure CategoryPageUpButtonClick(Sender: TObject);
    procedure CategoryPageDownButtonClick(Sender: TObject);
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure CategoryButtonClick(Sender: TObject);
    procedure MenuButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function  CanDeleteCode(Code: string): boolean;
    procedure DeleteButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure CategoryLookupBoxCloseUp(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SeekEditKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure SeekEditKeyPress(Sender: TObject; var Key: Char);
    procedure ListCheckBoxClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure PrintButtonClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure InstructionCheckBoxClick(Sender: TObject);
    procedure InstructionButtonClick(Sender: TObject);
    //procedure StockLinkButtonClick(Sender: TObject);
    procedure ButtonLayoutButtonClick(Sender: TObject);
    procedure ItemGroupSetupButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    function  MenuSetup(ShowButtonFlag: integer): boolean;
    procedure ShowComboBoxChange(Sender: TObject);
    procedure EditPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    function  CheckSeletedObjectStatus(var ItemCode: string; MenuButtonName: string): boolean;
    function  CheckReleaseObjectStatus(var NewPosition: integer; MenuButtonName: string): boolean;
    function  CheckCategoryButtonStatus(var CategoryName: string;
              CategoryButtonName: string): boolean;
    function  MoveToNewPosition(ItemCode: string; NewPosition: integer): boolean;
    function  MoveToNewCategory(ItemCode, NewCategory: string): boolean;
    procedure ProcessItemMove;
    procedure MenuButtonDblClick(Sender: TObject);
    procedure CategoryButtonDblClick(Sender: TObject);
    procedure CategorySetupButtonClick(Sender: TObject);
    procedure SearchComboBoxChange(Sender: TObject);
    procedure PrintBarcodeButtonClick(Sender: TObject);
    procedure ReArrangeButtonClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
              DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SubMenuLinkButtonClick(Sender: TObject);
    procedure MenuGroupButtonClick(Sender: TObject);
    procedure DescriptionComboBoxChange(Sender: TObject);

  private { Private declarations }
    CategoryCurrentPage, CategoryRowCount, MenuCurrentPage,
    MenuCount, CategoryCount, MenuLine, CategoryLine: integer;
    ReturnFlag, StartMoveMouse: boolean;
    SelectedObjectName, ReleaseObjectName, MenuGroupCode, MenuGroupDescription: string;
  public
    { Public declarations }
  end;

var
 MenuItemForm: TMenuItemForm;

implementation

uses Category, DataUnit, MenuItemEdit, MainMenu, Keyboard, MessageBox,
     InstructionLink, InstructionList, ButtonSetup,
     CategoryEdit,  PrintMenuItemSelect,
     PrintMenuList, MenuLink, MenuGroupSelect, ItemGroupSetup,
     MenuItemGroupSetup,BarcodeSetup;

{$R *.DFM}

procedure TMenuItemForm.InitMenuPanel;
var
 I: integer;
 ButtonName: string;
begin
 for I := 1 to 50 do
  begin
   ButtonName := 'Menu' + IntToStr(I);
   with TPanel(FindComponent(ButtonName)) do
    Visible := I <= MenuCount;
  end;
 //MenuPanel.Top := 3;
 //MenuPanel.Left := 566;
 //MenuPanel.Height := MenuLine * 57 + 9;
 //PageUpButton.Top := (MenuLine - 1) * 57 + 6;
 //PageDownButton.Top := PageUpButton.Top;
end;

procedure TMenuItemForm.InitCategoryPanel;
var
 I: integer;
 ButtonName: string;
begin
 for I := 1 to 11 do
  begin
   ButtonName := 'Category' + IntToStr(I);
   with TPanel(FindComponent(ButtonName)) do
    Visible := I <= CategoryCount;
  end;
 //CategoryPanel.Top := MenuPanel.Height + 5;
 //CategoryPanel.Left := 566;
 //CategoryPanel.Height := CategoryLine * 57 + 9;
 //CategoryPageUpButton.Top := (CategoryLine - 1) * 57 + 6;
 //CategoryPageDownButton.Top := CategoryPageUpButton.Top;
end;

procedure TMenuItemForm.OpenCategoryQuery;
var
 SQLStr: string;
begin
 case ShowComboBox.ItemIndex of
  0: SQLStr := 'Select * From Category Where ShowOnMainMenu <> 0 and ' +
               'MenuGroupCode=' + Chr(39) + CheckQuotes(MenuGroupCode) + Chr(39) +
               ' Order By Code';
  1: SQLStr := 'Select * From Category Where ShowOnPOSMenu <> 0 and ' +
               'MenuGroupCode=' + Chr(39) + CheckQuotes(MenuGroupCode) + Chr(39) +
               ' Order By Code';
  2: SQLStr := 'Select * From Category Where ShowOnPhoneOrderMenu <> 0 and ' +
               'MenuGroupCode=' + Chr(39) + CheckQuotes(MenuGroupCode) + Chr(39) +
               ' Order By Code';
 end;
 Screen.Cursor := crHourGlass;
 with CategoryQuery do
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
   CategoryRowCount := RecordCount;
   CategoryCurrentPage := 1;
  end;
end;

procedure TMenuItemForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From MenuItem ' +
           'Where MenuItem.Category=' + Chr(39) + CheckQuotes(CategoryLookupBox.Text) + Chr(39);
 if Not ListCheckBox.Checked then SQLStr := SQLStr + ' and Active <> 0';
 if Not InstructionCheckBox.Checked then SQLStr := SQLStr + ' and Instruction = 0';
 case SearchComboBox.ItemIndex of
  0: SQLStr := SQLStr + ' Order By ItemCode';
  1: SQLStr := SQLStr + ' Order By Description1';
  2: SQLStr := SQLStr + ' Order By Description2';
 end;
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
   MenuCurrentPage := 1;
  end;
end;

procedure TMenuItemForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  begin
   if FieldByName('AllowDiscount').AsBoolean then
      FieldByName('Disc').AsString := 'Yes'
     else
       FieldByName('Disc').AsString := 'No';
  end;
end;

procedure TMenuItemForm.AssignMenuKeyBoard;
var
 I, MenuPosition: integer;
 ButtonName: string;
begin
 Query.DisableControls;
 for I := 1 to MenuCount do
  begin
   ButtonName := 'Menu' + IntToStr(I);
   MenuPosition := (MenuCurrentPage - 1) * MenuCount + I;
   case ShowComboBox.ItemIndex of
    0: Query.Locate('MainPosition', IntToStr(MenuPosition), [loPartialKey]);
    1: Query.Locate('POSPosition', IntToStr(MenuPosition), [loPartialKey]);
    2: Query.Locate('PhoneOrderPosition', IntToStr(MenuPosition), [loPartialKey]);
   end;
   with TPanelButton(FindComponent(ButtonName)) do
    begin
     if ((ShowComboBox.ItemIndex = 0) and
        (Query.FieldByName('MainPosition').AsInteger = MenuPosition)) or
        ((ShowComboBox.ItemIndex = 1) and
        (Query.FieldByName('POSPosition').AsInteger = MenuPosition)) or
        ((ShowComboBox.ItemIndex = 2) and
        (Query.FieldByName('PhoneOrderPosition').AsInteger = MenuPosition)) then
        begin
         if (DescriptionComboBox.ItemIndex = 0) or (Query.FieldByName('Description2').AsString = '') then
            begin
             Caption := CopyDescription(Query.FieldByName('Description1').AsString);
             Color := Query.FieldByName('ButtonColor').AsInteger;
             Font.Size := Query.FieldByName('FontSize').AsInteger;
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
            end
           else
            begin
             Caption := CopyDescription(Query.FieldByName('Description2').AsString);
             Color := Query.FieldByName('ButtonColor1').AsInteger;
             Font.Size := Query.FieldByName('FontSize1').AsInteger;
             Font.Name := Query.FieldByName('FontName1').AsString;
             Font.Color := Query.FieldByName('FontColor1').AsInteger;
             Font.Style := [];
             if Query.FieldByName('FontBold1').AsBoolean then
                Font.Style := Font.Style + [fsBold];
             if Query.FieldByName('FontItalic1').AsBoolean then
                Font.Style := Font.Style + [fsItalic];
             if Query.FieldByName('FontUnderline1').AsBoolean then
                Font.Style := Font.Style + [fsUnderline];
             if Query.FieldByName('FontStrikeout1').AsBoolean then
                Font.Style := Font.Style + [fsStrikeout];
            end
         end
       else
        begin
         Caption := Format('%1d', [(MenuCurrentPage - 1) * MenuCount + I]);
         Color := $00D9D9D9;
         Font.Color := clGray;
         Font.Size := 8;
         Font.Style := [];
        end;
    end;
  end;
 Query.EnableControls;
end;

procedure TMenuItemForm.AssignCategoryKeyBoard;
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
        if (DescriptionComboBox.ItemIndex = 0) or (CategoryQuery.FieldByName('Category1').AsString = '') then
           begin
            Caption := CopyDescription(CategoryQuery.FieldByName('Category').AsString);
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
           end
          else
           begin
            Caption := CopyDescription(CategoryQuery.FieldByName('Category1').AsString);
            Color := CategoryQuery.FieldByName('ButtonColor1').AsInteger;
            Font.Size := CategoryQuery.FieldByName('FontSize1').AsInteger;;
            Font.Name := CategoryQuery.FieldByName('FontName1').AsString;
            Font.Color := CategoryQuery.FieldByName('FontColor1').AsInteger;
            Font.Style := [];
            if CategoryQuery.FieldByName('FontBold1').AsBoolean then
               Font.Style := Font.Style + [fsBold];
            if CategoryQuery.FieldByName('FontItalic1').AsBoolean then
               Font.Style := Font.Style + [fsItalic];
            if CategoryQuery.FieldByName('FontUnderline1').AsBoolean then
               Font.Style := Font.Style + [fsUnderline];
            if CategoryQuery.FieldByName('FontStrikeout1').AsBoolean then
               Font.Style := Font.Style + [fsStrikeout];
           end;
        CategoryQuery.Next;
       end
      else
       begin
        Caption := '';
        Color := $00D9D9D9;
        Font.Color := clBlack;
        Visible := True;
       end;
  end;
end;

procedure TMenuItemForm.ProcessCategoryButtonTouch(Position: integer);
begin
 CategoryQuery.First;
 CategoryQuery.MoveBy((CategoryCurrentPage - 1) * CategoryCount + Position - 1);
 CategoryLookupBox.KeyValue := CategoryQuery.FieldByName('Category').AsString;
 OpenQuery;
 AssignMenuKeyBoard;
end;

procedure TMenuItemForm.ProcessMenuButtonTouch(Position: integer);
begin
 case ShowComboBox.ItemIndex of
  0: Query.Locate('MainPosition', IntToStr((MenuCurrentPage - 1) * MenuCount + Position), [loPartialKey]);
  1: Query.Locate('POSPosition', IntToStr((MenuCurrentPage - 1) * MenuCount + Position), [loPartialKey]);
  2: Query.Locate('PhoneOrderPosition', IntToStr((MenuCurrentPage - 1) * MenuCount + Position), [loPartialKey]);
 end;
end;

procedure TMenuItemForm.CategoryPageUpButtonClick(Sender: TObject);
begin
 if CategoryCurrentPage >= 2 then
    begin
     CategoryCurrentPage := CategoryCurrentPage - 1;
     AssignCategoryKeyBoard;
    end;
end;

procedure TMenuItemForm.CategoryPageDownButtonClick(Sender: TObject);
begin
 if (CategoryCurrentPage * CategoryCount) < CategoryRowCount then
    begin
     CategoryCurrentPage := CategoryCurrentPage + 1;
     AssignCategoryKeyBoard;
    end;
end;

procedure TMenuItemForm.PageUpButtonClick(Sender: TObject);
begin
 if MenuCurrentPage >= 2 then
    begin
     MenuCurrentPage := MenuCurrentPage - 1;
     AssignMenuKeyBoard;
    end;
end;

procedure TMenuItemForm.PageDownButtonClick(Sender: TObject);
begin
 MenuCurrentPage := MenuCurrentPage + 1;
 AssignMenuKeyBoard;
end;

procedure TMenuItemForm.CategoryButtonClick(Sender: TObject);
var
 Num: string;
begin
 with Sender As TPanelButton do
  begin
   Num := Copy(Name, 9, 2);
   if Caption <>'' then ProcessCategoryButtonTouch(StrToInt(Num));
  end;
end;

procedure TMenuItemForm.MenuButtonClick(Sender: TObject);
var
 Num: string;
begin
 with Sender As TPanelButton do
  begin
   Num := Copy(Name, 5, 2);
   if Color <> $00DDF9E8 then ProcessMenuButtonTouch(StrToInt(Num));
  end;
end;

procedure TMenuItemForm.CategoryLookupBoxCloseUp(Sender: TObject);
begin
 CategoryLookupBox.KeyValue := CategoryQuery.FieldByName('Category').AsString;
 OpenQuery;
 AssignMenuKeyBoard;
end;

procedure TMenuItemForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TMenuItemForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CategoryQuery.Close;
 Query.Close;
 Action := caFree;
end;

procedure TMenuItemForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

function TMenuItemForm.CanDeleteCode(Code: string): boolean;
begin
 if (DataForm.CheckCodeSQLPro('Select Count(*) From OrderI where ItemCode=' + Chr(39) + CheckQuotes(Code) + Chr(39)) > 0) or
    (DataForm.CheckCodeSQLPro('Select Count(*) From WastageItem where ItemCode=' + Chr(39) + CheckQuotes(Code) + Chr(39)) > 0) or
    (DataForm.CheckCodeSQLPro('Select Count(*) From HoldItem where ItemCode=' + Chr(39) + CheckQuotes(Code) + Chr(39)) > 0) then
    Result := False
   else
    Result := True;
end;

procedure TMenuItemForm.DeleteButtonClick(Sender: TObject);
var
 ItemCode, SQLStr: String;
 Flag: boolean;
begin
 if Not Query.Active or (Query.RecordCount = 0) or
    (MessageBoxForm.MessagePro('Are you sure you want to delete this item code?', sConfirmMsg) = mrNo) then Exit;
 ItemCode := Query.FieldByName('ItemCode').AsString;
 if Not CanDeleteCode(ItemCode) then
    begin
     MessageBoxForm.MessagePro('This item can not be deleted that linked to another database.', sErrorMsg);
     Exit;
    end;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  SQLStr := 'Delete From MenuItem Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
  Flag := DataForm.ExecQueryPro(SQLStr);
  if Flag then
     begin
      SQLStr := 'Delete From StockLinkTable Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag then
     begin
      SQLStr := 'Delete From InstructionLink ' +
                'Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
                ' Or Code=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag then
     begin
      SQLStr := 'Delete From IngredientsTable ' +
                'Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag then
     begin
      SQLStr := 'Delete From SubMenuLinkHead ' +
                'Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
  if Flag then
     begin
      SQLStr := 'Delete From SubMenuLinkDetail ' +
                'Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
                ' Or SubMenuCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;
 finally
  if Flag then
     begin
      ReturnFlag := True;
      DataForm.CommitTransaction;
      OpenQuery;
      AssignMenuKeyBoard;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TMenuItemForm.SeekEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key In [VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR] then
    DBGrid.SetFocus
end;

procedure TMenuItemForm.SeekEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key In ['a'..'z'] then Key := UpCase(Key)
end;

procedure TMenuItemForm.ListCheckBoxClick(Sender: TObject);
begin
 OpenQuery;
 AssignMenuKeyBoard;
end;

procedure TMenuItemForm.DBGridDblClick(Sender: TObject);
begin
 EditButtonClick(Sender);
end;

procedure TMenuItemForm.PrintButtonClick(Sender: TObject);
var
 Select: integer;
begin
 if PrintMenuItemSelectForm.SelectMenuItemPrintPro(Select) then
    begin
     if Select = 0 then
        begin
         if CategoryQuery.Active and (CategoryQuery.RecordCount > 0) then
            PrintMenuListForm.PrintMenuListPro(CategoryLookupBox.Text)
        end
       else
        begin
         if Query.Active and (Query.RecordCount > 0) then
            PrintMenuListForm.PrintMenuListPro('');
        end;
    end;
end;

procedure TMenuItemForm.NewButtonClick(Sender: TObject);
var
 Code, Category: string;
begin
 Category := CategoryLookupBox.Text;
 if MenuItemEditForm.MenuItemEditPro(Code, Category, sNewStatus) then
    begin
     ReturnFlag := True;
     OpenQuery;
     AssignMenuKeyBoard;
     Query.Locate('ItemCode', Code, [loPartialKey]);
    end;
end;

procedure TMenuItemForm.EditButtonClick(Sender: TObject);
var
 Code, Category: string;
begin
 Category := CategoryLookupBox.Text;
 if Query.RecordCount > 0 then
    begin
     Code := Query.FieldByName('ItemCode').AsString;
     if MenuItemEditForm.MenuItemEditPro(Code, Category, sEditStatus) then
        begin
         ReturnFlag := True;
         OpenQuery;
         AssignMenuKeyBoard;
         Query.Locate('ItemCode', Code, [loPartialKey]);
        end;
    end;
end;

procedure TMenuItemForm.DescriptionComboBoxChange(Sender: TObject);
begin
 AssignCategoryKeyBoard;
 ProcessCategoryButtonTouch(1);
 AssignMenuKeyBoard;
end;

procedure TMenuItemForm.InstructionCheckBoxClick(Sender: TObject);
begin
 OpenQuery;
 AssignMenuKeyBoard;
end;

procedure TMenuItemForm.InstructionButtonClick(Sender: TObject);
var
 ItemCode, Description: string;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      ItemCode := FieldByName('ItemCode').AsString;
      Description := FieldByName('Description1').AsString;
      InstructionLinkForm.InstructionLinkPro(ItemCode, Description);
     end;
end;

{procedure TMenuItemForm.StockLinkButtonClick(Sender: TObject);
var
 ItemCode: string;
begin
 with Query do
  begin
   if Not Active or (RecordCount = 0) then Exit;
   ItemCode := FieldByName('ItemCode').AsString;
   StockLinkForm.StockLinkPro(ItemCode);
  end;
end;}

procedure TMenuItemForm.SubMenuLinkButtonClick(Sender: TObject);
var
 ItemCode, Description: string;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      ItemCode := FieldByName('ItemCode').AsString;
      Description := FieldByName('Description1').AsString;
      MenuLinkForm.MenuLinkPro(ItemCode, Description);
     end;
end;

procedure TMenuItemForm.ButtonLayoutButtonClick(Sender: TObject);
begin
 ButtonSetupForm.ButtonLayoutSetup;
 OpenQuery;
 AssignMenuKeyBoard;
end;

procedure TMenuItemForm.ItemGroupSetupButtonClick(Sender: TObject);
var
 Code: string;
begin
 with Query do
  begin
   if Active and (RecordCount > 0) then
      Code := FieldByName('ItemCode').AsString
     else
      Code := '';
   MenuItemGroupSetupForm.MenuItemGroupSetupPro;
   OpenQuery;
   AssignMenuKeyBoard;
   if Active and (RecordCount > 0) and (Code <> '') then
      Query.Locate('ItemCode', Code, [loPartialKey]);
  end;     
end;

procedure TMenuItemForm.ShowComboBoxChange(Sender: TObject);
begin
 case ShowComboBox.ItemIndex of
  0: begin
      MenuLine := MainMenuLine;
      CategoryLine := MainCategoryLine;
     end;
  1: begin
      MenuLine := POSMenuLine;
      CategoryLine := POSCategoryLine;
     end;
  2: begin
      MenuLine := PhoneOrderMenuLine;
      CategoryLine := PhoneOrderCategoryLine;
     end;
 end;
 //MenuCount := (MenuLine - 1) * 4 + 2;
 //CategoryCount := (CategoryLine - 1) * 4 + 2;
 MenuCount := 50;
 CategoryCount := 11;
 InitMenuPanel;
 InitCategoryPanel;
 OpenCategoryQuery;
 AssignCategoryKeyBoard;
 ProcessCategoryButtonTouch(1);
 AssignMenuKeyBoard;
end;

function TMenuItemForm.CheckSeletedObjectStatus(var ItemCode: string; MenuButtonName: string): boolean;
var
 Position: integer;
begin
 with TPanelButton(FindComponent(MenuButtonName)) do
  if Color = $00D9D9D9 then Result := False
   else
    begin
     Position := StrToInt(Copy(Name, 5, 2));
     case ShowComboBox.ItemIndex of
      0: Query.Locate('MainPosition', IntToStr((MenuCurrentPage - 1) * MenuCount + Position), [loPartialKey]);
      1: Query.Locate('POSPosition', IntToStr((MenuCurrentPage - 1) * MenuCount + Position), [loPartialKey]);
      2: Query.Locate('PhoneOrderPosition', IntToStr((MenuCurrentPage - 1) * MenuCount + Position), [loPartialKey]);
     end;
     ItemCode := Query.FieldByName('ItemCode').AsString;
     Result := True;
    end;
end;

function TMenuItemForm.CheckReleaseObjectStatus(var NewPosition: integer; MenuButtonName: string): boolean;
begin
 with TPanelButton(FindComponent(MenuButtonName)) do
  if Color <> $00D9D9D9 then Result := False else
     begin NewPosition := StrToInt(Caption); Result := True end;
end;

function TMenuItemForm.MoveToNewPosition(ItemCode: string; NewPosition: integer): boolean;
var
 SQLStr: string;
 Flag: boolean;
 Temp: integer;
begin
 case ShowComboBox.ItemIndex of
  0: SQLStr := 'Update MenuItem Set MainPosition=' + IntToStr(NewPosition) +
               ' Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
  1: SQLStr := 'Update MenuItem Set POSPosition=' + IntToStr(NewPosition) +
              ' Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
  2: SQLStr := 'Update MenuItem Set PhoneOrderPosition=' + IntToStr(NewPosition) +
              ' Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
 end;
 Flag := False;
 Temp := MenuCurrentPage;
 if DataForm.BeginTransaction then
    try
     Flag := DataForm.ExecQueryPro(SQLStr);
    finally
     if Flag then
        begin
         DataForm.CommitTransaction;
         OpenQuery;
         MenuCurrentPage := Temp;
         AssignMenuKeyBoard;
         Query.Locate('ItemCode', ItemCode, [loPartialKey]);
         ReturnFlag := True;
        end
       else
         DataForm.Rollback;
    end;
 Result := Flag;
end;

function TMenuItemForm.CheckCategoryButtonStatus(var CategoryName: string;
         CategoryButtonName: string): boolean;
var
 ButtonNumber: integer;
begin
 with TPanelButton(FindComponent(CategoryButtonName)) do
  if Color = $00D9D9D9 then Result := False
   else
    begin
     ButtonNumber := StrToInt(Copy(Name, 9, 2));
     CategoryQuery.First;
     CategoryQuery.MoveBy((CategoryCurrentPage - 1) * CategoryCount + (ButtonNumber - 1));
     CategoryName := CategoryQuery.FieldByName('Category').AsString;
     Result := True;
    end;
end;

function TMenuItemForm.MoveToNewCategory(ItemCode, NewCategory: string): boolean;
var
 SQLStr: string;
 MainPosition, POSPosition, PhoneOrderPosition: integer;
 Flag: boolean;
begin
 SQLStr := 'Select Max(MainPosition) From MenuItem ' +
           'Where Category=' + Chr(39) + CheckQuotes(NewCategory) + Chr(39);
 DataForm.OpenTempQuery(SQLStr);
 MainPosition := DataForm.TempQuery.Fields[0].AsInteger;
 if MainPosition = 0 then MainPosition := 1 else MainPosition := MainPosition + 1;

 SQLStr := 'Select Max(POSPosition) From MenuItem ' +
           'Where Category=' + Chr(39) + CheckQuotes(NewCategory) + Chr(39);
 DataForm.OpenTempQuery(SQLStr);
 POSPosition := DataForm.TempQuery.Fields[0].AsInteger;
 if POSPosition = 0 then POSPosition := 1 else POSPosition := POSPosition + 1;

 SQLStr := 'Select Max(PhoneOrderPosition) From MenuItem ' +
           'Where Category=' + Chr(39) + CheckQuotes(NewCategory) + Chr(39);
 DataForm.OpenTempQuery(SQLStr);
 PhoneOrderPosition := DataForm.TempQuery.Fields[0].AsInteger;
 if PhoneOrderPosition = 0 then PhoneOrderPosition := 1 else PhoneOrderPosition := PhoneOrderPosition + 1;

 SQLStr := 'Update MenuItem Set MainPosition=' + IntToStr(MainPosition) +
           ', POSPosition=' + IntToStr(POSPosition) +
           ', PhoneOrderPosition=' + IntToStr(PhoneOrderPosition) +
           ', Category=' + Chr(39) + CheckQuotes(NewCategory) + Chr(39) +
           ' Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
 Flag := False;
 if DataForm.BeginTransaction then
    try
     Flag := DataForm.ExecQueryPro(SQLStr);
    finally
     if Flag then
        begin
         DataForm.CommitTransaction;
         CategoryLookupBox.KeyValue := NewCategory;
         OpenQuery;
         AssignMenuKeyBoard;
         ReturnFlag := True;
        end
       else
        DataForm.Rollback;
    end;
 Result := Flag;
end;

procedure TMenuItemForm.ProcessItemMove;
var
 ItemCode, CategoryName: string;
 NewPosition: integer;
begin
 if (SelectedObjectName <> 'DBGrid') and (Copy(SelectedObjectName, 1, 4) <> 'Menu') then Exit;
 if (Copy(ReleaseObjectName, 1, 4) <> 'Menu') and (Copy(ReleaseObjectName, 1, 8) <> 'Category') then Exit;
 if (SelectedObjectName = 'DBGrid') and (ReleaseObjectName = SelectedObjectName) then Exit;
 if (Copy(SelectedObjectName, 1, 4) = 'Menu') and (SelectedObjectName=ReleaseObjectName) then Exit;
 if (SelectedObjectName = 'DBGrid') and (Copy(ReleaseObjectName, 1, 8) = 'Category') and
    CheckCategoryButtonStatus(CategoryName, ReleaseObjectName) and
    (CategoryLookupBox.Text <> CategoryName) then
    begin
     ItemCode := Query.FieldByName('ItemCode').AsString;
     MoveToNewCategory(ItemCode, CategoryName);
    end
   else
    if (Copy(SelectedObjectName, 1, 4) = 'Menu') and (Copy(ReleaseObjectName, 1, 4) = 'Menu') and
       CheckSeletedObjectStatus(ItemCode, SelectedObjectName) and
       CheckReleaseObjectStatus(NewPosition, ReleaseObjectName) then
       MoveToNewPosition(ItemCode, NewPosition)
      else
       if (Copy(SelectedObjectName, 1, 4) = 'Menu') and (Copy(ReleaseObjectName, 1, 8) = 'Category') and
          CheckSeletedObjectStatus(ItemCode, SelectedObjectName) and
          CheckCategoryButtonStatus(CategoryName, ReleaseObjectName) and
          (CategoryLookupBox.Text <> CategoryName) then
          MoveToNewCategory(ItemCode, CategoryName)
        else
         if (SelectedObjectName = 'DBGrid') and (Copy(ReleaseObjectName, 1, 4) = 'Menu') and
            CheckReleaseObjectStatus(NewPosition, ReleaseObjectName) then
            begin
             ItemCode := Query.FieldByName('ItemCode').AsString;
             MoveToNewPosition(ItemCode, NewPosition)
           end
end;

procedure TMenuItemForm.EditPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
 if Shift =  [ssLeft] then
    begin
     if Not StartMoveMouse and Query.Active and (Query.RecordCount > 0) and
        (X < DBGrid.Left + DBGrid.Width) and (Y < DBGrid.Top + DBGrid.Height) then
        begin
         StartMoveMouse := True;
         Screen.Cursor := crDrag;
         with Sender As TComponent do SelectedObjectName := Name;
        end;
    end
   else
    begin
     Screen.Cursor := crDefault;
     if StartMoveMouse then
        begin
         with Sender As TComponent do ReleaseObjectName := Name;
         ProcessItemMove;
         StartMoveMouse := False;
        end;
    end;
end;

procedure TMenuItemForm.MenuButtonDblClick(Sender: TObject);
var
 Code, Category: string;
 Position: integer;
begin
 with Sender As TPanelButton do
  begin
   Position := StrToInt(Copy(Name, 5, 2));
   if Color <> $00D9D9D9 then
      begin
       case ShowComboBox.ItemIndex of
        0: Query.Locate('MainPosition', IntToStr((MenuCurrentPage - 1) * MenuCount + Position), [loPartialKey]);
        1: Query.Locate('POSPosition', IntToStr((MenuCurrentPage - 1) * MenuCount + Position), [loPartialKey]);
        2: Query.Locate('PhoneOrderPosition', IntToStr((MenuCurrentPage - 1) * MenuCount + Position), [loPartialKey]);
       end;
       Category := CategoryLookupBox.Text;
       Code := Query.FieldByName('ItemCode').AsString;
       if MenuItemEditForm.MenuItemEditPro(Code, Category, sEditStatus) then
          begin
           OpenQuery;
           AssignMenuKeyBoard;
           Query.Locate('ItemCode', Code, [loPartialKey]);
           ReturnFlag := True;
          end;
      end;
  end;
end;

procedure TMenuItemForm.CategoryButtonDblClick(Sender: TObject);
var
 Position: integer;
 Category: string;
begin
 with Sender As TPanelButton do
  begin
   if Caption = '' then Exit;
   Position := StrToInt(Copy(Name, 9, 2));
  end;
 CategoryQuery.First;
 CategoryQuery.MoveBy((CategoryCurrentPage - 1) * CategoryCount + Position - 1);
 Category := CategoryQuery.FieldByName('Category').AsString;
 if CategoryEditForm.CategoryEditPro(Category, sEditStatus) then
    begin
     ReturnFlag := True;
     OpenCategoryQuery;
     AssignCategoryKeyBoard;
     ProcessCategoryButtonTouch(1);
     AssignMenuKeyBoard;
    end;
 CategoryButtonClick(Sender);   
end;

procedure TMenuItemForm.CategorySetupButtonClick(Sender: TObject);
begin
 if CategoryForm.CategorySetup then
    begin
     OpenCategoryQuery;
     AssignCategoryKeyBoard;
     ProcessCategoryButtonTouch(1);
     AssignMenuKeyBoard;
     ReturnFlag := True;
    end;
end;

procedure TMenuItemForm.SearchComboBoxChange(Sender: TObject);
begin
 OpenQuery;
 AssignMenuKeyBoard;
end;

procedure TMenuItemForm.PrintBarcodeButtonClick(Sender: TObject);
begin
 BarcodeSetupForm.BarcodeSetupPro;
end;


procedure TMenuItemForm.MenuGroupButtonClick(Sender: TObject);
begin
 if MenuGroupSelectForm.MenuGroupSelectPro(MenuGroupCode, MenuGroupDescription) then
    begin
     MenuGroupDescriptionEdit.Caption := MenuGroupDescription;
     ShowComboBoxChange(Sender);
    end;
end;

procedure TMenuItemForm.ReArrangeButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
 ButtonPosition: integer;
begin
 if (MessageBoxForm.MessagePro('Are you sure you want to Re-Arrange Buttons Position?', sConfirmMsg) = mrNo) then Exit;
 ButtonPosition := 1;
 Flag := True;
 with Query do
  if Active and (RecordCount > 0) then
     try
      First;
      Flag := DataForm.BeginTransaction;
      while Not EOF and Flag do
       begin
        case ShowComboBox.ItemIndex of
         0: SQLStr := 'Update MenuItem Set MainPosition=' + IntToStr(ButtonPosition) +
                      ' Where ItemCode=' + Chr(39) + CheckQuotes(FieldByName('ItemCode').AsString) + Chr(39);
         1: SQLStr := 'Update MenuItem Set POSPosition=' + IntToStr(ButtonPosition) +
                      ' Where ItemCode=' + Chr(39) + CheckQuotes(FieldByName('ItemCode').AsString) + Chr(39);
         2: SQLStr := 'Update MenuItem Set PhoneOrderPosition=' + IntToStr(ButtonPosition) +
                      ' Where ItemCode=' + Chr(39) + CheckQuotes(FieldByName('ItemCode').AsString) + Chr(39);
        end;
        Flag := DataForm.ExecQueryPro(SQLStr);
        ButtonPosition := ButtonPosition + 1;
        Next;
       end;
     finally
      if Flag then
         begin
          DataForm.CommitTransaction;
          OpenQuery;
          AssignMenuKeyBoard;
         end
        else
         DataForm.Rollback;
     end;
end;

procedure TMenuItemForm.DBGridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
          Column: TColumn; State: TGridDrawState);
var
 X: integer;
 S: string;
begin
 with Sender As TDBGrid do
  begin
   if (Column.FieldName = 'ItemCode') or (Column.FieldName = 'Category') or
      (Column.FieldName = 'Description1') or (Column.FieldName = 'Description2') then
      begin
       SetTextAlign(Canvas.Handle, TA_LEFT);
       X := Rect.Left + 2;
       S := Column.Field.AsString;
      end
     else
      if (Column.FieldName = 'Control') or (Column.FieldName = 'Disc') then
         begin
          SetTextAlign(Canvas.Handle, TA_CENTER);
          X := (Rect.Left + Rect.Right) div 2;
          S := Column.Field.AsString;
         end
        else
         begin
          SetTextAlign(Canvas.Handle, TA_RIGHT);
          X := Rect.Right - 2;
          if (Column.FieldName = 'TaxRate') then
             S := Format('%4.2f', [Column.Field.AsFloat])
            else
             S := FormatCurrency(Column.Field.AsFloat)
      end;
   if State = [] then
      begin
       if Query.FieldByName('Instruction').AsBoolean then
          Canvas.Font.Color := clBlue
         else
          Canvas.Font.Color := clBlack;
      end;
    Canvas.TextRect(Rect, X, Rect.Top + 2, S);
  end;
end;

procedure TMenuItemForm.FormShow(Sender: TObject);
begin
 NewButton.Caption := 'New';
 EditButton.Caption := 'Edit';
 DeleteButton.Caption := 'Delete';
 InstructionButton.Caption := 'Instruction';
 SubMenuLinkButton.Caption := 'Menu' + Chr(13) + 'Link';
 StockLinkButton.Caption := 'Stock' + Chr(13) + 'Link';
 CategorySetupButton.Caption := 'Category' + Chr(13) + 'Setup';
 ItemGroupSetupButton.Caption := 'Group' + Chr(13) + 'Setup';
 ButtonLayoutButton.Caption := 'Button' + Chr(13) + 'Font';
 PrintButton.Caption := 'Print' + Chr(13) + 'Menu';
 PrintBarcodeButton.Caption := 'Print' + Chr(13) + 'Barcode';
 MenuGroupButton.Caption := 'Menu' + Chr(13) + 'Group';
 ReArrangeButton.Caption := 'Re-arrange' + Chr(13) + 'Button';
 ExitButton.Caption := 'Exit';
 ListCheckBox.Checked := False;
 InstructionCheckBox.Checked := True;
 MenuItemForm.ShowComboBoxChange(Sender);
 ReturnFlag := False;
 Top := 0;
 Left := 0;
 QueryPrice.DisplayFormat := sCurrency + ',0.#0';
 QueryPrice1.DisplayFormat := sCurrency + ',0.#0';
 QueryPrice2.DisplayFormat := sCurrency + ',0.#0';
 QueryPrice3.DisplayFormat := sCurrency + ',0.#0';
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
end;

procedure TMenuItemForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

function TMenuItemForm.MenuSetup(ShowButtonFlag: integer): boolean;
begin
 Application.CreateForm(TMenuItemForm, MenuItemForm);
 if DataForm.GetDefaultMenuGroup(MenuItemForm.MenuGroupCode, MenuItemForm.MenugroupDescription) then
    begin
     MenuItemForm.MenuGroupDescriptionEdit.Caption := MenuItemForm.MenugroupDescription;
     MenuItemForm.ShowComboBox.ItemIndex := ShowButtonFlag;
     MenuItemForm.ShowModal;
     Result := MenuItemForm.ReturnFlag;
    end
   else
    begin
     MessageBoxForm.MessagePro('Can not find default menu gourp.', sErrorMsg);
     Result := False;
    end;
 MenuItemForm.Free;
end;



end.
