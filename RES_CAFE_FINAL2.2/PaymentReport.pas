unit PaymentReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, Db, Grids, DBGrids, UtilUnit,
  ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TPurchasePaymentRptForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    DBGrid1: TDBGrid;
    SummaryDataSource: TDataSource;
    DateCheckBox: TCheckBox;
    DateEdit1: TMaskEdit;
    Label1: TLabel;
    DateEdit2: TMaskEdit;
    SupplierCheckBox: TCheckBox;
    SupplierCodeEdit: TEdit;
    SupplierNameEdit: TEdit;
    ChequeNoCheckBox: TCheckBox;
    ChequeNoEdit: TEdit;
    SortRadioGroup: TRadioGroup;
    Query: TADOQuery;
    QueryReceiveNo: TStringField;
    QueryReceiveDate: TDateTimeField;
    QuerySupplierName: TStringField;
    QueryAmount: TFloatField;
    QueryGST: TFloatField;
    QueryPaidAmount: TFloatField;
    QueryAccountDate: TDateTimeField;
    QueryPayby: TStringField;
    QueryNotes: TStringField;
    QueryTotal: TFloatField;
    SummaryQuery: TADOQuery;
    SummaryQueryPayby: TStringField;
    SummaryQueryAmount: TFloatField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    DBGridPanel1: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    ViewButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    {procedure OpenQuery;
    procedure OpenSummaryQuery;
   / procedure DateCheckBoxClick(Sender: TObject);
    procedure SupplierCheckBoxClick(Sender: TObject);
    procedure ChequeNoCheckBoxClick(Sender: TObject);
    procedure SupplierCodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ChequeNoEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PurchasePaymentReportPro;
    procedure SearchButtonClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure DateEditClick(Sender: TObject);
    procedure ViewButtonClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);}
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PurchasePaymentRptForm: TPurchasePaymentRptForm;

implementation

uses  DatePanel, MainMenu, DataUnit;


{$R *.DFM}

{procedure TPurchasePaymentRptForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select PayAcct.ReceiveNo, ReceiveDate, SupplierName, Amount, GST, ' +
           'PayAcct.PaidAmount, AccountDate, Payby, PayAcct.Notes ' +
           'From PayAcct, StockH, Supplier ' +
           'Where PayAcct.ReceiveNo=StockH.ReceiveNo and ' +
           'StockH.SupplierCode=Supplier.SupplierCode';
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and AccountDate>=' +
      ConvertDateTime(TransferDate(DateEdit1.Text)) +
      ' and AccountDate<=' +
      ConvertDateTime(TransferDate(DateEdit2.Text));
 if SupplierCheckBox.Checked then
    SQLStr := SQLStr + ' and Supplier.SupplierCode=' +
              Chr(39) + CheckQuotes(SupplierCodeEdit.Text) + Chr(39);
 if ChequeNoCheckBox.Checked then
    SQLStr := SQLStr + ' and PayAcct.Notes=' + Chr(39) + CheckQuotes(ChequeNoEdit.Text) + Chr(39);
 case SortRadioGroup.ItemIndex of
  0: SQLStr := SQLStr + ' Order by AccountDate';
  1: SQLStr := SQLStr + ' Order by ReceiveDate';
  2: SQLStr := SQLStr + ' Order by Supplier.SupplierCode';
  3: SQLStr := SQLStr + ' Order by PayAcct.Notes';
 end;
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
end;  }

