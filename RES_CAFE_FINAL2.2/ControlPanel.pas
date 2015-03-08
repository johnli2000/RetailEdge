unit ControlPanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, UtilUnit, jpeg, BusinessSkinForm,
  bsSkinCtrls, XiButton, bsSkinBoxCtrls, Mask, SUIImagePanel, SUIButton,
  Menus, AppEvnts;

type
  TControlPanelForm = class(TForm)
    LogonPanel: TbsSkinPanel;
    ControlPanel: TbsSkinPanel;
    BookButton: TXiButton;
    PhoneOrderButton: TXiButton;
    PasswordPanel: TbsSkinPanel;
    DatabaseComboBox: TbsSkinMRUComboBox;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    PasswordEdit: TbsSkinPasswordEdit;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    POButton: TXiButton;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    suiButton3: TsuiButton;
    suiButton4: TsuiButton;
    Image2: TImage;
    NameEdit: TEdit;
    Image1: TImage;
    bsSkinMainMenuBar: TbsSkinMainMenuBar;
    ContraolPanel: TbsSkinPanel;
    TableServiceButton: TbsSkinSpeedButton;
    QuickServiceButton: TbsSkinSpeedButton;
    MenuSetupButton: TbsSkinSpeedButton;
    AttendanceButton: TbsSkinSpeedButton;
    DailyReportButton: TbsSkinSpeedButton;
    LogoutButton: TbsSkinSpeedButton;
    bsSkinPanel1: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    DateLabel: TbsSkinLabel;
    Timer1: TTimer;
    ApplicationEvents1: TApplicationEvents;
    ConnectTimer: TTimer;
    ImageLogo: TImage;
    procedure ControlPanelPro;
    procedure LogoutPro;
    procedure LogonPro;
    procedure FormShow(Sender: TObject);
    procedure LogonButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure AttendanceButtonClick(Sender: TObject);
    procedure LogoutButtonClick(Sender: TObject);
    //procedure BookButtonClick(Sender: TObject);
    procedure TableServiceButtonClick(Sender: TObject);
    procedure QuickServiceButtonClick(Sender: TObject);
    //procedure PhoneOrderButtonClick(Sender: TObject);
    procedure MenuSetupButtonClick(Sender: TObject);
    procedure DailyReportButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure NameEdit1Click(Sender: TObject);
    procedure NameEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure NameEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure PasswordEditClick(Sender: TObject);
    procedure PasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  ConnectDatabase: boolean;
    procedure DatabaseComboBoxChange(Sender: TObject);
    procedure PasswordEditKeyPress(Sender: TObject; var Key: Char);
    procedure UserNameButtonClick(Sender: TObject);
    procedure PasswordButtonClick(Sender: TObject);
    procedure SpeedButtonTableServiceClick(Sender: TObject);
    procedure SpeedButtonQuickServiceClick(Sender: TObject);
    procedure SpeedButtonMenuSetupClick(Sender: TObject);
    procedure SpeedButtonDailyReportClick(Sender: TObject);
    procedure SpeedButtonAttendanceClick(Sender: TObject);
    procedure SpeedButtonLogoutClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
   procedure ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
    procedure ConnectTimerTimer(Sender: TObject);


  private
    { Private declarations }
    ConnectTimes : integer;
  public
    { Public declarations }
  end;

var
  ControlPanelForm: TControlPanelForm;

implementation

uses MainMenu, DataUnit, ReadPSWD, TableOrder, PointOfsales,
    EndOfDayRpt, StaffList, NumPad,
     Attendance, MenuSetup, MessageBox, Upgrade, Regist, SecondDisplay,
     Backup, Security;

{$R *.DFM}

procedure TControlPanelForm.LogoutPro;
begin
 LogonPanel.Visible := True;
 ControlPanel.Visible := False;
 MainForm.ServiceMenu.Enabled := False;
 MainForm.ReportsMenu.Enabled := False;
 MainForm.BackOfficeMenu.Enabled := False;
 MainForm.SystemsMenu.Enabled := False;


 MainForm.bsSkinMainMenuBar.UpdateItems;
 bsSkinMainMenuBar.Visible := false;


 MainForm.Caption := 'Vii POS SOFTWARE ' +
                      sVersion + DistributorMsg;
end;

