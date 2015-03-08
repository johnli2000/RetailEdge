unit dhnetsdk;

interface

uses
        SysUtils,WinTypes;

type
(************************************************************************
 ** Network disconnection callback fucntion original shape
 ***********************************************************************)
        fDisConnect = procedure (lLoginID: LongInt; strDVRIP: Pchar; nDVRPort: LongInt;  dwUser: LongWord); stdcall;

(************************************************************************
 ** Network disconnection callback fucntion original shape
 ***********************************************************************)
        fDownLoadPosCallBack = procedure (lPlayHandle:LongInt;dwTotalSize:LongWord;dwDownloadSize:LongWord;dwUser: LongWord); stdcall;

(************************************************************************
 ** Alarm message callback fucntion original shape
 ***********************************************************************)
        fMessCallBack = function (lCommand,lLoginID:LongInt; var pBuf;
			dwBufLen:LongWord; strDVRIP:Pchar; nDVRPort:LongInt; dwUser: LongWord ):LongBool;stdcall;

(************************************************************************
 ** Set screen overlay callback
 ***********************************************************************)
        fDrawCallBack = procedure (lLoginID,lPlayHandle:LongInt; hDC: THandle; dwUser:LongInt);stdcall;
 (************************************************************************
 ** Device information
 ***********************************************************************)
        NET_TIME = Record
	        dwYear:integer;	//SN
        	dwMonth:integer;			//DVR alarm input amount
        	dwDay:integer;						//DVR HDD amount
	        dwHour:integer;						//DVR type
        	dwMinute:integer;
          dwSecond:integer;						//DVR channel ammount
        end;
(************************************************************************
 ** Device information
 ***********************************************************************)
        NET_DEVICEINFO=Record
	        sSerialNumber: array [0..47] of Byte;	//SN
        	byAlarmInPortNum: byte;				//DVR alarm input amount
	        byAlarmOutPortNum:BYTE;				//DVR alarm output amount
        	byDiskNum:BYTE;						//DVR HDD amount
	        byDVRType:BYTE ;						//DVR type
        	byChanNum:BYTE;						//DVR channel ammount
        end;
(************************************************************************
 ** Net Record File information
 ***********************************************************************)
        NET_RECORDFILE_INFO=Record
	        ch: integer;	//SN
        	fileName: array [0..128] of Pchar;				//DVR alarm input amount
	        Size:integer;				//DVR alarm output amount
        	startTime:NET_TIME;						//DVR HDD amount
	        stopTime:NET_TIME ;						//DVR type
        	DriverNo:integer;						//DVR channel ammount
          StartCluster : integer;
          nRecordFileType : Byte;
          bImportantRecID : Byte;
          bhint:byte;
          bRecType:byte;
        end;

        DH_RealPlayType = (DH_RType_RealPlay, DH_RType_Multiplay, DH_RType_RealPlay_0,
                          DH_RType_RealPlay_1,DH_RType_RealPlay_2,DH_RType_RealPlay_3,
                          DH_RType_Multiplay_1,DH_RType_Multiplay_4,DH_RType_Multiplay_8,
                          DH_RType_Multiplay_9,DH_RType_Multiplay_16,DH_RType_Multiplay_6,
                          DH_RType_Multiplay_12);
        RECORD_FILE_TYPE = (ALLRECORDFILE,OUTALARM,DYNAMICSCANALARM,ALLALARM,CARDNOSEACH,COMBINEDSEACH);



(************************************************************************
 ** SDK Initialization
 ***********************************************************************)
function  CLIENT_Init( cbDisConnect: fDisConnect; dwUser:LongWord): LongBool; stdcall;

(************************************************************************
 ** SDK exit and clear
 ***********************************************************************)
procedure CLIENT_Cleanup() ; stdcall;

(************************************************************************
 ** Set device connection timeout value and trial times 
 ***********************************************************************)
procedure CLIENT_SetConnectTime(nWaitTime: Integer; nTryTimes: Integer);stdcall; 


(************************************************************************
 ** Get SDK version informaiton
 ***********************************************************************)
function CLIENT_GetSDKVersion(): LongWord;stdcall; 


