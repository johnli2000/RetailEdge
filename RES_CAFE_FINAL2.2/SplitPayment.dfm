object SplitPaymentForm: TSplitPaymentForm
  Left = 377
  Top = 213
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Payment'
  ClientHeight = 379
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TotalPanel: TbsSkinPanel
    Left = 10
    Top = 10
    Width = 324
    Height = 164
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
    Caption = 'TotalPanel'
    object bsSkinStdLabel1: TbsSkinStdLabel
      Left = 40
      Top = 14
      Width = 64
      Height = 16
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -13
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Caption = 'Order No'
      ParentFont = False
    end
    object bsSkinStdLabel2: TbsSkinStdLabel
      Left = 40
      Top = 38
      Width = 52
      Height = 16
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -13
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Caption = 'Amount'
      ParentFont = False
    end
    object bsSkinStdLabel3: TbsSkinStdLabel
      Left = 40
      Top = 62
      Width = 67
      Height = 16
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -13
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Caption = 'Rounding'
      ParentFont = False
    end
    object bsSkinStdLabel4: TbsSkinStdLabel
      Left = 40
      Top = 86
      Width = 81
      Height = 16
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -13
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Caption = 'Receivable'
      ParentFont = False
    end
    object bsSkinStdLabel5: TbsSkinStdLabel
      Left = 40
      Top = 108
      Width = 90
      Height = 16
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -13
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Caption = 'Bank Charge'
      ParentFont = False
    end
    object bsSkinStdLabel6: TbsSkinStdLabel
      Left = 40
      Top = 134
      Width = 32
      Height = 16
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -13
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Caption = 'Tips'
      ParentFont = False
    end
    object TipsButton: TbsSkinSpeedButton
      Left = 246
      Top = 127
      Width = 40
      Height = 25
      SkinData = MainForm.bsSkinData
      SkinDataName = 'button'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      ImageIndex = 0
      RepeatMode = False
      RepeatInterval = 100
      Transparent = False
      Flat = False
      AllowAllUp = False
      Down = False
      GroupIndex = 0
      ShowCaption = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
        333333333373F3333333333330F033333333333337373F33333333330FFF0333
        33333333733F73F333333330F80FF033333333373373373F3333330F80F7FF03
        33333373373F3F73F33330F70F0F0FF03333373F737373F73F33330F77F7F0FF
        03333373F33F373F73F33330F70F0F0FF03333373F737373373F33330F77F7F7
        FF03333373F33F3F3F73333330F70F0F07F03333373F737373373333330F77FF
        7F0333333373F33F337333333330F707F033333333373F733733333333330F7F
        03333333333373F373F33333333330F0303333F3F3F3F73737F3303030303303
        3033373737373F7FF73303030303000003337373737377777333}
      NumGlyphs = 2
      Spacing = 1
      OnClick = TipsEditClick
    end
    object OrderNoEdit: TbsSkinLabel
      Left = 138
      Top = 10
      Width = 100
      Height = 21
      TabOrder = 0
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -19
      DefaultFont.Name = 'MS Serif'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taRightJustify
      AutoSize = False
    end
    object AmountEdit: TbsSkinLabel
      Left = 138
      Top = 34
      Width = 100
      Height = 21
      TabOrder = 1
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -19
      DefaultFont.Name = 'MS Serif'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taRightJustify
      AutoSize = False
    end
    object RoundingEdit: TbsSkinLabel
      Left = 138
      Top = 58
      Width = 100
      Height = 21
      TabOrder = 2
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -19
      DefaultFont.Name = 'MS Serif'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taRightJustify
      AutoSize = False
    end
    object ReceivableEdit: TbsSkinLabel
      Left = 138
      Top = 82
      Width = 100
      Height = 21
      TabOrder = 3
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -19
      DefaultFont.Name = 'MS Serif'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taRightJustify
      AutoSize = False
    end
    object SurchargeEdit: TbsSkinLabel
      Left = 138
      Top = 106
      Width = 100
      Height = 21
      TabOrder = 4
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -19
      DefaultFont.Name = 'MS Serif'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taRightJustify
      AutoSize = False
    end
    object TipsEdit: TbsSkinLabel
      Left = 118
      Top = 131
      Width = 120
      Height = 21
      TabOrder = 5
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -19
      DefaultFont.Name = 'MS Serif'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taRightJustify
      AutoSize = False
      OnClick = TipsEditClick
    end
  end
  object DataPanel: TbsSkinPanel
    Left = 10
    Top = 175
    Width = 324
    Height = 83
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
    Caption = 'DataPanel'
    object bsSkinStdLabel7: TbsSkinStdLabel
      Left = 40
      Top = 16
      Width = 52
      Height = 16
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -13
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Caption = 'Method'
      ParentFont = False
    end
    object bsSkinStdLabel8: TbsSkinStdLabel
      Left = 40
      Top = 50
      Width = 61
      Height = 16
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -13
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Caption = 'Payment'
      ParentFont = False
    end
    object MethodButton: TbsSkinSpeedButton
      Left = 246
      Top = 10
      Width = 40
      Height = 25
      SkinData = MainForm.bsSkinData
      SkinDataName = 'button'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      ImageIndex = 0
      RepeatMode = False
      RepeatInterval = 100
      Transparent = False
      Flat = False
      AllowAllUp = False
      Down = False
      GroupIndex = 0
      ShowCaption = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
        333333333373F3333333333330F033333333333337373F33333333330FFF0333
        33333333733F73F333333330F80FF033333333373373373F3333330F80F7FF03
        33333373373F3F73F33330F70F0F0FF03333373F737373F73F33330F77F7F0FF
        03333373F33F373F73F33330F70F0F0FF03333373F737373373F33330F77F7F7
        FF03333373F33F3F3F73333330F70F0F07F03333373F737373373333330F77FF
        7F0333333373F33F337333333330F707F033333333373F733733333333330F7F
        03333333333373F373F33333333330F0303333F3F3F3F73737F3303030303303
        3033373737373F7FF73303030303000003337373737377777333}
      NumGlyphs = 2
      Spacing = 1
      OnClick = PayByEditClick
    end
    object PaymentButton: TbsSkinSpeedButton
      Left = 246
      Top = 44
      Width = 40
      Height = 25
      SkinData = MainForm.bsSkinData
      SkinDataName = 'button'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      WidthWithCaption = 0
      WidthWithoutCaption = 0
      ImageIndex = 0
      RepeatMode = False
      RepeatInterval = 100
      Transparent = False
      Flat = False
      AllowAllUp = False
      Down = False
      GroupIndex = 0
      ShowCaption = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
        333333333373F3333333333330F033333333333337373F33333333330FFF0333
        33333333733F73F333333330F80FF033333333373373373F3333330F80F7FF03
        33333373373F3F73F33330F70F0F0FF03333373F737373F73F33330F77F7F0FF
        03333373F33F373F73F33330F70F0F0FF03333373F737373373F33330F77F7F7
        FF03333373F33F3F3F73333330F70F0F07F03333373F737373373333330F77FF
        7F0333333373F33F337333333330F707F033333333373F733733333333330F7F
        03333333333373F373F33333333330F0303333F3F3F3F73737F3303030303303
        3033373737373F7FF73303030303000003337373737377777333}
      NumGlyphs = 2
      Spacing = 1
      OnClick = PaymentEditClick
    end
    object PayByEdit: TbsSkinLabel
      Left = 118
      Top = 14
      Width = 120
      Height = 21
      TabOrder = 0
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -19
      DefaultFont.Name = 'MS Serif'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taRightJustify
      AutoSize = False
      OnClick = PayByEditExit
    end
    object PaymentEdit: TbsSkinLabel
      Left = 118
      Top = 48
      Width = 120
      Height = 21
      TabOrder = 1
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -19
      DefaultFont.Name = 'MS Serif'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taRightJustify
      AutoSize = False
      OnClick = PaymentEditClick
    end
  end
  object BalancePanel: TbsSkinPanel
    Left = 10
    Top = 259
    Width = 324
    Height = 51
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
    Caption = 'BalancePanel'
    object BalanceLabel: TbsSkinStdLabel
      Left = 69
      Top = 16
      Width = 58
      Height = 16
      UseSkinFont = True
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -13
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Alignment = taRightJustify
      Caption = 'Balance'
      ParentFont = False
    end
    object ChangeEdit: TbsSkinLabel
      Left = 134
      Top = 14
      Width = 120
      Height = 21
      TabOrder = 0
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -19
      DefaultFont.Name = 'MS Serif'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taRightJustify
      AutoSize = False
    end
  end
  object ConfirmButton: TXiButton
    Left = 56
    Top = 319
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
    TabOrder = 3
    OnClick = ConfirmButtonClick
  end
  object CancelButton: TXiButton
    Left = 184
    Top = 319
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
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = CancelButtonClick
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
    UseSkinFontInMenu = True
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
    Left = 668
    Top = 34
  end
end
