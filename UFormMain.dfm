object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Deploy Manager'
  ClientHeight = 577
  ClientWidth = 1079
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesktopCenter
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1079
    Height = 177
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 139
      Top = 115
      Width = 70
      Height = 13
      Caption = 'Configurations'
    end
    object Label1: TLabel
      Left = 314
      Top = 115
      Width = 79
      Height = 13
      Caption = 'Target Directory'
    end
    object Label3: TLabel
      Left = 524
      Top = 7
      Width = 77
      Height = 13
      Caption = 'Filter on Column'
    end
    object BAddFile: TButton
      Left = 6
      Top = 60
      Width = 110
      Height = 43
      Caption = 'Add File'
      TabOrder = 5
      OnClick = BAddFileClick
    end
    object BAddFolder: TButton
      Left = 118
      Top = 60
      Width = 110
      Height = 43
      Caption = 'Add Folder'
      TabOrder = 6
      OnClick = BAddFolderClick
    end
    object CBInclude: TCheckBox
      Left = 6
      Top = 132
      Width = 127
      Height = 21
      Hint = 'Include files in subfolders for selected folders'
      Caption = 'Include Subfolders'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = CBIncludeClick
    end
    object CBConf: TComboBox
      Left = 139
      Top = 132
      Width = 167
      Height = 21
      Hint = 'Change configuration for selected files/folders'
      ItemIndex = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
      Text = 'All'
      OnChange = CBConfChange
      Items.Strings = (
        'All'
        'Debug'
        'Release')
    end
    object BDelSel: TButton
      Left = 230
      Top = 60
      Width = 110
      Height = 43
      Caption = 'Delete Selected'
      TabOrder = 7
      OnClick = BDelSelClick
    end
    object BSave: TButton
      Left = 454
      Top = 60
      Width = 110
      Height = 43
      Caption = 'Save'
      TabOrder = 9
      OnClick = BSaveClick
    end
    object BTransfer: TButton
      Left = 342
      Top = 60
      Width = 110
      Height = 43
      Caption = 'Copy selected to other platform'
      TabOrder = 8
      WordWrap = True
      OnClick = BTransferClick
    end
    object FEProjFile: TAdvFileNameEdit
      Left = 6
      Top = 22
      Width = 491
      Height = 21
      Hint = '.dproj file for Android project'
      EmptyTextStyle = []
      Flat = True
      FocusColor = clBtnFace
      LabelCaption = 'Project File'
      LabelPosition = lpTopLeft
      LabelTransparent = True
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      BevelInner = bvNone
      BevelOuter = bvNone
      AutoSize = False
      Color = clBtnFace
      ParentShowHint = False
      ReadOnly = False
      ShowHint = True
      TabOrder = 0
      Text = ''
      Visible = True
      OnChange = FEProjFileChange
      OnKeyDown = FEProjFileKeyDown
      Version = '1.3.3.4'
      ButtonStyle = bsButton
      ButtonWidth = 18
      Etched = False
      Glyph.Data = {
        0E060000424D0E06000000000000360000002800000016000000160000000100
        180000000000D8050000C21E0000C21E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000FFFFFFFFFFFFFFFFFFD2D0D0A6A2A1B1B0B0C4C4C4D8D8D8EAEAEAF6F6F6
        FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF0000FFFFFFFFFFFFD4CBC8AF643AB856219D4F268E512F80543D7D63
        5487766E908784A19E9EB2B2B2C7C7C7DFDFDFEDEDEDF5F5F5FCFCFCFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFEBE9E8B06D45FF792BFF6318FF6B1DFE7220F9
        7523EE7527DF7126CA6523B15B23A156268F56338159438062558571698D8180
        9C9999D2D2D2FFFFFFFFFFFF0000FFFFFFBFA294F89559F95B12F46015F86C1C
        FC741FFD7D24FF8529FF8D2DFF922FFF9532FF9833FF9737F6862AD16928DD8B
        4DCD7D3CAA5C2B796861F0F0F0FFFFFF0000FFFFFFC2967EFEB488F55A0DF76B
        1CF97521FA7E25FB8629FD8C2CFE922FFF9631FF9834FF9A35FF9A35FF9C33E9
        832AF1B17EFFD185EB954E824C2CD1D1D1FFFFFF0000FFFFFFCC9572FECFAAF7
        6E20F96F1AFB7E26FC872AFE8F2DFF9632FF9B37FF9E3BFFA03FFFA141FFA141
        FFA040FA9B34DC7C36F8BC86D3782DA2561AA6A4A3FFFFFF0000F8F4F2CD9873
        FFE2C4FB9E60F97216FC8528FE8F2EFE9832FF9D39FFA041FFA447FFA64CFFA7
        4EFFA74EFFA64CFFA84BF29131E38A50B76125B4621A8A7E75FBFBFB0000EEE4
        E0D2A07BFFE1C5FECFA8FC9C52FD8722FF942CFF9D39FFA243FFA64CFFAA53FF
        AC58FFAD5AFFAD5AFFAB58FFA953FFAC50E8842EA54B0EBF7125856147E4E4E4
        0000EBD8CDE2AD85FFE1C7FED6B5FED4AEFFB771FFA041FF9F3FFFA448FFA852
        FFAD5BFFB162FFB366FFB267FFB263FFAE5EFFAD57F9A44CAF5E18C878279C5A
        27BCBCBC0000DFC5B6EBBC92FFE2CAFED7B8FFD9B5FFDAB5FFCFA0FFC286FFBB
        77FFB76EFFB66EFFB870FFB973FFB973FFB76FFFB368FFB261F39E4AB66319D7
        832DC96F229089870000C2AB9CFCCFA8FFE4D0FEDCC0FFDBB9FFDAB3FFD9B2FF
        D8B0FFD5AAFFD1A2FFCC9AFFC992FFC58AFFC082FFBC79FFB870FFB569EE9745
        D0701BEE9233F7922E846C5C0000CBA183FEDCBEFFE7D6FEE0C7FFDFC1FFDDBB
        FFDBB6FFD8B1FFD6ADFFD5A9FFD2A5FFD0A0FFCD9AFFC992FFC387FFBA76FFBB
        6FDC8C3EA27352DDA176E18E52B7A1910000D49E73FFE7D2FFE6D5FFE2CDFFE2
        C7FFE1C2FFDFBDFFDCB8FFDAB4FFD7AFFFD5ABFFD3A7FFD0A1FFCD9BFFC991FF
        BF82FFBD71CB7D33B4B2B2FFFFFFFEFDFCFEFDFD0000D59A68FFEDDAFFE7D6FF
        E6D4FFE4CFFFECD4FFEAD1FFE3C7FFDFBEFFDCB7FFD8B1FFD6ACFFD3A5FFCF9E
        FFCB96FFC78EFFC073BD722CC1C0C0FFFFFFFFFFFFFFFFFF0000DF9550FFCC98
        FFC795FFC99CFFCDA2F9C99AFAD5ACFADFC1FEE6C9FFE6C8FFE5C6FFE3C0FFDF
        B9FFD9AFFFD1A1FFCC98FFC57DA96D33DBDBDBFFFFFFFFFFFFFFFFFF0000DC9E
        64F7D0A6FDD4A9FFD4A6FFC98DAE6F3CCAAD95E5B286DBA376DFA573E5AA73EA
        B782F0C295F6CFA5FBD3A6FFD7ABFFD2959C6F45EBEBEBFFFFFFFFFFFFFFFFFF
        0000F5E7DAE4B791DEAB7EDFA774DCA069CAC3BEFFFFFFFFFFFFFBF7F4F8EDE6
        F5E5D8EED8C6E9C8AFE5B894DFAC7EDDA573E79F5BBA9E84FCFCFCFFFFFFFFFF
        FFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000}
      Filter = 'Project Files (*.dproj)|*.dproj'
      FilterIndex = 0
      DialogOptions = []
      DialogKind = fdOpen
    end
    object LERemName: TLabeledEdit
      Left = 545
      Top = 132
      Width = 200
      Height = 21
      Hint = 'Change remote name for selected files'
      EditLabel.Width = 67
      EditLabel.Height = 13
      EditLabel.Caption = 'Remote Name'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
      Text = ''
    end
    object BSaveTargetDir: TButton
      Left = 516
      Top = 132
      Width = 21
      Height = 21
      Hint = 'Update selected files/folders'
      HotImageIndex = 0
      ImageIndex = 0
      Images = ImageList1
      ParentShowHint = False
      PressedImageIndex = 0
      SelectedImageIndex = 0
      ShowHint = True
      TabOrder = 14
      OnClick = BSaveTargetDirClick
    end
    object BSaveRemName: TButton
      Left = 747
      Top = 132
      Width = 21
      Height = 21
      Hint = 'Update selected files/folders'
      HotImageIndex = 0
      ImageIndex = 0
      Images = ImageList1
      ParentShowHint = False
      PressedImageIndex = 0
      SelectedImageIndex = 0
      ShowHint = True
      TabOrder = 16
      OnClick = BSaveRemNameClick
    end
    object SBSearch: TSearchBox
      Left = 778
      Top = 132
      Width = 204
      Height = 21
      AutoSize = False
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 17
      OnKeyUp = SBSearchKeyUp
      OnInvokeSearch = SBSearchInvokeSearch
    end
    object BNext: TButton
      Left = 1005
      Top = 132
      Width = 21
      Height = 21
      Hint = 'Next ocurrence'
      DisabledImageIndex = 2
      HotImageIndex = 2
      ImageIndex = 2
      Images = ImageList1
      ParentShowHint = False
      PressedImageIndex = 2
      SelectedImageIndex = 2
      ShowHint = True
      TabOrder = 19
      OnClick = BNextClick
    end
    object BPrevious: TButton
      Left = 982
      Top = 132
      Width = 21
      Height = 21
      Hint = 'Previous ocurrence'
      DisabledImageIndex = 1
      HotImageIndex = 1
      ImageIndex = 1
      Images = ImageList1
      ParentShowHint = False
      PressedImageIndex = 1
      SelectedImageIndex = 1
      ShowHint = True
      TabOrder = 18
      OnClick = BPreviousClick
    end
    object BRefresh: TButton
      Left = 497
      Top = 22
      Width = 21
      Height = 21
      Hint = 'Refresh'
      ImageIndex = 3
      Images = ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BRefreshClick
    end
    object LETargetDir: TComboBox
      Left = 314
      Top = 132
      Width = 200
      Height = 21
      Hint = 'Change target directory for selected files/folders'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      Text = '.\'
      Items.Strings = (
        '.\')
    end
    object LEFilter: TLabeledEdit
      Left = 697
      Top = 22
      Width = 200
      Height = 21
      Hint = 'Change remote name for selected files'
      EditLabel.Width = 47
      EditLabel.Height = 13
      EditLabel.Caption = 'Filter text'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Text = ''
      OnChange = LEFilterChange
    end
    object CBFilterCol: TComboBox
      Left = 524
      Top = 22
      Width = 167
      Height = 21
      Hint = 'Change configuration for selected files/folders'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnChange = CBFilterColChange
    end
    object BClearFilter: TButton
      Left = 895
      Top = 22
      Width = 21
      Height = 21
      Hint = 'Clear filter'
      ImageIndex = 4
      Images = ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = BClearFilterClick
    end
    object BCompare: TButton
      Left = 566
      Top = 60
      Width = 110
      Height = 43
      Caption = 'Compare Platforms'
      TabOrder = 10
      Visible = False
      OnClick = BCompareClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 558
    Width = 1079
    Height = 19
    Panels = <>
  end
  object ASPConf: TAdvSmoothTabPager
    Left = 0
    Top = 177
    Width = 1079
    Height = 381
    Fill.Color = 3486515
    Fill.ColorTo = 3486515
    Fill.ColorMirror = 3486515
    Fill.ColorMirrorTo = 3486515
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = 3486515
    Fill.BorderWidth = 0
    Fill.Rounding = 0
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    Transparent = True
    Align = alClient
    ActivePage = ASPPAndroid32
    Color = clBackground
    PageMargin = 0
    ShowFocus = False
    TabPosition = tpTopLeft
    TabSettings.StartMargin = 4
    TabReorder = False
    OnChange = ASPConfChange
    TabOrder = 1
    object ASPPAndroid32: TAdvSmoothTabPage
      Left = 0
      Top = 26
      Width = 1079
      Height = 354
      Caption = 'Android 32'
      PageAppearance.Color = 3486515
      PageAppearance.ColorTo = 3486515
      PageAppearance.ColorMirror = 3486515
      PageAppearance.ColorMirrorTo = 3486515
      PageAppearance.GradientType = gtVertical
      PageAppearance.GradientMirrorType = gtVertical
      PageAppearance.BorderColor = 3486515
      PageAppearance.BorderWidth = 0
      PageAppearance.Rounding = 0
      PageAppearance.ShadowOffset = 0
      PageAppearance.Glow = gmNone
      TabAppearance.Appearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Appearance.Font.Color = clWhite
      TabAppearance.Appearance.Font.Height = -11
      TabAppearance.Appearance.Font.Name = 'Tahoma'
      TabAppearance.Appearance.Font.Style = []
      TabAppearance.Appearance.Rounding = 2
      TabAppearance.Status.Caption = '0'
      TabAppearance.Status.Appearance.Fill.Color = clRed
      TabAppearance.Status.Appearance.Fill.ColorMirror = clNone
      TabAppearance.Status.Appearance.Fill.ColorMirrorTo = clNone
      TabAppearance.Status.Appearance.Fill.GradientType = gtSolid
      TabAppearance.Status.Appearance.Fill.GradientMirrorType = gtSolid
      TabAppearance.Status.Appearance.Fill.BorderColor = clGray
      TabAppearance.Status.Appearance.Fill.Rounding = 0
      TabAppearance.Status.Appearance.Fill.ShadowOffset = 0
      TabAppearance.Status.Appearance.Fill.Glow = gmNone
      TabAppearance.Status.Appearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Status.Appearance.Font.Color = clWhite
      TabAppearance.Status.Appearance.Font.Height = -11
      TabAppearance.Status.Appearance.Font.Name = 'Tahoma'
      TabAppearance.Status.Appearance.Font.Style = []
      TabAppearance.Bevel = False
      TabAppearance.BevelColor = 16765357
      TabAppearance.BevelColorDown = 16640730
      TabAppearance.BevelColorSelected = 16640730
      TabAppearance.BevelColorHot = 16640730
      TabAppearance.BevelColorDisabled = 16640730
      TabAppearance.Color = clBlack
      TabAppearance.ColorDown = -1
      TabAppearance.ColorSelected = 3552822
      TabAppearance.ColorHot = clBlack
      TabAppearance.ColorDisabled = clBlack
      TabAppearance.ColorTextHot = clWhite
      TabAppearance.ColorTextDisabled = clWhite
      TabAppearance.ColorTextSelected = clWhite
      object SGAndroid32: TAdvStringGrid
        Left = 2
        Top = 2
        Width = 1075
        Height = 350
        Cursor = crDefault
        Align = alClient
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clWhite
        Ctl3D = True
        DefaultRowHeight = 24
        DefaultDrawing = True
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentCtl3D = False
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        OnSelectCell = SGAndroid32SelectCell
        GridLineColor = 15987699
        GridFixedLineColor = 15987699
        HoverRowCells = [hcNormal, hcSelected]
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <
          item
            Column = 0
            CaseSensitive = False
            Operation = foSHORT
            Method = fmExpression
          end>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FixedRowHeight = 24
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clBlack
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        Version = '6.2.1.1'
      end
    end
    object ASPPAndroid64: TAdvSmoothTabPage
      Left = 0
      Top = 26
      Width = 1079
      Height = 354
      Caption = 'Android 64'
      PageAppearance.Color = 3486515
      PageAppearance.ColorTo = 3486515
      PageAppearance.ColorMirror = 3486515
      PageAppearance.ColorMirrorTo = 3486515
      PageAppearance.GradientType = gtVertical
      PageAppearance.GradientMirrorType = gtVertical
      PageAppearance.BorderColor = 3486515
      PageAppearance.BorderWidth = 0
      PageAppearance.Rounding = 0
      PageAppearance.ShadowOffset = 0
      PageAppearance.Glow = gmNone
      TabAppearance.Appearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Appearance.Font.Color = clWhite
      TabAppearance.Appearance.Font.Height = -11
      TabAppearance.Appearance.Font.Name = 'Tahoma'
      TabAppearance.Appearance.Font.Style = []
      TabAppearance.Status.Caption = '0'
      TabAppearance.Status.Appearance.Fill.Color = clRed
      TabAppearance.Status.Appearance.Fill.ColorMirror = clNone
      TabAppearance.Status.Appearance.Fill.ColorMirrorTo = clNone
      TabAppearance.Status.Appearance.Fill.GradientType = gtSolid
      TabAppearance.Status.Appearance.Fill.GradientMirrorType = gtSolid
      TabAppearance.Status.Appearance.Fill.BorderColor = clGray
      TabAppearance.Status.Appearance.Fill.Rounding = 0
      TabAppearance.Status.Appearance.Fill.ShadowOffset = 0
      TabAppearance.Status.Appearance.Fill.Glow = gmNone
      TabAppearance.Status.Appearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Status.Appearance.Font.Color = clWhite
      TabAppearance.Status.Appearance.Font.Height = -11
      TabAppearance.Status.Appearance.Font.Name = 'Tahoma'
      TabAppearance.Status.Appearance.Font.Style = []
      TabAppearance.Bevel = False
      TabAppearance.BevelColor = 16765357
      TabAppearance.BevelColorDown = 16640730
      TabAppearance.BevelColorSelected = 16640730
      TabAppearance.BevelColorHot = 16640730
      TabAppearance.BevelColorDisabled = 16640730
      TabAppearance.Color = clBlack
      TabAppearance.ColorDown = clBlack
      TabAppearance.ColorSelected = 3552822
      TabAppearance.ColorHot = clBlack
      TabAppearance.ColorDisabled = clBlack
      TabAppearance.ColorTextHot = clWhite
      TabAppearance.ColorTextDisabled = clWhite
      TabAppearance.ColorTextSelected = clWhite
      object SGAndroid64: TAdvStringGrid
        Left = 2
        Top = 2
        Width = 1075
        Height = 350
        Cursor = crDefault
        Align = alClient
        BevelInner = bvSpace
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clWhite
        DefaultRowHeight = 24
        DefaultDrawing = True
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        OnSelectCell = SGAndroid64SelectCell
        GridLineColor = 15987699
        GridFixedLineColor = 15987699
        HoverRowCells = [hcNormal, hcSelected]
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <
          item
            Column = 0
            CaseSensitive = False
            Operation = foSHORT
            Method = fmExpression
          end>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FixedRowHeight = 24
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clBlack
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurrence'
        SearchFooter.HintFindPrev = 'Find previous occurrence'
        SearchFooter.HintHighlight = 'Highlight occurrences'
        SearchFooter.MatchCaseCaption = 'Match case'
        Version = '6.2.1.1'
      end
    end
  end
  object OpenDialog1: TOpenDialog
    InitialDir = 'd:\Deplhi'
    Left = 404
    Top = 228
  end
  object ImageList1: TImageList
    Left = 504
    Top = 336
    Bitmap = {
      494C010105004800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFA7A7D5003535B5003030
      F7002424B6009E9ED400000000FF000000FF000000FF000000FFB4B4E0002020
      BB006161F9003B3BC7008B8BD300000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF3B3BB2003636F7000101
      F5002020EE001F1FB9009696D100000000FF000000FFA9A9DB001C1CBB003E3E
      EC004444F2006C6CF8004343C700000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF4141FA000101FB000000
      F1000000E9001717EE001919B900000000FF000000FF1919B9003232EC003131
      E8004444F0004D4DF7007F7FFE00000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF3A3AA5003F3FEF000606
      F7000000E7000000E1000000DE000D0DB6000D0DB2001A1ADF002424E0003030
      E6004848F4006C6CF4003333BA00000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFC8C8E3003535A5003838
      F0000000E6000000E2000000DB000303E0000707E0001919DB002525E1002E2E
      E5006060F4003030BA00B4B4E100000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FFC0C0DF003333
      A6000404EE000000E1000000DC000000D1000202D1001919DB002424E0003232
      EA002B2BB800A9A9DC00000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF2525A2001818E3001414E7004C4CEF004D4DEF002C2CE5002C2CE6001E1E
      B200000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF2121A5002121E7006363FA008686FF008686FF007171FA003939EB001B1B
      B400000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FFAEAED1002D2D
      A6007777FF00A7A7FF009F9FFF007272F4006B6BF2009F9FFF00A3A3FF008C8C
      FE002B2BB7009494D000000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFB8B8D6003333A3003939
      F400BABAFF00ADADFF00BCBCFF000A0ADF000505DC00BBBBFF00AEAEFF00B5B5
      FF006A6AF8003131B8009D9DD400000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF39399D004242F2008D8D
      FF00BCBCFF00CECEFF009090FB000F0FA6001212A1008B8BF900CDCDFF00BDBD
      FF00A9A9FF007676F7003434B500000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF4E4EF500ABABFF00EEEE
      FF00A7A7FD002323ED001A1AA500000000FF000000FF1D1DA5003333E900A8A8
      FC00E7E7FF00CBCBFF008B8BFA00000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF3B3B9C004848F200B8B8
      FF002D2DEC002121A200AFAFD200000000FF000000FFC2C2DF002020A6004141
      E800D7D7FF007E7EF8003737B400000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FFBBBBD50036369D004343
      F20027279D00BABAD600000000FF000000FF000000FF000000FFC9C9E2002525
      A4007070F7003333B200A6A6D500000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D0B98300C0A15400B7903000C0A15400D1BA83000000
      0000000000000000000000000000000000000000000000000000000000000000
      000075694B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E85D0000F974
      0F00F5771E00000000000000000000000000000000000000000000000000E55D
      0000EF690900F494520000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E6E1D800B7A68000B9954300D2A02E00DDA62A00D3A02C00BA944200BA9B
      5200EEE9DC00000000000000000000000000000000000000000000000000C4BF
      B40038C75B0052742E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECB79500DC590300FF821B00FC6C
      0200EE6F1600000000000000000000000000000000000000000000000000DE59
      0000FF750A00F8781500ED660900000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D9D1
      C200C0A04700F7D54F00FEDD5D00FED75A00FDC03000F8B92B00F5B82A00E2AB
      2900B6933F00DFDACD00C7AA6600D1B97F00000000000000000000000000506D
      2A005EDF900051DC87004D6B2600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CF6E3300DD641000FF801A00FF6C0100FC78
      1300E7681200000000000000000000000000000000000000000000000000D756
      0200FF750B00FF710700FE862300EE610000FBDAC30000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C3AD
      6D00D5C07000BF9C4600BE9A4200D5AC4500EAC96100FECB4500FDBE2D00FCBD
      2D00F8BB2B00CFA13400F8BF2E00BD983E000000000000000000E5E7E10047C2
      5E007FE5A80074E3A1005AE292004E712A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B43F0000EE7E2300FF7D1400FF6A0000FB9C4A00D753
      0000F9E6DA00000000000000000000000000000000000000000000000000DA81
      4A00E0722400FF7F1800FF6F0400FF892500F26A0A00F79E6000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BB9D5A00DCBE5B00FFC53000FFC6
      2F00FFC92F00FFCB3000FFCF3200B68F2B000000000000000000597E3B008BF0
      BB008FEEBC0090ECBA007EE8AD005AE494005478330000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DDB8A500AA3B0200FE923000FF7A1200FF6E0400E79C6300CB5514000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EDC4AB00D4580C00FF9F5200FF6B0100FF852000F77E1E00F26B0E000000
      0000000000000000000000000000000000000000000000000000D6D5DF00392B
      8E00321F9D003F2F9600B8B2BB0000000000E5E1D500BA933500FFCC3400FFCE
      3000FFD23200FFD53400FCD63600C7A75B0000000000000000003EB74A00ABF8
      D70033891E003EB84A0091F2C50081EDB50058E6950056823C00000000000000
      000000000000000000000000000000000000000000000000000000000000B065
      4100BA5A1F00FF932E00FF770F00FF700300C3642E00D7936C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CE4C0200F47A1F00FF6E0200FF821C00FD8F2E00F464
      0400FCE1CE000000000000000000000000000000000000000000524890003A1C
      EA00421EFE003F1CFD00260FB4006558A200B2924300F0C03100FFD03200FFD5
      3400FFDB3800FFDE3900CFAD2F00D1B87A00000000006F9D5D0093FBD1002D96
      210000000000DDE6D9002F901D0070EFAF0080F0BC0053E690006A9957000000
      000000000000000000000000000000000000000000000000000000000000962F
      0000F9DAB300FFB06B00FF6B0000ED711500AC420A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EABA9D00D4530300FF7B1500FF730D00FFDBB100F599
      5500F4873B0000000000000000000000000000000000938DB0002F18BB00391A
      FC00381AFC00391BF9003516F300260EBE00CBA33300F6CF4000FFD33500FFDA
      3700FFE03A00FFE33C00C9A52F00000000000000000039B2400030A529000000
      00000000000000000000000000004E923C004EDC790077F7C5004EE1810086B1
      7A00000000000000000000000000000000000000000000000000000000000000
      0000952F0A00D69E7800FFD9AC00FF892A00FB974100AB3A0100EACDBC000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6662D00D9681B00FF943900FFA05100FFEACB00E1611100F1B0
      82000000000000000000000000000000000000000000342494004327ED003A1B
      FE003719FC003416F3003216E9002916A500DBCBAD00C89F2B00F7D34200FEE2
      4500FFE43E00CAA62C00E3D4B000000000000000000027941A00000000000000
      000000000000000000000000000000000000B2D1AD002EB22E0068FDCC004ADF
      760094C18E000000000000000000000000000000000000000000000000000000
      000000000000B66F4F00AE593100FFEECF00FFAC6200FFB96F00BC551700CD83
      5A00000000000000000000000000000000000000000000000000000000000000
      0000AB360000ED9D5700FFAA5C00FFCA9400F9D6B400CE470000F8E5DA000000
      000000000000000000000000000000000000AAA6C200301AC6004926FC00401C
      FE00391AFB003415EF002D12E4006C60AE0000000000E0D2AB00C19A2A00F3BC
      2C00CDA72E00E1D2AB0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000026981A005BF5
      A80047DE7100B2D6AE0000000000000000000000000000000000000000000000
      00000000000000000000E0C4B700952C0300FAE7CE00FFCC9700FFD09200DC93
      5A00C1632E00000000000000000000000000000000000000000000000000A135
      0000FFD99F00FFC48500FFE5C300DE986B00C5571C0000000000000000000000
      0000000000000000000000000000000000007F75B2005334F600481EFE00886F
      FE003A1BFD003316F0002F12E5002E18CA009C93AC00E7E1D500E4D6B600BA97
      4200DCD0B500DAD7DB0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000072BA
      6E003DD45C003AD15400CEE7CD00000000000000000000000000000000000000
      000000000000000000000000000000000000942B0800E0B59A00FFE2BF00F4D0
      9D00B04A16000000000000000000000000000000000000000000000000009E3A
      0A00FFE3B300FFF4DE00B7521E00D79A79000000000000000000000000000000
      000000000000000000000000000000000000948AC5006B41ED007C57F1005E33
      DB008567FC003F23F3003115E6002D13DF002F15D3004C3DA700786A97006658
      9A003D28B9007567C10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000017AD180022A82000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B0644300B56B4600F8E1
      C700A94212000000000000000000000000000000000000000000000000009C39
      0A00F9EDDB009B2C0000F0E0D600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D0CBE000C7C2DB00CBC4
      DF005834DA007C61FC006751F1005A45E5005944E3002E13DD003418E300361E
      CC005F4FBE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DFC1B3009B3C
      1900E5CCBE00000000000000000000000000000000000000000000000000B46D
      4A00AC5E3D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DFDDEA007465C4007258F300785EF900745BF7006E55F0005241B6008275
      CD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BBB3E8004730CD004730CD007161CD009286D7000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFF00000000000083C1000000000000
      8181000000000000818100000000000080010000000000008001000000000000
      C003000000000000F00F000000000000F00F000000000000C003000000000000
      8001000000000000800100000000000081810000000000008181000000000000
      83C1000000000000FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFC1F
      F7FFFFC7E3FFF007E3FFFF07E1FFE000E1FFFE07E07FE000C0FFFC07E03FFF00
      C07FF01FF01FC100C03FE03FFC07C000881FE07FFC0780019E0FF01FF80F8001
      BF07F80FF01F0083FFC3FC07E07F0003FFE1FF07E0FF0003FFF9FF87E1FF8007
      FFFFFFC7E7FFF00FFFFFFFFFFFFFFC1F00000000000000000000000000000000
      000000000000}
  end
  object AdvSmoothMessageDialog1: TAdvSmoothMessageDialog
    Images = ImageList1
    ButtonAreaFill.Color = 3486515
    ButtonAreaFill.ColorTo = 3486515
    ButtonAreaFill.ColorMirror = 3486515
    ButtonAreaFill.ColorMirrorTo = 3486515
    ButtonAreaFill.GradientType = gtVertical
    ButtonAreaFill.GradientMirrorType = gtVertical
    ButtonAreaFill.BorderColor = clWhite
    ButtonAreaFill.BorderWidth = 0
    ButtonAreaFill.Rounding = 0
    ButtonAreaFill.RoundingType = rtBottom
    ButtonAreaFill.ShadowOffset = 0
    ButtonAreaFill.Glow = gmNone
    Buttons = <
      item
        Spacing = 0
        Caption = 'Override'
        Color = clBlack
        ColorDown = clBlack
        ColorFocused = clBlack
        HoverColor = clBlack
        ButtonResult = 100
      end>
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWhite
    CaptionFont.Height = -13
    CaptionFont.Name = 'Tahoma'
    CaptionFont.Style = []
    ButtonFont.Charset = DEFAULT_CHARSET
    ButtonFont.Color = clWhite
    ButtonFont.Height = -11
    ButtonFont.Name = 'Tahoma'
    ButtonFont.Style = []
    CaptionFill.Color = 3486515
    CaptionFill.ColorTo = 3486515
    CaptionFill.ColorMirror = 3486515
    CaptionFill.ColorMirrorTo = 3486515
    CaptionFill.GradientType = gtVertical
    CaptionFill.GradientMirrorType = gtVertical
    CaptionFill.BorderColor = 3486515
    CaptionFill.BorderWidth = 0
    CaptionFill.Rounding = 0
    CaptionFill.RoundingType = rtTop
    CaptionFill.ShadowOffset = 0
    CaptionFill.Glow = gmNone
    Fill.Color = 3486515
    Fill.ColorTo = 3486515
    Fill.ColorMirror = 3486515
    Fill.ColorMirrorTo = 3486515
    Fill.GradientType = gtVertical
    Fill.GradientMirrorType = gtVertical
    Fill.BorderColor = 3486515
    Fill.BorderWidth = 0
    Fill.Rounding = 0
    Fill.ShadowOffset = 0
    Fill.Glow = gmNone
    HTMLText.Font.Charset = DEFAULT_CHARSET
    HTMLText.Font.Color = clWhite
    HTMLText.Font.Height = -11
    HTMLText.Font.Name = 'Tahoma'
    HTMLText.Font.Style = []
    Position = poDesktopCenter
    Version = '1.1.0.1'
    ProgressMaximum = 100.000000000000000000
    ProgressAppearance.BackGroundFill.Color = 16765615
    ProgressAppearance.BackGroundFill.ColorTo = 16765615
    ProgressAppearance.BackGroundFill.ColorMirror = clNone
    ProgressAppearance.BackGroundFill.ColorMirrorTo = clNone
    ProgressAppearance.BackGroundFill.GradientType = gtVertical
    ProgressAppearance.BackGroundFill.GradientMirrorType = gtSolid
    ProgressAppearance.BackGroundFill.BorderColor = clSilver
    ProgressAppearance.BackGroundFill.Rounding = 0
    ProgressAppearance.BackGroundFill.ShadowOffset = 0
    ProgressAppearance.BackGroundFill.Glow = gmNone
    ProgressAppearance.ProgressFill.Color = 11196927
    ProgressAppearance.ProgressFill.ColorTo = 7257087
    ProgressAppearance.ProgressFill.ColorMirror = 4370174
    ProgressAppearance.ProgressFill.ColorMirrorTo = 8053246
    ProgressAppearance.ProgressFill.GradientType = gtVertical
    ProgressAppearance.ProgressFill.GradientMirrorType = gtVertical
    ProgressAppearance.ProgressFill.BorderColor = 16765357
    ProgressAppearance.ProgressFill.Rounding = 0
    ProgressAppearance.ProgressFill.ShadowOffset = 0
    ProgressAppearance.ProgressFill.Glow = gmNone
    ProgressAppearance.Font.Charset = DEFAULT_CHARSET
    ProgressAppearance.Font.Color = clWindowText
    ProgressAppearance.Font.Height = -11
    ProgressAppearance.Font.Name = 'Tahoma'
    ProgressAppearance.Font.Style = []
    ProgressAppearance.ProgressFont.Charset = DEFAULT_CHARSET
    ProgressAppearance.ProgressFont.Color = clWindowText
    ProgressAppearance.ProgressFont.Height = -11
    ProgressAppearance.ProgressFont.Name = 'Tahoma'
    ProgressAppearance.ProgressFont.Style = []
    ProgressAppearance.ValueFormat = '%.0f%%'
    Left = 650
    Top = 324
  end
  object OpenDialog2: TOpenDialog
    Left = 232
    Top = 401
  end
  object JvSelectDirectory1: TJvSelectDirectory
    Options = [sdPerformCreate, sdPrompt]
    Left = 532
    Top = 272
  end
end
