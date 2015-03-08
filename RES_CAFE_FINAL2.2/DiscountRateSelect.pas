unit DiscountRateSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DataUnit, ADODB, XiButton, PanelButton,
  bsSkinCtrls, BusinessSkinForm;

type
  TDiscountRateSelectForm = class(TForm)
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
    ManuallyDiscountButton: TXiButton;
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
    function  DiscountRateSelectPro(var DiscountRate: double; var DiscountKind: integer;
                                    var PresetDiscountCode: string): boolean;
    procedure ManuallyDiscountButtonClick(Sender: TObject);
  private { Private declarations }
    CurrentPage, RowCount, CurrentPosition, DiscountKind: integer;
    ReturnFlag: boolean;
    DiscountRate: double;
    PresetDiscountCode: string;
  public
    { Public declarations }
  end;

var
  DiscountRateSelectForm: TDiscountRateSelectForm;

implementation

uses Discount, MainMenu;

{$R *.DFM}

procedure TDiscountRateSelectForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From DiscountRateTable Order By Code');
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

procedure TDiscountRateSelectForm.AssignKeyBoard;
begin
 with Query do
  begin
   First;
   MoveBy((CurrentPage - 1) * 6);
   if Not EOF then
      begin
       Menu1.Caption := Format('%-25s %5.2f%%', [FieldByName('Description').AsString, FieldByName('DiscountRate').AsFloat]);
       Next;
      end
     else
      Menu1.Caption := '';
   if Not EOF then
      begin
       Menu2.Caption := Format('%-25s %5.2f%%', [FieldByName('Description').AsString, FieldByName('DiscountRate').AsFloat]);
       Next;
      end
     else
      Menu2.Caption := '';
   if Not EOF then
      begin
       Menu3.Caption := Format('%-25s %5.2f%%', [FieldByName('Description').AsString, FieldByName('DiscountRate').AsFloat]);
       Next;
      end
     else
      Menu3.Caption := '';
   if Not EOF then
      begin
       Menu4.Caption := Format('%-25s %5.2f%%', [FieldByName('Description').AsString, FieldByName('DiscountRate').AsFloat]);
       Next;
      end
     else
      Menu4.Caption := '';
   if Not EOF then
      begin
       Menu5.Caption := Format('%-25s %5.2f%%', [FieldByName('Description').AsString, FieldByName('DiscountRate').AsFloat]);
       Next;
      end
     else
      Menu5.Caption := '';
   if Not EOF then
      begin
       Menu6.Caption := Format('%-25s %5.2f%%', [FieldByName('Description').AsString, FieldByName('DiscountRate').AsFloat]);
       Next;
      end
     else
      Menu6.Caption := '';
  end;
end;

procedure TDiscountRateSelectForm.PageUpButtonClick(Sender: TObject);
begin
 if CurrentPage >= 2 then
    begin
     CurrentPage := CurrentPage - 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
end;

procedure TDiscountRateSelectForm.PageDownButtonClick(Sender: TObject);
begin
 if (CurrentPage * 6) < RowCount then
    begin
     CurrentPage := CurrentPage + 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
end;

procedure TDiscountRateSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TDiscountRateSelectForm.ProcessButtonTouch(Position: integer);
begin
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 6 + Position - 1);
 DiscountRate := Query.FieldByName('DiscountRate').AsFloat;
 PresetDiscountCode := Query.FieldByName('Code').AsString;
 DiscountKind := 0;
 ReturnFlag := True;
 Close;
end;

procedure TDiscountRateSelectForm.Menu1Click(Sender: TObject);
begin
 CurrentPosition := 1;
 if Menu1.Caption <>'' then ProcessButtonTouch(CurrentPosition);
end;

procedure TDiscountRateSelectForm.Menu2Click(Sender: TObject);
begin
 CurrentPosition := 2;
 if Menu2.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TDiscountRateSelectForm.Menu3Click(Sender: TObject);
begin
 CurrentPosition := 3;
 if Menu3.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TDiscountRateSelectForm.Menu4Click(Sender: TObject);
begin
 CurrentPosition := 4;
 if Menu4.Caption <> '' then ProcessButtonTouch(CurrentPosition)
end;

procedure TDiscountRateSelectForm.Menu5Click(Sender: TObject);
begin
 CurrentPosition := 5;
 if Menu5.Caption <> '' then  ProcessButtonTouch(CurrentPosition)
end;

procedure TDiscountRateSelectForm.Menu6Click(Sender: TObject);
begin
 CurrentPosition := 6;
 if Menu6.Caption <> '' then ProcessButtonTouch(CurrentPosition);
end;

procedure TDiscountRateSelectForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 case Key of
  VK_PRIOR: PageUpButtonClick(Sender);
  VK_NEXT: PageDownButtonClick(Sender);
 end;
end;

procedure TDiscountRateSelectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then
    CancelButtonClick(Sender);
end;

procedure TDiscountRateSelectForm.ManuallyDiscountButtonClick(Sender: TObject);
var
 NumStr: string;
begin
 if DiscountForm.ReadDiscountPro(NumStr, DiscountKind) then
    begin
     DiscountRate := StrToFloat(NumStr);
     PresetDiscountCode := '';
     ReturnFlag := True;
     Close;
    end;
end;

procedure TDiscountRateSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
end;

procedure TDiscountRateSelectForm.FormShow(Sender: TObject);
begin
 OpenQuery;
 AssignKeyBoard;
 ManuallyDiscountButton.Caption := 'Manually' + Chr(13) + 'Discount';
 if Not ManuallyEnterDiscountRate then
    begin
     PageUpButton.Top := 34;
     PageDownButton.Top := 130;
     CancelButton.Top := 226;
     ManuallyDiscountButton.Visible := False;
    end
   else
    begin
     PageUpButton.Top := 12;
     PageDownButton.Top := 94;
     ManuallyDiscountButton.Top:= 176;
     CancelButton.Top := 258;
    end;
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
end;

function TDiscountRateSelectForm.DiscountRateSelectPro(var DiscountRate: double;
         var DiscountKind: integer; var PresetDiscountCode: string): boolean;
begin
 Application.CreateForm(TDiscountRateSelectForm, DiscountRateSelectForm);
 DiscountRateSelectForm.DiscountKind := DiscountKind;
 DiscountRateSelectForm.ShowModal;
 Result := DiscountRateSelectForm.ReturnFlag;
 if Result then
    begin
     DiscountRate := DiscountRateSelectForm.DiscountRate;
     DiscountKind := DiscountRateSelectForm.DiscountKind;
     PresetdiscountCode := DiscountRateSelectForm.PresetDiscountCode;
    end;
 DiscountRateSelectForm.Free;
end;

end.
