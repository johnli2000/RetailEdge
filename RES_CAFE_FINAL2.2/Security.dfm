object SecurityForm: TSecurityForm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 328
  Top = 196
  Height = 150
  Width = 215
  object SecurityTimer: TTimer
    Enabled = False
    Interval = 300000
    OnTimer = SecurityTimerTimer
    Left = 38
    Top = 10
  end
end
