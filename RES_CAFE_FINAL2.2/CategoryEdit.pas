unit CategoryEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, UtilUnit,
  jpeg, ADODB, bsSkinCtrls, BusinessSkinForm, bsSkinBoxCtrls, PanelButton,
  XiButton;

type
  TCategoryEditForm = class(TForm)
    ColorBox: TColorDialog;
    FontDialog: TFontDialog;
    Query: TADOQuery;
    SkinForm: TbsBusinessSkinForm;
    EditPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    CodeEdit: TbsSkinEdit;
    bsSkinStdLabel2: TbsSkinStdLabel;
    CategoryEdit: TbsSkinEdit;
    bsSkinStdLabel3: TbsSkinStdLabel;
    Category1Edit: TbsSkinEdit;
    bsSkinStdLabel4: TbsSkinStdLabel;
    MenuGroupDescriptionEdit: TbsSkinLabel;
    MainMenuCheckBox: TbsSkinCheckRadioBox;
    POSMenuCheckBox: TbsSkinCheckRadioBox;
    FontButton: TbsSkinButton;
    ColorButton: TbsSkinButton;
    MenuGroupCodeEdit: TbsSkinLabel;
    PanelButton: TPanelButton;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    PhoneOrderCheckBox: TbsSkinCheckRadioBox;
    DescriptionGroupBox1: TGroupBox;
    DescriptionGroupBox2: TGroupBox;
    PanelButton1: TPanelButton;
    ColorButton1: TbsSkinButton;
    FontButton1: TbsSkinButton;
    procedure OpenQuery;
    procedure InitEditPanel;
    function  UpgradeProductTable(OldCode, NewCode: string): boolean;
    function  TestCategory: boolean;
    function  TestCode: boolean;
    function  SaveCategory: Boolean;
    function  ProcessEditCode: Boolean;
    function  ProcessNewCode: Boolean;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  CategoryEditPro(var Category: string; OpFlag: integer): boolean;
    procedure CodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditDblClick(Sender: TObject);
    procedure CategoryEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonColorClick(Sender: TObject);
    procedure ColorButtonClick(Sender: TObject);
    procedure FontButtonClick(Sender: TObject);
    procedure Category1EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MenuGroupCodeEditClick(Sender: TObject);
    procedure ColorButton1Click(Sender: TObject);
    procedure FontButton1Click(Sender: TObject);
    procedure CategoryEditExit(Sender: TObject);
    procedure Category1EditExit(Sender: TObject);
  private { Private declarations }
   OpFlag: Integer;
   OldCode, OldCategory: String;
   ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
 CategoryEditForm: TCategoryEditForm;

implementation

uses DataUnit, Keyboard, MessageBox, MenuGroupSelect, MainMenu;

{$R *.DFM}

procedure TCategoryEditForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From Category, MenuGroupTable ' +
           'Where Category.MenuGroupCode=MenuGroupTable.Code and ' +
           'Category=' + Chr(39) + CheckQuotes(OldCategory) + Chr(39);
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

procedure TCategoryEditForm.InitEditPanel;
begin
 CodeEdit.Text := '';
 CategoryEdit.Text := '';
 Category1Edit.Text := '';
 MenuGroupCodeEdit.Caption := '';
 MenuGroupDescriptionEdit.Caption := '';
 MainMenuCheckBox.Checked := True;
 POSMenuCheckBox.Checked := True;
 PhoneOrderCheckBox.Checked := True;
 PanelButton.Caption := '';
 PanelButton.Color := clYellow;
 PanelButton.Font.Size := 8;
 PanelButton.Font.Name := 'MS Sans Serif';
 PanelButton.Font.Color := clBlack;
 PanelButton.Font.Style := [];
 PanelButton1.Caption := '';
 PanelButton1.Color := clYellow;
 PanelButton1.Font.Size := 8;
 PanelButton1.Font.Name := 'MS Sans Serif';
 PanelButton1.Font.Color := clBlack;
 PanelButton1.Font.Style := [];
end;

