unit Deposit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, UtilUnit, DB, ADODB, bsSkinCtrls, MainMenu,
  BusinessSkinForm, XiButton;

type
  TDepositForm = class(TForm)
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    EditPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    DateEdit: TbsSkinLabel;
    OperatorEdit: TbsSkinLabel;
    DepositAmountEdit: TbsSkinLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    DescriptionEdit: TbsSkinLabel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    bsSkinStdLabel5: TbsSkinStdLabel;
    VIPNoEdit: TbsSkinLabel;
    VIPNameEdit: TbsSkinLabel;
    VIPNoButton: TbsSkinSpeedButton;
    bsSkinStdLabel6: TbsSkinStdLabel;
    MethodEdit: TbsSkinLabel;
    MethodButton: TbsSkinSpeedButton;
    DepositAmountButton: TbsSkinSpeedButton;
    DescriptionButton: TbsSkinSpeedButton;
    ReprintButton: TXiButton;
    ExitButton: TXiButton;
    function  GenerateDepositID: integer;
    procedure DepositAmountEditClick(Sender: TObject);
    procedure PrintDocument;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DescriptionEditClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure VIPNoButtonClick(Sender: TObject);
    procedure MethodButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure ReprintButtonClick(Sender: TObject);
    procedure DepositPro(VIPNo: integer);
  private { Private declarations }
    OpDateTime: TDateTime;
    VIPNo, ID: integer;
  public
    { Public declarations }
  end;

var
 DepositForm: TDepositForm;

implementation

uses NumPad, DataUnit, Keyboard, VIPList, PaymentSelect, MessageBox;

{$R *.DFM}

function TDepositForm.GenerateDepositID: Integer;
var
 SQLStr: string;
begin
 SQLStr := 'Select Max(ID) As MaxID From DepositTable';
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
    if FieldByName('MaxID').AsInteger > 0 then
       Result := FieldByName('MaxID').AsInteger + 1
      else
       Result := 1;
    Active := False;
   end;
  end;
end;

procedure TDepositForm.VIPNoButtonClick(Sender: TObject);
var
 VIPNo:  integer;
 VIPName: string;
 Temp: double;
begin
 if VIPListForm.VIPListPro(VIPNo) and DataForm.ReadVIPInformation(VIPNo, VIPName, Temp) then
    begin
     VIPNoEdit.Caption := Format('%8.8d', [VIPNo]);
     VIPNameEdit.Caption := VIPName;
    end;
end;


procedure TDepositForm.DepositAmountEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Deposit Amount', 0) then
    DepositAmountEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
end;

procedure TDepositForm.MethodButtonClick(Sender: TObject);
var
 PaymentMethod: string;
 SurchargeRate: double;
 LinkToEFTPOS: boolean;
begin
 if PaymentSelectForm.PaymentSelectPro(PaymentMethod, SurchargeRate, LinkToEFTPOS) then
    MethodEdit.Caption := PaymentMethod;
end;

procedure TDepositForm.DescriptionEditClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    DescriptionEdit.Caption := Str;
end;

