unit PaymentSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DataUnit, ADODB, MainMenu,
  BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TPaymentSelectForm = class(TForm)
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
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
    CancelButton: TXiButton;
    procedure OpenQuery(SQLStr: string);
    procedure OpenPaymentQuery;
    procedure AssignKeyBoard;
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure ProcessButtonTouch(Position: integer);
    procedure MenuButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function  PaymentSelectPro(var Code: string; var SurchargeRate: double;
              var LinkToEFTPOS: boolean): boolean;
  private { Private declarations }
    CurrentPage, RowCount, CurrentPosition: integer;
    ReturnFlag, LinkToEFTPOS: boolean;
    Code: string;
    SurchargeRate: double;
  public
    { Public declarations }
  end;

var
  PaymentSelectForm: TPaymentSelectForm;

implementation

{$R *.DFM}

procedure TPaymentSelectForm.OpenQuery(SQLStr: string);
begin
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

procedure TPaymentSelectForm.OpenPaymentQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From Payment Where ShowOnList <> 0 Order By Code';
 OpenQuery(SQLStr);
end;

procedure TPaymentSelectForm.AssignKeyBoard;
var
 I: integer;
 ButtonName: string;
begin
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 10);
 for I := 1 to 10 do
  begin
   ButtonName := 'Menu' + IntToStr(I);
   with TPanel(FindComponent(ButtonName)) do
    if Not Query.EOF then
       begin
        Caption := Query.FieldByName('Payment').AsString;
        Query.Next;
       end
      else
       Caption := '';
    end;
end;

procedure TPaymentSelectForm.PageUpButtonClick(Sender: TObject);
begin
 if CurrentPage >= 2 then
    begin
     CurrentPage := CurrentPage - 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
 Menu1.SetFocus;
end;

procedure TPaymentSelectForm.PageDownButtonClick(Sender: TObject);
begin
 if (CurrentPage * 10) < RowCount then
    begin
     CurrentPage := CurrentPage + 1;
     AssignKeyBoard;
     CurrentPosition := 1;
    end;
 Menu1.SetFocus;
end;

procedure TPaymentSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TPaymentSelectForm.ProcessButtonTouch(Position: integer);
begin
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 10 + Position - 1);
 Code := Query.FieldByName('Payment').AsString;
 SurchargeRate := Query.FieldByName('SurchargeRate').AsFloat;
 LinkToEFTPOS := Query.FieldByName('LinkToEFTPOS').AsBoolean;
 ReturnFlag := True;
 Close;
end;

procedure TPaymentSelectForm.MenuButtonClick(Sender: TObject);
begin
 with Sender As TXiButton do
  if Caption <> '' then
     begin
      CurrentPosition := StrToInt(Copy(Name, 5, 2));
      ProcessButtonTouch(CurrentPosition);
     end;
end;

procedure TPaymentSelectForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 case Key of
  VK_PRIOR: PageUpButtonClick(Sender);
  VK_NEXT: PageDownButtonClick(Sender);
 end;
end;

procedure TPaymentSelectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then
    CancelButtonClick(Sender);
end;

procedure TPaymentSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
end;

procedure TPaymentSelectForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := CancelButton.Top + 86;
 OpenPaymentQuery;
 AssignKeyBoard;
 Menu1.SetFocus;
end;

function TPaymentSelectForm.PaymentSelectPro(var Code: string;
         var SurchargeRate: double; var LinkToEFTPOS: boolean): boolean;
begin
 Application.CreateForm(TPaymentSelectForm, PaymentSelectForm);
 PaymentSelectForm.ShowModal;
 Result := PaymentSelectForm.ReturnFlag;
 if Result then
    begin
     Code := PaymentSelectForm.Code;
     SurchargeRate := PaymentSelectForm.SurchargeRate;
     LinkToEFTPOS := PaymentSelectForm.LinkToEFTPOS;
    end;
 PaymentSelectForm.Free;
end;

end.
