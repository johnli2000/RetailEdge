unit SysConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DataUnit, UtilUnit, Printers, DB, ADODB,
  ComCtrls, bsSkinTabs, BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TConfigurationForm = class(TForm)
    Label5: TLabel;
    Printer1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Printer2: TComboBox;
    Printer3: TComboBox;
    Printer4: TComboBox;
    Label4: TLabel;
    DefaultPrinterComboBox: TComboBox;
    FirstCashDrawerGroupBox: TGroupBox;
    Label7: TLabel;
    CashDrawerPort: TComboBox;
    Label6: TLabel;
    CashDrawerSpeed: TComboBox;
    CashDrawerMode: TComboBox;
    CutCheckBox1: TCheckBox;
    ThermalCheckBox1: TCheckBox;
    Speed1: TComboBox;
    Speed2: TComboBox;
    CutCheckBox2: TCheckBox;
    ThermalCheckBox2: TCheckBox;
    Speed3: TComboBox;
    CutCheckBox3: TCheckBox;
    ThermalCheckBox3: TCheckBox;
    Speed4: TComboBox;
    CutCheckBox4: TCheckBox;
    ThermalCheckBox4: TCheckBox;
    PoleDisplayGroupBox: TGroupBox;
    Label11: TLabel;
    PoleDisplayPortComboBox: TComboBox;
    PoleDisplaySpeedComboBox: TComboBox;
    FlowCtrlComboBox1: TComboBox;
    FlowCtrlComboBox2: TComboBox;
    FlowCtrlComboBox3: TComboBox;
    FlowCtrlComboBox4: TComboBox;
    DrawerFlowCtrlComboBox: TComboBox;
    PoleFlowCtrlComboBox: TComboBox;
    MachineIDPanel: TPanel;
    Label10: TLabel;
    MachineIDEdit: TEdit;
    TillStatusCheckBox: TCheckBox;
    ScaleGroupBox: TGroupBox;
    Label13: TLabel;
    ScalePortComboBox: TComboBox;
    Label14: TLabel;
    ScaleSpeedComboBox: TComboBox;
    ScaleFlowCtrlComboBox: TComboBox;
    Panel2: TPanel;
    SecondDisplayCheckBox: TCheckBox;
    Label9: TLabel;
    SendDescriptionCheckBox: TCheckBox;
    KitchenScreenCheckBox: TCheckBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Printer5: TComboBox;
    Speed5: TComboBox;
    FlowCtrlComboBox5: TComboBox;
    CutCheckBox5: TCheckBox;
    ThermalCheckBox5: TCheckBox;
    Printer6: TComboBox;
    Speed6: TComboBox;
    FlowCtrlComboBox6: TComboBox;
    Printer7: TComboBox;
    Speed7: TComboBox;
    Printer8: TComboBox;
    Speed8: TComboBox;
    FlowCtrlComboBox8: TComboBox;
    FlowCtrlComboBox7: TComboBox;
    CutCheckBox6: TCheckBox;
    ThermalCheckBox6: TCheckBox;
    CutCheckBox7: TCheckBox;
    ThermalCheckBox7: TCheckBox;
    CutCheckBox8: TCheckBox;
    ThermalCheckBox8: TCheckBox;
    TablePageComboBox: TComboBox;
    Label8: TLabel;
    Query: TADOQuery;
    DuplicateComboBox1: TComboBox;
    DuplicateComboBox2: TComboBox;
    DuplicateComboBox3: TComboBox;
    DuplicateComboBox4: TComboBox;
    DuplicateComboBox5: TComboBox;
    DuplicateComboBox6: TComboBox;
    DuplicateComboBox7: TComboBox;
    DuplicateComboBox8: TComboBox;
    Panel3: TPanel;
    PDAPrinterServerCheckBox: TCheckBox;
    DevicePanel: TPanel;
    PrinterPanel: TPanel;
    Label12: TLabel;
    Printer9: TComboBox;
    DuplicateComboBox9: TComboBox;
    Speed9: TComboBox;
    FlowCtrlComboBox9: TComboBox;
    CutCheckBox9: TCheckBox;
    ThermalCheckBox9: TCheckBox;
    Label19: TLabel;
    Printer10: TComboBox;
    DuplicateComboBox10: TComboBox;
    Speed10: TComboBox;
    FlowCtrlComboBox10: TComboBox;
    CutCheckBox10: TCheckBox;
    ThermalCheckBox10: TCheckBox;
    Label20: TLabel;
    Printer11: TComboBox;
    DuplicateComboBox11: TComboBox;
    Speed11: TComboBox;
    FlowCtrlComboBox11: TComboBox;
    CutCheckBox11: TCheckBox;
    ThermalCheckBox11: TCheckBox;
    Label21: TLabel;
    Printer12: TComboBox;
    DuplicateComboBox12: TComboBox;
    Speed12: TComboBox;
    FlowCtrlComboBox12: TComboBox;
    CutCheckBox12: TCheckBox;
    ThermalCheckBox12: TCheckBox;
    LinkToEFTPOSCheckBox: TCheckBox;
    ScaleModelComboBox: TComboBox;
    Model: TLabel;
    GoWithCheckBox1: TCheckBox;
    GoWithCheckBox2: TCheckBox;
    GoWithCheckBox3: TCheckBox;
    GoWithCheckBox4: TCheckBox;
    GoWithCheckBox5: TCheckBox;
    GoWithCheckBox6: TCheckBox;
    GoWithCheckBox7: TCheckBox;
    GoWithCheckBox8: TCheckBox;
    GoWithCheckBox9: TCheckBox;
    GoWithCheckBox10: TCheckBox;
    GoWithCheckBox11: TCheckBox;
    GoWithCheckBox12: TCheckBox;
    SecondCashDrawerGroupBox: TGroupBox;
    Label22: TLabel;
    SecondCashDrawerPort: TComboBox;
    Label23: TLabel;
    SecondCashDrawerSpeed: TComboBox;
    SecondDrawerFlowCtrlComboBox: TComboBox;
    SecondCashDrawerMode: TComboBox;
    SecondTillStatusCheckBox: TCheckBox;
    PrintLogoCheckBox: TCheckBox;
    Label24: TLabel;
    MainMenuGroupCodeEdit: TStaticText;
    MainMenuGroupDescriptionEdit: TStaticText;
    Label25: TLabel;
    POSMenuGroupCodeEdit: TStaticText;
    POSMenuGroupDescriptionEdit: TStaticText;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    PageControl: TbsSkinPageControl;
    Device: TbsSkinTabSheet;
    Printers: TbsSkinTabSheet;
    DevicePanel1: TbsSkinPanel;
    PrinterPanel1: TbsSkinPanel;
    PictureLoadPathSetupButton: TXiButton;
    FeedLinesEdit: TStaticText;
    Label26: TLabel;
    SaveButton: TXiButton;
    CancelButton: TXiButton;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    PoleDisplayModeComboBox: TComboBox;
    Label30: TLabel;
    FirstFeedLinesEdit: TStaticText;
    Label31: TLabel;
    CheckListPrinterPortComboBox: TComboBox;
    SupportChineseCharacterPrinterCheckBox: TCheckBox;
    Label32: TLabel;
    PhoneOrderMenuGroupCodeEdit: TStaticText;
    PhoneOrderMenuGroupDescriptionEdit: TStaticText;
    GroupBox1: TGroupBox;
    Label33: TLabel;
    SecurityCameraPortComboBox: TComboBox;
    SecurityCameraPortSpeedComboBox: TComboBox;
    Label34: TLabel;
    Label35: TLabel;
    SecurityCameraPortControlComboBox: TComboBox;
    JobListTitles: TbsSkinTabSheet;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    TableOrderTitleEdit1: TEdit;
    TableOrderTitleEdit2: TEdit;
    TableOrderTitleEdit3: TEdit;
    TableOrderTitleEdit4: TEdit;
    TableOrderTitleEdit5: TEdit;
    TableOrderTitleEdit6: TEdit;
    TableOrderTitleEdit7: TEdit;
    TableOrderTitleEdit8: TEdit;
    TableOrderTitleEdit9: TEdit;
    TableOrderTitleEdit10: TEdit;
    TableOrderTitleEdit11: TEdit;
    TableOrderTitleEdit12: TEdit;
    TableOrderJobListGroupBox: TGroupBox;
    QuickServiceJobListGroupBox: TGroupBox;
    Label45: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    QuickServiceTitleEdit1: TEdit;
    QuickServiceTitleEdit2: TEdit;
    QuickServiceTitleEdit3: TEdit;
    QuickServiceTitleEdit4: TEdit;
    QuickServiceTitleEdit5: TEdit;
    QuickServiceTitleEdit6: TEdit;
    QuickServiceTitleEdit7: TEdit;
    QuickServiceTitleEdit8: TEdit;
    QuickServiceTitleEdit9: TEdit;
    QuickServiceTitleEdit10: TEdit;
    QuickServiceTitleEdit11: TEdit;
    QuickServiceTitleEdit12: TEdit;
    GroupBox3: TGroupBox;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    PhoneOrderTitleEdit1: TEdit;
    PhoneOrderTitleEdit2: TEdit;
    PhoneOrderTitleEdit3: TEdit;
    PhoneOrderTitleEdit4: TEdit;
    PhoneOrderTitleEdit5: TEdit;
    PhoneOrderTitleEdit6: TEdit;
    PhoneOrderTitleEdit7: TEdit;
    PhoneOrderTitleEdit8: TEdit;
    PhoneOrderTitleEdit9: TEdit;
    PhoneOrderTitleEdit10: TEdit;
    PhoneOrderTitleEdit11: TEdit;
    PhoneOrderTitleEdit12: TEdit;
    GroupBox2: TGroupBox;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    DVRIP_EDIT: TEdit;
    DVRUSERNAME_EDIT: TEdit;
    DVRPWD_Edit: TEdit;
    DVRNo_Edit: TEdit;
    procedure OpenQuery(SQLStr: string);
    procedure SaveButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SetupPro;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MachineIDEditClick(Sender: TObject);
    procedure PictureLoadPathSetupButtonClick(Sender: TObject);
    procedure ReadTablePageInfo;
    procedure MainMenuGroupCodeEditClick(Sender: TObject);
    procedure POSMenuGroupCodeEditClick(Sender: TObject);
    procedure FeedLinesEditClick(Sender: TObject);
    procedure PhoneOrderMenuGroupCodeEditClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfigurationForm: TConfigurationForm;

