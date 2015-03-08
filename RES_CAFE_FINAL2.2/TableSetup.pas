unit TableSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, GButton, Menus, DB, ADODB, UtilUnit, ComCtrls,
  bsSkinCtrls, bsSkinTabs, XiButton;

type
  TTableSetupForm = class(TForm)
    Query: TADOQuery;
    PositionXEdit: TEdit;
    PositionYEdit: TEdit;
    Bevel1: TBevel;
    TabControl: TbsSkinTabControl;
    BackPanel: TbsSkinPanel;
    WorkPanel: TbsSkinPanel;
    TablePanel: TPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    NewButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    PageSetupButton: TXiButton;
    CloseButton: TXiButton;
    PDALayoutButton: TXiButton;
    procedure OpenQuery(SQLStr: string);
    procedure OpenTableSetQuery;
    procedure GButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TableSetupPro;
    procedure CloseButtonClick(Sender: TObject);
    procedure ShowTable;
    procedure GButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure EditTableMessagePro;
    procedure EditButtonClick(Sender: TObject);
    procedure PositionXEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PositionXEditExit(Sender: TObject);
    procedure PositionXEditKeyPress(Sender: TObject; var Key: Char);
    procedure PositionYEditExit(Sender: TObject);
    procedure PositionYEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PositionYEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure PositionXEditDblClick(Sender: TObject);
    procedure PositionYEditDblClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    function  SaveData: boolean;
    procedure PageSetupButtonClick(Sender: TObject);
    procedure ReadTablePageInfo;
    procedure PDALayoutButtonClick(Sender: TObject);
  private { Private declarations }
    CurrentButton: TGButton;
    CurrentX, CurrentY: integer;
    CurrentTableName: string;
  public
    { Public declarations }
  end;

var
  TableSetupForm: TTableSetupForm;

implementation

uses DataUnit, MainMenu, MessageBox, TableEdit, NumPad, TablePageSetup,
     PDATableLayout;

{$R *.dfm}

procedure TTableSetupForm.OpenQuery(SQLStr: string);
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

procedure TTableSetupForm.OpenTableSetQuery;
var
 SQLStr: string;
begin
 if TabControl.TabIndex <= 0 then
    SQLStr := 'Select * From TableSet Where PageFlag=1 Order By TableNo'
   else
    SQLStr := 'Select * From TableSet Where PageFlag=' + IntToStr(TabControl.TabIndex + 1) +
              ' Order By TableNo';
 OpenQuery(SQLStr);
end;

procedure TTableSetupForm.GButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if CurrentButton <> NIL then CurrentButton.Pen.Width := 1;
 CurrentButton := Sender As TGButton;
 with Sender As TGButton do
  begin
   Pen.Width := 2;
   PositionXEdit.Text := IntToStr(Left);
   PositionYEdit.Text := IntToStr(Top);
   CurrentTableName := Copy(Name, 7, 15);
  end;
 CurrentX := X;
 CurrentY := Y;
end;

procedure TTableSetupForm.GButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 CurrentButton := Sender As TGButton;
 with Sender As TGButton do
  begin
   PositionXEdit.Text := IntToStr(Left);
   PositionYEdit.Text := IntToStr(Top);
   CurrentTableName := Copy(Name, 7, 15);
  end;
end;

procedure TTableSetupForm.GButtonClick(Sender: TObject);
begin
 CurrentButton := Sender As TGButton;
 with Sender As TGButton do
  CurrentTableName := Copy(Name, 7, 15);
end;

procedure TTableSetupForm.GButtonMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
 with Sender As TGButton do
  begin
   if Shift = [ssLeft] then
      begin
       case Screen.Cursor of
        crSizeNWSE: case Shape of
                     stCircle, stRoundSquare, stSquare: begin Width := X; Height := X; end;
                     stEllipse, stRectangle, stRoundRect: begin Width := X; Height := Y; end;
                    end;
        crSizeWE: case Shape of
                   stCircle, stRoundSquare, stSquare: begin Width := X; Height := X; end;
                   stEllipse, stRectangle, stRoundRect: Width := X;
                  end;
        crSizeNS: case Shape of
                   stCircle, stRoundSquare, stSquare: begin Width := Y; Height := Y; end;
                   stEllipse, stRectangle, stRoundRect: Height := Y;
                  end;
        crDefault: begin
                    if (Left + X - CurrentX > 0) and (Left + X - CurrentX < TablePanel.ClientWidth - Width) then
                       begin
                        Left := Left + X - CurrentX;
                        PositionXEdit.Text := IntToStr(Left);
                       end;
                    if (Top + Y - CurrentY > 0) and (Top + Y - CurrentY < TablePanel.ClientHeight - Height) then
                       begin
                        Top := Top + Y - CurrentY;
                        PositionYEdit.Text := IntToStr(Top);
                       end;
                   end;
       end;
      end
     else
      begin
       if (X > Width - 5) and (X < Width) and (Y > Height - 5) and (Y < Height) then
          Screen.Cursor := crSizeNWSE
         else
          if (X > Width - 5) and (X < Width) then Screen.Cursor := crSizeWE
             else
              if (Y > Height - 5) and (Y < Height) then Screen.Cursor := crSizeNS
                 else
                  Screen.Cursor := crDefault;
      end;
  end;