{procedure TPurchasePaymentRptForm.OpenSummaryQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select PayAcct.Payby, Sum(PayAcct.PaidAmount) As Amount ' +
           'From PayAcct';
 if SupplierCheckBox.Checked then
    SQLStr := SQLStr + ', Supplier, StockH';
 if DateCheckBox.Checked or SupplierCheckBox.Checked or ChequeNoCheckBox.Checked then
    begin
     SQLStr := SQLStr + ' Where ';
     if DateCheckBox.Checked then
        SQLStr := SQLStr + ' AccountDate>=' +
                  ConvertDateTime(TransferDate(DateEdit1.Text)) +
                  ' and AccountDate<=' +
                  ConvertDateTime(TransferDate(DateEdit2.Text));
     if SupplierCheckBox.Checked then
        begin
         if DateCheckBox.Checked then SQLStr := SQLStr + ' and ';
         SQLStr := SQLStr + ' PayAcct.ReceiveNo=StockH.ReceiveNo' +
                  ' and StockH.SupplierCode=Supplier.SupplierCode and ' +
                  'Supplier.SupplierCode=' + Chr(39) + CheckQuotes(SupplierCodeEdit.Text) + Chr(39);
        end;
     if ChequeNoCheckBox.Checked then
        begin
         if DateCheckBox.Checked or SupplierCheckBox.Checked then
            SQLStr := SQLStr + ' and ';
         SQLStr := SQLStr + ' PayAcct.Notes=' + Chr(39) + CheckQuotes(ChequeNoEdit.Text) + Chr(39);
        end;
    end;
 SQLStr := SQLStr + ' Group By Payby Order by PayBy';
 Screen.Cursor := crHourGlass;
 with SummaryQuery do
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
  }
{procedure TPurchasePaymentRptForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  FieldByName('Total').AsFloat :=
   FieldByName('Amount').AsFloat + FieldByName('GST').AsFloat;
end;

procedure TPurchasePaymentRptForm.DateCheckBoxClick(Sender: TObject);
begin
 if DateCheckBox.Checked then
    begin
     DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
     DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
     DateEdit1.Enabled := True;
     DateEdit2.Enabled := True;
    end
   else
    begin
     DateEdit1.Text := '';
     DateEdit2.Text := '';
     DateEdit1.Enabled := False;
     DateEdit2.Enabled := False;
    end
end;

procedure TPurchasePaymentRptForm.SupplierCheckBoxClick(Sender: TObject);
begin
 if SupplierCheckBox.Checked then
    begin
     SupplierCodeEdit.Enabled := True
    end
   else
    begin
     SupplierCodeEdit.Text := '';
     SupplierCodeEdit.Enabled := False;
    end;
end;

procedure TPurchasePaymentRptForm.ChequeNoCheckBoxClick(Sender: TObject);
begin
 if ChequeNoCheckBox.Checked then
    begin
     ChequeNoEdit.Enabled := True
    end
   else
    begin
     ChequeNoEdit.Text := '';
     ChequeNoEdit.Enabled := False;
    end;
end;

procedure TPurchasePaymentRptForm.SupplierCodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
 Code, SupplierName: string;
begin
 case Key of
   VK_RETURN: SearchButton.SetFocus;
   VK_F5: begin
           if SupplierListForm.ListSupplier(Code, SupplierName, 0) then
              begin
               SupplierCodeEdit.Text := Code;
               SupplierNameEdit.Text := SupplierName;
              end;
          end;
 end;
end;

procedure TPurchasePaymentRptForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TPurchasePaymentRptForm.DateEdit2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TPurchasePaymentRptForm.DateEditClick(Sender: TObject);
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

procedure TPurchasePaymentRptForm.ChequeNoEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TPurchasePaymentRptForm.ViewButtonClick(Sender: TObject);
begin
 with Query do
 if Active and (RecordCount > 0) then
    StockReceiveDetailForm.StockReceiveDetailPro(FieldByName('ReceiveNo').AsString);
end;

procedure TPurchasePaymentRptForm.DBGridDblClick(Sender: TObject);
begin
 ViewButtonClick(Sender);
end;

procedure TPurchasePaymentRptForm.SearchButtonClick(Sender: TObject);
begin
 OpenQuery;
 OpenSummaryQuery;
end;

procedure TPurchasePaymentRptForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TPurchasePaymentRptForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 SummaryQuery.Close;
 Action := caFree;
end;

procedure TPurchasePaymentRptForm.PrintButtonClick(Sender: TObject);
begin
 PrintPurchasePaymentReportForm.PrintPurchasePaymentReportPro;
end;

procedure TPurchasePaymentRptForm.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TPurchasePaymentRptForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := DBGridPanel1.Top + DBGridPanel1.Height + 44;
 QueryAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryGST.DisplayFormat := sCurrency + ',0.#0';
 QueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 QueryTotal.DisplayFormat := sCurrency + ',0.#0';
 SummaryQueryAmount.DisplayFormat := sCurrency + ',0.#0';
 DateCheckBox.Checked := False;
 DateEdit1.Enabled := False;
 DateEdit2.Enabled := False;
 SupplierCheckBox.Checked := False;
 SupplierCodeEdit.Enabled := False;
 ChequeNoCheckBox.Checked := False;
 ChequeNoEdit.Enabled := False;
 SortRadioGroup.ItemIndex := 0;
end;

procedure TPurchasePaymentRptForm.PurchasePaymentReportPro;
begin
 Application.CreateForm(TPurchasePaymentRptForm, PurchasePaymentRptForm);
 DataForm.OpenCompanyQuery;
 PurchasePaymentRptForm.ShowModal;
 DataForm.CompanyQuery.Close;
 PurchasePaymentRptForm.Free;
end;
  }
end.
