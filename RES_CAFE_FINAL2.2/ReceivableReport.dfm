object ReceivableReportForm: TReceivableReportForm
  Left = 368
  Top = 132
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Receivable Report'
  ClientHeight = 539
  ClientWidth = 776
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
    Width = 760
    Height = 423
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
      Width = 758
      Height = 421
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DetailButtonClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'VIPNo'
          Title.Alignment = taCenter
          Title.Caption = 'V.I.P. No'
          Width = 84
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VIPName'
          Title.Alignment = taCenter
          Title.Caption = 'Customer Name'
          Width = 314
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Telephone'
          Title.Alignment = taCenter
          Width = 123
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CreditLimit'
          Title.Alignment = taCenter
          Title.Caption = 'Credit Limit'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TotalCredit'
          Title.Alignment = taCenter
          Title.Caption = 'Receivable'
          Width = 100
          Visible = True
        end>
    end
  end
  object ControlPanel: TbsSkinPanel
    Left = 6
    Top = 430
    Width = 760
    Height = 46
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
    object Label2: TLabel
      Left = 559
      Top = 16
      Width = 81
      Height = 13
      Caption = 'Total Receivable'
      Color = clBtnFace
      ParentColor = False
    end
    object DateCheckBox: TCheckBox
      Left = 14
      Top = 15
      Width = 80
      Height = 17
      Caption = 'End of Day'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 0
      OnClick = DateCheckBoxClick
    end
    object DateEdit: TMaskEdit
      Left = 93
      Top = 13
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnClick = DateEditClick
    end
    object TotalEdit: TStaticText
      Left = 643
      Top = 14
      Width = 90
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 2
    end
    object SmartCard: TCheckBox
      Left = 176
      Top = 16
      Width = 97
      Height = 17
      Caption = 'SmartCard'
      TabOrder = 3
    end
  end
  object SearchButton: TXiButton
    Left = 44
    Top = 484
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
  object DetailButton: TXiButton
    Left = 152
    Top = 484
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
    Caption = 'Detail'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = DetailButtonClick
  end
  object PrintButton: TXiButton
    Left = 260
    Top = 484
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
    TabOrder = 4
    OnClick = PrintButtonClick
  end
  object ExitButton: TXiButton
    Left = 627
    Top = 484
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
    TabOrder = 5
    OnClick = ExitButtonClick
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 42
    Top = 68
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
      ' Select VIPTable.VIPNo, VIPName, Telephone, CreditLimit,'
      '        Sum(TempTable.TotalCredit) As TotalCredit From VIPTable,'
      
        '        (Select VIPNo, (Amount + ServiceCharge + OtherCharge + T' +
        'ips - PaidAmount) As TotalCredit'
      
        '        From OrderH Where (PriceIncludesGST <> 0) and (Credit <>' +
        ' 0) and'
      
        '        (Amount + ServiceCharge + OtherCharge + Tips - PaidAmoun' +
        't > 0)'
      '         Union All'
      
        '        Select VIPNo, (Amount + ServiceCharge + OtherCharge + Ti' +
        'ps + GST - PaidAmount) As TotalCredit'
      
        '        From OrderH Where (PriceIncludesGST = 0) and (Credit <> ' +
        '0) and'
      
        '        (Amount + ServiceCharge + OtherCharge + GST + Tips - Pai' +
        'dAmount > 0)'
      '         Union All'
      '        Select VIPNo, 0 - Amount As TotalCredit'
      '        From DepositTable ) As TempTable'
      '        Where VIPTable.VIPNo=TempTable.VIPNo'
      '        Group By VIPTable.VIPNo, VIPName, Telephone, CreditLimit'
      '        Having Sum(TempTable.TotalCredit) > 0'
      '        Order By VIPTable.VIPNo')
    Left = 72
    Top = 68
    object QueryVIPNo: TIntegerField
      FieldName = 'VIPNo'
      DisplayFormat = '#00000000#'
    end
    object QueryVIPName: TStringField
      FieldName = 'VIPName'
      Size = 30
    end
    object QueryTelephone: TStringField
      FieldName = 'Telephone'
      Size = 15
    end
    object QueryCreditLimit: TFloatField
      FieldName = 'CreditLimit'
    end
    object QueryTotalCredit: TFloatField
      FieldName = 'TotalCredit'
      ReadOnly = True
    end
    object QueryAvailableCredit: TFloatField
      FieldKind = fkCalculated
      FieldName = 'AvailableCredit'
      Calculated = True
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
    Left = 40
    Top = 104
  end
end
