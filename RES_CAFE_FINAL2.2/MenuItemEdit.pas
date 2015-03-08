unit MenuItemEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, DB, Grids, DBGrids, UtilUnit,
  ExtDlgs, ADODB, ComCtrls, TabNotBk, MainMenu, BusinessSkinForm,
  bsSkinCtrls, bsSkinTabs, XiButton, PanelButton;

type
  TMenuItemEditForm = class(TForm)
    EditPanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    CodeEdit: TEdit;
    DescriptionEdit1: TEdit;
    TaxRateEdit: TEdit;
    Label11: TLabel;
    ActiveCheckBox: TCheckBox;
    DescriptionEdit2: TEdit;
    Label4: TLabel;
    PrinterPortComboBox: TComboBox;
    DataSource: TDataSource;
    InstructionCheckBox: TCheckBox;
    DiscountCheckBox: TCheckBox;
    MultiCheckBox: TCheckBox;
    MultiPanel: TPanel;
    Label7: TLabel;
    PriceEdit1: TEdit;
    Label10: TLabel;
    SubEdit1: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    PriceEdit2: TEdit;
    SubEdit2: TEdit;
    PriceEdit3: TEdit;
    Label14: TLabel;
    SubEdit3: TEdit;
    PriceEdit: TEdit;
    Label5: TLabel;
    SubEdit: TEdit;
    Label17: TLabel;
    BarCodeEdit: TEdit;
    BarCodeEdit1: TEdit;
    BarCodeEdit2: TEdit;
    BarCodeEdit3: TEdit;
    ColorBox: TColorDialog;
    ButtonSetPanel: TPanel;
    FontDialog: TFontDialog;
    JobListColorComboBox: TComboBox;
    OpenPriceCheckBox: TCheckBox;
    OpenDialog: TOpenDialog;
    PrinterPortComboBox1: TComboBox;
    PrinterPortComboBox2: TComboBox;
    Query: TADOQuery;
    CategoryQuery: TADOQuery;
    Label18: TLabel;
    HappyHourPriceEdit1: TEdit;
    HappyHourPriceEdit2: TEdit;
    HappyHourPriceEdit3: TEdit;
    HappyHourPriceEdit4: TEdit;
    CategoryLabel: TLabel;
    Label19: TLabel;
    DefaultQtyEdit: TEdit;
    IngredientsGroupBox: TGroupBox;
    IngredientsEdit: TMemo;
    SubDescriptionSwapCheckBox: TCheckBox;
    KitchenScreenFontColorPanel: TPanel;
    PrinterPortComboBox3: TComboBox;
    OnlyShowOnSubMenuCheckBox: TCheckBox;
    Label21: TLabel;
    ItemGroupComboBox: TComboBox;
    CategoryComboBox: TComboBox;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    PageControl: TbsSkinPageControl;
    GeneralPage1: TbsSkinTabSheet;
    ButtonPage1: TbsSkinTabSheet;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinPanel2: TbsSkinPanel;
    ColorButton: TbsSkinButton;
    FontButton: TbsSkinButton;
    KitchenScreenFontColorButton: TbsSkinButton;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    MenuButton: TPanelButton;
    CategoryButton: TPanelButton;
    DescriptionButton1GroupBox: TGroupBox;
    DescriptionButton2GroupBox: TGroupBox;
    MenuButton1: TPanelButton;
    FontButton1: TbsSkinButton;
    ColorButton1: TbsSkinButton;
    AutoPopSpellInstructionKeyboardCheckBox: TCheckBox;
    KitchenScreenComboBox1: TComboBox;
    KitchenScreenComboBox2: TComboBox;
    KitchenScreenComboBox3: TComboBox;
    KitchenScreenComboBox4: TComboBox;
    KitchenPrintGroupBox: TGroupBox;
    KitchenScreenGroupBox: TGroupBox;
    AutoPopQuantityKeyboard: TCheckBox;
    ScalableChk: TCheckBox;
    procedure InitForm;
    procedure OpenCategoryQuery;
    procedure OpenItemGroupQuery;
    procedure ReadCategory;
    procedure ReadItemGroup;
    procedure OpenQuery(SQLStr: string);
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  UpdateOtherTable(OldCode, NewCode: string): boolean;
    procedure CreateNewButtonPosition(var MainPosition, POSPosition, PhoneOrderPosition: integer);
    function  ProcessEditCode: Boolean;
    function  ProcessNewCode: Boolean;
    function  AppendNewItem: boolean;
    function  SaveIngredientsRecord: boolean;
    function  CheckBarcode: boolean;
    procedure SaveButtonClick(Sender: TObject);
    procedure CodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DescriptionEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PriceEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TaxRateEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TaxRateEditEnter(Sender: TObject);
    procedure TaxRateEditExit(Sender: TObject);
    procedure CategoryComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CodeEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DescriptionEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PrinterPortComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure InstructionCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ActiveCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DiscountCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MultiCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PriceEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PriceEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PriceEdit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SubEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SubEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SubEdit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BarCodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PriceEditEnter(Sender: TObject);
    procedure PriceEditExit(Sender: TObject);
    procedure SubEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BarCodeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BarCodeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BarCodeEdit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditDBlClick(Sender: TObject);
    procedure NumberEditClick(Sender: TObject);
    procedure TaxRateEditClick(Sender: TObject);
    procedure ColorButtonClick(Sender: TObject);
    procedure FontButtonClick(Sender: TObject);
    procedure DescriptionEdit2Exit(Sender: TObject);
    procedure DescriptionEdit1Exit(Sender: TObject);
    procedure PrinterPortComboBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PrinterPortComboBox2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HappyHourPriceEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HappyHourPriceEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HappyHourPriceEdit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HappyHourPriceEdit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DefaultQtyEditDblClick(Sender: TObject);
    procedure DefaultQtyEditEnter(Sender: TObject);
    procedure DefaultQtyEditExit(Sender: TObject);
    procedure DefaultQtyEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OpenPriceCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  MenuItemEditPro(var Code: string; Category: string; OpFlag: Integer): boolean;
    procedure KitchenScreenCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KitchenScreenFontColorButtonClick(Sender: TObject);
    procedure PrinterPortComboBox3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OnlyShowOnSubMenuCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ItemGroupComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure JobListColorComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SubDescriptionSwapCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CategoryComboBoxChange(Sender: TObject);
    procedure FontButton1Click(Sender: TObject);
    procedure ColorButton1Click(Sender: TObject);
    procedure KitchenScreenComboBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KitchenScreenComboBox2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KitchenScreenComboBox3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KitchenScreenComboBox4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AutoPopSpellInstructionKeyboardCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private { Private declarations }
   OldCode, Code, Category: string;
   OpFlag, POSPosition, MainPosition, PhoneOrderPosition: integer;
   ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
 MenuItemEditForm: TMenuItemEditForm;

