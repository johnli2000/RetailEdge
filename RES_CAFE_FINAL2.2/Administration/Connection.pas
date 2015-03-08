unit Connection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Administration, BusinessSkinForm, XiButton, StdCtrls, Mask,
  bsSkinBoxCtrls, bsSkinCtrls, ComObj;

type
  TConnectionForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    ConnectButton: TXiButton;
    ExitButton: TXiButton;
    InstanceComboBox: TComboBox;
    procedure ExitButtonClick(Sender: TObject);
    procedure ConnectButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function  ConnectPro: boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  GetSQLServerList: Boolean;
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

procedure TConnectionForm.ExitButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TConnectionForm.ConnectButtonClick(Sender: TObject);
begin
 if InstanceComboBox.Text = '' then
    begin
     MessageBoxForm.MessagePro('Instance is invalid.', ErrorMsg);
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
end;

procedure TConnectionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
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
