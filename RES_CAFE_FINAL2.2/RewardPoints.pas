unit RewardPoints;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, DataUnit, Grids, DBGrids, DB, ADODB, UtilUnit,
  XiButton, bsSkinCtrls, BusinessSkinForm;

type
  TRewardPointsForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    PointsLabel: TbsSkinLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    AsDollarsLabel: TbsSkinStdLabel;
    bsSkinPanel2: TbsSkinPanel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    NumDisplay: TbsSkinLabel;
    bsSkinPanel3: TbsSkinPanel;
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
    Num0: TXiButton;
    Decimal: TXiButton;
    CancelButton: TXiButton;
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
    function  GetRewardPointsPro(var AsDollars: double; VIPNo: integer; SalesAmount: double;
              OrderNo: string): boolean;
  private{ Private declarations }
    VIPNo: integer;
    CurrentPointsBalance, CurrentAsDollars, AsDollars, SalesAmount: double;
    ReturnFlag: boolean;
    Number, OrderNo: string;
  public
    { Public declarations }
  end;

var
  RewardPointsForm: TRewardPointsForm;

implementation

uses MainMenu, MessageBox;

{$R *.DFM}

procedure TRewardPointsForm.DisplayNumber;
begin
 NumDisplay.Caption := Number
end;

procedure TRewardPointsForm.ClearButtonClick(Sender: TObject);
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
end;

procedure TRewardPointsForm.Num0Click(Sender: TObject);
begin
 if (Length(Number) < 10) and (Number <> '0')  then
    Number := Number + '0';
 DisplayNumber;
end;

procedure TRewardPointsForm.Num1Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if (Number <> '0') then
        Number := Number + '1'
       else
        Number := '1';
    end;
 DisplayNumber;
end;

procedure TRewardPointsForm.Num2Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '2'
       else
        Number := '2';
    end;
 DisplayNumber;
end;

procedure TRewardPointsForm.Num3Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '3'
       else
        Number := '3';
    end;
 DisplayNumber;
end;

procedure TRewardPointsForm.Num4Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '4'
       else
        Number := '4';
    end;
 DisplayNumber;
end;

procedure TRewardPointsForm.Num5Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '5'
       else
        Number := '5';
    end;
 DisplayNumber;
end;

procedure TRewardPointsForm.Num6Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '6'
       else
        Number := '6';
    end;
 DisplayNumber;
end;

procedure TRewardPointsForm.Num7Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '7'
       else
        Number := '7';
    end;
 DisplayNumber;
end;

procedure TRewardPointsForm.Num8Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '8'
       else
        Number := '8';
    end;
 DisplayNumber;
end;

procedure TRewardPointsForm.Num9Click(Sender: TObject);
begin
 if Length(Number) < 10 then
    begin
     if Number <> '0' then
        Number := Number + '9'
       else
        Number := '9';
    end;
 DisplayNumber;
end;

procedure TRewardPointsForm.DecimalClick(Sender: TObject);
begin
 if (POS('.', Number) = 0) then Number := Number + '.';
 DisplayNumber;
end;

procedure TRewardPointsForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TRewardPointsForm.OKButtonClick(Sender: TObject);
begin
 if NumDisplay.Caption <> '' then
    AsDollars := StrToFloat(NumDisplay.Caption)
   else
    AsDollars := 0;
 if AsDollars > CurrentAsDollars then
    begin
     MessageBoxForm.MessagePro('This customer has ' + Format('%1d', [Trunc(CurrentPointsBalance)]) +
      ' points as ' + FormatCurrency(CurrentAsDollars) + ' only.', sErrorMsg);
     NumDisplay.Caption := Format('%4.2f ', [CurrentAsDollars]);
    end
   else
    if AsDollars > SalesAmount then
       begin
        MessageBoxForm.MessagePro('This order only can reddem ' + FormatCurrency(SalesAmount), sErrorMsg);
        NumDisplay.Caption := Format('%4.2f ', [SalesAmount]);
       end
      else
       begin
        ReturnFlag := True;
        Close;
       end;
end;

procedure TRewardPointsForm.FormKeyPress(Sender: TObject; var Key: Char);
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
end;

procedure TRewardPointsForm.FormShow(Sender: TObject);
begin
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
 CurrentPointsBalance := DataForm.GetVIPAwardPoints(VIPNo, OrderNo);
 PointsLabel.Caption := Format('%1d', [Trunc(CurrentPointsBalance)]);
 if PaymentPoints >= 1 then
    CurrentAsDollars := Trunc(CurrentPointsBalance / PaymentPoints)
   else
    CurrentAsDollars := 0;
 AsDollarsLabel.Caption := FormatCurrency(CurrentAsDollars);
 if CurrentAsDollars < SalesAmount then
    NumDisplay.Caption := Format('%4.2f ', [CurrentAsDollars])
   else
    NumDisplay.Caption := Format('%4.2f ', [SalesAmount]);
 Number := '';
end;

function TRewardPointsForm.GetRewardPointsPro(var AsDollars: double; VIPNo: integer;
         SalesAmount: double; OrderNo: string): boolean;
begin
 Application.CreateForm(TRewardPointsForm, RewardPointsForm);
 RewardPointsForm.VIPNo := VIPNo;
 RewardPointsForm.SalesAmount := SalesAmount;
 RewardPointsForm.OrderNo := OrderNo;
 RewardPointsForm.ShowModal;
 Result := RewardPointsForm.ReturnFlag;
 if Result then
    AsDollars := RewardPointsForm.AsDollars;
 RewardPointsForm.Free;
end;

end.
