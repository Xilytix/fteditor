inherited SequenceRedirect_DateTimePropertiesFrame: TSequenceRedirect_DateTimePropertiesFrame
  Height = 243
  ExplicitHeight = 243
  DesignSize = (
    104
    243)
  object ValueLabel: TLabel [2]
    Caption = 'Value'
    Left = 2
    Top = 129
    Width = 26
    Height = 13
  end
  inherited InvokationDelayComboBox: TComboBoxEx
    TabOrder = 3
  end
  object DatePicker: TDateTimePicker
    Anchors = [akLeft, akTop, akRight]
    Date = 39176.8695059259
    Time = 39176.8695059259
    TabOrder = 1
    Left = 2
    Top = 145
    Width = 100
    Height = 21
    OnChange = DatePickerChange
  end
  object TimePicker: TDateTimePicker
    Anchors = [akLeft, akTop, akRight]
    Date = 39176.8695746528
    Time = 39176.8695746528
    TabOrder = 2
    Left = 2
    Top = 170
    Width = 100
    Height = 21
    Kind = dtkTime
    OnChange = TimePickerChange
  end
end
