unit ViewVIPDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Buttons, DBCtrls, Mask, Grids, DBGrids, ExtCtrls, DataUnit,
  ADODB, UtilUnit, bsSkinCtrls, BusinessSkinForm, XiButton, Variants;

type
  TViewVIPDetailForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    CompanyEdit: TEdit;
    TelephoneEdit: TEdit;
    FaxEdit: TEdit;
    MobileEdit: TEdit;
    VIPNoEdit: TEdit;
    VIPNameEdit: TEdit;
    EmailEdit: TEdit;
    CreateDateEdit: TMaskEdit;
    Label9: TLabel;
    Label10: TLabel;
    BirthDayEdit: TMaskEdit;
    Label11: TLabel;
    AddressEdit: TEdit;
    Label12: TLabel;
    SuburbEdit: TEdit;
    Label13: TLabel;
    StateEdit: TEdit;
    Label14: TLabel;
    PostCodeEdit: TEdit;
    Query: TADOQuery;
    Label15: TLabel;
    MapEdit: TEdit;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    TitlePanel: TbsSkinPanel;
    ExitButton: TXiButton;
    Label16: TLabel;
    StreetNumberEdit: TEdit;
    Label17: TLabel;
    NotesPanel: TbsSkinPanel;
    NotesEdit: TMemo;
    DiscountRateEdit: TEdit;
    Label18: TLabel;
    CreditLimitEdit: TStaticText;
    Label19: TLabel;
    SerialNumberEDit: TEdit;
    StatementButton: TXiButton;
    TotalPanel: TbsSkinPanel;
    Label20: TLabel;
    AvailableCreditEdit: TStaticText;
    PointsLabel: TLabel;
    PointsEdit: TStaticText;
    function  OpenQuery(SQLStr: string): boolean;
    procedure InitForm;
    procedure ReadVIPInformation;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ViewVIPDetailPro(VIPNo: integer);
    procedure StatementButtonClick(Sender: TObject);
  private { Private declarations }
    VIPNo: integer;
  public
    { Public declarations }
  end;

var
  ViewVIPDetailForm: TViewVIPDetailForm;

implementation

uses MainMenu, CustomerStatement;

{$R *.DFM}

function TViewVIPDetailForm.OpenQuery(SQLStr: string): boolean;
begin
 Result := True;
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   except
    Result := False;
   end;
   Screen.Cursor := crDefault;
  end;
end;

procedure TViewVIPDetailForm.InitForm;
begin
 VIPNameEdit.Text := '';
 CompanyEdit.Text := '';
 TelephoneEdit.Text := '';
 FaxEdit.Text := '';
 MobileEdit.Text := '';
 EMailEdit.Text := '';
 StreetNumberEdit.Text := '';
 AddressEdit.Text := '';
 SuburbEdit.Text := '';
 StateEdit.Text := '';
 PostCodeEdit.Text := '';
 VIPNoEdit.Text := Format('%8.8d', [VIPNo]);
 MapEdit.Text := '';
 CreateDateEdit.Text := FormatDateTime('dd/mm/yyyy', Date);
 BirthDayEdit.Text := '';
 DiscountRateEdit.Text := Format('%3.2f', [0.0]);
 NotesEdit.Lines.Clear;
 CreditLimitEdit.Caption := Format('%4.2', [0.0]);
end;

procedure TViewVIPDetailForm.ReadVIPInformation;
var
 SQLStr: string;
