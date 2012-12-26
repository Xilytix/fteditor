inherited FieldsFrame: TFieldsFrame
  Width = 177
  Height = 4
  ParentColor = False
  ExplicitWidth = 177
  ExplicitHeight = 4
  object Splitter: TSplitter
    Left = 12
    Top = 0
    Height = 4
    Align = alRight
    ResizeStyle = rsUpdate
    ExplicitLeft = 224
    ExplicitTop = 3
    ExplicitHeight = 225
  end
  object PropertiesPanel: TPanel
    Left = 15
    Top = 0
    Width = 162
    Height = 4
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
  end
  object FieldListPanel: TPanel
    Left = 0
    Top = 0
    Width = 12
    Height = 4
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 12
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Fields'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 32
    end
    object FieldsButtonGroup: TButtonGroup
      Left = 0
      Top = 13
      Width = 12
      Height = 24
      Align = alClient
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ButtonOptions = [gboAllowReorder, gboFullSize, gboGroupStyle, gboShowCaptions]
      Items = <>
      TabOrder = 0
      OnButtonClicked = FieldsButtonGroupButtonClicked
      OnReorderButton = FieldsButtonGroupReorderButton
      OnStartDrag = FieldsButtonGroupStartDrag
    end
    object FieldAddRemovePanel: TPanel
      Left = 0
      Top = -19
      Width = 12
      Height = 23
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object RemoveButton: TButton
        AlignWithMargins = True
        Left = -15
        Top = 0
        Width = 27
        Height = 23
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alRight
        Caption = 'Rem'
        TabOrder = 0
        OnClick = RemoveButtonClick
      end
      object AddFieldComboBox: TComboBoxEx
        Left = 0
        Top = 0
        Width = 7
        Height = 22
        Align = alClient
        ItemsEx.SortType = stText
        ItemsEx = <>
        Style = csExDropDownList
        TabOrder = 1
        OnChange = AddFieldComboBoxChange
      end
    end
  end
end
