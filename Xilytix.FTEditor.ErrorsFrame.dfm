inherited ErrorsFrame: TErrorsFrame
  Width = 1004
  Height = 4
  ExplicitWidth = 1004
  ExplicitHeight = 4
  object TopSplitter: TSplitter
    Left = 0
    Top = 15
    Width = 1004
    Height = 3
    Cursor = crVSplit
    Align = alTop
    AutoSnap = False
    Beveled = True
    MinSize = 15
    ExplicitLeft = 8
    ExplicitTop = 23
    ExplicitWidth = 626
  end
  object ErrorsMemo: TMemo
    Left = 0
    Top = 18
    Width = 1004
    Height = 22
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'ErrorsMem'
      'o')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object TopFlowPanel: TFlowPanel
    Left = 0
    Top = 0
    Width = 1004
    Height = 15
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object LinePanel: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 1
      Width = 75
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 19
        Height = 13
        Caption = 'Line'
      end
      object LineEdit: TEdit
        Left = 25
        Top = 0
        Width = 50
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object LinePosPanel: TPanel
      AlignWithMargins = True
      Left = 87
      Top = 1
      Width = 94
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 39
        Height = 13
        Caption = 'Line Pos'
        FocusControl = LinePosEdit
      end
      object LinePosEdit: TEdit
        Left = 44
        Top = 0
        Width = 50
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object RecordPanel: TPanel
      AlignWithMargins = True
      Left = 189
      Top = 1
      Width = 89
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 3
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 34
        Height = 13
        Caption = 'Record'
        FocusControl = RecordEdit
      end
      object RecordEdit: TEdit
        Left = 39
        Top = 0
        Width = 50
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object ActiveIndexPanel: TPanel
      AlignWithMargins = True
      Left = 286
      Top = 1
      Width = 116
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 5
      object Label6: TLabel
        Left = 0
        Top = 0
        Width = 61
        Height = 13
        Caption = 'Active Index'
        FocusControl = ActiveIndexEdit
      end
      object ActiveIndexEdit: TEdit
        Left = 66
        Top = 0
        Width = 50
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object FieldPanel: TPanel
      AlignWithMargins = True
      Left = 410
      Top = 1
      Width = 113
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 7
      object Label8: TLabel
        Left = 0
        Top = 0
        Width = 22
        Height = 13
        Caption = 'Field'
        FocusControl = FieldEdit
      end
      object FieldEdit: TEdit
        Left = 27
        Top = 0
        Width = 86
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object SequencePanel: TPanel
      AlignWithMargins = True
      Left = 531
      Top = 1
      Width = 138
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 8
      object Label9: TLabel
        Left = 0
        Top = 0
        Width = 47
        Height = 13
        Caption = 'Sequence'
        FocusControl = SequenceEdit
      end
      object SequenceEdit: TEdit
        Left = 52
        Top = 0
        Width = 86
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object ItemIndexPanel: TPanel
      AlignWithMargins = True
      Left = 677
      Top = 1
      Width = 108
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 6
      object Label7: TLabel
        Left = 0
        Top = 0
        Width = 53
        Height = 13
        Caption = 'Item Index'
        FocusControl = ItemIndexEdit
      end
      object ItemIndexEdit: TEdit
        Left = 58
        Top = 0
        Width = 50
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object FilePosPanel: TPanel
      AlignWithMargins = True
      Left = 793
      Top = 1
      Width = 91
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 2
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 36
        Height = 13
        Caption = 'File Pos'
        FocusControl = FilePosEdit
      end
      object FilePosEdit: TEdit
        Left = 41
        Top = 0
        Width = 50
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object TablePanel: TPanel
      AlignWithMargins = True
      Left = 892
      Top = 1
      Width = 81
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 4
      object Label5: TLabel
        Left = 0
        Top = 0
        Width = 26
        Height = 13
        Caption = 'Table'
        FocusControl = TableEdit
      end
      object TableEdit: TEdit
        Left = 31
        Top = 0
        Width = 50
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
end
