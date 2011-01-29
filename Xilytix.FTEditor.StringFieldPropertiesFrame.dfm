inherited StringFieldPropertiesFrame: TStringFieldPropertiesFrame
  Width = 157
  Height = 353
  ExplicitWidth = 157
  ExplicitHeight = 353
  inherited DelimitedPanel: TPanel
    Top = 154
    Width = 157
    Height = 199
    ExplicitTop = 154
    ExplicitWidth = 157
    ExplicitHeight = 199
    inherited Bevel5: TBevel
      Width = 156
      ExplicitWidth = 157
    end
    inherited Bevel6: TBevel
      ExplicitWidth = 156
    end
  end
  inherited FixedWidthPanel: TPanel
    Top = 154
    Width = 157
    Height = 199
    ExplicitTop = 154
    ExplicitWidth = 157
    ExplicitHeight = 199
    inherited FixedWidthPageControl: TPageControl
      Width = 157
      Height = 172
      ExplicitWidth = 157
      ExplicitHeight = 172
      inherited ValueTabSheet: TTabSheet
        ExplicitWidth = 149
        ExplicitHeight = 144
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
        ExplicitWidth = 149
        ExplicitHeight = 144
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
    inherited FxiedWidthTopPanel: TPanel
      Width = 157
      ExplicitWidth = 157
    end
  end
  inherited TopPanel: TPanel
    Width = 157
    Height = 154
    ExplicitWidth = 157
    ExplicitHeight = 154
    inherited DataTypeLabel: TLabel
      Width = 34
      Caption = 'String'
      ExplicitWidth = 34
    end
    object Label8: TLabel [4]
      Left = 22
      Top = 113
      Width = 26
      Height = 13
      Caption = '&Value'
      FocusControl = ConstantValueEdit
    end
    inherited NameEdit: TEdit
      TabOrder = 8
    end
    inherited HeadingConstraintComboBox: TComboBox
      TabOrder = 7
    end
    object ConstantValueEdit: TEdit [9]
      Left = 53
      Top = 110
      Width = 104
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Text = 'ConstantValueEdit'
      OnExit = StringEditExit
      OnKeyPress = StringEditKeyPress
    end
    inherited NullConstantCheckBox: TCheckBox
      Top = 93
      ExplicitTop = 93
    end
    inherited ConstantCheckBox: TCheckBox
      Left = 0
      Top = 93
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 93
    end
    inherited DelimitedRadioButton: TRadioButton
      Left = -2
      Top = 137
      TabOrder = 3
      ExplicitLeft = -2
      ExplicitTop = 137
    end
    inherited FixedWidthRadioButton: TRadioButton
      Left = 72
      Top = 137
      TabOrder = 5
      ExplicitLeft = 72
      ExplicitTop = 137
    end
    inherited HeadingsEdit: TEdit
      TabOrder = 9
    end
  end
end
