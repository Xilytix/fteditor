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
  end
  object TreeViewPanel: TPanel
    Left = 0
    Top = 0
    Width = 192
    Height = 145
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object TreeView: TTreeView
      Left = 0
      Top = 0
      Width = 192
      Height = 124
      Align = alClient
      Indent = 19
      TabOrder = 0
    end
    object AddComboBox: TComboBox
      Left = 0
      Top = 124
      Width = 192
      Height = 21
      Align = alBottom
      TabOrder = 1
      Text = 'AddComboBox'
    end
  end
end
