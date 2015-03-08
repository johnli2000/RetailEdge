unit CashFloatList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, Grids, DBGrids, ExtCtrls, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TCashFloatListForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    DateCheckBox: TCheckBox;
    DateEdit1: TMaskEdit;
    Label1: TLabel;
    DateEdit2: TMaskEdit;
    OperatorCheckBox: TCheckBox;
    OperatorEdit: TEdit;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    QueryOpDate: TDateTimeField;
    QueryCashIn: TFloatField;
    QueryCashOut: TFloatField;
    QueryOpName: TStringField;
    QueryMachineID: TStringField;
    QueryCashFloatIn: TFloatField;
    QueryCashFloatOut: TFloatField;
    MachineIDCheckBox: TCheckBox;
    MachineIDEdit: TEdit;
    QueryID: TIntegerField;
    QueryDescription: TStringField;
    procedure OpenQuery;
    procedure DateCheckBoxClick(Sender: TObject);
    procedure OperatorCheckBoxClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure OperatorEditClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure MachineIDCheckBoxClick(Sender: TObject);
    procedure MachineIDEditClick(Sender: TObject);
    procedure CashFloatListPro;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CashFloatListForm: TCashFloatListForm;

implementation

uses DatePanel, StaffList, MainMenu, UtilUnit, DataUnit, PrintCashPayOutReport,
     EditCashPayOut, MessageBox, MachineIDSelect, EditCashFloat,
  PrintCashFloatList;

{$R *.DFM}

procedure TCashFloatListForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From CashFloatTable ';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + 'Where OpDate>=' +
    ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0')) +
    ' and OpDate<=' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59'));
 if OperatorCheckBox.Checked then
    begin
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' and '
       else
        SQLStr := SQLStr + ' Where ';
     SQLStr := SQLStr + 'OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39);
    end;
 if MachineIDCheckBox.Checked then
    begin
     if DateCheckBox.Checked or OperatorCheckBox.Checked then
        SQLStr := SQLStr + ' and '
       else
        SQLStr := SQLStr + ' Where ';
     SQLStr := SQLStr + 'MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39);
    end;
 SQLStr := SQLStr + ' Order By OpDate';
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;

procedure TCashFloatListForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  if ABS(FieldByName('CashIn').AsFloat) >= 0.01 then
     FieldByName('CashFloatIn').AsFloat := FieldByName('CashIn').AsFloat
    else
     FieldByName('CashFloatOut').AsFloat := FieldByName('CashOut').AsFloat
end;

procedure TCashFloatListForm.DateCheckBoxClick(Sender: TObject);
begin
 if DateCheckBox.Checked then
    begin
     DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
     DateEdit2.Text := DateEdit1.Text;
     DateEdit1.Enabled := True;
     DateEdit2.Enabled := True;
    end
   else
    begin
     DateEdit1.Text := '';
     DateEdit2.Text := '';
     DateEdit1.Enabled := False;
     DateEdit2.Enabled := False;
    end
end;

procedure TCashFloatListForm.OperatorCheckBoxClick(Sender: TObject);
begin
 if OperatorCheckBox.Checked then
    OperatorEdit.Enabled := True
   else
    begin
     OperatorEdit.Text := '';
     OperatorEdit.Enabled := False;
    end;
end;

procedure TCashFloatListForm.MachineIDCheckBoxClick(Sender: TObject);
begin
 if MachineIDCheckBox.Checked then
    MachineIDEdit.Enabled := True
   else
    begin
     MachineIDEdit.Text := '';
     MachineIDEdit.Enabled := False;
    end;
end;

procedure TCashFloatListForm.DateEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   DateTemp := TransferDate(Text);
   if DateForm.ReadDatePro(DateTemp) then
      Text := FormatDateTime('dd/mm/yyyy', DateTemp);
  end;
end;

procedure TCashFloatListForm.OperatorEditClick(Sender: TObject);
var
 StaffName: string;
begin
 if StaffListForm.ListStaffPro(StaffName) then
    OperatorEdit.Text := StaffName;
end;

procedure TCashFloatListForm.MachineIDEditClick(Sender: TObject);
var
 MachineName: string;
begin
 if MachineIDSelectForm.MachineIDSelectPro(MachineName) then
    MachineIDEdit.Text := MachineName;
end;

procedure TCashFloatListForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
end;

procedure TCashFloatListForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TCashFloatListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TCashFloatListForm.EditButtonClick(Sender: TObject);
var
 ID: integer;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      ID := FieldByName('ID').AsInteger;
      if EditCashFloatForm.EditCashFloatPro(ID) then
         begin
          SearchButtonClick(Sender);
          Locate('ID', ID, [loPartialKey]);
         end;
     end;
end;

procedure TCashFloatListForm.DeleteButtonClick(Sender: TObject);
var
 SQLStr: string;
 ID: integer;
begin
 with Query do
  if Active and (RecordCount > 0) and
     (MessageBoxForm.MessagePro('Are you sure you want to delete this record?', sConfirmMsg) = mrYes)
     then
     begin
      ID := FieldByName('ID').AsInteger;
      SQLStr := 'Delete From CashFloatTable Where ID=' + IntToStr(ID);
      if DataForm.ExecQueryPro(SQLStr) then
         begin
          SearchButtonClick(Sender);
          if ID > 0 then ID := ID - 1;
          Locate('ID', ID, [loPartialKey]);
         end;
     end;
end;

procedure TCashFloatListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
 CashFloatListForm := NIL;
end;

procedure TCashFloatListForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 Top := (MainForm.ClientHeight - Height - MainForm.bsSkinMainMenuBar.Height) div 2;
 Left := (MainForm.ClientWidth - Width) div 2 ;
 DateCheckBox.Checked := False;
 DateEdit1.Enabled := False;
 DateEdit2.Enabled := False;
 OperatorCheckBox.Checked := False;
 OperatorEdit.Enabled := False;
 MachineIDCheckBox.Checked := False;
 MachineIDEdit.Enabled := False;
 EditButton.Enabled := Supervisor;
 DeleteButton.Enabled := Supervisor;
 QueryCashFloatIn.DisplayFormat := sCurrency + ',0.#0';
 QueryCashFloatOut.DisplayFormat := sCurrency + ',0.#0';
end;

procedure TCashFloatListForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PrintCashFloatListForm.PrintCashFloatListPro;
end;

procedure TCashFloatListForm.CashFloatListPro;
begin
 Application.CreateForm(TCashFloatListForm, CashFloatListForm);
 CashFloatListForm.ShowModal;
 CashFloatListForm.Free;
end;

end.
