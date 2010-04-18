// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Xilytix.FTEditor.TextViewFrame, Menus, ComCtrls,
  ToolWin, ActnMan, ActnCtrls, ActnMenus,
  ActnList, XPStyleActnCtrls, StdCtrls, ExtCtrls,
  Xilytix.FTEditor.Configuration,
  Xilytix.FTEditor.LayoutConfiguration,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.LayoutableFrame,
  Xilytix.FTEditor.SourceFrame,
  Xilytix.FTEditor.LayoutFrame, StdActns, BandActn,
  Xilytix.FTEditor.CommandLineParser, ExtActns;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    ActionManager: TActionManager;
    NewTextAction: TAction;
    MainMenuPanel: TPanel;
    Label1: TLabel;
    LayoutConfigurationsComboBox: TComboBoxEx;
    ConfigureLayoutButton: TButton;
    OpenTextAction: TFileOpen;
    SaveTextAction: TAction;
    SaveTextAsAction: TFileSaveAs;
    ResetMetaAction: TAction;
    OpenMetaAction: TFileOpen;
    SaveMetaToReferenceAction: TAction;
    SaveMetaAsAction: TFileSaveAs;
    ExitAction: TFileExit;
    CutAction: TEditCut;
    CopyAction: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    ActionMainMenuBar: TActionMainMenuBar;
    CustomizeActionBarsAction: TCustomizeActionBars;
    OptionsAction: TAction;
    AboutAction: TAction;
    OpenTextFromUrlAction: TAction;
    OpenMetaFromUrlAction: TAction;
    AutoParseCheckBox: TCheckBox;
    AutoGenerateCheckBox: TCheckBox;
    MouseOverPanel: TFlowPanel;
    MouseOverLineNrPanel: TPanel;
    Label2: TLabel;
    MouseOverLineNrEdit: TEdit;
    MouseOverLinePosPanel: TPanel;
    Label3: TLabel;
    MouseOverLinePosEdit: TEdit;
    MouseOverFilePosPanel: TPanel;
    Label4: TLabel;
    MouseOverFilePosEdit: TEdit;
    MouseOverFieldNamePanel: TPanel;
    Label5: TLabel;
    MouseOverFieldNameEdit: TEdit;
    MouseOverFieldIndexPanel: TPanel;
    Label6: TLabel;
    MouseOverFieldIndexEdit: TEdit;
    MouseOverFieldValuePanel: TPanel;
    Label7: TLabel;
    MouseOverFieldValueEdit: TEdit;
    MouseOverFieldPosPanel: TPanel;
    Label8: TLabel;
    MouseOverFieldPosEdit: TEdit;
    MouseOverSeqNamePanel: TPanel;
    Label9: TLabel;
    MouseOverSeqNameEdit: TEdit;
    MouseOverItemIndexPanel: TPanel;
    Label10: TLabel;
    MouseOverItemIndexEdit: TEdit;
    MouseOverFieldTextPanel: TPanel;
    Label11: TLabel;
    MouseOverFieldTextEdit: TEdit;
    MouseOverPanelVisibleAction: TAction;
    MouseOverRecordNrPanel: TPanel;
    Label12: TLabel;
    MouseOverRecordNrEdit: TEdit;
    MouseOverTableNrPanel: TPanel;
    Label13: TLabel;
    MouseOverTableNrEdit: TEdit;
    MouseOverPanelSplitter: TSplitter;
    MouseOverFieldHeadingPanel: TPanel;
    Label14: TLabel;
    MouseOverFieldHeadingEdit: TEdit;
    GenerateAction: TAction;
    GenerateAsAction: TFileSaveAs;
    HelpAction: TBrowseURL;
    procedure FormCreate(Sender: TObject);
    procedure ConfigureLayoutButtonClick(Sender: TObject);
    procedure LayoutConfigurationsComboBoxChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OptionsActionExecute(Sender: TObject);
    procedure ResetMetaActionExecute(Sender: TObject);
    procedure OpenMetaActionAccept(Sender: TObject);
    procedure SaveMetaAsActionAccept(Sender: TObject);
    procedure SaveMetaToReferenceActionExecute(Sender: TObject);
    procedure SaveMetaToReferenceActionUpdate(Sender: TObject);
    procedure OpenMetaFromUrlActionExecute(Sender: TObject);
    procedure NewTextActionExecute(Sender: TObject);
    procedure OpenTextActionAccept(Sender: TObject);
    procedure OpenTextFromUrlActionExecute(Sender: TObject);
    procedure SaveTextActionExecute(Sender: TObject);
    procedure SaveTextAsActionAccept(Sender: TObject);
    procedure SaveTextActionUpdate(Sender: TObject);
    procedure AutoParseCheckBoxClick(Sender: TObject);
    procedure AutoGenerateCheckBoxClick(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; Rect: TRect);
    procedure FormShow(Sender: TObject);
    procedure StatusBarHint(Sender: TObject);
    procedure MouseOverPanelVisibleActionExecute(Sender: TObject);
    procedure MouseOverPanelVisibleActionUpdate(Sender: TObject);
    procedure MouseOverPanelSplitterMoved(Sender: TObject);
    procedure GenerateActionUpdate(Sender: TObject);
    procedure GenerateActionExecute(Sender: TObject);
    procedure GenerateAsActionAccept(Sender: TObject);
    procedure AboutActionExecute(Sender: TObject);
  private
    type
      TActiveSourceSummary = (asNone, asText, asGrid, asReadOnly);

    const
