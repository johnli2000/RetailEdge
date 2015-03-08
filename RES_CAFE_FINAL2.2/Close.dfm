object ExitSystemForm: TExitSystemForm
  Left = 501
  Top = 218
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 381
  ClientWidth = 426
  Color = 11756644
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BackPanel: TbsSkinPanel
    Left = 1
    Top = 1
    Width = 387
    Height = 351
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
    Caption = 'BackPanel'
    object ExitButton: TXiButton
      Left = 65
      Top = 27
      Width = 250
      Height = 65
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
      Glyph.Data = {
        76020000424D7602000000000000760000002800000020000000200000000100
        0400000000000002000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FF07777777777
        7777777777777777770FFF0FF0F0F0F0F0F0F0F0F0FF0F0FF0FFFFF0FF0F0F0F
        0F0F0F0F0FF0F0FF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0000000
        000000000000000FFFFFFFFFF0F77777777777777777770FFFFFFFFFF0F77777
        777777700000770FFFFFFFFFF0F77777777777777777770FFFFFFFFFF0F77777
        777777700000770FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF000000
        00000000000000FFFFFFFFFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFFF0000
        000000000000FFFFFFFFFFFFFFF0F7777777777777770FFFFFFFFFFFFFF0F000
        0000000000070FFFFFFFFFFFFFF0F0BBBBBBBBBBBB070FFFFFFFFFFFFFF0F0BB
        BBBBBBBBBB070FFFFFFFFFFFFFF0F0BBBBBBBBBBBB070FFFFFFFFFFFFFF0F0BB
        BBBBBBBBBB070FFFFFFFFFFFFFF0F0BBBBBBBBBBBB070FFFFFFFFFFFFFF0F0BB
        BBBBBBBBBB070FFFFFFFFFFFFFF0F0BBBBBBBBBBBB070FFFFFFFFFFFFFF0F000
        0000000000070FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0000
        000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Spacing = 42
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Exit to windows'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = ExitButtonClick
    end
    object RestartButton: TXiButton
      Left = 65
      Top = 104
      Width = 250
      Height = 65
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
      Glyph.Data = {
        76020000424D7602000000000000760000002800000020000000200000000100
        0400000000000002000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FF07777777777
        7777777777777777770FFF0FF0F0F0F0F0F0F0F0F0FF0F0FF0FFFFF0FF0F0F0F
        0F0F0F0F0FF0F0FF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0000000
        000000000000000FFFFFFFFFF0F77777777777777777770FFFFFFFFFF0F77777
        777777700000770FFFFFFFFFF0F77777777777777777770FFFFFFFFFF0F77777
        777777700000770FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF000000
        00000000000000FFFFFFFFFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFFF0000
        000000000000FFFFFFFFFFFFFFF0F7777777777777770FFFFFFFFFFFFFF0F000
        0000000000070FFFFFFFFFFFFFF0F0AAAAAAAAAAAA070FFFFFFFFFFFFFF0F0AA
        AAAAAAAAAA070FFFFFFFFFFFFFF0F0AAAAAAAAAAAA070FFFFFFFFFFFFFF0F0AA
        AAAAAAAAAA070FFFFFFFFFFFFFF0F0AAAAAAAAAAAA070FFFFFFFFFFFFFF0F0AA
        AAAAAAAAAA070FFFFFFFFFFFFFF0F0AAAAAAAAAAAA070FFFFFFFFFFFFFF0F000
        0000000000070FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0000
        000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Spacing = 30
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Restart computer'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = RestartButtonClick
    end
    object ShutDownButton: TXiButton
      Left = 65
      Top = 181
      Width = 250
      Height = 65
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
      Glyph.Data = {
        76020000424D7602000000000000760000002800000020000000200000000100
        0400000000000002000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000FF07777777777
        7777777777777777770FFF0FF0F0F0F0F0F0F0F0F0FF0F0FF0FFFFF0FF0F0F0F
        0F0F0F0F0FF0F0FF0FFFFFFF0FFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0000000
        000000000000000FFFFFFFFFF0F77777777777777777770FFFFFFFFFF0F77777
        777777700000770FFFFFFFFFF0F77777777777777777770FFFFFFFFFF0F77777
        777777700000770FFFFFFFFFF0FFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF000000
        00000000000000FFFFFFFFFFFFFFFFF0000000000FFFFFFFFFFFFFFFFFFF0000
        000000000000FFFFFFFFFFFFFFF0F7777777777777770FFFFFFFFFFFFFF0F000
        0000000000070FFFFFFFFFFFFFF0F0000000000000070FFFFFFFFFFFFFF0F000
        0000000000070FFFFFFFFFFFFFF0F0000000000000070FFFFFFFFFFFFFF0F000
        0000000000070FFFFFFFFFFFFFF0F0000000000000070FFFFFFFFFFFFFF0F000
        0000000000070FFFFFFFFFFFFFF0F0000000000000070FFFFFFFFFFFFFF0F000
        0000000000070FFFFFFFFFFFFFF0FFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFF0000
        000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Spacing = 10
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Shut down computer'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = ShutDownButtonClick
    end
    object CancelButton: TXiButton
      Left = 65
      Top = 257
      Width = 250
      Height = 65
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
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333999333333399933339993333399933333399933399
        9333333339993999333333333399999333333333333999333333333333999993
        3333333339993399333333339993339993333339993333399933339993333333
        9993333333333333333333333333333333333333333333333333}
      Spacing = 10
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Cancel'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 3
      OnClick = CancelButtonClick
    end
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
    UseDefaultObjectHint = True
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
    UseDefaultSysMenu = True
    SkinData = MainForm.bsSkinData
    MinHeight = 0
    MinWidth = 0
    MaxHeight = 0
    MaxWidth = 0
    Magnetic = False
    MagneticSize = 5
    BorderIcons = []
    Left = 6
    Top = 4
  end
end
