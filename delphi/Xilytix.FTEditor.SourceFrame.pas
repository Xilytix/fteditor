// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.SourceFrame;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Xilytix.FTEditor.TypedXml,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.EditorFrame, StdCtrls, ComCtrls, ExtCtrls;

type
  TSourceFrame = class;

  TSourceMode = (smSelectable, smLatched, smReadOnly);
  TSourceState = (ssActive, ssSelectable, ssReadOnly);

  TSourceFrame = class(TEditorFrame)
    TopFlowPanel: TFlowPanel;
    SourcePanel: TPanel;
    SourceModeComboBox: TComboBoxEx;
    CharsPanel: TPanel;
    Label2: TLabel;
    CharsEdit: TEdit;
    FilePosPanel: TPanel;
    Label5: TLabel;
    FilePosEdit: TEdit;
    LineCountPanel: TPanel;
    Label1: TLabel;
    LineCountEdit: TEdit;
    LineNrPanel: TPanel;
    Label3: TLabel;
    LineNrEdit: TEdit;
    LinePosPanel: TPanel;
    Label4: TLabel;
    LinePosEdit: TEdit;
    FieldHeadingPanel: TPanel;
    Label14: TLabel;
    FieldHeadingEdit: TEdit;
    FieldIndexPanel: TPanel;
    Label6: TLabel;
    FieldIndexEdit: TEdit;
    FieldNamePanel: TPanel;
    Label7: TLabel;
    FieldNameEdit: TEdit;
    FieldPosPanel: TPanel;
    Label8: TLabel;
    FieldPosEdit: TEdit;
    FieldTextPanel: TPanel;
    Label11: TLabel;
    FieldTextEdit: TEdit;
    FieldValuePanel: TPanel;
    Label9: TLabel;
    FieldValueEdit: TEdit;
    ItemIndexPanel: TPanel;
    Label10: TLabel;
    ItemIndexEdit: TEdit;
    RecordNrPanel: TPanel;
    Label12: TLabel;
    RecordNrEdit: TEdit;
    SeqNamePanel: TPanel;
    Label13: TLabel;
    SeqNameEdit: TEdit;
    TableNrPanel: TPanel;
    Label15: TLabel;
    TableNrEdit: TEdit;
    RecordsPanel: TPanel;
    Label16: TLabel;
    RecordsEdit: TEdit;
    procedure FrameEnter(Sender: TObject);
    procedure SourceModeComboBoxChange(Sender: TObject);
  public
    type
      TRequestActiveSourceDelegate = procedure(sender: TSourceFrame) of object;
      TSourceModeChangeDelegate = procedure(sender: TSourceFrame; oldMode: TSourceMode) of object;

  private
    type
      TRequestActiveSourceDelegates = array of TRequestActiveSourceDelegate;
      TSourceModeChangeDelegates = array of TSourceModeChangeDelegate;
    const
      MetaTag_TopFlowPanelHeight = 'TopFlowPanelHeight';
      MetaTag_SourceMode = 'SourceMode';
      MetaTag_SourceState = 'SourceState';

    var
      FSourceMode: TSourceMode;
      FSourceState: TSourceState;

      FRequestActiveSourceDelegates: TRequestActiveSourceDelegates;
      FSourceModeChangeDelegates: TSourceModeChangeDelegates;

    procedure HandleSynchronisedChangeEvent;

    procedure NotifyRequestActiveSource;
    procedure NotifySourceModeChange(oldMode: TSourceMode);

    procedure SetTopPanelColor;

    function GetActive: Boolean;
    procedure SetSourceMode(const Value: TSourceMode);
    procedure SetSourceState(const Value: TSourceState);

    function GetSourceModeAsXmlValue: string;
    function GetSourceStateAsXmlValue: string;
    procedure SetSourceModeAsXmlValue(const Value: string);
    procedure SetSourceStateAsXmlValue(const Value: string);

    property SourceModeAsXmlValue: string read GetSourceModeAsXmlValue write SetSourceModeAsXmlValue;
    property SourceStateAsXmlValue: string read GetSourceStateAsXmlValue write SetSourceStateAsXmlValue;

  protected
    procedure ProcessConfigurationChange; override;
    procedure SetActive(value: Boolean); virtual; abstract;

    procedure PopulateActiveCursorInfo(frameChanged, cellChanged: Boolean); virtual;

  public
    constructor Create(AOwner: TComponent); override;

    procedure LoadFromXml(Element: ITypedXmlElement); override;
    procedure SaveToXml(Element: ITypedXmlElement); override;

    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder); override;
    procedure Unprepare; override;

    property SourceMode: TSourceMode read FSourceMode write SetSourceMode;
    property SourceState: TSourceState read FSourceState write SetSourceState;
    property Active: Boolean read GetActive;

    procedure SubscribeRequestActiveSourceEvent(Delegate: TRequestActiveSourceDelegate);
    procedure UnsubscribeRequestActiveSourceEvent(Delegate: TRequestActiveSourceDelegate);
    procedure SubscribeSourceModeChangeEvent(Delegate: TSourceModeChangeDelegate);
    procedure UnsubscribeSourceModeChangeEvent(Delegate: TSourceModeChangeDelegate);
  end;

  TSourceFrames = array of TSourceFrame;

