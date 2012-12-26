object MainForm: TMainForm
  Caption = 'FTEditor'
  ClientHeight = 493
  ClientWidth = 891
  Color = clBtnFace
  DockSite = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Left = 368
  Top = 60
  ActiveControl = AutoParseCheckBox
  Visible = True
  Hint = 'Open|Opens an existing Meta file'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MouseOverPanelSplitter: TSplitter
    Align = alTop
    AutoSnap = False
    Cursor = crVSplit
    MinSize = 15
    ResizeStyle = rsUpdate
    Width = 891
    Left = 0
    Top = 89
    Height = 3
    OnMoved = MouseOverPanelSplitterMoved
    ExplicitWidth = 404
  end
  object MainMenuPanel: TPanel
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    Left = 0
    Top = 0
    Width = 891
    Height = 22
    DesignSize = (
      891
      22)
    object Label1: TLabel
      Caption = '&Layout'
      FocusControl = LayoutConfigurationsComboBox
      Left = 135
      Top = 4
      Width = 33
      Height = 13
    end
    object StatusBar: TStatusBar
      Align = alNone
      Anchors = [akLeft, akTop, akRight]
      Panels = <
        item
          Width = 35
        end
        item
          Width = 35
        end
        item
          Width = 35
        end
        item
          Width = 35
        end
        item
          Width = 52
        end
        item
          Width = 52
        end
        item
          Width = 50
        end>
      Left = 560
      Top = -1
      Width = 329
      Height = 22
      OnHint = StatusBarHint
      OnDrawPanel = StatusBarDrawPanel
    end
    object ConfigureLayoutButton: TButton
      Caption = '&Configure'
      TabOrder = 2
      Left = 305
      Top = 3
      Width = 51
      Height = 17
      OnClick = ConfigureLayoutButtonClick
    end
    object LayoutConfigurationsComboBox: TComboBoxEx
      ItemsEx = <>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 1
      Left = 171
      Top = -1
      Width = 131
      Height = 22
      OnChange = LayoutConfigurationsComboBoxChange
    end
    object ActionMainMenuBar: TActionMainMenuBar
      UseSystemFont = False
      ActionManager = ActionManager
      Align = alNone
      Caption = 'ActionMainMenuBar'
      ColorMap.HighlightColor = 14410210
      ColorMap.BtnSelectedColor = clBtnFace
      ColorMap.UnusedColor = 14410210
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      PersistentHotKeys = True
      Spacing = 0
      Left = -1
      Top = -1
      Width = 121
      Height = 22
    end
    object AutoParseCheckBox: TCheckBox
      Caption = 'Auto &Parse'
      TabOrder = 4
      Left = 369
      Top = 3
      Width = 73
      Height = 17
      OnClick = AutoParseCheckBoxClick
    end
    object AutoGenerateCheckBox: TCheckBox
      Caption = 'Auto &Generate'
      TabOrder = 5
      Left = 452
      Top = 3
      Width = 93
      Height = 17
      OnClick = AutoGenerateCheckBoxClick
    end
  end
  object MouseOverPanel: TFlowPanel
    Align = alTop
    BevelEdges = [beTop, beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    FullRepaint = False
    TabOrder = 1
    Left = 0
    Top = 22
    Width = 891
    Height = 67
    object MouseOverLineNrPanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      AlignWithMargins = True
      Left = 4
      Top = 1
      Width = 76
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label2: TLabel
        Caption = 'Line Nr'
        FocusControl = MouseOverLineNrEdit
        Left = 0
        Top = 0
        Width = 33
        Height = 13
      end
      object MouseOverLineNrEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 35
        Top = 0
        Width = 41
        Height = 13
      end
    end
    object MouseOverLinePosPanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      AlignWithMargins = True
      Left = 88
      Top = 1
      Width = 82
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label3: TLabel
        Caption = 'Line Pos'
        FocusControl = MouseOverLinePosEdit
        Left = 0
        Top = 0
        Width = 39
        Height = 13
      end
      object MouseOverLinePosEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 41
        Top = 0
        Width = 41
        Height = 13
      end
    end
    object MouseOverFilePosPanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      AlignWithMargins = True
      Left = 178
      Top = 1
      Width = 79
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label4: TLabel
        Caption = 'File Pos'
        FocusControl = MouseOverFilePosEdit
        Left = 0
        Top = 0
        Width = 36
        Height = 13
      end
      object MouseOverFilePosEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 38
        Top = 0
        Width = 41
        Height = 13
      end
    end
    object MouseOverRecordNrPanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 10
      AlignWithMargins = True
      Left = 265
      Top = 1
      Width = 120
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label12: TLabel
        Caption = 'Record Nr'
        FocusControl = MouseOverRecordNrEdit
        Left = 0
        Top = 0
        Width = 48
        Height = 13
      end
      object MouseOverRecordNrEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 49
        Top = 0
        Width = 71
        Height = 13
      end
    end
    object MouseOverFieldPosPanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      AlignWithMargins = True
      Left = 393
      Top = 1
      Width = 87
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label8: TLabel
        Caption = 'Field Pos'
        FocusControl = MouseOverFieldPosEdit
        Left = 0
        Top = 0
        Width = 42
        Height = 13
      end
      object MouseOverFieldPosEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 46
        Top = 0
        Width = 41
        Height = 13
      end
    end
    object MouseOverFieldNamePanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      AlignWithMargins = True
      Left = 488
      Top = 1
      Width = 132
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label5: TLabel
        Caption = 'Field Name'
        FocusControl = MouseOverFieldNameEdit
        Left = 0
        Top = 0
        Width = 52
        Height = 13
      end
      object MouseOverFieldNameEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 54
        Top = 0
        Width = 78
        Height = 13
      end
    end
    object MouseOverFieldIndexPanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 4
      AlignWithMargins = True
      Left = 628
      Top = 1
      Width = 96
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label6: TLabel
        Caption = 'Field Index'
        FocusControl = MouseOverFieldIndexEdit
        Left = 0
        Top = 0
        Width = 53
        Height = 13
      end
      object MouseOverFieldIndexEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 55
        Top = 0
        Width = 41
        Height = 13
      end
    end
    object MouseOverFieldValuePanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 5
      AlignWithMargins = True
      Left = 732
      Top = 1
      Width = 124
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label7: TLabel
        Caption = 'Field Value'
        FocusControl = MouseOverFieldValueEdit
        Left = 0
        Top = 0
        Width = 51
        Height = 13
      end
      object MouseOverFieldValueEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 53
        Top = 0
        Width = 71
        Height = 13
      end
    end
    object MouseOverTableNrPanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 11
      AlignWithMargins = True
      Left = 4
      Top = 16
      Width = 83
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label13: TLabel
        Caption = 'Table Nr'
        FocusControl = MouseOverTableNrEdit
        Left = 0
        Top = 0
        Width = 40
        Height = 13
      end
      object MouseOverTableNrEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 42
        Top = 0
        Width = 41
        Height = 13
      end
    end
    object MouseOverSeqNamePanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 7
      AlignWithMargins = True
      Left = 95
      Top = 16
      Width = 128
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label9: TLabel
        Caption = 'Seq Name'
        FocusControl = MouseOverSeqNameEdit
        Left = 0
        Top = 0
        Width = 48
        Height = 13
      end
      object MouseOverSeqNameEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 50
        Top = 0
        Width = 78
        Height = 13
      end
    end
    object MouseOverItemIndexPanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 8
      AlignWithMargins = True
      Left = 231
      Top = 16
      Width = 96
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label10: TLabel
        Caption = 'Item Index'
        FocusControl = MouseOverItemIndexEdit
        Left = 0
        Top = 0
        Width = 53
        Height = 13
      end
      object MouseOverItemIndexEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 55
        Top = 0
        Width = 41
        Height = 13
      end
    end
    object MouseOverFieldTextPanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 9
      AlignWithMargins = True
      Left = 335
      Top = 16
      Width = 120
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label11: TLabel
        Caption = 'Field Text'
        FocusControl = MouseOverFieldTextEdit
        Left = 0
        Top = 0
        Width = 47
        Height = 13
      end
      object MouseOverFieldTextEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 49
        Top = 0
        Width = 71
        Height = 13
      end
    end
    object MouseOverFieldHeadingPanel: TPanel
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 12
      AlignWithMargins = True
      Left = 463
      Top = 16
      Width = 137
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      object Label14: TLabel
        Caption = 'Field Heading'
        FocusControl = MouseOverFieldHeadingEdit
        Left = 0
        Top = 0
        Width = 64
        Height = 13
      end
      object MouseOverFieldHeadingEdit: TEdit
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
        Left = 66
        Top = 0
        Width = 71
        Height = 13
      end
    end
  end
  object ActionManager: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = NewTextAction
            Tag = 0
          end>
        Tag = 0
      end
      item
        Tag = 0
      end
      item
        Tag = 0
      end
      item
        Items = <
          item
            Caption = '&File'
            Items = <
              item
                Action = NewTextAction
                Tag = 0
              end
              item
                Action = OpenTextAction
                ImageIndex = 7
                ShortCut = 16463
                Tag = 0
              end
              item
                Action = SaveTextAction
                Tag = 0
              end
              item
                Action = SaveTextAsAction
                ImageIndex = 30
                Tag = 0
              end
              item
                Caption = '-'
                Tag = 0
              end
              item
                Action = ResetMetaAction
                Tag = 0
              end
              item
                Action = OpenMetaAction
                ImageIndex = 7
                Tag = 0
              end
              item
                Action = SaveMetaToReferenceAction
                Tag = 0
              end
              item
                Action = SaveMetaAsAction
                ImageIndex = 30
                Tag = 0
              end
              item
                Caption = '-'
                Tag = 0
              end
              item
                Action = ExitAction
                ImageIndex = 43
                Tag = 0
              end>
            Tag = 0
          end
          item
            Caption = 'E&dit'
            Items = <
              item
                Action = CutAction
                ImageIndex = 0
                ShortCut = 16472
                Tag = 0
              end
              item
                Action = CopyAction
                ImageIndex = 1
                ShortCut = 16451
                Tag = 0
              end
              item
                Action = EditPaste1
                ImageIndex = 2
                ShortCut = 16470
                Tag = 0
              end
              item
                Action = EditSelectAll1
                ShortCut = 16449
                Tag = 0
              end>
            Tag = 0
          end
          item
            Caption = '&Edit'
            Items = <
              item
                Action = CutAction
                ImageIndex = 0
                ShortCut = 16472
                Tag = 0
              end
              item
                Action = CopyAction
                ImageIndex = 1
                ShortCut = 16451
                Tag = 0
              end>
            Tag = 0
          end>
        Tag = 0
      end
      item
        Tag = 0
      end
      item
        ActionBar = ActionMainMenuBar
        Items = <
          item
            Caption = '&File'
            Items = <
              item
                Action = NewTextAction
                Tag = 0
              end
              item
                Action = OpenTextAction
                ImageIndex = 7
                ShortCut = 16463
                Tag = 0
              end
              item
                Action = OpenTextFromUrlAction
                Tag = 0
              end
              item
                Action = SaveTextAction
                Tag = 0
              end
              item
                Action = SaveTextAsAction
                ImageIndex = 30
                Tag = 0
              end
              item
                Caption = '-'
                Tag = 0
              end
              item
                Action = GenerateAction
                Tag = 0
              end
              item
                Action = GenerateAsAction
                ImageIndex = 30
                Tag = 0
              end
              item
                Caption = '-'
                Tag = 0
              end
              item
                Action = ResetMetaAction
                Tag = 0
              end
              item
                Action = OpenMetaAction
                ImageIndex = 7
                Tag = 0
              end
              item
                Action = OpenMetaFromUrlAction
                Tag = 0
              end
              item
                Action = SaveMetaToReferenceAction
                Caption = 'Sa&ve Meta To Reference'
                Tag = 0
              end
              item
                Action = SaveMetaAsAction
                ImageIndex = 30
                Tag = 0
              end
              item
                Caption = '-'
                Tag = 0
              end
              item
                Action = ExitAction
                ImageIndex = 43
                Tag = 0
              end>
            Tag = 0
          end
          item
            Caption = '&Edit'
            Items = <
              item
                Action = CutAction
                ImageIndex = 0
                ShortCut = 16472
                Tag = 0
              end
              item
                Action = CopyAction
                ImageIndex = 1
                ShortCut = 16451
                Tag = 0
              end
              item
                Action = EditPaste1
                ImageIndex = 2
                ShortCut = 16470
                Tag = 0
              end
              item
                Action = EditSelectAll1
                ShortCut = 16449
                Tag = 0
              end>
            Tag = 0
          end
          item
            Caption = '&Tools'
            Items = <
              item
                Action = MouseOverPanelVisibleAction
                Caption = '&Mouse Over Toolbar Visible'
                Tag = 0
              end
              item
                Caption = '-'
                Tag = 0
              end
              item
                Action = OptionsAction
                Tag = 0
              end
              item
                Action = CustomizeActionBarsAction
                Tag = 0
              end>
            Tag = 0
          end
          item
            Caption = '&Help'
            Items = <
              item
                Action = HelpAction
                Tag = 0
              end
              item
                Action = AboutAction
                Tag = 0
              end>
            Tag = 0
          end>
        Tag = 0
      end>
    Left = 40
    Top = 104
    StyleName = 'XP Style'
    object NewTextAction: TAction
      Caption = '&New Text'
      Category = 'File'
      OnExecute = NewTextActionExecute
    end
    object OpenTextAction: TFileOpen
      Caption = '&Open Text ...'
      Dialog.DefaultExt = 'ftx'
      Dialog.Filter = 
        'Text Files|*.txt; *.ftx; *.csv|Fielded Text Files (*.ftx)|*.ftx|' +
        'All Files|*.*'
      Hint = 'Open|Opens an existing text file'
      ImageIndex = 7
      ShortCut = 16463
      Category = 'File'
      OnAccept = OpenTextActionAccept
    end
    object OpenTextFromUrlAction: TAction
      Caption = 'Open Text from &URL ...'
      Category = 'File'
      OnExecute = OpenTextFromUrlActionExecute
    end
    object SaveTextAction: TAction
      Caption = '&Save Text'
      Category = 'File'
      OnExecute = SaveTextActionExecute
      OnUpdate = SaveTextActionUpdate
    end
    object SaveTextAsAction: TFileSaveAs
      Caption = 'Save Text &As ...'
      Dialog.Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 30
      Category = 'File'
      OnAccept = SaveTextAsActionAccept
    end
    object GenerateAction: TAction
      Caption = '&Generate'
      Category = 'File'
      OnExecute = GenerateActionExecute
      OnUpdate = GenerateActionUpdate
    end
    object GenerateAsAction: TFileSaveAs
      Caption = 'G&enerate As ...'
      Hint = 'Generate and save to specified file'
      ImageIndex = 30
      Category = 'File'
      OnAccept = GenerateAsActionAccept
    end
    object ResetMetaAction: TAction
      Caption = '&Reset Meta'
      Category = 'File'
      OnExecute = ResetMetaActionExecute
    end
    object OpenMetaAction: TFileOpen
      Caption = 'Open &Meta ...'
      Dialog.Filter = 'FieldedText Meta File|*.ftm|XML File|*.xml|All Files|*.*'
      Dialog.Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofCreatePrompt, ofEnableSizing]
      Hint = 'Open|Opens an existing Meta file'
      ImageIndex = 7
      Category = 'File'
      OnAccept = OpenMetaActionAccept
    end
    object OpenMetaFromUrlAction: TAction
      Caption = 'Open Meta from UR&L ...'
      Category = 'File'
      OnExecute = OpenMetaFromUrlActionExecute
    end
    object SaveMetaToReferenceAction: TAction
      Caption = 'Save M&eta To &Reference'
      Category = 'File'
      OnExecute = SaveMetaToReferenceActionExecute
      OnUpdate = SaveMetaToReferenceActionUpdate
    end
    object SaveMetaAsAction: TFileSaveAs
      Caption = 'Save Me&ta As ...'
      Dialog.DefaultExt = 'ftm'
      Dialog.Filter = 
        'Fielded Text Meta File (*.ftm)|*.ftm|XML File (*.xml)|*.xml|All ' +
        'Files|*.*'
      Dialog.Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
      Hint = 'Save As|Saves Meta with a new file name'
      ImageIndex = 30
      Category = 'File'
      OnAccept = SaveMetaAsActionAccept
    end
    object ExitAction: TFileExit
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
      Category = 'File'
    end
    object CutAction: TEditCut
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
      Category = 'Edit'
    end
    object CopyAction: TEditCopy
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
      Category = 'Edit'
    end
    object EditPaste1: TEditPaste
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
      Category = 'Edit'
    end
    object EditSelectAll1: TEditSelectAll
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
      Category = 'Edit'
    end
    object OptionsAction: TAction
      Caption = '&Options'
      Category = 'Tools'
      OnExecute = OptionsActionExecute
    end
    object CustomizeActionBarsAction: TCustomizeActionBars
      CustomizeDlg.StayOnTop = False
      Caption = '&Customize'
      Category = 'Tools'
    end
    object AboutAction: TAction
      Caption = '&About'
      Category = 'Help'
      OnExecute = AboutActionExecute
    end
    object MouseOverPanelVisibleAction: TAction
      Caption = 'Mouse Over Toolbar Visible'
      Category = 'Tools'
      AutoCheck = True
      OnExecute = MouseOverPanelVisibleActionExecute
      OnUpdate = MouseOverPanelVisibleActionUpdate
    end
    object HelpAction: TBrowseURL
      Caption = '&Help'
      Hint = 'Go to Help Web Page'
      URL = 'http://www.xilytix.com/FieldedText/Editor/HtmlHelp'
      Category = 'Help'
    end
  end
end