//      piMetaErrors = 0;
      piSync = 0;
      piTextModified = 1;
      piMetaModified = 2;
      piSequences = 3;
      piSourceStatus = 4;
      piTextCharEncoding = 5;
      piFileName = 6;

      DefaultLayoutConfigurationName = '<Default>';

    var
      FLayoutFrame: TLayoutFrame;
      FEditEngine: TEditEngine;
      FBinder: TBinder;

      FLayoutConfigurations: TLayoutConfigurations;
      FActiveLayoutConfiguration: TLayoutConfiguration;
      FSourceFrames: TSourceFrames;

      FDoneFirstFormShow: Boolean;
      FCommandLineParser: TCommandLineParser;

      FActiveSourceSummary: TActiveSourceSummary;

    procedure HandleAddFrameEvent(sender: TLayoutFrame; frame: TLayoutableFrame; config: XmlElement);
    procedure HandleRemoveFrameEvent(sender: TLayoutFrame; frame: TLayoutableFrame);
    procedure HandleRequestActiveSourceEvent(sender: TSourceFrame);
    procedure HandleSourceModeChangeEvent(sender: TSourceFrame; oldMode: TSourceMode);
    procedure HandleErrorCountChangeEvent;
    procedure HandleTextModifiedChangeEvent;
    procedure HandleMetaModifiedChangeEvent;
    procedure HandleSynchronisedChangeEvent;
    procedure HandleSequencesChangeEvent;
    procedure HandleFieldedTextFilePathSetEvent;
    procedure HandleMouseOverChangedEvent;

    procedure HandleLayoutConfigurationChange;
    function HandleRequestNewConfigurationEvent: TLayoutConfiguration;
    procedure HandleRequestDeleteConfigurationEvent(configurationToDelete: TLayoutConfiguration);

    procedure CreateDefaultLayoutConfigurations;
    procedure SetDefaultActiveLayoutConfiguration;
    function CreateDefaultLayoutConfiguration: TLayoutConfiguration;
    function CreateCompactConfiguration: TLayoutConfiguration;
    function CreateSequencesLayoutConfiguration: TLayoutConfiguration;

    function CheckDuplicateConfigurationNameExists(aName: string): Boolean;

    procedure UpdateLayoutConfigurationsComboBox;
    procedure ConfigureLayoutFrame;
    procedure LoadComboBoxLayoutConfiguration;

    procedure SaveConfiguration(includeExplicitSizes: Boolean = True);

    procedure SetDefaultTextCharEncoding;
    procedure SetDefaultMetaCharEncoding;

    procedure OpenText(filePath: string);
    procedure OpenMeta(filePath: string);

    procedure PrepareSourceFrames;
    procedure UpdateActiveSourceSummary;
    function GetActiveSourceSummaryAsString: string;
    procedure ProcessSourceOnNewOpenText;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.IO,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.Common,
  Xilytix.FTEditor.EditData,
  Xilytix.FTEditor.EditorFrame,
  Xilytix.FTEditor.OptionsForm,
  Xilytix.FTEditor.LayoutConfigurationForm,
  Xilytix.FTEditor.UrlForm,
  Xilytix.FTEditor.AboutForm;

procedure TMainForm.AutoParseCheckBoxClick(Sender: TObject);
var
  I: Integer;
begin
  Configuration.AutoParse := AutoParseCheckBox.Checked;
  if Configuration.AutoParse then
  begin
    for I := Low(FSourceFrames) to High(FSourceFrames) do
    begin
      if FSourceFrames[I].Active then
      begin
        FSourceFrames[I].NotifyConfigurationChange;
      end;
    end;
  end;
end;

procedure TMainForm.AboutActionExecute(Sender: TObject);
var
  Form: TAboutForm;
begin
  Form := TAboutForm.Create(Self);
  try
    Form.ShowModal;
  finally
    Form.Release;
  end;
end;

procedure TMainForm.AutoGenerateCheckBoxClick(Sender: TObject);
var
  I: Integer;
begin
  Configuration.AutoGenerate := AutoGenerateCheckBox.Checked;
  if Configuration.AutoGenerate then
  begin
    for I := Low(FSourceFrames) to High(FSourceFrames) do
    begin
      if FSourceFrames[I].Active then
      begin
        FSourceFrames[I].NotifyConfigurationChange;
      end;
    end;
  end;
end;