implementation

{$R *.dfm}

uses
  Xilytix.FieldedText.DotNet,
  Xilytix.FieldedText.Utils,
  Xilytix.FTEditor.EditData,
  Xilytix.FTEditor.LayoutConfiguration,
  Xilytix.FTEditor.Colors,
  Xilytix.FTEditor.Configuration;

{ TSourceFrame }

constructor TSourceFrame.Create(AOwner: TComponent);
begin
  inherited;

  SourceModeComboBox.ItemsEx.AddItem('Selectable', -1, -1, -1, -1, Pointer(smSelectable));
  SourceModeComboBox.ItemsEx.AddItem('Latched', -1, -1, -1, -1, Pointer(smLatched));
  SourceModeComboBox.ItemsEx.AddItem('Read Only', -1, -1, -1, -1, Pointer(smReadOnly));

  SourceModeComboBox.ItemIndex := 0;
end;

procedure TSourceFrame.FrameEnter(Sender: TObject);
begin
  if SourceMode = smSelectable then
  begin
    NotifyRequestActiveSource;
  end;
end;

function TSourceFrame.GetActive: Boolean;
begin
  Result := FSourceState = ssActive;
end;

function TSourceFrame.GetSourceModeAsXmlValue: string;
begin
  case FSourceMode of
    smSelectable: Result := 'Selectable';
    smLatched: Result := 'Latched';
    smReadOnly: Result := 'ReadOnly';
    else
    begin
      Result := '';
      Assert(False);
    end;
  end;
end;

function TSourceFrame.GetSourceStateAsXmlValue: string;
begin
  case FSourceState of
    ssSelectable: Result := 'Selectable';
    ssActive: Result := 'Active';
    ssReadOnly: Result := 'ReadOnly';
    else
    begin
      Result := '';
      Assert(False);
    end;
  end;
end;

procedure TSourceFrame.HandleSynchronisedChangeEvent;

  procedure ClearInfo;
  begin
    LineCountEdit.Text := '';
    CharsEdit.Text := '';
    RecordsEdit.Text := '';
  end;

begin
  if not FEditEngine.Synchronised then
    ClearInfo
  else
  begin
    LineCountEdit.Text := IntToStr(FEditEngine.LineCount);
    CharsEdit.Text := IntToStr(FEditEngine.CharCount);
    RecordsEdit.Text := IntToStr(FEditEngine.RecordCount);
  end;

  PopulateActiveCursorInfo(True, True);
end;

procedure TSourceFrame.LoadFromXml(Element: ITypedXmlElement);
begin
  inherited;

  if Element.HasAttribute(MetaTag_TopFlowPanelHeight) then
  begin
    TopFlowPanel.Height := TLayoutConfiguration.XmlValueToInteger(Element.GetAttribute(MetaTag_TopFlowPanelHeight));
  end;
  if Element.HasAttribute(MetaTag_SourceMode) then
  begin
    SourceModeAsXmlValue := Element.GetAttribute(MetaTag_SourceMode);
  end;
  if Element.HasAttribute(MetaTag_SourceState) then
  begin
    SourceStateAsXmlValue := Element.GetAttribute(MetaTag_SourceState);
  end;
end;

procedure TSourceFrame.NotifyRequestActiveSource;
var
  I: Integer;
  Delegates: TRequestActiveSourceDelegates;