implementation

uses MainMenu, MachineIDSelect, PictureLoadPathSetup, Keyboard, MessageBox,
     MenuGroupSelect, NumPad;

{$R *.DFM}

procedure TConfigurationForm.OpenQuery(SQLStr: string);
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

procedure TConfigurationForm.SaveButtonClick(Sender: TObject);
begin
 if MachineIDEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Machine ID invalid.', sErrorMsg);
     Exit;
    end;


 StrPCopy(FVar.POSPrinter[1].Name, Printer1.Items[Printer1.ItemIndex]);
 StrPCopy(FVar.POSPrinter[2].Name, Printer2.Items[Printer2.ItemIndex]);
 StrPCopy(FVar.POSPrinter[3].Name, Printer3.Items[Printer3.ItemIndex]);
 StrPCopy(FVar.POSPrinter[4].Name, Printer4.Items[Printer4.ItemIndex]);
 StrPCopy(FVar.POSPrinter[5].Name, Printer5.Items[Printer5.ItemIndex]);
 StrPCopy(FVar.POSPrinter[6].Name, Printer6.Items[Printer6.ItemIndex]);
 StrPCopy(FVar.POSPrinter[7].Name, Printer7.Items[Printer7.ItemIndex]);
 StrPCopy(FVar.POSPrinter[8].Name, Printer8.Items[Printer8.ItemIndex]);
 StrPCopy(FVar.POSPrinter[9].Name, Printer9.Items[Printer9.ItemIndex]);
 StrPCopy(FVar.POSPrinter[10].Name, Printer10.Items[Printer10.ItemIndex]);
 StrPCopy(FVar.POSPrinter[11].Name, Printer11.Items[Printer11.ItemIndex]);
 StrPCopy(FVar.POSPrinter[12].Name, Printer12.Items[Printer12.ItemIndex]);

 FVar.JobListDuplicate[1] := DuplicateComboBox1.ItemIndex;
 FVar.JobListDuplicate[2] := DuplicateComboBox2.ItemIndex;
 FVar.JobListDuplicate[3] := DuplicateComboBox3.ItemIndex;
 FVar.JobListDuplicate[4] := DuplicateComboBox4.ItemIndex;
 FVar.JobListDuplicate[5] := DuplicateComboBox5.ItemIndex;
 FVar.JobListDuplicate[6] := DuplicateComboBox6.ItemIndex;
 FVar.JobListDuplicate[7] := DuplicateComboBox7.ItemIndex;
 FVar.JobListDuplicate[8] := DuplicateComboBox8.ItemIndex;
 FVar.JobListDuplicate[9] := DuplicateComboBox9.ItemIndex;
 FVar.JobListDuplicate[10] := DuplicateComboBox10.ItemIndex;
 FVar.JobListDuplicate[11] := DuplicateComboBox11.ItemIndex;
 FVar.JobListDuplicate[12] := DuplicateComboBox12.ItemIndex;

 FVar.PrinterSpeed[1] := Speed1.ItemIndex;
 FVar.PrinterSpeed[2] := Speed2.ItemIndex;
 FVar.PrinterSpeed[3] := Speed3.ItemIndex;
 FVar.PrinterSpeed[4] := Speed4.ItemIndex;
 FVar.PrinterSpeed[5] := Speed5.ItemIndex;
 FVar.PrinterSpeed[6] := Speed6.ItemIndex;
 FVar.PrinterSpeed[7] := Speed7.ItemIndex;
 FVar.PrinterSpeed[8] := Speed8.ItemIndex;
 FVar.PrinterSpeed[9] := Speed9.ItemIndex;
 FVar.PrinterSpeed[10] := Speed10.ItemIndex;
 FVar.PrinterSpeed[11] := Speed11.ItemIndex;
 FVar.PrinterSpeed[12] := Speed12.ItemIndex;

 FVar.PrinterFlowCtrl[1] := FlowCtrlComboBox1.ItemIndex;
 FVar.PrinterFlowCtrl[2] := FlowCtrlComboBox2.ItemIndex;
 FVar.PrinterFlowCtrl[3] := FlowCtrlComboBox3.ItemIndex;
 FVar.PrinterFlowCtrl[4] := FlowCtrlComboBox4.ItemIndex;
 FVar.PrinterFlowCtrl[5] := FlowCtrlComboBox5.ItemIndex;
 FVar.PrinterFlowCtrl[6] := FlowCtrlComboBox6.ItemIndex;
 FVar.PrinterFlowCtrl[7] := FlowCtrlComboBox7.ItemIndex;
 FVar.PrinterFlowCtrl[8] := FlowCtrlComboBox8.ItemIndex;
 FVar.PrinterFlowCtrl[9] := FlowCtrlComboBox9.ItemIndex;
 FVar.PrinterFlowCtrl[10] := FlowCtrlComboBox10.ItemIndex;
 FVar.PrinterFlowCtrl[11] := FlowCtrlComboBox11.ItemIndex;
 FVar.PrinterFlowCtrl[12] := FlowCtrlComboBox12.ItemIndex;

 if CutCheckBox1.Checked then FVar.AutoCutter[1] := 1 else FVar.AutoCutter[1] := 0;
 if CutCheckBox2.Checked then FVar.AutoCutter[2] := 1 else FVar.AutoCutter[2] := 0;
 if CutCheckBox3.Checked then FVar.AutoCutter[3] := 1 else FVar.AutoCutter[3] := 0;
 if CutCheckBox4.Checked then FVar.AutoCutter[4] := 1 else FVar.AutoCutter[4] := 0;
 if CutCheckBox5.Checked then FVar.AutoCutter[5] := 1 else FVar.AutoCutter[5] := 0;
 if CutCheckBox6.Checked then FVar.AutoCutter[6] := 1 else FVar.AutoCutter[6] := 0;
 if CutCheckBox7.Checked then FVar.AutoCutter[7] := 1 else FVar.AutoCutter[7] := 0;
 if CutCheckBox8.Checked then FVar.AutoCutter[8] := 1 else FVar.AutoCutter[8] := 0;
 if CutCheckBox9.Checked then FVar.AutoCutter[9] := 1 else FVar.AutoCutter[9] := 0;
 if CutCheckBox10.Checked then FVar.AutoCutter[10] := 1 else FVar.AutoCutter[10] := 0;
 if CutCheckBox11.Checked then FVar.AutoCutter[11] := 1 else FVar.AutoCutter[11] := 0;
 if CutCheckBox12.Checked then FVar.AutoCutter[12] := 1 else FVar.AutoCutter[12] := 0;

 if ThermalCheckBox1.Checked then FVar.Thermal[1] := 1 else FVar.Thermal[1] := 0;
 if ThermalCheckBox2.Checked then FVar.Thermal[2] := 1 else FVar.Thermal[2] := 0;
 if ThermalCheckBox3.Checked then FVar.Thermal[3] := 1 else FVar.Thermal[3] := 0;
 if ThermalCheckBox4.Checked then FVar.Thermal[4] := 1 else FVar.Thermal[4] := 0;
 if ThermalCheckBox5.Checked then FVar.Thermal[5] := 1 else FVar.Thermal[5] := 0;
 if ThermalCheckBox6.Checked then FVar.Thermal[6] := 1 else FVar.Thermal[6] := 0;
 if ThermalCheckBox7.Checked then FVar.Thermal[7] := 1 else FVar.Thermal[7] := 0;
 if ThermalCheckBox8.Checked then FVar.Thermal[8] := 1 else FVar.Thermal[8] := 0;
 if ThermalCheckBox9.Checked then FVar.Thermal[9] := 1 else FVar.Thermal[9] := 0;
 if ThermalCheckBox10.Checked then FVar.Thermal[10] := 1 else FVar.Thermal[10] := 0;
 if ThermalCheckBox11.Checked then FVar.Thermal[11] := 1 else FVar.Thermal[11] := 0;
 if ThermalCheckBox12.Checked then FVar.Thermal[12] := 1 else FVar.Thermal[12] := 0;

 if GoWithCheckBox1.Checked then FVar.GoWithMessage[1] := 1 else FVar.GoWithMessage[1] := 0;
 if GoWithCheckBox2.Checked then FVar.GoWithMessage[2] := 1 else FVar.GoWithMessage[2] := 0;
 if GoWithCheckBox3.Checked then FVar.GoWithMessage[3] := 1 else FVar.GoWithMessage[3] := 0;
 if GoWithCheckBox4.Checked then FVar.GoWithMessage[4] := 1 else FVar.GoWithMessage[4] := 0;
 if GoWithCheckBox5.Checked then FVar.GoWithMessage[5] := 1 else FVar.GoWithMessage[5] := 0;
 if GoWithCheckBox6.Checked then FVar.GoWithMessage[6] := 1 else FVar.GoWithMessage[6] := 0;
 if GoWithCheckBox7.Checked then FVar.GoWithMessage[7] := 1 else FVar.GoWithMessage[7] := 0;
 if GoWithCheckBox8.Checked then FVar.GoWithMessage[8] := 1 else FVar.GoWithMessage[8] := 0;
 if GoWithCheckBox9.Checked then FVar.GoWithMessage[9] := 1 else FVar.GoWithMessage[9] := 0;
 if GoWithCheckBox10.Checked then FVar.GoWithMessage[10] := 1 else FVar.GoWithMessage[10] := 0;
 if GoWithCheckBox11.Checked then FVar.GoWithMessage[11] := 1 else FVar.GoWithMessage[11] := 0;
 if GoWithCheckBox12.Checked then FVar.GoWithMessage[12] := 1 else FVar.GoWithMessage[12] := 0;

 FVar.DefaultPrinter := DefaultPrinterComboBox.ItemIndex;
 FVar.CheckListPrinterPort := CheckListPrinterPortComboBox.ItemIndex;

 if PrintLogoCheckBox.Checked then
    FVar.PrintLogoOnPOSPrinter := 1
   else
    FVar.PrintLogoOnPOSPrinter := 0;

 if TillStatusCheckBox.Checked then
    FVar.CheckTillStatus := 1
   else
    FVar.CheckTillStatus := 0;

 if SupportChineseCharacterPrinterCheckBox.Checked then
    FVar.SupportChineseCharacterPrinter := 1
   else
    FVar.SupportChineseCharacterPrinter := 0;

 FVar.CashDrawerPort := CashDrawerPort.ItemIndex;
 Fvar.CashDrawerSpeed := CashDrawerSpeed.ItemIndex;
 FVar.CashDrawerMode := CashDrawerMode.ItemIndex;
 Fvar.DrawerFlowCtrl := DrawerFlowCtrlComboBox.ItemIndex;

 if SecondTillStatusCheckBox.Checked then
    FVar.SecondCheckTillStatus := 1
   else
    FVar.SecondCheckTillStatus := 0;
 FVar.SecondCashDrawerPort := SecondCashDrawerPort.ItemIndex;
 Fvar.SecondCashDrawerSpeed := SecondCashDrawerSpeed.ItemIndex;
 FVar.SecondCashDrawerMode := SecondCashDrawerMode.ItemIndex;
 Fvar.SecondDrawerFlowCtrl := SecondDrawerFlowCtrlComboBox.ItemIndex;

 FVar.PoleDisplayPort := PoleDisplayPortComboBox.ItemIndex;
 FVar.PoleDisplaySpeed := PoleDisplaySpeedComboBox.ItemIndex;
 Fvar.PoleFlowCtrl := PoleFlowCtrlComboBox.ItemIndex;
 FVar.PoleDisplayMode := PoleDisplayModeComboBox.ItemIndex;

 FVar.SecurityCameraPort := SecurityCameraPortComboBox.ItemIndex;
 Fvar.SecurityCameraPortSpeed := SecurityCameraPortSpeedComboBox.ItemIndex;
 Fvar.SecurityCameraPortControl := SecurityCameraPortControlComboBox.ItemIndex;

 if PDAPrinterServerCheckBox.Checked then
    FVar.PDAPrinterServer := 1
   else
    FVar.PDAPrinterServer := 0;

 if KitchenScreenCheckBox.Checked then
    FVar.KitchenScreen := 1
   else
    FVar.KitchenScreen := 0;

 FVar.ScalePort := ScalePortComboBox.ItemIndex;
 FVar.ScaleSpeed := ScaleSpeedComboBox.ItemIndex;
 FVar.ScaleFlowCtrl := ScaleFlowCtrlComboBox.ItemIndex;
 FVar.ScaleModel := ScaleModelComboBox.ItemIndex;

 if SecondDisplayCheckBox.Checked then
    FVar.SecondDisplay := 1
   else
    FVar.SecondDisplay := 0;

 if LinkToEFTPOSCheckBox.Checked then
    FVar.LinkToEFTPOS := 1
   else
    FVar.LinkToEFTPOS := 0;

 if SendDescriptionCheckBox.Checked then
    FVar.SendDescription := 1
   else
    Fvar.SendDescription := 0;
 if TablePageComboBox.ItemIndex < 0 then
    FVar.DefaultTablePage := 0
   else
    FVar.DefaultTablePage := TablePageComboBox.ItemIndex;
 FVar.DefaultMainMenuGroupCode := StrToInt(MainMenuGroupCodeEdit.Caption);
 FVar.DefaultPOSMenuGroupCode := StrToInt(POSMenuGroupCodeEdit.Caption);
 FVar.DefaultPhoneOrderMenuGroupCode := StrToInt(PhoneOrderMenuGroupCodeEdit.Caption);
 FVar.FeedLines := StrToInt(FeedLinesEdit.Caption);
 FVar.FirstFeedLines := StrToInt(FirstFeedLinesEdit.Caption);

 StrPCopy(FVar.TableOrderJobListTitle[1].TitleName, TableOrderTitleEdit1.Text);
 StrPCopy(FVar.TableOrderJobListTitle[2].TitleName, TableOrderTitleEdit2.Text);
 StrPCopy(FVar.TableOrderJobListTitle[3].TitleName, TableOrderTitleEdit3.Text);
 StrPCopy(FVar.TableOrderJobListTitle[4].TitleName, TableOrderTitleEdit4.Text);
 StrPCopy(FVar.TableOrderJobListTitle[5].TitleName, TableOrderTitleEdit5.Text);
 StrPCopy(FVar.TableOrderJobListTitle[6].TitleName, TableOrderTitleEdit6.Text);
 StrPCopy(FVar.TableOrderJobListTitle[7].TitleName, TableOrderTitleEdit7.Text);
 StrPCopy(FVar.TableOrderJobListTitle[8].TitleName, TableOrderTitleEdit8.Text);
 StrPCopy(FVar.TableOrderJobListTitle[9].TitleName, TableOrderTitleEdit9.Text);
 StrPCopy(FVar.TableOrderJobListTitle[10].TitleName, TableOrderTitleEdit10.Text);
 StrPCopy(FVar.TableOrderJobListTitle[11].TitleName, TableOrderTitleEdit11.Text);
 StrPCopy(FVar.TableOrderJobListTitle[12].TitleName, TableOrderTitleEdit12.Text);

 StrPCopy(FVar.QuickServiceJobListTitle[1].TitleName, QuickServiceTitleEdit1.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[2].TitleName, QuickServiceTitleEdit2.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[3].TitleName, QuickServiceTitleEdit3.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[4].TitleName, QuickServiceTitleEdit4.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[5].TitleName, QuickServiceTitleEdit5.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[6].TitleName, QuickServiceTitleEdit6.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[7].TitleName, QuickServiceTitleEdit7.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[8].TitleName, QuickServiceTitleEdit8.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[9].TitleName, QuickServiceTitleEdit9.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[10].TitleName, QuickServiceTitleEdit10.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[11].TitleName, QuickServiceTitleEdit11.Text);
 StrPCopy(FVar.QuickServiceJobListTitle[12].TitleName, QuickServiceTitleEdit12.Text);

 StrPCopy(FVar.PhoneOrderJobListTitle[1].TitleName, PhoneOrderTitleEdit1.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[2].TitleName, PhoneOrderTitleEdit2.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[3].TitleName, PhoneOrderTitleEdit3.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[4].TitleName, PhoneOrderTitleEdit4.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[5].TitleName, PhoneOrderTitleEdit5.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[6].TitleName, PhoneOrderTitleEdit6.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[7].TitleName, PhoneOrderTitleEdit7.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[8].TitleName, PhoneOrderTitleEdit8.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[9].TitleName, PhoneOrderTitleEdit9.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[10].TitleName, PhoneOrderTitleEdit10.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[11].TitleName, PhoneOrderTitleEdit11.Text);
 StrPCopy(FVar.PhoneOrderJobListTitle[12].TitleName, PhoneOrderTitleEdit12.Text);

 SaveDevicePortInfo;
 if MachineID <> MachineIDEdit.Text then
    begin
     MachineID := MachineIDEdit.Text;
     SaveMachineID;
    end;

 if DVRNo_Edit.Text <> '' then
  begin
    DVRNo := DVRNo_Edit.Text;
    SaveDVRNo;
  end;
 if DVRIP_EDIT.Text <> '' then
  begin
    DVRIP := DVRIP_EDIT.Text;
    SaveDVRIP;
  end;
 if DVRUSERNAME_EDIT.Text <> ''then
  begin
    DVRUser := DVRUSERNAME_EDIT.Text;
    SaveDVRUser;
  end;
 if DVRPWD_Edit.Text <> '' then
  begin
    DVRPWD := DVRPWD_Edit.Text;
    SaveDVRPWD;
  end;   
 if PDAPrinterServerCheckBox.Checked then DataForm.ActiveSocket;
 Close;
