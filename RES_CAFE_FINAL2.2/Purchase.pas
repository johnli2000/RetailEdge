unit Purchase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, Buttons, DBCtrls, Mask, DB, UtilUnit, ADODB,
  bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TPurchaseForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    StringGrid: TStringGrid;
    ReceiveNoEdit: TEdit;
    DateEdit: TMaskEdit;
    Label3: TLabel;
    SupplierCodeEdit: TEdit;
    Label4: TLabel;
    PurchaseNoEdit: TEdit;
    Label5: TLabel;
    Label7: TLabel;
    GSTStatusCheckBox: TCheckBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    SubTotalEdit: TStaticText;
    GSTEdit: TStaticText;
    TotalInvoiceEdit: TStaticText;
    AddressEdit: TMemo;
    SupplierNameEdit: TEdit;
    TelephoneEdit: TEdit;
    FaxEdit: TEdit;
    CancelCheckBox: TCheckBox;
    DeliveryCheckBox: TCheckBox;
    Label6: TLabel;
    NoteEdit: TMemo;
    Label11: TLabel;
    DeliveryAddressEdit: TMemo;
    PurchaserEdit: TEdit;
    Shape1: TShape;
    HeadQuery: TADOQuery;
    ItemQuery: TADOQuery;
    Query: TADOQuery;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    HeadPanel: TbsSkinPanel;
    bsSkinPanel1: TbsSkinPanel;
    StringGridPanel: TbsSkinPanel;
    NotesPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    InsertButton: TXiButton;
    DeleteButton: TXiButton;
    ItemSetupButton: TXiButton;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    function  OpenQuery(SQLStr: string): boolean;
    function  OpenHeadQuery(PurchaseNo: string): boolean;
    procedure OpenItemQuery(SQLStr: string);
    function  CheckSupplierCode(SupplierCode: string): boolean;
    procedure CalcAmount;
    procedure InitStringGridHead;
    procedure InitCells;
    procedure InitForm;
    procedure DateEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGridEnter(Sender: TObject);
    function  TestProductCode(Code: string): boolean;
    function  CheckCells(ACol, ARow: integer): boolean;
    procedure MoveToNextCell;
    procedure StringGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGridClick(Sender: TObject);
    procedure DateEditExit(Sender: TObject);
    procedure InsertButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure ReadData;
    function  SaveHeadData: boolean;
    function  SaveItemData: boolean;
    function  SaveData: boolean;
    procedure MakePurchaseNo(var PurchaseNo: string);
    procedure SaveButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure SupplierCodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SupplierCodeEditExit(Sender: TObject);
    procedure GSTStatusCheckBoxClick(Sender: TObject);
    procedure ReceiveNoEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DeliveryCheckBoxClick(Sender: TObject);
    function  PurchasePro(EditStatus: integer; var PurchaseNo: string): boolean;
    procedure ItemSetupButtonClick(Sender: TObject);
    procedure StringGridKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    private { Private declarations }
     CurrentRow, CurrentCol, StatusFlag: integer;
     sPurchaseNo: string;
     ReturnFlag, Changed: boolean;
  public
    { Public declarations }
  end;

var
 PurchaseForm: TPurchaseForm;

implementation

uses DataUnit, SupplierList, MainMenu, MessageBox,
     StockItemList, PrintPurchaseOrder, StockItemSetup;

{$R *.DFM}

function TPurchaseForm.OpenQuery(SQLStr: string): boolean;
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
   if RecordCount = 0 then
      Result := False
     else
      Result := True;
  end;
end;

function TPurchaseForm.OpenHeadQuery(PurchaseNo: string): boolean;
var
 SQLStr: string;
 CurrentYearStr: string;
 Year, Month, Day: word;
begin
 if PurchaseNo <> '' then
    SQLStr := 'Select * From PurchaseHead ' +
              'Where PurchaseNo=' + Chr(39) + CheckQuotes(PurchaseNo) + Chr(39)
   else
    begin
     DecodeDate(Date, Year, Month, Day);
     CurrentYearStr := Copy(Format('%4.4d', [Year]), 3, 2);
     SQLStr := 'Select Max(PurchaseNo) From PurchaseHead ' +
               'Where PurchaseNo Like ' + Chr(39) + 'P' + CurrentYearStr + SearchMark + Chr(39);
    end;
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
   if RecordCount = 0 then
      Result := False
     else
      Result := True;
  end;
end;

