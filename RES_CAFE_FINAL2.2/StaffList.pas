unit StaffList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, Grids, DBGrids, ExtCtrls, ADODB, XiButton,
  BusinessSkinForm, bsSkinCtrls;

type
  TStaffListForm = class(TForm)
    Query: TADOQuery;
    WorkPanel: TbsSkinPanel;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    Button1: TXiButton;
    Button2: TXiButton;
    Button3: TXiButton;
    Button4: TXiButton;
    Button5: TXiButton;
    Button6: TXiButton;
    Button7: TXiButton;
    Button8: TXiButton;
    Button9: TXiButton;
    Button10: TXiButton;
    PageUpButton: TXiButton;
    PageDownButton: TXiButton;
    CancelButton: TXiButton;
    procedure OpenQuery;
    procedure AssignKeyBoard;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  ListStaffPro(Var StaffName: string): boolean;
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure ProcessButtonTouch(Position: integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }
     StaffName: string;
     ReturnFlag: boolean;
     CurrentPage, RowCount, CurrentPosition: integer;
  public
    { Public declarations }
  end;

var
  StaffListForm: TStaffListForm;

implementation

uses DataUnit, MainMenu;

{$R *.DFM}

procedure TStaffListForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select StaffName From AccessMenu Order By StaffName');
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

procedure TStaffListForm.AssignKeyBoard;
begin
 with Query do
  begin
   First;
   MoveBy((CurrentPage - 1) * 10);
   if Not EOF then
      begin
       Button1.Caption := Fields[0].AsString;
       Next;
      end
     else
      Button1.Caption := '';
   if Not EOF then
      begin
       Button2.Caption := Fields[0].AsString;
       Next;
      end
     else
      Button2.Caption := '';
   if Not EOF then
      begin
       Button3.Caption := Fields[0].AsString;
       Next;
      end
     else
      Button3.Caption := '';
   if Not EOF then
      begin
       Button4.Caption := Fields[0].AsString;
       Next;
      end
     else
      Button4.Caption := '';
   if Not EOF then
      begin
       Button5.Caption := Fields[0].AsString;
       Next;
      end
     else
      Button5.Caption := '';
   if Not EOF then
      begin
       Button6.Caption := Fields[0].AsString;
       Next;
      end
     else
      Button6.Caption := '';
   if Not EOF then
      begin
       Button7.Caption := Fields[0].AsString;
       Next;
      end
     else
      Button7.Caption := '';
   if Not EOF then
      begin
       Button8.Caption := Fields[0].AsString;
       Next;
      end
     else
      Button8.Caption := '';
   if Not EOF then
      begin
       Button9.Caption := Fields[0].AsString;
       Next;
      end
     else
      Button9.Caption := '';
   if Not EOF then
      begin
       Button10.Caption := Fields[0].AsString;
       Next;
      end
     else
      Button10.Caption := '';
  end;
end;

procedure TStaffListForm.PageUpButtonClick(Sender: TObject);
begin
 if CurrentPage >= 2 then
    begin
     CurrentPage := CurrentPage - 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
 Button1.SetFocus;
end;

procedure TStaffListForm.PageDownButtonClick(Sender: TObject);
begin
 if (CurrentPage * 10) < RowCount then
    begin
     CurrentPage := CurrentPage + 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
 Button1.SetFocus;
end;

procedure TStaffListForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TStaffListForm.ProcessButtonTouch(Position: integer);
begin
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 10 + Position - 1);
 StaffName := Query.FieldByName('StaffName').AsString;
 ReturnFlag := True;
 Close;
end;

procedure TStaffListForm.Button1Click(Sender: TObject);
begin
 CurrentPosition := 1;
 if Button1.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TStaffListForm.Button2Click(Sender: TObject);
begin
 CurrentPosition := 2;
 if Button2.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TStaffListForm.Button3Click(Sender: TObject);
begin
 CurrentPosition := 3;
 if Button3.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TStaffListForm.Button4Click(Sender: TObject);
begin
 CurrentPosition := 4;
 if Button4.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TStaffListForm.Button5Click(Sender: TObject);
begin
 CurrentPosition := 5;
 if Button5.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TStaffListForm.Button6Click(Sender: TObject);
begin
 CurrentPosition := 6;
 if Button6.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TStaffListForm.Button7Click(Sender: TObject);
begin
 CurrentPosition := 7;
 if Button7.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TStaffListForm.Button8Click(Sender: TObject);
begin
 CurrentPosition := 8;
 if Button8.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TStaffListForm.Button9Click(Sender: TObject);
begin
 CurrentPosition := 9;
 if Button9.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TStaffListForm.Button10Click(Sender: TObject);
begin
 CurrentPosition := 10;
 if Button10.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TStaffListForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 case Key of
  VK_PRIOR: PageUpButtonClick(Sender);
  VK_NEXT: PageDownButtonClick(Sender);
 end;
end;

procedure TStaffListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TStaffListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TStaffListForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := CancelButton.Top + 86;
 OpenQuery;
 AssignKeyBoard;
end;

function TStaffListForm.ListStaffPro(var StaffName: string): boolean;
begin
 Application.CreateForm(TStaffListForm, StaffListForm);
 StaffListForm.ShowModal;
 Result := StaffListForm.ReturnFlag;
 if Result then StaffName := StaffListForm.StaffName;
 StaffListForm.Free;
end;

end.
