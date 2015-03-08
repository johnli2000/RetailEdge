unit TableEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, UtilUnit,
  ADODB, GButton, BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TTableEditForm = class(TForm)
    Query: TADOQuery;
    EditPanel: TPanel;
    Label1: TLabel;
    TableNoEdit: TEdit;
    Label2: TLabel;
    SeatEdit: TEdit;
    Label3: TLabel;
    ShapeComboBox: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    TableLayout: TGButton;
    ButtonWidthEdit: TEdit;
    ButtonHeightEdit: TEdit;
    FontDialog: TFontDialog;
    Label6: TLabel;
    PropertyComboBox: TComboBox;
    Label7: TLabel;
    DescriptionEdit: TEdit;
    PageComboBox: TComboBox;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    bsSkinPanel: TbsSkinPanel;
    FontButton: TXiButton;
    LayoutPanel: TbsSkinPanel;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    MinimumChargeLabel: TLabel;
    MinimumChargeEdit: TEdit;
    procedure OpenQuery(SQLStr: string);
    procedure ReadTableMessage;
    procedure InitEditPanel;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TableNoEditDblClick(Sender: TObject);
    procedure TableNoEditKeyPress(Sender: TObject; var Key: Char);
    procedure TableNoEditExit(Sender: TObject);
    procedure SeatEditDblClick(Sender: TObject);
    procedure SeatEditEnter(Sender: TObject);
    procedure SeatEditExit(Sender: TObject);
    procedure SeatEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ShapeComboBoxChange(Sender: TObject);
    procedure ShapeComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonWidthEditEnter(Sender: TObject);
    procedure ButtonWidthEditExit(Sender: TObject);
    procedure ButtonWidthEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonHeightEditDblClick(Sender: TObject);
    procedure ButtonWidthEditDblClick(Sender: TObject);
    procedure ButtonHeightEditEnter(Sender: TObject);
    procedure ButtonHeightEditExit(Sender: TObject);
    procedure ButtonHeightEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FontButtonClick(Sender: TObject);
    procedure AdjustTablePosition;
    function  SaveTablePro: boolean;
    function  TestTableNo: boolean;
    function  GeneratePDAPosition: integer;
    function  ProcessNewTable: boolean;
    function  ProcessEditTable: boolean;
    procedure SaveButtonClick(Sender: TObject);
    function  TableEditPro(var TableNo: string; X, Y, H, W: integer; OpFlag: integer): boolean;
    procedure DescriptionEditKeyPress(Sender: TObject; var Key: Char);
    procedure DescriptionEditDblClick(Sender: TObject);
    procedure DescriptionEditExit(Sender: TObject);
    procedure ReadTablePageInfo;
    function  TestPDAPosition(PDAPosition: integer): boolean;
    procedure MinimumChargeEditDblClick(Sender: TObject);
    procedure MinimumChargeEditEnter(Sender: TObject);
    procedure MinimumChargeEditExit(Sender: TObject);
    procedure MinimumChargeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private { Private declarations }
    OpFlag, CurrentButtonPositionX, CurrentButtonPositionY, X, Y, H, W,
    CurrentPDAPosition, ServiceStatus: integer;
    TableStatus, TableLocked, ReturnFlag: boolean;
    OldTableNo: string;
  public
    { Public declarations }
  end;

var
 TableEditForm: TTableEditForm;

implementation

uses DataUnit, Keyboard, NumPad, MessageBox, MainMenu, TableSetup;

{$R *.DFM}

procedure TTableEditForm.OpenQuery(SQLStr: string);
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

