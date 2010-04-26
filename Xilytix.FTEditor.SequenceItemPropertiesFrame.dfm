inherited SequenceItemPropertiesFrame: TSequenceItemPropertiesFrame
  Width = 104
  Height = 85
  ExplicitWidth = 104
  ExplicitHeight = 85
  object Label1: TLabel
    Left = 2
    Top = 24
    Width = 22
    Height = 13
    Caption = 'Field'
  end
  object Label2: TLabel
    Left = 2
    Top = 69
    Width = 45
    Height = 13
    Caption = 'Redirects'
  end
  object Label3: TLabel
    Left = 3
    Top = 3
    Width = 86
    Height = 13
    Caption = 'Sequence Item'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object RedirectsCountLabel: TLabel
    Left = 56
    Top = 69
    Width = 6
    Height = 13
    Caption = '0'
  end
  object FieldComboBox: TComboBoxEx
    Left = 1
    Top = 40
    Width = 101
    Height = 22
    ItemsEx = <>
    Style = csExDropDownList
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnChange = FieldComboBoxChange
    OnDropDown = FieldComboBoxDropDown
    DropDownCount = 10
  end
  object SortCheckBox: TCheckBox
    Left = 65
    Top = 23
    Width = 39
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Sort'
    TabOrder = 1
    OnClick = SortCheckBoxClick
  end
end