procedure TControlPanelForm.LogonPro;
begin
 MainForm.ServiceMenu.Enabled := True;
 MainForm.ReportsMenu.Enabled := True;
 MainForm.BackOfficeMenu.Enabled := True;
 MainForm.SystemsMenu.Enabled := True;


 MainForm.bsSkinMainMenuBar.UpdateItems;
 bsSkinMainMenuBar.Visible := true;
 MainForm.Caption := 'Vii POS - ' + sDatabaseName + DistributorMsg;
end;

procedure TControlPanelForm.LogonButtonClick(Sender: TObject);
var
 I: integer;
begin
 LogonPanel.SetFocus;
 if SecurityForm.TestSoftDog or SecurityForm.TestSerialNo or
   (SecurityForm.GetExpireDate - 7 >= 0) or RegistryForm.RegistyPro then
    begin
     PasswordPanel.Visible := True;
     LogonPanel.Visible := False;
     Application.ProcessMessages;
     DataForm.ReadDatabaseName;
     DatabaseComboBox.Items.Clear;
     for I := 1 to 100 do
      if sAlias[I, 1] <> '' then
         DatabaseComboBox.Items.Add(sAlias[I, 1]);
     if sAliasName <> '' then
        DatabaseComboBox.ItemIndex := SearchString(DatabaseComboBox.Items, sAliasName)
       else
        DatabaseComboBox.ItemIndex := 0;
     PasswordEdit.Text := '';
     NameEdit.SetFocus;
    end;
end;

procedure TControlPanelForm.ExitButtonClick(Sender: TObject);
begin
 LogonPanel.SetFocus;
 MainForm.ExitMenuClick(Sender);
end;

procedure TControlPanelForm.AttendanceButtonClick(Sender: TObject);
begin
 ControlPanel.SetFocus;
 AttendanceForm.AttendancePro;
end;

procedure TControlPanelForm.LogoutButtonClick(Sender: TObject);
var
 I: integer;
begin
 if (MainForm.MDIChildCount > 1) then
    MessageBoxForm.MessagePro('Close all windows ', sErrorMsg)
   else
    begin
     {if MainForm.DatabaseBackupMenu.Enabled and
        (MessageBoxForm.MessagePro('Do you want to backup the system?', sConfirmMsg) = mrYes) then
        BackupForm.BackupPro;}
     LogoutPro;
     Application.ProcessMessages;
     for I := 0 to DataForm.ADOConnection.DataSetCount - 1 do
      DataForm.ADOConnection.DataSets[I].Active := False;
     DataForm.ADOConnection.Connected := False;
     DataForm.BackupTimer.Enabled := False;
     SecurityForm.SecurityTimer.Enabled := False;
     DataForm.PrinterStatusCheckTimer.Enabled := False;
     if DataForm.EFTPOS <> NIL then
        begin
         DataForm.EFTPOS.Free;
         DataForm.EFTPOS := NIL;
        end;
    end;
    ConnectTimes := 0;
end;



procedure TControlPanelForm.TableServiceButtonClick(Sender: TObject);
begin
 ControlPanel.SetFocus;
 TableOrderForm.TableOrderPro(False);
end;

procedure TControlPanelForm.QuickServiceButtonClick(Sender: TObject);
begin
 ControlPanel.SetFocus;
 PointOfSalesForm.PointOfsalesPro(False);

end;



procedure TControlPanelForm.MenuSetupButtonClick(Sender: TObject);
begin
 ControlPanel.SetFocus;
 MenuItemForm.MenuSetup(0);
end;

procedure TControlPanelForm.DailyReportButtonClick(Sender: TObject);
begin
 ControlPanel.SetFocus;
 EndOfdayForm.DailyReportPro(0);
end;

procedure TControlPanelForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if (Key = Chr(27)) and LogonPanel.Visible then
    ExitButtonClick(Sender);
end;

procedure TControlPanelForm.NameEdit1Click(Sender: TObject);
var
 StaffName: string;
begin
 if DataForm.ADOConnection.Connected or ConnectDatabase then
    begin
     if StaffListForm.ListStaffPro(StaffName) then
        begin
         NameEdit.Text := StaffName;
         PasswordEdit.SetFocus
        end;
    end;
end;

procedure TControlPanelForm.UserNameButtonClick(Sender: TObject);
begin
 ControlPanelForm.NameEdit1Click(Sender);
end;

