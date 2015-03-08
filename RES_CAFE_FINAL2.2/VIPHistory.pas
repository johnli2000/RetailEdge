unit VIPHistory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Buttons, DBCtrls, Mask, Grids, DBGrids, ExtCtrls, DataUnit,
  ADODB, UtilUnit, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TVIPHistoryForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    CompanyEdit: TEdit;
    TelephoneEdit: TEdit;
    FaxEdit: TEdit;
    MobileEdit: TEdit;
    VIPNoEdit: TEdit;
    VIPNameEdit: TEdit;
    EmailEdit: TEdit;
    CreateDateEdit: TMaskEdit;
    HeadDataSource: TDataSource;
    HeadDBGrid: TDBGrid;
    Label9: TLabel;
    DiscountEdit: TEdit;
    SummeryLabel: TStaticText;
    Label10: TLabel;
    BirthDayEdit: TMaskEdit;
    Label11: TLabel;
    AddressEdit: TEdit;
    Label12: TLabel;
    SuburbEdit: TEdit;
    Label13: TLabel;
    StateEdit: TEdit;
    Label14: TLabel;
    PostCodeEdit: TEdit;
    HeadQuery: TADOQuery;
    HeadQueryOrderDate: TDateTimeField;
    HeadQueryOrderNo: TStringField;
    HeadQueryPersons: TIntegerField;
    HeadQueryTableNo: TStringField;
    Query: TADOQuery;
    Label15: TLabel;
    MapEdit: TEdit;
    HeadQueryBalance: TFloatField;
    HeadQueryPaidAmount: TFloatField;
    DateCheckBox: TCheckBox;
    DateEdit1: TMaskEdit;
    Label16: TLabel;
    DateEdit2: TMaskEdit;
    ListCheckBox: TCheckBox;
    HeadQueryAmount: TFloatField;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    TitlePanel: TbsSkinPanel;
    DBGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    RefreshButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    procedure ReadVIPInformation;
    Procedure OpenHeadQuery(VIPNo: String);
    procedure CalcAmount;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VIPHistoryPro(VIPNo: string);
    procedure HeadQueryCalcFields(DataSet: TDataSet);
    procedure HeadDBGridDblClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure DateCheckBoxClick(Sender: TObject);
    procedure ListCheckBoxClick(Sender: TObject);
    procedure DateEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure RefreshButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
  private { Private declarations }
    VIPNo: string;
  public
    { Public declarations }
  end;

var
  VIPHistoryForm: TVIPHistoryForm;

implementation

uses MainMenu, SalesHistoryDetail, DatePanel, PrintVIPStatement;

{$R *.DFM}

procedure TVIPHistoryForm.ReadVIPInformation;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From VIPTable Where VIPNo=' + VIPNo;
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
   if Active and (RecordCount <> 0) then
      begin
       VIPNameEdit.Text := FieldByName('VIPName').AsString;
       CompanyEdit.Text := FieldByName('Company').AsString;
       TelephoneEdit.Text := FieldByName('Telephone').AsString;
       FaxEdit.Text := FieldByName('Fax').asString;
       MobileEdit.Text := FieldByName('Mobile').AsString;
       EMailEdit.Text := FieldByName('EMail').AsString;
       AddressEdit.Text := FieldByName('Number').AsString + ' ' +
                           FieldByName('Address').AsString;
       SuburbEdit.Text := FieldByName('Suburb').AsString;
       StateEdit.Text := FieldByName('State').AsString;
       PostCodeEdit.Text := FieldByName('PostCode').AsString;
       VIPNoEdit.Text := Format('%8.8d', [StrToInt(VIPNo)]);
       MapEdit.Text := FieldByName('MapReference').AsString;
       CreateDateEdit.Text := FormatDateTime('dd/mm/yyyy', FieldByName('CreateDate').AsDateTime);
       if FieldByName('BirthDay').AsDateTime <> 0 then
          BirthDayEdit.Text := FormatDateTime('dd/mm/yyyy', FieldByName('BirthDay').AsDateTime);
       DiscountEdit.Text := Format('%5.2f', [FieldByName('Discount').AsFloat]);
      end;
   Close;
  end;
end;

procedure TVIPHistoryForm.CalcAmount;
var
 Count: integer;
 Amount: double;
begin
 Amount := 0;
 with HeadQuery do
  begin
   Count := RecordCount;
   First;
   DisableControls;
   while Not EOF do
    begin
     Amount := Amount + FieldByName('Amount').AsFloat;
     Next;
    end;
   First;
   EnableControls;
  end;
 SummeryLabel.Caption := 'Visit(s): ' + IntToStr(Count) +
                         '   Amount: ' + FormatCurrency(Amount);
end;

procedure TVIPHistoryForm.OpenHeadQuery(VIPNo: String);
var
 SQLStr: string;
