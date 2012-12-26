object UrlForm: TUrlForm
  Left = 197
  Top = 81
  BorderIcons = []
  Caption = 'Enter URL'
  ClientHeight = 80
  ClientWidth = 501
  Color = clBtnFace
  Constraints.MaxHeight = 118
  Constraints.MinHeight = 118
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  DesignSize = (
    501
    80)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object UrlEdit: TEdit
    Left = 47
    Top = 13
    Width = 441
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'http://'
  end
  object OkButton: TButton
    Left = 56
    Top = 56
    Width = 75
    Height = 25
    Action = OkAction
    Default = True
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 360
    Top = 56
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
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
