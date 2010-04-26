inherited SequenceRedirect_DateTimePropertiesFrame: TSequenceRedirect_DateTimePropertiesFrame
  Height = 243
  ExplicitHeight = 243
  DesignSize = (
    104
    243)
  object ValueLabel: TLabel [2]
    Left = 2
    Top = 129
    Width = 26
    Height = 13
    Caption = 'Value'
  end
  inherited InvokationDelayComboBox: TComboBoxEx
    TabOrder = 3
  end
  object DatePicker: TDateTimePicker
    Left = 2
    Top = 145
    Width = 100
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Date = 39176.869505925890000000
    Time = 39176.869505925890000000
    TabOrder = 1
    OnChange = DatePickerChange
  end
  object TimePicker: TDateTimePicker
    Left = 2
    Top = 170
    Width = 100
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Date = 39176.869574652800000000
    Time = 39176.869574652800000000
    Kind = dtkTime
    TabOrder = 2
    OnChange = TimePickerChange
  end
end
