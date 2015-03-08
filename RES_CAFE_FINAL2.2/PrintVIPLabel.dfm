object PrintVIPLabelForm: TPrintVIPLabelForm
  Left = 456
  Top = 227
  Width = 263
  Height = 195
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
    Columns = 2
    DataPipeline = ppDBPipeline
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 0
    PrinterSetup.mmMarginLeft = 5000
    PrinterSetup.mmMarginRight = 5000
    PrinterSetup.mmMarginTop = 0
    PrinterSetup.mmPaperHeight = 297128
    PrinterSetup.mmPaperWidth = 210080
    PrinterSetup.PaperSize = 9
    Units = utScreenPixels
    AllowPrintToFile = True
    DeviceType = 'Screen'
    OnPreviewFormCreate = ReportPreviewFormCreate
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 78
    Top = 16
    Version = '7.02'
    mmColumnWidth = 100000
    DataPipelineName = 'ppDBPipeline'
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 5000
      mmPrintPosition = 0
    end
    object ppColumnHeaderBand1: TppColumnHeaderBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object DetailBand: TppDetailBand
      BeforeGenerate = DetailBandBeforeGenerate
      mmBottomOffset = 0
      mmHeight = 36000
      mmPrintPosition = 0
      object ppShape1: TppShape
        UserName = 'Shape1'
        mmHeight = 34500
        mmLeft = 1852
        mmTop = 265
        mmWidth = 95250
        BandType = 4
      end
      object VIPName: TppDBText
        UserName = 'VIPName'
        DataField = 'VIPName'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4868
        mmLeft = 6615
        mmTop = 3969
        mmWidth = 85990
        BandType = 4
      end
      object Company: TppDBText
        UserName = 'Company'
        DataField = 'Company'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4763
        mmLeft = 6615
        mmTop = 11377
        mmWidth = 85990
        BandType = 4
      end
      object Address: TppDBText
        UserName = 'Address'
        DataField = 'NumberAndStreet'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 4763
        mmLeft = 6615
        mmTop = 18785
        mmWidth = 85990
        BandType = 4
      end
      object Suburb: TppLabel
        UserName = 'Suburb'
        AutoSize = False
        Caption = 'Suburb'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 12
        Font.Style = []
        Transparent = True
        mmHeight = 4868
        mmLeft = 6615
        mmTop = 26194
        mmWidth = 85725
        BandType = 4
      end
    end
    object ppColumnFooterBand1: TppColumnFooterBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 5000
      mmPrintPosition = 0
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
    Left = 110
    Top = 16
  end
  object ppDBPipeline: TppDBPipeline
    DataSource = DataSource
    OpenDataSource = False
    UserName = 'DBPipeline'
    Left = 44
    Top = 16
    object ppDBPipelineppField1: TppField
      FieldAlias = 'VIPName'
      FieldName = 'VIPName'
      FieldLength = 0
      DisplayWidth = 0
      Position = 0
    end
    object ppDBPipelineppField2: TppField
      FieldAlias = 'Company'
      FieldName = 'Company'
      FieldLength = 40
      DisplayWidth = 40
      Position = 1
    end
    object ppDBPipelineppField3: TppField
      FieldAlias = 'Telephone'
      FieldName = 'Telephone'
      FieldLength = 15
      DisplayWidth = 15
      Position = 2
    end
    object ppDBPipelineppField4: TppField
      FieldAlias = 'Fax'
      FieldName = 'Fax'
      FieldLength = 15
      DisplayWidth = 15
      Position = 3
    end
    object ppDBPipelineppField5: TppField
      FieldAlias = 'Mobile'
      FieldName = 'Mobile'
      FieldLength = 15
      DisplayWidth = 15
      Position = 4
    end
    object ppDBPipelineppField6: TppField
      FieldAlias = 'EMail'
      FieldName = 'EMail'
      FieldLength = 40
      DisplayWidth = 40
      Position = 5
    end
    object ppDBPipelineppField7: TppField
      FieldAlias = 'Address'
      FieldName = 'Address'
      FieldLength = 100
      DisplayWidth = 100
      Position = 6
    end
    object ppDBPipelineppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'VIPNo'
      FieldName = 'VIPNo'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 7
    end
    object ppDBPipelineppField9: TppField
      FieldAlias = 'CreateDate'
      FieldName = 'CreateDate'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 8
    end
    object ppDBPipelineppField10: TppField
      Alignment = taRightJustify
      FieldAlias = 'Discount'
      FieldName = 'Discount'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 9
    end
    object ppDBPipelineppField11: TppField
      FieldAlias = 'BirthDay'
      FieldName = 'BirthDay'
      FieldLength = 0
      DataType = dtDateTime
      DisplayWidth = 18
      Position = 10
    end
    object ppDBPipelineppField12: TppField
      FieldAlias = 'Suburb'
      FieldName = 'Suburb'
      FieldLength = 25
      DisplayWidth = 25
      Position = 11
    end
    object ppDBPipelineppField13: TppField
      FieldAlias = 'State'
      FieldName = 'State'
      FieldLength = 3
      DisplayWidth = 3
      Position = 12
    end
    object ppDBPipelineppField14: TppField
      FieldAlias = 'PostCode'
      FieldName = 'PostCode'
      FieldLength = 4
      DisplayWidth = 4
      Position = 13
    end
    object ppDBPipelineppField15: TppField
      FieldAlias = 'SerialNo'
      FieldName = 'SerialNo'
      FieldLength = 16
      DisplayWidth = 16
      Position = 14
    end
    object ppDBPipelineppField16: TppField
      Alignment = taRightJustify
      FieldAlias = 'TotalCredit'
      FieldName = 'TotalCredit'
      FieldLength = 0
      DataType = dtDouble
      DisplayWidth = 10
      Position = 15
    end
    object ppDBPipelineppField17: TppField
      FieldAlias = 'Notes'
      FieldName = 'Notes'
      FieldLength = 255
      DisplayWidth = 255
      Position = 16
    end
    object ppDBPipelineppField18: TppField
      FieldAlias = 'MapReference'
      FieldName = 'MapReference'
      FieldLength = 15
      DisplayWidth = 15
      Position = 17
    end
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    LockType = ltUnspecified
    OnCalcFields = QueryCalcFields
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'Select * From VIPTable')
    Left = 42
    Top = 56
    object QueryTelephone: TStringField
      FieldName = 'Telephone'
      Size = 15
    end
    object QueryVIPName: TStringField
      FieldName = 'VIPName'
      Size = 30
    end
    object QueryCompany: TStringField
      FieldName = 'Company'
      Size = 40
    end
    object QueryNumber: TStringField
      FieldName = 'Number'
      Size = 10
    end
    object QueryAddress: TStringField
      FieldName = 'Address'
      Size = 100
    end
    object QuerySuburb: TStringField
      FieldName = 'Suburb'
      Size = 25
    end
    object QueryFax: TStringField
      FieldName = 'Fax'
      Size = 15
    end
    object QueryMobile: TStringField
      FieldName = 'Mobile'
      Size = 15
    end
    object QueryEmail: TStringField
      FieldName = 'Email'
      Size = 40
    end
    object QueryCreateDate: TDateTimeField
      FieldName = 'CreateDate'
    end
    object QueryDiscount: TFloatField
      FieldName = 'Discount'
    end
    object QueryNotes: TStringField
      FieldName = 'Notes'
      Size = 255
    end
    object QueryBirthday: TDateTimeField
      FieldName = 'Birthday'
    end
    object QueryState: TStringField
      FieldName = 'State'
      Size = 5
    end
    object QueryPostcode: TStringField
      FieldName = 'Postcode'
      Size = 6
    end
    object QuerySerialNo: TStringField
      FieldName = 'SerialNo'
      Size = 16
    end
    object QueryMapReference: TStringField
      FieldName = 'MapReference'
      Size = 15
    end
    object QueryCreditLimit: TFloatField
      FieldName = 'CreditLimit'
    end
    object QueryVIPNo: TIntegerField
      FieldName = 'VIPNo'
    end
    object QueryNumberAndStreet: TStringField
      FieldKind = fkCalculated
      FieldName = 'NumberAndStreet'
      Size = 150
      Calculated = True
    end
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 80
    Top = 54
  end
end
