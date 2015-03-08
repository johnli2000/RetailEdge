unit KindSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, MainMenu, XiButton, bsSkinCtrls,
  BusinessSkinForm;

type
  TKindSelectForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    DinnerButton: TXiButton;
    LunchButton: TXiButton;
    BreakfastButton: TXiButton;
    OthersButton: TXiButton;
    CancelButton: TXiButton;
    procedure DinnerButtonClick(Sender: TObject);
    procedure LunchButtonClick(Sender: TObject);
    procedure BreakfastButtonClick(Sender: TObject);
    procedure OthersButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  KindSelectPro: integer;
    procedure FormShow(Sender: TObject);
  private { Private declarations }
    ReturnFlag: integer;
  public
    { Public declarations }
  end;

var
  KindSelectForm: TKindSelectForm;

implementation

{$R *.dfm}

procedure TKindSelectForm.DinnerButtonClick(Sender: TObject);
begin
 ReturnFlag := 0;
 Close;
end;

procedure TKindSelectForm.LunchButtonClick(Sender: TObject);
begin
 ReturnFlag := 1;
 Close;
end;

procedure TKindSelectForm.BreakfastButtonClick(Sender: TObject);
begin
 ReturnFlag := 2;
 Close;
end;

procedure TKindSelectForm.OthersButtonClick(Sender: TObject);
begin
 ReturnFlag := 3;
 Close;
end;

procedure TKindSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := -1;
 Close;
end;

procedure TKindSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TKindSelectForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := CancelButton.Top + 86;
end;

function TKindSelectForm.KindSelectPro: integer;
begin
 Application.CreateForm(TKindSelectForm, KindSelectForm);
 KindSelectForm.ShowModal;
 Result := KindSelectForm.ReturnFlag;
 KindSelectForm.Free;
end;

end.
