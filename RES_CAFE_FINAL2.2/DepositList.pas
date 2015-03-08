unit DepositList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, Grids, DBGrids, ExtCtrls, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TDepositListForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    DateCheckBox: TCheckBox;
    DateEdit1: TMaskEdit;
    Label1: TLabel;
    DateEdit2: TMaskEdit;
    OperatorCheckBox: TCheckBox;
    Label2: TLabel;
    TotalDepositEdit: TStaticText;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    QueryVIPNo: TIntegerField;
    QueryDepositDate: TDateTimeField;
    QueryAmount: TFloatField;
    QueryPaymentMethod: TStringField;
    QueryMachineID: TStringField;
    QueryOpName: TStringField;
    QueryID: TIntegerField;
    QueryVIPName: TStringField;
    VIPCheckBox: TCheckBox;
    VIPNoEdit: TStaticText;
    VIPNameEdit: TStaticText;
    OperatorEdit: TStaticText;
    QueryPaidAmount: TFloatField;
    QueryBalance: TFloatField;
    Label3: TLabel;
    Label4: TLabel;
    PaidAmountEdit: TStaticText;
    BalanceEdit: TStaticText;
    procedure OpenQuery;
    procedure CalcAmount;
    procedure DateCheckBoxClick(Sender: TObject);
    procedure OperatorCheckBoxClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure OperatorEditClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DepositListPro;
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure VIPCheckBoxClick(Sender: TObject);
    procedure VIPNoEditClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DepositListForm: TDepositListForm;

implementation

uses DatePanel, StaffList, MainMenu, UtilUnit, DataUnit, PrintCashPayOutReport,
     EditCashPayOut, MessageBox, PrintDepositList, EditDeposit, VIPList;

{$R *.DFM}

procedure TDepositListForm.OpenQuery;
var
 SQLStr, Temp: string;
begin
 SQLStr := 'Select DepositTable.VIPNo, DepositDate, Amount, PaymentMethod, ' +
           'DepositTable.MachineID, DepositTable.OpName, ID, VIPName, ' +
           'Sum(RecvAcct.PaidAmount) As PaidAmount ' +
           'From VIPTable Join DepositTable On DepositTable.VIPNo=VIPTable.VIPNo ' +
           'Left Join RecvAcct On DepositID=ID ';
 Temp := '';
 if DateCheckBox.Checked then
    Temp := ' Where DepositDate>=' + ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0')) +
            ' and DepositDate <=' + ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59'));
 if OperatorCheckBox.Checked then
    begin
     if Temp = '' then Temp := 'Where ' else Temp := Temp + ' and ';
     Temp := Temp + ' OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Caption) + Chr(39);
    end;
 if VIPCheckBox.Checked and (VIPNoEdit.Caption <> '') then
    begin
     if Temp = '' then Temp := 'Where ' else Temp := Temp + ' and ';
     Temp := Temp + ' DepositTable.VIPNo=' + VIPNoEdit.Caption;
    end;
 if Temp <> '' then SQLStr := SQLStr + Temp;
 SQLStr := SQLStr + 'Group By DepositTable.VIPNo, DepositDate, Amount, PaymentMethod, ' +
                    'DepositTable.MachineID, DepositTable.OpName, ID, VIPName ' +
                    ' Order By DepositTable.DepositDate';
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

procedure TDepositListForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  FieldByName('Balance').AsFloat := FieldByName('Amount').AsFloat - FieldByName('PaidAmount').AsFloat;
end;

procedure TDepositListForm.CalcAmount;
var
 TotalDeposit, PaidAmount: double;
begin
 TotalDeposit := 0; PaidAmount := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     TotalDeposit := TotalDeposit + FieldByName('Amount').AsFloat;
     PaidAmount := PaidAmount + FieldByName('PaidAmount').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;
 TotalDepositEdit.Caption := FormatCurrency(TotalDeposit) + ' ';
 PaidAmountEdit.Caption := FormatCurrency(PaidAmount) + ' ';
 BalanceEdit.Caption := FormatCurrency(TotalDeposit - PaidAmount) + ' ';
