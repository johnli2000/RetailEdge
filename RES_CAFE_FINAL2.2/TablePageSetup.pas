unit TablePageSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, DB, ADODB, StdCtrls, Buttons, bsSkinCtrls,
  BusinessSkinForm, XiButton, UtilUnit;

type
  TTablePageSetupForm = class(TForm)
    StringGrid: TStringGrid;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    procedure InitStringGrid;
    procedure OpenQuery;
    function  SaveData: boolean;
    procedure ReadData;
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure CancelButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    function  TablePageSetupPro: boolean;
    procedure StringGridDblClick(Sender: TObject);
   
  private { Private declarations }
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  TablePageSetupForm: TTablePageSetupForm;

implementation

uses DataUnit, Keyboard;

{$R *.dfm}

procedure TTablePageSetupForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   Cells[0, 0] := 'Page No';
   Cells[1, 0] := 'Description';
   for I := 1 to 5 do
    begin
     Cells[0, I] := IntToStr(I);
     Cells[1, I] := '';
    end;
  end;
end;

procedure TTablePageSetupForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From TablePage Order By PageNo');
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

function TTablePageSetupForm.SaveData: boolean;
var
 SQLStr: string;
 I, PageNo: integer;
begin
 Result := DataForm.BeginTransaction;
 if Not Result then Exit;
 PageNo := 1;
 try
  SQLStr := 'Delete From TablePage';
  Result := DataForm.ExecQueryPro(SQLStr);
  if Result then
     for I := 1 to 5 do
      if StringGrid.Cells[1, I] <> '' then
         begin
          SQLStr := 'Insert Into TablePage(PageNo, Description) ' +
                    'Values(' + IntToStr(PageNo) + ',' +
                    Chr(39) + CheckQuotes(StringGrid.Cells[1, I]) + Chr(39) + ')';
          Result := DataForm.ExecQueryPro(SQLStr);
          PageNo := PageNo + 1;
        end;
  finally
   if Result then
      DataForm.CommitTransaction
     else
      DataForm.RollBack;
  end;
end;

procedure TTablePageSetupForm.ReadData;
var
 I: integer;
begin
 InitStringGrid;
 OpenQuery;
 I := 1;
 while Not Query.EOF do
  begin
   StringGrid.Cells[1, I] := Query.FieldByName('Description').AsString;
   Query.Next;
   I := I + 1;
  end;
 Query.Close;
end;

procedure TTablePageSetupForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   if (ARow > 0) and (ACol > 0) then
      begin
       SetTextAlign(Canvas.Handle, TA_LEFT);
       X := Rect.Left + 2;
      end
     else
      begin
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TTablePageSetupForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TTablePageSetupForm.SaveButtonClick(Sender: TObject);
begin
 if SaveData then
    begin
     ReturnFlag := True;
     Close;
    end;
end;

procedure TTablePageSetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TTablePageSetupForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TTablePageSetupForm.StringGridDblClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    with StringGrid do Cells[1, Row] := Str;
end;

procedure TTablePageSetupForm.FormShow(Sender: TObject);
begin
 InitStringGrid;
 ReadData;
 StringGrid.SetFocus;
end;

function TTablePageSetupForm.TablePageSetupPro: boolean;
begin
 Application.CreateForm(TTablePageSetupForm, TablePageSetupForm);
 TablePageSetupForm.ShowModal;
 Result := TablePageSetupForm.ReturnFlag;
 TablePageSetupForm.Free;
end;



end.
