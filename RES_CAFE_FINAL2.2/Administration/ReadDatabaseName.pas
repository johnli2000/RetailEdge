unit ReadDatabaseName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Administration, BusinessSkinForm, XiButton, StdCtrls, Mask,
  bsSkinBoxCtrls, bsSkinCtrls, ComObj;

type
  TReadDatabaseNameForm = class(TForm)
    bsBusinessSkinForm1: TbsBusinessSkinForm;
    BackPanel: TbsSkinPanel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    ConfirmButton: TXiButton;
    CancelButton: TXiButton;
    DatabaseNameEdit: TEdit;
    DemoDatabaseCheckBox: TCheckBox;
    CollationCheckBox: TCheckBox;
    procedure CancelButtonClick(Sender: TObject);
    procedure ConfirmButtonClick(Sender: TObject);
    function  ReadDatabaseNamePro(var DatabaseName: string; var SupportChinese, DemoDatabase: boolean): boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private { Private declarations }
     ReturnFlag: boolean;
  public
    { Public declarations }
  end;

var
  ReadDatabaseNameForm: TReadDatabaseNameForm;

implementation

uses MessageBox;

{$R *.dfm}

procedure TReadDatabaseNameForm.CancelButtonClick(Sender: TObject);
begin
 ReturnFlag := False;
 Close;
end;

procedure TReadDatabaseNameForm.ConfirmButtonClick(Sender: TObject);
begin
 if DatabaseNameEdit.Text = '' then
    begin
     MessageBoxForm.MessagePro('Database Name is invalid.', ErrorMsg);
     DatabaseNameEdit.SetFocus;
    end
   else
    begin
     ReturnFlag := True;
     Close;
    end;
end;

procedure TReadDatabaseNameForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action := caFree;
end;

function TReadDatabaseNameForm.ReadDatabaseNamePro(var DatabaseName: string; var SupportChinese, DemoDatabase: boolean): boolean;
begin
 Application.CreateForm(TReadDatabaseNameForm, ReadDatabaseNameForm);
 ReadDatabaseNameForm.ShowModal;
 Result := ReadDatabaseNameForm.ReturnFlag;
 if Result then
    begin
     DatabaseName := ReadDatabaseNameForm.DatabaseNameEdit.Text;
     DemoDatabase := ReadDatabaseNameForm.DemoDatabaseCheckBox.Checked;
     SupportChinese := ReadDatabaseNameForm.CollationCheckBox.Checked;
    end;
 ReadDatabaseNameForm.Free;
end;

end.
