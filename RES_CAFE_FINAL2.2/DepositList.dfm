object DepositListForm: TDepositListForm
  Left = 364
  Top = 145
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Deposit List'
  ClientHeight = 639
  ClientWidth = 882
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
    Width = 862
    Height = 491
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
      Height = 489
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
      OnDblClick = EditButtonClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DepositDate'
          Title.Alignment = taCenter
          Title.Caption = 'Date'
          Width = 122
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'VIPNo'
          Title.Alignment = taCenter
          Title.Caption = 'V.I.P. No.'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VIPName'
          Title.Alignment = taCenter
          Title.Caption = 'V.I.P. Name'
          Width = 178
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PaymentMethod'
          Title.Alignment = taCenter
          Title.Caption = 'Method'
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Amount'
          Title.Alignment = taCenter
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PaidAmount'
          Title.Alignment = taCenter
          Title.Caption = 'Paid Amount'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Balance'
          Title.Alignment = taCenter
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OpName'
          Title.Alignment = taCenter
          Title.Caption = 'Operator'
          Width = 159
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MachineID'
          Title.Alignment = taCenter
          Title.Caption = 'Machine ID'
          Width = 107
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ID'
          Title.Alignment = taCenter
          Width = 79
          Visible = True
        end>
    end
  end
  object ControlPanel: TbsSkinPanel
    Left = 6
    Top = 497
    Width = 862
    Height = 72
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
      Left = 136
      Top = 16
      Width = 13
      Height = 13
      Caption = 'To'
      Color = 15389375
      ParentColor = False
    end
    object Label2: TLabel
      Left = 679
      Top = 9
      Width = 63
      Height = 13
      Caption = 'Total Deposit'
      Color = 15389375
      ParentColor = False
    end
    object Label3: TLabel
      Left = 682
      Top = 29
      Width = 60
      Height = 13
      Caption = 'Paid Amount'
    end
    object Label4: TLabel
      Left = 702
      Top = 49
      Width = 39
      Height = 13
      Caption = 'Balance'
    end
    object DateCheckBox: TCheckBox
      Left = 14
      Top = 14
      Width = 47
      Height = 17
      Caption = 'Date'
      Color = 15389375
      ParentColor = False
      TabOrder = 0
      OnClick = DateCheckBoxClick
    end
    object DateEdit1: TMaskEdit
      Left = 66
      Top = 12
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnClick = DateEditClick
    end
    object DateEdit2: TMaskEdit
      Left = 154
      Top = 12
      Width = 65
      Height = 19
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnClick = DateEditClick
    end
    object OperatorCheckBox: TCheckBox
      Left = 226
      Top = 14
      Width = 64
      Height = 17
      Caption = 'Operator'
      Color = 15389375
      ParentColor = False
      TabOrder = 3
      OnClick = OperatorCheckBoxClick
    end
    object TotalDepositEdit: TStaticText
      Left = 748
      Top = 7
      Width = 90
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 4
    end
    object VIPCheckBox: TCheckBox
      Left = 14
      Top = 43
      Width = 47
      Height = 17
      Caption = 'V.I.P.'
      Color = 15389375
      ParentColor = False
      TabOrder = 5
      OnClick = VIPCheckBoxClick
    end
    object VIPNoEdit: TStaticText
      Left = 64
      Top = 42
      Width = 67
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSingle
      Enabled = False
      TabOrder = 6
      OnClick = VIPNoEditClick
    end
    object VIPNameEdit: TStaticText
      Left = 136
      Top = 42
      Width = 329
      Height = 17
      AutoSize = False
      BorderStyle = sbsSingle
      TabOrder = 7
    end
    object OperatorEdit: TStaticText
      Left = 293
      Top = 13
      Width = 172
      Height = 17
      AutoSize = False
      BorderStyle = sbsSingle
      TabOrder = 8
      OnClick = OperatorEditClick
    end
    object PaidAmountEdit: TStaticText
      Left = 748
      Top = 27
      Width = 90
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 9
    end
    object BalanceEdit: TStaticText
      Left = 748
      Top = 47
      Width = 90
      Height = 17
      Alignment = taRightJustify
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 10
    end
  end
  object SearchButton: TXiButton
    Left = 48
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
  object EditButton: TXiButton
    Left = 152
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
    Caption = 'Edit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = EditButtonClick
  end
  object DeleteButton: TXiButton
    Left = 256
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
    Caption = 'Delete'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = DeleteButtonClick
  end
  object PrintButton: TXiButton
    Left = 360
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
    TabOrder = 5
    OnClick = PrintButtonClick
  end
  object ExitButton: TXiButton
    Left = 736
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
    TabOrder = 6
    OnClick = ExitButtonClick
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 42
    Top = 68
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    OnCalcFields = QueryCalcFields
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      
        'Select DepositTable.VIPNo, DepositDate, Amount, PaymentMethod, D' +
        'epositTable.MachineID, DepositTable.OpName,'
      '       ID, VIPName, Sum(RecvAcct.PaidAmount) As PaidAmount'
      
        'From VIPTable Join DepositTable On DepositTable.VIPNo=VIPTable.V' +
        'IPNo Left Join RecvAcct On DepositID=ID'
      
        'Group By DepositTable.VIPNo, DepositDate, Amount, PaymentMethod,' +
        ' DepositTable.MachineID, DepositTable.OpName,'
      '      ID, VIPName'
      '')
    Left = 84
    Top = 74
    object QueryVIPNo: TIntegerField
      FieldName = 'VIPNo'
      DisplayFormat = '#0000000#'
    end
    object QueryDepositDate: TDateTimeField
      FieldName = 'DepositDate'
      DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
    end
    object QueryAmount: TFloatField
      FieldName = 'Amount'
      DisplayFormat = '$,0.#0'
    end
    object QueryPaymentMethod: TStringField
      FieldName = 'PaymentMethod'
      Size = 25
    end
    object QueryMachineID: TStringField
      FieldName = 'MachineID'
      Size = 15
    end
    object QueryOpName: TStringField
      FieldName = 'OpName'
      Size = 15
    end
    object QueryID: TIntegerField
      FieldName = 'ID'
      DisplayFormat = '#00000000#'
    end
    object QueryVIPName: TStringField
      FieldName = 'VIPName'
      Size = 30
    end
    object QueryPaidAmount: TFloatField
      FieldName = 'PaidAmount'
    end
    object QueryBalance: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Balance'
      Calculated = True
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
    Left = 38
    Top = 154
  end
end
