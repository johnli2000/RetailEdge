unit DispPayment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ExtCtrls, UtilUnit, BusinessSkinForm,
  bsSkinCtrls, XiButton;

type
  TDispPaymentForm = class(TForm)
    TotalPanel: TbsSkinPanel;
    DataPanel: TbsSkinPanel;
    BalanceLabel: TbsSkinStdLabel;
    OrderNoEdit: TbsSkinLabel;
    PayByEdit: TbsSkinLabel;
    TipsEdit: TbsSkinLabel;
    PaymentEdit: TbsSkinLabel;
    ChangeEdit: TbsSkinLabel;
    AmountEdit: TbsSkinLabel;
    RoundingEdit: TbsSkinLabel;
    ReceivableEdit: TbsSkinLabel;
    SurchargeEdit: TbsSkinLabel;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    ConfirmButton: TXiButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure DispPaymentPro(OrderNo: string;
              Amount, PayAmount, Tips, Rounding, Surcharge,
              Change: double; Payby: string);
    procedure FormShow(Sender: TObject);
  private { Private declarations }
  public
    { Public declarations }
  end;

var
  DispPaymentForm: TDispPaymentForm;

implementation

uses DataUnit, NumPad, PaymentSelect, MainMenu, MessageBox;

{$R *.DFM}

procedure TDispPaymentForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DataForm.SendToPoleDisp('NEXT CUSTOMER PLEASE', '');
 if FVar.SecondDisplay = 1 then SecondDisplayForm.SetWaitingStatus;
 Action := caFree;
end;

procedure TDispPaymentForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TDispPaymentForm.ConfirmButtonClick(Sender: TObject);
begin
 DataForm.TestDrawerStatus(CurrentDrawerNumber);
 if Not DrawerIsOpen then Close
end;

procedure TDispPaymentForm.FormShow(Sender: TObject);
begin
 Width := TotalPanel.Width + 28;
 Height := ConfirmButton.Top + 86;
end;

procedure TDispPaymentForm.DispPaymentPro(OrderNo: string; Amount, PayAmount, Tips,
          Rounding, Surcharge, Change: double; Payby: string);
begin
 Application.CreateForm(TDispPaymentForm, DispPaymentForm);
 DispPaymentForm.OrderNoEdit.Caption := OrderNo;
 DispPaymentForm.AmountEdit.Caption := Format('%4.2f ', [Amount]);
 DispPaymentForm.RoundingEdit.Caption := Format('%4.2f ', [Rounding]);
 DispPaymentForm.ReceivableEdit.Caption := Format('%4.2f ', [Amount + Rounding]);
 DispPaymentForm.PayByEdit.Caption := Payby;
 DispPaymentForm.TipsEdit.Caption := Format('%4.2f ', [Tips]);
 DispPaymentForm.SurchargeEdit.Caption := Format('%4.2f ', [Surcharge]);
 DispPaymentForm.PaymentEdit.Caption := Format('%4.2f ', [PayAmount]);
 DispPaymentForm.ChangeEdit.Caption := Format('%4.2f ', [ABS(Change)]);
 DispPaymentForm.ShowModal;
 DispPaymentForm.Free;
end;

end.
