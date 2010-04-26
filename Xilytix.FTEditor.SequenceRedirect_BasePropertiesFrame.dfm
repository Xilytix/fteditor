inherited SequenceRedirect_BasePropertiesFrame: TSequenceRedirect_BasePropertiesFrame
  Width = 104
  Height = 145
  ExplicitWidth = 104
  ExplicitHeight = 145
  DesignSize = (
    104
    145)
  object Label1: TLabel
    Left = 2
    Top = 3
    Width = 48
    Height = 13
    Caption = 'Redirect'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 2
    Top = 39
    Width = 47
    Height = 13
    Caption = 'Sequence'
  end
  object InvokationDelayLabel: TLabel
    Left = 2
    Top = 83
    Width = 81
    Height = 13
    Caption = 'Invokation Delay'
  end
  object SequenceComboBox: TComboBoxEx
    Left = 2
    Top = 56
    Width = 100
    Height = 22
    ItemsEx = <>
    Style = csExDropDownList
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    OnChange = SequenceComboBoxChange
    OnDropDown = SequenceComboBoxDropDown
  end
  object InvokationDelayComboBox: TComboBoxEx
    Left = 2
    Top = 99
    Width = 100
    Height = 22
    ItemsEx = <>
    Style = csExDropDownList
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    OnChange = ComboBoxChange
  end
end
