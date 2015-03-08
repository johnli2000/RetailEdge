unit PhoneOrderAdmin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, DB, ADODB, UtilUnit, bsSkinCtrls,
  BusinessSkinForm, XiButton, PanelButton;

type
  TPhoneOrderAdminForm = class(TForm)
    Query: TADOQuery;
    OrderListPanel: TbsSkinPanel;
    Button1: TXiButton;
    Button2: TXiButton;
    Button3: TXiButton;
    Button4: TXiButton;
    Button5: TXiButton;
    Button6: TXiButton;
    Button7: TXiButton;
    Button8: TXiButton;
    Button9: TXiButton;
    Button10: TXiButton;
    Button11: TXiButton;
    Button12: TXiButton;
    Button13: TXiButton;
    Button14: TXiButton;
    Button15: TXiButton;
    Button16: TXiButton;
    NewButton: TXiButton;
    EditButton: TXiButton;
    PrintJobListButton: TXiButton;
    PrintBillButton: TXiButton;
    PrintInvoiceButton: TXiButton;
    DeliveryReportButton: TXiButton;
    PickUpReportButton: TXiButton;
    AssignButton: TXiButton;
    PrintDeliveryListButton: TXiButton;
    PaymentButton: TXiButton;
    ExitButton: TXiButton;
    BackPanel: TbsSkinPanel;
    PickupButton: TPanelButton;
    DeliveryButton: TPanelButton;
    ListAllButton: TPanelButton;
    DriverNameButton: TPanelButton;
    VIPManagerButton: TXiButton;
    ChangeUserIDButton: TXiButton;
    ReservationButton: TPanelButton;
    ReservationListButton: TPanelButton;
    PageUpButton: TPanelButton;
    PageDownButton: TPanelButton;
    HistoryButton: TPanelButton;
    procedure ButtonClick(Sender: TObject);
    procedure OpenQuery;
    procedure AssignKeyPad(CurrentPage: integer);
    procedure PageUpButtonClick(Sender: TObject);
    procedure PageDownButtonClick(Sender: TObject);
    procedure PrintJobListButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure NewButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure PhoneOrderAdminPro;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetSearchButton;
    procedure FormShow(Sender: TObject);
    procedure PaymentButtonClick(Sender: TObject);
    procedure PrintBillButtonClick(Sender: TObject);
    procedure PrintInvoiceButtonClick(Sender: TObject);
    procedure AssignButtonClick(Sender: TObject);
    procedure PrintDeliveryListButtonClick(Sender: TObject);
    procedure PickupButtonClick(Sender: TObject);
    procedure DeliveryButtonClick(Sender: TObject);
    procedure ListAllButtonClick(Sender: TObject);
    procedure DriverNameButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure VIPManagerButtonClick(Sender: TObject);
    procedure ChangeUserIDButtonClick(Sender: TObject);
    procedure ReservationButtonClick(Sender: TObject);
    procedure ReservationListButtonClick(Sender: TObject);
    procedure DeliveryReportButtonClick(Sender: TObject);
    procedure PickUpReportButtonClick(Sender: TObject);
    procedure HistoryButtonClick(Sender: TObject);
  private { Private declarations }
    CurrentPage, RowCount, CurrentPosition, SearchKind: integer;
    DriverName: string;
  public
    { Public declarations }
  end;

var
  PhoneOrderAdminForm: TPhoneOrderAdminForm;

implementation

uses DataUnit, PrintJobCard, PrintJobCard1, PrintJobCard2, PrintInvoice,
     PrintInvoice1, MessageBox, MainMenu, Receipt, PrintOrder, PrintOrder1,
     StaffList, PrintDeliveryList, PrintJobCard3, PhoneOrder, VIPList,
     BookList, BookSearch, PrintCheckList, PrintJobCard4, DeliveryReport,
     PickUpReport, PrintInvoice2, PrintOrder2, SaleshistoryList,
     PrintJobCard5, PhoneOrderSelect, ReadCustomerName, SendToScreen,
  PrintJobListControl, PrintOrder3, PrintInvoice3;

