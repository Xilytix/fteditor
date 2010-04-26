object SequenceTreeFrame: TSequenceTreeFrame
  Left = 0
  Top = 0
  Width = 296
  Height = 145
  TabOrder = 0
  object PropertiesPanel: TPanel
    Left = 192
    Top = 0
    Width = 104
    Height = 145
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 200
    ExplicitHeight = 172
  end
  object TreeViewPanel: TPanel
    Left = 0
    Top = 0
    Width = 192
    Height = 145
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 24
    ExplicitTop = 136
    ExplicitWidth = 185
    ExplicitHeight = 41
    object TreeView: TTreeView
      Left = 0
      Top = 0
      Width = 192
      Height = 123
      Align = alClient
      Indent = 19
      TabOrder = 0
      ExplicitLeft = 64
      ExplicitTop = -56
      ExplicitWidth = 121
      ExplicitHeight = 97
    end
    object AddComboBoxEx: TComboBoxEx
      Left = 0
      Top = 123
      Width = 192
      Height = 22
      Align = alBottom
      ItemsEx = <>
      TabOrder = 1
      Text = 'AddComboBoxEx'
      ExplicitTop = 150
      ExplicitWidth = 200
    end
  end
end
