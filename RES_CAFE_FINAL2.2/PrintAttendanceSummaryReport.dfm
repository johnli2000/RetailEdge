object PrintAttendanceSummaryReportForm: TPrintAttendanceSummaryReportForm
  Left = 429
  Top = 152
  Width = 158
  Height = 185
  BorderIcons = []
  Caption = 'Attendance Report'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -9
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 12
  object ppDBPipeline: TppDBPipeline
    DataSource = DataSource
    OpenDataSource = False
    AutoCreateFields = False
    UserName = 'DBPipeline'
    Left = 16
    Top = 74
    object ppDBPipelineppField1: TppField
      FieldAlias = 'StaffName'
      FieldName = 'StaffName'
      FieldLength = 15
      DisplayWidth = 15
      Position = 0
    end
    object ppDBPipelineppField2: TppField
      FieldAlias = 'LoginTime'
      FieldName = 'LoginTime'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 1
    end
    object ppDBPipelineppField3: TppField
      FieldAlias = 'LogoutTime'
      FieldName = 'LogoutTime'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 2
    end
    object ppDBPipelineppField4: TppField
      Alignment = taRightJustify
      FieldAlias = 'IDNo'
      FieldName = 'IDNo'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 3
    end
    object ppDBPipelineppField5: TppField
      Alignment = taRightJustify
      FieldAlias = 'WorkHours'
      FieldName = 'WorkHours'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 4
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 16
    Top = 42
  end
  object Report: TppReport
    AutoStop = False
    DataPipeline = ppDBPipeline
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4 210 x 297 mm'
    PrinterSetup.PrinterName = 'Screen'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 297128
    PrinterSetup.mmPaperWidth = 210080
    PrinterSetup.PaperSize = 9
    Template.FileName = 'C:\CurrentEditFile\DigitalAssistSQL\StandardInvoice.rtm'
    Units = utScreenPixels
    AllowPrintToFile = True
    DeviceType = 'Screen'
    OnPreviewFormCreate = ReportPreviewFormCreate
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    TextFileType = ftTab
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 50
    Top = 8
    Version = '7.02'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline'
    object ppHeaderBand1: TppHeaderBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 33602
      mmPrintPosition = 0
      object CompanyTitle: TppDBText
        UserName = 'CompanyTitle'
        DataField = 'CompanyName'
        DataPipeline = CompanyDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'CompanyDBPipeline'
        mmHeight = 7673
        mmLeft = 10054
        mmTop = 794
        mmWidth = 123825
        BandType = 0
      end
      object BusinessRegistNameLabel: TppLabel
        UserName = 'BusinessRegistNameLabel'
        Caption = 'A.B.N.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 10054
        mmTop = 9525
        mmWidth = 8202
        BandType = 0
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        AutoSize = False
        Caption = 'Attendance Report'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 18
        Font.Style = [fsBold, fsUnderline]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 7938
        mmLeft = 10583
        mmTop = 17992
        mmWidth = 179917
        BandType = 0
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Weight = 0.75
        mmHeight = 1000
        mmLeft = 10054
        mmTop = 32544
        mmWidth = 179917
        BandType = 0
      end
      object CompanyAddress: TppDBMemo
        UserName = 'CompanyAddress'
        CharWrap = False
        DataField = 'Address'
        DataPipeline = CompanyDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'CompanyDBPipeline'
        mmHeight = 16404
        mmLeft = 135202
        mmTop = 794
        mmWidth = 55298
        BandType = 0
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
      object ReportDateLabel: TppLabel
        UserName = 'ReportDateLabel'
        AutoSize = False
        Caption = 'ReportDateLabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 10583
        mmTop = 27781
        mmWidth = 179917
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 4233
      mmPrintPosition = 0
      object LoginTime: TppDBText
        UserName = 'LoginTime'
        DataField = 'LoginTime'
        DataPipeline = ppDBPipeline
        DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 54240
        mmTop = 0
        mmWidth = 29369
        BandType = 4
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        Weight = 0.75
        mmHeight = 1058
        mmLeft = 84931
        mmTop = 1588
        mmWidth = 5556
        BandType = 4
      end
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'LogoutTime'
        DataPipeline = ppDBPipeline
        DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 93663
        mmTop = 0
        mmWidth = 29898
        BandType = 4
      end
      object WorkHours: TppDBText
        UserName = 'WorkHours'
        BlankWhenZero = True
        DataField = 'WorkHours'
        DataPipeline = ppDBPipeline
        DisplayFormat = '0.#0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 148696
        mmTop = 0
        mmWidth = 23283
        BandType = 4
      end
    end
    object FooterBand: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 7144
      mmPrintPosition = 0
      object ppLine3: TppLine
        UserName = 'Line3'
        Weight = 0.75
        mmHeight = 1058
        mmLeft = 10583
        mmTop = 265
        mmWidth = 179917
        BandType = 8
      end
      object PrintDateTime: TppSystemVariable
        UserName = 'PrintDateTime'
        VarType = vtDateTime
        DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 14817
        mmTop = 1323
        mmWidth = 26194
        BandType = 8
      end
      object ReportPage: TppSystemVariable
        UserName = 'ReportPage'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = [fsBold]
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3704
        mmLeft = 169598
        mmTop = 1058
        mmWidth = 15610
        BandType = 8
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'StaffName'
      DataPipeline = ppDBPipeline
      KeepTogether = True
      OutlineSettings.CreateNode = True
      ReprintOnSubsequentPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDBPipeline'
      object ppGroupHeaderBand1: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 4233
        mmPrintPosition = 0
        object StaffName: TppDBText
          UserName = 'StaffName'
          DataField = 'StaffName'
          DataPipeline = ppDBPipeline
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = [fsBold]
          Transparent = True
          DataPipelineName = 'ppDBPipeline'
          mmHeight = 4233
          mmLeft = 16669
          mmTop = 0
          mmWidth = 65352
          BandType = 3
          GroupNo = 0
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 6879
        mmPrintPosition = 0
        object HoursSummary: TppDBCalc
          UserName = 'HoursSummary'
          DataField = 'WorkHours'
          DataPipeline = ppDBPipeline
          DisplayFormat = '0.#0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          ResetGroup = ppGroup1
          TextAlignment = taRightJustified
          Transparent = True
          DataPipelineName = 'ppDBPipeline'
          mmHeight = 3704
          mmLeft = 148696
          mmTop = 529
          mmWidth = 23283
          BandType = 5
          GroupNo = 0
        end
        object ppLabel5: TppLabel
          UserName = 'Label5'
          Caption = 'Total Hours:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 8
          Font.Style = [fsBold]
          Transparent = True
          mmHeight = 3704
          mmLeft = 129382
          mmTop = 529
          mmWidth = 17463
          BandType = 5
          GroupNo = 0
        end
        object ppLine4: TppLine
          UserName = 'Line4'
          Weight = 0.75
          mmHeight = 3969
          mmLeft = 129117
          mmTop = 4763
          mmWidth = 42863
          BandType = 5
          GroupNo = 0
        end
      end
    end
    object ppParameterList1: TppParameterList
    end
  end
  object CompanyDataSource: TDataSource
    DataSet = DataForm.CompanyQuery
    Left = 52
    Top = 40
  end
  object CompanyDBPipeline: TppDBPipeline
    DataSource = CompanyDataSource
    OpenDataSource = False
    UserName = 'CompanyDBPipeline'
    Left = 54
    Top = 72
    object CompanyDBPipelineppField1: TppField
      FieldAlias = 'DefaultExemptTax'
      FieldName = 'DefaultExemptTax'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 0
    end
    object CompanyDBPipelineppField2: TppField
      FieldAlias = 'CompanyName'
      FieldName = 'CompanyName'
      FieldLength = 40
      DisplayWidth = 40
      Position = 1
    end
    object CompanyDBPipelineppField3: TppField
      FieldAlias = 'Telephone'
      FieldName = 'Telephone'
      FieldLength = 15
      DisplayWidth = 15
      Position = 2
    end
    object CompanyDBPipelineppField4: TppField
      FieldAlias = 'Fax'
      FieldName = 'Fax'
      FieldLength = 15
      DisplayWidth = 15
      Position = 3
    end
    object CompanyDBPipelineppField5: TppField
      FieldAlias = 'ABN'
      FieldName = 'ABN'
      FieldLength = 15
      DisplayWidth = 15
      Position = 4
    end
    object CompanyDBPipelineppField6: TppField
      FieldAlias = 'Address'
      FieldName = 'Address'
      FieldLength = 100
      DisplayWidth = 100
      Position = 5
    end
    object CompanyDBPipelineppField7: TppField
      FieldAlias = 'Initial'
      FieldName = 'Initial'
      FieldLength = 1
      DisplayWidth = 1
      Position = 6
    end
    object CompanyDBPipelineppField8: TppField
      FieldAlias = 'GSTStatus'
      FieldName = 'GSTStatus'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 7
    end
    object CompanyDBPipelineppField9: TppField
      FieldAlias = 'ExemptInit'
      FieldName = 'ExemptInit'
      FieldLength = 1
      DisplayWidth = 1
      Position = 8
    end
    object CompanyDBPipelineppField10: TppField
      FieldAlias = 'POSInit'
      FieldName = 'POSInit'
      FieldLength = 1
      DisplayWidth = 1
      Position = 9
    end
    object CompanyDBPipelineppField11: TppField
      FieldAlias = 'PrintDescription1'
      FieldName = 'PrintDescription1'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 10
    end
    object CompanyDBPipelineppField12: TppField
      FieldAlias = 'PrintDescription2'
      FieldName = 'PrintDescription2'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 11
    end
    object CompanyDBPipelineppField13: TppField
      FieldAlias = 'PrintDescription3'
      FieldName = 'PrintDescription3'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 12
    end
    object CompanyDBPipelineppField14: TppField
      FieldAlias = 'PrintDescription4'
      FieldName = 'PrintDescription4'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 13
    end
    object CompanyDBPipelineppField15: TppField
      FieldAlias = 'ReceiveConfirm'
      FieldName = 'ReceiveConfirm'
      FieldLength = 0
      DataType = dtBoolean
      DisplayWidth = 5
      Position = 14
    end
    object CompanyDBPipelineppField16: TppField
      Alignment = taRightJustify
      FieldAlias = 'DefaultSearch'
      FieldName = 'DefaultSearch'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 15
    end
    object CompanyDBPipelineppField17: TppField
      Alignment = taRightJustify
      FieldAlias = 'DefaultLayByTerm'
      FieldName = 'DefaultLayByTerm'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 16
    end
    object CompanyDBPipelineppField18: TppField
      Alignment = taRightJustify
      FieldAlias = 'LayByMinPayment'
      FieldName = 'LayByMinPayment'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 17
    end
    object CompanyDBPipelineppField19: TppField
      Alignment = taRightJustify
      FieldAlias = 'DefaultGSTRate'
      FieldName = 'DefaultGSTRate'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 18
    end
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
    Left = 86
    Top = 8
  end
  object Query: TADOQuery
    CursorType = ctStatic
    LockType = ltUnspecified
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select StaffName, LoginTime, LogoutTime, IDNo,'
      
        '       (CAST(LogoutTime AS Float)-CAST(LoginTime As Float)) As W' +
        'orkHours'
      'From Attendance'
      'Order By StaffName, IDNo')
    Left = 18
    Top = 6
    object QueryStaffName: TStringField
      FieldName = 'StaffName'
      Size = 15
    end
    object QueryLoginTime: TDateTimeField
      FieldName = 'LoginTime'
      DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
    end
    object QueryLogoutTime: TDateTimeField
      FieldName = 'LogoutTime'
      DisplayFormat = 'dd/mm/yyyy hh:mm:ss'
    end
    object QueryIDNo: TIntegerField
      FieldName = 'IDNo'
    end
    object QueryWorkHours: TFloatField
      FieldName = 'WorkHours'
      ReadOnly = True
      DisplayFormat = '0.#0'
    end
  end
end
