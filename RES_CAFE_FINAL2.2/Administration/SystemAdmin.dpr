program SystemAdmin;

uses
  Forms,
  Administration in 'Administration.pas' {AdministrationForm},
  MessageBox in 'MessageBox.pas' {MessageBoxForm},
  DisplayMessage in 'DisplayMessage.pas' {DisplayMessageForm},
  ReadPassword in 'ReadPassword.pas' {ReadPasswordForm},
  Connection in 'Connection.pas' {ConnectionForm},
  ReadUserName in 'ReadUserName.pas' {ReadUserNameForm},
  ReadDatabaseName in 'ReadDatabaseName.pas' {ReadDatabaseNameForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAdministrationForm, AdministrationForm);
  Application.CreateForm(TReadDatabaseNameForm, ReadDatabaseNameForm);
  GetDir(0, StartDir);
  if StartDir[Length(StartDir)] <> '\' then
     StartDir := StartDir + '\';
  ChDir('C:\');
  Application.Run;
end.
