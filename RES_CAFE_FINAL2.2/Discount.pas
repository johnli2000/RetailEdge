unit Discount;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DataUnit, bsSkinCtrls, BusinessSkinForm,
  XiButton;

type
  TDiscountForm = class(TForm)
    BusinessSkinForm: TbsBusinessSkinForm;
    DisplayPanel: TbsSkinPanel;
    NumDisplay: TbsSkinLabel;
    NumberPanel: TbsSkinPanel;
    Num7: TXiButton;
    Num8: TXiButton;
    Num9: TXiButton;
    ClearButton: TXiButton;
    Num4: TXiButton;
    Num5: TXiButton;
    Num6: TXiButton;
    OKButton: TXiButton;
    Num1: TXiButton;
    Num2: TXiButton;
    Num3: TXiButton;
    CancelButton: TXiButton;
    Num0: TXiButton;
    Decimal: TXiButton;
    ControlPanel: TbsSkinPanel;
    AllDiscountButton: TXiButton;
    ItemDiscountButton: TXiButton;
    DollarDiscountButton: TXiButton;
    procedure DisplayNumber;
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
    procedure DecimalClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure OKButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  ReadDiscountPro(var NumStr: string; var DiscountKind: integer): boolean;
    procedure AllDiscountButtonClick(Sender: TObject);
    procedure DollarDiscountButtonClick(Sender: TObject);
    procedure ItemDiscountButtonClick(Sender: TObject);
  private{ Private declarations }
    Number: string;
    ReturnFlag: boolean;
    DiscountKindFlag: integer;
  public
    { Public declarations }
  end;

var
  DiscountForm: TDiscountForm;

implementation

uses MainMenu, MessageBox;

{$R *.DFM}

procedure TDiscountForm.DisplayNumber;
begin
 NumDisplay.Caption := Number
end;

procedure TDiscountForm.ClearButtonClick(Sender: TObject);
var
 StrLength: integer;
begin
 StrLength := Length(Number);
 if Length(Number) = 1 then Number := '0'
   else
    begin
     if StrLength >= 1 then
        Number := Copy(Number, 1, StrLength - 1)
       else
        Number := '';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.Num0Click(Sender: TObject);
begin
 if (Length(Number) < 10) and (Number <> '0')  then
    Number := Number + '0';
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.Num1Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if (Number <> '0') then
        Number := Number + '1'
       else
        Number := '1';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.Num2Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '2'
       else
        Number := '2';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.Num3Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '3'
       else
        Number := '3';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.Num4Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '4'
       else
        Number := '4';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.Num5Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '5'
       else
        Number := '5';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.Num6Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '6'
       else
        Number := '6';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.Num7Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '7'
       else
        Number := '7';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.Num8Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '8'
       else
        Number := '8';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.Num9Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '9'
       else
        Number := '9';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.DecimalClick(Sender: TObject);
begin
 if (POS('.', Number) = 0) then Number := Number + '.';
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TDiscountForm.OKButtonClick(Sender: TObject);
begin
 ReturnFlag := True;
 Close;
end;

procedure TDiscountForm.FormKeyPress(Sender: TObject; var Key: Char);
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
  '.':    DecimalClick(Sender);
 end;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.AllDiscountButtonClick(Sender: TObject);
begin
 DiscountKindFlag := 0;
 AllDiscountButton.ColorScheme := csNeoSky;
 ItemDiscountButton.ColorScheme := csNeoSilver;
 DollarDiscountButton.ColorScheme := csNeoSilver;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.ItemDiscountButtonClick(Sender: TObject);
begin
 DiscountKindFlag := 1;
 AllDiscountButton.ColorScheme := csNeoSilver;
 ItemDiscountButton.ColorScheme := csNeoSky;
 DollarDiscountButton.ColorScheme := csNeoSilver;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.DollarDiscountButtonClick(Sender: TObject);
begin
 DiscountKindFlag := 2;
 AllDiscountButton.ColorScheme := csNeoSilver;
 ItemDiscountButton.ColorScheme := csNeoSilver;
 DollarDiscountButton.ColorScheme := csNeoSky;
 NumberPanel.SetFocus;
end;

procedure TDiscountForm.FormShow(Sender: TObject);
begin
 Height := ControlPanel.Height + 36;
 Width := DisplayPanel.Width + ControlPanel.Width + 16;
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
 Number := '0';
 case DiscountKindFlag of
  0: AllDiscountButtonClick(Sender);
  1: ItemDiscountButtonClick(Sender);
  2: DollarDiscountButtonClick(Sender);
 end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

function TDiscountForm.ReadDiscountPro(var NumStr: string; var DiscountKind: integer): boolean;
begin
 Application.CreateForm(TDiscountForm, DiscountForm);
 DiscountForm.DiscountKindFlag := DiscountKind;
 DiscountForm.ShowModal;
 Result := DiscountForm.ReturnFlag;
 if Result then
    begin
     NumStr := DiscountForm.Number;
     DiscountKind := DiscountForm.DiscountKindFlag;
    end;
 DiscountForm.Free;
end;

end.
