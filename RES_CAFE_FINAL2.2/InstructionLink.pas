unit InstructionLink;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Grids, DBGrids, Db, StdCtrls, Buttons, DBCtrls, ADODB,
  bsSkinCtrls, BusinessSkinForm, bsSkinTabs, XiButton;

type
  TInstructionLinkForm = class(TForm)
    DBGrid: TDBGrid;
    StringGrid: TStringGrid;
    DataSource: TDataSource;
    ItemDescriptionLabel: TLabel;
    Query: TADOQuery;
    QueryItemCode: TStringField;
    QueryDescription1: TStringField;
    QueryPrice: TFloatField;
    QueryInstruction: TBooleanField;
    TempQuery: TADOQuery;
    SearchComboBox: TComboBox;
    SearchEdit: TEdit;
    InstructionCheckBox: TCheckBox;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    SearchPanel: TbsSkinPanel;
    TitlePanel: TbsSkinPanel;
    TabControl: TbsSkinTabControl;
    StringGridPanel: TbsSkinPanel;
    NewButton: TXiButton;
    InsertButton: TXiButton;
    DeleteButton: TXiButton;
    QtyButton: TXiButton;
    PriceButton: TXiButton;
    InstructionButton: TXiButton;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    NotesLabel: TStaticText;
    procedure OpenQuery;
    procedure OpenTempQuery(SQLStr: string);
    procedure NewButtonClick(Sender: TObject);
    procedure InitStringGrid;
    procedure InitBuff;
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure DeleteFromStringGrid;
    function  CheckCode(Code: string): boolean;
    function  FindLastRow: integer;
    procedure DeleteButtonClick(Sender: TObject);
    procedure InsertButtonClick(Sender: TObject);
    procedure ReadInstructionLinkData;
    procedure PostBuffDataToStringGrid;
    procedure PostStringGriddataToBuff;
    function  SaveInstructionLinkData: boolean;
    procedure CancelButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabControlChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InstructionLinkPro(ItemCode, Description: string);
    procedure DBGridDblClick(Sender: TObject);
    procedure QtyButtonClick(Sender: TObject);
    procedure PriceButtonClick(Sender: TObject);
    procedure SetDescription(ARow: integer);
    procedure InstructionButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SearchComboBoxChange(Sender: TObject);
    procedure SearchEditChange(Sender: TObject);
    procedure InstructionCheckBoxClick(Sender: TObject);
    procedure StringGridDblClick(Sender: TObject);
  private { Private declarations }
    Buff: array [0..2, 0..6, 1..50] of String;
    ItemCode, Description: string;
    CurrentPage: integer;
  public
    { Public declarations }
  end;

var
  InstructionLinkForm: TInstructionLinkForm;

implementation

uses DataUnit, UtilUnit, MainMenu, MenuItemEdit, NumPad, Instruction;

{$R *.DFM}

procedure TInstructionLinkForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select ItemCode, Description1, Price, Instruction From MenuItem ';
 if SearchEdit.Text <> '' then
    case SearchComboBox.ItemIndex of
     0: if Not InstructionCheckBox.Checked  then
           SQLStr := SQLStr + 'Where ItemCode Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39)
          else
           SQLStr := SQLStr + 'Where Instruction = 1 and ItemCode Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
     1: if Not InstructionCheckBox.Checked then
           SQLStr := SQLStr + 'Where Description1 Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39)
          else
           SQLStr := SQLStr + 'Where Instruction = 1 and Description1 Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
    end
   else
    begin
     if InstructionCheckBox.Checked then SQLStr := SQLStr + ' Where Instruction = 1';
    end;
 if SearchComboBox.ItemIndex = 0 then
    SQLStr := SQLStr + ' Order By ItemCode'
   else
    SQLStr := SQLStr + ' Order By Description1';
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

procedure TInstructionLinkForm.OpenTempQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with TempQuery do
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

procedure TInstructionLinkForm.NewButtonClick(Sender: TObject);
var
 Code: string;
begin
 if MenuItemEditForm.MenuItemEditPro(Code, '', sNewStatus) then
    begin
     OpenQuery;
     Query.Locate('ItemCode', Code, [loPartialKey]);
    end;
end;

procedure TInstructionLinkForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   Cells[0, 0] := 'Code';
   Cells[1, 0] := 'Description';
   Cells[2, 0] := 'Qty';
   Cells[3, 0] := 'Price';
   Cells[4, 0] := '*';
   Cells[5, 0] := '';
   for I := 1 to 50 do
    begin
     Cells[0, I] := ''; Cells[1, I] := '';
     Cells[2, I] := ''; Cells[3, I] := '';
     Cells[4, I] := ''; Cells[5, I] := '';
    end;
   Row := 1; Col := 0;
  end;
