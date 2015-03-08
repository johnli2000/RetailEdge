unit NumPad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DataUnit, XiButton, BusinessSkinForm, Mask,
  bsSkinBoxCtrls, bsSkinCtrls, SUIButton, jpeg;

type
  TNumberPadForm = class(TForm)
    DispPanel: TbsSkinPanel;
    BusinessSkinForm: TbsBusinessSkinForm;
    NumberPanel: TbsSkinPanel;
    Num7: TXiButton;
    Num8: TXiButton;
    Num9: TXiButton;
    StubtractButton: TXiButton;
    ClearButton: TXiButton;
    Num4: TXiButton;
    Num5: TXiButton;
    Num6: TXiButton;
    OKButton: TXiButton;
    Num1: TXiButton;
    Num2: TXiButton;
    Num3: TXiButton;
    Num0: TXiButton;
    Decimal: TXiButton;
    CancelButton: TXiButton;
    MoneyPanel: TbsSkinPanel;
    MoneyButton1: TXiButton;
    MoneyButton2: TXiButton;
    MoneyButton3: TXiButton;
    MoneyButton4: TXiButton;
    MoneyButton5: TXiButton;
    NumDisplay: TbsSkinLabel;
    suiButton2: TsuiButton;
    suiButton3: TsuiButton;
    suiButton4: TsuiButton;
    suiButton5: TsuiButton;
    suiButton6: TsuiButton;
    suiButton7: TsuiButton;
    suiButton8: TsuiButton;
    suiButton9: TsuiButton;
    suiButton10: TsuiButton;
    suiButton11: TsuiButton;
    suiButton12: TsuiButton;
    suiButton13: TsuiButton;
    suiButton14: TsuiButton;
    suiButton15: TsuiButton;
    Image1: TImage;
    Image2: TImage;
    suiButton1: TsuiButton;
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
    procedure StubtractButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure MoneyButton1Click(Sender: TObject);
    procedure MoneyButton2Click(Sender: TObject);
    procedure MoneyButton3Click(Sender: TObject);
    procedure MoneyButton4Click(Sender: TObject);
    procedure MoneyButton5Click(Sender: TObject);
    function  ReadNumberPro(var NumStr: string; Password, DispMoney: boolean;
              Description: string; CompareAmount: double): boolean;

  private{ Private declarations }
    Number: string;
    ReturnFlag, Password, DispMoney: boolean;
    CompareAmount: double;
  public
    { Public declarations }
  end;

var
  NumberPadForm: TNumberPadForm;

implementation

uses MainMenu, MessageBox;

{$R *.DFM}

procedure TNumberPadForm.DisplayNumber;
var
 I: integer;
begin
 if Not Password then
    NumDisplay.Caption := Number
   else
    begin
     NumDisplay.Caption := '';
     for I := 1 to Length(Number) do
       NumDisplay.Caption := NumDisplay.Caption + 'X'
    end;
end;

procedure TNumberPadForm.ClearButtonClick(Sender: TObject);
var
 StrLength: integer;
begin
 StrLength := Length(Number);
 if Not Password and (StrLength = 1) then
    Number := '0'
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

procedure TNumberPadForm.Num0Click(Sender: TObject);
begin
 if Length(Number) < 16 then
    begin
     if Password or (Number <> '0')  then
        Number := Number + '0';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.Num1Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Password or (Number <> '0') then
        Number := Number + '1'
       else
        Number := '1';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.Num2Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Password or (Number <> '0') then
        Number := Number + '2'
       else
        Number := '2';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.Num3Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Password or (Number <> '0') then
        Number := Number + '3'
       else
        Number := '3';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.Num4Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Password or (Number <> '0') then
        Number := Number + '4'
       else
        Number := '4';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.Num5Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Password or (Number <> '0') then
        Number := Number + '5'
       else
        Number := '5';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.Num6Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Password or (Number <> '0') then
        Number := Number + '6'
       else
        Number := '6';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.Num7Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Password or (Number <> '0') then
        Number := Number + '7'
       else
        Number := '7';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.Num8Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Password or (Number <> '0') then
        Number := Number + '8'
       else
        Number := '8';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.Num9Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Password or (Number <> '0') then
        Number := Number + '9'
       else
        Number := '9';
    end;
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.StubtractButtonClick(Sender: TObject);
var
 Temp: double;
