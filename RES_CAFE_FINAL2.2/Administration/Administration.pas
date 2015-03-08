unit Administration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls,
  bsSkinData, BusinessSkinForm, bsSkinCtrls, XiButton;

const
 ErrorMsg = 1;
 InformationMsg = 2;
 ConfirmMsg = 3;

type
  TAdministrationForm = class(TForm)
    DBGrid: TDBGrid;
    Query: TADOQuery;
    DataSource: TDataSource;
    QueryName: TWideStringField;
    QueryFileName: TWideStringField;
    MasterConnection: TADOConnection;
    MasterCommand: TADOCommand;
    TempQuery: TADOQuery;
    ADOCommand: TADOCommand;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    bsSkinData: TbsSkinData;
    bsCompressedStoredSkin: TbsCompressedStoredSkin;
    ListPanel: TbsSkinPanel;
    LogonButton: TXiButton;
    ChangePasswordButton: TXiButton;
    NewButton: TXiButton;
    DeleteButton: TXiButton;
    AddUserGroupButton: TXiButton;
    ConfigueButton: TXiButton;
    ExitButton: TXiButton;
    function  ConnectToMasterDatabase: boolean;
    procedure OpenSysdatabases;
    function  OpenTempQuery(SQLStr: string): boolean;
    function  CheckPasswordTable: boolean;
    function  ExecCommandPro(SQLStr: string): boolean;
    function  TestPassword(UserName, Password: string): boolean;
    procedure DeleteButtonClick(Sender: TObject);
    procedure AddNewUsers(UserName: string);
    procedure CreateDatabase(DatabaseName: string; SupportChinese, DemoDatabase: boolean);
    procedure NewButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure AdministrationPro;
    procedure ConfigueButtonClick(Sender: TObject);
    procedure LogonButtonClick(Sender: TObject);
    procedure ChangePasswordButtonClick(Sender: TObject);
    procedure AddUserGroupButtonClick(Sender: TObject);
    function  GrantLogin(NewUserName: string): boolean;
    function  GrantDBAccess(NewUserName: string): boolean;
    function  ChangeDBOwner(NewUserName: string): boolean;
    function  AddServerRole(NewUserName: string): boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AdministrationForm: TAdministrationForm;
  StartDir: string;
  InstanceName, DatabaseName, FilePathName, MDFFileName, LGFFileName, DLLFileName: string;
  OpFlag: integer;

implementation

uses MessageBox, DisplayMessage, ReadPassword, Connection, ReadUserName,
  ReadDatabaseName;

{$R *.dfm}

function TAdministrationForm.ConnectToMasterDatabase: boolean;
begin
 with MasterConnection do
  begin
   Connected := False;
   ConnectionString := 'Provider=SQLOLEDB;' +
                       'Integrated Security=SSPI; ' +
                       'Persist Security Info=False; ' +
                       'Initial Catalog=Master' +
                       ';Data Source=' + InstanceName +
                       ';Use Procedure for Prepare=1; ' +
                       'Auto Translate=False; ' +
                       'Packet Size=32767; ' +
                       'Workstation ID=' + InstanceName;
   LoginPrompt := False;
   KeepConnection := True;
   try
    Open;
   finally
    Result := Connected;
    if Not Result then MessageBoxForm.MessagePro('Can not find database server.', ErrorMsg);
   end;
  end;
end;

procedure TAdministrationForm.OpenSysdatabases;
var
 SQLStr: string;
begin
 SQLStr := 'Select Name, FileName From SysDatabases ' +
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
   Connection := MasterConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
end;

function TAdministrationForm.OpenTempQuery(SQLStr: string): boolean;
begin
 Result := True;
 with TempQuery do
  begin
   Active := False;
   Connection := MasterConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   except
    Result := False;
   end;
  end;
end;

