unit SubMenuLink;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Grids, DBGrids, Db, StdCtrls, Buttons, DBCtrls, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TSubMenuLinkForm = class(TForm)
    DBGrid: TDBGrid;
    StringGrid: TStringGrid;
    DataSource: TDataSource;
    ItemDescriptionLabel: TLabel;
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
    procedure SubMenuLinkPro(ItemCode, Description: string);
    procedure DBGridDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SearchComboBoxChange(Sender: TObject);
    procedure SearchEditChange(Sender: TObject);
    procedure InstructionCheckBoxClick(Sender: TObject);
    procedure CategoryEditClick(Sender: TObject);
    procedure CategoryCheckBoxClick(Sender: TObject);
  private { Private declarations }
    ItemCode, Description: string;
  public
    { Public declarations }
  end;

var
  SubMenuLinkForm: TSubMenuLinkForm;

implementation

uses DataUnit, UtilUnit, MainMenu, MenuItemEdit, NumPad, Instruction,
  CategorySelect;

{$R *.DFM}

procedure TSubMenuLinkForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select ItemCode, Description1 From MenuItem ';
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

procedure TSubMenuLinkForm.OpenTempQuery(SQLStr: string);
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

procedure TSubMenuLinkForm.NewButtonClick(Sender: TObject);
var
 Code: string;
begin
 if MenuItemEditForm.MenuItemEditPro(Code, '', sNewStatus) then
    begin
     OpenQuery;
     Query.Locate('ItemCode', Code, [loPartialKey]);
    end;
end;

procedure TSubMenuLinkForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   Cells[0, 0] := 'Code';
   Cells[1, 0] := 'Description';
   for I := 1 to 200 do
    begin
     Cells[0, I] := ''; Cells[1, I] := '';
    end;
   Row := 1; Col := 1;
  end;
end;

procedure TSubMenuLinkForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   X := (Rect.Left + Rect.Right) div 2;
   if ARow > 0 then
      case ACol of
        0: begin
            SetTextAlign(Canvas.Handle, TA_CENTER);
            X := (Rect.Left + Rect.Right) div 2;
           end;
        1: begin
            SetTextAlign(Canvas.Handle, TA_LEFT);
            X := Rect.Left + 2;
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

procedure TSubMenuLinkForm.DeleteFromStringGrid;
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
    end;
   Cells[0, 50] := ''; Cells[1, 50] := '';
  end;
end;

function TSubMenuLinkForm.CheckCode(Code: string): boolean;
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

function TSubMenuLinkForm.FindLastRow: integer;
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
           end;
        J := J + 1;
       end;
   end;
 if J <= 200 then
    Result := J
   else
    Result := 200;
end;

procedure TSubMenuLinkForm.DeleteButtonClick(Sender: TObject);
begin
 DeleteFromStringGrid;
end;

procedure TSubMenuLinkForm.InsertButtonClick(Sender: TObject);
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
           end;
        Next;
       end;
      DBGrid.SelectedRows.Clear;
      First;
      Query.Locate('ItemCode', CurrentItemCode, [loPartialKey]);
      EnableControls;
     end;
end;

procedure TSubMenuLinkForm.ReadSubMenuLinkData;
var
 I: integer;
 SQLStr: string;
begin
 SQLStr := 'Select SubMenuCode, Description1 ' +
           'From SubMenuLinkTable, MenuItem ' +
           'Where SubMenuLinkTable.SubMenuCode=MenuItem.ItemCode and ' +
           'SubMenuLinkTable.ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) +
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
       Inc(I); TempQuery.Next;
      end;
    end;
 TempQuery.Close;
end;

function TSubMenuLinkForm.SaveSubMenuLinkData: boolean;
var
 SQLStr: string;
 I: integer;
begin
 Result := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  SQLStr := 'Delete From SubMenuLinkTable Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
  Result := DataForm.ExecQueryPro(SQLStr);
  I := 1;
  while Result and (I <= 200) do
   begin
    if StringGrid.Cells[0, I] <> '' then
       begin
        SQLStr := 'Insert Into SubMenuLinkTable(ItemCode, SubMenuCode) ' +
                  'Values(' + Chr(39) + CheckQuotes(ItemCode) + Chr(39) + ',' +
                  Chr(39) + CheckQuotes(StringGrid.Cells[0, I]) + Chr(39) + ')';
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

procedure TSubMenuLinkForm.DBGridDblClick(Sender: TObject);
begin
 InsertButtonClick(Sender);
end;

procedure TSubMenuLinkForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSubMenuLinkForm.SaveButtonClick(Sender: TObject);
begin
 if SaveSubMenuLinkData then Close;
end;

procedure TSubMenuLinkForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TSubMenuLinkForm.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TSubMenuLinkForm.SearchComboBoxChange(Sender: TObject);
begin
 SearchEdit.Text := '';
 OpenQuery;
end;

procedure TSubMenuLinkForm.SearchEditChange(Sender: TObject);
begin
 OpenQuery;
end;

procedure TSubMenuLinkForm.InstructionCheckBoxClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TSubMenuLinkForm.CategoryEditClick(Sender: TObject);
var
 SelectedCategory: string;
begin
 if CategorySelectForm.CategorySelectPro(SelectedCategory) then
    begin
     CategoryEdit.Text := SelectedCategory;
     OpenQuery;
    end;
end;

procedure TSubMenuLinkForm.CategoryCheckBoxClick(Sender: TObject);
begin
 CategoryEdit.Enabled := CategoryCheckBox.Checked;
 if Not CategoryCheckBox.Checked then CategoryEdit.Text := '';
 OpenQuery;
end;

procedure TSubMenuLinkForm.FormShow(Sender: TObject);
begin
 Width := TitlePanel.Left + TitlePanel.Width + 24;
 Height := CancelButton.Top + 86;
 InitStringGrid;
 ReadSubMenuLinkData;
 OpenQuery;
 ItemDescriptionLabel.Caption := ItemCode + ' - ' + Description;
end;

procedure TSubMenuLinkForm.SubMenuLinkPro(ItemCode, Description: string);
begin
 Application.CreateForm(TSubMenuLinkForm, SubMenuLinkForm);
 SubMenuLinkForm.ItemCode := ItemCode;
 SubMenuLinkForm.Description := Description;
 SubMenuLinkForm.ShowModal;
 SubMenuLinkForm.Free;
end;

end.
