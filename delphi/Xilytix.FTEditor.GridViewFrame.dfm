inherited GridViewFrame: TGridViewFrame
  Width = 543
  Height = 67
  ExplicitWidth = 543
  ExplicitHeight = 67
  object TopSplitter: TSplitter [0]
    Left = 0
    Top = 17
    Width = 543
    Height = 3
    Cursor = crVSplit
    Align = alTop
    AutoSnap = False
    Beveled = True
    MinSize = 15
    ExplicitLeft = -160
    ExplicitTop = 15
    ExplicitWidth = 626
  end
  inherited TopFlowPanel: TFlowPanel
    Width = 543
    TabOrder = 1
    OnClick = FrameComponentClick
    ExplicitWidth = 543
    inherited SourcePanel: TPanel
      Width = 134
      OnClick = FrameComponentClick
      ExplicitWidth = 134
      object GenerateButton: TButton
        Left = 0
        Top = 0
        Width = 50
        Height = 15
        Margins.Left = 0
        Margins.Top = 1
        Margins.Right = 4
        Margins.Bottom = 1
        Caption = 'Generate'
        TabOrder = 1
        OnClick = GenerateButtonClick
      end
    end
    inherited LineCountPanel: TPanel
      Left = 138
      ExplicitLeft = 138
    end
    inherited CharsPanel: TPanel
      Left = 224
      ExplicitLeft = 224
    end
    inherited RecordsPanel: TPanel
      Left = 310
      ExplicitLeft = 310
    end
    inherited LineNrPanel: TPanel
      Left = 411
      ExplicitLeft = 411
    end
    inherited LinePosPanel: TPanel
      Left = 4
      Top = 17
      ExplicitLeft = 4
      ExplicitTop = 17
    end
    inherited FilePosPanel: TPanel
      Left = 104
      ExplicitLeft = 104
    end
    inherited RecordNrPanel: TPanel
      Left = 201
      ExplicitLeft = 201
    end
    inherited FieldPosPanel: TPanel
      Left = 329
      ExplicitLeft = 329
    end
    inherited FieldNamePanel: TPanel
      Left = 4
      Top = 33
      ExplicitLeft = 4
      ExplicitTop = 33
    end
    inherited FieldIndexPanel: TPanel
      Left = 144
      Top = 33
      ExplicitLeft = 144
      ExplicitTop = 33
    end
    inherited FieldValuePanel: TPanel
      Left = 248
      ExplicitLeft = 248
    end
    inherited TableNrPanel: TPanel
      Left = 380
      ExplicitLeft = 380
    end
    inherited SeqNamePanel: TPanel
      Left = 4
      Top = 48
      ExplicitLeft = 4
      ExplicitTop = 48
    end
    inherited ItemIndexPanel: TPanel
      Left = 140
      Top = 48
      ExplicitLeft = 140
      ExplicitTop = 48
    end
    inherited FieldTextPanel: TPanel
      Left = 244
      Top = 48
      ExplicitLeft = 244
      ExplicitTop = 48
    end
    inherited FieldHeadingPanel: TPanel
      Left = 372
      ExplicitLeft = 372
    end
  end
  object Grid: TDrawGrid
    Left = 0
    Top = 20
    Width = 543
    Height = 47
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    DefaultDrawing = False
    Options = [goRowSizing, goColSizing, goTabs, goThumbTracking]
    TabOrder = 0
    OnDrawCell = GridDrawCell
    OnEnter = GridEnter
    OnExit = GridExit
    OnMouseEnter = GridMouseEnter
    OnMouseLeave = GridMouseLeave
    OnMouseMove = GridMouseMove
    OnSelectCell = GridSelectCell
  end
end
