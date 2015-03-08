unit TableStatus;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DataUnit, UtilUnit, ADODB, GButton,
  ComCtrls, bsSkinCtrls, bsSkinTabs, XiButton, PanelButton, bsSkinData;

type
  TTableStatusForm = class(TForm)
    TableQuery: TADOQuery;
    OrderQuery: TADOQuery;
    BackPanel: TbsSkinPanel;
    TabControl: TbsSkinTabControl;
    WorkPanel: TbsSkinPanel;
    TablePanel: TPanel;
    TableNoPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    TableNoEdit: TbsSkinLabel;
    ExitButton: TXiButton;
    DetailButton: TXiButton;
    ElapseTimeButton: TXiButton;
    ReadyButton: TPanelButton;
    NoReadyButton: TPanelButton;
    UnavailableButton: TPanelButton;
    EntreeButton: TPanelButton;
    MainCourseButton: TPanelButton;
    DesertButton: TPanelButton;
    OtherButton: TPanelButton;
    TableStatusPanel: TbsSkinPanel;
    bsCompressedStoredSkin1: TbsCompressedStoredSkin;
    TableStatusLegendPanel: TbsSkinPanel;
    Shape1: TShape;
    Shape2: TShape;
    bsSkinStdLabel2: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    UnLockTableButton: TXiButton;
    procedure OpenQuery(SQLStr: string);
    procedure OpenTableQuery;
    procedure OpenOrderQuery;
    procedure AssignCaption;
    procedure ReadTablePageInfo;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TableStatusPro(OrderDate: string);
    procedure ReadyButtonClick(Sender: TObject);
    procedure RefreshTable;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure CreateTableImage(TableColor, OrderPrinted: integer);
    procedure GButtonClick(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure NoReadyButtonClick(Sender: TObject);
    procedure DetailButtonClick(Sender: TObject);
    procedure ElapseTimeButtonClick(Sender: TObject);
    procedure UnavailableButtonClick(Sender: TObject);
    procedure EntreeButtonClick(Sender: TObject);
    procedure MainCourseButtonClick(Sender: TObject);
    procedure DesertButtonClick(Sender: TObject);
    procedure OtherButtonClick(Sender: TObject);
    procedure UnLockTableButtonClick(Sender: TObject);
  private { Private declarations }
    OrderDate, CurrentOrderNo: string;
    CurrentButton: TGButton;
  public
    { Public declarations }
  end;

var
  TableStatusForm: TTableStatusForm;

implementation

uses  OrderList, MessageBox, MainMenu, SaleshistoryDetail,
  ElapseTime;

{$R *.DFM}

procedure TTableStatusForm.OpenQuery(SQLStr: string);
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

procedure TTableStatusForm.OpenTableQuery;
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

procedure TTableStatusForm.OpenOrderQuery;
var
 SQLStr: string;
 DateTemp: TDateTime;
begin
 DateTemp := TransferDate(OrderDate);
 if (Time < EndTime) and (EndTime < BeginTime) then DateTemp := Date - 1;
 SQLStr := 'Select TableNo, OrderNo, OrderPrinted From OrderH ' +
           'Where (Credit=0) and (PriceIncludesGST <> 0) and ' +
           '(Amount + ServiceCharge + OtherCharge + Tips + Surcharge - PaidAmount >= 0.01) and ' +
           '(OrderDate>=' + ConvertDateTime(DateTemp + BeginTime) + ') ' +
           ' Union All ' +
           'Select TableNo, OrderNo, OrderPrinted From OrderH ' +
           'Where (Credit=0) and (PriceIncludesGST = 0) and ' +
           '(Amount + ServiceCharge + OtherCharge + GST + Tips + Surcharge - PaidAmount >= 0.01) and ' +
           '(OrderDate>=' + ConvertDateTime(DateTemp + BeginTime) + ') ' +
           ' Order By TableNo';
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

procedure TTableStatusForm.ReadTablePageInfo;
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

procedure TTableStatusForm.CreateTableImage(TableColor, OrderPrinted: integer);
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
  if OrderPrinted = 1 then Caption := '*' + Caption;
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
      Brush.Color := TableColor;
      //if (TableColor = clPurple) or (TableColor = clGreen) or (TableColor = clFuchsia) then
       if (TableColor = clPurple) or (TableColor = clSkyBlue) or (TableColor = clFuchsia) then
         Font.Color := clWhite
        else
         Font.Color := clBlack;
      OnClick := GButtonClick;
     end
    else
     begin
      Brush.Color := clYellow;
      Font.Color := clBlack;
     end
  end;
end;

procedure TTableStatusForm.AssignCaption;
var
 TableColor, OrderPrinted: integer;
 TableNo: string;
begin
 TableQuery.First;
 while Not TableQuery.Eof do
  begin
   TableNo := DeleteSpace(TableQuery.FieldByName('TableNo').AsString);
   OrderQuery.Locate('TableNo', TableNo, [loPartialKey]);
   OrderPrinted := 0;
   if DeleteSpace(OrderQuery.FieldByName('TableNo').AsString) = TableNo then
      begin
       if OrderQuery.FieldByName('OrderPrinted').AsBoolean then
          OrderPrinted := 1;
       case TableQuery.FieldByName('ServiceStatus').AsInteger of
        //1: TableColor := $0080FF80;
        1: TableColor := $0080FF81;
        2: TableColor := $009191FF;
        3: TableColor := $00FFFF80;
        4: TableColor := $00FFA54A;
       else
        TableColor := clPurple;
       end;
      end
     else
      if CheckTableStatus and Not TableQuery.FieldByName('Status').AsBoolean then
         TableColor := clFuchsia
        else
         //TableColor := clGreen;
         TableColor := clSkyBlue;
   CreateTableImage(TableColor, OrderPrinted);
   TableQuery.Next;
  end
end;

procedure TTableStatusForm.RefreshTable;
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

procedure TTableStatusForm.TabControlChange(Sender: TObject);
begin
 RefreshTable;
 OpenTableQuery;
 AssignCaption;
 TableNoEdit.Caption := '';
end;

procedure TTableStatusForm.GButtonClick(Sender: TObject);
var
 TableNo: string;
begin
 if CurrentButton <> NIL then CurrentButton.Pen.Width := 1;
 with Sender As TGButton do TableNo := Copy(Name, 7, 15);
 CurrentButton := Sender As TGButton;
 CurrentButton.Pen.Width := 2;
 TableNoEdit.Caption := TableNo;
 OrderQuery.Locate('TableNo', TableNo, [loPartialKey]);
 with OrderQuery do
  if Active and (RecordCount >= 1) and (DeleteSpace(FieldByName('TableNo').AsString) =  TableNo) then
     CurrentOrderNo := FieldByName('OrderNo').AsString
    else
     CurrentOrderNo := '';
end;

procedure TTableStatusForm.ReadyButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if TableNoEdit.Caption = '' then Exit;
 if CurrentOrderNo <> '' then
    begin
     MessageBoxForm.MessagePro('This table has not been paid yet!', sErrorMsg);
     Exit;
    end;
 SQLStr := 'Update TableSet Set Status = 1 ' +
           'Where TableNo=' + Chr(39) + CheckQuotes(TableNoEdit.Caption) + Chr(39);
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := DataForm.ExecQueryPro(SQLStr);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      //CurrentButton.Brush.Color := clGreen;
      CurrentButton.Brush.Color := clSkyBlue;
      CurrentButton.Font.Color := clWhite;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TTableStatusForm.NoReadyButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if TableNoEdit.Caption = '' then Exit;
 if CurrentOrderNo <> '' then
    begin
     MessageBoxForm.MessagePro('This table has not been paid yet!', sErrorMsg);
     Exit;
    end;
 SQLStr := 'Update TableSet Set Status = 0, ServiceStatus = 0 ' +
           'Where TableNo=' + Chr(39) + CheckQuotes(TableNoEdit.Caption) + Chr(39);
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;
 try
  Flag := DataForm.ExecQueryPro(SQLStr);
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      CurrentButton.Brush.Color := clFuchsia;
      CurrentButton.Font.Color := clWhite;
     end
    else
     DataForm.RollBack;
 end;
end;

procedure TTableStatusForm.UnavailableButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if (TableNoEdit.Caption <> '') and (CurrentOrderNo <> '') then
    begin
     SQLStr := 'Update TableSet Set ServiceStatus = 0 ' +
               'Where TableNo=' + Chr(39) + CheckQuotes(TableNoEdit.Caption) + Chr(39);
     Flag := False;
     if Not DataForm.BeginTransaction then Exit;
        try
         Flag := DataForm.ExecQueryPro(SQLStr);
        finally
         if Flag then
            begin
             DataForm.CommitTransaction;
             CurrentButton.Brush.Color := clPurple;
             CurrentButton.Font.Color := clWhite;
            end
           else
            DataForm.RollBack;
        end;
    end;
end;

procedure TTableStatusForm.EntreeButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if (TableNoEdit.Caption <> '') and (CurrentOrderNo <> '') then
    begin
     SQLStr := 'Update TableSet Set ServiceStatus = 1 ' +
               'Where TableNo=' + Chr(39) + CheckQuotes(TableNoEdit.Caption) + Chr(39);
     Flag := False;
     if Not DataForm.BeginTransaction then Exit;
        try
         Flag := DataForm.ExecQueryPro(SQLStr);
        finally
         if Flag then
            begin
             DataForm.CommitTransaction;
             //CurrentButton.Brush.Color := $0080FF80;
             CurrentButton.Brush.Color := $0080FF81;
             CurrentButton.Font.Color := clBlack;
            end
           else
            DataForm.RollBack;
        end;
    end;
end;

procedure TTableStatusForm.MainCourseButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if (TableNoEdit.Caption <> '') and (CurrentOrderNo <> '') then
    begin
     SQLStr := 'Update TableSet Set ServiceStatus = 2 ' +
               'Where TableNo=' + Chr(39) + CheckQuotes(TableNoEdit.Caption) + Chr(39);
     Flag := False;
     if Not DataForm.BeginTransaction then Exit;
        try
         Flag := DataForm.ExecQueryPro(SQLStr);
        finally
         if Flag then
            begin
             DataForm.CommitTransaction;
             CurrentButton.Brush.Color := $009191FF;
             CurrentButton.Font.Color := clBlack;
            end
           else
            DataForm.RollBack;
        end;
    end;
end;

procedure TTableStatusForm.DesertButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if (TableNoEdit.Caption <> '') and (CurrentOrderNo <> '') then
    begin
     SQLStr := 'Update TableSet Set ServiceStatus = 3 ' +
               'Where TableNo=' + Chr(39) + CheckQuotes(TableNoEdit.Caption) + Chr(39);
     Flag := False;
     if Not DataForm.BeginTransaction then Exit;
        try
         Flag := DataForm.ExecQueryPro(SQLStr);
        finally
         if Flag then
            begin
             DataForm.CommitTransaction;
             CurrentButton.Brush.Color := $00FFFF80;
             CurrentButton.Font.Color := clBlack;
            end
           else
            DataForm.RollBack;
        end;
    end;
end;

procedure TTableStatusForm.OtherButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if (TableNoEdit.Caption <> '') and (CurrentOrderNo <> '') then
    begin
     SQLStr := 'Update TableSet Set ServiceStatus = 4 ' +
               'Where TableNo=' + Chr(39) + CheckQuotes(TableNoEdit.Caption) + Chr(39);
     Flag := False;
     if Not DataForm.BeginTransaction then Exit;
        try
         Flag := DataForm.ExecQueryPro(SQLStr);
        finally
         if Flag then
            begin
             DataForm.CommitTransaction;
             CurrentButton.Brush.Color := $00FFA54A;
             CurrentButton.Font.Color := clBlack;
            end
           else
            DataForm.RollBack;
        end;
    end;
end;

procedure TTableStatusForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TTableStatusForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 TableQuery.Close;
 OrderQuery.Close;
 Action := caFree;
end;

procedure TTableStatusForm.DetailButtonClick(Sender: TObject);
begin
 if CurrentOrderNo <> '' then
    SalesHistoryDetailForm.SalesDetailPro(CurrentOrderNo);
end;

procedure TTableStatusForm.ElapseTimeButtonClick(Sender: TObject);
begin
 if CurrentOrderNo <> '' then
    ElapseTimeForm.ShowElapseDateTimePro(CurrentOrderNo);
end;

procedure TTableStatusForm.UnLockTableButtonClick(Sender: TObject);
begin
 if (TableNoEdit.Caption <> '') and TableLockFunctionEnabled then
    begin
     if MessageBoxForm.MessagePro('Are you sure you want to release this Table?', sConfirmMsg) = mrYes then
        begin
         if DataForm.ReleaseTable(TableNoEdit.Caption) then
            MessageBoxForm.MessagePro('This table has been released successful!', sInformationMsg)
           else
            MessageBoxForm.MessagePro('Can not release this Table!', sErrorMsg)
        end;
    end;
end;

procedure TTableStatusForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TTableStatusForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - 1024) div 2;
 BackPanel.Top := (Screen.Height - 768) div 2;
