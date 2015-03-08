unit MenuLink;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Grids, DBGrids, Db, StdCtrls, Buttons, DBCtrls, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TMenuLinkForm = class(TForm)
    DBGrid: TDBGrid;
    StringGrid: TStringGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryItemCode: TStringField;
    QueryDescription1: TStringField;
    TempQuery: TADOQuery;
    SearchComboBox: TComboBox;
    SearchEdit: TEdit;
    InstructionCheckBox: TCheckBox;
    CategoryCheckBox: TCheckBox;
    CategoryEdit: TEdit;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    SearchPanel: TbsSkinPanel;
    TitlePanel: TbsSkinPanel;
    StringGridPanel: TbsSkinPanel;
    NewButton: TXiButton;
    InsertButton: TXiButton;
    DeleteButton: TXiButton;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    ItemCodeLabel: TbsSkinLabel;
    ItemDescriptionLabel: TbsSkinLabel;
    NumberOfChoiceLabel: TbsSkinLabel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    QueryPrice: TFloatField;
    QueryInstruction: TBooleanField;
    SubCategoryCheckBox: TCheckBox;
    AutoShowSubMenuCheckBox: TCheckBox;
    procedure OpenQuery;
    procedure OpenTempQuery(SQLStr: string);
    procedure NewButtonClick(Sender: TObject);
    procedure InitStringGrid;
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure DeleteFromStringGrid;
    function  CheckCode(Code: string): boolean;
    function  FindLastRow: integer;
    procedure DeleteButtonClick(Sender: TObject);
    procedure InsertButtonClick(Sender: TObject);
    procedure ReadSubMenuLinkData;
    function  SaveSubMenuLinkData: boolean;
    procedure CancelButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuLinkPro(ItemCode, Description: string);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SearchComboBoxChange(Sender: TObject);
    procedure SearchEditChange(Sender: TObject);
    procedure InstructionCheckBoxClick(Sender: TObject);
    procedure CategoryEditClick(Sender: TObject);
    procedure CategoryCheckBoxClick(Sender: TObject);
    procedure NumberOfChoiceLabelClick(Sender: TObject);
    procedure StringGridDblClick(Sender: TObject);
  private { Private declarations }
    ItemCode, Description: string;
  public
    { Public declarations }
  end;

var
  MenuLinkForm: TMenuLinkForm;

implementation

uses DataUnit, UtilUnit, MainMenu, NumPad, CategorySelect, MessageBox, MenuLinkItemEdit,
  MenuItemEdit;

{$R *.DFM}

procedure TMenuLinkForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select ItemCode, Description1, Instruction, Price From MenuItem ';
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
 if CategoryCheckBox.Checked then
    begin
     if (SearchEdit.Text = '') and Not InstructionCheckBox.Checked
        then SQLStr := SQLStr + ' Where ' else SQLStr := SQLStr + ' and ';
     SQLStr := SQLStr +  'Category=' + Chr(39) + CheckQuotes(CategoryEdit.Text) + Chr(39);
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

procedure TMenuLinkForm.OpenTempQuery(SQLStr: string);
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

procedure TMenuLinkForm.NewButtonClick(Sender: TObject);
var
 Code: string;
begin
 if MenuItemEditForm.MenuItemEditPro(Code, '', sNewStatus) then
    begin
     OpenQuery;
     Query.Locate('ItemCode', Code, [loPartialKey]);
    end;
end;

procedure TMenuLinkForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   Cells[0, 0] := 'Code';
   Cells[1, 0] := 'Description';
   Cells[2, 0] := 'Price';
   Cells[3, 0] := 'Choice';
   Cells[4, 0] := 'Inst';
   for I := 1 to 200 do
    begin
     Cells[0, I] := '';
     Cells[1, I] := '';
     Cells[2, I] := '';
     Cells[3, I] := '';
     Cells[4, I] := '';
    end;
   Row := 1; Col := 1;
  end;
end;

procedure TMenuLinkForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   X := (Rect.Left + Rect.Right) div 2;
   if ARow > 0 then
      case ACol of
        0, 3, 4: begin
            SetTextAlign(Canvas.Handle, TA_CENTER);
            X := (Rect.Left + Rect.Right) div 2;
           end;
        1: begin
            SetTextAlign(Canvas.Handle, TA_LEFT);
            X := Rect.Left + 2;
           end;
        2: begin
            SetTextAlign(Canvas.Handle, TA_RIGHT);
            X := Rect.Right - 2;
           end;
      end
     else
      begin
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TMenuLinkForm.DeleteFromStringGrid;
var
 I: Integer;
 CurrentRow: integer;