end;

procedure TTableSetupForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
 Screen.Cursor := crDefault;
end;

function TTableSetupForm.SaveData: boolean;
var
 SQLStr, TableNo: string;
 PositionX, PositionY: integer;
begin
 Result := DataForm.BeginTransaction;
 if Not Result then Exit;
 try
  Query.First;
  while Not Query.EOF and Result do
   begin
    TableNo := DeleteSpace(Query.FieldByName('TableNo').AsString);
    with TGButton(FindComponent('Button' + TableNo)) do
     begin
      if Left > 0 then
         PositionX := ABS(Left)
        else
         PositionX := 0;
      if Top > 0 then
         PositionY := ABS(Top)
        else
         PositionY := 0;
      SQLStr := 'Update TableSet Set ' +
                ' ButtonX=' + IntToStr(PositionX) +
                ',ButtonY=' + IntToStr(PositionY) +
                ',ButtonWidth=' + IntToStr(ABS(Width)) +
                ',ButtonHeight=' + IntToStr(ABS(Height)) +
                ' Where TableNo=' + Chr(39) + CheckQuotes(TableNo) + Chr(39);
      Result := DataForm.ExecQueryPro(SQLStr);
      Destroy;
    end;
    Query.Next;
   end;
  finally
   if Result then
      DataForm.CommitTransaction
     else
      DataForm.RollBack;
  end;
 CurrentButton := NIL;
end;

procedure TTableSetupForm.CloseButtonClick(Sender: TObject);
begin
 if SaveData then Close;
end;

procedure TTableSetupForm.ShowTable;
begin
 with TGButton.Create( Self ) do
  begin
   Parent := TablePanel;
   if Query.FieldByName('ButtonX').AsInteger > 0 then
      Left := Query.FieldByName('ButtonX').AsInteger
     else
      Left := 0;
   if Query.FieldByName('ButtonY').AsInteger > 0 then
      Top := Query.FieldByName('ButtonY').AsInteger
     else
      Top := 0;
   Width := ABS(Query.FieldByName('ButtonWidth').AsInteger);
   Height := ABS(Query.FieldByName('ButtonHeight').AsInteger);
   case Query.FieldByName('ButtonShape').AsInteger of
    0: Shape := stCircle;
    1: Shape := stEllipse;
    2: Shape := stRectangle;
    3: Shape := stRoundRect;
    4: Shape := stRoundSquare;
    5: Shape := stSquare;
   end;
  Name := 'Button' + DeleteSpace(Query.FieldByName('TableNo').AsString);
  Caption := Query.FieldByName('Description').AsString;
  if (MinimumChargeKind = 2) and (Query.FieldByName('MinimumChargePerTable').AsFloat >= 0.01) then
     Caption := Caption + Chr(13) + '$' + Query.FieldByName('MinimumChargePerTable').AsString;
  Font.Name := Query.FieldByName('FontName').AsString;
  Font.Size := ABS(Query.FieldByName('FontSize').AsInteger);
  Font.Color := clBlack;
  Font.Style := [];
  if Query.FieldByName('FontBold').AsBoolean then
     Font.Style := Font.Style + [fsBold];
  if Query.FieldByName('FontItalic').AsBoolean then
     Font.Style := Font.Style + [fsItalic];
  if Query.FieldByName('FontUnderline').AsBoolean then
     Font.Style := Font.Style + [fsUnderline];
  if Query.FieldByName('FontStrikeout').AsBoolean then
     Font.Style := Font.Style + [fsStrikeout];
  OnMouseDown := GButtonMouseDown;
  OnMouseUp := GButtonMouseUp;
  OnMouseMove := GButtonMouseMove;
  OnClick := GButtonClick;
 end;
end;

procedure TTableSetupForm.DeleteButtonClick(Sender: TObject);
var
 TableNo, SQLStr: string;
 Flag: Boolean;
begin
 if (CurrentButton = NIL) or
    (MessageBoxForm.MessagePro('Are you sure you want to delete this Table No?', sConfirmMsg) = mrNo) then
    Exit;
 Flag := False;
 TableNo := CurrentTableName;
 SQLStr := 'Delete From TableSet Where TableNo=' + Chr(39) + CheckQuotes(TableNo) + Chr(39);
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := DataForm.ExecQueryPro(SQLStr);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      TGButton(FindComponent('Button' + TableNo)).Destroy;
      CurrentButton := Nil;
      CurrentTableName := '';
      OpenTableSetQuery;
     end
    else
     DataForm.RollBack;
  end;
end;

procedure TTableSetupForm.NewButtonClick(Sender: TObject);
var
 TableNo: string;
begin
 if TableEditForm.TableEditPro(TableNo, 0, 0, 0, 0, sNewStatus) then
    begin
     OpenTableSetQuery;
     Query.Locate('TableNo', TableNo, [loPartialKey]);
     if DeleteSpace(Query.FieldByName('TableNo').AsString) = TableNo then
        ShowTable;
    end;