implementation

uses DataUnit, MenuSetup, Keyboard, NumPad, MessageBox;


{$R *.DFM}

procedure TMenuItemEditForm.InitForm;
begin
 CodeEdit.Text := '';
 DescriptionEdit1.Text := '';
 DescriptionEdit2.Text := '';
 PriceEdit.Text := Format('%12.2f', [0.0]);
 TaxRateEdit.Text := Format('%10.2f', [DefaultGSTRate]);
 PriceEdit1.Text := Format('%12.2f', [0.0]);
 PriceEdit2.Text := Format('%12.2f', [0.0]);
 PriceEdit3.Text := Format('%12.2f', [0.0]);
 HappyHourPriceEdit1.Text := Format('%12.2f', [0.0]);
 HappyHourPriceEdit2.Text := Format('%12.2f', [0.0]);
 HappyHourPriceEdit3.Text := Format('%12.2f', [0.0]);
 HappyHourPriceEdit4.Text := Format('%12.2f', [0.0]);
 SubEdit.Text := '';
 SubEdit1.Text := '';
 SubEdit2.Text := '';
 SubEdit3.Text := '';
 BarCodeEdit.Text := '';
 BarCodeEdit1.Text := '';
 BarCodeEdit2.Text := '';
 BarCodeEdit3.Text := '';
 ActiveCheckBox.Checked := True;
 OnlyShowOnSubMenuCheckBox.Checked := False;
 OpenPriceCheckBox.Checked := True;
 DiscountCheckBox.Checked := True;
 InstructionCheckBox.Checked := False;
 MultiCheckBox.Checked := False;
 AutoPopSpellInstructionKeyboardCheckBox.Checked := False;
 PrinterPortComboBox.ItemIndex := 1;
 PrinterPortComboBox1.ItemIndex := 0;
 PrinterPortComboBox2.ItemIndex := 0;
 PrinterPortComboBox3.ItemIndex := 0;
 KitchenScreenComboBox1.ItemIndex := 0;
 KitchenScreenComboBox2.ItemIndex := 0;
 KitchenScreenComboBox3.ItemIndex := 0;
 KitchenScreenComboBox4.ItemIndex := 0;
 CategoryComboBox.Text := '';
 ItemGroupComboBox.Text := '';

 MenuButton.Caption := '';
 MenuButton.Color := clLime;
 MenuButton.Font.Size := 8;
 MenuButton.Font.Name := 'MS Sans Serif';
 MenuButton.Font.Color := clBlack;
 MenuButton.Font.Style := [fsBold];

 MenuButton1.Caption := '';
 MenuButton1.Color := clLime;
 MenuButton1.Font.Size := 8;
 MenuButton1.Font.Name := 'MS Sans Serif';
 MenuButton1.Font.Color := clBlack;
 MenuButton1.Font.Style := [fsBold];

 JobListColorComboBox.ItemIndex := 0;
 DefaultQtyEdit.Text := Format('%10.2f', [1.0]);
 IngredientsEdit.Text := '';
 KitchenScreenFontColorPanel.Font.Color := clWhite;
 SubDescriptionSwapCheckBox.Checked := False;
end;

function TMenuItemEditForm.AppendNewItem: boolean;
var
 SQLStr, ItemCode, CategoryStr, Description1, Description2, TaxRate, Price,
 Active, PrinterPort1, PrinterPort2, PrinterPort3, PrinterPort4,
 Instruction, AllowDiscount, Price1, Price2, Price3, HappyHourPrice1,
 HappyHourPrice2, HappyHourPrice3, HappyHourPrice4, SubDescription, SubDescription1,
 SubDescription2, SubDescription3, Multiple, BarCode, BarCode1, BarCode2, BarCode3,
 ButtonColor, FontColor, FontName, FontSize, FontBold, FontItalic, FontUnderline,
 FontStrikeout, ButtonColor1, FontColor1, FontName1, FontSize1, FontBold1, FontItalic1,
 FontUnderline1, FontStrikeout1, JobListColor, OpenPrice, DefaultQty, SubDescriptionSwap,
 KitchenScreenFontColor, OnlyShowOnSubMenu, ItemGroup, AutoPopSpellInstructionKeyboardTemp,
 KitchenScreen1, KitchenScreen2, KitchenScreen3, KitchenScreen4,AutoPopQuantityKeyboardTemp,
 ScalableTemp: widestring;
