object UrlForm: TUrlForm
  BorderIcons = []
  Caption = 'Enter URL'
  ClientHeight = 91
  ClientWidth = 501
  Color = clBtnFace
  Constraints.MaxHeight = 118
  Constraints.MinHeight = 118
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Left = 197
  Top = 81
  OnCreate = FormCreate
  DesignSize = (
    501
    91)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Caption = 'URL'
    Left = 16
    Top = 16
    Width = 19
    Height = 13
  end
  object UrlEdit: TEdit
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'http://'
    Left = 47
    Top = 13
    Width = 441
    Height = 21
  end
  object OkButton: TButton
    Action = OkAction
    Default = True
    TabOrder = 1
    Left = 56
    Top = 56
    Width = 75
    Height = 25
  end
  object CancelButton: TButton
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
    Left = 360
    Top = 56
    Width = 75
    Height = 25
  end
  object ActionList: TActionList
    Left = 272
    Top = 56
    object OkAction: TAction
      Caption = 'Ok'
      OnExecute = OkActionExecute
      OnUpdate = OkActionUpdate
    end
  end
end
