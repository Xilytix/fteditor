// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.LayoutFrame;

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
  ExtCtrls,
  ComCtrls,
  XMLIntf,
  Xilytix.FTEditor.LayoutConfiguration,
  Xilytix.FTEditor.LayoutableFrame;

type
  TLayoutFrame = class;

  TLayoutFrame = class(TFrame)
  public
    type
      TAddFrameDelegate = procedure(sender: TLayoutFrame; frame: TLayoutableFrame; Slot: TLayoutConfiguration.TFrameSlotId) of object;
      TRemoveFrameDelegate = procedure(sender: TLayoutFrame; frame: TLayoutableFrame) of object;
  strict private
    type
      TArrangement = TLayoutConfiguration.TArrangement;
      TFrameSlot = TLayoutConfiguration.TFrameSlotId;
      THalf = TLayoutConfiguration.THalf;
      THalfId = TLayoutConfiguration.THalfId;
      THalfAndFillRecs = TLayoutConfiguration.THalfAndFillRecs;
      TFrameTypeAndFillRecs = TLayoutConfiguration.TFrameTypeAndFillRecs;
//      TExplicitSizeDirectionRec = TLayoutConfiguration.TExplicitSizeDirectionRec;
      TExplicitSizesRec = TLayoutConfiguration.TExplicitSizesRec;
//      TFrameSlotConfigs = TLayoutConfiguration.TFrameSlotConfigs;

      TFrameTypeIds = array of TLayoutableFrame.TTypeId;

      TExplicitSizeOrientation = (esdNone, esdHorizontal, esdVertical);

      TExplicitSizeControlRec = record
        Control: TWinControl;
        ExplicitSizeOrientation: TExplicitSizeOrientation;
      end;
      THalfExplicitSizeControls = array[THalfId] of TExplicitSizeControlRec;

      TFrameSlotInfo = record
        Frame: TLayoutableFrame;
        ExplicitSizeOrientation: TExplicitSizeOrientation;
      end;
      TFrameSlotInfos = array[TFrameSlot] of TFrameSlotInfo;

      TAddFrameDelegates = array of TAddFrameDelegate;
      TRemoveFrameDelegates = array of TRemoveFrameDelegate;

    var
      FLayoutableFrames: TLayoutableFrameArray;
      FMainExplicitSizeControl: TExplicitSizeControlRec;
      FHalfExplicitSizeControls: THalfExplicitSizeControls;
      FFrameSlotInfos: TFrameSlotInfos;

      FAddFrameDelegates: TAddFrameDelegates;
      FRemoveFrameDelegates: TRemoveFrameDelegates;

    procedure NotifyAddFrame(frame: TLayoutableFrame; Slot: TLayoutConfiguration.TFrameSlotId);
    procedure NotifyRemoveFrame(frame: TLayoutableFrame);

    procedure Clear;

    function CreatePanel(panelName: string): TPanel;
    function CreateSplitter(splitterName: string): TSplitter;
    function CreatePageControl(pageControlName: string): TPageControl;
    function CreateTabSheet(tabSheetName: string): TTabSheet;
    function CreateLayoutableFrame(id: TLayoutableFrame.TTypeId; namePrefix: string): TLayoutableFrame;

    procedure CreateHalf(half: THalf; parentControl: TWinControl; 
                         out implicitWidth, implicitHeight: Integer);
    procedure CreateSplitHalf(half: THalf; parentControl: TWinControl;
                              out implicitWidth, implicitHeight: Integer);
    procedure CreateTabbedLayoutableFrames(idFills: TFrameTypeAndFillRecs;
                                           arrangement: TArrangement;
                                           parentControl: TWinControl;
                                           out implicitWidth, implicitHeight: Integer);
    procedure CreateVerticalSplit(typeAndFills: TFrameTypeAndFillRecs;
                                  arrangement: TArrangement;
                                  parentControl: TWinControl;
                                  out implicitWidth, implicitHeight: Integer);
    procedure CreateHorizontalSplit(typeAndFills: TFrameTypeAndFillRecs;
                                    arrangement: TArrangement;
                                    parentControl: TWinControl;
                                    out implicitWidth, implicitHeight: Integer);

    procedure CreateTabbedHalves(halves: THalfAndFillRecs; halvesArrangement: TArrangement);
    procedure CreateHalves(halves: THalfAndFillRecs; arrangement: TArrangement; tabbed: Boolean;
                           explicitSize: Integer);

    function GetExplicitSizesRec: TExplicitSizesRec;

    function GetLayoutableFrameCount: Integer;
    function GetLayoutableFrames(idx: Integer): TLayoutableFrame;
    { Private declarations }
  public
    { Public declarations }

    procedure ConfigureLayout(layoutConfiguration: TLayoutConfiguration);