begin
 CurrentRow := StringGrid.Row;
 with StringGrid do
  begin
   for I := CurrentRow to 199 do
    begin
     Cells[0, I] := Cells[0, I + 1];
     Cells[1, I] := Cells[1, I + 1];
     Cells[2, I] := Cells[2, I + 1];
     Cells[3, I] := Cells[3, I + 1];
     Cells[4, I] := Cells[4, I + 1];
    end;
   Cells[0, 200] := '';
   Cells[1, 200] := '';
   Cells[2, 200] := '';
   Cells[3, 200] := '';
   Cells[4, 200] := '';
  end;
end;

function TMenuLinkForm.CheckCode(Code: string): boolean;
var
 I: integer;
begin
 I := 1;
 Result := True;
 while Result and (I <= 200) do
  begin
   Result := StringGrid.Cells[0, I] <> Code;
   I := I + 1;
  end;
end;

function TMenuLinkForm.FindLastRow: integer;
var
 I, J: integer;
begin
 J := 1;
 with StringGrid do
  for I := 1 to 200 do
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
           end;
        J := J + 1;
       end;
   end;
 if J <= 200 then
    Result := J
   else
    Result := 200;
end;

procedure TMenuLinkForm.DeleteButtonClick(Sender: TObject);
begin
 DeleteFromStringGrid;
end;

procedure TMenuLinkForm.InsertButtonClick(Sender: TObject);
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
            StringGrid.Cells[2, I] := Format('%4.2f', [FieldByName('Price').AsFloat]);
            StringGrid.Cells[3, I] := '';
            if FieldByName('Instruction').AsBoolean then
               StringGrid.Cells[4, I] := 'Y'
              else
               StringGrid.Cells[4, I] := '';
           end;
        Next;
       end;
      DBGrid.SelectedRows.Clear;
      First;
      Query.Locate('ItemCode', CurrentItemCode, [loPartialKey]);
      EnableControls;
     end;
end;

procedure TMenuLinkForm.ReadSubMenuLinkData;
var
 I: integer;
 SQLStr: string;
begin
 SQLStr := 'Select * From SubMenuLinkHead ' +
           'Where ItemCode=' + Chr(39) +  CheckQuotes(ItemCode) + Chr(39);
 OpenTempQuery(SQLStr);
 with TempQuery do
  begin
   if Active and (RecordCount > 0) then
      begin
       NumberOfChoiceLabel.Caption := FieldByName('NumberOfChoice').AsString;
       SubCategoryCheckBox.Checked := FieldByName('SubCategory').AsBoolean;
       AutoShowSubMenuCheckBox.Checked := FieldByName('AutoShowSubMenu').AsBoolean;
      end
     else
      begin
       NumberOfChoiceLabel.Caption := '0';
       SubCategoryCheckBox.Checked := False;
       AutoShowSubMenuCheckBox.Checked := False;
      end;
   Close;
  end;
 SQLStr := 'Select SubMenuLinkDetail.SubMenuCode, MenuItem.Description1, ' +
           'SubMenuLinkDetail.ChoiceItem, SubMenuLinkDetail.SalesPrice, ' +
           'SubMenuLinkDetail.Instruction ' +
           'From SubMenuLinkDetail, MenuItem ' +
           'Where SubMenuLinkDetail.SubMenuCode=MenuItem.ItemCode and ' +
           'SubMenuLinkDetail.ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
           ' Order By SubMenuCode';
 OpenTempQuery(SQLStr);
 if TempQuery.RecordCount > 0 then
    begin
     TempQuery.First;
     I := 1;
     while Not TempQuery.EOF do
      begin
       StringGrid.Cells[0, I] := TempQuery.FieldByName('SubMenuCode').AsString;
       StringGrid.Cells[1, I] := TempQuery.fieldByName('Description1').AsString;
       StringGrid.Cells[2, I] := Format('%4.2f', [TempQuery.FieldByName('SalesPrice').AsFloat]);
       if TempQuery.FieldByName('ChoiceItem').AsBoolean then
          StringGrid.Cells[3, I] := 'Y';
       if TempQuery.FieldByName('Instruction').AsBoolean then
          StringGrid.Cells[4, I] := 'Y';
       Inc(I); TempQuery.Next;
      end;
    end;
 TempQuery.Close;
end;

function TMenuLinkForm.SaveSubMenuLinkData: boolean;
var
 SQLStr: string;
 I: integer;
