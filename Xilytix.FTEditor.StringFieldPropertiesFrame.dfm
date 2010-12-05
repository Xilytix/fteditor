inherited StringFieldPropertiesFrame: TStringFieldPropertiesFrame
  Width = 157
  Height = 353
  ExplicitWidth = 157
  ExplicitHeight = 353
  inherited DelimitedPanel: TPanel
    Top = 154
    Width = 157
    Height = 199
    ExplicitTop = 176
    ExplicitWidth = 157
    ExplicitHeight = 179
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
    ExplicitTop = 176
    ExplicitWidth = 161
    ExplicitHeight = 175
    inherited FixedWidthPageControl: TPageControl
      Width = 157
      Height = 172
      ExplicitWidth = 161
      ExplicitHeight = 148
      inherited ValueTabSheet: TTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 180
        ExplicitHeight = 110
        inherited ValuePadAlignmentComboBox: TComboBoxEx
          TabOrder = 0
          ExplicitWidth = 88
        end
        inherited ValuePadCharTypeComboBox: TComboBoxEx
          TabOrder = 2
          ExplicitWidth = 88
        end
        inherited ValueTruncateTypeComboBox: TComboBoxEx
          ExplicitWidth = 113
        end
        inherited ValuePadCharEdit: TEdit
          TabOrder = 1
        end
      end
      inherited HeadingTabSheet: TTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 161
        ExplicitHeight = 153
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
      Width = 157
      ExplicitWidth = 179
    end
  end
  inherited TopPanel: TPanel
    Width = 157
    Height = 154
    ExplicitWidth = 169
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
      ExplicitWidth = 122
    end
    inherited HeadingConstraintComboBox: TComboBoxEx
      TabOrder = 7
      ExplicitWidth = 82
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
      ExplicitWidth = 112
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
      ExplicitWidth = 104
    end
    inherited HeadingsButton: TButton
      ExplicitLeft = 142
    end
  end
end
