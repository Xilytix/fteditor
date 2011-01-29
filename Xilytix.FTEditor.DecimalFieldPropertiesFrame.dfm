inherited DecimalFieldPropertiesFrame: TDecimalFieldPropertiesFrame
  Height = 402
  ExplicitHeight = 402
  inherited DelimitedPanel: TPanel
    Height = 203
    ExplicitHeight = 203
    inherited Bevel5: TBevel
      Width = 189
      ExplicitWidth = 153
    end
    inherited Bevel6: TBevel
      Width = 185
      ExplicitWidth = 149
    end
  end
  inherited FixedWidthPanel: TPanel
    Height = 203
    ExplicitHeight = 203
    inherited FixedWidthPageControl: TPageControl
      Height = 176
      ExplicitHeight = 176
      inherited ValueTabSheet: TTabSheet
        ExplicitHeight = 148
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
        ExplicitHeight = 148
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
      Width = 45
      Caption = 'Decimal'
      ExplicitWidth = 45
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
