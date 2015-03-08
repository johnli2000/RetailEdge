unit CategorySelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DataUnit, ADODB, Grids, DBGrids, MainMenu,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TCategorySelectForm = class(TForm)
    Query: TADOQuery;
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    QueryCategory: TStringField;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure OpenQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  CategorySelectPro(var SelectedCategory: string): boolean;
    procedure ConfirmButtonClick(Sender: TObject);
  private { Private declarations }
    ReturnFlag: boolean;
    SelectedCategory: string;
  public
    { Public declarations }
  end;

var
  CategorySelectForm: TCategorySelectForm;

implementation

{$R *.DFM}

procedure TCategorySelectForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select Category From Category Order By Category');
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TCategorySelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;


procedure TCategorySelectForm.ConfirmButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      SelectedCategory := FieldByName('Category').AsString;
      ReturnFlag := True;
      CategorySelectForm.Close;
     end;
end;

procedure TCategorySelectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then
    CancelButtonClick(Sender);
end;

procedure TCategorySelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
end;

procedure TCategorySelectForm.FormShow(Sender: TObject);
begin
 OpenQuery;
end;

function TCategorySelectForm.CategorySelectPro(var SelectedCategory: string): boolean;
begin
 Application.CreateForm(TCategorySelectForm, CategorySelectForm);
 CategorySelectForm.ShowModal;
 Result := CategorySelectForm.ReturnFlag;
 if Result then SelectedCategory := CategorySelectForm.SelectedCategory;
 CategorySelectForm.Free;
end;

end.