end;

procedure TInstructionLinkForm.InitBuff;
Var
 I, J: integer;
begin
 for I := 0 to 2 do
  for J := 1 to 50 do
   begin
    Buff[I, 0, J] := ''; Buff[I, 1, J] := '';
    Buff[I, 2, J] := ''; Buff[I, 3, J] := '';
    Buff[I, 4, J] := ''; Buff[I, 5, J] := '';
   end;
end;

procedure TInstructionLinkForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   X := (Rect.Left + Rect.Right) div 2;
   if ARow > 0 then
      case ACol of
        0, 4, 5: begin
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
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
      end;
    Canvas.Font.Name := 'Arial';  
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TInstructionLinkForm.DeleteFromStringGrid;
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
    end;
   Cells[0, 50] := ''; Cells[1, 50] := '';
   Cells[2, 50] := ''; Cells[3, 50] := '';
   Cells[4, 50] := ''; Cells[5, 50] := '';
  end;
end;

function TInstructionLinkForm.CheckCode(Code: string): boolean;
var
 I: integer;
begin
 I := 1;
 Result := True;
 while Result and (I <= 50) do
  begin
   Result := StringGrid.Cells[0, I] <> Code;
   I := I + 1;
  end;
end;

function TInstructionLinkForm.FindLastRow: integer;
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
            Cells[0, J] := Cells[0, I];
            Cells[1, J] := Cells[1, I];
            Cells[2, J] := Cells[2, I];
            Cells[3, J] := Cells[3, I];
            Cells[4, J] := Cells[4, I];
            Cells[5, J] := Cells[5, I];
           end;
        J := J + 1;
       end;
   end;
 if J <= 50 then
    Result := J
   else
    Result := 50;
end;

procedure TInstructionLinkForm.DeleteButtonClick(Sender: TObject);
begin
 DeleteFromStringGrid;
end;

procedure TInstructionLinkForm.InsertButtonClick(Sender: TObject);
var
 I: integer;
 CurrentItemCode: string;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      DisableControls;
      CurrentItemCode := FieldByName('ItemCode').AsString;
      First;
      while Not EOF do
       begin
        if DBGrid.SelectedRows.CurrentRowSelected and
          (FieldByName('ItemCode').AsString <> ItemCode) and
           CheckCode(FieldByName('ItemCode').AsString) then
           begin
            I := FindLastRow; StringGrid.Row := I;
            StringGrid.Cells[0, I] := FieldByName('ItemCode').AsString;
            StringGrid.Cells[1, I] := FieldByname('Description1').AsString;
            StringGrid.Cells[2, I] := '1.00';
            StringGrid.Cells[3, I] := Format('%4.2f', [FieldByName('Price').AsFloat]);
            StringGrid.Cells[4, I] := '';
            if FieldByName('Instruction').AsBoolean then
               StringGrid.Cells[5, I] := '1'
              else
               StringGrid.cells[5, I] := '0';
            SetDescription(I);
           end;
        Next;
       end;
      DBGrid.SelectedRows.Clear;
      First;
      Query.Locate('ItemCode', CurrentItemCode, [loPartialKey]);
      EnableControls;
     end;
end;

procedure TInstructionLinkForm.ReadInstructionLinkData;
var
 I, J: integer;
 SQLStr: string;
begin
 InitBuff;
 for I := 0 to 2 do
  begin
   SQLStr := 'Select Code, Description1, Qty, InstructionLink.Price, Condition, ' +
             'MaximunCharge ' +
             'From InstructionLink, MenuItem ' +
             'Where InstructionLink.Code=MenuItem.ItemCode and ' +
             'InstructionLink.ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
             ' and Kind=' + IntToStr(I) +
             ' Order By InstructionLink.ID';
   OpenTempQuery(SQLStr);
   if TempQuery.RecordCount > 0 then
      begin
       TempQuery.First;
       J := 1;
       while Not TempQuery.EOF do
        begin
         Buff[I, 0, J] := TempQuery.FieldByName('Code').AsString;
         Buff[I, 1, J] := TempQuery.fieldByName('Description1').AsString;
         Buff[I, 2, J] := Format('%4.2f', [TempQuery.FieldByName('Qty').AsFloat]);
         Buff[I, 3, J] := Format('%4.2f', [TempQuery.fieldByName('Price').AsFloat]);
         if TempQuery.FieldByName('MaximunCharge').AsBoolean then
            Buff[I, 4, J] := '*'
           else
            Buff[I, 4, J] := '';
         Buff[I, 5, J] := IntToStr(TempQuery.FieldByName('Condition').AsInteger);
         J := J + 1; TempQuery.Next;
        end;
      end;
  end;
 TempQuery.Close;