//    procedure SaveFrameConfigurations(FrameSlotConfigs: TFrameSlotConfigs; out ExplicitSizes: TExplicitSizesRec);

    property LayoutableFrameCount: Integer read GetLayoutableFrameCount;
    property LayoutableFrames[idx: Integer]: TLayoutableFrame read GetLayoutableFrames;

    procedure SubscribeAddFrameEvent(Delegate: TAddFrameDelegate);
    procedure UnsubscribeAddFrameEvent(Delegate: TAddFrameDelegate);
    procedure SubscribeRemoveFrameEvent(Delegate: TRemoveFrameDelegate);
    procedure UnsubscribeRemoveFrameEvent(Delegate: TRemoveFrameDelegate);
{    property AddFrameEvent: TLayoutableFrameAddEvent add FAddFrameEvent remove FAddFrameEvent;
    property RemoveFrameEvent: TLayoutableFrameRemoveEvent add FRemoveFrameEvent remove FRemoveFrameEvent;}
  end;

implementation

{$R *.dfm}

uses
  Xilytix.FieldedText.Utils,
  Xilytix.FTEditor.MainPropertiesFrame,
  Xilytix.FTEditor.TextViewFrame,
  Xilytix.FTEditor.GridViewFrame,
  Xilytix.FTEditor.ErrorsFrame,
  Xilytix.FTEditor.FieldsFrame,
  Xilytix.FTEditor.SequencesFrame;

{ TLayoutFrame }

procedure TLayoutFrame.Clear;
var
  I: Integer;
  Found: Boolean;
  Component: TComponent;
  Slot: TFrameSlot;
  HalfId: THalfId;
begin
  for I := High(FLayoutableFrames) downto Low(FLayoutableFrames) do
  begin
    NotifyRemoveFrame(FLayoutableFrames[I]);
  end;
  FLayoutableFrames := nil;

  repeat
    Found := False;

    for I := ComponentCount-1 downto 0 do
    begin
      Component := Components[I];

      if (Component is TPanel)
         or
         (Component is TSplitter)
         or
         (Component is TPageControl)
         or
         (Component is TTabSheet)
         or
         (Component is TLayoutableFrame) then
      begin
        Component.Free;
        Found := True;
        Break;
      end;
    end;
  until not Found;

  FMainExplicitSizeControl.Control := nil;
  FMainExplicitSizeControl.ExplicitSizeOrientation := esdNone;

  for HalfId := Low(FHalfExplicitSizeControls) to High(FHalfExplicitSizeControls) do
  begin
    FHalfExplicitSizeControls[HalfId].Control := nil;
    FHalfExplicitSizeControls[HalfId].ExplicitSizeOrientation := esdNone;
  end;

  for Slot := Low(FFrameSlotInfos) to High(FFrameSlotInfos) do
  begin
    FFrameSlotInfos[Slot].Frame := nil;
    FFrameSlotInfos[Slot].ExplicitSizeOrientation := esdNone;
  end;
end;

procedure TLayoutFrame.ConfigureLayout(layoutConfiguration: TLayoutConfiguration);
begin
  Clear;

  layoutConfiguration.Calculate;

  if Length(layoutConfiguration.CalculatedHalfAndFillRecs) > 0 then
  begin
    CreateHalves(layoutConfiguration.CalculatedHalfAndFillRecs, layoutConfiguration.CalculatedHalvesArrangement, layoutConfiguration.Tabbed,
                 layoutConfiguration.ExplicitSize);
  end;
end;

function TLayoutFrame.CreateLayoutableFrame(id: TLayoutableFrame.TTypeId; namePrefix: string): TLayoutableFrame;
var
  Instance: Integer;
  FrameName: string;
  ExistingComponent: TComponent;
  AlreadyExists: Boolean;
  Idx: Integer;