procedure TPurchaseForm.OpenItemQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with ItemQuery do
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

function TPurchaseForm.CheckSupplierCode(SupplierCode: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := ' Select * From Supplier Where SupplierCode=' +
           Chr(39) + CheckQuotes(SupplierCode) + Chr(39);
 Screen.Cursor := crHourGlass;
 OpenQuery(SQLStr);
 with Query do
  if Active and (RecordCount > 0) then
     begin
      SupplierNameEdit.Text := FieldByName('SupplierName').AsString;
      TelephoneEdit.Text := FieldByName('Telephone').AsString;
      FaxEdit.Text := FieldByName('Fax').AsString;
      AddressEdit.Text := FieldByName('Address').AsString + Chr(13) + Chr(10) +
        FieldByName('Suburb').AsString + ' ' + FieldByName('State').AsString + ' ' +
        FieldByName('PostCode').AsString;
      if DeliveryCheckBox.Checked and (DeliveryAddressEdit.Text = '') then
         DeliveryAddressEdit.Text := AddressEdit.Text;
      Result := True;
     end
    else
     begin
      SupplierNameEdit.Text := '';
      TelephoneEdit.Text := '';
      FaxEdit.Text := '';
      AddressEdit.Text := '';
      Result := False;
     end;
 Query.Close;
 if Not Result then MessageBoxForm.MessagePro('Supplier code error!', sErrorMsg);
end;

procedure TPurchaseForm.CalcAmount;
var
 I: integer;
 SubTotal, Total, GST, GSTRate, Amount: double;
begin
 SubTotal := 0; Total := 0; GST := 0;
 with StringGrid do
  for I := 1 to 60 do
   begin
    if Cells[5, I] <> '' then
       GSTRate := StrToFloat(Cells[5, I]) / 100
      else
       GSTRate := 0;
    if (Cells[3, I] <> '') and (Cells[4, I] <> '') then
       begin
        Amount := StrToFloat(Cells[3, I]) * StrToFloat(Cells[4, I]);
        if GSTStatusCheckBox.Checked then
           begin
            Total := Total + Amount;
            GST := GST + Amount * (1 - 1 / (1 + GSTRate))
           end
          else
           begin
            SubTotal := SubTotal + Amount;
            GST := GST + Amount * GSTRate;
           end;
       end;
   end;
 if GSTStatusCheckBox.Checked then
    SubTotal := Total - GST
   else
    Total := SubTotal + GST;
 SubTotalEdit.Caption := Format('%4.2f ', [SubTotal]);
 GSTEdit.Caption := Format('%4.2f ', [GST]);
 TotalInvoiceEdit.Caption := Format('%4.2f ', [Total]);
end;

procedure TPurchaseForm.InitStringGridHead;
var
 Y: Integer;
begin
 with StringGrid do
  begin
    Cells[0, 0] := 'No';
    Cells[1, 0] := 'Code';
    Cells[2, 0] := 'Description';
    Cells[3, 0] := 'Qty';
    Cells[4, 0] := 'Price';
    Cells[5, 0] := 'GST(%)';
    Cells[6, 0] := 'Arrived';
    for Y := 1 to 60 do Cells[0, Y] := Format('%3d', [Y]);
  end;
end;

procedure TPurchaseForm.InitCells;
var
 X, Y: Integer;
begin
 with StringGrid do
  begin
   for Y := 1 to 60 do
     for X := 1 to 6 do Cells[X, Y] := '';
   Col := 1; Row := 1; TopRow := 1;
   CurrentRow := 1; CurrentCol := 1;
  end;
end;

procedure TPurchaseForm.InitForm;
begin
 InitCells;
 PurchaseNoEdit.Text := '';
 ReceiveNoEdit.Text := '';
 DateEdit.Text := '';
 SupplierCodeEdit.Text := '';
 SupplierNameEdit.Text := '';
 TelephoneEdit.Text := '';
 FaxEdit.Text := '';
 AddressEdit.Lines.Clear;
 DeliveryAddressEdit.Text := '';
 NoteEdit.Text := '';
 ReceiveNoEdit.Text := '';
 SubTotalEdit.Caption := '';
 GSTEdit.Caption := '';
 TotalInvoiceEdit.Caption := '';
 PurchaserEdit.Text := sUserName;
 GSTStatusCheckBox.Checked := True;
 CancelCheckBox.Checked := False;
 DeliveryCheckBox.Checked := False;
end;

procedure TPurchaseForm.DateEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then StringGrid.SetFocus
end;

procedure TPurchaseForm.ReceiveNoEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then StringGrid.SetFocus
end;

procedure TPurchaseForm.SupplierCodeEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
 CodeStr, SupplierName: string;
begin
 case Key of
   VK_RETURN: StringGrid.SetFocus;
   VK_F5: begin
           CodeStr := SupplierCodeEdit.Text;
           if SupplierListForm.ListSupplier(CodeStr, SupplierName, 0) then
              SupplierCodeEdit.Text := CodeStr;
          end;
 end;
end;

procedure TPurchaseForm.SupplierCodeEditExit(Sender: TObject);
begin
 if (SupplierCodeEdit.Text = '') then SupplierNameEdit.Text := ''
    else
      if Not CheckSupplierCode(SupplierCodeEdit.Text) then
         SupplierCodeEdit.SetFocus;
end;

procedure TPurchaseForm.StringGridEnter(Sender: TObject);
begin
 StringGrid.Col := 1;
end;

function TPurchaseForm.TestProductCode(Code: string): boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Select Description, GSTRate, LastOrderPrice ' +
           'From StockTable ' +
           'Where Code=' + Chr(39) + CheckQuotes(Code) + Chr(39);
 Result := OpenQuery(SQLStr);
 if Not Result then
    MessageBoxForm.MessagePro(Code + ' can not be found!', sErrorMsg)
end;

function TPurchaseForm.CheckCells(ACol, ARow: integer): boolean;
var
 CellsStr: string;
begin
 Result := True;
 if Not Changed or (ACol in [2, 5]) or (StringGrid.Cells[ACol, ARow] = '') then Exit;
 StringGrid.Cells[ACol, ARow] := Uppercase(StringGrid.Cells[ACol, ARow]);
 CellsStr := StringGrid.Cells[ACol, ARow];
 case ACol of
  1: begin
      if Not TestProductCode(CellsStr) then
         begin
          StringGrid.Cells[1, ARow] := '';
          StringGrid.Cells[2, ARow] := '';
          StringGrid.Cells[3, ARow] := '';
          StringGrid.Cells[4, ARow] := '';
          StringGrid.Cells[5, ARow] := '';
          StringGrid.Cells[6, ARow] := '';
          Result := False;
         end
       else
        begin
         StringGrid.Cells[2, ARow] := Query.FieldByName('Description').AsString;
         StringGrid.Cells[5, ARow] := Format('%4.2f', [Query.FieldByName('GSTRate').AsFloat]);
         StringGrid.Cells[4, ARow] := Format('%4.2f', [Query.FieldByName('LastOrderPrice').AsFloat]);
        end;
      Query.Close;
     end;
  3: if Not CheckNum(CellsStr, 12, 9999999.9999, -999999.9999, 'F') then
        Result := False
       else
        StringGrid.Cells[ACol, ARow] := Format('%12.4f', [StrToFloat(CellsStr)]);
  4: if Not CheckNum(CellsStr, 12, 9999999.99, -9999999.99, 'F') then
        Result := False
       else
        StringGrid.Cells[ACol, ARow] := Format('%12.2f', [StrToFloat(CellsStr)]);
 end;
 Changed := False;
end;

procedure TPurchaseForm.MoveToNextCell;
begin
 Case StringGrid.Col of
  1: StringGrid.Col := 3;
  2: StringGrid.Col := 3;
  3: StringGrid.Col := 4;
  4, 5, 6: begin
      if StringGrid.Row < 60 then
         StringGrid.Row := StringGrid.Row + 1;
      StringGrid.Col := 1;
     end;
 end;
 CurrentRow := StringGrid.Row; CurrentCol := StringGrid.Col;
end;

procedure TPurchaseForm.StringGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
 CellsStr: string;
begin
 case Key of
  VK_F5: if CurrentCol = 1 then
            begin
             CellsStr := StringGrid.Cells[1, CurrentRow];
             if StockItemListForm.ListStockItem(CellsStr) then
                begin
                 if StringGrid.Cells[1, CurrentRow] <> CellsStr then
                    StringGrid.Cells[4, CurrentRow] := '';
                 StringGrid.Cells[1, CurrentRow] := CellsStr;
                 Changed := True;
                end;

            end;
  VK_RETURN: begin
              Key := 0;
              MoveToNextCell;
             end;
 end;
end;

procedure TPurchaseForm.StringGridKeyPress(Sender: TObject; var Key: Char);
begin
 if Key in ['0'..'9', 'a'..'z', 'A'..'Z'] then Changed := True;
end;

procedure TPurchaseForm.StringGridClick(Sender: TObject);
begin
 if (StringGrid.Col = CurrentCol) and (StringGrid.Row = CurrentRow) then
    Exit;
 if CheckCells(CurrentCol, CurrentRow) then
    begin
     CurrentCol := StringGrid.Col;
     CurrentRow := StringGrid.Row;
    end
   else
    begin
     StringGrid.Col := CurrentCol;
     StringGrid.Row := CurrentRow;
    end;
 if Not (StringGrid.Col in [1, 3, 4]) then
    StringGrid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine]
   else
    StringGrid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goEditing];
 CalcAmount;