end;

procedure TConfigurationForm.CancelButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TConfigurationForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TConfigurationForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_F8 then SaveButtonClick(Sender)
   else
    if Key = VK_F10 then CancelButtonClick(Sender);
end;

procedure TConfigurationForm.MainMenuGroupCodeEditClick(Sender: TObject);
var
 MenuGroupCode, MenuGroupDescription: string;
begin
 if MenuGroupSelectForm.MenuGroupSelectPro(MenuGroupCode, MenuGroupDescription) then
    begin
     MainMenuGroupCodeEdit.Caption := MenuGroupCode;
     MainMenuGroupDescriptionEdit.Caption := MenuGroupDescription;
    end;
end;

procedure TConfigurationForm.POSMenuGroupCodeEditClick(Sender: TObject);
var
 MenuGroupCode, MenuGroupDescription: string;
begin
 if MenuGroupSelectForm.MenuGroupSelectPro(MenuGroupCode, MenuGroupDescription) then
    begin
     POSMenuGroupCodeEdit.Caption := MenuGroupCode;
     POSMenuGroupDescriptionEdit.Caption := MenuGroupDescription;
    end;
end;

procedure TConfigurationForm.PhoneOrderMenuGroupCodeEditClick(Sender: TObject);
var
 MenuGroupCode, MenuGroupDescription: string;
