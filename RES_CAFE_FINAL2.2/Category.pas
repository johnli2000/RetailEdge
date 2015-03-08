unit Category;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, UtilUnit,
  jpeg, ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TCategoryForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryCode: TStringField;
    QueryCategory: TStringField;
    QueryShowOnMainMenu: TBooleanField;
    QueryShowOnPOSMenu: TBooleanField;
    QueryShowOnMain: TStringField;
    QueryShowOnPos: TStringField;
    QueryCategory1: TStringField;
    QueryMenuGroupCode: TStringField;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    NewButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    ExitButton: TXiButton;
    QueryShowOnPhoneOrderMenu: TBooleanField;
    QueryShowOnPhoneOrder: TStringField;
    procedure OpenQuery;
    procedure ExitButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  CategorySetup: boolean;
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
  private { Private declarations }
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
 CategoryForm: TCategoryForm;

implementation

uses DataUnit, MainMenu, MessageBox, CategoryEdit;

{$R *.DFM}

procedure TCategoryForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select Code, Category, Category1, ShowOnMainMenu, ShowOnPOSMenu, ' +
           'ShowOnPhoneOrderMenu, MenuGroupCode ' +
           'From Category Order By Code';
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

procedure TCategoryForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  begin
   if FieldByName('ShowOnMainMenu').AsBoolean then
      FieldByName('ShowOnMain').AsString := 'Yes';
   if FieldByName('ShowOnPOSMenu').AsBoolean then
      FieldByName('ShowOnPOS').AsString := 'Yes';
   if FieldByName('ShowOnPhoneOrderMenu').AsBoolean then
      FieldByName('ShowOnPhoneOrder').AsString := 'Yes';
  end;
end;

procedure TCategoryForm.DeleteButtonClick(Sender: TObject);
var
 Category, Code, SQLStr: string;
 Flag: boolean;
begin
 if MessageBoxForm.MessagePro('Are you sure you want to delete this record?', sConfirmMsg) = mrNo then
    Exit;
 Code := Query.FieldByName('Code').AsString;
 Category := Query.FieldByName('Category').AsString;
 SQLStr := 'Select Count(*) From MenuItem ' +
           'where Category=' + Chr(39) + CheckQuotes(Category) + Chr(39);
 if DataForm.CheckCodeSQLPro(SQLStr) > 0 then
    begin
     MessageBoxForm.MessagePro('This category can not be delete' + Chr(13) + Chr(10) +
     Chr(13) + Chr(10) + 'which linked to another database.', sErrorMsg);
     Exit;
    end;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  SQLStr := 'Delete From Category Where Code=' + Chr(39) + CheckQuotes(Code) + Chr(39) +
            ' and Category=' + Chr(39) + CheckQuotes(Category) + Chr(39);
  Flag := DataForm.ExecQueryPro(SQLStr);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      OpenQuery;
      ReturnFlag := True;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TCategoryForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close
end;

procedure TCategoryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TCategoryForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TCategoryForm.NewButtonClick(Sender: TObject);
var
 Category: string;
begin
 if CategoryEditForm.CategoryEditPro(Category, sNewStatus) then
    begin
     OpenQuery;
     Query.Locate('Category', Category, [loPartialKey]);
     ReturnFlag := True;
    end;
end;

procedure TCategoryForm.EditButtonClick(Sender: TObject);
var
 Category: string;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      Category := FieldByName('Category').AsString;
      if CategoryEditForm.CategoryEditPro(Category, sEditStatus) then
         begin
          OpenQuery;
          Query.Locate('Category', Category, [loPartialKey]);
          ReturnFlag := True;
         end;
     end;
end;

procedure TCategoryForm.DBGridDblClick(Sender: TObject);
begin
 EditButtonClick(Sender);
end;

procedure TCategoryForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 OpenQuery;
 ReturnFlag := False;
end;

function TCategoryForm.CategorySetup: boolean;
begin
 Application.CreateForm(TCategoryForm, CategoryForm);
 CategoryForm.ShowModal;
 Result := CategoryForm.ReturnFlag;
 CategoryForm.Free;
end;

end.
