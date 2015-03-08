unit PrintAttendanceReportSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, MainMenu, XiButton, bsSkinCtrls,
  BusinessSkinForm;

type
  TPrintAttendanceReportSelectForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    ControlPanel: TbsSkinPanel;
    PrintAttendanceSummaryReportButton: TXiButton;
    PrintAttendanceReportButton: TXiButton;
    PrintAttendanceDetailButton: TXiButton;
    CancelButton: TXiButton;
    procedure PrintAttendanceSummaryReportButtonClick(Sender: TObject);
    procedure PrintAttendanceReportButtonClick(Sender: TObject);
    procedure PrintAttendanceDetailButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    function  PrintAttendanceReportSelectPro(var Operation: integer): boolean;
    procedure FormShow(Sender: TObject);
  private { Private declarations }
    ReturnFlag: Boolean;
    Operation: integer;
  public
    { Public declarations }
  end;

var
  PrintAttendanceReportSelectForm: TPrintAttendanceReportSelectForm;

implementation

{$R *.dfm}

procedure TPrintAttendanceReportSelectForm.PrintAttendanceSummaryReportButtonClick(Sender: TObject);
begin
 Operation := 1;
 ReturnFlag := True;
 Close;
end;

procedure TPrintAttendanceReportSelectForm.PrintAttendanceReportButtonClick(Sender: TObject);
begin
 Operation := 2;
 ReturnFlag := True;
 Close;
end;

procedure TPrintAttendanceReportSelectForm.PrintAttendanceDetailButtonClick(Sender: TObject);
begin
 Operation := 3;
 ReturnFlag := True;
 Close;
end;

procedure TPrintAttendanceReportSelectForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TPrintAttendanceReportSelectForm.FormShow(Sender: TObject);
begin
 Width := ControlPanel.Width + 28;
 Height := ControlPanel.Height + 48;
end;

function TPrintAttendanceReportSelectForm.PrintAttendanceReportSelectPro(var Operation: integer): boolean;
begin
 Application.CreateForm(TPrintAttendanceReportSelectForm, PrintAttendanceReportSelectForm);
 PrintAttendanceReportSelectForm.ShowModal;
 Result := PrintAttendanceReportSelectForm.ReturnFlag;
 if Result then
    Operation := PrintAttendanceReportSelectForm.Operation;
 PrintAttendanceReportSelectForm.Free;
end;

end.