begin
 if MenuGroupSelectForm.MenuGroupSelectPro(MenuGroupCode, MenuGroupDescription) then
    begin
     PhoneOrderMenuGroupCodeEdit.Caption := MenuGroupCode;
     PhoneOrderMenuGroupDescriptionEdit.Caption := MenuGroupDescription;
    end;
end;

procedure TConfigurationForm.MachineIDEditClick(Sender: TObject);
var
 MachineName: string;
begin
 if MachineIDSelectForm.MachineIDSelectPro(MachineName) then
    MachineIDEdit.Text := MachineName;
end;

procedure TConfigurationForm.PictureLoadPathSetupButtonClick(Sender: TObject);
begin
 PictureLoadPathSetupForm.SetupPro;
end;

procedure TConfigurationForm.ReadTablePageInfo;
var
 SQLStr: string;
begin
 TablePageComboBox.Items.Clear;
 SQLStr := 'Select * From TablePage Order By PageNo';
 OpenQuery(SQLStr);
 with Query do
  begin
   if Active and (RecordCount >= 1) then
      while Not EOF do
       begin
        TablePageComboBox.Items.Add(FieldByName('Description').AsString);
        Next;
       end;
   Close;
  end;
end;

procedure TConfigurationForm.FeedLinesEditClick(Sender: TObject);
var
 NumStr: string;