function TCategoryEditForm.UpgradeProductTable(OldCode, NewCode: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'UPDATE MenuItem Set Category=' + Chr(39) + CheckQuotes(NewCode) + Chr(39) +
           ' Where Category=' + Chr(39) + CheckQuotes(OldCode) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TCategoryEditForm.TestCategory: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select Count(*) From Category where Category = ' +
           Chr(39) + CheckQuotes(CategoryEdit.Text) + Chr(39);
 Result := DataForm.CheckCodeSQLPro(SQLStr) <> 0;
end;

function TCategoryEditForm.TestCode: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select Count(*) From Category where Code = ' +
           Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39);
 Result := DataForm.CheckCodeSQLPro(SQLStr) <> 0;
end;

function TCategoryEditForm.SaveCategory: Boolean;
var
 SQLStr, ButtonColor, FontColor, FontName, FontSize, FontBold,
 FontItalic, FontUnderline, FontStrikeout, ButtonColor1, FontColor1,
 FontName1, FontSize1, FontBold1, FontItalic1, FontUnderline1,
 FontStrikeout1, ShowOnMainMenu, ShowOnPOSMenu, ShowOnPhoneOrderMenu,
 Category1, MenuGroupCode: string;
begin
 ButtonColor := IntToStr(PanelButton.Color);
 FontColor := IntToStr(PanelButton.Font.Color);
 FontName := Chr(39) + CheckQuotes(PanelButton.Font.Name) + Chr(39);
 FontSize := IntToStr(PanelButton.Font.Size);
 if fsBold in PanelButton.Font.Style then
    FontBold := '1'
   else
    FontBold := '0';
 if fsItalic in PanelButton.Font.Style then
    FontItalic := '1'
   else
    FontItalic := '0';
 if fsUnderline in PanelButton.Font.Style then
    FontUnderline := '1'
   else
    FontUnderline := '0';
 if fsStrikeout in PanelButton.Font.Style then
    FontStrikeout := '1'
   else
    FontStrikeout := '0';

 ButtonColor1 := IntToStr(PanelButton1.Color);
 FontColor1 := IntToStr(PanelButton1.Font.Color);
 FontName1 := Chr(39) + CheckQuotes(PanelButton1.Font.Name) + Chr(39);
 FontSize1 := IntToStr(PanelButton1.Font.Size);
 if fsBold in PanelButton1.Font.Style then
    FontBold1 := '1'
   else
    FontBold1 := '0';
 if fsItalic in PanelButton1.Font.Style then
    FontItalic1 := '1'
   else
    FontItalic1 := '0';
 if fsUnderline in PanelButton1.Font.Style then
    FontUnderline1 := '1'
   else
    FontUnderline1 := '0';
 if fsStrikeout in PanelButton1.Font.Style then
    FontStrikeout1 := '1'
   else
    FontStrikeout1 := '0';

 if MainMenuCheckBox.Checked then
    ShowOnMainMenu := '1'
   else
    ShowOnMainMenu := '0';
 if POSMenuCheckBox.Checked then
    ShowOnPOSMenu := '1'
   else
    ShowOnPOSMenu := '0';
 if PhoneOrderCheckBox.Checked then
    ShowOnPhoneOrderMenu := '1'
   else
    ShowOnPhoneOrderMenu := '0';
 if Category1Edit.Text <> '' then
    Category1 := Chr(39) + CheckQuotes(Category1Edit.Text) + Chr(39)
   else
    Category1 := 'Null';
 MenuGroupCode := Chr(39) + CheckQuotes(MenuGroupCodeEdit.Caption) + Chr(39);
 SQLStr := 'INSERT INTO Category(Code, Category, ButtonColor, ' +
           'FontName, FontColor, FontSize, FontBold, FontItalic, ' +
           'FontUnderline, FontStrikeout, ButtonColor1, FontName1, ' +
           'FontColor1, FontSize1, FontBold1, FontItalic1, ' +
           'FontUnderline1, FontStrikeout1, ShowOnMainMenu, ShowOnPOSMenu, ' +
           'ShowOnPhoneOrderMenu, Category1, MenuGroupCode) ' +
           'VALUES(' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39) + ',' +
           Chr(39) + CheckQuotes(CategoryEdit.Text) + Chr(39) + ',' +
           ButtonColor + ',' + FontName + ',' + FontColor + ',' +
           FontSize + ',' + FontBold + ',' + FontItalic + ',' +
           FontUnderline + ',' + FontStrikeout + ',' + ButtonColor1 + ',' +
           FontName1 + ',' + FontColor1 + ',' + FontSize1 + ',' +
           FontBold1 + ',' + FontItalic1 + ',' + FontUnderline1 + ',' +
           FontStrikeout1 + ',' + ShowOnMainMenu + ',' + ShowOnPOSMenu + ',' +
           ShowOnPhoneOrderMenu + ',' + Category1 + ',' + MenuGroupCode + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TCategoryEditForm.ProcessEditCode: Boolean;
