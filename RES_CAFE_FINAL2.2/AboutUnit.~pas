unit AboutUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DataUnit, BusinessSkinForm, bsSkinCtrls,
  XiButton, Security;

type
  TAboutForm = class(TForm)
    bsBusinessSkinForm: TbsBusinessSkinForm;
    VersionLabel: TbsSkinStdLabel;
    bsSkinStdLabel1: TbsSkinStdLabel;
    bsSkinStdLabel2: TbsSkinStdLabel;
    WindowsVersionLabel: TbsSkinStdLabel;
    bsSkinStdLabel3: TbsSkinStdLabel;
    bsSkinStdLabel4: TbsSkinStdLabel;
    bsSkinStdLabel5: TbsSkinStdLabel;
    bsSkinStdLabel6: TbsSkinStdLabel;
    bsSkinStdLabel7: TbsSkinStdLabel;
    TotalPhysicalMemory: TbsSkinStdLabel;
    AvailablePhysicalMemory: TbsSkinStdLabel;
    TotalVirtualMemory: TbsSkinStdLabel;
    AvailableVirtualMemory: TbsSkinStdLabel;
    SystemResource: TbsSkinStdLabel;
    bsSkinStdLabel8: TbsSkinStdLabel;
    BackPanel: TbsSkinPanel;
    OKButton: TXiButton;
    ProductID: TbsSkinStdLabel;
    bsSkinStdLabel9: TbsSkinStdLabel;
    bsSkinStdLabel10: TbsSkinStdLabel;
    bsSkinTextLabel1: TbsSkinTextLabel;
    procedure OKButtonClick(Sender: TObject);
    function  GetWinVersion: string;
    procedure FormShow(Sender: TObject);
    procedure ShowAboutBox;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

uses MainMenu;

{$R *.DFM}

procedure TAboutForm.OKButtonClick(Sender: TObject);
begin
 Close;
end;

procedure TAboutForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = Chr(27) then Close;
end;

function TAboutForm.GetWinVersion: string;
var
 OS: TOSVERSIONINFO;
 MajorVersion, MinorVersion, BuildNumber: DWord;
begin
 OS.dwOSVersionInfoSize := sizeof(OS);
 GetVersionEx(OS);
 MajorVersion := OS.dwMajorVersion;
 MinorVersion := OS.dwMinorVersion;
if OS.dwPlatformId = VER_PLATFORM_WIN32_NT then
   BuildNumber := OS.dwBuildNumber
  else
   BuildNumber := DWORD(LoWORD(OS.dwBuildNumber));
 case OS.dwPlatformId of
   VER_PLATFORM_WIN32_NT: begin
                           if majorVersion <= 4 then
                              Result := 'Windows NT ' + IntToStr(MajorVersion) + '.' +
                                          IntToStr(MinorVersion) + ' [Build ' + IntToStr(BuildNumber) + ']'
                             else
                              if (majorVersion = 5) and (minorVersion = 0) then
                                 Result := 'Windows 2000 ' + IntToStr(MajorVersion) + '.' +
                                           IntToStr(MinorVersion) + ' [Build ' + IntToStr(BuildNumber) + ']'
                                else
                                 if (majorVersion = 5) and (minorVersion = 1) then
                                     Result := 'Windows XP ' + IntToStr(MajorVersion) + '.' +
                                               IntToStr(MinorVersion) + ' [Build ' + IntToStr(BuildNumber) + ']'
                                   else
                                    if (majorVersion = 6) then
                                       begin
                                        if BuildNumber < 7000 then
                                           Result := 'Windows Vista ' + IntToStr(MajorVersion) + '.' +
                                                      IntToStr(MinorVersion) + ' [Build ' + IntToStr(BuildNumber) + ']'
                                          else
                                           Result := 'Windows 7     ' + IntToStr(MajorVersion) + '.' +
                                                      IntToStr(MinorVersion) + ' [Build ' + IntToStr(BuildNumber) + ']'
                                       end;
                          end;
   VER_PLATFORM_WIN32_WINDOWS: begin
                                if (majorVersion = 4) and (minorVersion = 0) then
                                   Result := 'Windows 95 ' + IntToStr(MajorVersion) + '.' +
                                             IntToStr(MinorVersion) + ' [Build ' + IntToStr(BuildNumber) + ']'
                                  else
                                   if (majorVersion = 4) and (minorVersion = 10) then
                                      begin
                                       if OS.szCSDVersion[1] = 'A' then
                                          Result := 'Windows 98 Second Edition ' + IntToStr(MajorVersion) + '.' +
                                                    IntToStr(MinorVersion) + ' [Build ' + IntToStr(BuildNumber) + ']'
                                         else
                                          Result := 'Windows 98 ' + IntToStr(MajorVersion) + '.' +
                                                    IntToStr(MinorVersion) + ' [Build ' + IntToStr(BuildNumber) + ']'
                                      end
                                     else
                                      if (majorVersion = 4) and (minorVersion = 90) then
                                         Result := 'Windows Me ' + IntToStr(MajorVersion) + '.' +
                                                   IntToStr(MinorVersion) + ' [Build ' + IntToStr(BuildNumber) + ']'
                                        else
                                         Result := 'Unknown';
                               end;
  end;
 Result := Result + ' ' + OS.szCSDVersion
end;

procedure TAboutForm.FormShow(Sender: TObject);
var
 MemInfo: MemoryStatus;
begin
 VersionLabel.Caption := 'Hospitality Edition V ' + sVersion;
 ProductID.Caption := SecurityForm.GetActiveCode;
 WindowsVersionLabel.Caption := GetWinVersion;
 MemInfo.dwLength := sizeof(MemoryStatus);
 GlobalMemoryStatus(MemInfo);
 TotalPhysicalMemory.Caption := FormatFloat('#,###" KB"', MemInfo.dwTotalPhys / 1024);
 AvailablePhysicalMemory.Caption := FormatFloat('#,###" KB"', MemInfo.dwAvailPhys / 1024);
 TotalVirtualMemory.Caption := FormatFloat('#,###" KB"', MemInfo.dwTotalVirtual / 1024);
 AvailableVirtualMemory.Caption := FormatFloat('#,###" KB"', MemInfo.dwAvailVirtual / 1024);
 SystemResource.Caption := IntToStr(MemInfo.dwMemoryLoad) + ' % Free';
end;

procedure TAboutForm.ShowAboutBox;
begin
 Application.CreateForm(TAboutForm, AboutForm);
 AboutForm.ShowModal;
 AboutForm.Free;
end;

end.