{$R *.dfm}

procedure TPhoneOrderAdminForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select OrderDate, VIPName, Telephone, Number, Address, Suburb, PostCode, ' +
           'MapReference, OrderNo, ServicePerson, OrderH.VIPNo, CustomerName, ' +
           '(Amount + Tips + ServiceCharge + OtherCharge) As TotalAmount, ' +
           'Delivery ' +
           'From OrderH Left Join VIPTable ' +
           'On OrderH.VIPNo=VIPTable.VIPNo ' +
           'Where OrderH.BillKind=' + IntToStr(sPHONEORDER) + ' and ' +
           'Amount + Tips + ServiceCharge + OtherCharge - PaidAmount >= 0.01 and ' +
           'Credit = 0 and PriceIncludesGST <> 0 ';
 case SearchKind of
  0: SQLStr := SQLStr + ' and Delivery = 0 ';
  1: SQLStr := SQLStr + ' and Delivery <> 0 ';
 end;
 if (SearchKind = 1) and (DriverName <> '') then
    SQLStr := SQLStr + ' and ServicePerson=' + Chr(39) + CheckQuotes(DriverName) + Chr(39);
 SQLStr := SQLStr + ' Union All ' +
           'Select OrderDate, VIPName, Telephone, Number, Address, Suburb, PostCode, ' +
           'MapReference, OrderNo, ServicePerson, OrderH.VIPNo, CustomerName, ' +
           '(Amount + Tips + ServiceCharge + OtherCharge + GST) As TotalAmount, ' +
           'Delivery ' +
           'From OrderH Left Join VIPTable ' +
           'On OrderH.VIPNo=VIPTable.VIPNo ' +
           'Where OrderH.BillKind=' + IntToStr(sPHONEORDER) + ' and ' +
           'Amount + Tips + ServiceCharge + OtherCharge + GST - PaidAmount >= 0.01 and ' +
           'Credit = 0 and PriceIncludesGST = 0 ';
 case SearchKind of
  0: SQLStr := SQLStr + ' and Delivery = 0 ';
  1: SQLStr := SQLStr + ' and Delivery <> 0 ';
 end;
 if (SearchKind = 1) and (DriverName <> '') then
    SQLStr := SQLStr + ' and ServicePerson=' + Chr(39) + CheckQuotes(DriverName) + Chr(39);
 SQLStr := SQLStr + ' Order By OrderNo DESC';
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
   RowCount := RecordCount;
   CurrentPage := 1;
   CurrentPosition := 1;
  end;
end;

procedure TPhoneOrderAdminForm.ButtonClick(Sender: TObject);
begin
 with Sender As TXiButton do
  begin
   if Caption <> '' then
      begin
       CurrentPosition := StrToInt(Copy(Name, 7, 2));
       AssignKeyPad(CurrentPage);
      end;
  end;
end;

procedure TPhoneOrderAdminForm.AssignKeyPad(CurrentPage: integer);
var
 I: integer;
 Temp: string;