begin
 Result := True;
 if (OldCategory <> CategoryEdit.Text) or (OldCode <> CodeEdit.Text) then
    begin
     if (OldCategory <> CategoryEdit.Text) and TestCategory and
        (MessageBoxForm.MessagePro(CategoryEdit.Text + ' is already exist.' +
        Chr(13) + Chr(10) + Chr(13) + Chr(10) + 'Do you want to replace?', sConfirmMsg) = mrNo) then
        begin
         Result := False;
         Exit;
        end;
     if (OldCode <> CodeEdit.Text) and TestCode and
        (MessageBoxForm.MessagePro(CodeEdit.Text + ' is already exist.' +
        Chr(13) + Chr(10) + 'Do you want to replace?', sConfirmMsg) = mrNo) then
        begin
         Result := False;
         Exit;
        end;
     Result := UpgradeProductTable(OldCategory, CategoryEdit.Text);
     if Result then
        Result := DataForm.ExecQueryPro('Delete From Category Where Category=' + Chr(39) + CheckQuotes(CategoryEdit.Text) + Chr(39));
    end;
  if Result then
     Result := DataForm.ExecQueryPro('Delete From Category Where Category=' + Chr(39) + CheckQuotes(OldCategory) + Chr(39));
  if Result then Result := SaveCategory;
end;

function TCategoryEditForm.ProcessNewCode: boolean;
begin
 if TestCategory then
     begin
     MessageBoxForm.MessagePro(CategoryEdit.Text + ' is already exist.', sErrorMsg);
     Result := False;
     Exit;
    end;
 if TestCode then
    begin
     MessageBoxForm.MessagePro(CodeEdit.Text + ' is already exist.', sErrorMsg);
     Result := False;
     Exit;
    end;
 Result := SaveCategory;
end;

procedure TCategoryEditForm.ConfirmButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 if (CodeEdit.Text = '') or (CategoryEdit.Text = '') or (MenuGroupCodeEdit.Caption = '') then
    begin
     MessageBoxForm.MessagePro('Some fields are invalid!', sErrorMsg);
     Exit;
    end;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  if OpFlag = sNewStatus then
     Flag := ProcessNewCode
    else
     Flag := ProcessEditCode;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      ReturnFlag := True;
      Close;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TCategoryEditForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TCategoryEditForm.CodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then CategoryEdit.SetFocus;
end;

procedure TCategoryEditForm.CategoryEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then Category1Edit.SetFocus;
end;

procedure TCategoryEditForm.Category1EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ConfirmButton.SetFocus;
end;

procedure TCategoryEditForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close
end;

procedure TCategoryEditForm.MenuGroupCodeEditClick(Sender: TObject);
var
 MenuGroupCode, MenuGroupDescription: string;
begin
 if MenuGroupSelectForm.MenuGroupSelectPro(MenuGroupCode, MenuGroupDescription) then
    begin
     MenuGroupCodeEdit.Caption := MenuGroupCode;
     MenuGroupDescriptionEdit.Caption := MenuGroupDescription;
    end;
end;

procedure TCategoryEditForm.ColorButtonClick(Sender: TObject);
begin
 ColorBox.Color := PanelButton.Color;
 if ColorBox.Execute then
    PanelButton.Color := ColorBox.Color;
end;

procedure TCategoryEditForm.FontButtonClick(Sender: TObject);
begin
 FontDialog.Font := PanelButton.Font;
 if FontDialog.Execute then
    PanelButton.Font := FontDialog.Font;
end;

procedure TCategoryEditForm.ColorButton1Click(Sender: TObject);
begin
 ColorBox.Color := PanelButton1.Color;
 if ColorBox.Execute then
    PanelButton1.Color := ColorBox.Color;
end;

procedure TCategoryEditForm.FontButton1Click(Sender: TObject);
begin
 FontDialog.Font := PanelButton1.Font;
 if FontDialog.Execute then
    PanelButton1.Font := FontDialog.Font;
