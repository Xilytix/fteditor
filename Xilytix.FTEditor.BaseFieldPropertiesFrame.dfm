object BaseFieldPropertiesFrame: TBaseFieldPropertiesFrame
  Left = 0
  Top = 0
  Width = 159
  Height = 377
  TabOrder = 0
  TabStop = True
  object DelimitedPanel: TPanel
    Left = 0
    Top = 177
    Width = 159
    Height = 200
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      159
      200)
    object Label5: TLabel
      Left = 7
      Top = 21
      Width = 36
      Height = 13
      Caption = 'Quoted'
      FocusControl = ValueQuotedComboBox
    end
    object Label4: TLabel
      Left = 7
      Top = 97
      Width = 36
      Height = 13
      Caption = 'Quoted'
      FocusControl = HeadingQuotedComboBox
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Bevel5: TBevel
      Left = 3
      Top = 8
      Width = 160
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
      ExplicitWidth = 159
    end
    object DelimitedValueLabel: TLabel
      Left = 3
      Top = 3
      Width = 26
      Height = 13
      Caption = 'Value'
    end
    object Bevel6: TBevel
      Left = 3
      Top = 85
      Width = 156
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
      ExplicitWidth = 165
    end
    object DelimitedHeadingLabel: TLabel
      Left = 3
      Top = 78
      Width = 39
      Height = 13
      Caption = 'Heading'
    end
    object ValueQuotedComboBox: TComboBoxEx
      Left = 63
      Top = 14
      Width = 92
      Height = 22
      ItemsEx = <>
      Style = csExDropDownList
      TabOrder = 0
      OnChange = ComboBoxChange
    end
    object HeadingQuotedComboBox: TComboBoxEx
      Left = 63
      Top = 92
      Width = 92
      Height = 22
      ItemsEx = <>
      Style = csExDropDownList
      TabOrder = 3
      OnChange = ComboBoxChange
    end
    object ValueWritePrefixSpaceCheckBox: TCheckBox
      Left = 6
      Top = 41
      Width = 113
      Height = 17
      Caption = 'Write Prefix Space'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = CheckBoxClick
    end
    object ValueAlwaysWriteOptionalQuoteCheckBox: TCheckBox
      Left = 6
      Top = 57
      Width = 162
      Height = 17
      Caption = 'Always Write Optional Quote'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = CheckBoxClick
    end
    object HeadingWritePrefixSpaceCheckBox: TCheckBox
      Left = 7
      Top = 115
      Width = 113
      Height = 17
      Caption = 'Write Prefix Space'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = CheckBoxClick
    end
    object HeadingAlwaysWriteOptionalQuoteCheckBox: TCheckBox
      Left = 7
      Top = 131
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
  object FixedWidthPanel: TPanel
    Left = 0
    Top = 177
    Width = 159
    Height = 200
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 211
    ExplicitWidth = 173
    ExplicitHeight = 271
    object FixedWidthPageControl: TPageControl
      Left = 0
      Top = 27
      Width = 159
      Height = 173
      ActivePage = ValueTabSheet
      Align = alClient
      TabOrder = 1
      ExplicitTop = 25
      ExplicitWidth = 364
      ExplicitHeight = 179
      object ValueTabSheet: TTabSheet
        Caption = 'Value'
        DesignSize = (
          151
          145)
        object Label14: TLabel
          Left = 9
          Top = 36
          Width = 47
          Height = 13
          Caption = 'Alignment'
          FocusControl = ValuePadAlignmentComboBox
        end
        object Label15: TLabel
          Left = 9
          Top = 14
          Width = 50
          Height = 13
          Caption = 'Char Type'
          FocusControl = ValuePadCharTypeComboBox
        end
        object Bevel3: TBevel
          Left = 0
          Top = 4
          Width = 165
          Height = 17
          Shape = bsTopLine
        end
        object Label20: TLabel
          Left = 0
          Top = -3
          Width = 18
          Height = 13
          Caption = 'Pad'
        end
        object Label21: TLabel
          Left = 9
          Top = 58
          Width = 23
          Height = 13
          Caption = 'Char'
          FocusControl = ValuePadCharEdit
        end
        object Label22: TLabel
          Left = 79
          Top = 58
          Width = 44
          Height = 13
          Caption = 'EoV Char'
          FocusControl = ValuePadEoFCharEdit
        end
        object Bevel4: TBevel
          Left = 0
          Top = 83
          Width = 165
          Height = 17
          Shape = bsTopLine
        end
        object Label16: TLabel
          Left = 0
          Top = 76
          Width = 43
          Height = 13
          Caption = 'Truncate'
        end
        object Label23: TLabel
          Left = 9
          Top = 93
          Width = 24
          Height = 13
          Caption = 'Type'
          FocusControl = ValueTruncateTypeComboBox
        end
        object Label24: TLabel
          Left = 96
          Top = 114
          Width = 23
          Height = 13
          Caption = 'Char'
          FocusControl = ValueTruncateCharEdit
        end
        object Label10: TLabel
          Left = 0
          Top = 130
          Width = 43
          Height = 13
          Caption = 'Null Char'
          FocusControl = ValueNullCharEdit
        end
        object ValuePadAlignmentComboBox: TComboBoxEx
          Left = 64
          Top = 31
          Width = 88
          Height = 22
          ItemsEx = <>
          Style = csExDropDownList
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          OnChange = ComboBoxChange
          ExplicitWidth = 96
        end
        object ValuePadCharTypeComboBox: TComboBoxEx
          Left = 64
          Top = 9
          Width = 88
          Height = 22
          ItemsEx = <>
          Style = csExDropDownList
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = ComboBoxChange
          ExplicitWidth = 96
        end
        object ValuePadEoFCharEdit: TEdit
          Left = 124
          Top = 55
          Width = 37
          Height = 21
          TabOrder = 3
          Text = 'Edit1'
          OnExit = CharEditExit
          OnKeyPress = CharEditKeyPress
        end
        object ValueTruncateTypeComboBox: TComboBoxEx
          Left = 39
          Top = 88
          Width = 113
          Height = 22
          ItemsEx = <>
          Style = csExDropDownList
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 4
          OnChange = ComboBoxChange
          ExplicitWidth = 121
        end
        object ValuePadCharEdit: TEdit
          Left = 35
          Top = 55
          Width = 37
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
          OnExit = CharEditExit
          OnKeyPress = CharEditKeyPress
        end
        object ValueTruncateCharEdit: TEdit
          Left = 124
          Top = 111
          Width = 37
          Height = 21
          TabOrder = 5
          Text = 'Edit1'
          OnExit = CharEditExit
          OnKeyPress = CharEditKeyPress
        end
        object ValueNullCharEdit: TEdit
          Left = 48
          Top = 127
          Width = 36
          Height = 21
          TabOrder = 6
          Text = 'Edit1'
          OnExit = CharEditExit
          OnKeyPress = CharEditKeyPress
        end
      end
      object HeadingTabSheet: TTabSheet
        Caption = 'Heading'
        ImageIndex = 1
        DesignSize = (
          151
          145)
        object Label11: TLabel
          Left = 9
          Top = 36
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
        object Label12: TLabel
          Left = 9
          Top = 14
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
        object Bevel1: TBevel
          Left = 0
          Top = 4
          Width = 165
          Height = 17
          Shape = bsTopLine
        end
        object Label13: TLabel
          Left = 0
          Top = -3
          Width = 18
          Height = 13
          Caption = 'Pad'
        end
        object Label17: TLabel
          Left = 9
          Top = 58
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
        object Label18: TLabel
          Left = 79
          Top = 58
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
        object Bevel2: TBevel
          Left = 0
          Top = 83
          Width = 165
          Height = 17
          Shape = bsTopLine
        end
        object Label19: TLabel
          Left = 0
          Top = 76
          Width = 43
          Height = 13
          Caption = 'Truncate'
        end
        object Label25: TLabel
          Left = 9
          Top = 93
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
        object Label26: TLabel
          Left = 96
          Top = 114
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
        object HeadingPadAlignmentComboBox: TComboBoxEx
          Left = 64
          Top = 31
          Width = 88
          Height = 22
          ItemsEx = <>
          Style = csExDropDownList
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
          OnChange = ComboBoxChange
          ExplicitWidth = 96
        end
        object HeadingPadCharTypeComboBox: TComboBoxEx
          Left = 64
          Top = 9
          Width = 88
          Height = 22
          ItemsEx = <>
          Style = csExDropDownList
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = ComboBoxChange
          ExplicitWidth = 96
        end
        object HeadingPadEoFCharEdit: TEdit
          Left = 124
          Top = 55
          Width = 37
          Height = 21
          TabOrder = 3
          Text = 'Edit1'
          OnExit = CharEditExit
          OnKeyPress = CharEditKeyPress
        end
        object HeadingTruncateTypeComboBox: TComboBoxEx
          Left = 39
          Top = 88
          Width = 113
          Height = 22
          ItemsEx = <>
          Style = csExDropDownList
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 4
          OnChange = ComboBoxChange
          ExplicitWidth = 121
        end
        object HeadingPadCharEdit: TEdit
          Left = 35
          Top = 55
          Width = 37
          Height = 21
          TabOrder = 2
          Text = 'Edit1'
          OnExit = CharEditExit
          OnKeyPress = CharEditKeyPress
        end
        object HeadingTruncateCharEdit: TEdit
          Left = 124
          Top = 111
          Width = 37
          Height = 21
          TabOrder = 5
          Text = 'Edit1'
          OnExit = CharEditExit
          OnKeyPress = CharEditKeyPress
        end
      end
    end
    object FxiedWidthTopPanel: TPanel
      Left = 0
      Top = 0
      Width = 159
      Height = 27
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitWidth = 167
      object Label9: TLabel
        Left = 3
        Top = 6
        Width = 28
        Height = 13
        Caption = 'Width'
        FocusControl = WidthEdit
      end
      object WidthEdit: TEdit
        Left = 40
        Top = 3
        Width = 60
        Height = 21
        TabOrder = 0
        Text = 'WidthEdit'
        OnExit = IntegerEditExit
        OnKeyPress = IntegerEditKeyPress
      end
    end
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 159
    Height = 177
    Align = alTop
    BevelEdges = []
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 166
    DesignSize = (
      159
      177)
    object Label1: TLabel
      Left = 3
      Top = 3
      Width = 27
      Height = 13
      Caption = 'Name'
      FocusControl = NameEdit
    end
    object Label3: TLabel
      Left = 3
      Top = 51
      Width = 72
      Height = 13
      Caption = 'Hdg Constraint'
      FocusControl = HeadingConstraintComboBox
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 3
      Top = 26
      Width = 10
      Height = 13
      Caption = 'Id'
      FocusControl = IdEdit
    end
    object DataTypeLabel: TLabel
      Left = 107
      Top = 21
      Width = 85
      Height = 13
      Caption = 'DataTypeLabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object HeadingsLabel: TLabel
      Left = 3
      Top = 73
      Width = 24
      Height = 13
      Caption = 'Hdgs'
      FocusControl = HeadingsEdit
    end
    object NameEdit: TEdit
      Left = 36
      Top = 0
      Width = 122
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'NameEdit'
      OnExit = StringEditExit
      OnKeyPress = StringEditKeyPress
      ExplicitWidth = 130
    end
    object IdEdit: TEdit
      Left = 36
      Top = 23
      Width = 64
      Height = 21
      TabOrder = 1
      Text = '123456789'
      OnExit = IntegerEditExit
      OnKeyPress = IntegerEditKeyPress
    end
    object HeadingConstraintComboBox: TComboBoxEx
      Left = 77
      Top = 46
      Width = 82
      Height = 22
      ItemsEx = <
        item
          Caption = '<Default>'
        end
        item
          Caption = 'None'
        end
        item
          Caption = 'All Constant'
        end
        item
          Caption = 'Main Constant'
        end
        item
          Caption = 'Name Constant'
        end
        item
          Caption = 'Name Is Main'
        end>
      Style = csExDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      OnChange = ComboBoxChange
      ExplicitWidth = 90
    end
    object NullConstantCheckBox: TCheckBox
      Left = 130
      Top = 94
      Width = 35
      Height = 17
      Caption = 'Null'
      TabOrder = 6
      OnClick = CheckBoxClick
    end
    object ConstantCheckBox: TCheckBox
      Left = 3
      Top = 94
      Width = 65
      Height = 17
      Caption = 'Constant'
      TabOrder = 5
      OnClick = CheckBoxClick
    end
    object DelimitedRadioButton: TRadioButton
      Left = 3
      Top = 127
      Width = 62
      Height = 17
      Caption = 'Delimited'
      TabOrder = 7
      OnClick = DelimitedRadioButtonClick
    end
    object FixedWidthRadioButton: TRadioButton
      Left = 77
      Top = 127
      Width = 75
      Height = 17
      Caption = 'Fixed Width'
      TabOrder = 8
      OnClick = FixedWidthRadioButtonClick
    end
    object HeadingsEdit: TEdit
      Left = 36
      Top = 70
      Width = 104
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      Text = 'HeadingsEdit'
      OnExit = CommaTextEditExit
      OnKeyPress = CommaTextEditKeyPress
      ExplicitWidth = 112
    end
    object HeadingsButton: TButton
      Left = 142
      Top = 72
      Width = 15
      Height = 17
      Anchors = [akTop, akRight]
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = HeadingsButtonClick
      ExplicitLeft = 150
    end
  end
end