procedure TControlPanelForm.NameEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) or (Key = VK_DOWN) then
     PasswordEdit.SetFocus
    else
     if (Key = VK_F5) then
         NameEdit1Click(Sender);
end;

procedure TControlPanelForm.NameEdit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key In ['a'..'z'] then Key := UpCase(Key)
end;

procedure TControlPanelForm.PasswordEditClick(Sender: TObject);
var
 NumStr: string;
begin
 PasswordEdit.SetFocus;
 NumStr := '';
 if NumberPadForm.ReadNumberPro(NumStr, True, False, 'Password', 0) then
    begin
     PasswordEdit.Text := NumStr;
     ConfirmButton.SetFocus;
    end;
end;

procedure TControlPanelForm.PasswordButtonClick(Sender: TObject);
begin
 PasswordEditClick(Sender);
end;

procedure TControlPanelForm.PasswordEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (Key = VK_RETURN) or (Key = VK_DOWN) then ConfirmButton.SetFocus;
 if (Key = VK_UP) then NameEdit.SetFocus;
end;

procedure TControlPanelForm.ConfirmButtonClick(Sender: TObject);
begin
 PasswordPanel.SetFocus;
 if DataForm.ADOConnection.Connected or ConnectDatabase then
    with DataForm do
     if TestPassword(NameEdit.Text, PasswordEdit.Text) then
        begin
         SetSystemDateTime;
         OpenCompanyQuery;
         CompanyTitle := CompanyQuery.FieldByName('CompanyName').AsString;
         Password := CompanyQuery.FieldByName('CheckPassword').AsBoolean;
         BeginTime := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('BeginTime').AsDateTime));
         EndTime := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('EndTime').AsDateTime));
         ButtonLayOut := CompanyQuery.FieldByName('ButtonLayOut').AsInteger;
         MainMenuLine := CompanyQuery.FieldByName('MainMenuLine').AsInteger;
         MainCategoryLine := CompanyQuery.FieldByName('MainCategoryLine').AsInteger;
         POSMenuLine := CompanyQuery.FieldByName('POSMenuLine').AsInteger;
         POSCategoryLine := CompanyQuery.FieldByName('POSCategoryLine').AsInteger;
         PhoneOrderMenuLine := CompanyQuery.FieldByName('PhoneOrderMenuLine').AsInteger;
         PhoneOrderCategoryLine := CompanyQuery.FieldByName('PhoneOrderCategoryLine').AsInteger;
         TableTracking := CompanyQuery.FieldByName('TableTracking').AsBoolean;
         ManuallyEnterTableNumber := CompanyQuery.FieldByName('ManuallyEnterTableNumber').AsBoolean;
         CheckTableStatus := CompanyQuery.FieldByName('CheckTableStatus').AsBoolean;
         PersonCount := CompanyQuery.FieldByName('PersonCount').AsBoolean;
         PrintBillNo := CompanyQuery.FieldByName('PrintBillNo').AsBoolean;
         PrintInvoiceNo := CompanyQuery.FieldByName('PrintInvoiceNo').AsBoolean;
         ForceVIPDiscount := CompanyQuery.FieldByName('ForceVIPDiscount').AsBoolean;
         RoundingFlag := CompanyQuery.FieldByName('RoundingFlag').AsInteger;
         NotAllowModify := CompanyQuery.FieldByName('NotAllowModify').AsBoolean;
         NotAllowChangeQty := CompanyQuery.FieldByName('NotAllowChangeQty').AsBoolean;
         AutoOpenTill := CompanyQuery.FieldByName('AutoOpenTill').AsBoolean;
         AutoPrintJobList := CompanyQuery.FieldByName('AutoPrintJobList').AsBoolean;
         ManuallyPrintJobList := CompanyQuery.FieldByName('ManuallyPrintJobList').AsBoolean;
         PrintServiceOnJobList := CompanyQuery.FieldByName('PrintServiceOnJobList').AsBoolean;
         PrintPersonsOnJobList := CompanyQuery.FieldByName('PrintPersonsOnJobList').AsBoolean;
         PrintPriceOnJobList := CompanyQuery.FieldByName('PrintPriceOnJobList').AsBoolean;
         PrintTimeOnInvoice := CompanyQuery.FieldByName('PrintTimeOnInvoice').AsBoolean;
         HappyHourAvailable := CompanyQuery.FieldByName('HappyHour').AsBoolean;
         AutoSurcharge := CompanyQuery.FieldByName('AutoSurcharge').AsBoolean;
         ShowTaxOnSalesSection := CompanyQuery.FieldByName('ShowTaxOnSalesSection').AsBoolean;
         AutoPrintPOSJobList := CompanyQuery.FieldByName('POSJobList').AsBoolean;
         AutoPrintPOSOrderList := CompanyQuery.FieldByName('POSOrderList').AsBoolean;
         AutoPrintPOSInvoice := CompanyQuery.FieldByName('POSInvoice').AsBoolean;
         AutoPrintPickupSlip := CompanyQuery.FieldByName('PrintPickupSlip').AsBoolean;
         PrintCategoryColor := CompanyQuery.FieldByName('PrintCategoryColor').AsInteger;
         PrintJobListDescription := CompanyQuery.FieldByName('JobListDescription').AsInteger;
         PrintOrderListDescription := CompanyQuery.FieldByName('OrderListDescription').AsInteger;
         PrintInvoiceDescription := CompanyQuery.FieldByName('InvoiceDescription').AsInteger;
         PrintInvoiceMode := CompanyQuery.FieldByName('PrintInvoiceCategory').AsInteger;
         PrintBillMode := CompanyQuery.FieldByName('PrintBillCategory').AsInteger;
         VIPDefaultSearch := CompanyQuery.FieldByName('VIPDefaultSearch').AsInteger;
         AutoPrintPhoneOrderJobList := CompanyQuery.FieldByName('AutoPrintPhoneOrderJobList').AsBoolean;
         AutoInstructionSelection := CompanyQuery.FieldByName('AutoInstructionSelection').AsBoolean;
         PrintTableNo := CompanyQuery.FieldByName('PrintTableNo').AsBoolean;
         PrintDateOnDailyReport := CompanyQuery.FieldByName('PrintDateOnDailyReport').AsBoolean;
         AutoPrintBill := CompanyQuery.FieldByName('AutoPrintBill').AsBoolean;
         AutoPrintInvoice := CompanyQuery.FieldByName('AutoPrintInvoice').AsBoolean;
         AutoPriceWindow := CompanyQuery.FieldByName('AutoPriceWindow').AsBoolean;
         PrintZeroPriceItemOnInvoice := CompanyQuery.FieldByName('PrintZeroPriceItemOnInvoice').AsBoolean;
         AutoPopVoidReason := CompanyQuery.FieldByName('AutoPopVoidReason').AsBoolean;
         AutoSaveOrder := CompanyQuery.FieldByName('AutoSaveOrder').AsBoolean;
         ScaleBarcode := CompanyQuery.FieldByName('ScaleBarcode').AsInteger;
         PrintGoWithInstruction := CompanyQuery.FieldByName('PrintGoWithInstruction').AsBoolean;
         PrintOpNameOnJobList := CompanyQuery.FieldByName('PrintOpNameOnJobList').AsBoolean;
         AutoPrintMergedOrder := CompanyQuery.FieldByName('AutoPrintMergedOrder').AsBoolean;
         AutoPrintJobListForHoldOrder := CompanyQuery.FieldByName('AutoPrintJobListForHoldOrder').AsBoolean;
         AutoSurcharge := CompanyQuery.FieldByName('AutoSurcharge').AsBoolean;
         ServiceChargeRate := CompanyQuery.FieldByName('ServiceChargeRate').AsFloat;
         SurchargeName := CompanyQuery.FieldByName('SurchargeName').AsString;
         OtherChargeEnable := CompanyQuery.FieldByName('OtherCharge').AsBoolean;
         OtherChargeName := CompanyQuery.FieldByName('OtherChargeName').AsString;
         OtherChargeRate := CompanyQuery.FieldByName('OtherChargeRate').AsFloat;
         PriceIncludesGST  := CompanyQuery.FieldByName('PriceIncludesGST').AsBoolean;
         DefaultGSTRate := CompanyQuery.FieldByName('DefaultGSTRate').AsFloat;
         DefaultVIPState := CompanyQuery.FieldByName('DefaultVIPState').AsString;
         PrintIngredientsOnJobList := CompanyQuery.FieldByName('PrintIngredientsOnJobList').AsBoolean;
         MaxDiscountPercentage := CompanyQuery.FieldByName('MaxDiscountPercentage').AsFloat;
         MaxDollarDiscount := CompanyQuery.FieldByName('MaxDollarDiscount').AsFloat;
         JobListFontSize := CompanyQuery.FieldByName('JobListFontSize').AsInteger;
         DefaultBackupPath := CompanyQuery.FieldByName('DefaultBackupPath').AsString;
         ShowPrintInvoiceWindow := CompanyQuery.FieldByName('ShowPrintInvoiceWindow').AsBoolean;
         ChangeQtyWithCondiment := CompanyQuery.FieldByName('ChangeQtyWithCondiment').AsBoolean;
         CompulsoryEnterCustomerName := CompanyQuery.FieldByName('CompulsoryEnterCustomerName').AsBoolean;
         AutoPrintCheckList := CompanyQuery.FieldByName('AutoPrintCheckList').AsBoolean;
         PrintOrderNoOnJobList := CompanyQuery.FieldByName('PrintOrderNoOnJobList').AsBoolean;
         PrintOrderNoOnTaxInvoice := CompanyQuery.FieldByName('PrintOrderNoOnTaxInvoice').AsBoolean;
         if HappyHourAvailable then
            begin
             HappyHourStartTime := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourStartTime').AsDateTime));
             HappyHourStartTime1 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourStartTime1').AsDateTime));
             HappyHourStartTime2 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourStartTime2').AsDateTime));
             HappyHourStartTime3 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourStartTime3').AsDateTime));
             HappyHourStartTime4 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourStartTime4').AsDateTime));
             HappyHourStartTime5 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourStartTime5').AsDateTime));
             HappyHourStartTime6 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourStartTime6').AsDateTime));
             HappyHourEndTime := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourEndTime').AsDateTime));
             HappyHourEndTime1 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourEndTime1').AsDateTime));
             HappyHourEndTime2 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourEndTime2').AsDateTime));
             HappyHourEndTime3 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourEndTime3').AsDateTime));
             HappyHourEndTime4 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourEndTime4').AsDateTime));
             HappyHourEndTime5 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourEndTime5').AsDateTime));
             HappyHourEndTime6 := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('HappyHourEndTime6').AsDateTime));
            end
           else
            begin
             HappyHourStartTime  := StrToTime('00:00:00');
             HappyHourStartTime1 := StrToTime('00:00:00');
             HappyHourStartTime2 := StrToTime('00:00:00');
             HappyHourStartTime3 := StrToTime('00:00:00');
             HappyHourStartTime4 := StrToTime('00:00:00');
             HappyHourStartTime5 := StrToTime('00:00:00');
             HappyHourStartTime6 := StrToTime('00:00:00');
             HappyHourEndTime  := StrToTime('00:00:00');
             HappyHourEndTime1 := StrToTime('00:00:00');
             HappyHourEndTime2 := StrToTime('00:00:00');
             HappyHourEndTime3 := StrToTime('00:00:00');
             HappyHourEndTime4 := StrToTime('00:00:00');
             HappyHourEndTime5 := StrToTime('00:00:00');
             HappyHourEndTime6 := StrToTime('00:00:00');
            end;
         LoyaltyAwardAvailible := CompanyQuery.FieldByName('LoyaltyAward').AsBoolean;
         SalesPoints := CompanyQuery.FieldByName('SalesPoints').AsInteger;
         PaymentPoints := CompanyQuery.FieldByName('PaymentPoints').AsInteger;
         ReachPoints := CompanyQuery.FieldByName('ReachPoints').AsInteger;
         if AutoSurcharge then
            begin
             SurchargeStartTime := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('SurchargeStartTime').AsDateTime));
             SurchargeEndTime := StrToTime(FormatDateTime('hh:mm:ss', CompanyQuery.FieldByName('SurchargeEndTime').AsDateTime));
            end
           else
            begin
             SurchargeStartTime := StrToTime('00:00:00');
             SurchargeEndTime := StrToTime('00:00:00');
            end;
         if OtherChargeName = '' then OtherChargeName := 'Other Charge';
         if SurchargeName = '' then SurchargeName := 'Surcharge';
         BackupFrequency := CompanyQuery.FieldByName('BackupFrequency').AsInteger;
         BackupOnceTime := CompanyQuery.FieldByName('BackupOnceTime').AsDateTime;
         if BackupFrequency = 0 then
            DataForm.BackupTimer.Interval := (CompanyQuery.FieldByName('BackupTime').AsInteger + 1) * 3600000
           else
            DataForm.BackupTimer.Interval := 1000;
         DataForm.BackupTimer.Enabled := CompanyQuery.FieldByName('AutoBackup').AsBoolean;
         DiscountRateEnterMode := CompanyQuery.FieldByName('DiscountRateEnterMode').AsInteger;
         ShowNegativeQty := CompanyQuery.FieldByName('ShowNegativeQty').AsBoolean;
         AutoLogout := CompanyQuery.FieldByName('AutoLogout').AsBoolean;
         AutoLogoutTimeOut := CompanyQuery.FieldByName('AutoLogoutTimeOut').AsInteger;
         PrintRedColorQtyOnJobList := CompanyQuery.FieldByName('PrintRedColorQtyOnJobList').AsBoolean;
         MinimumChargeKind := CompanyQuery.FieldByName('MinimumChargeKind').AsInteger;
         MinimumChargeItemCode := CompanyQuery.FieldByName('MinimumChargeItemCode').AsString;
         MinimumChargePerPerson := CompanyQuery.FieldByName('MinimumChargePerPerson').AsFloat;
         CheckListFormat := CompanyQuery.FieldByName('CheckListFormat').AsInteger;
         OnlyOpenDrawerForCashPayment := CompanyQuery.FieldByName('OnlyOpenDrawerForCashPayment').AsBoolean;
         PrintDiscountRateOnBill := CompanyQuery.FieldByName('PrintDiscountRateOnBill').AsBoolean;
         OnlyPrintSimpleFormatDailyReport := CompanyQuery.FieldByName('OnlyPrintSimpleFormatDailyReport').AsBoolean;
         OnlyPrintLastTwoDigitalOrderNo := CompanyQuery.FieldByName('OnlyPrintLastTwoDigitalOrderNo').AsBoolean;
         CheckPrinterStatus := CompanyQuery.FieldByName('CheckPrinterStatus').AsBoolean;
         AutoPrintBillWhenPhoneOrderSaved := CompanyQuery.FieldByName('AutoPrintBillWhenPhoneOrderSaved').AsBoolean;
         AutoAddDeliveryChargeForPhoneOrder := CompanyQuery.FieldByName('AutoAddDeliveryChargeForPhoneOrder').AsBoolean;
         DeliveryChargeItemCode := CompanyQuery.FieldByName('DeliveryChargeItemCode').AsString;
         TableLockFunctionEnabled := CompanyQuery.FieldByName('TableLockFunctionEnabled').AsBoolean;
         PrintZeroQtyItemsOnJobList := CompanyQuery.FieldByName('PrintZeroQtyItemsOnJobList').AsBoolean;
         JobListFormatForPrinter[1] := CompanyQuery.FieldByName('JobListFormatForPrinter1').AsInteger;
         JobListFormatForPrinter[2] := CompanyQuery.FieldByName('JobListFormatForPrinter2').AsInteger;
         JobListFormatForPrinter[3] := CompanyQuery.FieldByName('JobListFormatForPrinter3').AsInteger;
         JobListFormatForPrinter[4] := CompanyQuery.FieldByName('JobListFormatForPrinter4').AsInteger;
         JobListFormatForPrinter[5] := CompanyQuery.FieldByName('JobListFormatForPrinter5').AsInteger;
         JobListFormatForPrinter[6] := CompanyQuery.FieldByName('JobListFormatForPrinter6').AsInteger;
         JobListFormatForPrinter[7] := CompanyQuery.FieldByName('JobListFormatForPrinter7').AsInteger;
         JobListFormatForPrinter[8] := CompanyQuery.FieldByName('JobListFormatForPrinter8').AsInteger;
         JobListFormatForPrinter[9] := CompanyQuery.FieldByName('JobListFormatForPrinter9').AsInteger;
         JobListFormatForPrinter[10] := CompanyQuery.FieldByName('JobListFormatForPrinter10').AsInteger;
         JobListFormatForPrinter[11] := CompanyQuery.FieldByName('JobListFormatForPrinter11').AsInteger;
         JobListFormatForPrinter[12] := CompanyQuery.FieldByName('JobListFormatForPrinter12').AsInteger;
         SecondDisplayDescription := CompanyQuery.FieldByName('SecondDisplayDescription').AsInteger;
         CompanyQuery.Close;
         if MainMenuLine + MainCategoryLine < 13 then Inc(MainMenuLine);
         if POSMenuLine + POSCategoryLine < 13 then Inc(POSMenuLine);
         ReadDevicePortInfo;
         ReadMachineID;
         ReadDVRNo;
         ReadDVRIP;
         ReadDVRUser;
         ReadDVRPWD;
         if FVar.PDAPrinterServer = 1 then DataForm.ActiveSocket;
         DataForm.PrinterStatusCheckTimer.Enabled := CheckPrinterStatus;
         PasswordPanel.Visible := False;
         ControlPanel.Visible := True;
         LogonPro;
         Application.ProcessMessages;
         if FVar.SecondDisplay = 1 then
            begin
             SecondDisplayForm := TSecondDisplayForm.Create(Self);
             SecondDisplayForm.Left := Screen.Width + 1;
             SecondDisplayForm.Top := 0;
             SecondDisplayForm.SetWaitingStatus;
            end;
         if FVar.LinkToEFTPOS = 1 then DataForm.InitToLinkEFTPOS;
         //SecurityForm.SecurityTimer.Enabled := SecurityForm.TestSoftDog;
        end
       else
        NameEdit.SetFocus;
