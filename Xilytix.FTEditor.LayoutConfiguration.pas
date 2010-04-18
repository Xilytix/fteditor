// Project: FTEditor (Fielded Text Editor)
// Licence (this file): Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.LayoutConfiguration;

interface

uses
  System.Collections,
  System.Xml,
  Borland.Vcl.Classes,
  Xilytix.FTEditor.LayoutableFrame;

type
  TLayoutConfiguration = class
  public
    type
      TArrangement = (laNone,
                      laSingle,
                      la2Vertical,
                      la2Horizontal,
                      la2Left1Right,
                      la2Top1Bottom,
                      la3Vertical,
                      la3Horizontal);

      THalfId = (lhNone, lhA, lhB);

      TFrameSlot = (fsALeft,
                    fsAMiddle,
                    fsARight,
                    fsBLeft,
                    fsBMiddle,
                    fsBRight);

      THalfExplicitSizes = array[THalfId] of Integer;
      TFrameSlotExplicitSizes = array[TFrameSlot] of Integer;
      TFrameSlotConfigs = array[TFrameSlot] of XmlElement;

      TExplicitSizesRec = record
        Main: Integer;
        Halves: THalfExplicitSizes;
        Frames: TFrameSlotExplicitSizes;
      end;

      TFrameTypeAndFillRec = record
        FrameTypeId: TLayoutableFrame.TTypeId;
        Fill: Boolean;
        ExplicitSize: Integer;
        Slot: TFrameSlot;
        Config: XmlElement;
      end;
      TFrameTypeAndFillRecs = array of TFrameTypeAndFillRec;

      THalf = class
      strict private
        var
          FId: THalfId;
          FArrangement: TArrangement;
          FTabbed: Boolean;
          FExplicitSize: Integer;

          FLeftFrameTypeId: TLayoutableFrame.TTypeId;
          FLeftFrameFill: Boolean;
          FLeftFrameExplicitSize: Integer;
          FLeftFrameSlot: TFrameSlot;
          FLeftFrameConfiguration: XmlElement;
          FMiddleFrameTypeId: TLayoutableFrame.TTypeId;
          FMiddleFrameFill: Boolean;
          FMiddleFrameExplicitSize: Integer;
          FMiddleFrameSlot: TFrameSlot;
          FMiddleFrameConfiguration: XmlElement;
          FRightFrameTypeId: TLayoutableFrame.TTypeId;
          FRightFrameFill: Boolean;
          FRightFrameExplicitSize: Integer;
          FRightFrameSlot: TFrameSlot;
          FRightFrameConfiguration: XmlElement;

          FCalculatedArrangement: TArrangement;
          FCalculatedFrameTypeAndFills: TFrameTypeAndFillRecs;
          FCalculatedTabbed: Boolean;

        procedure AddFrameTypeAndFill(frameTypeId: TLayoutableFrame.TTypeId; fill: Boolean; explicitSize: Integer;
                                      slot: TFrameSlot; config: XmlElement);
        procedure CalculateHorizontalVertical;
        procedure CalculateDoubleSingle;

        procedure CheckSufficientFills;

        procedure SetArrangement(const Value: TArrangement);
        procedure SetLeftFrameFill(const Value: Boolean);
        procedure SetMiddleFrameFill(const Value: Boolean);
        procedure SetRightFrameFill(const Value: Boolean);

      public
        constructor Create(myId: THalfId);

        property Id: THalfId read FId;
        property Arrangement: TArrangement read FArrangement write SetArrangement;
        property Tabbed: Boolean read FTabbed write FTabbed;
        property ExplicitSize: Integer read FExplicitSize;

        property LeftFrameTypeId: TLayoutableFrame.TTypeId read FLeftFrameTypeId write FLeftFrameTypeId;
        property LeftFrameFill: Boolean read FLeftFrameFill write SetLeftFrameFill;
        property LeftFrameExplicitSize: Integer read FLeftFrameExplicitSize;
        property LeftFrameConfiguration: XmlElement read FLeftFrameConfiguration;
        property MiddleFrameTypeId: TLayoutableFrame.TTypeId read FMiddleFrameTypeId write FMiddleFrameTypeId;
        property MiddleFrameFill: Boolean read FMiddleFrameFill write SetMiddleFrameFill;
        property MiddleFrameExplicitSize: Integer read FMiddleFrameExplicitSize;
        property MiddleFrameConfiguration: XmlElement read FMiddleFrameConfiguration;
        property RightFrameTypeId: TLayoutableFrame.TTypeId read FRightFrameTypeId write FRightFrameTypeId;
        property RightFrameFill: Boolean read FRightFrameFill write SetRightFrameFill;
        property RightFrameExplicitSize: Integer read FRightFrameExplicitSize;
        property RightFrameConfiguration: XmlElement read FRightFrameConfiguration;

        procedure Calculate;
        procedure Check;

        property CalculatedArrangement: TArrangement read FCalculatedArrangement;
        property CalculatedIdFills: TFrameTypeAndFillRecs read FCalculatedFrameTypeAndFills;
        property CalculatedTabbed: Boolean read FCalculatedTabbed;

        procedure AssignFrameSlotConfigs(configs: TFrameSlotConfigs);
        procedure AssignExplicitSizes(myExplicitSize: Integer; frameSlotExplicitSizes: TFrameSlotExplicitSizes);
        procedure ResetExplicitSizes;

        procedure Load(element: XmlElement);
        procedure Save(element: XmlElement);

        class function HalfIdToXmlValue(value: THalfId): string;
        class function XmlValueToHalfId(value: string): THalfId;
        class function LayoutableFrameTypeIdToXmlValue(typeId: TLayoutableFrame.TTypeId): string;
        class function XmlValueToLayoutableFrameTypeId(value: string): TLayoutableFrame.TTypeId;

        class procedure CheckExplicitSize(var value: Integer);
      end;

      THalfAndFillRec = record
        Half: THalf;
        Fill: Boolean;
