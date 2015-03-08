unit ItemGroupSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, UtilUnit,
  ADODB, bsSkinCtrls, BusinessSkinForm, bsSkinBoxCtrls, XiButton;

type
  TItemGroupSetupForm = class(TForm)
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryGroupName: TStringField;
    DBGrid: TDBGrid;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    EditPanel: TbsSkinPanel;
    WorkPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    DescriptionEdit: TbsSkinEdit;
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
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridDblClick(Sender: TObject);
    procedure ItemGroupSetupPro;
    procedure DescriptionEditKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }
   OpFlag: Integer;
   OldGroupName: String;
  public
    { Public declarations }
  end;

var
 ItemGroupSetupForm: TItemGroupSetupForm;

implementation

uses DataUnit, MainMenu, MessageBox, Keyboard;

{$R *.DFM}

procedure TItemGroupSetupForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From ItemGroupTable Order By GroupName');
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TItemGroupSetupForm.SetReadStatus;
begin
 DBGrid.Enabled := True;
 NewButton.Enabled := True;
 EditButton.Enabled := True;
 DeleteButton.Enabled := True;
 ExitButton.Enabled := True;
 ConfirmButton.Enabled := False;
 CancelButton.Enabled := False;
 DescriptionEdit.Text := '';
 EditPanel.Enabled := False;
 DBGrid.SetFocus;
end;

procedure TItemGroupSetupForm.SetEditStatus;
begin
 DBGrid.Enabled := False;
 EditPanel.Enabled := True;
 DeleteButton.Enabled := False;
 NewButton.Enabled := False;
 EditButton.Enabled := False;
 ExitButton.Enabled := False;
 ConfirmButton.Enabled := True;
 CancelButton.Enabled := True;
 DescriptionEdit.SetFocus;
end;

procedure TItemGroupSetupForm.DBGridDblClick(Sender: TObject);
begin
 EditButtonClick(Sender);
end;

procedure TItemGroupSetupForm.DeleteButtonClick(Sender: TObject);
var
 SQLStr, GroupName: string;
 Flag: boolean;
begin
 if (MessageBoxForm.MessagePro('Are you sure you want to delete this record?', sConfirmMsg) = mrNo) then
    Exit;
 GroupName := Query.FieldByName('GroupName').AsString;
 SQLStr := 'Select Count(*) From MenuItem Where ItemGroup=' + Chr(39) + CheckQuotes(GroupName) + Chr(39);
 if DataForm.CheckCodeSQLPro(SQLStr) > 0 then
    begin
     MessageBoxForm.MessagePro('This item can not be delete' +
                               Chr(13) + Chr(10) + Chr(13) + Chr(10) +
                               'that is used for menu item database.', sErrorMsg);
     Exit;
    end;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := DataForm.ExecQueryPro('Delete From ItemGroupTable Where GroupName=' + Chr(39) + CheckQuotes(GroupName) + Chr(39));
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

procedure TItemGroupSetupForm.NewButtonClick(Sender: TObject);
begin
 OpFlag := sNewStatus;
 SetEditStatus;
end;

procedure TItemGroupSetupForm.EditButtonClick(Sender: TObject);
begin
 if Query.RecordCount > 0 then
    begin
     OpFlag := sEditStatus;
     OldGroupName := Query.FieldByName('GroupName').AsString;
     DescriptionEdit.Text := Query.FieldByName('GroupName').AsString;
     SetEditStatus;
    end;
end;

function TItemGroupSetupForm.ProcessEditCode: Boolean;
var
 SQLStr: string;
 RecordCount: Integer;
begin
 Result := True;
 if OldGroupName <> DescriptionEdit.Text then
    begin
     SQLStr := 'Select Count(*) From ItemGroupTable where GroupName = ' + Chr(39) + CheckQuotes(DescriptionEdit.Text) + Chr(39);
     RecordCount := DataForm.CheckCodeSQLPro(SQLStr);
     if (RecordCount > 0) and
        (MessageBoxForm.MessagePro('Group Name: ' + DescriptionEdit.Text + ' is already exist.' +
            Chr(13) + Chr(10) + Chr(13) + Chr(10) +
        'Do you want to replace?', sConfirmMsg) = mrNo) then
        begin
         Result := False;
         Exit;
        end;
     SQLStr := 'Delete From ItemGroupTable Where GroupName=' + Chr(39) + CheckQuotes(DescriptionEdit.Text) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
  if Result then
     begin
      SQLStr := 'Delete From ItemGroupTable Where GroupName=' + Chr(39) + CheckQuotes(OldGroupName) + Chr(39);
      Result := DataForm.ExecQueryPro(SQLStr);
     end;
  if Result then
     begin
      SQLStr := 'INSERT INTO ItemGroupTable(GroupName) ' +
                'VALUES(' + Chr(39) + CheckQuotes(DescriptionEdit.Text) + Chr(39) + ')';
      Result := DataForm.ExecQueryPro(SQLStr);
     end;
  if Result then
     begin
      SQLStr := 'Update MenuItem Set ItemGroup=' + Chr(39) + CheckQuotes(DescriptionEdit.Text) + Chr(39) + ' ' +
                'Where ItemGroup=' + Chr(39) + CheckQuotes(OldGroupName) + Chr(39);
      Result := DataForm.ExecQueryPro(SQLStr);
     end;
end;

function TItemGroupSetupForm.ProcessNewCode: boolean;
begin
 if DataForm.CheckCodeSQLPro('Select Count(*) From ItemGroupTable where GroupName=' +
          Chr(39) + CheckQuotes(DescriptionEdit.Text) + Chr(39)) > 0 then
    begin
     MessageBoxForm.MessagePro(DescriptionEdit.Text + ' is already exist.', sErrorMsg);
     Result := False;
    end
   else
    Result := DataForm.ExecQueryPro('INSERT INTO ItemGroupTable(GroupName) ' +
               'VALUES(' + Chr(39) + CheckQuotes(DescriptionEdit.Text) + Chr(39) + ')');
end;

procedure TItemGroupSetupForm.ConfirmButtonClick(Sender: TObject);
var
 Flag: boolean;
 GroupName: string;
begin
 if DescriptionEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Description is invalid!', sErrorMsg);
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
      GroupName := DescriptionEdit.Text;
      SetReadStatus;
      OpenQuery;
      Query.Locate('GroupName', GroupName, [loPartialKey]);
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TItemGroupSetupForm.CancelButtonClick(Sender: TObject);
begin
 SetReadStatus;
end;

procedure TItemGroupSetupForm.DescriptionEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then ConfirmButton.SetFocus;
end;

procedure TItemGroupSetupForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TItemGroupSetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if ExitButton.Enabled then
    begin
     Query.Close;
     Action := caFree;
     ItemGroupSetupForm := NIL;
    end
   else
    Action := caNone;
end;

procedure TItemGroupSetupForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TItemGroupSetupForm.FormShow(Sender: TObject);
begin
 OpenQuery;
 SetReadStatus;
 Top := (MainForm.ClientHeight - Height - MainForm.bsSkinMainMenuBar.Height) div 2;
 Left := (MainForm.ClientWidth - Width) div 2;
end;

procedure TItemGroupSetupForm.ItemGroupSetupPro;
begin
  Application.CreateForm(TItemGroupSetupForm, ItemGroupSetupForm);
  ItemGroupSetupForm.ShowModal;
  ItemGroupSetupForm.Free;
end;


end.
