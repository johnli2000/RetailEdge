object CustomerStatementForm: TCustomerStatementForm
  Left = 392
  Top = 158
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Customer Statement'
  ClientHeight = 483
  ClientWidth = 680
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
  object StringGridPanel: TbsSkinPanel
    Left = 6
    Top = 6
    Width = 658
    Height = 341
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
    Caption = 'StringGridPanel'
    object StringGrid: TStringGrid
      Left = 1
      Top = 1
      Width = 656
      Height = 339
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DefaultRowHeight = 20
      FixedColor = 15389375
      FixedCols = 0
      RowCount = 16
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine]
      ParentCtl3D = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnDrawCell = StringGridDrawCell
      ColWidths = (
        110
        298
        75
        75
        75)
    end
  end
  object TotalPanel: TbsSkinPanel
    Left = 252
    Top = 348
    Width = 413
    Height = 67
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
    object Label4: TLabel
      Left = 210
      Top = 18
      Width = 90
      Height = 13
      AutoSize = False
      Caption = 'Total Payment'
    end
    object Label7: TLabel
      Left = 112
      Top = 18
      Width = 90
      Height = 13
      AutoSize = False
      Caption = 'Total Sales'
    end
    object Label8: TLabel
      Left = 308
      Top = 18
      Width = 90
      Height = 13
      AutoSize = False
      Caption = 'Balance'
    end
    object Label2: TLabel
      Left = 14
      Top = 18
      Width = 90
      Height = 13
      AutoSize = False
      Caption = 'Opening'
    end
    object TotalSalesEdit: TStaticText
      Left = 112
      Top = 36
      Width = 90
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 0
    end
    object TotalPaymentEdit: TStaticText
      Left = 210
      Top = 36
      Width = 90
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 1
    end
    object BalanceEdit: TStaticText
      Left = 308
      Top = 36
      Width = 90
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 2
    end
    object OpenningEdit: TStaticText
      Left = 14
      Top = 36
      Width = 90
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 3
    end
  end
  object ControlPanel: TbsSkinPanel
    Left = 6
    Top = 348
    Width = 245
    Height = 67
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
    Caption = 'ControlPanel'
    object Label5: TLabel
      Left = 14
      Top = 16
      Width = 26
      Height = 13
      Caption = 'Date:'
    end
    object Label6: TLabel
      Left = 139
      Top = 16
      Width = 13
      Height = 13
      Caption = 'To'
    end
    object Label1: TLabel
      Left = 14
      Top = 40
      Width = 44
      Height = 13
      Caption = 'Customer'
    end
    object DateEdit1: TMaskEdit
      Left = 62
      Top = 12
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnClick = DateEditClick
    end
    object DateEdit2: TMaskEdit
      Left = 167
      Top = 12
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnClick = DateEditClick
    end
    object CustomerNameEdit: TStaticText
      Left = 62
      Top = 38
      Width = 170
      Height = 17
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 2
    end
  end
  object SearchButton: TXiButton
    Left = 40
    Top = 423
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
    TabOrder = 3
    OnClick = SearchButtonClick
  end
  object PrintButton: TXiButton
    Left = 148
    Top = 423
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
    Left = 522
    Top = 423
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
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      
        'Select InvoiceNo, InvoiceDate, (Amount + Freight + OtherCharge +' +
        ' GST) As Credit,'
      '       0 As Debit, PaidAmount, KindFlag'
      'From InvoiceHead'
      'Union all'
      
        'Select RecvAcct.InvoiceNo, AccountDate, 0 As Credit, RecvAcct.Pa' +
        'idAmount As Debit,'
      '       RecvAcct.PaidAmount, 10 As KindFlag'
      'From RecvAcct'
      'Order By InvoiceDate, InvoiceNo, KindFlag'
      '')
    Left = 20
    Top = 32
  end
  object TempQuery: TADOQuery
    Connection = DataForm.ADOConnection
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select InvoiceNo, InvoiceDate, '
      '          (Amount+ Freight+ OtherCharge+ GST) As Total'
      '        , PaidAmount'
      'From InvoiceHead'
      'Order By InvoiceNo'
      '')
    Left = 50
    Top = 32
    object TempQueryInvoiceNo: TStringField
      FieldName = 'InvoiceNo'
      Size = 10
    end
    object TempQueryInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
    end
    object TempQueryTotal: TFloatField
      FieldName = 'Total'
      ReadOnly = True
    end
    object TempQueryPaidAmount: TFloatField
      FieldName = 'PaidAmount'
    end
    object TempQueryBalance: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Balance'
      Calculated = True
    end
    object TempQueryAge: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Age'
      Calculated = True
    end
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
    UseSkinFontInMenu = True
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
    Left = 32
    Top = 78
  end
end
