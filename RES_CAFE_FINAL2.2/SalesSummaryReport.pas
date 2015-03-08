unit SalesSummaryReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, Mask, DataUnit,
  UtilUnit, TeeProcs, TeEngine, Chart, DBChart, Series, ComCtrls,
  ADODB, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  ReportType = Record
   Description: string;
   Detail: Boolean;
   Qty, AmountInc, AmountEx, Percent: double;
  end;
  TSalesSummaryReportForm = class(TForm)
    DateEdit1: TMaskEdit;
    Label4: TLabel;
    DateEdit2: TMaskEdit;
    SummaryComboBox: TComboBox;
    StringGrid: TStringGrid;
    Label1: TLabel;
    TimeEdit1: TMaskEdit;
    TimeEdit2: TMaskEdit;
    MachineIDCheckBox: TCheckBox;
    MachineIDEdit: TEdit;
    Query: TADOQuery;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    StringGridPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    SearchButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    procedure InitStringGrid;
    procedure InitReportBuf;
    procedure OpenQuery(SQLStr: string);
    procedure PostDataToBuffer;
    procedure PostDataToStringGrid;
    procedure SearchButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SalesReportPro;
    procedure ExitButtonClick(Sender: TObject);
    procedure DateCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DateEdit1Exit(Sender: TObject);
    procedure DateEdit2Exit(Sender: TObject);
    procedure DateEditClick(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure PrintButtonClick(Sender: TObject);
    procedure TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimeEditClick(Sender: TObject);
    procedure MachineIDCheckBoxClick(Sender: TObject);
    procedure MachineIDEditClick(Sender: TObject);
  private { Private declarations }
    DateTemp1, DateTemp2: TDateTime;
    TotalSales: double;
  public { Public declarations }
    RecordCount: integer;
    ReportBuf: Array [1..15000] of ReportType;
  end;

var
  SalesSummaryReportForm: TSalesSummaryReportForm;

implementation

uses MainMenu, DatePanel, PrintSalesSummaryReport, TimePanel, MachineIDSelect;

{$R *.DFM}

procedure TSalesSummaryReportForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   if RecordCount < 24 then
      RowCount := 24
     else
      RowCount := RecordCount + 1;
   Cells[0, 0] := 'Description';
   Cells[1, 0] := 'Qty';
   Cells[2, 0] := 'Amount (Inc)';
   Cells[3, 0] := 'Amount (Ex)';
   Cells[4, 0] := '%';
   Row := 1; Col := 0;
   for I := 1 to RowCount do
    begin
     Cells[0, I] := ''; Cells[1, I] := '';
     Cells[2, I] := ''; Cells[3, I] := '';
     Cells[4, I] := '';
    end;
  end;
end;

procedure TSalesSummaryReportForm.InitReportBuf;
var
 I: integer;
begin
 for I := 1 to 15000 do
  with ReportBuf[I] do
   begin
    Description := '';
    Qty := 0;
    AmountInc := 0;
    AmountEx := 0;
    Percent := 0;
    Detail := False;
   end;
end;

procedure TSalesSummaryReportForm.StringGridDrawCell(Sender: TObject; ACol,
          ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   if ARow > 0 then
      begin
       case ACol of
         0: begin
             SetTextAlign(Canvas.Handle, TA_LEFT);
             X := Rect.Left + 2;
            end;
        else
          begin
           SetTextAlign(Canvas.Handle, TA_RIGHT);
           X := Rect.Right - 2;
          end
       end;
       if Not ReportBuf[ARow].Detail then
          begin
           if (ARow <> StringGrid.Row) or (ACOL <> StringGrid.Col) then
              Canvas.Font.Color := clTeal
             else
              Canvas.Font.Color := clYellow;
           if ACol > 0 then
              Canvas.Font.Style := [fsUnderline]
             else
              Canvas.Font.Style := []
          end
         else
          begin
           Canvas.Font.Style := [];
           if (ARow <> StringGrid.Row) or (ACOL <> StringGrid.Col) then
              Canvas.Font.Color := clBlack
             else
              Canvas.Font.Color := clWhite;
          end;
      end
     else
      begin
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    if State = [gdSelected] then Canvas.Font.Color := clWhite;  
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TSalesSummaryReportForm.OpenQuery(SQLStr: string);
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

procedure TSalesSummaryReportForm.PostDataToBuffer;
var
 I, J: integer;
 X: string;
 TotalInc, TotalEx, AmountInc, AmountEx: double;
 TotalQty : double;
begin
 ReportBuf[1].Description := 'TOTAL SALES';
 ReportBuf[1].Detail := False;
 I := 2; J := 2; X := ''; TotalInc := 0; TotalEx := 0; AmountInc := 0; AmountEx := 0; TotalQty:=0;
 with Query do
  begin
   while Not EOF do
    begin
     if ((I <> J) and (X <> FieldByName('X').AsString)) or (I = 2) then
        begin
         ReportBuf[J].AmountInc := AmountInc;
         ReportBuf[J].AmountEx := AmountEx;
         ReportBuf[J].Qty := TotalQty;
         if ABS(TotalSales) > 0.01 then
            ReportBuf[J].Percent := StrToFloat(Format('%4.2f', [AmountInc / TotalSales * 100]))
           else
            ReportBuf[J].Percent := 0;
         AmountInc := 0; AmountEx := 0; TotalQty := 0;
         X := FieldByName('X').AsString;
         ReportBuf[I].Description := '   ' + X;
         ReportBuf[I].Detail := False;
         J := I;
         I := I + 1;
        end;
     ReportBuf[I].Description := '      ' + FieldByName('Y').AsString;
     if SummaryComboBox.ItemIndex = 0 then
        case FieldByName('PriceSelect').AsInteger of
         0: if FieldByName('SubDescription').AsString <> '' then
               ReportBuf[I].Description :=
                ReportBuf[I].Description + '/' + FieldByName('SubDescription').AsString;
         1: if FieldByName('SubDescription1').AsString <> '' then
               ReportBuf[I].Description :=
                ReportBuf[I].Description + '/' + FieldByName('SubDescription1').AsString;
         2: if FieldByName('SubDescription2').AsString <> '' then
               ReportBuf[I].Description :=
                ReportBuf[I].Description + '/' + FieldByName('SubDescription2').AsString;
         3: if FieldByName('SubDescription3').AsString <> '' then
               ReportBuf[I].Description :=
                ReportBuf[I].Description + '/' + FieldByName('SubDescription3').AsString;
        end;
     ReportBuf[I].Qty := FieldByName('TotalQty').AsFloat;
     ReportBuf[I].AmountInc := FieldByName('Amount').AsFloat;
     if FieldByName('TaxRate').AsFloat >= 1 then
        ReportBuf[I].AmountEx := FieldByName('Amount').AsFloat / (1 + 1 / FieldByName('TaxRate').AsFloat)
       else
        ReportBuf[I].AmountEx := ReportBuf[I].AmountInc;
     ReportBuf[I].Detail := True;
     AmountInc := AmountInc + ReportBuf[I].AmountInc;
     AmountEx := AmountEx + ReportBuf[I].AmountEx;
     TotalInc := TotalInc + ReportBuf[I].AmountInc;
     TotalEx := TotalEx + ReportBuf[I].AmountEx;
     TotalQty := TotalQty + ReportBuf[I].Qty;
     I := I + 1;
     Next;
    end;
   if I > J + 1 then
      begin
       ReportBuf[J].AmountInc := AmountInc;
       ReportBuf[J].AmountEx := AmountEx;
       ReportBuf[J].Qty := TotalQty;
       if ABS(TotalSales) > 0.01 then
          ReportBuf[J].Percent := StrToFloat(Format('%4.2f', [AmountInc / TotalSales * 100]))
         else
          ReportBuf[J].Percent := 0;
      end;
   ReportBuf[1].AmountInc := TotalInc;
   ReportBuf[1].AmountEx := TotalEx;
   ReportBuf[1].Qty := TotalQty;
   Close;
  end;
 RecordCount := I;
end;

procedure TSalesSummaryReportForm.PostDataToStringGrid;
var
 I: integer;
begin
 for I := 1 to RecordCount - 1 do
  begin
   StringGrid.Cells[0, I] := ReportBuf[I].Description;
   //if ReportBuf[I].Detail then
   StringGrid.Cells[1, I] := Format('%4.2f', [ReportBuf[I].Qty]);
   StringGrid.Cells[2, I] := Format('%4.2f', [ReportBuf[I].AmountInc]);
   StringGrid.Cells[3, I] := Format('%4.2f', [ReportBuf[I].AmountEx]);
   if Abs(ReportBuf[I].Percent) >= 0.01 then
      StringGrid.Cells[4, I] := Format('%4.2f%%', [ReportBuf[I].Percent]);
  end;
end;

procedure TSalesSummaryReportForm.SearchButtonClick(Sender: TObject);
var
 SQLStr: string;
begin
 DateTemp1 := TransferDate(DateEdit1.Text) + StrToTime(TimeEdit1.Text);
 DateTemp2 := TransferDate(DateEdit2.Text) + StrToTime(TimeEdit2.Text);
 SQLStr := 'Select Sum(OrderI.Price * (1 - OrderI.Discount / 100) * Qty) ' +
           'From OrderH, OrderI ' +
           ' Where OrderDate>=' + ConvertDateTime(DateTemp1) +
           ' and OrderDate<=' + ConvertDateTime(DateTemp2) +
           ' and OrderI.OrderNo=OrderH.OrderNo';
 if MachineIDCheckBox.Checked then
    SQLStr := SQLStr + ' and MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39);
 OpenQuery(SQLStr);
 TotalSales := Query.Fields[0].AsFloat;
 case SummaryComboBox.ItemIndex of
  0: begin
      SQLStr := 'Select MenuItem.ItemGroup As X, MenuItem.ItemCode, ' +
                'Description1 As Y, SubDescription, SubDescription1, ' +
                'SubDescription2, SubDescription3, PriceSelect, OrderI.TaxRate, ' +
                'Sum(OrderI.Qty) As TotalQty, ' +
                'Sum(OrderI.Price * (1 - OrderI.Discount / 100) * Qty) As Amount ' +
                'From MenuItem, OrderI, OrderH, ItemGroupTable ' +
                'Where MenuItem.ItemCode=OrderI.ItemCode ' +
                ' and OrderH.OrderNo=OrderI.OrderNo ' +
                ' and OrderDate>=' + ConvertDateTime(DateTemp1) +
                ' and OrderDate<=' + ConvertDateTime(DateTemp2) +
                ' and MenuItem.ItemGroup = ItemGroupTable.GroupName ' +
                ' and OrderI.Qty <> 0 and OrderI.Price <> 0';
      if MachineIDCheckBox.Checked then
         SQLStr := SQLStr + ' and MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39);
      SQLStr := SQLStr + ' Group By MenuItem.ItemGroup, MenuItem.ItemCode, ' +
                ' Description1, SubDescription, SubDescription1, ' +
                'SubDescription2, SubDescription3, PriceSelect, OrderI.TaxRate ' +
                'Order By MenuItem.ItemGroup, MenuItem.ItemCode';
     end;
  1: begin
      SQLStr := 'Select Category.Code, OrderOperator As X, OrderI.TaxRate, ' +
                'MenuItem.Category As Y, Sum(OrderI.Qty) As TotalQty, ' +
                'Sum(OrderI.Price * (1 - OrderI.Discount / 100) * Qty) As Amount ' +
                'From OrderH, OrderI, MenuItem, Category ' +
                ' Where OrderDate>=' + ConvertDateTime(DateTemp1) +
                ' and OrderDate<=' + ConvertDateTime(DateTemp2) +
                ' and OrderI.OrderNo=OrderH.OrderNo ' +
                ' and MenuItem.ItemCode=OrderI.ItemCode ' +
                ' and MenuItem.Category = Category.Category ' +
                ' and OrderI.Qty <> 0 and OrderI.Price <> 0';
      if MachineIDCheckBox.Checked then
         SQLStr := SQLStr + ' and MachineID=' + Chr(39) + CheckQuotes(MachineIDEdit.Text) + Chr(39);
      SQLStr := SQLStr + ' Group By OrderOperator, MenuItem.Category, ' +
                'Category.Code, OrderI.TaxRate Order By OrderOperator, Code ';
     end;
 end;
 InitReportBuf;
 OpenQuery(SQLStr);
 PostDataToBuffer;
 InitStringGrid;
 PostDataToStringGrid;
end;

procedure TSalesSummaryReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
 SalesSummaryReportForm := Nil;
end;

procedure TSalesSummaryReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TSalesSummaryReportForm.DateCheckBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit1.SetFocus;
end;

procedure TSalesSummaryReportForm.DateEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit1.SetFocus;
end;

procedure TSalesSummaryReportForm.DateEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then TimeEdit2.SetFocus;
end;

procedure TSalesSummaryReportForm.TimeEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then DateEdit2.SetFocus;
end;

procedure TSalesSummaryReportForm.TimeEdit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then SearchButton.SetFocus;
end;

procedure TSalesSummaryReportForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TSalesSummaryReportForm.DateEdit1Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit1.Text) then DateEdit1.SetFocus;
end;

procedure TSalesSummaryReportForm.DateEdit2Exit(Sender: TObject);
begin
 if Not CheckDate(DateEdit2.Text) then DateEdit2.SetFocus;
end;

procedure TSalesSummaryReportForm.DateEditClick(Sender: TObject);
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

procedure TSalesSummaryReportForm.TimeEditClick(Sender: TObject);
var
 TimeStr: string;
begin
 with Sender As TMaskEdit do
  begin
   TimeStr := Text;
   if TimeForm.ReadTimePro(TimeStr) then
      Text := TimeStr;
  end;
end;

procedure TSalesSummaryReportForm.PrintButtonClick(Sender: TObject);
begin
 if RecordCount > 0 then
    PrintSalesSummaryReportForm.PrintSalesSummaryReportPro;
end;

procedure TSalesSummaryReportForm.MachineIDCheckBoxClick(Sender: TObject);
begin
 if MachineIDCheckBox.Checked then
    begin
     MachineIDEdit.Enabled := True;
     MachineIDEdit.SetFocus;
    end
   else
    begin
     MachineIDEdit.Text := '';
     MachineIDEdit.Enabled := False;
    end;
end;

procedure TSalesSummaryReportForm.MachineIDEditClick(Sender: TObject);
var
 MachineName: string;
begin
 if MachineIDSelectForm.MachineIDSelectPro(MachineName) then
    MachineIDEdit.Text := MachineName;
end;

procedure TSalesSummaryReportForm.FormShow(Sender: TObject);
begin
 Width := StringGridPanel.Width + 28;
 Height := ControlPanel.Top + ControlPanel.Height + 42;
 Top := (MainForm.ClientHeight - Height - MainForm.bsSkinMainMenuBar.Height) div 2;
 Left := (MainForm.ClientWidth - Width) div 2 ;
 DateEdit1.Text := FormatDateTime('dd/mm/yyyy', Date);
 DateEdit2.Text := DateEdit1.Text;
 TimeEdit1.Text := '00:00';
 TimeEdit2.Text := '23:59';
 SummaryComboBox.ItemIndex := 0;
 RecordCount := 0;
 MachineIDCheckBox.Checked := False;
 MachineIDEdit.Enabled := False;
 InitStringGrid;
end;

procedure TSalesSummaryReportForm.SalesReportPro;
begin
 Application.CreateForm(TSalesSummaryReportForm, SalesSummaryReportForm);
 SalesSummaryReportForm.ShowModal;
 SalesSummaryReportForm.Free;
end;

end.
