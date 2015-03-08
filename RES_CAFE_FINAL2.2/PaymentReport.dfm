object PurchasePaymentRptForm: TPurchasePaymentRptForm
  Left = 390
  Top = 144
  BorderIcons = []
  BorderStyle = bsSingle
  ClientHeight = 530
  ClientWidth = 782
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
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridPanel: TbsSkinPanel
    Left = 6
    Top = 6
    Width = 760
    Height = 322
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
    Caption = 'DBGridPanel'
    object DBGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 758
      Height = 320
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
      FixedColor = 15389375
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
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
          FieldName = 'ReceiveNo'
          Title.Alignment = taCenter
          Title.Caption = 'Receive No'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ReceiveDate'
          Title.Alignment = taCenter
          Title.Caption = 'Receive Date'
          Width = 78
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SupplierName'
          Title.Alignment = taCenter
          Title.Caption = 'Supplier'
          Width = 247
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Total'
          Title.Alignment = taCenter
          Title.Caption = 'Total Purchase'
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PaidAmount'
          Title.Alignment = taCenter
          Title.Caption = 'Paid Amount'
          Width = 71
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'AccountDate'
          Title.Alignment = taCenter
          Title.Caption = 'Payment Date'
          Width = 74
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Payby'
          Title.Alignment = taCenter
          Title.Caption = 'Pay Method'
          Width = 111
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Notes'
          Title.Alignment = taCenter
          Title.Caption = 'Cheque #'
          Width = 108
          Visible = True
        end>
    end
  end
  object DBGridPanel1: TbsSkinPanel
    Left = 6
    Top = 330
    Width = 325
    Height = 184
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
    Caption = 'DBGridPanel1'
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 323
      Height = 182
      Align = alClient
      BorderStyle = bsNone
      DataSource = SummaryDataSource
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
          Expanded = False
          FieldName = 'Payby'
          Title.Alignment = taCenter
          Title.Caption = 'Payment Methods'
          Width = 160
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Amount'
          Title.Alignment = taCenter
          Title.Caption = 'Paid Amount'
          Width = 130
          Visible = True
        end>
    end
  end
  object ControlPanel: TbsSkinPanel
    Left = 333
    Top = 330
    Width = 433
    Height = 125
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
    object Label1: TLabel
      Left = 138
      Top = 14
      Width = 13
      Height = 13
      Caption = 'To'
    end
    object DateCheckBox: TCheckBox
      Left = 18
      Top = 12
      Width = 47
      Height = 17
      Caption = 'Date'
      TabOrder = 0
    end
    object DateEdit1: TMaskEdit
      Left = 66
      Top = 10
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
    end
    object DateEdit2: TMaskEdit
      Left = 160
      Top = 10
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
    end
    object SupplierCheckBox: TCheckBox
      Left = 18
      Top = 44
      Width = 63
      Height = 17
      Caption = 'Supplier'
      TabOrder = 3
    end
    object SupplierCodeEdit: TEdit
      Left = 80
      Top = 42
      Width = 145
      Height = 19
      ReadOnly = True
      TabOrder = 4
    end
    object SupplierNameEdit: TEdit
      Left = 18
      Top = 64
      Width = 207
      Height = 19
      Enabled = False
      TabOrder = 5
    end
    object ChequeNoCheckBox: TCheckBox
      Left = 18
      Top = 96
      Width = 79
      Height = 17
      Caption = 'Cheque No'
      TabOrder = 6
    end
    object ChequeNoEdit: TEdit
      Left = 96
      Top = 94
      Width = 129
      Height = 19
      TabOrder = 7
    end
    object SortRadioGroup: TRadioGroup
      Left = 245
      Top = 5
      Width = 173
      Height = 108
      Caption = ' Sort '
      Items.Strings = (
        'Sort by payment date'
        'Sort by receive date'
        'Sort by supplier name'
        'Sort by cheque number')
      TabOrder = 8
    end
  end
  object SearchButton: TXiButton
    Left = 342
    Top = 466
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
  end
  object ViewButton: TXiButton
    Left = 446
    Top = 466
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
    Caption = 'View Detail'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object PrintButton: TXiButton
    Left = 550
    Top = 466
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
    TabOrder = 5
  end
  object ExitButton: TXiButton
    Left = 654
    Top = 466
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
    TabOrder = 6
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 68
    Top = 54
  end
  object SummaryDataSource: TDataSource
    DataSet = SummaryQuery
    Left = 40
    Top = 368
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      
        'Select PayAcct.ReceiveNo, ReceiveDate, SupplierName, Amount, GST' +
        ', PayAcct.PaidAmount, AccountDate, Payby, PayAcct.Notes'
      'From PayAcct, StockH, Supplier'
      'Where PayAcct.ReceiveNo=StockH.ReceiveNo and'
      '           StockH.SupplierCode=Supplier.SupplierCode'
      'Order By PayAcct.ReceiveNo'
      '')
    Left = 136
    Top = 52
    object QueryReceiveNo: TStringField
      FieldName = 'ReceiveNo'
      Size = 8
    end
    object QueryReceiveDate: TDateTimeField
      FieldName = 'ReceiveDate'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object QuerySupplierName: TStringField
      FieldName = 'SupplierName'
      Size = 40
    end
    object QueryAmount: TFloatField
      FieldName = 'Amount'
    end
    object QueryGST: TFloatField
      FieldName = 'GST'
    end
    object QueryPaidAmount: TFloatField
      FieldName = 'PaidAmount'
    end
    object QueryAccountDate: TDateTimeField
      FieldName = 'AccountDate'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object QueryPayby: TStringField
      FieldName = 'Payby'
      Size = 25
    end
    object QueryNotes: TStringField
      FieldName = 'Notes'
      Size = 25
    end
    object QueryTotal: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Total'
      Calculated = True
    end
  end
  object SummaryQuery: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Hospitality;Data Source=CHARLES-PC'
    CursorType = ctStatic
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select Payby, Sum(PaidAmount) As Amount From PayAcct'
      'Group By PayBy'
      'Order By Payby'
      '')
    Left = 74
    Top = 366
    object SummaryQueryPayby: TStringField
      FieldName = 'Payby'
      Size = 25
    end
    object SummaryQueryAmount: TFloatField
      FieldName = 'Amount'
      ReadOnly = True
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
    Left = 48
    Top = 124
  end
end