procedure TTableEditForm.InitEditPanel;
begin
 CurrentButtonPositionX := 10;
 CurrentButtonPositionY := 10;
 CurrentPDAPosition := 0;
 TableStatus := True;
 ServiceStatus := 0;
 TableLocked := False;
 TableNoEdit.Text := '';
 DescriptionEdit.Text := '';
 TableLayOut.Width := 60;
 ButtonWidthEdit.Text := Format('%8d', [60]);
 ButtonHeightEdit.Text := Format('%8d', [60]);
 TableLayOut.Height := 60;
 SeatEdit.Text := Format('%10d', [0]);
 ShapeComboBox.ItemIndex := 3;
 TableLayout.Caption := '';
 TableLayout.Font.Name := 'MS Sans Serif';
 TableLayout.Font.Size := 16;
 TableLayout.Font.Color := clBlack;
 TableLayout.Font.Style := [fsBold];
 TableLayout.Shape := stRoundRect;
 PropertyComboBox.ItemIndex := 0;
 PageComboBox.ItemIndex := 0;
 PageComboBox.Text := PageComboBox.Items[PageComboBox.ItemIndex];
 MinimumChargeEdit.Text := Format('%10.2f', [0.0]);
 MinimumChargeLabel.Visible := MinimumChargeKind = 2;
 MinimumChargeEdit.Visible := MinimumChargeKind = 2;
 AdjustTablePosition;
end;

procedure TTableEditForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TTableEditForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TTableEditForm.TableNoEditDblClick(Sender: TObject);
var
 Str: string;
 I: integer;
begin
 if KeyboardForm.KeyboardPro(Str) then
    with TableNoEdit do
     begin
      Text := '';
      for I := 1 to Length(Str) do
       if Str[I] In ['0'..'9', 'a'..'z', 'A'..'Z'] then
          Text := Text + UpperCase(Str[I]);
     end;
end;

procedure TTableEditForm.TableNoEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then DescriptionEdit.SetFocus;
end;

procedure TTableEditForm.DescriptionEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then SeatEdit.SetFocus;
end;

procedure TTableEditForm.DescriptionEditDblClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    begin
     DescriptionEdit.Text := Str;
     TableLayOut.Caption := Str;
    end;
end;

procedure TTableEditForm.DescriptionEditExit(Sender: TObject);
begin
 TableLayout.Caption := DescriptionEdit.Text;
end;

procedure TTableEditForm.TableNoEditExit(Sender: TObject);
var
 I: integer;
 Temp: string;
begin
  with TableNoEdit do
   begin
    Temp := '';
    for I := 1 to Length(Text) do
     if Text[I] In ['0'..'9', 'A'..'Z', 'a'..'z'] then
        Temp := Temp + Text[I];
    Text := UpperCase(Temp);
    if DescriptionEdit.Text = '' then
       DescriptionEdit.Text := Text;
    TableLayout.Caption := DescriptionEdit.Text;
   end;
end;

procedure TTableEditForm.SeatEditDblClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TEdit do
  begin
   NumStr := Text;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Seats', 0) then
      Text := NumStr;
  end
end;

procedure TTableEditForm.SeatEditEnter(Sender: TObject);
begin
 if SeatEdit.Text <> '' then
    begin
     SeatEdit.Text := IntToStr(StrToInt(SeatEdit.Text));
     SeatEdit.SelectAll;
    end;
end;

procedure TTableEditForm.SeatEditExit(Sender: TObject);
begin
 if CheckNum(SeatEdit.Text, 3, 999, 0, 'D') then
    SeatEdit.Text := Format('%10d', [StrToInt(SeatEdit.Text)])
   else
    begin
     SeatEdit.Text := '0';
     SeatEdit.SetFocus;
    end;
end;

procedure TTableEditForm.SeatEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ShapeComboBox.SetFocus;
end;

procedure TTableEditForm.ShapeComboBoxChange(Sender: TObject);
begin
 case ShapeComboBox.ItemIndex of
  0: TableLayOut.Shape := stCircle;
  1: TableLayOut.Shape := stEllipse;
  2: TableLayOut.Shape := stRectangle;
  3: TableLayOut.Shape := stRoundRect;
  4: TableLayOut.Shape := stRoundSquare;
  5: TableLayOut.Shape := stSquare;


 end;
 AdjustTablePosition;
