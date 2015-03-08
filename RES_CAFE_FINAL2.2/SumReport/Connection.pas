unit Connection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XiButton, StdCtrls, Mask, ComObj, Grids, DBGrids, ExtCtrls, Utility,
  DB, ADODB;

type
  TConnectionForm = class(TForm)
    ConnectButton: TXiButton;
    ExitButton: TXiButton;
    InstanceComboBox: TComboBox;
    BackPanel: TPanel;
    bsSkinStdLabel1: TLabel;
    DBGrid: TDBGrid;
    XiButton1: TXiButton;
    ADOConnection: TADOConnection;
    Query: TADOQuery;
    DataSource: TDataSource;
    function  ConnectToServer(ServerName, DatabaseName: string): boolean;
    procedure OpenDatabaseTablePro;
    procedure ExitButtonClick(Sender: TObject);
    procedure ConnectButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function  ConnectPro: boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  GetSQLServerList: Boolean;
    procedure XiButton1Click(Sender: TObject);
  private { Private declarations }
     ReturnFlag: boolean;
     LocalMachineName: string;
  public
    { Public declarations }
  end;

var
  ConnectionForm: TConnectionForm;

implementation

uses MessageBox;

{$R *.dfm}

function TConnectionForm.ConnectToServer(ServerName, DatabaseName: string): boolean;
var
 LocalMachineName: string;
begin
 UtilityForm.GetLocalMachineName(LocalMachineName);
 Result := True;
 with ADOConnection do
  begin
   Connected := False;
   ConnectionString := 'Provider=SQLOLEDB;' +
                       'Integrated Security=SSPI; ' +
                       'Persist Security Info=False; ' +
                       'Initial Catalog=' + DatabaseName +
                       ';Data Source=' + ServerName +
                       ';Use Procedure for Prepare=1; ' +
                       'Auto Translate=False; ' +
                       'Packet Size=32767; ' +
                       'Workstation ID=' + LocalMachineName;
   LoginPrompt := False;
   KeepConnection := True;
   try
    Open;
   except
    Result := False;
    MessageBoxForm.MessagePro('Can not find database server.', sErrorMsg);
   end;
  end;
end;

procedure TConnectionForm.OpenDatabaseTablePro;
var
 SQLStr: string;
begin
 SQLStr := 'Select Name From SysDatabases ' +
           'Where Name <> ' + Chr(39) + 'Master' + Chr(39) + ' and ' +
           'Name <> ' + Chr(39) + 'Model' + Chr(39) + ' and ' +
           'Name <> ' + Chr(39) + 'MSDB' + Chr(39) + ' and ' +
           'Name <> ' + Chr(39) + 'Tempdb' + Chr(39) + ' and ' +
           'Name <> ' + Chr(39) + 'Pubs' + Chr(39) + ' and ' +
           'Name <> ' + Chr(39) + 'Northwind' + Chr(39) + ' and ' +
           'Name <> ' + Chr(39) + 'Distribution' + Chr(39) +
           ' Order By Name';
 with Query do
  begin
   Active := False;
   Connection := ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
end;

procedure TConnectionForm.XiButton1Click(Sender: TObject);
begin
 if InstanceComboBox.Text = '' then
    MessageBoxForm.MessagePro('Server name is invalid.', sErrorMsg)
   else
    if ConnectToServer(InstanceComboBox.Text, 'Master') then
       OpenDatabaseTablePro;
end;

procedure TConnectionForm.ExitButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TConnectionForm.ConnectButtonClick(Sender: TObject);
begin
{ if InstanceComboBox.Text = '' then
    begin
     MessageBoxForm.MessagePro('Instance is invalid.', sErrorMsg);
     InstanceComboBox.SetFocus;
    end
   else
    begin
     InstanceName := InstanceComboBox.Text;
     try
      ReturnFlag := AdministrationForm.ConnectToMasterDatabase;
     finally
      if ReturnFlag then Close;
     end;
    end;
  }  
end;

procedure TConnectionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 ADOConnection.Close;
 Action := caFree;
end;

function TConnectionForm.GetSQLServerList: Boolean;
var
 SQLServerApp: Variant;
 ServerList: Variant;
 I: Integer;
 S: array [1..MAX_COMPUTERNAME_LENGTH + 1] of char;
 NameLength: DWORD;
begin
 NameLength := MAX_COMPUTERNAME_LENGTH + 1;
 GetComputerName(@S, NameLength);
 LocalMachineName := Copy(String(S), 1, NameLength);
 Result := True;
 try
  SQLServerApp := CreateOleObject('SQLDMO.Application');
  ServerList := SQLServerApp.ListAvailableSQLServers;
  for I := 1 to ServerList.Count do
   if (Uppercase(ServerList.Item(I)) = UpperCase('(local)')) or
      (Uppercase(ServerList.Item(I)) = Uppercase(LocalMachineName)) then
      InstanceComboBox.Items.Add(LocalMachineName)
     else
      if (Uppercase(Copy(ServerList.Item(I), 1 , Length(LocalMachineName))) = Uppercase(LocalMachineName)) then
         InstanceComboBox.Items.Add(ServerList.Item(I));
  SQLServerApp := Unassigned;
  ServerList := Unassigned;
 except
  Result := False;
 end;
end;

procedure TConnectionForm.FormShow(Sender: TObject);
begin
 GetSQLServerList;
 if InstanceComboBox.Items.Count = 0 then
    InstanceComboBox.Items.Add(LocalMachineName);
 InstanceComboBox.ItemIndex := 0;
end;

function TConnectionForm.ConnectPro: boolean;
begin
 Application.CreateForm(TConnectionForm, ConnectionForm);
 ConnectionForm.ShowModal;
 Result := ConnectionForm.ReturnFlag;
 ConnectionForm.Free;
end;

end.