begin
 ItemCode := Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39);

 if CategoryComboBox.Text <> '' then
    CategoryStr := Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39)
   else
    CategoryStr := 'Null';
 if ItemGroupComboBox.Text <> '' then
    ItemGroup := Chr(39) + CheckQuotes(ItemGroupComboBox.Text) + Chr(39)
   else
    ItemGroup := 'Null';
 Description1 := Chr(39) + CheckQuotes(DescriptionEdit1.Text) + Chr(39);
 if DescriptionEdit2.Text <> '' then
    Description2 := Chr(39) + CheckQuotes(DescriptionEdit2.Text) + Chr(39)
   else
    Description2 := 'Null';
 Price := Format('%4.2f', [StrToFloat(PriceEdit.Text)]);
 Price1 := Format('%4.2f', [StrToFloat(PriceEdit1.Text)]);
 Price2 := Format('%4.2f', [StrToFloat(PriceEdit2.Text)]);
 Price3 := Format('%4.2f', [StrToFloat(PriceEdit3.Text)]);

 HappyHourPrice1 := Format('%4.2f', [StrToFloat(HappyHourPriceEdit1.Text)]);
 HappyHourPrice2 := Format('%4.2f', [StrToFloat(HappyHourPriceEdit2.Text)]);
 HappyHourPrice3 := Format('%4.2f', [StrToFloat(HappyHourPriceEdit3.Text)]);
 HappyHourPrice4 := Format('%4.2f', [StrToFloat(HappyHourPriceEdit4.Text)]);

 TaxRate := Format('%4.2f', [StrToFloat(TaxRateEdit.Text)]);
 PrinterPort1 := IntToStr(PrinterPortComboBox.ItemIndex);
 PrinterPort2 := IntToStr(PrinterPortComboBox1.ItemIndex);
 PrinterPort3 := IntToStr(PrinterPortComboBox2.ItemIndex);
 PrinterPort4 := IntToStr(PrinterPortComboBox3.ItemIndex);
 KitchenScreen1 := IntToStr(KitchenScreenComboBox1.ItemIndex);
 KitchenScreen2 := IntToStr(KitchenScreenComboBox2.ItemIndex);
 KitchenScreen3 := IntToStr(KitchenScreenComboBox3.ItemIndex);
 KitchenScreen4 := IntToStr(KitchenScreenComboBox4.ItemIndex);

 DefaultQty := Format('%4.2f', [StrToFloat(DefaultQtyEdit.Text)]);
 if ScalableChk.Checked then
    ScalableTemp := '1'
   else
    ScalableTemp :='0';
 if ActiveCheckBox.Checked then
    Active := '1'
   else
    Active := '0';
 if InstructionCheckBox.Checked then
    Instruction := '1'
   else
    Instruction := '0';
 if DiscountCheckBox.Checked then
    AllowDiscount := '1'
   else
    AllowDiscount := '0';
 if MultiCheckBox.Checked then
    Multiple := '1'
   else
    Multiple := '0';
 if SubEdit.Text <> '' then
    SubDescription := Chr(39) + CheckQuotes(SubEdit.Text) + Chr(39)
   else
    SubDescription := 'Null';
 if SubEdit1.Text <> '' then
    SubDescription1 := Chr(39) + CheckQuotes(SubEdit1.Text) + Chr(39)
   else
    SubDescription1 := 'Null';
 if SubEdit2.Text <> '' then
    SubDescription2 := Chr(39) + CheckQuotes(SubEdit2.Text) + Chr(39)
   else
    SubDescription2 := 'Null';
 if SubEdit3.Text <> '' then
    SubDescription3 := Chr(39) + CheckQuotes(SubEdit3.Text) + Chr(39)
   else
    SubDescription3 := 'Null';
 if BarCodeEdit.Text <> '' then
    BarCode := Chr(39) + CheckQuotes(BarCodeEdit.Text) + Chr(39)
   else
    BarCode := 'Null';
 if BarCodeEdit1.Text <> '' then
    BarCode1 := Chr(39) + CheckQuotes(BarCodeEdit1.Text) + Chr(39)
   else
    BarCode1 := 'Null';
 if BarCodeEdit2.Text <> '' then
    BarCode2 := Chr(39) + CheckQuotes(BarCodeEdit2.Text) + Chr(39)
   else
    BarCode2 := 'Null';
 if BarCodeEdit3.Text <> '' then
    BarCode3 := Chr(39) + CheckQuotes(BarCodeEdit3.Text) + Chr(39)
   else
    BarCode3 := 'Null';
 ButtonColor := IntToStr(MenuButton.Color);
 FontColor := IntToStr(MenuButton.Font.Color);
 FontName := Chr(39) + CheckQuotes(MenuButton.Font.Name) + Chr(39);
 FontSize := IntToStr(MenuButton.Font.Size);
 if fsBold in MenuButton.Font.Style then
    FontBold := '1'
   else
    FontBold := '0';
 if fsItalic in MenuButton.Font.Style then
    FontItalic := '1'
   else
    FontItalic := '0';
 if fsUnderline in MenuButton.Font.Style then
    FontUnderline := '1'
   else
    FontUnderline := '0';
 if fsStrikeout in MenuButton.Font.Style then
    FontStrikeout := '1'
   else
    FontStrikeout := '0';

 ButtonColor1 := IntToStr(MenuButton1.Color);
 FontColor1 := IntToStr(MenuButton1.Font.Color);
 FontName1 := Chr(39) + CheckQuotes(MenuButton1.Font.Name) + Chr(39);
 FontSize1 := IntToStr(MenuButton1.Font.Size);
 if fsBold in MenuButton1.Font.Style then
    FontBold1 := '1'
   else
    FontBold1 := '0';
 if fsItalic in MenuButton1.Font.Style then
    FontItalic1 := '1'
   else
    FontItalic1 := '0';
 if fsUnderline in MenuButton1.Font.Style then
    FontUnderline1 := '1'
   else
    FontUnderline1 := '0';
 if fsStrikeout in MenuButton1.Font.Style then
    FontStrikeout1 := '1'
   else
    FontStrikeout1 := '0';

 if OpenPriceCheckBox.Checked then
    OpenPrice := '1'
   else
    OpenPrice := '0';
 if SubDescriptionSwapCheckBox.Checked then
    SubDescriptionSwap := '1'
   else
    SubDescriptionSwap := '0';
 if OnlyShowOnSubMenuCheckBox.Checked then
    OnlyShowOnSubMenu := '1'
   else
    OnlyShowOnSubMenu := '0';
 JobListColor := IntToStr(JobListColorComboBox.ItemIndex);
 KitchenScreenFontColor := IntToStr(KitchenScreenFontColorPanel.Font.Color);
 if AutoPopSpellInstructionKeyboardCheckBox.Checked then
    AutoPopSpellInstructionKeyboardTemp := '1'
   else
    AutoPopSpellInstructionKeyboardTemp := '0';
 //if AutoPopQuantityKeyboard.Checked then
    //AutoPopQuantityKeyboardTemp := '1'
   //else
    //AutoPopQuantityKeyboardTemp := '0';

 SQLStr := 'INSERT INTO MenuItem(ItemCode, Category, Description1, Description2, ' +
           'Price, TaxRate, Active, PrinterPort, PrinterPort1, PrinterPort2, ' +
           'PrinterPort3, Instruction, AllowDiscount, Multiple, Price1, Price2, ' +
           'Price3, HappyHourPrice1, HappyHourPrice2, HappyHourPrice3, ' +
           'HappyHourPrice4, SubDescription, SubDescription1, SubDescription2, ' +
           'SubDescription3, BarCode, BarCode1, BarCode2, BarCode3, ButtonColor, ' +
           'FontName, FontColor, FontSize, FontBold, FontItalic, FontUnderline, ' +
           'FontStrikeout, ButtonColor1, FontName1, FontColor1, FontSize1, FontBold1, ' +
           'FontItalic1, FontUnderline1, FontStrikeout1, JobListColor, OpenPrice, DefaultQty, ' +
           'POSPosition, MainPosition, PhoneOrderPosition, SubDescriptionSwap, ' +
           'KitchenScreenFontColor, OnlyShowOnSubMenu, ItemGroup, ' +
           'AutoPopSpellInstructionKeyboard, KitchenScreen1, KitchenScreen2, ' +
           'KitchenScreen3, KitchenScreen4,Scalable) ' +
           'VALUES(' + ItemCode + ',' + CategoryStr + ',' + Description1 + ',' +
           Description2 + ',' + Price + ',' + TaxRate + ',' + Active + ',' +
           PrinterPort1 + ',' + PrinterPort2 + ',' + PrinterPort3 + ',' +
           PrinterPort4 + ',' + Instruction + ',' + AllowDiscount + ',' +
           Multiple + ',' + Price1 + ',' + Price2 + ',' + Price3 + ',' +
           HappyHourPrice1 + ',' + HappyHourPrice2 + ',' + HappyHourPrice3 + ',' +
           HappyHourPrice4 + ',' + SubDescription + ',' + SubDescription1 + ',' +
           SubDescription2 + ',' + SubDescription3 + ',' + BarCode + ',' +
           BarCode1 + ',' + BarCode2 + ',' + BarCode3 + ',' + ButtonColor + ',' +
           FontName + ',' + FontColor + ',' + FontSize + ',' + FontBold + ',' +
           FontItalic + ',' + FontUnderline + ',' + FontStrikeout + ',' +
           ButtonColor1 + ',' + FontName1 + ',' + FontColor1 + ',' + FontSize1 + ',' +
           FontBold1 + ',' + FontItalic1 + ',' + FontUnderline1 + ',' + FontStrikeout1 + ',' +
           JobListColor + ',' + OpenPrice + ',' + DefaultQty + ',' + IntToStr(POSPosition) + ',' +
           IntToStr(MainPosition) + ',' + IntToStr(PhoneOrderPosition) + ',' +
           SubDescriptionSwap + ',' + KitchenScreenFontColor + ',' + OnlyShowOnSubMenu + ',' +
           ItemGroup + ',' + AutoPopSpellInstructionKeyboardTemp + ',' + KitchenScreen1 + ',' +
           KitchenScreen2 + ',' + KitchenScreen3 + ',' + KitchenScreen4 + ',' + ScalableTemp+ ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TMenuItemEditForm.SaveIngredientsRecord: boolean;
