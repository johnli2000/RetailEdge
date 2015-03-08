unit MenuPrintJobList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, Grids, Db, DataUnit, UtilUnit, ADODB, MainMenu,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TMenuPrintJobListForm = class(TForm)
    SourceStringGrid: TStringGrid;
    TargetStringGrid: TStringGrid;
    Query: TADOQuery;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    SourceStringGridPanel: TbsSkinPanel;
    TargetStringGridPanel: TbsSkinPanel;
    OneMoveToRightButton: TXiButton;
    AllMoveToRightButton: TXiButton;
    OneMoveToLeftButton: TXiButton;
    AllMoveToLeftButton: TXiButton;
    UpButton: TXiButton;
    DownButton: TXiButton;
    ConvertButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    TargetUpButton: TXiButton;
    TargetDownButton: TXiButton;
    procedure InitSourceStringGrid;
    procedure InitTargetStringGrid;
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure OpenQuery(SQLStr: string);
    procedure UpButtonClick(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure DeleteSourceLine(ARow: integer);
    procedure DeleteTargetLine(ARow: integer);
    function  FindSourceLastLine: integer;
    function  FindTargetLastLine: integer;
    procedure PostDataToSourceStringGrid;
    procedure OneMoveToRightButtonClick(Sender: TObject);
    procedure OneMoveToLeftButtonClick(Sender: TObject);
    procedure AllMoveToLeftButtonClick(Sender: TObject);
    procedure AllMoveToRightButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PrintJobListPro;
    procedure PrintButtonClick(Sender: TObject);
    procedure ConvertButtonClick(Sender: TObject);
    procedure TargetUpButtonClick(Sender: TObject);
    procedure TargetDownButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PrintJobList(OrderNo: string);
    procedure TargetStringGridDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
  private { Private declarations }
    OrderNo: string;
    Langurage: boolean;
  public
    { Public declarations }
  end;

var
  MenuPrintJobListForm: TMenuPrintJobListForm;

implementation

uses MessageBox, PrintJobCard, PrintJobCard1, PrintJobCard2, PrintJobCard3,
     PrintJobCard4, PrintCheckList, PrintJobCard5, SendToScreen,
  PrintJobListControl;

{$R *.DFM}

procedure TMenuPrintJobListForm.InitSourceStringGrid;
var
 I: integer;
begin
 with SourceStringGrid do
  begin
   Cells[0, 0] := 'Qty';
   Cells[1, 0] := 'Description';
   Cells[2, 0] := '';
   Cells[3, 0] := 'Description2';
   Cells[4, 0] := 'ID';
   for I := 1 to 500 do
    begin
     Cells[0, I] := ''; Cells[1, I] := '';
     Cells[2, I] := ''; Cells[3, I] := '';
     Cells[4, I] := '';
    end;
   Row := 1;
  end;
end;

procedure TMenuPrintJobListForm.InitTargetStringGrid;
var
 I: integer;
begin
 with TargetStringGrid do
  begin
   Cells[0, 0] := 'Qty';
   Cells[1, 0] := 'Description';
   Cells[2, 0] := 'Printed';
   Cells[3, 0] := 'Description2';
   Cells[4, 0] := 'ID';
   for I := 1 to 500 do
    begin
     Cells[0, I] := ''; Cells[1, I] := '';
     Cells[2, I] := ''; Cells[3, I] := '';
     Cells[4, I] := '';
    end;
   Row := 1;
  end;
end;

procedure TMenuPrintJobListForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   Canvas.Font.Size := 10;
   if ARow > 0 then
      begin
       Canvas.Font.Name := 'MS Sans Serif';
       Canvas.Font.Style := [];
       case ACol of
         1: begin
             SetTextAlign(Canvas.Handle, TA_LEFT);
             X := Rect.Left + 2;
             if Cells[2, ARow] <> '' then
                Canvas.Font.Style := [fsStrikeOut];
            end;
        else
          begin
           SetTextAlign(Canvas.Handle, TA_CENTER);
           X := (Rect.Left + Rect.Right) div 2;
          end;
       end;
      end
     else
      begin
       Canvas.Font.Name := 'Arial';
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TMenuPrintJobListForm.TargetStringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   Canvas.Font.Size := 10;
   if ARow > 0 then
      begin
       Canvas.Font.Name := 'MS Sans Serif';
       Canvas.Font.Style := [];
       case ACol of
         1: begin
             SetTextAlign(Canvas.Handle, TA_LEFT);
             X := Rect.Left + 2;
            end;
        else
          begin
           SetTextAlign(Canvas.Handle, TA_CENTER);
           X := (Rect.Left + Rect.Right) div 2;
          end;
       end;
      end
     else
      begin
       Canvas.Font.Name := 'Arial';
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TMenuPrintJobListForm.OpenQuery(SQLStr: string);
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

procedure TMenuPrintJobListForm.UpButtonClick(Sender: TObject);
begin
 WorkPanel.SetFocus;
 if SourceStringGrid.Row > 1 then
    SourceStringGrid.Row := SourceStringGrid.Row - 1;
end;

procedure TMenuPrintJobListForm.DownButtonClick(Sender: TObject);
var
 LastRow: integer;
begin
 WorkPanel.SetFocus;
 LastRow := FindSourceLastLine;
 if SourceStringGrid.Row < LastRow - 1 then
    SourceStringGrid.Row := SourceStringGrid.Row + 1;
end;

procedure TMenuPrintJobListForm.TargetUpButtonClick(Sender: TObject);
begin
 WorkPanel.SetFocus;
 if TargetStringGrid.Row > 1 then
    TargetStringGrid.Row := TargetStringGrid.Row - 1;
end;

procedure TMenuPrintJobListForm.TargetDownButtonClick(Sender: TObject);
var
 LastRow: integer;
begin
 WorkPanel.SetFocus;
 LastRow := FindTargetLastLine;
 if TargetStringGrid.Row < LastRow - 1 then
    TargetStringGrid.Row := TargetStringGrid.Row + 1;
end;

procedure TMenuPrintJobListForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TMenuPrintJobListForm.DeleteSourceLine(ARow: integer);
var
 I, J: Integer;
begin
 with SourceStringGrid do
  begin
   for I := ARow to 500 do
    for J := 0 to 4 do
     Cells[J, I] := Cells[J, I + 1];
   for J := 0 to 4 do Cells[J, 500] := '';
  end;
end;

procedure TMenuPrintJobListForm.DeleteTargetLine(ARow: integer);
var
 I, J: Integer;
begin
 with TargetStringGrid do
  begin
   for I := ARow to 500 do
    for J := 0 to 4 do
     Cells[J, I] := Cells[J, I + 1];
   for J := 0 to 4 do Cells[J, 500] := '';
  end;
end;

function  TMenuPrintJobListForm.FindSourceLastLine: integer;
var
 I, J, K: integer;
begin
 J := 1;
 with SourceStringGrid do
  for I := 1 to 500 do
   begin
    if Cells[0, I] <> '' then
       begin
        if J <> I then
           for K := 0 to 4 do
            Cells[K, J] := Cells[K, I];
        J := J + 1;
       end;
   end;
 if J <= 500 then
    Result := J
   else
    Result := 500;
end;

function  TMenuPrintJobListForm.FindTargetLastLine: integer;
var
 I, J, K: integer;
begin
 J := 1;
 with TargetStringGrid do
   for I := 1 to 500 do
    begin
     if Cells[0, I] <> '' then
        begin
         if J <> I then
            for K := 0 to 4 do
             Cells[K, J] := Cells[K, I];
         J := J + 1;
        end;
    end;
 if J <= 500 then
    Result := J
   else
    Result := 500;
end;

procedure TMenuPrintJobListForm.PostDataToSourceStringGrid;
var
 I: integer;
 SQLStr, FieldName: string;
begin
 InitSourceStringGrid;
 InitTargetStringGrid;
 SQLStr := 'Select Description1, Description2, Qty, PriceSelect, ' +
           'SubDescription, SubDescription1, SubDescription2, ' +
           'SubDescription3, PrintFlag, SentToKitchen, Multiple, IDNo ' +
           'From MenuItem, OrderI ' +
           'Where MenuItem.ItemCode=OrderI.ItemCode and Condition = 0 and ' +
           'OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39) +
           ' Order By IDNo';
 OpenQuery(SQLStr);
 I := 1;
 with SourceStringGrid do
  begin
   Query.First;
   while Not Query.EOF do
    begin
     Cells[0, I] := Format('%4.2f', [Query.FieldByName('Qty').AsFloat]);
     if Langurage or (Query.FieldByName('Description2').AsString = '') then
        begin
         Cells[1, I] := Query.FieldByName('Description1').AsString;
         Cells[3, I] := Query.FieldByName('Description2').AsString;
        end
       else
        begin
         Cells[3, I] := Query.FieldByName('Description1').AsString;
         Cells[1, I] := Query.FieldByName('Description2').AsString;
        end;
     if Query.FieldByName('Multiple').AsBoolean then
        begin
         FieldName := GenerateSubDescriptionFieldName(Query.FieldByName('PriceSelect').AsInteger);
         if Query.FieldByName(FieldName).AsString <> '' then
            begin
             Cells[1, I] := Cells[1, I] + '/' + Query.FieldByName(FieldName).AsString;
             if Cells[3, I] <> '' then Cells[3, I] := Cells[3, I] + '/' +
                Query.FieldByName(FieldName).AsString;
            end;
        end;
     if Query.FieldByName('PrintFlag').AsBoolean or Query.FieldByName('SentToKitchen').AsBoolean then
        Cells[2, I] := 'Y'
       else
        Cells[2, I] := '';
     Cells[4, I] := Query.FieldByName('IDNo').AsString;
     Query.Next;
     I := I + 1;
    end;
   Query.Close;
  end;
 SourceStringGrid.Row := 1;
 TargetStringGrid.Row := 1;
end;

procedure TMenuPrintJobListForm.OneMoveToRightButtonClick(Sender: TObject);
var
 SourceRow, TargetRow, LastRow: integer;
begin
 SourceRow := SourceStringGrid.Row;
 TargetRow := FindTargetLastLine;
 if SourceStringGrid.Cells[0, SourceRow] <> '' then
    begin
     TargetStringGrid.Cells[0, TargetRow] := SourceStringGrid.Cells[0, SourceRow];
     TargetStringGrid.Cells[1, TargetRow] := SourceStringGrid.Cells[1, SourceRow];
     TargetStringGrid.Cells[2, TargetRow] := SourceStringGrid.Cells[2, SourceRow];
     TargetStringGrid.Cells[3, TargetRow] := SourceStringGrid.Cells[3, SourceRow];
     TargetStringGrid.Cells[4, TargetRow] := SourceStringGrid.Cells[4, SourceRow];
     DeleteSourceLine(SourceRow);
     TargetStringGrid.Row := TargetRow;
     LastRow := FindSourceLastLine;
     if (SourceRow >= LastRow) then
        begin
         if LastRow > 1 then SourceStringGrid.Row := LastRow - 1
           else
            SourceStringGrid.Row := 1;
        end;
    end;
end;

procedure TMenuPrintJobListForm.OneMoveToLeftButtonClick(Sender: TObject);
var
 SourceRow, TargetRow, LastRow: integer;
begin
 SourceRow := FindSourceLastLine;
 TargetRow := TargetStringGrid.Row;
 if TargetStringGrid.Cells[0, TargetRow] <> '' then
    begin
     SourceStringGrid.Cells[0, SourceRow] := TargetStringGrid.Cells[0, TargetRow];
     SourceStringGrid.Cells[1, SourceRow] := TargetStringGrid.Cells[1, TargetRow];
     SourceStringGrid.Cells[2, SourceRow] := TargetStringGrid.Cells[2, TargetRow];
     SourceStringGrid.Cells[3, SourceRow] := TargetStringGrid.Cells[3, TargetRow];
     SourceStringGrid.Cells[4, SourceRow] := TargetStringGrid.Cells[4, TargetRow];
     SourceStringgrid.Row := SourceRow;
    end;
 DeleteTargetLine(TargetRow);
 LastRow := FindTargetLastLine;
 if TargetRow >= LastRow then
    begin
     if LastRow > 1 then TargetStringGrid.Row := LastRow - 1
       else
        TargetStringGrid.Row := 1;
    end;
end;

procedure TMenuPrintJobListForm.AllMoveToLeftButtonClick(Sender: TObject);
begin
 PostDataToSourceStringGrid;
end;

procedure TMenuPrintJobListForm.AllMoveToRightButtonClick(Sender: TObject);
var
 SourceRow, TargetRow: integer;
begin
 SourceRow := 1;
 TargetRow := FindTargetLastLine;
 while SourceRow <= 500 do
  begin
   if SourceStringGrid.Cells[0, SourceRow] <> '' then
      begin
       TargetStringGrid.Cells[0, TargetRow] := SourceStringGrid.Cells[0, SourceRow];
       TargetStringGrid.Cells[1, TargetRow] := SourceStringGrid.Cells[1, SourceRow];
       TargetStringGrid.Cells[2, TargetRow] := SourceStringGrid.Cells[2, SourceRow];
       TargetStringGrid.Cells[3, TargetRow] := SourceStringGrid.Cells[3, SourceRow];
       TargetStringGrid.Cells[4, TargetRow] := SourceStringGrid.Cells[4, SourceRow];
       TargetStringGrid.Row := TargetRow;
       TargetRow := TargetRow + 1;
      end;
   SourceRow := SourceRow + 1;
  end;
 InitSourceStringGrid;
end;

procedure TMenuPrintJobListForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := ExitButton.Top + 106;
 Langurage := True;
 PostDataToSourceStringGrid;
end;

procedure TMenuPrintJobListForm.PrintJobListPro;
var
 IDStr: string;
 I: integer;
begin
 IDStr := '';
 with TargetStringGrid do
  for I := 1 to 500 do
   if Cells[4, I] <> '' then
      begin
       if IDStr <> '' then IDStr := IDStr + ',';
       IDStr := IDStr + Cells[4, I];
      end;
 if IDStr <> '' then
    begin
     PrintJobListControlForm.PrintJobListControlPro(OrderNo, IDStr, False, sConfirmedOrder);
     if AutoPrintCheckList then
        PrintCheckListForm.PrintCheckList(OrderNo, IDStr, False, sConfirmedOrder);
     if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(OrderNo, IDStr, False);
    end;
 Langurage := True;
 PostDataToSourceStringGrid;
end;

procedure TMenuPrintJobListForm.PrintButtonClick(Sender: TObject);
begin
 WorkPanel.SetFocus;
 PrintJobListPro;
end;

procedure TMenuPrintJobListForm.ConvertButtonClick(Sender: TObject);
var
 I: integer;
 StrTemp: string;
begin
 Langurage := Not Langurage;
 for I := 1 to 500 do
  with SourceStringGrid do
   if Cells[3, I] <> '' then
      begin
       StrTemp := Cells[3, I];
       Cells[3, I] := Cells[1, I];
       Cells[1, I] := StrTemp;
      end;
 for I := 1 to 500 do
  with TargetStringGrid do
   if Cells[3, I] <> '' then
      begin
       StrTemp := Cells[3, I];
       Cells[3, I] := Cells[1, I];
       Cells[1, I] := StrTemp;
      end;
end;

procedure TMenuPrintJobListForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TMenuPrintJobListForm.PrintJobList(OrderNo: string);
begin
 Application.CreateForm(TMenuPrintJobListForm, MenuPrintJobListForm);
 MenuPrintJobListForm.OrderNo := OrderNo;
 MenuPrintJobListForm.ShowModal;
 MenuPrintJobListForm.Free;
end;

end.
