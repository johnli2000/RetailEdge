unit HoldModeSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainMenu, XiButton, bsSkinCtrls, BusinessSkinForm;

type
  THoldModeSelectForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
    ExistHoldOrderButton: TXiButton;
    NewHoldOrderButton: TXiButton;
    CancelButton: TXiButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure ExistHoldOrderButtonClick(Sender: TObject);
    procedure NewHoldOrderButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  HoldModeSelectPro(var ModeSelected: integer): boolean;
    procedure FormShow(Sender: TObject);
  private { Private declarations }
     ReturnFlag: boolean;
     ModeSelect: integer;
  public
    { Public declarations }
  end;

var
  HoldModeSelectForm: THoldModeSelectForm;

implementation

{$R *.dfm}

procedure THoldModeSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure THoldModeSelectForm.ExistHoldOrderButtonClick(Sender: TObject);
begin
 ReturnFlag := True;
 ModeSelect := 1;
 Close;
end;

procedure THoldModeSelectForm.NewHoldOrderButtonClick(Sender: TObject);
begin
 ReturnFlag := True;
 ModeSelect := 0;
 Close;
end;

procedure THoldModeSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure THoldModeSelectForm.FormShow(Sender: TObject);
begin
 Width := BackPanel.Width + 28;
 Height := BackPanel.Height + 50;
end;

function THoldModeSelectForm.HoldModeSelectPro(var ModeSelected: integer): boolean;
begin
 Application.CreateForm(THoldModeSelectForm, HoldModeSelectForm);
 HoldModeSelectForm.ShowModal;
 Result := HoldModeSelectForm.ReturnFlag;
 if Result then
    ModeSelected := HoldModeSelectForm.ModeSelect;
 HoldModeSelectForm.Free;
end;

end.