var
 SQLStr, ItemCode, Ingredients: string;
begin
 Result := True;
 if IngredientsEdit.Text <> '' then
    begin
     ItemCode := Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39);
     Ingredients := Chr(39) + CheckQuotes(IngredientsEdit.Text) + Chr(39);
     SQLStr := 'Insert Into IngredientsTable(ItemCode, Ingredients) ' +
               'Values(' + ItemCode + ',' + Ingredients + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

function TMenuItemEditForm.UpdateOtherTable(OldCode, NewCode: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Update OrderI Set ItemCode=' + Chr(39) + CheckQuotes(NewCode) + Chr(39) +
           ' Where ItemCode=' + Chr(39) + CheckQuotes(OldCode) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Update StockLinkTable Set ItemCode=' + Chr(39) + CheckQuotes(NewCode) + Chr(39) +
               ' Where ItemCode=' + Chr(39) + CheckQuotes(OldCode) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Update InstructionLink Set ItemCode=' + Chr(39) + CheckQuotes(NewCode) + Chr(39) +
               ' Where ItemCode=' + Chr(39) + CheckQuotes(OldCode) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Update SubMenuLinkHead Set ItemCode=' + Chr(39) + CheckQuotes(NewCode) + Chr(39) +
               ' Where ItemCode=' + Chr(39) + CheckQuotes(OldCode) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Update SubMenuLinkDetail Set ItemCode=' + Chr(39) + CheckQuotes(NewCode) + Chr(39) +
               ' Where ItemCode=' + Chr(39) + CheckQuotes(OldCode) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    begin
     SQLStr := 'Update SubMenuLinkDetail Set SubMenuCode=' + Chr(39) + CheckQuotes(NewCode) + Chr(39) +
               ' Where SubMenuCode=' + Chr(39) + CheckQuotes(OldCode) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

procedure TMenuItemEditForm.OpenCategoryQuery;
begin
 OpenQuery('Select * From Category Order By Code');
end;

procedure TMenuItemEditForm.OpenItemGroupQuery;
begin
 OpenQuery('Select * From ItemGroupTable Order By GroupName');
end;

procedure TMenuItemEditForm.ReadCategory;
begin
 CategoryComboBox.Items.Clear;
 OpenCategoryQuery;
 with Query do
  begin
   while Not EOF do
    begin
     CategoryComboBox.Items.Add(FieldByName('Category').AsString);
     Next;
    end;
   Close;
  end;
 if (CategoryComboBox.Items.Count > 0) and (Category <> '') then
    CategoryComboBox.ItemIndex := SearchString(CategoryComboBox.Items, Category)
   else
    CategoryComboBox.ItemIndex := 0;
end;

procedure TMenuItemEditForm.ReadItemGroup;
begin
 ItemGroupComboBox.Items.Clear;
 OpenItemGroupQuery;
 with Query do
  begin
   while Not EOF do
    begin
     ItemGroupComboBox.Items.Add(FieldByName('GroupName').AsString);
     Next;
    end;
   Close;
  end;
 ItemGroupComboBox.ItemIndex := 0;
end;

procedure TMenuItemEditForm.OpenQuery(SQLStr: string);
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

procedure TMenuItemEditForm.CodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DescriptionEdit1.SetFocus;
end;

procedure TMenuItemEditForm.CodeEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key In ['a'..'z'] then Key := UpCase(Key);
end;

procedure TMenuItemEditForm.DescriptionEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DescriptionEdit2.SetFocus;
end;

procedure TMenuItemEditForm.DescriptionEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then CategoryComboBox.SetFocus;
end;

procedure TMenuItemEditForm.DescriptionEdit2Exit(Sender: TObject);
begin
 MenuButton1.Caption := CopyDescription(DescriptionEdit2.Text);
end;

procedure TMenuItemEditForm.DescriptionEdit1Exit(Sender: TObject);
begin
 MenuButton.Caption := CopyDescription(DescriptionEdit1.Text);
end;

procedure TMenuItemEditForm.PriceEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then HappyHourPriceEdit1.SetFocus;
end;

procedure TMenuItemEditForm.HappyHourPriceEdit1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SubEdit.SetFocus;
end;

procedure TMenuItemEditForm.SubEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then BarCodeEdit.SetFocus;
end;

procedure TMenuItemEditForm.PriceEditExit(Sender: TObject);
begin
 with Sender As TEdit do
  begin
   if CheckNum(Text, 12, 999999999.99, -99999999.99, 'F') then
      Text := Format('%12.2f', [StrToFloat(Text)])
     else
      begin
       Text := '0';
       SetFocus;
    end;
  end;
end;

procedure TMenuItemEditForm.PriceEditEnter(Sender: TObject);
begin
 with Sender As TEdit do
  begin
   if Text <> '' then
      Text := FloatToStr(StrToFloat(Text));
   SelectAll;
  end; 
end;

procedure TMenuItemEditForm.TaxRateEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DefaultQtyEdit.SetFocus;
end;

procedure TMenuItemEditForm.TaxRateEditExit(Sender: TObject);
begin
 if CheckNum(TaxRateEdit.Text, 10, 9999999.99, -999999.99, 'F') then
    TaxRateEdit.Text := Format('%10.2f', [StrToFloat(TaxRateEdit.Text)])
   else
    begin
     TaxRateEdit.Text := '0';
     TaxRateEdit.SetFocus;
    end;
end;

procedure TMenuItemEditForm.TaxRateEditEnter(Sender: TObject);
begin
 if TaxRateEdit.Text <> '' then
    TaxRateEdit.Text := FloatToStr(StrToFloat(TaxRateEdit.Text));
 TaxRateEdit.SelectAll;
end;

procedure TMenuItemEditForm.DefaultQtyEditEnter(Sender: TObject);
begin
 if DefaultQtyEdit.Text <> '' then
    DefaultQtyEdit.Text := FloatToStr(StrToFloat(DefaultQtyEdit.Text));
 DefaultQtyEdit.SelectAll;
end;

procedure TMenuItemEditForm.DefaultQtyEditExit(Sender: TObject);
begin
 if CheckNum(DefaultQtyEdit.Text, 10, 9999999.99, -999999.99, 'F') then
    DefaultQtyEdit.Text := Format('%10.2f', [StrToFloat(DefaultQtyEdit.Text)])
   else
    begin
     DefaultQtyEdit.Text := '0';
     DefaultQtyEdit.SetFocus;
    end;
end;

procedure TMenuItemEditForm.DefaultQtyEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then JobListColorComboBox.SetFocus;
end;

procedure TMenuItemEditForm.JobListColorComboBoxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PrinterPortComboBox.SetFocus;
end;

procedure TMenuItemEditForm.CategoryComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ItemGroupComboBox.SetFocus
end;

procedure TMenuItemEditForm.ItemGroupComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PriceEdit.SetFocus;
end;

procedure TMenuItemEditForm.KitchenScreenCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SubDescriptionSwapCheckBox.SetFocus
end;

procedure TMenuItemEditForm.SubDescriptionSwapCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SaveButton.SetFocus
end;

procedure TMenuItemEditForm.CategoryComboBoxChange(Sender: TObject);
var
 SQLStr: string;
begin
 if CategoryComboBox.Text <> '' then
    begin
     SQLStr := 'Select * From Category Where Category = ' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
     OpenQuery(SQLStr);
     with CategoryButton do
      with Query do
       begin
        Color := FieldByName('ButtonColor').AsInteger;
        Font.Size := FieldByName('FontSize').AsInteger;;
        Font.Name := FieldByName('FontName').AsString;
        Font.Color := FieldByName('FontColor').AsInteger;
        Font.Style := [];
        if FieldByName('FontBold').AsBoolean then
           Font.Style := MenuButton.Font.Style + [fsBold];
        if FieldByName('FontItalic').AsBoolean then
           Font.Style := MenuButton.Font.Style + [fsItalic];
        if FieldByName('FontUnderline').AsBoolean then
           Font.Style := MenuButton.Font.Style + [fsUnderline];
        if FieldByName('FontStrikeout').AsBoolean then
           Font.Style := MenuButton.Font.Style + [fsStrikeout];
        Close;
       end;
    end;
end;

procedure TMenuItemEditForm.PrinterPortComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PrinterPortComboBox1.SetFocus;
end;

procedure TMenuItemEditForm.PrinterPortComboBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PrinterPortComboBox2.SetFocus;
end;

procedure TMenuItemEditForm.PrinterPortComboBox2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PrinterPortComboBox3.SetFocus;
end;

procedure TMenuItemEditForm.PrinterPortComboBox3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then KitchenScreenComboBox1.SetFocus;
end;

procedure TMenuItemEditForm.KitchenScreenComboBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then KitchenScreenComboBox2.SetFocus;
end;

procedure TMenuItemEditForm.KitchenScreenComboBox2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then KitchenScreenComboBox3.SetFocus;
end;

procedure TMenuItemEditForm.KitchenScreenComboBox3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then KitchenScreenComboBox4.SetFocus;
end;

procedure TMenuItemEditForm.KitchenScreenComboBox4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ActiveCheckBox.SetFocus;
end;

procedure TMenuItemEditForm.InstructionCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then MultiCheckBox.SetFocus;
end;

procedure TMenuItemEditForm.DiscountCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then OnlyShowOnSubMenuCheckBox.SetFocus;
end;

procedure TMenuItemEditForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TMenuItemEditForm.ActiveCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then InstructionCheckBox.SetFocus;
end;

procedure TMenuItemEditForm.OnlyShowOnSubMenuCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then AutoPopSpellInstructionKeyboardCheckBox.SetFocus;
end;

procedure TMenuItemEditForm.AutoPopSpellInstructionKeyboardCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SubDescriptionSwapCheckBox.SetFocus;
end;

procedure TMenuItemEditForm.MultiCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then OpenPriceCheckBox.SetFocus
end;

procedure TMenuItemEditForm.OpenPriceCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DiscountCheckBox.SetFocus
end;

procedure TMenuItemEditForm.PriceEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then HappyHourPriceEdit2.SetFocus;
end;

procedure TMenuItemEditForm.HappyHourPriceEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SubEdit1.SetFocus;
end;

procedure TMenuItemEditForm.PriceEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then HappyHourPriceEdit3.SetFocus;
end;

procedure TMenuItemEditForm.HappyHourPriceEdit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SubEdit2.SetFocus;
end;

procedure TMenuItemEditForm.PriceEdit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then HappyHourPriceEdit4.SetFocus;
end;

procedure TMenuItemEditForm.HappyHourPriceEdit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SubEdit3.SetFocus;
end;

procedure TMenuItemEditForm.SubEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then BarCodeEdit1.SetFocus;
end;

procedure TMenuItemEditForm.BarCodeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PriceEdit2.SetFocus;
end;

procedure TMenuItemEditForm.SubEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then BarCodeEdit2.SetFocus;
end;

procedure TMenuItemEditForm.BarCodeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PriceEdit3.SetFocus;
end;

procedure TMenuItemEditForm.SubEdit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then BarCodeEdit3.SetFocus;
end;

procedure TMenuItemEditForm.BarCodeEdit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TaxRateEdit.SetFocus;
end;

procedure TMenuItemEditForm.BarCodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PriceEdit1.SetFocus;
end;

procedure TMenuItemEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CategoryQuery.Close;
 Action := caFree;
end;

function TMenuItemEditForm.ProcessEditCode: Boolean;
begin
 Result := DataForm.ExecQueryPro('Delete From MenuItem Where ItemCode=' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39));
 if Result then
    Result := DataForm.ExecQueryPro('Delete From MenuItem Where ItemCode=' + Chr(39) + CheckQuotes(OldCode) + Chr(39));
 if Result then
    Result := DataForm.ExecQueryPro('Delete From IngredientsTable Where ItemCode=' + Chr(39) + CheckQuotes(OldCode) + Chr(39));
 if Result then
    begin
     if CategoryComboBox.Text <> Category then
        CreateNewButtonPosition(MainPosition, POSPosition, PhoneOrderPosition);
     Result := AppendNewItem;
    end;
 if Result then Result := SaveIngredientsRecord;
 if Result and (OldCode <> CodeEdit.Text) then Result := UpdateOtherTable(OldCode, CodeEdit.Text);
