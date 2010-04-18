object LayoutConfigurationForm: TLayoutConfigurationForm
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Configure Layout'
  ClientHeight = 375
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Left = 197
  Top = 88
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label23: TLabel
    Caption = '&Name'
    FocusControl = NameEdit
    Left = 8
    Top = 16
    Width = 27
    Height = 13
  end
  object DuplicateOrBlankNameLabel: TLabel
    Caption = '<Duplicate or Blank Name>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
    Left = 49
    Top = 34
    Width = 131
    Height = 13
  end
  object MetaDataGroupBox: TGroupBox
    Caption = 'Halves'
    TabOrder = 1
    Left = 8
    Top = 54
    Width = 105
    Height = 240
    object Label3: TLabel
      Caption = '&Left, Top'
      FocusControl = HalvesLeftTopHalfComboBox
      Left = 8
      Top = 110
      Width = 44
      Height = 13
    end
    object Label4: TLabel
      Caption = '&Right, Bottom'
      FocusControl = HalvesRightBottomHalfComboBox
      Left = 8
      Top = 175
      Width = 66
      Height = 13
    end
    object HalvesTabbedCheckBox: TCheckBox
      Caption = '&Tabbed'
      TabOrder = 1
      Left = 8
      Top = 83
      Width = 66
      Height = 17
      OnClick = HalvesTabbedCheckBoxClick
    end
    object HalvesLeftTopHalfComboBox: TComboBoxEx
      ItemsEx = <>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 2
      Left = 18
      Top = 127
      Width = 76
      Height = 22
      OnChange = HalvesLeftTopHalfComboBoxChange
    end
    object HalvesRightBottomHalfComboBox: TComboBoxEx
      ItemsEx = <>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 3
      Left = 18
      Top = 193
      Width = 76
      Height = 22
      OnChange = HalvesRightBottomHalfComboBoxChange
    end
    object GroupBox1: TGroupBox
      Caption = 'Arrangment'
      TabOrder = 0
      Left = 8
      Top = 17
      Width = 86
      Height = 53
      object HalvesHorizontalRadioButton: TRadioButton
        Caption = '&Horizontal'
        TabOrder = 0
        Left = 11
        Top = 15
        Width = 73
        Height = 17
        OnClick = HalvesHorizontalRadioButtonClick
      end
      object HalvesVerticalRadioButton: TRadioButton
        Caption = '&Vertical'
        TabOrder = 1
        Left = 11
        Top = 34
        Width = 63
        Height = 13
        OnClick = HalvesVerticalRadioButtonClick
      end
    end
    object HalvesLeftTopFillRadioButton: TRadioButton
      Caption = 'Fill'
      TabOrder = 4
      Left = 19
      Top = 150
      Width = 37
      Height = 17
      OnClick = HalvesLeftTopFillRadioButtonClick
    end
    object HalvesRightBottomFillRadioButton: TRadioButton
      Caption = 'Fill'
      TabOrder = 5
      Left = 19
      Top = 215
      Width = 37
      Height = 17
    end
  end
  object GroupBox2: TGroupBox
    Caption = 'Half &A'
    TabOrder = 2
    Left = 131
    Top = 54
    Width = 331
    Height = 114
    object Label7: TLabel
      Caption = 'Left, Top'
      Left = 120
      Top = 17
      Width = 44
      Height = 13
    end
    object Label8: TLabel
      AutoSize = False
      Caption = 'Middle,'
      Left = 120
      Top = 40
      Width = 56
      Height = 13
    end
    object Label2: TLabel
      Caption = 'Top Right,'
      Left = 120
      Top = 52
      Width = 50
      Height = 13
    end
    object Label5: TLabel
      Caption = 'Bottom Left'
      Left = 120
      Top = 65
      Width = 56
      Height = 13
    end
    object Label6: TLabel
      Caption = 'Right, Bottom'
      Left = 120
      Top = 87
      Width = 66
      Height = 13
    end
    object HalfATabbedCheckBox: TCheckBox
      Caption = 'Tabbed'
      TabOrder = 4
      Left = 8
      Top = 86
      Width = 65
      Height = 17
      OnClick = HalfATabbedCheckBoxClick
    end
    object HalfAHorizontalRadioButton: TRadioButton
      Caption = 'Horizontal'
      TabOrder = 0
      Left = 8
      Top = 19
      Width = 81
      Height = 17
      OnClick = HalfAHorizontalRadioButtonClick
    end
    object HalfAVerticalRadioButton: TRadioButton
      Caption = 'Vertical'
      TabOrder = 1
      Left = 8
      Top = 34
      Width = 55
      Height = 17
      OnClick = HalfAVerticalRadioButtonClick
    end
    object HalfALeftComboBox: TComboBoxEx
      ItemsEx = <>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 5
      Left = 196
      Top = 12
      Width = 84
      Height = 22
      OnChange = HalfALeftComboBoxChange
    end
    object HalfAMiddleComboBox: TComboBoxEx
      ItemsEx = <>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 7
      Left = 196
      Top = 47
      Width = 84
      Height = 22
      OnChange = HalfAMiddleComboBoxChange
    end
    object HalfA2Left1RightRadioButton: TRadioButton
      Caption = '2 Left, 1 Right'
      TabOrder = 2
      Left = 8
      Top = 49
      Width = 97
      Height = 17
      OnClick = HalfA2Left1RightRadioButtonClick
    end
    object HalfALeftFillCheckBox: TCheckBox
      Caption = 'Fill'
      TabOrder = 6
      Left = 293
      Top = 14
      Width = 35
      Height = 17
      OnClick = HalfALeftFillCheckBoxClick
    end
    object HalfARightComboBox: TComboBoxEx
      ItemsEx = <>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 9
      Left = 196
      Top = 82
      Width = 84
      Height = 22
      OnChange = HalfARightComboBoxChange
    end
    object HalfARightFillCheckBox: TCheckBox
      Caption = 'Fill'
      TabOrder = 10
      Left = 293
      Top = 84
      Width = 35
      Height = 17
      OnClick = HalfARightFillCheckBoxClick
    end
    object HalfAMiddleFillCheckBox: TCheckBox
      Caption = 'Fill'
      TabOrder = 8
      Left = 293
      Top = 50
      Width = 35
      Height = 17
      OnClick = HalfAMiddleFillCheckBoxClick
    end
    object HalfA2Top1BottomRadioButton: TRadioButton
      Caption = '2 Top, 1 Bottom'
      TabOrder = 3
      Left = 8
      Top = 64
      Width = 97
      Height = 17
      OnClick = HalfA2Top1BottomRadioButtonClick
    end
  end
  object NameEdit: TEdit
    TabOrder = 0
    Left = 49
    Top = 13
    Width = 160
    Height = 21
    OnChange = NameEditChange
  end
  object NewButton: TButton
    Caption = 'Ne&w'
    TabOrder = 7
    Left = 232
    Top = 13
    Width = 50
    Height = 21
    OnClick = NewButtonClick
  end
  object OkButton: TButton
    Caption = '&Ok'
    TabOrder = 4
    Left = 38
    Top = 334
    Width = 75
    Height = 25
    OnClick = OkButtonClick
  end
  object DeleteButton: TButton
    Caption = 'Dele&te'
    TabOrder = 8
    Left = 401
    Top = 13
    Width = 50
    Height = 21
    OnClick = DeleteButtonClick
  end
  object CancelButton: TButton
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 6
    Left = 361
    Top = 334
    Width = 75
    Height = 25
    OnClick = CancelButtonClick
  end
  object GroupBox3: TGroupBox
    Caption = 'Half &B'
    TabOrder = 3
    Left = 131
    Top = 180
    Width = 331
    Height = 114
    object Label1: TLabel
      Caption = 'Left, Top'
      Left = 120
      Top = 17
      Width = 44
      Height = 13
    end
    object Label9: TLabel
      AutoSize = False
      Caption = 'Middle,'
      Left = 120
      Top = 41
      Width = 56
      Height = 13
    end
    object Label10: TLabel
      Caption = 'Top Right,'
      Left = 120
      Top = 53
      Width = 50
      Height = 13
    end
    object Label11: TLabel
      Caption = 'Bottom Left'
      Left = 120
      Top = 66
      Width = 56
      Height = 13
    end
    object Label12: TLabel
      Caption = 'Right, Bottom'
      Left = 120
      Top = 87
      Width = 66
      Height = 13
    end
    object HalfBTabbedCheckBox: TCheckBox
      Caption = 'Tabbed'
      TabOrder = 4
      Left = 8
      Top = 86
      Width = 65
      Height = 17
      OnClick = HalfBTabbedCheckBoxClick
    end
    object HalfBHorizontalRadioButton: TRadioButton
      Caption = 'Horizontal'
      TabOrder = 0
      Left = 8
      Top = 19
      Width = 81
      Height = 17
      OnClick = HalfBHorizontalRadioButtonClick
    end
    object HalfBVerticalRadioButton: TRadioButton
      Caption = 'Vertical'
      TabOrder = 1
      Left = 8
      Top = 34
      Width = 55
      Height = 17
      OnClick = HalfBVerticalRadioButtonClick
    end
    object HalfBLeftComboBox: TComboBoxEx
      ItemsEx = <>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 5
      Left = 196
      Top = 12
      Width = 84
      Height = 22
      OnChange = HalfBLeftComboBoxChange
    end
    object HalfBMiddleComboBox: TComboBoxEx
      ItemsEx = <>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 7
      Left = 196
      Top = 47
      Width = 84
      Height = 22
      OnChange = HalfBMiddleComboBoxChange
    end
    object HalfB2Left1RightRadioButton: TRadioButton
      Caption = '2 Left, 1 Right'
      TabOrder = 2
      Left = 8
      Top = 49
      Width = 97
      Height = 17
      OnClick = HalfB2Left1RightRadioButtonClick
    end
    object HalfBLeftFillCheckBox: TCheckBox
      Caption = 'Fill'
      TabOrder = 6
      Left = 293
      Top = 15
      Width = 35
      Height = 17
      OnClick = HalfBLeftFillCheckBoxClick
    end
    object HalfBRightComboBox: TComboBoxEx
      ItemsEx = <>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 9
      Left = 196
      Top = 82
      Width = 84
      Height = 22
      OnChange = HalfBRightComboBoxChange
    end
    object HalfBRightFillCheckBox: TCheckBox
      Caption = 'Fill'
      TabOrder = 10
      Left = 293
      Top = 85
      Width = 35
      Height = 17
      OnClick = HalfBRightFillCheckBoxClick
    end
    object HalfBMiddleFillCheckBox: TCheckBox
      Caption = 'Fill'
      TabOrder = 8
      Left = 293
      Top = 51
      Width = 35
      Height = 17
      OnClick = HalfBMiddleFillCheckBoxClick
    end
    object HalfB2Top1BottomRadioButton: TRadioButton
      Caption = '2 Top, 1 Bottom'
      TabOrder = 3
      Left = 8
      Top = 64
      Width = 97
      Height = 17
      OnClick = HalfB2Top1BottomRadioButtonClick
    end
  end
  object ApplyButton: TButton
    Caption = '&Apply'
    TabOrder = 5
    Left = 149
    Top = 334
    Width = 75
    Height = 25
    OnClick = ApplyButtonClick
  end
  object ResetSizesCheckBox: TCheckBox
    Caption = 'Reset Sizes'
    TabOrder = 9
    Left = 8
    Top = 302
    Width = 82
    Height = 17
  end
end
