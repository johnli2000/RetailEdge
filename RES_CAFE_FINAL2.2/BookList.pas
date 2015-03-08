unit BookList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, Grids, DBGrids, ExtCtrls, DataUnit,
  UtilUnit, DBCtrls, ADODB, bsSkinCtrls, XiButton, PanelButton;

type
  TBookingListForm = class(TForm)
    DBGrid: TDBGrid;
    ControlPanel: TPanel;
    DataSource: TDataSource;
    DateCheckBox: TCheckBox;
    DateEdit1: TMaskEdit;
    Label2: TLabel;
    DateEdit2: TMaskEdit;
    ArrivedCheckBox: TCheckBox;
    Query: TADOQuery;
    QueryKind: TSmallintField;
    QueryRecordDate: TDateTimeField;
    QueryCustomerName: TStringField;
    QueryTelephone: TStringField;
    QueryFax: TStringField;
    QueryMobile: TStringField;
    QueryAddress: TStringField;
    QueryPersons: TIntegerField;
    QueryTableNo: TStringField;
    QueryBookingDate: TDateTimeField;
    QueryNotes: TStringField;
    QueryBookingNo: TStringField;
    QueryVIPNo: TIntegerField;
    QueryArrived: TBooleanField;
    QueryKindStr: TStringField;
    QueryArrivedStr: TStringField;
    QueryVIPNoStr: TStringField;
    BackPanel: TbsSkinPanel;
    WorkPanel: TbsSkinPanel;
    ListPanel: TbsSkinPanel;
    bsSkinPanel2: TbsSkinPanel;
    bsSkinPanel3: TbsSkinPanel;
    NewButton: TXiButton;
    EditButton: TXiButton;
    DeleteButton: TXiButton;
    PrintButton: TXiButton;
    PrintListButton: TXiButton;
    TableStatusButton: TXiButton;
    ExitButton: TXiButton;
    DetailButton: TXiButton;
    PrintDocButton: TXiButton;
    DinnerButton: TPanelButton;
    LunchButton: TPanelButton;
    BreakfastButton: TPanelButton;
    OthersButton: TPanelButton;
    ListAllButton: TPanelButton;
    DateTimeButton: TPanelButton;
    ReserveButton: TPanelButton;
    CustomerButton: TPanelButton;
    procedure OpenQuery(SQLStr: string);
    procedure DateCheckBoxClick(Sender: TObject);
    procedure RefreshQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DateEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DateEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure DateCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridDblClick(Sender: TObject);
    procedure ArrivedCheckBoxClick(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure PrintButtonClick(Sender: TObject);
    procedure BookingListPro;
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure TableStatusButtonClick(Sender: TObject);
    procedure DateTimeButtonClick(Sender: TObject);
    procedure ReserveButtonClick(Sender: TObject);
    procedure CustomerButtonClick(Sender: TObject);
    procedure DinnerButtonClick(Sender: TObject);
    procedure LunchButtonClick(Sender: TObject);
    procedure BreakfastButtonClick(Sender: TObject);
    procedure OthersButtonClick(Sender: TObject);
    procedure ListAllButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PrintListButtonClick(Sender: TObject);
    procedure DetailButtonClick(Sender: TObject);
    procedure PrintDocButtonClick(Sender: TObject);
    procedure SetKindButton;
    procedure SetSortButton;
  private { Private declarations }
    SortFlag, ListFlag: integer;
  public
    { Public declarations }
  end;

var
  BookingListForm: TBookingListForm;

implementation

uses BookForm, PrintBookingList, MainMenu, DatePanel, BookStatus, MessageBox,
  BookDetail, PrintBooking;

{$R *.DFM}

procedure TBookingListForm.OpenQuery(SQLStr: string);
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

procedure TBookingListForm.DateCheckBoxClick(Sender: TObject);
begin
 if DateCheckBox.Checked then
    begin
     DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
     DateEdit2.Text := FormatDateTime('dd/mm/yyyy', Date);
     DateEdit1.Enabled := True; DateEdit2.Enabled := True;
    end
   else
    begin
     DateEdit1.Text := ''; DateEdit2.Text := '';
     DateEdit1.Enabled := False; DateEdit2.Enabled := False;
    end;
 RefreshQuery;
end;

procedure TBookingListForm.RefreshQuery;
var
 SQLStr, Temp: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 Temp := '';
 SQLStr := 'Select * From BookTable ';
 if ListFlag <= 4 then Temp := 'Kind=' + IntToStr(ListFlag - 1);
 if ArrivedCheckBox.Checked then
    begin
     if Temp <> '' then Temp := Temp + ' and ';
     Temp := Temp + 'Arrived=0 ';
    end;
 if DateCheckBox.Checked then
    begin
     if Temp <> '' then Temp := Temp + ' and ';
     DateTemp1 := TransferDate(DateEdit1.Text);
     DateTemp2 := TransferDate(DateEdit2.Text);
     Temp := Temp +'BookingDate>=' + ConvertDateTime(DateTemp1)  +
             ' and BookingDate<=' + ConvertDateTime(DateTemp2 + StrToTime('23:59'));
    end;
 if Temp <> '' then SQLStr := SQLStr + ' Where ' + Temp;
 case SortFlag of
  1: SQLStr := SQLStr + ' Order By BookingDate';
  2: SQLStr := SQLStr + ' Order By BookingNo';
  3: SQLStr := SQLStr + ' Order By CustomerName';
 end;
 OpenQuery(SQLStr);
end;

procedure TBookingListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then ExitButtonClick(Sender);
end;

procedure TBookingListForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TBookingListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
 BookingListForm := Nil;
end;

procedure TBookingListForm.DateCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (Key = VK_RETURN) and DateCheckBox.Checked then
    DateEdit1.SetFocus;
end;

procedure TBookingListForm.DateEdit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then DateEdit2.SetFocus;
end;

procedure TBookingListForm.DateEdit2KeyPress(Sender: TObject; var Key: Char);
begin
if Key = Chr(13) then RefreshQuery;
end;

procedure TBookingListForm.NewButtonClick(Sender: TObject);
var
 BookingNo: string;
begin
 if BookingForm.BookingPro(BookingNo, sNewStatus, ListFlag - 1) then
    begin
     RefreshQuery;
     Query.Locate('BookingNo', BookingNo, [loPartialKey]);
    end;
end;

procedure TBookingListForm.EditButtonClick(Sender: TObject);
var
 BookingNo: string;
begin
  if Query.Active and (Query.RecordCount > 0) then
     begin
      BookingNo := Query.FieldByName('BookingNo').AsString;
      if BookingForm.BookingPro(BookingNo, sEditStatus, ListFlag) then
         begin
          RefreshQuery;
          Query.Locate('BookingNo', BookingNo, [loPartialKey]);
         end;
     end;
end;

procedure TBookingListForm.DetailButtonClick(Sender: TObject);
var
 BookingNo: string;
begin
  if Query.Active and (Query.RecordCount > 0) then
     begin
      BookingNo := Query.FieldByName('BookingNo').AsString;
      BookDetailForm.BookingDetailEditPro(BookingNo);
     end;
end;

procedure TBookingListForm.PrintDocButtonClick(Sender: TObject);
var
 BookingNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     BookingNo := Query.FieldByName('BookingNo').AsString;
     PrintBookingForm.PrintBookingFormPro(BookingNo);
    end;
end;

procedure TBookingListForm.DeleteButtonClick(Sender: TObject);
var
 SQLStr, BookingNo: string;
 Flag: boolean;
begin
 if Not Query.Active or (Query.RecordCount = 0) or
    (MessageBoxForm.MessagePro('Are you sure you want to delete this reservation record?', sConfirmMsg) = mrNo)
    then
    Exit;
 BookingNo := Query.FieldByName('BookingNo').AsString;
 if Not DataForm.BeginTransaction then Exit;
 Flag := False;
 try
  SQLStr := 'Delete From BookTable Where BookingNo=' + Chr(39) + CheckQuotes(BookingNo) + Chr(39);
  Flag := DataForm.ExecQueryPro(SQLStr);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      RefreshQuery;
     end
    else
     begin
      DataForm.RollBack;
     end;
 end;
end;

procedure TBookingListForm.DBGridDblClick(Sender: TObject);
begin
 EditButtonClick(Sender);
end;

procedure TBookingListForm.ArrivedCheckBoxClick(Sender: TObject);
begin
 RefreshQuery;
end;

procedure TBookingListForm.PrintButtonClick(Sender: TObject);
var
 BookingNo: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     BookingNo := Query.FieldByName('BookingNo').AsString;
     PrintBookingListForm.PrintBookingListPro;
     Query.Locate('BookingNo', BookingNo, [loPartialKey]);
   end;
end;

procedure TBookingListForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  begin
   if FieldByname('Arrived').AsBoolean then
      FieldByName('ArrivedStr').AsString := '¡Ì'
     else
      FieldByName('ArrivedStr').AsString := '';
   if FieldByName('VIPNo').AsInteger <> 0 then
      FieldByName('VIPNoStr').AsString := Format('%8.8d', [FieldByName('VIPNo').AsInteger]);   
   case FieldByName('Kind').AsInteger of
    0: FieldByName('KindStr').AsString := 'Dinner';
    1: FieldByName('KindStr').AsString := 'Lunch';
    2: FieldByName('KindStr').AsString := 'Breakfast';
    3: FieldByName('KindStr').AsString := 'Others';
   end;
 end;
end;

procedure TBookingListForm.DateEdit1Exit(Sender: TObject);
begin
 if DateCheckBox.Checked and Not CheckDate(DateEdit1.Text) then
    DateEdit1.SetFocus;
end;

procedure TBookingListForm.DateEdit2Exit(Sender: TObject);
begin
 if DateCheckBox.Checked and Not CheckDate(DateEdit2.Text) then
    DateEdit2.SetFocus;
end;


procedure TBookingListForm.DateEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   DateTemp := TransferDate(Text);
   if DateForm.ReadDatePro(DateTemp) then
      begin
       Text := FormatDateTime('dd/mm/yyyy', DateTemp);
       RefreshQuery;
       DBGrid.SetFocus;
      end;
  end;
end;

procedure TBookingListForm.TableStatusButtonClick(Sender: TObject);
var
 Temp: string;
 DateTemp: TDateTime;
begin
 if DateEdit1.Enabled then
    DateTemp := TransferDate(DateEdit1.Text)
   else
    DateTemp := Date;
 BookStatusForm.ListBookingStatus(Temp, True, ListFlag - 1, DateTemp);
end;

procedure TBookingListForm.DateTimeButtonClick(Sender: TObject);
begin
 SortFlag := 1;
 SetSortButton;
 RefreshQuery;
end;

procedure TBookingListForm.ReserveButtonClick(Sender: TObject);
begin
 SortFlag := 2;
 SetSortButton;
 RefreshQuery;
end;

procedure TBookingListForm.CustomerButtonClick(Sender: TObject);
begin
 SortFlag := 3;
 SetSortButton;
 RefreshQuery;
end;

procedure TBookingListForm.DinnerButtonClick(Sender: TObject);
begin
 ListFlag := 1;
 SetKindButton;
 RefreshQuery;
end;

procedure TBookingListForm.LunchButtonClick(Sender: TObject);
begin
 ListFlag := 2;
 SetKindButton;
 RefreshQuery;
end;

procedure TBookingListForm.BreakfastButtonClick(Sender: TObject);
begin
 ListFlag := 3;
 SetKindButton;
 RefreshQuery;
end;

procedure TBookingListForm.OthersButtonClick(Sender: TObject);
begin
 ListFlag := 4;
 SetKindButton;
 RefreshQuery;
end;

procedure TBookingListForm.ListAllButtonClick(Sender: TObject);
begin
 ListFlag := 5;
 SetKindButton;
 RefreshQuery;
end;

procedure TBookingListForm.PrintListButtonClick(Sender: TObject);
var
 LineStr, PrintStr: string;
 PaperWidth, I: integer;
begin
 if (FVar.DefaultPrinter = 0) or (String(FVar.POSPrinter[FVar.DefaultPrinter].Name) = 'N/A') then Exit;
 with Query do
  if Active and (RecordCount > 0) then
     begin
      DataForm.OpenPrinterPort(FVar.DefaultPrinter);
      PaperWidth := 40;
      LineStr := '';
      for I := 1 to PaperWidth do LineStr := LineStr + '=';
      DataForm.SetBlackFontA;
      DataForm.PrintBillHead;
      DataForm.OutPutToPrinter(LineStr);
      PrintStr := Format('%' + IntToStr((PaperWidth - 24) div 4) + 's%s', ['', 'BOOKING LIST']);
      DataForm.SetBlackFontB;
      DataForm.OutPutToPrinter(PrintStr);
      DataForm.SetBlackFontA;
      DataForm.OutPutToPrinter(LineStr);
      First;
      while NOT EOF do
       begin
        PrintStr := 'Name: ' + FieldByName('CustomerName').AsString;
        DataForm.OutPutToPrinter(PrintStr);
        if FieldByName('Telephone').AsString <> '' then
           begin
            PrintStr := 'Telephone: ' + FieldByName('Telephone').AsString;
            DataForm.OutPutToPrinter(PrintStr);
           end;
        PrintStr := 'Date & Time: ' + FormatDateTime('dd/mm/yyyy hh:mm', FieldByName('BookingDate').AsDateTime);
        DataForm.OutPutToPrinter(PrintStr);

        PrintStr := 'People: ' + Format('%4d', [FieldByName('Persons').AsInteger]) +
                    '  Table: ' + Format('%s', [FieldByName('TableNo').AsString]);
        DataForm.OutPutToPrinter(PrintStr);
        DataForm.OutPutToPrinter(' ');
        Next;
       end;
      DataForm.OutPutToPrinter(LineStr);
      PrintStr := FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time);
      DataForm.OutPutToPrinter(PrintStr);
      DataForm.OutPutToPrinter(' ');
      DataForm.OutPutToPrinter(' ');
      DataForm.CutPaper;
      DataForm.ClosePrinterPort;
     end;