end;

procedure TMenuItemEditForm.CreateNewButtonPosition(var MainPosition, POSPosition, PhoneOrderPosition: integer);
var
 SQLStr: string;
begin
 SQLStr := 'Select Max(MainPosition) As MainPosition From MenuItem Where Category=' +
           Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  if Active and (RecordCount > 0) then
     MainPosition := FieldByName('MainPosition').AsInteger + 1
    else
     MainPosition := 1;
 SQLStr := 'Select Max(POSPosition) As POSPosition From MenuItem Where Category=' +
           Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  if Active and (RecordCount > 0) then
     POSPosition := FieldByName('POSPosition').AsInteger + 1
    else
     POSPosition := 1;
 SQLStr := 'Select Max(PhoneOrderPosition) As PhoneOrderPosition From MenuItem Where Category=' +
           Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  if Active and (RecordCount > 0) then
     PhoneOrderPosition := FieldByName('PhoneOrderPosition').AsInteger + 1
    else
     PhoneOrderPosition := 1;
end;

function TMenuItemEditForm.ProcessNewCode: boolean;
begin
 CreateNewButtonPosition(MainPosition, POSPosition, PhoneOrderPosition);
 Result := AppendNewItem;
 if Result then SaveIngredientsRecord;
end;

function TMenuItemEditForm.CheckBarcode: boolean;
var
 SQLStr: string;