function TMainForm.CheckDuplicateConfigurationNameExists(aName: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FLayoutConfigurations.Count - 1 do
  begin
    if (FLayoutConfigurations[I] <> FActiveLayoutConfiguration)
       and
       (System.&String.Compare(aName, FLayoutConfigurations[I].Name, True) = 0) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TMainForm.ConfigureLayoutButtonClick(Sender: TObject);
var
  Form: TLayoutConfigurationForm;
begin
  Form := TLayoutConfigurationForm.Create(nil);
  try
    Form.Configuration := FActiveLayoutConfiguration;
    Form.ConfigurationChangeEvent := HandleLayoutConfigurationChange;
    Form.CheckDuplicateConfigurationNameExistsEvent := CheckDuplicateConfigurationNameExists;
    Form.RequestNewEvent := HandleRequestNewConfigurationEvent;
    Form.RequestDeleteEvent := HandleRequestDeleteConfigurationEvent;
    if Form.ShowModal = mrOk then
    begin
      SaveConfiguration(not Form.ExplicitSizesReset);
      ConfigureLayoutFrame;
      UpdateLayoutConfigurationsComboBox;
    end;
  finally
    Form.ConfigurationChangeEvent := nil;
    Form.CheckDuplicateConfigurationNameExistsEvent := nil;
    Form.RequestNewEvent := nil;
    Form.RequestDeleteEvent := nil;
    Form.Release;
  end;
end;

procedure TMainForm.ConfigureLayoutFrame;
begin
  FBinder.ConfigurationChanged := True;
  try
    FLayoutFrame.ConfigureLayout(FActiveLayoutConfiguration);
    PrepareSourceFrames;
    UpdateActiveSourceSummary;
    FEditEngine.RefreshControls;
  finally
    FBinder.ConfigurationChanged := False;
  end;
end;

function TMainForm.CreateCompactConfiguration: TLayoutConfiguration;
begin
  Result := FLayoutConfigurations.New;
  Result.Name := '<Compact>';

  Result.LeftHalfId := TLayoutConfiguration.THalfId.lhA;
  Result.RightHalfId := TLayoutConfiguration.THalfId.lhB;
  Result.Arrangement := TLayoutConfiguration.TArrangement.la2Horizontal;

  Result.HalfA.Arrangement := TLayoutConfiguration.TArrangement.la2Vertical;
  Result.HalfA.LeftFrameTypeId := TLayoutableFrame.TTypeId.ftMainProperties;
  Result.HalfA.LeftFrameFill := False;
  Result.HalfA.MiddleFrameTypeId := TLayoutableFrame.TTypeId.ftFields;
  Result.HalfA.MiddleFrameFill := True;
  Result.HalfA.RightFrameTypeId := TLayoutableFrame.TTypeId.ftNone;
  Result.HalfA.RightFrameFill := False;
  Result.HalfA.Tabbed := True;

  Result.HalfB.Arrangement := TLayoutConfiguration.TArrangement.la2Top1Bottom;
  Result.HalfB.LeftFrameTypeId := TLayoutableFrame.TTypeId.ftTextView;
  Result.HalfB.LeftFrameFill := True;
  Result.HalfB.MiddleFrameTypeId := TLayoutableFrame.TTypeId.ftGridView;
  Result.HalfB.MiddleFrameFill := True;
  Result.HalfB.RightFrameTypeId := TLayoutableFrame.TTypeId.ftErrors;
  Result.HalfB.RightFrameFill := False;
  Result.HalfB.Tabbed := True;

  Result.Check;

  UpdateLayoutConfigurationsComboBox;
end;

function TMainForm.CreateDefaultLayoutConfiguration: TLayoutConfiguration;
begin
  Result := FLayoutConfigurations.New;
  Result.Name := DefaultLayoutConfigurationName;

  Result.LeftHalfId := TLayoutConfiguration.THalfId.lhA;
  Result.RightHalfId := TLayoutConfiguration.THalfId.lhB;
  Result.Arrangement := TLayoutConfiguration.TArrangement.la2Horizontal;

  Result.HalfA.Arrangement := TLayoutConfiguration.TArrangement.la2Vertical;
  Result.HalfA.LeftFrameTypeId := TLayoutableFrame.TTypeId.ftMainProperties;
  Result.HalfA.LeftFrameFill := False;
  Result.HalfA.MiddleFrameTypeId := TLayoutableFrame.TTypeId.ftFields;
  Result.HalfA.MiddleFrameFill := True;
  Result.HalfA.RightFrameTypeId := TLayoutableFrame.TTypeId.ftNone;
  Result.HalfA.RightFrameFill := False;

  Result.HalfB.Arrangement := TLayoutConfiguration.TArrangement.la3Vertical;
  Result.HalfB.LeftFrameTypeId := TLayoutableFrame.TTypeId.ftTextView;
  Result.HalfB.LeftFrameFill := True;
  Result.HalfB.MiddleFrameTypeId := TLayoutableFrame.TTypeId.ftGridView;
  Result.HalfB.MiddleFrameFill := True;
  Result.HalfB.RightFrameTypeId := TLayoutableFrame.TTypeId.ftErrors;
  Result.HalfB.RightFrameFill := False;

  Result.Check;

  UpdateLayoutConfigurationsComboBox;
end;

procedure TMainForm.CreateDefaultLayoutConfigurations;
var
  LayoutConfiguration: TLayoutConfiguration;
begin
  LayoutConfiguration := CreateDefaultLayoutConfiguration;
  LayoutConfiguration := CreateCompactConfiguration;
  LayoutConfiguration := CreateSequencesLayoutConfiguration;
end;

function TMainForm.CreateSequencesLayoutConfiguration: TLayoutConfiguration;
begin
  Result := FLayoutConfigurations.New;
  Result.Name := '<Sequences>';

  Result.LeftHalfId := TLayoutConfiguration.THalfId.lhA;
  Result.RightHalfId := TLayoutConfiguration.THalfId.lhB;
  Result.Arrangement := TLayoutConfiguration.TArrangement.la2Horizontal;

  Result.HalfA.Arrangement := TLayoutConfiguration.TArrangement.la3Vertical;
  Result.HalfA.LeftFrameTypeId := TLayoutableFrame.TTypeId.ftMainProperties;
  Result.HalfA.LeftFrameFill := False;
  Result.HalfA.MiddleFrameTypeId := TLayoutableFrame.TTypeId.ftFields;
  Result.HalfA.MiddleFrameFill := True;
  Result.HalfA.RightFrameTypeId := TLayoutableFrame.TTypeId.ftSequences;
  Result.HalfA.RightFrameFill := False;

  Result.HalfB.Arrangement := TLayoutConfiguration.TArrangement.la3Vertical;
  Result.HalfB.LeftFrameTypeId := TLayoutableFrame.TTypeId.ftTextView;
  Result.HalfB.LeftFrameFill := True;
  Result.HalfB.MiddleFrameTypeId := TLayoutableFrame.TTypeId.ftGridView;
  Result.HalfB.MiddleFrameFill := True;
  Result.HalfB.RightFrameTypeId := TLayoutableFrame.TTypeId.ftErrors;
  Result.HalfB.RightFrameFill := False;

  Result.Check;

  UpdateLayoutConfigurationsComboBox;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  TextFileNameFilter: string;
  MetaFileNameFilter: string;
begin
  FCommandLineParser := TCommandLineParser.Create;
  FCommandLineParser.Parse;

  Configuration := TConfiguration.Load;

  FEditEngine := TEditEngine.Create;
  Include(FEditEngine.TextModifiedChangeEvent, HandleTextModifiedChangeEvent);
  Include(FEditEngine.MetaModifiedChangeEvent, HandleMetaModifiedChangeEvent);
  Include(FEditEngine.SynchronisedChangeEvent, HandleSynchronisedChangeEvent);
  Include(FEditEngine.SequencesChangeEvent, HandleSequencesChangeEvent);
  Include(FEditEngine.FieldedTextFilePathSetEvent, HandleFieldedTextFilePathSetEvent);
  Include(FEditEngine.MouseOverChangedEvent, HandleMouseOverChangedEvent);

  FBinder := TBinder.Create(FEditEngine);
  Include(FBinder.ErrorCountChangeEvent, HandleErrorCountChangeEvent);

  Configuration.TriggerUpdatedEvent;

  AutoParseCheckBox.Checked := Configuration.AutoParse;
  AutoGenerateCheckBox.Checked := Configuration.AutoGenerate;
  MouseOverPanel.Height := Configuration.MouseOverPanelHeight;
  MouseOverPanel.Visible := Configuration.MouseOverPanelVisible;

  TextFileNameFilter := 'Text Files (*.' + TCommon.FieldedTextFileNameExtension + ', *.txt, *.csv)|' +
                        '*.' + TCommon.FieldedTextFileNameExtension + ';*.txt;*.csv|' +
                        'Fielded Text File (*.' + TCommon.FieldedTextFileNameExtension + ')|' +
                        '*.' + TCommon.FieldedTextFileNameExtension + '|' +
                        'All Files (*.*)|*.*';

  MetaFileNameFilter := 'Fielded Text Meta File (*.' + TCommon.MetaFileNameExtension + ')|' +
                        '*.' + TCommon.MetaFileNameExtension + '|' +
                        'XML File (*.xml)|*.xml|' +
                        'All Files (*.*)|*.*';

  OpenTextAction.Dialog.Filter := TextFileNameFilter;
  OpenTextAction.Dialog.DefaultExt := TCommon.FieldedTextFileNameExtension;
  SaveTextAsAction.Dialog.Filter := TextFileNameFilter;
  SaveTextAsAction.Dialog.DefaultExt := TCommon.FieldedTextFileNameExtension;

  OpenMetaAction.Dialog.Filter := MetaFileNameFilter;
  OpenMetaAction.Dialog.DefaultExt := TCommon.MetaFileNameExtension;
  SaveMetaAsAction.Dialog.Filter := MetaFileNameFilter;
  SaveMetaAsAction.Dialog.DefaultExt := TCommon.MetaFileNameExtension;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SaveConfiguration;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  ActiveLayoutConfigurationName: string;
begin
  if not FDoneFirstFormShow then
  begin
    if Configuration.MainWindowMaximised then
      WindowState := wsMaximized
    else
    begin
      WindowState := wsNormal;
      Top := Configuration.MainWindowTop;
      Left := Configuration.MainWindowLeft;
      Height := Configuration.MainWindowHeight;
      Width := Configuration.MainWindowWidth;
    end;

    FLayoutConfigurations := TLayoutConfigurations.Create;
    FLayoutConfigurations.Load(Configuration.LayoutConfigurations);
    if FLayoutConfigurations.Count = 0 then
    begin
      CreateDefaultLayoutConfigurations;
    end;

    FLayoutFrame := TLayoutFrame.Create(Self);
    FLayoutFrame.Align := alClient;
    FLayoutFrame.Parent := Self;
    Include(FLayoutFrame.AddFrameEvent, HandleAddFrameEvent);
    Include(FLayoutFrame.RemoveFrameEvent, HandleRemoveFrameEvent);


    ActiveLayoutConfigurationName := Configuration.ActiveLayoutConfigurationName;
    FActiveLayoutConfiguration := FLayoutConfigurations.Get(ActiveLayoutConfigurationName);
    UpdateLayoutConfigurationsComboBox;

    if not Assigned(FActiveLayoutConfiguration) then
    begin
      SetDefaultActiveLayoutConfiguration;
    end;

    ConfigureLayoutFrame;

    if FCommandLineParser.ErrorDescription <> '' then
      MessageDlg('Invalid Command Line: ' + FCommandLineParser.ErrorDescription, mtWarning, [mbOk], 0)
    else
    begin
      if FCommandLineParser.MetaFilePath <> '' then
      begin
        OpenMeta(FCommandLineParser.MetaFilePath);
      end;

      if FCommandLineParser.TextFilePath <> '' then
      begin
        OpenText(FCommandLineParser.TextFilePath);
      end;
    end;

    FDoneFirstFormShow := True;
  end;
end;

procedure TMainForm.GenerateActionExecute(Sender: TObject);
begin
  FEditEngine.GenerateToFile;
end;

procedure TMainForm.GenerateActionUpdate(Sender: TObject);
begin
  SaveTextAction.Enabled := FEditEngine.TextFilePath <> '';
end;

procedure TMainForm.GenerateAsActionAccept(Sender: TObject);
begin
  FEditEngine.GenerateAsToFile(GenerateAsAction.Dialog.FileName);
end;

function TMainForm.GetActiveSourceSummaryAsString: string;
begin
  case FActiveSourceSummary of
    asNone: Result := 'None';
    asText: Result := 'Text';
    asGrid: Result := 'Grid';
    asReadOnly: Result := 'ReadOnly';
    else
    begin
      Assert(False);
      Result := '';
    end;
  end;
end;

procedure TMainForm.HandleAddFrameEvent(sender: TLayoutFrame; frame: TLayoutableFrame; config: XmlElement);
begin
  TEditorFrame(frame).Prepare(FEditEngine, FBinder);

  if frame is TSourceFrame then
  begin
    Include(TSourceFrame(frame).RequestActiveSourceEvent, HandleRequestActiveSourceEvent);
    Include(TSourceFrame(frame).SourceModeChangeEvent, HandleSourceModeChangeEvent);
  end;

  if Assigned(config) then
  begin
    frame.LoadFromXml(config);
  end;
end;

procedure TMainForm.HandleErrorCountChangeEvent;
begin

end;

procedure TMainForm.HandleFieldedTextFilePathSetEvent;
begin
  StatusBar.Panels[piFileName].Text := Path.GetFileName(FEditEngine.TextFilePath);
end;

procedure TMainForm.HandleLayoutConfigurationChange;
begin
  SaveConfiguration;
  ConfigureLayoutFrame;
end;

procedure TMainForm.HandleMetaModifiedChangeEvent;
begin
  if FEditEngine.MetaModified then
    StatusBar.Panels[piMetaModified].Text := 'MMod'
  else
    StatusBar.Panels[piMetaModified].Text := '';
end;

procedure TMainForm.HandleMouseOverChangedEvent;

  procedure ClearMouseOverInfo;
  begin
    MouseOverLineNrEdit.Text := '';
    MouseOverLinePosEdit.Text := '';
    MouseOverFilePosEdit.Text := '';
    MouseOverRecordNrEdit.Text := '';
    MouseOverFieldPosEdit.Text := '';
    MouseOverFieldNameEdit.Text := '';
    MouseOverFieldIndexEdit.Text := '';
    MouseOverFieldValueEdit.Text := '';
    MouseOverTableNrEdit.Text := '';
    MouseOverSeqNameEdit.Text := '';
    MouseOverItemIndexEdit.Text := '';
    MouseOverFieldTextEdit.Text := '';
    MouseOverFieldHeadingEdit.Text := '';
  end;
var
  Cell: TCell;
  FilePos: Int64;
begin
  if not FEditEngine.Synchronised then
    ClearMouseOverInfo
  else
  begin
    Cell := FEditEngine.MouseOverCell;
    if not Assigned(Cell) then
      ClearMouseOverInfo
    else
    begin
      FilePos := Cell.FilePos;
      MouseOverLineNrEdit.Text := Cell.LineNumber.ToString;
      MouseOverLinePosEdit.Text := Cell.LinePos.ToString;
      MouseOverFilePosEdit.Text := FilePos.ToString;
      MouseOverFieldPosEdit.Text := Cell.ActiveIndex.ToString;
      MouseOverFieldValueEdit.Text := Cell.ValueAsString;
      MouseOverFieldTextEdit.Text := FEditEngine.Text.Substring(FilePos, Cell.TextLength);
      MouseOverFieldHeadingEdit.Text := FEditEngine.Heading[FEditEngine.MouseOverColIdx];
      if Cell.Row.Heading then
      begin
        MouseOverRecordNrEdit.Text := 'H' + Cell.Row.Number.ToString;
        MouseOverFieldNameEdit.Text := Cell.SequenceItem.Field.Name;
        MouseOverFieldIndexEdit.Text := Cell.SequenceItem.Field.Index.ToString;
        MouseOverTableNrEdit.Text := '';
        MouseOverSeqNameEdit.Text := Cell.SequenceItem.Owner.Name;
        MouseOverItemIndexEdit.Text := Cell.SequenceItem.Index.ToString;
      end
      else
      begin
        MouseOverRecordNrEdit.Text := Cell.Row.Number.ToString;
        MouseOverFieldNameEdit.Text := Cell.SequenceItem.Field.Name;
        MouseOverFieldIndexEdit.Text := Cell.SequenceItem.Field.Index.ToString;
        MouseOverTableNrEdit.Text := Cell.Row.TableNr.ToString;
        MouseOverSeqNameEdit.Text := Cell.SequenceItem.Owner.Name;
        MouseOverItemIndexEdit.Text := Cell.SequenceItem.Index.ToString;
      end;
    end;
  end;
end;

procedure TMainForm.HandleRemoveFrameEvent(sender: TLayoutFrame; frame: TLayoutableFrame);
begin
  TEditorFrame(frame).Unprepare;

  if frame is TSourceFrame then
  begin
    Exclude(TSourceFrame(frame).RequestActiveSourceEvent, HandleRequestActiveSourceEvent);
    Exclude(TSourceFrame(frame).SourceModeChangeEvent, HandleSourceModeChangeEvent);
  end;
end;

procedure TMainForm.HandleRequestActiveSourceEvent(sender: TSourceFrame);
var
  I: Integer;
  FoundLocked: Boolean;
begin
  FoundLocked := False;
  for I := Low(FSourceFrames) to High(FSourceFrames) do
  begin
    if (FSourceFrames[I] <> sender) and (FSourceFrames[I].SourceMode = smLatched) then
    begin
      FoundLocked := True;
      Break;
    end;
  end;

  if not FoundLocked then
  begin
    for I := Low(FSourceFrames) to High(FSourceFrames) do
    begin
      if (FSourceFrames[I] <> sender) and (FSourceFrames[I].SourceState = ssActive) then
      begin
        FSourceFrames[I].SourceState := ssSelectable
      end;
    end;

    sender.SourceState := ssActive;
  end;

  UpdateActiveSourceSummary;
end;

procedure TMainForm.HandleRequestDeleteConfigurationEvent(configurationToDelete: TLayoutConfiguration);
begin
  FLayoutConfigurations.Remove(configurationToDelete);
  UpdateLayoutConfigurationsComboBox;
end;

function TMainForm.HandleRequestNewConfigurationEvent: TLayoutConfiguration;
begin
  SaveConfiguration;
  Result := FLayoutConfigurations.New;
  FActiveLayoutConfiguration := Result;
  UpdateLayoutConfigurationsComboBox;
  LoadComboBoxLayoutConfiguration;
end;

procedure TMainForm.HandleSequencesChangeEvent;
begin
  if FEditEngine.SequenceCount > 0 then
    StatusBar.Panels[piSequences].Text := 'Seq'
  else
    StatusBar.Panels[piSequences].Text := '';
end;

procedure TMainForm.HandleSourceModeChangeEvent(sender: TSourceFrame; oldMode: TSourceMode);

  procedure ResetOtherSourceFrames;
  var
    I: Integer;
  begin
    for I := Low(FSourceFrames) to High(FSourceFrames) do
    begin
      if FSourceFrames[I] <> sender then
      begin
        case FSourceFrames[I].SourceMode of
          smSelectable: FSourceFrames[I].SourceState := ssSelectable;
          smLatched:
          begin
            FSourceFrames[I].SourceState := ssSelectable;
            FSourceFrames[I].SourceMode := smSelectable;
          end;
          smReadOnly: FSourceFrames[I].SourceState := ssReadOnly;
          else Assert(False);
        end;
      end;
    end;
  end;

  procedure ActivateSourceFrameIfNoneActive;
  var
    I: Integer;
    OtherFrameActive: Boolean;
  begin
    OtherFrameActive := False;
    for I := Low(FSourceFrames) to High(FSourceFrames) do
    begin
      if (FSourceFrames[I] <> sender)
         and
         (FSourceFrames[I].SourceState = ssActive) then
      begin
        OtherFrameActive := True;
        Break;
      end;
    end;

    if not OtherFrameActive then
    begin
      sender.SourceState := ssActive;
    end;
  end;

  procedure UnlatchOtherSourceFramesAndSetReadOnlyState;
  var
    I: Integer;
  begin
    for I := Low(FSourceFrames) to High(FSourceFrames) do
    begin
      if FSourceFrames[I] <> sender then
      begin
        if FSourceFrames[I].SourceMode = smLatched then
        begin
          FSourceFrames[I].SourceMode := smSelectable;
        end;
        FSourceFrames[I].SourceState := ssReadOnly;
      end;
    end;
  end;

  function IsOtherFrameLatched: Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := Low(FSourceFrames) to High(FSourceFrames) do
    begin
      if (FSourceFrames[I] <> sender) and (FSourceFrames[I].SourceMode = smLatched) then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

var
  NewMode: TSourceMode;
begin
  NewMode := sender.SourceMode;

  case NewMode of
    smSelectable:
    begin
      if oldMode = smLatched then
      begin
        ResetOtherSourceFrames;
        sender.SourceState := ssActive;
      end
      else
      begin
        if IsOtherFrameLatched then
          sender.SourceState := ssReadOnly
        else
        begin
          sender.SourceState := ssSelectable;
          ActivateSourceFrameIfNoneActive;
        end;
      end;
    end;
    smLatched:
    begin
      UnlatchOtherSourceFramesAndSetReadOnlyState;
      sender.SourceState := ssActive;
    end;
    smReadOnly:
    begin
      sender.SourceState := ssReadOnly;
    end;
    else
    begin
      Assert(False);
    end;
  end;

  UpdateActiveSourceSummary;
end;

procedure TMainForm.HandleSynchronisedChangeEvent;
begin
  if FEditEngine.Synchronised then
    StatusBar.Panels[piSync].Text := 'Sync'
  else
    StatusBar.Panels[piSync].Text := '';
end;

procedure TMainForm.HandleTextModifiedChangeEvent;
begin
  if FEditEngine.TextModified then
    StatusBar.Panels[piTextModified].Text := 'TMod'
  else
    StatusBar.Panels[piTextModified].Text := '';
end;

procedure TMainForm.LayoutConfigurationsComboBoxChange(Sender: TObject);
begin
  SaveConfiguration;
  LoadComboBoxLayoutConfiguration;
end;

procedure TMainForm.LoadComboBoxLayoutConfiguration;
var
  ItemIndex: Integer;
begin
  ItemIndex := LayoutConfigurationsComboBox.ItemIndex;
  FActiveLayoutConfiguration := LayoutConfigurationsComboBox.ItemsEx[ItemIndex].Data as TLayoutConfiguration;
  ConfigureLayoutFrame;
end;

procedure TMainForm.MouseOverPanelSplitterMoved(Sender: TObject);
begin
  Configuration.MouseOverPanelHeight := MouseOverPanel.Height;
  SaveConfiguration;
end;

procedure TMainForm.MouseOverPanelVisibleActionExecute(Sender: TObject);
begin
  MouseOverPanel.Visible := MouseOverPanelVisibleAction.Checked;
  MouseOverPanelSplitter.Visible := MouseOverPanel.Visible;
  if MouseOverPanel.Height < Configuration.MinMouseOverPanelHeight then
  begin
    MouseOverPanel.Height := Configuration.MinMouseOverPanelHeight;
  end;
  Configuration.MouseOverPanelVisible := MouseOverPanel.Visible;
  SaveConfiguration;
end;

procedure TMainForm.MouseOverPanelVisibleActionUpdate(Sender: TObject);
begin
  MouseOverPanelVisibleAction.Checked := MouseOverPanel.Visible;
end;

procedure TMainForm.NewTextActionExecute(Sender: TObject);
begin
  SetDefaultTextCharEncoding;
  FEditEngine.NewText;
  StatusBar.Panels[piTextCharEncoding].Text := FEditEngine.TextCharEncodingName;
  ProcessSourceOnNewOpenText;
end;

procedure TMainForm.OpenMeta(filePath: string);
begin
  SetDefaultMetaCharEncoding;

  try
    FEditEngine.OpenMeta(filePath);
  except
    on E: EFieldedText do
    begin
      if E.ErrorCode <> ftecMetaLoad then
        raise
      else
        MessageDlg('Error Loading Meta File "' + FilePath + '"'#13 + FEditEngine.MetaLoadErrorDescription,
                   mtError, [mbOk], 0);
    end;
  end;
end;

procedure TMainForm.OpenMetaActionAccept(Sender: TObject);
begin
  OpenMeta(OpenMetaAction.Dialog.FileName);
end;

procedure TMainForm.OpenMetaFromUrlActionExecute(Sender: TObject);
var
  UrlForm: TUrlForm;
begin
  UrlForm := TUrlForm.Create(Self);
  try
    if UrlForm.ShowModal = mrOk then
    begin
      SetDefaultMetaCharEncoding;

      FEditEngine.OpenMetaFromUrl(UrlForm.Url);
    end;
  finally
    UrlForm.Free;
  end;
end;

procedure TMainForm.OpenText(filePath: string);
var
  ErrorDescription: string;
begin
  SetDefaultTextCharEncoding;

  if not FEditEngine.OpenText(FilePath, ErrorDescription) then
    MessageDlg('Error opening file "' + FilePath + '"'#13 + ErrorDescription, mtError, [mbOk], 0)
  else
  begin
    StatusBar.Panels[piTextCharEncoding].Text := FEditEngine.TextCharEncodingName;
    ProcessSourceOnNewOpenText;
  end;
end;

procedure TMainForm.OpenTextActionAccept(Sender: TObject);
begin
  OpenText(OpenTextAction.Dialog.FileName);
end;

procedure TMainForm.OpenTextFromUrlActionExecute(Sender: TObject);
var
  UrlForm: TUrlForm;
begin
  UrlForm := TUrlForm.Create(Self);
  try
    if UrlForm.ShowModal = mrOk then
    begin
      SetDefaultTextCharEncoding;

      FEditEngine.OpenTextFromUrl(UrlForm.Url);
      StatusBar.Panels[piTextCharEncoding].Text := FEditEngine.TextCharEncodingName;
      ProcessSourceOnNewOpenText;
    end;
  finally
    UrlForm.Free;
  end;
end;

procedure TMainForm.OptionsActionExecute(Sender: TObject);
var
  Form: TOptionsForm;
  I: Integer;
begin
  Form := TOptionsForm.Create(Self);
  try
    if Form.ShowModal = mrOk then
    begin
      SaveConfiguration;

      FBinder.ConfigurationChanged := True;
      try
        FEditEngine.UpdateDisplayCulture;

        for I := 0 to FLayoutFrame.LayoutableFrameCount - 1 do
        begin
          TEditorFrame(FLayoutFrame.LayoutableFrames[I]).NotifyConfigurationChange;
        end;
        FEditEngine.RefreshControls;
      finally
        FBinder.ConfigurationChanged := False;
      end;
    end;

  finally
    Form.Release;
  end;
end;

procedure TMainForm.PrepareSourceFrames;
var
  I, Idx: Integer;
begin
  FSourceFrames := nil;
  for I := 0 to FLayoutFrame.LayoutableFrameCount-1 do
  begin
    if FLayoutFrame.LayoutableFrames[I] is TSourceFrame then
    begin
      Idx := Length(FSourceFrames);
      SetLength(FSourceFrames, Idx+1);
      FSourceFrames[Idx] := FLayoutFrame.LayoutableFrames[I] as TSourceFrame;
    end;
  end;
end;

procedure TMainForm.ProcessSourceOnNewOpenText;

  function ResetSourceStates: Integer;
  var
    I: Integer;
    LatchedFound: Boolean;
  begin
    Result := 0;
    LatchedFound := False;
    for I := Low(FSourceFrames) to High(FSourceFrames) do
    begin
      case FSourceFrames[I].SourceMode of
        smSelectable:
        begin
          if FSourceFrames[I].SourceState = ssActive then
            Inc(Result)
          else
            FSourceFrames[I].SourceState := ssSelectable;
        end;
        smLatched:
        begin
          if LatchedFound then
          begin
            FSourceFrames[I].SourceMode := smSelectable;
            FSourceFrames[I].SourceState := ssSelectable;
          end
          else
          begin
            FSourceFrames[I].SourceState := ssActive;
            Inc(Result);
            LatchedFound := True;
          end;
        end;
        smReadOnly: FSourceFrames[I].SourceState := ssReadOnly;
        else Assert(False);
      end;
    end;

    if LatchedFound then
    begin
      for I := Low(FSourceFrames) to High(FSourceFrames) do
      begin
        if FSourceFrames[I].SourceMode = smSelectable then
        begin
          if FSourceFrames[I].SourceState = ssActive then
          begin
            Dec(Result);
          end;
          FSourceFrames[I].SourceState := ssReadOnly; 
        end;
      end;
    end;
  end;

  procedure ActivateFrameType(typeId: TLayoutableFrame.TTypeId; latched: Boolean);
  var
    I: Integer;
    ActiveFound: Boolean;
  begin
    ActiveFound := False;
    for I := Low(FSourceFrames) to High(FSourceFrames) do
    begin
      if FSourceFrames[I].GetTypeId <> typeId then
      begin
        if FSourceFrames[I].SourceState = ssActive then
        begin
          FSourceFrames[I].SourceMode := smSelectable;
          FSourceFrames[I].SourceState := ssSelectable;
        end;
      end
      else
      begin
        if FSourceFrames[I].SourceState = ssActive then
        begin
          if ActiveFound then
          begin
            FSourceFrames[I].SourceMode := smSelectable;
            FSourceFrames[I].SourceState := ssSelectable;
          end
          else
          begin
            ActiveFound := True;
            if latched then
              FSourceFrames[I].SourceMode := smLatched
            else
              FSourceFrames[I].SourceMode := smSelectable;
          end;
        end;
      end;
    end;

    if not ActiveFound then
    begin
      for I := Low(FSourceFrames) to High(FSourceFrames) do
      begin
        if FSourceFrames[I].GetTypeId = typeId then
        begin
          if latched then
            FSourceFrames[I].SourceMode := smLatched
          else
            FSourceFrames[I].SourceMode := smSelectable;

          FSourceFrames[I].SourceState := ssActive;
        end;
      end;
    end;
  end;

  procedure SetAllReadOnly;
  var
    I: Integer;
  begin
    for I := Low(FSourceFrames) to High(FSourceFrames) do
    begin
      FSourceFrames[I].SourceMode := smReadOnly;
      FSourceFrames[I].SourceState := ssReadOnly;
    end;
  end;

var
  ActiveCount: Integer;
begin
  ActiveCount := ResetSourceStates;
  case Configuration.SourceOnNewOpenText of
    soCurrent:
    begin
      if ActiveCount <> 1 then
      begin
        ActivateFrameType(ftTextView, False);
      end;
    end;
    soReadOnly: SetAllReadOnly;
    soText: ActivateFrameType(ftTextView, False);
    soTextLocked: ActivateFrameType(ftTextView, True);
    soGrid: ActivateFrameType(ftGridView, False);
    soGridLocked: ActivateFrameType(ftGridView, True);
    else Assert(False);
  end;
end;

procedure TMainForm.ResetMetaActionExecute(Sender: TObject);
begin
  SetDefaultMetaCharEncoding;
  FEditEngine.ResetMeta;
end;

procedure TMainForm.SaveConfiguration(includeExplicitSizes: Boolean);
var
  ActiveLayoutConfigurationName: string;
  Element: XmlElement;
  FrameSlotConfigs: TLayoutConfiguration.TFrameSlotConfigs;
  ExplicitSizes: TLayoutConfiguration.TExplicitSizesRec;
  WindowStateMaximised: Boolean;
begin
  WindowStateMaximised := WindowState = wsMaximized;
  Configuration.MainWindowMaximised := WindowStateMaximised;
  if not WindowStateMaximised then
  begin
    Configuration.MainWindowTop := Top;
    Configuration.MainWindowLeft := Left;
    Configuration.MainWindowHeight := Height;
    Configuration.MainWindowWidth := Width;
  end;

  if not Assigned(FActiveLayoutConfiguration) then
    ActiveLayoutConfigurationName := ''
  else
  begin
    ActiveLayoutConfigurationName := FActiveLayoutConfiguration.Name;

    FrameSlotConfigs := FActiveLayoutConfiguration.GenerateBlankFrameSlotConfigs(Configuration.XmlElementHolder);
    FLayoutFrame.SaveFrameConfigurations(FrameSlotConfigs, ExplicitSizes);
    FActiveLayoutConfiguration.AssignFrameSlotConfigs(FrameSlotConfigs);
    if includeExplicitSizes then
    begin
      FActiveLayoutConfiguration.AssignExplicitSizes(ExplicitSizes);
    end;
  end;
  Configuration.ActiveLayoutConfigurationName := ActiveLayoutConfigurationName;

  Element := Configuration.LayoutConfigurations;
  Element.RemoveAll;
  FLayoutConfigurations.Save(Element);

  Configuration.Save;
end;

procedure TMainForm.SaveMetaAsActionAccept(Sender: TObject);
begin
  FEditEngine.SaveMetaAs(SaveMetaAsAction.Dialog.FileName);
end;

procedure TMainForm.SaveMetaToReferenceActionExecute(Sender: TObject);
begin
  FEditEngine.SaveMetaAs(FEditEngine.MetaReference);
end;

procedure TMainForm.SaveMetaToReferenceActionUpdate(Sender: TObject);
begin
  SaveMetaToReferenceAction.Enabled := (FEditEngine.MetaReferenceType = ftmrFile)
                                       and
                                       (FEditEngine.MetaReference <> '');
end;

procedure TMainForm.SaveTextActionExecute(Sender: TObject);
begin
  FEditEngine.SaveText;
end;

procedure TMainForm.SaveTextActionUpdate(Sender: TObject);
begin
  SaveTextAction.Enabled := FEditEngine.TextFilePath <> '';
end;

procedure TMainForm.SaveTextAsActionAccept(Sender: TObject);
begin
  FEditEngine.SaveTextAs(SaveTextAsAction.Dialog.FileName);
end;

procedure TMainForm.SetDefaultActiveLayoutConfiguration;
begin
  FActiveLayoutConfiguration := FLayoutConfigurations.Get(DefaultLayoutConfigurationName);
  if not Assigned(FActiveLayoutConfiguration) then
  begin
    FActiveLayoutConfiguration := CreateDefaultLayoutConfiguration;
    FLayoutConfigurations.Add(FActiveLayoutConfiguration);
  end;
  UpdateLayoutConfigurationsComboBox;
end;

procedure TMainForm.SetDefaultMetaCharEncoding;
begin
  try
    FEditEngine.MetaCharEncodingName := Configuration.DefaultMetaCharEncodingName;
  except
    FEditEngine.MetaCharEncodingName := Configuration.GetDefaultDefaultMetaCharEncodingName;
    Configuration.DefaultMetaCharEncodingName := Configuration.GetDefaultDefaultMetaCharEncodingName;
  end;
end;

procedure TMainForm.SetDefaultTextCharEncoding;
begin
  try
    FEditEngine.TextCharEncodingName := Configuration.DefaultTextCharEncodingName;
  except
    FEditEngine.TextCharEncodingName := Configuration.GetDefaultDefaultTextCharEncodingName;
    Configuration.DefaultTextCharEncodingName := Configuration.GetDefaultDefaultTextCharEncodingName;
  end;
end;

procedure TMainForm.StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; Rect: TRect);
var
  ActiveSourceSummaryAsString: string;
begin
  case Panel.Index of
//    piMetaErrors: ;
    piSync: ;
    piTextModified: ;
    piMetaModified: ;
    piSourceStatus:
    begin
      ActiveSourceSummaryAsString := GetActiveSourceSummaryAsString;
      StatusBar.Canvas.TextRect(Rect, ActiveSourceSummaryAsString);
    end;
    piSequences: ;
    piFileName: ;
    else Assert(False);
  end;
end;

procedure TMainForm.StatusBarHint(Sender: TObject);
begin
  Beep;
end;

procedure TMainForm.UpdateLayoutConfigurationsComboBox;
var
  I: Integer;
  ItemIndex: Integer;
begin
  ItemIndex := -1;
  LayoutConfigurationsComboBox.Items.Clear;
  for I := 0 to FLayoutConfigurations.Count - 1 do
  begin
    LayoutConfigurationsComboBox.ItemsEx.AddItem(FLayoutConfigurations[I].Name, -1, -1, -1, 0, FLayoutConfigurations[I]);
    if FLayoutConfigurations[I] = FActiveLayoutConfiguration then
    begin
      ItemIndex := I;
    end;
  end;

  LayoutConfigurationsComboBox.ItemIndex := ItemIndex;
end;

procedure TMainForm.UpdateActiveSourceSummary;
var
  I: Integer;
  None: Boolean;
  &ReadOnly: Boolean;
begin
  None := True;
  &ReadOnly := True;
  for I := Low(FSourceFrames) to High(FSourceFrames) do
  begin
    case FSourceFrames[I].SourceState of
      ssActive:
      begin
        None := False;
        &ReadOnly := False;
        if FSourceFrames[I].GetTypeId = ftGridView then
          FActiveSourceSummary := asGrid
        else
          FActiveSourceSummary := asText;

        Break;
      end;
      ssSelectable: &ReadOnly := False;
      ssReadOnly: ;
      else Assert(False);
    end;
  end;

  if &ReadOnly then
    FActiveSourceSummary := asReadOnly
  else
  begin
    if None then
    begin
      FActiveSourceSummary := asNone;
    end;
  end;

  StatusBar.Panels[Integer(piSourceStatus)].Text := GetActiveSourceSummaryAsString; 
end;

end.
