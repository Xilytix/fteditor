inherited SequencesFrame: TSequencesFrame
  Width = 184
  Height = 4
  ExplicitWidth = 184
  ExplicitHeight = 4
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 184
    Height = 4
    ActivePage = ListTabSheet
    Align = alClient
    TabOrder = 0
    object ListTabSheet: TTabSheet
      Caption = 'List'
    end
    object TreeTabSheet: TTabSheet
      Caption = 'Tree'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 216
      ExplicitHeight = 31
    end
  end
end
