object FieldHeadingsForm: TFieldHeadingsForm
  Left = 197
  Top = 81
  Caption = 'Field Headings'
  ClientHeight = 212
  ClientWidth = 196
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Left = 0
    Top = 171
    Width = 196
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object OkButton: TButton
      Left = 11
      Top = 8
      Width = 41
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = OkButtonClick
    end
    object CancelButton: TButton
      Left = 145
      Top = 8
      Width = 41
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object ClearButton: TButton
      Left = 69
      Top = 8
      Width = 41
      Height = 25
      Caption = 'Clear'
      TabOrder = 2
      OnClick = ClearButtonClick
    end
  end
  object Grid: TStringGrid
    Left = 0
    Top = 0
    Width = 196
    Height = 171
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ColCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing, goAlwaysShowEditor, goThumbTracking]
    TabOrder = 1
    ColWidths = (
      64
      108)
  end
end