begin
 if Not Password then
    begin
     Temp := StrToFloat(Number);
     Temp := 0 - Temp;
     Number := FloatToStr(Temp);
     DisplayNumber;
    end;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.DecimalClick(Sender: TObject);
begin
 if Not Password and (POS('.', Number) = 0) then
    Number := Number + '.';
 DisplayNumber;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TNumberPadForm.OKButtonClick(Sender: TObject);
begin
 ReturnFlag := True;
 Close;
end;

procedure TNumberPadForm.FormKeyPress(Sender: TObject; var Key: Char);
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
  Chr(8): ClearButtonClick(Sender);
  '.': DecimalClick(Sender);
 else
  Key := Chr(0); 
 end;
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.MoneyButton1Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Number <> '0' then
        Number := FloatToStr(StrToFloat(Number) + 5)
       else
        Number := '5';
    end;
 DisplayNumber;
 if (ABS(CompareAmount) >= 0.01) and
    (StrToFloat(Number) - CompareAmount >= 0) then
    OKButtonClick(Sender);
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.MoneyButton2Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Number <> '0' then
        Number := FloatToStr(StrToFloat(Number) + 10)
       else
        Number := '10';
    end;
 DisplayNumber;
 if (ABS(CompareAmount) >= 0.01) and
    (StrToFloat(Number) - CompareAmount >= 0) then
    OKButtonClick(Sender);
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.MoneyButton3Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Number <> '0' then
        Number := FloatToStr(StrToFloat(Number) + 20)
       else
        Number := '20';
    end;
 DisplayNumber;
 if (ABS(CompareAmount) >= 0.01) and
    (StrToFloat(Number) - CompareAmount >= 0) then
    OKButtonClick(Sender);
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.MoneyButton4Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Number <> '0' then
        Number := FloatToStr(StrToFloat(Number) + 50)
       else
        Number := '50';
    end;
 DisplayNumber;
 if (ABS(CompareAmount) >= 0.01) and
    (StrToFloat(Number) - CompareAmount >= 0) then
    OKButtonClick(Sender);
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.MoneyButton5Click(Sender: TObject);
begin
 if (Length(Number) < 16) then
    begin
     if Number <> '0' then
        Number := FloatToStr(StrToFloat(Number) + 100)
       else
        Number := '100';
    end;
 DisplayNumber;
 if (ABS(CompareAmount) >= 0.01) and
    (StrToFloat(Number) - CompareAmount >= 0) then
    OKButtonClick(Sender);
 NumberPanel.SetFocus;
end;

procedure TNumberPadForm.FormShow(Sender: TObject);
begin
 //Height := MoneyPanel.Height + 38;
 if Not DispMoney then
    begin
     MoneyPanel.Visible := False;
     //Width := DispPanel.Width + 16;
    end
   else
    begin
     MoneyPanel.Visible := True;
     //Width := DispPanel.Width + MoneyPanel.Width + 16;
    end;
 if Password then
    begin
     Number := '';
     NumDisplay.Caption := '';
     //StubtractButton.Visible := False;
     //ClearButton.Left := StubtractButton.Left;
     //ClearButton.Width := OKButton.Width;
    end
   else
    begin
     NumDisplay.Caption := Number;
     Number := '0'
    end;
 MoneyButton1.Caption := sCurrency + '5';
 MoneyButton2.Caption := sCurrency + '10';
 MoneyButton3.Caption := sCurrency + '20';
 MoneyButton4.Caption := sCurrency + '50';
 MoneyButton5.Caption := sCurrency + '100';
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
 NumberPanel.SetFocus;
end;

function TNumberPadForm.ReadNumberPro(var NumStr: string;
         Password, DispMoney: boolean;
         Description: string; CompareAmount: double): boolean;
begin
 Application.CreateForm(TNumberPadForm, NumberPadForm);
 NumberPadForm.Number := NumStr;
 NumberPadForm.Password := Password;
 NumberPadForm.DispMoney := DispMoney;
 NumberPadForm.CompareAmount := CompareAmount;
 NumberPadForm.Caption := Description;
 NumberPadForm.ShowModal;
 Result := NumberPadForm.ReturnFlag;
 if Result then
    begin
     if Password then
        NumStr := NumberPadForm.Number
       else
        if NumberPadForm.NumDisplay.Caption = '' then
           NumStr := '0'
          else
           NumStr := NumberPadForm.NumDisplay.Caption;
    end;
 NumberPadForm.Free;
end;

end.
