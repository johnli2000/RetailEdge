unit StreetSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainMenu, BusinessSkinForm, DataUnit, XiButton, DB, Grids,
  DBGrids, ADODB, bsSkinCtrls, StdCtrls, Mask, bsSkinBoxCtrls, UtilUnit;

type
  TStreetSearchForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    Query: TADOQuery;
    DataSource: TDataSource;
    DBGrid: TDBGrid;
    QueryStreet: TStringField;
    QuerySuburb: TStringField;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    MoveUpButton: TXiButton;
    MoveDownButton: TXiButton;
    PageUpButton: TXiButton;
    PageDownButton: TXiButton;
    QueryMapReference: TStringField;
    SearchEdit: TbsSkinEdit;
    procedure OpenQuery;
    procedure MoveUpButtonClick(Sender: TObject);
    procedure MoveDownButtonClick(Sender: TObject);
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function  StreetSearchPro(var Street, Suburb, MapRef: string): boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SearchEditChange(Sender: TObject);
  private { Private declarations }
    Street, Suburb, MapRef: string;
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  StreetSearchForm: TStreetSearchForm;

implementation

{$R *.dfm}

procedure TStreetSearchForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From StreetTable ';
 if SearchEdit.Text <> '' then
    SQLStr := SQLStr + 'Where Street Like ' + Chr(39) + CheckQuotes(SearchEdit.Text) + SearchMark + Chr(39);
 SQLStr := SQLStr + ' Order By Street';
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

procedure TStreetSearchForm.MoveUpButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.BOF then
    Query.Prior;
 DBGrid.SetFocus;
end;

procedure TStreetSearchForm.MoveDownButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.EOF then
    Query.Next;
 DBGrid.SetFocus;
end;

procedure TStreetSearchForm.PageUpButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.BOF then
    Query.MoveBy(-26);
 DBGrid.SetFocus;
end;

procedure TStreetSearchForm.PageDownButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.EOF then
    Query.MoveBy(26);
 DBGrid.SetFocus;
end;

procedure TStreetSearchForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TStreetSearchForm.ConfirmButtonClick(Sender: TObject);
begin
 if Query.RecordCount > 0 then
    begin
     Street := Query.FieldByName('Street').AsString;
     Suburb := Query.FieldByName('Suburb').AsString;
     MapRef := Query.FieldByName('MapReference').AsString;
     ReturnFlag := True;
     Close;
    end;
end;

procedure TStreetSearchForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key In [VK_UP, VK_DOWN, VK_NEXT, VK_PRIOR] then
    DBGrid.SetFocus
   else
    if Key = VK_RETURN then
       ConfirmButtonClick(Sender)
      else
       if Key = VK_ESCAPE then
          CancelButtonClick(Sender);
end;

procedure TStreetSearchForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key In ['0'..'9', 'A'..'Z', 'a'..'z', Chr(8)] then
    SearchEdit.SetFocus
end;

procedure TStreetSearchForm.SearchEditChange(Sender: TObject);
begin
 OpenQuery;
end;

procedure TStreetSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TStreetSearchForm.FormShow(Sender: TObject);
begin
 Width := ConfirmButton.Width + ConfirmButton.Left + 28;
 Height := SearchEdit.Top + 66;
 SearchEdit.Text := Street;
 OpenQuery;
end;

function TStreetSearchForm.StreetSearchPro(var Street, Suburb, MapRef: string): boolean;
begin
 Application.CreateForm(TStreetSearchForm, StreetSearchForm);
 StreetSearchForm.Street := Street;
 StreetSearchForm.ShowModal;
 Result := StreetSearchForm.ReturnFlag;
 if Result then
    begin
     Street := StreetSearchForm.Street;
     Suburb := StreetSearchForm.Suburb;
     MapRef := StreetSearchForm.MapRef;
    end;
end;

end.