end;

procedure TPurchaseForm.DateEditExit(Sender: TObject);
begin
 if Not ReturnFlag and Not CheckDate(DateEdit.Text) then
    DateEdit.SetFocus
end;

procedure TPurchaseForm.InsertButtonClick(Sender: TObject);
var
 I, J: Integer;
begin
 if Not CheckCells(CurrentCol, CurrentRow) then
    begin
     StringGrid.SetFocus;
     Exit;
    end;
 for I := 60 Downto CurrentRow + 1 do
  for J := 1 to 6 do StringGrid.Cells[J, I] := StringGrid.Cells[J, I - 1];
 for J := 1 to 6 do StringGrid.Cells[J, CurrentRow] := '';
end;

procedure TPurchaseForm.DeleteButtonClick(Sender: TObject);
var
 I, J: Integer;
begin
 if (MessageBoxForm.MessagePro('Are you sure you want to delete this line?', sConfirmMsg) = mrNo) then
    Exit;
 for I := CurrentRow to 59 do
  for J := 1 to 6 do StringGrid.Cells[J, I] := StringGrid.Cells[J, I + 1];
 for J := 1 to 6 do StringGrid.Cells[J, 60] := '';
end;

procedure TPurchaseForm.ReadData;
var
 I: Integer;
begin
 with HeadQuery do
  begin
   PurchaseNoEdit.Text := FieldByName('PurchaseNo').AsString;
   ReceiveNoEdit.Text := FieldByName('ReceiveNo').AsString;
   DateEdit.Text := FormatDateTime('dd/mm/yyyy', FieldByName('PurchaseDate').AsDateTime);
   SupplierCodeEdit.Text := FieldByName('SupplierCode').AsString;
   NoteEdit.Text := FieldByName('Notes').AsString;
   DeliveryAddressEdit.Text := FieldByName('DeliveryAddress').AsString;
   GSTStatusCheckBox.Checked := FieldByName('GSTStatus').AsBoolean;
   CancelCheckBox.Checked := FieldByName('Cancel').AsBoolean;
   DeliveryCheckBox.Checked := FieldByName('Delivery').AsBoolean;
   PurchaserEdit.Text := FieldByName('OpName').AsString;
  end;
 I := 1;
 with ItemQuery do
  while Not EOF do
   begin
    StringGrid.Cells[1, I] := FieldByName('Code').AsString;
    StringGrid.Cells[2, I] := FieldByName('Description').AsString;
    StringGrid.Cells[3, I] := Format('%6.4f', [FieldByName('Qty').AsFloat]);
    StringGrid.Cells[4, I] := Format('%4.2f', [FieldByName('Price').AsFloat]);
    StringGrid.Cells[5, I] := Format('%4.2f', [FieldByName('GSTRate').AsFloat]);
    if FieldByName('ArrivedQty').AsFloat > 0.0001 then
       StringGrid.Cells[6, I] := Format('%6.4f', [FieldByName('ArrivedQty').AsFloat]);
    Next; Inc(I);
   end;
