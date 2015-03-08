unit ElapseTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bsSkinCtrls, BusinessSkinForm, MainMenu, XiButton, StdCtrls, DB,
  ADODB, UtilUnit;

type
  TElapseTimeForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
    EndDateTimeLabel: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    StartDateTimeLabel: TbsSkinLabel;
    CurrentDateTimeLabel: TbsSkinLabel;
    ElapseTimeLabel: TbsSkinLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    OKButton: TXiButton;
    Query: TADOQuery;
    bsSkinStdLabel1: TbsSkinStdLabel;
    OrderNoLabel: TbsSkinLabel;
    function  OpenQuery(SQLStr: string): boolean;
    procedure GetElapseDateTime;
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ShowElapseDateTimePro(OrderNo: string);
  private { Private declarations }
     OrderNo: string;
  public
    { Public declarations }
  end;

var
  ElapseTimeForm: TElapseTimeForm;

implementation

uses DataUnit;

{$R *.dfm}

function TElapseTimeForm.OpenQuery(SQLStr: string): boolean;
begin
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   try
    Active := True;
   finally
    Result := Active;
    Screen.Cursor := crDefault;
   end;
  end;
end;

procedure TElapseTimeForm.GetElapseDateTime;
var
 SQLStr: string;
begin
 SQLStr := 'Select OrderDate, AccountDate ' +
           'From OrderH Left Join RecvAcct ' +
           'On OrderH.OrderNo = RecvAcct.OrderNo ' +
           'Where OrderH.OrderNo = ' + Chr(39) + CheckQuotes(OrderNo) + Chr(39);
 if OpenQuery(SQLStr) then
    with Query do
     begin
      OrderNoLabel.Caption := OrderNo;
      StartDateTimeLabel.Caption := FormatDateTime('dd/mm/yyyy hh:mm', FieldByName('OrderDate').AsDateTime);
      if FieldByName('AccountDate').AsDateTime > 0 then
         begin
          EndDateTimeLabel.Caption := 'End Date && Time';
          CurrentDateTimeLabel.Caption := FormatDateTime('dd/mm/yyyy hh:mm', FieldByName('AccountDate').AsDateTime);
          ElapseTimeLabel.Caption :=
           Format('%4.2f', [24 * (FieldByName('AccountDate').AsDateTime - FieldByName('OrderDate').AsDateTime)]);
         end
        else
         begin
          EndDateTimeLabel.Caption := 'Current Date && Time';
          CurrentDateTimeLabel.Caption := FormatDateTime('dd/mm/yyyy hh:mm', Date + Time);
          ElapseTimeLabel.Caption := Format('%4.2f', [24 * (Date + Time - FieldByName('OrderDate').AsDateTime)]);
         end
    end;
end;
    
procedure TElapseTimeForm.OKButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TElapseTimeForm.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TElapseTimeForm.FormShow(Sender: TObject);
begin
 Width := BackPanel.Width + 28;
 Height := OKButton.Top + 86; 
 GetElapseDateTime;
end;

procedure TElapseTimeForm.ShowElapseDateTimePro(OrderNo: string);
begin
 Application.CreateForm(TElapseTimeForm, ElapseTimeForm);
 ElapseTimeForm.OrderNo := OrderNo;
 ElapseTimeForm.ShowModal;
 ElapseTimeForm.Free;
end;

end.
