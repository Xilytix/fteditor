object DateTimeStylesForm: TDateTimeStylesForm
  Left = 197
  Top = 81
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Edit DateTimeStyles'
  ClientHeight = 88
  ClientWidth = 197
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
  object AllowInnerWhiteCheckBox: TCheckBox
    Tag = 256
    Left = 13
    Top = 13
    Width = 134
    Height = 17
    Caption = 'Allow Inner White'
    TabOrder = 0
    OnClick = AllowInnerWhiteCheckBoxClick
  end
  object OkButton: TButton
    Left = 8
    Top = 44
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 114
    Top = 44
    Width = 74
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
