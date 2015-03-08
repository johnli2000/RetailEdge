unit SuburbSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainMenu, BusinessSkinForm, DataUnit, XiButton, DB, Grids,
  DBGrids, ADODB, bsSkinCtrls, StdCtrls, Mask, bsSkinBoxCtrls;

type
  TSuburbSearchForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    Query: TADOQuery;
    DataSource: TDataSource;
    DBGrid: TDBGrid;
    QuerySuburb: TStringField;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    MoveUpButton: TXiButton;
    MoveDownButton: TXiButton;
    PageUpButton: TXiButton;
    PageDownButton: TXiButton;
    procedure OpenQuery;
    procedure MoveUpButtonClick(Sender: TObject);
    procedure MoveDownButtonClick(Sender: TObject);
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function  SuburbSearchPro(var Suburb: string): boolean;
  private { Private declarations }
    Suburb: string;
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  SuburbSearchForm: TSuburbSearchForm;

implementation

{$R *.dfm}

procedure TSuburbSearchForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select Suburb From StreetTable Group By Suburb Order By Suburb';
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

procedure TSuburbSearchForm.MoveUpButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.BOF then
    Query.Prior;
 DBGrid.SetFocus;
end;

procedure TSuburbSearchForm.MoveDownButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.EOF then
    Query.Next;
 DBGrid.SetFocus;
end;

procedure TSuburbSearchForm.PageUpButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.BOF then
    Query.MoveBy(-26);
 DBGrid.SetFocus;
end;

procedure TSuburbSearchForm.PageDownButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.EOF then
    Query.MoveBy(26);
 DBGrid.SetFocus;
end;

procedure TSuburbSearchForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TSuburbSearchForm.ConfirmButtonClick(Sender: TObject);
begin
 if Query.RecordCount > 0 then
    begin
     Suburb := Query.FieldByName('Suburb').AsString;
     ReturnFlag := True;
     Close;
    end;
end;

procedure TSuburbSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TSuburbSearchForm.FormShow(Sender: TObject);
begin
 Width := ConfirmButton.Left + ConfirmButton.Width + 28;
 Height := DBGridPanel.Height + 48;
 OpenQuery;
end;

function TSuburbSearchForm.SuburbSearchPro(var Suburb: string): boolean;
begin
 Application.CreateForm(TSuburbSearchForm, SuburbSearchForm);
 SuburbSearchForm.ShowModal;
 Result := SuburbSearchForm.ReturnFlag;
 if Result then Suburb := SuburbSearchForm.Suburb;
end;

end.