begin
 with Sender As TStaticText do
  begin
   NumStr := Caption;
   if NumberPadForm.ReadNumberPro(NumStr, False, False, 'Printer feeds lines', 0) then
      Caption := Format('%1d', [StrToInt(NumStr)]);
  end;
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
var
 I: Integer;
 SQLStr: string;
begin
 Width := PageControl.Width + 28;
 DataForm.PrinterStatusCheckTimer.Enabled := False;
 ReadTablePageInfo;
 ReadDevicePortInfo;
 Printer1.Items.Add('N/A');
 for I := 1 to 8 do Printer1.Items.Add('COM' + IntToStr(I));
 Printer1.Items.Add('LPT1');
 I := 0;
 while I < Printer.Printers.Count do
  begin
   Printer1.Items.Add(Printer.Printers[I]);
   I := I + 1;
  end;
 Printer2.Items := Printer1.Items;
 Printer3.Items := Printer1.Items;
 Printer4.Items := Printer1.Items;
 Printer5.Items := Printer1.Items;
 Printer6.Items := Printer1.Items;
 Printer7.Items := Printer1.Items;
 Printer8.Items := Printer1.Items;
 Printer9.Items := Printer1.Items;
 Printer10.Items := Printer1.Items;
 Printer11.Items := Printer1.Items;
 Printer12.Items := Printer1.Items;

 I := SearchString(Printer1.Items, String(FVar.POSPrinter[1].Name));
 if I < 0 then I := 0;
 Printer1.ItemIndex := I;

 I := SearchString(Printer2.Items, String(FVar.POSPrinter[2].Name));
 if I < 0 then I := 0;
 Printer2.ItemIndex := I;

 I := SearchString(Printer3.Items, String(FVar.POSPrinter[3].Name));
 if I < 0 then I := 0;
 Printer3.ItemIndex := I;

 I := SearchString(Printer4.Items, String(FVar.POSPrinter[4].Name));
 if I < 0 then I := 0;
 Printer4.ItemIndex := I;

 I := SearchString(Printer5.Items, String(FVar.POSPrinter[5].Name));
 if I < 0 then I := 0;
 Printer5.ItemIndex := I;

 I := SearchString(Printer6.Items, String(FVar.POSPrinter[6].Name));
 if I < 0 then I := 0;
 Printer6.ItemIndex := I;

 I := SearchString(Printer7.Items, String(FVar.POSPrinter[7].Name));
 if I < 0 then I := 0;
 Printer7.ItemIndex := I;

 I := SearchString(Printer8.Items, String(FVar.POSPrinter[8].Name));
 if I < 0 then I := 0;
 Printer8.ItemIndex := I;

 I := SearchString(Printer9.Items, String(FVar.POSPrinter[9].Name));
 if I < 0 then I := 0;
 Printer9.ItemIndex := I;

 I := SearchString(Printer10.Items, String(FVar.POSPrinter[10].Name));
 if I < 0 then I := 0;
 Printer10.ItemIndex := I;

 I := SearchString(Printer11.Items, String(FVar.POSPrinter[11].Name));
 if I < 0 then I := 0;
 Printer11.ItemIndex := I;

 I := SearchString(Printer12.Items, String(FVar.POSPrinter[12].Name));
 if I < 0 then I := 0;
 Printer12.ItemIndex := I;


 DuplicateComboBox1.ItemIndex := FVar.JobListDuplicate[1];
 DuplicateComboBox2.ItemIndex := FVar.JobListDuplicate[2];
 DuplicateComboBox3.ItemIndex := FVar.JobListDuplicate[3];
 DuplicateComboBox4.ItemIndex := FVar.JobListDuplicate[4];
 DuplicateComboBox5.ItemIndex := FVar.JobListDuplicate[5];
 DuplicateComboBox6.ItemIndex := FVar.JobListDuplicate[6];
 DuplicateComboBox7.ItemIndex := FVar.JobListDuplicate[7];
 DuplicateComboBox8.ItemIndex := FVar.JobListDuplicate[8];
 DuplicateComboBox9.ItemIndex := FVar.JobListDuplicate[9];
 DuplicateComboBox10.ItemIndex := FVar.JobListDuplicate[10];
 DuplicateComboBox11.ItemIndex := FVar.JobListDuplicate[11];
 DuplicateComboBox12.ItemIndex := FVar.JobListDuplicate[12];

 Speed1.ItemIndex := FVar.PrinterSpeed[1];
 Speed2.ItemIndex := FVar.PrinterSpeed[2];
 Speed3.ItemIndex := FVar.PrinterSpeed[3];
 Speed4.ItemIndex := FVar.PrinterSpeed[4];
 Speed5.ItemIndex := FVar.PrinterSpeed[5];
 Speed6.ItemIndex := FVar.PrinterSpeed[6];
 Speed7.ItemIndex := FVar.PrinterSpeed[7];
 Speed8.ItemIndex := FVar.PrinterSpeed[8];
 Speed9.ItemIndex := FVar.PrinterSpeed[9];
 Speed10.ItemIndex := FVar.PrinterSpeed[10];
 Speed11.ItemIndex := FVar.PrinterSpeed[11];
 Speed12.ItemIndex := FVar.PrinterSpeed[12];

 FlowCtrlComboBox1.ItemIndex := FVar.PrinterFlowCtrl[1];
 FlowCtrlComboBox2.ItemIndex := FVar.PrinterFlowCtrl[2];
 FlowCtrlComboBox3.ItemIndex := FVar.PrinterFlowCtrl[3];
 FlowCtrlComboBox4.ItemIndex := FVar.PrinterFlowCtrl[4];
 FlowCtrlComboBox5.ItemIndex := FVar.PrinterFlowCtrl[5];
 FlowCtrlComboBox6.ItemIndex := FVar.PrinterFlowCtrl[6];
 FlowCtrlComboBox7.ItemIndex := FVar.PrinterFlowCtrl[7];
 FlowCtrlComboBox8.ItemIndex := FVar.PrinterFlowCtrl[8];
 FlowCtrlComboBox9.ItemIndex := FVar.PrinterFlowCtrl[9];
 FlowCtrlComboBox10.ItemIndex := FVar.PrinterFlowCtrl[10];
 FlowCtrlComboBox11.ItemIndex := FVar.PrinterFlowCtrl[11];
 FlowCtrlComboBox12.ItemIndex := FVar.PrinterFlowCtrl[12];

 CutCheckBox1.Checked := FVar.AutoCutter[1]=1;
 CutCheckBox2.Checked := FVar.AutoCutter[2]=1;
 CutCheckBox3.Checked := FVar.AutoCutter[3]=1;
 CutCheckBox4.Checked := FVar.AutoCutter[4]=1;
 CutCheckBox5.Checked := FVar.AutoCutter[5]=1;
 CutCheckBox6.Checked := FVar.AutoCutter[6]=1;
 CutCheckBox7.Checked := FVar.AutoCutter[7]=1;
 CutCheckBox8.Checked := FVar.AutoCutter[8]=1;
 CutCheckBox9.Checked := FVar.AutoCutter[9]=1;
 CutCheckBox10.Checked := FVar.AutoCutter[10]=1;
 CutCheckBox11.Checked := FVar.AutoCutter[11]=1;
 CutCheckBox12.Checked := FVar.AutoCutter[12]=1;

 ThermalCheckBox1.Checked := FVar.Thermal[1] = 1;
 ThermalCheckBox2.Checked := FVar.Thermal[2] = 1;
 ThermalCheckBox3.Checked := FVar.Thermal[3] = 1;
 ThermalCheckBox4.Checked := FVar.Thermal[4] = 1;
 ThermalCheckBox5.Checked := FVar.Thermal[5] = 1;
 ThermalCheckBox6.Checked := FVar.Thermal[6] = 1;
 ThermalCheckBox7.Checked := FVar.Thermal[7] = 1;
 ThermalCheckBox8.Checked := FVar.Thermal[8] = 1;
 ThermalCheckBox9.Checked := FVar.Thermal[9] = 1;
 ThermalCheckBox10.Checked := FVar.Thermal[10] = 1;
 ThermalCheckBox11.Checked := FVar.Thermal[11] = 1;
 ThermalCheckBox12.Checked := FVar.Thermal[12] = 1;

 GoWithCheckBox1.Checked := FVar.GoWithMessage[1] = 1;
 GoWithCheckBox2.Checked := FVar.GoWithMessage[2] = 1;
 GoWithCheckBox3.Checked := FVar.GoWithMessage[3] = 1;
 GoWithCheckBox4.Checked := FVar.GoWithMessage[4] = 1;
 GoWithCheckBox5.Checked := FVar.GoWithMessage[5] = 1;
 GoWithCheckBox6.Checked := FVar.GoWithMessage[6] = 1;
 GoWithCheckBox7.Checked := FVar.GoWithMessage[7] = 1;
 GoWithCheckBox8.Checked := FVar.GoWithMessage[8] = 1;
 GoWithCheckBox9.Checked := FVar.GoWithMessage[9] = 1;
 GoWithCheckBox10.Checked := FVar.GoWithMessage[10] = 1;
 GoWithCheckBox11.Checked := FVar.GoWithMessage[11] = 1;
 GoWithCheckBox12.Checked := FVar.GoWithMessage[12] = 1;

 DefaultPrinterComboBox.ItemIndex := FVar.DefaultPrinter;
 CheckListPrinterPortComboBox.ItemIndex := FVar.CheckListPrinterPort;

 KitchenScreenCheckBox.Checked := FVar.KitchenScreen <> 0;
 PrintLogoCheckBox.Checked := FVar.PrintLogoOnPOSPrinter = 1;
 SupportChineseCharacterPrinterCheckBox.Checked := FVar.SupportChineseCharacterPrinter = 1;
 CashDrawerPort.ItemIndex := FVar.CashDrawerPort;
 CashDrawerSpeed.ItemIndex := FVar.CashDrawerSpeed;
 CashDrawerMode.ItemIndex := FVar.CashDrawerMode;
 DrawerFlowCtrlComboBox.ItemIndex := Fvar.DrawerFlowCtrl;
 TillStatusCheckBox.Checked := FVar.CheckTillStatus = 1;

 SecondCashDrawerPort.ItemIndex := FVar.SecondCashDrawerPort;
 SecondCashDrawerSpeed.ItemIndex := FVar.SecondCashDrawerSpeed;
 SecondCashDrawerMode.ItemIndex := FVar.SecondCashDrawerMode;
 SecondDrawerFlowCtrlComboBox.ItemIndex := Fvar.SecondDrawerFlowCtrl;
 SecondTillStatusCheckBox.Checked := FVar.SecondCheckTillStatus = 1;

 PoleDisplayPortComboBox.ItemIndex := FVar.PoleDisplayPort;
 PoleDisplaySpeedComboBox.ItemIndex := FVar.PoleDisplaySpeed;
 PoleFlowCtrlComboBox.ItemIndex := Fvar.PoleFlowCtrl;
 PoleDisplayModeComboBox.ItemIndex := FVar.PoleDisplayMode;

 SecurityCameraPortComboBox.ItemIndex := FVar.SecurityCameraPort;
 SecurityCameraPortSpeedComboBox.ItemIndex := Fvar.SecurityCameraPortSpeed;
 SecurityCameraPortControlComboBox.ItemIndex := Fvar.SecurityCameraPortControl;

 SendDescriptionCheckBox.Checked := FVar.SendDescription = 1;
 ScalePortComboBox.ItemIndex := FVar.ScalePort;
 ScaleSpeedComboBox.ItemIndex := FVar.ScaleSpeed;
 ScaleFlowCtrlComboBox.ItemIndex := FVar.ScaleFlowCtrl;
 ScaleModelComboBox.ItemIndex := FVar.ScaleModel;

 SecondDisplayCheckBox.Checked := FVar.SecondDisplay = 1;
 PDAPrinterServerCheckBox.Checked := FVar.PDAPrinterServer = 1;
 LinkToEFTPOSCheckBox.Checked := FVar.LinkToEFTPOS = 1;
 MainMenuGroupCodeEdit.Caption := Format('%2.2d', [FVar.DefaultMainMenuGroupCode]);
 POSMenuGroupCodeEdit.Caption := Format('%2.2d', [FVar.DefaultPOSMenuGroupCode]);
 PhoneOrderMenuGroupCodeEdit.Caption := Format('%2.2d', [FVar.DefaultPOSMenuGroupCode]);
 if FVar.DefaultTablePage <= TablePageComboBox.Items.Count then
    TablePageComboBox.ItemIndex := FVar.DefaultTablePage
   else
    TablePageComboBox.ItemIndex := -1;
 MachineIDEdit.Text := MachineID;
 FeedLinesEdit.Caption := Format('%1d', [FVar.FeedLines]);
 FirstFeedLinesEdit.Caption := Format('%1d', [FVar.FirstFeedLines]);
 DVRNo_Edit.Text := DVRNo;
 DVRIP_EDIT.Text := DVRIP;
 DVRUSERNAME_EDIT.Text := DVRUser;
 DVRPWD_Edit.Text := DVRPWD;
 TableOrderTitleEdit1.Text := String(FVar.TableOrderJobListTitle[1].TitleName);
 TableOrderTitleEdit2.Text := String(FVar.TableOrderJobListTitle[2].TitleName);
 TableOrderTitleEdit3.Text := String(FVar.TableOrderJobListTitle[3].TitleName);
 TableOrderTitleEdit4.Text := String(FVar.TableOrderJobListTitle[4].TitleName);
 TableOrderTitleEdit5.Text := String(FVar.TableOrderJobListTitle[5].TitleName);
 TableOrderTitleEdit6.Text := String(FVar.TableOrderJobListTitle[6].TitleName);
 TableOrderTitleEdit7.Text := String(FVar.TableOrderJobListTitle[7].TitleName);
 TableOrderTitleEdit8.Text := String(FVar.TableOrderJobListTitle[8].TitleName);
 TableOrderTitleEdit9.Text := String(FVar.TableOrderJobListTitle[9].TitleName);
 TableOrderTitleEdit10.Text := String(FVar.TableOrderJobListTitle[10].TitleName);
 TableOrderTitleEdit11.Text := String(FVar.TableOrderJobListTitle[11].TitleName);
 TableOrderTitleEdit12.Text := String(FVar.TableOrderJobListTitle[12].TitleName);

 QuickServiceTitleEdit1.Text := String(FVar.QuickServiceJobListTitle[1].TitleName);
 QuickServiceTitleEdit2.Text := String(FVar.QuickServiceJobListTitle[2].TitleName);
 QuickServiceTitleEdit3.Text := String(FVar.QuickServiceJobListTitle[3].TitleName);
 QuickServiceTitleEdit4.Text := String(FVar.QuickServiceJobListTitle[4].TitleName);
 QuickServiceTitleEdit5.Text := String(FVar.QuickServiceJobListTitle[5].TitleName);
 QuickServiceTitleEdit6.Text := String(FVar.QuickServiceJobListTitle[6].TitleName);
 QuickServiceTitleEdit7.Text := String(FVar.QuickServiceJobListTitle[7].TitleName);
 QuickServiceTitleEdit8.Text := String(FVar.QuickServiceJobListTitle[8].TitleName);
 QuickServiceTitleEdit9.Text := String(FVar.QuickServiceJobListTitle[9].TitleName);
 QuickServiceTitleEdit10.Text := String(FVar.QuickServiceJobListTitle[10].TitleName);
 QuickServiceTitleEdit11.Text := String(FVar.QuickServiceJobListTitle[11].TitleName);
 QuickServiceTitleEdit12.Text := String(FVar.QuickServiceJobListTitle[12].TitleName);

 PhoneOrderTitleEdit1.Text := String(FVar.PhoneOrderJobListTitle[1].TitleName);
 PhoneOrderTitleEdit2.Text := String(FVar.PhoneOrderJobListTitle[2].TitleName);
 PhoneOrderTitleEdit3.Text := String(FVar.PhoneOrderJobListTitle[3].TitleName);
 PhoneOrderTitleEdit4.Text := String(FVar.PhoneOrderJobListTitle[4].TitleName);
 PhoneOrderTitleEdit5.Text := String(FVar.PhoneOrderJobListTitle[5].TitleName);
 PhoneOrderTitleEdit6.Text := String(FVar.PhoneOrderJobListTitle[6].TitleName);
 PhoneOrderTitleEdit7.Text := String(FVar.PhoneOrderJobListTitle[7].TitleName);
 PhoneOrderTitleEdit8.Text := String(FVar.PhoneOrderJobListTitle[8].TitleName);
 PhoneOrderTitleEdit9.Text := String(FVar.PhoneOrderJobListTitle[9].TitleName);
 PhoneOrderTitleEdit10.Text := String(FVar.PhoneOrderJobListTitle[10].TitleName);
 PhoneOrderTitleEdit11.Text := String(FVar.PhoneOrderJobListTitle[11].TitleName);
 PhoneOrderTitleEdit12.Text := String(FVar.PhoneOrderJobListTitle[12].TitleName);

 SQLStr := 'Select * From MenuGroupTable ' +
            'Where Code=' + Chr(39) + CheckQuotes(MainMenuGroupCodeEdit.Caption) + Chr(39);
 DataForm.OpenCheckQuery(SQLStr);
 MainMenuGroupDescriptionEdit.Caption := DataForm.CheckQuery.FieldByName('Description').AsString;

 SQLStr := 'Select * From MenuGroupTable ' +
            'Where Code=' + Chr(39) + CheckQuotes(POSMenuGroupCodeEdit.Caption) + Chr(39);
 DataForm.OpenCheckQuery(SQLStr);
 POSMenuGroupDescriptionEdit.Caption := DataForm.CheckQuery.FieldByName('Description').AsString;

 SQLStr := 'Select * From MenuGroupTable ' +
            'Where Code=' + Chr(39) + CheckQuotes(PhoneOrderMenuGroupCodeEdit.Caption) + Chr(39);
 DataForm.OpenCheckQuery(SQLStr);
 PhoneOrderMenuGroupDescriptionEdit.Caption := DataForm.CheckQuery.FieldByName('Description').AsString;
 DataForm.CheckQuery.Close;
end;

procedure TConfigurationForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DataForm.PrinterStatusCheckTimer.Enabled := CheckPrinterStatus;
 Action := caFree;
end;

procedure TConfigurationForm.SetupPro;
begin
 Application.CreateForm(TConfigurationForm, ConfigurationForm);
 ConfigurationForm.ShowModal;
 ConfigurationForm.Free;
end;

end.
