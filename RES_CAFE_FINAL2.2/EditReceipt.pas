unit EditReceipt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ExtCtrls, UtilUnit, Mask, Db, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TEditReceiptForm = class(TForm)
    Label1: TLabel;
    PaymentEdit: TEdit;
    Label4: TLabel;
    Label11: TLabel;
    OrderNoEdit: TEdit;
    Query: TADOQuery;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    TotalPanel: TbsSkinPanel;
    DataPanel: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    DateEdit: TMaskEdit;
    Label2: TLabel;
    TimeEdit: TMaskEdit;
    Label3: TLabel;
    MachineIDEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    OperatorEdit: TEdit;
    PaymentMethodEdit: TEdit;
    procedure OpenQuery(SQLStr: string);
    procedure AssignData;
    procedure PaymentEditEnter(Sender: TObject);
    procedure PaymentEditExit(Sender: TObject);
    procedure PaymentEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    function  SaveAccountData: boolean;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaymentEditKeyPress(Sender: TObject; var Key: Char);
    function  PaymentEditPro(OrderNo: string): boolean;
    procedure DateEditClick(Sender: TObject);
    procedure TimeEditClick(Sender: TObject);
    procedure PaymentMethodEditClick(Sender: TObject);
    procedure MachineIDEditClick(Sender: TObject);
    procedure OperatorEditClick(Sender: TObject);
    procedure PaymentMethodEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MachineIDEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OperatorEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private { Private declarations }
    ReturnFlag: boolean;
    OrderNo: string;
    IDNo: integer;
  public
    { Public declarations }
  end;

var
  EditReceiptForm: TEditReceiptForm;

implementation

uses DataUnit, ReceiptList, MainMenu, DatePanel, TimePanel, PaymentSelect,
  MachineIDCollect, StaffList, MachineIDSelect;

{$R *.DFM}

procedure TEditReceiptForm.OpenQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TEditReceiptForm.AssignData;
begin
 with ReceiptListForm.Query do
  begin
   OrderNo := FieldByName('OrderNo').AsString;
   OrderNoEdit.Text := OrderNo;
   DateEdit.Text := FormatDateTime('dd/mm/yyyy', FieldByName('AccountDate').AsDateTime);
   TimeEdit.Text := FormatDateTime('hh:mm', FieldByName('AccountDate').AsDateTime);
   PaymentEdit.Text := Format('%12.2f', [FieldByName('PaidAmount').AsFloat]);
   MachineIDEdit.Text := FieldByName('MachineID').AsString;
   PaymentMethodEdit.Text := FieldByName('PayBy').AsString;
   OperatorEdit.Text := FieldByName('OpName').AsString;
   IDNo := FieldByName('IDNo').Asinteger;
  end;
end;

procedure TEditReceiptForm.PaymentEditEnter(Sender: TObject);
begin
 if PaymentEdit.Text <> '' then
    PaymentEdit.Text := FloatToStr(StrToFloat(PaymentEdit.Text));
 PaymentEdit.SelectAll;
end;

procedure TEditReceiptForm.PaymentEditExit(Sender: TObject);
begin
 if PaymentEdit.Text = '' then Exit;
 if Not CheckNum(PaymentEdit.Text, 12, 9999999.99, -999999.99, 'F') then
    PaymentEdit.SetFocus
   else
    PaymentEdit.Text := Format('%12.2f', [StrToFloat(PaymentEdit.Text)]);
end;

procedure TEditReceiptForm.PaymentEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
    MachineIDEdit.SetFocus;
end;

procedure TEditReceiptForm.PaymentEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Not (Key In ['0'..'9', '.', '-', CHR(8)]) then
    Key := Chr(0);
end;

procedure TEditReceiptForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TEditReceiptForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TEditReceiptForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TEditReceiptForm.PaymentMethodEditClick(Sender: TObject);
var
 PaymentMethod: string;
 LinkToEFTPOS: boolean;
 BankChargeRate: double;
begin
 if PaymentSelectForm.PaymentSelectPro(PaymentMethod, BankChargeRate, LinkToEFTPOS) then
    PaymentMethodEdit.Text := PaymentMethod;
end;

procedure TEditReceiptForm.MachineIDEditClick(Sender: TObject);
var
 MachineName: string;
begin
 if MachineIDSelectForm.MachineIDSelectPro(MachineName) then
    MachineIDEdit.Text := MachineName;
end;

procedure TEditReceiptForm.OperatorEditClick(Sender: TObject);
var
 StaffName: string;
begin
 if StaffListForm.ListStaffPro(StaffName) then
    OperatorEdit.Text := StaffName;
end;

procedure TEditReceiptForm.PaymentMethodEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PaymentEdit.SetFocus;
end;

procedure TEditReceiptForm.MachineIDEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then OperatorEdit.SetFocus;
end;

procedure TEditReceiptForm.OperatorEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ConfirmButton.SetFocus;
end;

procedure TEditReceiptForm.DateEditClick(Sender: TObject);
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

procedure TEditReceiptForm.TimeEditClick(Sender: TObject);
var
 TimeStr: string;
begin
 with Sender As TMaskEdit do
  begin
   TimeStr := Text;
   if TimeForm.ReadTimePro(TimeStr) then
      Text := TimeStr;
  end;
end;

function TEditReceiptForm.SaveAccountData: boolean;
var
 SQLStr, Amount, DateTemp: string;
begin
 if PaymentEdit.Text <> '' then
    Amount := Format('%4.2f', [StrToFloat(PaymentEdit.Text)])
   else
    Amount := '0.0';
 DateTemp := ConvertDateTime(TransferDate(DateEdit.Text) + StrToTime(TimeEdit.Text));
 SQLStr := 'Update RecvAcct Set PayBy=' + Chr(39) + CheckQuotes(PaymentMethodEdit.Text) + Chr(39) +
           ', PaidAmount=' + Amount +
           ', OpName=' + Chr(39) + CheckQuotes(OperatorEdit.Text) + Chr(39) +
           ', AccountDate=' + DateTemp +
           ', MachineID=' + Chr(39) + MachineIDEdit.Text + Chr(39) +
           ' Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           ' and IDNo=' + IntToStr(IDNo);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    Result := DataForm.UpdateOrderPayment(OrderNo, False);
end;

procedure TEditReceiptForm.ConfirmButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 if Not DataForm.BeginTransaction then Exit;
 Flag := True;
 try
  Flag := SaveAccountData;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      ReturnFlag := True;
      Close;
     end
    else
     begin
      DataForm.RollBack;
     end;
 end;
end;

procedure TEditReceiptForm.FormShow(Sender: TObject);
begin
 AssignData;
end;

function TEditReceiptForm.PaymentEditPro(OrderNo: string): boolean;
begin
 Application.CreateForm(TEditReceiptForm, EditReceiptForm);
 EditReceiptForm.ShowModal;
 Result := EditReceiptForm.ReturnFlag;
 EditReceiptForm.Free;
end;

end.
