unit Instruction;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, XiButton, bsSkinCtrls, BusinessSkinForm;

type
  TInstructionForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    NoteButton: TXiButton;
    AddButton: TXiButton;
    CutButton: TXiButton;
    MoreButton: TXiButton;
    LittleButton: TXiButton;
    NormalButton: TXiButton;
    CancelButton: TXiButton;
    procedure NoteButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure MoreButtonClick(Sender: TObject);
    procedure LittleButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    function  InstructionPro: integer;
    procedure NormalButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private { Private declarations }
    Instruction: integer;
  public
    { Public declarations }
  end;

var
  InstructionForm: TInstructionForm;

implementation

{$R *.DFM}

procedure TInstructionForm.NoteButtonClick(Sender: TObject);
begin
 Instruction := 1;
 Close;
end;

procedure TInstructionForm.AddButtonClick(Sender: TObject);
begin
 Instruction := 2;
 Close;
end;

procedure TInstructionForm.CutButtonClick(Sender: TObject);
begin
 Instruction := 3;
 Close;
end;

procedure TInstructionForm.MoreButtonClick(Sender: TObject);
begin
 Instruction := 4;
 Close;
end;

procedure TInstructionForm.LittleButtonClick(Sender: TObject);
begin
 Instruction := 5;
 Close;
end;

procedure TInstructionForm.NormalButtonClick(Sender: TObject);
begin
 Instruction := 0;
 Close;
end;

procedure TInstructionForm.CancelButtonClick(Sender: TObject);
begin
 Instruction := -1;
 Close;
end;

procedure TInstructionForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 case Key of
  'N', 'n': NoteButtonClick(Sender);
  'A', 'a': AddButtonClick(Sender);
  'C', 'c': CutButtonClick(Sender);
  'M', 'm': MoreButtonClick(Sender);
  'L', 'l': LittleButtonClick(Sender);
  'V', 'v': NormalButtonClick(Sender);
  Chr(27): CancelButtonClick(Sender);
 end;
end;

procedure TInstructionForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_F10 then begin CancelButtonClick(Sender); Key := 0; end;
end;

procedure TInstructionForm.FormShow(Sender: TObject);
begin
 Instruction := 0;
 NoteButton.SetFocus;
end;

function TInstructionForm.InstructionPro: integer;
begin
 Application.CreateForm(TInstructionForm, InstructionForm);
 InstructionForm.ShowModal;
 Result := InstructionForm.Instruction;
 InstructionForm.Free;
end;

end.
