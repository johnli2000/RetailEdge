unit Backup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, ADODB, Gauges, UtilUnit, Mask,
  bsSkinCtrls, bsSkinShellCtrls, bsSkinBoxCtrls, BusinessSkinForm, XiButton;

type
  TBackupForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    BrowseButton: TbsSkinSpeedButton;
    OpenDialog: TOpenDialog;
    TargetFileNameEdit: TbsSkinEdit;
    StartButton: TXiButton;
    ExitButton: TXiButton;
    procedure BrowseButtonClick(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure BackupPro;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BackupForm: TBackupForm;

implementation

uses MessageBox, DataUnit, MainMenu, DisplayMessage;

{$R *.dfm}

procedure TBackupForm.BrowseButtonClick(Sender: TObject);
begin
 if TargetFileNameEdit.Text <> '' then
 OpenDialog.FileName := ExtractFileName(TargetFileNameEdit.Text);
 if OpenDialog.Execute then
    TargetFileNameEdit.Text := OpenDialog.FileName;
end;

procedure TBackupForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TBackupForm.StartButtonClick(Sender: TObject);
var
 SQLStr, TargetDir: string;
 Flag: boolean;
begin
 if TargetFileNameEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('File name error.', sErrorMsg);
     Exit;
    end;
 TargetDir := ExtractFilePath(TargetFileNameEdit.Text);
 if (TargetDir <> '') and Not DirectoryExists(TargetDir) then
    begin
     if MessageBoxForm.MessagePro('The directory does not exist, do you want to create?', sConfirmMsg) = mrYes then
        begin
         if Not CreateDir(TargetDir) then
            begin
             MessageBoxForm.MessagePro('Can not create the directory.', sERRORMsg);
             Exit;
            end
        end
       else
        Exit;
    end;
 if FileExists(TargetFileNameEdit.Text) then
    begin
     if MessageBoxForm.MessagePro('The file that you specified exists already,' +
        Chr(13) + Chr(10) + Chr(13) + Chr(10) +
        'do you want to replace it?', sConfirmMsg) = mrNo then
        Exit
       else
        if Not DeleteFile(TargetFileNameEdit.Text) then
           begin
            MessageBoxForm.MessagePro('Can not delete the file.', sERRORMsg);
            Exit;
           end;
    end;
 DisplayMessageForm.DisplayMessagePro('Backup database, please wait...');
 SQLStr := 'BACKUP DATABASE ' + sDatabaseName +
           ' TO DISK=' + Chr(39) + TargetFileNameEdit.Text + Chr(39);
 DataForm.ExecCommand.CommandTimeout := 300;
 Flag := False;
 try
  Flag := DataForm.ExecQueryPro(SQLStr);
 finally
  DisplayMessageForm.Close;
  DisplayMessageForm.Free;
  if Flag then
     begin
      StartButton.Enabled := False;
      WorkPanel.Enabled := False;
      MessageBoxForm.MessagePro('Database backup completed.', sInformationMsg);
     end
    else
     MessageBoxForm.MessagePro('Database backup failure!', sErrorMsg);
 end;
 DataForm.ExecCommand.CommandTimeout := 60;
end;

procedure TBackupForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := StartButton.Top + 86;
 TargetFileNameEdit.Text := StartDir + 'Backup\' + sDatabaseName + FormatDateTime('yyyymmddhhmmss', Date + Time) + '.Dat';
 StartButton.SetFocus;
end;

procedure TBackupForm.BackupPro;
begin
 Application.CreateForm(TBackupForm, BackupForm);
 BackupForm.ShowModal;
 BackupForm.Free;
end;

end.
