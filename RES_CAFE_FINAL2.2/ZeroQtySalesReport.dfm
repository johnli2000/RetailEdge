object ZeroQtySalesReportForm: TZeroQtySalesReportForm
  Left = 380
  Top = 146
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Zero Quantity Sales Report'
  ClientHeight = 625
  ClientWidth = 901
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
  object DBGridPanel: TbsSkinPanel
    Left = 6
    Top = 6
    Width = 879
    Height = 552
    HintImageIndex = 0
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
    RibbonStyle = False
    ImagePosition = bsipDefault
    TransparentMode = False
    CaptionImageIndex = -1
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
      Width = 877
      Height = 550
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
      FixedColor = 15389375
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgConfirmDelete, dgCancelOnExit]
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
          Alignment = taCenter
          Expanded = False
          FieldName = 'OrderNo'
          Title.Alignment = taCenter
          Title.Caption = 'Order No'
          Width = 75
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'OrderDate'
          Title.Alignment = taCenter
          Title.Caption = 'Date'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Description'
          Title.Alignment = taCenter
          Width = 320
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Qty'
          Title.Alignment = taCenter
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FixPrice'
          Title.Alignment = taCenter
          Title.Caption = 'Fix Price'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SalesPrice'
          Title.Alignment = taCenter
          Title.Caption = 'Sales Price'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OrderOperator'
          Title.Alignment = taCenter
          Title.Caption = 'Operator'
          Width = 130
          Visible = True
        end>
    end
  end
  object ControlPanel: TbsSkinPanel
    Left = 6
    Top = 558
    Width = 298
    Height = 41
    HintImageIndex = 0
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
    RibbonStyle = False
    ImagePosition = bsipDefault
    TransparentMode = False
    CaptionImageIndex = -1
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
    object Label1: TLabel
      Left = 17
      Top = 14
      Width = 26
      Height = 13
      Caption = 'Date:'
    end
    object Label2: TLabel
      Left = 156
      Top = 14
      Width = 13
      Height = 13
      Caption = 'To'
    end
    object DateEdit1: TMaskEdit
      Left = 49
      Top = 10
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnClick = DateEditClick
      OnKeyDown = DateEdit1KeyDown
    end
    object DateEdit2: TMaskEdit
      Left = 175
      Top = 10
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnClick = DateEditClick
      OnKeyDown = DateEdit2KeyDown
    end
    object TimeEdit1: TMaskEdit
      Left = 116
      Top = 10
      Width = 34
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 1
      Text = '  :  '
      OnClick = TimeEditClick
      OnKeyDown = TimeEdit1KeyDown
    end
    object TimeEdit2: TMaskEdit
      Left = 243
      Top = 10
      Width = 34
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 3
      Text = '  :  '
      OnClick = TimeEditClick
      OnKeyDown = TimeEdit2KeyDown
    end
  end
  object SearchButton: TXiButton
    Left = 546
    Top = 565
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
    Left = 652
    Top = 565
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
    Left = 758
    Top = 565
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
  object DataSource: TDataSource
    DataSet = Query
    Left = 54
    Top = 86
  end
  object Query: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Hospitality;Data Source=CHARLES-PC'
    CursorType = ctStatic
    LockType = ltReadOnly
    OnCalcFields = QueryCalcFields
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select OrderH.OrderNo, OrderDate, Description1, SubDescription,'
      
        '       OrderI.Qty, OrderI.Price As SalesPrice, MenuItem.Price As' +
        ' FixPrice,'
      '       OrderOperator'
      'From OrderH, OrderI, MenuItem'
      'Where OrderH.OrderNo=OrderI.OrderNo and PriceSelect = 0 and'
      '      OrderI.ItemCode=MenuItem.ItemCode and OrderI.Qty <> 0')
    Left = 84
    Top = 88
    object QueryOrderNo: TWideStringField
      FieldName = 'OrderNo'
      Size = 10
    end
    object QueryOrderDate: TDateTimeField
      FieldName = 'OrderDate'
      DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
    end
    object QueryDescription1: TWideStringField
      FieldName = 'Description1'
      Size = 100
    end
    object QuerySubDescription: TWideStringField
      FieldName = 'SubDescription'
      Size = 10
    end
    object QueryQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.###'
    end
    object QuerySalesPrice: TFloatField
      FieldName = 'SalesPrice'
      DisplayFormat = '$,0.#0'
    end
    object QueryOrderOperator: TWideStringField
      FieldName = 'OrderOperator'
      Size = 15
    end
    object QueryDescription: TStringField
      FieldKind = fkCalculated
      FieldName = 'Description'
      Size = 200
      Calculated = True
    end
    object QueryFixPrice: TFloatField
      FieldName = 'FixPrice'
    end
  end
  object bsBusinessSkinForm: TbsBusinessSkinForm
    ShowMDIScrollBars = True
    WindowState = wsNormal
    QuickButtons = <>
    QuickButtonsShowHint = False
    QuickButtonsShowDivider = True
    ClientInActiveEffect = False
    ClientInActiveEffectType = bsieSemiTransparent
    DisableSystemMenu = False
    AlwaysResize = False
    PositionInMonitor = bspDefault
    UseFormCursorInNCArea = False
    MaxMenuItemsInWindow = 0
    ClientWidth = 0
    ClientHeight = 0
    HideCaptionButtons = False
    AlwaysShowInTray = False
    LogoBitMapTransparent = False
    AlwaysMinimizeToTray = False
    UseSkinFontInMenu = False
    UseSkinFontInCaption = True
    UseSkinSizeInMenu = True
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
    BorderIcons = [biSystemMenu, biMinimize, biMaximize]
    Left = 50
    Top = 56
  end
end
