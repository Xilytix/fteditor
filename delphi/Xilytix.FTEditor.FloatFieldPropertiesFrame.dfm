inherited FloatFieldPropertiesFrame: TFloatFieldPropertiesFrame
  Height = 392
  ExplicitHeight = 392
  inherited DelimitedPanel: TPanel
    Height = 193
    ExplicitHeight = 193
    inherited Bevel5: TBevel
      Width = 189
      ExplicitWidth = 180
    end
    inherited Bevel6: TBevel
      Width = 185
      ExplicitWidth = 176
    end
    inherited ValueQuotedComboBox: TComboBox
      Width = 73
      ExplicitWidth = 73
    end
    inherited HeadingQuotedComboBox: TComboBox
      Width = 73
      ExplicitWidth = 73
    end
  end
  inherited FixedWidthPanel: TPanel
    Height = 193
    ExplicitHeight = 193
    inherited FixedWidthPageControl: TPageControl
      Height = 166
      ExplicitHeight = 166
      inherited ValueTabSheet: TTabSheet
        ExplicitHeight = 138
        inherited ValuePadAlignmentComboBox: TComboBox
          TabOrder = 0
        end
        inherited ValuePadCharTypeComboBox: TComboBox
          TabOrder = 2
        end
        inherited ValuePadCharEdit: TEdit
          TabOrder = 1
        end
      end
      inherited HeadingTabSheet: TTabSheet
        ExplicitHeight = 138
        inherited HeadingPadAlignmentComboBox: TComboBox
          TabOrder = 0
        end
        inherited HeadingPadCharTypeComboBox: TComboBox
          TabOrder = 2
        end
        inherited HeadingPadCharEdit: TEdit
          TabOrder = 1
        end
      end
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
    end
    inherited HeadingConstraintComboBox: TComboBox
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
    end
    inherited ConstantValueEdit: TEdit
      TabOrder = 6
    end
    inherited StylesEdit: TEdit
      TabOrder = 7
    end
    inherited FixedWidthRadioButton: TRadioButton
      TabOrder = 9
    end
    inherited StyleButton: TButton
      TabOrder = 10
    end
    inherited HeadingsEdit: TEdit
      TabOrder = 11
    end
  end
end
