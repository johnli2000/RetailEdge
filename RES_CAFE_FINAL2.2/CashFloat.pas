unit CashFloat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, UtilUnit, DB, ADODB, bsSkinCtrls,
  BusinessSkinForm, XiButton;

type
  TCashFloatForm = class(TForm)
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    EditPanel: TbsSkinPanel;
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
    function  GenerateCashFloatID: Integer;
    procedure CashInEditClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CashFloatPro;
    procedure CashOutEditClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DescriptionButtonClick(Sender: TObject);
  private { Private declarations }
    OpDateTime: TDateTime;
  public
    { Public declarations }
  end;

var
 CashFloatForm: TCashFloatForm;

implementation

uses NumPad, DataUnit, Keyboard, MessageBox;

{$R *.DFM}

function TCashFloatForm.GenerateCashFloatID: Integer;
var
 SQLStr: string;
begin
 SQLStr := 'Select Max(ID) As MaxID From CashFloatTable';
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

procedure TCashFloatForm.CashInEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Float In Amount', 0) then
    begin
     CashInEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
     CashOutEdit.Caption := '';
    end;
end;

procedure TCashFloatForm.CashOutEditClick(Sender: TObject);
var
 NumStr: string;
begin
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, False, True, 'Float Out Amount', 0) then
    begin
     CashOutEdit.Caption := Format('%4.2f ', [StrToFloat(NumStr)]);
     CashInEdit.Caption := '';
    end;
end;

procedure TCashFloatForm.DescriptionButtonClick(Sender: TObject);
var
 Str: string;
begin
 if KeyboardForm.KeyboardPro(Str) then
    DescriptionEdit.Caption := Str;
end;

procedure TCashFloatForm.ConfirmButtonClick(Sender: TObject);
var
 SQLStr, DateTemp, MachineIDTemp, Description: string;
 CashIn, CashOut: double;
 ID: integer;
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
    MachineIDTemp := Chr(39) + CheckQuotes(MachineID) + Chr(39)
   else
    MachineIDTemp := 'Null';
 if DescriptionEdit.Caption <> '' then
    Description := Chr(39) + CheckQuotes(DescriptionEdit.Caption) + Chr(39)
   else
    Description := 'Null';
 DateTemp := ConvertDateTime(OpDateTime);
 ID := GenerateCashFloatID;
 SQLStr := 'Insert Into CashFloatTable(OpDate, CashIn, CashOut, OpName, MachineID, ID, Description) ' +
           'Values(' + DateTemp + ',' + FloatToStr(CashIn) + ',' +
           FloatToStr(CashOut) + ',' + Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' +
           MachineIDTemp + ',' + IntToStr(ID) + ',' + Description + ')';
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
         Close;
        end
      else
       DataForm.RollBack;
    end;
end;

procedure TCashFloatForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TCashFloatForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TCashFloatForm.FormShow(Sender: TObject);
begin
 Width := EditPanel.Width + 28;
 Height := ConfirmButton.Top + 86;
 OpDateTime := Date + Time;
 DateEdit.Caption := FormatDateTime('dd/mm/yyyy  hh:mm:ss', OpDateTime);
 OperatorEdit.Caption := sUserName;
 CashInEdit.Caption := '';
 CashOutEdit.Caption := '';
 DescriptionEdit.Caption := '';
 CashInEdit.SetFocus;
end;

procedure TCashFloatForm.CashFloatPro;
begin
 Application.CreateForm(TCashFloatForm, CashFloatForm);
 CashFloatForm.ShowModal;
 CashFloatForm.Free;
end;

end.
