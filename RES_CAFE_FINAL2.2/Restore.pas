unit Restore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, ADODB, Gauges, UtilUnit, Mask,
  bsSkinCtrls, bsSkinBoxCtrls, BusinessSkinForm, XiButton;

type
  TRestoreForm = class(TForm)
    OpenDialog: TOpenDialog;
    Query: TADOQuery;
    BusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    FileNameEdit: TbsSkinEdit;
    BrowseButton: TbsSkinSpeedButton;
    StartButton: TXiButton;
    ExitButton: TXiButton;
    procedure OpenQuery(SQLStr: string);
    procedure BrowseButtonClick(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    function  RestoreDatabasePro: boolean;
    function  RestorePro: boolean;
    procedure FormShow(Sender: TObject);
  private { Private declarations }
    LocalMachineName: string;
  public
    { Public declarations }
  end;

var
  RestoreForm: TRestoreForm;

implementation

uses MessageBox, DataUnit, MainMenu, DisplayMessage, Upgrade;

{$R *.dfm}

procedure TRestoreForm.OpenQuery(SQLStr: string);
begin
 with Query do
  begin
   Active := False;
   ConnectionString := 'Provider=SQLOLEDB;' +
                       'Integrated Security=SSPI; ' +
                       'Persist Security Info=False; ' +
                       'Initial Catalog=Master' +
                       ';Data Source=' + sServerName +
                       ';Use Procedure for Prepare=1; ' +
                       'Auto Translate=False; ' +
                       'Packet Size=32767; ' +
                       'Workstation ID=' + LocalMachineName;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
end;

procedure TRestoreForm.BrowseButtonClick(Sender: TObject);
begin
 if OpenDialog.Execute then FileNameEdit.Text := OpenDialog.FileName;
end;

procedure TRestoreForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

function  TRestoreForm.RestoreDatabasePro: boolean;
var
 SQLStr, MDFFileName, LGFFileName, LogicalDBMFileName, LogicalLOGFileName: string;
 Flag : boolean;
 I: integer;
begin
 SQLStr := 'Select Name, FileName From SysDatabases ' +
           'Where Name=' + Chr(39) + CheckQuotes(sDatabaseName) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   MDFFileName := FieldByName('FileName').AsString;
   Close;
  end;
 LGFFileName := ChangeFileExt(MDFFileName, '.LGF');
 SQLStr := 'RESTORE FILELISTONLY FROM DISK = ' + Chr(39) + CheckQuotes(FileNameEdit.Text) + Chr(39);
 OpenQuery(SQLStr);
 with Query do
  begin
   First;
   if FieldByName('Type').AsString = 'D' then
      LogicalDBMFileName := FieldByName('LogicalName').AsString
     else
      LogicalLOGFileName := FieldByName('LogicalName').AsString;
   Next;
   if FieldByName('Type').AsString = 'D' then
      LogicalDBMFileName := FieldByName('LogicalName').AsString
     else
      LogicalLOGFileName := FieldByName('LogicalName').AsString;
   Close;
  end;

 Flag := False; I := 0;
 Repeat
  try
   I := I + 1;
   SQLStr := 'RESTORE DATABASE ' + sDatabaseName + ' ' +
             'FROM DISK=' + Chr(39) + CheckQuotes(FileNameEdit.Text) + Chr(39) + ' ' +
             'WITH REPLACE, ' +
             'MOVE ' + Chr(39) + CheckQuotes(LogicalDBMFileName) + Chr(39) + ' TO ' + Chr(39) + CheckQuotes(MDFFileName) + Chr(39) + ', ' +
             'MOVE ' + Chr(39) + CheckQuotes(LogicalLOGFileName) + Chr(39) + ' TO ' + Chr(39) + CheckQuotes(LGFFileName) + Chr(39);
   Flag := DataForm.ExecQueryPro(SQLStr);
   if Flag then Flag := DataForm.ExecQueryPro('Use ' + sDatabaseName);
   if Flag then Flag := DataForm.ExecQueryPro('Grant All To Guest');
   if Flag then Flag := DataForm.ExecQueryPro('Grant All To Public');
  Finally
   Result := Flag
  end;
 Until Result or (I > 3);
end;

procedure TRestoreForm.StartButtonClick(Sender: TObject);
var
 Flag: boolean;
 I: integer;
begin
 GetLocalMachineName(LocalMachineName);
 if FileNameEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('File name error.', sErrorMsg);
     Exit;
    end;
 if Not FileExists(FileNameEdit.Text) then
    begin
     MessageBoxForm.MessagePro('Can not find the backup file that you specified.', sInformationMsg);
     Exit
    end;
 if MessageBoxForm.MessagePro('Are you sure you want to restore the database?', sConfirmMsg) = mrNo then
    Exit;

 for I := 0 to DataForm.ADOConnection.DataSetCount - 1 do
  DataForm.ADOConnection.DataSets[I].Active := False;
 DataForm.ExecCommand.CommandTimeout := 300;
 DataForm.ExecQueryPro('Use Master');
 Application.ProcessMessages;
 repeat
  DisplayMessageForm.DisplayMessagePro('Restore database, please wait...');
  Flag := RestoreDatabasePro;
  DisplayMessageForm.Close;
  DisplayMessageForm.Free;
 until Flag or (MessageBoxForm.MessagePro('Database restore failure because database currently in uses.' +
         Chr(13) + Chr(10) + Chr(13) + Chr(10) +
         'Do you want to try again ?', sConfirmMsg) = mrNo);
 DataForm.ExecQueryPro('Use ' + sDatabaseName);
 if Flag then
    begin
     StartButton.Enabled := False;
     WorkPanel.Enabled := False;
     UpgradeForm.UpgradePro(DataForm.ADOConnection);
     MessageBoxForm.MessagePro('Database restore completed.', sInformationMsg);
    end;
 DataForm.ExecCommand.CommandTimeout := 30;
end;

procedure TRestoreForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := StartButton.Top + 86;
end;

function TRestoreForm.RestorePro: boolean;
var
 LocalMachineName: string;
begin
 GetLocalMachineName(LocalMachineName);
 if Uppercase(LocalMachineName) <> Uppercase(Copy(sServerName, 1, Length(LocalMachineName))) then
    begin
     MessageBoxForm.MessagePro('Database restore must do on the server.', sInformationMsg);
     Result := False;
    end
   else
    begin
     Application.CreateForm(TRestoreForm, RestoreForm);
     RestoreForm.ShowModal;
     Result := Not RestoreForm.StartButton.Enabled;
     RestoreForm.Free;
    end;
end;

end.
