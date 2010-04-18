object AboutForm: TAboutForm
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'About'
  ClientHeight = 198
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Left = 156
  Top = 84
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Caption = 'FTEditor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Left = 7
    Top = 5
    Width = 115
    Height = 33
  end
  object Label2: TLabel
    Caption = 'Fielded Text Editor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Left = 7
    Top = 44
    Width = 157
    Height = 23
  end
  object VersionLabel: TLabel
    Caption = 'Version'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Left = 7
    Top = 83
    Width = 43
    Height = 16
  end
  object Label3: TLabel
    Caption = 'Licence: GPL'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Left = 7
    Top = 105
    Width = 72
    Height = 16
  end
  object SourceForgeLineLabel: TLabel
    Caption = 'http://sourceforge.net/projects/FTEditor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    Left = 7
    Top = 173
    Width = 226
    Height = 14
    Cursor = crHandPoint
    OnClick = SourceForgeLineLabelClick
  end
  object FieldedTextLinkLabel: TLabel
    Caption = 'http://www.fieldedtext.org'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    Left = 7
    Top = 155
    Width = 153
    Height = 14
    Cursor = crHandPoint
    OnClick = FieldedTextLinkLabelClick
  end
  object Bevel1: TBevel
    Shape = bsLeftLine
    Left = 274
    Top = 6
    Width = 3
    Height = 181
  end
  object Label6: TLabel
    Caption = 'Developers'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Left = 284
    Top = 6
    Width = 64
    Height = 13
  end
  object Label7: TLabel
    Caption = 'Paul Klink'
    Left = 297
    Top = 22
    Width = 44
    Height = 13
  end
  object Label8: TLabel
    Caption = 'Supporting Companies'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Left = 284
    Top = 111
    Width = 127
    Height = 13
  end
  object XilytixLinkLabel: TLabel
    Caption = 'Xilytix'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    Left = 297
    Top = 129
    Width = 28
    Height = 13
    Cursor = crHandPoint
    OnClick = XilytixLinkLabelClick
  end
  object XilytixFTEditorLinkLabel: TLabel
    Caption = 'http://www.xilytix.com/FieldedTextEditor.html'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    Left = 7
    Top = 137
    Width = 257
    Height = 14
    Cursor = crHandPoint
    OnClick = XilytixFTEditorLinkLabelClick
  end
  object Button1: TButton
    Caption = 'Close'
    TabOrder = 0
    Left = 360
    Top = 162
    Width = 51
    Height = 25
    ModalResult = 1
  end
end
