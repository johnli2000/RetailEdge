object PrintSalesMenuGroupSummaryReportForm: TPrintSalesMenuGroupSummaryReportForm
  Left = 356
  Top = 244
  Width = 265
  Height = 161
  BorderIcons = []
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Report: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297128
    PrinterSetup.mmPaperWidth = 210080
    PrinterSetup.PaperSize = 9
    Template.FileName = 'C:\Applied Software\DigitalAssist\DigitalAssistSQL\Invoice.rtm'
    Units = utScreenPixels
    AllowPrintToFile = True
    BeforePrint = ReportBeforePrint
    DeviceType = 'Screen'
    OnPreviewFormCreate = ReportPreviewFormCreate
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 101
    Top = 32
    Version = '7.02'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline'
    object ppHeaderBand1: TppHeaderBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 39688
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'CompanyName'
        DataPipeline = ppCompanyDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppCompanyDBPipeline'
        mmHeight = 7673
        mmLeft = 7938
        mmTop = 794
        mmWidth = 125148
        BandType = 0
      end
      object BusinessRegistName: TppLabel
        UserName = 'BusinessRegistName'
        AutoSize = False
        Caption = 'A.B.N.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3440
        mmLeft = 7938
        mmTop = 9525
        mmWidth = 42333
        BandType = 0
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Tel:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3440
        mmLeft = 50800
        mmTop = 9525
        mmWidth = 6085
        BandType = 0
      end
      object Telephone: TppDBText
        UserName = 'Telephone'
        DataField = 'Telephone'
        DataPipeline = ppCompanyDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppCompanyDBPipeline'
        mmHeight = 3440
        mmLeft = 57679
        mmTop = 9525
        mmWidth = 23813
        BandType = 0
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        AutoSize = False
        Caption = 'Fax:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3440
        mmLeft = 83079
        mmTop = 9525
        mmWidth = 6085
        BandType = 0
      end
      object Fax: TppDBText
        UserName = 'Fax'
        DataField = 'Fax'
        DataPipeline = ppCompanyDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppCompanyDBPipeline'
        mmHeight = 3440
        mmLeft = 89959
        mmTop = 9525
        mmWidth = 23813
        BandType = 0
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Weight = 0.75
        mmHeight = 1058
        mmLeft = 7938
        mmTop = 38629
        mmWidth = 179917
        BandType = 0
      end
      object CompanyAddress: TppDBMemo
        UserName = 'CompanyAddress'
        CharWrap = False
        DataField = 'Address'
        DataPipeline = ppCompanyDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppCompanyDBPipeline'
        mmHeight = 16669
        mmLeft = 133879
        mmTop = 529
        mmWidth = 53975
        BandType = 0
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        AutoSize = False
        Caption = 'Sales Summary Report (Menu Group)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold, fsUnderline]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 7535
        mmLeft = 7938
        mmTop = 18785
        mmWidth = 179917
        BandType = 0
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        AutoSize = False
        Caption = 'Menu Group'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 4233
        mmLeft = 44450
        mmTop = 33867
        mmWidth = 60854
        BandType = 0
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Caption = 'Sales Amount'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 107421
        mmTop = 33867
        mmWidth = 26458
        BandType = 0
      end
      object DateLabel: TppLabel
        UserName = 'DateLabel'
        AutoSize = False
        Caption = 'DateLabel'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 3598
        mmLeft = 7938
        mmTop = 27517
        mmWidth = 179917
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 5292
      mmPrintPosition = 0
      object MenuGroup: TppDBText
        UserName = 'MenuGroup'
        DataField = 'Description'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 44450
        mmTop = 794
        mmWidth = 60854
        BandType = 4
      end
      object SalesAmount: TppDBText
        UserName = 'SalesAmount'
        DataField = 'Amount'
        DataPipeline = ppDBPipeline
        DisplayFormat = '0.#0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 107421
        mmTop = 794
        mmWidth = 26458
        BandType = 4
      end
    end
    object ppFooterBand: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 5821
      mmPrintPosition = 0
      object ppLine5: TppLine
        UserName = 'Line5'
        Weight = 0.75
        mmHeight = 265
        mmLeft = 7938
        mmTop = 265
        mmWidth = 179917
        BandType = 8
      end
      object PageNumber: TppSystemVariable
        UserName = 'PageNumber'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 164042
        mmTop = 1058
        mmWidth = 21431
        BandType = 8
      end
    end
    object ppSummaryBand1: TppSummaryBand
      mmBottomOffset = 0
      mmHeight = 5556
      mmPrintPosition = 0
      object TotalSales: TppDBCalc
        UserName = 'TotalSales'
        DataField = 'Amount'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = [fsBold, fsUnderline]
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4233
        mmLeft = 87577
        mmTop = 529
        mmWidth = 46302
        BandType = 7
      end
    end
  end
  object ppDBPipeline: TppDBPipeline
    DataSource = SalesMenuGroupSummaryReportForm.DataSource
    OpenDataSource = False
    UserName = 'DBPipeline'
    Left = 68
    Top = 38
    object ppDBPipelineppField1: TppField
      FieldAlias = 'Code'
      FieldName = 'Code'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField2: TppField
      FieldAlias = 'Description'
      FieldName = 'Description'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField3: TppField
      FieldAlias = 'Amount'
      FieldName = 'Amount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
  end
  object ppCompanyDBPipeline: TppDBPipeline
    DataSource = CompanyDataSource
    OpenDataSource = False
    UserName = 'CompanyDBPipeline'
    Left = 68
    Top = 70
    object ppCompanyDBPipelineppField1: TppField
      FieldAlias = 'DefaultExemptTax'
      FieldName = 'DefaultExemptTax'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 0
    end
    object ppCompanyDBPipelineppField2: TppField
      FieldAlias = 'CompanyName'
      FieldName = 'CompanyName'
      FieldLength = 40
      DisplayWidth = 40
      Position = 1
    end
    object ppCompanyDBPipelineppField3: TppField
      FieldAlias = 'Telephone'
      FieldName = 'Telephone'
      FieldLength = 15
      DisplayWidth = 15
      Position = 2
    end
    object ppCompanyDBPipelineppField4: TppField
      FieldAlias = 'Fax'
      FieldName = 'Fax'
      FieldLength = 15
      DisplayWidth = 15
      Position = 3
    end
    object ppCompanyDBPipelineppField5: TppField
      FieldAlias = 'ABN'
      FieldName = 'ABN'
      FieldLength = 15
      DisplayWidth = 15
      Position = 4
    end
    object ppCompanyDBPipelineppField6: TppField
      FieldAlias = 'Address'
      FieldName = 'Address'
      FieldLength = 100
      DisplayWidth = 100
      Position = 5
    end
    object ppCompanyDBPipelineppField7: TppField
      FieldAlias = 'Initial'
      FieldName = 'Initial'
      FieldLength = 1
      DisplayWidth = 1
      Position = 6
    end
    object ppCompanyDBPipelineppField8: TppField
      FieldAlias = 'GSTStatus'
      FieldName = 'GSTStatus'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 7
    end
    object ppCompanyDBPipelineppField9: TppField
      FieldAlias = 'ExemptInit'
      FieldName = 'ExemptInit'
      FieldLength = 1
      DisplayWidth = 1
      Position = 8
    end
    object ppCompanyDBPipelineppField10: TppField
      FieldAlias = 'POSInit'
      FieldName = 'POSInit'
      FieldLength = 1
      DisplayWidth = 1
      Position = 9
    end
    object ppCompanyDBPipelineppField11: TppField
      FieldAlias = 'PrintDescription1'
      FieldName = 'PrintDescription1'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 10
    end
    object ppCompanyDBPipelineppField12: TppField
      FieldAlias = 'PrintDescription2'
      FieldName = 'PrintDescription2'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 11
    end
    object ppCompanyDBPipelineppField13: TppField
      FieldAlias = 'PrintDescription3'
      FieldName = 'PrintDescription3'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 12
    end
    object ppCompanyDBPipelineppField14: TppField
      FieldAlias = 'PrintDescription4'
      FieldName = 'PrintDescription4'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 13
    end
    object ppCompanyDBPipelineppField15: TppField
      FieldAlias = 'ReceiveConfirm'
      FieldName = 'ReceiveConfirm'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 14
    end
    object ppCompanyDBPipelineppField16: TppField
      Alignment = taRightJustify
      FieldAlias = 'DefaultSearch'
      FieldName = 'DefaultSearch'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 15
    end
    object ppCompanyDBPipelineppField17: TppField
      Alignment = taRightJustify
      FieldAlias = 'DefaultLayByTerm'
      FieldName = 'DefaultLayByTerm'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 16
    end
    object ppCompanyDBPipelineppField18: TppField
      Alignment = taRightJustify
      FieldAlias = 'LayByMinPayment'
      FieldName = 'LayByMinPayment'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 17
    end
    object ppCompanyDBPipelineppField19: TppField
      Alignment = taRightJustify
      FieldAlias = 'DefaultGSTRate'
      FieldName = 'DefaultGSTRate'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 18
    end
  end
  object CompanyDataSource: TDataSource
    DataSet = DataForm.CompanyQuery
    Left = 102
    Top = 68
  end
  object ExtraOptions: TExtraOptions
    About = 'TExtraDevices 2.6'
    HTML.ItemsToExport = [reText, reImage, reLine, reShape, reRTF, reBarCode, reCheckBox]
    HTML.BackLink = '&lt&lt'
    HTML.ForwardLink = '&gt&gt'
    HTML.ShowLinks = True
    HTML.UseTextFileName = False
    HTML.ZoomableImages = False
    HTML.Visible = True
    HTML.PixelFormat = pf8bit
    HTML.SingleFileOutput = False
    XHTML.ItemsToExport = [reText, reImage, reLine, reShape, reRTF, reBarCode, reCheckBox]
    XHTML.BackLink = '&lt&lt'
    XHTML.ForwardLink = '&gt&gt'
    XHTML.ShowLinks = True
    XHTML.UseTextFileName = False
    XHTML.ZoomableImages = False
    XHTML.Visible = True
    XHTML.PixelFormat = pf8bit
    XHTML.SingleFileOutput = False
    RTF.ItemsToExport = [reText, reImage, reLine, reShape, reRTF, reBarCode, reCheckBox]
    RTF.Visible = True
    RTF.RichTextAsImage = False
    RTF.UseTextBox = True
    Lotus.ItemsToExport = [reText, reImage, reLine, reShape, reRTF, reBarCode, reCheckBox]
    Lotus.Visible = True
    Lotus.ColSpacing = 16934
    Quattro.ItemsToExport = [reText, reImage, reLine, reShape, reRTF, reBarCode, reCheckBox]
    Quattro.Visible = True
    Quattro.ColSpacing = 16934
    Excel.ItemsToExport = [reText, reImage, reLine, reShape, reRTF, reBarCode, reCheckBox]
    Excel.Visible = True
    Excel.ColSpacing = 16934
    Excel.RowSizing = False
    Excel.AutoConvertToNumber = True
    Graphic.ItemsToExport = [reText, reImage, reLine, reShape, reRTF, reBarCode, reCheckBox]
    Graphic.PixelFormat = pf8bit
    Graphic.UseTextFileName = False
    Graphic.Visible = True
    Graphic.PixelsPerInch = 96
    Graphic.GrayScale = False
    PDF.ItemsToExport = [reText, reImage, reLine, reShape, reRTF, reBarCode, reCheckBox]
    PDF.FastCompression = False
    PDF.CompressImages = True
    PDF.ScaleImages = True
    PDF.Visible = True
    PDF.RichTextAsImage = False
    PDF.PixelFormat = pf24bit
    PDF.PixelsPerInch = 96
    PDF.Permissions = [ppPrint, ppModify, ppCopy, ppModifyAnnot]
    PDF.AutoEmbedFonts = True
    DotMatrix.ItemsToExport = [reText, reImage, reLine, reShape, reRTF, reBarCode, reCheckBox]
    DotMatrix.Visible = True
    DotMatrix.CharsPerInch = cs10CPI
    DotMatrix.LinesPerInch = ls6LPI
    DotMatrix.Port = 'LPT1'
    DotMatrix.ContinousPaper = False
    Left = 136
    Top = 30
  end
end