(************************************************************************
 ** Register to the device
 ***********************************************************************)
function CLIENT_Login(strDVRIP: Pchar; wDVRPort: WORD; strUserName: Pchar; strPassword: Pchar; var netDeviceInfo: NET_DEVICEINFO; error:Pinteger):LongInt;stdcall;


(************************************************************************
 ** Log out the device
 ***********************************************************************)
function CLIENT_Logout(lLoginID: LongInt):LongBool;stdcall; 



(************************************************************************
 ** Set alarm callback fucntion
 ***********************************************************************)
procedure CLIENT_SetDVRMessCallBack(cbMessage:fMessCallBack; dwUser:LongWord);stdcall;


(************************************************************************
 ** Set screen overlay callback 
 ***********************************************************************)
procedure CLIENT_RigisterDrawFun(cbDraw:fDrawCallBack; dwUser:LongWord);stdcall; 


(************************************************************************
 ** Begin real-time monitor 
 ***********************************************************************)
function CLIENT_RealPlay(lLoginID:LongInt; nChannelID:Integer; hWnd:HWND):LongInt;stdcall;

function CLIENT_RealPlayEx(lLoginID:LongInt; nChannelID:Integer; hWnd:HWND;rType:DH_RealPlayType):LongInt;stdcall;
(************************************************************************
 ** Stop real-time preview
 ***********************************************************************)
function CLIENT_StopRealPlay(lRealHandle:LongInt):LongBool;stdcall;

(************************************************************************
 ** PlaybackBy Time
 ***********************************************************************)

//function CLIENT_PlayBackByTime(lLoginID:LongInt; nChannelID:Integer;lpStartTime:NET_TIME;lpEndTime:NET_TIME; hWnd:HWND;
                             // cbDownLoadPos:fDownloadPosCallback;dwUser:LongWord):LongInt;stdcall;

function CLIENT_PlayBackByTime(lLoginID:LongInt; nChannelID:Integer;var lpStartTime:Net_Time;var lpEndTime:Net_Time; hWnd:HWND;
                              cbDownLoadPos:fDownloadPosCallback;dwUser:LongWord):LongInt;stdcall;
function CLIENT_PlayBackByRecordFile(lLoginID:LongInt; var lpRecordFile:NET_RECORDFILE_INFO;hWnd:HWND;
                                    cbDownLoadPosCallBack:fDownloadPosCallback;dwUserData:LongWord):LongInt; stdcall;
function CLIENT_QueryRecordFile(lLoginID:LongInt;nChannelID:Integer;RecordFileType:integer;var lpStartTime:Net_Time;var lpEndTime:Net_Time;
                                pchCardid:string;var lpRecordFile:NET_RECORDFILE_INFO;maxlen:integer;filecount:integer;
                                waittime:integer;bTime:boolean):boolean; stdcall;

function CLIENT_StopPlayBack(lPlayHandle:LongInt):boolean; stdcall


implementation


function  CLIENT_Init; external 'dhnetsdk.dll';
procedure CLIENT_Cleanup; external 'dhnetsdk.dll';
procedure CLIENT_SetConnectTime; external 'dhnetsdk.dll';
function CLIENT_Login; external 'dhnetsdk.dll';
function CLIENT_Logout; external 'dhnetsdk.dll';
procedure CLIENT_SetDVRMessCallBack; external 'dhnetsdk.dll';
procedure CLIENT_RigisterDrawFun; external 'dhnetsdk.dll';
function CLIENT_RealPlay; external 'dhnetsdk.dll';
function CLIENT_StopRealPlay; external 'dhnetsdk.dll';
function CLIENT_GetSDKVersion;external 'dhnetsdk.dll';
function CLIENT_PlayBackByTime; external 'dhnetsdk.dll';
function CLIENT_PlayBackByRecordFile;external 'dhnetsdk.dll';
function CLIENT_RealPlayEx; external 'dhnetsdk.dll';
function CLIENT_QueryRecordFile; external 'dhnetsdk.dll';
function CLIENT_StopPlayBack; external 'dhnetsdk.dll';

end.

