inherited BooleanFieldPropertiesFrame: TBooleanFieldPropertiesFrame
  Height = 366
  ExplicitHeight = 366
  inherited DelimitedPanel: TPanel
    Top = 210
    Height = 156
    ExplicitTop = 242
    ExplicitWidth = 168
    ExplicitHeight = 173
    inherited Bevel5: TBevel
      Width = 192
      ExplicitWidth = 192
    end
    inherited Bevel6: TBevel
      Width = 188
      ExplicitWidth = 188
    end
  end
  inherited FixedWidthPanel: TPanel
    Top = 210
    Height = 156
    ExplicitTop = 242
    ExplicitWidth = 147
    ExplicitHeight = 138
    inherited FixedWidthPageControl: TPageControl
      Height = 129
      ExplicitWidth = 147
      ExplicitHeight = 111
      inherited ValueTabSheet: TTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 127
        ExplicitHeight = 32
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
        ExplicitWidth = 159
        ExplicitHeight = 86
        inherited HeadingPadCharTypeComboBox: TComboBoxEx
          TabOrder = 2
        end
        inherited HeadingPadCharEdit: TEdit
          TabOrder = 0
        end
      end
    end
    inherited FxiedWidthTopPanel: TPanel
      ExplicitWidth = 155
    end
  end
  inherited TopPanel: TPanel
    Height = 210
    ExplicitWidth = 167
    ExplicitHeight = 210
    inherited DataTypeLabel: TLabel
      Width = 45
      Caption = 'Boolean'
      ExplicitWidth = 45
    end
    object Label6: TLabel [4]
      Left = 3
      Top = 96
      Width = 47
      Height = 13
      Caption = 'True Text'
      FocusControl = TrueTextEdit
    end
    object Label27: TLabel [5]
      Left = 3
      Top = 117
      Width = 50
      Height = 13
      Caption = 'False Text'
      FocusControl = FalseTextEdit
    end
    object Label28: TLabel [6]
      Left = 3
      Top = 138
      Width = 29
      Height = 13
      Caption = 'Styles'
      FocusControl = StylesEdit
    end
    inherited NameEdit: TEdit
      TabOrder = 10
      ExplicitWidth = 122
    end
    inherited HeadingConstraintComboBox: TComboBoxEx
      TabOrder = 11
      ExplicitWidth = 82
    end
    inherited NullConstantCheckBox: TCheckBox
      Left = 86
      Top = 175
      ExplicitLeft = 86
      ExplicitTop = 175
    end
    inherited ConstantCheckBox: TCheckBox
      Top = 158
      TabOrder = 9
      ExplicitTop = 158
    end
    inherited DelimitedRadioButton: TRadioButton
      Top = 195
      ExplicitTop = 195
    end
    object TrueTextEdit: TEdit [14]
      Left = 57
      Top = 93
      Width = 109
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'TrueTextEdit'
      OnExit = StringEditExit
      OnKeyPress = StringEditKeyPress
    end
    object FalseTextEdit: TEdit [15]
      Left = 57
      Top = 114
      Width = 109
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Text = 'TrueTextEdit'
      OnExit = StringEditExit
      OnKeyPress = StringEditKeyPress
    end
    object StylesEdit: TEdit [16]
      Left = 57
      Top = 135
      Width = 91
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      Text = 'TrueTextEdit'
      OnExit = StylesEditExit
      OnKeyPress = StylesEditKeyPress
    end
    object StylesButton: TButton [17]
      Left = 150
      Top = 138
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
      OnClick = StylesButtonClick
    end
    inherited FixedWidthRadioButton: TRadioButton
      Top = 195
      ExplicitTop = 195
    end
    inherited HeadingsEdit: TEdit
      TabOrder = 12
      ExplicitWidth = 104
    end
    object ConstantValueCheckBox: TCheckBox [20]
      Left = 21
      Top = 175
      Width = 49
      Height = 17
      Caption = '&Value'
      TabOrder = 5
      OnClick = CheckBoxClick
    end
    inherited HeadingsButton: TButton
      TabOrder = 13
      ExplicitLeft = 142
    end
  end
end
