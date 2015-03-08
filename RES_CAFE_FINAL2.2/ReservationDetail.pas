unit ReservationDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, DataUnit, UtilUnit,
  ADODB, MainMenu, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TReservationDetailForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryTableNo: TStringField;
    QueryBookingDate: TDateTimeField;
    QueryPersons: TIntegerField;
    QueryCustomerName: TStringField;
    QueryTelephone: TStringField;
    QueryBookingNo: TStringField;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure OpenQuery;
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    function  ReservatioDetailPro(var TableNo, ReserveNo: string; BookingDate: TDateTime; Kind: integer): boolean;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }
    ReturnFlag: boolean;
    ReserveDate: TDateTime;
    Kind: integer;
    TableNo, ReserveNo: string;
  public
    { Public declarations }
  end;

var
  ReservationDetailForm: TReservationDetailForm;

implementation

{$R *.DFM}

procedure TReservationDetailForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select TableNo, BookingDate, Persons, CustomerName, ' +
           'Telephone, BookingNo From BookTable ' +
           'Where BookingDate>=' +
           ConvertDateTime(ReserveDate + StrToTime('00:01')) +
           ' and BookingDate<=' +
           ConvertDateTime(ReserveDate + StrToTime('23:59')) +
           ' and Kind=' + IntToStr(Kind) +
           ' and (' +
           ' TableNo Like ' + Chr(39) + CheckQuotes(TableNo) + ',%' + Chr(39) +
           ' or TableNo Like ' + Chr(39) + '%,' + CheckQuotes(TableNo) + ',%' + Chr(39) +
           ' or TableNo Like ' + Chr(39) + '%,' + CheckQuotes(TableNo) + Chr(39) +
           ' or TableNo=' + Chr(39) + CheckQuotes(TableNo) + Chr(39) +
           ') Order By BookingDate';
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

procedure TReservationDetailForm.ConfirmButtonClick(Sender: TObject);
begin
 if Query.Active and (Query.RecordCount > 0) then
    begin
     ReserveNo := Query.FieldByName('BookingNo').AsString;
     ReturnFlag := True;
     Close;
    end;
end;

procedure TReservationDetailForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TReservationDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TReservationDetailForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Height := CancelButton.Top + 86;
 OpenQuery;
end;

procedure TReservationDetailForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

function TReservationDetailForm.ReservatioDetailPro(Var TableNo, ReserveNo: string;
         BookingDate: TDateTime; Kind: integer): boolean;
begin
 Application.CreateForm(TReservationDetailForm, ReservationDetailForm);
 ReservationDetailForm.TableNo := TableNo;
 ReservationDetailForm.ReserveDate := BookingDate;
 ReservationDetailForm.Kind := Kind;
 ReservationDetailForm.ShowModal;
 Result := ReservationDetailForm.ReturnFlag;
 if Result then
    ReserveNo := ReservationDetailForm.ReserveNo;
 ReservationDetailForm.Free;
end;

end.
