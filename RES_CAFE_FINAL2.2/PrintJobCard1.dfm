object PrintJobListForm1: TPrintJobListForm1
  OldCreateOrder = True
  Left = 283
  Top = 208
  Height = 114
  Width = 290
  object InstructionQuery: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 108
    Top = 2
  end
  object Query: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 32
    Top = 2
  end
end
