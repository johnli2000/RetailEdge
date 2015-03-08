unit DatePanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, ExtCtrls, UtilUnit, Grids, bsSkinCtrls,
  BusinessSkinForm, XiButton, Calendar, DateUtils;

type
  TDateForm = class(TForm)
    DayEdit: TCalendar;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    ShowPanel: TbsSkinPanel;
    YearEdit: TbsSkinStdLabel;
    MonthEdit: TbsSkinStdLabel;
    YearDownButton: TXiButton;
    YearUpButton: TXiButton;
    MonthDownButton: TXiButton;
    MonthUpButton: TXiButton;
    bsSkinPanel2: TbsSkinPanel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    procedure MonthUpButtonClick(Sender: TObject);
    procedure YearUpButtonClick(Sender: TObject);
    procedure MonthDownButtonClick(Sender: TObject);
    procedure YearDownButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    function  ReadDatePro(var DateStr: TDateTime): boolean;
  private { Private declarations }
    ReturnFlag: boolean;
    ReturnDate, Present: TDateTime;
  public
    { Public declarations }
  end;

var
  DateForm: TDateForm;

implementation

{$R *.DFM}

procedure TDateForm.MonthUpButtonClick(Sender: TObject);
var
 DD, MM, YY: Word;
begin
 MM := StrToInt(MonthEdit.Caption);
 YY := DayEdit.Year;
 if MM < 12 then
    begin
     MM := MM + 1;
     DD := DaysInAMonth(YY, MM);
     if DD < DayEdit.Day then DayEdit.Day := DD;
     MonthEdit.Caption := Format('%2.2d', [MM]);
     DayEdit.Month := MM;
    end;
end;

procedure TDateForm.YearUpButtonClick(Sender: TObject);
var
 DD, MM, YY: Word;
begin
 YY := StrToInt(YearEdit.Caption);
 if YY < 2500 then
    begin
     YY := YY + 1;
     MM := DayEdit.Month;
     DD := DaysInAMonth(YY, MM);
     if DD < DayEdit.Day then DayEdit.Day := DD;
     YearEdit.Caption := Format('%4.4d', [YY]);
     DayEdit.Year := YY;
    end;
end;

procedure TDateForm.MonthDownButtonClick(Sender: TObject);
var
 DD, MM, YY: Word;
begin
 MM := StrToInt(MonthEdit.Caption);
 YY := DayEdit.Year;
 if MM > 1 then
    begin
     MM := MM - 1;
     DD := DaysInAMonth(YY, MM);
     if DD < DayEdit.Day then
        DayEdit.Day := DD;
     MonthEdit.Caption := Format('%2.2d', [MM]);
     DayEdit.Month := MM;
    end;
end;

procedure TDateForm.YearDownButtonClick(Sender: TObject);
var
 DD, MM, YY: Word;
begin
 YY := StrToInt(YearEdit.Caption);
 if YY > 1900 then
    begin
     YY := YY - 1;
     MM := DayEdit.Month;
     DD := DaysInAMonth(YY, MM);
     if DD < DayEdit.Day then DayEdit.Day := DD;
     YearEdit.Caption := Format('%4.4d', [YY]);
     DayEdit.Year := YY;
    end;
end;

procedure TDateForm.ConfirmButtonClick(Sender: TObject);
begin
 with DayEdit do
  ReturnDate := EncodeDate(Year, Month, Day);
  ReturnFlag := True;
  Close;
end;

procedure TDateForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TDateForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then CancelButtonClick(Sender);
end;

procedure TDateForm.FormShow(Sender: TObject);
var
 Year, Month, Day: Word;
begin
 Width := ShowPanel.Width + 28;
 Height := ConfirmButton.Top + 90;
 DecodeDate(Present, Year, Month, Day);
 YearEdit.Caption := Format('%4.4d', [Year]);
 MonthEdit.Caption := Format('%2.2d', [Month]);
 DayEdit.Day := 1;
 DayEdit.Year := Integer(Year);
 DayEdit.Month := Integer(Month);
 DayEdit.Day := Integer(Day);
 DayEdit.SetFocus;
end;

function TDateForm.ReadDatePro(var DateStr: TDateTime): boolean;
begin
 Application.CreateForm(TDateForm, DateForm);
 DateForm.Present := DateStr;
 DateForm.ShowModal;
 Result := DateForm.ReturnFlag;
 if Result then
    DateStr := DateForm.ReturnDate;
 DateForm.Free;
end;


end.