end;

procedure TCategoryEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TCategoryEditForm.CategoryEditExit(Sender: TObject);
begin
 PanelButton.Caption := CopyDescription(CategoryEdit.Text);
end;

procedure TCategoryEditForm.Category1EditExit(Sender: TObject);
begin
 PanelButton1.Caption := CopyDescription(Category1Edit.Text);
end;

procedure TCategoryEditForm.FormShow(Sender: TObject);
begin
 Width := EditPanel.Width + 28;
 Height := ConfirmButton.Top + 86;
 if OpFlag = sEditStatus then
    begin
     OpenQuery;
     with Query do
      begin
       OldCode := FieldByName('Code').AsString;
       CodeEdit.Text := OldCode;
       CategoryEdit.Text := OldCategory;
       Category1Edit.Text := FieldByName('Category1').AsString;
       MenuGroupCodeEdit.Caption := FieldByName('MenuGroupCode').AsString;
       MenuGroupDescriptionEdit.Caption := FieldByName('Description').AsString;
       MainMenuCheckBox.Checked := FieldByName('ShowOnMainMenu').AsBoolean;
       POSMenuCheckBox.Checked := FieldByName('ShowOnPOSMenu').AsBoolean;
       PhoneOrderCheckBox.Checked := FieldByName('ShowOnPhoneOrderMenu').AsBoolean;
       PanelButton.Caption := CopyDescription(CategoryEdit.Text);
       PanelButton.Color := FieldByName('ButtonColor').AsInteger;
       PanelButton.Font.Size := FieldByName('FontSize').AsInteger;;
       PanelButton.Font.Name := FieldByName('FontName').AsString;
       PanelButton.Font.Color := FieldByName('FontColor').AsInteger;
       PanelButton.Font.Style := [];
       if FieldByName('FontBold').AsBoolean then
          PanelButton.Font.Style := PanelButton.Font.Style + [fsBold];
       if FieldByName('FontItalic').AsBoolean then
          PanelButton.Font.Style := PanelButton.Font.Style + [fsItalic];
       if FieldByName('FontUnderline').AsBoolean then
          PanelButton.Font.Style := PanelButton.Font.Style + [fsUnderline];
       if FieldByName('FontStrikeout').AsBoolean then
          PanelButton.Font.Style := PanelButton.Font.Style + [fsStrikeout];
       PanelButton1.Caption := CopyDescription(Category1Edit.Text);
       PanelButton1.Color := FieldByName('ButtonColor1').AsInteger;
       PanelButton1.Font.Size := FieldByName('FontSize1').AsInteger;;
       PanelButton1.Font.Name := FieldByName('FontName1').AsString;
       PanelButton1.Font.Color := FieldByName('FontColor1').AsInteger;
       PanelButton1.Font.Style := [];
       if FieldByName('FontBold1').AsBoolean then
          PanelButton1.Font.Style := PanelButton1.Font.Style + [fsBold];
       if FieldByName('FontItalic1').AsBoolean then
          PanelButton1.Font.Style := PanelButton1.Font.Style + [fsItalic];
       if FieldByName('FontUnderline1').AsBoolean then
          PanelButton1.Font.Style := PanelButton1.Font.Style + [fsUnderline];
       if FieldByName('FontStrikeout1').AsBoolean then
          PanelButton1.Font.Style := PanelButton1.Font.Style + [fsStrikeout];
       Close;
      end;
    end
   else
    InitEditPanel;
end;

procedure TCategoryEditForm.EditDblClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    with Sender As TbsSkinEdit do
     Text := UpperCase(Str);
end;

procedure TCategoryEditForm.ButtonColorClick(Sender: TObject);
begin
 if ColorBox.Execute then
    PanelButton.Color := ColorBox.Color;
end;

function TCategoryEditForm.CategoryEditPro(var Category: string; OpFlag: integer): boolean;
begin
 Application.CreateForm(TCategoryEditForm, CategoryEditForm);
 CategoryEditForm.OpFlag := OpFlag;
 CategoryEditForm.OldCategory := Category;
 CategoryEditForm.ShowModal;
 Result := CategoryEditForm.ReturnFlag;
 if Result then
    Category := CategoryEditForm.CategoryEdit.Text;
 CategoryEditForm.Free;
end;

end.
