object NumberStylesForm: TNumberStylesForm
  Left = 197
  Top = 81
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Edit NumberStyles'
  ClientHeight = 193
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 6
    Width = 60
    Height = 13
    Caption = 'Composite'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object AllowCurrencySymbolCheckBox: TCheckBox
    Tag = 256
    Left = 117
    Top = 5
    Width = 134
    Height = 17
    Caption = 'Allow Currency Symbol'
    TabOrder = 7
    OnClick = StyleClick
  end
  object AllowThousandsCheckBox: TCheckBox
    Tag = 64
    Left = 117
    Top = 107
    Width = 135
    Height = 17
    Caption = 'Allow Thousands'
    TabOrder = 13
    OnClick = StyleClick
  end
  object AllowTrailingSignCheckBox: TCheckBox
    Tag = 8
    Left = 117
    Top = 124
    Width = 135
    Height = 17
    Caption = 'Allow Trailing Sign'
    TabOrder = 14
    OnClick = StyleClick
  end
  object AnyRadioButton: TRadioButton
    Tag = 511
    Left = 10
    Top = 25
    Width = 83
    Height = 17
    Caption = '&Any'
    TabOrder = 0
    OnClick = CompositeClick
  end
  object CurrencyRadioButton: TRadioButton
    Tag = 383
    Left = 10
    Top = 42
    Width = 83
    Height = 17
    Caption = '&Currency'
    TabOrder = 1
    OnClick = CompositeClick
  end
  object FloatRadioButton: TRadioButton
    Tag = 167
    Left = 10
    Top = 59
    Width = 83
    Height = 17
    Caption = '&Float'
    TabOrder = 2
    OnClick = CompositeClick
  end
  object AllowDecimalPointCheckBox: TCheckBox
    Tag = 32
    Left = 117
    Top = 22
    Width = 135
    Height = 17
    Caption = 'Allow Decimal Point'
    TabOrder = 8
    OnClick = StyleClick
  end
  object AllowExponentCheckBox: TCheckBox
    Tag = 128
    Left = 117
    Top = 39
    Width = 135
    Height = 17
    Caption = 'Allow Exponent'
    TabOrder = 9
    OnClick = StyleClick
  end
  object AllowHexSpecifierCheckBox: TCheckBox
    Tag = 512
    Left = 117
    Top = 56
    Width = 135
    Height = 17
    Caption = 'Allow Hex Specifier'
    TabOrder = 10
    OnClick = StyleClick
  end
  object AllowLeadingSignCheckBox: TCheckBox
    Tag = 4
    Left = 117
    Top = 73
    Width = 135
    Height = 17
    Caption = 'Allow Leading Sign'
    TabOrder = 11
    OnClick = StyleClick
  end
  object AllowParenthesesCheckBox: TCheckBox
    Tag = 16
    Left = 117
    Top = 90
    Width = 135
    Height = 17
    Caption = 'Allow Parentheses'
    TabOrder = 12
    OnClick = StyleClick
  end
  object HexNumberRadioButton: TRadioButton
    Tag = 515
    Left = 10
    Top = 76
    Width = 83
    Height = 17
    Caption = '&Hex Number'
    TabOrder = 3
    OnClick = CompositeClick
  end
  object IntegerRadioButton: TRadioButton
    Tag = 7
    Left = 10
    Top = 93
    Width = 83
    Height = 17
    Caption = '&Integer'
    TabOrder = 4
    OnClick = CompositeClick
  end
  object NumberRadioButton: TRadioButton
    Tag = 111
    Left = 10
    Top = 127
    Width = 83
    Height = 17
    Caption = '&Number'
    TabOrder = 6
    OnClick = CompositeClick
  end
  object NoneRadioButton: TRadioButton
    Left = 10
    Top = 110
    Width = 83
    Height = 17
    Caption = 'N&one'
    TabOrder = 5
    OnClick = CompositeClick
  end
  object OkButton: TButton
    Left = 19
    Top = 157
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 15
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 157
    Top = 157
    Width = 74
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 16
  end
end
