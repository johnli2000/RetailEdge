unit MachineIDSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, UtilUnit,
  ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TMachineIDSetupForm = class(TForm)
    DBGrid: TDBGrid;
    MachineIDEdit: TEdit;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryMachineID: TStringField;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    bsSkinPanel1: TbsSkinPanel;
    EditPanel: TbsSkinPanel;
    NewButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    ExitButton: TXiButton;
    procedure OpenQuery;
    procedure SetReadStatus;
    procedure SetEditStatus;
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    function  ProcessEditCode: Boolean;
    function  ProcessNewCode: Boolean;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MachineIDEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridDblClick(Sender: TObject);
    procedure MachineIDSetupPro;
    procedure MachineIDEditDblClick(Sender: TObject);
  private { Private declarations }
   OpFlag: Integer;
   OldMachineName: String;
  public
    { Public declarations }
  end;

var
 MachineIDSetupForm: TMachineIDSetupForm;

implementation

uses DataUnit, MainMenu, MessageBox, Keyboard;

{$R *.DFM}

procedure TMachineIDSetupForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select MachineID From MachineID Order By MachineID');
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TMachineIDSetupForm.SetReadStatus;
begin
 DBGrid.Enabled := True;
 MachineIDEdit.Enabled := False;
 NewButton.Enabled := True;
 EditButton.Enabled := True;
 DeleteButton.Enabled := True;
 ExitButton.Enabled := True;
 ConfirmButton.Enabled := False;
 CancelButton.Enabled := False;
 MachineIDEdit.Text := '';
 DBGrid.SetFocus;
end;

procedure TMachineIDSetupForm.SetEditStatus;
begin
 DBGrid.Enabled := False;
 MachineIDEdit.Enabled := True;
 DeleteButton.Enabled := False;
 NewButton.Enabled := False;
 EditButton.Enabled := False;
 ExitButton.Enabled := False;
 ConfirmButton.Enabled := True;
 CancelButton.Enabled := True;
 MachineIDEdit.SetFocus;
end;

procedure TMachineIDSetupForm.DBGridDblClick(Sender: TObject);
begin
 EditButtonClick(Sender);
end;

procedure TMachineIDSetupForm.DeleteButtonClick(Sender: TObject);
var
 MachineName: string;
 Flag: boolean;
begin
 if (MessageBoxForm.MessagePro('Are you sure you want to delete this record?', sConfirmMsg) = mrNo) then
    Exit;
 MachineName := Query.FieldByName('MachineID').AsString;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := DataForm.ExecQueryPro('Delete From MachineID Where MachineID=' + Chr(39) + CheckQuotes(MachineName) + Chr(39));
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      OpenQuery;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TMachineIDSetupForm.NewButtonClick(Sender: TObject);
begin
 OpFlag := sNewStatus;
 SetEditStatus;
end;

procedure TMachineIDSetupForm.EditButtonClick(Sender: TObject);
begin
 if Query.RecordCount > 0 then
    begin
     OpFlag := sEditStatus;
     OldMachineName := Query.FieldByName('MachineID').AsString;
     MachineIDEdit.Text := OldMachineName;
     SetEditStatus;
    end;
end;

function TMachineIDSetupForm.ProcessEditCode: Boolean;
var
 RecordCount: Integer;
begin
 Result := True;
 if OldMachineName <> MachineIDEdit.Text then
    begin
     RecordCount := DataForm.CheckCodeSQLPro('Select Count(*) From MachineID where MachineID = ' +
                   Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39));
     if (RecordCount > 0) and
        (MessageBoxForm.MessagePro(MachineIDEdit.Text + ' is already exist.' +
        Chr(13) + Chr(10) + Chr(13) + Chr(10) +
        'Do you want to replace?', sConfirmMsg) = mrNo) then
        begin
         Result := False;
         Exit;
        end;
     Result := DataForm.ExecQueryPro('Delete From MachineID Where MachineID=' +
               Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39));
    end;
  if Result then
     Result := DataForm.ExecQueryPro('Delete From MachineID Where MachineID=' +
               Chr(39) + CheckQuotes(OldMachineName) + Chr(39));
  if Result then
     Result := DataForm.ExecQueryPro('INSERT INTO MachineID(MachineID) VALUES(' +
               Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39) + ')');
end;

function TMachineIDSetupForm.ProcessNewCode: boolean;
begin
 if DataForm.CheckCodeSQLPro('Select Count(*) From MachineID where MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39)) > 0 then
    begin
     MessageBoxForm.MessagePro(MachineIDEdit.Text + ' is already exist.', sErrorMsg);
     Result := False;
     Exit;
    end;
  Result := DataForm.ExecQueryPro('INSERT INTO MachineID(MachineID) VALUES(' +
            Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39) + ')');
end;

procedure TMachineIDSetupForm.ConfirmButtonClick(Sender: TObject);
var
 Flag: boolean;
 MachineName: string;
begin
 if MachineIDEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Some fields are invalid!', sErrorMsg);
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
      MachineName := MachineIDEdit.Text;
      SetReadStatus;
      OpenQuery;
      Query.Locate('MachineID', MachineName, [loPartialKey]);
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TMachineIDSetupForm.CancelButtonClick(Sender: TObject);
begin
 SetReadStatus;
end;

procedure TMachineIDSetupForm.MachineIDEditKeyPress(Sender: TObject; var Key: Char);
begin
 case Key of
  Chr(13): ConfirmButton.SetFocus;
  'a'..'z': Key := UpCase(Key);
 end;
end;

procedure TMachineIDSetupForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TMachineIDSetupForm.MachineIDEditDblClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    with Sender As TEdit do
     Text := UpperCase(Str);
end;

procedure TMachineIDSetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if ExitButton.Enabled then
    begin
     Query.Close;
     Action := caFree;
    end
   else
    Action := caNone;
end;

procedure TMachineIDSetupForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TMachineIDSetupForm.FormShow(Sender: TObject);
begin
 Width := ExitButton.Left + ExitButton.Width + 28;
 Height := EditPanel.Height + 50;
 OpenQuery;
 SetReadStatus;
end;

procedure TMachineIDSetupForm.MachineIDSetupPro;
begin
 Application.CreateForm(TMachineIDSetupForm, MachineIDSetupForm);
 MachineIDSetupForm.ShowModal;
 MachineIDSetupForm.Free;
end;

end.
