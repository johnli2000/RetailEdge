object MenuItemForm: TMenuItemForm
  Left = 163
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Item Setup'
  ClientHeight = 857
  ClientWidth = 1264
  Color = clBlack
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BackPanel: TbsSkinPanel
    Left = 4
    Top = 4
    Width = 1085
    Height = 768
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
    UseSkinFont = False
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
    Caption = 'BackPanel'
    object DBGridPanel: TbsSkinPanel
      Left = 7
      Top = 4
      Width = 388
      Height = 381
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
      UseSkinFont = False
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
        Width = 386
        Height = 379
        Cursor = crArrow
        Align = alClient
        BorderStyle = bsNone
        Ctl3D = True
        DataSource = DataSource
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ImeName = '??(??) - ?????'
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        OnDrawColumnCell = DBGridDrawColumnCell
        OnDblClick = DBGridDblClick
        OnMouseMove = EditPanelMouseMove
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ItemCode'
            Title.Alignment = taCenter
            Title.Caption = 'Code'
            Width = 48
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Description1'
            Title.Alignment = taCenter
            Width = 160
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Price'
            Title.Alignment = taCenter
            Title.Caption = 'Price1'
            Width = 68
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Price1'
            Title.Alignment = taCenter
            Title.Caption = 'Price2'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Price2'
            Title.Alignment = taCenter
            Title.Caption = 'Price3'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Price3'
            Title.Alignment = taCenter
            Title.Caption = 'Price4'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Category'
            Title.Alignment = taCenter
            Width = 147
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TaxRate'
            Title.Alignment = taCenter
            Title.Caption = 'GST(%)'
            Width = 51
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Disc'
            Title.Alignment = taCenter
            Title.Caption = 'Discount'
            Width = 51
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Description2'
            Title.Alignment = taCenter
            Width = 370
            Visible = True
          end>
      end
    end
    object bsSkinPanel1: TbsSkinPanel
      Left = 7
      Top = 385
      Width = 386
      Height = 184
      HintImageIndex = 0
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
      Caption = 'bsSkinPanel1'
      object CategoryLookupBox: TDBLookupComboBox
        Left = 16
        Top = 44
        Width = 150
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ImeName = '??(??) - ?????'
        KeyField = 'Category'
        ListField = 'Category'
        ListSource = CategoryDataSource
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        OnCloseUp = CategoryLookupBoxCloseUp
      end
      object ListCheckBox: TCheckBox
        Left = 178
        Top = 75
        Width = 131
        Height = 17
        Caption = 'Include inactive items'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 5
        OnClick = ListCheckBoxClick
      end
      object InstructionCheckBox: TCheckBox
        Left = 16
        Top = 75
        Width = 136
        Height = 17
        Caption = 'Include instruction items'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        TabOrder = 4
        OnClick = InstructionCheckBoxClick
      end
      object ShowComboBox: TComboBox
        Left = 14
        Top = 99
        Width = 197
        Height = 21
        Style = csDropDownList
        ImeName = '??(??) - ?????'
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'Show Table Order Menu'
        OnChange = ShowComboBoxChange
        Items.Strings = (
          'Show Table Order Menu'
          'Show Quick Sale Menu'
          'Show Phone Order Menu')
      end
      object SearchComboBox: TComboBox
        Left = 16
        Top = 11
        Width = 313
        Height = 21
        Style = csDropDownList
        ImeName = '??(??) - ?????'
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Sort by Code'
        OnChange = SearchComboBoxChange
        Items.Strings = (
          'Sort by Code'
          'Sort by Description1'
          'Sort by Description2')
      end
      object MenuGroupDescriptionEdit: TStaticText
        Left = 178
        Top = 45
        Width = 150
        Height = 17
        AutoSize = False
        BorderStyle = sbsSingle
        Color = clWhite
        ParentColor = False
        TabOrder = 3
      end
      object DescriptionComboBox: TComboBox
        Left = 14
        Top = 131
        Width = 197
        Height = 21
        Style = csDropDownList
        ImeName = '??(??) - ?????'
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 6
        Text = 'Show Description 1'
        OnChange = DescriptionComboBoxChange
        Items.Strings = (
          'Show Description 1'
          'Show Description 2')
      end
    end
    object NewButton: TXiButton
      Left = 8
      Top = 576
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'New'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = NewButtonClick
    end
    object EditButton: TXiButton
      Left = 105
      Top = 576
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Edit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = EditButtonClick
    end
    object DeleteButton: TXiButton
      Left = 202
      Top = 576
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Delete'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = DeleteButtonClick
    end
    object InstructionButton: TXiButton
      Left = 299
      Top = 576
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Instruction'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = InstructionButtonClick
    end
    object SubMenuLinkButton: TXiButton
      Left = 8
      Top = 698
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Sub Menu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = SubMenuLinkButtonClick
    end
    object StockLinkButton: TXiButton
      Left = 306
      Top = 480
      Width = 75
      Height = 60
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
      Caption = 'Stock Link'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Visible = False
    end
    object CategorySetupButton: TXiButton
      Left = 8
      Top = 637
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Category'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = CategorySetupButtonClick
    end
    object ItemGroupSetupButton: TXiButton
      Left = 202
      Top = 698
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Group Setup'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      OnClick = ItemGroupSetupButtonClick
    end
    object ButtonLayoutButton: TXiButton
      Left = 105
      Top = 637
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Font Setup'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      OnClick = ButtonLayoutButtonClick
    end
    object PrintButton: TXiButton
      Left = 202
      Top = 637
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Print Menu'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnClick = PrintButtonClick
    end
    object PrintBarcodeButton: TXiButton
      Left = 289
      Top = 470
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Print Barcode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      Visible = False
      OnClick = PrintBarcodeButtonClick
    end
    object MenuGroupButton: TXiButton
      Left = 105
      Top = 698
      Width = 95
      Height = 60
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Menu Group'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      OnClick = MenuGroupButtonClick
    end
    object ReArrangeButton: TXiButton
      Left = 234
      Top = 488
      Width = 75
      Height = 60
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
      Caption = 'Re-Arrange'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      Visible = False
      OnClick = ReArrangeButtonClick
    end
    object ExitButton: TXiButton
      Left = 299
      Top = 637
      Width = 95
      Height = 121
      ColorFace = clWhite
      ColorGrad = clWhite
      ColorDark = clWhite
      ColorLight = clWhite
      ColorBorder = clBlack
      ColorText = clBlack
      OverColorFace = clWhite
      OverColorGrad = clWhite
      OverColorDark = clWhite
      OverColorLight = clWhite
      OverColorBorder = clBlack
      OverColorText = clBlack
      DownColorFace = clWhite
      DownColorGrad = clWhite
      DownColorDark = clWhite
      DownColorLight = clWhite
      DownColorBorder = clBlack
      DownColorText = clBlack
      DisabledColorFace = clWhite
      DisabledColorGrad = clWhite
      DisabledColorDark = clWhite
      DisabledColorLight = clWhite
      DisabledColorBorder = clBlack
      DisabledColorText = clGray
      ColorFocusRect = clWhite
      ColorScheme = csWhite
      Ctl3D = True
      Layout = blGlyphLeft
      Spacing = 4
      TransparentGlyph = True
      Gradient = True
      HotTrack = True
      Caption = 'Exit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
      OnClick = ExitButtonClick
    end
    object CategoryPanel: TbsSkinPanel
      Left = 883
      Top = 7
      Width = 150
      Height = 750
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
      Caption = 'CategoryPanel'
      object Category1: TPanelButton
        Left = 17
        Top = 67
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 0
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category2: TPanelButton
        Left = 17
        Top = 123
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 1
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category3: TPanelButton
        Left = 17
        Top = 179
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 2
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category4: TPanelButton
        Left = 17
        Top = 235
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 3
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category5: TPanelButton
        Left = 17
        Top = 292
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 4
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category6: TPanelButton
        Left = 17
        Top = 348
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 5
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category7: TPanelButton
        Left = 17
        Top = 404
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 6
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category8: TPanelButton
        Left = 17
        Top = 460
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 7
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category9: TPanelButton
        Left = 17
        Top = 517
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 8
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category10: TPanelButton
        Left = 17
        Top = 573
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 9
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category11: TPanelButton
        Left = 17
        Top = 629
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 10
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category12: TPanelButton
        Left = 553
        Top = 64
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 11
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category13: TPanelButton
        Left = 223
        Top = 121
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 12
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category14: TPanelButton
        Left = 333
        Top = 121
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 13
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category15: TPanelButton
        Left = 443
        Top = 121
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 14
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category16: TPanelButton
        Left = 553
        Top = 121
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 15
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category17: TPanelButton
        Left = 223
        Top = 178
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 16
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category18: TPanelButton
        Left = 333
        Top = 178
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 17
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category19: TPanelButton
        Left = 443
        Top = 178
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 18
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category20: TPanelButton
        Left = 553
        Top = 178
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 19
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category21: TPanelButton
        Left = 223
        Top = 235
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 20
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category22: TPanelButton
        Left = 333
        Top = 235
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 21
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category23: TPanelButton
        Left = 443
        Top = 235
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 22
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category24: TPanelButton
        Left = 553
        Top = 235
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 23
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category25: TPanelButton
        Left = 223
        Top = 292
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 24
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category26: TPanelButton
        Left = 333
        Top = 292
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 25
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category27: TPanelButton
        Left = 443
        Top = 292
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 26
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category28: TPanelButton
        Left = 553
        Top = 292
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 27
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category29: TPanelButton
        Left = 223
        Top = 349
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 28
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category30: TPanelButton
        Left = 333
        Top = 349
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 29
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category31: TPanelButton
        Left = 443
        Top = 349
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 30
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category32: TPanelButton
        Left = 553
        Top = 349
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 31
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category33: TPanelButton
        Left = 223
        Top = 406
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 32
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category34: TPanelButton
        Left = 333
        Top = 406
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 33
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category35: TPanelButton
        Left = 443
        Top = 406
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 34
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category36: TPanelButton
        Left = 553
        Top = 406
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 35
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category37: TPanelButton
        Left = 223
        Top = 463
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 36
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category38: TPanelButton
        Left = 333
        Top = 463
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 37
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category39: TPanelButton
        Left = 443
        Top = 463
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 38
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category40: TPanelButton
        Left = 553
        Top = 463
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 39
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category41: TPanelButton
        Left = 223
        Top = 520
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 40
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object Category42: TPanelButton
        Left = 333
        Top = 520
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 41
        OnClick = CategoryButtonClick
        OnDblClick = CategoryButtonDblClick
        OnMouseMove = EditPanelMouseMove
      end
      object CategoryPageUpButton: TPanelButton
        Left = 16
        Top = 11
        Width = 108
        Height = 54
        Color = clGray
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        Caption = 'Prior'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 42
        OnClick = CategoryPageUpButtonClick
      end
      object CategoryPageDownButton: TPanelButton
        Left = 17
        Top = 685
        Width = 108
        Height = 54
        Color = clGray
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        Caption = 'Next'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 43
        OnClick = CategoryPageDownButtonClick
      end
    end
    object MenuPanel: TbsSkinPanel
      Left = 414
      Top = 6
      Width = 448
      Height = 759
      HintImageIndex = 0
      TabOrder = 17
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
      Caption = 'MenuPanel'
      object Menu1: TPanelButton
        Left = 5
        Top = 6
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 0
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu2: TPanelButton
        Left = 115
        Top = 6
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 1
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu3: TPanelButton
        Left = 225
        Top = 6
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 2
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu4: TPanelButton
        Left = 335
        Top = 6
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 3
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu5: TPanelButton
        Left = 5
        Top = 63
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 4
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu6: TPanelButton
        Left = 115
        Top = 63
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 5
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu7: TPanelButton
        Left = 225
        Top = 63
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 6
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu8: TPanelButton
        Left = 335
        Top = 63
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 7
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu9: TPanelButton
        Left = 5
        Top = 120
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 8
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu10: TPanelButton
        Left = 115
        Top = 120
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 9
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu11: TPanelButton
        Left = 225
        Top = 120
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 10
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu12: TPanelButton
        Left = 335
        Top = 120
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 11
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu13: TPanelButton
        Left = 5
        Top = 177
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 12
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu14: TPanelButton
        Left = 115
        Top = 177
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 13
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu15: TPanelButton
        Left = 225
        Top = 177
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 14
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu16: TPanelButton
        Left = 335
        Top = 177
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 15
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu17: TPanelButton
        Left = 5
        Top = 234
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 16
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu18: TPanelButton
        Left = 115
        Top = 234
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 17
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu19: TPanelButton
        Left = 225
        Top = 234
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 18
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu20: TPanelButton
        Left = 335
        Top = 234
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 19
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu21: TPanelButton
        Left = 5
        Top = 291
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 20
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu22: TPanelButton
        Left = 115
        Top = 291
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 21
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu23: TPanelButton
        Left = 225
        Top = 291
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 22
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu24: TPanelButton
        Left = 335
        Top = 291
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 23
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu25: TPanelButton
        Left = 5
        Top = 348
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 24
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu26: TPanelButton
        Left = 115
        Top = 348
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 25
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu27: TPanelButton
        Left = 225
        Top = 348
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 26
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu28: TPanelButton
        Left = 335
        Top = 348
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 27
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu29: TPanelButton
        Left = 5
        Top = 405
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 28
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu30: TPanelButton
        Left = 115
        Top = 405
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 29
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu31: TPanelButton
        Left = 225
        Top = 405
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 30
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu32: TPanelButton
        Left = 335
        Top = 405
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 31
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu33: TPanelButton
        Left = 5
        Top = 462
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 32
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu34: TPanelButton
        Left = 115
        Top = 462
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 33
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu35: TPanelButton
        Left = 225
        Top = 462
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 34
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu36: TPanelButton
        Left = 335
        Top = 462
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 35
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu37: TPanelButton
        Left = 5
        Top = 519
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 36
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu38: TPanelButton
        Left = 115
        Top = 519
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 37
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object PageUpButton: TPanelButton
        Left = 225
        Top = 692
        Width = 108
        Height = 54
        Hint = 'Prior'
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Glyph.Data = {
          D60B0000424DD60B00000000000036000000280000001F0000001F0000000100
          180000000000A00B000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000080800080800000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          001818044C4C0418180400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000001818
          04343404FCFC0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000001818042525
          04BCBC04CCCC0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000001818042525049C9C
          04FCFC04ACAC0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000181804252504898904ECEC
          04ECEC04ACAC0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000181804252504898904CCCC04FCFC
          04CCCC049C9C0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000181804252504898904CCCC04FCFC04FCFC
          04CCCC0489890418180418180406060406060406060406060406060406060406
          0604060604060604060604060604060604000000000000000000000000000000
          000000000000000000000000181804252504898904CCCC04FCFC04ECEC04FCFC
          04ACAC045C5C048989049C9C049C9C049C9C049C9C049C9C049C9C049C9C049C
          9C049C9C049C9C049C9C04BCBC04181804808000000000000000000000000000
          000000000000000000181804252504898904CCCC04FCFC04BCBC04FCFC04DCDC
          047C7C04ACAC04CCCC04BCBC04BCBC04BCBC04BCBC04BCBC04BCBC04BCBC04BC
          BC04BCBC04BCBC04CCCC04FCFC04CCCC047C7C04000000000000000000000000
          000000000000181804252504898904CCCC04FCFC04CCCC04FCFC04FCFC04ACAC
          04CCCC04ECEC04CCCC04ECEC04DCDC04ECEC04DCDC04ECEC04DCDC04ECEC04DC
          DC04ECEC04ECEC04FCFC04CCCC049C9C047C7C04000000000000000000000000
          000000181804252504898904CCCC04FCFC04BCBC04FCFC04FCFC04FCFC04FCFC
          04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FC
          FC04FCFC04FCFC04ECEC04CCCC049C9C04808000000000000000000000000000
          181804252504898904CCCC04FCFC04CCCC04FCFC04FCFC04FCFC04FCFC04FCFC
          04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FC
          FC04FCFC04FCFC04ECEC04ACAC049C9C048080000000000000000000007C7C04
          252504898904CCCC04FCFC04CCCC04ECEC04FCFC04FCFC04FCFC04FCFC04FCFC
          04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FC
          FC04FCFC04FCFC04DCDC04CCCC049C9C047C7C04000000000000000000808000
          DCDC04FCFC04FCFC04ECEC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC
          04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FC
          FC04FCFC04FCFC04ECEC04ACAC049C9C048080000000000000000000007C7C04
          181804898904CCCC04FCFC04CCCC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC
          04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FC
          FC04FCFC04FCFC04DCDC04CCCC049C9C047C7C04000000000000000000000000
          060604181804898904CCCC04FCFC04BCBC04FCFC04FCFC04FCFC04FCFC04FCFC
          04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FC
          FC04FCFC04FCFC04ECEC04BCBC049C9C04808000000000000000000000000000
          0000000606041818049C9C04CCCC04FCFC04CCCC04FCFC04FCFC04FCFC04FCFC
          04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FCFC04FC
          FC04FCFC04FCFC04ECEC04BCBC049C9C047C7C04000000000000000000000000
          000000000000060604181804898904CCCC04FCFC04BCBC04FCFC04FCFC049C9C
          04CCCC04ECEC04DCDC04ECEC04DCDC04ECEC04DCDC04DCDC04ECEC04DCDC04DC
          DC04ECEC04ECEC04FCFC04CCCC04ACAC047C7C04000000000000000000000000
          000000000000000000060604181804898904CCCC04FCFC04CCCC04FCFC04ECEC
          047C7C04ACAC04BCBC04BCBC04BCBC04BCBC04BCBC04CCCC04ACAC04CCCC04BC
          BC04BCBC04BCBC04CCCC04FCFC04BCBC047C7C04000000000000000000000000
          000000000000000000000000060604181804898904CCCC04FCFC04DCDC04FCFC
          04ACAC045C5C049C9C049C9C049C9C049C9C049C9C049C9C049C9C049C9C049C
          9C049C9C049C9C049C9C04BCBC04181804808000000000000000000000000000
          000000000000000000000000000000060604181804898904CCCC04FCFC04FCFC
          04CCCC0489890406060406060406060406060406060406060406060406060406
          0604060604060604060604060604060604000000000000000000000000000000
          000000000000000000000000000000000000060604181804898904CCCC04FCFC
          04CCCC049C9C0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000606041818049C9C04ECEC
          04ECEC04ACAC0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000606041818049C9C
          04FCFC04ACAC0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000606041818
          04BCBC04CCCC0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000606
          04252504FCFC0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000606044C4C0406060400000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000080800080800000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        Spacing = 4
        TransparentGlyph = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 38
        OnClick = PageUpButtonClick
      end
      object PageDownButton: TPanelButton
        Left = 335
        Top = 692
        Width = 108
        Height = 54
        Hint = 'Next'
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Glyph.Data = {
          3A0F0000424D3A0F00000000000036000000280000001F0000001F0000000100
          200000000000040F0000C40E0000C40E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000808000FF808000FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000060604FF4C4C04FF060604FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000060604FFFCFC04FF252504FF060604FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000060604FFCCCC04FFBCBC04FF181804FF060604FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000060604FFACAC04FFFCFC04FF9C9C04FF181804FF060604FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000606
          04FFACAC04FFECEC04FFECEC04FF9C9C04FF181804FF060604FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000060604FF9C9C
          04FFCCCC04FFFCFC04FFCCCC04FF898904FF181804FF060604FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000060604FF060604FF060604FF060604FF060604FF060604FF060604FF0606
          04FF060604FF060604FF060604FF060604FF060604FF060604FF898904FFCCCC
          04FFFCFC04FFFCFC04FFCCCC04FF898904FF181804FF060604FF000000000000
          0000000000000000000000000000000000000000000000000000808000FF1818
          04FFBCBC04FF9C9C04FF9C9C04FF9C9C04FF9C9C04FF9C9C04FF9C9C04FF9C9C
          04FF9C9C04FF9C9C04FF9C9C04FF9C9C04FF9C9C04FF5C5C04FFACAC04FFFCFC
          04FFDCDC04FFFCFC04FFCCCC04FF898904FF181804FF060604FF000000000000
          000000000000000000000000000000000000000000007C7C04FFBCBC04FFFCFC
          04FFCCCC04FFBCBC04FFBCBC04FFBCBC04FFCCCC04FFACAC04FFCCCC04FFBCBC
          04FFBCBC04FFBCBC04FFBCBC04FFBCBC04FFACAC04FF7C7C04FFECEC04FFFCFC
          04FFCCCC04FFFCFC04FFCCCC04FF898904FF181804FF060604FF000000000000
          0000000000000000000000000000000000007C7C04FFACAC04FFCCCC04FFFCFC
          04FFECEC04FFECEC04FFDCDC04FFDCDC04FFECEC04FFDCDC04FFDCDC04FFECEC
          04FFDCDC04FFECEC04FFDCDC04FFECEC04FFCCCC04FF9C9C04FFFCFC04FFFCFC
          04FFBCBC04FFFCFC04FFCCCC04FF898904FF181804FF060604FF000000000000
          00000000000000000000000000007C7C04FF9C9C04FFBCBC04FFECEC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFCCCC04FFFCFC04FFCCCC04FF9C9C04FF181804FF060604FF000000000000
          00000000000000000000808000FF9C9C04FFBCBC04FFECEC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFBCBC04FFFCFC04FFCCCC04FF898904FF181804FF060604FF000000000000
          0000000000007C7C04FF9C9C04FFCCCC04FFDCDC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFCCCC04FFFCFC04FFCCCC04FF898904FF181804FF7C7C04FF000000000000
          0000808000FF9C9C04FFACAC04FFECEC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFECEC04FFFCFC04FFFCFC04FFDCDC04FF808000FF00000000000000007C7C
          04FF9C9C04FFCCCC04FFDCDC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFECEC04FFCCCC04FFFCFC
          04FFCCCC04FF898904FF252504FF7C7C04FF0000000000000000808000FF9C9C
          04FFACAC04FFECEC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFCCCC04FFFCFC04FFCCCC04FF8989
          04FF252504FF181804FF000000000000000000000000808000FF9C9C04FFCCCC
          04FFECEC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC04FFFCFC
          04FFFCFC04FFFCFC04FFBCBC04FFFCFC04FFCCCC04FF898904FF252504FF1818
          04FF000000000000000000000000000000007C7C04FF9C9C04FFCCCC04FFFCFC
          04FFECEC04FFECEC04FFDCDC04FFECEC04FFDCDC04FFECEC04FFDCDC04FFECEC
          04FFDCDC04FFECEC04FFCCCC04FFECEC04FFCCCC04FFACAC04FFFCFC04FFFCFC
          04FFCCCC04FFFCFC04FFCCCC04FF898904FF252504FF181804FF000000000000
          00000000000000000000000000007C7C04FFCCCC04FFFCFC04FFCCCC04FFBCBC
          04FFBCBC04FFBCBC04FFBCBC04FFBCBC04FFBCBC04FFBCBC04FFBCBC04FFBCBC
          04FFBCBC04FFCCCC04FFACAC04FF7C7C04FFDCDC04FFFCFC04FFBCBC04FFFCFC
          04FFCCCC04FF898904FF252504FF181804FF0000000000000000000000000000
          00000000000000000000808000FF181804FFBCBC04FF9C9C04FF9C9C04FF9C9C
          04FF9C9C04FF9C9C04FF9C9C04FF9C9C04FF9C9C04FF9C9C04FF9C9C04FF9C9C
          04FF898904FF5C5C04FFACAC04FFFCFC04FFECEC04FFFCFC04FFCCCC04FF8989
          04FF252504FF181804FF00000000000000000000000000000000000000000000
          00000000000000000000060604FF060604FF060604FF060604FF060604FF0606
          04FF060604FF060604FF060604FF060604FF060604FF060604FF181804FF1818
          04FF898904FFCCCC04FFFCFC04FFFCFC04FFCCCC04FF898904FF252504FF1818
          04FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000060604FF9C9C
          04FFCCCC04FFFCFC04FFCCCC04FF898904FF252504FF181804FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000060604FFACAC04FFECEC
          04FFECEC04FF898904FF252504FF181804FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000060604FFACAC04FFFCFC04FF9C9C
          04FF252504FF181804FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000060604FFCCCC04FFBCBC04FF252504FF1818
          04FF000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000060604FFFCFC04FF343404FF181804FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000181804FF4C4C04FF181804FF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000808000FF808000FF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000}
        Spacing = 4
        TransparentGlyph = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 39
        OnClick = PageDownButtonClick
      end
      object Menu39: TPanelButton
        Left = 225
        Top = 519
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 40
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu40: TPanelButton
        Left = 335
        Top = 519
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 41
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu41: TPanelButton
        Left = 5
        Top = 576
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 42
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu42: TPanelButton
        Left = 115
        Top = 576
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 43
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu47: TPanelButton
        Left = 226
        Top = 635
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 44
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu50: TPanelButton
        Left = 115
        Top = 693
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 45
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu49: TPanelButton
        Left = 5
        Top = 693
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 46
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu48: TPanelButton
        Left = 336
        Top = 635
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 47
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu46: TPanelButton
        Left = 116
        Top = 635
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 48
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu45: TPanelButton
        Left = 6
        Top = 635
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 49
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu44: TPanelButton
        Left = 336
        Top = 578
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 50
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
      object Menu43: TPanelButton
        Left = 226
        Top = 578
        Width = 108
        Height = 54
        Color = clSilver
        Ctl3D = True
        Layout = blGlyphLeft
        Spacing = 4
        TransparentGlyph = True
        TabOrder = 51
        OnClick = MenuButtonClick
        OnDblClick = MenuButtonClick
        OnMouseMove = EditPanelMouseMove
      end
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 18
    Top = 148
  end
  object CategoryDataSource: TDataSource
    AutoEdit = False
    DataSet = CategoryQuery
    Left = 110
    Top = 148
  end
  object Query: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=Hospitality;Data Source=CHARLESPC'
    CursorType = ctStatic
    LockType = ltUnspecified
    OnCalcFields = QueryCalcFields
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select * From MenuItem')
    Left = 48
    Top = 148
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
    object QueryCategory: TStringField
      FieldName = 'Category'
      Size = 25
    end
    object QueryControl: TStringField
      FieldKind = fkCalculated
      FieldName = 'Control'
      Calculated = True
    end
    object QueryTaxRate: TFloatField
      FieldName = 'TaxRate'
      DisplayFormat = '0.#0'
    end
    object QueryDescription2: TStringField
      FieldName = 'Description2'
      Size = 100
    end
    object QueryDisc: TStringField
      FieldKind = fkCalculated
      FieldName = 'Disc'
      Size = 3
      Calculated = True
    end
    object QueryPrice1: TFloatField
      FieldName = 'Price1'
    end
    object QueryPrice2: TFloatField
      FieldName = 'Price2'
    end
    object QueryPrice3: TFloatField
      FieldName = 'Price3'
    end
    object QueryInstruction: TBooleanField
      FieldName = 'Instruction'
    end
    object QueryAllowDiscount: TBooleanField
      FieldName = 'AllowDiscount'
    end
    object QueryBarCode: TStringField
      FieldName = 'BarCode'
      Size = 30
    end
    object QueryBarCode1: TStringField
      FieldName = 'BarCode1'
      Size = 30
    end
    object QueryBarCode2: TStringField
      FieldName = 'BarCode2'
      Size = 30
    end
    object QueryBarCode3: TStringField
      FieldName = 'BarCode3'
      Size = 30
    end
    object QueryButtonColor: TIntegerField
      FieldName = 'ButtonColor'
    end
    object QueryFontColor: TIntegerField
      FieldName = 'FontColor'
    end
    object QueryJobListColor: TSmallintField
      FieldName = 'JobListColor'
    end
    object QueryMultiple: TBooleanField
      FieldName = 'Multiple'
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
    object QueryActive: TBooleanField
      FieldName = 'Active'
    end
    object QueryPrinterPort: TSmallintField
      FieldName = 'PrinterPort'
    end
    object QueryFontName: TStringField
      FieldName = 'FontName'
      Size = 50
    end
    object QueryFontSize: TIntegerField
      FieldName = 'FontSize'
    end
    object QueryFontBold: TBooleanField
      FieldName = 'FontBold'
    end
    object QueryFontItalic: TBooleanField
      FieldName = 'FontItalic'
    end
    object QueryFontUnderline: TBooleanField
      FieldName = 'FontUnderline'
    end
    object QueryFontStrikeout: TBooleanField
      FieldName = 'FontStrikeout'
    end
    object QueryOpenPrice: TBooleanField
      FieldName = 'OpenPrice'
    end
    object QueryPrinterPort1: TIntegerField
      FieldName = 'PrinterPort1'
    end
    object QueryPrinterPort2: TIntegerField
      FieldName = 'PrinterPort2'
    end
    object QueryHappyHourPrice1: TFloatField
      FieldName = 'HappyHourPrice1'
    end
    object QueryHappyHourPrice2: TFloatField
      FieldName = 'HappyHourPrice2'
    end
    object QueryHappyHourPrice3: TFloatField
      FieldName = 'HappyHourPrice3'
    end
    object QueryHappyHourPrice4: TFloatField
      FieldName = 'HappyHourPrice4'
    end
    object QueryDefaultQty: TFloatField
      FieldName = 'DefaultQty'
    end
    object QueryMainPosition: TIntegerField
      FieldName = 'MainPosition'
    end
    object QueryPOSPosition: TIntegerField
      FieldName = 'POSPosition'
    end
    object QueryPhoneOrderPosition: TIntegerField
      FieldName = 'PhoneOrderPosition'
    end
    object QueryFontSize1: TIntegerField
      FieldName = 'FontSize1'
    end
    object QueryButtonColor1: TIntegerField
      FieldName = 'ButtonColor1'
    end
    object QueryFontName1: TWideStringField
      FieldName = 'FontName1'
      Size = 50
    end
    object QueryFontColor1: TIntegerField
      FieldName = 'FontColor1'
    end
    object QueryFontBold1: TBooleanField
      FieldName = 'FontBold1'
    end
    object QueryFontItalic1: TBooleanField
      FieldName = 'FontItalic1'
    end
    object QueryFontUnderline1: TBooleanField
      FieldName = 'FontUnderline1'
    end
    object QueryFontStrikeout1: TBooleanField
      FieldName = 'FontStrikeout1'
    end
  end
  object CategoryQuery: TADOQuery
    Connection = DataForm.ADOConnection
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select * From category')
    Left = 78
    Top = 148
  end
end
