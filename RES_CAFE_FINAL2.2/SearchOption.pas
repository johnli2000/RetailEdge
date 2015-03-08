unit SearchOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, XiButton, bsSkinCtrls,
  BusinessSkinForm;

type
  TSearchOptionForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
    VIPNumberButton: TXiButton;
    VIPNameButton: TXiButton;
    CompanyButton: TXiButton;
    TelephoneButton: TXiButton;
    FaxButton: TXiButton;
    MobileButton: TXiButton;
    AddressButton: TXiButton;
    SuburbButton: TXiButton;
    StateButton: TXiButton;
    PostCodeButton: TXiButton;
    SerialNumberButton: TXiButton;
    CancelButton: TXiButton;
    procedure VIPNumberButtonClick(Sender: TObject);
    procedure VIPNameButtonClick(Sender: TObject);
    procedure CompanyButtonClick(Sender: TObject);
    procedure TelephoneButtonClick(Sender: TObject);
    procedure FaxButtonClick(Sender: TObject);
    procedure MobileButtonClick(Sender: TObject);
    procedure AddressButtonClick(Sender: TObject);
    procedure SuburbButtonClick(Sender: TObject);
    procedure StateButtonClick(Sender: TObject);
    procedure PostCodeButtonClick(Sender: TObject);
    procedure SerialNumberButtonClick(Sender: TObject);
    function  SearchOptionPro: integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private { Private declarations }
    ReturnFlag: integer;
  public
    { Public declarations }
  end;

var
  SearchOptionForm: TSearchOptionForm;

implementation

{$R *.dfm}

procedure TSearchOptionForm.VIPNumberButtonClick(Sender: TObject);
begin
 ReturnFlag := 0;
 Close;
end;

procedure TSearchOptionForm.VIPNameButtonClick(Sender: TObject);
begin
 ReturnFlag := 1;
 Close;
end;

procedure TSearchOptionForm.CompanyButtonClick(Sender: TObject);
begin
 ReturnFlag := 2;
 Close;
end;

procedure TSearchOptionForm.TelephoneButtonClick(Sender: TObject);
begin
 ReturnFlag := 3;
 Close;
end;

procedure TSearchOptionForm.FaxButtonClick(Sender: TObject);
begin
 ReturnFlag := 4;
 Close;
end;

procedure TSearchOptionForm.MobileButtonClick(Sender: TObject);
begin
 ReturnFlag := 5;
 Close;
end;

procedure TSearchOptionForm.AddressButtonClick(Sender: TObject);
begin
 ReturnFlag := 6;
 Close;
end;

procedure TSearchOptionForm.SuburbButtonClick(Sender: TObject);
begin
 ReturnFlag := 7;
 Close;
end;

procedure TSearchOptionForm.StateButtonClick(Sender: TObject);
begin
 ReturnFlag := 8;
 Close;
end;

procedure TSearchOptionForm.PostCodeButtonClick(Sender: TObject);
begin
 ReturnFlag := 9;
 Close;
end;

procedure TSearchOptionForm.SerialNumberButtonClick(Sender: TObject);
begin
 ReturnFlag := 10;
 Close;
end;

procedure TSearchOptionForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := -1;
 Close;
end;

procedure TSearchOptionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TSearchOptionForm.FormShow(Sender: TObject);
begin
 Width := BackPanel.Width + 28;
 Height := BackPanel.Height + 48;
end;

function TSearchOptionForm.SearchOptionPro: integer;
begin
 Application.CreateForm(TSearchOptionForm, SearchOptionForm);
 SearchOptionForm.ShowModal;
 Result := SearchOptionForm.ReturnFlag;
 SearchOptionForm.Free;
end;

end.
