object UserManagerForm: TUserManagerForm
  Left = 367
  Top = 164
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'User Manager'
  ClientHeight = 544
  ClientWidth = 745
  Color = 15389375
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridPanel: TbsSkinPanel
    Left = 8
    Top = 6
    Width = 242
    Height = 451
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
      Width = 240
      Height = 449
      Align = alClient
      BorderStyle = bsNone
      Color = clBtnFace
      DataSource = DataSource
      Options = [dgTitles, dgIndicator, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGridDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'StaffName'
          Title.Alignment = taCenter
          Title.Caption = 'User'
          Width = 208
          Visible = True
        end>
    end
  end
  object EditPanel: TbsSkinPanel
    Left = 254
    Top = 6
    Width = 491
    Height = 451
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
    Caption = 'EditPanel'
    object Label1: TLabel
      Left = 17
      Top = 20
      Width = 28
      Height = 13
      Caption = 'Name'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 249
      Top = 20
      Width = 46
      Height = 13
      Caption = 'Password'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label10: TLabel
      Left = 498
      Top = 36
      Width = 184
      Height = 13
      Caption = 'Inquiry sales related report within day(s)'
      Color = clBtnFace
      ParentColor = False
    end
    object UserNameEdit: TEdit
      Left = 75
      Top = 16
      Width = 165
      Height = 19
      CharCase = ecUpperCase
      MaxLength = 15
      TabOrder = 0
      OnDblClick = UserNameEditDblClick
      OnKeyDown = UserNameEditKeyDown
    end
    object PasswordEdit: TEdit
      Left = 308
      Top = 16
      Width = 165
      Height = 19
      MaxLength = 16
      PasswordChar = '*'
      TabOrder = 1
      OnDblClick = PasswordEditDblClick
      OnKeyDown = PasswordEditKeyDown
      OnKeyPress = PasswordEditKeyPress
    end
    object TabbedNotebook: TbsSkinNotebook
      Left = 11
      Top = 52
      Width = 468
      Height = 340
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
      UseSkinFont = False
      RealHeight = -1
      AutoEnabledControls = True
      CheckedMode = False
      Checked = False
      DefaultAlignment = taLeftJustify
      DefaultCaptionHeight = 22
      BorderStyle = bvFrame
      CaptionMode = False
      RollUpMode = True
      RollUpState = False
      NumGlyphs = 1
      Spacing = 2
      Caption = 'TabbedNotebook'
      ButtonsMode = True
      ButtonSkinDataName = 'toolbutton'
      object TbsSkinPage
        Left = 1
        Top = 26
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
        BorderStyle = bvNone
        CaptionMode = False
        RollUpMode = False
        RollUpState = False
        NumGlyphs = 1
        Spacing = 2
        Caption = 'Authorise'
        Align = alClient
        ImageIndex = -1
        object StringGridPanel: TbsSkinPanel
          Left = 0
          Top = 0
          Width = 466
          Height = 288
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
          Caption = 'StringGridPanel'
          Align = alClient
          object StringGrid: TStringGrid
            Left = 1
            Top = 1
            Width = 464
            Height = 286
            Align = alClient
            BorderStyle = bsNone
            ColCount = 3
            DefaultRowHeight = 18
            RowCount = 30
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
            TabOrder = 0
            OnDblClick = StringGridDblClick
            OnDrawCell = StringGridDrawCell
            ColWidths = (
              31
              372
              39)
            RowHeights = (
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18
              18)
          end
        end
      end
      object TbsSkinPage
        Left = 1
        Top = 26
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
        BorderStyle = bvNone
        CaptionMode = False
        RollUpMode = False
        RollUpState = False
        NumGlyphs = 1
        Spacing = 2
        Caption = 'Staff Detail'
        Align = alClient
        ImageIndex = -1
        object DetailPanel: TbsSkinPanel
          Left = 0
          Top = 0
          Width = 466
          Height = 288
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
          Caption = 'DetailPanel'
          Align = alClient
          object Label3: TLabel
            Left = 24
            Top = 18
            Width = 38
            Height = 13
            Caption = 'Birthday'
          end
          object Label4: TLabel
            Left = 206
            Top = 18
            Width = 31
            Height = 13
            Caption = 'Phone'
          end
          object Label5: TLabel
            Left = 24
            Top = 64
            Width = 38
            Height = 13
            Caption = 'Address'
          end
          object Label6: TLabel
            Left = 24
            Top = 140
            Width = 28
            Height = 13
            Caption = 'Rates'
          end
          object Label7: TLabel
            Left = 24
            Top = 42
            Width = 31
            Height = 13
            Caption = 'Mobile'
          end
          object Label8: TLabel
            Left = 206
            Top = 42
            Width = 17
            Height = 13
            Caption = 'Fax'
          end
          object Label9: TLabel
            Left = 26
            Top = 174
            Width = 101
            Height = 13
            Caption = 'Cash Drawer Number'
          end
          object DefaultDrawerPortNumberLabel: TLabel
            Left = 26
            Top = 210
            Width = 101
            Height = 13
            Caption = 'Default Cash Drawer '
          end
          object BirthdayEdit: TMaskEdit
            Left = 68
            Top = 14
            Width = 65
            Height = 19
            EditMask = '!99/99/0000;1;_'
            MaxLength = 10
            TabOrder = 0
            Text = '  /  /    '
            OnDblClick = BirthdayEditClick
            OnExit = BirthdayEditExit
            OnKeyDown = BirthdayEditKeyDown
          end
          object TelephoneEdit: TEdit
            Left = 242
            Top = 14
            Width = 110
            Height = 19
            TabOrder = 1
            OnDblClick = EditComponentClick
            OnKeyDown = TelephoneEditKeyDown
          end
          object AddressEdit: TMemo
            Left = 68
            Top = 62
            Width = 284
            Height = 69
            Lines.Strings = (
              '')
            TabOrder = 4
            OnDblClick = AddressEditDblClick
          end
          object RateEdit: TEdit
            Left = 68
            Top = 136
            Width = 77
            Height = 20
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnDblClick = RateEditClick
            OnEnter = RateEditEnter
            OnExit = RateEditExit
            OnKeyDown = RateEditKeyDown
          end
          object MobileEdit: TEdit
            Left = 68
            Top = 38
            Width = 110
            Height = 19
            TabOrder = 2
            OnDblClick = EditComponentClick
            OnKeyDown = MobileEditKeyDown
          end
          object FaxEdit: TEdit
            Left = 242
            Top = 38
            Width = 110
            Height = 19
            TabOrder = 3
            OnDblClick = EditComponentClick
            OnKeyDown = FaxEditKeyDown
          end
          object DrawerPortNumberComboBox: TComboBox
            Left = 134
            Top = 170
            Width = 217
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 6
            Text = 'Cash Drawer 1'
            OnChange = DrawerPortNumberComboBoxChange
            Items.Strings = (
              'Cash Drawer 1'
              'Cash Drawer 2'
              'Cash Drawer 1 & 2')
          end
          object DefaultDrawerPortNumberComboBox: TComboBox
            Left = 134
            Top = 205
            Width = 145
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 0
            TabOrder = 7
            Text = 'Cash Drawer 1'
            Items.Strings = (
              'Cash Drawer 1'
              'Cahs Drawer 2')
          end
        end
      end
    end
    object GrantButton: TXiButton
      Left = 67
      Top = 406
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
      Caption = 'Grant All'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = GrantButtonClick
    end
    object RevokeButton: TXiButton
      Left = 291
      Top = 406
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
      Caption = 'Revoke All'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = RevokeButtonClick
    end
    object InquirySalesRelatedReportDaysEdit: TStaticText
      Left = 702
      Top = 34
      Width = 83
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSingle
      Color = clWhite
      ParentColor = False
      TabOrder = 5
      OnClick = InquirySalesRelatedReportDaysEditClick
    end
  end
  object NewButton: TXiButton
    Left = 24
    Top = 484
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
    Caption = 'New'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = NewButtonClick
  end
  object EditButton: TXiButton
    Left = 130
    Top = 484
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
    Left = 236
    Top = 484
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
  object SaveButton: TXiButton
    Left = 342
    Top = 484
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
    TabOrder = 5
    OnClick = SaveButtonClick
  end
  object CancelButton: TXiButton
    Left = 448
    Top = 484
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
    TabOrder = 6
    OnClick = CancelButtonClick
  end
  object ExitButton: TXiButton
    Left = 617
    Top = 484
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
    TabOrder = 7
    OnClick = ExitButtonClick
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 48
    Top = 296
  end
  object Query: TADOQuery
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=CPL;Data Source=CHARLES-PC'
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select * From AccessMenu')
    Left = 14
    Top = 294
  end
  object TempQuery: TADOQuery
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    Left = 78
    Top = 296
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
    Left = 14
    Top = 250
  end
end
