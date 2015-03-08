object MaintenanceForm: TMaintenanceForm
  Left = 390
  Top = 329
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Database Maintenance'
  ClientHeight = 304
  ClientWidth = 662
  Color = 15389375
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ControlPanel: TbsSkinPanel
    Left = 6
    Top = 6
    Width = 639
    Height = 230
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
    Caption = 'ControlPanel'
    object TableGroupBox: TbsSkinGroupBox
      Left = 18
      Top = 59
      Width = 602
      Height = 113
      TabOrder = 2
      SkinData = MainForm.bsSkinData
      SkinDataName = 'groupbox'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      RealHeight = -1
      AutoEnabledControls = True
      CheckedMode = False
      Checked = False
      DefaultAlignment = taCenter
      DefaultCaptionHeight = 22
      BorderStyle = bvFrame
      CaptionMode = True
      RollUpMode = False
      RollUpState = False
      NumGlyphs = 1
      Spacing = 2
      Caption = ' Select data that you want to clear '
      object SalesandReceiptsBox: TCheckBox
        Left = 34
        Top = 40
        Width = 147
        Height = 17
        Caption = 'Sales &&  Receipts'
        TabOrder = 0
      end
      object ExemptTaxInvoiceCheckBox: TCheckBox
        Left = 439
        Top = 40
        Width = 117
        Height = 17
        Caption = 'Attendance Record'
        TabOrder = 2
      end
      object PointOfSalesInvoiceCheckBox: TCheckBox
        Left = 246
        Top = 40
        Width = 131
        Height = 17
        Caption = 'Purchase && Payments'
        TabOrder = 1
      end
      object StockValueCheckBox: TCheckBox
        Left = 34
        Top = 73
        Width = 293
        Height = 17
        Caption = 'Auto make stock adjustment for keepping stock balance'
        TabOrder = 3
      end
    end
    object DatePanel: TbsSkinPanel
      Left = 18
      Top = 12
      Width = 602
      Height = 44
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
      Caption = 'DatePanel'
      object Label1: TLabel
        Left = 142
        Top = 16
        Width = 13
        Height = 13
        Caption = 'To'
      end
      object DateCheckBox: TCheckBox
        Left = 18
        Top = 14
        Width = 45
        Height = 17
        Caption = 'Date'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = DateCheckBoxClick
      end
      object DateEdit1: TMaskEdit
        Left = 68
        Top = 12
        Width = 65
        Height = 19
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        OnClick = DateEditClick
        OnKeyDown = DateEdit1KeyDown
      end
      object DateEdit2: TMaskEdit
        Left = 163
        Top = 12
        Width = 65
        Height = 19
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 2
        Text = '  /  /    '
        OnClick = DateEditClick
      end
      object DeleteAllCheckBox: TCheckBox
        Left = 512
        Top = 14
        Width = 69
        Height = 17
        Caption = 'Delete All'
        TabOrder = 3
        OnClick = DeleteAllCheckBoxClick
      end
    end
    object IndicatePanel: TbsSkinPanel
      Left = 18
      Top = 175
      Width = 602
      Height = 41
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
      Caption = 'IndicatePanel'
      Enabled = False
      object Gauge: TGauge
        Left = 10
        Top = 11
        Width = 581
        Height = 20
        ForeColor = clYellow
        Progress = 0
      end
    end
  end
  object IndividualButton: TXiButton
    Left = 42
    Top = 244
    Width = 175
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
    Caption = 'Manually Maintain Database'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = IndividualButtonClick
  end
  object StartButton: TXiButton
    Left = 390
    Top = 244
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
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = StartButtonClick
  end
  object ExitButton: TXiButton
    Left = 502
    Top = 244
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
    TabOrder = 3
    OnClick = ExitButtonClick
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      
        'Select InvoiceNo, InvoiceDate, CustomerName, ReferenceNo, Custom' +
        'erOrderNo, KindFlag'
      'From InvoiceHead, Customer'
      'Where InvoiceHead.CustomerCode=Customer.CustomerCode'
      'Order By InvoiceNo'
      '')
    Left = 272
    Top = 25
  end
  object TempQuery: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 302
    Top = 26
  end
  object bsBusinessSkinForm1: TbsBusinessSkinForm
    UseFormCursorInNCArea = False
    MaxMenuItemsInWindow = 0
    ClientWidth = 0
    ClientHeight = 0
    HideCaptionButtons = False
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
    DefCaptionFont.Charset = ANSI_CHARSET
    DefCaptionFont.Color = clBtnText
    DefCaptionFont.Height = -32
    DefCaptionFont.Name = 'MS Sans Serif'
    DefCaptionFont.Style = []
    DefInActiveCaptionFont.Charset = ANSI_CHARSET
    DefInActiveCaptionFont.Color = clBtnShadow
    DefInActiveCaptionFont.Height = -11
    DefInActiveCaptionFont.Name = 'MS Sans Serif'
    DefInActiveCaptionFont.Style = []
    DefMenuItemHeight = 20
    DefMenuItemFont.Charset = ANSI_CHARSET
    DefMenuItemFont.Color = clWindowText
    DefMenuItemFont.Height = -11
    DefMenuItemFont.Name = 'MS Sans Serif'
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
    Left = 334
    Top = 26
  end
end
