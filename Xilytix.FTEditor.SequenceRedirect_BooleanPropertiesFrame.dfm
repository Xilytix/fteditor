inherited SequenceRedirect_BooleanPropertiesFrame: TSequenceRedirect_BooleanPropertiesFrame
  Height = 172
  ExplicitHeight = 172
  object Label2: TLabel [1]
    Left = 2
    Top = 18
    Width = 45
    Height = 13
    Caption = 'Boolean'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited InvokationDelayComboBox: TComboBoxEx
    TabOrder = 2
  end
  object ValueCheckBox: TCheckBox
    Left = 3
    Top = 136
    Width = 47
    Height = 17
    Caption = 'Value'
    TabOrder = 1
    OnClick = CheckBoxClick
  end
end
