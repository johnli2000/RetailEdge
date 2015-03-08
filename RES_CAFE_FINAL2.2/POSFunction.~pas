unit POSFunction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, BusinessSkinForm, XiButton,
  bsSkinCtrls;

type
  TPOSFunctionForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    MenuSetupButton: TXiButton;
    DailyReportButton: TXiButton;
    CashFloatButton: TXiButton;
    SetOrderdueTimeButton: TXiButton;
    MealPackageButton: TXiButton;
    RewardPointsButton: TXiButton;
    DepositButton: TXiButton;
    OtherChargeButton: TXiButton;
    CancelButton: TXiButton;
    procedure MenuSetupButtonClick(Sender: TObject);
    procedure DailyReportButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  FunctionPro(var Operation: integer): boolean;
    procedure CashFloatButtonClick(Sender: TObject);
    procedure SetOrderdueTimeButtonClick(Sender: TObject);
    procedure RewardPointsButtonClick(Sender: TObject);
    procedure MealPackageButtonClick(Sender: TObject);
    procedure OtherChargeButtonClick(Sender: TObject);
    procedure DepositButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private { Private declarations }
    ReturnFlag: boolean;
    Operation: integer;
  public
    { Public declarations }
  end;

var
  POSFunctionForm: TPOSFunctionForm;

implementation

{$R *.dfm}

procedure TPOSFunctionForm.MenuSetupButtonClick(Sender: TObject);
begin
 Operation := 1;
 ReturnFlag := True;
 Close;
end;

procedure TPOSFunctionForm.DailyReportButtonClick(Sender: TObject);
begin
 Operation := 2;
 ReturnFlag := True;
 Close;
end;

procedure TPOSFunctionForm.CashFloatButtonClick(Sender: TObject);
begin
 Operation := 3;
 ReturnFlag := True;
 Close;
end;

procedure TPOSFunctionForm.SetOrderdueTimeButtonClick(Sender: TObject);
begin
 Operation := 4;
 ReturnFlag := True;
 Close;
end;

procedure TPOSFunctionForm.MealPackageButtonClick(Sender: TObject);
begin
 Operation := 5;
 ReturnFlag := True;
 Close;
end;

procedure TPOSFunctionForm.RewardPointsButtonClick(Sender: TObject);
begin
 Operation := 6;
 ReturnFlag := True;
 Close;
end;

procedure TPOSFunctionForm.DepositButtonClick(Sender: TObject);
begin
 Operation := 7;
 ReturnFlag := True;
 Close;
end;

procedure TPOSFunctionForm.OtherChargeButtonClick(Sender: TObject);
begin
 Operation := 8;
 ReturnFlag := True;
 Close;
end;

procedure TPOSFunctionForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TPOSFunctionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree
end;

procedure TPOSFunctionForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := CancelButton.Top + 86;
end;

function TPOSFunctionForm.FunctionPro(var Operation: integer): boolean;
begin
 Application.CreateForm(TPOSFunctionForm, POSFunctionForm);
 POSFunctionForm.ShowModal;
 Result := POSFunctionForm.ReturnFlag;
 if Result then
    Operation := POSFunctionForm.Operation;
 POSFunctionForm.Free;
end;

end.
