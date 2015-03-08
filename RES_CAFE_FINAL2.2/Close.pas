unit Close;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, XiButton, bsSkinCtrls, BusinessSkinForm;

type
  TExitSystemForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
    ExitButton: TXiButton;
    RestartButton: TXiButton;
    ShutDownButton: TXiButton;
    CancelButton: TXiButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function  ExitSystemPro(var CloseMode: integer): boolean;
    procedure ExitButtonClick(Sender: TObject);
    procedure RestartButtonClick(Sender: TObject);
    procedure ShutDownButtonClick(Sender: TObject);
  private { Private declarations }
    ReturnFlag: boolean;
    CloseMode: integer;
  public
    { Public declarations }
  end;

var
  ExitSystemForm: TExitSystemForm;

implementation

uses MainMenu;

{$R *.DFM}


procedure TExitSystemForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TExitSystemForm.ExitButtonClick(Sender: TObject);
begin
 CloseMode := 0;
 ReturnFlag := True;
 Close;
end;

procedure TExitSystemForm.RestartButtonClick(Sender: TObject);
begin
 CloseMode := 1;
 ReturnFlag := True;
 Close;
end;

procedure TExitSystemForm.ShutDownButtonClick(Sender: TObject);
begin
 CloseMode := 2;
 ReturnFlag := True;
 Close;
end;

procedure TExitSystemForm.FormShow(Sender: TObject);
begin
 Width := BackPanel.Width + 16;
 Height := BackPanel.Height + 36;
 BackPanel.Left := 0;
 BackPanel.Top := 0;
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
end;

function TExitSystemForm.ExitSystemPro(var CloseMode: integer): boolean;
begin
 Application.CreateForm(TExitSystemForm, ExitSystemForm);
 ExitSystemForm.ShowModal;
 Result := ExitSystemForm.ReturnFlag;
 if Result then CloseMode := ExitSystemForm.CloseMode;
 ExitSystemForm.Free;
end;

end.
