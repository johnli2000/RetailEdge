unit PDATableLayout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BusinessSkinForm, MainMenu, DataUnit, DB, ADODB, Grids, DBGrids,
  bsSkinCtrls, XiButton, PanelButton, ComCtrls, bsSkinTabs, UtilUnit;

type
  TPDATableLayoutForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryTableNo: TStringField;
    QueryPDAPosition: TIntegerField;
    TabControl: TbsSkinTabControl;
    Table1: TPanelButton;
    Table2: TPanelButton;
    Table3: TPanelButton;
    Table4: TPanelButton;
    Table5: TPanelButton;
    Table6: TPanelButton;
    Table7: TPanelButton;
    Table8: TPanelButton;
    Table9: TPanelButton;
    Table10: TPanelButton;
    Table11: TPanelButton;
    Table12: TPanelButton;
    Table13: TPanelButton;
    Table14: TPanelButton;
    Table15: TPanelButton;
    Table16: TPanelButton;
    Table17: TPanelButton;
    Table18: TPanelButton;
    Table19: TPanelButton;
    Table20: TPanelButton;
    Table21: TPanelButton;
    Table22: TPanelButton;
    Table23: TPanelButton;
    Table24: TPanelButton;
    Table25: TPanelButton;
    Table26: TPanelButton;
    Table27: TPanelButton;
    Table28: TPanelButton;
    Table29: TPanelButton;
    Table30: TPanelButton;
    Table31: TPanelButton;
    Table32: TPanelButton;
    Table33: TPanelButton;
    Table34: TPanelButton;
    Table35: TPanelButton;
    Table36: TPanelButton;
    Table37: TPanelButton;
    Table38: TPanelButton;
    Table39: TPanelButton;
    Table40: TPanelButton;
    ExitButton: TXiButton;
    procedure OpenQuery;
    procedure AssignTableLayout;
    procedure ExitButtonClick(Sender: TObject);
    procedure PDATableLayoutSetup;
    procedure FormShow(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure PanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TableButtonClick(Sender: TObject);
    procedure ProcessButtonTouch(Position: integer);
    function  CheckSeletedObjectStatus(var TableNo: string; ButtonName: string): boolean;
    function  CheckReleaseObjectStatus(var NewPosition: integer; ButtonName: string): boolean;
    function  MoveToNewPosition(TableNo: string; NewPosition: integer): boolean;
    procedure ProcessItemMove;
  private { Private declarations }
    SelectedObjectName, ReleaseObjectName: string;
    StartMoveMouse: boolean;
  public
    { Public declarations }
  end;

var
  PDATableLayoutForm: TPDATableLayoutForm;

implementation

{$R *.dfm}

procedure TPDATableLayoutForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select TableNo, PDAPosition From TableSet ' +
           'Where PropertyFlag <> 0 Order By TableNo';
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

procedure TPDATableLayoutForm.AssignTableLayout;
var
 I, TablePosition: integer;
 ButtonName: string;
begin
 Query.DisableControls;
 for I := 1 to 40 do
  begin
   ButtonName := 'Table' + IntToStr(I);
   TablePosition := TabControl.TabIndex * 40 + I;
   Query.Locate('PDAPosition', IntToStr(TablePosition), [loPartialKey]);
   with TPanelButton(FindComponent(ButtonName)) do
    if Query.FieldByName('PDAPosition').AsInteger = TablePosition then
       begin
        Caption := Query.FieldByName('TableNo').AsString;
        Color := clLime;
       end
      else
       begin
        Caption := '';
        Color := clSilver;
       end;
  end;
 Query.EnableControls;
end;

procedure TPDATableLayoutForm.TabControlChange(Sender: TObject);
begin
 AssignTableLayout;
end;

procedure TPDATableLayoutForm.PanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
 if Shift =  [ssLeft] then
    begin
     if Not StartMoveMouse and Query.Active and (Query.RecordCount > 0) and
        (X < DBGrid.Left + DBGrid.Width) and (Y < DBGrid.Top + DBGrid.Height) then
        begin
         StartMoveMouse := True;
         Screen.Cursor := crDrag;
         with Sender As TComponent do SelectedObjectName := Name;
        end;
    end
   else
    begin
     Screen.Cursor := crDefault;
     if StartMoveMouse then
        begin
         with Sender As TComponent do ReleaseObjectName := Name;
         ProcessItemMove;
         StartMoveMouse := False;
        end;
    end;

end;

procedure TPDATableLayoutForm.ProcessButtonTouch(Position: integer);
begin
 Query.Locate('PDAPosition', IntToStr(TabControl.TabIndex * 40 + Position), [loPartialKey])
end;

procedure TPDATableLayoutForm.TableButtonClick(Sender: TObject);
var
 Num: string;
begin
 with Sender As TPanelButton do
  begin
   Num := Copy(Name, 6, 2);
   if Caption <> '' then ProcessButtonTouch(StrToInt(Num));
  end;
end;

function TPDATableLayoutForm.CheckSeletedObjectStatus(var TableNo: string; ButtonName: string): boolean;
var
 Position: integer;
begin
 with TPanelButton(FindComponent(ButtonName)) do
  if Color = clSilver then Result := False
   else
    begin
     Position := StrToInt(Copy(Name, 6, 2));
     Query.Locate('PDAPosition', IntToStr(TabControl.TabIndex * 40 + Position), [loPartialKey]);
     TableNo := Query.FieldByName('TableNo').AsString;
     Result := True;
    end;
end;

function TPDATableLayoutForm.CheckReleaseObjectStatus(var NewPosition: integer; ButtonName: string): boolean;
begin
 with TPanelButton(FindComponent(ButtonName)) do
  if Color <> clSilver then Result := False else
     begin
      NewPosition := TabControl.TabIndex * 40 + StrToInt(Copy(Name, 6, 2)); Result := True end;
end;

function TPDATableLayoutForm.MoveToNewPosition(TableNo: string; NewPosition: integer): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Update TableSet Set PDAPosition=' + IntToStr(NewPosition) +
           ' Where TableNo=' + Chr(39) + CheckQuotes(TableNo) + Chr(39);
 Result := DataForm.BeginTransaction;
 if Result then
    try
     Result := DataForm.ExecQueryPro(SQLStr);
    finally
     if Result then
        begin
         DataForm.CommitTransaction;
         OpenQuery;
         AssignTableLayout;
         Query.Locate('TableNo', TableNo, [loPartialKey]);
        end
       else
        DataForm.Rollback;
    end;
end;

procedure TPDATableLayoutForm.ProcessItemMove;
var
 TableNo: string;
 NewPosition: integer;
begin
 if (SelectedObjectName <> 'DBGrid') and (Copy(SelectedObjectName, 1, 5) <> 'Table') then Exit;
 if (Copy(ReleaseObjectName, 1, 5) <> 'Table') then Exit;
 if (SelectedObjectName = 'DBGrid') and (ReleaseObjectName = SelectedObjectName) then Exit;
 if (Copy(SelectedObjectName, 1, 5) = 'Table') and (SelectedObjectName=ReleaseObjectName) then Exit;
 if (Copy(SelectedObjectName, 1, 5) = 'Table') and (Copy(ReleaseObjectName, 1, 5) = 'Table') and
    CheckSeletedObjectStatus(TableNo, SelectedObjectName) and
    CheckReleaseObjectStatus(NewPosition, ReleaseObjectName) then
    MoveToNewPosition(TableNo, NewPosition)
   else
    if (SelectedObjectName = 'DBGrid') and (Copy(ReleaseObjectName, 1, 5) = 'Table') and
       CheckReleaseObjectStatus(NewPosition, ReleaseObjectName) then
       begin
        TableNo := Query.FieldByName('TableNo').AsString;
        MoveToNewPosition(TableNo, NewPosition)
      end
end;

procedure TPDATableLayoutForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TPDATableLayoutForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Left + DBGridPanel.Width + 22;
 Height := TabControl.Height + 46;
 OpenQuery;
 TabControl.TabIndex := 0;
 AssignTableLayout;
end;

procedure TPDATableLayoutForm.PDATableLayoutSetup;
begin
 Application.CreateForm(TPDATableLayoutForm, PDATableLayoutForm);
 PDATableLayoutForm.ShowModal;
 PDATableLayoutForm.Free;
end;

end.