end;

procedure TTableSetupForm.EditTableMessagePro;
var
 OldTableNo, TableNo: string;
 X, Y, H, W: integer;
begin
 if CurrentButton = NIL then Exit;
 with CurrentButton do
  begin
   TableNo := CurrentTableName;
   X := Left;
   Y := Top;
   H := Height;
   W := Width;
  end;
 OldTableNo := TableNo;
 if TableEditForm.TableEditPro(TableNo, X, Y, H, W, sEditStatus) then
    begin
     TGButton(FindComponent('Button' + OldTableNo)).Destroy;
     OpenTableSetQuery;
     Query.Locate('TableNo', TableNo, [loPartialKey]);
     if DeleteSpace(Query.FieldByName('TableNo').AsString) = TableNo then
        begin
         ShowTable;
         CurrentButton := TGButton(FindComponent('Button' + TableNo));
         CurrentButton.Pen.Width := 2;
         CurrentTableName := TableNo;
        end
       else
        begin
         CurrentButton := NIL;
         CurrentTableName := '';
        end;
    end;
end;

procedure TTableSetupForm.EditButtonClick(Sender: TObject);
begin
 EditTableMessagePro;
end;

procedure TTableSetupForm.PositionXEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PositionXEditExit(Sender);
end;

procedure TTableSetupForm.PositionXEditExit(Sender: TObject);
begin
 if CurrentButton = NIL then Exit;
 if CheckNum(PositionXEdit.Text, 4, 9999, 0, 'D') and
   (StrToInt(PositionXEdit.Text) > 0) and
   (StrToInt(PositionXEdit.Text) < TablePanel.ClientWidth - CurrentButton.Width) then
   begin
    CurrentButton.Left := StrToInt(PositionXEdit.Text);
   end
  else
   PositionXEdit.Text := IntToStr(CurrentButton.Left);
end;

procedure TTableSetupForm.PositionXEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Not (Key In ['0'..'9', Chr(8), Chr(13)]) then Key := Chr(0);
end;

procedure TTableSetupForm.PositionYEditExit(Sender: TObject);
begin
 if CurrentButton = NIL then Exit;
 if CheckNum(PositionYEdit.Text, 4, 9999, 0, 'D') and
    (StrToInt(PositionYEdit.Text) > 0) and
    (StrToInt(PositionYEdit.Text) < TablePanel.ClientHeight - CurrentButton.Height) then
    begin
     CurrentButton.Top := StrToInt(PositionYEdit.Text);
    end
   else
    PositionYEdit.Text := IntToStr(CurrentButton.Top);
end;

procedure TTableSetupForm.PositionYEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PositionYEditExit(Sender);
end;

procedure TTableSetupForm.PositionYEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Not (Key In ['0'..'9', Chr(8), Chr(13)]) then Key := Chr(0);
end;

procedure TTableSetupForm.PositionXEditDblClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TEdit do
  begin
   NumStr := Text;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Position X', 0) then
      begin
        Text := NumStr;
        PositionXEditExit(Sender);
      end;
  end;
end;

procedure TTableSetupForm.PositionYEditDblClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TEdit do
  begin
   NumStr := Text;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Position Y', 0) then
      begin
       Text := NumStr;
       PositionYEditExit(Sender);
      end;
  end;
end;

procedure TTableSetupForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TTableSetupForm.TabControlChange(Sender: TObject);
begin
 if SaveData then
    begin
     OpenTableSetQuery;
     while Not Query.EOF do
      begin
       ShowTable;
       Query.Next;
      end;
    end
end;

procedure TTableSetupForm.ReadTablePageInfo;
var
 SQLStr: string;
begin
 TabControl.Tabs.Clear;
 SQLStr := 'Select * From TablePage Order By PageNo';
 OpenQuery(SQLStr);
 with Query do
  begin
   if Active and (RecordCount > 1) then
      while Not EOF do
       begin
        TabControl.Tabs.Add(FieldByName('Description').AsString);
        Next;
       end;
   Close;
  end;
end;

procedure TTableSetupForm.PDALayoutButtonClick(Sender: TObject);
begin
 PDATableLayoutForm.PDATableLayoutSetup;
end;

procedure TTableSetupForm.PageSetupButtonClick(Sender: TObject);
begin
 if TablePageSetupForm.TablePageSetupPro and SaveData then
    begin
     ReadTablePageInfo;
     TabControl.TabIndex := 0;
     OpenTableSetQuery;
     while Not Query.EOF do
      begin
       ShowTable;
       Query.Next;
      end;
    end;
end;

procedure TTableSetupForm.FormShow(Sender: TObject);
begin
 ReadTablePageInfo;
 OpenTableSetQuery;
 while Not Query.EOF do
  begin
   ShowTable;
   Query.Next;
  end;
 Top := 0; Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
end;

procedure TTableSetupForm.TableSetupPro;
begin
 Application.CreateForm(TTableSetupForm, TableSetupForm);
 TableSetupForm.ShowModal;
 TableSetupForm.Free;
end;

end.
