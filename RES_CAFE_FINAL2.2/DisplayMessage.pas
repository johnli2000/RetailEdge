unit DisplayMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ExtCtrls, MainMenu, BusinessSkinForm,
  bsSkinCtrls;

type
  TDisplayMessageForm = class(TForm)
    MessageLabel: TLabel;
    BackPanel: TbsSkinPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DisplayMessagePro(MessageStr: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 DisplayMessageForm: TDisplayMessageForm;

implementation

{$R *.dfm}

procedure TDisplayMessageForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TDisplayMessageForm.DisplayMessagePro(MessageStr: string);
begin
 Application.CreateForm(TDisplayMessageForm, DisplayMessageForm);
 DisplayMessageForm.MessageLabel.Caption := MessageStr;
 DisplayMessageForm.Show;
 Application.ProcessMessages;
end;

end.
