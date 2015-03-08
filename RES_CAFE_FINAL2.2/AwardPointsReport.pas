unit AwardPointsReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, DataUnit, UtilUnit, MainMenu,
  Buttons, StdCtrls, bsSkinCtrls, BusinessSkinForm, XiButton;

type
  TAwardPointsReportForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryVIPNo: TIntegerField;
    QueryVIPName: TStringField;
    QueryAwardPoints: TIntegerField;
    QueryPaymentPoints: TIntegerField;
    QueryBalance: TIntegerField;
    SkinForm: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    ResetButton: TXiButton;
    DetailButton: TXiButton;
    PrintButton: TXiButton;
    ExitButton: TXiButton;
    procedure OpenQuery;
    procedure DBGridDblClick(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ShowAwardPointsReportPro;
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure QueryCalcFields(DataSet: TDataSet);
    procedure DetailButtonClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AwardPointsReportForm: TAwardPointsReportForm;

implementation

uses SaleshistoryDetail, MessageBox, AwardPoints, PrintAwardPointsreport;

{$R *.dfm}

procedure TAwardPointsReportForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select LoyaltyPoints.VIPNo, VIPName, Sum(AwardPoints) As AwardPoints, ' +
           'Sum(PaymentPoints) As PaymentPoints ' +
           'From LoyaltyPoints, VIPTable ' +
           'Where LoyaltyPoints.VIPNo = VIPTable.VIPNo ' +
           'Group By LoyaltyPoints.VIPNo, VIPName ' +
           'Having Sum(AwardPoints) - Sum(PaymentPoints) > 0 ' +
           'Order By LoyaltyPoints.VIPNo';
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

procedure TAwardPointsReportForm.QueryCalcFields(DataSet: TDataSet);
begin
 with Query do
  FieldByName('Balance').AsInteger :=
   FieldByName('AwardPoints').AsInteger - FieldByName('PaymentPoints').AsInteger;
end;

procedure TAwardPointsReportForm.DBGridDblClick(Sender: TObject);
begin
 DetailButtonClick(Sender);
end;

procedure TAwardPointsReportForm.DetailButtonClick(Sender: TObject);
var
 VIPNo: integer;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      VIPNo := FieldByName('VIPNo').AsInteger;
      AwardPointsForm.ShowAwardPointsPro(VIPNo);
     end;
end;

procedure TAwardPointsReportForm.ResetButtonClick(Sender: TObject);
var
 SQLStr: string;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      if MessageBoxForm.MessagePro('Are you sure you want to delete all VIP Award Points?', sConfirmMsg) = mrYes then
         begin
          SQLStr := 'Delete From LoyaltyPoints';
          if DataForm.ExecQueryPro(SQLStr) then
             OpenQuery;
         end;
     end;
end;

procedure TAwardPointsReportForm.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
 X: integer;
 S: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
 with Sender As TDBGrid do
  begin
   if (Column.FieldName = 'VIPNo') then
      begin
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
       S := Format('%8.8d', [Column.Field.AsInteger]);
      end
     else
      if (Column.FieldName = 'VIPName') then
         begin
          SetTextAlign(Canvas.Handle, TA_LEFT);
          X := Rect.Left + 2;
          S := Column.Field.AsString;
         end
        else
         begin
          SetTextAlign(Canvas.Handle, TA_RIGHT);
          X := Rect.Right - 2;
          if Column.Field.AsInteger <> 0 then
             S := Column.Field.AsString
            else
             S := '';
         end;
    Canvas.TextRect(Rect, X, Rect.Top + 2, S);
  end;
end;

procedure TAwardPointsReportForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TAwardPointsReportForm.PrintButtonClick(Sender: TObject);
begin
 PrintAwardPointsReportForm.PrintAwardPointsReportPro;
end;

procedure TAwardPointsReportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TAwardPointsReportForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 OpenQuery;
 ReSetButton.Visible := Supervisor;
end;

procedure TAwardPointsReportForm.ShowAwardPointsReportPro;
begin
 Application.CreateForm(TAwardPointsReportForm, AwardPointsReportForm);
 AwardPointsReportForm.ShowModal;
 AwardPointsReportForm.Free;
end;

end.