begin
 Result := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  SQLStr := 'Delete From SubMenuLinkHead Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
  Result := DataForm.ExecQueryPro(SQLStr);
  if Result then
     begin
      SQLStr := 'Delete From SubMenuLinkDetail Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
      Result := DataForm.ExecQueryPro(SQLStr);
     end;

  if Result and (FindLastRow > 1) then
     begin
      SQLStr := 'Insert Into SubMenuLinkHead(ItemCode, NumberOfChoice, SubCategory, AutoShowSubMenu) ' +
                'Values(' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) + ',' +
                NumberOfChoiceLabel.Caption + ',';
      if SubCategoryCheckBox.Checked then
         SQLStr := SQLStr + '1' else SQLStr := SQLStr + '0';
      SQLStr := SQLStr + ',';
      if AutoShowSubMenuCheckBox.Checked then
         SQLStr := SQLStr + '1' else SQLStr := SQLStr + '0';
      SQLStr := SQLStr + ')';
      Result := DataForm.ExecQueryPro(SQLStr);
     end;

  I := 1;
  while Result and (I <= 200) do
   begin
    if StringGrid.Cells[0, I] <> '' then
       begin
        SQLStr := 'Insert Into SubMenuLinkDetail(ItemCode, SubMenuCode, ' +
                   'SalesPrice, ChoiceItem, Instruction) ' +
                  'Values(' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) + ',' +
                  Chr(39) + CheckQuotes(StringGrid.Cells[0, I]) + Chr(39) + ',' +
                  StringGrid.Cells[2, I] + ',';
        if StringGrid.Cells[3, I] = '' then
           SQLStr := SQLStr + '0'
          else
           SQLStr := SQLStr + '1';
        SQLStr := SQLStr + ',';
        if StringGrid.Cells[4, I] = '' then
           SQLStr := SQLStr + '0'
          else
           SQLStr := SQLStr + '1';
        SQLStr := SQLStr + ')';
        Result := DataForm.ExecQueryPro(SQLStr);
       end;
    I := I + 1;
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

procedure TMenuLinkForm.DBGridDblClick(Sender: TObject);
begin
 InsertButtonClick(Sender);
end;

procedure TMenuLinkForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TMenuLinkForm.SaveButtonClick(Sender: TObject);
begin
 if SaveSubMenuLinkData then Close;
end;

procedure TMenuLinkForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TMenuLinkForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TMenuLinkForm.SearchComboBoxChange(Sender: TObject);
begin
 SearchEdit.Text := '';
 OpenQuery;
end;

procedure TMenuLinkForm.SearchEditChange(Sender: TObject);
begin
 OpenQuery;
end;

procedure TMenuLinkForm.InstructionCheckBoxClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TMenuLinkForm.CategoryEditClick(Sender: TObject);
var
 SelectedCategory: string;
begin
 if CategorySelectForm.CategorySelectPro(SelectedCategory) then
    begin
     CategoryEdit.Text := SelectedCategory;
     OpenQuery;
    end;
end;

procedure TMenuLinkForm.CategoryCheckBoxClick(Sender: TObject);
begin
 CategoryEdit.Enabled := CategoryCheckBox.Checked;
 if Not CategoryCheckBox.Checked then CategoryEdit.Text := '';
 OpenQuery;
end;

procedure TMenuLinkForm.NumberOfChoiceLabelClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TbsSkinLabel do
  begin
   NumStr := Caption;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Number Of Choice', 0) and
      (StrToFloat(NumStr) <= 100) then
      Caption := Format('%4.0f ', [StrToFloat(NumStr)])
     else
      MessageBoxForm.MessagePro('Number out of range!', sErrorMsg);
  end;
end;

procedure TMenuLinkForm.StringGridDblClick(Sender: TObject);
var
 ItemCode, Description: string;
 Price: double;
 Choice, Instruction: boolean;
begin
 with StringGrid do
  if Cells[0, Row] <> '' then
     begin
      ItemCode := Cells[0, Row];
      Description := Cells[1, Row];
      Price := StrToFloat(Cells[2, Row]);
      Choice := Cells[3, Row] = 'Y';
      Instruction := Cells[4, Row] = 'Y';
      if MenuLinkItemEditForm.MenuKinkItemEditPro(ItemCode, Description, Price, Choice, Instruction) then
         begin
          Cells[2, Row] := Format('%4.2f', [Price]);
          if Choice then Cells[3, Row] := 'Y' else Cells[3, Row] := '';
          if Instruction then Cells[4, Row] := 'Y' else Cells[4, Row] := '';
         end;
     end;
end;

procedure TMenuLinkForm.FormShow(Sender: TObject);
begin
 Width := TitlePanel.Left + TitlePanel.Width + 24;
 Height := CancelButton.Top + 86;
 InitStringGrid;
 ReadSubMenuLinkData;
 OpenQuery;
 ItemCodeLabel.Caption := ItemCode;
 ItemDescriptionLabel.Caption := Description;
end;

procedure TMenuLinkForm.MenuLinkPro(ItemCode, Description: string);
begin
 Application.CreateForm(TMenuLinkForm, MenuLinkForm);
 MenuLinkForm.ItemCode := ItemCode;
 MenuLinkForm.Description := Description;
 MenuLinkForm.ShowModal;
 MenuLinkForm.Free;
end;

end.
