unit PictureLoadPathSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, Buttons, DataUnit, bsSkinCtrls,
  bsSkinGrids, BusinessSkinForm, XiButton;

type
  TPictureLoadPathSetupForm = class(TForm)
    OpenDialog: TOpenDialog;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    StringGrid: TStringGrid;
    AddButton: TXiButton;
    InsertButton: TXiButton;
    DeleteButton: TXiButton;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure InitStringGrid;
    function  FindLastRow: integer;
    function  InsertLine: integer;
    procedure DeleteLine;
    procedure AddButtonClick(Sender: TObject);
    procedure InsertButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure ReadDataFile;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetupPro;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PictureLoadPathSetupForm: TPictureLoadPathSetupForm;

implementation

uses MainMenu;

{$R *.dfm}

procedure TPictureLoadPathSetupForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   Canvas.Font.Size := 8;
   if (ARow > 0) and (ACol > 0) then
      begin
       Canvas.Font.Style := [];
       SetTextAlign(Canvas.Handle, TA_LEFT);
       X := Rect.Left + 2;
      end
     else
      begin
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    Canvas.TextRect(Rect, X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TPictureLoadPathSetupForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   Cells[0, 0] := 'No.';
   Cells[1, 0] := 'Picture Loading Path';
   for I := 1 to 100 do
    begin
     Cells[0, I] := IntToStr(I);
     Cells[1, I] := '';
    end;
   Row := 1; Col := 1; TopRow := 1; LeftCol := 1;
  end;
end;

function TPictureLoadPathSetupForm.FindLastRow: integer;
var
 LastRow, I: integer;
begin
 LastRow := 0;
 for I := 1 to 100 do
  if StringGrid.Cells[1, I] <> '' then LastRow := I;
 if LastRow <= 100 then
    Result := LastRow + 1
   else
    Result := 100;
end;

function TPictureLoadPathSetupForm.InsertLine;
var
 I, CurrentRow: integer;
begin
 with StringGrid do
  begin
   CurrentRow := Row;
   for I := 100 Downto CurrentRow + 1 do
    Cells[1, I] := StringGrid.Cells[1, I - 1];
   StringGrid.Cells[1, CurrentRow] := '';
  end;
 Result := CurrentRow;
end;

procedure TPictureLoadPathSetupForm.DeleteLine;
var
 I, CurrentRow: Integer;
begin
 with StringGrid do
  begin
   CurrentRow := Row;
   for I := CurrentRow to 99 do
     Cells[1, I] := Cells[1, I + 1];
   Cells[1, 100] := '';
  end;
end;

procedure TPictureLoadPathSetupForm.AddButtonClick(Sender: TObject);
var
 LastRow: integer;
begin
 if OpenDialog.Execute then
    begin
     LastRow := FindLastRow;
     StringGrid.Cells[1, LastRow] := OpenDialog.FileName;
    end;
end;

procedure TPictureLoadPathSetupForm.InsertButtonClick(Sender: TObject);
var
 CurrentRow: integer;
begin
 if OpenDialog.Execute then
    begin
     CurrentRow := InsertLine;
     StringGrid.Cells[1, CurrentRow] := OpenDialog.FileName;
    end;
end;


procedure TPictureLoadPathSetupForm.DeleteButtonClick(Sender: TObject);
begin
 DeleteLine;
end;

procedure TPictureLoadPathSetupForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TPictureLoadPathSetupForm.SaveButtonClick(Sender: TObject);
var
 FileName: string;
 F: TextFile;
 I: integer;
begin
 FileName := StartDir + 'PictureLoad.CFG';
 AssignFile(F, FileName);
 Rewrite(F);
 for I := 1 to 100 do
  if StringGrid.Cells[1, I] <> '' then
     Writeln(F, StringGrid.Cells[1, I]);
 CloseFile(F);
 Close;
end;

procedure TPictureLoadPathSetupForm.ReadDataFile;
var
 FileName: string;
 F: TextFile;
 S: string;
 I: integer;
begin
 InitStringGrid;
 FileName := StartDir + 'PictureLoad.CFG';
 if FileExists(FileName) then
    begin
     AssignFile(F, FileName);
     Reset(F);
     I := 1;
     while Not EOF(F) do
      begin
       Readln(F, S);
       StringGrid.Cells[1, I] := S;
       I := I + 1;
      end;
     CloseFile(F);
    end;
end;


procedure TPictureLoadPathSetupForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := CancelButton.Top + 86;
 ReadDataFile;
end;

procedure TPictureLoadPathSetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TPictureLoadPathSetupForm.SetupPro;
begin
 Application.CreateForm(TPictureLoadPathSetupForm, PictureLoadPathSetupForm);
 PictureLoadPathSetupForm.ShowModal;
 PictureLoadPathSetupForm.Free;
end;
 
end.
