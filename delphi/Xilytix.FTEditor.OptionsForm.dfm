object OptionsForm: TOptionsForm
  Left = 190
  Top = 133
  BorderIcons = []
  Caption = 'Options'
  ClientHeight = 297
  ClientWidth = 350
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Left = 0
    Top = 256
    Width = 350
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      350
      41)
    object OkButton: TButton
      Left = 43
      Top = 8
      Width = 75
      Height = 25
      Action = OkAction
      TabOrder = 0
    end
    object CancelButton: TButton
      Left = 227
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 350
    Height = 256
    ActivePage = ControlsTabSheet
    Align = alClient
    TabOrder = 1
    object ControlsTabSheet: TTabSheet
      Caption = 'Controls'
      ImageIndex = 1
      object Label4: TLabel
        Left = 7
        Top = 8
        Width = 190
        Height = 13
        Caption = 'Default Non &Viewable Character Format'
        FocusControl = DefaultNonViewableCharacterFormatComboBox
      end
      object Label7: TLabel
        Left = 7
        Top = 50
        Width = 72
        Height = 13
        Caption = 'Display &Culture'
        FocusControl = DisplayCultureComboBox
      end
      object Label8: TLabel
        Left = 7
        Top = 127
        Width = 80
        Height = 13
        Caption = 'Display &Encoding'
        FocusControl = DisplayEncodingComboBox
      end
      object DefaultNonViewableCharacterFormatComboBox: TComboBoxEx
        Left = 204
        Top = 2
        Width = 101
        Height = 22
        ItemsEx = <>
        TabOrder = 0
        Text = 'DefaultNonViewableCharacterFormatComboBox'
      end
      object DisplayCultureComboBox: TComboBoxEx
        Left = 93
        Top = 45
        Width = 101
        Height = 22
        ItemsEx = <>
        TabOrder = 1
        Text = 'DefaultNonViewableCharacterFormatComboBox'
      end
      object NamedDisplayCultureEdit: TEdit
        Left = 31
        Top = 74
        Width = 163
        Height = 21
        TabOrder = 2
        Text = 'NamedDisplayCultureEdit'
        OnExit = NamedDisplayCultureEditExit
        OnKeyPress = NamedDisplayCultureEditKeyPress
      end
      object DisplayEncodingComboBox: TComboBoxEx
        Left = 93
        Top = 121
        Width = 101
        Height = 22
        ItemsEx = <>
        TabOrder = 3
        Text = 'DefaultNonViewableCharacterFormatComboBox'
      end
      object NamedDisplayEncodingEdit: TEdit
        Left = 31
        Top = 150
        Width = 163
        Height = 21
        Enabled = False
        TabOrder = 4
        Text = 'DisplayCultureEdit'
        OnExit = NamedDisplayEncodingEditExit
        OnKeyPress = NamedDisplayEncodingEditKeyPress
      end
    end
    object TextTabSheet: TTabSheet
      Caption = 'Text'
      ImageIndex = 2
      object Label6: TLabel
        Left = 56
        Top = 91
        Width = 87
        Height = 13
        Caption = '(Very, very slow!)'
      end
      object Label12: TLabel
        Left = 92
        Top = 128
        Width = 74
        Height = 13
        Caption = '(Causes flicker)'
      end
      object TextFontGroupBox: TGroupBox
        Left = 3
        Top = 3
        Width = 335
        Height = 76
        Caption = 'Font'
        TabOrder = 0
        object TextFontSelectButton: TButton
          Left = 34
          Top = 13
          Width = 49
          Height = 25
          Caption = '&Select'
          TabOrder = 0
          OnClick = TextFontSelectButtonClick
        end
        object TextFontResetButton: TButton
          Left = 34
          Top = 49
          Width = 49
          Height = 19
          Caption = '&Reset'
          TabOrder = 1
          OnClick = TextFontResetButtonClick
        end
        object TextFontExampleMemo: TMemo
          Left = 99
          Top = 13
          Width = 228
          Height = 55
          Lines.Strings = (
            'Example of Font - ABC ghi 123 $#^!}_ ", |'
            '124.5, "Radio", 145976000, True, communication, 0.003'
            ', "", 0, False, none, 0.0009')
          ReadOnly = True
          TabOrder = 2
          WordWrap = False
        end
      end
      object TextTrackCursorCheckBox: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 146
        Width = 80
        Height = 14
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 4
        Margins.Bottom = 1
        Caption = 'Track C&ursor'
        TabOrder = 4
      end
      object TextTrackMouseCheckBox: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 128
        Width = 78
        Height = 14
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 4
        Margins.Bottom = 1
        Caption = 'Track &Mouse'
        TabOrder = 3
      end
      object ColorTextCheckBox: TCheckBox
        Left = 3
        Top = 90
        Width = 46
        Height = 17
        Caption = '&Color Text'
        TabOrder = 1
      end
      object WrapTextCheckBox: TCheckBox
        Left = 3
        Top = 108
        Width = 46
        Height = 17
        Caption = '&Wrap'
        TabOrder = 2
      end
    end
    object GridTabSheet: TTabSheet
      Caption = 'Grid'
      ImageIndex = 3
      object Label5: TLabel
        Left = 184
        Top = 128
        Width = 42
        Height = 13
        Caption = 'N&ull Text'
        FocusControl = GridNullTextEdit
      end
      object FontGroupBox: TGroupBox
        Left = 3
        Top = 3
        Width = 335
        Height = 49
        Caption = 'Font'
        TabOrder = 0
        object GridFontSelectButton: TButton
          Left = 24
          Top = 16
          Width = 49
          Height = 25
          Caption = '&Select'
          TabOrder = 0
          OnClick = GridFontSelectButtonClick
        end
        object GridFontExampleEdit: TEdit
          Left = 79
          Top = 18
          Width = 184
          Height = 21
          AutoSelect = False
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 1
          Text = 'Example of Font - ABC ghi 123 $#^!}_'
        end
        object GridFontResetButton: TButton
          Left = 278
          Top = 16
          Width = 45
          Height = 25
          Caption = '&Reset'
          TabOrder = 2
          OnClick = GridFontResetButtonClick
        end
      end
      object GridHorizontalLinesVisibleCheckBox: TCheckBox
        Left = 3
        Top = 60
        Width = 126
        Height = 17
        Caption = '&Horizontal Lines Visible'
        TabOrder = 1
      end
      object GridVerticalLinesVisibleCheckBox: TCheckBox
        Left = 3
        Top = 79
        Width = 126
        Height = 17
        Caption = '&Vertical Lines Visible'
        TabOrder = 2
      end
      object GridShowFieldNamesIfNoFixedHeadingRowsCheckBox: TCheckBox
        Left = 3
        Top = 155
        Width = 238
        Height = 17
        Caption = 'Show Field &Names if no Fixed Heading Rows'
        TabOrder = 3
      end
      object FixedHeadingRowsCheckBox: TCheckBox
        Left = 3
        Top = 136
        Width = 150
        Height = 17
        Caption = '&Fixed Heading Rows'
        TabOrder = 4
      end
      object GridRowHeightGroupBox: TGroupBox
        Left = 183
        Top = 58
        Width = 155
        Height = 55
        Caption = 'Row Height'
        TabOrder = 7
        object GridRowHeightAutoRadioButton: TRadioButton
          Left = 16
          Top = 16
          Width = 54
          Height = 17
          Caption = '&Auto'
          TabOrder = 0
          OnClick = GridRowHeightAutoRadioButtonClick
        end
        object GridRowHeightManualRadioButton: TRadioButton
          Left = 16
          Top = 32
          Width = 59
          Height = 17
          Caption = 'Man&ual'
          TabOrder = 1
          OnClick = GridRowHeightManualRadioButtonClick
        end
        object GridRowHeightEdit: TEdit
          Left = 76
          Top = 30
          Width = 57
          Height = 21
          TabOrder = 2
          Text = 'GridRowHeightEdit'
          OnEnter = GridRowHeightEditEnter
          OnExit = GridRowHeightEditExit
          OnKeyPress = GridRowHeightEditKeyPress
        end
      end
      object GridTrackMouseCheckBox: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 100
        Width = 78
        Height = 14
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 4
        Margins.Bottom = 1
        Caption = 'Track &Mouse'
        TabOrder = 5
      end
      object GridTrackCursorCheckBox: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 119
        Width = 80
        Height = 14
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 4
        Margins.Bottom = 1
        Caption = 'Track C&ursor'
        TabOrder = 6
      end
      object GridNullTextEdit: TEdit
        Left = 232
        Top = 125
        Width = 105
        Height = 21
        TabOrder = 8
      end
    end
    object ColoursTabSheet: TTabSheet
      Caption = 'Colours'
      ImageIndex = 4
      object ColoursPropertyPanel: TPanel
        Left = 146
        Top = 0
        Width = 196
        Height = 228
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object ColourItemLabel: TLabel
          Left = 16
          Top = 0
          Width = 94
          Height = 13
          Caption = 'ColourItemLabel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 16
          Top = 22
          Width = 56
          Height = 13
          Caption = '&Background'
          FocusControl = BackgroundColorBox
        end
        object Label10: TLabel
          Left = 16
          Top = 76
          Width = 22
          Height = 13
          Caption = '&Font'
          FocusControl = FontColorBox
        end
        object Label11: TLabel
          Left = 16
          Top = 169
          Width = 40
          Height = 13
          Caption = '&Example'
          FocusControl = ColourExampleMemo
        end
        object BackgroundColorBox: TColorBox
          Left = 33
          Top = 38
          Width = 161
          Height = 22
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          TabOrder = 0
          OnChange = ColorBoxChange
        end
        object FontColorBox: TColorBox
          Left = 33
          Top = 91
          Width = 161
          Height = 22
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          TabOrder = 1
          OnChange = ColorBoxChange
        end
        object ColourBoldFontStyleCheckBox: TCheckBox
          Left = 33
          Top = 121
          Width = 41
          Height = 17
          Caption = 'B&old'
          TabOrder = 2
          OnClick = ColorFontStyleCheckBoxClick
        end
        object ColourItalicFontStyleCheckBox: TCheckBox
          Left = 33
          Top = 139
          Width = 46
          Height = 17
          Caption = '&Italic'
          TabOrder = 3
          OnClick = ColorFontStyleCheckBoxClick
        end
        object ColourUnderlineFontStyleCheckBox: TCheckBox
          Left = 91
          Top = 121
          Width = 66
          Height = 17
          Caption = '&Underline'
          TabOrder = 4
          OnClick = ColorFontStyleCheckBoxClick
        end
        object ColourStrikeOutFontStyleCheckBox: TCheckBox
          Left = 91
          Top = 139
          Width = 66
          Height = 17
          Caption = 'S&trike Out'
          TabOrder = 5
          OnClick = ColorFontStyleCheckBoxClick
        end
        object ColourExampleMemo: TMemo
          Left = 16
          Top = 186
          Width = 178
          Height = 38
          Lines.Strings = (
            'ABCD efgh 12345 #@~)",.%'
            'This is a fielded text editor!')
          TabOrder = 6
        end
      end
      object ColoursLeftPanel: TPanel
        Left = 0
        Top = 0
        Width = 146
        Height = 228
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object ColoursButtonGroup: TButtonGroup
          Left = 0
          Top = 0
          Width = 146
          Height = 197
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
          Items = <>
          TabOrder = 0
          OnButtonClicked = ColoursButtonGroupButtonClicked
          OnKeyDown = ColoursButtonGroupKeyDown
        end
        object ColoursLeftBottomPanel: TPanel
          Left = 0
          Top = 197
          Width = 146
          Height = 31
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object ColoursLoadSchemeButton: TButton
            Left = 7
            Top = 7
            Width = 49
            Height = 19
            Caption = '&Load'
            TabOrder = 0
            OnClick = ColoursLoadSchemeButtonClick
          end
          object ColoursSaveSchemeButton: TButton
            Left = 86
            Top = 7
            Width = 49
            Height = 19
            Caption = '&Save'
            TabOrder = 1
            OnClick = ColoursSaveSchemeButtonClick
          end
        end
      end
    end
    object MetaTabSheet: TTabSheet
      Caption = 'Meta'
      object Label1: TLabel
        Left = 26
        Top = 77
        Width = 56
        Height = 13
        Caption = 'Inden&tation'
        FocusControl = MetaIndentationEdit
      end
      object Label2: TLabel
        Left = 26
        Top = 103
        Width = 48
        Height = 13
        Caption = '&Character'
        FocusControl = MetaIndentCharComboBox
      end
      object Label3: TLabel
        Left = 8
        Top = 130
        Width = 112
        Height = 13
        Caption = '&Embedded Meta Margin'
        FocusControl = EmbeddedMetaMarginEdit
      end
      object IgnoreDeclaredMetaCheckBox: TCheckBox
        Left = 8
        Top = 31
        Width = 145
        Height = 17
        Caption = '&Ignore Declared Meta'
        TabOrder = 1
      end
      object IndentMetaXmlCheckBox: TCheckBox
        Left = 8
        Top = 54
        Width = 145
        Height = 17
        Caption = 'I&ndent Meta XML'
        TabOrder = 2
      end
      object MetaIndentationEdit: TEdit
        Left = 97
        Top = 73
        Width = 72
        Height = 21
        TabOrder = 3
        Text = 'MetaIndentationEdit'
        OnExit = IntegerEditExit
        OnKeyPress = IntegerEditKeyPress
      end
      object EmbeddedMetaMarginEdit: TEdit
        Left = 127
        Top = 127
        Width = 72
        Height = 21
        TabOrder = 5
        Text = 'EmbeddedMetaMarginEdit'
        OnExit = IntegerEditExit
        OnKeyPress = IntegerEditKeyPress
      end
      object SaveDesignOnlyMetaCheckBox: TCheckBox
        Left = 8
        Top = 157
        Width = 145
        Height = 17
        Caption = 'Save "&Design Only" Meta'
        TabOrder = 6
      end
      object SaveMetaWithExplicitIndicesCheckBox: TCheckBox
        Left = 8
        Top = 180
        Width = 177
        Height = 17
        Caption = 'Save Meta with E&xplicit Indices'
        TabOrder = 7
      end
      object ResetMetaForNewOpenTextCheckBox: TCheckBox
        Left = 8
        Top = 8
        Width = 177
        Height = 17
        Caption = '&Reset Meta for New/Open Text'
        TabOrder = 0
      end
      object MetaIndentCharComboBox: TComboBoxEx
        Left = 97
        Top = 99
        Width = 73
        Height = 22
        ItemsEx = <>
        TabOrder = 4
        Text = 'MetaIndentCharComboBox'
      end
    end
    object OtherTabSheet: TTabSheet
      Caption = 'Other'
      ImageIndex = 5
      object NumberFromZeroCheckBox: TCheckBox
        Left = 8
        Top = 188
        Width = 112
        Height = 17
        Caption = '&Number From Zero'
        TabOrder = 2
      end
      object SourceOnNewOpenTextGroupBox: TGroupBox
        Left = 8
        Top = 6
        Width = 169
        Height = 101
        Caption = 'Source on New/Open Text'
        TabOrder = 0
        object CurrentSourceRadioButton: TRadioButton
          Left = 16
          Top = 16
          Width = 113
          Height = 17
          Caption = '&Current'
          TabOrder = 0
          OnClick = CurrentSourceRadioButtonClick
        end
        object AllReadOnlySourceRadioButton: TRadioButton
          Left = 16
          Top = 35
          Width = 113
          Height = 17
          Caption = '&All Read Only'
          TabOrder = 1
          OnClick = AllReadOnlySourceRadioButtonClick
        end
        object TextSourceRadioButton: TRadioButton
          Left = 16
          Top = 55
          Width = 49
          Height = 17
          Caption = '&Text'
          TabOrder = 2
          OnClick = TextSourceRadioButtonClick
        end
        object TextSourceLatchedCheckBox: TCheckBox
          Left = 71
          Top = 55
          Width = 61
          Height = 17
          Caption = 'L&atched'
          TabOrder = 3
          OnClick = TextSourceLatchedCheckBoxClick
        end
        object GridSourceRadioButton: TRadioButton
          Left = 16
          Top = 75
          Width = 48
          Height = 17
          Caption = '&Grid'
          TabOrder = 4
          OnClick = GridSourceRadioButtonClick
        end
        object GridSourceLatchedCheckBox: TCheckBox
          Left = 71
          Top = 75
          Width = 65
          Height = 16
          Caption = 'Latc&hed'
          TabOrder = 5
          OnClick = GridSourceLatchedCheckBoxClick
        end
      end
      object DefaultCharEncodingGroupBox: TGroupBox
        Left = 192
        Top = 6
        Width = 142
        Height = 101
        Caption = 'Default Char Encoding'
        TabOrder = 1
        object Label13: TLabel
          Left = 8
          Top = 16
          Width = 41
          Height = 13
          Caption = 'Text File'
        end
        object Label14: TLabel
          Left = 8
          Top = 56
          Width = 43
          Height = 13
          Caption = 'Meta File'
        end
        object TextFileDefaultCharEncodingComboBox: TComboBoxEx
          Left = 19
          Top = 30
          Width = 118
          Height = 22
          ItemsEx = <>
          TabOrder = 0
        end
        object MetaFileDefaultCharEncodingComboBox: TComboBoxEx
          Left = 19
          Top = 70
          Width = 118
          Height = 22
          ItemsEx = <>
          TabOrder = 1
        end
      end
    end
  end
  object ActionList: TActionList
    Left = 300
    Top = 48
    object OkAction: TAction
      Caption = 'Ok'
      OnExecute = OkActionExecute
      OnUpdate = OkActionUpdate
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 252
    Top = 96
  end
end
