unit SecondDisplay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, Grids, bsSkinCtrls;

type
  TSecondDisplayForm = class(TForm)
    PoleMessage1: TLabel;
    PoleMessage2: TLabel;
    PictureTimer: TTimer;
    StringGrid: TStringGrid;
    AmountLabel: TLabel;
    TotalSalesEdit: TStaticText;
    Image: TImage;
    DiscountLabel: TLabel;
    ReceivableLabel: TLabel;
    ChangeLabel: TLabel;
    MethodLabel1: TLabel;
    DiscountEdit: TStaticText;
    ReceivableEdit: TStaticText;
    PaymentEdit1: TStaticText;
    MethodLabel2: TLabel;
    PaymentEdit2: TStaticText;
    RoundingLabel: TLabel;
    RoundingEdit: TStaticText;
    ChangeEdit: TStaticText;
    Shape2: TShape;
    ItemImage: TImage;
    TipsLabel: TLabel;
    TipsEdit: TStaticText;
    BankChargeLabel: TLabel;
    BankChargeEdit: TStaticText;
    AvailableCreditLabel: TLabel;
    AvailableCreditEdit: TLabel;
    BackPanel: TbsSkinPanel;
    ImagePanel: TbsSkinPanel;
    StringGridPanel: TbsSkinPanel;
    ItemPictureBackPanel: TbsSkinPanel;
    TotalPanel: TbsSkinPanel;
    TitalPanel: TbsSkinPanel;
    procedure InitStringGrid;
    procedure StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure InitForm;
    procedure SetSalesStatus;
    procedure SetPaymentStatus;
    procedure SetWaitingStatus;
    procedure SetCounterCloseStatus;
    procedure GotoCurrentRow;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PictureTimerTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private { Private declarations }
    TotalPicture, CurrentPicture: integer;
    LoadPath: array [1..100] of string;
  public
    { Public declarations }
  end;

implementation

uses DataUnit, MainMenu;

{$R *.dfm}

procedure TSecondDisplayForm.InitStringGrid;
var
 I: integer;
begin
 with StringGrid do
  begin
   Cells[0, 0] := 'Item';
   Cells[1, 0] := 'QTY';
   Cells[2, 0] := 'Price';
   Cells[3, 0] := 'AMOUNT';

   for I := 1 to 50 do
    begin
     Cells[0, I] := '';
     Cells[1, I] := '';
     Cells[2, I] := '';
     Cells[3, I] := '';
    end;
   Row := 1;
  end;
end;

procedure TSecondDisplayForm.StringGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
 X: integer;
begin
 with Sender As TStringGrid do
  begin
   if ARow > 0 then
      begin
       Canvas.Font.Size := 18;
      end
     else
      begin

       Canvas.Font.Size := 16;
      end;
    if ACol = 0 then
       begin
       
        SetTextAlign(Canvas.Handle, TA_LEFT);
        X := Rect.Left + 2;
       end
     else
       begin
        SetTextAlign(Canvas.Handle, TA_RIGHT);
        X := Rect.Right - 2;
       end;
    Canvas.Font.Style := [fsBold];
    if State = [gdSelected] then Canvas.Font.Color := clWhite;
    Canvas.TextRect(Rect,X, Rect.Top + 2, Cells[ACol, ARow]);
 end;
end;

procedure TSecondDisplayForm.InitForm;
begin
 InitStringGrid;
end;

procedure TSecondDisplayForm.SetSalesStatus;
begin
 PoleMessage2.Caption := 'THANK YOU';
 MethodLabel1.Caption := 'Payment:';
 StringGridPanel.Visible := True;
 ImagePanel.Visible := False;
 TotalPanel.Visible := True;
 ReceivableLabel.Visible := true;
 ReceivableEdit.Visible := true;
 PaymentEdit1.Visible := False;
 MethodLabel2.Visible := False;
 PaymentEdit2.Visible := False;
 TipsLabel.Visible := False;
 TipsEdit.Visible := False;
 BankChargeLabel.Visible := False;
 BankChargeEdit.Visible := False;
 RoundingLabel.Visible := False;
 RoundingEdit.Visible := False;
 ChangeLabel.Visible := False;
 ChangeEdit.Visible := False;
end;

procedure TSecondDisplayForm.SetPaymentStatus;
begin
 PoleMessage2.Caption := 'THANK YOU';
 StringGridPanel.Visible := True;
 ImagePanel.Visible := False;
 TotalPanel.Visible := True;
 ReceivableLabel.Visible := True;
 ReceivableEdit.Visible := True;
 PaymentEdit1.Visible := True;
 MethodLabel2.Visible := False;
 PaymentEdit2.Visible := False;
 TipsLabel.Visible := False;
 TipsEdit.Visible := False;
 BankChargeLabel.Visible := False;
 BankChargeEdit.Visible := False;
 RoundingLabel.Visible := False;
 RoundingEdit.Visible := False;
 ChangeLabel.Visible := True;
 ChangeEdit.Visible := True;
end;

