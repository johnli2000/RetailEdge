unit VIPCreditBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainMenu, DataUnit, BusinessSkinForm, XiButton, StdCtrls,
  bsSkinCtrls, UtilUnit;

type
  TVIPCreditBalanceForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    Label1: TLabel;
    Label2: TLabel;
    AvailableCreditLabel: TStaticText;
    PointsLabel: TStaticText;
    ExitButton: TXiButton;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CreditBalancePro(VIPNo: integer);
  private  { Private declarations }
     VIPNo: integer;
  public
    { Public declarations }
  end;

var
  VIPCreditBalanceForm: TVIPCreditBalanceForm;

implementation

{$R *.dfm}

procedure TVIPCreditBalanceForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TVIPCreditBalanceForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TVIPCreditBalanceForm.FormShow(Sender: TObject);
begin
 AvailableCreditLabel.Caption := FormatCurrency(DataForm.GetAvailableCredit(VIPNo)) + ' ';
 if LoyaltyAwardAvailible then
    PointsLabel.Caption := Format('%1d ', [Trunc(DataForm.GetVIPAwardPoints(VIPNo, ''))]);
end;

procedure TVIPCreditBalanceForm.CreditBalancePro(VIPNo: integer);
begin
 Application.CreateForm(TVIPCreditBalanceForm, VIPCreditBalanceForm);
 VIPCreditBalanceForm.VIPNo := VIPNo;
 VIPCreditBalanceForm.ShowModal;
 VIPCreditBalanceForm.Free;
end;

end.