begin
 I := 0;
 Query.First;
 Query.MoveBy((CurrentPage - 1) * 16);
 while Not Query.EOF and (I < 16) do
  begin
   I := I + 1;
   with TXiButton(FindComponent('Button' + IntToStr(I))) do
    begin
     Font.Size := 11;
     Caption := 'No. ' + Copy(Query.FieldByName('OrderNo').AsString, 7, 4) +
                ' / Date: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Query.FieldByName('OrderDate').AsDateTime) +
                '  /  ' + Query.FieldByName('ServicePerson').AsString + Chr(13);
     if Query.FieldByName('VIPName').AsString <> '' then
        Caption := Caption + Query.FieldByName('VIPName').AsString +
                ' (' + Query.FieldByName('Telephone').AsString + ')'
       else
        Caption := Caption + Query.FieldByName('CustomerName').AsString;
     Caption := Caption + '   ' + FormatCurrency(Query.FieldByName('TotalAmount').AsFloat);
     Temp := '';
     if Query.FieldByName('Number').AsString <> '' then
        Temp := Query.FieldByName('Number').AsString;
     if Query.FieldByName('Address').AsString <> '' then
        begin
         if Temp <> '' then Temp := Temp + ' ';
         Temp := Temp + Query.FieldByName('Address').AsString;
        end;
     if Query.FieldByName('Suburb').AsString <> '' then
        begin
         if Temp <> '' then Temp := Temp + ', ';
         Temp := Temp + Query.FieldByName('Suburb').AsString;
        end;
     if Query.FieldByName('PostCode').AsString <> '' then
        begin
         if Temp <> '' then Temp := Temp + ' ';
         Temp := Temp + Query.FieldByName('Postcode').AsString;
        end;
     if Query.FieldByName('MapReference').AsString <> '' then
        Temp := Temp + ' [' + Query.FieldByName('MapReference').AsString + '] ';
     if Temp <> '' then Caption := Caption + Chr(13) + Temp;
     if Query.FieldByName('Delivery').AsBoolean then
        ColorScheme := csSun
       else
        if Query.FieldByName('VIPNo').AsInteger <> 0 then
           ColorScheme := csNeoRose
          else
           ColorScheme := csNeoSky;
     if I <> CurrentPosition then
        ColorText := clWhite
       else
        ColorText := clBlack
    end;
   Query.Next;
  end;
 while I < 16 do
  begin
   I := I + 1;
   with TXiButton(FindComponent('Button' + IntToStr(I))) do
    begin
     Font.Size := 11;
     Caption := '';
     ColorScheme := csNeoSilver;
    end;
  end;
end;

procedure TPhoneOrderAdminForm.PageUpButtonClick(Sender: TObject);
begin
 if CurrentPage >= 2 then
    begin
     CurrentPage := CurrentPage - 1;
     AssignKeyPad(CurrentPage);
     CurrentPosition := 1;
    end;
end;

procedure TPhoneOrderAdminForm.PageDownButtonClick(Sender: TObject);
begin
 if (CurrentPage * 16) < RowCount then
    begin
     CurrentPage := CurrentPage + 1;
     AssignKeyPad(CurrentPage);
     CurrentPosition := 1;
    end;
end;

procedure TPhoneOrderAdminForm.PrintJobListButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 if (CurrentPage - 1) * 16 + CurrentPosition <= RowCount then
    with Query do
     begin
      First;
      MoveBy((CurrentPage - 1) * 16 + CurrentPosition - 1);
      OrderNo := FieldByName('OrderNo').AsString;
      PrintJobListControlForm.PrintJobListControlPro(OrderNo, '', True, sConfirmedOrder);
      if AutoPrintCheckList then
         PrintCheckListForm.PrintCheckList(OrderNo, '', True, sConfirmedOrder);
      if FVar.KitchenScreen = 1 then SendToScreenForm.SendToScreenPro(OrderNo, '', True);
     end;
end;

procedure TPhoneOrderAdminForm.PrintBillButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 if (CurrentPage - 1) * 16 + CurrentPosition <= RowCount then
    with Query do
     begin
      First;
      MoveBy((CurrentPage - 1) * 16 + CurrentPosition - 1);
      OrderNo := FieldByName('OrderNo').AsString;
      case PrintBillMode of
       0, 1: PrintOrderForm.PrintOrderPro(OrderNo);
       2:    PrintOrderForm1.PrintOrderPro(OrderNo, True);
       3:    PrintOrderForm1.PrintOrderPro(OrderNo, False);
       4:    PrintOrderForm2.PrintOrderPro(OrderNo);
       5:    PrintOrderForm3.PrintOrderPro(OrderNo);
      end;
     end; 
end;

procedure TPhoneOrderAdminForm.PrintInvoiceButtonClick(Sender: TObject);
var
 OrderNo: string;
 Flag: boolean;
