object TableEditForm: TTableEditForm
  Left = 362
  Top = 178
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Table Edit'
  ClientHeight = 355
  ClientWidth = 529
  Color = clNone
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object bsSkinPanel: TbsSkinPanel
    Left = 6
    Top = 6
    Width = 500
    Height = 274
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
    Caption = 'bsSkinPanel'
    object EditPanel: TPanel
      Left = 1
      Top = 1
      Width = 498
      Height = 272
      Align = alClient
      BevelOuter = bvNone
      Color = 15389375
      TabOrder = 0
      object Label1: TLabel
        Left = 22
        Top = 20
        Width = 47
        Height = 13
        Caption = 'Table No.'
      end
      object Label2: TLabel
        Left = 24
        Top = 71
        Width = 27
        Height = 13
        Caption = 'Seats'
      end
      object Label3: TLabel
        Left = 24
        Top = 96
        Width = 61
        Height = 13
        Caption = 'Table Shape'
      end
      object Label4: TLabel
        Left = 26
        Top = 126
        Width = 28
        Height = 13
        Caption = 'Width'
      end
      object Label5: TLabel
        Left = 26
        Top = 152
        Width = 31
        Height = 13
        Caption = 'Height'
      end
      object Label6: TLabel
        Left = 26
        Top = 186
        Width = 39
        Height = 13
        Caption = 'Property'
      end
      object Label7: TLabel
        Left = 24
        Top = 46
        Width = 53
        Height = 13
        Caption = 'Description'
      end
      object MinimumChargeLabel: TLabel
        Left = 26
        Top = 241
        Width = 78
        Height = 13
        Caption = 'Minimum Charge'
      end
      object TableNoEdit: TEdit
        Left = 96
        Top = 16
        Width = 129
        Height = 19
        TabOrder = 0
        OnDblClick = TableNoEditDblClick
        OnExit = TableNoEditExit
        OnKeyPress = TableNoEditKeyPress
      end
      object SeatEdit: TEdit
        Left = 96
        Top = 66
        Width = 77
        Height = 20
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnDblClick = SeatEditDblClick
        OnEnter = SeatEditEnter
        OnExit = SeatEditExit
        OnKeyDown = SeatEditKeyDown
      end
      object ShapeComboBox: TComboBox
        Left = 95
        Top = 92
        Width = 130
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 2
        TabOrder = 3
        Text = 'Rectangle'
        OnChange = ShapeComboBoxChange
        OnKeyDown = ShapeComboBoxKeyDown
        Items.Strings = (
          'Circle.'
          'Ellipse'
          'Rectangle'
          'Round Rectangle'
          'Round Square.'
          'Square'#9)
      end
      object ButtonWidthEdit: TEdit
        Left = 62
        Top = 122
        Width = 63
        Height = 20
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnDblClick = ButtonWidthEditDblClick
        OnEnter = ButtonWidthEditEnter
        OnExit = ButtonWidthEditExit
        OnKeyDown = ButtonWidthEditKeyDown
      end
      object ButtonHeightEdit: TEdit
        Left = 62
        Top = 148
        Width = 63
        Height = 20
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnDblClick = ButtonHeightEditDblClick
        OnEnter = ButtonHeightEditEnter
        OnExit = ButtonHeightEditExit
        OnKeyDown = ButtonHeightEditKeyDown
      end
      object PropertyComboBox: TComboBox
        Left = 70
        Top = 182
        Width = 77
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 6
        Text = 'Non Table'
        Items.Strings = (
          'Table'
          'Non Table')
      end
      object DescriptionEdit: TEdit
        Left = 96
        Top = 41
        Width = 129
        Height = 19
        TabOrder = 1
        OnDblClick = DescriptionEditDblClick
        OnExit = DescriptionEditExit
        OnKeyPress = DescriptionEditKeyPress
      end
      object PageComboBox: TComboBox
        Left = 26
        Top = 208
        Width = 197
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 7
      end
      object FontButton: TXiButton
        Left = 146
        Top = 120
        Width = 75
        Height = 50
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
        Caption = 'Font'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        OnClick = FontButtonClick
      end
      object LayoutPanel: TbsSkinPanel
        Left = 250
        Top = 29
        Width = 217
        Height = 200
        TabOrder = 9
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
        Caption = 'LayoutPanel'
        object TableLayout: TGButton
          Left = 81
          Top = 69
          Width = 60
          Height = 60
        end
      end
      object MinimumChargeEdit: TEdit
        Left = 111
        Top = 237
        Width = 77
        Height = 20
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnDblClick = MinimumChargeEditDblClick
        OnEnter = MinimumChargeEditEnter
        OnExit = MinimumChargeEditExit
        OnKeyDown = MinimumChargeEditKeyDown
      end
    end
  end
  object SaveButton: TXiButton
    Left = 140
    Top = 289
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
    Caption = 'Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = SaveButtonClick
  end
  object CancelButton: TXiButton
    Left = 271
    Top = 289
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
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = CancelButtonClick
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select * From TableSet')
    Left = 356
    Top = 62
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 322
    Top = 64
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
    DefCaptionFont.Style = [fsBold]
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
    Left = 286
    Top = 64
  end
end
