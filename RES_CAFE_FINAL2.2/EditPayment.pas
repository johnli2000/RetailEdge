unit EditPayment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ExtCtrls, UtilUnit, Mask, MainMenu,
  BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TEditPaymentForm = class(TForm)
    Label1: TLabel;
    NotesEdit: TEdit;
    Label4: TLabel;
    DateEdit: TMaskEdit;
    Label2: TLabel;
    PaymentEdit: TEdit;
    PayByEdit: TEdit;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DataPanel: TbsSkinPanel;
    TotalPanel: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure NotesEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CancelButtonClick(Sender: TObject);
    function  SaveAccountData: boolean;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NotesEditKeyPress(Sender: TObject; var Key: Char);
    function  PaymentEditPro: boolean;
    procedure DateEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PaymentEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PaymentEditEnter(Sender: TObject);
    procedure PaymentEditExit(Sender: TObject);
    procedure PaymentEditKeyPress(Sender: TObject; var Key: Char);
    procedure PayByEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private { Private declarations }
    ReturnFlag, LinkToEFTPOSFlag: boolean;
    SerialNo, ID: integer;
  public
    { Public declarations }
  end;

var
  EditPaymentForm: TEditPaymentForm;

implementation

uses DataUnit,  PaymentSelect, MessageBox;

{$R *.DFM}

procedure TEditPaymentForm.DateEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then PaymentEdit.setFocus;
end;

procedure TEditPaymentForm.PaymentEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if key = VK_RETURN then PayByEdit.SetFocus;
end;

procedure TEditPaymentForm.PaymentEditEnter(Sender: TObject);
begin
 if PaymentEdit.Text <> '' then
    PaymentEdit.Text := FloatToStr(StrToFloat(PaymentEdit.Text));
 PaymentEdit.SelectAll;
end;

procedure TEditPaymentForm.PaymentEditExit(Sender: TObject);
begin
 if PaymentEdit.Text = '' then Exit;
 if Not CheckNum(PaymentEdit.Text, 12, 9999999.99, -999999.99, 'F') then
    PaymentEdit.SetFocus
   else
    PaymentEdit.Text := Format('%12.2f', [StrToFloat(PaymentEdit.Text)]);
end;

procedure TEditPaymentForm.PaymentEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Not (Key In ['0'..'9', '.', '-', CHR(8)]) then
    Key := Chr(0);
end;

procedure TEditPaymentForm.PayByEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
 Temp: string;
 A: double;
begin
 case Key of
  VK_RETURN: NotesEdit.SetFocus;
  VK_F5:     if PaymentSelectForm.PaymentSelectPro(Temp, A, LinkToEFTPOSFlag) then
                PayByEdit.Text := Temp;
 end;
end;

procedure TEditPaymentForm.NotesEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ConfirmButton.SetFocus;
end;

procedure TEditPaymentForm.NotesEditKeyPress(Sender: TObject; var Key: Char);
begin
 if Not (Key In ['0'..'9', '.', '-', CHR(8)]) then
    Key := Chr(0);
end;

procedure TEditPaymentForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TEditPaymentForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TEditPaymentForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

function TEditPaymentForm.SaveAccountData: boolean;
var
 SQLStr, Amount, Notes: string;
begin
 if PaymentEdit.Text <> '' then
    Amount := Format('%4.2f', [StrToFloat(PaymentEdit.Text)])
   else
    Amount := '0.0';
 if NotesEdit.Text <> '' then
    Notes := Chr(39) + CheckQuotes(NotesEdit.Text) + Chr(39)
   else
    Notes := 'Null';
 SQLStr := 'Update ExpAcct Set AcctDate=' +
           ConvertDateTime(TransferDate(DateEdit.Text)) + ',' +
           'PayBy=' + Chr(39) + CheckQuotes(PayByEdit.Text) + Chr(39) + ',' +
           'PaidAmount=' + Amount + ', Notes=' + Notes +
           ' Where SerialNo=' + IntToStr(SerialNo) +  ' and ID=' + IntToStr(ID);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    Result := DataForm.UpdateExpensesPayment(SerialNo);
end;

procedure TEditPaymentForm.ConfirmButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 if PayByEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Pay Method is invalid!', sErrorMsg);
     Exit;
    end;
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

procedure TEditPaymentForm.FormShow(Sender: TObject);
begin
 Width := TotalPanel.Width + 28;
 Height := CancelButton.Top + 86;
 {with ExpensePaymentDetailForm.Query do
  begin
   SerialNo := FieldByName('SerialNo').AsInteger;
   ID := FieldByName('ID').AsInteger;
   DateEdit.Text := FormatDateTime('dd/mm/yyyy', FieldByName('AcctDate').AsDateTime);
   PaymentEdit.Text := Format('%12.2f', [FieldByName('PaidAmount').AsFloat]);
   PaybyEdit.Text := FieldByName('PayBy').AsString;
   NotesEdit.Text := FieldByName('Notes').AsString;
  end;  }
end;

function TEditPaymentForm.PaymentEditPro: boolean;
begin
 Application.CreateForm(TEditPaymentForm, EditPaymentForm);
 EditPaymentForm.ShowModal;
 Result := EditPaymentForm.ReturnFlag;
 EditPaymentForm.Free;
end;

end.
