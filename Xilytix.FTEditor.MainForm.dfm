object MainForm: TMainForm
  Left = 368
  Top = 60
  Hint = 'Open|Opens an existing Meta file'
  ActiveControl = AutoParseCheckBox
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
  OldCreateOrder = True
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MouseOverPanelSplitter: TSplitter
    Left = 0
    Top = 89
    Width = 891
    Height = 3
    Cursor = crVSplit
    Align = alTop
    AutoSnap = False
    MinSize = 15
    ResizeStyle = rsUpdate
    OnMoved = MouseOverPanelSplitterMoved
    ExplicitWidth = 404
  end
  object MainMenuPanel: TPanel
    Left = 0
    Top = 0
    Width = 891
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      891
      22)
    object Label1: TLabel
      Left = 135
      Top = 4
      Width = 33
      Height = 13
      Caption = '&Layout'
      FocusControl = LayoutConfigurationsComboBox
    end
    object StatusBar: TStatusBar
      Left = 560
      Top = -1
      Width = 329
      Height = 22
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
      OnHint = StatusBarHint
      OnDrawPanel = StatusBarDrawPanel
    end
    object ConfigureLayoutButton: TButton
      Left = 305
      Top = 3
      Width = 51
      Height = 17
      Caption = '&Configure'
      TabOrder = 2
      OnClick = ConfigureLayoutButtonClick
    end
    object LayoutConfigurationsComboBox: TComboBox
      Left = 171
      Top = -1
      Width = 131
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = LayoutConfigurationsComboBoxChange
    end
    object ActionMainMenuBar: TActionMainMenuBar
      Left = -1
      Top = -1
      Width = 121
      Height = 22
      UseSystemFont = False
      ActionManager = ActionManager
      Align = alNone
      Caption = 'ActionMainMenuBar'
      ColorMap.HighlightColor = clWhite
      ColorMap.BtnSelectedColor = clBtnFace
      ColorMap.UnusedColor = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Spacing = 0
    end
    object AutoParseCheckBox: TCheckBox
      Left = 369
      Top = 3
      Width = 73
      Height = 17
      Caption = 'Auto &Parse'
      TabOrder = 4
      OnClick = AutoParseCheckBoxClick
    end
    object AutoGenerateCheckBox: TCheckBox
      Left = 452
      Top = 3
      Width = 93
      Height = 17
      Caption = 'Auto &Generate'
      TabOrder = 5
      OnClick = AutoGenerateCheckBoxClick
    end
  end
  object MouseOverPanel: TFlowPanel
    Left = 0
    Top = 22
    Width = 891
    Height = 67
    Align = alTop
    BevelEdges = [beTop, beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    FullRepaint = False
    TabOrder = 1
    object MouseOverLineNrPanel: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 1
      Width = 76
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 33
        Height = 13
        Caption = 'Line Nr'
        FocusControl = MouseOverLineNrEdit
      end
      object MouseOverLineNrEdit: TEdit
        Left = 35
        Top = 0
        Width = 41
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object MouseOverLinePosPanel: TPanel
      AlignWithMargins = True
      Left = 88
      Top = 1
      Width = 82
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 39
        Height = 13
        Caption = 'Line Pos'
        FocusControl = MouseOverLinePosEdit
      end
      object MouseOverLinePosEdit: TEdit
        Left = 41
        Top = 0
        Width = 41
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object MouseOverFilePosPanel: TPanel
      AlignWithMargins = True
      Left = 178
      Top = 1
      Width = 79
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 2
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 36
        Height = 13
        Caption = 'File Pos'
        FocusControl = MouseOverFilePosEdit
      end
      object MouseOverFilePosEdit: TEdit
        Left = 38
        Top = 0
        Width = 41
        Height = 13
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 0
      end
    end
    object MouseOverRecordNrPanel: TPanel
      AlignWithMargins = True
      Left = 265
      Top = 1
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
      object Label12: TLabel
        Left = 0
        Top = 0
        Width = 48
        Height = 13
        Caption = 'Record Nr'
        FocusControl = MouseOverRecordNrEdit
      end
      object MouseOverRecordNrEdit: TEdit
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
    object MouseOverFieldPosPanel: TPanel
      AlignWithMargins = True
      Left = 393
      Top = 1
      Width = 87
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 6
      object Label8: TLabel
        Left = 0
        Top = 0
        Width = 42
        Height = 13
        Caption = 'Field Pos'
        FocusControl = MouseOverFieldPosEdit
      end
      object MouseOverFieldPosEdit: TEdit
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
    object MouseOverFieldNamePanel: TPanel
      AlignWithMargins = True
      Left = 488
      Top = 1
      Width = 132
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      object Label5: TLabel
        Left = 0
        Top = 0
        Width = 52
        Height = 13
        Caption = 'Field Name'
        FocusControl = MouseOverFieldNameEdit
      end
      object MouseOverFieldNameEdit: TEdit
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
    object MouseOverFieldIndexPanel: TPanel
      AlignWithMargins = True
      Left = 628
      Top = 1
      Width = 96
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 4
      object Label6: TLabel
        Left = 0
        Top = 0
        Width = 53
        Height = 13
        Caption = 'Field Index'
        FocusControl = MouseOverFieldIndexEdit
      end
      object MouseOverFieldIndexEdit: TEdit
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
    object MouseOverFieldValuePanel: TPanel
      AlignWithMargins = True
      Left = 732
      Top = 1
      Width = 124
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 5
      object Label7: TLabel
        Left = 0
        Top = 0
        Width = 51
        Height = 13
        Caption = 'Field Value'
        FocusControl = MouseOverFieldValueEdit
      end
      object MouseOverFieldValueEdit: TEdit
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
    object MouseOverTableNrPanel: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 16
      Width = 83
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 11
      object Label13: TLabel
        Left = 0
        Top = 0
        Width = 40
        Height = 13
        Caption = 'Table Nr'
        FocusControl = MouseOverTableNrEdit
      end
      object MouseOverTableNrEdit: TEdit
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
    object MouseOverSeqNamePanel: TPanel
      AlignWithMargins = True
      Left = 95
      Top = 16
      Width = 128
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 7
      object Label9: TLabel
        Left = 0
        Top = 0
        Width = 48
        Height = 13
        Caption = 'Seq Name'
        FocusControl = MouseOverSeqNameEdit
      end
      object MouseOverSeqNameEdit: TEdit
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
    object MouseOverItemIndexPanel: TPanel
      AlignWithMargins = True
      Left = 231
      Top = 16
      Width = 96
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 8
      object Label10: TLabel
        Left = 0
        Top = 0
        Width = 53
        Height = 13
        Caption = 'Item Index'
        FocusControl = MouseOverItemIndexEdit
      end
      object MouseOverItemIndexEdit: TEdit
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
    object MouseOverFieldTextPanel: TPanel
      AlignWithMargins = True
      Left = 335
      Top = 16
      Width = 120
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 9
      object Label11: TLabel
        Left = 0
        Top = 0
        Width = 47
        Height = 13
        Caption = 'Field Text'
        FocusControl = MouseOverFieldTextEdit
      end
      object MouseOverFieldTextEdit: TEdit
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
    object MouseOverFieldHeadingPanel: TPanel
      AlignWithMargins = True
      Left = 463
      Top = 16
      Width = 137
      Height = 13
      Margins.Left = 4
      Margins.Top = 1
      Margins.Right = 4
      Margins.Bottom = 1
      AutoSize = True
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 12
      object Label14: TLabel
        Left = 0
        Top = 0
        Width = 64
        Height = 13
        Caption = 'Field Heading'
        FocusControl = MouseOverFieldHeadingEdit
      end
      object MouseOverFieldHeadingEdit: TEdit
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
  object ActionManager: TActionManager
    ActionBars = <
      item
      end
      item
      end
      item
      end
      item
        Items = <
          item
            Items = <
              item
                Action = NewTextAction
              end
              item
                Action = OpenTextAction
                ImageIndex = 7
                ShortCut = 16463
              end
              item
                Action = SaveTextAction
              end
              item
                Action = SaveTextAsAction
                ImageIndex = 30
              end
              item
                Caption = '-'
              end
              item
                Action = ResetMetaAction
              end
              item
                Action = OpenMetaAction
                ImageIndex = 7
              end
              item
                Action = SaveMetaToReferenceAction
                Caption = 'Sa&ve Meta To Reference'
              end
              item
                Action = SaveMetaAsAction
                ImageIndex = 30
              end
              item
                Caption = '-'
              end
              item
                Action = ExitAction
                ImageIndex = 43
              end>
            Caption = '&File'
          end
          item
            Items = <
              item
                Action = CutAction
                ImageIndex = 0
                ShortCut = 16472
              end
              item
                Action = CopyAction
                ImageIndex = 1
                ShortCut = 16451
              end
              item
                Action = EditPaste1
                ImageIndex = 2
                ShortCut = 16470
              end
              item
                Action = EditSelectAll1
                ShortCut = 16449
              end>
            Caption = 'E&dit'
          end
          item
            Items = <
              item
                Action = CutAction
                ImageIndex = 0
                ShortCut = 16472
              end
              item
                Action = CopyAction
                ImageIndex = 1
                ShortCut = 16451
              end>
            Caption = '&Edit'
          end>
      end
      item
      end
      item
        Items = <
          item
            Items = <
              item
                Action = NewTextAction
              end
              item
                Action = OpenTextAction
                ImageIndex = 7
                ShortCut = 16463
              end
              item
                Action = OpenTextFromUrlAction
              end
              item
                Action = SaveTextAction
              end
              item
                Action = SaveTextAsAction
                ImageIndex = 30
              end
              item
                Caption = '-'
              end
              item
                Action = GenerateAction
              end
              item
                Action = GenerateAsAction
                ImageIndex = 30
              end
              item
                Caption = '-'
              end
              item
                Action = ResetMetaAction
              end
              item
                Action = OpenMetaAction
                ImageIndex = 7
              end
              item
                Action = OpenMetaFromUrlAction
              end
              item
                Action = SaveMetaAction
                ShortCut = 49238
              end
              item
                Action = SaveMetaToReferenceAction
                Caption = 'Save Meta To Re&ference'
              end
              item
                Action = SaveMetaAsAction
                ImageIndex = 30
              end
              item
                Caption = '-'
              end
              item
                Action = ExitAction
                ImageIndex = 43
              end>
            Caption = '&File'
          end
          item
            Items = <
              item
                Action = CutAction
                ImageIndex = 0
                ShortCut = 16472
              end
              item
                Action = CopyAction
                ImageIndex = 1
                ShortCut = 16451
              end
              item
                Action = EditPaste1
                ImageIndex = 2
                ShortCut = 16470
              end
              item
                Action = EditSelectAll1
                ShortCut = 16449
              end>
            Caption = '&Edit'
          end
          item
            Items = <
              item
                Action = MouseOverPanelVisibleAction
                Caption = '&Mouse Over Toolbar Visible'
              end
              item
                Caption = '-'
              end
              item
                Action = OptionsAction
              end
              item
                Action = CustomizeActionBarsAction
              end>
            Caption = '&Tools'
          end
          item
            Items = <
              item
                Action = HelpAction
              end
              item
                Action = AboutAction
              end>
            Caption = '&Help'
          end>
        ActionBar = ActionMainMenuBar
      end>
    Left = 40
    Top = 104
    StyleName = 'XP Style'
    object NewTextAction: TAction
      Category = 'File'
      Caption = '&New Text'
      OnExecute = NewTextActionExecute
    end
    object OpenTextAction: TFileOpen
      Category = 'File'
      Caption = '&Open Text ...'
      Dialog.DefaultExt = 'ftx'
      Dialog.Filter = 
        'Text Files|*.txt; *.ftx; *.csv|Fielded Text Files (*.ftx)|*.ftx|' +
        'All Files|*.*'
      Hint = 'Open|Opens an existing text file'
      ImageIndex = 7
      ShortCut = 16463
      OnAccept = OpenTextActionAccept
    end
    object OpenTextFromUrlAction: TAction
      Category = 'File'
      Caption = 'Open Text from &URL ...'
      OnExecute = OpenTextFromUrlActionExecute
    end
    object SaveTextAction: TAction
      Category = 'File'
      Caption = '&Save Text'
      OnExecute = SaveTextActionExecute
      OnUpdate = SaveTextActionUpdate
    end
    object SaveTextAsAction: TFileSaveAs
      Category = 'File'
      Caption = 'Save Text &As ...'
      Dialog.Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 30
      OnAccept = SaveTextAsActionAccept
    end
    object GenerateAction: TAction
      Category = 'File'
      Caption = '&Generate'
      OnExecute = GenerateActionExecute
      OnUpdate = GenerateActionUpdate
    end
    object GenerateAsAction: TFileSaveAs
      Category = 'File'
      Caption = 'G&enerate As ...'
      Hint = 'Generate and save to specified file'
      ImageIndex = 30
      OnAccept = GenerateAsActionAccept
    end
    object ResetMetaAction: TAction
      Category = 'File'
      Caption = '&Reset Meta'
      OnExecute = ResetMetaActionExecute
    end
    object OpenMetaAction: TFileOpen
      Category = 'File'
      Caption = 'Open &Meta ...'
      Dialog.Filter = 'FieldedText Meta File|*.ftm|XML File|*.xml|All Files|*.*'
      Dialog.Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofCreatePrompt, ofEnableSizing]
      Hint = 'Open|Opens an existing Meta file'
      ImageIndex = 7
      OnAccept = OpenMetaActionAccept
    end
    object OpenMetaFromUrlAction: TAction
      Category = 'File'
      Caption = 'Open Meta from UR&L ...'
      OnExecute = OpenMetaFromUrlActionExecute
    end
    object SaveMetaAction: TAction
      Category = 'File'
      Caption = 'Sa&ve Meta'
      ShortCut = 49238
      OnExecute = SaveMetaActionExecute
      OnUpdate = SaveMetaActionUpdate
    end
    object SaveMetaToReferenceAction: TAction
      Category = 'File'
      Caption = 'Save M&eta To &Reference'
      OnExecute = SaveMetaToReferenceActionExecute
      OnUpdate = SaveMetaToReferenceActionUpdate
    end
    object SaveMetaAsAction: TFileSaveAs
      Category = 'File'
      Caption = 'Save Me&ta As ...'
      Dialog.DefaultExt = 'ftm'
      Dialog.Filter = 
        'Fielded Text Meta File (*.ftm)|*.ftm|XML File (*.xml)|*.xml|All ' +
        'Files|*.*'
      Dialog.Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
      Hint = 'Save As|Saves Meta with a new file name'
      ImageIndex = 30
      OnAccept = SaveMetaAsActionAccept
    end
    object ExitAction: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
    end
    object CutAction: TEditCut
      Category = 'Edit'
      Caption = 'Cu&t'
      Hint = 'Cut|Cuts the selection and puts it on the Clipboard'
      ImageIndex = 0
      ShortCut = 16472
    end
    object CopyAction: TEditCopy
      Category = 'Edit'
      Caption = '&Copy'
      Hint = 'Copy|Copies the selection and puts it on the Clipboard'
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditPaste1: TEditPaste
      Category = 'Edit'
      Caption = '&Paste'
      Hint = 'Paste|Inserts Clipboard contents'
      ImageIndex = 2
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Edit'
      Caption = 'Select &All'
      Hint = 'Select All|Selects the entire document'
      ShortCut = 16449
    end
    object OptionsAction: TAction
      Category = 'Tools'
      Caption = '&Options'
      OnExecute = OptionsActionExecute
    end
    object CustomizeActionBarsAction: TCustomizeActionBars
      Category = 'Tools'
      Caption = '&Customize'
      CustomizeDlg.StayOnTop = False
    end
    object AboutAction: TAction
      Category = 'Help'
      Caption = '&About'
      OnExecute = AboutActionExecute
    end
    object MouseOverPanelVisibleAction: TAction
      Category = 'Tools'
      AutoCheck = True
      Caption = 'Mouse Over Toolbar Visible'
      OnExecute = MouseOverPanelVisibleActionExecute
      OnUpdate = MouseOverPanelVisibleActionUpdate
    end
    object HelpAction: TBrowseURL
      Category = 'Help'
      Caption = '&Help'
      Hint = 'Go to Help Web Page'
      URL = 'http://www.xilytix.com/FieldedText/Editor/HtmlHelp'
    end
  end
end
