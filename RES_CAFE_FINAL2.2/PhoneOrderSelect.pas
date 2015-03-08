unit PhoneOrderSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, MainMenu, XiButton, bsSkinCtrls, BusinessSkinForm, DataUnit;

type
  TPhoneOrderSelectForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    PickupButton: TXiButton;
    DeliveryButton: TXiButton;
    CancelButton: TXiButton;
    TakeAwayButton: TXiButton;
    procedure PickupButtonClick(Sender: TObject);
    procedure DeliveryButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  SelectPhoneOrder(var Op: integer): boolean;
    procedure CancelButtonClick(Sender: TObject);
    procedure TakeAwayButtonClick(Sender: TObject);
  private { Private declarations }
     ReturnFlag: boolean;
     Op: integer;
  public
    { Public declarations }
  end;

var
  PhoneOrderSelectForm: TPhoneOrderSelectForm;

implementation

{$R *.dfm}

procedure TPhoneOrderSelectForm.DeliveryButtonClick(Sender: TObject);
begin
 Op := sPhoneOrderDelivery;
 ReturnFlag := True;
 Close;
end;

procedure TPhoneOrderSelectForm.PickupButtonClick(Sender: TObject);
begin
 Op := sPhoneOrderPickUp;
 ReturnFlag := True;
 Close;
end;

procedure TPhoneOrderSelectForm.TakeAwayButtonClick(Sender: TObject);
begin
 Op := sTakeAway;
 ReturnFlag := True;
 Close;
end;

procedure TPhoneOrderSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TPhoneOrderSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

function TPhoneOrderSelectForm.SelectPhoneOrder(var Op: integer): boolean;
begin
 Application.CreateForm(TPhoneOrderSelectForm, PhoneOrderSelectForm);
 PhoneOrderSelectForm.ShowModal;
 Result := PhoneOrderSelectForm.ReturnFlag;
 if Result then Op := PhoneOrderSelectForm.Op;
 PhoneOrderSelectForm.Free;
end;

end.
