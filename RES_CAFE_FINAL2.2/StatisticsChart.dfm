�
 TSTATISTICSCHARTFORM 0�  TPF0TStatisticsChartFormStatisticsChartFormLeftNTop6BorderIcons BorderStylebsSingleCaptionStatistics GraphClientHeight;ClientWidth8Color��� Ctl3DFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
KeyPreview	OldCreateOrder	Position	poDefaultOnClose	FormClose
OnKeyPressFormKeyPressOnShowFormShowPixelsPerInch`
TextHeight TLabelLabel1LeftTopWidth8HeightCaptionStatistics by  TLabelLabel2LeftTopWidthHeightCaptionTo  TLabelLabel3Left� TopWidthHeightCaptionDate  	TComboBoxComboBoxLeftLTopWidthOHeightStylecsDropDownList
ItemHeightTabOrder OnChangeComboBoxChangeItems.StringsTimeDayMonth   	TMaskEdit	DateEdit1Left� TopWidthAHeightEditMask!99/99/0000;1;_	MaxLength
TabOrderText
  /  /    OnClickDateEditClick	OnKeyDownDateEdit1KeyDown  	TMaskEdit	DateEdit2Left)TopWidthAHeightEditMask!99/99/0000;1;_	MaxLength
TabOrderText
  /  /    OnClickDateEditClick	OnKeyDownDateEdit2KeyDown  	TXiButton
CalcButtonLeft TopWidthdHeight(	ColorFace��� 	ColorGrad��� 	ColorDark��� 
ColorLight��� ColorBorderbbb 	ColorTextclBlackOverColorFace��� OverColorGrad��� OverColorDark��� OverColorLight��� OverColorBorderuuu OverColorTextclBlackDownColorFace��� DownColorGrad��� DownColorDark��� DownColorLight||| DownColorBorderNNN DownColorTextclBlackDisabledColorFace��� DisabledColorGradclWhiteDisabledColorDark��� DisabledColorLightclWhiteDisabledColorBorderclGrayDisabledColorTextclGrayColorFocusRect��� ColorSchemecsNeoSilverCtl3D	LayoutblGlyphLeftSpacingTransparentGlyph	Gradient	HotTrack	CaptionCalcFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnClickCalcButtonClick  	TXiButton
ExitButtonLeft�TopWidthdHeight(	ColorFace��� 	ColorGrad��� 	ColorDark��� 
ColorLight��� ColorBorderbbb 	ColorTextclBlackOverColorFace��� OverColorGrad��� OverColorDark��� OverColorLight��� OverColorBorderuuu OverColorTextclBlackDownColorFace��� DownColorGrad��� DownColorDark��� DownColorLight||| DownColorBorderNNN DownColorTextclBlackDisabledColorFace��� DisabledColorGradclWhiteDisabledColorDark��� DisabledColorLightclWhiteDisabledColorBorderclGrayDisabledColorTextclGrayColorFocusRect��� ColorSchemecsNeoSilverCtl3D	LayoutblGlyphLeftSpacingTransparentGlyph	Gradient	HotTrack	CaptionExitFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderOnClickExitButtonClick  TbsSkinPanelbsSkinPanel1LeftTopWidth%Height�TabOrderSkinDataMainForm.bsSkinDataSkinDataNamepanelDefaultFont.CharsetDEFAULT_CHARSETDefaultFont.ColorclWindowTextDefaultFont.HeightDefaultFont.NameArialDefaultFont.Style DefaultWidth DefaultHeight UseSkinFont
RealHeight�AutoEnabledControls	CheckedModeCheckedDefaultAlignmenttaLeftJustifyDefaultCaptionHeightBorderStylebvFrameCaptionMode
RollUpModeRollUpState	NumGlyphsSpacingCaptionbsSkinPanel1 TDBChartDBChartLeftTopWidth#Height�AnimatedZoomStepsBackWall.Brush.ColorclWhiteBackWall.Color��� Gradient.DirectiongdBottomTopGradient.EndColor��� Gradient.StartColor��� Gradient.Visible	MarginBottom
MarginLeftMarginRight	MarginTopTitle.Text.StringsTDBChart Title.Visible	BackColor��� BottomAxis.Title.CaptionTimeBottomAxis.Title.Font.CharsetDEFAULT_CHARSETBottomAxis.Title.Font.ColorclBlackBottomAxis.Title.Font.Height�BottomAxis.Title.Font.NameArialBottomAxis.Title.Font.StylefsBold Chart3DPercent
ClipPointsLeftAxis.Title.CaptionSalesLeftAxis.Title.Font.CharsetDEFAULT_CHARSETLeftAxis.Title.Font.ColorclBlackLeftAxis.Title.Font.Height�LeftAxis.Title.Font.NameArialLeftAxis.Title.Font.StylefsBold Legend.VisibleAlignalClient
BevelOuterbvNoneColor��� TabOrder AutoSize	 
TBarSeriesSeriesColorEachPoint	Marks.ArrowLengthMarks.StylesmsValueMarks.Visible	
DataSourceQuerySeriesColorclRedValueFormat$,0.#0XLabelsSourceXXValues.DateTimeXValues.NameXXValues.Multiplier       ��?XValues.OrderloAscendingXValues.ValueSourceXYValues.DateTimeYValues.NameBarYValues.Multiplier       ��?YValues.OrderloNoneYValues.ValueSourceY    	TADOQueryQuery
ConnectionDataForm.ADOConnection
CursorTypectStatic
Parameters SQL.Strings,Select Sum(Amount) As Y, Day(OrderDate) As XFrom OrderHGroup By Day(OrderDate)  Left&Top  TbsBusinessSkinFormbsBusinessSkinForm1UseFormCursorInNCAreaMaxMenuItemsInWindow ClientWidth ClientHeight HideCaptionButtonsAlwaysShowInTrayLogoBitMapTransparentAlwaysMinimizeToTrayUseSkinFontInMenuShowIconMaximizeOnFullScreen
AlphaBlendAlphaBlendAnimationAlphaBlendValue� ShowObjectHintUseDefaultObjectHintMenusAlphaBlendMenusAlphaBlendAnimationMenusAlphaBlendValue� DefCaptionFont.CharsetANSI_CHARSETDefCaptionFont.Color	clBtnTextDefCaptionFont.Height�DefCaptionFont.NameMS Sans SerifDefCaptionFont.Style DefInActiveCaptionFont.CharsetANSI_CHARSETDefInActiveCaptionFont.ColorclBtnShadowDefInActiveCaptionFont.Height�DefInActiveCaptionFont.NameMS Sans SerifDefInActiveCaptionFont.Style DefMenuItemHeightDefMenuItemFont.CharsetANSI_CHARSETDefMenuItemFont.ColorclWindowTextDefMenuItemFont.Height�DefMenuItemFont.NameMS Sans SerifDefMenuItemFont.Style UseDefaultSysMenuSkinDataMainForm.bsSkinData	MinHeight MinWidth 	MaxHeight MaxWidth MagneticMagneticSizeBorderIcons LeftFTop   