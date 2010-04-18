// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.SourceFrame;

interface

uses
  System.Xml,
  System.ComponentModel,
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Borland.Vcl.StdCtrls,
  Borland.Vcl.ComCtrls,
  Borland.Vcl.ExtCtrls,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.EditorFrame;

type
  TSourceFrame = class;

  TSourceMode = (smSelectable, smLatched, smReadOnly);
  TSourceState = (ssActive, ssSelectable, ssReadOnly);

  TRequestActiveSourceEvent = procedure(sender: TSourceFrame) of object;
  TSourceModeChangeEvent = procedure(sender: TSourceFrame; oldMode: TSourceMode) of object;

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
  private
    const
      MetaTag_TopFlowPanelHeight = 'TopFlowPanelHeight';
      MetaTag_SourceMode = 'SourceMode';
      MetaTag_SourceState = 'SourceState';

    var
      FSourceMode: TSourceMode;
      FSourceState: TSourceState;
      FRequestActiveSourceEvent: TRequestActiveSourceEvent;
      FSourceModeChangeEvent: TSourceModeChangeEvent;

    procedure HandleSynchronisedChangeEvent;

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

    procedure LoadFromXml(config: XmlElement); override;
    procedure SaveToXml(config: XmlElement); override;

    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder); override;
    procedure Unprepare; override;

    property SourceMode: TSourceMode read FSourceMode write SetSourceMode;
    property SourceState: TSourceState read FSourceState write SetSourceState;
    property Active: Boolean read GetActive;

    property RequestActiveSourceEvent: TRequestActiveSourceEvent add FRequestActiveSourceEvent remove FRequestActiveSourceEvent;
    property SourceModeChangeEvent: TSourceModeChangeEvent add FSourceModeChangeEvent remove FSourceModeChangeEvent;
  end;

  TSourceFrames = array of TSourceFrame;

implementation

{$R *.dfm}

uses
  System.Globalization,
  Xilytix.FTEditor.EditData,
  Xilytix.FTEditor.LayoutConfiguration,
  Xilytix.FTEditor.Colors,
  Xilytix.FTEditor.Configuration;

{ TSourceFrame }

constructor TSourceFrame.Create(AOwner: TComponent);
begin
  inherited;

  SourceModeComboBox.ItemsEx.AddItem('Selectable', -1, -1, -1, -1, smSelectable);
  SourceModeComboBox.ItemsEx.AddItem('Latched', -1, -1, -1, -1, smLatched);
  SourceModeComboBox.ItemsEx.AddItem('Read Only', -1, -1, -1, -1, smReadOnly);

  SourceModeComboBox.ItemIndex := 0;
end;

procedure TSourceFrame.FrameEnter(Sender: TObject);
begin
  if SourceMode = smSelectable then
  begin
    FRequestActiveSourceEvent(Self);
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
    LineCountEdit.Text := FEditEngine.LineCount.ToString;
    CharsEdit.Text := FEditEngine.CharCount.ToString;
    RecordsEdit.Text := FEditEngine.RecordCount.ToString;
  end;

  PopulateActiveCursorInfo(True, True);
end;

procedure TSourceFrame.LoadFromXml(config: XmlElement);
begin
  inherited;

  if config.HasAttribute(MetaTag_TopFlowPanelHeight) then
  begin
    TopFlowPanel.Height := TLayoutConfiguration.XmlValueToInteger(config.GetAttribute(MetaTag_TopFlowPanelHeight));
  end;
  if config.HasAttribute(MetaTag_SourceMode) then
  begin
    SourceModeAsXmlValue := config.GetAttribute(MetaTag_SourceMode);
  end;
  if config.HasAttribute(MetaTag_SourceState) then
  begin
    SourceStateAsXmlValue := config.GetAttribute(MetaTag_SourceState);
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
        FieldPosEdit.Text := Cell.ActiveIndex.ToString;
        FieldValueEdit.Text := Cell.ValueAsString;
        FieldTextEdit.Text := FEditEngine.Text.Substring(Cell.FilePos, Cell.TextLength);
        FieldHeadingEdit.Text := FEditEngine.Heading[FEditEngine.CursorActiveColIdx];
        if Cell.Row.Heading then
        begin
          RecordNrEdit.Text := 'H' + Cell.Row.Number.ToString;
          FieldNameEdit.Text := Cell.SequenceItem.Field.Name;
          FieldIndexEdit.Text := Cell.SequenceItem.Field.Index.ToString;
          TableNrEdit.Text := '';
          SeqNameEdit.Text := Cell.SequenceItem.Owner.Name;
          ItemIndexEdit.Text := Cell.SequenceItem.Index.ToString;
        end
        else
        begin
          RecordNrEdit.Text := Cell.Row.Number.ToString;
          FieldNameEdit.Text := Cell.SequenceItem.Field.Name;
          FieldIndexEdit.Text := Cell.SequenceItem.Field.Index.ToString;
          TableNrEdit.Text := Cell.Row.TableNr.ToString;
          SeqNameEdit.Text := Cell.SequenceItem.Owner.Name;
          ItemIndexEdit.Text := Cell.SequenceItem.Index.ToString;
        end;
      end;
    end;
  end;
end;

procedure TSourceFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
begin
  inherited;
  Include(FEditEngine.SynchronisedChangeEvent, HandleSynchronisedChangeEvent);
end;

procedure TSourceFrame.ProcessConfigurationChange;
begin
  inherited;

  SetTopPanelColor;
end;

procedure TSourceFrame.SaveToXml(config: XmlElement);
begin
  inherited;

  config.SetAttribute(MetaTag_TopFlowPanelHeight, TLayoutConfiguration.IntegerToXmlValue(TopFlowPanel.Height));
  config.SetAttribute(MetaTag_SourceMode, SourceModeAsXmlValue);
  config.SetAttribute(MetaTag_SourceState, SourceStateAsXmlValue);
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
  if System.&String.Compare(Value, 'Latched', True, CultureInfo.InvariantCulture) = 0 then
    SourceMode := smLatched
  else
  begin
    if System.&String.Compare(Value, 'ReadOnly', True, CultureInfo.InvariantCulture) = 0 then
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
  if System.&String.Compare(Value, 'Active', True, CultureInfo.InvariantCulture) = 0 then
    SourceState := ssActive
  else
  begin
    if System.&String.Compare(Value, 'ReadOnly', True, CultureInfo.InvariantCulture) = 0 then
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
  FSourceMode := (SourceModeComboBox.ItemsEx[SourceModeComboBox.ItemIndex].Data) as TSourceMode;
  FSourceModeChangeEvent(Self, OldMode);
end;

procedure TSourceFrame.Unprepare;
begin
  Exclude(FEditEngine.SynchronisedChangeEvent, HandleSynchronisedChangeEvent);
  inherited;
end;

end.
