inherited FloatFieldPropertiesFrame: TFloatFieldPropertiesFrame
  Height = 392
  ExplicitHeight = 392
  inherited DelimitedPanel: TPanel
    Height = 193
    ExplicitTop = 174
    ExplicitWidth = 137
    ExplicitHeight = 7
    inherited Bevel5: TBevel
      Width = 189
      ExplicitWidth = 180
    end
    inherited Bevel6: TBevel
      Width = 185
      ExplicitWidth = 176
    end
    inherited ValueQuotedComboBox: TComboBoxEx
      Width = 73
      ExplicitWidth = 65
    end
    inherited HeadingQuotedComboBox: TComboBoxEx
      Width = 73
      ExplicitWidth = 57
    end
  end
  inherited FixedWidthPanel: TPanel
    Height = 193
    ExplicitTop = 174
    ExplicitWidth = 131
    ExplicitHeight = 142
    inherited FixedWidthPageControl: TPageControl
      Height = 166
      ExplicitWidth = 131
      ExplicitHeight = 115
      inherited ValueTabSheet: TTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 131
        ExplicitHeight = 114
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
        ExplicitWidth = 142
        ExplicitHeight = 44
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
      ExplicitWidth = 139
    end
  end
  inherited TopPanel: TPanel
    inherited DataTypeLabel: TLabel
      Width = 28
      Caption = 'Float'
      ExplicitWidth = 28
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
