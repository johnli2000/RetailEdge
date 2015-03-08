unit ShowIngredients;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Buttons, ExtCtrls, bsSkinCtrls, UtilUnit,
  BusinessSkinForm, XiButton;

type
  TShowIngredientsForm = class(TForm)
    IngredientsEdit: TMemo;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    ExitButton: TXiButton;
    procedure OpenQuery(ItemCode: string);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShowIngredientsPro(ItemCode: string);
  private { Private declarations }
    ItemCode: string;
  public
    { Public declarations }
  end;

var
  ShowIngredientsForm: TShowIngredientsForm;

implementation

uses DataUnit;

{$R *.dfm}

procedure TShowIngredientsForm.OpenQuery(ItemCode: string);
var
 SQLStr: string;
begin
 SQLStr := 'Select * From IngredientsTable Where ItemCode=' + Chr(39) + CheckQuotes(ItemCode) + Chr(39);
 with Query do
   begin
    Active := False;
    Connection := Dataform.ADOConnection;
    SQL.Clear;
    SQL.Add(SQLStr);
    try
     Active := True;
    finally
     Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TShowIngredientsForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TShowIngredientsForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := ExitButton.Top + 86;
 OpenQuery(ItemCode);
 with Query do
  begin
   if Active and (RecordCount > 0) then
      IngredientsEdit.Text := FieldByName('Ingredients').AsString;
   Close;
  end;
end;

procedure TShowIngredientsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TShowIngredientsForm.ShowIngredientsPro(ItemCode: string);
begin
 Application.CreateForm(TShowIngredientsForm, ShowIngredientsForm);
 ShowIngredientsForm.ItemCode := ItemCode;
 ShowIngredientsForm.ShowModal;
 ShowIngredientsForm.Free;
end;

end.
