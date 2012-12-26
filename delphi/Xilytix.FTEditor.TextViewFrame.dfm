inherited TextViewFrame: TTextViewFrame
  Width = 727
  Height = 168
  DragKind = dkDock
  DragMode = dmAutomatic
  ExplicitWidth = 727
  ExplicitHeight = 168
  object TopSplitter: TSplitter [0]
    Left = 0
    Top = 17
    Width = 727
    Height = 3
    Cursor = crVSplit
    Align = alTop
    AutoSnap = False
    Beveled = True
    MinSize = 15
    ExplicitTop = 16
    ExplicitWidth = 469
  end
  inherited TopFlowPanel: TFlowPanel
    Width = 727
    FullRepaint = False
    TabOrder = 1
    OnClick = FrameComponentClick
    ExplicitWidth = 727
    inherited SourcePanel: TPanel
      Width = 122
      OnClick = FrameComponentClick
      ExplicitWidth = 122
      inherited SourceModeComboBox: TComboBoxEx
        Left = 42
        ExplicitLeft = 42
      end
      object ParseButton: TButton
        Left = 0
        Top = 0
        Width = 39
        Height = 15
        Caption = 'Parse'
        TabOrder = 1
        OnClick = ParseButtonClick
      end
    end
    inherited LineCountPanel: TPanel
      Left = 126
      ExplicitLeft = 126
    end
    inherited CharsPanel: TPanel
      Left = 212
      ExplicitLeft = 212
    end
    inherited RecordsPanel: TPanel
      Left = 298
      ExplicitLeft = 298
    end
    inherited LineNrPanel: TPanel
      Left = 399
      ExplicitLeft = 399
    end
    inherited LinePosPanel: TPanel
      Left = 493
      ExplicitLeft = 493
    end
    inherited FilePosPanel: TPanel
      Left = 593
      Top = 1
      ExplicitLeft = 593
      ExplicitTop = 1
    end
    inherited RecordNrPanel: TPanel
      Left = 4
      ExplicitLeft = 4
    end
    inherited FieldPosPanel: TPanel
      Left = 132
      ExplicitLeft = 132
    end
    inherited FieldNamePanel: TPanel
      Left = 227
      ExplicitLeft = 227
    end
    inherited FieldIndexPanel: TPanel
      Left = 367
      ExplicitLeft = 367
    end
    inherited FieldValuePanel: TPanel
      Left = 471
      Top = 17
      ExplicitLeft = 471
      ExplicitTop = 17
    end
    inherited TableNrPanel: TPanel
      Left = 603
      Top = 17
      ExplicitLeft = 603
      ExplicitTop = 17
    end
    inherited SeqNamePanel: TPanel
      Left = 4
      Top = 32
      ExplicitLeft = 4
      ExplicitTop = 32
    end
    inherited ItemIndexPanel: TPanel
      Left = 140
      Top = 32
      ExplicitLeft = 140
      ExplicitTop = 32
    end
    inherited FieldTextPanel: TPanel
      Left = 244
      Top = 32
      ExplicitLeft = 244
      ExplicitTop = 32
    end
    inherited FieldHeadingPanel: TPanel
      Left = 372
      Top = 32
      ExplicitLeft = 372
      ExplicitTop = 32
    end
  end
  object TextEdit: TRichEdit
    Left = 0
    Top = 20
    Width = 727
    Height = 148
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    OnChange = TextEditChange
    OnEnter = TextEditEnter
    OnExit = TextEditExit
    OnKeyDown = TextEditKeyDown
    OnMouseDown = TextEditMouseDown
    OnMouseEnter = TextEditMouseEnter
    OnMouseLeave = TextEditMouseLeave
    OnMouseMove = TextEditMouseMove
  end
end
