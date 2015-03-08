unit ReadOrderNo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DataUnit, UtilUnit, ADODB, GButton,
  Variants, ComCtrls, bsSkinCtrls, bsSkinTabs, XiButton;

type
  TReadOrderNoForm = class(TForm)
    Shape1: TShape;
    NoReadyShape: TShape;
    Shape3: TShape;
    Shape4: TShape;
    OrderQuery: TADOQuery;
    ReserveQuery: TADOQuery;
    TableQuery: TADOQuery;
    TempQuery: TADOQuery;
    BackPanel: TbsSkinPanel;
    TabControl: TbsSkinTabControl;
    WorkPanel: TbsSkinPanel;
    TablePanel: TPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    NoReadyLabel: TbsSkinStdLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    SearchOrderNoButton: TXiButton;
    CancelButton: TXiButton;
    EntreeShape: TShape;
    EntreeLabel: TbsSkinStdLabel;
    MainCourseShape: TShape;
    DesertShape: TShape;
    OthersShape: TShape;
    MainCourseLabel: TbsSkinStdLabel;
    DesertLabel: TbsSkinStdLabel;
    OthersLabel: TbsSkinStdLabel;
    procedure OpenQuery(SQLStr: string);
    procedure OpenTableQuery;
    procedure OpenOrderQuery(SQLStr: string);
    procedure OpenReserveQuery;
    procedure OpenTempQuery(SQLStr: string);
    procedure ReadTablePageInfo;
    procedure CreateTableImage;
    procedure AssignCaption;
    procedure RefreshTable;
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SearchOrderNoButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure GButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    function  ReadOrderNoPro(var OrderNo, BookingNo, TableNo: string;
              var TableSeats: integer; OpStatus: integer): boolean;
  private { Private declarations }
    TableSeats, OpStatus,  KindFlag: integer;
    OrderDate, OrderNo, TableNo, BookingNo: string;
    ReturnFlag: boolean;
    CurrentButton: TGButton;
    CurrentDateTime: TDateTime;
  public
    { Public declarations }
  end;

var
  ReadOrderNoForm: TReadOrderNoForm;
  CustomerName : String;

implementation

uses  OrderList, MessageBox, MainMenu;

{$R *.DFM}

procedure TReadOrderNoForm.OpenQuery(SQLStr: string);
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

procedure TReadOrderNoForm.OpenTableQuery;
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

procedure TReadOrderNoForm.OpenOrderQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with OrderQuery do
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

procedure TReadOrderNoForm.OpenReserveQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select TableNo, BookingDate, ExpireTime From BookTable ' +
           'Where BookingDate>=' + ConvertDateTime(CurrentDateTime + StrToTime('00:00:00')) +
           ' and BookingDate<=' + ConvertDateTime(CurrentDateTime + StrToTime('23:59:59')) +
           ' and ExpireTime >= ' + ConvertDateTime(Date + Time) +
           ' and (Kind=' + IntToStr(KindFlag) + ' or Kind=3) and Arrived = 0' +
           ' Group By TableNo, BookingDate, ExpireTime Order By TableNo';
 Screen.Cursor := crHourGlass;
 with ReserveQuery do
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

procedure TReadOrderNoForm.OpenTempQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with TempQuery do
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

procedure TReadOrderNoForm.RefreshTable;
var
 TableNo: String;
begin
 TableQuery.First;
 while Not TableQuery.EOF  do
  begin
   TableNo := DeleteSpace(TableQuery.FieldByName('TableNo').AsString);
   TGButton(FindComponent('Button' + TableNo)).Destroy;
   TableQuery.Next;
  end;
 CurrentButton := NIL;
end;

procedure TReadOrderNoForm.ReadTablePageInfo;
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

procedure TReadOrderNoForm.CreateTableImage;
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
   if (MinimumChargeKind = 2) and (TableQuery.FieldByName('MinimumChargePerTable').AsFloat >= 0.01) then
      Caption := Caption + Chr(13) + '$' + TableQuery.FieldByName('MinimumChargePerTable').AsString;
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
       if CheckTableStatus and Not TableQuery.FieldByName('Status').AsBoolean then
          Brush.Color := clFuchsia

         else
          //Brush.Color := clGreen;
          Brush.Color := clSkyBlue;
       Font.Color := clWhite;
       OnClick := GButtonClick;
      end
     else
      begin
       Brush.Color := clYellow;
       Font.Color := clBlack;
      end;
  end;
end;

