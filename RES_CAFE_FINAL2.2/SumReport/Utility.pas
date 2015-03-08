unit Utility;

interface

uses
  SysUtils, Classes, DB, ADODB,
  Windows, Messages, Controls, DBCtrls, StdCtrls, ExtCtrls, DateUtils;

Const
 sErrorMsg =1;
 sInformationMsg = 2;
 sConfirmMsg = 3;


type
  TUtilityForm = class(TDataModule)
    LocalConnection: TADOConnection;
    RemoteConnection: TADOConnection;
    ExecCommand: TADOCommand;
    LockQuery: TADOQuery;
    procedure GetLocalMachineName(var MachineName: string);
    function  ConnectToLocalDatabase(ServerName, DatabaseName: string): boolean;
    function  ConnectToRemoteDatabase(CommString: string): boolean;
    function  LockDatabasePro: boolean;
    function  BeginTransaction: boolean;
    procedure CommitTransaction;
    procedure RollBack;
    function  ExecQueryPro(SQLStr: widestring): boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UtilityForm: TUtilityForm;
  sLocalServerName, sLocalDatabaseName: string;

implementation

uses MessageBox;

{$R *.dfm}

procedure TUtilityForm.GetLocalMachineName(var MachineName: string);
var
 S: array [1..MAX_COMPUTERNAME_LENGTH + 1] of char;
 NameLength: DWORD;
begin
 NameLength := MAX_COMPUTERNAME_LENGTH + 1;
 GetComputerName(@S, NameLength);
 MachineName := Copy(String(S), 1, NameLength);
end;

function TUtilityForm.ConnectToLocalDatabase(ServerName, DatabaseName: string): boolean;
var
 LocalMachineName: string;
begin
 GetLocalMachineName(LocalMachineName);
 Result := True;
 with LocalConnection do
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
    MessageBoxForm.MessagePro('Can not find database server, network connection error.', sErrorMsg);
   end;
  end;
end;

function TUtilityForm.ConnectToRemoteDatabase(CommString: string): boolean;
var
 LocalMachineName: string;
begin
 GetLocalMachineName(LocalMachineName);
 Result := True;
 with LocalConnection do
  begin
   Connected := False;
   ConnectionString := CommString;
   LoginPrompt := False;
   KeepConnection := True;
   try
    Open;
   except
    Result := False;
    MessageBoxForm.MessagePro('Can not find database server, network connection error.', sErrorMsg);
   end;
  end;
end;

function TUtilityForm.LockDatabasePro: boolean;
begin
 Result := True;
 with LockQuery do
  begin
   Active := False;
   Connection := LocalConnection;
   SQL.Clear;
   SQL.Add('Select * From Version (TabLockX)');
   try
    Active := True;
   except
    Result := False;
   end;
  end;
end;

function TUtilityForm.BeginTransaction: boolean;
begin
 ExecQueryPro('SET TRANSACTION ISOLATION LEVEL SERIALIZABLE');
 ExecQueryPro('Begin Transaction');
 repeat
  Result := LockDatabasePro;
 until Result or (MessageBoxForm.MessagePro('Database has been used by another user, ' +
                 Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                  'Do you want to try again? ', sConfirmMsg) = mrNo);
 if Not Result then RollBack;
end;

procedure TUtilityForm.CommitTransaction;
begin
 LockQuery.Close;
 ExecQueryPro('Commit Transaction');
 ExecQueryPro('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
end;

procedure TUtilityForm.RollBack;
begin
 LockQuery.Close;
 ExecQueryPro('RollBack Transaction');
 ExecQueryPro('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
end;

function TUtilityForm.ExecQueryPro(SQLStr: widestring): boolean;
begin
 Result := True;
 with ExecCommand do
  begin
   Connection := LocalConnection;
   CommandText := SQLStr;
   try
    Execute;
   except
    Result := False;
   end;
  end;
end;

end.
