object SalesHistoryDetailForm: TSalesHistoryDetailForm
  Left = 1030
  Top = 213
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Sales Detail'
  ClientHeight = 343
  ClientWidth = 637
  Color = 15389375
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object NoteLabel: TLabel
    Left = 12
    Top = 281
    Width = 59
    Height = 13
    Caption = 'NoteLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBGridPanel: TbsSkinPanel
    Left = 6
    Top = 6
    Width = 616
    Height = 214
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
      Width = 614
      Height = 212
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgTabs, dgConfirmDelete, dgCancelOnExit]
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
          FieldName = 'ItemCode'
          Title.Alignment = taCenter
          Title.Caption = 'Code'
          Width = 43
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Description'
          Width = 283
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Qty'
          Title.Alignment = taRightJustify
          Width = 44
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Price'
          Title.Alignment = taRightJustify
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Discount'
          Title.Alignment = taRightJustify
          Title.Caption = 'Dis(%)'
          Width = 48
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Amount'
          Title.Alignment = taRightJustify
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TaxRate'
          Title.Alignment = taRightJustify
          Title.Caption = 'GST(%)'
          Width = 43
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OrderOperator'
          Title.Alignment = taCenter
          Title.Caption = 'Operator'
          Width = 148
          Visible = True
        end>
    end
  end
  object TotalPanel: TbsSkinPanel
    Left = 60
    Top = 221
    Width = 523
    Height = 54
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
    Caption = 'TotalPanel'
    Enabled = False
    object Label1: TLabel
      Left = 20
      Top = 9
      Width = 75
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Amount'
      Color = clBtnFace
      ParentColor = False
    end
    object Label2: TLabel
      Left = 103
      Top = 9
      Width = 75
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Discount'
      Color = clBtnFace
      ParentColor = False
    end
    object Label3: TLabel
      Left = 434
      Top = 9
      Width = 75
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Total'
      Color = clBtnFace
      ParentColor = False
    end
    object Label4: TLabel
      Left = 351
      Top = 9
      Width = 75
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'G.S.T.'
      Color = clBtnFace
      ParentColor = False
    end
    object SurchargeLabel: TLabel
      Left = 185
      Top = 9
      Width = 75
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Surcharge'
      Color = clBtnFace
      ParentColor = False
    end
    object OtherChargeLabel: TLabel
      Left = 268
      Top = 9
      Width = 75
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Other Charge'
      Color = clBtnFace
      ParentColor = False
    end
    object Label5: TLabel
      Left = 342
      Top = 57
      Width = 75
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Points Redeem'
      Visible = False
    end
    object AmountEdit: TStaticText
      Left = 20
      Top = 27
      Width = 75
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 0
    end
    object DiscountEdit: TStaticText
      Left = 103
      Top = 27
      Width = 75
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 1
    end
    object TotalEdit: TStaticText
      Left = 434
      Top = 27
      Width = 75
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 2
    end
    object GSTEdit: TStaticText
      Left = 351
      Top = 27
      Width = 75
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 3
    end
    object ServiceChargeEdit: TStaticText
      Left = 185
      Top = 27
      Width = 75
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 4
    end
    object OtherChargeEdit: TStaticText
      Left = 268
      Top = 27
      Width = 75
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 5
    end
    object RewardPointsEdit: TStaticText
      Left = 342
      Top = 75
      Width = 75
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 6
      Visible = False
    end
  end
  object ExitButton: TXiButton
    Left = 472
    Top = 283
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
  object DataSource: TDataSource
    DataSet = Query
    Left = 36
    Top = 84
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    OnCalcFields = QueryCalcFields
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select OrderI.ItemCode, Description1, Qty, OrderI.Price, '
      
        '           OrderI.Discount, OrderI.TaxRate, PriceSelect, SubDesc' +
        'ription, '
      
        '           SubDescription1, SubDescription2, SubDescription3, Co' +
        'ndition '
      '           From MenuItem, OrderI'
      '           Where MenuItem.ItemCode=OrderI.ItemCode '
      '           ')
    Left = 68
    Top = 86
    object QueryItemCode: TStringField
      FieldName = 'ItemCode'
      Size = 4
    end
    object QueryDescription1: TStringField
      FieldName = 'Description1'
      Size = 100
    end
    object QueryQty: TFloatField
      FieldName = 'Qty'
      DisplayFormat = '0.#0'
    end
    object QueryPrice: TFloatField
      FieldName = 'Price'
    end
    object QueryDiscount: TFloatField
      FieldName = 'Discount'
    end
    object QueryTaxRate: TFloatField
      FieldName = 'TaxRate'
      DisplayFormat = '0.#0'
    end
    object QueryAmount: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Amount'
      Calculated = True
    end
    object QueryPriceSelect: TSmallintField
      FieldName = 'PriceSelect'
    end
    object QuerySubDescription: TStringField
      FieldName = 'SubDescription'
      Size = 10
    end
    object QuerySubDescription1: TStringField
      FieldName = 'SubDescription1'
      Size = 10
    end
    object QuerySubDescription2: TStringField
      FieldName = 'SubDescription2'
      Size = 10
    end
    object QuerySubDescription3: TStringField
      FieldName = 'SubDescription3'
      Size = 10
    end
    object QueryCondition: TSmallintField
      FieldName = 'Condition'
    end
    object QueryDescription: TStringField
      DisplayWidth = 100
      FieldKind = fkCalculated
      FieldName = 'Description'
      Size = 100
      Calculated = True
    end
    object QueryOrderOperator: TStringField
      FieldName = 'OrderOperator'
      Size = 15
    end
  end
  object TempQuery: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 98
    Top = 86
  end
  object bsBusinessSkinForm1: TbsBusinessSkinForm
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
    HideCaptionButtons = True
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
    BorderIcons = []
    Left = 130
    Top = 88
  end
end