begin
 SQLStr := 'Select VIPTable.VIPNo, VIPName, Company, Telephone, Fax, Mobile, Number, Address, Suburb, ' +
           'State, PostCode, SerialNo, EMail, Birthday, CreateDate, Discount, Notes, MapReference, ' +
           'CreditLimit, Sum(TempTable.TotalCredit) As TotalCredit From VIPTable Left Join ' +
           '(Select VIPNo, (Amount + ServiceCharge + OtherCharge + Tips - PaidAmount) As TotalCredit ' +
           'From OrderH Where (PriceIncludesGST <> 0) and (Credit <> 0) and ' +
           '(Amount + ServiceCharge + OtherCharge + Tips - PaidAmount > 0) ' +
           ' Union All ' +
           'Select VIPNo, (Amount + ServiceCharge + OtherCharge + Tips + GST - PaidAmount) As TotalCredit ' +
           'From OrderH Where (PriceIncludesGST = 0) and (Credit <> 0) and ' +
           '(Amount + ServiceCharge + OtherCharge + GST + Tips - PaidAmount > 0)) ' +
           ' As TempTable On VIPTable.VIPNo=TempTable.VIPNo ' +
           'Where VIPTable.VIPNo =' + IntToStr(VIPNo) +
           ' Group By VIPTable.VIPNo, VIPName, Company, Telephone, Fax, Mobile, Number, Address, ' +
           'Suburb, State, PostCode, SerialNo, EMail, Birthday, CreateDate, Discount, ' +
           'Notes, MapReference, CreditLimit ';
 if OpenQuery(SQLStr) then
    with Query do
     begin
      VIPNameEdit.Text := FieldByName('VIPName').AsString;
      CompanyEdit.Text := FieldByName('Company').AsString;
      TelephoneEdit.Text := FieldByName('Telephone').AsString;
      FaxEdit.Text := FieldByName('Fax').asString;
      MobileEdit.Text := FieldByName('Mobile').AsString;
      EMailEdit.Text := FieldByName('EMail').AsString;
      StreetNumberEdit.Text := FieldByName('Number').AsString;
      AddressEdit.Text := FieldByName('Address').AsString;
      SuburbEdit.Text := FieldByName('Suburb').AsString;
      StateEdit.Text := FieldByName('State').AsString;
      PostCodeEdit.Text := FieldByName('PostCode').AsString;
      VIPNoEdit.Text := Format('%8.8d', [VIPNo]);
      MapEdit.Text := FieldByName('MapReference').AsString;
      CreateDateEdit.Text := FormatDateTime('dd/mm/yyyy', FieldByName('CreateDate').AsDateTime);
      if Not VarIsNull(FieldByName('BirthDay').AsDateTime) and (FieldByName('BirthDay').AsDateTime <> 0) then
         BirthDayEdit.Text := FormatDateTime('dd/mm/yyyy', FieldByName('BirthDay').AsDateTime)
        else
         BirthDayEdit.Text := '';
      DiscountRateEdit.Text := Format('%3.2f', [FieldByName('Discount').AsFloat]);
      NotesEdit.Lines.Add(FieldByName('Notes').AsString);
      CreditLimitEdit.Caption := Format('%4.2m ', [FieldByName('CreditLimit').AsFloat]);
      AvailableCreditEdit.Caption := FormatCurrency(DataForm.GetAvailableCredit(VIPNo)) + ' ';
      if LoyaltyAwardAvailible then
         begin
          TotalPanel.Top := 336;
          TotalPanel.Height := 104;
          PointsEdit.Caption := Format('%1d ', [Trunc(DataForm.GetVIPAwardPoints(VIPNo, ''))]);
          PointsLabel.Visible := True;
          PointsEdit.Visible := True;
         end
        else
         begin
          TotalPanel.Top := 381;
          TotalPanel.Height := 59;
          PointsEdit.Caption := '';
          PointsLabel.Visible := False;
          PointsEdit.Visible := False;
         end;
      Close;
     end;
end;

procedure TViewVIPDetailForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then ExitButtonClick(Sender);
end;

procedure TViewVIPDetailForm.StatementButtonClick(Sender: TObject);
begin
 CustomerStatementForm.CustomerStatementPro(VIPNo);
end;

procedure TViewVIPDetailForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TViewVIPDetailForm.FormShow(Sender: TObject);
begin
 InitForm;
 ReadVIPInformation;
end;

procedure TViewVIPDetailForm.ViewVIPDetailPro(VIPNo: Integer);
begin
 Application.CreateForm(TViewVIPDetailForm, ViewVIPDetailForm);
 ViewVIPDetailForm.VIPNo := VIPNo;
 ViewVIPDetailForm.ShowModal;
 ViewVIPDetailForm.Free;
end;

end.