begin
 Result := True;
 if BarCodeEdit.Text <> '' then
    begin
     if (BarCodeEdit.Text = BarCodeEdit1.Text) or
        (BarCodeEdit.Text = BarCodeEdit2.Text) or
        (BarCodeEdit.Text = BarCodeEdit3.Text) then
        Result := False;
    end;
 if BarCodeEdit1.Text <> '' then
    begin
     if (BarCodeEdit1.Text = BarCodeEdit2.Text) or
        (BarCodeEdit1.Text = BarCodeEdit3.Text) then
        Result := False;
    end;
 if BarCodeEdit2.Text <> '' then
    begin
     if (BarCodeEdit2.Text = BarCodeEdit3.Text) then
         Result := False;
    end;
 if Result and
    ((BarCodeEdit.Text <> '') or (BarCodeEdit1.Text <> '') or
    (BarCodeEdit2.Text <> '') or (BarCodeEdit3.Text <> '')) then
    begin
     SQLStr := 'Select Count(*) From MenuItem ' +
               'Where ItemCode <>' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39) +
               ' and (';
     if BarCodeEdit.Text <> '' then
        SQLStr := SQLStr + 'BarCode=' + Chr(39) + CheckQuotes(BarCodeEdit.Text) + Chr(39) +
                  ' or BarCode1=' + Chr(39) + CheckQuotes(BarCodeEdit.Text) + Chr(39) +
                  ' or BarCode2=' + Chr(39) + CheckQuotes(BarCodeEdit.Text) + Chr(39) +
                  ' or BarCode3=' + Chr(39) + CheckQuotes(BarCodeEdit.Text) + Chr(39);
     if BarCodeEdit1.Text <> '' then
        begin
         if BarCodeEdit.Text <> '' then SQLStr := SQLStr + ' or ';
        SQLStr := SQLStr + 'BarCode=' + Chr(39) + CheckQuotes(BarCodeEdit1.Text) + Chr(39) +
                  ' or BarCode1=' + Chr(39) + CheckQuotes(BarCodeEdit1.Text) + Chr(39) +
                  ' or BarCode2=' + Chr(39) + CheckQuotes(BarCodeEdit1.Text) + Chr(39) +
                  ' or BarCode3=' + Chr(39) + CheckQuotes(BarCodeEdit1.Text) + Chr(39);
        end;
     if BarCodeEdit2.Text <> '' then
        begin
         if (BarCodeEdit.Text <> '') or (BarCodeEdit1.Text <> '') then
            SQLStr := SQLStr + ' or ';
        SQLStr := SQLStr + 'BarCode=' + Chr(39) + CheckQuotes(BarCodeEdit2.Text) + Chr(39) +
                  ' or BarCode1=' + Chr(39) + CheckQuotes(BarCodeEdit2.Text) + Chr(39) +
                  ' or BarCode2=' + Chr(39) + CheckQuotes(BarCodeEdit2.Text) + Chr(39) +
                  ' or BarCode3=' + Chr(39) + CheckQuotes(BarCodeEdit2.Text) + Chr(39);
        end;
     if BarCodeEdit3.Text <> '' then
        begin
         if (BarCodeEdit.Text <> '') or (BarCodeEdit1.Text <> '') or
            (BarCodeEdit2.Text <> '') then SQLStr := SQLStr + ' or ';
        SQLStr := SQLStr + 'BarCode=' + Chr(39) + CheckQuotes(BarCodeEdit3.Text) + Chr(39) +
                  ' or BarCode1=' + Chr(39) + CheckQuotes(BarCodeEdit3.Text) + Chr(39) +
                  ' or BarCode2=' + Chr(39) + CheckQuotes(BarCodeEdit3.Text) + Chr(39) +
                  ' or BarCode3=' + Chr(39) + CheckQuotes(BarCodeEdit3.Text) + Chr(39);
        end;
      SQLStr := SQLStr + ')';
      if DataForm.CheckCodeSQLPro(SQLStr) >= 1 then Result := False;
    end;
