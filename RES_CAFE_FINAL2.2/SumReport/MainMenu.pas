unit MainMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  TMainMenuForm = class(TForm)
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    ReportMenu: TMenuItem;
    LoginMenu: TMenuItem;
    CreatenewdatabaseMenu: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    BranchInformationSetupMenu: TMenuItem;
    Downloaddata1: TMenuItem;
    N2: TMenuItem;
    UploadSalesPrice1: TMenuItem;
    DeleteDatabase1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainMenuForm: TMainMenuForm;

implementation

uses MessageBox, Utility;

{$R *.dfm}

procedure TMainMenuForm.FormShow(Sender: TObject);
begin
 Top := 0; Left := 0;
 Width := Screen.Width;
 Height := Screen.Height;
end;

procedure TMainMenuForm.Exit1Click(Sender: TObject);
begin
 Close;
end;

procedure TMainMenuForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if MDIChildCount > 1 then
    MessageBoxForm.MessagePro('You should close all windows first.', sErrorMsg)
   else
    begin
     UtilityForm.Free;
     Action := caFree;
    end
end;

end.
