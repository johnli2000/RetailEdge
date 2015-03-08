unit ReceivableReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, Grids, DBGrids, ExtCtrls, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TReceivableReportForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    DateCheckBox: TCheckBox;
    DateEdit: TMaskEdit;
    Label2: TLabel;
    TotalEdit: TStaticText;
    Query: TADOQuery;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    DetailButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    QueryVIPNo: TIntegerField;
    QueryVIPName: TStringField;
    QueryTelephone: TStringField;
    QueryCreditLimit: TFloatField;
    QueryTotalCredit: TFloatField;
    QueryAvailableCredit: TFloatField;
    SmartCard: TCheckBox;
    procedure OpenQuery;
    procedure CalcAmount;
    procedure DateCheckBoxClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ReceivableReportPro;
    procedure SearchButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DetailButtonClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReceivableReportForm: TReceivableReportForm;

implementation

uses DatePanel, MainMenu, UtilUnit, DataUnit, MessageBox, CustomerStatement,
  PrintReceivableReport;

{$R *.DFM}

procedure TReceivableReportForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select VIPTable.VIPNo, VIPName, Telephone, CreditLimit, ' +
           'Sum(TempTable.TotalCredit) As TotalCredit From VIPTable, ' +
           '(Select VIPNo, (Amount + ServiceCharge + OtherCharge + Tips - PaidAmount) As TotalCredit ' +
           'From OrderH Where (PriceIncludesGST <> 0) and (Credit <> 0) and ' +
           '(Amount + ServiceCharge + OtherCharge + Tips - PaidAmount > 0) ';

 if DateCheckBox.Checked then
    SQLStr := SQLStr + 'and OrderDate <=' +
              ConvertDateTime(TransferDate(DateEdit.Text) + StrToTime('23:59:59'));
 SQLStr := SQLStr + ' Union All ' +
           'Select VIPNo, (Amount + ServiceCharge + OtherCharge + Tips + GST - PaidAmount) As TotalCredit ' +
           'From OrderH Where (PriceIncludesGST = 0) and (Credit <> 0) and ' +
           '(Amount + ServiceCharge + OtherCharge + GST + Tips - PaidAmount > 0) ';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + 'and OrderDate <=' +
              ConvertDateTime(TransferDate(DateEdit.Text) + StrToTime('23:59:59'));
 SQLStr := SQLStr + ' Union All ' +
           'Select VIPNo, 0 - Amount As TotalCredit ' +
           'From DepositTable ';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + 'Where Flag = 0 and DepositDate <=' +
              ConvertDateTime(TransferDate(DateEdit.Text) + StrToTime('23:59:59'));
 SQLStr := SQLStr + ') As TempTable ' +
           'Where VIPTable.VIPNo=TempTable.VIPNo ';
 if SmartCard.Checked then
    SQLStr := SQLStr + 'and VIPTable.SmartCard = 1 ';

 SQLStr := SQLStr + 'Group By VIPTable.VIPNo, VIPName, Telephone, CreditLimit ' +
           'Having Sum(TempTable.TotalCredit) > 0 ' +
           ' Order By VIPTable.VIPNo';
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

procedure TReceivableReportForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  FieldByName('AvailableCredit').AsFloat :=
   FieldByName('CreditLimit').AsFloat - FieldByName('TotalCredit').AsFloat;
end;

procedure TReceivableReportForm.CalcAmount;
var
 Total: double;
begin
 Total := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     Total := Total + FieldByName('TotalCredit').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;
 TotalEdit.Caption := FormatCurrency(Total) + ' ';
end;

procedure TReceivableReportForm.DateCheckBoxClick(Sender: TObject);
begin
 if DateCheckBox.Checked then
    begin
     DateEdit.Text := FormatDateTime('dd/mm/yyyy', Date);
     DateEdit.Enabled := True;
    end
   else
    begin
     DateEdit.Text := '';
     DateEdit.Enabled := False;
    end
end;

procedure TReceivableReportForm.DateEditClick(Sender: TObject);
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

procedure TReceivableReportForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
 CalcAmount;
end;

procedure TReceivableReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TReceivableReportForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TReceivableReportForm.DetailButtonClick(Sender: TObject);
var
 VIPNo: integer;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      VIPNo := FieldByName('VIPNo').AsInteger;
      CustomerStatementForm.CustomerStatementPro(VIPNo);
     end;
end;

procedure TReceivableReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TReceivableReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := ExitButton.Top + 86;
 DateCheckBox.Checked := True;
 DateEdit.Enabled := True;
 DateEdit.Text := FormatDateTime('dd/mm/yyyy', Date);
 QueryCreditLimit.DisplayFormat := sCurrency + ',0.#0';
 QueryTotalCredit.DisplayFormat := sCurrency + ',0.#0';
end;

procedure TReceivableReportForm.PrintButtonClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     PrintReceivableReportFrom.PrintReceivableReportPro;
end;

procedure TReceivableReportForm.ReceivableReportPro;
begin
 Application.CreateForm(TReceivableReportForm, ReceivableReportForm);
 ReceivableReportForm.ShowModal;
 ReceivableReportForm.Free;
end;

end.
