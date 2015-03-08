unit SelectDrawerNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, MainMenu, XiButton, bsSkinCtrls,
  BusinessSkinForm;

type
  TSelectDrawerNumberForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    CashDrawerButton1: TXiButton;
    CashDrawerButton2: TXiButton;
    CancelButton: TXiButton;
    procedure CashDrawerButton1Click(Sender: TObject);
    procedure CashDrawerButton2Click(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  SelectDrawerNumber(var DrawerNumber: integer): boolean;
  private { Private declarations }
     DrawerNumber: integer;
     ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  SelectDrawerNumberForm: TSelectDrawerNumberForm;

implementation

{$R *.dfm}

procedure TSelectDrawerNumberForm.CashDrawerButton1Click(Sender: TObject);
begin
 DrawerNumber := 0;
 ReturnFlag := True;
 Close;
end;

procedure TSelectDrawerNumberForm.CashDrawerButton2Click(Sender: TObject);
begin
 DrawerNumber := 1;
 ReturnFlag := True;
 Close;
end;

procedure TSelectDrawerNumberForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TSelectDrawerNumberForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

function TSelectDrawerNumberForm.SelectDrawerNumber(var DrawerNumber: integer): boolean;
begin
 Application.CreateForm(TSelectDrawerNumberForm, SelectDrawerNumberForm);
 SelectDrawerNumberForm.ShowModal;
 Result := SelectDrawerNumberForm.ReturnFlag;
 if Result then
    DrawerNumber := SelectDrawerNumberForm.DrawerNumber;
 SelectDrawerNumberForm.Free;
end;

end.
