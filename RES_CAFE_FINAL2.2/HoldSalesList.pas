unit HoldSalesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, DB, ADODB, Grids, UtilUnit,
  bsSkinCtrls, XiButton, BusinessSkinForm;

type
  THoldOrderListForm = class(TForm)
    Query: TADOQuery;
    OrderListPanel: TbsSkinPanel;
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
    ConfirmButton: TXiButton;
    PageUpButton: TXiButton;
    PageDownButton: TXiButton;
    CancelButton: TXiButton;
    Button12: TXiButton;
    Button13: TXiButton;
    Button14: TXiButton;
    Button15: TXiButton;
    Button16: TXiButton;
    Button17: TXiButton;
    Button18: TXiButton;
    Button19: TXiButton;
    Button20: TXiButton;
    Button11: TXiButton;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    procedure ButtonClick(Sender: TObject);
    procedure OpenQuery;
    procedure AssignKeyPad(CurrentPage: integer);
    procedure PageUpButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    function  HoldOrderListPro(var HoldNo: integer): boolean;
  private { Private declarations }
    CurrentPage, RowCount, CurrentPosition: integer;
    ReturnFlag: boolean;
    HoldNo: integer;
  public
    { Public declarations }
  end;

var
  HoldOrderListForm: THoldOrderListForm;

implementation

uses DataUnit, MainMenu, MessageBox;

{$R *.dfm}

procedure THoldOrderListForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select HoldNo, HoldDate, CustomerName, Telephone, OpName ' +
           'From HoldHead Order By HoldDate, HoldNo';
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

procedure THoldOrderListForm.ButtonClick(Sender: TObject);
var
 I: integer;
begin
 with Sender As TXiButton do if Caption = '' then Exit;

 for I := 1 to 20 do
  with TXiButton(FindComponent('Button' + IntToStr(I))) do
   ColorScheme := csNeoSilver;

 with Sender As TXiButton do
  begin
   ColorScheme := csNeoRose;
   CurrentPosition := StrToInt(Copy(Name, 7, 2));
  end;
 if (CurrentPage - 1) * 20 + CurrentPosition <= RowCount then
    begin
     Query.First;
     Query.MoveBy((CurrentPage - 1) * 20 + CurrentPosition - 1);
     HoldNo := Query.FieldByName('HoldNo').AsInteger;
    end;
end;

procedure THoldOrderListForm.AssignKeyPad(CurrentPage: integer);
var
 I: integer;
begin
 I := 0;
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 12);
 while Not Query.EOF and (I < 20) do
  begin
   I := I + 1;
   with TXiButton(FindComponent('Button' + IntToStr(I))) do
    begin
     Caption := '';
     if (Query.FieldByName('CustomerName').AsString <> '') or
        (Query.FieldByName('Telephone').AsString <> '') then
        begin
         Caption := Query.FieldByName('CustomerName').AsString;
         if Query.FieldByName('Telephone').AsString <> '' then
            Caption := Caption + ' (' + Query.FieldByName('Telephone').AsString + ')';
         Caption := Caption + Chr(13) + Chr(10);
        end;
     Caption := Caption + FormatDateTime('dd/mm/yyyy hh:mm:ss', Query.FieldByName('HoldDate').AsDateTime) +
                   '  ' + Query.FieldByName('OpName').AsString;
     if I = CurrentPosition then
        ColorScheme := csNeoRose
       else
        ColorScheme := csNeoSilver;
    end;
   Query.Next;
  end;
 while I < 20 do
  begin
   I := I + 1;
   with TXiButton(FindComponent('Button' + IntToStr(I))) do
    begin
     Caption := '';
     ColorScheme := csNeoSilver;
    end;
  end;
end;

procedure THoldOrderListForm.PageUpButtonClick(Sender: TObject);
begin
 if CurrentPage >= 2 then
    begin
     CurrentPage := CurrentPage - 1;
     CurrentPosition := 1;
     AssignKeyPad(CurrentPage);
     Query.First;
     Query.MoveBy((CurrentPage - 1) * 20 + CurrentPosition - 1);
     HoldNo := Query.FieldByName('HoldNo').AsInteger;
    end;
end;

procedure THoldOrderListForm.PageDownButtonClick(Sender: TObject);
begin
 if CurrentPage * 20 < RowCount then
    begin
     CurrentPage := CurrentPage + 1;
     CurrentPosition := 1;
     AssignKeyPad(CurrentPage);
     Query.First;
     Query.MoveBy((CurrentPage - 1) * 20 + CurrentPosition - 1);
     HoldNo := Query.FieldByName('HoldNo').AsInteger;
    end;
end;

procedure THoldOrderListForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure THoldOrderListForm.ConfirmButtonClick(Sender: TObject);
begin
 if (CurrentPage - 1) * 20 + CurrentPosition <= RowCount then
    begin
     Query.First;
     Query.MoveBy((CurrentPage - 1) * 20 + CurrentPosition - 1);
     HoldNo := Query.FieldByName('HoldNo').AsInteger;
     ReturnFlag := True;
     Close;
    end;
end;

procedure THoldOrderListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure THoldOrderListForm.FormShow(Sender: TObject);
begin
 PageUpButton.Caption := 'Page' + Chr(13) + 'Up';
 PageDownButton.Caption := 'Page' + Chr(13) + 'Down';
 OpenQuery;
 AssignKeyPad(1);
 if (CurrentPage - 1) * 20 + CurrentPosition <= RowCount then
    begin
     Query.First;
     Query.MoveBy((CurrentPage - 1) * 20 + CurrentPosition - 1);
     HoldNo := Query.FieldByName('HoldNo').AsInteger;
    end;
end;

function THoldOrderListForm.HoldOrderListPro(var HoldNo: integer): boolean;
begin
 Application.CreateForm(THoldOrderListForm, HoldOrderListForm);
 HoldOrderListForm.ShowModal;
 Result := HoldOrderListForm.ReturnFlag;
 if Result then HoldNo := HoldOrderListForm.HoldNo;
 HoldOrderListForm.Free;
end;

end.