function TAdministrationForm.CheckPasswordTable: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From AdminTable';
 Result := OpenTempQuery(SQLStr);
 if Not Result then
    begin
     SQLStr := 'Create Table AdminTable(AdminName Varchar(10) Null, SecureCode VarChar(8) Null)';
     Result := ExecCommandPro(SQLStr);
     if Result then
        begin
         SQLStr := 'Insert Into AdminTable(AdminName, SecureCode) ' +
                   'Values(' + Chr(39) + 'SA' + Chr(39) + ',' +
                   Chr(39) + '0000' + Chr(39) + ')';
         Result := ExecCommandPro(SQLStr);
        end;
    end;
end;

function TAdministrationForm.TestPassword(UserName, Password: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From AdminTable';
 Result := OpenTempQuery(SQLStr);
 if Result then
    with TempQuery do
     begin
      if (Uppercase(FieldByName('AdminName').AsString) = Uppercase(UserName)) and
         (FieldByName('SecureCode').AsString = Uppercase(Password)) then
         Result := True
        else
         Result := False;
    end;
 TempQuery.Close;
 if Not Result then
    MessageBoxForm.MessagePro('User name or password error.', ErrorMsg);
end;

function TAdministrationForm.ExecCommandPro(SQLStr: string): boolean;
begin
 Result := True;
 with MasterCommand do
  begin
   Connection := MasterConnection;
   CommandText := SQLStr;
   try
    Execute;
   except
    Result := False;
   end;
  end;
end;

procedure TAdministrationForm.DeleteButtonClick(Sender: TObject);
var
 SQLStr, DatabaseName: string;
begin
 if Not Query.Active or (Query.RecordCount <= 0) then Exit;
 DatabaseName := Query.FieldByName('Name').AsString;
 if MessageBoxForm.MessagePro('Are you sure you want to delete database ' +
    DatabaseName + ' ?', ConfirmMsg) = mrNo then Exit;
 SQLStr := 'DROP DATABASE ' + DatabaseName;
 if ExecCommandPro(SQLStr) then
    begin
     OpenSysDatabases;
     MessageBoxForm.MessagePro('Database has been deleted', InformationMsg);
    end
   else
    MessageBoxForm.MessagePro('Database delete failure because it is using for another user.', ERRORMsg);
end;

function  TAdministrationForm.GrantLogin(NewUserName: string): boolean;
begin
 ADOCommand.CommandText := 'sp_grantlogin; 1';
 ADOCommand.Parameters.Clear;
 ADOCommand.Parameters.AddParameter.Name := '@RETURN_VALUE';
 ADOCommand.Parameters.FindParam('@RETURN_VALUE').DataType := ftInteger;
 ADOCommand.Parameters.FindParam('@RETURN_VALUE').Direction := pdReturnValue;
 ADOCommand.Parameters.AddParameter.Name := '@loginname';
 ADOCommand.Parameters.FindParam('@loginname').DataType := ftString;
 ADOCommand.Parameters.FindParam('@loginname').Direction := pdInput;
 ADOCommand.Parameters.FindParam('@loginname').Value := NewUserName;
 try
  ADOCommand.Execute;
 finally
  Result := ADOCommand.Parameters.FindParam('@RETURN_VALUE').Value = 0
 end;
end;

function  TAdministrationForm.AddServerRole(NewUserName: string): boolean;
begin
 ADOCommand.CommandText := 'sp_addsrvrolemember; 1';
 ADOCommand.Parameters.Clear;
 ADOCommand.Parameters.AddParameter.Name := '@RETURN_VALUE';
 ADOCommand.Parameters.FindParam('@RETURN_VALUE').DataType := ftInteger;
 ADOCommand.Parameters.FindParam('@RETURN_VALUE').Direction := pdReturnValue;
 ADOCommand.Parameters.AddParameter.Name := '@loginname';
 ADOCommand.Parameters.FindParam('@loginname').DataType := ftString;
 ADOCommand.Parameters.FindParam('@loginname').Direction := pdInput;
 ADOCommand.Parameters.FindParam('@loginname').Value := NewUserName;
 ADOCommand.Parameters.AddParameter.Name := '@rolename';
 ADOCommand.Parameters.FindParam('@rolename').DataType := ftString;
 ADOCommand.Parameters.FindParam('@rolename').Direction := pdInput;
 ADOCommand.Parameters.FindParam('@rolename').Value := 'sysadmin';
 try
  ADOCommand.Execute;
 finally
  Result := ADOCommand.Parameters.FindParam('@RETURN_VALUE').Value = 0
 end;
end;

function TAdministrationForm.GrantDBAccess(NewUserName: string): boolean;
begin
 Result := False;
 ADOCommand.CommandText := 'sp_grantdbaccess;1';
 ADOCommand.Parameters.Clear;
 ADOCommand.Parameters.AddParameter.Name := '@RETURN_VALUE';
 ADOCommand.Parameters.FindParam('@RETURN_VALUE').DataType := ftInteger;
 ADOCommand.Parameters.FindParam('@RETURN_VALUE').Direction := pdReturnValue;
 ADOCommand.Parameters.AddParameter.Name := '@loginname';
 ADOCommand.Parameters.FindParam('@loginname').DataType := ftString;
 ADOCommand.Parameters.FindParam('@loginname').Direction := pdInput;
 ADOCommand.Parameters.FindParam('@loginname').Value := NewUserName;
 ADOCommand.Parameters.AddParameter.Name := '@name_in_db';
 ADOCommand.Parameters.FindParam('@name_in_db').DataType := ftString;
 ADOCommand.Parameters.FindParam('@name_in_db').Direction := pdInput;
 ADOCommand.Parameters.FindParam('@name_in_db').Value := NewUserName;
 try
  ADOCommand.Execute;
 except
  Result := ADOCommand.Parameters.FindParam('@RETURN_VALUE').Value = 0
 end;
end;

function TAdministrationForm.ChangeDBOwner(NewUserName: string): boolean;
begin
 Result := False;
 ADOCommand.CommandText := 'sp_addrolemember;1';
 ADOCommand.Parameters.Clear;
 ADOCommand.Parameters.AddParameter.Name := '@RETURN_VALUE';
 ADOCommand.Parameters.FindParam('@RETURN_VALUE').DataType := ftInteger;
 ADOCommand.Parameters.FindParam('@RETURN_VALUE').Direction := pdReturnValue;
 ADOCommand.Parameters.AddParameter.Name := '@rolename';
 ADOCommand.Parameters.FindParam('@rolename').DataType := ftString;
 ADOCommand.Parameters.FindParam('@rolename').Direction := pdInput;
 ADOCommand.Parameters.FindParam('@rolename').Value := 'db_owner';
 ADOCommand.Parameters.AddParameter.Name := '@membername';
 ADOCommand.Parameters.FindParam('@membername').DataType := ftString;
 ADOCommand.Parameters.FindParam('@membername').Direction := pdInput;
 ADOCommand.Parameters.FindParam('@membername').Value := NewUserName;
 try
  ADOCommand.Execute;
 except
  Result := ADOCommand.Parameters.FindParam('@RETURN_VALUE').Value = 0
 end;
end;

procedure TAdministrationForm.AddNewUsers(UserName: string);
var
 Flag: boolean;
 DatabaseName, NewUserName, LocalMachineName: string;
 S: array [1..MAX_COMPUTERNAME_LENGTH + 1] of char;
 NameLength: DWORD;
begin
 NameLength := MAX_COMPUTERNAME_LENGTH + 1;
 GetComputerName(@S, NameLength);
 LocalMachineName := Copy(String(S), 1, NameLength);
 NewUserName := LocalMachineName + '\' + UserName;
 Flag := GrantLogin(NewUserName);
 if Flag then Flag := AddServerRole(NewUserName);
 if Flag then
    with Query do
     begin
      First;
      while Flag and Not EOF do
       begin
        DatabaseName := FieldByName('Name').AsString;
        Flag := ExecCommandPro('Use ' + DatabaseName);
        GrantDBAccess(NewUserName);
        ChangeDBOwner(NewUserName);
        Next;
       end;
      ExecCommandPro('Use Master');
     end;
 if Flag then
    MessageBoxForm.MessagePro('User / Group Added successful', InformationMsg)
   else
    MessageBoxForm.MessagePro('Error.', ERRORMsg);
end;

procedure TAdministrationForm.CreateDatabase(DatabaseName: string; SupportChinese, DemoDatabase: boolean);
var
 LogicalDBMFileName, LogicalLOGFileName, SQLStr: string;
 Flag: boolean;
begin
 OpenTempQuery('Select Name, FileName From SysDatabases Order By Name');
 Flag := True;
 with TempQuery do
  begin
   First;
   FilePathName := ExtractFilePath(FieldByName('FileName').AsString);
   while Not EOF do
    begin
     if DatabaseName = FieldByName('Name').AsString then
        Flag := False;
     Next;
    end;
   Close;
  end;
 if Not Flag then
    begin
     MessageBoxForm.MessagePro('Database: ' + DatabaseName + ' exists already', ErrorMsg);
     Exit;
    end;
 MDFFileName := FilePathName + DatabaseName + '_Data.MDF';
 LGFFileName := FilePathName + DatabaseName + '_LOG.LGF';
 if FileExists(MDFFileName) then
    begin
     MessageBoxForm.MessagePro('File: ' + MDFFileName + ' exists already', ErrorMsg);
     Exit;
    end;
 if FileExists(LGFFileName) then
    begin
     MessageBoxForm.MessagePro('File: ' + LGFFileName + ' exists already', ErrorMsg);
     Exit;
    end;
 if DemoDatabase then
    DLLFileName := StartDir + 'DigitalData.DLL'
   else
    begin
     if SupportChinese then
        DLLFileName := StartDir + 'DigitalAssistCH.DLL'
       else
        DLLFileName := StartDir + 'DigitalAssistEN.DLL';
    end;
 if Not FileExists(DLLFileName) then
    begin
     MessageBoxForm.MessagePro('Can not find file: ' + DLLFileName, ErrorMsg);
     Exit;
    end;
 DisplayMessageForm.DisplayMessagePro('Creating database, please waiting...');
 try
  SQLStr := 'RESTORE FILELISTONLY FROM DISK = ' + Chr(39) + DLLFileName + Chr(39);
  OpenTempQuery(SQLStr);
  with TempQuery do
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
  SQLStr := 'RESTORE DATABASE ' + DatabaseName + ' ' +
            'FROM DISK=' + Chr(39) + DLLFileName + Chr(39) + ' ' +
            'WITH RECOVERY, ' +
            'MOVE ' + Chr(39) + LogicalDBMFileName + Chr(39) + ' TO ' + Chr(39) + MDFFileName + Chr(39) + ', ' +
            'MOVE ' + Chr(39) + LogicalLOGFileName + Chr(39) + ' TO ' + Chr(39) + LGFFileName + Chr(39);
  Flag := ExecCommandPro(SQLStr);
  if Flag then
     begin
      ExecCommandPro('Use ' + DatabaseName);
      ExecCommandPro('Grant All To Guest');
      EXecCommandPro('Grant All To Public');
      ExecCommandPro('Use Master');
     end;
 finally
  DisplayMessageForm.Close;
  DisplayMessageForm.Free;
  if Flag then
     begin
      OpenSysDatabases;
      MessageBoxForm.MessagePro('Database ' + DatabaseName + ' has been created.', InformationMsg);
     end
    else
     MessageBoxForm.MessagePro('Error.', ERRORMsg);
 end;
end;

procedure TAdministrationForm.ConfigueButtonClick(Sender: TObject);
var
 F: TextFile;
 FileName, S, SQLStr: string;
begin
 FileName := StartDir + 'Database.CFG';
 AssignFile(F, FileName);
 Rewrite(F);
 with Query do
  begin
   First;
   while Not EOF do
    begin
     ExecCommandPro('Use ' + FieldByName('Name').AsString);
     SQLStr := 'Select Name From Sysfiles where FileID=1';
     if OpenTempQuery(SQLStr) and (Copy(TempQuery.FieldByName('Name').AsString, 1, 16) = 'Hospitality_Data') then
        begin
         S := FieldByName('Name').AsString + Chr(09) + Chr(09) +
              InstanceName + Chr(09) + Chr(09) + FieldByName('Name').AsString;
         Writeln(F, S);
        end;
     Next;
    end;
  end;
 CloseFile(F);
 ExecCommandPro('Use Master');
 MessageBoxForm.MessagePro('Database config file has been created.', InformationMsg);
end;

procedure TAdministrationForm.NewButtonClick(Sender: TObject);
var
 DatabaseName: string;
 SupportChinese, DemoDatabase: boolean;
begin
 if ReadDatabaseNameForm.ReadDatabaseNamePro(DatabaseName, SupportChinese, DemoDatabase) then
    CreateDatabase(DatabaseName, SupportChinese, DemoDatabase);
end;

procedure TAdministrationForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TAdministrationForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 MasterConnection.Close;
 Action := caFree;
end;

procedure TAdministrationForm.ChangePasswordButtonClick(Sender: TObject);
var
 NewUserName, NewPassword, SQLStr: string;
begin
 if Not ReadPasswordForm.ReadPasswordPro(NewUserName, NewPassword) then Exit;
 SQLStr := 'Delete From AdminTable';
 if ExecCommandPro(SQLStr) then
    begin
     SQLStr := 'Insert Into AdminTable(AdminName, SecureCode) ' +
               'Values(' + Chr(39) + Uppercase(NewUserName) + Chr(39) + ',' +
                Chr(39) + NewPassword + Chr(39) + ')';
     ExecCommandPro(SQLStr);
    end;
end;

procedure TAdministrationForm.AddUserGroupButtonClick(Sender: TObject);
var
 UserName: string;
begin
 if ReadUserNameForm.ReadUserNamePro(UserName) then AddNewUsers(UserName);
end;

procedure TAdministrationForm.LogonButtonClick(Sender: TObject);
var
 UserName, Password: string;
begin
 if Not ReadPasswordForm.ReadPasswordPro(UserName, Password) then Exit;
 if TestPassword(UserName, Password) then
    begin
     OpenSysdatabases;
     LogonButton.Visible := False;
     ChangePasswordButton.Visible := True;
     NewButton.Enabled := True;
     DeleteButton.Enabled := True;
     ConfigueButton.Enabled := True;
     ListPanel.Enabled := True;
     AddUserGroupButton.Enabled := True;
    end;
end;

procedure TAdministrationForm.FormShow(Sender: TObject);
begin
 if Not ConnectionForm.ConnectPro then
    Close
   else
    if Not CheckPassWordTable then
       begin
        MessageBoxForm.MessagePro('Error.', ERRORMsg);
        Close;
       end
      else
       begin
        LogonButton.Visible := True;
        ChangePasswordButton.Visible := False;
        NewButton.Enabled := False;
        DeleteButton.Enabled := False;
        AddUserGroupButton.Enabled := False;
        ConfigueButton.Enabled := False;
        ListPanel.Enabled := False;
       end;
end;

procedure TAdministrationForm.AdministrationPro;
begin
 Application.CreateForm(TAdministrationForm, AdministrationForm);
 AdministrationForm.ShowModal;
 AdministrationForm.Free;
end;

end.