end;

function TControlPanelForm.ConnectDatabase: boolean;
begin
 if (DatabaseComboBox.Text = '') then
    begin
     MessageBoxForm.MessagePro('You have to specify Server Name and Database Name!', sErrorMsg);
     Result := False;
     Exit;
    end;
 sAliasName := DatabaseComboBox.Text;
 sServerName := sAlias[DatabaseComboBox.ItemIndex + 1, 2];
 sDatabaseName := sAlias[DatabaseComboBox.ItemIndex + 1, 3];
 Result := DataForm.ConnectToDatabase(sServerName, sDatabaseName);
 if Result then
    begin
     Result := DataForm.TestDatabaseEdition;
     if Result then
        UpgradeForm.UpgradePro(DataForm.ADOConnection)
       else
        DataForm.ADOConnection.Connected := False;
    end;    
end;

procedure TControlPanelForm.CancelButtonClick(Sender: TObject);
begin
 PasswordPanel.SetFocus;
 LogonPanel.Visible := True;
 PasswordPanel.Visible := False;
 Application.ProcessMessages;
end;

procedure TControlPanelForm.DatabaseComboBoxChange(Sender: TObject);
begin
 sAliasName := '';
 DataForm.ADOConnection.Connected := False;
end;

procedure TControlPanelForm.PasswordEditKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Not (Key In ['0'..'9', 'a'..'z', 'A'..'Z', Chr(8), Chr(13)]) then
    Key := Chr(0);