end;

function TPurchaseForm.SaveHeadData: boolean;
var
 SQLStr, PurchaseNo, Notes, ReceiveNo, GSTStatus, Delivery,
 DeliveryAddress, Cancel: string;
begin
 if GSTStatusCheckBox.Checked then
    GSTStatus := '1'
   else
    GSTStatus := '0';
 if DeliveryCheckBox.Checked then
    Delivery := '1'
   else
    Delivery := '0';
 if CancelCheckBox.Checked then
    Cancel := '1'
   else
    Cancel := '0';
 if PurchaseNoEdit.Text <> '' then
    PurchaseNo := Chr(39) + CheckQuotes(PurchaseNoEdit.Text) + Chr(39)
   else
    PurchaseNo := 'Null';
 if ReceiveNoEdit.Text <> '' then
    ReceiveNo := Chr(39) + CheckQuotes(ReceiveNoEdit.Text) + Chr(39)
   else
    ReceiveNo := 'Null';
 if NoteEdit.Text = '' then
    Notes := 'NULL'
   else
    Notes := Chr(39) + CheckQuotes(NoteEdit.Text) + Chr(39);
 if DeliveryAddressEdit.Text <> '' then
    DeliveryAddress := Chr(39) + CheckQuotes(DeliveryAddressEdit.Text) + Chr(39)
   else
    DeliveryAddress := 'Null';
 SQLStr := 'Insert Into PurchaseHead(PurchaseNo, ReceiveNo, PurchaseDate, ' +
           'SupplierCode, GSTStatus, Notes, OpName, Cancel, Delivery, ' +
           'DeliveryAddress)' +
           'Values(' + PurchaseNo + ',' + ReceiveNo + ',' +
           ConvertDateTime(TransferDate(DateEdit.Text)) + ',' +
           Chr(39) + CheckQuotes(SupplierCodeEdit.Text) + Chr(39) + ',' + GSTStatus + ',' +
           Notes + ',' +  Chr(39) + CheckQuotes(sUserName) + Chr(39) + ',' +
           Cancel + ',' + Delivery + ',' + DeliveryAddress + ')';
 Result := DataForm.ExecQueryPro(SQLStr);
