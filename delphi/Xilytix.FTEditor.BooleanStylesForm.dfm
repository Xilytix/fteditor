object BooleanStylesForm: TBooleanStylesForm
  Left = 197
  Top = 81
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Edit Boolean Styles'
  ClientHeight = 144
  ClientWidth = 182
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
  object OkButton: TButton
    Left = 13
    Top = 101
    Width = 59
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 111
    Top = 101
    Width = 58
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object IgnoreCaseCheckBox: TCheckBox
    Tag = 256
    Left = 13
    Top = 13
    Width = 134
    Height = 17
    Caption = 'Ignore Case'
    TabOrder = 2
    OnClick = CheckBoxClick
  end
  object MatchFirstCharOnlyCheckBox: TCheckBox
    Tag = 32
    Left = 13
    Top = 30
    Width = 164
    Height = 17
    Caption = 'Match First Character Only'
    TabOrder = 3
    OnClick = CheckBoxClick
  end
  object IgnoreTrailingCharsCheckBox: TCheckBox
    Tag = 128
    Left = 13
    Top = 47
    Width = 164
    Height = 17
    Caption = 'Ignore Trailing Characters'
    TabOrder = 4
    OnClick = CheckBoxClick
  end
  object FalseIfNotMatchTrueCheckBox: TCheckBox
    Tag = 512
    Left = 13
    Top = 64
    Width = 135
    Height = 17
    Caption = 'False If Not Match True'
    TabOrder = 5
    OnClick = CheckBoxClick
  end
end