//        ExplicitSize: Integer;
      end;

      THalfAndFillRecs = array of THalfAndFillRec;

  strict private
    const
      XmlTag_Name = 'Name';
      XmlTag_Arrangement = 'Arrangement';
      XmlTag_Tabbed = 'Tabbed';
      XmlTag_LeftHalfId = 'LeftHalfId';
      XmlTag_RightHalfId = 'RightHalfId';
      XmlTag_LeftHalfFill = 'LeftHalfFill';
      XmlTag_ExplicitSize = 'ExplicitSize';
      XmlTag_Half = 'Half';

      XmlTag_HalfId = 'HalfId';
      XmlTag_LeftFrameTypeId = 'LeftFrameTypeId';
      XmlTag_LeftFrameFill = 'LeftFrameFill';
      XmlTag_LeftFrameExplicitSize = 'LeftFrameExplicitSize';
      XmlTag_LeftFrameConfiguration = 'LeftFrameConfiguration';
      XmlTag_MiddleFrameTypeId = 'MiddleFrameTypeId';
      XmlTag_MiddleFrameFill = 'MiddleFrameFill';
      XmlTag_MiddleFrameExplicitSize = 'MiddleFrameExplicitSize';
      XmlTag_MiddleFrameConfiguration = 'MiddleFrameConfiguration';
      XmlTag_RightFrameTypeId = 'RightFrameTypeId';
      XmlTag_RightFrameFill = 'RightFrameFill';
      XmlTag_RightFrameExplicitSize = 'RightFrameExplicitSize';
      XmlTag_RightFrameConfiguration = 'RightFrameConfiguration';

      MinimumExplicitSize = 4;

    var
      FName: string;

      FHalvesArrangement: TArrangement;
      FTabbed: Boolean;

      FLeftHalfId: THalfId;
      FRightHalfId: THalfId;

      FLeftHalfFill: Boolean;
      FExplicitSize: Integer;

      FHalfA: THalf;
      FHalfB: THalf;

      FCalculatedHalvesArrangement: TArrangement;
      FCalculatedHalfAndFillRecs: THalfAndFillRecs;

    class function ArrangementToXmlValue(value: TArrangement): string;
    class function XmlValueToArrangement(value: string): TArrangement;

    procedure SetHalvesArrangement(const Value: TArrangement);
  public
    constructor Create;

    property Name: string read FName write FName;

    property HalfA: THalf read FHalfA;
    property HalfB: THalf read FHalfB;

    property Arrangement: TArrangement read FHalvesArrangement write SetHalvesArrangement;
    property Tabbed: Boolean read FTabbed write FTabbed;

    property LeftHalfId: THalfId read FLeftHalfId write FLeftHalfId;
    property RightHalfId: THalfId read FRightHalfId write FRightHalfId;

    property LeftHalfFill: Boolean read FLeftHalfFill write FLeftHalfFill;
    property ExplicitSize: Integer read FExplicitSize;

    procedure Check;

    property CalculatedHalvesArrangement: TArrangement read FCalculatedHalvesArrangement;
    property CalculatedHalfAndFillRecs: THalfAndFillRecs read FCalculatedHalfAndFillRecs;

    procedure Calculate;

    procedure AssignFrameSlotConfigs(configs: TFrameSlotConfigs);
    procedure AssignExplicitSizes(const explicitSizes: TExplicitSizesRec);
    procedure ResetExplicitSizes;

    procedure Save(element: XmlElement);
    procedure Load(element: XmlElement);

    class function IntegerToXmlValue(value: Integer): string;
    class function XmlValueToInteger(value: string): Integer;
    class function BooleanToXmlValue(value: Boolean): string;
    class function XmlValueToBoolean(value: string): Boolean;

    class function GenerateBlankFrameSlotConfigs(doc: XmlDocument): TFrameSlotConfigs;
    class function GetFrameSlotConfigElementName(slot: TFrameSlot): string;
  end;

  TLayoutConfigurations = class(CollectionBase)
  strict private
    const
      XmlTag_Configuration = 'Configuration';

    function GetConfigurations(idx: Integer): TLayoutConfiguration;
    function CalculateUniqueName: string;
  public
    property Configurations[idx: Integer]: TLayoutConfiguration read GetConfigurations; default;
    function New: TLayoutConfiguration;
    function Get(name: string): TLayoutConfiguration;
    function Add(value: TLayoutConfiguration): Integer;
    procedure Remove(configuration: TLayoutConfiguration);

    procedure Save(element: XmlElement);
    procedure Load(element: XmlElement);
  end;