begin
 if Password and Not DataForm.VerifyPassword(sUserName) then Exit;
 if Not PrintInvoiceAuthority then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to print invoice.', sErrorMsg);
     Exit;
    end;
 if (CurrentPage - 1) * 16 + CurrentPosition <= RowCount then
    with Query do
     begin
      First;
      MoveBy((CurrentPage - 1) * 16 + CurrentPosition - 1);
      OrderNo := FieldByName('OrderNo').AsString;
      Flag := False;
      if DataForm.BeginTransaction then
         try
          Flag := DataForm.SetInvoiceNo(OrderNo);
         finally
          if Flag then
             begin
              DataForm.CommitTransaction;
              case PrintInvoiceMode of
               0, 1: PrintInvoiceForm.PrintInvoicePro(OrderNo);
               2:    PrintInvoiceForm1.PrintInvoicePro(OrderNo, True);
               3:    PrintInvoiceForm1.PrintInvoicePro(OrderNo, False);
               4:    PrintInvoiceForm2.PrintInvoicePro(OrderNo);
               5:    PrintInvoiceForm3.PrintInvoicePro(OrderNo);
              end
             end
           else
            DataForm.RollBack;
         end;
     end;
end;

procedure TPhoneOrderAdminForm.VIPManagerButtonClick(Sender: TObject);
var
 VIPNo: integer;
begin
 VIPListForm.VIPListPro(VIPNo);
end;

procedure TPhoneOrderAdminForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TPhoneOrderAdminForm.NewButtonClick(Sender: TObject);
var
 VIPNo, Op: integer;
 CustomerName: string;
begin
 if Password then
    begin
     if Not DataForm.VerifyPassword(sUserName) then Exit;
     if Not MainForm.PhoneOrderMenu.Enabled then
        begin
         MessageBoxForm.MessagePro('You have not been authorised to do Phone Order.', sErrorMsg);
         Exit
        end
    end;
 VIPNo := 0;
 if PhoneOrderSelectForm.SelectPhoneOrder(Op) then
    begin
     case Op of
      sPhoneOrderDelivery, sPhoneOrderPickup:
        if Not VIPListForm.VIPListPro(VIPNo) then Exit;
      sTakeAway: if Not ReadCustomerNameForm.ReadCustomerNamePro(CustomerName) then Exit;
     end;
     if PhoneOrderForm.PhoneOrderPro(VIPNo, Op, '', CustomerName, '') then
        begin
         OpenQuery;
         AssignKeyPad(1);
        end;
     DataForm.SendToPoleDisp('Next Customer Please', '');
     if FVar.SecondDisplay = 1 then SecondDisplayForm.SetWaitingStatus;
    end;
end;

procedure TPhoneOrderAdminForm.ReservationListButtonClick(Sender: TObject);
var
 BookingNo: string;
 VIPNo, OrderType: integer;
begin
 VIPNo := 0;
 if BookingSearchForm.SearchPro(BookingNo, VIPNo) and PhoneOrderSelectForm.SelectPhoneOrder(OrderType) then
    begin
     if PhoneOrderForm.PhoneOrderPro(VIPNo, OrderType, '', '', BookingNo) then
        begin
         OpenQuery;
         AssignKeyPad(1);
        end;
    end;
end;

procedure TPhoneOrderAdminForm.EditButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Password then
    begin
     if Not DataForm.VerifyPassword(sUserName) then Exit;
     if Not MainForm.PhoneOrderMenu.Enabled then
        begin
         MessageBoxForm.MessagePro('You have not been authorised to do Phone Order.', sErrorMsg);
         Exit
        end;
    end;
 if (CurrentPage - 1) * 16 + CurrentPosition <= RowCount then
    begin
     Query.First;
     Query.MoveBy((CurrentPage - 1) * 16 + CurrentPosition - 1);
     OrderNo := Query.FieldByName('OrderNo').AsString;
     if PhoneOrderForm.PhoneOrderPro(0, 0, OrderNo, '', '') then
        begin
         OpenQuery;
         AssignKeyPad(1);
        end;
     DataForm.SendToPoleDisp('Next Customer Please', '');
     if FVar.SecondDisplay = 1 then SecondDisplayForm.SetWaitingStatus;
    end;
end;

procedure TPhoneOrderAdminForm.PaymentButtonClick(Sender: TObject);
var
 OrderNo: string;
