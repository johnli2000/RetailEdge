unit VoidReasonSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask,
  UtilUnit, ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TVoidReasonSetupForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    Label1: TLabel;
    DescriptionEdit: TEdit;
    Label2: TLabel;
    CodeEdit: TEdit;
    QueryCode: TStringField;
    QueryDescription: TStringField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    EditPanel: TbsSkinPanel;
    NewButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    ExitButton: TXiButton;
    procedure OpenQuery;
    procedure SetReadStatus;
    procedure SetEditStatus;
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    function  ProcessEditCode: Boolean;
    function  ProcessNewCode: Boolean;
    procedure SaveButtonClick(Sender: TObject);
    function  SaveData: boolean;
    procedure CancelButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridDblClick(Sender: TObject);
    procedure VoidReasonSetupPro;
    procedure CodeEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DescriptionEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private { Private declarations }
   OpFlag: Integer;
   OldCode: String;
  public
    { Public declarations }
  end;

var
 VoidReasonSetupForm: TVoidReasonSetupForm;

implementation

uses DataUnit, MainMenu, MessageBox;

{$R *.DFM}

procedure TVoidReasonSetupForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From VoidReasonTable Order By Code');
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TVoidReasonSetupForm.SetReadStatus;
begin
 DBGrid.Enabled := True;
 EditPanel.Enabled := False;
 NewButton.Enabled := True;
 EditButton.Enabled := True;
 DeleteButton.Enabled := True;
 ExitButton.Enabled := True;
 SaveButton.Enabled := False;
 CancelButton.Enabled := False;
 CodeEdit.Text := '';
 DescriptionEdit.Text := '';
 DBGrid.SetFocus;
end;

procedure TVoidReasonSetupForm.SetEditStatus;
begin
 DBGrid.Enabled := False;
 EditPanel.Enabled := True;
 DeleteButton.Enabled := False;
 NewButton.Enabled := False;
 EditButton.Enabled := False;
 ExitButton.Enabled := False;
 SaveButton.Enabled := True;
 CancelButton.Enabled := True;
 CodeEdit.SetFocus;
end;

procedure TVoidReasonSetupForm.DBGridDblClick(Sender: TObject);
begin
 EditButtonClick(Sender);
end;

procedure TVoidReasonSetupForm.DeleteButtonClick(Sender: TObject);
var
 Code: string;
 Flag: boolean;
begin
 if (MessageBoxForm.MessagePro('Are you sure you want to delete this record?', sConfirmMsg) = mrNo) then
    Exit;
 Code := Query.FieldByName('Code').AsString;
 Flag := False;
 if DataForm.BeginTransaction then
    try
     Flag := DataForm.ExecQueryPro('Delete From VoidReasonTable Where Code=' + Chr(39) + CheckQuotes(Code) + Chr(39));
    finally
     if Flag then
        begin
         DataForm.CommitTransaction;
         OpenQuery
        end
       else
         DataForm.RollBack;
    end;
end;

procedure TVoidReasonSetupForm.NewButtonClick(Sender: TObject);
begin
 OpFlag := sNewStatus;
 SetEditStatus;
end;

procedure TVoidReasonSetupForm.EditButtonClick(Sender: TObject);
begin
 with Query do
  if RecordCount > 0 then
     begin
      OpFlag := sEditStatus;
      OldCode := FieldByName('Code').AsString;
      CodeEdit.Text := OldCode;
      DescriptionEdit.Text := FieldByName('Description').AsString;
      SetEditStatus;
     end;
end;

function TVoidReasonSetupForm.SaveData: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Insert Into VoidReasonTable(Code, Description) ' +
           'Values(' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39) + ',' +
           Chr(39) + CheckQuotes(DescriptionEdit.Text) + Chr(39) + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TVoidReasonSetupForm.ProcessEditCode: Boolean;
var
 RecordCount: Integer;
begin
 Result := True;
 if OldCode <> CodeEdit.Text then
    begin
     RecordCount := DataForm.CheckCodeSQLPro('Select Count(*) From VoidReasonTable where Code = ' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39));
     if (RecordCount > 0) and
        (MessageBoxForm.MessagePro(CodeEdit.Text + ' exists already. Do you want to replace?', sConfirmMsg) = mrNo) then
        begin
         Result := False;
         Exit;
        end;
     Result := DataForm.ExecQueryPro('Delete From VoidReasonTable Where Code=' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39));
    end;
  if Result then
     Result := DataForm.ExecQueryPro('Delete From VoidReasonTable Where Code=' + Chr(39) + CheckQuotes(OldCode) + Chr(39));
  if Result then Result := SaveData;
end;

function TVoidReasonSetupForm.ProcessNewCode: boolean;
begin
 if DataForm.CheckCodeSQLPro('Select Count(*) From VoidReasonTable where Code=' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39)) > 0 then
    begin
     MessageBoxForm.MessagePro(CodeEdit.Text + ' is already exist.', sErrorMsg);
     Result := False;
    end
   else
    Result := SaveData;
end;

procedure TVoidReasonSetupForm.SaveButtonClick(Sender: TObject);
var
 Flag: boolean;
 Code: string;
begin
 if CodeEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Code invalid!', sErrorMsg);
     Exit;
    end;
 if DescriptionEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Description invalid!', sErrorMsg);
     Exit;
    end;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  if OpFlag = sNewStatus then
     Flag := ProcessNewCode
    else
     Flag := ProcessEditCode;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      Code := CodeEdit.Text;
      SetReadStatus;
      OpenQuery;
      Query.Locate('Code', Code, [loPartialKey]);
     end
    else
     begin
      DataForm.RollBack;
     end;
 end;
end;

procedure TVoidReasonSetupForm.CancelButtonClick(Sender: TObject);
begin
 SetReadStatus;
end;

procedure TVoidReasonSetupForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TVoidReasonSetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if ExitButton.Enabled then
    begin
     Query.Close;
     Action := caFree;
     VoidReasonSetupForm := Nil;
    end
   else
    Action := caNone;
end;

procedure TVoidReasonSetupForm.CodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DescriptionEdit.SetFocus
end;

procedure TVoidReasonSetupForm.DescriptionEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SaveButton.SetFocus
end;

procedure TVoidReasonSetupForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TVoidReasonSetupForm.FormShow(Sender: TObject);
begin
 Width := NewButton.Left + NewButton.Width + 28;
 Height := EditPanel.Top + EditPanel.Height + 46;
 Top := (MainForm.ClientHeight - Height - MainForm.bsSkinMainMenuBar.Height) div 2;
 Left := (MainForm.ClientWidth - Width) div 2;
 OpenQuery;
 SetReadStatus;
end;

procedure TVoidReasonSetupForm.VoidReasonSetupPro;
begin
  Application.CreateForm(TVoidReasonSetupForm, VoidReasonSetupForm);
  VoidReasonSetupForm.ShowModal;
  VoidReasonSetupForm.Free;
end;

end.
