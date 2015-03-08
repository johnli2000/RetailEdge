object BookingNoSelectForm: TBookingNoSelectForm
  Left = 491
  Top = 333
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Reservation Detail'
  ClientHeight = 207
  ClientWidth = 638
  Color = clTeal
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
    Width = 598
    Height = 133
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
      Width = 596
      Height = 131
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      DataSource = DataSource
      FixedColor = 15389375
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CustomerName'
          Title.Alignment = taCenter
          Title.Caption = 'Customer'
          Width = 158
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'TableNo'
          Title.Alignment = taCenter
          Title.Caption = 'Table No.'
          Width = 170
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'BookingDate'
          Title.Alignment = taCenter
          Title.Caption = 'Reserve Date & Time'
          Width = 153
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Persons'
          Title.Alignment = taCenter
          Width = 76
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'Telephone'
          Title.Alignment = taCenter
          Width = 100
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'BookingNo'
          Title.Alignment = taCenter
          Title.Caption = 'Reserve No'
          Width = 87
          Visible = True
        end>
    end
  end
  object ConfirmButton: TXiButton
    Left = 328
    Top = 147
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
    Left = 437
    Top = 147
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
  object DataSource: TDataSource
    DataSet = Query
    Left = 6
    Top = 142
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
      
        'Select TableNo, BookingDate, Persons, CustomerName, Telephone, B' +
        'ookingNo From BookTable'
      '')
    Left = 36
    Top = 140
    object QueryTableNo: TStringField
      FieldName = 'TableNo'
      Size = 10
    end
    object QueryBookingDate: TDateTimeField
      FieldName = 'BookingDate'
      DisplayFormat = 'dd/mm/yyyy  hh:mm AM/PM'
    end
    object QueryPersons: TIntegerField
      FieldName = 'Persons'
    end
    object QueryCustomerName: TStringField
      FieldName = 'CustomerName'
      Size = 30
    end
    object QueryTelephone: TStringField
      FieldName = 'Telephone'
      Size = 15
    end
    object QueryBookingNo: TStringField
      FieldName = 'BookingNo'
      Size = 8
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
    Left = 70
    Top = 140
  end
end