procedure TReadOrderNoForm.AssignCaption;
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
          begin
           if CheckTableStatus and Not TableQuery.FieldByName('Status').AsBoolean then
              TempComponent.Brush.Color := clFuchsia
             else
              //TempComponent.Brush.Color := clGreen
              TempComponent.Brush.Color := clSkyBlue
          end
         else
          TempComponent.Brush.Color := clYellow;
      end;
   TableQuery.Next;
  end;

 ReserveQuery.First;
 while Not ReserveQuery.EOF do
  begin
   Temp := DeleteSpace(ReserveQuery.FieldByName('TableNo').AsString);
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
  ReserveQuery.Next;
 end;

 OrderQuery.First;
 while Not OrderQuery.EOF do
  begin
   TableNo := DeleteSpace(OrderQuery.FieldByName('TableNo').AsString);
   TempComponent := FindComponent('Button' + TableNo) As TGButton;
   TableQuery.Locate('TableNo', TableNo, [loPartialKey]);
   if TempComponent <> NIL then
      begin
       if OrderQuery.FieldByName('OrderPrinted').AsBoolean then
          TempComponent.Caption := '*' + TempComponent.Caption;
       case TableQuery.FieldByName('ServiceStatus').AsInteger of
        //1: TempComponent.Brush.Color := $0080FF80;
        1: TempComponent.Brush.Color := $0080FF81;
        2: TempComponent.Brush.Color := $009191FF;
        3: TempComponent.Brush.Color := $00FFFF80;
        4: TempComponent.Brush.Color := $00FFA54A;
       else
        TempComponent.Brush.Color := clPurple;
       end;
       if TempComponent.Brush.Color = clPurple then
          TempComponent.Font.Color := clWhite
         else
          TempComponent.Font.Color := clBlack;
       CustomerName := OrderQuery.FieldByName('CustomerName').AsString;
       if(CustomerName<>'') then
       begin
          TempComponent.Brush.Color := $00ffa54a;

          TempComponent.Caption := TableQuery.FieldByName('Description').AsString
                                   + Chr(13)+Chr(10)+CustomerName;
       end;
      end;
   OrderQuery.Next;
  end;
end;

procedure TReadOrderNoForm.GButtonClick(Sender: TObject);
var
 SQLStr, TableNum: string;
begin
 if CurrentButton <> NIL then CurrentButton.Pen.Width := 1;
 CurrentButton := Sender As TGButton;
 CurrentButton.Pen.Width := 2;
 with Sender As TGButton do TableNum := Copy(Name, 7, 15);
 case OpStatus of
  sNewTable: if (CurrentButton.Brush.Color = clPurple) or
                //(CurrentButton.Brush.Color = $0080FF80) or
                (CurrentButton.Brush.Color = $0080FF81) or
                (CurrentButton.Brush.Color = $009191FF) or
                (CurrentButton.Brush.Color = $00FFFF80) or
                (CurrentButton.Brush.Color = $00FFA54A) then
                begin
                 OrderQuery.Locate('TableNo', TableNum, [loPartialKey]);
                 OrderNo := OrderQuery.FieldByName('OrderNo').AsString;
                 BookingNo := '';
                 TableNo := TableNum;
                 TableSeats := 0;
                 ReturnFlag := True;
                 Close;
                end
              else
               if (CurrentButton.Brush.Color = clBlue) then
                  begin
                   OrderNo := '';
                   TableNo := TableNum;
                   {if BookingNoSelectForm.BookingNoSelectPro(BookingNo, TableNo, CurrentDateTime, KindFlag) then
                      begin
                       TableQuery.Locate('TableNo', TableNo, [loPartialKey]);
                       TableSeats := TableQuery.FieldByName('Seats').AsInteger;
                       ReturnFlag := True;
                       Close;
                      end;}
                  end
                 else
                  if (CurrentButton.Brush.Color <> clFuchsia) or
                     (MessageBoxForm.MessagePro('This Table is no ready, do you want to use the Table?', sConfirmMsg) = mrYes) then
                      begin
                       OrderNo := '';
                       BookingNo := '';
                       TableNo := TableNum;
                       TableQuery.Locate('TableNo', TableNo, [loPartialKey]);
                       TableSeats := TableQuery.FieldByName('Seats').AsInteger;
                       ReturnFlag := True;
                       Close;
                      end;
  sEditTable: if (CurrentButton.Brush.Color = clPurple) or
                 //(CurrentButton.Brush.Color = $0080FF80) or
                 (CurrentButton.Brush.Color = $0080FF81) or
                 (CurrentButton.Brush.Color = $009191FF) or
                 (CurrentButton.Brush.Color = $00FFFF80) or
                 (CurrentButton.Brush.Color = $00FFA54A) then
                begin
                 OrderQuery.Locate('TableNo', TableNum, [loPartialKey]);
                 OrderNo := OrderQuery.FieldByName('OrderNo').AsString;
                 TableNo := TableNum;
                 BookingNo := '';
                 TableSeats := 0;
                 ReturnFlag := True;
                 Close;
                end
               else
                if (CurrentButton.Brush.Color = clFuchsia) then
                   begin
                    SQLStr := 'Select Max(OrderNo) As OrderNo From OrderH ' +
                              'Where TableNo =' + Chr(39) + CheckQuotes(TableNum) + Chr(39) +
                              ' and OrderDate>=' + ConvertDateTime(CurrentDateTime + BeginTime);
                    OpenTempQuery(SQLStr);
                    with TempQuery do
                     if Active and (RecordCount > 0) and (FieldByName('OrderNo').AsString <> '') then
                        begin
                         OrderNo := FieldByName('OrderNo').AsString;
                         TableNo := TableNum;
                         BookingNo := '';
                         TableSeats := 0;
                         ReturnFlag := True;
                         ReadOrderNoForm.Close;
                        end;
                   end;
  //sChangeTable: if (CurrentButton.Brush.Color = clGreen) or (CurrentButton.Brush.Color = clBlue) or
  sChangeTable: if (CurrentButton.Brush.Color = clSkyBlue) or (CurrentButton.Brush.Color = clBlue) or
                   ((CurrentButton.Brush.Color = clFuchsia) and
                   (MessageBoxForm.MessagePro('This Table is no ready, do you want to use the Table?', sConfirmMsg) = mrYes)) then
                   begin
                    OrderNo := '';
                    TableNo := TableNum;
                    BookingNo := '';
                    TableSeats := 0;
                    ReturnFlag := True;
                    Close;
                   end;
 end;