procedure TSecondDisplayForm.SetWaitingStatus;
begin
 
 //PoleMessage2.Caption := 'Welcome';
 MethodLabel1.Caption := 'Payment:';
 StringGridPanel.Visible := False;
 ImagePanel.Visible := True;
 DiscountLabel.Visible := False;
 DiscountEdit.Visible := False;
 ReceivableLabel.Visible := false;
 ReceivableEdit.Visible := false;
 PaymentEdit1.Visible := False;
 MethodLabel2.Visible := False;
 PaymentEdit2.Visible := False;
 TipsLabel.Visible := False;
 TipsEdit.Visible := False;
 BankChargeLabel.Visible := False;
 BankChargeEdit.Visible := False;
 RoundingLabel.Visible := False;
 RoundingEdit.Visible := False;
 ChangeLabel.Visible := False;
 ChangeEdit.Visible := False;
 AvailableCreditLabel.Visible := False;
 AvailableCreditEdit.Visible := False;
 TotalSalesEdit.Caption := Format('%4.2m ', [0.0]);
 ReceivableEdit.Caption := Format('%4.2m ', [0.0]);
 if FileExists(StartDir + 'Logo.JPG') then ItemImage.Picture.LoadFromFile(StartDir + 'Logo.JPG');
end;

procedure TSecondDisplayForm.SetCounterCloseStatus;
begin
 //PoleMessage2.Caption := 'SORRY, THIS COUNTER IS CLOSED';
 //PoleMessage2.Caption := 'Welcome';
 MethodLabel1.Caption := 'Payment:';
 StringGridPanel.Visible := False;
 ImagePanel.Visible := True;
 ReceivableLabel.Visible := false;
 ReceivableEdit.Visible := false;
 DiscountLabel.Visible := False;
 DiscountEdit.Visible := False;
 PaymentEdit1.Visible := False;
 MethodLabel2.Visible := False;
 PaymentEdit2.Visible := False;
 TipsLabel.Visible := False;
 TipsEdit.Visible := False;
 BankChargeLabel.Visible := False;
 BankChargeEdit.Visible := False;
 RoundingLabel.Visible := False;
 RoundingEdit.Visible := False;
 ChangeLabel.Visible := False;
 ChangeEdit.Visible := False;
 AvailableCreditLabel.Visible := False;
 AvailableCreditEdit.Visible := False;
 TotalSalesEdit.Caption := Format('%4.2m ', [0.0]);
 ReceivableEdit.Caption := Format('%4.2m ', [0.0]);
 if FileExists(StartDir + 'Logo.JPG') then ItemImage.Picture.LoadFromFile(StartDir + 'Logo.JPG');
end;

procedure TSecondDisplayForm.GotoCurrentRow;
var
 I, CurrentRow: integer;
begin
 CurrentRow := 1;
 with StringGrid do
  begin
   for I := 1 to 500 do
    if Cells[0, I] <> '' then CurrentRow := I;
   Row := CurrentRow;
  end;
end;

procedure TSecondDisplayForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TSecondDisplayForm.PictureTimerTimer(Sender: TObject);
begin
 if (TotalPicture > 0) then
    begin
     if CurrentPicture < TotalPicture then
        Inc(CurrentPicture)
       else
        CurrentPicture := 1;
     if FileExists(LoadPath[CurrentPicture]) then
        Image.Picture.Graphic.LoadFromFile(LoadPath[CurrentPicture]);
    end;
end;

procedure TSecondDisplayForm.FormResize(Sender: TObject);
begin
 BackPanel.Left := 0;
 BackPanel.Top := 0;
end;

procedure TSecondDisplayForm.FormCreate(Sender: TObject);
var
 FileName, S: string;
 F: TextFile;
 I: integer;
begin
 for I := 1 to Length(CompanyTitle) do
  if CompanyTitle[I] = '&' then
     S := S + '&&'
    else
     S := S + CompanyTitle[I];
 PoleMessage1.Caption := 'WELCOME TO ' + Uppercase(S);
 if Length(PoleMessage1.Caption) >= 38 then
    PoleMessage1.Font.Size := 18
   else
    PoleMessage1.Font.Size := 24;
 Width := 800;
 Height := 600;
 BackPanel.Width := 800;
 BackPanel.Height := 600;
 BackPanel.Left := 0;
 BackPanel.Top := 0;
 InitForm;
 SetWaitingStatus;
 PictureTimer.Enabled := True;
 FileName := StartDir + 'PictureLoad.CFG';
 TotalPicture := 0;
 if FileExists(FileName) then
    begin
     AssignFile(F, FileName);
     Reset(F);
     while Not EOF(F) do
      begin
       Readln(F, S);
       if S <> '' then
          begin
           Inc(TotalPicture);
           LoadPath[TotalPicture] := S;
          end;
      end;
     CloseFile(F);
    end;
 if (TotalPicture > 0) then
    begin
     CurrentPicture := 1;
     if FileExists(LoadPath[CurrentPicture]) then
        Image.Picture.Graphic.LoadFromFile(LoadPath[CurrentPicture]);
    end;
end;



end.