procedure TDepositForm.PrintDocument;
var
 StrTemp, PrintStr, LineStr: string;
 PaperWidth, I: integer;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 LineStr := '';
 for I := 1 to 40 do LineStr := LineStr + '=';
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 DataForm.OutPutToPrinter(LineStr);
 DataForm.SetBlackFontB;
 StrTemp := 'DEPOSIT RECEIPT';
 PrintStr := Format('%' + IntToStr((PaperWidth - 30) div 4) + 's%s', ['', StrTemp]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(LineStr);

 PrintStr := 'CUSTOMER NAME: ' + VIPNameEdit.Caption;
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := 'Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', OpDateTime);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := MethodEdit.Caption + Format(': %4.2m', [StrToFloat(DepositAmountEdit.Caption)]);
 DataForm.OutPutToPrinter(PrintStr);

 PrintStr := Format('ID: #%8.8d', [ID]);
 DataForm.OutPutToPrinter(PrintStr);

 if DescriptionEdit.Caption <> '' then
    DataForm.OutPutToPrinter(DescriptionEdit.Caption);

 PrintStr := 'Operator: ' + sUserName;
 DataForm.OutPutToPrinter(PrintStr);

 DataForm.OutPutToPrinter(LineStr);
 DataForm.OutPutToPrinter('Print: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time));
 DataForm.OutPutToPrinter(' ');
 DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

procedure TDepositForm.ConfirmButtonClick(Sender: TObject);
var
 SQLStr, VIPNo, DateTemp, PaymentMethod, Description, MachineIDTemp: string;
 Flag: boolean;
 DepositAmount: double;
begin
 if VIPNoEdit.Caption = '' then
    begin
     MessageBoxForm.MessagePro('V.I.P. Number invalid.', sErrorMsg);
     Exit;
    end
   else
    VIPNo := VIPNoEdit.Caption;
 if DepositAmountEdit.Caption <> '' then
    DepositAmount := StrToFloat(DepositAmountEdit.Caption)
   else
    DepositAmount := 0;
 if DescriptionEdit.Caption <> '' then
    Description := Chr(39) + CheckQuotes(DescriptionEdit.Caption) + Chr(39)
   else
    Description := 'Null';
 if MachineID <> '' then
    MachineIDTemp := Chr(39) + CheckQuotes(MachineID) + Chr(39)
   else
    MachineIDTemp := 'Null';
 if MethodEdit.Caption <> '' then
    PaymentMethod := Chr(39) + CheckQuotes(MethodEdit.Caption) + Chr(39)
   else
    PaymentMethod := 'Null';
 DateTemp := ConvertDateTime(OpDateTime);
 ID := GenerateDepositID;
 if DepositAmount <> 0 then
    begin
     SQLStr := 'Insert Into DepositTable(VIPNo, DepositDate, Amount, ' +
               'PaymentMethod, Notes, OpName, MachineID, ID,flag) ' +
               'Values(' + VIPNo + ',' + DateTemp + ',' + FloatToStr(DepositAmount) + ',' +
               PaymentMethod + ',' + Description + ',' + Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' +
               MachineIDTemp + ',' + IntToStr(ID) + ', 0)';
     Flag := False;
     if Not DataForm.BeginTransaction then Exit;
     try
      Flag := DataForm.ExecQueryPro(SQLStr);
     finally
      if Flag then
         begin
          DataForm.CommitTransaction;
          if Not OnlyOpenDrawerForCashPayment or (Uppercase(MethodEdit.Caption) = 'CASH') then
             begin
              CurrentDrawerNumber := DefaultDrawerPortNumber;
              DataForm.OpenDrawer(True, CurrentDrawerNumber);
             end;
          PrintDocument;
          ReprintButton.Visible := True;
          ExitButton.Visible := True;
          CancelButton.Visible := False;
          ConfirmButton.Visible := False;
         end
       else
        DataForm.RollBack;
     end;
    end;
end;

procedure TDepositForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TDepositForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TDepositForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TDepositForm.ReprintButtonClick(Sender: TObject);
begin
 PrintDocument;
end;

procedure TDepositForm.FormShow(Sender: TObject);
var
 VIPName: string;
 Temp: double;
begin
 Width := EditPanel.Width + 28;
 Height := ExitButton.Top + 86;
 OpDateTime := Date + Time;
 DateEdit.Caption := FormatDateTime('dd/mm/yyyy  hh:mm:ss', OpDateTime);
 MethodEdit.Caption := 'CASH';
 if VIPNo >= 1 then
    begin
     if DataForm.ReadVIPInformation(VIPNo, VIPName, Temp) then
        begin
         VIPNoEdit.Caption := Format('%8.8d', [VIPNo]);
         VIPNameEdit.Caption := VIPName;
        end;
    end;
 DescriptionEdit.Caption := '';
 OperatorEdit.Caption := sUserName;
 VIPNoEdit.SetFocus;
 ReprintButton.Visible := False;
 ExitButton.Visible := False;
 CancelButton.Visible := True;
 ConfirmButton.Visible := True;
end;

procedure TDepositForm.DepositPro(VIPNo: integer);
begin
 Application.CreateForm(TDepositForm, DepositForm);
 DepositForm.VIPNo := VIPNo;
 DepositForm.ShowModal;
 DepositForm.Free;
end;

end.