end;

procedure TTableEditForm.AdjustTablePosition;
begin
 TableLayOut.Left := (LayOutPanel.Width - TableLayout.Width) div 2;
 TableLayOut.Top := (LayOutPanel.Height - TableLayout.Height) div 2;
end;

procedure TTableEditForm.ShapeComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ButtonWidthEdit.SetFocus;
end;

procedure TTableEditForm.ButtonWidthEditDblClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TEdit do
  begin
   NumStr := Text;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Width', 0) then
      Text := NumStr;
  end;
end;

procedure TTableEditForm.ButtonWidthEditEnter(Sender: TObject);
begin
 if ButtonWidthEdit.Text <> '' then
    begin
     ButtonWidthEdit.Text := IntToStr(StrToInt(ButtonWidthEdit.Text));
     ButtonWidthEdit.SelectAll;
    end;
end;

procedure TTableEditForm.ButtonWidthEditExit(Sender: TObject);
begin
 if CheckNum(ButtonWidthEdit.Text, 3, 999, 0, 'D') then
    ButtonWidthEdit.Text := Format('%8d', [StrToInt(ButtonWidthEdit.Text)])
   else
    begin
     ButtonWidthEdit.Text := '40';
     ButtonWidthEdit.SetFocus;
    end;
 TableLayout.Width := StrToInt(ButtonWidthEdit.Text);
 AdjustTablePosition;
end;

procedure TTableEditForm.ButtonWidthEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ButtonHeightEdit.SetFocus;
end;

procedure TTableEditForm.ButtonHeightEditDblClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TEdit do
  begin
   NumStr := Text;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Height', 0) then
      Text := NumStr;
  end;    
end;

procedure TTableEditForm.ButtonHeightEditEnter(Sender: TObject);
begin
 if ButtonHeightEdit.Text <> '' then
    begin
     ButtonHeightEdit.Text := IntToStr(StrToInt(ButtonHeightEdit.Text));
     ButtonHeightEdit.SelectAll;
    end;
end;

procedure TTableEditForm.ButtonHeightEditExit(Sender: TObject);
begin
 if CheckNum(ButtonHeightEdit.Text, 3, 999, 0, 'D') then
    ButtonHeightEdit.Text := Format('%8d', [StrToInt(ButtonHeightEdit.Text)])
   else
    begin
     ButtonHeightEdit.Text := '40';
     ButtonHeightEdit.SetFocus;
    end;
 TableLayout.Height := StrToInt(ButtonHeightEdit.Text);
 AdjustTablePosition;
end;

procedure TTableEditForm.ButtonHeightEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
    begin
     if MinimumChargeKind = 2 then
        MinimumChargeEdit.SetFocus
       else
        SaveButton.SetFocus;
    end;     
end;

procedure TTableEditForm.FontButtonClick(Sender: TObject);
begin
 FontDialog.Font := TableLayOut.Font;
 if FontDialog.Execute then
    begin
     TableLayout.Font := FontDialog.Font;
     TableLayout.Font.Color := clBlack;
    end;
end;