end;

procedure TReadOrderNoForm.SearchOrderNoButtonClick(Sender: TObject);
begin
 if OrderListForm.OrderListPro(OrderNo, TableNo) then
    begin
     TableSeats := 0;
     ReturnFlag := True;
     Close;
    end;
end;

procedure TReadOrderNoForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TReadOrderNoForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TReadOrderNoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 TableQuery.Close;
 OrderQuery.Close;
 ReserveQuery.Close;
 Action := caFree;
end;

procedure TReadOrderNoForm.FormResize(Sender: TObject);
begin
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TReadOrderNoForm.TabControlChange(Sender: TObject);
begin
 RefreshTable;
 OpenTableQuery;
 AssignCaption;
end;

procedure TReadOrderNoForm.FormShow(Sender: TObject);
var
 SQLStr: string;
begin
 BookingNo := '';
 ReadTablePageInfo;
 if TabControl.Tabs.Count >= FVar.DefaultTablePage then
    TabControl.TabIndex := FVar.DefaultTablePage
   else
    TabControl.TabIndex := 0;
 OpenTableQuery;
 OrderDate := FormatDateTime('dd/mm/yyyy', Date);
 CurrentDateTime := TransferDate(OrderDate);
 if (Time < EndTime) and (EndTime < BeginTime) then CurrentDateTime := Date - 1;
 SQLStr := 'Select TableNo,CustomerName,OrderNo, OrderPrinted, ' +
           'Amount + ServiceCharge + OtherCharge + Tips + Surcharge - PaidAmount As Balance ' +
           'From OrderH Where Credit=0 and (PriceIncludesGST <> 0) and ' +
           '(Amount + ServiceCharge + Tips + Surcharge + OtherCharge - PaidAmount >= 0.01) and ' +
           'OrderDate>=' + ConvertDateTime(CurrentDateTime + BeginTime) +
           ' Union All ' +
           'Select TableNo,CustomerName,OrderNo, OrderPrinted, ' +
           'Amount + ServiceCharge + OtherCharge + Tips + Surcharge + GST - PaidAmount As Balance ' +
           'From OrderH Where Credit=0 and (PriceIncludesGST = 0) and ' +
           '(Amount + ServiceCharge + Tips + Surcharge + OtherCharge + GST - PaidAmount >= 0.01) and ' +
           'OrderDate>=' + ConvertDateTime(CurrentDateTime + BeginTime) +
           ' Order By TableNo';
 OpenOrderQuery(SQLStr);
 if Time < StrToTime('11:00') then KindFlag := 2
   else
    if Time < StrToTime('17:00') then KindFlag := 1
      else
        KindFlag := 0;
 OpenReserveQuery;
 AssignCaption;
 SearchOrderNoButton.Visible := OpStatus <> sChangeTable;
 NoReadyShape.Visible := CheckTableStatus;
 NoReadyLabel.Visible := CheckTableStatus;
 EntreeShape.Visible := CheckTableStatus;
 EntreeLabel.Visible := CheckTableStatus;
 MainCourseShape.Visible := CheckTableStatus;
 MainCourseLabel.Visible := CheckTableStatus;
 DesertShape.Visible := CheckTableStatus;
 DesertLabel.Visible := CheckTableStatus;
 OthersShape.Visible := CheckTableStatus;
 OthersLabel.Visible := CheckTableStatus;
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
end;

function TReadOrderNoForm.ReadOrdernoPro(var OrderNo, BookingNo, TableNo: string;
         var TableSeats: integer; OpStatus: integer): boolean;
begin
 Application.CreateForm(TReadOrderNoForm, ReadOrderNoForm);
 ReadOrderNoForm.OpStatus := OpStatus;
 ReadOrderNoForm.ShowModal;
 Result := ReadOrderNoForm.ReturnFlag;
 if Result then
    begin
     OrderNo := ReadOrderNoForm.OrderNo;
     BookingNo := ReadOrderNoForm.BookingNo;
     TableNo := ReadOrderNoForm.TableNo;
     TableSeats := ReadOrderNoForm.TableSeats;
    end;
 ReadOrderNoForm.Free;
end;

end.
