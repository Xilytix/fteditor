inherited FieldsFrame: TFieldsFrame
  Width = 177
  Height = 4
  ParentColor = False
  ExplicitWidth = 177
  ExplicitHeight = 4
  object Splitter: TSplitter
    Align = alRight
    ResizeStyle = rsUpdate
    Left = 12
    Top = 0
    Height = 4
    ExplicitLeft = 224
    ExplicitTop = 3
    ExplicitHeight = 225
  end
  object PropertiesPanel: TPanel
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    Left = 15
    Top = 0
    Width = 162
    Height = 4
  end
  object FieldListPanel: TPanel
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    Left = 0
    Top = 0
    Width = 12
    Height = 4
    object Label1: TLabel
      Align = alTop
      Alignment = taCenter
      Caption = 'Fields'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Left = 0
      Top = 0
      Width = 12
      Height = 13
      ExplicitWidth = 32
    end
    object FieldsButtonGroup: TButtonGroup
      Align = alClient
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ButtonOptions = [gboAllowReorder, gboFullSize, gboGroupStyle, gboShowCaptions]
      Height = 24
      Items = <>
      TabOrder = 0
      Width = 12
      Left = 0
      Top = 13
      OnButtonClicked = FieldsButtonGroupButtonClicked
      OnReorderButton = FieldsButtonGroupReorderButton
      OnStartDrag = FieldsButtonGroupStartDrag
    end
    object FieldAddRemovePanel: TPanel
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      Left = 0
      Top = -19
      Width = 12
      Height = 23
      object RemoveButton: TButton
        Caption = 'Rem'
        TabOrder = 0
        Left = -15
        Top = 0
        Width = 27
        Height = 23
        Align = alRight
        AlignWithMargins = True
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        OnClick = RemoveButtonClick
      end
      object AddFieldComboBox: TComboBoxEx
        ItemsEx.SortType = stText
        ItemsEx = <>
        Style = csExDropDownList
        ItemHeight = 16
        TabOrder = 1
        Left = 0
        Top = 0
        Width = 7
        Height = 22
        Align = alClient
        OnChange = AddFieldComboBoxChange
      end
    end
  end
end