end;

procedure TDepositListForm.DateCheckBoxClick(Sender: TObject);
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

procedure TDepositListForm.OperatorCheckBoxClick(Sender: TObject);
begin
 if OperatorCheckBox.Checked then
    OperatorEdit.Enabled := True
   else
    begin
     OperatorEdit.Caption := '';
     OperatorEdit.Enabled := False;
    end;
end;

procedure TDepositListForm.VIPCheckBoxClick(Sender: TObject);
begin
 if VIPCheckBox.Checked then
    VIPNoEdit.Enabled := True
   else
    begin
     VIPNoEdit.Caption := '';
     VIPNoEdit.Enabled := False;
     VIPNameEdit.Caption := '';
    end;
end;

procedure TDepositListForm.DateEditClick(Sender: TObject);
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

procedure TDepositListForm.OperatorEditClick(Sender: TObject);
var
 StaffName: string;
begin
 if StaffListForm.ListStaffPro(StaffName) then
    OperatorEdit.Caption := StaffName;
end;

procedure TDepositListForm.VIPNoEditClick(Sender: TObject);
var
 VIPNo: integer;
 VIPDiscountRate: double;
 VIPName: string;
begin
 if VIPListForm.VIPListPro(VIPNo) then
    begin
     if DataForm.ReadVIPInformation(VIPNo, VIPName, VIPDiscountRate) then
        begin
         VIPNoEdit.Caption := Format('%8.8d', [VIPNo]);
         VIPNameEdit.Caption := VIPName;
        end
    end
end;

procedure TDepositListForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
 CalcAmount;
end;

procedure TDepositListForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TDepositListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TDepositListForm.EditButtonClick(Sender: TObject);
var
 ID: integer;
begin
 if Supervisor then
    with Query do
     if Active and (RecordCount > 0) then
        begin
         ID := FieldByName('ID').AsInteger;
         if EditDepositForm.EditDepositPro(ID) then
            begin
             SearchButtonClick(Sender);
             Locate('ID', ID, [loPartialKey]);
            end;
        end
   else
    MessageBoxForm.MessagePro('You have not been authorised to edit deposit record.', sErrorMsg);
end;

procedure TDepositListForm.DeleteButtonClick(Sender: TObject);
var
 SQLStr: string;
 ID: integer;
begin
 if Supervisor then
    begin
     with Query do
      if Active and (RecordCount > 0) and
         (MessageBoxForm.MessagePro('Are you sure you want to delete this record?', sConfirmMsg) = mrYes)
         then
         begin
          ID := FieldByName('ID').AsInteger;
          SQLStr := 'Delete From DepositTable Where ID=' + IntToStr(ID);
          if DataForm.ExecQueryPro(SQLStr) then
             begin
              SearchButtonClick(Sender);
              if ID > 0 then ID := ID - 1;
              Locate('ID', ID, [loPartialKey]);
             end;
         end;
    end
   else
    MessageBoxForm.MessagePro('You have not been authorised to delete deposit record.', sErrorMsg);
end;

procedure TDepositListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
 DepositListForm := NIL;
end;

procedure TDepositListForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 DateCheckBox.Checked := False;
 DateEdit1.Enabled := False;
 DateEdit2.Enabled := False;
 OperatorCheckBox.Checked := False;
 OperatorEdit.Enabled := False;
 VIPCheckBox.Checked := False;
 VIPNoEdit.Enabled := False;
 EditButton.Enabled := Supervisor;
 DeleteButton.Enabled := Supervisor;
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryBalance.DisplayFormat := sCurrency + ',0.#0';
end;

procedure TDepositListForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PrintDepositListForm.PrintDepositListPro;
end;

procedure TDepositListForm.DepositListPro;
begin
  Application.CreateForm(TDepositListForm, DepositListForm);
  DepositListForm.ShowModal;
  DepositListForm.Free;
end;

end.
