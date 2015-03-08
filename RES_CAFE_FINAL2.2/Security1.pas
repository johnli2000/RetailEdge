unit Security1;

interface

uses Windows, SysUtils;

Const
INVALID_HANDLE_VALUE = $ffffffff;

KM_DRIVER = 0;
KM_HID = 1;
KM_AUTO = -1;

LED_OFF = 0;
LED_ON = 1;

SK_DRIVERLESS = 0;
SK_DRIVER = 1;

PASSWORD_TYPE_WRITE = 0;
PASSWORD_TYPE_READ = 1;

Type
sk_init_data = record
    cbSize : UINT;
    sdkVersion : UINT;
    KeyMode : UINT;
    bUseSessionKey : BOOL;
    Reserved : array [0..3] of UINT;
end;

PSKI = ^sk_init_data;
SKI = sk_init_data;

Function SK_Init(pInitData : PSKI): BOOL; stdcall;
Function SK_Open(CustomerId : WORD; szPath : PChar): THandle; stdcall;
procedure SK_Close(hKey : THandle); stdcall;

Function SK_Query(hKey : THandle; Size : DWORD; skInput : PChar; skOutput : PChar): BOOL; stdcall;
Function SK_CheckSum(hKey : THandle; skBuffer : PChar; Length : Integer; CheckSum32 : PDWORD): BOOL; stdcall;
Function SK_GetRandom32(hKey : THandle; dwRandom : PDWORD): BOOL; stdcall;

Function SK_GetSerial(hKey : THandle; Buffer : PChar; Size : Integer): BOOL; stdcall;
Function SK_GetPublicSize(hKey : THandle; Size : PDWORD): BOOL; stdcall;
Function SK_GetProtectSize(hKey : THandle; Size : PDWORD): BOOL; stdcall;
Function SK_GetDriverMemorySize(hKey : THandle; Size : PDWORD): BOOL; stdcall;

Function SK_ReadPublicMemory(hKey : THandle; Index : Integer; Buffer : PChar; Size : Integer): BOOL; stdcall;
Function SK_ReadProtectMemory(hKey : THandle; Password : DWORD; Index : Integer; Buffer : PChar; Size : Integer): BOOL; stdcall;
Function SK_ReadDriverMemory(hKey : THandle; Index : Integer; Buffer : PChar; Size : Integer): BOOL; stdcall;

Function SK_WritePublicMemory(hKey : THandle; Index : Integer; Buffer : PChar; Size : Integer): BOOL; stdcall;
Function SK_WriteProtectMemory(hKey : THandle; Password : DWORD; Index : Integer; Buffer : PChar; Size : Integer): BOOL; stdcall;
Function SK_WriteDriverMemory(hKey : THandle; Index : Integer; Buffer : PChar; Size : Integer): BOOL; stdcall;

Function SK_ChangeLED(hKey : THandle; State : DWORD): BOOL; stdcall;
Function SK_ChangeMode(hKey : THandle; KeyMode : Integer): BOOL; stdcall;
Function SK_ChangePassword(hKey : THandle; Password : DWORD; NPassword : DWORD; PSDType : DWORD): BOOL; stdcall;

implementation

Function SK_Init; external 'skrtl.dll';
Function SK_Open; external 'skrtl.dll';
procedure SK_Close; external 'skrtl.dll';

Function SK_Query; external 'skrtl.dll';
Function SK_CheckSum; external 'skrtl.dll';
Function SK_GetRandom32; external 'skrtl.dll';

Function SK_GetSerial; external 'skrtl.dll';
Function SK_GetPublicSize; external 'skrtl.dll';
Function SK_GetProtectSize; external 'skrtl.dll';
Function SK_GetDriverMemorySize; external 'skrtl.dll';

Function SK_ReadPublicMemory; external 'skrtl.dll';
Function SK_ReadProtectMemory; external 'skrtl.dll';
Function SK_ReadDriverMemory; external 'skrtl.dll';

Function SK_WritePublicMemory; external 'skrtl.dll';
Function SK_WriteProtectMemory; external 'skrtl.dll';
Function SK_WriteDriverMemory; external 'skrtl.dll';

Function SK_ChangeLED; external 'skrtl.dll';
Function SK_ChangeMode; external 'skrtl.dll';
Function SK_ChangePassword; external 'skrtl.dll';

end.
 