end;

procedure TControlPanelForm.FormShow(Sender: TObject);
begin
 //Height := Screen.Height;
 //Width := Screen.Width;
  Height := 768;
  Width := 1024;
 //BackPanel.Left := (Screen.Width - BackPanel.Width) div 2;
 //BackPanel.Top := (Screen.Height - BackPanel.Height) div 2;
 //Width := VersionPanel.Width + 16;
 //Height := VersionPanel.Height + ControlPanel.Height + 36;
 Top := (Screen.Height - 768) div 2;
 Left := (Screen.Width - 1024) div 2;
 //Height := 768;
 //VersionPanel.Top := 0;
 //Top :=0;
 //Left :=0;
// VersionPanel.Left := 0;
// ControlPanel.Top := VersionPanel.Top + VersionPanel.Height + 1;
 //LogonPanel.Top := VersionPanel.Top + VersionPanel.Height + 1;
// PasswordPanel.Top := VersionPanel.Top + VersionPanel.Height + 1;
// ControlPanel.Left := 0;
// LogonPanel.Left := 0;
// PasswordPanel.Left := 0;
 ControlPanel.Visible := False;
 PasswordPanel.Visible := False;
 LogonPanel.Visible := True;
 LogoutPro;

 //BookButton.Caption := 'Reservation' + Chr(13) + Chr(10) + '(Booking)';
 TableServiceButton.Caption := 'Table' + Chr(13) + Chr(10) + 'Service';
 //QuickServiceButton.Caption := 'Quick' + Chr(13) + Chr(10) + 'Service';
 QuickServiceButton.Caption := 'Quick Service';
 PhoneOrderButton.Caption := 'Phone' + Chr(13) + Chr(10) + 'Order';
 //MenuSetupButton.Caption := 'Menu' + Chr(13) + Chr(10) + 'Setup';
 //DailyReportButton.Caption := 'Daily' + Chr(13) + Chr(10) + 'Report';
 //AttendanceButton.Caption := 'Clerk' + Chr(13) + Chr(10) + 'Attendance';
 if FileExists(StartDir + 'Logo.JPG') then
    begin
      ImageLogo.Picture.LoadFromFile(StartDir + 'Logo.JPG');
      //CompanyLogo2.Picture.LoadFromFile(StartDir + 'Logo.JPG');
      //CompanyLogo3.Picture.LoadFromFile(StartDir + 'Logo.JPG');
    end;