implementation

uses
  System.Globalization,
  Xilytix.FTEditor.MainPropertiesFrame,
  Xilytix.FTEditor.FieldsFrame,
  Xilytix.FTEditor.GridViewFrame,
  Xilytix.FTEditor.TextViewFrame,
  Xilytix.FTEditor.ErrorsFrame;

{ TLayoutConfiguration }

class function TLayoutConfiguration.ArrangementToXmlValue(value: TArrangement): string;
begin
  Result := Enum(value).ToString.Substring(2);
end;

procedure TLayoutConfiguration.AssignExplicitSizes(const explicitSizes: TExplicitSizesRec);
begin
  FExplicitSize := explicitSizes.Main;
  FHalfA.AssignExplicitSizes(explicitSizes.Halves[lha], explicitSizes.Frames);
  FHalfB.AssignExplicitSizes(explicitSizes.Halves[lhb], explicitSizes.Frames);
end;

procedure TLayoutConfiguration.AssignFrameSlotConfigs(configs: TFrameSlotConfigs);
begin
  FHalfA.AssignFrameSlotConfigs(configs);
  FHalfB.AssignFrameSlotConfigs(configs);
end;

class function TLayoutConfiguration.BooleanToXmlValue(value: Boolean): string;
begin
  Result := value.ToString(CultureInfo.InvariantCulture);
end;

procedure TLayoutConfiguration.Calculate;
var
  Half: THalf;
  Idx: Integer;
begin
  FCalculatedHalvesArrangement := laNone;
  FCalculatedHalfAndFillRecs := nil;

  case LeftHalfId of
    lhNone: Half := nil;
    lhA: Half := FHalfA;
    lhB: Half := FHalfB;
    else Half := nil;
  end;

  if Assigned(Half) then
  begin
    Half.Calculate;
    if Half.CalculatedArrangement <> laNone then
    begin
      SetLength(FCalculatedHalfAndFillRecs, 1);
      FCalculatedHalfAndFillRecs[0].Half := Half;
      FCalculatedHalfAndFillRecs[0].Fill := LeftHalfFill;
    end;
  end;

  case RightHalfId of
    lhNone: Half := nil;
    lhA: Half := FHalfA;
    lhB: Half := FHalfB;
  end;

  if Assigned(Half) then
  begin
    Half.Calculate;
    if Half.CalculatedArrangement <> laNone then
    begin
      Idx := Length(FCalculatedHalfAndFillRecs);
      SetLength(FCalculatedHalfAndFillRecs, Idx+1);
      FCalculatedHalfAndFillRecs[Idx].Half := Half;
      FCalculatedHalfAndFillRecs[Idx].Fill := not FLeftHalfFill;
    end;
  end;

  case Length(FCalculatedHalfAndFillRecs) of
    0: FCalculatedHalvesArrangement := laNone;
    1: FCalculatedHalvesArrangement := laSingle;
    2:
    begin
      if FHalvesArrangement = la2Vertical then
        FCalculatedHalvesArrangement := la2Vertical
      else
        FCalculatedHalvesArrangement := la2Horizontal;
    end;
    else FCalculatedHalvesArrangement := laNone;
  end;
end;

procedure TLayoutConfiguration.Check;
begin
  THalf.CheckExplicitSize(FExplicitSize);

  Arrangement := Arrangement;
  HalfA.Check;
  HalfB.Check;
end;

constructor TLayoutConfiguration.Create;
begin
  inherited;

  FHalfA := THalf.Create(lhA);
  FHalfB := THalf.Create(lhB);

  FName := '';

  FHalvesArrangement := la2Horizontal;
  FTabbed := False;

  FLeftHalfId := lhA;
  FRightHalfId := lhB;
  FLeftHalfFill := False;
  FExplicitSize := -1;

  FCalculatedHalvesArrangement := laNone;
  FCalculatedHalfAndFillRecs := nil;
end;

class function TLayoutConfiguration.GenerateBlankFrameSlotConfigs(doc: XmlDocument): TFrameSlotConfigs;
begin
  Result[fsALeft] := doc.CreateElement(XmlTag_LeftFrameConfiguration);
  Result[fsAMiddle] := doc.CreateElement(XmlTag_MiddleFrameConfiguration);
  Result[fsARight] := doc.CreateElement(XmlTag_RightFrameConfiguration);
  Result[fsBLeft] := doc.CreateElement(XmlTag_LeftFrameConfiguration);
  Result[fsBMiddle] := doc.CreateElement(XmlTag_MiddleFrameConfiguration);
  Result[fsBRight] := doc.CreateElement(XmlTag_RightFrameConfiguration);
end;

class function TLayoutConfiguration.GetFrameSlotConfigElementName(slot: TFrameSlot): string;
begin
  case slot of
    fsALeft: Result := XmlTag_LeftFrameConfiguration;
    fsAMiddle: Result := XmlTag_MiddleFrameConfiguration;
    fsARight: Result := XmlTag_RightFrameConfiguration;
    fsBLeft: Result := XmlTag_LeftFrameConfiguration;
    fsBMiddle: Result := XmlTag_MiddleFrameConfiguration;
    fsBRight: Result := XmlTag_RightFrameConfiguration;
    else
    begin
      Result := '';
      Assert(False);
    end;
  end;
