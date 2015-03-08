unit PriceSelect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, StdCtrls, Buttons, bsSkinCtrls, XiButton, BusinessSkinForm, UtilUnit;

type
  TPriceSelectForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    Price1: TXiButton;
    Price2: TXiButton;
    Price3: TXiButton;
    Price4: TXiButton;
    CancelButton: TXiButton;
    procedure ReadPrice;
    procedure Price1Click(Sender: TObject);
    procedure Price2Click(Sender: TObject);
    procedure Price3Click(Sender: TObject);
    procedure Price4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ReadPricePro(ItemCode: string; var Select: integer; var HappyHourPrice: boolean);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private { Private declarations }
    Select: integer;
    ItemCode: string;
    HappyHourPrice: Boolean;
  public
    { Public declarations }
  end;

var
  PriceSelectForm: TPriceSelectForm;

implementation

uses DataUnit;

{$R *.DFM}

procedure TPriceSelectForm.ReadPrice;
var
 SQLStr, Temp: string;
begin
 Price1.Caption := '';
 Price2.Caption := '';
 Price3.Caption := '';
 Price4.Caption := '';
 SQLStr := 'Select * From MenuItem Where ItemCode=' +
           Chr(39) + CheckQuotes(ItemCode) + Chr(39);
 DataForm.OpenCheckQuery(SQLStr);
 with DataForm.CheckQuery do
  begin
   if HappyHourPrice and
     ((FieldByName('HappyHourPrice1').AsFloat > 0) or
     (FieldByName('HappyHourPrice2').AsFloat > 0) or
     (FieldByName('HappyHourPrice3').AsFloat > 0) or
     (FieldByName('HappyHourPrice4').AsFloat > 0)) then
     begin
      Temp := Format('$%4.2f', [FieldByName('HappyHourPrice1').AsFloat]);
      Price1.Caption := Format('%-12s%8s', [FieldByName('SubDescription').AsString, Temp]);
      if (FieldByName('HappyHourPrice2').AsFloat >= 0.009) or
         (FieldByName('SubDescription1').AsString <> '') then
         begin
          Temp := Format('$%4.2f', [FieldByName('HappyHourPrice2').AsFloat]);
          Price2.Caption := Format('%-12s%8s', [FieldByName('SubDescription1').AsString, Temp])
         end;
      if (FieldByName('HappyHourPrice3').AsFloat >= 0.009) or
         (FieldByName('SubDescription2').AsString <> '') then
         begin
          Temp := Format('$%4.2f', [FieldByName('HappyHourPrice3').AsFloat]);
          Price3.Caption := Format('%-12s%8s', [FieldByName('SubDescription2').AsString, Temp])
         end;
      if (FieldByName('HappyHourPrice4').AsFloat >= 0.009) or
         (FieldByName('SubDescription3').AsString <> '') then
         begin
          Temp := Format('$%4.2f', [FieldByName('HappyHourPrice2').AsFloat]);
          Price4.Caption := Format('%-12s%8s', [FieldByName('SubDescription3').AsString, Temp])
         end;
     end
    else
     begin
      HappyHourPrice := False;
      Temp := Format('$%4.2f', [FieldByName('Price').AsFloat]);
      Price1.Caption := Format('%-12s%8s', [FieldByName('SubDescription').AsString, Temp]);
      if (FieldByName('Price1').AsFloat >= 0.009) or
         (FieldByName('SubDescription1').AsString <> '') then
         begin
          Temp := Format('$%4.2f', [FieldByName('Price1').AsFloat]);
          Price2.Caption := Format('%-12s%8s', [FieldByName('SubDescription1').AsString, Temp])
         end;
      if (FieldByName('Price2').AsFloat >= 0.009) or
         (FieldByName('SubDescription2').AsString <> '') then
         begin
          Temp := Format('$%4.2f', [FieldByName('Price2').AsFloat]);
          Price3.Caption := Format('%-12s%8s', [FieldByName('SubDescription2').AsString, Temp])
         end;
      if (FieldByName('Price3').AsFloat >= 0.009) or
         (FieldByName('SubDescription3').AsString <> '') then
         begin
          Temp := Format('$%4.2f', [FieldByName('Price3').AsFloat]);
          Price4.Caption := Format('%-12s%8s', [FieldByName('SubDescription3').AsString, Temp])
         end;
     end;
   Close;
  end;
end;

procedure TPriceSelectForm.Price1Click(Sender: TObject);
begin
 if Price1.Caption <> '' then
    begin
     Select := 0;
     Close;
    end;
end;

procedure TPriceSelectForm.Price2Click(Sender: TObject);
begin
 if Price2.Caption <> '' then
    begin
     Select := 1;
     Close;
    end;
end;

procedure TPriceSelectForm.Price3Click(Sender: TObject);
begin
 if Price3.Caption <> '' then
    begin
     Select := 2;
     Close;
    end;
end;

procedure TPriceSelectForm.Price4Click(Sender: TObject);
begin
 if Price4.Caption <> '' then
    begin
     Select := 3;
     Close;
    end;
end;

procedure TPriceSelectForm.CancelButtonClick(Sender: TObject);
begin
 Select := -1;
 Close;
end;

procedure TPriceSelectForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TPriceSelectForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender)
end;

procedure TPriceSelectForm.FormShow(Sender: TObject);
begin
 Width := WorkPanel.Width + 28;
 Height := CancelButton.Top + 86;
 CancelButton.Left := WorkPanel.Left + (WorkPanel.Width - CancelButton.Width) div 2;
 ReadPrice;
end;

procedure TPriceSelectForm.ReadPricePro(ItemCode: string; var Select: integer; var HappyHourPrice: boolean);
begin
 Application.CreateForm(TPriceSelectForm, PriceSelectForm);
 PriceSelectForm.ItemCode := ItemCode;
 PriceSelectForm.HappyHourPrice := HappyHourPrice;
 PriceSelectForm.ShowModal;
 Select := PriceSelectForm.Select;
 HappyHourPrice := PriceSelectForm.HappyHourPrice;
 PriceSelectForm.Free;
end;

end.
