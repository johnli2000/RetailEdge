unit FixedButtonEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, DB, Grids, DBGrids, UtilUnit,
  ExtDlgs, ADODB, bsSkinCtrls, BusinessSkinForm, XiButton, PanelButton;

type
  TFixedButtonEditForm = class(TForm)
    FontDialog: TFontDialog;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    EditPanel: TbsSkinPanel;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    ColorComboBox: TComboBox;
    Label1: TLabel;
    ButtonNameEdit: TStaticText;
    Label2: TLabel;
    CaptionEdit: TMemo;
    Label3: TLabel;
    FontButton: TXiButton;
    ButtonPanel: TbsSkinPanel;
    ItemButton: TXiButton;
    procedure OpenQuery;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FontButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CaptionEditChange(Sender: TObject);
    procedure ColorComboBoxChange(Sender: TObject);
    procedure SizeComboBoxChange(Sender: TObject);
    function  ControlButtonEditPro(ButtonName: string; ButtonKind: integer): boolean;
  private { Private declarations }
     ButtonName: string;
     ButtonKind, ButtonHeight, ButtonWidth: integer;
     ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
 FixedButtonEditForm: TFixedButtonEditForm;

implementation

uses DataUnit, MainMenu, MessageBox;


{$R *.DFM}

procedure TFixedButtonEditForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From ButtonsTable ' +
           'Where CanRelocate = 0 and Kind=' + IntToStr(ButtonKind) +
           ' and ButtonName=' + Chr(39) + ButtonName + Chr(39);
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

procedure TFixedButtonEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TFixedButtonEditForm.FontButtonClick(Sender: TObject);
begin
 FontDialog.Font := ItemButton.Font;
 if FontDialog.Execute then
    ItemButton.Font := FontDialog.Font;
end;

procedure TFixedButtonEditForm.CaptionEditChange(Sender: TObject);
begin
 ItemButton.Caption := CaptionEdit.Text;
end;

procedure TFixedButtonEditForm.ColorComboBoxChange(Sender: TObject);
begin
 case ColorComboBox.ItemIndex of
  0:  ItemButton.ColorScheme := csNeoDesert;
  1:  ItemButton.ColorScheme := csNeoSky;
  2:  ItemButton.ColorScheme := csNeoGrass;
  3:  ItemButton.ColorScheme := csNeoSilver;
  4:  ItemButton.ColorScheme := csNeoRose;
  5:  ItemButton.ColorScheme := csNeoSun;
  6:  ItemButton.ColorScheme := csDesert;
  7:  ItemButton.ColorScheme := csGrass;
  8:  ItemButton.ColorScheme := csSky;
  9:  ItemButton.ColorScheme := csSun;
  10: ItemButton.ColorScheme := csRose;
  11: ItemButton.ColorScheme := csSilver;
 end;
end;

procedure TFixedButtonEditForm.SizeComboBoxChange(Sender: TObject);
begin
 with ItemButton do
  begin
   Height := ButtonHeight;
   Width := ButtonWidth;
   Left := Round((ButtonPanel.Width - ItemButton.Width) / 2);
   Top := Round((ButtonPanel.Height - ItemButton.Height) / 2);
  end;
end;

procedure TFixedButtonEditForm.SaveButtonClick(Sender: TObject);
var
 SQLStr, ButtonCaption, ButtonColor, FontName, FontSize, FontBold, FontItalic,
 FontUnderline, FontStrikeout: string;
 Flag: boolean;