end;

class function TLayoutConfiguration.IntegerToXmlValue(value: Integer): string;
begin
  Result := value.ToString(CultureInfo.InvariantCulture);
end;

procedure TLayoutConfiguration.Load(element: XmlElement);
var
  HalfElements: XmlNodeList;
  HalfElement: XmlElement;
  HalfId: THalfId;
  I: Integer;
begin
  if element.HasAttribute(XmlTag_Name) then
  begin
    FName := element.GetAttribute(XmlTag_Name);
  end;
  if element.HasAttribute(XmlTag_Arrangement) then
  begin
    FHalvesArrangement := XmlValueToArrangement(element.GetAttribute(XmlTag_Arrangement));
  end;
  if element.HasAttribute(XmlTag_Tabbed) then
  begin
    FTabbed := XmlValueToBoolean(element.GetAttribute(XmlTag_Tabbed));
  end;
  if element.HasAttribute(XmlTag_LeftHalfId) then
  begin
    FLeftHalfId := THalf.XmlValueToHalfId(element.GetAttribute(XmlTag_LeftHalfId));
  end;
  if element.HasAttribute(XmlTag_RightHalfId) then
  begin
    FRightHalfId := THalf.XmlValueToHalfId(element.GetAttribute(XmlTag_RightHalfId));
  end;
  if element.HasAttribute(XmlTag_LeftHalfFill) then
  begin
    FLeftHalfFill := XmlValueToBoolean(element.GetAttribute(XmlTag_LeftHalfFill));
  end;
  if element.HasAttribute(XmlTag_ExplicitSize) then
  begin
    FExplicitSize := XmlValueToInteger(element.GetAttribute(XmlTag_ExplicitSize));
  end;

  HalfElements := element.GetElementsByTagName(XmlTag_Half);
  for I := 0 to HalfElements.Count - 1 do
  begin
    HalfElement := HalfElements[I] as XmlElement;
    if HalfElement.HasAttribute(XmlTag_HalfId) then
    begin
      HalfId := THalf.XmlValueToHalfId(HalfElement.GetAttribute(XmlTag_HalfId));
      case HalfId of
        lhNone: ;
        lhA: HalfA.Load(HalfElement);
        lhB: HalfB.Load(HalfElement);
        else ;
      end;
    end;
  end;

  Check;
end;

procedure TLayoutConfiguration.ResetExplicitSizes;
begin
  FExplicitSize := -1;
  FHalfA.ResetExplicitSizes;;
  FHalfB.ResetExplicitSizes;
end;

procedure TLayoutConfiguration.Save(element: XmlElement);
var
  halfElement: XmlElement;
begin
  element.SetAttribute(XmlTag_Name, Name);
  element.SetAttribute(XmlTag_Arrangement, ArrangementToXmlValue(Arrangement));
  element.SetAttribute(XmlTag_Tabbed, BooleanToXmlValue(Tabbed));
  element.SetAttribute(XmlTag_LeftHalfId, THalf.HalfIdToXmlValue(LeftHalfId));
  element.SetAttribute(XmlTag_RightHalfId, THalf.HalfIdToXmlValue(RightHalfId));
  element.SetAttribute(XmlTag_LeftHalfFill, BooleanToXmlValue(LeftHalfFill));
  element.SetAttribute(XmlTag_ExplicitSize, IntegerToXmlValue(ExplicitSize));

  halfElement := element.OwnerDocument.CreateElement(XmlTag_Half);
  element.AppendChild(halfElement);
  HalfA.Save(halfElement);

  halfElement := element.OwnerDocument.CreateElement(XmlTag_Half);
  element.AppendChild(halfElement);
  HalfB.Save(halfElement);
end;

procedure TLayoutConfiguration.SetHalvesArrangement(const Value: TArrangement);
begin
  case Value of
    laNone, laSingle: FHalvesArrangement := la2Horizontal;
    la3Vertical, la2Top1Bottom: FHalvesArrangement := la2Vertical;
    la3Horizontal, la2Left1Right: FHalvesArrangement := la2Horizontal;
    else FHalvesArrangement := Value;
  end;
end;

class function TLayoutConfiguration.XmlValueToArrangement(value: string): TArrangement;
begin
  try
    Result := Enum.Parse(TypeOf(TArrangement), 'la' + value, True) as TArrangement;
  except
    on ArgumentException do Result := laNone;
  end;
end;

class function TLayoutConfiguration.XmlValueToBoolean(value: string): Boolean;
begin
  Result := System.&String.Compare(value, System.Boolean.TrueString, True, CultureInfo.InvariantCulture) = 0;
end;

class function TLayoutConfiguration.XmlValueToInteger(value: string): Integer;
begin
  try
    Result := System.Int32.Parse(value, CultureInfo.InvariantCulture);
  except
    on FormatException do Result := -1;
    on OverflowException do Result := -1;
  end;
end;

{ TLayoutConfiguration.THalf }

procedure TLayoutConfiguration.THalf.AddFrameTypeAndFill(frameTypeId: TLayoutableFrame.TTypeId;
                                                         fill: Boolean;
                                                         explicitSize: Integer;
                                                         slot: TFrameSlot;
                                                         config: XmlElement);
