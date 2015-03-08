unit Keyboard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, BusinessSkinForm, XiButton, Mask,
  bsSkinBoxCtrls, bsSkinCtrls;

type
  TKeyboardForm = class(TForm)
    MessagePanel: TbsSkinPanel;
    StringEdit: TbsSkinEdit;
    KeyPanel: TbsSkinPanel;
    Button1: TXiButton;
    Button2: TXiButton;
    Button3: TXiButton;
    Button4: TXiButton;
    Button5: TXiButton;
    Button6: TXiButton;
    Button7: TXiButton;
    Button8: TXiButton;
    Button9: TXiButton;
    Button0: TXiButton;
    CharButton1: TXiButton;
    CharButton2: TXiButton;
    BackButton: TXiButton;
    LockKey: TXiButton;
    ButtonQ: TXiButton;
    ButtonW: TXiButton;
    ButtonE: TXiButton;
    ButtonR: TXiButton;
    ButtonT: TXiButton;
    ButtonY: TXiButton;
    ButtonU: TXiButton;
    ButtonI: TXiButton;
    ButtonO: TXiButton;
    ButtonP: TXiButton;
    CharButton3: TXiButton;
    CharButton4: TXiButton;
    CharButton5: TXiButton;
    ESCButton: TXiButton;
    ButtonA: TXiButton;
    ButtonS: TXiButton;
    ButtonD: TXiButton;
    ButtonF: TXiButton;
    ButtonG: TXiButton;
    ButtonH: TXiButton;
    ButtonJ: TXiButton;
    ButtonK: TXiButton;
    ButtonL: TXiButton;
    CharButton6: TXiButton;
    CharButton7: TXiButton;
    EnterButton: TXiButton;
    ShiftButton: TXiButton;
    ButtonZ: TXiButton;
    ButtonX: TXiButton;
    ButtonC: TXiButton;
    ButtonV: TXiButton;
    ButtonB: TXiButton;
    ButtonN: TXiButton;
    ButtonM: TXiButton;
    CharButton8: TXiButton;
    CharButton9: TXiButton;
    CharButton11: TXiButton;
    CharButton10: TXiButton;
    CharButton12: TXiButton;
    CharButton13: TXiButton;
    CharButton14: TXiButton;
    CharButton15: TXiButton;
    CharButton16: TXiButton;
    CharButton20: TXiButton;
    SpaceButton: TXiButton;
    CharButton17: TXiButton;
    CharButton18: TXiButton;
    CharButton19: TXiButton;
    XiButton1: TXiButton;
    SingleQouteButton: TXiButton;
    DoubleQouteButton: TXiButton;
    BackPanel: TbsSkinPanel;
    procedure ButtonClick(Sender: TObject);
    procedure SpaceButtonClick(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
    procedure ESCButtonClick(Sender: TObject);
    procedure ShiftButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function  KeyboardPro(var Str: string): boolean;
    procedure EnterButtonClick(Sender: TObject);
    procedure SetKeyboardStatus;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure StringEditChange(Sender: TObject);
    procedure LockKeyClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private { Private declarations }
    ReturnFlag, LockFlag: boolean;
  public
    { Public declarations }
  end;

var
  KeyboardForm: TKeyboardForm;

implementation

uses MainMenu;

{$R *.DFM}

procedure TKeyboardForm.ButtonClick(Sender: TObject);
var
 CH: Char;
begin
 with Sender As TXiButton do
  CH := Caption[1];
 StringEdit.Text := StringEdit.Text + CH;
 LockFlag := LockKey.ColorScheme = csNeoSky;
 SetKeyboardStatus;
 KeyPanel.SetFocus;
end;

procedure TKeyboardForm.SpaceButtonClick(Sender: TObject);
begin
 StringEdit.Text := StringEdit.Text + ' ';
 LockFlag := True;
 SetKeyboardStatus;
 KeyPanel.SetFocus;
end;

procedure TKeyboardForm.BackButtonClick(Sender: TObject);
var
 Len: integer;
begin
 Len := Length(StringEdit.Text);
 if Len > 0 then StringEdit.Text := Copy(StringEdit.Text, 1, Len - 1);
 if (Length(StringEdit.Text) = 0) or
    (Copy(StringEdit.Text, Length(StringEdit.Text), 1) = ' ') or
    (LockKey.ColorScheme = csNeoSky) then
    LockFlag := True
   else
    LockFlag := False;
 SetKeyboardStatus;
 KeyPanel.SetFocus;
end;

procedure TKeyboardForm.StringEditChange(Sender: TObject);
begin
 StringEdit.SelStart := Length(StringEdit.Text);
 StringEdit.SelLength := 0;
end;

procedure TKeyboardForm.LockKeyClick(Sender: TObject);
begin
 if LockKey.ColorScheme = csNeoSilver then
    LockKey.ColorScheme := csNeoSky
   else
    LockKey.ColorScheme := csNeoSilver;
 LockFlag := LockKey.ColorScheme = csNeoSky;
 SetKeyboardStatus;
 KeyPanel.SetFocus;
end;

procedure TKeyboardForm.ESCButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TKeyboardForm.EnterButtonClick(Sender: TObject);
begin
 ReturnFlag := True;
 Close;
end;

procedure TKeyboardForm.SetKeyboardStatus;
var
 ButtonName: string;
 I: integer;
begin
 for I := 1 to 26 do
  begin
   ButtonName := 'Button' + Chr(I + 64);
   with TXiButton(FindComponent(ButtonName)) do
    if LockFlag then
       Caption := Uppercase(Caption)
      else
       Caption := LowerCase(Caption);
  end;
end;

procedure TKeyboardForm.ShiftButtonClick(Sender: TObject);
begin
 LockFlag := Not LockFlag;
 SetKeyboardStatus;
 KeyPanel.SetFocus;
end;

procedure TKeyboardForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 case Key of
  Chr(27): ESCButtonClick(Sender);
  Chr(13): EnterButtonClick(Sender);
  Chr(8):  BackButtonClick(Sender);
 else
  begin
   if LockFlag then
      StringEdit.Text := StringEdit.Text + UpperCase(Key)
     else
      StringEdit.Text := StringEdit.Text + LowerCase(Key);
  end;
 end;
 Key := Chr(0);
 if (Length(StringEdit.Text) = 0) or (Copy(StringEdit.Text, Length(StringEdit.Text), 1) = ' ') or
    (LockKey.ColorScheme = csNeoSky) then
    LockFlag := True
   else
    LockFlag := False;
 SetKeyboardStatus;
 KeyPanel.SetFocus;
end;

procedure TKeyboardForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_CAPITAL then
    begin
     LockFlag := Lo(GetKeyState(VK_CAPITAL)) = 129;
     SetKeyboardStatus;
    end;
 KeyPanel.SetFocus;
end;

procedure TKeyboardForm.FormShow(Sender: TObject);
begin
 LockFlag := True;
 LockKey.ColorScheme := csNeoSilver;
 SetKeyboardStatus;
 StringEdit.Text := '';
 BackPanel.Width := 1024;
 BackPanel.Height := 316;
 BackPanel.Left := 0;
 BackPanel.Top := 0;
 Width := BackPanel.Width;
 Height := BackPanel.Height;
 Top := (Screen.Height - 768) div 2 + (768 - Height);
 Left := (Screen.Width - BackPanel.Width) div 2;
 KeyPanel.SetFocus;
end;

function TKeyboardForm.KeyboardPro(var Str: string): boolean;
begin
 Application.CreateForm(TKeyboardForm, KeyboardForm);
 KeyboardForm.ShowModal;
 Result := KeyboardForm.ReturnFlag;
 if Result then Str := KeyboardForm.StringEdit.Text;
 KeyboardForm.Free;
end;

end.