begin
 SQLStr := 'Select OrderNo, OrderDate, Persons, TableNo, ' +
           '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge) As Amount, ' +
           'PaidAmount ' +
           'From OrderH Where (PriceIncludesGST <> 0) and VIPNo=' + VIPNo;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderDate>=' +
              ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0:0')) +
              ' and OrderDate <=' +
              ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59:59'));
 if ListCheckBox.Checked then
    SQLStr := SQLStr + ' and (Amount + ServiceCharge + OtherCharge + Tips + Surcharge - PaidAmount) >= 0.01';
 SQLStr := SQLStr + ' Union All ' +
           'Select OrderNo, OrderDate, Persons, TableNo, ' +
           '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST) As Amount, ' +
           'PaidAmount ' +
           'From OrderH Where (PriceIncludesGST = 0) and VIPNo=' + VIPNo;
 if DateCheckBox.Checked then
    SQLStr := SQLStr + ' and OrderDate>=' +
              ConvertDateTime(TransferDate(DateEdit1.Text) + StrToTime('0:0:0')) +
              ' and OrderDate <=' +
              ConvertDateTime(TransferDate(DateEdit2.Text) + StrToTime('23:59:59'));
 if ListCheckBox.Checked then
    SQLStr := SQLStr + ' and (Amount + ServiceCharge + OtherCharge + GST + Tips + Surcharge - PaidAmount) >= 0.01';
 SQLStr := SQLStr + ' Order By OrderDate';
 Screen.Cursor := crHourGlass;
 with HeadQuery do
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

procedure TVIPHistoryForm.HeadQueryCalcFields(DataSet: TDataSet);
begin
 with HeadQuery do
  begin
   FieldByName('Balance').AsFloat :=
     FieldByName('Amount').AsFloat - FieldByName('PaidAmount').AsFloat;
  end;
end;

procedure TVIPHistoryForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TVIPHistoryForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 HeadQuery.Close;
 Action := caFree;
end;

procedure TVIPHistoryForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TVIPHistoryForm.HeadDBGridDblClick(Sender: TObject);
var
 OrderNo: string;
begin
 with HeadQuery do
  if Active and (RecordCount > 0) then
     begin
      OrderNo := FieldByName('OrderNo').AsString;
      SalesHistoryDetailForm.SalesDetailPro(OrderNo);
     end;
end;

procedure TVIPHistoryForm.DateEditClick(Sender: TObject);
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

procedure TVIPHistoryForm.DateCheckBoxClick(Sender: TObject);
begin
 DateEdit1.Enabled := DateCheckBox.Checked;
 DateEdit2.Enabled := DateCheckBox.Checked;
end;

procedure TVIPHistoryForm.ListCheckBoxClick(Sender: TObject);
begin
 OpenHeadQuery(VIPNo);
 CalcAmount;
end;

procedure TVIPHistoryForm.DateEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key = Chr(13) then DateEdit2.SetFocus;
end;

procedure TVIPHistoryForm.RefreshButtonClick(Sender: TObject);
begin
 OpenHeadQuery(VIPNo);
 CalcAmount;
end;

procedure TVIPHistoryForm.PrintButtonClick(Sender: TObject);
var
 Date1, Date2: string;
 NonBalance: boolean;
begin
 if DateCheckBox.Checked then
    begin
     Date1 := DateEdit1.Text;
     Date2 := DateEdit2.Text;
    end
   else
    begin
     Date1 := '';
     Date2 := '';
    end;
 NonBalance := ListCheckBox.Checked;
 PrintVIPStatementForm.PrintVIPStatementPro(StrToInt(VIPNo), Date1, Date2, NonBalance);
end;

procedure TVIPHistoryForm.FormShow(Sender: TObject);
begin
 Width := TitlePanel.Width + 28;
 Height := ControlPanel.Top + ControlPanel.Height + 46;
 DateCheckBox.Checked := False;
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit1.Enabled := False;
 DateEdit2.Enabled := False;
 ListCheckBox.Checked := False;
 HeadQueryAmount.DisplayFormat := sCurrency + ',0.#0';
 HeadQueryPaidAmount.DisplayFormat := sCurrency + ',0.#0';
 HeadQueryBalance.DisplayFormat := sCurrency + ',0.#0';
 ReadVIPInformation;
 OpenHeadQuery(VIPNo);
 CalcAmount;
 HeadDBGrid.SetFocus;
end;

procedure TVIPHistoryForm.VIPHistoryPro(VIPNo: string);
begin
 Application.CreateForm(TVIPHistoryForm, VIPHistoryForm);
 VIPHistoryForm.VIPNo := VIPNo;
 VIPHistoryForm.ShowModal;
 VIPHistoryForm.Free;
end;

end.
