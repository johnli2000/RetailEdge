unit PrintMenuItemSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, MainMenu, bsSkinCtrls,
  BusinessSkinForm, XiButton;

type
  TPrintMenuItemSelectForm = class(TForm)
    RadioGroup: TRadioGroup;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    OKButton: TXiButton;
    CancelButton: TXiButton;
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  SelectMenuItemPrintPro(var Select: integer): boolean;
    procedure FormShow(Sender: TObject);
  private { Private declarations }
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  PrintMenuItemSelectForm: TPrintMenuItemSelectForm;

implementation

{$R *.dfm}

procedure TPrintMenuItemSelectForm.OKButtonClick(Sender: TObject);
begin
 ReturnFlag := True;
 Close;
end;

procedure TPrintMenuItemSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TPrintMenuItemSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TPrintMenuItemSelectForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := CancelButton.Top + 86;
end;

function TPrintMenuItemSelectForm.SelectMenuItemPrintPro(var Select: integer): boolean;
begin
 Application.CreateForm(TPrintMenuItemSelectForm, PrintMenuItemSelectForm);
 PrintMenuItemSelectForm.ShowModal;
 Result := PrintMenuItemSelectForm.ReturnFlag;
 if Result then
    Select := PrintMenuItemSelectForm.RadioGroup.ItemIndex;
 PrintMenuItemSelectForm.Free;
end;

end.