end;

function TPurchaseForm.SaveItemData: boolean;
var
 I, IDNo: Integer;
 SQLStr, ReceiveNo, Code, Qty, Price, ArrivedQty, TaxRate: string;
begin
 ReceiveNo := ReceiveNoEdit.Text;
 I := 1; IDNo := 1; Result := True;
 while (I <= 60) and Result do
  begin
   if StringGrid.Cells[1, I] <> '' then
      begin
       Code := StringGrid.Cells[1, I];
       if StringGrid.Cells[3, I] <> '' then
          Qty := Format('%6.4f', [StrToFloat(StringGrid.Cells[3, I])])
         else
          Qty := '0.0';
       if StringGrid.Cells[4, I] <> '' then
          Price := Format('%6.2f', [StrToFloat(StringGrid.Cells[4, I])])
         else
          Price := '0.0';
       if StringGrid.Cells[5, I] <> '' then
          TaxRate := Format('%6.2f', [StrToFloat(StringGrid.Cells[5, I])])
         else
          TaxRate := '0.0';
       if StringGrid.Cells[6, I] <> '' then
          ArrivedQty := Format('%6.4f', [StrToFloat(StringGrid.cells[6, I])])
         else
          ArrivedQty := '0.0';
       if Result then
          begin
           SQLStr := 'Insert Into PurchaseItem(PurchaseNo, Code, Qty, Price, ' +
                     'GSTRate, ArrivedQty, ID) ' +
                     'Values(' + Chr(39) + CheckQuotes(sPurchaseNo) + Chr(39) + ',' + Chr(39) +
                     CheckQuotes(Code) + Chr(39) + ',' + Qty + ',' + Price + ',' +
                     TaxRate + ',' + ArrivedQty + ',' + IntToStr(IDNo) + ')';
           Result := DataForm.ExecQueryPro(SQLStr);
          end;
       IDNo := IDNo + 1;
      end;
   I := I + 1;
  end;
end;

function TPurchaseForm.SaveData: boolean;
var
 SQLStr: string;
begin
 SQLStr := 'Delete From PurchaseHead ' +
           'Where PurchaseNo=' + Chr(39) + CheckQuotes(PurchaseNoEdit.Text) + Chr(39);
 Result := DataForm.ExecQueryPro(SQLStr);
 if Result then
    begin
     SQLStr := 'Delete From PurchaseItem ' +
               'Where PurchaseNo=' + Chr(39) + CheckQuotes(PurchaseNoEdit.Text) + Chr(39);
     Result := DataForm.ExecQueryPro(SQLStr);
    end;
 if Result then
    Result := SaveHeadData;
 if Result then
    Result := SaveItemData;
end;

procedure TPurchaseForm.MakePurchaseNo(var PurchaseNo: string);
var
 CurYearStr: string;
 NewNo: Integer;
 Year, Month, Day: word;
