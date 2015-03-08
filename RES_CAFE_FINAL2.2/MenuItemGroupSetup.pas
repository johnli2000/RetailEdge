unit MenuItemGroupSetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, DB, Grids, DBGrids, UtilUnit,
  ExtDlgs, ADODB, MainMenu, BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TMenuItemGroupSetupForm = class(TForm)
    Label11: TLabel;
    PrinterPortComboBox: TComboBox;
    PrinterPortComboBox1: TComboBox;
    PrinterPortComboBox2: TComboBox;
    PrintGroupBox: TGroupBox;
    PrinterSetupCheckBox: TCheckBox;
    KitchenScreenSetupCheckBox: TCheckBox;
    KitchenScreenGroupBox: TGroupBox;
    KitchenScreenFontColorPanel: TPanel;
    ColorBox: TColorDialog;
    PrinterPortComboBox3: TComboBox;
    bsBusinessSkinForm: TbsBusinessSkinForm;
    EditPanel: TbsSkinPanel;
    SaveButton: TXiButton;
    ExitButton: TXiButton;
    ColorButton: TbsSkinSpeedButton;
    bsSkinPanel1: TbsSkinPanel;
    ChangeGSTRateCheckBox: TCheckBox;
    GSTRateEdit: TStaticText;
    StaticText1: TStaticText;
    ChangeGroupCheckBox: TCheckBox;
    ChangeJobListColorCheckBox: TCheckBox;
    JobListColorComboBox: TComboBox;
    ChangeItemActiveCheckBox: TCheckBox;
    ActiveCheckBox: TCheckBox;
    ChangeInstructionCheckBox: TCheckBox;
    InstructionCheckBox: TCheckBox;
    ChangeMultiplePriceCheckBox: TCheckBox;
    MultiplePriceCheckBox: TCheckBox;
    ChangeOpenPriceCheckBox: TCheckBox;
    OpenPriceCheckBox: TCheckBox;
    ChangeAllowDiscountCheckBox: TCheckBox;
    AllowDiscountCheckBox: TCheckBox;
    GroupComboBox: TComboBox;
    Query: TADOQuery;
    ChangeMenuButtonPositionCheckBox: TCheckBox;
    MenuButtonComboBox: TComboBox;
    CategoryComboBox: TComboBox;
    KitchenScreenComboBox1: TComboBox;
    KitchenScreenComboBox2: TComboBox;
    KitchenScreenComboBox3: TComboBox;
    KitchenScreenComboBox4: TComboBox;
    ChangePrintSubDescriptionCheckBox: TCheckBox;
    PrintSubDescriptionFirstCheckBox: TCheckBox;
    procedure OpenQuery(SQLStr: string);
    procedure FormShow(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MenuItemGroupSetupPro;
    procedure SaveButtonClick(Sender: TObject);
    procedure ColorButtonClick(Sender: TObject);
    procedure PrinterSetupCheckBoxClick(Sender: TObject);
    procedure KitchenScreenSetupCheckBoxClick(Sender: TObject);
    procedure ChangeGSTRateCheckBoxClick(Sender: TObject);
    procedure ChangeGroupCheckBoxClick(Sender: TObject);
    procedure ChangeJobListColorCheckBoxClick(Sender: TObject);
    procedure ChangeItemActiveCheckBoxClick(Sender: TObject);
    procedure ChangeInstructionCheckBoxClick(Sender: TObject);
    procedure ChangeMultiplePriceCheckBoxClick(Sender: TObject);
    procedure ChangeOpenPriceCheckBoxClick(Sender: TObject);
    procedure ChangeAllowDiscountCheckBoxClick(Sender: TObject);
    procedure GSTRateEditClick(Sender: TObject);
    procedure ReadItemGroup;
    procedure ReadCategory;
    procedure ChangeMenuButtonPositionCheckBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 MenuItemGroupSetupForm: TMenuItemGroupSetupForm;

implementation

uses DataUnit, MessageBox, NumPad;


{$R *.DFM}

procedure TMenuItemGroupSetupForm.OpenQuery(SQLStr: string);
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

procedure TMenuItemGroupSetupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TMenuItemGroupSetupForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TMenuItemGroupSetupForm.PrinterSetupCheckBoxClick(Sender: TObject);
begin
 PrintGroupBox.Enabled := PrinterSetupCheckBox.Checked;
end;

procedure TMenuItemGroupSetupForm.KitchenScreenSetupCheckBoxClick(Sender: TObject);
begin
 KitchenScreenGroupBox.Enabled := KitchenScreenSetupCheckBox.Checked;
end;

procedure TMenuItemGroupSetupForm.ColorButtonClick(Sender: TObject);
begin
 ColorBox.Color := KitchenScreenFontColorPanel.Font.Color;
 if ColorBox.Execute then
    KitchenScreenFontColorPanel.Font.Color := ColorBox.Color;
end;

procedure TMenuItemGroupSetupForm.ChangeGSTRateCheckBoxClick(Sender: TObject);
begin
 GSTRateEdit.Enabled := ChangeGSTRateCheckBox.Checked;
 if GSTRateEdit.Enabled and (GSTRateEdit.Caption = '') then
    GSTRateEdit.Caption := '10.00';
end;

procedure TMenuItemGroupSetupForm.ChangeGroupCheckBoxClick(Sender: TObject);
begin
 GroupComboBox.Enabled := ChangeGroupCheckBox.Checked;
 if GroupComboBox.Enabled and (GroupComboBox.ItemIndex = -1) then
    GroupComboBox.ItemIndex := 0;
end;

procedure TMenuItemGroupSetupForm.ChangeJobListColorCheckBoxClick(Sender: TObject);
begin
 JobListColorComboBox.Enabled := ChangeJobListColorCheckBox.Checked;
end;

procedure TMenuItemGroupSetupForm.ChangeItemActiveCheckBoxClick(Sender: TObject);
begin
 ActiveCheckBox.Enabled := ChangeItemActiveCheckBox.Checked;
end;

procedure TMenuItemGroupSetupForm.ChangeInstructionCheckBoxClick(
  Sender: TObject);
begin
  InstructionCheckBox.Enabled := ChangeInstructionCheckBox.Checked
end;

procedure TMenuItemGroupSetupForm.ChangeMultiplePriceCheckBoxClick(
  Sender: TObject);
begin
 MultiplePriceCheckBox.Enabled := ChangeMultiplePriceCheckBox.Checked;
end;

procedure TMenuItemGroupSetupForm.ChangeOpenPriceCheckBoxClick(Sender: TObject);
begin
 OpenPriceCheckBox.Enabled := ChangeOpenPriceCheckBox.Checked;
end;

procedure TMenuItemGroupSetupForm.ChangeAllowDiscountCheckBoxClick(
  Sender: TObject);
begin
 AllowDiscountCheckBox.Enabled := ChangeAllowDiscountCheckBox.Checked;
end;

procedure TMenuItemGroupSetupForm.ChangeMenuButtonPositionCheckBoxClick(Sender: TObject);
begin
 MenuButtonComboBox.Enabled := ChangeMenuButtonPositionCheckBox.Checked;
end;

procedure TMenuItemGroupSetupForm.GSTRateEditClick(Sender: TObject);
var
 NumStr: string;
begin
  NumStr := GSTRateEdit.Caption;
 if NumberPadForm.ReadNumberPro(NumStr, False, False, 'G.S.T. Rate', 0) then
    GSTRateEdit.Caption := NumStr;
end;

procedure TMenuItemGroupSetupForm.SaveButtonClick(Sender: TObject);
var
 SQLStr: string;
 Flag: boolean;
begin
 if Not PrinterSetupCheckBox.Checked and Not KitchenScreenSetupCheckBox.Checked and
    Not ChangeGSTRateCheckBox.Checked and Not ChangeGroupCheckBox.Checked and
    Not ChangeJobListColorCheckBox.Checked and Not ChangeItemActiveCheckBox.Checked and
    Not ChangeInstructionCheckBox.Checked and Not ChangeMultiplePriceCheckBox.Checked and
    Not ChangeOpenPriceCheckBox.Checked and Not ChangeAllowDiscountCheckBox.Checked and
    Not ChangeMenuButtonPositionCheckBox.Checked and Not ChangePrintSubDescriptionCheckBox.Checked then Exit;
 if Not DataForm.BeginTransaction then Exit;
 Flag := True;
 try
  if KitchenScreenSetupCheckBox.Checked then
     begin
      SQLStr := 'Update MenuItem Set KitchenScreen1=' + IntToStr(KitchenScreenComboBox1.ItemIndex) +
                ', KitchenScreen2=' + IntToStr(KitchenScreenComboBox2.ItemIndex) +
                ', KitchenScreen3=' + IntToStr(KitchenScreenComboBox3.ItemIndex) +
                ', KitchenScreen4=' + IntToStr(KitchenScreenComboBox4.ItemIndex) +
                ', KitchenScreenFontColor=' + IntToStr(KitchenScreenFontColorPanel.Font.Color);
       if CategoryComboBox.ItemIndex > 0 then
          SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and PrinterSetupCheckBox.Checked then
     begin
      SQLStr := 'Update MenuItem Set PrinterPort=' + IntToStr(PrinterPortComboBox.ItemIndex) +
                ', PrinterPort1=' + IntToStr(PrinterPortComboBox1.ItemIndex) +
                ', PrinterPort2=' + IntToStr(PrinterPortComboBox2.ItemIndex) +
                ', PrinterPort3=' + IntToStr(PrinterPortComboBox3.ItemIndex);
      if CategoryComboBox.ItemIndex > 0 then
         SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and GSTRateEdit.Enabled then
     begin
      SQLStr := 'Update MenuItem Set TaxRate=' + GSTRateEdit.Caption;
      if CategoryComboBox.ItemIndex > 0 then
         SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and GroupComboBox.Enabled then
     begin
      SQLStr := 'Update MenuItem Set ItemGroup=' + Chr(39) + CheckQuotes(GroupComboBox.Text) + Chr(39);
      if CategoryComboBox.ItemIndex > 0 then
         SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and ChangeJobListColorCheckBox.Checked then
     begin
      SQLStr := 'Update MenuItem Set JobListColor=' + IntToStr(JobListColorComboBox.ItemIndex);
       if CategoryComboBox.ItemIndex > 0 then
          SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and ActiveCheckBox.Enabled then
     begin
      SQLStr := 'Update MenuItem Set Active=';
      if ActiveCheckBox.Checked then
         SQLStr := SQLStr + '1'
        else
         SQLStr := SQLStr + '0';
      if CategoryComboBox.ItemIndex > 0 then
         SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and InstructionCheckBox.Enabled then
     begin
      SQLStr := 'Update MenuItem Set Instruction=';
      if InstructionCheckBox.Checked then
         SQLStr := SQLStr + '1'
        else
         SQLStr := SQLStr + '0';
      if CategoryComboBox.ItemIndex > 0 then
         SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and MultiplePriceCheckBox.Enabled then
     begin
      SQLStr := 'Update MenuItem Set Multiple=';
      if MultiplePriceCheckBox.Checked then
         SQLStr := SQLStr + '1'
        else
         SQLStr := SQLStr + '0';
      if CategoryComboBox.ItemIndex > 0 then
         SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and OpenPriceCheckBox.Enabled then
     begin
      SQLStr := 'Update MenuItem Set OpenPrice=';
      if OpenPriceCheckBox.Checked then
         SQLStr := SQLStr + '1'
        else
         SQLStr := SQLStr + '0';
      if CategoryComboBox.ItemIndex > 0 then
         SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and AllowDiscountCheckBox.Enabled then
     begin
      SQLStr := 'Update MenuItem Set AllowDiscount=';
      if AllowDiscountCheckBox.Checked then
         SQLStr := SQLStr + '1'
        else
         SQLStr := SQLStr + '0';
      if CategoryComboBox.ItemIndex > 0 then
         SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and ChangePrintSubDescriptionCheckBox.Checked then
     begin
      SQLStr := 'Update MenuItem Set SubDescriptionSwap=';
      if PrintSubDescriptionFirstCheckBox.Checked then
         SQLStr := SQLStr + '1'
        else
         SQLStr := SQLStr + '0';
      if CategoryComboBox.ItemIndex > 0 then
         SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

  if Flag and ChangeMenuButtonPositionCheckBox.Checked then
     begin
      SQLStr := 'Update MenuItem Set ';
      case MenuButtonComboBox.ItemIndex of
       0: SQLStr := SQLStr + 'POSPosition = MainPosition';
       1: SQLStr := SQLStr + 'MainPosition = POSPosition';
       2: SQLStr := SQLStr + 'PhoneOrderPosition = MainPosition';
       3: SQLStr := SQLStr + 'PhoneOrderPosition = POSPosition';
      end;
      if CategoryComboBox.ItemIndex > 0 then
         SQLStr := SQLStr + ' Where Category=' + Chr(39) + CheckQuotes(CategoryComboBox.Text) + Chr(39);
      Flag := DataForm.ExecQueryPro(SQLStr);
     end;

 finally
  if Flag then
     begin
      DataForm.CommitTransaction;
      MessageBoxForm.MessagePro('Item has been updated.', sInformationMsg);
     end
    else
     DataForm.Rollback;
 end;
end;

procedure TMenuItemGroupSetupForm.ReadItemGroup;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From ItemGroupTable Order By GroupName';
 OpenQuery(SQLStr);
 GroupComboBox.Items.Clear;
 with Query do
  begin
   if Active and (RecordCount > 0) then
      begin
       First;
       While Not EOF do
        begin
         GroupComboBox.Items.Add(FieldByName('GroupName').AsString);
         Next;
        end;
      end;
   Close;
  end;
end;

procedure TMenuItemGroupSetupForm.ReadCategory;
var
 SQLStr: string;
begin
 SQLStr := 'Select Category From Category Order By Code';
 OpenQuery(SQLStr);
 CategoryComboBox.Items.Clear;
 CategoryComboBox.Items.Add('All Items');
 with Query do
  begin
   if Active and (RecordCount > 0) then
      begin
       First;
       While Not EOF do
        begin
         CategoryComboBox.Items.Add(FieldByName('Category').AsString);
         Next;
        end;
      end;
   Close;
  end;
end;

procedure TMenuItemGroupSetupForm.FormShow(Sender: TObject);
begin
 Width := EditPanel.Width + 28;
 Height := ExitButton.Top + 86;
 ReadCategory;
 ReadItemGroup;
 CategoryComboBox.ItemIndex := 0;
 KitchenScreenComboBox1.ItemIndex := 0;
 KitchenScreenComboBox2.ItemIndex := 0;
 KitchenScreenComboBox3.ItemIndex := 0;
 KitchenScreenComboBox4.ItemIndex := 0;
 PrinterPortComboBox.ItemIndex := 0;
 PrinterPortComboBox1.ItemIndex := 0;
 PrinterPortComboBox2.ItemIndex := 0;
 PrinterPortComboBox3.ItemIndex := 0;
 PrintGroupBox.Enabled := False;
 KitchenScreenGroupBox.Enabled := False;
 PrinterSetupCheckBox.Checked := False;
 KitchenScreenSetupCheckBox.Checked := False;
 MenuButtonComboBox.Enabled :=  False;
end;

procedure TMenuItemGroupSetupForm.MenuItemGroupSetupPro;
begin
 Application.CreateForm(TMenuItemGroupSetupForm, MenuItemGroupSetupForm);
 MenuItemGroupSetupForm.ShowModal;
 MenuItemGroupSetupForm.Free;
end;

end.
