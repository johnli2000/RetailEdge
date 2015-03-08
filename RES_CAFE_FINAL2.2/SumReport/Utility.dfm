object UtilityForm: TUtilityForm
  OldCreateOrder = False
  Left = 421
  Top = 162
  Height = 370
  Width = 502
  object LocalConnection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB'
    Left = 54
    Top = 18
  end
  object RemoteConnection: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB'
    Left = 180
    Top = 18
  end
  object ExecCommand: TADOCommand
    Parameters = <>
    Left = 292
    Top = 20
  end
  object LockQuery: TADOQuery
    LockType = ltUnspecified
    Parameters = <>
    Left = 50
    Top = 82
  end
end
