unit MenuGroupSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DataUnit, ADODB, XiButton, PanelButton,
  bsSkinCtrls, BusinessSkinForm;

type
  TMenuGroupSelectForm = class(TForm)
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    PageUpButton: TXiButton;
    PageDownButton: TXiButton;
    CancelButton: TXiButton;
    Menu1: TXiButton;
    Menu2: TXiButton;
    Menu3: TXiButton;
    Menu4: TXiButton;
    Menu5: TXiButton;
    Menu6: TXiButton;
    procedure OpenQuery;
    procedure AssignKeyBoard;
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure ProcessButtonTouch(Position: integer);
    procedure Menu1Click(Sender: TObject);
    procedure Menu2Click(Sender: TObject);
    procedure Menu3Click(Sender: TObject);
    procedure Menu4Click(Sender: TObject);
    procedure Menu5Click(Sender: TObject);
    procedure Menu6Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  MenuGroupSelectPro(var MenuGroupCode, MenuGroupDescription: string): boolean;
  private { Private declarations }
    CurrentPage, RowCount, CurrentPosition: integer;
    ReturnFlag: boolean;
    MenuGroupCode, MenuGroupDescription: string;
  public
    { Public declarations }
  end;

var
  MenuGroupSelectForm: TMenuGroupSelectForm;

implementation

{$R *.DFM}

procedure TMenuGroupSelectForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From MenuGroupTable Order By Code');
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
   RowCount := RecordCount;
   CurrentPage := 1;
   CurrentPosition := 1;
  end;
end;

procedure TMenuGroupSelectForm.AssignKeyBoard;
begin
 with Query do
  begin
   First;
   MoveBy((CurrentPage - 1) * 6);
   if Not EOF then
      begin
       Menu1.Caption := FieldByName('Description').AsString;
       Next;
      end
     else
      Menu1.Caption := '';
   if Not EOF then
      begin
       Menu2.Caption := FieldByName('Description').AsString;
       Next;
      end
     else
      Menu2.Caption := '';
   if Not EOF then
      begin
       Menu3.Caption := FieldByName('Description').AsString;
       Next;
      end
     else
      Menu3.Caption := '';
   if Not EOF then
      begin
       Menu4.Caption := FieldByName('Description').AsString;
       Next;
      end
     else
      Menu4.Caption := '';
   if Not EOF then
      begin
       Menu5.Caption := FieldByName('Description').AsString;
       Next;
      end
     else
      Menu5.Caption := '';
   if Not EOF then
      begin
       Menu6.Caption := FieldByName('Description').AsString;
       Next;
      end
     else
      Menu6.Caption := '';
  end;
end;

procedure TMenuGroupSelectForm.PageUpButtonClick(Sender: TObject);
begin
 if CurrentPage >= 2 then
    begin
     CurrentPage := CurrentPage - 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
end;

procedure TMenuGroupSelectForm.PageDownButtonClick(Sender: TObject);
begin
 if (CurrentPage * 6) < RowCount then
    begin
     CurrentPage := CurrentPage + 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
end;

procedure TMenuGroupSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TMenuGroupSelectForm.ProcessButtonTouch(Position: integer);
begin
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 6 + Position - 1);
 MenuGroupCode := Query.FieldByName('Code').AsString;
 MenuGroupDescription := Query.FieldByName('Description').AsString;
 ReturnFlag := True;
 Close;
end;

procedure TMenuGroupSelectForm.Menu1Click(Sender: TObject);
begin
 CurrentPosition := 1;
 if Menu1.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TMenuGroupSelectForm.Menu2Click(Sender: TObject);
begin
 CurrentPosition := 2;
 if Menu2.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TMenuGroupSelectForm.Menu3Click(Sender: TObject);
begin
 CurrentPosition := 3;
 if Menu3.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TMenuGroupSelectForm.Menu4Click(Sender: TObject);
begin
 CurrentPosition := 4;
 if Menu4.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TMenuGroupSelectForm.Menu5Click(Sender: TObject);
begin
 CurrentPosition := 5;
 if Menu5.Caption <> '' then  ProcessButtonTouch(CurrentPosition)
end;

procedure TMenuGroupSelectForm.Menu6Click(Sender: TObject);
begin
 CurrentPosition := 6;
 if Menu6.Caption <> '' then ProcessButtonTouch(CurrentPosition);
end;

procedure TMenuGroupSelectForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 case Key of
  VK_PRIOR: PageUpButtonClick(Sender);
  VK_NEXT: PageDownButtonClick(Sender);
 end;
end;

procedure TMenuGroupSelectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then
    CancelButtonClick(Sender);
end;

procedure TMenuGroupSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
end;

procedure TMenuGroupSelectForm.FormShow(Sender: TObject);
begin
 OpenQuery;
 AssignKeyBoard;
end;

function TMenuGroupSelectForm.MenuGroupSelectPro(var MenuGroupCode, MenuGroupDescription: string): boolean;
begin
 Application.CreateForm(TMenuGroupSelectForm, MenuGroupSelectForm);
 MenuGroupSelectForm.ShowModal;
 Result := MenuGroupSelectForm.ReturnFlag;
 if Result then
    begin
     MenuGroupCode := MenuGroupSelectForm.MenuGroupCode;
     MenuGroupDescription := MenuGroupSelectForm.MenuGroupDescription;
    end;
 MenuGroupSelectForm.Free;
end;

end.
