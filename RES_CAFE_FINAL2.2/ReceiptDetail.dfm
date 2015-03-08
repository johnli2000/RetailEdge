object ReceiptsDetailList: TReceiptsDetailList
  Left = 386
  Top = 258
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Receipts Detail List'
  ClientHeight = 354
  ClientWidth = 605
  Color = clWindow
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
  object DBGridPanel: TbsSkinPanel
    Left = 6
    Top = 6
    Width = 579
    Height = 280
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
      Width = 577
      Height = 278
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
      FixedColor = 15389375
      Options = [dgTitles, dgIndicator, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
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
          FieldName = 'OrderNoStr'
          Title.Alignment = taCenter
          Title.Caption = 'Order No'
          Width = 67
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'OrderDate'
          Title.Alignment = taCenter
          Title.Caption = 'Order Date'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TotalAmount'
          Title.Alignment = taCenter
          Title.Caption = 'Amount'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PaidAmount'
          Title.Alignment = taCenter
          Title.Caption = 'Paid Amount'
          Width = 75
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'AccountDate'
          Title.Alignment = taCenter
          Title.Caption = 'Payment Date & Time'
          Width = 118
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Notes'
          Title.Alignment = taCenter
          Width = 94
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MachineID'
          Title.Alignment = taCenter
          Title.Caption = 'Machine ID'
          Visible = True
        end>
    end
  end
  object ExitButton: TXiButton
    Left = 438
    Top = 293
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
    TabOrder = 1
    OnClick = ExitButtonClick
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 14
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
      
        'Select OrderH.OrderNo, OrderDate, Amount+GST As TotalAmount, Rec' +
        'vAcct.PaidAmount,'
      '       AccountDate, PayBy, RecvAcct.MachineID'
      'From OrderH, RecvAcct'
      'Where OrderH.OrderNo=RecvAcct.OrderNo'
      'Order By OrderH.OrderNo'
      ' ')
    Left = 14
    Top = 30
    object QueryOrderNo: TStringField
      FieldName = 'OrderNo'
      Size = 10
    end
    object QueryOrderDate: TDateTimeField
      FieldName = 'OrderDate'
      DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
    end
    object QueryPaidAmount: TFloatField
      FieldName = 'PaidAmount'
    end
    object QueryTotalAmount: TFloatField
      FieldName = 'TotalAmount'
      ReadOnly = True
    end
    object QueryAccountDate: TDateTimeField
      FieldName = 'AccountDate'
      DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
    end
    object QueryPayBy: TWideStringField
      FieldName = 'PayBy'
      Size = 25
    end
    object QueryNotes: TStringField
      FieldKind = fkCalculated
      FieldName = 'Notes'
      Size = 10
      Calculated = True
    end
    object QueryMachineID: TStringField
      FieldName = 'MachineID'
      Size = 15
    end
    object QueryOrderNoStr: TStringField
      FieldKind = fkCalculated
      FieldName = 'OrderNoStr'
      Size = 10
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
    Left = 56
    Top = 56
  end
end
