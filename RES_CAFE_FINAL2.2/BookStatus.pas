unit BookStatus;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DataUnit, UtilUnit, Mask, GButton,
  ADODB, ComCtrls, bsSkinCtrls, bsSkinTabs, XiButton, PanelButton;

type
  TBookStatusForm = class(TForm)
    Shape1: TShape;
    Shape2: TShape;
    DateEdit: TMaskEdit;
    TableQuery: TADOQuery;
    BookingQuery: TADOQuery;
    BackPanel: TbsSkinPanel;
    TabControl: TbsSkinTabControl;
    WorkPanel: TbsSkinPanel;
    TablePanel: TPanel;
    ButtonPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    ExitButton: TXiButton;
    DinnerButton: TPanelButton;
    LunchButton: TPanelButton;
    BreakfastButton: TPanelButton;
    OthersButton: TPanelButton;
    procedure OpenQuery(SQLStr: string);
    procedure OpenTableQuery;
    procedure OpenBookingQuery;
    procedure CreateTableImage;
    procedure RefreshTable;
    procedure AssignCaption;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DinnerButtonClick(Sender: TObject);
    procedure LunchButtonClick(Sender: TObject);
    procedure BreakfastButtonClick(Sender: TObject);
    procedure OthersButtonClick(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure GButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    function  ListBookingStatus(var TableNo: string; ViewFlag: boolean;
              KindFlag: integer; BookingDate: TDateTime): boolean;
    procedure TabControlChange(Sender: TObject);
    procedure ReadTablePageInfo;
    procedure SetKindButton;
  private { Private declarations }
    KindFlag: integer;
    TableNo: string;
    ReturnFlag, ViewFlag: boolean;
    CurrentButton: TGButton;
  public
    { Public declarations }
  end;

var
  BookStatusForm: TBookStatusForm;

implementation

uses DatePanel, MainMenu, ReservationDetail;

{$R *.DFM}

procedure TBookStatusForm.OpenQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with TableQuery do
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

procedure TBookStatusForm.OpenTableQuery;
var
 SQLStr: string;
begin
 if TabControl.TabIndex <= 0 then
    SQLStr := 'Select * From TableSet Where PageFlag=1 Order By TableNo'
   else
    SQLStr := 'Select * From TableSet Where PageFlag=' + IntToStr(TabControl.TabIndex + 1) +
              ' Order By TableNo';
 OpenQuery(SQLStr);
end;

procedure TBookStatusForm.ReadTablePageInfo;
var
 SQLStr: string;
begin
 TabControl.Tabs.Clear;
 SQLStr := 'Select * From TablePage Order By PageNo';
 OpenQuery(SQLStr);
 with TableQuery do
  begin
   if Active and (RecordCount > 1) then
      while Not EOF do
       begin
        TabControl.Tabs.Add(FieldByName('Description').AsString);
        Next;
       end;
   Close;
  end;
end;

procedure TBookStatusForm.OpenBookingQuery;
var
 SQLStr: string;
 DateTemp: TDateTime;
begin
 DateTemp := TransferDate(DateEdit.Text);
 SQLStr := 'Select TableNo  ' +
           'From BookTable Where BookingDate>=' +
           ConvertDateTime(DateTemp + StrToTime('00:01')) +
           ' and BookingDate<=' + ConvertDateTime(DateTemp + StrToTime('23:59')) +
           ' and Kind=' + IntToStr(KindFlag) + ' Group By TableNo Order By TableNo';
 Screen.Cursor := crHourGlass;
 with BookingQuery do
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

procedure TBookStatusForm.RefreshTable;
var
 TableNo: String;
begin
 TableQuery.First;
 while Not TableQuery.EOF  do
  begin
   TableNo := DeleteSpace(TableQuery.FieldByName('TableNo').AsString);
   with TGButton(FindComponent('Button' + TableNo)) do Destroy;
   TableQuery.Next;
  end;
 CurrentButton := Nil;
end;

procedure TBookStatusForm.CreateTableImage;
begin
 with TGButton.Create( Self ) do
  begin
   Parent := TablePanel;
   Left := TableQuery.FieldByName('ButtonX').AsInteger;
   Top := TableQuery.FieldByName('ButtonY').AsInteger;
   Width := TableQuery.FieldByName('ButtonWidth').AsInteger;
   Height := TableQuery.FieldByName('ButtonHeight').AsInteger;
   case TableQuery.FieldByName('ButtonShape').AsInteger of
    0: Shape := stCircle;
    1: Shape := stEllipse;
    2: Shape := stRectangle;
    3: Shape := stRoundRect;
    4: Shape := stRoundSquare;
    5: Shape := stSquare;
   end;
  Name := 'Button' + DeleteSpace(TableQuery.FieldByName('TableNo').AsString);
  Caption := TableQuery.FieldByName('Description').AsString;
  Font.Name := TableQuery.FieldByName('FontName').AsString;
  Font.Size := TableQuery.FieldByName('FontSize').AsInteger;
  Font.Style := [];
  if TableQuery.FieldByName('FontBold').AsBoolean then
     Font.Style := Font.Style + [fsBold];
  if TableQuery.FieldByName('FontItalic').AsBoolean then
     Font.Style := Font.Style + [fsItalic];
  if TableQuery.FieldByName('FontUnderline').AsBoolean then
     Font.Style := Font.Style + [fsUnderline];
  if TableQuery.FieldByName('FontStrikeout').AsBoolean then
     Font.Style := Font.Style + [fsStrikeout];
  if TableQuery.FieldByName('PropertyFlag').AsBoolean then
     begin
      Brush.Color := clGreen;
      Font.Color := clWhite;
      OnClick := GButtonClick;
     end
    else
     begin
      Brush.Color := clYellow;
      Font.Color := clBlack;
     end
 end;
end;

procedure TBookStatusForm.AssignCaption;
var
 I, J: integer;
 BookingTableNo: array [1..50] of string;
 TableNo, Temp: string;
 TempComponent: TGButton;
begin
 TableQuery.First;
 while Not TableQuery.Eof do
  begin
   TableNo := DeleteSpace(TableQuery.FieldByName('TableNo').AsString);
   TempComponent := FindComponent('Button' + TableNo) As TGButton;
   if TempComponent = NIL then CreateTableImage
     else
      begin
       if TableQuery.FieldByName('PropertyFlag').AsBoolean then
          TempComponent.Brush.Color := clGreen
         else
          TempComponent.Brush.Color := clYellow;
      end;
   TableQuery.Next;
  end;
 BookingQuery.First;
 while Not BookingQuery.EOF do
  begin
   Temp := DeleteSpace(BookingQuery.FieldByName('TableNo').AsString);
   for I := 1 to 50 do BookingTableNo[I] := '';
   I := 1; J := 1;
   while I <= Length(Temp) do
    begin
     if Temp[I] = ',' then
        J := J + 1
       else
        BookingTableNo[J] := BookingTableNo[J] + Temp[I];
     I := I + 1;
    end;
   for I := 1 to 50 do
    begin
     if BookingTableNo[I] <> '' then
        begin
         TempComponent := FindComponent('Button' + BookingTableNo[I]) As TGButton;
         if TempComponent <> NIL then TempComponent.Brush.Color := clBlue;
        end;
    end;
  BookingQuery.Next;
 end;
end;

procedure TBookStatusForm.SetKindButton;
begin
 DinnerButton.Color := $00DDF9E8;
 LunchButton.Color := $00DDF9E8;
 BreakfastButton.Color := $00DDF9E8;
 OthersButton.Color := $00DDF9E8;
 case KindFlag of
  0: DinnerButton.Color := $00E8E8FF;
  1: LunchButton.Color := $00E8E8FF;
  2: BreakfastButton.Color := $00E8E8FF;
  3: OthersButton.Color := $00E8E8FF;
 end;
end;

procedure TBookStatusForm.DinnerButtonClick(Sender: TObject);
begin
 KindFlag := 0;
 SetKindButton;
 OpenTableQuery;
 OpenBookingQuery;
 AssignCaption;
end;

procedure TBookStatusForm.LunchButtonClick(Sender: TObject);
begin
 KindFlag := 1;
 SetKindButton;
 OpenTableQuery;
 OpenBookingQuery;
 AssignCaption;
end;

procedure TBookStatusForm.BreakfastButtonClick(Sender: TObject);
begin
 KindFlag := 2;
 SetKindButton;
 OpenTableQuery;
 OpenBookingQuery;
 AssignCaption;
end;

procedure TBookStatusForm.OthersButtonClick(Sender: TObject);
begin
 KindFlag := 3;
 SetKindButton;
 OpenTableQuery;
 OpenBookingQuery;
 AssignCaption;
end;

procedure TBookStatusForm.DateEditClick(Sender: TObject);
var
 DateTemp: TDateTime;
begin
 with Sender As TMaskEdit do
  begin
   DateTemp := TransferDate(Text);
   if DateForm.ReadDatePro(DateTemp) then
      begin
       Text := FormatDateTime('dd/mm/yyyy', DateTemp);
       OpenTableQuery;
       OpenBookingQuery;
       AssignCaption;
      end;
  end;
end;

procedure TBookStatusForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TBookStatusForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 TableQuery.Close;
 BookingQuery.Close;
 Action := caFree;
end;

procedure TBookStatusForm.GButtonClick(Sender: TObject);
var
 ReserveNo: string;
 BookingDate: TDateTime;
begin
 if CurrentButton <> NIL then CurrentButton.Pen.Width := 1;
 CurrentButton := Sender As TGButton;
 CurrentButton.Pen.Width := 2;
 with Sender As TGButton do
  TableNo := Copy(Name, 7, 15);
 BookingDate := TransferDate(DateEdit.Text);
 if ((CurrentButton.Brush.Color <> clBlue) or
     ReservationDetailForm.ReservatioDetailPro(TableNo, ReserveNo, BookingDate, KindFlag))
     and Not ViewFlag then
    begin
     ReturnFlag := True;
     Close;
    end;
end;

procedure TBookStatusForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TBookStatusForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TBookStatusForm.TabControlChange(Sender: TObject);
begin
 RefreshTable;
 OpenTableQuery;
 AssignCaption;
end;

procedure TBookStatusForm.FormShow(Sender: TObject);
begin
 SetKindButton;
 ReadTablePageInfo;
 OpenTableQuery;
 OpenBookingQuery;
 AssignCaption;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

function TBookStatusForm.ListBookingStatus(var TableNo: string; ViewFlag: boolean;
         KindFlag: integer; BookingDate: TDateTime): boolean;
begin
 Application.CreateForm(TBookStatusForm, BookStatusForm);
 BookStatusForm.ViewFlag := ViewFlag;
 if KindFlag <= 3 then
    BookStatusForm.KindFlag := KindFlag
   else
    BookStatusForm.KindFlag := 0;
 BookStatusForm.DateEdit.Text := FormatDateTime('dd/mm/yyyy', BookingDate);
 BookStatusForm.ShowModal;
 Result := BookStatusForm.ReturnFlag;
 if Result then
    TableNo := BookStatusForm.TableNo;
 BookStatusForm.Free;
end;

end.
