unit BookSearch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, Grids, DBGrids, ExtCtrls, DataUnit, UtilUnit,
  DBCtrls, ADODB, XiButton, PanelButton, bsSkinCtrls;

type
  TBookingSearchForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    DateEdit1: TMaskEdit;
    DateEdit2: TMaskEdit;
    Query: TADOQuery;
    QueryCustomerName: TStringField;
    QueryTelephone: TStringField;
    QueryMobile: TStringField;
    QueryTableNo: TStringField;
    QueryBookingDate: TDateTimeField;
    QueryBookingNo: TStringField;
    QueryPersons: TIntegerField;
    QueryCover: TIntegerField;
    BackPanel: TbsSkinPanel;
    WorkPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    KindButton: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    UpButton: TXiButton;
    DownButton: TXiButton;
    PageUpButton: TXiButton;
    PageDownButton: TXiButton;
    ListAllButton: TPanelButton;
    NoShowButton: TPanelButton;
    DinnerButton: TPanelButton;
    LunchButton: TPanelButton;
    BreakfastButton: TPanelButton;
    OthersButton: TPanelButton;
    AllButton: TPanelButton;
    QueryVIPNo: TIntegerField;
    procedure OpenQuery;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DateEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ConfirmButtonClick(Sender: TObject);
    function  SearchPro(var BookingNo: string; var VIPNo: integer): boolean;
    procedure DateEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure ListAllButtonClick(Sender: TObject);
    procedure NoShowButtonClick(Sender: TObject);
    procedure DinnerButtonClick(Sender: TObject);
    procedure LunchButtonClick(Sender: TObject);
    procedure BreakfastButtonClick(Sender: TObject);
    procedure OthersButtonClick(Sender: TObject);
    procedure AllButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure SetListButton;
    procedure SetKindButton;
  private { Private declarations }
    ReturnFlag: boolean;
    BookingNo: string;
    VIPNo: integer;
    ListFlag, KindFlag: integer;
  public
    { Public declarations }
  end;

var
  BookingSearchForm: TBookingSearchForm;

implementation

uses MainMenu, DatePanel;

{$R *.DFM}

procedure TBookingSearchForm.OpenQuery;
var
 SQLStr: string;
 DateTemp1, DateTemp2: TDateTime;
begin
 DateTemp1 := TransferDate(DateEdit1.Text);
 DateTemp2 := TransferDate(DateEdit2.Text);
 SQLStr := 'Select BookingNo, BookingDate, CustomerName, TableNo, Telephone, Mobile, Persons, VIPNo ' +
           'From BookTable Where BookingDate>=' + ConvertDateTime(DateTemp1) +
           ' and BookingDate<=' + ConvertDateTime(DateTemp2 + StrToTime('23:59'));
 if ListFlag = 1 then SQLStr := SQLStr + ' and Arrived=0 ';
 if KindFlag <= 3 then
    SQLStr := SQLStr + ' and Kind=' + IntToStr(KindFlag);
 SQLStr := SQLStr + ' Order By BookingDate';
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

procedure TBookingSearchForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  if FieldByName('Persons').AsInteger > 0 then
     FieldByName('Cover').AsInteger := FieldByName('Persons').AsInteger;
end;

procedure TBookingSearchForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TBookingSearchForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TBookingSearchForm.DateEdit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then
    begin
     OpenQuery;
     DateEdit2.SetFocus;
    end;
end;

procedure TBookingSearchForm.DateEdit2KeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(13) then
    OpenQuery;
end;

procedure TBookingSearchForm.DBGridDblClick(Sender: TObject);
begin
 ConfirmButtonClick(Sender);
end;

procedure TBookingSearchForm.DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then
    ConfirmButtonClick(Sender);
end;

procedure TBookingSearchForm.ConfirmButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     ReturnFlag := True;
     BookingNo := Query.FieldByName('BookingNo').asString;
     VIPNo := Query.FieldByName('VIPNo').AsInteger;
     Close;
    end;
