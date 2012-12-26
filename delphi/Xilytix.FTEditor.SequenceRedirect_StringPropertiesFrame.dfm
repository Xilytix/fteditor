inherited SequenceRedirect_StringPropertiesFrame: TSequenceRedirect_StringPropertiesFrame
  Height = 248
  ExplicitHeight = 248
  DesignSize = (
    104
    248)
  object ValueLabel: TLabel [2]
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
