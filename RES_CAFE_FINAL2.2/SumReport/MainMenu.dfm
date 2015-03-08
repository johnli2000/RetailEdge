object MainMenuForm: TMainMenuForm
  Left = 343
  Top = 124
  Width = 937
  Height = 601
  Caption = 'Sum Report for Digital Data Assist Hospitality Edition'
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 6
    Top = 4
    object FileMenu: TMenuItem
      Caption = 'File'
      object LoginMenu: TMenuItem
        Caption = 'Connect to server'
      end
      object CreatenewdatabaseMenu: TMenuItem
        Caption = 'Create new database'
      end
      object DeleteDatabase1: TMenuItem
        Caption = 'Delete Database'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object BranchInformationSetupMenu: TMenuItem
        Caption = 'Branch Information Setup'
      end
      object Downloaddata1: TMenuItem
        Caption = 'Download Data'
      end
      object UploadSalesPrice1: TMenuItem
        Caption = 'Upload Sales Price'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object ReportMenu: TMenuItem
      Caption = 'Report'
    end
  end
end
