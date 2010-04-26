inherited DecimalFieldPropertiesFrame: TDecimalFieldPropertiesFrame
  Height = 402
  ExplicitHeight = 402
  inherited DelimitedPanel: TPanel
    Height = 203
    ExplicitTop = 174
    ExplicitWidth = 145
    ExplicitHeight = 34
    inherited Bevel5: TBevel
      Width = 189
      ExplicitWidth = 153
    end
    inherited Bevel6: TBevel
      Width = 185
      ExplicitWidth = 149
    end
    inherited ValueQuotedComboBox: TComboBoxEx
      ExplicitWidth = 79
    end
    inherited HeadingQuotedComboBox: TComboBoxEx
      ExplicitWidth = 79
    end
  end
  inherited FixedWidthPanel: TPanel
    Height = 203
    ExplicitTop = 174
    ExplicitWidth = 123
    ExplicitHeight = 115
    inherited FixedWidthPageControl: TPageControl
      Height = 176
      ExplicitWidth = 123
      ExplicitHeight = 88
      inherited ValueTabSheet: TTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 123
        ExplicitHeight = 87
        inherited ValuePadAlignmentComboBox: TComboBoxEx
          TabOrder = 0
          ExplicitWidth = 80
        end
        inherited ValuePadCharTypeComboBox: TComboBoxEx
          TabOrder = 2
          ExplicitWidth = 80
        end
        inherited ValueTruncateTypeComboBox: TComboBoxEx
          ExplicitWidth = 105
        end
        inherited ValuePadCharEdit: TEdit
          TabOrder = 1
        end
      end
      inherited HeadingTabSheet: TTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 159
        ExplicitHeight = 175
        inherited HeadingPadAlignmentComboBox: TComboBoxEx
          TabOrder = 0
        end
        inherited HeadingPadCharTypeComboBox: TComboBoxEx
          TabOrder = 2
        end
        inherited HeadingPadCharEdit: TEdit
          TabOrder = 1
        end
      end
    end
    inherited FxiedWidthTopPanel: TPanel
      ExplicitWidth = 131
    end
  end
  inherited TopPanel: TPanel
    inherited DataTypeLabel: TLabel
      Width = 45
      Caption = 'Decimal'
      ExplicitWidth = 45
    end
    inherited NameEdit: TEdit
      TabOrder = 0
      ExplicitWidth = 114
    end
    inherited HeadingConstraintComboBox: TComboBoxEx
      TabOrder = 2
    end
    inherited NullConstantCheckBox: TCheckBox
      TabOrder = 3
    end
    inherited ConstantCheckBox: TCheckBox
      TabOrder = 4
    end
    inherited FormatEdit: TEdit
      TabOrder = 5
      ExplicitWidth = 115
    end
    inherited ConstantValueEdit: TEdit
      TabOrder = 6
      ExplicitWidth = 83
    end
    inherited StylesEdit: TEdit
      TabOrder = 7
      ExplicitWidth = 96
    end
    inherited FixedWidthRadioButton: TRadioButton
      TabOrder = 9
    end
    inherited StyleButton: TButton
      TabOrder = 10
      ExplicitLeft = 142
    end
    inherited HeadingsEdit: TEdit
      TabOrder = 11
      ExplicitWidth = 96
    end
    inherited HeadingsButton: TButton
      ExplicitLeft = 134
    end
  end
end
