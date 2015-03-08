unit BookingNoSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, DataUnit, UtilUnit,
  ADODB, MainMenu, BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TBookingNoSelectForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryTableNo: TStringField;
    QueryBookingDate: TDateTimeField;
    QueryPersons: TIntegerField;
    QueryCustomerName: TStringField;
    QueryTelephone: TStringField;
    QueryBookingNo: TStringField;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure OpenQuery;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    function  BookingNoSelectPro(var ReserveNo: string; TableNo: string;
              BookingDate: TDateTime; Kind: integer): boolean;
  private { Private declarations }
    ReturnFlag: boolean;
    ReserveDate: TDateTime;
    Kind: integer;
    TableNo, ReserveNo: string;
  public
    { Public declarations }
  end;

var
  BookingNoSelectForm: TBookingNoSelectForm;

implementation

{$R *.DFM}

procedure TBookingNoSelectForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select TableNo, BookingDate, Persons, CustomerName, ' +
           'Telephone, BookingNo From BookTable ' +
           'Where BookingDate>=' + ConvertDateTime(ReserveDate + StrToTime('00:01')) +
           ' and BookingDate<=' +  ConvertDateTime(ReserveDate + StrToTime('23:59')) +
           ' and ExpireTime >= ' + ConvertDateTime(Date + Time) +
           ' and (Kind=' + IntToStr(Kind) + ' Or Kind=3) ' +
           ' and (' +
           ' TableNo Like ' + Chr(39) + CheckQuotes(TableNo) + ',%' + Chr(39) +
           ' or TableNo Like ' + Chr(39) + '%,' + CheckQuotes(TableNo) + ',%' + Chr(39) +
           ' or TableNo Like ' + Chr(39) + '%,' + CheckQuotes(TableNo) + Chr(39) +
           ' or TableNo=' + Chr(39) + CheckQuotes(TableNo) + Chr(39) +
           ') and Arrived = 0 Order By BookingDate';
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

procedure TBookingNoSelectForm.ConfirmButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     ReserveNo := Query.FieldByName('BookingNo').AsString;
     ReturnFlag := True;
     Close;
    end;
end;

procedure TBookingNoSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TBookingNoSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TBookingNoSelectForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 OpenQuery;
end;

procedure TBookingNoSelectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

function TBookingNoSelectForm.BookingNoSelectPro(var ReserveNo: string;
         TableNo: string; BookingDate: TDateTime; Kind: integer): boolean;
begin
 Application.CreateForm(TBookingNoSelectForm, BookingNoSelectForm);
 BookingNoSelectForm.TableNo := TableNo;
 BookingNoSelectForm.ReserveDate := BookingDate;
 BookingNoSelectForm.Kind := Kind;
 BookingNoSelectForm.ShowModal;
 Result := BookingNoSelectForm.ReturnFlag;
 if Result then ReserveNo := BookingNoSelectForm.ReserveNo;
 BookingNoSelectForm.Free;
end;

end.
