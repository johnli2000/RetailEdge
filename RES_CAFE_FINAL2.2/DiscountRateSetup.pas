unit DiscountRateSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Buttons, Mask, UtilUnit,
  ADODB, bsSkinCtrls, BusinessSkinForm, XiButton, bsSkinBoxCtrls,
  bsSkinGrids, bsDBGrids, bsSkinData;

type
  TDiscountRateSetupForm = class(TForm)
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryCode: TStringField;
    QueryDescription: TStringField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanle: TbsSkinPanel;
    EditPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    CodeEdit: TbsSkinEdit;
    bsSkinStdLabel2: TbsSkinStdLabel;
    DescriptionEdit: TbsSkinEdit;
    bsSkinPanel1: TbsSkinPanel;
    DBGrid: TDBGrid;
    NewButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    ExitButton: TXiButton;
    QueryDiscountRate: TFloatField;
    bsSkinStdLabel3: TbsSkinStdLabel;
    DiscountRateEdit: TbsSkinEdit;
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
    procedure DiscountRateSetupPro;
    procedure CodeEditKeyPress(Sender: TObject; var Key: Char);
    procedure DescriptionEditKeyPress(Sender: TObject; var Key: Char);
    procedure DiscountRateEditKeyPress(Sender: TObject; var Key: Char);
    procedure DiscountRateEditEnter(Sender: TObject);
    procedure DiscountRateEditExit(Sender: TObject);
  private { Private declarations }
   OpFlag: Integer;
   OldCode: String;
  public
    { Public declarations }
  end;

var
 DiscountRateSetupForm: TDiscountRateSetupForm;

implementation

uses DataUnit, MainMenu, MessageBox, Keyboard;

{$R *.DFM}

procedure TDiscountRateSetupForm.OpenQuery;
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add('Select * From DiscountRateTable Order By Code');
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TDiscountRateSetupForm.SetReadStatus;
begin
 DBGrid.Enabled := True;
 NewButton.Enabled := True;
 EditButton.Enabled := True;
 DeleteButton.Enabled := True;
 ExitButton.Enabled := True;
 ConfirmButton.Enabled := False;
 CancelButton.Enabled := False;
 CodeEdit.Text := '';
 DescriptionEdit.Text := '';
 DiscountRateEdit.Text := '';
 EditPanel.Enabled := False;
 DBGrid.SetFocus;
end;

procedure TDiscountRateSetupForm.SetEditStatus;
begin
 DBGrid.Enabled := False;
 EditPanel.Enabled := True;
 DeleteButton.Enabled := False;
 NewButton.Enabled := False;
 EditButton.Enabled := False;
 ExitButton.Enabled := False;
 ConfirmButton.Enabled := True;
 CancelButton.Enabled := True;
 CodeEdit.SetFocus;
end;

procedure TDiscountRateSetupForm.DBGridDblClick(Sender: TObject);
begin
 EditButtonClick(Sender);
end;

procedure TDiscountRateSetupForm.DeleteButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if (MessageBoxForm.MessagePro('Are you sure you want to delete this record?', sConfirmMsg) = mrYes) then
    begin
     Flag := False;
     if DataForm.BeginTransaction then
        try
         SQLStr := 'Delete From DiscountRateTable Where Code=' + Chr(39) + CheckQuotes(Query.FieldByName('Code').AsString) + Chr(39);
         Flag := DataForm.ExecQueryPro(SQLStr);
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
end;

procedure TDiscountRateSetupForm.NewButtonClick(Sender: TObject);
begin
 OpFlag := sNewStatus;
 SetEditStatus;
end;

procedure TDiscountRateSetupForm.EditButtonClick(Sender: TObject);
begin
 if Query.RecordCount > 0 then
    begin
     OpFlag := sEditStatus;
     OldCode := Query.FieldByName('Code').AsString;
     CodeEdit.Text := OldCode;
     DescriptionEdit.Text := Query.FieldByName('Description').AsString;
     DiscountRateEdit.Text := Format('%10.2f', [Query.FieldByName('DiscountRate').AsFloat]);
     SetEditStatus;
    end;
end;

function TDiscountRateSetupForm.ProcessEditCode: Boolean;
var
 SQLStr, DiscountRate: string;
 RecordCount: Integer;