var
  Idx: Integer;
begin
  Idx := Length(FCalculatedFrameTypeAndFills);
  SetLength(FCalculatedFrameTypeAndFills, Idx+1);
  FCalculatedFrameTypeAndFills[Idx].FrameTypeId := frameTypeId;
  FCalculatedFrameTypeAndFills[Idx].Fill := fill;
  FCalculatedFrameTypeAndFills[Idx].ExplicitSize := explicitSize;
  FCalculatedFrameTypeAndFills[Idx].Slot := slot;
  FCalculatedFrameTypeAndFills[Idx].Config := config;
end;

procedure TLayoutConfiguration.THalf.AssignExplicitSizes(myExplicitSize: Integer;
  frameSlotExplicitSizes: TFrameSlotExplicitSizes);
begin
  FExplicitSize := myExplicitSize;
  case FId of
    lhA:
    begin
      FLeftFrameExplicitSize := frameSlotExplicitSizes[fsALeft];
      FMiddleFrameExplicitSize := frameSlotExplicitSizes[fsAMiddle];
      FRightFrameExplicitSize := frameSlotExplicitSizes[fsARight];
    end;
    lhB:
    begin
      FLeftFrameExplicitSize := frameSlotExplicitSizes[fsBLeft];
      FMiddleFrameExplicitSize := frameSlotExplicitSizes[fsBMiddle];
      FRightFrameExplicitSize := frameSlotExplicitSizes[fsBRight];
    end;
    else
    begin
      FLeftFrameExplicitSize := -1;
      FMiddleFrameExplicitSize := -1;
      FRightFrameExplicitSize := -1;
    end;
  end;
end;

procedure TLayoutConfiguration.THalf.AssignFrameSlotConfigs(configs: TFrameSlotConfigs);
begin
  case id of
    Xilytix.FTEditor.LayoutConfiguration.lhA:
    begin
      FLeftFrameConfiguration := Configs[fsALeft];
      FMiddleFrameConfiguration := Configs[fsAMiddle];
      FRightFrameConfiguration := Configs[fsARight];
    end;
    Xilytix.FTEditor.LayoutConfiguration.lhB:
    begin
      FLeftFrameConfiguration := Configs[fsBLeft];
      FMiddleFrameConfiguration := Configs[fsBMiddle];
      FRightFrameConfiguration := Configs[fsBRight];
    end;
  end;
end;

procedure TLayoutConfiguration.THalf.Calculate;
begin
  FCalculatedArrangement := laNone;
  FCalculatedFrameTypeAndFills := nil;
  FCalculatedTabbed := False;

  case FArrangement of
    la2Left1Right, la2Top1Bottom:
    begin
      CalculateDoubleSingle;
    end;

    la2Horizontal, la2Vertical, la3Vertical, la3Horizontal:
    begin
      CalculateHorizontalVertical;
    end;
  end;
end;

procedure TLayoutConfiguration.THalf.CalculateHorizontalVertical;
var
  Count: Integer;
begin
  if FLeftFrameTypeId <> TLayoutableFrame.TTypeId.ftNone then
  begin
    AddFrameTypeAndFill(FLeftFrameTypeId, FLeftFrameFill, FLeftFrameExplicitSize, FLeftFrameSlot, FLeftFrameConfiguration);
  end;
  if FMiddleFrameTypeId <> TLayoutableFrame.TTypeId.ftNone then
  begin
    AddFrameTypeAndFill(FMiddleFrameTypeId, FMiddleFrameFill, FMiddleFrameExplicitSize, FMiddleFrameSlot, FMiddleFrameConfiguration);
  end;
  if FRightFrameTypeId <> TLayoutableFrame.TTypeId.ftNone then
  begin
    AddFrameTypeAndFill(FRightFrameTypeId, FRightFrameFill, FRightFrameExplicitSize, FRightFrameSlot, FRightFrameConfiguration);
  end;
  Count := Length(FCalculatedFrameTypeAndFills);
  if FArrangement = la3Vertical then
  begin
    case Count of
      0:
        FCalculatedArrangement := laNone;
      1:
        FCalculatedArrangement := laSingle;
      2:
        FCalculatedArrangement := la2Vertical;
      3:
        FCalculatedArrangement := la3Vertical;
    else
      FCalculatedArrangement := laNone;
    end;
  end
  else
  begin
    case Count of
      0:
        FCalculatedArrangement := laNone;
      1:
        FCalculatedArrangement := laSingle;
      2:
        FCalculatedArrangement := la2Horizontal;
      3:
        FCalculatedArrangement := la3Horizontal;
    else
      FCalculatedArrangement := laNone;
    end;
  end;
  if Count <= 1 then
    FCalculatedTabbed := False
  else
    FCalculatedTabbed := FTabbed;
end;

procedure TLayoutConfiguration.THalf.Check;
begin
  Arrangement := Arrangement;
  CheckSufficientFills;

  CheckExplicitSize(FExplicitSize);
  CheckExplicitSize(FLeftFrameExplicitSize);
  CheckExplicitSize(FMiddleFrameExplicitSize);
  CheckExplicitSize(FRightFrameExplicitSize);
end;

