unit MachineIDCollect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainMenu, DataUnit, Grids, XiButton, DB, ADODB, DBGrids,
  bsSkinCtrls, BusinessSkinForm;

type
  TMachineIDCollectForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    StringGridPanel: TbsSkinPanel;
    DeleteButton: TXiButton;
    AddButton: TXiButton;
    CancelButton: TXiButton;
    ConfirmButton: TXiButton;
    StringGrid: TStringGrid;
    QueryMachineID: TWideStringField;
    procedure OpenQuery;
    function  CheckCode(MachineID: string): boolean;
    procedure InitStringGrid;
    function  FindLastRow: integer;
    procedure AddButtonClick(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure DeleteButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function  MachineIDPro(var MachineIDString: string): boolean;
    procedure DBGridDblClick(Sender: TObject);
  private { Private declarations }
    ReturnFlag: boolean;
    MachineIDString: string;
  public
    { Public declarations }
  end;

var
  MachineIDCollectForm: TMachineIDCollectForm;

implementation

{$R *.dfm}

procedure TMachineIDCollectForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From MachineID Order By MachineID';
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TMachineIDCollectForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   //Cells[0, 0] := 'Selected Machine ID';
   Cells[0,0] := 'Selected Terminal No.';
   for I := 1 to 20 do Cells[0, I] := '';
   Row := 1; Col := 0;
  end;
end;

function TMachineIDCollectForm.CheckCode(MachineID: string): boolean;
var
 I: integer;
begin
 I := 1;
 Result := True;
 while Result and (I <= 20) do
  begin
   Result := StringGrid.Cells[0, I] <> MachineID;
   I := I + 1;
  end;
end;

function TMachineIDCollectForm.FindLastRow: integer;
var
 I, J: integer;
begin
 J := 1;
 with StringGrid do
  for I := 1 to 20 do
   begin
    if Cells[0, I] <> '' then
       begin
        if J <> I then Cells[0, J] := Cells[0, I];
        J := J + 1;
       end;
   end;
 if J <= 20 then
    Result := J
   else
    Result := 20;
end;

procedure TMachineIDCollectForm.AddButtonClick(Sender: TObject);
var
 I: integer;
 CurrentMachineID: string;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      DisableControls;
      CurrentMachineID := FieldByName('MachineID').AsString;
      First;
      while Not EOF do
       begin
        if DBGrid.SelectedRows.CurrentRowSelected and
           CheckCode(FieldByName('MachineID').AsString) then
           begin
            I := FindLastRow; StringGrid.Row := I;
            StringGrid.Cells[0, I] := FieldByName('MachineID').AsString;
           end;
        Next;
       end;
      DBGrid.SelectedRows.Clear;
      First;
      Query.Locate('MachineID', CurrentMachineID, [loPartialKey]);
      EnableControls;
     end;
end;

procedure TMachineIDCollectForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   if ARow = 0 then
      begin
       Canvas.Font.Name := 'Arial';
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end
     else
      begin
       Canvas.Font.Name := 'MS Sans Serif';
       Canvas.Font.Style := [];
       SetTextAlign(Canvas.Handle, TA_LEFT);
       X := Rect.Left + 2;
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
  end;
end;

procedure TMachineIDCollectForm.DeleteButtonClick(Sender: TObject);
var
 I: Integer;
 CurrentRow: integer;
begin
 CurrentRow := StringGrid.Row;
 with StringGrid do
  begin
   for I := CurrentRow to 20 do
    Cells[0, I] := Cells[0, I + 1];
   Cells[0, 20] := '';
  end;
end;

procedure TMachineIDCollectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TMachineIDCollectForm.ConfirmButtonClick(Sender: TObject);
var
 I: integer;
begin
 MachineIDString := StringGrid.Cells[0, 1];
 for I := 2 to 20 do
  if StringGrid.Cells[0, I] <> '' then
     MachineIDString := MachineIDString + ',' + StringGrid.Cells[0, I];
 if MachineIDString <> '' then
    begin
     ReturnFlag := True;
     Close;
    end;
end;

procedure TMachineIDCollectForm.DBGridDblClick(Sender: TObject);
begin
 AddButtonClick(Sender);
end;

procedure TMachineIDCollectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TMachineIDCollectForm.FormShow(Sender: TObject);
begin
 Width := StringGridPanel.Left + StringGridPanel.Width + 22;
 Height := DBGridPanel.Height + 50;
 InitStringGrid;
 OpenQuery;
end;

function TMachineIDCollectForm.MachineIDPro(var MachineIDString: string): boolean;
begin
 Application.CreateForm(TMachineIDCollectForm, MachineIDCollectForm);
 MachineIDCollectForm.ShowModal;
 Result := MachineIDCollectForm.ReturnFlag;
 if Result then MachineIDString := MachineIDCollectForm.MachineIDString;
 MachineIDCollectForm.Free;
end;

end.
