object PickupReportForm: TPickupReportForm
  Left = 435
  Top = 183
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Pickup Order Report'
  ClientHeight = 537
  ClientWidth = 521
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
    Width = 500
    Height = 421
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
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 498
      Height = 419
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
      FixedColor = 15389375
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'OrderNo'
          Title.Alignment = taCenter
          Title.Caption = 'Order No.'
          Width = 76
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'OrderDate'
          Title.Alignment = taCenter
          Title.Caption = 'Date'
          Width = 122
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ServicePerson'
          Title.Alignment = taCenter
          Title.Caption = 'Service'
          Width = 192
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TotalAmount'
          Title.Alignment = taCenter
          Title.Caption = 'Amount'
          Width = 73
          Visible = True
        end>
    end
  end
  object bsSkinPanel1: TbsSkinPanel
    Left = 6
    Top = 428
    Width = 500
    Height = 42
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
      Left = 22
      Top = 14
      Width = 58
      Height = 13
      Caption = 'Report Date'
    end
    object Label2: TLabel
      Left = 198
      Top = 14
      Width = 13
      Height = 13
      Caption = 'To'
    end
    object DateEdit1: TMaskEdit
      Left = 86
      Top = 10
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 0
      Text = '  /  /    '
      OnChange = EditChange
      OnClick = DateEditClick
      OnExit = DateEdit1Exit
      OnKeyDown = DateEdit1KeyDown
    end
    object TimeEdit1: TMaskEdit
      Left = 156
      Top = 10
      Width = 35
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 1
      Text = '  :  '
      OnChange = EditChange
      OnClick = TimeEditClick
      OnKeyDown = TimeEdit1KeyDown
    end
    object DateEdit2: TMaskEdit
      Left = 220
      Top = 10
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      ReadOnly = True
      TabOrder = 2
      Text = '  /  /    '
      OnChange = EditChange
      OnClick = DateEditClick
      OnExit = DateEdit2Exit
      OnKeyDown = DateEdit2KeyDown
    end
    object TimeEdit2: TMaskEdit
      Left = 292
      Top = 10
      Width = 34
      Height = 19
      EditMask = '!90:00;1;_'
      MaxLength = 5
      ReadOnly = True
      TabOrder = 3
      Text = '  :  '
      OnChange = EditChange
      OnClick = TimeEditClick
      OnKeyDown = TimeEdit2KeyDown
    end
  end
  object SearchButton: TXiButton
    Left = 38
    Top = 478
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
    Left = 146
    Top = 478
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
    Left = 374
    Top = 478
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
  object bsBusinessSkinForm1: TbsBusinessSkinForm
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
    Left = 24
    Top = 138
  end
  object Query: TADOQuery
    CursorType = ctStatic
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      
        'Select OrderNo, OrderDate, ServicePerson, Amount + ServiceCharge' +
        ' + OtherCharge As TotalAmount'
      'From OrderH'
      'Where BillKind=1 and Delivery = 0 and PriceIncludesGST <> 0'
      'Union All'
      
        'Select OrderNo, OrderDate, ServicePerson, Amount + ServiceCharge' +
        ' + OtherCharge + GST As TotalAmount'
      'From OrderH'
      'Where BillKind=1 and Delivery = 0 and PriceIncludesGST = 0'
      'Order By ServicePerson, OrderNo  ')
    Left = 30
    Top = 102
    object QueryOrderNo: TWideStringField
      FieldName = 'OrderNo'
      Size = 10
    end
    object QueryOrderDate: TDateTimeField
      FieldName = 'OrderDate'
    end
    object QueryServicePerson: TWideStringField
      FieldName = 'ServicePerson'
      Size = 15
    end
    object QueryTotalAmount: TFloatField
      FieldName = 'TotalAmount'
      ReadOnly = True
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 76
    Top = 96
  end
end