begin
  Delegates := Copy(FRequestActiveSourceDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
    Delegates[I](Self);
  end;
end;

procedure TSourceFrame.NotifySourceModeChange(oldMode: TSourceMode);
var
  I: Integer;
  Delegates: TSourceModeChangeDelegates;
begin
  Delegates := Copy(FSourceModeChangeDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
    Delegates[I](Self, OldMode);
  end;
end;

procedure TSourceFrame.PopulateActiveCursorInfo(frameChanged, cellChanged: Boolean);
  procedure ClearInfo;
  begin
    LineNrEdit.Text := '';
    LinePosEdit.Text := '';
    FilePosEdit.Text := '';
    RecordNrEdit.Text := '';
    FieldPosEdit.Text := '';
    FieldNameEdit.Text := '';
    FieldIndexEdit.Text := '';
    FieldValueEdit.Text := '';
    TableNrEdit.Text := '';
    SeqNameEdit.Text := '';
    ItemIndexEdit.Text := '';
    FieldTextEdit.Text := '';
    FieldHeadingEdit.Text := '';
  end;

var
  Cell: TCell;
begin
  if not FEditEngine.Synchronised then
    ClearInfo
  else
  begin
    if frameChanged or cellChanged then
    begin
      Cell := FEditEngine.CursorActiveCell;
      if not Assigned(Cell) then
        ClearInfo
      else
      begin
        FieldPosEdit.Text := IntToStr(Cell.ActiveIndex);
        FieldValueEdit.Text := Cell.ValueAsString;
        FieldTextEdit.Text := Copy(FEditEngine.Text, Cell.FilePos+1, Cell.TextLength);
        FieldHeadingEdit.Text := FEditEngine.Heading[FEditEngine.CursorActiveColIdx];
        if Cell.Row.Heading then
        begin
          RecordNrEdit.Text := 'H' + IntToStr(Cell.Row.Number);
          FieldNameEdit.Text := Cell.SequenceItem.Field.Name;
          FieldIndexEdit.Text := IntToStr(Cell.SequenceItem.Field.Index);
          TableNrEdit.Text := '';
          SeqNameEdit.Text := Cell.SequenceItem.Owner.Name;
          ItemIndexEdit.Text := IntToStr(Cell.SequenceItem.Index);
        end
        else
        begin
          RecordNrEdit.Text := IntToStr(Cell.Row.Number);
          FieldNameEdit.Text := Cell.SequenceItem.Field.Name;
          FieldIndexEdit.Text := IntToStr(Cell.SequenceItem.Field.Index);
          TableNrEdit.Text := IntToStr(Cell.Row.TableNr);
          SeqNameEdit.Text := Cell.SequenceItem.Owner.Name;
          ItemIndexEdit.Text := IntToStr(Cell.SequenceItem.Index);
        end;
      end;
    end;
  end;
end;

procedure TSourceFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
begin
  inherited;
  FEditEngine.SubscribeSynchronisedChangeEvent(HandleSynchronisedChangeEvent);
end;

procedure TSourceFrame.ProcessConfigurationChange;
begin
  inherited;

  SetTopPanelColor;
end;

procedure TSourceFrame.SaveToXml(Element: ITypedXmlElement);
begin
  inherited;

  Element.SetAttribute(MetaTag_TopFlowPanelHeight, TLayoutConfiguration.IntegerToXmlValue(TopFlowPanel.Height));
  Element.SetAttribute(MetaTag_SourceMode, SourceModeAsXmlValue);
  Element.SetAttribute(MetaTag_SourceState, SourceStateAsXmlValue);
end;

procedure TSourceFrame.SetSourceMode(const Value: TSourceMode);
var
  I, Idx: Integer;
begin
  FSourceMode := Value;

  Idx := -1;
  for I := 0 to SourceModeComboBox.ItemsEx.Count do
  begin
    if TSourceMode(SourceModeComboBox.ItemsEx[I].Data) = FSourceMode then
    begin
      Idx := I;
      Break;
    end;
  end;

  SourceModeComboBox.ItemIndex := Idx;
end;

procedure TSourceFrame.SetSourceModeAsXmlValue(const Value: string);
begin
  if TFieldedTextLocaleSettings.Invariant.SameString(Value, 'Latched', True) then
    SourceMode := smLatched
  else
  begin
    if TFieldedTextLocaleSettings.Invariant.SameString(Value, 'ReadOnly', True) then
      SourceMode := smReadOnly
    else
      SourceMode := smSelectable;
  end;
end;

procedure TSourceFrame.SetSourceState(const Value: TSourceState);
begin
  FSourceState := Value;
  case FSourceState of
    ssActive: SetActive(True);
    ssSelectable, ssReadOnly: SetActive(False);
    else Assert(False);
  end;

  SetTopPanelColor;
end;

procedure TSourceFrame.SetSourceStateAsXmlValue(const Value: string);
begin
  if TFieldedTextLocaleSettings.Invariant.SameString(Value, 'Active', True) then
    SourceState := ssActive
  else
  begin
    if TFieldedTextLocaleSettings.Invariant.SameString(Value, 'ReadOnly', True) then
      SourceState := ssReadOnly
    else
      SourceState := ssSelectable;
  end;
end;

procedure TSourceFrame.SetTopPanelColor;
var
  ResolvedColorId: TResolvedColorId;
begin
  case FSourceState of
    ssActive: ResolvedColorId := rcActiveFrameHeader;
    ssSelectable: ResolvedColorId := rcSelectableFrameHeader;
    ssReadOnly: ResolvedColorId := rcReadOnlyFrameHeader;
    else
    begin
      ResolvedColorId := rcReadOnlyFrameHeader;
      Assert(False);
    end;
  end;

  TopFlowPanel.Color := Configuration.Colors[ResolvedColorId].Background;
end;

procedure TSourceFrame.SourceModeComboBoxChange(Sender: TObject);
var
  OldMode: TSourceMode;
begin
  OldMode := FSourceMode;
  FSourceMode := TSourceMode(SourceModeComboBox.ItemsEx[SourceModeComboBox.ItemIndex].Data);
  NotifySourceModeChange(OldMode);
end;

procedure TSourceFrame.SubscribeRequestActiveSourceEvent(
  Delegate: TRequestActiveSourceDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FRequestActiveSourceDelegates);
  SetLength(FRequestActiveSourceDelegates, Idx + 1);
  FRequestActiveSourceDelegates[Idx] := Delegate;
end;

procedure TSourceFrame.SubscribeSourceModeChangeEvent(
  Delegate: TSourceModeChangeDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FSourceModeChangeDelegates);
  SetLength(FSourceModeChangeDelegates, Idx + 1);
  FSourceModeChangeDelegates[Idx] := Delegate;
end;

procedure TSourceFrame.Unprepare;
begin
  FEditEngine.UnsubscribeSynchronisedChangeEvent(HandleSynchronisedChangeEvent);
  inherited;
end;

procedure TSourceFrame.UnsubscribeRequestActiveSourceEvent(
  Delegate: TRequestActiveSourceDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TRequestActiveSourceDelegate;
begin
  Idx := -1;
  for I := Low(FRequestActiveSourceDelegates) to High(FRequestActiveSourceDelegates) do
  begin
    ExistingDelegate := FRequestActiveSourceDelegates[I];
    if SameMethods(TMethod(ExistingDelegate), TMethod(Delegate)) then
    begin
      Idx := I;
      Break;
    end;
  end;

  if Idx < 0 then
    Assert(False)
  else
  begin
    FRequestActiveSourceDelegates[Idx] := FRequestActiveSourceDelegates[High(FRequestActiveSourceDelegates)];
    SetLength(FRequestActiveSourceDelegates, Length(FRequestActiveSourceDelegates)-1);
  end;
end;

procedure TSourceFrame.UnsubscribeSourceModeChangeEvent(
  Delegate: TSourceModeChangeDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TSourceModeChangeDelegate;
begin
  Idx := -1;
  for I := Low(FSourceModeChangeDelegates) to High(FSourceModeChangeDelegates) do
  begin
    ExistingDelegate := FSourceModeChangeDelegates[I];
    if SameMethods(TMethod(ExistingDelegate), TMethod(Delegate)) then
    begin
      Idx := I;
      Break;
    end;
  end;

  if Idx < 0 then
    Assert(False)
  else
  begin
    FSourceModeChangeDelegates[Idx] := FSourceModeChangeDelegates[High(FSourceModeChangeDelegates)];
    SetLength(FSourceModeChangeDelegates, Length(FSourceModeChangeDelegates)-1);
  end;
end;

end.