class procedure TLayoutConfiguration.THalf.CheckExplicitSize(var value: Integer);
begin
  if (value >= 0) and (value < MinimumExplicitSize) then
  begin
    value := MinimumExplicitSize;
  end;
end;

procedure TLayoutConfiguration.THalf.CheckSufficientFills;
begin
  case FArrangement of
    laNone: ;
    laSingle, la2Vertical, la2Horizontal, la3Vertical, la3Horizontal:
    begin
      if not FLeftFrameFill and not FMiddleFrameFill and not FRightFrameFill then
      begin
        FLeftFrameFill := True;
      end;
    end;
    la2Left1Right, la2Top1Bottom:
    begin
      if not FLeftFrameFill and not FMiddleFrameFill then
      begin
        FLeftFrameFill := True;
      end;
    end
    else Assert(False);
  end;
end;

constructor TLayoutConfiguration.THalf.Create(myId: THalfId);
begin
  inherited Create;

  FId := myId;
  FArrangement := la3Vertical;
  FTabbed := False;

  FLeftFrameTypeId := TLayoutableFrame.TTypeId.ftNone;
  FLeftFrameFill := False;
  FLeftFrameExplicitSize := -1;
  FMiddleFrameTypeId := TLayoutableFrame.TTypeId.ftNone;
  FMiddleFrameFill := False;
  FMiddleFrameExplicitSize := -1;
  FRightFrameTypeId := TLayoutableFrame.TTypeId.ftNone;
  FRightFrameFill := False;
  FRightFrameExplicitSize := -1;

  if myId = lhA then
  begin
    FLeftFrameSlot := fsALeft;
    FMiddleFrameSlot := fsAMiddle;
    FRightFrameSlot := fsARight;
  end
  else
  begin
    FLeftFrameSlot := fsBLeft;
    FMiddleFrameSlot := fsBMiddle;
    FRightFrameSlot := fsBRight;
  end;

  FCalculatedArrangement := laNone;
  FCalculatedFrameTypeAndFills := nil;
  FCalculatedTabbed := False;
end;

class function TLayoutConfiguration.THalf.HalfIdToXmlValue(value: THalfId): string;
begin
  Result := Enum(value).ToString.Substring(2);
end;

class function TLayoutConfiguration.THalf.LayoutableFrameTypeIdToXmlValue(typeId: TLayoutableFrame.TTypeId): string;
begin
  Result := Enum(typeId).ToString.Substring(2);
end;

procedure TLayoutConfiguration.THalf.Load(element: XmlElement);
var
  ConfigNodes: XmlNodeList;
begin
  if element.HasAttribute(XmlTag_Arrangement) then
  begin
    FArrangement := XmlValueToArrangement(element.GetAttribute(XmlTag_Arrangement));
  end;
  if element.HasAttribute(XmlTag_Tabbed) then
  begin
    FTabbed := XmlValueToBoolean(element.GetAttribute(XmlTag_Tabbed));
  end;
  if element.HasAttribute(XmlTag_ExplicitSize) then
  begin
    FExplicitSize := XmlValueToInteger(element.GetAttribute(XmlTag_ExplicitSize));
  end;

  if element.HasAttribute(XmlTag_LeftFrameTypeId) then
  begin
    FLeftFrameTypeId := XmlValueToLayoutableFrameTypeId(element.GetAttribute(XmlTag_LeftFrameTypeId));
  end;
  if element.HasAttribute(XmlTag_LeftFrameFill) then
  begin
    FLeftFrameFill := XmlValueToBoolean(element.GetAttribute(XmlTag_LeftFrameFill));
  end;
  if element.HasAttribute(XmlTag_LeftFrameExplicitSize) then
  begin
    FLeftFrameExplicitSize := XmlValueToInteger(element.GetAttribute(XmlTag_LeftFrameExplicitSize));
  end;
  ConfigNodes := element.GetElementsByTagName(XmlTag_LeftFrameConfiguration);
  if ConfigNodes.Count > 0 then
  begin
    FLeftFrameConfiguration := ConfigNodes[0] as XmlElement;
  end;

  if element.HasAttribute(XmlTag_MiddleFrameTypeId) then
  begin
    FMiddleFrameTypeId := XmlValueToLayoutableFrameTypeId(element.GetAttribute(XmlTag_MiddleFrameTypeId));
  end;
  if element.HasAttribute(XmlTag_MiddleFrameFill) then
  begin
    FMiddleFrameFill := XmlValueToBoolean(element.GetAttribute(XmlTag_MiddleFrameFill));
  end;
  if element.HasAttribute(XmlTag_MiddleFrameExplicitSize) then
  begin
    FMiddleFrameExplicitSize := XmlValueToInteger(element.GetAttribute(XmlTag_MiddleFrameExplicitSize));
  end;
  ConfigNodes := element.GetElementsByTagName(XmlTag_MiddleFrameConfiguration);
  if ConfigNodes.Count > 0 then
  begin
    FMiddleFrameConfiguration := ConfigNodes[0] as XmlElement;
  end;

  if element.HasAttribute(XmlTag_RightFrameTypeId) then
  begin
    FRightFrameTypeId := XmlValueToLayoutableFrameTypeId(element.GetAttribute(XmlTag_RightFrameTypeId));
  end;
  if element.HasAttribute(XmlTag_RightFrameFill) then
  begin
    FRightFrameFill := XmlValueToBoolean(element.GetAttribute(XmlTag_RightFrameFill));
  end;
  if element.HasAttribute(XmlTag_RightFrameExplicitSize) then
  begin
    FRightFrameExplicitSize := XmlValueToInteger(element.GetAttribute(XmlTag_RightFrameExplicitSize));
  end;
  ConfigNodes := element.GetElementsByTagName(XmlTag_RightFrameConfiguration);
  if ConfigNodes.Count > 0 then
  begin
    FRightFrameConfiguration := ConfigNodes[0] as XmlElement;
  end;
