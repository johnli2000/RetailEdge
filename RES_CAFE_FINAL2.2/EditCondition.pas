unit EditCondition;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, ClipBrd, ToolWin, DataUnit,
  MainMenu, BusinessSkinForm;

type
  TEditConditionForm = class(TForm)
    Editor: TMemo;
    CoolBar1: TCoolBar;
    SaveButton: TSpeedButton;
    CutButton: TSpeedButton;
    UnDoButton: TSpeedButton;
    CopyButton: TSpeedButton;
    PasteButton: TSpeedButton;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    procedure FileSave;
    procedure SaveButtonClick(Sender: TObject);
    procedure UndoButtonClick(Sender: TObject);
    procedure CutButtonClick(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
    procedure PasteButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditConditionPro(EditFlag: integer);
  private
    FileName: string;
  public
    { Public declarations }

  end;

var
  EditConditionForm: TEditConditionForm;

implementation

uses RichEdit, MessageBox;

{$R *.DFM}

procedure TEditConditionForm.FileSave;
begin
 Editor.Lines.SaveToFile(FileName);
 Editor.Modified := False;
end;

procedure TEditConditionForm.SaveButtonClick(Sender: TObject);
begin
 FileSave;
end;

procedure TEditConditionForm.UndoButtonClick(Sender: TObject);
begin
  with Editor do
    if HandleAllocated then SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure TEditConditionForm.CutButtonClick(Sender: TObject);
begin
 Editor.CutToClipboard;
end;

procedure TEditConditionForm.CopyButtonClick(Sender: TObject);
begin
 Editor.CopyToClipboard;
end;

procedure TEditConditionForm.PasteButtonClick(Sender: TObject);
begin
 Editor.PasteFromClipboard;
end;

procedure TEditConditionForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
 SaveResp: Integer;
begin
 Action := caFree;
 if Editor.Modified then
    begin
     SaveResp :=
     MessageBoxForm.MessagePro('File has been changed. Do you want to save?', sConfirmMsg);
     case SaveResp of
      idYes: FileSave;
      idNo: {Nothing};
      idCancel: begin
                 Action := caNone;
                 Abort;
                end;
     end;
    end;
end;

procedure TEditConditionForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TEditConditionForm.FormShow(Sender: TObject);
begin
 EditConditionForm.Caption := FileName;
 Editor.Lines.Clear;
 if FileExists(FileName) then
    Editor.Lines.LoadFromFile(FileName);
 Editor.SetFocus;
end;

procedure TEditConditionForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_F8 then SaveButtonClick(Sender);
end;

procedure TEditConditionForm.EditConditionPro(EditFlag: integer);
begin
 Application.CreateForm(TEditConditionForm, EditConditionForm);
 case EditFlag of
  0: EditConditionForm.FileName := StartDir + 'Bill.CFG';
  1: EditConditionForm.FileName := StartDir + 'Invoice.CFG';
  2: EditConditionForm.FileName := StartDir + 'Booking.CFG';
 end;
 EditConditionForm.ShowModal;
 EditConditionForm.Free;
end;

end.