end;

procedure TInstructionLinkForm.PostBuffDataToStringGrid;
var
 I, J: integer;
begin
 InitStringGrid;
 J := 1;
 for I := 1 to 50 do
  if Buff[CurrentPage, 0, I] <> '' then
     begin
      StringGrid.Cells[0, J] := Buff[CurrentPage, 0, I];
      StringGrid.Cells[1, J] := Buff[CurrentPage, 1, I];
      StringGrid.Cells[2, J] := Buff[CurrentPage, 2, I];
      StringGrid.Cells[3, J] := Buff[CurrentPage, 3, I];
      StringGrid.Cells[4, J] := Buff[CurrentPage, 4, I];
      StringGrid.Cells[5, J] := Buff[CurrentPage, 5, I];
      SetDescription(J);
      J := J + 1;
     end;
end;

procedure TInstructionLinkForm.PostStringGridDataToBuff;
var
 I, J: integer;
begin
 for I := 1 to 50 do
  begin
   Buff[CurrentPage, 0, I] := '';
   Buff[CurrentPage, 1, I] := '';
   Buff[CurrentPage, 2, I] := '';
   Buff[CurrentPage, 3, I] := '';
   Buff[CurrentPage, 4, I] := '';
   Buff[CurrentPage, 5, I] := '';
  end;
 J := 1;
 for I := 1 to 50 do
  if StringGrid.Cells[0, I] <> '' then
     begin
      Buff[CurrentPage, 0, J] := StringGrid.Cells[0, I];
      Buff[CurrentPage, 1, J] := StringGrid.Cells[1, I];
      Buff[CurrentPage, 2, J] := StringGrid.Cells[2, I];
      Buff[CurrentPage, 3, J] := StringGrid.Cells[3, I];
      Buff[CurrentPage, 4, J] := StringGrid.Cells[4, I];
      Buff[CurrentPage, 5, J] := StringGrid.Cells[5, I];
      J := J + 1;
     end;
end;

function TInstructionLinkForm.SaveInstructionLinkData: boolean;
var
 SQLStr, QtyTemp, PriceTemp, Condition, MaximunCharge: string;
 PageNo, I: integer;
begin
 Result := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  SQLStr := 'Delete From InstructionLink Where ItemCode=' +
            Chr(39) + CheckQuotes(ItemCode) + Chr(39);
  Result := DataForm.ExecQueryPro(SQLStr);
  PageNo := 0;
  while Result and (PageNo <=2) do
   begin
    I := 1;
    while Result and (I <= 50) do
     begin
       if Buff[PageNo, 0, I] <> '' then
          begin
           if Buff[PageNo, 2, I] <> '' then
              QtyTemp := Buff[PageNo, 2, I]
             else
              QtyTemp := '0.0';
           if Buff[PageNo, 3, I] <> '' then
              PriceTemp := Buff[PageNo, 3, I]
             else
              PriceTemp := '0.0';
           if Buff[PageNo, 4, I] = '*' then
              MaximunCharge := '1'
             else
              MaximunCharge := '0';
           if Buff[PageNo, 5, I] <> '' then
              Condition := Buff[PageNo, 5, I]
             else
              Condition := '0';
           SQLStr := 'Insert Into InstructionLink(Code, ItemCode, Kind, Qty, ' +
                     'Price, Condition, MaximunCharge, ID) ' +
                     'Values(' + Chr(39) + CheckQuotes(Buff[PageNo, 0, I]) + Chr(39) +
                     ',' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) + ',' +
                     IntToStr(PageNo) + ',' + QtyTemp + ',' + PriceTemp + ',' +
                     Condition + ',' + MaximunCharge + ',' + IntToStr(I) + ')';
           Result := DataForm.ExecQueryPro(SQLStr);
          end;
      I := I + 1;
     end;
    PageNo := PageNo + 1;
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

procedure TInstructionLinkForm.QtyButtonClick(Sender: TObject);
var
 NumStr: string;
 I: integer;
