unit VoidReasonSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DataUnit, ADODB, MainMenu, XiButton,
  bsSkinCtrls, BusinessSkinForm;

type
  TVoidReasonSelectForm = class(TForm)
    Query: TADOQuery;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    Menu1: TXiButton;
    Menu2: TXiButton;
    Menu3: TXiButton;
    Menu4: TXiButton;
    Menu5: TXiButton;
    Menu6: TXiButton;
    Menu7: TXiButton;
    Menu8: TXiButton;
    Menu9: TXiButton;
    Menu10: TXiButton;
    PageUpButton: TXiButton;
    PageDownButton: TXiButton;
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
    procedure Menu7Click(Sender: TObject);
    procedure Menu8Click(Sender: TObject);
    procedure Menu9Click(Sender: TObject);
    procedure Menu10Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure VoidReasonSelectPro(var Code: string);
  private { Private declarations }
    CurrentPage, RowCount, CurrentPosition: integer;
    Code: string;
  public
    { Public declarations }
  end;

var
  VoidReasonSelectForm: TVoidReasonSelectForm;

implementation

{$R *.DFM}

procedure TVoidReasonSelectForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From VoidReasonTable Order By Code';
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
   RowCount := RecordCount;
   CurrentPage := 1;
   CurrentPosition := 1;
  end;
end;

procedure TVoidReasonSelectForm.AssignKeyBoard;
begin
 with Query do
  begin
   First;
   MoveBy((CurrentPage - 1) * 10);
   if Not EOF then
      begin
       Menu1.Caption := Query.FieldByName('Description').AsString;
       Next;
      end
     else
      Menu1.Caption := '';
   if Not EOF then
      begin
       Menu2.Caption := Query.FieldByName('Description').AsString;
       Next;
      end
     else
      Menu2.Caption := '';
   if Not EOF then
      begin
       Menu3.Caption := Query.FieldByName('Description').AsString;
       Next;
      end
     else
      Menu3.Caption := '';
   if Not EOF then
      begin
       Menu4.Caption := Query.FieldByName('Description').AsString;
       Next;
      end
     else
      Menu4.Caption := '';
   if Not EOF then
      begin
       Menu5.Caption := Query.FieldByName('Description').AsString;
       Next;
      end
     else
      Menu5.Caption := '';
   if Not EOF then
      begin
       Menu6.Caption := Query.FieldByName('Description').AsString;
       Next;
      end
     else
      Menu6.Caption := '';
   if Not EOF then
      begin
       Menu7.Caption := Query.FieldByName('Description').AsString;
       Next;
      end
     else
      Menu7.Caption := '';
   if Not EOF then
      begin
       Menu8.Caption := Query.FieldByName('Description').AsString;
       Next;
      end
     else
      Menu8.Caption := '';
   if Not EOF then
      begin
       Menu9.Caption := Query.FieldByName('Description').AsString;
       Next;
      end
     else
      Menu9.Caption := '';
   if Not EOF then
      begin
       Menu10.Caption := Query.FieldByName('Description').AsString;
       Next;
      end
     else
      Menu10.Caption := '';
  end;
end;

procedure TVoidReasonSelectForm.PageUpButtonClick(Sender: TObject);
begin
 if CurrentPage >= 2 then
    begin
     CurrentPage := CurrentPage - 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
 Menu1.SetFocus;
end;

procedure TVoidReasonSelectForm.PageDownButtonClick(Sender: TObject);
begin
 if (CurrentPage * 10) < RowCount then
    begin
     CurrentPage := CurrentPage + 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
 Menu1.SetFocus;
end;

procedure TVoidReasonSelectForm.ProcessButtonTouch(Position: integer);
begin
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 10 + Position - 1);
 Code := Query.FieldByName('Code').AsString;
 Close;
end;

procedure TVoidReasonSelectForm.Menu1Click(Sender: TObject);
begin
 CurrentPosition := 1;
 if Menu1.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TVoidReasonSelectForm.Menu2Click(Sender: TObject);
begin
 CurrentPosition := 2;
 if Menu2.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TVoidReasonSelectForm.Menu3Click(Sender: TObject);
begin
 CurrentPosition := 3;
 if Menu3.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TVoidReasonSelectForm.Menu4Click(Sender: TObject);
begin
 CurrentPosition := 4;
 if Menu4.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TVoidReasonSelectForm.Menu5Click(Sender: TObject);
begin
 CurrentPosition := 5;
 if Menu5.Caption <> '' then  ProcessButtonTouch(CurrentPosition)
end;

procedure TVoidReasonSelectForm.Menu6Click(Sender: TObject);
begin
 CurrentPosition := 6;
 if Menu6.Caption <> '' then ProcessButtonTouch(CurrentPosition);
end;

procedure TVoidReasonSelectForm.Menu7Click(Sender: TObject);
begin
 CurrentPosition := 7;
 if Menu7.Caption <> '' then ProcessButtonTouch(CurrentPosition);
end;

procedure TVoidReasonSelectForm.Menu8Click(Sender: TObject);
begin
 CurrentPosition := 8;
 if Menu8.Caption <> '' then ProcessButtonTouch(CurrentPosition);
end;

procedure TVoidReasonSelectForm.Menu9Click(Sender: TObject);
begin
 CurrentPosition := 9;
 if Menu9.Caption <> '' then ProcessButtonTouch(CurrentPosition);
end;

procedure TVoidReasonSelectForm.Menu10Click(Sender: TObject);
begin
 CurrentPosition := 10;
 if Menu10.Caption <> '' then ProcessButtonTouch(CurrentPosition);
end;

procedure TVoidReasonSelectForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 case Key of
  VK_PRIOR: PageUpButtonClick(Sender);
  VK_NEXT: PageDownButtonClick(Sender);
 end;
end;

procedure TVoidReasonSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
end;

procedure TVoidReasonSelectForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := PageDownButton.Top + 86;
 OpenQuery;
 AssignKeyBoard;
 Menu1.SetFocus;
end;

procedure TVoidReasonSelectForm.VoidReasonSelectPro(var Code: string);
begin
 Application.CreateForm(TVoidReasonSelectForm, VoidReasonSelectForm);
 VoidReasonSelectForm.ShowModal;
 Code := VoidReasonSelectForm.Code;
 VoidReasonSelectForm.Free;
end;

end.
