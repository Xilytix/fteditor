inherited MainPropertiesFrame: TMainPropertiesFrame
  Width = 264
  Height = 195
  ExplicitWidth = 264
  ExplicitHeight = 195
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 264
    Height = 195
    ActivePage = FileTabSheet
    Align = alClient
    TabOrder = 0
    object MainTabSheet: TTabSheet
      Caption = 'Main'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object CultureEditLabel: TLabel
        Left = 159
        Top = 99
        Width = 35
        Height = 13
        Caption = 'Culture'
        FocusControl = CultureEdit
      end
      object Label2: TLabel
        Left = 0
        Top = 6
        Width = 41
        Height = 13
        Caption = 'Delimiter'
        FocusControl = DelimiterCharEdit
      end
      object Label3: TLabel
        Left = 88
        Top = 6
        Width = 30
        Height = 13
        Caption = 'Quote'
        FocusControl = QuoteCharEdit
      end
      object Label4: TLabel
        Left = 167
        Top = 6
        Width = 45
        Height = 13
        Caption = 'Comment'
        FocusControl = CommentCharEdit
      end
      object Label6: TLabel
        Left = 18
        Top = 73
        Width = 23
        Height = 13
        Caption = 'Char'
        FocusControl = EndOfLineCharEdit
      end
      object Label7: TLabel
        Left = 18
        Top = 48
        Width = 24
        Height = 13
        Caption = 'Type'
        FocusControl = EndOfLineTypeComboBox
      end
      object Label8: TLabel
        Left = 120
        Top = 73
        Width = 52
        Height = 13
        Caption = 'Auto Write'
        FocusControl = EndOfLineAutoWriteComboBox
      end
      object Bevel1: TBevel
        Left = 64
        Top = 32
        Width = 194
        Height = 3
        Shape = bsTopLine
      end
      object Label9: TLabel
        Left = 3
        Top = 25
        Width = 55
        Height = 13
        Caption = 'End-of-Line'
      end
      object CultureEdit: TEdit
        Left = 159
        Top = 114
        Width = 96
        Height = 21
        TabOrder = 10
        Text = 'CultureEdit'
        OnExit = CultureEditExit
        OnKeyPress = CultureEditKeyPress
      end
      object DelimiterCharEdit: TEdit
        Left = 43
        Top = 3
        Width = 37
        Height = 21
        BevelEdges = []
        BevelInner = bvNone
        BevelOuter = bvNone
        TabOrder = 0
        Text = 'DelimiterCharEdit'
        OnExit = CharEditExit
        OnKeyPress = CharEditKeyPress
      end
      object QuoteCharEdit: TEdit
        Left = 121
        Top = 3
        Width = 37
        Height = 21
        TabOrder = 1
        Text = 'Edit1'
        OnExit = CharEditExit
        OnKeyPress = CharEditKeyPress
      end
      object CommentCharEdit: TEdit
        Left = 218
        Top = 3
        Width = 37
        Height = 21
        TabOrder = 2
        Text = 'Edit1'
        OnExit = CharEditExit
        OnKeyPress = CharEditKeyPress
      end
      object IgnoreBlankLinesCheckBox: TCheckBox
        Left = 3
        Top = 97
        Width = 121
        Height = 19
        Caption = 'Ignore Blank Lines'
        TabOrder = 7
        OnClick = CheckBoxClick
      end
      object AllowInQuotesCheckBox: TCheckBox
        Left = 120
        Top = 45
        Width = 98
        Height = 19
        Caption = 'Allow in Quotes'
        TabOrder = 4
        OnClick = CheckBoxClick
      end
      object IgnoreExtraFieldsCheckBox: TCheckBox
        Left = 3
        Top = 113
        Width = 121
        Height = 19
        Caption = 'Ignore Extra Chars'
        TabOrder = 8
        OnClick = CheckBoxClick
      end
      object EndOfLineTypeComboBox: TComboBox
        Left = 46
        Top = 43
        Width = 57
        Height = 21
        Style = csDropDownList
        TabOrder = 3
        OnChange = ComboBoxChange
      end
      object EndOfLineCharEdit: TEdit
        Left = 46
        Top = 70
        Width = 37
        Height = 21
        TabOrder = 5
        Text = 'Edit1'
        OnExit = CharEditExit
        OnKeyPress = CharEditKeyPress
      end
      object EndOfLineAutoWriteComboBox: TComboBox
        Left = 177
        Top = 67
        Width = 57
        Height = 21
        Style = csDropDownList
        TabOrder = 6
        OnChange = ComboBoxChange
      end
      object StuffedEmbeddedQuotesCheckBox: TCheckBox
        Left = 3
        Top = 129
        Width = 153
        Height = 19
        Caption = 'Stuffed Embedded Quotes'
        TabOrder = 9
        OnClick = CheckBoxClick
      end
    end
    object HeadingTabSheet: TTabSheet
      Caption = 'Heading'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label10: TLabel
        Left = 0
        Top = 3
        Width = 51
        Height = 13
        Caption = 'Line Count'
        FocusControl = HeadingLineCountEdit
      end
      object Label11: TLabel
        Left = 120
        Top = 3
        Width = 75
        Height = 13
        Caption = 'Main Line Index'
        FocusControl = HeadingMainLineIndexEdit
      end
      object Bevel2: TBevel
        Left = 0
        Top = 23
        Width = 256
        Height = 17
        Shape = bsTopLine
      end
      object Label12: TLabel
        Left = 145
        Top = 28
        Width = 50
        Height = 13
        Caption = 'Constraint'
        FocusControl = HeadingConstraintComboBox
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 0
        Top = 32
        Width = 63
        Height = 13
        Caption = 'Quoted Type'
        FocusControl = HeadingQuotedTypeComboBox
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 11
        Top = 127
        Width = 47
        Height = 13
        Caption = 'Alignment'
        FocusControl = HeadingPadAlignmentComboBox
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 11
        Top = 103
        Width = 50
        Height = 13
        Caption = 'Char Type'
        FocusControl = HeadingPadCharTypeComboBox
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Bevel3: TBevel
        Left = 24
        Top = 94
        Width = 232
        Height = 17
        Shape = bsTopLine
      end
      object Label20: TLabel
        Left = 0
        Top = 86
        Width = 18
        Height = 13
        Caption = 'Pad'
      end
      object Label21: TLabel
        Left = 174
        Top = 103
        Width = 23
        Height = 13
        Caption = 'Char'
        FocusControl = HeadingPadCharEdit
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 174
        Top = 127
        Width = 44
        Height = 13
        Caption = 'EoV Char'
        FocusControl = HeadingPadEoFCharEdit
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Bevel4: TBevel
        Left = 49
        Top = 152
        Width = 207
        Height = 17
        Shape = bsTopLine
      end
      object Label16: TLabel
        Left = 0
        Top = 145
        Width = 43
        Height = 13
        Caption = 'Truncate'
      end
      object Label23: TLabel
        Left = 11
        Top = 161
        Width = 24
        Height = 13
        Caption = 'Type'
        FocusControl = HeadingTruncateTypeComboBox
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label24: TLabel
        Left = 174
        Top = 161
        Width = 23
        Height = 13
        Caption = 'Char'
        FocusControl = HeadingTruncateCharEdit
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object HeadingConstraintComboBox: TComboBox
        Left = 158
        Top = 43
        Width = 98
        Height = 21
        Style = csDropDownList
        TabOrder = 5
        OnChange = ComboBoxChange
      end
      object HeadingQuotedTypeComboBox: TComboBox
        Left = 67
        Top = 27
        Width = 65
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnChange = ComboBoxChange
      end
      object HeadingPadAlignmentComboBox: TComboBox
        Left = 72
        Top = 122
        Width = 83
        Height = 21
        Style = csDropDownList
        TabOrder = 8
        OnChange = ComboBoxChange
      end
      object HeadingPadCharTypeComboBox: TComboBox
        Left = 72
        Top = 98
        Width = 83
        Height = 21
        Style = csDropDownList
        TabOrder = 6
        OnChange = ComboBoxChange
      end
      object HeadingPadEoFCharEdit: TEdit
        Left = 219
        Top = 124
        Width = 37
        Height = 21
        TabOrder = 9
        Text = 'Edit1'
        OnExit = CharEditExit
        OnKeyPress = CharEditKeyPress
      end
      object HeadingTruncateTypeComboBox: TComboBox
        Left = 49
        Top = 156
        Width = 106
        Height = 21
        Style = csDropDownList
        TabOrder = 10
        OnChange = ComboBoxChange
      end
      object HeadingLineCountEdit: TEdit
        Left = 56
        Top = 0
        Width = 41
        Height = 21
        TabOrder = 0
        Text = 'Edit1'
        OnExit = IntegerEditExit
        OnKeyPress = IntegerEditKeyPress
      end
      object HeadingMainLineIndexEdit: TEdit
        Left = 199
        Top = 0
        Width = 41
        Height = 21
        TabOrder = 1
        Text = 'Edit1'
        OnExit = IntegerEditExit
        OnKeyPress = IntegerEditKeyPress
      end
      object HeadingPadCharEdit: TEdit
        Left = 219
        Top = 100
        Width = 37
        Height = 21
        TabOrder = 7
        Text = 'Edit1'
        OnExit = CharEditExit
        OnKeyPress = CharEditKeyPress
      end
      object HeadingTruncateCharEdit: TEdit
        Left = 219
        Top = 158
        Width = 37
        Height = 21
        TabOrder = 11
        Text = 'Edit1'
        OnExit = CharEditExit
        OnKeyPress = CharEditKeyPress
      end
      object HeadingWritePrefixSpaceCheckBox: TCheckBox
        Left = 0
        Top = 52
        Width = 113
        Height = 17
        Caption = 'Write Prefix Space'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = CheckBoxClick
      end
      object HeadingAlwaysWriteOptionalQuoteCheckBox: TCheckBox
        Left = 0
        Top = 68
        Width = 162
        Height = 17
        Caption = 'Always Write Optional Quote'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = cl3DDkShadow
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = CheckBoxClick
      end
    end
    object SubstitutionsTabSheet: TTabSheet
      Caption = 'Substitutions'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SubstitutionsTopPanel: TPanel
        Left = 0
        Top = 0
        Width = 256
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label5: TLabel
          Left = 104
          Top = 3
          Width = 23
          Height = 13
          Caption = 'Char'
          FocusControl = SubstitutionCharEdit
        end
        object SubstitutionCharEdit: TEdit
          Left = 144
          Top = 0
          Width = 37
          Height = 21
          TabOrder = 1
          Text = 'Edit1'
          OnExit = CharEditExit
          OnKeyPress = CharEditKeyPress
        end
        object SubstitutionsEnabledCheckBox: TCheckBox
          Left = 1
          Top = 2
          Width = 97
          Height = 17
          Caption = 'Enabled'
          TabOrder = 0
          OnClick = CheckBoxClick
        end
      end
      object SubstitutionPropertiesPanel: TPanel
        Left = 65
        Top = 25
        Width = 191
        Height = 142
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        DesignSize = (
          191
          142)
        object SubstitutionsSplitter: TSplitter
          Left = 0
          Top = 0
          Height = 142
          ExplicitLeft = 24
          ExplicitTop = 56
          ExplicitHeight = 140
        end
        object Label39: TLabel
          Left = 11
          Top = 19
          Width = 55
          Height = 13
          Caption = 'Token Char'
          FocusControl = SubstitutionTokenEdit
        end
        object Bevel7: TBevel
          Left = 118
          Top = 121
          Width = 69
          Height = 8
          Anchors = [akLeft, akTop, akRight]
          Shape = bsTopLine
        end
        object Label40: TLabel
          Left = 11
          Top = 114
          Width = 101
          Height = 13
          Caption = 'XML Character Entity'
        end
        object SubstitutionTypeStringRadioButton: TRadioButton
          Left = 9
          Top = 47
          Width = 65
          Height = 17
          Caption = 'String'
          TabOrder = 1
          OnClick = SubstitutionTypeStringRadioButtonClick
        end
        object SubstitutionStringValueEdit: TEdit
          Left = 72
          Top = 46
          Width = 116
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          Text = 'SubstitutionStringValueEdit'
          OnEnter = SubstitutionStringValueEditEnter
          OnExit = SubstitutionStringValueEditExit
          OnKeyPress = SubstitutionStringValueEditKeyPress
        end
        object SubstitutionTypeCharRadioButton: TRadioButton
          Left = 9
          Top = 72
          Width = 56
          Height = 17
          Caption = 'Char'
          TabOrder = 3
          OnClick = SubstitutionTypeCharRadioButtonClick
        end
        object SubstitutionCharValueEdit: TEdit
          Left = 72
          Top = 70
          Width = 38
          Height = 21
          TabOrder = 4
          Text = 'SubstitutionStringValueEdit'
          OnEnter = SubstitutionCharValueEditEnter
          OnExit = SubstitutionCharValueEditExit
          OnKeyPress = SubstitutionCharValueEditKeyPress
        end
        object SubstitutionTypeAutoEndOfLineRadioButton: TRadioButton
          Left = 9
          Top = 93
          Width = 107
          Height = 17
          Caption = 'Auto End-of-Line'
          TabOrder = 5
          OnClick = SubstitutionTypeAutoEndOfLineRadioButtonClick
        end
        object SubstitutionTypeXmlCharLessThanRadioButton: TRadioButton
          Left = 9
          Top = 129
          Width = 32
          Height = 17
          Caption = '<'
          TabOrder = 6
          OnClick = SubstitutionTypeXmlCharLessThanRadioButtonClick
        end
        object SubstitutionTokenEdit: TEdit
          Left = 72
          Top = 16
          Width = 37
          Height = 21
          TabOrder = 0
          Text = 'Edit1'
          OnExit = SubstitutionTokenEditExit
          OnKeyPress = SubstitutionTokenEditKeyPress
        end
        object SubstitutionTypeXmlCharGreaterThanRadioButton: TRadioButton
          Left = 48
          Top = 129
          Width = 32
          Height = 17
          Caption = '>'
          TabOrder = 7
          OnClick = SubstitutionTypeXmlCharGreaterThanRadioButtonClick
        end
        object SubstitutionTypeXmlCharAmpersandRadioButton: TRadioButton
          Left = 87
          Top = 129
          Width = 32
          Height = 17
          Caption = '&&'
          TabOrder = 8
          OnClick = SubstitutionTypeXmlCharAmpersandRadioButtonClick
        end
        object SubstitutionTypeXmlCharApostropheRadioButton: TRadioButton
          Left = 126
          Top = 129
          Width = 32
          Height = 17
          Caption = #39
          TabOrder = 9
          OnClick = SubstitutionTypeXmlCharApostropheRadioButtonClick
        end
        object SubstitutionTypeXmlCharQuotationMarkRadioButton: TRadioButton
          Left = 163
          Top = 129
          Width = 32
          Height = 17
          Caption = '"'
          TabOrder = 10
          OnClick = SubstitutionTypeXmlCharQuotationMarkRadioButtonClick
        end
      end
      object SubstitutionsListPanel: TPanel
        Left = 0
        Top = 25
        Width = 65
        Height = 142
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object Label38: TLabel
          Left = 0
          Top = 0
          Width = 65
          Height = 13
          Align = alTop
          Caption = 'Substitutions'
          FocusControl = SubstitutionsButtonGroup
          ExplicitWidth = 62
        end
        object SubstitutionsButtonGroup: TButtonGroup
          Left = 0
          Top = 13
          Width = 65
          Height = 112
          Align = alClient
          BevelInner = bvNone
          BorderStyle = bsNone
          ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
          Items = <>
          TabOrder = 0
          OnClick = SubstitutionsButtonGroupClick
        end
        object SubstitutionAddRemovePanel: TPanel
          Left = 0
          Top = 125
          Width = 65
          Height = 17
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object SubstitutionsAddButton: TButton
            AlignWithMargins = True
            Left = 0
            Top = 0
            Width = 28
            Height = 17
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alLeft
            Caption = 'Add'
            TabOrder = 0
            OnClick = SubstitutionsAddButtonClick
          end
          object SubstitutionsRemoveButton: TButton
            Left = 33
            Top = 0
            Width = 32
            Height = 17
            Align = alClient
            Caption = 'Rem'
            TabOrder = 1
            OnClick = SubstitutionsRemoveButtonClick
          end
        end
      end
    end
    object DesignTabSheet: TTabSheet
      Caption = 'Design'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        256
        167)
      object Bevel5: TBevel
        Left = 115
        Top = 26
        Width = 139
        Height = 17
        Shape = bsTopLine
      end
      object Label25: TLabel
        Left = 0
        Top = 19
        Width = 109
        Height = 13
        Caption = 'New Field Format/Text'
      end
      object Label27: TLabel
        Left = 10
        Top = 38
        Width = 36
        Height = 13
        Caption = 'Integer'
        FocusControl = DesignNewFieldFormatIntegerEdit
      end
      object Label28: TLabel
        Left = 10
        Top = 59
        Width = 24
        Height = 13
        Caption = 'Float'
        FocusControl = DesignNewFieldFormatFloatEdit
      end
      object Label29: TLabel
        Left = 134
        Top = 38
        Width = 36
        Height = 13
        Caption = 'Decimal'
        FocusControl = DesignNewFieldFormatDecimalEdit
      end
      object Label30: TLabel
        Left = 134
        Top = 58
        Width = 45
        Height = 13
        Caption = 'DateTime'
        FocusControl = DesignNewFieldFormatDateTimeEdit
      end
      object Bevel6: TBevel
        Left = 84
        Top = 107
        Width = 170
        Height = 17
        Shape = bsTopLine
      end
      object Label31: TLabel
        Left = 0
        Top = 100
        Width = 78
        Height = 13
        Caption = 'New Field Styles'
      end
      object Label33: TLabel
        Left = 10
        Top = 118
        Width = 36
        Height = 13
        Caption = 'Integer'
      end
      object Label34: TLabel
        Left = 10
        Top = 139
        Width = 24
        Height = 13
        Caption = 'Float'
      end
      object Label35: TLabel
        Left = 134
        Top = 118
        Width = 36
        Height = 13
        Caption = 'Decimal'
      end
      object Label36: TLabel
        Left = 134
        Top = 139
        Width = 45
        Height = 13
        Caption = 'DateTime'
      end
      object Label32: TLabel
        Left = 10
        Top = 161
        Width = 38
        Height = 13
        Caption = 'Boolean'
        FocusControl = DesignNewFieldStylesBooleanEdit
      end
      object Label26: TLabel
        Left = 10
        Top = 79
        Width = 22
        Height = 13
        Caption = 'True'
        FocusControl = DesignNewFieldTrueTextEdit
      end
      object Label37: TLabel
        Left = 134
        Top = 79
        Width = 25
        Height = 13
        Caption = 'False'
        FocusControl = DesignNewFieldFalseTextEdit
      end
      object SaveDesignOnlyMetaCheckBox: TCheckBox
        Left = 0
        Top = 0
        Width = 137
        Height = 17
        Caption = 'Save Design Only Meta'
        TabOrder = 0
      end
      object DesignNewFieldFormatIntegerEdit: TEdit
        Left = 51
        Top = 34
        Width = 72
        Height = 21
        TabOrder = 1
        Text = 'Edit7'
        OnExit = StringEditExit
        OnKeyPress = StringEditKeyPress
      end
      object DesignNewFieldFormatFloatEdit: TEdit
        Left = 51
        Top = 55
        Width = 72
        Height = 21
        TabOrder = 3
        Text = 'Edit7'
        OnExit = StringEditExit
        OnKeyPress = StringEditKeyPress
      end
      object DesignNewFieldFormatDecimalEdit: TEdit
        Left = 182
        Top = 34
        Width = 74
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        Text = 'Edit7'
        OnExit = StringEditExit
        OnKeyPress = StringEditKeyPress
      end
      object DesignNewFieldFormatDateTimeEdit: TEdit
        Left = 182
        Top = 55
        Width = 74
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 4
        Text = 'Edit7'
        OnExit = StringEditExit
        OnKeyPress = StringEditKeyPress
      end
      object DesignNewFieldStylesIntegerEdit: TEdit
        Left = 51
        Top = 115
        Width = 54
        Height = 21
        TabOrder = 7
        Text = 'Edit7'
        OnExit = DesignNewFieldStylesIntegerEditExit
        OnKeyPress = DesignNewFieldStylesIntegerEditKeyPress
      end
      object DesignNewFieldStylesFloatEdit: TEdit
        Left = 51
        Top = 136
        Width = 54
        Height = 21
        TabOrder = 11
        Text = 'Edit7'
        OnExit = DesignNewFieldStylesFloatEditExit
        OnKeyPress = DesignNewFieldStylesFloatEditKeyPress
      end
      object DesignNewFieldStylesDecimalEdit: TEdit
        Left = 182
        Top = 115
        Width = 56
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 9
        Text = 'Edit7'
        OnExit = DesignNewFieldStylesDecimalEditExit
        OnKeyPress = DesignNewFieldStylesDecimalEditKeyPress
      end
      object DesignNewFieldStylesDateTimeEdit: TEdit
        Left = 182
        Top = 136
        Width = 56
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 13
        Text = 'Edit7'
        OnExit = DesignNewFieldStylesDateTimeEditExit
        OnKeyPress = DesignNewFieldStylesDateTimeEditKeyPress
      end
      object DesignNewFieldStylesIntegerButton: TButton
        Left = 107
        Top = 117
        Width = 16
        Height = 17
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        OnClick = DesignNewFieldStylesIntegerButtonClick
      end
      object DesignNewFieldStylesFloatButton: TButton
        Left = 107
        Top = 138
        Width = 16
        Height = 17
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = DesignNewFieldStylesFloatButtonClick
      end
      object DesignNewFieldStylesDecimalButton: TButton
        Left = 239
        Top = 117
        Width = 16
        Height = 17
        Anchors = [akTop, akRight]
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        OnClick = DesignNewFieldStylesDecimalButtonClick
      end
      object DesignNewFieldStylesDateTimeButton: TButton
        Left = 239
        Top = 138
        Width = 16
        Height = 17
        Anchors = [akTop, akRight]
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        OnClick = DesignNewFieldStylesDateTimeButtonClick
      end
      object DesignNewFieldStylesBooleanEdit: TEdit
        Left = 51
        Top = 157
        Width = 187
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 15
        Text = 'DesignNewFieldFormatBooleanEdit'
        OnExit = DesignNewFieldStylesBooleanEditExit
        OnKeyPress = DesignNewFieldStylesBooleanEditKeyPress
      end
      object DesignNewFieldsStyleBooleanButton: TButton
        Left = 239
        Top = 159
        Width = 16
        Height = 17
        Anchors = [akTop, akRight]
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 16
        OnClick = DesignNewFieldsStyleBooleanButtonClick
      end
      object DesignNewFieldTrueTextEdit: TEdit
        Left = 51
        Top = 76
        Width = 72
        Height = 21
        TabOrder = 5
        Text = 'DesignNewFieldTrueTextEdit'
        OnExit = StringEditExit
        OnKeyPress = StringEditKeyPress
      end
      object DesignNewFieldFalseTextEdit: TEdit
        Left = 182
        Top = 76
        Width = 74
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 6
        Text = 'Edit7'
        OnExit = StringEditExit
        OnKeyPress = StringEditKeyPress
      end
    end
    object FileTabSheet: TTabSheet
      Caption = 'Declare'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object FileParametersValueListEditor: TValueListEditor
        Left = 0
        Top = 107
        Width = 256
        Height = 60
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 1
        TitleCaptions.Strings = (
          'Name'
          'Value')
        Visible = False
        ColWidths = (
          96
          158)
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 256
        Height = 107
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          256
          107)
        object Label17: TLabel
          Left = 83
          Top = 22
          Width = 71
          Height = 13
          Caption = 'Meta Ref Type'
          FocusControl = MetaReferenceTypeComboBox
        end
        object Label18: TLabel
          Left = 0
          Top = 45
          Width = 77
          Height = 13
          Caption = 'Meta Reference'
          FocusControl = MetaReferenceEdit
        end
        object Label19: TLabel
          Left = 0
          Top = 90
          Width = 55
          Height = 13
          Caption = 'Parameters'
          FocusControl = FileParametersValueListEditor
          Visible = False
        end
        object FileNoteLabel: TLabel
          Left = 0
          Top = 1
          Width = 253
          Height = 13
          Caption = 'Note: These properties are from Text File (not Meta)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGrayText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object DeclaredCheckBox: TCheckBox
          Left = 0
          Top = 21
          Width = 65
          Height = 17
          Caption = 'Declared'
          TabOrder = 0
          OnClick = CheckBoxClick
        end
        object MetaReferenceTypeComboBox: TComboBox
          Left = 157
          Top = 17
          Width = 96
          Height = 21
          Style = csDropDownList
          TabOrder = 1
          OnChange = ComboBoxChange
        end
        object MetaReferenceEdit: TEdit
          Left = 8
          Top = 62
          Width = 231
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 2
          Text = 'MetaReferenceEdit'
          OnExit = StringEditExit
          OnKeyPress = StringEditKeyPress
        end
      end
    end
  end
end
