unit ManuallyEnterTableNo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DataUnit, bsSkinCtrls, BusinessSkinForm,
  XiButton;

type
  TManuallyEnterTableNoForm = class(TForm)
    TableNoEdit: TStaticText;
    DescriptionLabel: TLabel;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DispPanel: TbsSkinPanel;
    NumberPanel: TbsSkinPanel;
    Num7: TXiButton;
    Num8: TXiButton;
    Num9: TXiButton;
    Num4: TXiButton;
    Num5: TXiButton;
    Num6: TXiButton;
    Num1: TXiButton;
    Num2: TXiButton;
    Num3: TXiButton;
    Num0: TXiButton;
    ClearButton: TXiButton;
    OKButton: TXiButton;
    CancelButton: TXiButton;
    SearchOrderButton: TXiButton;
    AlphaKeyBoardButton: TXiButton;
    procedure ClearButtonClick(Sender: TObject);
    procedure Num0Click(Sender: TObject);
    procedure Num1Click(Sender: TObject);
    procedure Num2Click(Sender: TObject);
    procedure Num3Click(Sender: TObject);
    procedure Num4Click(Sender: TObject);
    procedure Num5Click(Sender: TObject);
    procedure Num6Click(Sender: TObject);
    procedure Num7Click(Sender: TObject);
    procedure Num8Click(Sender: TObject);
    procedure Num9Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OKButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  ReadTableNumberPro(var TableNo, OrderNo: string): boolean;
    procedure SearchOrderButtonClick(Sender: TObject);
    procedure AlphaKeyBoardButtonClick(Sender: TObject);
  private{ Private declarations }
    OrderNo: string;
    ReturnFlag: boolean;
    Op: integer;
  public
    { Public declarations }
  end;

var
  ManuallyEnterTableNoForm: TManuallyEnterTableNoForm;

implementation

uses MainMenu, MessageBox, OrderList, Keyboard;

{$R *.DFM}

procedure TManuallyEnterTableNoForm.ClearButtonClick(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) >= 1 then
    TableNoEdit.Caption := Copy(TableNoEdit.Caption, 1, Length(TableNoEdit.Caption) - 1)
end;

procedure TManuallyEnterTableNoForm.Num0Click(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) < 10 then
    TableNoEdit.Caption := TableNoEdit.Caption + '0';
end;

procedure TManuallyEnterTableNoForm.Num1Click(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) < 10 then
    TableNoEdit.Caption := TableNoEdit.Caption + '1';
end;

procedure TManuallyEnterTableNoForm.Num2Click(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) < 10 then
    TableNoEdit.Caption := TableNoEdit.Caption + '2';
end;

procedure TManuallyEnterTableNoForm.Num3Click(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) < 10 then
    TableNoEdit.Caption := TableNoEdit.Caption + '3';
end;

procedure TManuallyEnterTableNoForm.Num4Click(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) < 10 then
    TableNoEdit.Caption := TableNoEdit.Caption + '4';
end;

procedure TManuallyEnterTableNoForm.Num5Click(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) < 10 then
    TableNoEdit.Caption := TableNoEdit.Caption + '5';
end;

procedure TManuallyEnterTableNoForm.Num6Click(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) < 10 then
    TableNoEdit.Caption := TableNoEdit.Caption + '6';
end;

procedure TManuallyEnterTableNoForm.Num7Click(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) < 10 then
    TableNoEdit.Caption := TableNoEdit.Caption + '7';
end;

procedure TManuallyEnterTableNoForm.Num8Click(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) < 10 then
    TableNoEdit.Caption := TableNoEdit.Caption + '8';
end;

procedure TManuallyEnterTableNoForm.Num9Click(Sender: TObject);
begin
 if Length(TableNoEdit.Caption) < 10 then
    TableNoEdit.Caption := TableNoEdit.Caption + '9';
end;

procedure TManuallyEnterTableNoForm.AlphaKeyBoardButtonClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    TableNoEdit.Caption := Str;
end;

procedure TManuallyEnterTableNoForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TManuallyEnterTableNoForm.OKButtonClick(Sender: TObject);
begin
 if TableNoEdit.Caption <> '' then
    begin
     ReturnFlag := True;
     Op := 1;
     Close;
    end;
end;

procedure TManuallyEnterTableNoForm.SearchOrderButtonClick(Sender: TObject);
var
 TableNo: string;
begin
 if OrderListForm.OrderListPro(OrderNo, TableNo) then
    begin
     Op := 2;
     TableNoEdit.Caption := TableNo;
     ReturnFlag := True;
     Close;
    end;
end;

procedure TManuallyEnterTableNoForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 case Key of
  '1': Num1Click(Sender);
  '2': Num2Click(Sender);
  '3': Num3Click(Sender);
  '4': Num4Click(Sender);
  '5': Num5Click(Sender);
  '6': Num6Click(Sender);
  '7': Num7Click(Sender);
  '8': Num8Click(Sender);
  '9': Num9Click(Sender);
  '0': Num0Click(Sender);
  Chr(13): OKButtonClick(Sender);
  Chr(27): CancelButtonClick(Sender);
  Chr(8):  ClearButtonClick(Sender);
 end;
end;

procedure TManuallyEnterTableNoForm.FormShow(Sender: TObject);
begin
 SearchOrderButton.Caption := 'Edit' + Chr(13) + Chr(10) + 'Order';
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
 AlphaKeyBoardButton.Caption := 'Alpha' + Chr(13) + 'Keyboard';
end;

function TManuallyEnterTableNoForm.ReadTableNumberPro(var TableNo, OrderNo: string): boolean;
begin
 Application.CreateForm(TManuallyEnterTableNoForm, ManuallyEnterTableNoForm);
 ManuallyEnterTableNoForm.ShowModal;
 Result := ManuallyEnterTableNoForm.ReturnFlag;
 if Result then
    begin
     TableNo := ManuallyEnterTableNoForm.TableNoEdit.Caption;
     if ManuallyEnterTableNoForm.Op = 1 then OrderNo := ''
       else
        OrderNo := ManuallyEnterTableNoForm.OrderNo;
    end;
 ManuallyEnterTableNoForm.Free;
end;

end.