end;

procedure TLayoutConfiguration.THalf.ResetExplicitSizes;
begin
  FExplicitSize := -1;
  FLeftFrameExplicitSize := -1;
  FMiddleFrameExplicitSize := -1;
  FRightFrameExplicitSize := -1;

  Check;
end;

procedure TLayoutConfiguration.THalf.Save(element: XmlElement);
begin
  element.SetAttribute(XmlTag_HalfId, HalfIdToXmlValue(Id));
  element.SetAttribute(XmlTag_Arrangement, ArrangementToXmlValue(Arrangement));
  element.SetAttribute(XmlTag_Tabbed, BooleanToXmlValue(Tabbed));
  element.SetAttribute(XmlTag_ExplicitSize, IntegerToXmlValue(ExplicitSize));

  element.SetAttribute(XmlTag_LeftFrameTypeId, LayoutableFrameTypeIdToXmlValue(LeftFrameTypeId));
  element.SetAttribute(XmlTag_LeftFrameFill, BooleanToXmlValue(LeftFrameFill));
  element.SetAttribute(XmlTag_LeftFrameExplicitSize, IntegerToXmlValue(LeftFrameExplicitSize));
  if Assigned(LeftFrameConfiguration) then
  begin
    element.AppendChild(LeftFrameConfiguration);
  end;

  element.SetAttribute(XmlTag_MiddleFrameTypeId, LayoutableFrameTypeIdToXmlValue(MiddleFrameTypeId));
  element.SetAttribute(XmlTag_MiddleFrameFill, BooleanToXmlValue(MiddleFrameFill));
  element.SetAttribute(XmlTag_MiddleFrameExplicitSize, IntegerToXmlValue(MiddleFrameExplicitSize));
  if Assigned(MiddleFrameConfiguration) then
  begin
    element.AppendChild(MiddleFrameConfiguration);
  end;

  element.SetAttribute(XmlTag_RightFrameTypeId, LayoutableFrameTypeIdToXmlValue(RightFrameTypeId));
  element.SetAttribute(XmlTag_RightFrameFill, BooleanToXmlValue(RightFrameFill));
  element.SetAttribute(XmlTag_RightFrameExplicitSize, IntegerToXmlValue(RightFrameExplicitSize));
  if Assigned(RightFrameConfiguration) then
  begin
    element.AppendChild(RightFrameConfiguration);
  end;
end;

procedure TLayoutConfiguration.THalf.SetArrangement(const Value: TArrangement);
begin
  case Value of
    laNone, laSingle: Arrangement := la3Vertical;
    la2Vertical: Arrangement := la3Vertical;
    la2Horizontal: Arrangement := la3Horizontal;
    la2Left1Right, la2Top1Bottom:
    begin
      FArrangement := Value;
      CheckSufficientFills;
    end;
    la3Vertical, la3Horizontal:
    begin
      FArrangement := Value;
      if FRightFrameFill and (FLeftFrameFill or FMiddleFrameFill) then
      begin
        FRightFrameFill := False;
      end;
      CheckSufficientFills;
    end;
    else Arrangement := la3Vertical;
  end;
end;

procedure TLayoutConfiguration.THalf.SetLeftFrameFill(const Value: Boolean);
begin
  FLeftFrameFill := Value;

  if not FLeftFrameFill then
    CheckSufficientFills
  else
  begin
    FMiddleFrameFill := False;
    case FArrangement of
      la2Left1Right, la2Top1Bottom: ;
      else FRightFrameFill := False;
    end;
  end;
end;

procedure TLayoutConfiguration.THalf.SetMiddleFrameFill(const Value: Boolean);
begin
  FMiddleFrameFill := Value;
  if not FMiddleFrameFill then
    CheckSufficientFills
  else
  begin
    FLeftFrameFill := False;
    case FArrangement of
      la2Left1Right, la2Top1Bottom: ;
      else FRightFrameFill := False;
    end;
  end;
end;

procedure TLayoutConfiguration.THalf.SetRightFrameFill(const Value: Boolean);
begin
  FRightFrameFill := Value;
  if not FRightFrameFill then
    CheckSufficientFills
  else
  begin
    case FArrangement of
      la2Left1Right, la2Top1Bottom: ;
      else
      begin
        FLeftFrameFill := False;
        FMiddleFrameFill := False;
      end;
    end;
  end;
end;

class function TLayoutConfiguration.THalf.XmlValueToHalfId(value: string): THalfId;
begin
  try
    Result := Enum.Parse(TypeOf(THalfId), 'lh' + value, True) as THalfId;
  except
    on ArgumentException do Result := lhNone;
  end;