end;

procedure TMenuItemEditForm.SaveButtonClick(Sender: TObject);
var
 Flag: boolean;
 SQLStr: string;
 Temp: Integer;
begin
 if (CodeEdit.Text = '') or (DescriptionEdit1.Text = '') or (CategoryComboBox.Text = '') then
    begin
     MessageBoxForm.MessagePro('Some fields are invalid!', sErrorMsg);
     Exit;
    end;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 if OpFlag = sNewStatus then
    begin
     SQLStr := 'Select Count(*) From MenuItem Where ItemCode=' +
               Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39);
     Temp := DataForm.CheckCodeSQLPro(SQLStr);
     if Temp  > 0 then
        begin
         DataForm.RollBack;
         MessageBoxForm.MessagePro(CodeEdit.Text + ' is already exist.', sErrorMsg);
         Exit;
        end;
    end
   else
    begin
     if OldCode <> CodeEdit.Text then
        begin
         SQLStr := 'Select Count(*) From MenuItem Where ItemCode=' +
                   Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39);
         Temp := DataForm.CheckCodeSQLPro(SQLStr);
         if (Temp > 0) and
            (MessageBoxForm.MessagePro(CodeEdit.Text + ' is already exist, do you want to replace?', sConfirmMsg) = mrNo) then
            begin
             DataForm.RollBack;
             Exit;
            end;
        end;
    end;
 if Not CheckBarcode then
    begin
     MessageBoxForm.MessagePro('The Barcode are already exist!', sErrorMsg);
     DataForm.RollBack;
     Exit;
    end;
 try
  if OpFlag = sNewStatus then
     Flag := ProcessNewCode
    else
     Flag := ProcessEditCode;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      Code := CodeEdit.Text;
      ReturnFlag := True;
      Close;
     end
    else
     begin
      DataForm.Rollback;
     end;
 end;
end;

procedure TMenuItemEditForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TMenuItemEditForm.EditDBlClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    with Sender As TEdit do
     begin
      Text := Str;
      if Name = 'CodeEdit' then
         Text := Uppercase(Text);
     end;
end;

procedure TMenuItemEditForm.NumberEditClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TEdit do
  begin
   NumStr := Text;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Price', 0) then
      Text := NumStr;
  end;    
end;

procedure TMenuItemEditForm.TaxRateEditClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TEdit do
  begin
   NumStr := Text;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'G.S.T. Rate', 0) then
      Text := NumStr;
  end;
end;

procedure TMenuItemEditForm.DefaultQtyEditDblClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TEdit do
  begin
   NumStr := Text;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Default Sales Qty', 0) then
      Text := NumStr;
  end;
end;

procedure TMenuItemEditForm.ColorButtonClick(Sender: TObject);
begin
 ColorBox.Color := MenuButton.Color;
 if ColorBox.Execute then
    MenuButton.Color := ColorBox.Color;
end;

procedure TMenuItemEditForm.ColorButton1Click(Sender: TObject);
begin
 ColorBox.Color := MenuButton1.Color;
 if ColorBox.Execute then
    MenuButton1.Color := ColorBox.Color;
end;

procedure TMenuItemEditForm.FontButtonClick(Sender: TObject);
begin
 FontDialog.Font := MenuButton.Font;
 if FontDialog.Execute then
    MenuButton.Font := FontDialog.Font;
end;

procedure TMenuItemEditForm.FontButton1Click(Sender: TObject);
begin
 FontDialog.Font := MenuButton1.Font;
 if FontDialog.Execute then
    MenuButton1.Font := FontDialog.Font;
end;

procedure TMenuItemEditForm.KitchenScreenFontColorButtonClick(Sender: TObject);
begin
 ColorBox.Color := KitchenScreenFontColorPanel.Font.Color;
 if ColorBox.Execute then
    KitchenScreenFontColorPanel.Font.Color := ColorBox.Color;
end;

procedure TMenuItemEditForm.FormShow(Sender: TObject);
var
 SQLStr: string;
