object MergeTableForm: TMergeTableForm
  Left = 372
  Top = 205
  ActiveControl = WorkPanel
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'MergeTable'
  ClientHeight = 233
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object WorkPanel: TbsSkinPanel
    Left = 16
    Top = 16
    Width = 430
    Height = 138
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
    UseSkinFont = False
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
    Caption = 'WorkPanel'
    object bsSkinStdLabel1: TbsSkinStdLabel
      Left = 38
      Top = 36
      Width = 161
      Height = 19
      UseSkinFont = False
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -16
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = [fsBold]
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Caption = 'From Table Number: '
      ParentFont = False
    end
    object bsSkinStdLabel2: TbsSkinStdLabel
      Left = 38
      Top = 86
      Width = 137
      Height = 19
      UseSkinFont = False
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -16
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = [fsBold]
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Caption = 'To Table Number:'
      ParentFont = False
    end
    object SourceTableButton: TbsSkinSpeedButton
      Left = 348
      Top = 30
      Width = 40
      Height = 40
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
      OnClick = SourceTableButtonClick
    end
    object TargetTableButton: TbsSkinSpeedButton
      Left = 348
      Top = 80
      Width = 40
      Height = 40
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
      OnClick = TargetTableButtonClick
    end
    object SourceTableNo: TbsSkinLabel
      Left = 204
      Top = 34
      Width = 130
      Height = 23
      TabOrder = 0
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -16
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
    object TargetTableNo: TbsSkinLabel
      Left = 204
      Top = 84
      Width = 130
      Height = 23
      TabOrder = 1
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = ANSI_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -16
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
  end
  object ConfirmButton: TXiButton
    Left = 120
    Top = 166
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
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = ConfirmButtonClick
  end
  object CancelButton: TXiButton
    Left = 248
    Top = 166
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
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = CancelButtonClick
  end
  object Query: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 6
    Top = 4
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
    Left = 40
    Top = 4
  end
end
