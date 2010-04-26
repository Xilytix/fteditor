inherited NumberFieldPropertiesFrame: TNumberFieldPropertiesFrame
  Height = 404
  ExplicitHeight = 404
  inherited DelimitedPanel: TPanel
    Top = 199
    Height = 205
    ExplicitTop = 199
    ExplicitHeight = 205
    DesignSize = (
      159
      205)
    inherited Bevel5: TBevel
      Width = 191
      ExplicitWidth = 161
    end
    inherited Bevel6: TBevel
      Width = 187
      ExplicitWidth = 157
    end
  end
  inherited FixedWidthPanel: TPanel
    Top = 199
    Height = 205
    ExplicitTop = 222
    ExplicitWidth = 155
    ExplicitHeight = 250
    inherited FixedWidthPageControl: TPageControl
      Height = 178
      ExplicitWidth = 155
      ExplicitHeight = 223
      inherited ValueTabSheet: TTabSheet
        ExplicitHeight = 150
        DesignSize = (
          151
          150)
        inherited ValuePadAlignmentComboBox: TComboBoxEx
          ExplicitWidth = 50
        end
        inherited ValuePadCharTypeComboBox: TComboBoxEx
          ExplicitWidth = 50
        end
        inherited ValueTruncateTypeComboBox: TComboBoxEx
          ExplicitWidth = 75
        end
      end
      inherited HeadingTabSheet: TTabSheet
        ExplicitHeight = 150
        DesignSize = (
          151
          150)
        inherited HeadingPadAlignmentComboBox: TComboBoxEx
          ExplicitWidth = 84
        end
        inherited HeadingPadCharTypeComboBox: TComboBoxEx
          ExplicitWidth = 84
        end
        inherited HeadingTruncateTypeComboBox: TComboBoxEx
          ExplicitWidth = 109
        end
      end
    end
    inherited FxiedWidthTopPanel: TPanel
      ExplicitWidth = 188
    end
  end
  inherited TopPanel: TPanel
    Height = 199
    ExplicitWidth = 167
    ExplicitHeight = 199
    DesignSize = (
      159
      199)
    object Label6: TLabel [4]
      Left = 3
      Top = 96
      Width = 34
      Height = 13
      Caption = '&Format'
      FocusControl = FormatEdit
    end
    object Label8: TLabel [5]
      Left = 22
      Top = 159
      Width = 26
      Height = 13
      Caption = 'Value'
      FocusControl = ConstantValueEdit
    end
    object Label27: TLabel [6]
      Left = 3
      Top = 118
      Width = 29
      Height = 13
      Caption = 'Styles'
      FocusControl = StylesEdit
    end
    inherited NameEdit: TEdit
      TabOrder = 11
      ExplicitWidth = 122
    end
    inherited HeadingConstraintComboBox: TComboBoxEx
      TabOrder = 9
      ExplicitWidth = 82
    end
    inherited NullConstantCheckBox: TCheckBox
      Top = 139
      ExplicitTop = 139
    end
    inherited ConstantCheckBox: TCheckBox
      Top = 139
      TabOrder = 7
      ExplicitTop = 139
    end
    object FormatEdit: TEdit [13]
      Left = 43
      Top = 93
      Width = 123
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'FormatEdit'
      OnExit = StringEditExit
      OnKeyPress = StringEditKeyPress
    end
    object ConstantValueEdit: TEdit [14]
      Left = 74
      Top = 156
      Width = 91
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 5
      Text = 'ConstantValueEdit'
    end
    object StylesEdit: TEdit [15]
      Left = 43
      Top = 115
      Width = 104
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Text = 'FormatEdit'
      OnExit = StylesEditExit
      OnKeyPress = StylesEditKeyPress
    end
    inherited DelimitedRadioButton: TRadioButton
      Top = 183
      TabOrder = 8
      ExplicitTop = 183
    end
    inherited FixedWidthRadioButton: TRadioButton
      Top = 183
      TabOrder = 4
      ExplicitTop = 183
    end
    object StyleButton: TButton [18]
      Left = 150
      Top = 117
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
      TabOrder = 3
      OnClick = StyleButtonClick
    end
    inherited HeadingsEdit: TEdit
      TabOrder = 10
      ExplicitWidth = 104
    end
    inherited HeadingsButton: TButton
      TabOrder = 12
      ExplicitLeft = 142
    end
  end
end