procedure TTableEditForm.ReadTableMessage;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From TableSet Where TableNo=' + Chr(39) + CheckQuotes(OldTableNo) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  if Active and (RecordCount > 0) then
     begin
      TableNoEdit.Text := DeleteSpace(FieldByName('TableNo').AsString);
      OldTableNo := DeleteSpace(FieldByName('TableNo').AsString);
      DescriptionEdit.Text := FieldByName('Description').AsString;
      SeatEdit.Text := Format('%10d', [FieldByName('Seats').AsInteger]);
      ButtonWidthEdit.Text := Format('%8d', [W]);
      ButtonHeightEdit.Text := Format('%8d', [H]);
      TableLayout.Width := W;
      TableLayout.Height := H;
      TableLayout.Font.Size := FieldByName('FontSize').AsInteger;;
      TableLayout.Font.Name := FieldByName('FontName').AsString;
      TableLayout.Font.Color := clBlack;
      TableLayout.Font.Style := [];
      if FieldByName('FontBold').AsBoolean then
         TableLayout.Font.Style := TableLayout.Font.Style + [fsBold];
      if FieldByName('FontItalic').AsBoolean then
         TableLayout.Font.Style := TableLayout.Font.Style + [fsItalic];
      if FieldByName('FontUnderline').AsBoolean then
         TableLayout.Font.Style := TableLayout.Font.Style + [fsUnderline];
      if FieldByName('FontStrikeout').AsBoolean then
         TableLayout.Font.Style := TableLayout.Font.Style + [fsStrikeout];
      ShapeComboBox.ItemIndex := FieldByName('ButtonShape').AsInteger;
      case FieldByName('ButtonShape').AsInteger of
       0: TableLayOut.Shape := stCircle;
       1: TableLayOut.Shape := stEllipse;
       2: TableLayOut.Shape := stRectangle;
       3: TableLayOut.Shape := stRoundRect;
       4: TableLayOut.Shape := stRoundSquare;
       5: TableLayOut.Shape := stSquare;
      end;
      TableLayout.Caption := FieldByName('Description').AsString;
      if FieldByName('PropertyFlag').AsBoolean then
         PropertyComboBox.ItemIndex := 0
        else
         PropertyComboBox.ItemIndex := 1;
      AdjustTablePosition;
      if X > 0 then
         CurrentButtonPositionX := X
        else
         CurrentButtonPositionX := 0;
      if Y > 0 then
         CurrentButtonPositionY := Y
        else
         CurrentButtonPositionY := 0;
      TableStatus := FieldByName('Status').AsBoolean;
      ServiceStatus := FieldByName('ServiceStatus').AsInteger;
      TableLocked := FieldByName('TableLocked').AsBoolean;
      if FieldByName('PageFlag').AsInteger <= PageComboBox.Items.Count then
         PageComboBox.ItemIndex := FieldByName('PageFlag').AsInteger - 1
        else
         PageComboBox.ItemIndex := 0;
      CurrentPDAPosition := FieldByName('PDAPosition').AsInteger;
      MinimumChargeEdit.Text := Format('%10.2f', [FieldByName('MinimumChargePerTable').AsFloat]);
      Close;
     end;
end;

function TTableEditForm.SaveTablePro: boolean;
var
 SQLStr, TableNoTemp, SeatsTemp, FontNameTemp, FontSizeTemp, FontBoldTemp,
 FontItalicTemp, FontUnderlineTemp, FontStrikeoutTemp, TableStatusTemp,
 ButtonHeightTemp, ButtonWidthTemp, ButtonXTemp, ButtonYTemp, TableLockedTemp,
 ButtonShapeTemp, PropertyFlag, Description, TablePage, MinimumCharge: string;
