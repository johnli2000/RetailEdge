object DepositPaymentForm: TDepositPaymentForm
  Left = 440
  Top = 212
  AutoScroll = False
  BorderIcons = []
  Caption = 'Deposit List'
  ClientHeight = 231
  ClientWidth = 614
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
    Width = 586
    Height = 152
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
      Width = 584
      Height = 150
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = DataSource
      FixedColor = 15389375
      Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect]
      ParentCtl3D = False
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
          FieldName = 'DepositDate'
          Title.Alignment = taCenter
          Title.Caption = 'Deposit Date'
          Width = 137
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PaymentMethod'
          Title.Alignment = taCenter
          Title.Caption = 'Method'
          Width = 170
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DepositAmount'
          Title.Alignment = taCenter
          Title.Caption = 'Deposit'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PaidAmount'
          Title.Alignment = taCenter
          Title.Caption = 'Paid Amount'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Balance'
          Title.Alignment = taCenter
          Width = 80
          Visible = True
        end>
    end
  end
  object ConfirmButton: TXiButton
    Left = 340
    Top = 166
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
    Caption = 'OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = ConfirmButtonClick
  end
  object CancelButton: TXiButton
    Left = 449
    Top = 166
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
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = CancelButtonClick
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
    Left = 256
    Top = 28
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 288
    Top = 28
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    CursorType = ctStatic
    LockType = ltUnspecified
    OnCalcFields = QueryCalcFields
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select DepositTable.VIPNo, DepositDate, Amount As DepositAmount,'
      '       PaymentMethod, ID, TempTable.PaidAmount'
      'From DepositTable,'
      
        '     (Select DepositID, Sum(PaidAmount) As PaidAmount From RecvA' +
        'cct'
      '     Where DepositID > 0'
      '     Group By DepositID) As TempTable'
      'Where DepositTable.ID *= TempTable.DepositID')
    Left = 320
    Top = 28
    object QueryDepositDate: TDateTimeField
      FieldName = 'DepositDate'
    end
    object QueryDepositAmount: TFloatField
      FieldName = 'DepositAmount'
    end
    object QueryPaymentMethod: TWideStringField
      FieldName = 'PaymentMethod'
      Size = 25
    end
    object QueryID: TIntegerField
      FieldName = 'ID'
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
end
