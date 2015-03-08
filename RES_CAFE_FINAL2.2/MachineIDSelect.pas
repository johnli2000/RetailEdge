unit MachineIDSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DataUnit, ADODB, MainMenu, XiButton,
  bsSkinCtrls, BusinessSkinForm;

type
  TMachineIDSelectForm = class(TForm)
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    Menu1: TXiButton;
    Menu2: TXiButton;
    Menu3: TXiButton;
    Menu4: TXiButton;
    Menu5: TXiButton;
    Menu6: TXiButton;
    PageUpButton: TXiButton;
    PageDownButton: TXiButton;
    CancelButton: TXiButton;
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
    procedure Menu1Enter(Sender: TObject);
    procedure Menu2Enter(Sender: TObject);
    procedure Menu3Enter(Sender: TObject);
    procedure Menu4Enter(Sender: TObject);
    procedure Menu5Enter(Sender: TObject);
    procedure Menu6Enter(Sender: TObject);
    procedure Menu1Exit(Sender: TObject);
    procedure Menu2Exit(Sender: TObject);
    procedure Menu3Exit(Sender: TObject);
    procedure Menu4Exit(Sender: TObject);
    procedure Menu5Exit(Sender: TObject);
    procedure Menu6Exit(Sender: TObject);
    function  MachineIDSelectPro(var MachineName: string): boolean;
  private { Private declarations }
    CurrentPage, RowCount, CurrentPosition: integer;
    ReturnFlag: boolean;
    MachineName: string;
  public
    { Public declarations }
  end;

var
  MachineIDSelectForm: TMachineIDSelectForm;

implementation

{$R *.DFM}

procedure TMachineIDSelectForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From MachineID Order By MachineID');
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

procedure TMachineIDSelectForm.AssignKeyBoard;
begin
 with Query do
  begin
   First;
   MoveBy((CurrentPage - 1) * 6);
   if Not EOF then
      begin
       Menu1.Caption := Query.FieldByName('MachineID').AsString;
       Next;
      end
     else
      Menu1.Caption := '';
   if Not EOF then
      begin
       Menu2.Caption := Query.FieldByName('MachineID').AsString;
       Next;
      end
     else
      Menu2.Caption := '';
   if Not EOF then
      begin
       Menu3.Caption := Query.FieldByName('MachineID').AsString;
       Next;
      end
     else
      Menu3.Caption := '';
   if Not EOF then
      begin
       Menu4.Caption := Query.FieldByName('MachineID').AsString;
       Next;
      end
     else
      Menu4.Caption := '';
   if Not EOF then
      begin
       Menu5.Caption := Query.FieldByName('MachineID').AsString;
       Next;
      end
     else
      Menu5.Caption := '';
   if Not EOF then
      begin
       Menu6.Caption := Query.FieldByName('MachineID').AsString;
       Next;
      end
     else
      Menu6.Caption := '';
  end;
end;

procedure TMachineIDSelectForm.PageUpButtonClick(Sender: TObject);
begin
 if CurrentPage >= 2 then
    begin
     CurrentPage := CurrentPage - 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
 Menu1.SetFocus;
end;

procedure TMachineIDSelectForm.PageDownButtonClick(Sender: TObject);
begin
 if (CurrentPage * 6) < RowCount then
    begin
     CurrentPage := CurrentPage + 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
 Menu1.SetFocus;
end;

procedure TMachineIDSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TMachineIDSelectForm.ProcessButtonTouch(Position: integer);
begin
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 6 + Position - 1);
 MachineName := Query.FieldByName('MachineID').AsString;
 ReturnFlag := True;
 Close;
end;

procedure TMachineIDSelectForm.Menu1Click(Sender: TObject);
begin
 CurrentPosition := 1;
 if Menu1.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TMachineIDSelectForm.Menu2Click(Sender: TObject);
begin
 CurrentPosition := 2;
 if Menu2.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TMachineIDSelectForm.Menu3Click(Sender: TObject);
begin
 CurrentPosition := 3;
 if Menu3.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TMachineIDSelectForm.Menu4Click(Sender: TObject);
begin
 CurrentPosition := 4;
 if Menu4.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TMachineIDSelectForm.Menu5Click(Sender: TObject);
begin
 CurrentPosition := 5;
 if Menu5.Caption <> '' then  ProcessButtonTouch(CurrentPosition)
end;

procedure TMachineIDSelectForm.Menu6Click(Sender: TObject);
begin
 CurrentPosition := 6;
 if Menu6.Caption <> '' then ProcessButtonTouch(CurrentPosition);
end;

procedure TMachineIDSelectForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 case Key of
  VK_PRIOR: PageUpButtonClick(Sender);
  VK_NEXT: PageDownButtonClick(Sender);
 end;
end;

procedure TMachineIDSelectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then
    CancelButtonClick(Sender);
end;

procedure TMachineIDSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
end;

procedure TMachineIDSelectForm.Menu1Enter(Sender: TObject);
begin
 Menu1.Font.Color := clBlue;
end;

procedure TMachineIDSelectForm.Menu2Enter(Sender: TObject);
begin
 Menu2.Font.Color := clBlue;
end;

procedure TMachineIDSelectForm.Menu3Enter(Sender: TObject);
begin
 Menu3.Font.Color := clBlue;
end;

procedure TMachineIDSelectForm.Menu4Enter(Sender: TObject);
begin
 Menu4.Font.Color := clBlue;
end;

procedure TMachineIDSelectForm.Menu5Enter(Sender: TObject);
begin
 Menu5.Font.Color := clBlue;
end;

procedure TMachineIDSelectForm.Menu6Enter(Sender: TObject);
begin
 Menu6.Font.Color := clBlue;
end;

procedure TMachineIDSelectForm.Menu1Exit(Sender: TObject);
begin
 Menu1.Font.Color := clBlack;
end;

procedure TMachineIDSelectForm.Menu2Exit(Sender: TObject);
begin
 Menu2.Font.Color := clBlack;
end;

procedure TMachineIDSelectForm.Menu3Exit(Sender: TObject);
begin
 Menu3.Font.Color := clBlack;
end;

procedure TMachineIDSelectForm.Menu4Exit(Sender: TObject);
begin
 Menu4.Font.Color := clBlack;
end;

procedure TMachineIDSelectForm.Menu5Exit(Sender: TObject);
begin
 Menu5.Font.Color := clBlack;
end;

procedure TMachineIDSelectForm.Menu6Exit(Sender: TObject);
begin
 Menu6.Font.Color := clBlack;
end;

procedure TMachineIDSelectForm.FormShow(Sender: TObject);
begin
 OpenQuery;
 AssignKeyBoard;
 Menu1.SetFocus;
end;

function TMachineIDSelectForm.MachineIDSelectPro(var MachineName: string): boolean;
begin
 Application.CreateForm(TMachineIDSelectForm, MachineIDSelectForm);
 MachineIDSelectForm.ShowModal;
 Result := MachineIDSelectForm.ReturnFlag;
 if Result then
    MachineName := MachineIDSelectForm.MachineName;
 MachineIDSelectForm.Free;
end;

end.
