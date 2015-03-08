unit TimePanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ExtCtrls, UtilUnit, bsSkinCtrls, XiButton,
  BusinessSkinForm;

type
  TTimeForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    WorkPanel: TbsSkinPanel;
    bsSkinPanel2: TbsSkinPanel;
    HoursEdit: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    MinsEdit: TbsSkinStdLabel;
    AMPMEdit: TbsSkinStdLabel;
    HourUpButton: TXiButton;
    HourDownButton: TXiButton;
    Min5UpButton: TXiButton;
    Min5DownButton: TXiButton;
    Min1UpButton: TXiButton;
    Min1DowmButton: TXiButton;
    DayUpButton: TXiButton;
    DayDownButton: TXiButton;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure HourUpButtonClick(Sender: TObject);
    procedure Min5UpButtonClick(Sender: TObject);
    procedure HourDownButtonClick(Sender: TObject);
    procedure Min5DownButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    function  ReadTimePro(var TimeStr: string): boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DayUpButtonClick(Sender: TObject);
    procedure Min1UpButtonClick(Sender: TObject);
    procedure Min1DowmButtonClick(Sender: TObject);
  private { Private declarations }
    ReturnTime: string;
    ReturnFlag: boolean;
    Present: TDateTime;
  public
    { Public declarations }
  end;

var
  TimeForm: TTimeForm;

implementation

{$R *.DFM}

procedure TTimeForm.HourUpButtonClick(Sender: TObject);
var
 Temp: integer;
begin
 Temp := StrToInt(HoursEdit.Caption);
 if Temp < 12 then
    Temp := Temp + 1
   else
    Temp := 1;
 HoursEdit.Caption := Format('%2.2d', [Temp]);
end;

procedure TTimeForm.Min5UpButtonClick(Sender: TObject);
var
 Temp: integer;
begin
 Temp := StrToInt(MinsEdit.Caption);
 if Temp < 55 then
    Temp := Temp + 5
   else
    Temp := 0;
 MinsEdit.Caption := Format('%2.2d', [Temp]);
end;

procedure TTimeForm.Min1UpButtonClick(Sender: TObject);
var
 Temp: integer;
begin
 Temp := StrToInt(MinsEdit.Caption);
 if Temp < 59 then
    Temp := Temp + 1
   else
    Temp := 0;
 MinsEdit.Caption := Format('%2.2d', [Temp]);
end;

procedure TTimeForm.HourDownButtonClick(Sender: TObject);
var
 Temp: integer;
begin
 Temp := StrToInt(HoursEdit.Caption);
 if Temp >= 2 then
    Temp := Temp - 1
   else
    Temp := 12;
 HoursEdit.Caption := Format('%2.2d', [Temp]);
end;

procedure TTimeForm.Min5DownButtonClick(Sender: TObject);
var
 Temp: integer;
begin
 Temp := StrToInt(MinsEdit.Caption);
 if Temp >= 5 then
    Temp := Temp - 5
   else
    Temp := 55;
 MinsEdit.Caption := Format('%2.2d', [Temp]);
end;

procedure TTimeForm.Min1DowmButtonClick(Sender: TObject);
var
 Temp: integer;
begin
 Temp := StrToInt(MinsEdit.Caption);
 if Temp > 0 then
    Temp := Temp - 1
   else
    Temp := 59;
 MinsEdit.Caption := Format('%2.2d', [Temp]);
end;

procedure TTimeForm.ConfirmButtonClick(Sender: TObject);
var
 Hour: integer;
begin
 Hour := StrToInt(HoursEdit.Caption);
 if AMPMEdit.Caption = 'PM' then
    begin
     if Hour < 12 then Hour := Hour + 12;
    end
   else
    if (AMPMEdit.Caption = 'AM') and (Hour = 12) then
       Hour := 0;
 ReturnTime := Format('%2.2d', [Hour]) + ':' + MinsEdit.Caption;
 ReturnFlag := True;
 Close;
end;

procedure TTimeForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TTimeForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TTimeForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then ConfirmButtonClick(Sender);
end;

procedure TTimeForm.DayUpButtonClick(Sender: TObject);
begin
 if AMPMEdit.Caption = 'AM' then
    AMPMEdit.Caption := 'PM'
   else
    AMPMEdit.Caption := 'AM';
end;

procedure TTimeForm.FormShow(Sender: TObject);
var
 Hour, Min, Sec, MSec: Word;
begin
 Width := WorkPanel.Width + 16;
 Height := WorkPanel.Height + 98;
 WorkPanel.Left := 0;
 WorkPanel.Top := 0;
 DecodeTime(Present, Hour, Min, Sec, MSec);
 if Hour >= 12 then
    begin
     if Hour > 12 then Hour := Hour - 12;
     HoursEdit.Caption := Format('%2.2d', [Hour]);
     AMPMEdit.Caption := 'PM';
    end
   else
    begin
     AMPMEdit.Caption := 'AM';
     if Hour = 0 then Hour := 12;
     HoursEdit.Caption := Format('%2.2d', [Hour]);
    end;
 MinsEdit.Caption := Format('%2.2d', [(Min div 5) * 5]);
end;

function TTimeForm.ReadTimePro(var TimeStr: string): boolean;
begin
 Application.CreateForm(TTimeForm, TimeForm);
 TimeForm.Present := StrToTime(TimeStr);
 TimeForm.ShowModal;
 Result := TimeForm.ReturnFlag;
 if Result then TimeStr := TimeForm.ReturnTime;
 TimeForm.Free;
end;

end.
