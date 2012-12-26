inherited SequencePropertiesFrame: TSequencePropertiesFrame
  Width = 104
  Height = 80
  ExplicitWidth = 104
  ExplicitHeight = 80
  object Label1: TLabel
    Left = 3
    Top = 24
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 3
    Top = 3
    Width = 55
    Height = 13
    Caption = 'Sequence'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 3
    Top = 90
    Width = 27
    Height = 13
    Caption = 'Items'
  end
  object ItemsCountLabel: TLabel
    Left = 43
    Top = 90
    Width = 6
    Height = 13
    Caption = '0'
  end
  object NameEdit: TEdit
    Left = 2
    Top = 40
    Width = 99
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 'NameEdit'
    OnExit = NameEditExit
    OnKeyPress = NameEditKeyPress
  end
  object IsRootCheckBox: TCheckBox
    Left = 3
    Top = 69
    Width = 61
    Height = 17
    Caption = 'Is Root'
    TabOrder = 1
    OnClick = IsRootCheckBoxClick
  end
end
