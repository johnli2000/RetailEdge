unit EditCashPayOut;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, UtilUnit, DB, ADODB, MainMenu, bsSkinCtrls,
  BusinessSkinForm, XiButton;

type
  TEditCashPayOutForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    PaidAmountEdit: TStaticText;
    Label3: TLabel;
    DateEdit: TStaticText;
    OperatorEdit: TStaticText;
    Label4: TLabel;
    DescriptionEdit: TStaticText;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure PaidAmountEditClick(Sender: TObject);
    procedure OpenQuery;
    procedure PrintDocument;
    function  SaveData: boolean;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function  EditCashPayOutPro(ID: integer): boolean;
    procedure DescriptionEditClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }
    OpDateTime: TDateTime;
    PayoutID: integer;
    MachineIDTemp: string;
    ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
 EditCashPayOutForm: TEditCashPayOutForm;

implementation

uses NumPad, DataUnit, Keyboard;

{$R *.DFM}

procedure TEditCashPayOutForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From PayOutTable Where ID=' + IntToStr(PayoutID);
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

procedure TEditCashPayOutForm.PaidAmountEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Payment Amount', 0) then
    PaidAmountEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
end;

procedure TEditCashPayOutForm.DescriptionEditClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    DescriptionEdit.Caption := Str;
end;

procedure TEditCashPayOutForm.PrintDocument;
var
 StrTemp, PrintStr, LineStr: string;
 PaperWidth, CharCount, I: integer;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 DataForm.OpenPrinterPort(FVar.DefaultPrinter);
 PaperWidth := 40;
 LineStr := '';
 for I := 1 to 40 do LineStr := LineStr + '-';
 DataForm.SetBlackFontA;
 DataForm.PrintBillHead;
 DataForm.OutPutToPrinter(LineStr);
 DataForm.SetBlackFontB;
 StrTemp := 'Paid Out';
 PrintStr := Format('%' + IntToStr((PaperWidth - 16) div 4) + 's%s', ['', StrTemp]);
 DataForm.OutPutToPrinter(PrintStr);
 DataForm.SetBlackFontA;
 DataForm.OutPutToPrinter(LineStr);
 StrTemp := Format('CASH:    %4.2f', [0 - StrToFloat(PaidAmountEdit.Caption)]);
 CharCount := (PaperWidth - Length(StrTemp)) div 2;
 PrintStr := Format('%' + IntToStr(CharCount) + 's%s', ['', StrTemp]);
 DataForm.OutPutToPrinter(PrintStr);
 StrTemp := Format('TOTAL:   %4.2f', [0 - StrToFloat(PaidAmountEdit.Caption)]);
 CharCount := (PaperWidth - Length(StrTemp)) div 2;
 PrintStr := Format('%' + IntToStr(CharCount) + 's%s', ['', StrTemp]);
 DataForm.OutPutToPrinter(PrintStr);

 StrTemp := DescriptionEdit.Caption;
 CharCount := (PaperWidth - Length(StrTemp)) div 2;
 if CharCount < 0 then
    PrintStr := StrTemp
   else
   PrintStr := Format('%' + IntToStr(CharCount) + 's%s', ['', StrTemp]);
 DataForm.OutPutToPrinter(PrintStr);

 StrTemp := 'Operator: ' + OperatorEdit.Caption;
 CharCount := (PaperWidth - Length(StrTemp)) div 2;
 PrintStr := Format('%' + IntToStr(CharCount) + 's%s', ['', StrTemp]);
 DataForm.OutPutToPrinter(PrintStr);

 StrTemp := 'Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', OpDateTime);
 CharCount := (PaperWidth - Length(StrTemp)) div 2;
 PrintStr := Format('%' + IntToStr(CharCount) + 's%s', ['', StrTemp]);
 DataForm.OutPutToPrinter(PrintStr);

 DataForm.OutPutToPrinter(LineStr);
 DataForm.OutPutToPrinter('Print: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time));
 for I :=1 to 7 do DataForm.OutPutToPrinter(' ');
 DataForm.CutPaper;
 DataForm.ClosePrinterPort;
end;

function TEditCashPayoutForm.SaveData: boolean;
var
 SQLStr, DateTemp, Description: string;
begin
 SQLStr := 'Delete From PayOutTable Where ID=' + IntToStr(PayOutID);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     if DescriptionEdit.Caption <> '' then
        Description := Chr(39) + CheckQuotes(DescriptionEdit.Caption) + Chr(39)
       else
        Description := 'Null';
     DateTemp := ConvertDateTime(OpDateTime);
     SQLStr := 'Insert Into PayOutTable(PaymentDate, Amount, Description, OpName, MachineID, ID) ' +
               'Values(' + DateTemp + ',' + PaidAmountEdit.Caption + ',' +
               Description + ',' + Chr(39) + CheckQuotes(OperatorEdit.Caption) + Chr(39) + ',' +
               MachineIDTemp + ',' + IntToStr(PayoutID) + ')';
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
end;

procedure TEditCashPayOutForm.ConfirmButtonClick(Sender: TObject);
var
 Flag: boolean;
 Paid: double;
begin
 if PaidAmountEdit.Caption <> '' then
    Paid := StrToFloat(PaidAmountEdit.Caption)
   else
    Paid := 0;
 if Paid <> 0 then
    begin
     Flag := False;
     if Not DataForm.BeginTransaction then Exit;
     try
       Flag := SaveData;
     finally
      if Flag then
         begin
          DataForm.CommitTransaction;
          PrintDocument;
          ReturnFlag := True;
          Close;
         end
       else
        DataForm.RollBack;
     end;
    end;
end;

procedure TEditCashPayOutForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TEditCashPayOutForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TEditCashPayOutForm.FormShow(Sender: TObject);
begin
 Width := BackPanel.Width + 28;
 Height := CancelButton.Top + 86;
 OpenQuery;
 with Query do
  begin
   OpDateTime := FieldByName('PaymentDate').AsDateTime;
   DateEdit.Caption := FormatDateTime('dd/mm/yyyy  hh:mm:ss', OpDateTime);
   PaidAmountEdit.Caption := Format('%4.2f ', [FieldByName('Amount').AsFloat]);
   DescriptionEdit.Caption := FieldByName('Description').AsString;
   OperatorEdit.Caption := FieldByName('OpName').AsString;
   if FieldByName('MachineID').AsString <> '' then
      MachineIDTemp := Chr(39) + CheckQuotes(FieldByName('MachineID').AsString) + Chr(39)
     else
      MachineIDTemp := 'Null';
  end;
 PaidAmountEdit.SetFocus;
end;

function TEditCashPayOutForm.EditCashPayOutPro(ID: Integer): boolean;
begin
 Application.CreateForm(TEditCashPayOutForm, EditCashPayOutForm);
 EditCashPayoutForm.PayoutID := ID;
 EditCashPayOutForm.ShowModal;
 Result := EditCashPayOutForm.ReturnFlag;
 EditCashPayOutForm.Free;
end;

end.
