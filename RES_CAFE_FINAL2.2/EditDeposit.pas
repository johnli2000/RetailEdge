unit EditDeposit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, UtilUnit, DB, ADODB, bsSkinCtrls, MainMenu,
  BusinessSkinForm, XiButton;

type
  TEditDepositForm = class(TForm)
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
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
    procedure OpenQuery(SQLStr: string);
    procedure DepositAmountEditClick(Sender: TObject);
    procedure PrintDocument;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DescriptionEditClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure VIPNoButtonClick(Sender: TObject);
    procedure MethodButtonClick(Sender: TObject);
    function  EditDepositPro(ID: integer): boolean;
  private { Private declarations }
     ID: integer;
     ReturnFlag: Boolean;
     DepositDate: TDateTime;
  public
    { Public declarations }
  end;

var
 EditDepositForm: TEditDepositForm;

implementation

uses NumPad, DataUnit, Keyboard, VIPList, PaymentSelect, MessageBox;

{$R *.DFM}

procedure TEditDepositForm.OpenQuery(SQLStr: string);
begin
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

procedure TEditDepositForm.VIPNoButtonClick(Sender: TObject);
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

procedure TEditDepositForm.DepositAmountEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Deposit Amount', 0) then
    DepositAmountEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
end;

procedure TEditDepositForm.MethodButtonClick(Sender: TObject);
var
 PaymentMethod: string;
 SurchargeRate: double;
 LinkToEFTPOS: boolean;
begin
 if PaymentSelectForm.PaymentSelectPro(PaymentMethod, SurchargeRate, LinkToEFTPOS) then
    MethodEdit.Caption := PaymentMethod;
end;

procedure TEditDepositForm.DescriptionEditClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    DescriptionEdit.Caption := Str;
end;

procedure TEditDepositForm.PrintDocument;
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

 PrintStr := 'Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', DepositDate);
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

procedure TEditDepositForm.ConfirmButtonClick(Sender: TObject);
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
 DateTemp := ConvertDateTime(DepositDate);
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
    try
     SQLStr := 'Delete DepositTable Where ID =' + IntToStr(ID);
     Flag := DataForm.ExecQueryPro(SQLStr);
     if Flag then
        begin
         SQLStr := 'Insert Into DepositTable(VIPNo, DepositDate, Amount, PaymentMethod, ' +
                   'Notes, OpName, MachineID, ID) ' +
                   'Values(' + VIPNo + ',' + DateTemp + ',' + FloatToStr(DepositAmount) + ',' +
                   PaymentMethod + ',' + Description + ',' + Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' +
                   MachineIDTemp + ',' + IntToStr(ID) + ')';
         Flag := DataForm.ExecQueryPro(SQLStr);
        end;
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
          ReturnFlag := True;
          Close;
         end
       else
        DataForm.RollBack;
     end;
end;

procedure TEditDepositForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TEditDepositForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TEditDepositForm.FormShow(Sender: TObject);
var
 SQLStr: string;
begin
 Width := BackPanel.Width + 28;
 Height := CancelButton.Top + 86;
 SQLStr := 'Select DepositTable.VIPNo, DepositDate, Amount, PaymentMethod, ' +
           'MachineID, OpName, DepositTable.Notes, ID, VIPName ' +
           'From DepositTable, VIPTable ' +
           'Where VIPTable.VIPNo = DepositTable.VIPNo and ID=' + IntToStr(ID);
 OpenQuery(SQLStr);
 with Query do
  begin
   VIPNoEdit.Caption := Format('%8.8d', [FieldByName('VIPNo').AsInteger]);
   VIPNameEdit.Caption := FieldByName('VIPName').AsString;
   DepositDate := FieldByName('DepositDate').AsDateTime;
   DateEdit.Caption := FormatDateTime('dd/mm/yyyy  hh:mm:ss', DepositDate);
   DepositAmountEdit.Caption := Format('%4.2f', [FieldByName('Amount').AsFloat]);
   MethodEdit.Caption := FieldByName('PaymentMethod').AsString;
   DescriptionEdit.Caption := FieldByName('Notes').AsString;
   OperatorEdit.Caption := FieldByName('OpName').AsString;
   Close;
  end;
 VIPNoEdit.SetFocus;
end;

function TEditDepositForm.EditDepositPro(ID: integer): boolean;
begin
 Application.CreateForm(TEditDepositForm, EditDepositForm);
 EditDepositForm.ID := ID;
 EditDepositForm.ShowModal;
 Result := EditDepositForm.ReturnFlag;
 EditDepositForm.Free;
end;

end.
