object ColorSchemaForm: TColorSchemaForm
  Left = 377
  Top = 126
  Caption = 'Load/Save Colour Schema'
  ClientHeight = 317
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Left = 0
    Top = 280
    Width = 366
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      366
      37)
    object LoadSaveButton: TButton
      Left = 16
      Top = 6
      Width = 75
      Height = 25
      Caption = 'LoadSave'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object DeleteButton: TButton
      Left = 128
      Top = 6
      Width = 75
      Height = 25
      Action = DeleteAction
      TabOrder = 1
    end
    object CancelButton: TButton
      Left = 276
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
  end
  object SelectedPanel: TPanel
    Left = 0
    Top = 244
    Width = 366
    Height = 36
    Align = alBottom
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      366
      36)
    object LoadSaveAsLabel: TLabel
      Left = 16
      Top = 12
      Width = 39
      Height = 13
      Caption = 'Save As'
      FocusControl = SelectedEdit
    end
    object SelectedEdit: TEdit
      Left = 62
      Top = 9
      Width = 289
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'SelectedEdit'
    end
  end
  object SchemaButtonGroup: TButtonGroup
    Left = 0
    Top = 0
    Width = 366
    Height = 244
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    ButtonWidth = 240
    ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
    Items = <>
    TabOrder = 0
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
