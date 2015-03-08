unit ItemStatistics;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, TeeProcs, TeEngine, Chart, DBChart, StdCtrls, Buttons, Series,
  BusinessSkinForm;

type
  TItemStatisticsForm = class(TForm)
    DBChart: TDBChart;
    Series: TPieSeries;
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StatisticsPro;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ItemStatisticsForm: TItemStatisticsForm;

implementation

uses SalesStatistics, MainMenu;

{$R *.DFM}

procedure TItemStatisticsForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

procedure TItemStatisticsForm.ExitButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TItemStatisticsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

procedure TItemStatisticsForm.StatisticsPro;
begin
 Application.CreateForm(TItemStatisticsForm, ItemStatisticsForm);
 ItemStatisticsForm.ShowModal;
 ItemStatisticsForm.Free;
end;

end.