begin
 if Password then
    begin
     if Not DataForm.VerifyPassword(sUserName) then Exit;
     if Not PaymentAuthority then
        begin
         MessageBoxForm.MessagePro('You have not been authorised to do payment.', sErrorMsg);
         Exit;
        end;
    end;
 if (CurrentPage - 1) * 16 + CurrentPosition <= RowCount then
    begin
     Query.First;
     Query.MoveBy((CurrentPage - 1) * 16 + CurrentPosition - 1);
     OrderNo := Query.FieldByName('OrderNo').AsString;
     if ReceiptForm.ReceiptPro(OrderNo) then
        begin
         OpenQuery;
         AssignKeyPad(1);
        end;
    end;
end;

procedure TPhoneOrderAdminForm.AssignButtonClick(Sender: TObject);
var
 SQLStr, OrderNo, ServiceName: string;
 TempPage, TempPosition: integer;
 Flag: boolean;
begin
 if Not AssignDriverAuthorised then
    begin
     MessageBoxForm.MessagePro('You have not been authorised to assign delivery driver.', sErrorMsg);
     Exit;
    end;
 if ((CurrentPage - 1) * 16 + CurrentPosition > RowCount) then Exit;
 with Query do
  begin
   First;
   MoveBy((CurrentPage - 1) * 16 + CurrentPosition - 1);
   if Not FieldByName('Delivery').AsBoolean then
      begin
       MessageBoxForm.MessagePro('This is the pick up order.', sInformationMsg);
       Exit;
      end;
   if Not StaffListForm.ListStaffPro(ServiceName) then Exit;
   OrderNo := FieldByName('OrderNo').AsString;
   Flag := False;
   if DataForm.BeginTransaction then
      try
       SQLStr := 'Update OrderH Set ServicePerson=' + Chr(39) + CheckQuotes(ServiceName) + Chr(39) +
                 ' Where OrderNo=' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
       Flag := DataForm.ExecQueryPro(SQLStr);
      finally
       if Flag then
          begin
           DataForm.CommitTransaction;
           TempPage := CurrentPage;
           TempPosition := CurrentPosition;
           OpenQuery;
           CurrentPage := TempPage;
           CurrentPosition := TempPosition;
           AssignKeyPad(CurrentPage);
          end
         else
          DataForm.RollBack;
      end;
  end;
end;

procedure TPhoneOrderAdminForm.PrintDeliveryListButtonClick(Sender: TObject);
var
 DriverName: string;
begin
  if StaffListForm.ListStaffPro(DriverName) then
     PrintDeliveryListForm.PrintDeliveryListPro(DriverName);
end;

procedure TPhoneOrderAdminForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DataForm.SendToPoleDisp('       Closed', '');
 DataForm.ClosePoleDisplayPort;
 if FVar.SecondDisplay = 1 then SecondDisplayForm.SetCounterCloseStatus;
 Query.Close;
 Action := caFree;
end;

procedure TPhoneOrderAdminForm.SetSearchButton;
begin
 PickupButton.Font.Color := clBlack;
 DeliveryButton.Font.Color := clBlack;
 ListAllButton.Font.Color := clBlack;
 case SearchKind of
  0: PickupButton.Font.Color := clRed;
  1: DeliveryButton.Font.Color := clRed;
  2: ListAllButton.Font.Color := clRed;
 end;
end;

procedure TPhoneOrderAdminForm.PickupButtonClick(Sender: TObject);
begin
 SearchKind := 0;
 SetSearchButton;
 DriverNameButton.Enabled := False;
 DrivernameButton.Caption := 'Search by driver';
 DriverName := '';
 OpenQuery;
 AssignKeyPad(1);
end;

procedure TPhoneOrderAdminForm.DeliveryButtonClick(Sender: TObject);
begin
 SearchKind := 1;
 SetSearchButton;
 DriverNameButton.Enabled := True;
 DrivernameButton.Caption := 'Search by driver';
 DriverName := '';
 OpenQuery;
 AssignKeyPad(1);
end;

