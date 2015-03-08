unit PhoneFunctions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, BusinessSkinForm, XiButton,
  bsSkinCtrls;

type
  TPhoneFunctionsForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    SetOrderdueTimeButton: TXiButton;
    MealPackageButton: TXiButton;
    RewardPointsButton: TXiButton;
    OtherChargeButton: TXiButton;
    CancelButton: TXiButton;
    SurchargeButton: TXiButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  FunctionPro(var Operation: integer): boolean;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SetOrderdueTimeButtonClick(Sender: TObject);
    procedure MealPackageButtonClick(Sender: TObject);
    procedure SurchargeButtonClick(Sender: TObject);
    procedure OtherChargeButtonClick(Sender: TObject);
    procedure RewardPointsButtonClick(Sender: TObject);
  private { Private declarations }
    ReturnFlag: boolean;
    Operation: integer;
  public
    { Public declarations }
  end;

var
  PhoneFunctionsForm: TPhoneFunctionsForm;

implementation

{$R *.dfm}

procedure TPhoneFunctionsForm.SetOrderdueTimeButtonClick(Sender: TObject);
begin
 Operation := 1;
 ReturnFlag := True;
 Close;
end;

procedure TPhoneFunctionsForm.MealPackageButtonClick(Sender: TObject);
begin
 Operation := 2;
 ReturnFlag := True;
 Close;
end;

procedure TPhoneFunctionsForm.SurchargeButtonClick(Sender: TObject);
begin
 Operation := 3;
 ReturnFlag := True;
 Close;
end;

procedure TPhoneFunctionsForm.OtherChargeButtonClick(Sender: TObject);
begin
 Operation := 4;
 ReturnFlag := True;
 Close;
end;

procedure TPhoneFunctionsForm.RewardPointsButtonClick(Sender: TObject);
begin
 Operation := 5;
 ReturnFlag := True;
 Close;
end;

procedure TPhoneFunctionsForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TPhoneFunctionsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree
end;

procedure TPhoneFunctionsForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := WorkPanel.Height + 46;
end;

function TPhoneFunctionsForm.FunctionPro(var Operation: integer): boolean;
begin
 Application.CreateForm(TPhoneFunctionsForm, PhoneFunctionsForm);
 PhoneFunctionsForm.ShowModal;
 Result := PhoneFunctionsForm.ReturnFlag;
 if Result then
    Operation := PhoneFunctionsForm.Operation;
 PhoneFunctionsForm.Free;
end;

end.
