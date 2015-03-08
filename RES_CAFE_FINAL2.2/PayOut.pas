unit PayOut;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, UtilUnit, DB, ADODB, bsSkinCtrls,
  BusinessSkinForm, XiButton;

type
  TPayOutForm = class(TForm)
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    DateEdit: TbsSkinLabel;
    OperatorEdit: TbsSkinLabel;
    PaidAmountEdit: TbsSkinLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    DescriptionEdit: TbsSkinLabel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    function  GeneratePayOutID: integer;
    procedure PaidAmountEditClick(Sender: TObject);
    procedure PrintDocument;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PayOutPro;
    procedure DescriptionEditClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }
    OpDateTime: TDateTime;
  public
    { Public declarations }
  end;

var
 PayOutForm: TPayOutForm;

implementation

uses NumPad, DataUnit, Keyboard;

{$R *.DFM}

function TPayOutForm.GeneratePayOutID: Integer;
var
 SQLStr: string;
begin
 SQLStr := 'Select Max(ID) As MaxID From PayOutTable';
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

procedure TPayOutForm.PaidAmountEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := PaidAmountEdit.Caption;
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Payment Amount', 0) then
    PaidAmountEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
end;

procedure TPayOutForm.DescriptionEditClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    DescriptionEdit.Caption := Str;
end;

procedure TPayOutForm.PrintDocument;
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
 StrTemp := Format('CASH:    %4.2f', [StrToFloat(PaidAmountEdit.Caption)]);
 CharCount := (PaperWidth - Length(StrTemp)) div 2;
 PrintStr := Format('%' + IntToStr(CharCount) + 's%s', ['', StrTemp]);
 DataForm.OutPutToPrinter(PrintStr);
 StrTemp := Format('TOTAL:   %4.2f', [StrToFloat(PaidAmountEdit.Caption)]);
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

 StrTemp := 'Operator: ' + sUserName;
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

procedure TPayOutForm.ConfirmButtonClick(Sender: TObject);
var
 SQLStr, DateTemp, Description, MachineIDTemp: string;
 PayoutID: integer;
 Flag: boolean;
 Paid: double;
begin
 if PaidAmountEdit.Caption <> '' then
    Paid := StrToFloat(PaidAmountEdit.Caption)
   else
    Paid := 0;
 if DescriptionEdit.Caption <> '' then
    Description := Chr(39) + CheckQuotes(DescriptionEdit.Caption) + Chr(39)
   else
    Description := 'Null';
 if MachineID <> '' then
    MachineIDTemp := Chr(39) + CheckQuotes(MachineID) + Chr(39)
   else
    MachineIDTemp := 'Null';
 DateTemp := ConvertDateTime(OpDateTime);
 PayOutID := GeneratePayoutID;
 if Paid <> 0 then
    begin
     SQLStr := 'Insert Into PayOutTable(PaymentDate, Amount, Description, OpName, MachineID, ID) ' +
               'Values(' + DateTemp + ',' + PaidAmountEdit.Caption + ',' +
               Description + ',' + Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' +
               MachineIDTemp + ',' + IntToStr(PayOutID) + ')';
     Flag := False;
     if Not DataForm.BeginTransaction then Exit;
     try
      Flag := DataForm.ExecQueryPro(SQLStr);
     finally
      if Flag then
         begin
          DataForm.CommitTransaction;
          CurrentDrawerNumber := DefaultDrawerPortNumber;
          DataForm.OpenDrawer(True, CurrentDrawerNumber);
          PrintDocument;
          Close;
         end
       else
        DataForm.RollBack;
     end;
    end;
end;

procedure TPayOutForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TPayOutForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TPayOutForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := CancelButton.Top + 86;
 OpDateTime := Date + Time;
 DateEdit.Caption := FormatDateTime('dd/mm/yyyy  hh:mm:ss', OpDateTime);
 DescriptionEdit.Caption := '';
 OperatorEdit.Caption := sUserName;
 PaidAmountEdit.SetFocus;
end;

procedure TPayOutForm.PayOutPro;
begin
 Application.CreateForm(TPayOutForm, PayOutForm);
 PayOutForm.ShowModal;
 PayOutForm.Free;
end;

end.