end;

procedure TBookingListForm.SetKindButton;
begin
 DinnerButton.Font.Color := clBlack;
 LunchButton.Font.Color := clBlack;
 BreakfastButton.Font.Color := clBlack;
 OthersButton.Font.Color := clBlack;
 ListAllButton.Font.Color := clBlack;
 case ListFlag of
  1: DinnerButton.Font.Color := clRed;
  2: LunchButton.Font.Color := clRed;
  3: BreakfastButton.Font.Color := clRed;
  4: OthersButton.Font.Color := clRed;
  5: ListAllButton.Font.Color := clRed;
 end;
end;

procedure TBookingListForm.SetSortButton;
begin
 DateTimeButton.Font.Color := clBlack;
 ReserveButton.Font.Color := clBlack;
 CustomerButton.Font.Color := clBlack;
 case SortFlag of
  1: DateTimeButton.Font.Color := clRed;
  2: ReserveButton.Font.Color := clRed;
  3: CustomerButton.Font.Color := clRed;
 end;
end;

procedure TBookingListForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TBookingListForm.FormShow(Sender: TObject);
begin
 NewButton.Caption := 'New';
 EditButton.Caption := 'Edit';
 DeleteButton.Caption := 'Delete';
 DetailButton.Caption := 'Detail';
 PrintDocButton.Caption := 'Print' + Chr(13) + 'Docket';
 PrintButton.Caption := 'Print List' + Chr(13) + '(A4)';
 PrintListButton.Caption := 'Print List' + Chr(13) + '(POS)';
 TableStatusButton.Caption := 'Table' + Chr(13) + 'Status';
 ExitButton.Caption := 'Exit';
 DateCheckBox.Checked := True;
 ArrivedCheckBox.Checked := False;
 SortFlag := 1;
 ListFlag := 5;
 SetKindButton;
 SetSortButton;
 RefreshQuery;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
end;

procedure TBookingListForm.BookingListPro;
begin
 Application.CreateForm(TBookingListForm, BookingListForm);
 BookingListForm.ShowModal;
 BookingListForm.Free;
end;

end.
