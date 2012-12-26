object LayoutConfigurationForm: TLayoutConfigurationForm
  Left = 197
  Top = 88
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
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label23: TLabel
    Left = 8
    Top = 16
    Width = 27
    Height = 13
    Caption = '&Name'
    FocusControl = NameEdit
  end
  object DuplicateOrBlankNameLabel: TLabel
    Left = 49
    Top = 34
    Width = 131
    Height = 13
    Caption = '<Duplicate or Blank Name>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object MetaDataGroupBox: TGroupBox
    Left = 8
    Top = 54
    Width = 105
    Height = 240
    Caption = 'Halves'
    TabOrder = 1
    object Label3: TLabel
      Left = 8
      Top = 110
      Width = 44
      Height = 13
      Caption = '&Left, Top'
      FocusControl = HalvesLeftTopHalfComboBox
    end
    object Label4: TLabel
      Left = 8
      Top = 175
      Width = 66
      Height = 13
      Caption = '&Right, Bottom'
      FocusControl = HalvesRightBottomHalfComboBox
    end
    object HalvesTabbedCheckBox: TCheckBox
      Left = 8
      Top = 83
      Width = 66
      Height = 17
      Caption = '&Tabbed'
      TabOrder = 1
      OnClick = HalvesTabbedCheckBoxClick
    end
    object HalvesLeftTopHalfComboBox: TComboBoxEx
      Left = 18
      Top = 127
      Width = 76
      Height = 22
      ItemsEx = <>
      Style = csExDropDownList
      TabOrder = 2
      OnChange = HalvesLeftTopHalfComboBoxChange
    end
    object HalvesRightBottomHalfComboBox: TComboBoxEx
      Left = 18
      Top = 193
      Width = 76
      Height = 22
      ItemsEx = <>
      Style = csExDropDownList
      TabOrder = 3
      OnChange = HalvesRightBottomHalfComboBoxChange
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 17
      Width = 86
      Height = 53
      Caption = 'Arrangment'
      TabOrder = 0
      object HalvesHorizontalRadioButton: TRadioButton
        Left = 11
        Top = 15
        Width = 73
        Height = 17
        Caption = '&Horizontal'
        TabOrder = 0
        OnClick = HalvesHorizontalRadioButtonClick
      end
      object HalvesVerticalRadioButton: TRadioButton
        Left = 11
        Top = 34
        Width = 63
        Height = 13
        Caption = '&Vertical'
        TabOrder = 1
        OnClick = HalvesVerticalRadioButtonClick
      end
    end
    object HalvesLeftTopFillRadioButton: TRadioButton
      Left = 19
      Top = 150
      Width = 37
      Height = 17
      Caption = 'Fill'
      TabOrder = 4
      OnClick = HalvesLeftTopFillRadioButtonClick
    end
    object HalvesRightBottomFillRadioButton: TRadioButton
      Left = 19
      Top = 215
      Width = 37
      Height = 17
      Caption = 'Fill'
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 131
    Top = 54
    Width = 331
    Height = 114
    Caption = 'Half &A'
    TabOrder = 2
    object Label7: TLabel
      Left = 120
      Top = 17
      Width = 44
      Height = 13
      Caption = 'Left, Top'
    end
    object Label8: TLabel
      Left = 120
      Top = 40
      Width = 56
      Height = 13
      AutoSize = False
      Caption = 'Middle,'
    end
    object Label2: TLabel
      Left = 120
      Top = 52
      Width = 50
      Height = 13
      Caption = 'Top Right,'
    end
    object Label5: TLabel
      Left = 120
      Top = 65
      Width = 56
      Height = 13
      Caption = 'Bottom Left'
    end
    object Label6: TLabel
      Left = 120
      Top = 87
      Width = 66
      Height = 13
      Caption = 'Right, Bottom'
    end
    object HalfATabbedCheckBox: TCheckBox
      Left = 8
      Top = 86
      Width = 65
      Height = 17
      Caption = 'Tabbed'
      TabOrder = 4
      OnClick = HalfATabbedCheckBoxClick
    end
    object HalfAHorizontalRadioButton: TRadioButton
      Left = 8
      Top = 19
      Width = 81
      Height = 17
      Caption = 'Horizontal'
      TabOrder = 0
      OnClick = HalfAHorizontalRadioButtonClick
    end
    object HalfAVerticalRadioButton: TRadioButton
      Left = 8
      Top = 34
      Width = 55
      Height = 17
      Caption = 'Vertical'
      TabOrder = 1
      OnClick = HalfAVerticalRadioButtonClick
    end
    object HalfALeftComboBox: TComboBoxEx
      Left = 196
      Top = 12
      Width = 84
      Height = 22
      ItemsEx = <>
      Style = csExDropDownList
      TabOrder = 5
      OnChange = HalfALeftComboBoxChange
    end
    object HalfAMiddleComboBox: TComboBoxEx
      Left = 196
      Top = 47
      Width = 84
      Height = 22
      ItemsEx = <>
      Style = csExDropDownList
      TabOrder = 7
      OnChange = HalfAMiddleComboBoxChange
    end
    object HalfA2Left1RightRadioButton: TRadioButton
      Left = 8
      Top = 49
      Width = 97
      Height = 17
      Caption = '2 Left, 1 Right'
      TabOrder = 2
      OnClick = HalfA2Left1RightRadioButtonClick
    end
    object HalfALeftFillCheckBox: TCheckBox
      Left = 293
      Top = 14
      Width = 35
      Height = 17
      Caption = 'Fill'
      TabOrder = 6
      OnClick = HalfALeftFillCheckBoxClick
    end
    object HalfARightComboBox: TComboBoxEx
      Left = 196
      Top = 82
      Width = 84
      Height = 22
      ItemsEx = <>
      Style = csExDropDownList
      TabOrder = 9
      OnChange = HalfARightComboBoxChange
    end
    object HalfARightFillCheckBox: TCheckBox
      Left = 293
      Top = 84
      Width = 35
      Height = 17
      Caption = 'Fill'
      TabOrder = 10
      OnClick = HalfARightFillCheckBoxClick
    end
    object HalfAMiddleFillCheckBox: TCheckBox
      Left = 293
      Top = 50
      Width = 35
      Height = 17
      Caption = 'Fill'
      TabOrder = 8
      OnClick = HalfAMiddleFillCheckBoxClick
    end
    object HalfA2Top1BottomRadioButton: TRadioButton
      Left = 8
      Top = 64
      Width = 97
      Height = 17
      Caption = '2 Top, 1 Bottom'
      TabOrder = 3
      OnClick = HalfA2Top1BottomRadioButtonClick
    end
  end
  object NameEdit: TEdit
    Left = 49
    Top = 13
    Width = 160
    Height = 21
    TabOrder = 0
    OnChange = NameEditChange
  end
  object NewButton: TButton
    Left = 232
    Top = 13
    Width = 50
    Height = 21
    Caption = 'Ne&w'
    TabOrder = 7
    OnClick = NewButtonClick
  end
  object OkButton: TButton
    Left = 38
    Top = 334
    Width = 75
    Height = 25
    Caption = '&Ok'
    TabOrder = 4
    OnClick = OkButtonClick
  end
  object DeleteButton: TButton
    Left = 401
    Top = 13
    Width = 50
    Height = 21
    Caption = 'Dele&te'
    TabOrder = 8
    OnClick = DeleteButtonClick
  end
  object CancelButton: TButton
    Left = 361
    Top = 334
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 6
    OnClick = CancelButtonClick
  end
  object GroupBox3: TGroupBox
    Left = 131
    Top = 180
    Width = 331
    Height = 114
    Caption = 'Half &B'
    TabOrder = 3
    object Label1: TLabel
      Left = 120
      Top = 17
      Width = 44
      Height = 13
      Caption = 'Left, Top'
    end
    object Label9: TLabel
      Left = 120
      Top = 41
      Width = 56
      Height = 13
      AutoSize = False
      Caption = 'Middle,'
    end
    object Label10: TLabel
      Left = 120
      Top = 53
      Width = 50
      Height = 13
      Caption = 'Top Right,'
    end
    object Label11: TLabel
      Left = 120
      Top = 66
      Width = 56
      Height = 13
      Caption = 'Bottom Left'
    end
    object Label12: TLabel
      Left = 120
      Top = 87
      Width = 66
      Height = 13
      Caption = 'Right, Bottom'
    end
    object HalfBTabbedCheckBox: TCheckBox
      Left = 8
      Top = 86
      Width = 65
      Height = 17
      Caption = 'Tabbed'
      TabOrder = 4
      OnClick = HalfBTabbedCheckBoxClick
    end
    object HalfBHorizontalRadioButton: TRadioButton
      Left = 8
      Top = 19
      Width = 81
      Height = 17
      Caption = 'Horizontal'
      TabOrder = 0
      OnClick = HalfBHorizontalRadioButtonClick
    end
    object HalfBVerticalRadioButton: TRadioButton
      Left = 8
      Top = 34
      Width = 55
      Height = 17
      Caption = 'Vertical'
      TabOrder = 1
      OnClick = HalfBVerticalRadioButtonClick
    end
    object HalfBLeftComboBox: TComboBoxEx
      Left = 196
      Top = 12
      Width = 84
      Height = 22
      ItemsEx = <>
      Style = csExDropDownList
      TabOrder = 5
      OnChange = HalfBLeftComboBoxChange
    end
    object HalfBMiddleComboBox: TComboBoxEx
      Left = 196
      Top = 47
      Width = 84
      Height = 22
      ItemsEx = <>
      Style = csExDropDownList
      TabOrder = 7
      OnChange = HalfBMiddleComboBoxChange
    end
    object HalfB2Left1RightRadioButton: TRadioButton
      Left = 8
      Top = 49
      Width = 97
      Height = 17
      Caption = '2 Left, 1 Right'
      TabOrder = 2
      OnClick = HalfB2Left1RightRadioButtonClick
    end
    object HalfBLeftFillCheckBox: TCheckBox
      Left = 293
      Top = 15
      Width = 35
      Height = 17
      Caption = 'Fill'
      TabOrder = 6
      OnClick = HalfBLeftFillCheckBoxClick
    end
    object HalfBRightComboBox: TComboBoxEx
      Left = 196
      Top = 82
      Width = 84
      Height = 22
      ItemsEx = <>
      Style = csExDropDownList
      TabOrder = 9
      OnChange = HalfBRightComboBoxChange
    end
    object HalfBRightFillCheckBox: TCheckBox
      Left = 293
      Top = 85
      Width = 35
      Height = 17
      Caption = 'Fill'
      TabOrder = 10
      OnClick = HalfBRightFillCheckBoxClick
    end
    object HalfBMiddleFillCheckBox: TCheckBox
      Left = 293
      Top = 51
      Width = 35
      Height = 17
      Caption = 'Fill'
      TabOrder = 8
      OnClick = HalfBMiddleFillCheckBoxClick
    end
    object HalfB2Top1BottomRadioButton: TRadioButton
      Left = 8
      Top = 64
      Width = 97
      Height = 17
      Caption = '2 Top, 1 Bottom'
      TabOrder = 3
      OnClick = HalfB2Top1BottomRadioButtonClick
    end
  end
  object ApplyButton: TButton
    Left = 149
    Top = 334
    Width = 75
    Height = 25
    Caption = '&Apply'
    TabOrder = 5
    OnClick = ApplyButtonClick
  end
  object ResetSizesCheckBox: TCheckBox
    Left = 8
    Top = 302
    Width = 82
    Height = 17
    Caption = 'Reset Sizes'
    TabOrder = 9
  end
end