end;

procedure TBookingSearchForm.DateEdit1Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit1.Text) then
    DateEdit1.SetFocus;
end;

procedure TBookingSearchForm.DateEdit2Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit2.Text) then
    DateEdit2.SetFocus;
end;

procedure TBookingSearchForm.CheckBoxClick(Sender: TObject);
begin
 OpenQuery;
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.DateEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   DateTemp := TransferDate(Text);
   if DateForm.ReadDatePro(DateTemp) then
      begin
       Text := FormatDateTime('dd/mm/yyyy', DateTemp);
       OpenQuery;
       DBGrid.SetFocus;
      end;
  end;
end;

procedure TBookingSearchForm.UpButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.BOF then
    Query.Prior;
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.DownButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.EOF then
    Query.Next;
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.PageUpButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.BOF then
    Query.MoveBy(-18);
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.PageDownButtonClick(Sender: TObject);
begin
 if Query.Active and Not Query.EOF then
    Query.MoveBy(18);
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.ListAllButtonClick(Sender: TObject);
begin
 ListFlag := 0;
 SetListButton;
 OpenQuery;
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.NoShowButtonClick(Sender: TObject);
begin
 ListFlag := 1;
 SetListButton;
 OpenQuery;
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.DinnerButtonClick(Sender: TObject);
begin
 KindFlag := 0;
 SetKindButton;
 OpenQuery;
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.LunchButtonClick(Sender: TObject);
begin
 KindFlag := 1;
 SetKindButton;
 OpenQuery;
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.BreakfastButtonClick(Sender: TObject);
begin
 KindFlag := 2;
 SetKindButton;
 OpenQuery;
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.OthersButtonClick(Sender: TObject);
begin
 KindFlag := 3;
 SetKindButton;
 OpenQuery;
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.AllButtonClick(Sender: TObject);
begin
 KindFlag := 4;
 SetKindButton;
 OpenQuery;
 DBGrid.SetFocus;
end;

procedure TBookingSearchForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (Shift = [ssAlt]) and ((Key = Ord('D')) or (Key = Ord('d'))) then
    DateEdit1.SetFocus;
end;

procedure TBookingSearchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TBookingSearchForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TBookingSearchForm.SetListButton;
begin
 ListAllButton.Font.Color := clBlack;
 NoShowButton.Font.Color := clBlack;
 case ListFlag of
  0: ListAllButton.Font.Color := clRed;
  1: NoShowButton.Font.Color := clRed;
 end;
end;

procedure TBookingSearchForm.SetKindButton;
begin
 DinnerButton.Font.Color := clBlack;
 LunchButton.Font.Color := clBlack;
 BreakfastButton.Font.Color := clBlack;
 OthersButton.Font.Color := clBlack;
 AllButton.Font.Color := clBlack;
 case KindFlag of
  0: DinnerButton.Font.Color := clRed;
  1: LunchButton.Font.Color := clRed;
  2: BreakfastButton.Font.Color := clRed;
  3: OthersButton.Font.Color := clRed;
  4: AllButton.Font.Color := clRed;
 end;
end;

procedure TBookingSearchForm.FormShow(Sender: TObject);
begin
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := DateEdit1.Text;
 ListFlag := 1;
 SetListButton;
 KindFlag := 4;
 SetKindButton;
 OpenQuery;
 DBGrid.SetFocus;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
end;

function TBookingSearchForm.SearchPro(var BookingNo: string; var VIPNo: integer): boolean;
begin
 Application.CreateForm(TBookingSearchForm, BookingSearchForm);
 BookingSearchForm.ShowModal;
 Result := BookingSearchForm.ReturnFlag;
 if Result then
    begin
     BookingNo := BookingSearchForm.BookingNo;
     VIPNo := BookingSearchForm.VIPNo;
    end; 
 BookingSearchForm.Free;
end;

end.
