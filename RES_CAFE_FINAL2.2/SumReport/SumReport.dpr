program SumReport;

uses
  Forms,
  MainMenu in 'MainMenu.pas' {MainMenuForm},
  Utility in 'Utility.pas' {UtilityForm: TDataModule},
  MessageBox in 'MessageBox.pas' {MessageBoxForm},
  Connection in 'Connection.pas' {ConnectionForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TUtilityForm, UtilityForm);
  Application.CreateForm(TMainMenuForm, MainMenuForm);
  Application.CreateForm(TConnectionForm, ConnectionForm);
  Application.Run;
end.