end;

procedure TControlPanelForm.ControlPanelPro;
begin
 if ControlPanelForm = NIL then
  begin
    ControlPanelForm := TControlPanelForm.Create(Self);
    ControlPanelForm.ShowModal;
  end;  
end;





procedure TControlPanelForm.SpeedButtonTableServiceClick(Sender: TObject);
begin
  ControlPanel.SetFocus;
 TableOrderForm.TableOrderPro(false);
end;

procedure TControlPanelForm.SpeedButtonQuickServiceClick(Sender: TObject);
begin
  ControlPanel.SetFocus;
 PointOfSalesForm.PointOfsalesPro(False);
end;

procedure TControlPanelForm.SpeedButtonMenuSetupClick(Sender: TObject);
begin
  ControlPanel.SetFocus;
  MenuItemForm.MenuSetup(0);
end;

procedure TControlPanelForm.SpeedButtonDailyReportClick(Sender: TObject);
begin
  ControlPanel.SetFocus;
 EndOfdayForm.DailyReportPro(0);
end;

procedure TControlPanelForm.SpeedButtonAttendanceClick(Sender: TObject);
begin
  ControlPanel.SetFocus;
 AttendanceForm.AttendancePro;
end;

procedure TControlPanelForm.SpeedButtonLogoutClick(Sender: TObject);

