unit EditCashFloat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, UtilUnit, DB, ADODB, bsSkinCtrls,
  BusinessSkinForm, XiButton;

type
  TEditCashFloatForm = class(TForm)
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    DateEdit: TbsSkinLabel;
    OperatorEdit: TbsSkinLabel;
    CashInEdit: TbsSkinLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    CashOutEdit: TbsSkinLabel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    CashInButtonButton: TbsSkinButton;
    CashOutButton: TbsSkinButton;
    DescriptionEdit: TbsSkinLabel;
    DescriptionButton: TbsSkinButton;
    procedure OpenQuery(SQLStr: string);
    procedure CashInEditClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CashOutEditClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    function  EditCashFloatPro(ID: integer): boolean;
    procedure DescriptionButtonClick(Sender: TObject);
  private { Private declarations }
    OpDateTime: TDateTime;
    ID: integer;
    ReturnFlag: Boolean;
    CurrentMachineID: string;
  public
    { Public declarations }
  end;

var
 EditCashFloatForm: TEditCashFloatForm;

implementation

uses NumPad, DataUnit, Keyboard, MessageBox;

{$R *.DFM}

procedure TEditCashFloatForm.OpenQuery(SQLStr: string);
begin
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
end;

procedure TEditCashFloatForm.CashInEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Cash In Amount', 0) then
    begin
     CashInEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
     CashOutEdit.Caption := '';
    end;
end;

procedure TEditCashFloatForm.CashOutEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Cash Out Amount', 0) then
    begin
     CashOutEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
     CashInEdit.Caption := '';
    end;
end;

procedure TEditCashFloatForm.ConfirmButtonClick(Sender: TObject);
var
 SQLStr, DateTemp, MachineIDTemp, OpName, Description: string;
 CashIn, CashOut: double;
 Flag: boolean;
begin
 if CashInEdit.Caption <> '' then
    CashIn := StrToFloat(CashInEdit.Caption)
   else
    CashIn := 0;
 if CashOutEdit.Caption <> '' then
    CashOut := StrToFloat(CashOutEdit.Caption)
   else
    CashOut := 0;
 if (CashIn = 0) and (CashOut = 0) then
    begin
     MessageBoxForm.MessagePro('Cash In / Out can not be zero.', sErrorMsg);
     Exit;
    end;
 if MachineID <> '' then
    MachineIDTemp := Chr(39) + CheckQuotes(CurrentMachineID) + Chr(39)
   else
    MachineIDTemp := 'Null';
 if OperatorEdit.Caption <> '' then
    OpName := Chr(39) + CheckQuotes(OperatorEdit.Caption) + Chr(39)
   else
    OpName := 'Null';
 if DescriptionEdit.Caption <> '' then
    Description := Chr(39) + CheckQuotes(DescriptionEdit.Caption) + Chr(39)
   else
    Description := 'Null';
 DateTemp := ConvertDateTime(OpDateTime);
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
    try
     SQLStr := 'Delete From CashFloatTable Where ID=' + IntToStr(ID);
     Flag := DataForm.ExecQueryPro(SQLStr);
     if Flag then
        begin
         SQLStr := 'Insert Into CashFloatTable(OpDate, CashIn, CashOut, OpName, MachineID, ID, Description) ' +
                   'Values(' + DateTemp + ',' + FloatToStr(CashIn) + ',' +
                   FloatToStr(CashOut) + ',' + OpName + ',' +
                   MachineIDTemp + ',' + IntToStr(ID) + ',' + Description + ')';
         Flag := DataForm.ExecQueryPro(SQLStr);
        end;
    finally
     if Flag then
        begin
         DataForm.CommitTransaction;
         ReturnFlag := True;
         Close;
        end
      else
       DataForm.RollBack;
    end;
end;

procedure TEditCashFloatForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TEditCashFloatForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TEditCashFloatForm.DescriptionButtonClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    DescriptionEdit.Caption := Str;
end;

procedure TEditCashFloatForm.FormShow(Sender: TObject);
var
 SQLStr: string;
begin
 Width := BackPanel.Width + 28;
 Height := CancelButton.Top + 86;
 SQLStr := 'Select * From CashFloatTable Where ID=' + IntToStr(ID);
 OpenQuery(SQLStr);
 with Query do
  begin
   OpDateTime := FieldByName('OpDate').AsDateTime;
   DateEdit.Caption := FormatDateTime('dd/mm/yyyy  hh:mm:ss', OpDateTime);
   OperatorEdit.Caption := FieldByName('OpName').AsString;
   if ABS(FieldByName('CashIn').AsFloat) >= 0.01 then
      begin
       CashInEdit.Caption := Format('%4.2f ', [FieldByName('CashIn').AsFloat]);
       CashOutEdit.Caption := '';
      end
     else
      begin
       CashOutEdit.Caption := Format('%4.2f ', [FieldByName('CashOut').AsFloat]);
       CashInEdit.Caption := '';
      end;
   CurrentMachineID := FieldByName('MachineID').AsString;
   DescriptionEdit.Caption := FieldByName('Description').AsString;
   Close;
  end;
 CashInEdit.SetFocus;
end;

function TEditCashFloatForm.EditCashFloatPro(ID: integer): boolean;
begin
 Application.CreateForm(TEditCashFloatForm, EditCashFloatForm);
 EditCashFloatForm.ID := ID;
 EditCashFloatForm.ShowModal;
 Result := EditCashFloatForm.ReturnFlag;
 EditCashFloatForm.Free;
end;

end.
