inherited SourceFrame: TSourceFrame
  Width = 670
  Height = 143
  OnEnter = FrameEnter
  ExplicitWidth = 670
  ExplicitHeight = 143
  object TopFlowPanel: TFlowPanel
    Left = 0
    Top = 0
    Width = 670
    Height = 17
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object SourcePanel: TPanel
      Left = 0
      Top = 0
      Width = 142
      Height = 15
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object SourceModeComboBox: TComboBoxEx
        Left = 53
        Top = -4
        Width = 71
        Height = 22
        ItemsEx = <>
        Style = csExDropDownList
        TabOrder = 0
        OnChange = SourceModeComboBoxChange
      end
    end
    object LineCountPanel: TPanel
      AlignWithMargins = True
      Left = 146
      Top = 1
      Width = 78
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 3
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 24
        Height = 13
        Caption = 'Lines'
        FocusControl = LineCountEdit
      end
      object LineCountEdit: TEdit
        Left = 28
        Top = 0
        Width = 50
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object CharsPanel: TPanel
      AlignWithMargins = True
      Left = 232
      Top = 1
      Width = 78
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 1
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 28
        Height = 13
        Caption = 'Chars'
        FocusControl = CharsEdit
      end
      object CharsEdit: TEdit
        Left = 28
        Top = 0
        Width = 50
        Height = 14
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object RecordsPanel: TPanel
      AlignWithMargins = True
      Left = 318
      Top = 1
      Width = 93
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 16
      object Label16: TLabel
        Left = 0
        Top = 0
        Width = 39
        Height = 13
        Caption = 'Records'
        FocusControl = RecordsEdit
      end
      object RecordsEdit: TEdit
        Left = 43
        Top = 0
        Width = 50
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object LineNrPanel: TPanel
      AlignWithMargins = True
      Left = 419
      Top = 1
      Width = 86
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 4
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 33
        Height = 13
        Caption = 'Line Nr'
        FocusControl = LineNrEdit
      end
      object LineNrEdit: TEdit
        Left = 36
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
      Left = 513
      Top = 1
      Width = 92
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 5
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 39
        Height = 13
        Caption = 'Line Pos'
        FocusControl = LinePosEdit
      end
      object LinePosEdit: TEdit
        Left = 42
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
      Left = 4
      Top = 17
      Width = 89
      Height = 14
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 2
      object Label5: TLabel
        Left = 0
        Top = 0
        Width = 36
        Height = 13
        Caption = 'File Pos'
        FocusControl = FilePosEdit
      end
      object FilePosEdit: TEdit
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
    object RecordNrPanel: TPanel
      AlignWithMargins = True
      Left = 101
      Top = 17
      Width = 120
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 13
      object Label12: TLabel
        Left = 0
        Top = 0
        Width = 48
        Height = 13
        Caption = 'Record Nr'
        FocusControl = RecordNrEdit
      end
      object RecordNrEdit: TEdit
        Left = 49
        Top = 0
        Width = 71
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object FieldPosPanel: TPanel
      AlignWithMargins = True
      Left = 229
      Top = 17
      Width = 87
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 9
      object Label8: TLabel
        Left = 0
        Top = 0
        Width = 42
        Height = 13
        Caption = 'Field Pos'
        FocusControl = FieldPosEdit
      end
      object FieldPosEdit: TEdit
        Left = 46
        Top = 0
        Width = 41
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object FieldNamePanel: TPanel
      AlignWithMargins = True
      Left = 324
      Top = 17
      Width = 132
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 8
      object Label7: TLabel
        Left = 0
        Top = 0
        Width = 52
        Height = 13
        Caption = 'Field Name'
        FocusControl = FieldNameEdit
      end
      object FieldNameEdit: TEdit
        Left = 54
        Top = 0
        Width = 78
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object FieldIndexPanel: TPanel
      AlignWithMargins = True
      Left = 464
      Top = 17
      Width = 96
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 7
      object Label6: TLabel
        Left = 0
        Top = 0
        Width = 53
        Height = 13
        Caption = 'Field Index'
        FocusControl = FieldIndexEdit
      end
      object FieldIndexEdit: TEdit
        Left = 55
        Top = 0
        Width = 41
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object FieldValuePanel: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 33
      Width = 124
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 11
      object Label9: TLabel
        Left = 0
        Top = 0
        Width = 51
        Height = 13
        Caption = 'Field Value'
        FocusControl = FieldValueEdit
      end
      object FieldValueEdit: TEdit
        Left = 53
        Top = 0
        Width = 71
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object TableNrPanel: TPanel
      AlignWithMargins = True
      Left = 136
      Top = 33
      Width = 83
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 15
      object Label15: TLabel
        Left = 0
        Top = 0
        Width = 40
        Height = 13
        Caption = 'Table Nr'
        FocusControl = TableNrEdit
      end
      object TableNrEdit: TEdit
        Left = 42
        Top = 0
        Width = 41
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object SeqNamePanel: TPanel
      AlignWithMargins = True
      Left = 227
      Top = 33
      Width = 128
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 14
      object Label13: TLabel
        Left = 0
        Top = 0
        Width = 48
        Height = 13
        Caption = 'Seq Name'
        FocusControl = SeqNameEdit
      end
      object SeqNameEdit: TEdit
        Left = 50
        Top = 0
        Width = 78
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object ItemIndexPanel: TPanel
      AlignWithMargins = True
      Left = 363
      Top = 33
      Width = 96
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 12
      object Label10: TLabel
        Left = 0
        Top = 0
        Width = 53
        Height = 13
        Caption = 'Item Index'
        FocusControl = ItemIndexEdit
      end
      object ItemIndexEdit: TEdit
        Left = 55
        Top = 0
        Width = 41
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object FieldTextPanel: TPanel
      AlignWithMargins = True
      Left = 467
      Top = 33
      Width = 120
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 10
      object Label11: TLabel
        Left = 0
        Top = 0
        Width = 47
        Height = 13
        Caption = 'Field Text'
        FocusControl = FieldTextEdit
      end
      object FieldTextEdit: TEdit
        Left = 49
        Top = 0
        Width = 71
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object FieldHeadingPanel: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 48
      Width = 137
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      object Label14: TLabel
        Left = 0
        Top = 0
        Width = 64
        Height = 13
        Caption = 'Field Heading'
        FocusControl = FieldHeadingEdit
      end
      object FieldHeadingEdit: TEdit
        Left = 66
        Top = 0
        Width = 71
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
end
