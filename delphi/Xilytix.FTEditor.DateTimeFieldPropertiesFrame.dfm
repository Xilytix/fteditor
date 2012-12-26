inherited DateTimeFieldPropertiesFrame: TDateTimeFieldPropertiesFrame
  Height = 397
  ExplicitHeight = 397
  inherited DelimitedPanel: TPanel
    Top = 218
    Height = 179
    ExplicitTop = 218
    ExplicitHeight = 179
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
    ExplicitTop = 218
    ExplicitHeight = 179
    inherited FixedWidthPageControl: TPageControl
      Height = 152
      ExplicitHeight = 152
      inherited ValueTabSheet: TTabSheet
        ExplicitHeight = 124
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
        ExplicitHeight = 124
        inherited HeadingPadAlignmentComboBox: TComboBox
          TabOrder = 2
        end
        inherited HeadingPadCharTypeComboBox: TComboBox
          TabOrder = 1
        end
        inherited HeadingPadCharEdit: TEdit
          TabOrder = 0
        end
      end
    end
  end
  inherited TopPanel: TPanel
    Height = 218
    ExplicitHeight = 218
    inherited DataTypeLabel: TLabel
      Width = 55
      Caption = 'DateTime'
      ExplicitWidth = 55
    end
    object Label6: TLabel [4]
      Left = 3
      Top = 96
      Width = 34
      Height = 13
      Caption = 'Format'
      FocusControl = FormatEdit
    end
    object Label8: TLabel [5]
      Left = 21
      Top = 160
      Width = 23
      Height = 13
      Caption = 'Date'
      FocusControl = ConstantDatePicker
    end
    object Label27: TLabel [6]
      Left = 21
      Top = 182
      Width = 22
      Height = 13
      Caption = 'Time'
      FocusControl = ConstantTimePicker
    end
    object Label28: TLabel [7]
      Left = 3
      Top = 118
      Width = 29
      Height = 13
      Caption = 'Styles'
      FocusControl = StylesEdit
    end
    inherited NameEdit: TEdit
      TabOrder = 12
    end
    inherited HeadingConstraintComboBox: TComboBox
      TabOrder = 11
    end
    inherited NullConstantCheckBox: TCheckBox
      Top = 138
      Width = 36
      TabOrder = 9
      ExplicitTop = 138
      ExplicitWidth = 36
    end
    inherited ConstantCheckBox: TCheckBox
      Top = 138
      TabOrder = 4
      ExplicitTop = 138
    end
    inherited DelimitedRadioButton: TRadioButton
      Top = 204
      ExplicitTop = 204
    end
    object FormatEdit: TEdit [15]
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
    object ConstantDatePicker: TDateTimePicker [16]
      Left = 51
      Top = 155
      Width = 115
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Date = 39076.386233541700000000
      Time = 39076.386233541700000000
      TabOrder = 5
      OnChange = ConstantDatePickerChange
    end
    object ConstantTimePicker: TDateTimePicker [17]
      Left = 51
      Top = 177
      Width = 115
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Date = 39076.386233541700000000
      Time = 39076.386233541700000000
      Kind = dtkTime
      TabOrder = 6
      OnChange = ConstantTimePickerChange
    end
    object StylesButton: TButton [18]
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
      OnClick = StylesButtonClick
    end
    object StylesEdit: TEdit [19]
      Left = 43
      Top = 115
      Width = 105
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Text = 'FormatEdit'
      OnExit = StylesEditExit
      OnKeyPress = StylesEditKeyPress
    end
    inherited FixedWidthRadioButton: TRadioButton
      Top = 204
      ExplicitTop = 204
    end
    inherited HeadingsEdit: TEdit
      TabOrder = 13
    end
    inherited HeadingsButton: TButton
      TabOrder = 10
    end
  end
end
