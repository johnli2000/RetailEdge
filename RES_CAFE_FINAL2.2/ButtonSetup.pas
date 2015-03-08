unit ButtonSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, DB, Grids, DBGrids, UtilUnit,
  ExtDlgs, ADODB, bsSkinCtrls, BusinessSkinForm, XiButton, PanelButton;

type
  TButtonSetupForm = class(TForm)
    DataSource: TDataSource;
    ColorBox: TColorDialog;
    FontDialog: TFontDialog;
    Bevel1: TBevel;
    Label11: TLabel;
    Category: TDBLookupComboBox;
    CategoryButton: TPanel;
    CategoryQuery: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    EditPanel: TbsSkinPanel;
    ButtonSetPanel: TbsSkinPanel;
    ColorButton: TbsSkinSpeedButton;
    FontButton: TbsSkinSpeedButton;
    SaveButton: TXiButton;
    ExitButton: TXiButton;
    ItemButton: TPanelButton;
    DescriptionComboBox: TComboBox;
    procedure OpenCategoryQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CategoryCloseUp(Sender: TObject);
    procedure ColorButtonClick(Sender: TObject);
    procedure FontButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure ButtonLayoutSetup;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 ButtonSetupForm: TButtonSetupForm;

implementation

uses DataUnit, MainMenu, MessageBox;


{$R *.DFM}

procedure TButtonSetupForm.OpenCategoryQuery;
begin
 Screen.Cursor := crHourGlass;
 with CategoryQuery do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From Category Order By Code');
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TButtonSetupForm.CategoryCloseUp(Sender: TObject);
begin
 Category.KeyValue := CategoryQuery.FieldByName('Category').AsString;
 with CategoryButton do
  with CategoryQuery do
   begin
    Color := FieldByName('ButtonColor').AsInteger;
    Font.Size := FieldByName('FontSize').AsInteger;;
    Font.Name := FieldByName('FontName').AsString;
    Font.Color := FieldByName('FontColor').AsInteger;
    Font.Style := [];
    if FieldByName('FontBold').AsBoolean then
       Font.Style := ItemButton.Font.Style + [fsBold];
    if FieldByName('FontItalic').AsBoolean then
       Font.Style := ItemButton.Font.Style + [fsItalic];
    if FieldByName('FontUnderline').AsBoolean then
       Font.Style := ItemButton.Font.Style + [fsUnderline];
    if FieldByName('FontStrikeout').AsBoolean then
       Font.Style := ItemButton.Font.Style + [fsStrikeout];
   end;
 ItemButton.Color := CategoryButton.Color;
 ItemButton.Font := CategoryButton.Font;
end;

procedure TButtonSetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CategoryQuery.Close;
 Action := caFree;
end;

procedure TButtonSetupForm.ColorButtonClick(Sender: TObject);
begin
 ColorBox.Color := ItemButton.Color;
 if ColorBox.Execute then
    ItemButton.Color := ColorBox.Color;
end;

procedure TButtonSetupForm.FontButtonClick(Sender: TObject);
begin
 FontDialog.Font := ItemButton.Font;
 if FontDialog.Execute then
    ItemButton.Font := FontDialog.Font;
end;

procedure TButtonSetupForm.SaveButtonClick(Sender: TObject);
var
 SQLStr, CategoryTemp, ButtonColor, FontColor, FontName, FontSize,
 FontBold, FontItalic, FontUnderline, FontStrikeout: string;
 Flag: boolean;
begin
 CategoryTemp := Chr(39) + CheckQuotes(Category.Text) + Chr(39);
 ButtonColor := IntToStr(ItemButton.Color);
 FontColor := IntToStr(ItemButton.Font.Color);
 FontName := Chr(39) + CheckQuotes(ItemButton.Font.Name) + Chr(39);
 FontSize := IntToStr(ItemButton.Font.Size);
 if fsBold in ItemButton.Font.Style then
    FontBold := '1'
   else
    FontBold := '0';
 if fsItalic in ItemButton.Font.Style then
    FontItalic := '1'
   else
    FontItalic := '0';
 if fsUnderline in ItemButton.Font.Style then
    FontUnderline := '1'
   else
    FontUnderline := '0';
 if fsStrikeout in ItemButton.Font.Style then
    FontStrikeout := '1'
   else
    FontStrikeout := '0';
 case DescriptionComboBox.ItemIndex of
  0: SQLStr := 'Update MenuItem Set ' +
               'ButtonColor=' + ButtonColor + ',' +
               'FontName=' + FontName + ',' +
               'FontColor=' + FontColor + ',' +
               'FontSize=' + FontSize + ',' +
               'FontBold=' + FontBold + ',' +
               'FontItalic=' + FontItalic + ',' +
               'FontUnderline=' + FontUnderline + ',' +
               'FontStrikeout=' + FontStrikeout +
               ' Where Category=' + CategoryTemp;
  1: SQLStr := 'Update MenuItem Set ' +
               'ButtonColor1=' + ButtonColor + ',' +
               'FontName1=' + FontName + ',' +
               'FontColor1=' + FontColor + ',' +
               'FontSize1=' + FontSize + ',' +
               'FontBold1=' + FontBold + ',' +
               'FontItalic1=' + FontItalic + ',' +
               'FontUnderline1=' + FontUnderline + ',' +
               'FontStrikeout1=' + FontStrikeout +
               ' Where Category=' + CategoryTemp;
  2: SQLStr := 'Update MenuItem Set ' +
               'ButtonColor=' + ButtonColor + ',' +
               'FontName=' + FontName + ',' +
               'FontColor=' + FontColor + ',' +
               'FontSize=' + FontSize + ',' +
               'FontBold=' + FontBold + ',' +
               'FontItalic=' + FontItalic + ',' +
               'FontUnderline=' + FontUnderline + ',' +
               'FontStrikeout=' + FontStrikeout + ',' +
               'ButtonColor1=' + ButtonColor + ',' +
               'FontName1=' + FontName + ',' +
               'FontColor1=' + FontColor + ',' +
               'FontSize1=' + FontSize + ',' +
               'FontBold1=' + FontBold + ',' +
               'FontItalic1=' + FontItalic + ',' +
               'FontUnderline1=' + FontUnderline + ',' +
               'FontStrikeout1=' + FontStrikeout +
                ' Where Category=' + CategoryTemp;
 end;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := DataForm.ExecQueryPro(SQLStr);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      MessageBoxForm.MessagePro('Buttons layout has been changed successful.', sInformationMsg);
     end
    else
     begin
      DataForm.Rollback;
     end;
 end;
end;

procedure TButtonSetupForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then ExitButtonClick(Sender);
end;

procedure TButtonSetupForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TButtonSetupForm.FormShow(Sender: TObject);
begin
 Width := ButtonSetPanel.Width + 28;
 Height := SaveButton.Top + 86;
 OpenCategoryQuery;
 CategoryCloseUp(Sender);
end;

procedure TButtonSetupForm.ButtonLayoutSetup;
begin
 Application.CreateForm(TButtonSetupForm, ButtonSetupForm);
 ButtonSetupForm.ShowModal;
 ButtonSetupForm.Free;
end;

end.
