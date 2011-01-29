inherited SequenceRedirect_DecimalPropertiesFrame: TSequenceRedirect_DecimalPropertiesFrame
  Height = 232
  ExplicitHeight = 232
  object Label2: TLabel [2]
    Left = 2
    Top = 18
    Width = 45
    Height = 13
    Caption = 'Decimal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ValueLabel: TLabel [3]
    Left = 2
    Top = 129
    Width = 26
    Height = 13
    Caption = 'Value'
  end
  inherited InvokationDelayComboBox: TComboBox
    TabOrder = 2
  end
  object ValueEdit: TEdit
    Left = 2
    Top = 145
    Width = 98
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = 'ValueEdit'
    OnExit = ValueEditExit
    OnKeyPress = ValueEditKeyPress
  end
end
