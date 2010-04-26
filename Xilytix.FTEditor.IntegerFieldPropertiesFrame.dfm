inherited IntegerFieldPropertiesFrame: TIntegerFieldPropertiesFrame
  Height = 403
  ExplicitHeight = 403
  inherited DelimitedPanel: TPanel
    Height = 204
    ExplicitTop = 175
    ExplicitWidth = 145
    ExplicitHeight = 34
    inherited Bevel5: TBevel
      ExplicitWidth = 190
    end
    inherited Bevel6: TBevel
      ExplicitWidth = 186
    end
  end
  inherited FixedWidthPanel: TPanel
    Height = 204
    ExplicitTop = 175
    ExplicitWidth = 139
    ExplicitHeight = 169
    inherited FixedWidthPageControl: TPageControl
      Height = 177
      ExplicitWidth = 139
      ExplicitHeight = 142
      inherited ValueTabSheet: TTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 139
        ExplicitHeight = 141
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
        ExplicitWidth = 0
        ExplicitHeight = 200
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
      ExplicitWidth = 147
    end
  end
  inherited TopPanel: TPanel
    inherited DataTypeLabel: TLabel
      Width = 43
      Caption = 'Integer'
      ExplicitWidth = 43
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
