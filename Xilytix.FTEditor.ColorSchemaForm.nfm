object ColorSchemaForm: TColorSchemaForm
  Caption = 'Load/Save Colour Schema'
  ClientHeight = 317
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Left = 377
  Top = 126
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    Left = 0
    Top = 280
    Width = 366
    Height = 37
    DesignSize = (
      366
      37)
    object LoadSaveButton: TButton
      Caption = 'LoadSave'
      Default = True
      ModalResult = 1
      TabOrder = 0
      Left = 16
      Top = 6
      Width = 75
      Height = 25
    end
    object DeleteButton: TButton
      Action = DeleteAction
      TabOrder = 1
      Left = 128
      Top = 6
      Width = 75
      Height = 25
    end
    object CancelButton: TButton
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
      Left = 276
      Top = 6
      Width = 75
      Height = 25
    end
  end
  object SelectedPanel: TPanel
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 2
    Left = 0
    Top = 244
    Width = 366
    Height = 36
    DesignSize = (
      366
      36)
    object LoadSaveAsLabel: TLabel
      Caption = 'Save As'
      FocusControl = SelectedEdit
      Left = 16
      Top = 12
      Width = 39
      Height = 13
    end
    object SelectedEdit: TEdit
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'SelectedEdit'
      Left = 62
      Top = 9
      Width = 289
      Height = 21
    end
  end
  object SchemaButtonGroup: TButtonGroup
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ButtonWidth = 240
    ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
    Height = 244
    Items = <>
    TabOrder = 0
    Width = 366
    Left = 0
    Top = 0
    OnButtonClicked = SchemaButtonGroupButtonClicked
    OnKeyDown = SchemaButtonGroupKeyDown
  end
  object ActionList: TActionList
    Left = 248
    Top = 104
    object LoadAction: TAction
      Caption = 'Load'
      OnExecute = LoadSaveActionExecute
      OnUpdate = LoadActionUpdate
    end
    object SaveAction: TAction
      Caption = 'Save'
      OnExecute = LoadSaveActionExecute
      OnUpdate = SaveDeleteActionUpdate
    end
    object DeleteAction: TAction
      Caption = '&Delete'
      OnExecute = DeleteActionExecute
      OnUpdate = SaveDeleteActionUpdate
    end
  end
end
