object DataForm: TDataForm
  OldCreateOrder = False
  Left = 724
  Top = 151
  Height = 338
  Width = 535
  object POSPrinterPort: TCommPortDriver
    ComPort = pnCOM1
    ComPortHwHandshaking = hhRTSCTS
    ComPortSwHandshaking = shXONXOFF
    ComPortPollingDelay = 10
    Left = 36
    Top = 62
  end
  object PoleDisplayComPort: TCommPortDriver
    ComPort = pnCOM1
    ComPortHwHandshaking = hhRTSCTS
    ComPortSwHandshaking = shXONXOFF
    ComPortPollingDelay = 0
    Left = 38
    Top = 116
  end
  object DrawerControlPort: TCommPortDriver
    ComPortPollingDelay = 0
    Left = 144
    Top = 64
  end
  object ADOConnection: TADOConnection
    CommandTimeout = 120
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=southmel2;Data Source=SERVER-pc;Auto Tr' +
      'anslate=True;'
    ConnectionTimeout = 120
    KeepConnection = False
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 146
    Top = 116
  end
  object CompanyQuery: TADOQuery
    LockType = ltUnspecified
    Parameters = <>
    Left = 308
    Top = 8
  end
  object LockQuery: TADOQuery
    Parameters = <>
    Left = 230
    Top = 60
  end
  object CheckQuery: TADOQuery
    LockType = ltUnspecified
    Parameters = <>
    Left = 34
    Top = 10
  end
  object TempQuery: TADOQuery
    LockType = ltUnspecified
    Parameters = <>
    Left = 228
    Top = 8
  end
  object ExecCommand: TADOCommand
    Parameters = <>
    ParamCheck = False
    Left = 130
    Top = 10
  end
  object DrawerStatusPort: TCommPortDriver
    ComPortPollingDelay = 0
    Left = 434
    Top = 116
  end
  object ScaleCommPort: TCommPortDriver
    ComPortPollingDelay = 0
    Left = 306
    Top = 58
  end
  object BackupTimer: TTimer
    Enabled = False
    OnTimer = BackupTimerTimer
    Left = 434
    Top = 8
  end
  object PrinterStatusCheckTimer: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = PrinterStatusCheckTimerTimer
    Left = 64
    Top = 176
  end
  object SecurityCameraCommPort: TCommPortDriver
    ComPortPollingDelay = 0
    Left = 308
    Top = 114
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 60607
    ServerType = stNonBlocking
    OnClientRead = ServerSocketClientRead
    OnClientError = ServerSocketClientError
    Left = 144
    Top = 184
  end
end
