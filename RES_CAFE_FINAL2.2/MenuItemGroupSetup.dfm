object MenuItemGroupSetupForm: TMenuItemGroupSetupForm
  Left = 422
  Top = 159
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Menu Item Group Setting'
  ClientHeight = 483
  ClientWidth = 708
  Color = 15389375
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EditPanel: TbsSkinPanel
    Left = 6
    Top = 6
    Width = 691
    Height = 411
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
    Caption = 'EditPanel'
    object Label11: TLabel
      Left = 10
      Top = 19
      Width = 42
      Height = 13
      Caption = 'Category'
      Color = 15389375
      ParentColor = False
    end
    object PrintGroupBox: TGroupBox
      Left = 10
      Top = 64
      Width = 222
      Height = 138
      Caption = ' Send To Printer '
      Color = 15389375
      ParentColor = False
      TabOrder = 2
      object PrinterPortComboBox: TComboBox
        Left = 20
        Top = 22
        Width = 180
        Height = 21
        Style = csDropDownList
        DropDownCount = 9
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'N/A'
          'Kitchen Printer 1'
          'Kitchen Printer 2'
          'Kitchen Printer 3'
          'Kitchen Printer 4'
          'Kitchen Printer 5'
          'Kitchen Printer 6'
          'Kitchen Printer 7'
          'Kitchen Printer 8'
          'Kitchen Printer 9'
          'Kitchen Printer 10'
          'Kitchen Printer 11'
          'Kitchen Printer 12')
      end
      object PrinterPortComboBox1: TComboBox
        Left = 20
        Top = 48
        Width = 180
        Height = 21
        Style = csDropDownList
        DropDownCount = 9
        ItemHeight = 13
        TabOrder = 2
        Items.Strings = (
          'N/A'
          'Kitchen Printer 1'
          'Kitchen Printer 2'
          'Kitchen Printer 3'
          'Kitchen Printer 4'
          'Kitchen Printer 5'
          'Kitchen Printer 6'
          'Kitchen Printer 7'
          'Kitchen Printer 8'
          'Kitchen Printer 9'
          'Kitchen Printer 10'
          'Kitchen Printer 11'
          'Kitchen Printer 12')
      end
      object PrinterPortComboBox2: TComboBox
        Left = 20
        Top = 74
        Width = 180
        Height = 21
        Style = csDropDownList
        DropDownCount = 9
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          'N/A'
          'Kitchen Printer 1'
          'Kitchen Printer 2'
          'Kitchen Printer 3'
          'Kitchen Printer 4'
          'Kitchen Printer 5'
          'Kitchen Printer 6'
          'Kitchen Printer 7'
          'Kitchen Printer 8'
          'Kitchen Printer 9'
          'Kitchen Printer 10'
          'Kitchen Printer 11'
          'Kitchen Printer 12')
      end
      object PrinterPortComboBox3: TComboBox
        Left = 20
        Top = 100
        Width = 180
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        Items.Strings = (
          'N/A'
          'Kitchen Printer 1'
          'Kitchen Printer 2'
          'Kitchen Printer 3'
          'Kitchen Printer 4'
          'Kitchen Printer 5'
          'Kitchen Printer 6'
          'Kitchen Printer 7'
          'Kitchen Printer 8'
          'Kitchen Printer 9'
          'Kitchen Printer 10'
          'Kitchen Printer 11'
          'Kitchen Printer 12')
      end
    end
    object PrinterSetupCheckBox: TCheckBox
      Left = 10
      Top = 45
      Width = 125
      Height = 17
      Caption = 'Kitchen Printer Setup'
      Color = 15389375
      ParentColor = False
      TabOrder = 1
      OnClick = PrinterSetupCheckBoxClick
    end
    object KitchenScreenSetupCheckBox: TCheckBox
      Left = 10
      Top = 212
      Width = 159
      Height = 17
      Caption = ' Kitchen Screen Setup'
      Color = 15389375
      ParentColor = False
      TabOrder = 3
      OnClick = KitchenScreenSetupCheckBoxClick
    end
    object KitchenScreenGroupBox: TGroupBox
      Left = 10
      Top = 231
      Width = 222
      Height = 168
      Caption = ' Send To Screen '
      Color = 15389375
      ParentColor = False
      TabOrder = 4
      object ColorButton: TbsSkinSpeedButton
        Left = 160
        Top = 128
        Width = 41
        Height = 31
        SkinData = MainForm.bsSkinData
        SkinDataName = 'button'
        DefaultFont.Charset = DEFAULT_CHARSET
        DefaultFont.Color = clWindowText
        DefaultFont.Height = -11
        DefaultFont.Name = 'Arial'
        DefaultFont.Style = [fsBold]
        DefaultWidth = 0
        DefaultHeight = 0
        UseSkinFont = False
        WidthWithCaption = 20
        WidthWithoutCaption = 0
        ImageIndex = 0
        RepeatMode = False
        RepeatInterval = 100
        Transparent = False
        Flat = False
        AllowAllUp = False
        Down = False
        GroupIndex = 0
        Caption = 'Color'
        ShowCaption = True
        NumGlyphs = 1
        Spacing = 1
        OnClick = ColorButtonClick
      end
      object KitchenScreenFontColorPanel: TPanel
        Left = 22
        Top = 128
        Width = 87
        Height = 31
        BorderStyle = bsSingle
        Caption = 'Font Color'
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object KitchenScreenComboBox1: TComboBox
        Left = 22
        Top = 22
        Width = 180
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          'N/A'
          'Kitchen Screen 1'
          'Kitchen Screen 2'
          'Kitchen Screen 3'
          'Kitchen Screen 4'
          'Kitchen Screen 5'
          'Kitchen Screen 6'
          'Kitchen Screen 7'
          'Kitchen Screen 8'
          'Kitchen Screen 9'
          'Kitchen Screen 10'
          'Kitchen Screen 11'
          'Kitchen Screen 12')
      end
      object KitchenScreenComboBox2: TComboBox
        Left = 23
        Top = 48
        Width = 180
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        Items.Strings = (
          'N/A'
          'Kitchen Screen 1'
          'Kitchen Screen 2'
          'Kitchen Screen 3'
          'Kitchen Screen 4'
          'Kitchen Screen 5'
          'Kitchen Screen 6'
          'Kitchen Screen 7'
          'Kitchen Screen 8'
          'Kitchen Screen 9'
          'Kitchen Screen 10'
          'Kitchen Screen 11'
          'Kitchen Screen 12')
      end
      object KitchenScreenComboBox3: TComboBox
        Left = 22
        Top = 74
        Width = 180
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        Items.Strings = (
          'N/A'
          'Kitchen Screen 1'
          'Kitchen Screen 2'
          'Kitchen Screen 3'
          'Kitchen Screen 4'
          'Kitchen Screen 5'
          'Kitchen Screen 6'
          'Kitchen Screen 7'
          'Kitchen Screen 8'
          'Kitchen Screen 9'
          'Kitchen Screen 10'
          'Kitchen Screen 11'
          'Kitchen Screen 12')
      end
      object KitchenScreenComboBox4: TComboBox
        Left = 24
        Top = 100
        Width = 180
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        Items.Strings = (
          'N/A'
          'Kitchen Screen 1'
          'Kitchen Screen 2'
          'Kitchen Screen 3'
          'Kitchen Screen 4'
          'Kitchen Screen 5'
          'Kitchen Screen 6'
          'Kitchen Screen 7'
          'Kitchen Screen 8'
          'Kitchen Screen 9'
          'Kitchen Screen 10'
          'Kitchen Screen 11'
          'Kitchen Screen 12')
      end
    end
    object bsSkinPanel1: TbsSkinPanel
      Left = 253
      Top = 14
      Width = 425
      Height = 385
      TabOrder = 5
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
      Caption = 'bsSkinPanel1'
      object ChangeGSTRateCheckBox: TCheckBox
        Left = 30
        Top = 22
        Width = 129
        Height = 17
        Caption = 'Change GST Rate'
        TabOrder = 0
        OnClick = ChangeGSTRateCheckBoxClick
      end
      object GSTRateEdit: TStaticText
        Left = 200
        Top = 22
        Width = 63
        Height = 17
        Alignment = taCenter
        AutoSize = False
        BorderStyle = sbsSingle
        Color = clWhite
        Enabled = False
        ParentColor = False
        TabOrder = 1
        OnClick = GSTRateEditClick
      end
      object StaticText1: TStaticText
        Left = 267
        Top = 22
        Width = 12
        Height = 17
        Caption = '%'
        TabOrder = 20
      end
      object ChangeGroupCheckBox: TCheckBox
        Left = 30
        Top = 50
        Width = 97
        Height = 17
        Caption = 'Change Group'
        TabOrder = 2
        OnClick = ChangeGroupCheckBoxClick
      end
      object ChangeJobListColorCheckBox: TCheckBox
        Left = 30
        Top = 78
        Width = 153
        Height = 17
        Caption = 'Change Job List Print Color'
        TabOrder = 4
        OnClick = ChangeJobListColorCheckBoxClick
      end
      object JobListColorComboBox: TComboBox
        Left = 200
        Top = 74
        Width = 212
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 5
        Text = 'Print Job List in Black Color'
        Items.Strings = (
          'Print Job List in Black Color'
          'Print Job List in Red Color')
      end
      object ChangeItemActiveCheckBox: TCheckBox
        Left = 30
        Top = 106
        Width = 125
        Height = 17
        Caption = 'Change Item Active'
        TabOrder = 6
        OnClick = ChangeItemActiveCheckBoxClick
      end
      object ActiveCheckBox: TCheckBox
        Left = 200
        Top = 106
        Width = 99
        Height = 17
        Caption = 'Active'
        Enabled = False
        TabOrder = 7
      end
      object ChangeInstructionCheckBox: TCheckBox
        Left = 30
        Top = 134
        Width = 123
        Height = 17
        Caption = 'Change Instruction'
        TabOrder = 8
        OnClick = ChangeInstructionCheckBoxClick
      end
      object InstructionCheckBox: TCheckBox
        Left = 200
        Top = 134
        Width = 97
        Height = 17
        Caption = 'Instruction Item'
        Enabled = False
        TabOrder = 9
      end
      object ChangeMultiplePriceCheckBox: TCheckBox
        Left = 30
        Top = 162
        Width = 131
        Height = 17
        Caption = 'Change Multiple Price'
        TabOrder = 10
        OnClick = ChangeMultiplePriceCheckBoxClick
      end
      object MultiplePriceCheckBox: TCheckBox
        Left = 200
        Top = 162
        Width = 97
        Height = 17
        Caption = 'Multiple Price'
        Enabled = False
        TabOrder = 11
      end
      object ChangeOpenPriceCheckBox: TCheckBox
        Left = 30
        Top = 190
        Width = 148
        Height = 17
        Caption = 'Change Open Price'
        TabOrder = 12
        OnClick = ChangeOpenPriceCheckBoxClick
      end
      object OpenPriceCheckBox: TCheckBox
        Left = 200
        Top = 190
        Width = 97
        Height = 17
        Caption = 'Open Price'
        Enabled = False
        TabOrder = 13
      end
      object ChangeAllowDiscountCheckBox: TCheckBox
        Left = 30
        Top = 218
        Width = 149
        Height = 17
        Caption = 'Change Allow Discount'
        TabOrder = 14
        OnClick = ChangeAllowDiscountCheckBoxClick
      end
      object AllowDiscountCheckBox: TCheckBox
        Left = 200
        Top = 218
        Width = 97
        Height = 17
        Caption = 'Allow Discount'
        Enabled = False
        TabOrder = 15
      end
      object GroupComboBox: TComboBox
        Left = 200
        Top = 47
        Width = 212
        Height = 19
        Style = csOwnerDrawFixed
        Enabled = False
        ItemHeight = 13
        TabOrder = 3
      end
      object ChangeMenuButtonPositionCheckBox: TCheckBox
        Left = 30
        Top = 274
        Width = 125
        Height = 17
        Caption = 'Menu Button Position'
        TabOrder = 18
        OnClick = ChangeMenuButtonPositionCheckBoxClick
      end
      object MenuButtonComboBox: TComboBox
        Left = 160
        Top = 273
        Width = 248
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 19
        Text = 'Quick Service Menu = Table Service Menu'
        Items.Strings = (
          'Quick Service Menu = Table Service Menu'
          'Table Service Menu = Quick Service Menu'
          'Phone Order Menu = Table Service Menu'
          'Phone Order Menu = Quick Service Menu')
      end
      object ChangePrintSubDescriptionCheckBox: TCheckBox
        Left = 30
        Top = 246
        Width = 161
        Height = 17
        Caption = 'Change Print Sub Description'
        TabOrder = 16
      end
      object PrintSubDescriptionFirstCheckBox: TCheckBox
        Left = 200
        Top = 246
        Width = 201
        Height = 17
        Caption = 'Print Sub Description first on Job List'
        TabOrder = 17
      end
    end
    object CategoryComboBox: TComboBox
      Left = 56
      Top = 14
      Width = 183
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object SaveButton: TXiButton
    Left = 430
    Top = 425
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
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = SaveButtonClick
  end
  object ExitButton: TXiButton
    Left = 542
    Top = 425
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
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = ExitButtonClick
  end
  object ColorBox: TColorDialog
    Ctl3D = True
    Left = 188
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
    Left = 160
    Top = 44
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 216
    Top = 44
  end
end
