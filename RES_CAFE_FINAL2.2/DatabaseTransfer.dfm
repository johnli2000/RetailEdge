object DatabaseTransferForm: TDatabaseTransferForm
  Left = 357
  Top = 123
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Database Transfer'
  ClientHeight = 422
  ClientWidth = 762
  Color = 15389375
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelDatabasePanel: TbsSkinPanel
    Left = 4
    Top = 6
    Width = 742
    Height = 117
    TabOrder = 0
    SkinData = MainForm.bsSkinData
    SkinDataName = 'panel'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 14
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    RealHeight = -1
    AutoEnabledControls = True
    CheckedMode = False
    Checked = False
    DefaultAlignment = taLeftJustify
    DefaultCaptionHeight = 22
    BorderStyle = bvFrame
    CaptionMode = False
    RollUpMode = False
    RollUpState = False
    NumGlyphs = 1
    Spacing = 2
    Caption = 'PanelDatabasePanel'
    object GroupBox1: TGroupBox
      Left = 12
      Top = 11
      Width = 352
      Height = 94
      Caption = ' Data Source '
      Color = 15389375
      ParentColor = False
      TabOrder = 0
      object Label1: TLabel
        Left = 22
        Top = 31
        Width = 62
        Height = 13
        Caption = 'Server Name'
        Color = 15389375
        ParentColor = False
      end
      object Label3: TLabel
        Left = 22
        Top = 63
        Width = 77
        Height = 13
        Caption = 'Database Name'
        Color = 15389375
        ParentColor = False
      end
      object SourceServerName: TStaticText
        Left = 112
        Top = 29
        Width = 219
        Height = 17
        AutoSize = False
        BorderStyle = sbsSingle
        Color = 15389375
        ParentColor = False
        TabOrder = 0
      end
      object SourceDatabaseName: TStaticText
        Left = 112
        Top = 61
        Width = 219
        Height = 17
        AutoSize = False
        BorderStyle = sbsSingle
        Color = 15389375
        ParentColor = False
        TabOrder = 1
      end
    end
    object GroupBox2: TGroupBox
      Left = 374
      Top = 11
      Width = 355
      Height = 94
      Caption = ' Destination '
      Color = 15389375
      ParentColor = False
      TabOrder = 1
      object Label4: TLabel
        Left = 24
        Top = 31
        Width = 62
        Height = 13
        Caption = 'Server Name'
        Color = 15389375
        ParentColor = False
      end
      object Label5: TLabel
        Left = 24
        Top = 63
        Width = 77
        Height = 13
        Caption = 'Database Name'
        Color = 15389375
        ParentColor = False
      end
      object ServerNameEdit: TEdit
        Left = 110
        Top = 28
        Width = 225
        Height = 19
        TabOrder = 0
      end
      object DatabaseNameEdit: TEdit
        Left = 110
        Top = 60
        Width = 225
        Height = 19
        TabOrder = 1
      end
    end
  end
  object ControlPanel: TbsSkinPanel
    Left = 4
    Top = 125
    Width = 367
    Height = 173
    TabOrder = 1
    SkinData = MainForm.bsSkinData
    SkinDataName = 'panel'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 14
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    RealHeight = -1
    AutoEnabledControls = True
    CheckedMode = False
    Checked = False
    DefaultAlignment = taLeftJustify
    DefaultCaptionHeight = 22
    BorderStyle = bvFrame
    CaptionMode = False
    RollUpMode = False
    RollUpState = False
    NumGlyphs = 1
    Spacing = 2
    Caption = 'ControlPanel'
    object CompanyProfileCheckBox: TCheckBox
      Left = 32
      Top = 14
      Width = 97
      Height = 17
      Caption = 'Company Profile'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 0
    end
    object CategoryCheckBox: TCheckBox
      Left = 32
      Top = 40
      Width = 97
      Height = 17
      Caption = 'Category'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 1
    end
    object MenuItemCheckBox: TCheckBox
      Left = 32
      Top = 66
      Width = 97
      Height = 17
      Caption = 'Menu Items'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 2
    end
    object VIPInformationCheckBox: TCheckBox
      Left = 202
      Top = 40
      Width = 105
      Height = 17
      Caption = 'V.I.P. Information'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 3
    end
    object ChartCheckBox: TCheckBox
      Left = 32
      Top = 118
      Width = 141
      Height = 17
      Caption = 'Chart Of Account'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 4
    end
    object SupplierInformationCheckBox: TCheckBox
      Left = 202
      Top = 14
      Width = 127
      Height = 17
      Caption = 'Supplier Information'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 6
    end
    object MealPackageCheckBox: TCheckBox
      Left = 32
      Top = 92
      Width = 97
      Height = 17
      Caption = 'Meal Package'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 7
    end
    object PaymentsMethodCheckBox: TCheckBox
      Left = 202
      Top = 66
      Width = 115
      Height = 17
      Caption = 'Payments Method'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 8
    end
    object UserCheckBox: TCheckBox
      Left = 202
      Top = 92
      Width = 103
      Height = 17
      Caption = 'User Information'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 9
    end
    object BankCheckBox: TCheckBox
      Left = 202
      Top = 118
      Width = 151
      Height = 17
      Caption = 'Bank Account Information'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 10
    end
    object DeliveryStreetCheckBox: TCheckBox
      Left = 32
      Top = 144
      Width = 145
      Height = 17
      Caption = 'Delivery Street Database'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 5
    end
  end
  object DataPanel: TbsSkinPanel
    Left = 374
    Top = 125
    Width = 372
    Height = 173
    TabOrder = 2
    SkinData = MainForm.bsSkinData
    SkinDataName = 'panel'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 14
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    RealHeight = -1
    AutoEnabledControls = True
    CheckedMode = False
    Checked = False
    DefaultAlignment = taLeftJustify
    DefaultCaptionHeight = 22
    BorderStyle = bvFrame
    CaptionMode = False
    RollUpMode = False
    RollUpState = False
    NumGlyphs = 1
    Spacing = 2
    Caption = 'DataPanel'
    object Label2: TLabel
      Left = 180
      Top = 19
      Width = 13
      Height = 13
      Caption = 'To'
      Color = 15389375
      ParentColor = False
    end
    object DateEdit1: TMaskEdit
      Left = 70
      Top = 16
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnClick = DateEditClick
      OnExit = DateEdit1Exit
      OnKeyDown = DateEdit1KeyDown
    end
    object DateEdit2: TMaskEdit
      Left = 200
      Top = 16
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      OnClick = DateEditClick
      OnExit = DateEdit2Exit
      OnKeyDown = DateEdit2KeyDown
    end
    object SalesCheckBox: TCheckBox
      Left = 34
      Top = 48
      Width = 101
      Height = 17
      Caption = 'Sales && Receipts'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 5
    end
    object ExpensesCheckBox: TCheckBox
      Left = 34
      Top = 114
      Width = 125
      Height = 17
      Caption = 'Expenses && Payments'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 6
    end
    object StockCheckBox: TCheckBox
      Left = 34
      Top = 70
      Width = 147
      Height = 17
      Caption = 'Stock Receive && Payment'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 7
    end
    object BookingCheckBox: TCheckBox
      Left = 210
      Top = 48
      Width = 137
      Height = 17
      Caption = 'Booking Information'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 8
    end
    object DateCheckBox: TCheckBox
      Left = 24
      Top = 17
      Width = 45
      Height = 17
      Caption = 'Date'
      Color = 15389375
      ParentColor = False
      TabOrder = 0
      OnClick = DateCheckBoxClick
    end
    object PurchaseCheckBox: TCheckBox
      Left = 34
      Top = 92
      Width = 97
      Height = 17
      Caption = 'Purchase Order'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 9
    end
    object CashPayOutCheckBox: TCheckBox
      Left = 210
      Top = 70
      Width = 97
      Height = 17
      Caption = 'Cash Pay Out'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 10
    end
    object TimeEdit1: TMaskEdit
      Left = 140
      Top = 16
      Width = 35
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 2
      Text = '  :  '
      OnClick = TimeEditClick
      OnKeyDown = TimeEdit1KeyDown
    end
    object TimeEdit2: TMaskEdit
      Left = 270
      Top = 16
      Width = 35
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 4
      Text = '  :  '
      OnClick = TimeEditClick
      OnKeyDown = TimeEdit2KeyDown
    end
    object AttendanceCheckBox: TCheckBox
      Left = 210
      Top = 92
      Width = 133
      Height = 17
      Caption = 'Attendance Records'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 11
    end
    object CashFloatCheckBox: TCheckBox
      Left = 210
      Top = 114
      Width = 97
      Height = 17
      Caption = 'Cash Float'
      Checked = True
      Color = 15389375
      ParentColor = False
      State = cbChecked
      TabOrder = 12
    end
    object WastageCheckBox: TCheckBox
      Left = 34
      Top = 136
      Width = 97
      Height = 17
      Caption = 'Stock Wastage'
      Checked = True
      State = cbChecked
      TabOrder = 13
    end
  end
  object GaugePanel: TbsSkinPanel
    Left = 4
    Top = 300
    Width = 742
    Height = 53
    TabOrder = 3
    SkinData = MainForm.bsSkinData
    SkinDataName = 'panel'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = 14
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultWidth = 0
    DefaultHeight = 0
    UseSkinFont = True
    RealHeight = -1
    AutoEnabledControls = True
    CheckedMode = False
    Checked = False
    DefaultAlignment = taLeftJustify
    DefaultCaptionHeight = 22
    BorderStyle = bvFrame
    CaptionMode = False
    RollUpMode = False
    RollUpState = False
    NumGlyphs = 1
    Spacing = 2
    Caption = 'GaugePanel'
    object Gauge: TGauge
      Left = 12
      Top = 24
      Width = 717
      Height = 20
      ForeColor = clYellow
      Progress = 0
    end
    object TableNameLabel: TLabel
      Left = 13
      Top = 8
      Width = 58
      Height = 13
      Caption = 'Table Name'
      Color = 15389375
      ParentColor = False
    end
  end
  object StartButton: TXiButton
    Left = 444
    Top = 360
    Width = 100
    Height = 40
    ColorFace = 15987699
    ColorGrad = 12369084
    ColorDark = 10987431
    ColorLight = 16250871
    ColorBorder = 6447714
    ColorText = clBlack
    OverColorFace = 15790320
    OverColorGrad = 10921638
    OverColorDark = 10658466
    OverColorLight = 15658734
    OverColorBorder = 7697781
    OverColorText = clBlack
    DownColorFace = 13290186
    DownColorGrad = 14342874
    DownColorDark = 15329769
    DownColorLight = 8158332
    DownColorBorder = 5131854
    DownColorText = clBlack
    DisabledColorFace = 15658734
    DisabledColorGrad = clWhite
    DisabledColorDark = 13816530
    DisabledColorLight = clWhite
    DisabledColorBorder = clGray
    DisabledColorText = clGray
    ColorFocusRect = 11382189
    ColorScheme = csNeoSilver
    Ctl3D = True
    Layout = blGlyphLeft
    Spacing = 4
    TransparentGlyph = True
    Gradient = True
    HotTrack = True
    Caption = 'Start'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = StartButtonClick
  end
  object ExitButton: TXiButton
    Left = 554
    Top = 360
    Width = 100
    Height = 40
    ColorFace = 15987699
    ColorGrad = 12369084
    ColorDark = 10987431
    ColorLight = 16250871
    ColorBorder = 6447714
    ColorText = clBlack
    OverColorFace = 15790320
    OverColorGrad = 10921638
    OverColorDark = 10658466
    OverColorLight = 15658734
    OverColorBorder = 7697781
    OverColorText = clBlack
    DownColorFace = 13290186
    DownColorGrad = 14342874
    DownColorDark = 15329769
    DownColorLight = 8158332
    DownColorBorder = 5131854
    DownColorText = clBlack
    DisabledColorFace = 15658734
    DisabledColorGrad = clWhite
    DisabledColorDark = 13816530
    DisabledColorLight = clWhite
    DisabledColorBorder = clGray
    DisabledColorText = clGray
    ColorFocusRect = 11382189
    ColorScheme = csNeoSilver
    Ctl3D = True
    Layout = blGlyphLeft
    Spacing = 4
    TransparentGlyph = True
    Gradient = True
    HotTrack = True
    Caption = 'Exit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = ExitButtonClick
  end
  object TargetQuery: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 10
    Top = 358
  end
  object SourceQuery: TADOQuery
    Connection = DataForm.ADOConnection
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 100
    Top = 358
  end
  object TargetADOConnection: TADOConnection
    CommandTimeout = 300
    ConnectionTimeout = 120
    Left = 70
    Top = 358
  end
  object ExecCommand: TADOCommand
    CommandTimeout = 300
    Parameters = <>
    ParamCheck = False
    Left = 40
    Top = 358
  end
  object bsBusinessSkinForm: TbsBusinessSkinForm
    UseFormCursorInNCArea = False
    MaxMenuItemsInWindow = 0
    ClientWidth = 0
    ClientHeight = 0
    HideCaptionButtons = True
    AlwaysShowInTray = False
    LogoBitMapTransparent = False
    AlwaysMinimizeToTray = False
    UseSkinFontInMenu = False
    ShowIcon = False
    MaximizeOnFullScreen = False
    AlphaBlend = False
    AlphaBlendAnimation = False
    AlphaBlendValue = 200
    ShowObjectHint = False
    UseDefaultObjectHint = False
    MenusAlphaBlend = False
    MenusAlphaBlendAnimation = False
    MenusAlphaBlendValue = 200
    DefCaptionFont.Charset = DEFAULT_CHARSET
    DefCaptionFont.Color = clBtnText
    DefCaptionFont.Height = 14
    DefCaptionFont.Name = 'Arial'
    DefCaptionFont.Style = [fsBold]
    DefInActiveCaptionFont.Charset = DEFAULT_CHARSET
    DefInActiveCaptionFont.Color = clBtnShadow
    DefInActiveCaptionFont.Height = 14
    DefInActiveCaptionFont.Name = 'Arial'
    DefInActiveCaptionFont.Style = [fsBold]
    DefMenuItemHeight = 20
    DefMenuItemFont.Charset = DEFAULT_CHARSET
    DefMenuItemFont.Color = clWindowText
    DefMenuItemFont.Height = 14
    DefMenuItemFont.Name = 'Arial'
    DefMenuItemFont.Style = []
    UseDefaultSysMenu = False
    SkinData = MainForm.bsSkinData
    MinHeight = 0
    MinWidth = 0
    MaxHeight = 0
    MaxWidth = 0
    Magnetic = False
    MagneticSize = 5
    BorderIcons = []
    Left = 128
    Top = 358
  end
end
