object SplitBillForm: TSplitBillForm
  Left = 239
  Top = 56
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Split Bill'
  ClientHeight = 779
  ClientWidth = 1028
  Color = clBlack
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BackPanel: TbsSkinPanel
    Left = 20
    Top = 12
    Width = 1024
    Height = 768
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
    object SourceStringGridPanel: TbsSkinPanel
      Left = 10
      Top = 10
      Width = 437
      Height = 605
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
      Caption = 'SourceStringGridPanel'
      object SourceStringGrid: TStringGrid
        Left = 1
        Top = 1
        Width = 435
        Height = 603
        Align = alClient
        BorderStyle = bsNone
        ColCount = 9
        DefaultRowHeight = 20
        FixedColor = 15389375
        FixedCols = 0
        RowCount = 501
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect]
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        OnDrawCell = StringGridDrawCell
        ColWidths = (
          41
          276
          51
          44
          64
          64
          64
          64
          64)
      end
    end
    object TargetStringGridPanel: TbsSkinPanel
      Left = 576
      Top = 10
      Width = 437
      Height = 605
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
      Caption = 'TargetStringGridPanel'
      object TargetStringGrid: TStringGrid
        Left = 1
        Top = 1
        Width = 435
        Height = 603
        Align = alClient
        BorderStyle = bsNone
        ColCount = 9
        DefaultRowHeight = 20
        FixedColor = 15389375
        FixedCols = 0
        RowCount = 501
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRowSelect]
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        OnDrawCell = StringGridDrawCell
        ColWidths = (
          39
          280
          51
          43
          64
          64
          64
          64
          64)
      end
    end
    object OneMoveToRightButton: TXiButton
      Left = 470
      Top = 32
      Width = 80
      Height = 70
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
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = OneMoveToRightButtonClick
    end
    object AllMoveToRightButton: TXiButton
      Left = 470
      Top = 106
      Width = 80
      Height = 70
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
      Caption = '>>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = AllMoveToRightButtonClick
    end
    object QtyMoveToRightbutton: TXiButton
      Left = 470
      Top = 180
      Width = 80
      Height = 70
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
      Caption = 'X.X >'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = QtyMoveToRightbuttonClick
    end
    object SplitButton: TXiButton
      Left = 470
      Top = 254
      Width = 80
      Height = 70
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
      Caption = '----'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = SplitButtonClick
    end
    object OneMoveToLeftButton: TXiButton
      Left = 470
      Top = 328
      Width = 80
      Height = 70
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
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = OneMoveToLeftButtonClick
    end
    object AllMoveToLeftButton: TXiButton
      Left = 470
      Top = 402
      Width = 80
      Height = 70
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
      Caption = '<<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = AllMoveToLeftButtonClick
    end
    object TotalPanel: TbsSkinPanel
      Left = 10
      Top = 617
      Width = 1003
      Height = 48
      TabOrder = 8
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
        Left = 109
        Top = 17
        Width = 43
        Height = 13
        UseSkinFont = False
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -11
        DefaultFont.Name = 'MS Sans Serif'
        DefaultFont.Style = [fsBold]
        SkinData = MainForm.bsSkinData
        SkinDataName = 'stdlabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Caption = 'Amount'
        ParentFont = False
      end
      object bsSkinStdLabel2: TbsSkinStdLabel
        Left = 751
        Top = 17
        Width = 65
        Height = 13
        UseSkinFont = False
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -11
        DefaultFont.Name = 'MS Sans Serif'
        DefaultFont.Style = [fsBold]
        SkinData = MainForm.bsSkinData
        SkinDataName = 'stdlabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Caption = 'Receivable'
        ParentFont = False
      end
      object TotalAmount: TbsSkinLabel
        Left = 162
        Top = 14
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
        Caption = 'TotalAmount'
        AutoSize = False
      end
      object SubTotalAmount: TbsSkinLabel
        Left = 826
        Top = 14
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
        Caption = 'SubTotalAmount'
        AutoSize = False
      end
    end
    object SourceUpButton: TXiButton
      Left = 26
      Top = 674
      Width = 100
      Height = 80
      ColorFace = 16772829
      ColorGrad = 16758380
      ColorDark = 16754769
      ColorLight = 16772313
      ColorBorder = 11753728
      ColorText = clBlack
      OverColorFace = 16772055
      OverColorGrad = 16753478
      OverColorDark = 16752190
      OverColorLight = 16770250
      OverColorBorder = 11753728
      OverColorText = clBlack
      DownColorFace = 16757606
      DownColorGrad = 16764573
      DownColorDark = 16765864
      DownColorLight = 16752190
      DownColorBorder = 11753728
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 16755027
      ColorScheme = csNeoSky
      Ctl3D = True
      Layout = blGlyphLeft
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        33333333330E033333333333330E033333333333330E033333333333330E0333
        33333333330E033333333330000E000033333330EEEEEEE0333333330EEEEE03
        333333330EEEEE033333333330EEE0333333333330EEE03333333333330E0333
        33333333330E0333333333333330333333333333333033333333}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      TabOrder = 9
      OnClick = SourceUpButtonClick
    end
    object DownButton: TXiButton
      Left = 132
      Top = 674
      Width = 100
      Height = 80
      ColorFace = 16772829
      ColorGrad = 16758380
      ColorDark = 16754769
      ColorLight = 16772313
      ColorBorder = 11753728
      ColorText = clBlack
      OverColorFace = 16772055
      OverColorGrad = 16753478
      OverColorDark = 16752190
      OverColorLight = 16770250
      OverColorBorder = 11753728
      OverColorText = clBlack
      DownColorFace = 16757606
      DownColorGrad = 16764573
      DownColorDark = 16765864
      DownColorLight = 16752190
      DownColorBorder = 11753728
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 16755027
      ColorScheme = csNeoSky
      Ctl3D = True
      Layout = blGlyphLeft
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333330333333333333330E033333333333330E03333333333330EEE033
        3333333330EEE033333333330EEEEE03333333330EEEEE0333333330EEEEEEE0
        33333330000E000033333333330E033333333333330E033333333333330E0333
        33333333330E033333333333330E033333333333330003333333}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      TabOrder = 10
      OnClick = SourceDownButtonClick
    end
    object ConvertButton: TXiButton
      Left = 248
      Top = 674
      Width = 100
      Height = 80
      ColorFace = 16772829
      ColorGrad = 16758380
      ColorDark = 16754769
      ColorLight = 16772313
      ColorBorder = 11753728
      ColorText = clBlack
      OverColorFace = 16772055
      OverColorGrad = 16753478
      OverColorDark = 16752190
      OverColorLight = 16770250
      OverColorBorder = 11753728
      OverColorText = clBlack
      DownColorFace = 16757606
      DownColorGrad = 16764573
      DownColorDark = 16765864
      DownColorLight = 16752190
      DownColorBorder = 11753728
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 16755027
      ColorScheme = csNeoSky
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Convert'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      OnClick = ConvertButtonClick
    end
    object PrintInvoiceButton: TXiButton
      Left = 354
      Top = 674
      Width = 100
      Height = 80
      ColorFace = 16772829
      ColorGrad = 16758380
      ColorDark = 16754769
      ColorLight = 16772313
      ColorBorder = 11753728
      ColorText = clBlack
      OverColorFace = 16772055
      OverColorGrad = 16753478
      OverColorDark = 16752190
      OverColorLight = 16770250
      OverColorBorder = 11753728
      OverColorText = clBlack
      DownColorFace = 16757606
      DownColorGrad = 16764573
      DownColorDark = 16765864
      DownColorLight = 16752190
      DownColorBorder = 11753728
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 16755027
      ColorScheme = csNeoSky
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Print Invoice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnClick = PrintInvoiceButtonClick
    end
    object PrintOrderButton: TXiButton
      Left = 460
      Top = 674
      Width = 100
      Height = 80
      ColorFace = 16772829
      ColorGrad = 16758380
      ColorDark = 16754769
      ColorLight = 16772313
      ColorBorder = 11753728
      ColorText = clBlack
      OverColorFace = 16772055
      OverColorGrad = 16753478
      OverColorDark = 16752190
      OverColorLight = 16770250
      OverColorBorder = 11753728
      OverColorText = clBlack
      DownColorFace = 16757606
      DownColorGrad = 16764573
      DownColorDark = 16765864
      DownColorLight = 16752190
      DownColorBorder = 11753728
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 16755027
      ColorScheme = csNeoSky
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Print Bill'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      OnClick = PrintOrderButtonClick
    end
    object PaymentButton: TXiButton
      Left = 566
      Top = 674
      Width = 100
      Height = 80
      ColorFace = 16772829
      ColorGrad = 16758380
      ColorDark = 16754769
      ColorLight = 16772313
      ColorBorder = 11753728
      ColorText = clBlack
      OverColorFace = 16772055
      OverColorGrad = 16753478
      OverColorDark = 16752190
      OverColorLight = 16770250
      OverColorBorder = 11753728
      OverColorText = clBlack
      DownColorFace = 16757606
      DownColorGrad = 16764573
      DownColorDark = 16765864
      DownColorLight = 16752190
      DownColorBorder = 11753728
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 16755027
      ColorScheme = csNeoSky
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Payment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      OnClick = PaymentButtonClick
    end
    object ExitButton: TXiButton
      Left = 672
      Top = 674
      Width = 100
      Height = 80
      ColorFace = 16772829
      ColorGrad = 16758380
      ColorDark = 16754769
      ColorLight = 16772313
      ColorBorder = 11753728
      ColorText = clBlack
      OverColorFace = 16772055
      OverColorGrad = 16753478
      OverColorDark = 16752190
      OverColorLight = 16770250
      OverColorBorder = 11753728
      OverColorText = clBlack
      DownColorFace = 16757606
      DownColorGrad = 16764573
      DownColorDark = 16765864
      DownColorLight = 16752190
      DownColorBorder = 11753728
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 16755027
      ColorScheme = csNeoSky
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
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
      OnClick = ExitButtonClick
    end
    object TargetUpButton: TXiButton
      Left = 790
      Top = 674
      Width = 100
      Height = 80
      ColorFace = 16772829
      ColorGrad = 16758380
      ColorDark = 16754769
      ColorLight = 16772313
      ColorBorder = 11753728
      ColorText = clBlack
      OverColorFace = 16772055
      OverColorGrad = 16753478
      OverColorDark = 16752190
      OverColorLight = 16770250
      OverColorBorder = 11753728
      OverColorText = clBlack
      DownColorFace = 16757606
      DownColorGrad = 16764573
      DownColorDark = 16765864
      DownColorLight = 16752190
      DownColorBorder = 11753728
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 16755027
      ColorScheme = csNeoSky
      Ctl3D = True
      Layout = blGlyphLeft
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        33333333330E033333333333330E033333333333330E033333333333330E0333
        33333333330E033333333330000E000033333330EEEEEEE0333333330EEEEE03
        333333330EEEEE033333333330EEE0333333333330EEE03333333333330E0333
        33333333330E0333333333333330333333333333333033333333}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      TabOrder = 16
      OnClick = TargetUpButtonClick
    end
    object TargetDownButton: TXiButton
      Left = 896
      Top = 674
      Width = 100
      Height = 80
      ColorFace = 16772829
      ColorGrad = 16758380
      ColorDark = 16754769
      ColorLight = 16772313
      ColorBorder = 11753728
      ColorText = clBlack
      OverColorFace = 16772055
      OverColorGrad = 16753478
      OverColorDark = 16752190
      OverColorLight = 16770250
      OverColorBorder = 11753728
      OverColorText = clBlack
      DownColorFace = 16757606
      DownColorGrad = 16764573
      DownColorDark = 16765864
      DownColorLight = 16752190
      DownColorBorder = 11753728
      DownColorText = clBlack
      DisabledColorFace = 15658734
      DisabledColorGrad = clWhite
      DisabledColorDark = 13816530
      DisabledColorLight = clWhite
      DisabledColorBorder = clGray
      DisabledColorText = clGray
      ColorFocusRect = 16755027
      ColorScheme = csNeoSky
      Ctl3D = True
      Layout = blGlyphLeft
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333330333333333333330E033333333333330E03333333333330EEE033
        3333333330EEE033333333330EEEEE03333333330EEEEE0333333330EEEEEEE0
        33333330000E000033333333330E033333333333330E033333333333330E0333
        33333333330E033333333333330E033333333333330003333333}
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      TabOrder = 17
      OnClick = TargetDownButtonClick
    end
  end
  object Query: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 130
    Top = 32
  end
end
