unit ItemSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, StdCtrls, ExtCtrls, Buttons, Grids, UtilUnit, Db, DataUnit,
  DBCtrls, DBGrids, ADODB, MainMenu, bsSkinCtrls, BusinessSkinForm,
  XiButton;

type
  TItemSelectForm = class(TForm)
    CategoryDBGrid: TDBGrid;
    MenuDBGrid: TDBGrid;
    CategoryDataSource: TDataSource;
    MenuDataSource: TDataSource;
    CategoryEdit: TDBEdit;
    CategoryQuery: TADOQuery;
    CategoryQueryCategory: TStringField;
    MenuQuery: TADOQuery;
    MenuQueryItemCode: TStringField;
    MenuQueryDescription1: TStringField;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    CategoryDBGridPanel: TbsSkinPanel;
    MenuDBGridPanel: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure OpenCategoryQuery(SQLStr: string);
    procedure OpenMenuQuery(SQLStr: string);
    procedure OpenCategory;
    procedure OpenMenu(Category: string);
    procedure CategoryEditChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  ItemSelectPro(var ItemCode: string): boolean;
    procedure FormShow(Sender: TObject);
    procedure MenuDBGridDblClick(Sender: TObject);
  private { Private declarations }
    ItemCode: string;
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  ItemSelectForm: TItemSelectForm;

implementation


{$R *.DFM}

procedure TItemSelectForm.OpenCategoryQuery(SQLStr: string);
begin
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
  end;
end;

procedure TItemSelectForm.OpenMenuQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with MenuQuery do
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

procedure TItemSelectForm.OpenCategory;
var
 SQLStr: string;
begin
 SQLStr := 'Select Category From Category Order By Code';
 OpenCategoryQuery(SQLStr);
end;

procedure TItemSelectForm.OpenMenu(Category: string);
var
 SQLStr: string;
begin
 SQLStr := 'Select ItemCode, Description1, Description2 From MenuItem ' +
           'Where Category=' + Chr(39) + CheckQuotes(Category) + Chr(39) +
           ' and Active=1 Order By ItemCode';
 OpenMenuQuery(SQLStr);
end;

procedure TItemSelectForm.CategoryEditChange(Sender: TObject);
begin
 OpenMenu(CategoryEdit.Text);
end;

procedure TItemSelectForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key In [VK_RIGHT, VK_LEFT, VK_RETURN] then
    begin
     case Key of
      VK_RIGHT: MenuDBGrid.SetFocus;
      VK_LEFT:  CategoryDBGrid.SetFocus;
      VK_RETURN: ConfirmButtonClick(Sender);
     end;
    Key := 0;
   end;
end;

procedure TItemSelectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TItemSelectForm.ConfirmButtonClick(Sender: TObject);
begin
 if MenuQuery.Active and (MenuQuery.RecordCount > 0) then
    begin
     ItemCode := MenuQuery.FieldByName('ItemCode').AsString;
     ReturnFlag := True;
     Close;
    end;
end;

procedure TItemSelectForm.MenuDBGridDblClick(Sender: TObject);
begin
 ConfirmButtonClick(Sender);
end;

procedure TItemSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TItemSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CategoryQuery.Close;
 MenuQuery.Close;
 Action := caFree;
end;

procedure TItemSelectForm.FormShow(Sender: TObject);
begin
 Width := MenuDBGridPanel.Left + MenuDBGridPanel.Width + 22;
 Height := CancelButton.Top + 86;
 OpenCategory;
 CategoryDBGrid.SetFocus;
end;

function TItemSelectForm.ItemSelectPro(var ItemCode: string): boolean;
begin
 Application.CreateForm(TItemSelectForm, ItemSelectForm);
 ItemSelectForm.ShowModal;
 Result := ItemSelectForm.ReturnFlag;
 if Result then
    ItemCode := ItemSelectForm.ItemCode;
 ItemSelectForm.Free;
end;

end.