begin
 if OpenHeadQuery('') and (HeadQuery.Fields[0].AsString <> '') then
    NewNo := StrToInt(Copy(HeadQuery.Fields[0].AsString, 4, 5))
   else
    NewNo := 0;
 HeadQuery.Close;
 DecodeDate(Date, Year, Month, Day);
 CurYearStr := Copy(Format('%4.4d', [Year]), 3, 2);
 Inc(NewNo);
 PurchaseNo := 'P' + CurYearStr + Format('%5.5d', [NewNo]);
end;

procedure TPurchaseForm.SaveButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 if Not CheckCells(CurrentCol, CurrentRow) then
    StringGrid.SetFocus;
 if SupplierCodeEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Supplier code is invalid!', sErrorMsg);
     SupplierCodeEdit.SetFocus;
     Exit;
    end;
 Flag := False;
 if Not DataForm.BeginTransaction then Exit;

 try
  if StatusFlag = sNewStatus then
     begin
      MakePurchaseNo(sPurchaseNo);
      PurchaseNoEdit.Text := sPurchaseNo;
     end
    else
     sPurchaseNo := PurchaseNoEdit.Text;
  Flag := SaveData;
 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      PrintPurchaseOrderForm.PrintPurchasePro(sPurchaseNo);
      ReturnFlag := True;
      Close;
     end
    else
     DataForm.RollBack;
 end
end;

procedure TPurchaseForm.GSTStatusCheckBoxClick(Sender: TObject);
begin
 CalcAmount
end;

procedure TPurchaseForm.CancelButtonClick(Sender: TObject);
begin
 if MessageBoxForm.MessagePro('Are you sure you want to cancel? ', sConfirmMsg) = mrYes then
    begin
     ReturnFlag := False;
     Close;
    end;
end;

procedure TPurchaseForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 X := 0;
 with Sender As TStringGrid do
  begin
   if (ARow > 0) and (ACol > 0) then
      case ACol of
        1, 2:
           begin
            SetTextAlign(Canvas.Handle, TA_LEFT);
            X := Rect.Left + 2;
           end;
        3, 4, 5, 6: begin
            SetTextAlign(Canvas.Handle, TA_RIGHT);
            X := Rect.Right - 2;
           end;
      end
     else
      begin
       Canvas.Font.Style := [fsBold];
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
      end;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TPurchaseForm.ItemSetupButtonClick(Sender: TObject);
begin
 StockItemSetupForm.StockItemSetupPro;
end;

procedure TPurchaseForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TPurchaseForm.DeliveryCheckBoxClick(Sender: TObject);
begin
 if DeliveryCheckBox.Checked then
    begin
     if DeliveryAddressEdit.Text = '' then
        DeliveryAddressEdit.Text := AddressEdit.Text
    end
   else
    DeliveryAddressEdit.Text := '';
end;

procedure TPurchaseForm.FormShow(Sender: TObject);
var
 SQLStr: string;
begin
 Width := StringGridPanel.Width + 28;
 Height := CancelButton.Top + 86;
 InitStringGridHead;
 InitForm;
 if StatusFlag = sNewStatus then
    begin
     DateEdit.Text := FormatDateTime('dd/mm/yyyy', Date);
     SupplierCodeEdit.SetFocus;
    end
   else
    begin
     OpenHeadQuery(sPurchaseNo);
     SQLStr := 'Select PurchaseItem.Code, StockTable.Description, Qty, ' +
               'Price, PurchaseItem.GSTRate, ArrivedQty, ID ' +
               'From PurchaseItem, StockTable ' +
               'Where StockTable.Code=PurchaseItem.Code and PurchaseNo=' +
               Chr(39) + CheckQuotes(sPurchaseNo) + Chr(39) + ' Order By ID';
     OpenItemQuery(SQLStr);
     ReadData;
     ItemQuery.Close;
     HeadQuery.Close;
     CheckSupplierCode(SupplierCodeEdit.Text);
    end;
 CalcAmount;
 Changed := False;
end;

function TPurchaseForm.PurchasePro(EditStatus: integer; var PurchaseNo: string): boolean;
begin
 Application.CreateForm(TPurchaseForm, PurchaseForm);
 PurchaseForm.StatusFlag := EditStatus;
 PurchaseForm.sPurchaseNo := PurchaseNo;
 PurchaseForm.ShowModal;
 PurchaseNo := PurchaseForm.sPurchaseNo;
 Result := PurchaseForm.ReturnFlag;
 PurchaseForm.Free;
end;

end.
