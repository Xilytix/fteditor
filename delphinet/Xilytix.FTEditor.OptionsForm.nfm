object OptionsForm: TOptionsForm
  BorderIcons = []
  Caption = 'Options'
  ClientHeight = 297
  ClientWidth = 350
  Color = clBtnFace
  ParentFont = True
  Left = 190
  Top = 133
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    Left = 0
    Top = 256
    Width = 350
    Height = 41
    DesignSize = (
      350
      41)
    object OkButton: TButton
      TabOrder = 0
      Left = 43
      Top = 8
      Width = 75
      Height = 25
      Action = OkAction
    end
    object CancelButton: TButton
      Caption = 'Cancel'
      TabOrder = 1
      Left = 227
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      ModalResult = 2
    end
  end
  object PageControl: TPageControl
    ActivePage = OtherTabSheet
    Align = alClient
    TabOrder = 1
    Left = 0
    Top = 0
    Width = 350
    Height = 256
    object ControlsTabSheet: TTabSheet
      Caption = 'Controls'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label4: TLabel
        Caption = 'Default Non &Viewable Character Format'
        FocusControl = DefaultNonViewableCharacterFormatComboBox
        Left = 7
        Top = 8
        Width = 190
        Height = 13
      end
      object Label7: TLabel
        Caption = 'Display &Culture'
        FocusControl = DisplayCultureComboBox
        Left = 7
        Top = 50
        Width = 72
        Height = 13
      end
      object Label8: TLabel
        Caption = 'Display &Encoding'
        FocusControl = DisplayEncodingComboBox
        Left = 7
        Top = 127
        Width = 80
        Height = 13
      end
      object DefaultNonViewableCharacterFormatComboBox: TComboBoxEx
        ItemsEx = <>
        ItemHeight = 16
        TabOrder = 0
        Left = 204
        Top = 2
        Width = 101
        Height = 22
        Text = 'DefaultNonViewableCharacterFormatComboBox'
      end
      object DisplayCultureComboBox: TComboBoxEx
        ItemsEx = <>
        ItemHeight = 16
        TabOrder = 1
        Left = 93
        Top = 45
        Width = 101
        Height = 22
        Text = 'DefaultNonViewableCharacterFormatComboBox'
      end
      object NamedDisplayCultureEdit: TEdit
        TabOrder = 2
        Text = 'NamedDisplayCultureEdit'
        Left = 31
        Top = 74
        Width = 163
        Height = 21
        OnExit = NamedDisplayCultureEditExit
        OnKeyPress = NamedDisplayCultureEditKeyPress
      end
      object DisplayEncodingComboBox: TComboBoxEx
        ItemsEx = <>
        ItemHeight = 16
        TabOrder = 3
        Left = 93
        Top = 121
        Width = 101
        Height = 22
        Text = 'DefaultNonViewableCharacterFormatComboBox'
      end
      object NamedDisplayEncodingEdit: TEdit
        TabOrder = 4
        Text = 'DisplayCultureEdit'
        Left = 31
        Top = 150
        Width = 163
        Height = 21
        OnExit = NamedDisplayEncodingEditExit
        OnKeyPress = NamedDisplayEncodingEditKeyPress
      end
    end
    object TextTabSheet: TTabSheet
      Caption = 'Text'
      ImageIndex = 2
      object Label6: TLabel
        Caption = '(Very, very slow!)'
        Left = 56
        Top = 91
        Width = 87
        Height = 13
      end
      object Label12: TLabel
        Caption = '(Causes flicker)'
        Left = 92
        Top = 128
        Width = 74
        Height = 13
      end
      object TextFontGroupBox: TGroupBox
        Caption = 'Font'
        TabOrder = 0
        Left = 3
        Top = 3
        Width = 335
        Height = 76
        object TextFontSelectButton: TButton
          Caption = '&Select'
          TabOrder = 0
          Left = 34
          Top = 13
          Width = 49
          Height = 25
          OnClick = TextFontSelectButtonClick
        end
        object TextFontResetButton: TButton
          Caption = '&Reset'
          TabOrder = 1
          Left = 34
          Top = 49
          Width = 49
          Height = 19
          OnClick = TextFontResetButtonClick
        end
        object TextFontExampleMemo: TMemo
          Lines.Strings = (
            'Example of Font - ABC ghi 123 $#^!}_ ", |'
            '124.5, "Radio", 145976000, True, communication, 0.003'
            ', "", 0, False, none, 0.0009')
          ReadOnly = True
          TabOrder = 2
          WordWrap = False
          Left = 99
          Top = 13
          Width = 228
          Height = 55
        end
      end
      object TextTrackCursorCheckBox: TCheckBox
        Caption = 'Track C&ursor'
        TabOrder = 4
        Left = 3
        Top = 146
        Width = 80
        Height = 14
        AlignWithMargins = True
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 4
        Margins.Bottom = 1
      end
      object TextTrackMouseCheckBox: TCheckBox
        Caption = 'Track &Mouse'
        TabOrder = 3
        Left = 3
        Top = 128
        Width = 78
        Height = 14
        AlignWithMargins = True
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 4
        Margins.Bottom = 1
      end
      object ColorTextCheckBox: TCheckBox
        Caption = '&Color Text'
        TabOrder = 1
        Left = 3
        Top = 90
        Width = 46
        Height = 17
      end
      object WrapTextCheckBox: TCheckBox
        Caption = '&Wrap'
        TabOrder = 2
        Left = 3
        Top = 108
        Width = 46
        Height = 17
      end
    end
    object GridTabSheet: TTabSheet
      Caption = 'Grid'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label5: TLabel
        Caption = 'N&ull Text'
        FocusControl = GridNullTextEdit
        Left = 184
        Top = 128
        Width = 42
        Height = 13
      end
      object FontGroupBox: TGroupBox
        Caption = 'Font'
        TabOrder = 0
        Left = 3
        Top = 3
        Width = 335
        Height = 49
        object GridFontSelectButton: TButton
          Caption = '&Select'
          TabOrder = 0
          Left = 24
          Top = 16
          Width = 49
          Height = 25
          OnClick = GridFontSelectButtonClick
        end
        object GridFontExampleEdit: TEdit
          AutoSelect = False
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 1
          Text = 'Example of Font - ABC ghi 123 $#^!}_'
          Left = 79
          Top = 18
          Width = 184
          Height = 21
        end
        object GridFontResetButton: TButton
          Caption = '&Reset'
          TabOrder = 2
          Left = 278
          Top = 16
          Width = 45
          Height = 25
          OnClick = GridFontResetButtonClick
        end
      end
      object GridHorizontalLinesVisibleCheckBox: TCheckBox
        Caption = '&Horizontal Lines Visible'
        TabOrder = 1
        Left = 3
        Top = 60
        Width = 126
        Height = 17
      end
      object GridVerticalLinesVisibleCheckBox: TCheckBox
        Caption = '&Vertical Lines Visible'
        TabOrder = 2
        Left = 3
        Top = 79
        Width = 126
        Height = 17
      end
      object GridShowFieldNamesIfNoFixedHeadingRowsCheckBox: TCheckBox
        Caption = 'Show Field &Names if no Fixed Heading Rows'
        TabOrder = 3
        Left = 3
        Top = 155
        Width = 238
        Height = 17
      end
      object FixedHeadingRowsCheckBox: TCheckBox
        Caption = '&Fixed Heading Rows'
        TabOrder = 4
        Left = 3
        Top = 136
        Width = 150
        Height = 17
      end
      object GridRowHeightGroupBox: TGroupBox
        Caption = 'Row Height'
        TabOrder = 7
        Left = 183
        Top = 58
        Width = 155
        Height = 55
        object GridRowHeightAutoRadioButton: TRadioButton
          Caption = '&Auto'
          TabOrder = 0
          Left = 16
          Top = 16
          Width = 54
          Height = 17
          OnClick = GridRowHeightAutoRadioButtonClick
        end
        object GridRowHeightManualRadioButton: TRadioButton
          Caption = 'Man&ual'
          TabOrder = 1
          Left = 16
          Top = 32
          Width = 59
          Height = 17
          OnClick = GridRowHeightManualRadioButtonClick
        end
        object GridRowHeightEdit: TEdit
          TabOrder = 2
          Text = 'GridRowHeightEdit'
          Left = 76
          Top = 30
          Width = 57
          Height = 21
          OnEnter = GridRowHeightEditEnter
          OnExit = GridRowHeightEditExit
          OnKeyPress = GridRowHeightEditKeyPress
        end
      end
      object GridTrackMouseCheckBox: TCheckBox
        Caption = 'Track &Mouse'
        TabOrder = 5
        Left = 3
        Top = 100
        Width = 78
        Height = 14
        AlignWithMargins = True
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 4
        Margins.Bottom = 1
      end
      object GridTrackCursorCheckBox: TCheckBox
        Caption = 'Track C&ursor'
        TabOrder = 6
        Left = 3
        Top = 119
        Width = 80
        Height = 14
        AlignWithMargins = True
        Margins.Left = 4
        Margins.Top = 1
        Margins.Right = 4
        Margins.Bottom = 1
      end
      object GridNullTextEdit: TEdit
        TabOrder = 8
        Left = 232
        Top = 125
        Width = 105
        Height = 21
      end
    end
    object ColoursTabSheet: TTabSheet
      Caption = 'Colours'
      ImageIndex = 4
      object ColoursPropertyPanel: TPanel
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        Left = 146
        Top = 0
        Width = 196
        Height = 228
        object ColourItemLabel: TLabel
          Caption = 'ColourItemLabel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Left = 16
          Top = 0
          Width = 94
          Height = 13
        end
        object Label9: TLabel
          Caption = '&Background'
          FocusControl = BackgroundColorBox
          Left = 16
          Top = 22
          Width = 56
          Height = 13
        end
        object Label10: TLabel
          Caption = '&Font'
          FocusControl = FontColorBox
          Left = 16
          Top = 76
          Width = 22
          Height = 13
        end
        object Label11: TLabel
          Caption = '&Example'
          FocusControl = ColourExampleMemo
          Left = 16
          Top = 169
          Width = 40
          Height = 13
        end
        object BackgroundColorBox: TColorBox
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 0
          Left = 33
          Top = 38
          Width = 161
          Height = 22
          OnChange = ColorBoxChange
        end
        object FontColorBox: TColorBox
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 1
          Left = 33
          Top = 91
          Width = 161
          Height = 22
          OnChange = ColorBoxChange
        end
        object ColourBoldFontStyleCheckBox: TCheckBox
          Caption = 'B&old'
          TabOrder = 2
          Left = 33
          Top = 121
          Width = 41
          Height = 17
          OnClick = ColorFontStyleCheckBoxClick
        end
        object ColourItalicFontStyleCheckBox: TCheckBox
          Caption = '&Italic'
          TabOrder = 3
          Left = 33
          Top = 139
          Width = 46
          Height = 17
          OnClick = ColorFontStyleCheckBoxClick
        end
        object ColourUnderlineFontStyleCheckBox: TCheckBox
          Caption = '&Underline'
          TabOrder = 4
          Left = 91
          Top = 121
          Width = 66
          Height = 17
          OnClick = ColorFontStyleCheckBoxClick
        end
        object ColourStrikeOutFontStyleCheckBox: TCheckBox
          Caption = 'S&trike Out'
          TabOrder = 5
          Left = 91
          Top = 139
          Width = 66
          Height = 17
          OnClick = ColorFontStyleCheckBoxClick
        end
        object ColourExampleMemo: TMemo
          Lines.Strings = (
            'ABCD efgh 12345 #@~)",.%'
            'This is a fielded text editor!')
          TabOrder = 6
          Left = 16
          Top = 186
          Width = 178
          Height = 38
        end
      end
      object ColoursLeftPanel: TPanel
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        Left = 0
        Top = 0
        Width = 146
        Height = 228
        object ColoursButtonGroup: TButtonGroup
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
          Height = 197
          Items = <>
          TabOrder = 0
          Width = 146
          Left = 0
          Top = 0
          OnButtonClicked = ColoursButtonGroupButtonClicked
          OnKeyDown = ColoursButtonGroupKeyDown
          ExplicitLeft = 8
          ExplicitTop = 58
          ExplicitWidth = 100
          ExplicitHeight = 100
        end
        object ColoursLeftBottomPanel: TPanel
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          Left = 0
          Top = 197
          Width = 146
          Height = 31
          object ColoursLoadSchemeButton: TButton
            Caption = '&Load'
            TabOrder = 0
            Left = 7
            Top = 7
            Width = 49
            Height = 19
            OnClick = ColoursLoadSchemeButtonClick
          end
          object ColoursSaveSchemeButton: TButton
            Caption = '&Save'
            TabOrder = 1
            Left = 86
            Top = 7
            Width = 49
            Height = 19
            OnClick = ColoursSaveSchemeButtonClick
          end
        end
      end
    end
    object MetaTabSheet: TTabSheet
      Caption = 'Meta'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Caption = 'Inden&tation'
        FocusControl = MetaIndentationEdit
        Left = 26
        Top = 77
        Width = 56
        Height = 13
      end
      object Label2: TLabel
        Caption = '&Character'
        FocusControl = MetaIndentCharComboBox
        Left = 26
        Top = 103
        Width = 48
        Height = 13
      end
      object Label3: TLabel
        Caption = '&Embedded Meta Margin'
        FocusControl = EmbeddedMetaMarginEdit
        Left = 8
        Top = 130
        Width = 112
        Height = 13
      end
      object IgnoreDeclaredMetaCheckBox: TCheckBox
        Caption = '&Ignore Declared Meta'
        TabOrder = 1
        Left = 8
        Top = 31
        Width = 145
        Height = 17
      end
      object IndentMetaXmlCheckBox: TCheckBox
        Caption = 'I&ndent Meta XML'
        TabOrder = 2
        Left = 8
        Top = 54
        Width = 145
        Height = 17
      end
      object MetaIndentationEdit: TEdit
        TabOrder = 3
        Text = 'MetaIndentationEdit'
        Left = 97
        Top = 73
        Width = 72
        Height = 21
        OnExit = IntegerEditExit
        OnKeyPress = IntegerEditKeyPress
      end
      object EmbeddedMetaMarginEdit: TEdit
        TabOrder = 5
        Text = 'EmbeddedMetaMarginEdit'
        Left = 127
        Top = 127
        Width = 72
        Height = 21
        OnExit = IntegerEditExit
        OnKeyPress = IntegerEditKeyPress
      end
      object SaveDesignOnlyMetaCheckBox: TCheckBox
        Caption = 'Save "&Design Only" Meta'
        TabOrder = 6
        Left = 8
        Top = 157
        Width = 145
        Height = 17
      end
      object SaveMetaWithExplicitIndicesCheckBox: TCheckBox
        Caption = 'Save Meta with E&xplicit Indices'
        TabOrder = 7
        Left = 8
        Top = 180
        Width = 177
        Height = 17
      end
      object ResetMetaForNewOpenTextCheckBox: TCheckBox
        Caption = '&Reset Meta for New/Open Text'
        TabOrder = 0
        Left = 8
        Top = 8
        Width = 177
        Height = 17
      end
      object MetaIndentCharComboBox: TComboBoxEx
        ItemsEx = <>
        ItemHeight = 16
        TabOrder = 4
        Left = 97
        Top = 99
        Width = 73
        Height = 22
        Text = 'MetaIndentCharComboBox'
      end
    end
    object OtherTabSheet: TTabSheet
      Caption = 'Other'
      ImageIndex = 5
      object NumberFromZeroCheckBox: TCheckBox
        Caption = '&Number From Zero'
        TabOrder = 2
        Left = 8
        Top = 188
        Width = 112
        Height = 17
      end
      object SourceOnNewOpenTextGroupBox: TGroupBox
        Caption = 'Source on New/Open Text'
        TabOrder = 0
        Left = 8
        Top = 6
        Width = 169
        Height = 101
        object CurrentSourceRadioButton: TRadioButton
          Caption = '&Current'
          TabOrder = 0
          Left = 16
          Top = 16
          Width = 113
          Height = 17
          OnClick = CurrentSourceRadioButtonClick
        end
        object AllReadOnlySourceRadioButton: TRadioButton
          Caption = '&All Read Only'
          TabOrder = 1
          Left = 16
          Top = 35
          Width = 113
          Height = 17
          OnClick = AllReadOnlySourceRadioButtonClick
        end
        object TextSourceRadioButton: TRadioButton
          Caption = '&Text'
          TabOrder = 2
          Left = 16
          Top = 55
          Width = 49
          Height = 17
          OnClick = TextSourceRadioButtonClick
        end
        object TextSourceLatchedCheckBox: TCheckBox
          Caption = 'L&atched'
          TabOrder = 3
          Left = 71
          Top = 55
          Width = 61
          Height = 17
          OnClick = TextSourceLatchedCheckBoxClick
        end
        object GridSourceRadioButton: TRadioButton
          Caption = '&Grid'
          TabOrder = 4
          Left = 16
          Top = 75
          Width = 48
          Height = 17
          OnClick = GridSourceRadioButtonClick
        end
        object GridSourceLatchedCheckBox: TCheckBox
          Caption = 'Latc&hed'
          TabOrder = 5
          Left = 71
          Top = 75
          Width = 65
          Height = 16
          OnClick = GridSourceLatchedCheckBoxClick
        end
      end
      object DefaultCharEncodingGroupBox: TGroupBox
        Caption = 'Default Char Encoding'
        TabOrder = 1
        Left = 192
        Top = 6
        Width = 142
        Height = 101
        object Label13: TLabel
          Caption = 'Text File'
          Left = 8
          Top = 16
          Width = 41
          Height = 13
        end
        object Label14: TLabel
          Caption = 'Meta File'
          Left = 8
          Top = 56
          Width = 43
          Height = 13
        end
        object TextFileDefaultCharEncodingComboBox: TComboBoxEx
          ItemsEx = <>
          ItemHeight = 16
          TabOrder = 0
          Left = 19
          Top = 30
          Width = 118
          Height = 22
        end
        object MetaFileDefaultCharEncodingComboBox: TComboBoxEx
          ItemsEx = <>
          ItemHeight = 16
          TabOrder = 1
          Left = 19
          Top = 70
          Width = 118
          Height = 22
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