begin
 SQLStr := 'Delete From TableSet Where TableNo=' + Chr(39) + CheckQuotes(TableNoEdit.Text) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Not Result then Exit;
 TableNoTemp := Chr(39) + CheckQuotes(TableNoEdit.Text) + Chr(39);
 if SeatEdit.Text <> '' then
    SeatsTemp := IntToStr(StrToInt(SeatEdit.Text))
   else
    SeatsTemp := '0';
 FontNameTemp := Chr(39) + CheckQuotes(TableLayout.Font.Name) + Chr(39);
 FontSizeTemp := IntToStr(ABS(TableLayout.Font.Size));
 if fsBold in TableLayout.Font.Style then
    FontBoldTemp := '1'
   else
    FontBoldTemp := '0';
 if fsItalic in TableLayout.Font.Style then
    FontItalicTemp := '1'
   else
    FontItalicTemp := '0';
 if fsUnderline in TableLayout.Font.Style then
    FontUnderlineTemp := '1'
   else
    FontUnderlineTemp := '0';
 if fsStrikeout in TableLayout.Font.Style then
    FontStrikeoutTemp := '1'
   else
    FontStrikeoutTemp := '0';
 if TableStatus then
    TableStatusTemp := '1'
   else
    TableStatusTemp := '0';
 ButtonHeightTemp := IntToStr(ABS(TableLayout.Height));
 ButtonWidthTemp := IntToStr(ABS(TableLayout.Width));
 ButtonXTemp := IntToStr(ABS(CurrentButtonPositionX));
 ButtonYTemp := IntToStr(ABS(CurrentButtonPositionY));
 ButtonShapeTemp := IntToStr(ShapeComboBox.ItemIndex);
 if PropertyComboBox.ItemIndex = 0 then
    PropertyFlag := '1'
   else
    PropertyFlag := '0';
 if DescriptionEdit.Text <> '' then
    Description := Chr(39) + CheckQuotes(DescriptionEdit.Text) + Chr(39)
   else
    Description := 'Null';
 if PageComboBox.ItemIndex >= 0 then
    TablePage := IntToStr(PageComboBox.ItemIndex + 1)
   else
    TablePage := '1';
 if (OpFlag = sNewStatus) or (CurrentPDAPOsition = 0) or
    Not TestPDAPosition(CurrentPDAPosition) then
    CurrentPDAPosition := GeneratePDAPosition;
 if MinimumChargeEdit.Text <> '' then
    MinimumCharge := MinimumChargeEdit.Text
   else
    MinimumCharge := '0';
 if TableLocked then
    TableLockedTemp := '1'
   else
    TableLockedTemp := '0';
 SQLStr := 'INSERT INTO TableSet(TableNo, Seats, Status, FontName, FontSize, ' +
           'FontBold, FontItalic, FontUnderline, FontStrikeout, ButtonShape, ' +
           'ButtonWidth, ButtonHeight, ButtonX, ButtonY, PropertyFlag, ' +
           'Description, PageFlag, PDAPosition, MinimumChargePerTable, ' +
           'ServiceStatus, TableLocked) ' +
           'VALUES(' + TableNoTemp + ',' + SeatsTemp + ',' + TableStatusTemp + ',' +
           FontNameTemp + ',' + FontSizeTemp + ',' + FontBoldTemp + ',' +
           FontItalicTemp + ',' + FontUnderlineTemp + ',' + FontStrikeoutTemp + ',' +
           ButtonShapeTemp + ',' + ButtonWidthTemp + ',' + ButtonHeightTemp + ',' +
           ButtonXTemp + ',' + ButtonYTemp + ',' + PropertyFlag + ',' +
           Description + ',' + TablePage + ',' + IntToStr(CurrentPDAPosition) + ',' +
           MinimumCharge + ',' + IntToStr(ServiceStatus) + ',' + TableLockedTemp + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TTableEditForm.TestTableNo: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select Count(*) From TableSet Where TableNo = ' +
           Chr(39) + CheckQuotes(TableNoEdit.Text) + Chr(39);
 Result := DataForm.CheckCodeSQLPro(SQLStr) <> 0;
end;