begin
 ButtonCaption := Chr(39) + CheckQuotes(CaptionEdit.Text) + Chr(39);
 case ItemButton.ColorScheme of
  csNeoDesert: ButtonColor := IntToStr(bcNeoDesert);
  csNeoSky:    ButtonColor := IntToStr(bcNeoSky);
  csNeoGrass:  ButtonColor := IntToStr(bcNeoGrass);
  csNeoSilver: ButtonColor := IntToStr(bcNeoSilver);
  csNeoRose:   ButtonColor := IntToStr(bcNeoRose);
  csNeoSun:    ButtonColor := IntToStr(bcNeoSun);
  csDesert:    ButtonColor := IntToStr(bcDesert);
  csGrass:     ButtonColor := IntToStr(bcGrass);
  csSky:       ButtonColor := IntToStr(bcSky);
  csSun:       ButtonColor := IntToStr(bcSun);
  csRose:      ButtonColor := IntToStr(bcRose);
  csSilver:    ButtonColor := IntToStr(bcSilver);
 end;
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
 SQLStr := 'Update ButtonsTable Set ' +
           'Caption=' + ButtonCaption + ',' +
           'ButtonColor=' + ButtonColor + ',' +
           'FontName=' + FontName + ',' +
           'FontSize=' + FontSize + ',' +
           'FontBold=' + FontBold + ',' +
           'FontItalic=' + FontItalic + ',' +
           'FontUnderline=' + FontUnderline + ',' +
           'FontStrikeout=' + FontStrikeout +
           ' Where ButtonName=' + Chr(39) + ButtonName + Chr(39) +  ' and ' +
           ' CanRelocate = 0 and Kind=' + IntToStr(ButtonKind);
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := DataForm.ExecQueryPro(SQLStr);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      ReturnFlag := True;
      Close;
     end
    else
     DataForm.Rollback;
 end;
end;

procedure TFixedButtonEditForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TFixedButtonEditForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TFixedButtonEditForm.FormShow(Sender: TObject);
begin
 case ButtonKind of
  1: begin
      ButtonHeight := 66;
      ButtonWidth := 70;
     end;
  2: begin
      ButtonHeight := 58;
      ButtonWidth := 80;
     end;
  else
     begin
      ButtonHeight := 43;
      ButtonWidth := 108;
     end;
 end;
 OpenQuery;
 with ItemButton do
  begin
   case Query.FieldByName('ButtonColor').AsInteger of
    bcNeoDesert: ColorScheme := csNeoDesert;
    bcNeoSky:    ColorScheme := csNeoSky;
    bcNeoGrass:  ColorScheme := csNeoGrass;
    bcNeoSilver: ColorScheme := csNeoSilver;
    bcNeoRose:   ColorScheme := csNeoRose;
    bcNeoSun:    ColorScheme := csNeoSun;
    bcDesert:    ColorScheme := csDesert;
    bcGrass:     ColorScheme := csGrass;
    bcSky:       ColorScheme := csSky;
    bcSun:       ColorScheme := csSun;
    bcRose:      ColorScheme := csRose;
    bcSilver:    ColorScheme := csSilver;
   end;
   Caption := Query.FieldByName('Caption').AsString;
   Font.Name := Query.FieldByName('FontName').AsString;
   Font.Size := Query.FieldByName('FontSize').AsInteger;
   Font.Color := clBlack;
   Font.Style := [];
   if Query.FieldByName('FontBold').AsBoolean then Font.Style := Font.Style + [fsBold];
   if Query.FieldByName('FontItalic').AsBoolean then Font.Style := Font.Style + [fsItalic];
   if Query.FieldByName('FontUnderline').AsBoolean then Font.Style := Font.Style + [fsUnderline];
   if Query.FieldByName('FontStrikeout').AsBoolean then Font.Style := Font.Style + [fsStrikeout];
   ItemButton.Height := ButtonHeight;
   ItemButton.Width := ButtonWidth;
   Left := Round((ButtonPanel.Width - ItemButton.Width) / 2);
   Top := Round((ButtonPanel.Height - ItemButton.Height) / 2);
  end;
 ButtonNameEdit.Caption := ButtonName;
 CaptionEdit.Text := Query.FieldByName('Caption').AsString;
 ColorComboBox.ItemIndex := Query.FieldByName('ButtonColor').AsInteger;
 Query.Close;
end;

function TFixedButtonEditForm.ControlButtonEditPro(ButtonName: string; ButtonKind: integer): boolean;
begin
 Application.CreateForm(TFixedButtonEditForm, FixedButtonEditForm);
 FixedButtonEditForm.ButtonName := ButtonName;
 FixedButtonEditForm.ButtonKind := ButtonKind;
 FixedButtonEditForm.ShowModal;
 Result := FixedButtonEditForm.ReturnFlag;
 FixedButtonEditForm.Free;
end;

end.
