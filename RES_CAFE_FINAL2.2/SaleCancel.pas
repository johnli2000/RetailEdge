unit SaleCancel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, XiButton, StdCtrls, Mask, Grids, DBGrids, bsSkinCtrls,UtilUnit;

type
  TSalesCancelForm = class(TForm)
    DBGridPanel: TbsSkinPanel;
    DBGrid: TDBGrid;
    ControlPanel: TbsSkinPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DateEdit1: TMaskEdit;
    DateEdit2: TMaskEdit;
    AmountEdit: TStaticText;
    TimeEdit1: TMaskEdit;
    TimeEdit2: TMaskEdit;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryHoldDate: TDateTimeField;
    QueryTotalAmount: TFloatField;
    QueryMachineId: TWideStringField;
    QueryOpname: TWideStringField;
    QueryHoldNo: TIntegerField;
    DeleteBtn: TXiButton;
    DVRBtn: TXiButton;
    procedure SearchButtonClick(Sender: TObject);
    procedure CalcAmount;
    procedure OpenQuery(SQLStr: string);
    procedure SalesCancelReportPro;
    procedure FormShow(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    function DeleteRecordPro: boolean;
    procedure DVRBtnClick(Sender: TObject);
  private
    { Private declarations }
    InvoiceDate: TDateTime;
  public
    { Public declarations }
  end;

var
  SalesCancelForm: TSalesCancelForm;

implementation
uses DatePanel, SaleshistoryDetail, MainMenu, DataUnit, PrintSalesVoidReport,
     TimePanel, PrintSalesCancelReport, MessageBox, DisplayMessage,
  SecurityCamera;

{$R *.dfm}

procedure TSalesCancelForm.SearchButtonClick(Sender: TObject);
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
 DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
 SQLStr := 'Select HoldNo, HoldDate, TotalAmount, MachineID, opName ' +
           'From CancelHead ' +
           'Where HoldDate>=' + ConvertDateTime(DateTemp1) +
           ' and HoldDate<=' + ConvertDateTime(DateTemp2) +
           ' Order By Opname';
 OpenQuery(SQLStr);
 if Query.Active and (Query.RecordCount > 0) then
    CalcAmount
   else
    AmountEdit.Caption := FormatCurrency(0.0) + ' ';
end;


procedure TSalesCancelForm.CalcAmount;
var
 Amount: double;
begin
 Amount := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     Amount := Amount + FieldByname('TotalAmount').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;
 AmountEdit.Caption := FormatCurrency(Amount) + ' ';
end;

procedure TSalesCancelForm.OpenQuery(SQLStr: string);
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

procedure TSalesCancelForm.SalesCancelReportPro;
begin
 Application.CreateForm(TSalesCancelForm, SalesCancelForm);
 SalesCancelForm.ShowModal;
 SalesCancelForm.Free;
end;

procedure TSalesCancelForm.FormShow(Sender: TObject);
begin
 Top := (MainForm.ClientHeight - Height - MainForm.bsSkinMainMenuBar.Height) div 2;
 Left := (MainForm.ClientWidth - Width) div 2;
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
 TimeEdit1.Text := '00:00';
 TimeEdit2.Text := '23:59';
 AmountEdit.Caption := FormatCurrency(0.0) + ' ';
end;

procedure TSalesCancelForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesCancelForm.PrintButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
    PrintSalesCancelFormReport.PrintSaleCancelPro;
end;

procedure TSalesCancelForm.DeleteBtnClick(Sender: TObject);
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      if DBGrid.SelectedRows.Count = 0 then
         MessageBoxForm.MessagePro('There are no data has been selected.', sErrorMsg)
        else
         if MessageBoxForm.MessagePro('Are you sure you want to delete selected record(s)?', sConfirmMsg) = mrYes then
            begin
             DisableControls;
             if DeleteRecordPro then SearchButtonClick(Sender);
             EnableControls;
            end;
     end;
end;

function TSalesCancelForm.DeleteRecordPro: boolean;
var
 SQLStr: string;
begin
 Result := DataForm.BeginTransaction;
 if Result then
    try
     DisplayMessageForm.DisplayMessagePro('Update database, please wait...');
     DataForm.ExecCommand.CommandTimeout := 600;
     with Query do
      begin
       First;
       while Result and Not EOF do
        begin
         if DBGrid.SelectedRows.CurrentRowSelected then
            begin
             SQLStr := 'Delete From CancelHead Where HoldNo=' + IntToStr(FieldByName('HoldNo').AsInteger);
             Result := DataForm.ExecQueryPro(SQLStr);
             SQLStr := 'Delete From CancelItem Where HoldNo=' + IntToStr(FieldByName('HoldNo').AsInteger);
             Result := DataForm.ExecQueryPro(SQLStr);
            end;
         Next;
        end;
      end;
     finally
      if Result then
         DataForm.CommitTransaction
        else
         DataForm.RollBack;
      DataForm.ExecCommand.CommandTimeout := 30;
      DisplayMessageForm.Close;
      DisplayMessageForm.Free;
     end;
end;

procedure TSalesCancelForm.DVRBtnClick(Sender: TObject);
begin
 with Query do
  InvoiceDate := Query.FieldByname('HoldDate').AsDateTime;
  SecurityCameraForm.SecurityCameraPro(integer(StrToInt(DVRNo)),invoiceDate);


end;

end.
