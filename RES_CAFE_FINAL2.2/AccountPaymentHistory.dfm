object AccountPaymentHistoryForm: TAccountPaymentHistoryForm
  Left = 373
  Top = 157
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Account Payment History'
  ClientHeight = 482
  ClientWidth = 718
  Color = clWindow
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
    Width = 699
    Height = 408
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
      Width = 697
      Height = 406
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
          Title.Caption = 'Order No'
          Width = 83
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'OrderDate'
          Title.Alignment = taCenter
          Title.Caption = 'Order Date'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OrderAmount'
          Title.Alignment = taCenter
          Title.Caption = 'Order Amount'
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PaidAmount'
          Title.Alignment = taCenter
          Title.Caption = 'Paid Amount'
          Width = 84
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'AccountDate'
          Title.Alignment = taCenter
          Title.Caption = 'Payment Date'
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PayBy'
          Title.Alignment = taCenter
          Title.Caption = 'Payment Method'
          Visible = True
        end>
    end
  end
  object ControlPanel: TbsSkinPanel
    Left = 6
    Top = 416
    Width = 215
    Height = 45
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
    Caption = 'ControlPanel'
    object DateCheckBox: TCheckBox
      Left = 20
      Top = 14
      Width = 93
      Height = 17
      Caption = 'Payment Date'
      Color = 15389375
      ParentColor = False
      TabOrder = 0
      OnClick = DateCheckBoxClick
    end
    object DateEdit: TMaskEdit
      Left = 122
      Top = 13
      Width = 65
      Height = 19
      Enabled = False
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnClick = DateEditClick
    end
  end
  object PrintButton: TXiButton
    Left = 444
    Top = 422
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
    TabOrder = 2
    OnClick = PrintButtonClick
  end
  object ExitButton: TXiButton
    Left = 554
    Top = 422
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
    TabOrder = 3
    OnClick = ExitButtonClick
  end
  object Query: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Hospitality;Data Source=CHARLES-PC'
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      
        'Select OrderH.OrderNo, OrderDate, Amount + ServiceCharge As Orde' +
        'rAmount,'
      '       RecvAcct.PaidAmount, AccountDate, PayBy, IDNo'
      'From OrderH, RecvAcct'
      'Where OrderH.OrderNo=RecvAcct.OrderNo'
      'Order By OrderH.OrderNo        ')
    Left = 70
    Top = 42
    object QueryOrderNo: TStringField
      DisplayWidth = 17
      FieldName = 'OrderNo'
      Size = 10
    end
    object QueryOrderDate: TDateTimeField
      DisplayWidth = 22
      FieldName = 'OrderDate'
      DisplayFormat = 'dd/mm/yyyy hh:mm'
    end
    object QueryOrderAmount: TFloatField
      DisplayWidth = 13
      FieldName = 'OrderAmount'
      ReadOnly = True
      DisplayFormat = '$,0.#0'
    end
    object QueryPaidAmount: TFloatField
      DisplayWidth = 12
      FieldName = 'PaidAmount'
      DisplayFormat = '$,0.#0'
    end
    object QueryAccountDate: TDateTimeField
      DisplayWidth = 22
      FieldName = 'AccountDate'
      DisplayFormat = 'dd/mm/yyyy hh:mm'
    end
    object QueryPayBy: TStringField
      DisplayWidth = 30
      FieldName = 'PayBy'
      Size = 25
    end
    object QueryIDNo: TIntegerField
      FieldName = 'IDNo'
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 40
    Top = 42
  end
  object VIPQuery: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 102
    Top = 42
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
    Left = 136
    Top = 44
  end
end