var
 I: integer;
begin
 if (MainForm.MDIChildCount > 1) then
    MessageBoxForm.MessagePro('Close all windows ', sErrorMsg)
   else
    begin
     {if MainForm.DatabaseBackupMenu.Enabled and
        (MessageBoxForm.MessagePro('Do you want to backup the system?', sConfirmMsg) = mrYes) then
        BackupForm.BackupPro;}
     LogoutPro;
     Application.ProcessMessages;
     for I := 0 to DataForm.ADOConnection.DataSetCount - 1 do
      DataForm.ADOConnection.DataSets[I].Active := False;
     DataForm.ADOConnection.Connected := False;
     DataForm.BackupTimer.Enabled := False;
     SecurityForm.SecurityTimer.Enabled := False;
     DataForm.PrinterStatusCheckTimer.Enabled := False;
     if DataForm.EFTPOS <> NIL then
        begin
         DataForm.EFTPOS.Free;
         DataForm.EFTPOS := NIL;
        end;
    end;
end;

procedure TControlPanelForm.Timer1Timer(Sender: TObject);
begin
  DateLabel.Caption := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now);
end;

procedure TControlPanelForm.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
var
Msg : string;
begin


    if MyCheckErrorMsg(Msg) then
    begin

        if ConnectTimer.Tag = 0 then
        begin
            ConnectTimer.Tag := 9999;
            ConnectTimes := 0;
            MessageBoxForm.MessagePro('With the host lost connection, check network connection.' , sErrorMsg);
            try
                screen.Cursor := crSQLWait;
                DataForm.ADOConnection.Close;
                DataForm.ADOConnection.Open;
                Application.ProcessMessages;
                ConnectTimer.Tag := 0;

            except
                ConnectTimer.Enabled := true;
            end;
            screen.Cursor := crDefault;
        end;
    end;
end;

procedure TControlPanelForm.ConnectTimerTimer(Sender: TObject);
begin
    if (ConnectTimer.Tag = 9999) then
    begin
        inc(ConnectTimes);
        if ConnectTimes>=1 then
        begin
            ConnectTimer.Enabled := false;
            try
                screen.Cursor := crSQLWait;
                DataForm.ADOConnection.Close;
                DataForm.ADOConnection.Open;

            except
            end;
            ConnectTimer.Tag := 0;
            ConnectTimes := 0;
            screen.Cursor := crdefault;
        end;
    end;
end;
end.