end;

class function TLayoutConfiguration.THalf.XmlValueToLayoutableFrameTypeId(value: string): TLayoutableFrame.TTypeId;
begin
  try
    Result := Enum.Parse(TypeOf(TLayoutableFrame.TTypeId), 'ft' + value, True) as TLayoutableFrame.TTypeId;
  except
    on ArgumentException do Result := ftNone;
  end;
end;

procedure TLayoutConfiguration.THalf.CalculateDoubleSingle;
var
  DoubleSideCount: Integer;
  SingleSideCount: Integer;
begin
  DoubleSideCount := 2;
  SingleSideCount := 1;
  if FLeftFrameTypeId = TLayoutableFrame.TTypeId.ftNone then
    Dec(DoubleSideCount)
  else
    AddFrameTypeAndFill(LeftFrameTypeId, LeftFrameFill, FLeftFrameExplicitSize, FLeftFrameSlot, FLeftFrameConfiguration);
  if FMiddleFrameTypeId = TLayoutableFrame.TTypeId.ftNone then
    Dec(DoubleSideCount)
  else
    AddFrameTypeAndFill(MiddleFrameTypeId, MiddleFrameFill, FMiddleFrameExplicitSize, FMiddleFrameSlot, FMiddleFrameConfiguration);
  if FRightFrameTypeId = TLayoutableFrame.TTypeId.ftNone then
    Dec(SingleSideCount)
  else
    AddFrameTypeAndFill(RightFrameTypeId, RightFrameFill, FRightFrameExplicitSize, FRightFrameSlot, FRightFrameConfiguration);
  if FArrangement = la2Left1Right then
  begin
    if SingleSideCount = 0 then
    begin
      case DoubleSideCount of
        0:
          FCalculatedArrangement := laNone;
        1:
          FCalculatedArrangement := laSingle;
        2:
          FCalculatedArrangement := la2Vertical;
      else
        FCalculatedArrangement := laNone;
      end;
    end
    else
    begin
      case DoubleSideCount of
        0:
          FCalculatedArrangement := laSingle;
        1:
          FCalculatedArrangement := la2Horizontal;
        2:
          FCalculatedArrangement := la2Left1Right;
      else
        FCalculatedArrangement := laSingle;
      end;
    end;
  end
  else
  begin
    if SingleSideCount = 0 then
    begin
      case DoubleSideCount of
        0:
          FCalculatedArrangement := laNone;
        1:
          FCalculatedArrangement := laSingle;
        2:
          FCalculatedArrangement := la2Horizontal;
      else
        FCalculatedArrangement := laNone;
      end;
    end
    else
    begin
      case DoubleSideCount of
        0:
          FCalculatedArrangement := laSingle;
        1:
          FCalculatedArrangement := la2Vertical;
        2:
          FCalculatedArrangement := la2Top1Bottom;
      else
        FCalculatedArrangement := laSingle;
      end;
    end;
  end;
  if DoubleSideCount < 2 then
    FCalculatedTabbed := False
  else
    FCalculatedTabbed := FTabbed;
end;

{ TLayoutConfigurations }

function TLayoutConfigurations.Add(value: TLayoutConfiguration): Integer;
begin
  Result := InnerList.Add(value);
end;

function TLayoutConfigurations.CalculateUniqueName: string;
const
  BaseName = 'Layout';
var
  Suffix: Integer;
begin
  Suffix := 1;

  while True do
  begin
    Result := BaseName + Suffix.ToString;
    if Assigned(Get(Result)) then
      Inc(Suffix)
    else
      Break;
  end;
end;

function TLayoutConfigurations.Get(name: string): TLayoutConfiguration;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to InnerList.Count - 1 do
  begin
    if system.&String.Compare(Configurations[I].Name, name, True) = 0 then
    begin
      Result := Configurations[I];
      Break;
    end;
  end;
end;

function TLayoutConfigurations.GetConfigurations(idx: Integer): TLayoutConfiguration;
begin
  Result := TLayoutConfiguration(InnerList[idx]);
end;

procedure TLayoutConfigurations.Load(element: XmlElement);
var
  Configurations: XmlNodeList;
  I: Integer;
  Configuration: TLayoutConfiguration;
begin
  Configurations := element.GetElementsByTagName(XmlTag_Configuration);
  for I := 0 to Configurations.Count - 1 do
  begin
    Configuration := New;
    Configuration.Load(Configurations[I] as XmlElement);
  end;
end;

function TLayoutConfigurations.New: TLayoutConfiguration;
begin
  Result := TLayoutConfiguration.Create;
  Result.Name := CalculateUniqueName;
  InnerList.Add(Result);
end;

procedure TLayoutConfigurations.Remove(configuration: TLayoutConfiguration);
begin
  InnerList.Remove(configuration);
end;

procedure TLayoutConfigurations.Save(element: XmlElement);
var
  I: Integer;
  ConfigurationElement: XmlElement;
begin
  for I := 0 to Count - 1 do
  begin
    ConfigurationElement := element.OwnerDocument.CreateElement(XmlTag_Configuration);
    element.AppendChild(configurationElement);
    Configurations[I].Save(configurationElement);
  end;
end;

end.
