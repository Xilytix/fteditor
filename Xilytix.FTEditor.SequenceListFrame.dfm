object SequenceListFrame: TSequenceListFrame
  Left = 0
  Top = 0
  Width = 179
  Height = 95
  TabOrder = 0
  TabStop = True
  object ButtonsAndPropertyPanel: TPanel
    Left = 0
    Top = 0
    Width = 179
    Height = 74
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PropertyButtonsSplitter: TSplitter
      Left = 79
      Top = 0
      Height = 74
      Align = alRight
      AutoSnap = False
      ExplicitLeft = 72
      ExplicitTop = -40
      ExplicitHeight = 124
    end
    object ButtonsPanel: TPanel
      Left = 0
      Top = 0
      Width = 79
      Height = 74
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Buttons: TCategoryButtons
        Left = 0
        Top = 0
        Width = 79
        Height = 74
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ButtonFlow = cbfVertical
        ButtonWidth = 110
        ButtonOptions = [boFullSize, boShowCaptions, boBoldCaptions]
        Categories = <
          item
            Caption = 'Sequences'
            Color = 16771839
            Collapsed = False
            Items = <>
          end
          item
            Caption = 'Items'
            Color = 16053492
            Collapsed = False
            Items = <>
          end
          item
            Caption = 'Redirects'
            Color = 15395839
            Collapsed = False
            Items = <>
          end>
        RegularButtonColor = 15660791
        SelectedButtonColor = 13361893
        TabOrder = 0
        OnDragDrop = ButtonsDragDrop
        OnDragOver = ButtonsDragOver
        OnMouseDown = ButtonsMouseDown
        OnMouseMove = ButtonsMouseMove
        OnSelectedItemChange = ButtonsSelectedItemChange
      end
    end
    object PropertiesPanel: TPanel
      Left = 82
      Top = 0
      Width = 97
      Height = 74
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object AddRemovePanel: TPanel
    Left = 0
    Top = 74
    Width = 179
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      179
      21)
    object AddItemComboBox: TComboBox
      Left = 0
      Top = 0
      Width = 125
      Height = 21
      Align = alLeft
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      OnChange = AddItemComboBoxChange
      OnDropDown = AddItemComboBoxDropDown
    end
    object RemoveButton: TButton
      Left = 140
      Top = 1
      Width = 37
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'Rem'
      Enabled = False
      TabOrder = 1
      OnClick = RemoveButtonClick
    end
  end
end