function TTableEditForm.TestPDAPosition(PDAPosition: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select Count(*) From TableSet Where PropertyFlag <> 0 and ' +
           'PDAPosition=' + IntToStr(PDAPosition);
 Result := DataForm.CheckCodeSQLPro(SQLStr) <> 0;
end;

function TTableEditForm.GeneratePDAPosition: integer;
var
 SQLStr: string;
begin
 SQLStr := 'Select Max(PDAPosition) As PDAPosition From TableSet';
 OpenQuery(SQLStr);
 with Query do
  begin
   if FieldByName('PDAPosition').AsInteger >= 0 then
      Result := FieldByName('PDAPosition').AsInteger + 1
     else
      Result := 1;
   Close;
  end;
end;

function TTableEditForm.ProcessEditTable: Boolean;
begin
 if (OldTableNo <> TableNoEdit.Text) and TestTableNo then
    begin
     MessageBoxForm.MessagePro('Table: ' + TableNoEdit.Text + ' is already exist.', sErrorMsg);
     Result := False;
    end
   else
    begin
     Result := DataForm.ExecQueryPro('Delete From TableSet Where TableNo=' +
               Chr(39) + CheckQuotes(OldTableNo) + Chr(39));
     if Result then Result := SaveTablePro;
    end;
end;

function TTableEditForm.ProcessNewTable: boolean;
begin
 if TestTableNo then
    begin
     MessageBoxForm.MessagePro(TableNoEdit.Text + ' is already exist.', sErrorMsg);
     Result := False;
    end
   else
    Result := SaveTablePro;
end;

procedure TTableEditForm.SaveButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 if TableNoEdit.Text = '' then
     begin
      MessageBoxForm.MessagePro('Table No. is invalid!', sErrorMsg);
      Exit;
     end;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  if OpFlag = sNewStatus then
     Flag := ProcessNewTable
    else
     Flag := ProcessEditTable;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      OldTableNo := TableNoEdit.Text;
      ReturnFlag := True;
      Close;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TTableEditForm.ReadTablePageInfo;
var
 SQLStr: string;
begin
 PageComboBox.Items.Clear;
 SQLStr := 'Select * From TablePage Order By PageNo';
 OpenQuery(SQLStr);
 with Query do
  begin
   if Active and (RecordCount >= 1) then
      while Not EOF do
       begin
        PageComboBox.Items.Add(FieldByName('Description').AsString);
        Next;
       end;
   Close;
  end;
end;

procedure TTableEditForm.MinimumChargeEditDblClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TEdit do
  begin
   NumStr := Text;
   if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Minimum Charge', 0) then
      Text := NumStr;
  end;
end;

procedure TTableEditForm.MinimumChargeEditEnter(Sender: TObject);
begin
  if MinimumChargeEdit.Text <> '' then
    begin
     MinimumChargeEdit.Text := FloatToStr(StrToFloat(MinimumChargeEdit.Text));
     MinimumChargeEdit.SelectAll;
    end;
end;

procedure TTableEditForm.MinimumChargeEditExit(Sender: TObject);
begin
 if CheckNum(MinimumChargeEdit.Text, 10, 99999.99, 0, 'F') then
    MinimumChargeEdit.Text := Format('%10.2f', [StrToFloat(MinimumChargeEdit.Text)])
   else
    begin
     MinimumChargeEdit.Text := '0';
     MinimumChargeEdit.SetFocus;
    end;
end;

procedure TTableEditForm.MinimumChargeEditKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SaveButton.SetFocus;
end;

procedure TTableEditForm.FormShow(Sender: TObject);
begin
 Width := bsSkinPanel.Width + 28;
 Height := CancelButton.Top + 86;
 ReadTablePageInfo;
 InitEditPanel;
 if OpFlag = sEditStatus then ReadTableMessage;
 TableNoEdit.SetFocus;
end;

function TTableEditForm.TableEditPro(var TableNo: string; X, Y, H, W: integer;
         OpFlag: integer): boolean;
begin
 Application.CreateForm(TTableEditForm, TableEditForm);
 TableEditForm.OldTableNo := TableNo;
 TableEditForm.OpFlag := OpFlag;
 TableEditForm.X := X;
 TableEditForm.Y := Y;
 TableEditForm.H := H;
 TableEditForm.W := W;
 TableEditForm.ShowModal;
 Result := TableEditForm.ReturnFlag;
 if Result then TableNo := TableEditForm.OldTableNo;
 TableEditForm.Free;
end;

end.
