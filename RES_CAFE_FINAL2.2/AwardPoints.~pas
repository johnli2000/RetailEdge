unit AwardPoints;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, DataUnit, UtilUnit,
  Buttons, StdCtrls, MainMenu, BusinessSkinForm, bsSkinCtrls, XiButton;

type
  TAwardPointsForm = class(TForm)
    DBGrid: TDBGrid;
    DataSource: TDataSource;
    Query: TADOQuery;
    QueryOrderNo: TStringField;
    QueryOrderDate: TDateTimeField;
    QueryVIPNo: TIntegerField;
    QueryAwardPoints: TIntegerField;
    QueryPaymentPoints: TIntegerField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SalesPointsEdit: TStaticText;
    PointsPaymentEdit: TStaticText;
    BalanceEdit: TStaticText;
    Label4: TLabel;
    Label5: TLabel;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    DBGridPanel: TbsSkinPanel;
    BalancePanel: TbsSkinPanel;
    ResetButton: TXiButton;
    ExitButton: TXiButton;
    procedure OpenQuery;
    procedure CalcBalance;
    procedure DBGridDblClick(Sender: TObject);
    procedure ResetButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ShowAwardPointsPro(VIPNo: integer);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private { Private declarations }
     VIPNo: integer;
  public
    { Public declarations }
  end;

var
  AwardPointsForm: TAwardPointsForm;

implementation

uses SaleshistoryDetail, MessageBox;

{$R *.dfm}

procedure TAwardPointsForm.OpenQuery;
var
 SQLStr: string;
begin
 SQLStr := 'Select * From LoyaltyPoints Where VIPNo=' + IntToStr(VIPNo) +
           ' Order By OrderNo, OrderDate';
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

procedure TAwardPointsForm.CalcBalance;
var
 SalesPoints, PointsPayment: integer;
begin
 SalesPoints := 0; PointsPayment := 0;
 with Query do
  begin
   DisableControls;
   First;
   while Not EOF do
    begin
     SalesPoints := SalesPoints + FieldByName('AwardPoints').AsInteger;
     PointsPayment := PointsPayment + FieldByName('PaymentPoints').AsInteger;
     Next;
    end;
   First;
   EnableControls;
  end;
 SalesPointsEdit.Caption := Format('%1d ', [SalesPoints]);
 PointsPaymentEdit.Caption := Format('%1d ', [PointsPayment]);
 BalanceEdit.Caption := Format('%1d ', [SalesPoints - PointsPayment]);
end;

procedure TAwardPointsForm.DBGridDblClick(Sender: TObject);
var
 OrderNo: string;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      OrderNo := FieldByName('OrderNo').AsString;
      SalesHistoryDetailForm.SalesDetailPro(OrderNo);
     end;
end;

procedure TAwardPointsForm.ResetButtonClick(Sender: TObject);
var
 SQLStr: string;
begin
 with Query do
  if Active and (RecordCount > 0) then
     begin
      if MessageBoxForm.MessagePro('Are you sure you want to delete the points for the VIP customer?', sConfirmMsg) = mrYes then
         begin
          SQLStr := 'Delete From LoyaltyPoints Where VIPNo=' + IntToStr(VIPNo);
          if DataForm.ExecQueryPro(SQLStr) then
             begin
              OpenQuery;
              CalcBalance;
             end;
         end;
     end;
end;

procedure TAwardPointsForm.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
 X: integer;
 S: string;
begin
 if Query.Active and (Query.RecordCount > 0) then
 with Sender As TDBGrid do
  begin
   if (Column.FieldName = 'OrderNo') then
      begin
       SetTextAlign(Canvas.Handle, TA_CENTER);
       X := (Rect.Left + Rect.Right) div 2;
       S := Column.Field.AsString;
      end
     else
      if (Column.FieldName = 'OrderDate') then
         begin
          SetTextAlign(Canvas.Handle, TA_CENTER);
          X := (Rect.Left + Rect.Right) div 2;
          S := FormatDateTime('dd/mm/yyyy', Column.Field.AsDateTime);
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

procedure TAwardPointsForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TAwardPointsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Query.Close;
 Action := caFree;
end;

procedure TAwardPointsForm.FormShow(Sender: TObject);
begin
 Width := DBGridPanel.Width + 28;
 Caption := Caption + ' - ' + Format('%8.8d', [VIPNo]);
 OpenQuery;
 CalcBalance;
end;

procedure TAwardPointsForm.ShowAwardPointsPro(VIPNo: integer);
begin
 Application.CreateForm(TAwardPointsForm, AwardPointsForm);
 AwardPointsForm.VIPNo := VIPNo;
 AwardPointsForm.ShowModal;
 AwardPointsForm.Free;
end;

end.
