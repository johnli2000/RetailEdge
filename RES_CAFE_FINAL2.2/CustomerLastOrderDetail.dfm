�
 TCUSTOMERLASTORDERDETAILFORM 0"  TPF0TCustomerLastOrderDetailFormCustomerLastOrderDetailFormLeft�Top� BorderIcons BorderStylebsSingleCaptionCustomer Order HistoryClientHeight�ClientWidth}Color��� Ctl3DFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
KeyPreview	OldCreateOrder	PositionpoScreenCenterOnClose	FormClose
OnKeyPressFormKeyPressOnShowFormShowPixelsPerInch`
TextHeight TbsSkinPanelDBGridPanelLeftTop� WidthhHeight� TabOrder SkinDataMainForm.bsSkinDataSkinDataNamepanelDefaultFont.CharsetDEFAULT_CHARSETDefaultFont.ColorclWindowTextDefaultFont.HeightDefaultFont.NameArialDefaultFont.Style DefaultWidth DefaultHeight UseSkinFont	
RealHeight�AutoEnabledControls	CheckedModeCheckedDefaultAlignmenttaLeftJustifyDefaultCaptionHeightBorderStylebvFrameCaptionMode
RollUpModeRollUpState	NumGlyphsSpacingCaptionDBGridPanel TDBGridDBGridLeftTopWidthfHeight� AlignalClientBorderStylebsNone
DataSource
DataSource
FixedColor��� Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold OptionsdgTitlesdgIndicatordgTabsdgRowSelectdgConfirmDeletedgCancelOnExit 
ParentFontReadOnly	TabOrder TitleFont.CharsetANSI_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameArialTitleFont.StylefsBold ColumnsExpanded	FieldNameItemCodeTitle.AlignmenttaCenterTitle.CaptionCodeWidth2Visible	 Expanded	FieldNameDescriptionWidthVisible	 Expanded	FieldNameQtyTitle.AlignmenttaRightJustifyWidth.Visible	 Expanded	FieldNamePriceTitle.AlignmenttaRightJustifyVisible	 Expanded	FieldNameDiscountTitle.AlignmenttaRightJustifyTitle.CaptionDis(%)WidthCVisible	 Expanded	FieldNameAmountTitle.AlignmenttaRightJustifyWidthCVisible	     	TXiButton
ExitButtonLeft�TopdWidthdHeight<	ColorFace��� 	ColorGrad��� 	ColorDark��� 
ColorLight��� ColorBorderbbb 	ColorTextclBlackOverColorFace��� OverColorGrad��� OverColorDark��� OverColorLight��� OverColorBorderuuu OverColorTextclBlackDownColorFace��� DownColorGrad��� DownColorDark��� DownColorLight||| DownColorBorderNNN DownColorTextclBlackDisabledColorFace��� DisabledColorGradclWhiteDisabledColorDark��� DisabledColorLightclWhiteDisabledColorBorderclGrayDisabledColorTextclGrayColorFocusRect��� ColorSchemecsNeoSilverCtl3D	LayoutblGlyphLeftSpacingTransparentGlyph	Gradient	HotTrack	CaptionExitFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickExitButtonClick  	TXiButtonPasteItemButtonLeft�TopWidthdHeight<	ColorFace��� 	ColorGrad��� 	ColorDark��� 
ColorLight��� ColorBorderbbb 	ColorTextclBlackOverColorFace��� OverColorGrad��� OverColorDark��� OverColorLight��� OverColorBorderuuu OverColorTextclBlackDownColorFace��� DownColorGrad��� DownColorDark��� DownColorLight||| DownColorBorderNNN DownColorTextclBlackDisabledColorFace��� DisabledColorGradclWhiteDisabledColorDark��� DisabledColorLightclWhiteDisabledColorBorderclGrayDisabledColorTextclGrayColorFocusRect��� ColorSchemecsNeoSilverCtl3D	LayoutblGlyphLeftSpacingTransparentGlyph	Gradient	HotTrack	CaptionPasteFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFontTabOrderOnClickPasteItemButtonClick  TbsSkinPanelOrderHeadPanelLeftTopWidth�Height� TabOrderSkinDataMainForm.bsSkinDataSkinDataNamepanelDefaultFont.CharsetDEFAULT_CHARSETDefaultFont.ColorclWindowTextDefaultFont.HeightDefaultFont.NameArialDefaultFont.Style DefaultWidth DefaultHeight UseSkinFont	
RealHeight�AutoEnabledControls	CheckedModeCheckedDefaultAlignmenttaLeftJustifyDefaultCaptionHeightBorderStylebvFrameCaptionMode
RollUpModeRollUpState	NumGlyphsSpacingCaptionOrderHeadPanel TDBGridOrderHeadDBGridLeftTopWidth�Height� AlignalClientBorderStylebsNone
DataSourceOrderHeadDataSource
FixedColor��� Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBold OptionsdgTitlesdgIndicator
dgColLinesdgRowSelectdgConfirmDeletedgCancelOnExit 
ParentFontTabOrder TitleFont.CharsetANSI_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameArialTitleFont.StylefsBold Columns	AlignmenttaCenterExpanded	FieldNameOrderNoTitle.AlignmenttaCenterTitle.CaptionOrder NoWidth_Visible	 	AlignmenttaCenterExpanded	FieldName	OrderDateTitle.AlignmenttaCenterTitle.CaptionOrder Date / TimeWidth� Visible	 Expanded	FieldNameAmountTitle.AlignmenttaCenterWidth� Visible	     TDBEditDBEditLeft$Top"WidthKHeight	DataFieldOrderNo
DataSourceOrderHeadDataSourceReadOnly	TabOrderVisibleOnChangeDBEditChange  TDataSource
DataSourceDataSetQueryLeft"Top�   	TADOQueryQueryConnectionStringdProvider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Hospitality
CursorTypectStaticLockType
ltReadOnlyOnCalcFieldsQueryCalcFieldsCommandTimeout,
Parameters SQL.StringsCSelect OrderI.ItemCode, Description1, Qty, OrderI.Price, OpenPrice,I           OrderI.Discount, OrderI.TaxRate, PriceSelect, SubDescription, H           SubDescription1, SubDescription2, SubDescription3, Condition,2           AllowDiscount, VoidReason, SpecialOrder            From MenuItem, OrderI3           Where MenuItem.ItemCode=OrderI.ItemCode             Left@Top�  TStringFieldQueryItemCode	FieldNameItemCodeSize  TStringFieldQueryDescription1	FieldNameDescription1Sized  TFloatFieldQueryQty	FieldNameQtyDisplayFormat0.#0  TFloatField
QueryPrice	FieldNamePrice  TFloatFieldQueryDiscount	FieldNameDiscount  TFloatFieldQueryTaxRate	FieldNameTaxRateDisplayFormat0.#0  TFloatFieldQueryAmount	FieldKindfkCalculated	FieldNameAmount
Calculated	  TSmallintFieldQueryPriceSelect	FieldNamePriceSelect  TStringFieldQuerySubDescription	FieldNameSubDescriptionSize
  TStringFieldQuerySubDescription1	FieldNameSubDescription1Size
  TStringFieldQuerySubDescription2	FieldNameSubDescription2Size
  TStringFieldQuerySubDescription3	FieldNameSubDescription3Size
  TSmallintFieldQueryCondition	FieldName	Condition  TStringFieldQueryDescriptionDisplayWidthd	FieldKindfkCalculated	FieldNameDescriptionSized
Calculated	  TBooleanFieldQueryOpenPrice	FieldName	OpenPrice  TBooleanFieldQueryAllowDiscount	FieldNameAllowDiscount  TStringFieldQueryVoidReasonDisplayWidth	FieldName
VoidReasonSize  TStringFieldQuerySpecialOrder	FieldNameSpecialOrderSize�    	TADOQuery	TempQueryLockTypeltUnspecifiedCommandTimeout,
Parameters Left\Top�   TbsBusinessSkinFormbsBusinessSkinForm1UseFormCursorInNCAreaMaxMenuItemsInWindow ClientWidth ClientHeight HideCaptionButtons	AlwaysShowInTrayLogoBitMapTransparentAlwaysMinimizeToTrayUseSkinFontInMenuShowIconMaximizeOnFullScreen
AlphaBlendAlphaBlendAnimationAlphaBlendValue� ShowObjectHintUseDefaultObjectHintMenusAlphaBlendMenusAlphaBlendAnimationMenusAlphaBlendValue� DefCaptionFont.CharsetDEFAULT_CHARSETDefCaptionFont.Color	clBtnTextDefCaptionFont.HeightDefCaptionFont.NameArialDefCaptionFont.StylefsBold DefInActiveCaptionFont.CharsetDEFAULT_CHARSETDefInActiveCaptionFont.ColorclBtnShadowDefInActiveCaptionFont.HeightDefInActiveCaptionFont.NameArialDefInActiveCaptionFont.StylefsBold DefMenuItemHeightDefMenuItemFont.CharsetDEFAULT_CHARSETDefMenuItemFont.ColorclWindowTextDefMenuItemFont.HeightDefMenuItemFont.NameArialDefMenuItemFont.Style UseDefaultSysMenuSkinDataMainForm.bsSkinData	MinHeight MinWidth 	MaxHeight MaxWidth MagneticMagneticSizeBorderIcons LeftzTop�   	TADOQueryOrderHeadQueryConnectionString{Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Hospitality;Data Source=CHARLES-PC
CursorTypectStatic
Parameters SQL.StringsSelect OrderNo, OrderDate,D (Amount + ServiceCharge + OtherCharge + Tips + Surcharge) As Amount From OrderH LeftTopT TWideStringFieldOrderHeadQueryOrderNo	FieldNameOrderNoSize
  TDateTimeFieldOrderHeadQueryOrderDate	FieldName	OrderDateDisplayFormatdd/mm/yyyy hh:mm:ss  TFloatFieldOrderHeadQueryAmount	FieldNameAmount   TDataSourceOrderHeadDataSourceDataSetOrderHeadQueryLeft4TopV   