begin
  case id of
    ftNone: Result := nil;
    ftTextView: Result := TTextViewFrame.Create(Self);
    ftGridView: Result := TGridViewFrame.Create(Self);
    ftErrors: Result := TErrorsFrame.Create(Self);
    ftMainProperties: Result := TMainPropertiesFrame.Create(Self);
    ftFields: Result := TFieldsFrame.Create(Self);
    ftSequences: Result := TSequencesFrame.Create(Self);
    else Result := nil;
  end;

  if Assigned(Result) then
  begin
    Result.NamePrefix := namePrefix;

    Instance := 1;
    repeat
      FrameName := Result.CalculateName(Instance);
      ExistingComponent := FindComponent(FrameName);
      AlreadyExists := Assigned(ExistingComponent);
      if not AlreadyExists then
        Result.TypeInstance := Instance
      else
        Inc(Instance);
    until not AlreadyExists;
  end;

  Idx := Length(FLayoutableFrames);
  SetLength(FLayoutableFrames, Idx+1);
  FLayoutableFrames[Idx] := Result;
end;

function TLayoutFrame.CreatePageControl(pageControlName: string): TPageControl;
begin
  Result := TPageControl.Create(Self);
  Result.Name := pageControlName;
end;

function TLayoutFrame.CreatePanel(panelName: string): TPanel;
begin
  Result := TPanel.Create(Self);
  Result.Name := panelName;
  Result.Caption := '';
  Result.BorderWidth := 0;
  Result.BevelInner := bvNone;
  Result.BevelOuter := bvNone;
  Result.BevelKind := bkNone;
end;

function TLayoutFrame.CreateSplitter(splitterName: string): TSplitter;
begin
  Result := TSplitter.Create(Self);
  Result.Name := splitterName;
  Result.Align := alNone;
  Result.ResizeStyle := rsUpdate;
  Result.Beveled := True;
  Result.Width := 4;
  Result.Height := Result.Width;
  Result.Hint := splitterName;
  Result.AutoSnap := False;
end;

function TLayoutFrame.CreateTabSheet(tabSheetName: string): TTabSheet;
begin
  Result := TTabSheet.Create(Self);
  Result.Name := tabSheetName;
end;

procedure TLayoutFrame.CreateVerticalSplit(typeAndFills: TFrameTypeAndFillRecs; arrangement: TArrangement; parentControl: TWinControl;
  out implicitWidth, implicitHeight: Integer);
var
  I: Integer;
  Frames: array of TLayoutableFrame;
  Splitters: array of TSplitter;
  FrameHeight: Integer;
  Filled: Boolean;

  function CalculateHeight(idx: Integer): Integer;
  begin
    if typeAndFills[idx].Fill or (typeAndFills[idx].ExplicitSize < 0) then
      Result := Frames[idx].ImplicitHeight
    else
      Result := typeAndFills[idx].ExplicitSize;
  end;

begin
  SetLength(Frames, Length(typeAndFills));
  SetLength(Splitters, Length(typeAndFills)-1);

  for I := Low(typeAndFills) to High(typeAndFills) do
  begin
    if I <> Low(typeAndFills) then
    begin
      Splitters[I-1] := CreateSplitter(parentControl.Name + '_Splitter' + IntToStr(I-1));
      Splitters[I-1].Parent := parentControl;
      Splitters[I-1].Top := Frames[I-1].Top + Frames[I-1].Height;
      Splitters[I-1].Align := alTop;
    end;

    Frames[I] := CreateLayoutableFrame(typeAndFills[I].FrameTypeId, parentControl.Name + '_');

    if I = Low(typeAndFills) then
      Frames[I].Top := 0
    else
      Frames[I].Top := Splitters[I-1].Top + Splitters[I-1].Height;
    Frames[I].Parent := parentControl;
    Frames[I].Align := alTop;
    Frames[I].Height := CalculateHeight(I);
  end;

  implicitWidth := 0;
  implicitHeight := 0;
  Filled := False;

  for I := High(typeAndFills) downto Low(typeAndFills) do
  begin
    if Filled then
      FrameHeight := CalculateHeight(I)
    else
    begin
      if I = Low(typeAndFills) then
      begin
        typeAndFills[I].Fill := True;
      end;

      FrameHeight := CalculateHeight(I);

      if typeAndFills[I].Fill then
      begin
        Frames[I].Align := alClient;
        Filled := True;
      end
      else
      begin
        Frames[I].Align := alNone;
        Frames[I].Height := FrameHeight;
        if I < High(typeAndFills) then
        begin
          Frames[I].Top := Splitters[I].Top - Frames[I].Height;
        end;
        Frames[I].Align := alBottom;
        Splitters[I-1].Align := alNone;
        Splitters[I-1].Top := Frames[I].Top - Splitters[I-1].Height;
        Splitters[I-1].Align := alBottom;
      end;
    end;

    if Frames[I].ImplicitWidth > implicitWidth then
    begin
      implicitWidth := Frames[I].ImplicitWidth;
    end;
    implicitHeight := implicitHeight + FrameHeight;

    FFrameSlotInfos[typeAndFills[I].Slot].Frame := Frames[I];
    if typeAndFills[I].Fill then
      FFrameSlotInfos[typeAndFills[I].Slot].ExplicitSizeOrientation := esdNone
    else
      FFrameSlotInfos[typeAndFills[I].Slot].ExplicitSizeOrientation := esdVertical;

    NotifyAddFrame(Frames[I], typeAndFills[I].Slot);
  end;