end;

procedure TTableStatusForm.FormShow(Sender: TObject);
begin
 ReadTablePageInfo;
 if TabControl.Tabs.Count >= FVar.DefaultTablePage then
    TabControl.TabIndex := FVar.DefaultTablePage
   else
    TabControl.TabIndex := 0;
 OpenTableQuery;
 OpenOrderQuery;
 AssignCaption;
 TableNoEdit.Caption := '';
 CurrentOrderNo := '';
 ReadyButton.Caption := 'Ready';
 NoReadyButton.Caption := 'No' + Chr(10) + Chr(13) + 'Ready';
 UnavailableButton.Caption := 'No' + Chr(13) + Chr(10) + 'Available';
 EntreeButton.Caption := 'Entree';
 MainCourseButton.Caption := 'Main' + Chr(13) + Chr(10) + 'Course';
 DesertButton.Caption := 'Dessert';
 OtherButton.Caption := 'Others';
 ElapseTimeButton.Caption := 'Elapse' + Chr(13) + Chr(10) + 'Time';
 UnLockTableButton.Caption := 'Release' + Chr(13) + Chr(10) + 'Table';
 ReadyButton.Visible := CheckTableStatus;
 NoReadyButton.Visible := CheckTableStatus;
 UnavailableButton.Visible := CheckTableStatus;
 EntreeButton.Visible := CheckTableStatus;
 MainCourseButton.Visible := CheckTableStatus;
 DesertButton.Visible := CheckTableStatus;
 OtherButton.Visible := CheckTableStatus;
 TableStatusPanel.Visible := CheckTableStatus;
 TableStatusLegendPanel.Visible := Not CheckTableStatus;
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
end;

procedure TTableStatusForm.TableStatusPro(OrderDate: string);
begin
 Application.CreateForm(TTableStatusForm, TableStatusForm);
 TableStatusForm.OrderDate := OrderDate;
 TableStatusForm.ShowModal;
 TableStatusForm.Free;
end;

end.
