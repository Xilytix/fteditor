object SequenceListFrame: TSequenceListFrame
  TabOrder = 0
  TabStop = True
  Left = 0
  Top = 0
  Width = 179
  Height = 95
  object ButtonsAndPropertyPanel: TPanel
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    Left = 0
    Top = 0
    Width = 179
    Height = 74
    object PropertyButtonsSplitter: TSplitter
      Align = alRight
      AutoSnap = False
      Left = 79
      Top = 0
      Height = 74
      ExplicitLeft = 72
      ExplicitTop = -40
      ExplicitHeight = 124
    end
    object ButtonsPanel: TPanel
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      Left = 0
      Top = 0
      Width = 79
      Height = 74
      object Buttons: TCategoryButtons
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ButtonFlow = cbfVertical
        ButtonWidth = 110
        ButtonOptions = [boFullSize, boShowCaptions, boBoldCaptions]
        Height = 74
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
        Width = 79
        Left = 0
        Top = 0
        OnDragDrop = ButtonsDragDrop
        OnDragOver = ButtonsDragOver
        OnMouseDown = ButtonsMouseDown
        OnMouseMove = ButtonsMouseMove
        OnSelectedItemChange = ButtonsSelectedItemChange
      end
    end
    object PropertiesPanel: TPanel
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      Left = 82
      Top = 0
      Width = 97
      Height = 74
    end
  end
  object AddRemovePanel: TPanel
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Left = 0
    Top = 74
    Width = 179
    Height = 21
    DesignSize = (
      179
      21)
    object AddItemComboBox: TComboBoxEx
      ItemsEx = <>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 0
      Left = 0
      Top = 0
      Width = 125
      Height = 21
      Align = alLeft
      Anchors = [akLeft, akTop, akRight, akBottom]
      OnChange = AddItemComboBoxChange
      OnDropDown = AddItemComboBoxDropDown
      ExplicitHeight = 22
    end
    object RemoveButton: TButton
      Caption = 'Rem'
      TabOrder = 1
      Left = 140
      Top = 1
      Width = 37
      Height = 20
      Anchors = [akTop, akRight]
      Enabled = False
      OnClick = RemoveButtonClick
    end
  end
end