end;

function TLayoutFrame.GetExplicitSizesRec: TExplicitSizesRec;

  procedure Assign(const orientation: TExplicitSizeOrientation; control: TWinControl; var explicitSize: Integer);
  begin
    case orientation of
      esdNone: explicitSize := -1;
      esdHorizontal: explicitSize := control.Width;
      esdVertical: explicitSize := control.Height;
      else Assert(False);
    end;
  end;

var
  HalfId: ThalfId;
  Slot: TFrameSlot;
begin
  Assign(FMainExplicitSizeControl.ExplicitSizeOrientation, FMainExplicitSizeControl.Control, Result.Main);

  for HalfId := Low(FHalfExplicitSizeControls) to High(FHalfExplicitSizeControls) do
  begin
    Assign(FHalfExplicitSizeControls[HalfId].ExplicitSizeOrientation,
           FHalfExplicitSizeControls[HalfId].Control,
           Result.Halves[HalfId]);
  end;

  for Slot := Low(FFrameSlotInfos) to High(FFrameSlotInfos) do
  begin
    Assign(FFrameSlotInfos[Slot].ExplicitSizeOrientation,
           FFrameSlotInfos[Slot].Frame,
           Result.Frames[Slot]);
  end;
end;

function TLayoutFrame.GetLayoutableFrameCount: Integer;
begin
  Result := Length(FLayoutableFrames);
end;

function TLayoutFrame.GetLayoutableFrames(idx: Integer): TLayoutableFrame;
begin
  Result := FLayoutableFrames[idx];
end;

procedure TLayoutFrame.NotifyAddFrame(frame: TLayoutableFrame;
  Slot: TLayoutConfiguration.TFrameSlotId);
var
  I: Integer;
  Delegates: TAddFrameDelegates;