begin
 Result := True;
 if DiscountRateEdit.Text <> '' then
    DiscountRate := DiscountRateEdit.Text
   else
    DiscountRate := '0';
 if OldCode <> CodeEdit.Text then
    begin
     SQLStr := 'Select Count(*) From DiscountRateTable where Code = ' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39);
     RecordCount := DataForm.CheckCodeSQLPro(SQLStr);
     if (RecordCount > 0) and
        (MessageBoxForm.MessagePro('Code ' + CodeEdit.Text + ' is already exist.' +
            Chr(13) + Chr(10) + Chr(13) + Chr(10) +
        'Do you want to replace?', sConfirmMsg) = mrNo) then
        begin
         Result := False;
         Exit;
        end;
     SQLStr := 'Delete From DiscountRateTable Where Code=' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
  if Result then
     begin
      SQLStr := 'Delete From DiscountRateTable Where Code=' + Chr(39) + CheckQuotes(OldCode) + Chr(39);
      Result := DataForm.ExecQueryPro(SQLStr);
     end;
  if Result then
     begin
      SQLStr := 'INSERT INTO DiscountRateTable(Code, Description, DiscountRate) ' +
                'VALUES(' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39) + ',' +
                Chr(39) + CheckQuotes(DescriptionEdit.Text) + Chr(39) + ',' +
                DiscountRateEdit.Text + ')';
      Result := DataForm.ExecQueryPro(SQLStr);
     end;
end;

function TDiscountRateSetupForm.ProcessNewCode: boolean;
var
 SQLStr, DiscountRate: string;
begin
 if DiscountRateEdit.Text <> '' then
    DiscountRate := DiscountRateEdit.Text
   else
    DiscountRate := '0';
 if DataForm.CheckCodeSQLPro('Select Count(*) From DiscountRateTable where Code=' +
          Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39)) > 0 then
    begin
     MessageBoxForm.MessagePro(CodeEdit.Text + ' is already exist.', sErrorMsg);
     Result := False;
    end
   else
    begin
      SQLStr := 'INSERT INTO DiscountRateTable(Code, Description, DiscountRate) ' +
                'VALUES(' + Chr(39) + CheckQuotes(CodeEdit.Text) + Chr(39) + ',' +
                Chr(39) + CheckQuotes(DescriptionEdit.Text) + Chr(39) + ',' +
                DiscountRateEdit.Text + ')';
      Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

procedure TDiscountRateSetupForm.ConfirmButtonClick(Sender: TObject);
var
 Flag: boolean;
 Code: string;
begin
 if CodeEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Code is invalid!', sErrorMsg);
     Exit;
    end;
 if DescriptionEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Description is invalid!', sErrorMsg);
     Exit;
    end;
 if DiscountRateEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Discount Rate is invalid!', sErrorMsg);
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
      Code := CodeEdit.Text;
      SetReadStatus;
      OpenQuery;
      Query.Locate('Code', Code, [loPartialKey]);
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TDiscountRateSetupForm.CancelButtonClick(Sender: TObject);
begin
 SetReadStatus;
end;

procedure TDiscountRateSetupForm.CodeEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then DescriptionEdit.SetFocus
    else
     if Not (Key in ['0'..'9', Chr(8)]) then Key := Chr(0);
end;

procedure TDiscountRateSetupForm.DescriptionEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then DiscountRateEdit.SetFocus;
end;

procedure TDiscountRateSetupForm.DiscountRateEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then ConfirmButton.SetFocus;
end;

procedure TDiscountRateSetupForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TDiscountRateSetupForm.DiscountRateEditEnter(Sender: TObject);
begin
 if DiscountRateEdit.Text <> '' then
    DiscountRateEdit.Text := FloatToStr(StrToFloat(DiscountRateEdit.Text));
 DiscountRateEdit.SelectAll;
end;

procedure TDiscountRateSetupForm.DiscountRateEditExit(Sender: TObject);
begin
 if (DiscountRateEdit.Text <> '') and CheckNum(DiscountRateEdit.Text, 5, 100.01, 0, 'F') then
    DiscountRateEdit.Text := Format('%10.2f', [StrToFloat(DiscountRateEdit.Text)])
   else
    begin
     DiscountRateEdit.Text := '0';
     DiscountRateEdit.SetFocus;
    end;
end;

procedure TDiscountRateSetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if ExitButton.Enabled then
    begin
     Query.Close;
     Action := caFree;
    end
end;

procedure TDiscountRateSetupForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TDiscountRateSetupForm.FormShow(Sender: TObject);
begin
 OpenQuery;
 SetReadStatus;
 Top := GetSystemMetrics(SM_CYMENU) * 2 + (MainForm.ClientHeight - Height) div 2;
 Left := (GetSystemMetrics(SM_CXSCREEN) - Width) div 2;
end;

procedure TDiscountRateSetupForm.DiscountRateSetupPro;
begin
 Application.CreateForm(TDiscountRateSetupForm, DiscountRateSetupForm);
 DiscountRateSetupForm.ShowModal;
 DiscountRateSetupForm.Free;
end;

end.
