object AboutForm: TAboutForm
  Left = 156
  Top = 84
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'About'
  ClientHeight = 197
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 5
    Width = 115
    Height = 33
    Caption = 'FTEditor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 7
    Top = 44
    Width = 157
    Height = 23
    Caption = 'Fielded Text Editor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object VersionLabel: TLabel
    Left = 7
    Top = 84
    Width = 43
    Height = 16
    Caption = 'Version'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 7
    Top = 126
    Width = 131
    Height = 16
    Caption = 'Licence: Public Domain'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object FieldedTextLinkLabel: TLabel
    Left = 7
    Top = 170
    Width = 153
    Height = 14
    Cursor = crHandPoint
    Caption = 'http://www.fieldedtext.org'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = FieldedTextLinkLabelClick
  end
  object Bevel1: TBevel
    Left = 274
    Top = 6
    Width = 3
    Height = 178
    Shape = bsLeftLine
  end
  object Label6: TLabel
    Left = 284
    Top = 6
    Width = 64
    Height = 13
    Caption = 'Developers'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 297
    Top = 22
    Width = 44
    Height = 13
    Caption = 'Paul Klink'
  end
  object Label8: TLabel
    Left = 284
    Top = 51
    Width = 127
    Height = 13
    Caption = 'Supporting Companies'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object XilytixLinkLabel: TLabel
    Left = 297
    Top = 69
    Width = 28
    Height = 13
    Cursor = crHandPoint
    Caption = 'Xilytix'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = XilytixLinkLabelClick
  end
  object XilytixFTEditorLinkLabel: TLabel
    Left = 7
    Top = 152
    Width = 229
    Height = 14
    Cursor = crHandPoint
    Caption = 'http://www.xilytix.com/fieldedtext/editor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = XilytixFTEditorLinkLabelClick
  end
  object FieldedTextVersionLabel: TLabel
    Left = 7
    Top = 108
    Width = 117
    Height = 16
    Caption = 'Fielded Text Version'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 360
    Top = 159
    Width = 51
    Height = 25
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 0
  end
end
