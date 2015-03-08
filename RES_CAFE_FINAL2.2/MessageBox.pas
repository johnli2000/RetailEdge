unit MessageBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, DataUnit, bsSkinCtrls, bsSkinBoxCtrls,
  BusinessSkinForm, XiButton;

type
  TMessageBoxForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    MessagePanel: TbsSkinPanel;
    MessageBox: TbsSkinMemo;
    CloseButton: TXiButton;
    YesButton: TXiButton;
    NoButton: TXiButton;
    procedure YesButtonClick(Sender: TObject);
    procedure NoButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  MessagePro(MessageText: string; MessageKind: integer): integer;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }
    ReturnFlag, MessageKind: integer;
    MessageText: string;
  public
    { Public declarations }
  end;

var
  MessageBoxForm: TMessageBoxForm;

implementation

{$R *.DFM}

procedure TMessageBoxForm.YesButtonClick(Sender: TObject);
begin
 ReturnFlag := mrYes;
 Close;
end;

procedure TMessageBoxForm.NoButtonClick(Sender: TObject);
begin
 ReturnFlag := mrNo;
 Close;
end;

procedure TMessageBoxForm.CloseButtonClick(Sender: TObject);
begin
 ReturnFlag := mrNo;
 Close;
end;

procedure TMessageBoxForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TMessageBoxForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TMessageBoxForm.FormShow(Sender: TObject);
var
 I, Temp: integer;
 StrTemp: string;
begin
 Width := MessagePanel.Width + 28;
 Height := CloseButton.Top + 86;
 MessageBox.Text := MessageText;
 Temp := (5 - MessageBox.Lines.Count) div 2;
 MessageBox.Lines.Clear;
 for I := 1 to Temp do StrTemp := StrTemp +Chr(13) + Chr(10);
 MessageBox.Text := StrTemp + MessageText;
 case MessageKind of
  1: begin
      YesButton.Visible := False;
      NoButton.Visible := False;
      MessageBox.Font.Color := clPurple;
     end;
  2: begin
      YesButton.Visible := False;
      NoButton.Visible := False;
     end;
  3: begin
      CloseButton.Visible := False;
     end;
 end;
end;

function TMessageBoxForm.MessagePro(MessageText: string; MessageKind: integer): integer;
begin
 Application.CreateForm(TMessageBoxForm, MessageBoxForm);
 MessageBoxForm.MessageText := MessageText;
 MessageBoxForm.MessageKind := MessageKind;
 MessageBoxForm.ShowModal;
 Result := MessageBoxForm.ReturnFlag;
 MessageBoxForm.Free;
end;

end.
