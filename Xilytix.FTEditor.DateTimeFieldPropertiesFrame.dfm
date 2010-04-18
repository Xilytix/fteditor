inherited DateTimeFieldPropertiesFrame: TDateTimeFieldPropertiesFrame
  Height = 397
  ExplicitHeight = 397
  inherited DelimitedPanel: TPanel
    Top = 218
    Height = 179
    ExplicitTop = 246
    ExplicitWidth = 158
    ExplicitHeight = 173
    inherited Bevel5: TBevel
      Width = 197
      ExplicitWidth = 202
    end
    inherited Bevel6: TBevel
      Width = 197
      ExplicitWidth = 202
    end
  end
  inherited FixedWidthPanel: TPanel
    Top = 218
    Height = 179
    ExplicitTop = 246
    ExplicitWidth = 169
    ExplicitHeight = 138
    inherited FixedWidthPageControl: TPageControl
      Height = 152
      ExplicitWidth = 169
      ExplicitHeight = 111
      inherited ValueTabSheet: TTabSheet
        ExplicitWidth = 143
        ExplicitHeight = 67
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
        ExplicitHeight = 13
        inherited HeadingPadAlignmentComboBox: TComboBoxEx
          TabOrder = 2
        end
        inherited HeadingPadCharTypeComboBox: TComboBoxEx
          TabOrder = 1
        end
        inherited HeadingPadCharEdit: TEdit
          TabOrder = 0
        end
      end
    end
    inherited FxiedWidthTopPanel: TPanel
      ExplicitWidth = 132
    end
  end
  inherited TopPanel: TPanel
    Height = 218
    ExplicitWidth = 167
    ExplicitHeight = 218
    inherited DataTypeLabel: TLabel
      Caption = 'DateTime'
      Width = 55
      ExplicitWidth = 55
    end
    object Label6: TLabel [4]
      Caption = 'Format'
      FocusControl = FormatEdit
      Left = 3
      Top = 96
      Width = 34
      Height = 13
    end
    object Label8: TLabel [5]
      Caption = 'Date'
      FocusControl = ConstantDatePicker
      Left = 21
      Top = 160
      Width = 23
      Height = 13
    end
    object Label27: TLabel [6]
      Caption = 'Time'
      FocusControl = ConstantTimePicker
      Left = 21
      Top = 182
      Width = 22
      Height = 13
    end
    object Label28: TLabel [7]
      Caption = 'Styles'
      FocusControl = StylesEdit
      Left = 3
      Top = 118
      Width = 29
      Height = 13
    end
    inherited NameEdit: TEdit
      TabOrder = 12
      ExplicitWidth = 122
    end
    inherited HeadingConstraintComboBox: TComboBoxEx
      TabOrder = 11
      ExplicitWidth = 82
    end
    inherited NullConstantCheckBox: TCheckBox
      TabOrder = 9
      Top = 138
      Width = 36
      ExplicitTop = 138
      ExplicitWidth = 36
    end
    inherited ConstantCheckBox: TCheckBox
      TabOrder = 4
      Top = 138
      ExplicitTop = 138
    end
    inherited DelimitedRadioButton: TRadioButton
      Top = 204
      ExplicitTop = 204
    end
    object FormatEdit: TEdit [15]
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'FormatEdit'
      Left = 43
      Top = 93
      Width = 123
      Height = 21
      OnExit = StringEditExit
      OnKeyPress = StringEditKeyPress
    end
    object ConstantDatePicker: TDateTimePicker [16]
      Anchors = [akLeft, akTop, akRight]
      Date = 39076.3862335417
      Time = 39076.3862335417
      TabOrder = 5
      Left = 51
      Top = 155
      Width = 115
      Height = 21
      OnChange = ConstantDatePickerChange
    end
    object ConstantTimePicker: TDateTimePicker [17]
      Anchors = [akLeft, akTop, akRight]
      Date = 39076.3862335417
      Time = 39076.3862335417
      Kind = dtkTime
      TabOrder = 6
      Left = 51
      Top = 177
      Width = 115
      Height = 21
      OnChange = ConstantTimePickerChange
    end
    object StylesButton: TButton [18]
      Anchors = [akTop, akRight]
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Left = 150
      Top = 117
      Width = 15
      Height = 17
      OnClick = StylesButtonClick
    end
    object StylesEdit: TEdit [19]
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Text = 'FormatEdit'
      Left = 43
      Top = 115
      Width = 105
      Height = 21
      OnExit = StylesEditExit
      OnKeyPress = StylesEditKeyPress
    end
    inherited FixedWidthRadioButton: TRadioButton
      Top = 204
      ExplicitTop = 204
    end
    inherited HeadingsEdit: TEdit
      TabOrder = 13
      ExplicitWidth = 104
    end
    inherited HeadingsButton: TButton
      TabOrder = 10
      ExplicitLeft = 142
    end
  end
end
