object EditDepositForm: TEditDepositForm
  Left = 563
  Top = 319
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Deposit'
  ClientHeight = 217
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BackPanel: TbsSkinPanel
    Left = 6
    Top = 6
    Width = 505
    Height = 139
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
    object bsSkinStdLabel1: TbsSkinStdLabel
      Left = 22
      Top = 48
      Width = 67
      Height = 13
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Caption = 'Payment Date'
    end
    object bsSkinStdLabel2: TbsSkinStdLabel
      Left = 256
      Top = 48
      Width = 41
      Height = 13
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Caption = 'Operator'
    end
    object bsSkinStdLabel3: TbsSkinStdLabel
      Left = 22
      Top = 78
      Width = 75
      Height = 13
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Caption = 'Deposit Amount'
    end
    object bsSkinStdLabel4: TbsSkinStdLabel
      Left = 22
      Top = 108
      Width = 53
      Height = 13
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinDataName = 'stdlabel'
      Caption = 'Description'
    end
    object bsSkinStdLabel5: TbsSkinStdLabel
      Left = 22
      Top = 18
      Width = 66
      Height = 13
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Caption = 'V.I.P. Number'
    end
    object VIPNoButton: TbsSkinSpeedButton
      Left = 202
      Top = 12
      Width = 35
      Height = 25
      SkinData = MainForm.bsSkinData
      SkinDataName = 'toolbutton'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
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
      OnClick = VIPNoButtonClick
    end
    object bsSkinStdLabel6: TbsSkinStdLabel
      Left = 260
      Top = 78
      Width = 36
      Height = 13
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Caption = 'Method'
    end
    object MethodButton: TbsSkinSpeedButton
      Left = 448
      Top = 72
      Width = 35
      Height = 25
      SkinData = MainForm.bsSkinData
      SkinDataName = 'toolbutton'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
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
      OnClick = MethodButtonClick
    end
    object DepositAmountButton: TbsSkinSpeedButton
      Left = 202
      Top = 72
      Width = 35
      Height = 25
      SkinData = MainForm.bsSkinData
      SkinDataName = 'toolbutton'
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
      OnClick = DepositAmountEditClick
    end
    object DescriptionButton: TbsSkinSpeedButton
      Left = 448
      Top = 102
      Width = 37
      Height = 25
      SkinData = MainForm.bsSkinData
      SkinDataName = 'toolbutton'
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
      OnClick = DescriptionEditClick
    end
    object DateEdit: TbsSkinLabel
      Left = 110
      Top = 44
      Width = 133
      Height = 21
      TabOrder = 0
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taCenter
      Caption = '12/12/2007 hh:mm:ss'
      AutoSize = False
    end
    object OperatorEdit: TbsSkinLabel
      Left = 303
      Top = 44
      Width = 180
      Height = 21
      TabOrder = 1
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taCenter
      Caption = 'OperatorEdit'
      AutoSize = False
    end
    object DepositAmountEdit: TbsSkinLabel
      Left = 110
      Top = 74
      Width = 90
      Height = 21
      TabOrder = 2
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -13
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taCenter
      AutoSize = False
      OnClick = DepositAmountEditClick
    end
    object DescriptionEdit: TbsSkinLabel
      Left = 110
      Top = 104
      Width = 335
      Height = 21
      TabOrder = 3
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Caption = 'DescriptionEdit'
      AutoSize = False
      OnClick = DescriptionEditClick
    end
    object VIPNoEdit: TbsSkinLabel
      Left = 110
      Top = 14
      Width = 90
      Height = 21
      TabOrder = 4
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taCenter
      AutoSize = False
    end
    object VIPNameEdit: TbsSkinLabel
      Left = 242
      Top = 14
      Width = 241
      Height = 21
      TabOrder = 5
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      AutoSize = False
    end
    object MethodEdit: TbsSkinLabel
      Left = 304
      Top = 74
      Width = 141
      Height = 21
      TabOrder = 6
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = False
      UseSkinSize = False
      BorderStyle = bvFrame
      Alignment = taCenter
      Caption = 'CASH'
      AutoSize = False
    end
  end
  object ConfirmButton: TXiButton
    Left = 144
    Top = 154
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
    TabOrder = 1
    OnClick = ConfirmButtonClick
  end
  object CancelButton: TXiButton
    Left = 276
    Top = 154
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
    TabOrder = 2
    OnClick = CancelButtonClick
  end
  object Query: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 56
    Top = 156
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
    Left = 16
    Top = 152
  end
end
