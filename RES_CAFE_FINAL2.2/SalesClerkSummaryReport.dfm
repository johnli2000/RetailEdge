object SalesClerkSummaryReportForm: TSalesClerkSummaryReportForm
  Left = 449
  Top = 185
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Sales Summary Report (Clerks)'
  ClientHeight = 399
  ClientWidth = 605
  Color = 15389375
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridPanel: TbsSkinPanel
    Left = 6
    Top = 6
    Width = 580
    Height = 279
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
    Caption = 'DBGridPanel'
    object DBGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 578
      Height = 277
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColLines]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'OpName'
          Title.Alignment = taCenter
          Title.Caption = 'Clerk Name'
          Width = 242
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Amount'
          Title.Alignment = taCenter
          Title.Caption = 'Sales Amount'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WorkHours'
          Title.Alignment = taCenter
          Title.Caption = 'Work Hours'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HourlySales'
          Title.Alignment = taCenter
          Title.Caption = 'Sales/Hour'
          Width = 90
          Visible = True
        end>
    end
  end
  object bsSkinPanel1: TbsSkinPanel
    Left = 6
    Top = 287
    Width = 580
    Height = 44
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
    Caption = 'bsSkinPanel1'
    object Label1: TLabel
      Left = 15
      Top = 16
      Width = 23
      Height = 13
      Caption = 'Date'
      Color = clBtnFace
      ParentColor = False
    end
    object Label2: TLabel
      Left = 153
      Top = 16
      Width = 13
      Height = 13
      Caption = 'To'
      Color = clBtnFace
      ParentColor = False
    end
    object DateEdit1: TMaskEdit
      Left = 44
      Top = 13
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 0
      Text = '  /  /    '
      OnClick = DateEditClick
    end
    object DateEdit2: TMaskEdit
      Left = 173
      Top = 13
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 2
      Text = '  /  /    '
      OnClick = DateEditClick
    end
    object SortComboBox: TComboBox
      Left = 292
      Top = 11
      Width = 130
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      Text = 'Sort by Clerk Name'
      Items.Strings = (
        'Sort by Clerk Name'
        'Sort by Amount')
    end
    object AscendingComboBox: TComboBox
      Left = 431
      Top = 11
      Width = 131
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 5
      Text = 'Sort by ascending'
      Visible = False
      Items.Strings = (
        'Sort by ascending'
        'Sort by descending')
    end
    object TimeEdit1: TMaskEdit
      Left = 113
      Top = 13
      Width = 34
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 1
      Text = '  :  '
    end
    object TimeEdit2: TMaskEdit
      Left = 242
      Top = 13
      Width = 34
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 3
      Text = '  :  '
    end
  end
  object SearchButton: TXiButton
    Left = 40
    Top = 340
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
    Left = 148
    Top = 340
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
    Left = 451
    Top = 340
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
    TabOrder = 4
    OnClick = ExitButtonClick
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    OnCalcFields = QueryCalcFields
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select MenuGroupTable.Code, MenuGroupTable.Description,'
      
        '       Sum(OrderI.Price * (1 - OrderI.Discount / 100) * Qty) As ' +
        'Amount'
      'From MenuGroupTable, MenuItem, Category, OrderH, OrderI'
      'Where MenuGroupTable.Code=Category.MenuGroupCode and'
      
        '      MenuItem.ItemCode=OrderI.ItemCode and OrderI.OrderNo=Order' +
        'H.OrderNo'
      'Group By MenuGroupTable.Code, MenuGroupTable.Description'
      'Order By MenuGroupTable.Code'
      '')
    Left = 26
    Top = 60
    object QueryOpName: TStringField
      FieldName = 'OpName'
    end
    object QueryAmount: TFloatField
      FieldName = 'Amount'
      ReadOnly = True
      DisplayFormat = '$,0.#0'
    end
    object QueryWorkHours: TFloatField
      FieldName = 'WorkHours'
      DisplayFormat = '0.#0'
    end
    object QueryHourlySales: TFloatField
      FieldKind = fkCalculated
      FieldName = 'HourlySales'
      Calculated = True
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 60
    Top = 60
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
    Left = 94
    Top = 62
  end
end
