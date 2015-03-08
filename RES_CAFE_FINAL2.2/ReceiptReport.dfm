object ReceiptReportForm: TReceiptReportForm
  Left = 391
  Top = 177
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Payment Receive Report'
  ClientHeight = 398
  ClientWidth = 439
  Color = 15389375
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DetailPanel: TbsSkinPanel
    Left = 7
    Top = 8
    Width = 291
    Height = 273
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
    Caption = 'DetailPanel'
    object Label1: TLabel
      Left = 28
      Top = 220
      Width = 67
      Height = 13
      Caption = 'Total Receive'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 28
      Top = 246
      Width = 82
      Height = 13
      Caption = 'Rounding Benefit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ReceiveEdit: TStaticText
      Left = 134
      Top = 218
      Width = 115
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 0
    end
    object RoundingEdit: TStaticText
      Left = 134
      Top = 244
      Width = 115
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 2
    end
    object DBGridPanel: TbsSkinPanel
      Left = 11
      Top = 10
      Width = 267
      Height = 200
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
      Caption = 'DBGridPanel'
      object DBGrid: TDBGrid
        Left = 1
        Top = 1
        Width = 265
        Height = 198
        Align = alClient
        BorderStyle = bsNone
        DataSource = DataSource
        FixedColor = 15389375
        Options = [dgTitles, dgIndicator, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGridDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'PayBy'
            Title.Caption = 'Method'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Amount'
            Title.Alignment = taRightJustify
            Width = 83
            Visible = True
          end>
      end
    end
  end
  object ControlPanel: TbsSkinPanel
    Left = 7
    Top = 283
    Width = 291
    Height = 96
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
    object Label5: TLabel
      Left = 14
      Top = 14
      Width = 26
      Height = 13
      Caption = 'Date:'
    end
    object Label6: TLabel
      Left = 152
      Top = 14
      Width = 13
      Height = 13
      Caption = 'To'
    end
    object DateEdit1: TMaskEdit
      Left = 46
      Top = 10
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnClick = DateEditClick
      OnExit = DateEdit1Exit
      OnKeyDown = DateEdit1KeyDown
    end
    object TimeEdit1: TMaskEdit
      Left = 114
      Top = 10
      Width = 33
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 1
      Text = '  :  '
      OnClick = TimeEditClick
      OnKeyDown = TimeEdit1KeyDown
    end
    object DateEdit2: TMaskEdit
      Left = 172
      Top = 10
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnClick = DateEditClick
      OnExit = DateEdit2Exit
      OnKeyDown = DateEdit2KeyDown
    end
    object TimeEdit2: TMaskEdit
      Left = 240
      Top = 10
      Width = 33
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      TabOrder = 3
      Text = '  :  '
      OnClick = TimeEditClick
      OnKeyDown = TimeEdit2KeyDown
    end
    object OperatorCheckBox: TCheckBox
      Left = 14
      Top = 38
      Width = 63
      Height = 17
      Caption = 'Operator'
      TabOrder = 4
      OnClick = OperatorCheckBoxClick
    end
    object ComboBox: TComboBox
      Left = 80
      Top = 36
      Width = 195
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
    end
    object SalesComboBox: TComboBox
      Left = 14
      Top = 64
      Width = 261
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 6
      Items.Strings = (
        'List All'
        'Table Service'
        'Quick Service'
        'Phone Order')
    end
  end
  object SearchButton: TXiButton
    Left = 312
    Top = 40
    Width = 100
    Height = 100
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
    Caption = 'Search'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = SearchButtonClick
  end
  object PrintButton: TXiButton
    Left = 312
    Top = 148
    Width = 100
    Height = 100
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
    Caption = 'Print'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = PrintButtonClick
  end
  object ExitButton: TXiButton
    Left = 312
    Top = 256
    Width = 100
    Height = 100
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
    TabOrder = 4
    OnClick = ExitButtonClick
  end
  object DataSource: TDataSource
    DataSet = ReceiveQuery
    Left = 8
    Top = 178
  end
  object Query: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 72
    Top = 178
  end
  object ReceiveQuery: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select PayBy, Sum(PaidAmount) As Amount From RecvAcct'
      'Group By PayBy Order By PayBy'
      '')
    Left = 40
    Top = 178
    object ReceiveQueryPayBy: TStringField
      FieldName = 'PayBy'
      Size = 25
    end
    object ReceiveQueryAmount: TFloatField
      FieldName = 'Amount'
      ReadOnly = True
    end
  end
  object bsBusinessSkinForm1: TbsBusinessSkinForm
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
    Left = 104
    Top = 180
  end
end