begin
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Item Qty', 0) then
    with StringGrid do
     for I := Selection.Top to Selection.Bottom do
      if Cells[0, I] <> '' then
         Cells[2, I] := Format('%4.2f', [StrToFloat(NumStr)]);
end;

procedure TInstructionLinkForm.PriceButtonClick(Sender: TObject);
var
 NumStr: string;
 I: integer;
begin
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Sales Price', 0) then
    with StringGrid do
     for I := Selection.Top to Selection.Bottom do
       if Cells[0, I] <> '' then
          Cells[3, I] := Format('%4.2f', [StrToFloat(NumStr)]);
end;

procedure TInstructionLinkForm.SetDescription(ARow: integer);
var
 TempStr: string;
 Condition: integer;
begin
 with StringGrid do
  if Cells[0, ARow] <> '' then
     begin
      if Cells[5, ARow] <> '' then
         Condition := StrToInt(Cells[5, ARow])
        else
         Condition := 0;
      TempStr := Copy(Cells[1, ARow], 1, 5);
      if (TempStr = '[*] ') or (TempStr = '[A] ') or (TempStr = '[C] ') or
         (TempStr = '[M] ') or (TempStr = '[L] ') then
         TempStr := Copy(Cells[1, ARow], 5, Length(Cells[1, ARow]) - 4)
        else
         TempStr := Cells[1, ARow];
      case Condition of
       0: Cells[1, ARow] := TempStr;
       1: Cells[1, ARow] := '[*] ' + TempStr;
       2: Cells[1, ARow] := '[A] ' + TempStr;
       3: Cells[1, ARow] := '[C] ' + TempStr;
       4: Cells[1, ARow] := '[M] ' + TempStr;
       5: Cells[1, ARow] := '[L] ' + TempStr;
      end;
     end;
end;

procedure TInstructionLinkForm.InstructionButtonClick(Sender: TObject);
var
 Temp, I: integer;
begin
 Temp := InstructionForm.InstructionPro;
 if Temp >= 0 then
    with StringGrid do
     begin
      for I := Selection.Top to Selection.Bottom do
       if Cells[0, I] <> '' then
           begin
            Cells[5, I] := IntToStr(Temp);
            SetDescription(I);
           end;
     end;
end;

procedure TInstructionLinkForm.StringGridDblClick(Sender: TObject);
var
 CurRow: integer;
begin
 with StringGrid do
  begin
   CurRow := Row;
   if Cells[0, CurRow] <> '' then
      begin
       if Cells[4, CurRow] = '*' then
          Cells[4, CurRow] := ''
         else
          Cells[4, CurRow] := '*';
      end;
  end;         
end;

procedure TInstructionLinkForm.DBGridDblClick(Sender: TObject);
begin
 InsertButtonClick(Sender);
end;

procedure TInstructionLinkForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TInstructionLinkForm.SaveButtonClick(Sender: TObject);
begin
 PostStringGriddataToBuff;
 if SaveInstructionLinkData then Close;
end;

procedure TInstructionLinkForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TInstructionLinkForm.TabControlChange(Sender: TObject);
begin
 PostStringGridDataToBuff;
 CurrentPage := TabControl.TabIndex;
 PostBuffDataToStringGrid;
end;

procedure TInstructionLinkForm.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TInstructionLinkForm.SearchComboBoxChange(Sender: TObject);
begin
 SearchEdit.Text := '';
 OpenQuery;
end;

procedure TInstructionLinkForm.SearchEditChange(Sender: TObject);
begin
 OpenQuery;
end;

procedure TInstructionLinkForm.InstructionCheckBoxClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TInstructionLinkForm.FormShow(Sender: TObject);
begin
 Width := TitlePanel.Left + TitlePanel.Width + 22;
 Height := CancelButton.Top + 86;
 InitStringGrid;
 TabControl.TabIndex := 0;
 InstructionCheckBox.Checked := True;
 CurrentPage := 0;
 ReadInstructionLinkData;
 PostBuffDataToStringGrid;
 OpenQuery;
 ItemDescriptionLabel.Caption := ItemCode + ' - ' + Description;
end;

procedure TInstructionLinkForm.InstructionLinkPro(ItemCode, Description: string);
begin
 Application.CreateForm(TInstructionLinkForm, InstructionLinkForm);
 InstructionLinkForm.ItemCode := ItemCode;
 InstructionLinkForm.Description := Description;
 InstructionLinkForm.ShowModal;
 InstructionLinkForm.Free;
end;

end.
