unit PrintSimpleDailyReport;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TPrintSimpleDailyReportForm = class(TDataModule)
    Query: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintSimpleDailyReportForm: TPrintSimpleDailyReportForm;

implementation

{$R *.dfm}

procedure TPrintSimpleDailyReportForm.OpenQuery(SQLStr: string);
begin
 Screen.Cursor := crHourGlass;
 with Query do
  begin
   Active := False;
   Connection := DataForm.ADOConnection;
   SQL.Clear;
   SQL.Add(SQLStr);
   Active := True;
  end;
 Screen.Cursor := crDefault;
end;

procedure PrintSimpleDailyReportForm.PrintReport;
var
 PrintStr: string;
begin

end.
