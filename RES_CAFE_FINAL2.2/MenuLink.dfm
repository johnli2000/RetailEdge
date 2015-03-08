object MenuLinkForm: TMenuLinkForm
  Left = 329
  Top = 85
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Menu Link'
  ClientHeight = 582
  ClientWidth = 883
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
    Width = 337
    Height = 407
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
      Width = 335
      Height = 405
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource
      FixedColor = 15389375
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnDblClick = DBGridDblClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ItemCode'
          Title.Alignment = taCenter
          Title.Caption = 'Code'
          Width = 42
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Description1'
          Title.Alignment = taCenter
          Title.Caption = 'Description'
          Width = 261
          Visible = True
        end>
    end
  end
  object SearchPanel: TbsSkinPanel
    Left = 6
    Top = 415
    Width = 337
    Height = 103
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
    Caption = 'SearchPanel'
    object SearchComboBox: TComboBox
      Left = 10
      Top = 39
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'Search by code'
      OnChange = SearchComboBoxChange
      Items.Strings = (
        'Search by code'
        'Search by description')
    end
    object SearchEdit: TEdit
      Left = 10
      Top = 13
      Width = 311
      Height = 19
      TabOrder = 0
      OnChange = SearchEditChange
    end
    object InstructionCheckBox: TCheckBox
      Left = 185
      Top = 39
      Width = 137
      Height = 20
      Caption = 'Only list instruction items'
      TabOrder = 2
      OnClick = InstructionCheckBoxClick
    end
    object CategoryCheckBox: TCheckBox
      Left = 10
      Top = 73
      Width = 65
      Height = 17
      Caption = 'Category'
      TabOrder = 3
      OnClick = CategoryCheckBoxClick
    end
    object CategoryEdit: TEdit
      Left = 76
      Top = 72
      Width = 245
      Height = 19
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      OnClick = CategoryEditClick
    end
  end
  object TitlePanel: TbsSkinPanel
    Left = 346
    Top = 6
    Width = 521
    Height = 88
    TabOrder = 3
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
    Caption = 'TitlePanel'
    object bsSkinStdLabel1: TbsSkinStdLabel
      Left = 18
      Top = 40
      Width = 85
      Height = 13
      UseSkinFont = False
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = -11
      DefaultFont.Name = 'MS Sans Serif'
      DefaultFont.Style = []
      SkinData = MainForm.bsSkinData
      SkinDataName = 'stdlabel'
      Caption = 'Number of Choice'
    end
    object ItemCodeLabel: TbsSkinLabel
      Left = 16
      Top = 10
      Width = 55
      Height = 21
      TabOrder = 0
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      UseSkinSize = True
      BorderStyle = bvFrame
      AutoSize = False
    end
    object ItemDescriptionLabel: TbsSkinLabel
      Left = 76
      Top = 10
      Width = 427
      Height = 21
      TabOrder = 1
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      UseSkinSize = True
      BorderStyle = bvFrame
      AutoSize = False
    end
    object NumberOfChoiceLabel: TbsSkinLabel
      Left = 108
      Top = 36
      Width = 50
      Height = 21
      TabOrder = 2
      SkinData = MainForm.bsSkinData
      SkinDataName = 'label'
      DefaultFont.Charset = DEFAULT_CHARSET
      DefaultFont.Color = clWindowText
      DefaultFont.Height = 14
      DefaultFont.Name = 'Arial'
      DefaultFont.Style = []
      DefaultWidth = 0
      DefaultHeight = 0
      UseSkinFont = True
      UseSkinSize = True
      BorderStyle = bvFrame
      Alignment = taRightJustify
      AutoSize = False
      OnClick = NumberOfChoiceLabelClick
    end
    object SubCategoryCheckBox: TCheckBox
      Left = 172
      Top = 39
      Width = 185
      Height = 17
      Caption = 'Set this main item as Sub-Category'
      TabOrder = 3
    end
    object AutoShowSubMenuCheckBox: TCheckBox
      Left = 18
      Top = 63
      Width = 469
      Height = 17
      Caption = 
        'Do not show the following item(s) on  the Sub-Menu Panel and dir' +
        'ect link to next sub menu'
      TabOrder = 4
    end
  end
  object StringGridPanel: TbsSkinPanel
    Left = 346
    Top = 96
    Width = 521
    Height = 422
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
    Caption = 'StringGridPanel'
    object StringGrid: TStringGrid
      Left = 1
      Top = 1
      Width = 519
      Height = 420
      Align = alClient
      BorderStyle = bsNone
      DefaultRowHeight = 20
      FixedColor = 15389375
      RowCount = 201
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRangeSelect, goRowSelect]
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnDblClick = StringGridDblClick
      OnDrawCell = StringGridDrawCell
      ColWidths = (
        46
        290
        55
        52
        52)
      RowHeights = (
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20
        20)
    end
  end
  object NewButton: TXiButton
    Left = 32
    Top = 525
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
    Caption = 'New Item'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = NewButtonClick
  end
  object InsertButton: TXiButton
    Left = 396
    Top = 525
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
    Caption = 'Add'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = InsertButtonClick
  end
  object DeleteButton: TXiButton
    Left = 500
    Top = 525
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
    TabOrder = 6
    OnClick = DeleteButtonClick
  end
  object SaveButton: TXiButton
    Left = 640
    Top = 525
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
    Caption = 'Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = SaveButtonClick
  end
  object CancelButton: TXiButton
    Left = 744
    Top = 525
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
    TabOrder = 8
    OnClick = CancelButtonClick
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 17
    Top = 60
  end
  object Query: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Hospitality;Data Source=CHARLES-PC'
    CursorType = ctStatic
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select ItemCode, Description1, Price , Instruction From MenuItem'
      'Order By ItemCode')
    Left = 46
    Top = 60
    object QueryItemCode: TStringField
      FieldName = 'ItemCode'
      Size = 4
    end
    object QueryDescription1: TStringField
      FieldName = 'Description1'
      Size = 100
    end
    object QueryPrice: TFloatField
      FieldName = 'Price'
    end
    object QueryInstruction: TBooleanField
      FieldName = 'Instruction'
    end
  end
  object TempQuery: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 76
    Top = 60
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
    Left = 66
    Top = 118
  end
end
