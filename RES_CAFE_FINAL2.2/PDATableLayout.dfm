object PDATableLayoutForm: TPDATableLayoutForm
  Left = 416
  Top = 182
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'PDA Table Button Layout Setup'
  ClientHeight = 477
  ClientWidth = 640
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridPanel: TbsSkinPanel
    Left = 374
    Top = 6
    Width = 251
    Height = 409
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
    Caption = 'DBGridPanel'
    object DBGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 249
      Height = 407
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
      FixedColor = 15389375
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgRowSelect]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      OnMouseMove = PanelMouseMove
      Columns = <
        item
          Expanded = False
          FieldName = 'TableNo'
          Title.Alignment = taCenter
          Title.Caption = 'Table No.'
          Width = 218
          Visible = True
        end>
    end
  end
  object TabControl: TbsSkinTabControl
    Left = 6
    Top = 6
    Width = 364
    Height = 461
    Font.Charset = ANSI_CHARSET
    Font.Color = clBtnText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabHeight = 24
    TabOrder = 1
    Tabs.Strings = (
      'Page 1'
      'Page 2'
      'Page 3'
      'Page 4'
      'Page 5'
      'Page 6'
      'Page 7'
      'Page 8'
      'Page 9'
      'Page 10'
      'Page 11'
      'Page 12'
      'Page 13'
      'Page 14'
      'Page 15'
      'Page 16'
      'Page 17'
      'Page 18'
      'Page 19'
      'Page 20')
    TabIndex = 0
    TabWidth = 65
    OnChange = TabControlChange
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clBtnText
    DefaultFont.Height = -11
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    UseSkinFont = False
    DefaultItemHeight = 20
    SkinData = MainForm.bsSkinData
    SkinDataName = 'tab'
    object Table1: TPanelButton
      Left = 10
      Top = 32
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Caption = '1'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table2: TPanelButton
      Left = 96
      Top = 32
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table3: TPanelButton
      Left = 182
      Top = 32
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table4: TPanelButton
      Left = 268
      Top = 32
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table5: TPanelButton
      Left = 10
      Top = 74
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table6: TPanelButton
      Left = 96
      Top = 74
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table7: TPanelButton
      Left = 182
      Top = 74
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table8: TPanelButton
      Left = 268
      Top = 74
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table9: TPanelButton
      Left = 10
      Top = 116
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table10: TPanelButton
      Left = 96
      Top = 116
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table11: TPanelButton
      Left = 182
      Top = 116
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table12: TPanelButton
      Left = 268
      Top = 116
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table13: TPanelButton
      Left = 10
      Top = 158
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table14: TPanelButton
      Left = 96
      Top = 158
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table15: TPanelButton
      Left = 182
      Top = 158
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table16: TPanelButton
      Left = 268
      Top = 158
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table17: TPanelButton
      Left = 10
      Top = 200
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table18: TPanelButton
      Left = 96
      Top = 200
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 17
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table19: TPanelButton
      Left = 182
      Top = 200
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 18
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table20: TPanelButton
      Left = 268
      Top = 200
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 19
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table21: TPanelButton
      Left = 10
      Top = 242
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 20
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table22: TPanelButton
      Left = 96
      Top = 242
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 21
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table23: TPanelButton
      Left = 182
      Top = 242
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 22
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table24: TPanelButton
      Left = 268
      Top = 242
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 23
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table25: TPanelButton
      Left = 10
      Top = 284
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 24
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table26: TPanelButton
      Left = 96
      Top = 284
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 25
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table27: TPanelButton
      Left = 182
      Top = 284
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 26
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table28: TPanelButton
      Left = 268
      Top = 284
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 27
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table29: TPanelButton
      Left = 10
      Top = 326
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 28
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table30: TPanelButton
      Left = 96
      Top = 326
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 29
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table31: TPanelButton
      Left = 182
      Top = 326
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 30
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table32: TPanelButton
      Left = 268
      Top = 326
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 31
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table33: TPanelButton
      Left = 10
      Top = 368
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 32
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table34: TPanelButton
      Left = 96
      Top = 368
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 33
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table35: TPanelButton
      Left = 182
      Top = 368
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 34
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table36: TPanelButton
      Left = 268
      Top = 368
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 35
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table37: TPanelButton
      Left = 10
      Top = 410
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 36
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table38: TPanelButton
      Left = 96
      Top = 410
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 37
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table39: TPanelButton
      Left = 182
      Top = 410
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 38
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
    object Table40: TPanelButton
      Left = 268
      Top = 410
      Width = 85
      Height = 40
      Color = clSilver
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBtnText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 39
      OnClick = TableButtonClick
      OnMouseMove = PanelMouseMove
    end
  end
  object ExitButton: TXiButton
    Left = 503
    Top = 424
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
    TabOrder = 2
    OnClick = ExitButtonClick
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
    DefCaptionFont.Charset = ANSI_CHARSET
    DefCaptionFont.Color = clBtnText
    DefCaptionFont.Height = -11
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
    Left = 86
    Top = 80
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 26
    Top = 78
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select TableNo, PDAPosition From TableSet'
      'Order By PDAPosition, TableNo')
    Left = 54
    Top = 80
    object QueryTableNo: TStringField
      DisplayWidth = 30
      FieldName = 'TableNo'
      Size = 10
    end
    object QueryPDAPosition: TIntegerField
      FieldName = 'PDAPosition'
    end
  end
end
