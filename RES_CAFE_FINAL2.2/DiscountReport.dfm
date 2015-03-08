object DiscountReportForm: TDiscountReportForm
  Left = 784
  Top = 288
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Discount Report'
  ClientHeight = 639
  ClientWidth = 882
  Color = clWindow
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
    Width = 862
    Height = 520
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
      Width = 860
      Height = 518
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
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
          Width = 72
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'OrderDate'
          Title.Alignment = taCenter
          Title.Caption = 'Order Date'
          Width = 117
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DiscountOperator'
          Title.Alignment = taCenter
          Title.Caption = 'Operator'
          Width = 150
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'VIPTemp'
          Title.Alignment = taCenter
          Title.Caption = 'V.I.P.'
          Width = 98
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DiscountPercentage'
          Title.Alignment = taCenter
          Title.Caption = 'Disc (%)'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Amount'
          Title.Alignment = taCenter
          Title.Caption = 'Order Amount'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DiscountAmount'
          Title.Alignment = taCenter
          Title.Caption = 'Discount'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Description'
          Title.Alignment = taCenter
          Width = 189
          Visible = True
        end>
    end
  end
  object ControlPanel: TbsSkinPanel
    Left = 6
    Top = 526
    Width = 862
    Height = 43
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
    UseSkinFont = False
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
    object Label2: TLabel
      Left = 170
      Top = 16
      Width = 13
      Height = 13
      Caption = 'To'
      Color = clBtnFace
      ParentColor = False
    end
    object Label3: TLabel
      Left = 670
      Top = 16
      Width = 69
      Height = 13
      Caption = 'Total Discount'
      Color = clBtnFace
      ParentColor = False
      WordWrap = True
    end
    object Label1: TLabel
      Left = 510
      Top = 16
      Width = 83
      Height = 13
      Alignment = taCenter
      Caption = 'Total Transaction'
      Color = clBtnFace
      ParentColor = False
      WordWrap = True
    end
    object DateEdit1: TMaskEdit
      Left = 62
      Top = 12
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnClick = DateEditClick
      OnKeyDown = DateEdit1KeyDown
    end
    object DateEdit2: TMaskEdit
      Left = 190
      Top = 12
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      OnClick = DateEditClick
      OnKeyDown = DateEdit2KeyDown
    end
    object DiscountEdit: TStaticText
      Left = 745
      Top = 12
      Width = 95
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 7
    end
    object TimeEdit1: TMaskEdit
      Left = 130
      Top = 12
      Width = 34
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 2
      Text = '  :  '
      OnClick = TimeEditClick
      OnKeyDown = TimeEdit1KeyDown
    end
    object TimeEdit2: TMaskEdit
      Left = 258
      Top = 12
      Width = 34
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 4
      Text = '  :  '
      OnClick = TimeEditClick
      OnKeyDown = TimeEdit2KeyDown
    end
    object DateCheckBox: TCheckBox
      Left = 16
      Top = 14
      Width = 44
      Height = 17
      Caption = 'Date'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 0
      OnClick = DateCheckBoxClick
    end
    object VIPCheckBox: TCheckBox
      Left = 335
      Top = 14
      Width = 66
      Height = 17
      Caption = 'V.I.P. No'
      Color = 15389375
      ParentColor = False
      TabOrder = 5
      Visible = False
      OnClick = VIPCheckBoxClick
    end
    object VIPNumberEdit: TStaticText
      Left = 405
      Top = 12
      Width = 86
      Height = 19
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 6
      Visible = False
    end
    object TotalTransactionEdit: TStaticText
      Left = 599
      Top = 12
      Width = 51
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
  end
  object SearchButton: TXiButton
    Left = 40
    Top = 577
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
    Top = 577
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
    Left = 740
    Top = 577
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
    Left = 20
    Top = 234
  end
  object Query: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Hospitality;Data Source=CHARLES-PC'
    CursorType = ctStatic
    LockType = ltUnspecified
    OnCalcFields = QueryCalcFields
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      
        'Select OrderI.OrderNo, OrderDate, Sum(OrderI.Qty * OrderI.Price)' +
        ' As Amount,'
      
        '       Sum(OrderI.Qty * OrderI.Price * Discount / 100) As Discou' +
        'ntAmount,'
      '       OrderI.Discount, VIPNo, ServicePerson, DiscountOperator'
      'From OrderH, OrderI'
      'Where OrderH.OrderNo=OrderI.OrderNo and (OrderI.Discount > 0)'
      
        'Group By OrderI.OrderNo, OrderDate, OrderI.Discount, VIPNo, Serv' +
        'icePerson,'
      'DiscountOperator'
      'Order By OrderI.OrderNo'
      ' ')
    Left = 52
    Top = 234
    object QueryOrderNo: TStringField
      FieldName = 'OrderNo'
      Size = 10
    end
    object QueryOrderDate: TDateTimeField
      FieldName = 'OrderDate'
      DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
    end
    object QueryDiscount: TFloatField
      FieldName = 'Discount'
      DisplayFormat = '0.#0'
    end
    object QueryVIPNo: TIntegerField
      FieldName = 'VIPNo'
      DisplayFormat = '0######0'
    end
    object QueryAmount: TFloatField
      FieldName = 'Amount'
      ReadOnly = True
    end
    object QueryVIPTemp: TStringField
      FieldKind = fkCalculated
      FieldName = 'VIPTemp'
      Size = 10
      Calculated = True
    end
    object QueryDiscountAmount: TFloatField
      FieldName = 'DiscountAmount'
    end
    object QueryDiscountPercentage: TFloatField
      FieldKind = fkCalculated
      FieldName = 'DiscountPercentage'
      DisplayFormat = '0.#0'
      Calculated = True
    end
    object QueryDescription: TStringField
      FieldName = 'Description'
      Size = 25
    end
    object QueryDiscountOperator: TStringField
      FieldName = 'DiscountOperator'
      Size = 15
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
    UseSkinFontInMenu = True
    UseSkinFontInCaption = True
    UseSkinSizeInMenu = True
    ShowIcon = False
    MaximizeOnFullScreen = False
    AlphaBlend = False
    AlphaBlendAnimation = False
    AlphaBlendValue = 200
    ShowObjectHint = False
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
    BorderIcons = [biSystemMenu, biMinimize, biMaximize]
    Left = 40
    Top = 176
  end
end