begin
 Width := PageControl.Width + 28;
 Height := SaveButton.Top + 86;
 InitForm;
 ReadCategory;
 ReadItemGroup;
 if OpFlag = sEditStatus then
    begin
     SQLStr := 'Select * From MenuItem Where ItemCode=' + Chr(39) + CheckQuotes(OldCode) + Chr(39);
     OpenQuery(SQLStr);
     with Query do
      begin
       ScalableChk.Checked := FieldByName('Scalable').AsBoolean;
       CodeEdit.Text := FieldByName('ItemCode').AsString;
       CategoryComboBox.ItemIndex := SearchString(CategoryComboBox.Items, FieldByName('Category').AsString);
       ItemGroupComboBox.ItemIndex := SearchString(ItemGroupComboBox.Items, FieldByName('ItemGroup').AsString);
       DescriptionEdit1.Text := FieldByName('Description1').AsString;
       DescriptionEdit2.Text := FieldByName('Description2').AsString;
       PriceEdit.Text := Format('%12.2f', [FieldByName('Price').AsFloat]);
       TaxRateEdit.Text := Format('%10.2f', [FieldByName('TaxRate').AsFloat]);
       DefaultQtyEdit.Text := Format('%10.2f', [FieldByName('DefaultQty').AsFloat]);
       ActiveCheckBox.Checked := FieldByName('Active').AsBoolean;
       PrinterPortComboBox.ItemIndex := FieldByName('PrinterPort').AsInteger;
       PrinterPortComboBox1.ItemIndex := FieldByName('PrinterPort1').AsInteger;
       PrinterPortComboBox2.ItemIndex := FieldByName('PrinterPort2').AsInteger;
       PrinterPortComboBox3.ItemIndex := FieldByName('PrinterPort3').AsInteger;
       KitchenScreenComboBox1.ItemIndex := FieldByName('KitchenScreen1').AsInteger;
       KitchenScreenComboBox2.ItemIndex := FieldByName('KitchenScreen2').AsInteger;
       KitchenScreenComboBox3.ItemIndex := FieldByName('KitchenScreen3').AsInteger;
       KitchenScreenComboBox4.ItemIndex := FieldByName('KitchenScreen4').AsInteger;
       InstructionCheckBox.Checked := FieldByName('Instruction').AsBoolean;
       DiscountCheckBox.Checked := FieldByName('AllowDiscount').AsBoolean;
       MultiCheckBox.Checked := FieldByName('Multiple').AsBoolean;
       PriceEdit1.Text := Format('%12.2f', [FieldByName('Price1').AsFloat]);
       PriceEdit2.Text := Format('%12.2f', [FieldByName('Price2').AsFloat]);
       PriceEdit3.Text := Format('%12.2f', [FieldByName('Price3').AsFloat]);
       HappyHourPriceEdit1.Text := Format('%12.2f', [FieldByName('HappyHourPrice1').AsFloat]);
       HappyHourPriceEdit2.Text := Format('%12.2f', [FieldByName('HappyHourPrice2').AsFloat]);
       HappyHourPriceEdit3.Text := Format('%12.2f', [FieldByName('HappyHourPrice3').AsFloat]);
       HappyHourPriceEdit4.Text := Format('%12.2f', [FieldByName('HappyHourPrice4').AsFloat]);
       SubEdit.Text := FieldByName('SubDescription').AsString;
       SubEdit1.Text := FieldByName('SubDescription1').AsString;
       SubEdit2.Text := FieldByName('SubDescription2').AsString;
       SubEdit3.Text := FieldByName('SubDescription3').AsString;
       BarCodeEdit.Text := FieldByName('BarCode').AsString;
       BarCodeEdit1.Text := FieldByName('BarCode1').AsString;
       BarCodeEdit2.Text := FieldByName('BarCode2').AsString;
       BarCodeEdit3.Text := FieldByName('BarCode3').AsString;
       MenuButton.Color := FieldByName('ButtonColor').AsInteger;
       MenuButton.Font.Size := FieldByName('FontSize').AsInteger;;
       MenuButton.Font.Name := FieldByName('FontName').AsString;
       MenuButton.Font.Color := FieldByName('FontColor').AsInteger;
       MenuButton.Font.Style := [];
       if FieldByName('FontBold').AsBoolean then
          MenuButton.Font.Style := MenuButton.Font.Style + [fsBold];
       if FieldByName('FontItalic').AsBoolean then
          MenuButton.Font.Style := MenuButton.Font.Style + [fsItalic];
       if FieldByName('FontUnderline').AsBoolean then
          MenuButton.Font.Style := MenuButton.Font.Style + [fsUnderline];
       if FieldByName('FontStrikeout').AsBoolean then
          MenuButton.Font.Style := MenuButton.Font.Style + [fsStrikeout];
       MenuButton1.Color := FieldByName('ButtonColor1').AsInteger;
       MenuButton1.Font.Size := FieldByName('FontSize1').AsInteger;;
       MenuButton1.Font.Name := FieldByName('FontName1').AsString;
       MenuButton1.Font.Color := FieldByName('FontColor1').AsInteger;
       MenuButton1.Font.Style := [];
       if FieldByName('FontBold1').AsBoolean then
          MenuButton1.Font.Style := MenuButton1.Font.Style + [fsBold];
       if FieldByName('FontItalic1').AsBoolean then
          MenuButton1.Font.Style := MenuButton1.Font.Style + [fsItalic];
       if FieldByName('FontUnderline1').AsBoolean then
          MenuButton1.Font.Style := MenuButton1.Font.Style + [fsUnderline];
       if FieldByName('FontStrikeout1').AsBoolean then
          MenuButton1.Font.Style := MenuButton1.Font.Style + [fsStrikeout];
       MenuButton.Caption := CopyDescription(DescriptionEdit1.Text);
       MenuButton1.Caption := CopyDescription(DescriptionEdit2.Text);
       JobListColorComboBox.ItemIndex := FieldByName('JobListColor').AsInteger;
       OpenPriceCheckBox.Checked := FieldByName('OpenPrice').AsBoolean;
       POSPosition := FieldByName('POSPosition').AsInteger;
       MainPosition := FieldByName('MainPosition').AsInteger;
       PhoneOrderPosition := FieldByName('PhoneOrderPosition').AsInteger;
       SubDescriptionSwapCheckBox.Checked := FieldByName('SubDescriptionSwap').AsBoolean;
       KitchenScreenFontColorPanel.Font.Color := FieldByName('KitchenScreenFontColor').AsInteger;
       OnlyShowOnSubMenuCheckBox.Checked := FieldByName('OnlyShowOnSubMenu').AsBoolean;
       AutoPopSpellInstructionKeyboardCheckBox.Checked := FieldByName('AutoPopSpellInstructionKeyboard').AsBoolean;
       //AutoPopQuantityKeyboard.Checked := FieldByName('AutoPopQuantityKeyboard').AsBoolean;
       Close;
      end;
     SQLStr := 'Select * From IngredientsTable Where ItemCode=' + Chr(39) + CheckQuotes(OldCode) + Chr(39);
     OpenQuery(SQLStr);
     with Query do
      begin
       if Active and (RecordCount > 0) then
          IngredientsEdit.Text := FieldByName('Ingredients').AsString;
       Close;
      end;
    end;
 CategoryComboBoxChange(Sender);
 CodeEdit.SetFocus;
end;

function TMenuItemEditForm.MenuItemEditPro(var Code: string; Category: string; OpFlag: integer): boolean;
begin
 Application.CreateForm(TMenuItemEditForm, MenuItemEditForm);
 MenuItemEditForm.OpFlag := OpFlag;
 MenuItemEditForm.OldCode := Code;
 MenuItemEditForm.Category := Category;
 MenuItemEditForm.ShowModal;
 Result := MenuItemEditForm.ReturnFlag;
 if Result then Code := MenuItemEditForm.Code;
 MenuItemEditForm.Free;
end;

end.