begin
  Delegates := Copy(FAddFrameDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
    Delegates[I](Self, Frame, Slot);
  end;
end;

procedure TLayoutFrame.NotifyRemoveFrame(frame: TLayoutableFrame);
var
  I: Integer;
  Delegates: TRemoveFrameDelegates;
begin
  Delegates := Copy(FRemoveFrameDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
    Delegates[I](Self, Frame);
  end;
end;

procedure TLayoutFrame.SubscribeAddFrameEvent(Delegate: TAddFrameDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FAddFrameDelegates);
  SetLength(FAddFrameDelegates, Idx + 1);
  FAddFrameDelegates[Idx] := Delegate;
end;

procedure TLayoutFrame.SubscribeRemoveFrameEvent(
  Delegate: TRemoveFrameDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FRemoveFrameDelegates);
  SetLength(FRemoveFrameDelegates, Idx + 1);
  FRemoveFrameDelegates[Idx] := Delegate;
end;

procedure TLayoutFrame.UnsubscribeAddFrameEvent(Delegate: TAddFrameDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TAddFrameDelegate;
begin
  Idx := -1;
  for I := Low(FAddFrameDelegates) to High(FAddFrameDelegates) do
  begin
    ExistingDelegate := FAddFrameDelegates[I];
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
    FAddFrameDelegates[Idx] := FAddFrameDelegates[High(FAddFrameDelegates)];
    SetLength(FAddFrameDelegates, Length(FAddFrameDelegates)-1);
  end;
end;

procedure TLayoutFrame.UnsubscribeRemoveFrameEvent(
  Delegate: TRemoveFrameDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TRemoveFrameDelegate;
begin
  Idx := -1;
  for I := Low(FRemoveFrameDelegates) to High(FRemoveFrameDelegates) do
  begin
    ExistingDelegate := FRemoveFrameDelegates[I];
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
    FRemoveFrameDelegates[Idx] := FRemoveFrameDelegates[High(FRemoveFrameDelegates)];
    SetLength(FRemoveFrameDelegates, Length(FRemoveFrameDelegates)-1);
  end;
end;

(*procedure TLayoutFrame.SaveFrameConfigurations(FrameSlotConfigs: TFrameSlotConfigs; out ExplicitSizes: TExplicitSizesRec);
var
  I: TFrameSlot;
begin
  for I := Low(FrameSlotConfigs) to High(FrameSlotConfigs) do
  begin
    if {Assigned(FrameSlotConfigs[I]) and} Assigned(FFrameSlotInfos[I].Frame) then
    begin
      FFrameSlotInfos[I].Frame.SaveToXml(FrameSlotConfigs[I]);
    end;
  end;

  ExplicitSizes := GetExplicitSizesRec;
end; *)

procedure TLayoutFrame.CreateSplitHalf(half: THalf; parentControl: TWinControl;
  out implicitWidth, implicitHeight: Integer);
var
  Frame: TLayoutableFrame;
  Panel: TPanel;
  PanelImplicitHeight: Integer;
  PanelImplicitWidth: Integer;
  Splitter: TSplitter;
  IdFills: TFrameTypeAndFillRecs;
  FrameWidth: Integer;
  FrameHeight: Integer;
  PanelWidth: Integer;
  PanelHeight: Integer;
//  Config: XmlElement;
  Slot: TFrameSlot;
begin
  case half.Arrangement of
    la2Vertical, la3Vertical:
    begin
      CreateVerticalSplit(half.CalculatedIdFills, half.CalculatedArrangement, parentControl,
                          implicitWidth, implicitHeight);
    end;
    la2Horizontal, la3Horizontal:
    begin
      CreateHorizontalSplit(half.CalculatedIdFills, half.CalculatedArrangement, parentControl,
                            implicitWidth, implicitHeight);
    end;
    la2Left1Right:
    begin
      Panel := CreatePanel(parentControl.Name + '_' + 'LeftPanel');
      Panel.Parent := parentControl;
      Panel.Left := 0;
      Panel.Width := parentControl.Width div 2;
      Panel.Align := alLeft;

      IdFills := Copy(half.CalculatedIdFills, 0, 2);
      if half.Tabbed then
        CreateTabbedLayoutableFrames(IdFills, la2Vertical, Panel, PanelImplicitWidth, PanelImplicitHeight)
      else
        CreateVerticalSplit(IdFills, la2Vertical, Panel, PanelImplicitWidth, PanelImplicitHeight);

      Splitter := CreateSplitter(parentControl.Name + '_' + 'Splitter');
      Splitter.Left := Panel.Left + Panel.Width;
      Splitter.Align := alLeft;
      Splitter.Parent := parentControl;

      Frame := CreateLayoutableFrame(half.CalculatedIdFills[2].FrameTypeId, parentControl.Name + '_Right');
//      Config := half.CalculatedIdFills[2].Config;
      Slot := half.CalculatedIdFills[2].Slot;
      Frame.Parent := parentControl;
      Frame.Left := Splitter.Left + Splitter.Width;
      Frame.Align := alClient;

      if half.CalculatedIdFills[2].Fill then
      begin
        FrameWidth := Frame.ImplicitWidth;

        if half.ExplicitSize >= 0 then
          PanelWidth := half.ExplicitSize
        else
          PanelWidth := PanelImplicitWidth;
        Panel.Width := PanelWidth;
        FHalfExplicitSizeControls[half.Id].Control := Panel;
        FHalfExplicitSizeControls[half.Id].ExplicitSizeOrientation := esdHorizontal;
      end
      else
      begin
        PanelWidth := PanelImplicitWidth;

        Frame.Align := alRight;
        if half.CalculatedIdFills[2].ExplicitSize >= 0 then
          FrameWidth := half.CalculatedIdFills[2].ExplicitSize
        else
          FrameWidth := Frame.ImplicitWidth;
        Frame.Width := FrameWidth;
        Splitter.Align := alRight;
        Panel.Align := alClient;
      end;

      NotifyAddFrame(Frame, {Config}Slot);

      implicitWidth := PanelWidth + FrameWidth;
      if PanelImplicitHeight > Frame.ImplicitHeight then
        implicitHeight := PanelImplicitHeight
      else
        implicitHeight := Frame.ImplicitHeight;
    end;
    la2Top1Bottom:
    begin
      Panel := CreatePanel(parentControl.Name + '_' + 'TopPanel');
      Panel.Parent := parentControl;
      Panel.Top := 0;
      Panel.Height := parentControl.Height div 2;
      Panel.Align := alTop;

      IdFills := Copy(half.CalculatedIdFills, 0, 2);
      if half.Tabbed then
        CreateTabbedLayoutableFrames(IdFills, la2Horizontal, Panel, PanelImplicitWidth, PanelImplicitHeight)
      else
        CreateHorizontalSplit(IdFills, la2Horizontal, Panel, PanelImplicitWidth, PanelImplicitHeight);

      Splitter := CreateSplitter(parentControl.Name + '_' + 'Splitter');
      Splitter.Top := Panel.Top + Panel.Height;
      Splitter.Align := alTop;
      Splitter.Parent := parentControl;

      Frame := CreateLayoutableFrame(half.CalculatedIdFills[2].FrameTypeId, parentControl.Name + '_Bottom');
      Frame.Parent := parentControl;
      Frame.Top := Splitter.Top + Splitter.Height;
      Frame.Align := alClient;
//      Config := half.CalculatedIdFills[2].Config;
      Slot := half.CalculatedIdFills[2].Slot;

      if half.CalculatedIdFills[2].Fill then
      begin
        FrameHeight := Frame.ImplicitHeight;

        if half.ExplicitSize >= 0 then
          PanelHeight := half.ExplicitSize
        else
          PanelHeight := PanelImplicitHeight;
        Panel.Height := PanelHeight;
        FHalfExplicitSizeControls[half.Id].Control := Panel;
        FHalfExplicitSizeControls[half.Id].ExplicitSizeOrientation := esdVertical;
      end
      else
      begin
        PanelHeight := PanelImplicitHeight;

        Frame.Align := alBottom;
        if half.CalculatedIdFills[2].ExplicitSize >= 2 then
          FrameHeight := half.CalculatedIdFills[2].ExplicitSize
        else
          FrameHeight := Frame.ImplicitHeight;
        Frame.Height := FrameHeight;
        Splitter.Align := alBottom;
        Panel.Align := alClient;
      end;

      NotifyAddFrame(Frame, {Config}Slot);

      implicitHeight := PanelHeight + FrameHeight;
      if PanelImplicitWidth > Frame.ImplicitWidth then
        implicitWidth := PanelImplicitWidth
      else
        implicitWidth := Frame.ImplicitWidth;
    end;
    else ;
  end;
end;

procedure TLayoutFrame.CreateHalf(half: THalf; parentControl: TWinControl;
  out implicitWidth, implicitHeight: Integer);
var
  Frame: TLayoutableFrame;
begin
  case half.Arrangement of
    laNone:
    begin
      implicitWidth := -1;
      implicitHeight := -1;
    end;
    laSingle:
    begin
      Frame := CreateLayoutableFrame(half.CalculatedIdFills[0].FrameTypeId, parentControl.Name + '_');
      Frame.Align := alClient;
      Frame.Parent := parentControl;

      NotifyAddFrame(Frame, half.CalculatedIdFills[0].Slot {Config});

      implicitWidth := Frame.ImplicitWidth;
      implicitHeight := Frame.ImplicitHeight;
    end;
    la2Vertical,
    la2Horizontal,
    la3Vertical,
    la3Horizontal:
    begin
      if half.Tabbed then
        CreateTabbedLayoutableFrames(half.CalculatedIdFills, half.Arrangement, parentControl,
                                     implicitWidth, implicitHeight)
      else
        CreateSplitHalf(half, parentControl, implicitWidth, implicitHeight);
    end;
    la2Left1Right,
    la2Top1Bottom:
    begin
      CreateSplitHalf(half, parentControl, implicitWidth, implicitHeight);
    end;
    else
    begin
      implicitWidth := -1;
      implicitHeight := -1;
    end;
  end;
end;

procedure TLayoutFrame.CreateTabbedLayoutableFrames(idFills: TFrameTypeAndFillRecs; arrangement: TArrangement; parentControl: TWinControl;
                                                    out implicitWidth, implicitHeight: Integer);
var
  PageControl: TPageControl;
  TabSheet: TTabSheet;
  Frame: TLayoutableFrame;
  I: Integer;
begin
  implicitWidth := 0;
  implicitHeight := 0;

  PageControl := CreatePageControl(parentControl.Name + '_PageControl');
  PageControl.Align := alClient;
  PageControl.Parent := parentControl;
  case arrangement of
    la2Vertical, la3Vertical: PageControl.TabPosition := tpLeft;
    else PageControl.TabPosition := tpTop;
  end;

  for I := Low(idFills) to High(idFills) do
  begin
    Frame := CreateLayoutableFrame(idFills[I].FrameTypeId, parentControl.Name + '_');
    TabSheet := CreateTabSheet(parentControl.Name + '_' + Frame.GetTypeName + 'TabSheet');
    TabSheet.Caption := Frame.InstanceCaption;
    TabSheet.PageControl := PageControl;
    Frame.Parent := TabSheet;
    Frame.Align := alClient;

    NotifyAddFrame(Frame, idFills[I].Slot {Config});

    if Frame.ImplicitWidth > implicitWidth then
    begin
      implicitWidth := Frame.ImplicitWidth;
    end;
    if Frame.ImplicitHeight > implicitHeight then
    begin
      implicitHeight := Frame.ImplicitHeight;
    end;
  end;
end;

procedure TLayoutFrame.CreateTabbedHalves(halves: THalfAndFillRecs; halvesArrangement: TArrangement);
var
  PageControl: TPageControl;
  TabSheet: TTabSheet;
  ImplicitWidth, implicitHeight: Integer;
begin
  PageControl := CreatePageControl('HalvesPageControl');
  PageControl.Align := alClient;
  PageControl.Parent := Self;

  TabSheet := CreateTabSheet('Half1TabSheet');
  TabSheet.Caption := 'Meta';
  TabSheet.PageControl := PageControl;
  CreateHalf(halves[0].Half, TabSheet, ImplicitWidth, implicitHeight);

  TabSheet := CreateTabSheet('Half2TabSheet');
  TabSheet.Caption := 'Text';
  TabSheet.PageControl := PageControl;
  CreateHalf(halves[1].Half, TabSheet, ImplicitWidth, implicitHeight);

  if halvesArrangement = la2Vertical then
  begin
    PageControl.TabPosition := tpLeft;
  end;
end;

procedure TLayoutFrame.CreateHalves(halves: THalfAndFillRecs; arrangement: TArrangement; tabbed: Boolean;
                                    explicitSize: Integer);
var
  Panel1: TPanel;
  Panel1ImplicitHeight, Panel1ImplicitWidth: Integer;
  Panel2: TPanel;
  Panel2ImplicitHeight, Panel2ImplicitWidth: Integer;
  Splitter: TSplitter;

  function CalculateSize(implicitSize: Integer): Integer;
  begin
    if explicitSize >= 0 then
      Result := explicitSize
    else
      Result := implicitSize;
  end;

begin
  case arrangement of
    laNone:
    begin
      Panel1ImplicitHeight := -1;
      Panel1ImplicitWidth := -1;
    end;
    laSingle:
    begin
      Panel1 := CreatePanel('SingleHalfPanel');
      Panel1.Align := alClient;
      Panel1.Parent := Self;
      CreateHalf(halves[0].Half, Panel1, Panel1ImplicitHeight, Panel1ImplicitWidth);
    end;
    la2Vertical:
    begin
      if tabbed then
        CreateTabbedHalves(halves, arrangement)
      else
      begin
        Panel1 := CreatePanel('TopHalfPanel');
        Panel1.Parent := Self;
        Panel1.Top := 0;
        Panel1.Align := alTop;
        CreateHalf(halves[0].Half, Panel1, Panel1ImplicitHeight, Panel1ImplicitWidth);

        Splitter := CreateSplitter('HalvesSplitter');
        Splitter.Parent := Self;
        Splitter.Top := Panel1.Top + Panel1.Height;
        Splitter.Align := alTop;

        Panel2 := CreatePanel('BottomHalfPanel');
        Panel2.Parent := Self;
        Panel2.Top := Splitter.Top + Splitter.Height;
        Panel2.Align := alClient;
        CreateHalf(halves[1].Half, Panel2, Panel2ImplicitHeight, Panel2ImplicitWidth);

        if not halves[0].Fill or halves[1].Fill then
        begin
          Panel1.Height := CalculateSize(Panel1ImplicitHeight);
          FMainExplicitSizeControl.Control := Panel1;
        end
        else
        begin
          Panel2.Align := alBottom;
          Panel2.Height := CalculateSize(Panel2ImplicitHeight);
          FMainExplicitSizeControl.Control := Panel2;
          Splitter.Align := alBottom;
          Panel1.Align := alClient;
        end;
        FMainExplicitSizeControl.ExplicitSizeOrientation := esdVertical;
      end;
    end;
    la2Horizontal:
    begin
      if tabbed then
        CreateTabbedHalves(halves, arrangement)
      else
      begin
        Panel1 := CreatePanel('LeftHalfPanel');
        Panel1.Parent := Self;
        Panel1.Left := 0;
        Panel1.Align := alLeft;
        CreateHalf(halves[0].Half, Panel1, Panel1ImplicitWidth, Panel1ImplicitHeight);

        Splitter := CreateSplitter('HalvesSplitter');
        Splitter.Parent := Self;
        Splitter.Left := Panel1.Left + Panel1.Width;
        Splitter.Align := alLeft;

        Panel2 := CreatePanel('RightHalfPanel');
        Panel2.Parent := Self;
        Panel2.Left := Splitter.Left + Splitter.Width;
        Panel2.Align := alClient;
        CreateHalf(halves[1].Half, Panel2, Panel2ImplicitWidth, Panel2ImplicitHeight);

        if not halves[0].Fill or halves[1].Fill then
        begin
          Panel1.Width := CalculateSize(Panel1ImplicitWidth);
          FMainExplicitSizeControl.Control := Panel1;
        end
        else
        begin
          Panel2.Align := alRight;
          Panel2.Width := CalculateSize(Panel2ImplicitWidth);
          FMainExplicitSizeControl.Control := Panel2;
          Splitter.Align := alRight;
          Panel1.Align := alClient;
        end;
        FMainExplicitSizeControl.ExplicitSizeOrientation := esdHorizontal;
      end;
    end;
    else
    begin
      Panel1ImplicitHeight := -1;
      Panel1ImplicitWidth := -1;
    end;
  end;
end;

procedure TLayoutFrame.CreateHorizontalSplit(typeAndFills: TFrameTypeAndFillRecs; arrangement: TArrangement; parentControl: TWinControl;
  out implicitWidth, implicitHeight: Integer);
var
  I: Integer;
  Frames: array of TLayoutableFrame;
  Splitters: array of TSplitter;
  FrameWidth: Integer;
  Filled: Boolean;

  function CalculateWidth(idx: Integer): Integer;
  begin
    if typeAndFills[idx].Fill or (typeAndFills[idx].ExplicitSize < 0) then
      Result := Frames[idx].ImplicitWidth
    else
      Result := typeAndFills[idx].ExplicitSize;
  end;

begin
  SetLength(Frames, Length(typeAndFills));
  SetLength(Splitters, Length(typeAndFills)-1);

  for I := Low(typeAndFills) to High(typeAndFills) do
  begin
    if I <> Low(typeAndFills) then
    begin
      Splitters[I-1] := CreateSplitter(parentControl.Name + '_Splitter' + IntToStr(I-1));
      Splitters[I-1].Parent := parentControl;
      Splitters[I-1].Left := Frames[I-1].Left + Frames[I-1].Width;
      Splitters[I-1].Align := alLeft;
    end;

    Frames[I] := CreateLayoutableFrame(typeAndFills[I].FrameTypeId, parentControl.Name + '_');
    Frames[I].Parent := parentControl;
    if I = Low(typeAndFills) then
      Frames[I].Left := 0
    else
      Frames[I].Left := Splitters[I-1].Left + Splitters[I-1].Width;
    Frames[I].Align := alLeft;
    Frames[I].Width := CalculateWidth(I);
  end;

  implicitWidth := 0;
  implicitHeight := 0;
  Filled := False;

  for I := High(typeAndFills) downto Low(typeAndFills) do
  begin
    if Filled then
      FrameWidth := CalculateWidth(I)
    else
    begin
      if I = Low(typeAndFills) then
      begin
        typeAndFills[I].Fill := True;
      end;

      FrameWidth := CalculateWidth(I);

      if typeAndFills[I].Fill then
      begin
        Frames[I].Align := alClient;
        Filled := True;
      end
      else
      begin
        Frames[I].Align := alNone;
        Frames[I].Width := FrameWidth;
        if I < High(typeAndFills) then
        begin
          Frames[I].Left := Splitters[I].Left - Frames[I].Width;
        end;
        Frames[I].Align := alRight;
        Splitters[I-1].Align := alNone;
        Splitters[I-1].Left := Frames[I].Left - Splitters[I-1].Width;
        Splitters[I-1].Align := alRight;
      end;
    end;

    if Frames[I].ImplicitHeight > implicitHeight then
    begin
      implicitHeight := Frames[I].ImplicitHeight;
    end;
    implicitWidth := implicitWidth + FrameWidth;

    FFrameSlotInfos[typeAndFills[I].Slot].Frame := Frames[I];
    if typeAndFills[I].Fill then
      FFrameSlotInfos[typeAndFills[I].Slot].ExplicitSizeOrientation := esdNone
    else
      FFrameSlotInfos[typeAndFills[I].Slot].ExplicitSizeOrientation := esdHorizontal;

    NotifyAddFrame(Frames[I], typeAndFills[I].Slot {Config});
  end;
end;

end.