procedure TPhoneOrderAdminForm.ListAllButtonClick(Sender: TObject);
begin
 SearchKind := 2;
 SetSearchButton;
 DriverNameButton.Enabled := False;
 DrivernameButton.Caption := 'Search by driver';
 DriverName := '';
 OpenQuery;
 AssignKeyPad(1);
end;

procedure TPhoneOrderAdminForm.DriverNameButtonClick(Sender: TObject);
begin
 if StaffListForm.ListStaffPro(DriverName) then
    begin
     DriverNameButton.Caption := DriverName;
     OpenQuery;
     AssignKeyPad(1);
    end;
end;

procedure TPhoneOrderAdminForm.ChangeUserIDButtonClick(Sender: TObject);
var
 Flag: boolean;
begin
 BackPanel.SetFocus;
 repeat
  Flag := DataForm.VerifyPassword(sUserName);
  if Flag and Not MainForm.PhoneOrderMenu.Enabled then
     begin
      MessageBoxForm.MessagePro('You have not been authorised to do phone order.', sErrorMsg);
      Flag := False;
     end;
 until Flag;
end;

procedure TPhoneOrderAdminForm.ReservationButtonClick(Sender: TObject);
begin
 if MainForm.BookingListMenu.Enabled then
    BookingListForm.BookingListPro;
end;

procedure TPhoneOrderAdminForm.DeliveryReportButtonClick(Sender: TObject);
begin
 DeliveryReportForm.DeliveryReportPro;
end;

procedure TPhoneOrderAdminForm.PickUpReportButtonClick(Sender: TObject);
begin
 PickupReportForm.PickupReportPro;
end;

procedure TPhoneOrderAdminForm.HistoryButtonClick(Sender: TObject);
begin
 SalesHistoryListForm.SalesHistoryListPro(sPhoneOrder);
end;

procedure TPhoneOrderAdminForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
end;

procedure TPhoneOrderAdminForm.FormShow(Sender: TObject);
begin
 NewButton.Caption := 'New' + Chr(13) + 'Order';
 EditButton.Caption := 'Edit' + Chr(13) + 'Order';
 PrintJobListButton.Caption := 'Print' + Chr(13) + 'Job List';
 PrintBillButton.Caption := 'Print' + Chr(13) + 'Bill';
 PrintInvoiceButton.Caption := 'Print' + Chr(13) + 'Invoice';
 ChangeUserIDButton.Caption := 'Change' + Chr(13) + 'User ID';
 PageUpButton.Caption := 'Page' + Chr(13) + 'Up';
 PageDownButton.Caption := 'Page' + Chr(13) + 'Down';
 PickUpReportButton.Caption := 'Pick Up' + Chr(13) + 'Report';
 DeliveryReportButton.Caption := 'Delivery' + Chr(13) + 'Report';
 AssignButton.Caption := 'Assign' + Chr(13) + 'Driver';
 PrintDeliveryListButton.Caption := 'Print' + Chr(13) + 'Delivery' + Chr(13) + 'List';
 PaymentButton.Caption := 'Payment';
 HistoryButton.Caption := 'History';
 VIPManagerButton.Caption := 'V.I.P.' + Chr(13) + 'Manager';
 ExitButton.Caption := 'Exit';
 SearchKind := 2;
 SetSearchButton;
 DriverNameButton.Enabled := False;
 DrivernameButton.Caption := 'Search by driver';
 OpenQuery;
 AssignKeyPad(1);
 Top := 0;
 Left := 0;
 Height := Screen.Height;
 Width := Screen.Width;
 BackPanel.Height := 768;
 BackPanel.Width := 1024;
 BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
 DataForm.OpenPoleDisplayPort;
 DataForm.SendToPoleDisp('Next Customer Please', '');
end;

procedure TPhoneOrderAdminForm.PhoneOrderAdminPro;
begin
 Application.CreateForm(TPhoneOrderAdminForm, PhoneOrderAdminForm);
 PhoneOrderAdminForm.ShowModal;
 PhoneOrderAdminForm.Free;
end;

end.
