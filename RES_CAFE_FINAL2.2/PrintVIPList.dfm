object PrintVIPListForm: TPrintVIPListForm
  Left = 619
  Top = 373
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
    DeviceType = 'Screen'
    OnPreviewFormCreate = ReportPreviewFormCreate
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = False
    Left = 59
    Top = 12
    Version = '7.02'
    mmColumnWidth = 0
    DataPipelineName = 'ppDBPipeline'
    object ppHeaderBand1: TppHeaderBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 29633
      mmPrintPosition = 0
      object ppDBText1: TppDBText
        UserName = 'DBText1'
        DataField = 'CompanyName'
        DataPipeline = ppCompanyDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 16
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppCompanyDBPipeline'
        mmHeight = 6646
        mmLeft = 7938
        mmTop = 794
        mmWidth = 120650
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
        mmLeft = 129911
        mmTop = 794
        mmWidth = 57944
        BandType = 0
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        AutoSize = False
        Caption = 'V.I.P. List'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 20
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 9790
        mmLeft = 7938
        mmTop = 18785
        mmWidth = 179917
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 20902
      mmPrintPosition = 0
      object VIPNo: TppDBText
        UserName = 'VIPNo'
        DataField = 'VIPNo'
        DataPipeline = ppDBPipeline
        DisplayFormat = '0######0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 23283
        mmTop = 2117
        mmWidth = 16404
        BandType = 4
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        Caption = 'V.I.P. No.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 7938
        mmTop = 2117
        mmWidth = 14817
        BandType = 4
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Weight = 0.75
        mmHeight = 529
        mmLeft = 7938
        mmTop = 794
        mmWidth = 179917
        BandType = 4
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        Caption = 'Name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 43656
        mmTop = 2117
        mmWidth = 9694
        BandType = 4
      end
      object VIPName: TppDBText
        UserName = 'VIPName'
        DataField = 'VIPName'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 54504
        mmTop = 2117
        mmWidth = 52652
        BandType = 4
      end
      object Company: TppDBText
        UserName = 'Company'
        DataField = 'Company'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 124884
        mmTop = 2117
        mmWidth = 62706
        BandType = 4
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        Caption = 'Tel:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3704
        mmLeft = 7938
        mmTop = 6879
        mmWidth = 5556
        BandType = 4
      end
      object CustomerTelephone: TppDBText
        UserName = 'CustomerTelephone'
        DataField = 'Telephone'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 14552
        mmTop = 6879
        mmWidth = 26458
        BandType = 4
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        Caption = 'Fax:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 43392
        mmTop = 6879
        mmWidth = 6519
        BandType = 4
      end
      object CustomerFax: TppDBText
        UserName = 'CustomerFax'
        DataField = 'Fax'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3598
        mmLeft = 51329
        mmTop = 6879
        mmWidth = 26458
        BandType = 4
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        Caption = 'Mobile:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 79904
        mmTop = 6879
        mmWidth = 11134
        BandType = 4
      end
      object CustomerMobile: TppDBText
        UserName = 'CustomerMobile'
        DataField = 'Mobile'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3810
        mmLeft = 92075
        mmTop = 6879
        mmWidth = 26458
        BandType = 4
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        Caption = 'E-Mail:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 121973
        mmTop = 6879
        mmWidth = 10414
        BandType = 4
      end
      object Email: TppDBText
        UserName = 'Email'
        DataField = 'EMail'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3598
        mmLeft = 133350
        mmTop = 6879
        mmWidth = 54240
        BandType = 4
      end
      object VIPAddress: TppDBText
        UserName = 'VIPAddress'
        OnGetText = VIPAddressGetText
        DataField = 'NumberAndStreet'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 22754
        mmTop = 11642
        mmWidth = 91017
        BandType = 4
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        Caption = 'Suburb:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 115094
        mmTop = 11642
        mmWidth = 12150
        BandType = 4
      end
      object Suburb: TppDBText
        UserName = 'Suburb'
        DataField = 'Suburb'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3598
        mmLeft = 128588
        mmTop = 11642
        mmWidth = 32279
        BandType = 4
      end
      object VIPState: TppDBText
        UserName = 'VIPState'
        DataField = 'State'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 161925
        mmTop = 11642
        mmWidth = 10848
        BandType = 4
      end
      object ppLabel15: TppLabel
        UserName = 'Label15'
        Caption = 'Create Date:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 7938
        mmTop = 16404
        mmWidth = 18711
        BandType = 4
      end
      object CreateDate: TppDBText
        UserName = 'CreateDate'
        DataField = 'CreateDate'
        DataPipeline = ppDBPipeline
        DisplayFormat = 'dd/mm/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 28046
        mmTop = 16404
        mmWidth = 19050
        BandType = 4
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = 'Company:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 108215
        mmTop = 2117
        mmWidth = 15367
        BandType = 4
      end
      object ppLabel12: TppLabel
        UserName = 'Label12'
        Caption = 'Address:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 3810
        mmLeft = 7938
        mmTop = 11642
        mmWidth = 13716
        BandType = 4
      end
      object PostCode: TppDBText
        UserName = 'PostCode'
        DataField = 'PostCode'
        DataPipeline = ppDBPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'ppDBPipeline'
        mmHeight = 3704
        mmLeft = 173832
        mmTop = 11642
        mmWidth = 13758
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
        mmLeft = 8467
        mmTop = 265
        mmWidth = 179917
        BandType = 8
      end
      object PrintDate: TppSystemVariable
        UserName = 'PrintDate'
        DisplayFormat = 'dd/mm/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 10054
        mmTop = 1000
        mmWidth = 15610
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
        mmLeft = 164571
        mmTop = 1058
        mmWidth = 21431
        BandType = 8
      end
    end
  end
  object ppDBPipeline: TppDBPipeline
    DataSource = DataSource
    OpenDataSource = False
    UserName = 'DBPipeline'
    Left = 26
    Top = 12
    object ppDBPipelineppField1: TppField
      FieldAlias = 'Telephone'
      FieldName = 'Telephone'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField2: TppField
      FieldAlias = 'VIPName'
      FieldName = 'VIPName'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField3: TppField
      FieldAlias = 'Company'
      FieldName = 'Company'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField4: TppField
      FieldAlias = 'Number'
      FieldName = 'Number'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField5: TppField
      FieldAlias = 'Address'
      FieldName = 'Address'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField6: TppField
      FieldAlias = 'Suburb'
      FieldName = 'Suburb'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField7: TppField
      FieldAlias = 'Fax'
      FieldName = 'Fax'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField8: TppField
      FieldAlias = 'Mobile'
      FieldName = 'Mobile'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField9: TppField
      FieldAlias = 'Email'
      FieldName = 'Email'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField10: TppField
      FieldAlias = 'CreateDate'
      FieldName = 'CreateDate'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField11: TppField
      FieldAlias = 'Discount'
      FieldName = 'Discount'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField12: TppField
      FieldAlias = 'Notes'
      FieldName = 'Notes'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField13: TppField
      FieldAlias = 'Birthday'
      FieldName = 'Birthday'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField14: TppField
      FieldAlias = 'State'
      FieldName = 'State'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField15: TppField
      FieldAlias = 'Postcode'
      FieldName = 'Postcode'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField16: TppField
      FieldAlias = 'SerialNo'
      FieldName = 'SerialNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField17: TppField
      FieldAlias = 'MapReference'
      FieldName = 'MapReference'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField18: TppField
      FieldAlias = 'CreditLimit'
      FieldName = 'CreditLimit'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object ppDBPipelineppField19: TppField
      FieldAlias = 'VIPNo'
      FieldName = 'VIPNo'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
  end
  object ppCompanyDBPipeline: TppDBPipeline
    DataSource = CompanyDataSource
    OpenDataSource = False
    UserName = 'CompanyDBPipeline'
    Left = 152
    Top = 12
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
    Left = 122
    Top = 12
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
    Left = 90
    Top = 12
  end
  object Query: TADOQuery
    Connection = DataForm.ADOConnection
    LockType = ltUnspecified
    OnCalcFields = QueryCalcFields
    CommandTimeout = 300
    Parameters = <>
    SQL.Strings = (
      'select * From VIPTable')
    Left = 28
    Top = 44
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
    Left = 60
    Top = 44
  end
end
