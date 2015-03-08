object CurrentSalesMarginDetailForm: TCurrentSalesMarginDetailForm
  Left = 421
  Top = 203
  AutoScroll = False
  BorderIcons = []
  Caption = 'Current Sales Margin Detail'
  ClientHeight = 425
  ClientWidth = 820
  Color = clBtnFace
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
    Width = 800
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
    Caption = 'DBGridPanel'
    object DBGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 798
      Height = 349
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
      FixedColor = 15389375
      Options = [dgTitles, dgIndicator, dgColLines, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Code'
          Title.Alignment = taCenter
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Description'
          Title.Alignment = taCenter
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'StockMeasureDescription'
          Title.Alignment = taCenter
          Title.Caption = 'Stock Measurement'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LastOrderPrice'
          Title.Alignment = taCenter
          Title.Caption = 'Current Cost'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SalesMeasureDescription'
          Title.Alignment = taCenter
          Title.Caption = 'Sales Measurement'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SalesCost'
          Title.Alignment = taCenter
          Title.Caption = 'Sales Cost'
          Width = 75
          Visible = True
        end>
    end
  end
  object ExitButton: TXiButton
    Left = 652
    Top = 365
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
    TabOrder = 1
    OnClick = ExitButtonClick
  end
  object bsSkinPanel1: TbsSkinPanel
    Left = 6
    Top = 358
    Width = 168
    Height = 44
    TabOrder = 2
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
    object SalesCostLabel: TbsSkinStdLabel
      Left = 24
      Top = 16
      Width = 88
      Height = 13
      UseSkinFont = True
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = [fsBold]
      SkinDataName = 'stdlabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Caption = 'SalesCostLabel'
      ParentFont = False
    end
  end
  object Query: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Hospitality;Data Source=CHARLES-PC'
    CursorType = ctStatic
    LockType = ltReadOnly
    OnCalcFields = QueryCalcFields
    Parameters = <>
    SQL.Strings = (
      
        'Select StockTable.Code, Description, StockTable.Measure As Stock' +
        'Measure, StockTable.MeasureKind,StockLinkTable.Measure, LastOrde' +
        'rPrice,'
      
        '       StockLinkTable.Measure * (LastOrderPrice / StockTable.Mea' +
        'sure) As SalesCost'
      'From StockLinkTable, StockTable'
      
        'Where  StockLinkTable.Code=StockTable.Code and PriceSelect = 0 a' +
        'nd'
      '       StockLinkTable.ItemCode='#39'BE10'#39' ')
    Left = 22
    Top = 196
    object QueryCode: TWideStringField
      DisplayWidth = 11
      FieldName = 'Code'
      Size = 8
    end
    object QueryDescription: TWideStringField
      DisplayWidth = 54
      FieldName = 'Description'
      Size = 100
    end
    object QueryStockMeasure: TFloatField
      DisplayWidth = 14
      FieldName = 'StockMeasure'
    end
    object QueryMeasureKind: TSmallintField
      DisplayWidth = 13
      FieldName = 'MeasureKind'
    end
    object QueryMeasure: TFloatField
      DisplayWidth = 11
      FieldName = 'Measure'
    end
    object QueryLastOrderPrice: TFloatField
      DisplayWidth = 15
      FieldName = 'LastOrderPrice'
      DisplayFormat = '$,0.#0'
    end
    object QuerySalesCost: TFloatField
      DisplayWidth = 14
      FieldName = 'SalesCost'
      ReadOnly = True
      DisplayFormat = '$,0.###0'
    end
    object QueryStockMeasureDescription: TStringField
      FieldKind = fkCalculated
      FieldName = 'StockMeasureDescription'
      Size = 30
      Calculated = True
    end
    object QuerySalesMeasureDescription: TStringField
      FieldKind = fkCalculated
      FieldName = 'SalesMeasureDescription'
      Calculated = True
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 56
    Top = 198
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
    UseDefaultSysMenu = True
    SkinData = MainForm.bsSkinData
    MinHeight = 0
    MinWidth = 0
    MaxHeight = 0
    MaxWidth = 0
    Magnetic = False
    MagneticSize = 5
    BorderIcons = []
    Left = 16
    Top = 158
  end
end
