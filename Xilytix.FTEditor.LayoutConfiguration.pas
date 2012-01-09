// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.LayoutConfiguration;

interface

uses
  Types,
  Classes,
  XmlIntf,
  Generics.Collections,
  Xilytix.FTEditor.Common,
  Xilytix.FTEditor.TypedXml,
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

      TFrameSlotId = (fsALeft,
                      fsAMiddle,
                      fsARight,
                      fsBLeft,
                      fsBMiddle,
                      fsBRight);

      THalfExplicitSizes = array[THalfId] of Integer;
      TFrameSlotExplicitSizes = array[TFrameSlotId] of Integer;
      TFrameSlotConfig = ITypedXmlElement;
      TFrameSlotConfigs = array[TFrameSlotId] of TFrameSlotConfig;

      TExplicitSizesRec = record
        Main: Integer;
        Halves: THalfExplicitSizes;
        Frames: TFrameSlotExplicitSizes;
      end;

      TFrameTypeAndFillRec = record
        FrameTypeId: TLayoutableFrame.TTypeId;
        Fill: Boolean;
        ExplicitSize: Integer;
        Slot: TFrameSlotId;
//        Config: TFrameSlotConfig;
      end;
      TFrameTypeAndFillRecs = array of TFrameTypeAndFillRec;

      THalf = class
      strict private
        type
          THalfIdInfo = record
            HalfId: THalfId;
            XmlValue: string;
          end;
          THalfIdInfos = array[THalfId] of THalfIdInfo;

        const
          HalfIdInfos: THalfIdInfos =
          (
            (HalfId: lhNone; XmlValue: 'None'),
            (HalfId: lhA; XmlValue: 'A'),
            (HalfId: lhB; XmlValue: 'B')
          );

        var
          FId: THalfId;
          FArrangement: TArrangement;
          FTabbed: Boolean;
          FExplicitSize: Integer;

          FLeftFrameTypeId: TLayoutableFrame.TTypeId;
          FLeftFrameFill: Boolean;
          FLeftFrameExplicitSize: Integer;
          FLeftFrameSlot: TFrameSlotId;
//          FLeftFrameConfiguration: TFrameSlotConfig;
          FMiddleFrameTypeId: TLayoutableFrame.TTypeId;
          FMiddleFrameFill: Boolean;
          FMiddleFrameExplicitSize: Integer;
          FMiddleFrameSlot: TFrameSlotId;
//          FMiddleFrameConfiguration: TFrameSlotConfig;
          FRightFrameTypeId: TLayoutableFrame.TTypeId;
          FRightFrameFill: Boolean;
          FRightFrameExplicitSize: Integer;
          FRightFrameSlot: TFrameSlotId;
//          FRightFrameConfiguration: TFrameSlotConfig;

          FCalculatedArrangement: TArrangement;
          FCalculatedFrameTypeAndFills: TFrameTypeAndFillRecs;
          FCalculatedTabbed: Boolean;

        class constructor Create;

        procedure AddFrameTypeAndFill(frameTypeId: TLayoutableFrame.TTypeId; fill: Boolean; explicitSize: Integer;
                                      slot: TFrameSlotId{; const config: TFrameSlotConfig});
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
//        property LeftFrameConfiguration: TFrameSlotConfig read FLeftFrameConfiguration;
        property MiddleFrameTypeId: TLayoutableFrame.TTypeId read FMiddleFrameTypeId write FMiddleFrameTypeId;
        property MiddleFrameFill: Boolean read FMiddleFrameFill write SetMiddleFrameFill;
        property MiddleFrameExplicitSize: Integer read FMiddleFrameExplicitSize;
//        property MiddleFrameConfiguration: TFrameSlotConfig read FMiddleFrameConfiguration;
        property RightFrameTypeId: TLayoutableFrame.TTypeId read FRightFrameTypeId write FRightFrameTypeId;
        property RightFrameFill: Boolean read FRightFrameFill write SetRightFrameFill;
        property RightFrameExplicitSize: Integer read FRightFrameExplicitSize;
//        property RightFrameConfiguration: TFrameSlotConfig read FRightFrameConfiguration;

        procedure Calculate;
        procedure Check;

        property CalculatedArrangement: TArrangement read FCalculatedArrangement;
        property CalculatedIdFills: TFrameTypeAndFillRecs read FCalculatedFrameTypeAndFills;
        property CalculatedTabbed: Boolean read FCalculatedTabbed;

//        procedure AssignFrameSlotConfigs(configs: TFrameSlotConfigs);
        procedure AssignExplicitSizes(myExplicitSize: Integer; frameSlotExplicitSizes: TFrameSlotExplicitSizes);
        procedure ResetExplicitSizes;

        procedure LoadFromXml(element: ITypedXmlElement;
                       out LeftFrame, MiddleFrame, RightFrame: ITypedXmlElement);
        procedure SaveToXml(element: ITypedXmlElement);

        class function HalfIdToXmlValue(value: THalfId): string;
        class function XmlValueToHalfId(const value: string): THalfId;
        class function LayoutableFrameTypeIdToXmlValue(typeId: TLayoutableFrame.TTypeId): string;
        class function XmlValueToLayoutableFrameTypeId(const value: string): TLayoutableFrame.TTypeId;

        class procedure CheckExplicitSize(var value: Integer);
      end;

      THalfAndFillRec = record
        Half: THalf;
        Fill: Boolean;
//        ExplicitSize: Integer;
      end;

      THalfAndFillRecs = array of THalfAndFillRec;

  strict private
    type
      TArrangementInfo = record
        Arrangement: TArrangement;
        XmlValue: string;
      end;
      TArrangementInfos = array[TArrangement] of TArrangementInfo;

      TFrameSlotInfo = record
        FrameSlot: TFrameSlotId;
        XmlValue: string;
      end;
      TFrameSlotInfos = array[TFrameSlotId] of TFrameSlotInfo;

    const
      SavedExtension = 'xml';
      SavedPrefix = 'slc';

      ArrangementInfos: TArrangementInfos =
      (
        (Arrangement: laNone; XmlValue: 'None'),
        (Arrangement: laSingle; XmlValue: 'Single'),
        (Arrangement: la2Vertical; XmlValue: '2Vertical'),
        (Arrangement: la2Horizontal; XmlValue: '2Horizontal'),
        (Arrangement: la2Left1Right; XmlValue: '2Left1Right'),
        (Arrangement: la2Top1Bottom; XmlValue: '2Top1Bottom'),
        (Arrangement: la3Vertical; XmlValue: '3Vertical'),
        (Arrangement: la3Horizontal; XmlValue: '3Horizontal')
      );

      FrameSlotInfos: TFrameSlotInfos =
      (
        (FrameSlot: fsALeft; XmlValue: 'ALeft'),
        (FrameSlot: fsAMiddle; XmlValue: 'AMiddle'),
        (FrameSlot: fsARight; XmlValue: 'ARight'),
        (FrameSlot: fsBLeft; XmlValue: 'BLeft'),
        (FrameSlot: fsBMiddle; XmlValue: 'BMiddle'),
        (FrameSlot: fsBRight; XmlValue: 'BRight')
      );

      XmlTag_Root = 'LayoutConfiguration';

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

      TrueBooleanXmlValue = 'True';
      FalseBooleanXmlValue = 'False';

    var
      FName: string;
      FXMLDocument: ITypedXMLDocument;
      FFrameSlotConfigs: TFrameSlotConfigs;

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

    class constructor Create;

    class function ArrangementToXmlValue(value: TArrangement): string;
    class function XmlValueToArrangement(const value: string): TArrangement;

    class function NameToFileName(const value: string): string;
    class function NameToFilePath(const value: string): string;
    class function TryFileNameToName(const fileName: string; out Name: string): Boolean;

    procedure SaveToXml(element: ITypedXmlElement);
    procedure LoadFromXml(element: ITypedXmlElement);

    procedure SetHalvesArrangement(const Value: TArrangement);
  public
    constructor Create(const MyName: string; MyXmlDocument: ITypedXMLDocument);

    property Name: string read FName write FName;
    property FrameSlotConfigs: TFrameSlotConfigs read FFrameSlotConfigs;

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

//    procedure AssignFrameSlotConfigs(configs: TFrameSlotConfigs);
    procedure AssignExplicitSizes(const explicitSizes: TExplicitSizesRec);
    procedure ResetExplicitSizes;

    class function IntegerToXmlValue(value: Integer): string;
    class function XmlValueToInteger(const value: string): Integer;
    class function BooleanToXmlValue(value: Boolean): string;
    class function XmlValueToBoolean(const value: string): Boolean;

    class function Exists(const LayoutConfigurationName: string): Boolean;
    class function CreateFromFile(const LayoutConfigurationName: string): TLayoutConfiguration;
    procedure SaveToFile;

//    class function GenerateBlankFrameSlotConfigs: TFrameSlotConfigs;
    class function GetFrameSlotConfigElementName(slot: TFrameSlotId): string;

    class function GetSavedNames(const FolderPath: string): TStringDynArray;
  end;

{  TLayoutConfigurations = class(TObjectList<TLayoutConfiguration>)
  strict private
    const
      XmlTag_Configuration = 'Configuration';

//    function GetConfigurations(idx: Integer): TLayoutConfiguration;
    function CalculateUniqueName: string;
  public
//    property Configurations[idx: Integer]: TLayoutConfiguration read GetConfigurations; default;
    function New: TLayoutConfiguration;
    function Get(name: string): TLayoutConfiguration;

    procedure SaveToXml(element: ITypedXmlElement);
    procedure LoadFromXml(element: ITypedXmlElement;
                          out ALeftFrame, AMiddleFrame, ARightFrame: ITypedXmlElement;
                          out BLeftFrame, BMiddleFrame, BRightFrame: ITypedXmlElement);
    procedure LoadFromDefault;
  end;  }

implementation

uses
  SysUtils,
  IOUtils,
  Xilytix.FieldedText.Utils,
  Xilytix.FTEditor.MainPropertiesFrame,
  Xilytix.FTEditor.FieldsFrame,
  Xilytix.FTEditor.GridViewFrame,
  Xilytix.FTEditor.TextViewFrame,
  Xilytix.FTEditor.ErrorsFrame;

{ TLayoutConfiguration }

class function TLayoutConfiguration.ArrangementToXmlValue(value: TArrangement): string;
begin
  Result := ArrangementInfos[Value].XmlValue;
end;

procedure TLayoutConfiguration.AssignExplicitSizes(const explicitSizes: TExplicitSizesRec);
begin
  FExplicitSize := explicitSizes.Main;
  FHalfA.AssignExplicitSizes(explicitSizes.Halves[lha], explicitSizes.Frames);
  FHalfB.AssignExplicitSizes(explicitSizes.Halves[lhb], explicitSizes.Frames);
end;

{procedure TLayoutConfiguration.AssignFrameSlotConfigs(configs: TFrameSlotConfigs);
begin
  FHalfA.AssignFrameSlotConfigs(configs);
  FHalfB.AssignFrameSlotConfigs(configs);
end;}

class function TLayoutConfiguration.BooleanToXmlValue(value: Boolean): string;
begin
  Result := BoolToInvariantStr(Value);
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

class constructor TLayoutConfiguration.Create;
var
  Arrangement: TArrangement;
  Slot: TFrameSlotId;
begin
  for Arrangement := Low(TArrangement) to High(TArrangement) do
  begin
    if ArrangementInfos[Arrangement].Arrangement <> Arrangement then
    begin
      raise Exception.Create('ArrangementInfos out of order');
    end;
  end;

  for Slot := Low(TFrameSlotId) to High(TFrameSlotId) do
  begin
    if FrameSlotInfos[Slot].FrameSlot <> Slot then
    begin
      raise Exception.Create('FrameSlotInfos out of order');
    end;
  end;
end;

constructor TLayoutConfiguration.Create(const MyName: string; MyXmlDocument: ITypedXMLDocument);
begin
  inherited Create;

  FName := MyName;
  FXmlDocument := MyXmlDocument;

  FHalfA := THalf.Create(lhA);
  FHalfB := THalf.Create(lhB);

  FHalvesArrangement := la2Horizontal;
  FTabbed := False;

  FLeftHalfId := lhA;
  FRightHalfId := lhB;
  FLeftHalfFill := False;
  FExplicitSize := -1;

  FCalculatedHalvesArrangement := laNone;
  FCalculatedHalfAndFillRecs := nil;

  if Assigned(FXmlDocument) then
  begin
    LoadFromXml(MyXmlDocument.RootElement);
  end;
end;

class function TLayoutConfiguration.CreateFromFile(
  const LayoutConfigurationName: string): TLayoutConfiguration;
var
  FilePath: string;
  XMLDocument: ITypedXMLDocument;
  Strm: TFileStream;
begin
  FilePath := NameToFilePath(LayoutConfigurationName);
  if not FileExists(FilePath) then
    Result := nil
  else
  begin
    Strm := TFileStream.Create(FilePath, fmOpenRead or fmShareDenyWrite);
    try
      XMLDocument := TTypedXmlDocument.Create('');
      XMLDocument.LoadFromStream(Strm);
    finally
      Strm.Free;
    end;

    Result := TLayoutConfiguration.Create(LayoutConfigurationName, XmlDocument);
  end;
end;

class function TLayoutConfiguration.Exists(
  const LayoutConfigurationName: string): Boolean;
var
  FilePath: string;
begin
  FilePath := NameToFilePath(LayoutConfigurationName);
  Result := TFile.Exists(FilePath);
end;

{class function TLayoutConfiguration.GenerateBlankFrameSlotConfigs: TFrameSlotConfigs;
begin
  Result[fsALeft] := doc.CreateElement(XmlTag_LeftFrameConfiguration);
  Result[fsAMiddle] := doc.CreateElement(XmlTag_MiddleFrameConfiguration);
  Result[fsARight] := doc.CreateElement(XmlTag_RightFrameConfiguration);
  Result[fsBLeft] := doc.CreateElement(XmlTag_LeftFrameConfiguration);
  Result[fsBMiddle] := doc.CreateElement(XmlTag_MiddleFrameConfiguration);
  Result[fsBRight] := doc.CreateElement(XmlTag_RightFrameConfiguration);
end;}

class function TLayoutConfiguration.GetFrameSlotConfigElementName(slot: TFrameSlotId): string;
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

class function TLayoutConfiguration.GetSavedNames(
  const FolderPath: string): TStringDynArray;
var
  I: Integer;
  FileNames: TStringDynArray;
  Name: string;
  Count: Integer;
begin
  TCommon.EnsureLayoutConfigurationsFolderExists;
  FileNames := TDirectory.GetFiles(FolderPath, SavedPrefix + '*.' + SavedExtension);
  Count := 0;
  SetLength(Result, Length(FileNames));
  for I := Low(FileNames) to High(FileNames) do
  begin
    if TryFileNameToName(FileNames[I], Name) then
    begin
      Result[Count] := Name;
      Inc(Count);
    end;
  end;
  SetLength(Result, Count);
end;

class function TLayoutConfiguration.IntegerToXmlValue(value: Integer): string;
begin
  Result := IntToInvariantStr(value);
end;

procedure TLayoutConfiguration.LoadFromXml(element: ITypedXmlElement);
var
  ChildNode: IXmlNode;
  HalfElement: ITypedXmlElement;
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

  for I := 0 to Element.ChildNodes.Count - 1 do
  begin
    ChildNode := Element.ChildNodes[I];
    if (ChildNode.NodeType = ntElement) and (ChildNode.NodeName = XmlTag_Half) then
    begin
      HalfElement := ChildNode as ITypedXmlElement;
      if HalfElement.HasAttribute(XmlTag_HalfId) then
      begin
        HalfId := THalf.XmlValueToHalfId(HalfElement.GetAttribute(XmlTag_HalfId));
        case HalfId of
          lhNone: ;
          lhA: HalfA.LoadFromXml(HalfElement, FFrameSlotConfigs[fsALeft], FFrameSlotConfigs[fsAMiddle], FFrameSlotConfigs[fsARight]);
          lhB: HalfB.LoadFromXml(HalfElement, FFrameSlotConfigs[fsBLeft], FFrameSlotConfigs[fsBMiddle], FFrameSlotConfigs[fsBRight]);
          else ;
        end;
      end;
    end;
  end;

  Check;
end;

class function TLayoutConfiguration.NameToFileName(const value: string): string;
begin
  Result := SavedPrefix + TCommon.SafeFileNameEncode(value) + '.' + SavedExtension;
end;

class function TLayoutConfiguration.NameToFilePath(const value: string): string;
begin
  Result := NameToFileName(value);
  Result := TPath.Combine(TCommon.LayoutConfigurationsFolder, Result);
end;

procedure TLayoutConfiguration.ResetExplicitSizes;
begin
  FExplicitSize := -1;
  FHalfA.ResetExplicitSizes;;
  FHalfB.ResetExplicitSizes;
end;

procedure TLayoutConfiguration.SaveToFile;
var
  FilePath: string;
  XMLDocument: ITypedXmlDocument;
  RootNode: ITypedXmlElement;
  Strm: TFileStream;
begin
  TCommon.EnsureLayoutConfigurationsFolderExists;

  FilePath := NameToFilePath(Name);
  XMLDocument := TTypedXmlDocument.Create('');
  XMLDocument.Active := True;
  RootNode := XMLDocument.AddElement(XmlTag_Root);

  SaveToXml(RootNode);

  Strm := TFileStream.Create(FilePath, fmCreate or fmShareExclusive);
  try
    XmlDocument.SaveToStream(Strm);
  finally
    Strm.Free;
  end;
end;

procedure TLayoutConfiguration.SaveToXml(element: ITypedXmlElement);
var
  halfElement: ITypedXmlElement;
begin
  element.SetAttribute(XmlTag_Name, Name);
  element.SetAttribute(XmlTag_Arrangement, ArrangementToXmlValue(Arrangement));
  element.SetAttribute(XmlTag_Tabbed, BooleanToXmlValue(Tabbed));
  element.SetAttribute(XmlTag_LeftHalfId, THalf.HalfIdToXmlValue(LeftHalfId));
  element.SetAttribute(XmlTag_RightHalfId, THalf.HalfIdToXmlValue(RightHalfId));
  element.SetAttribute(XmlTag_LeftHalfFill, BooleanToXmlValue(LeftHalfFill));
  element.SetAttribute(XmlTag_ExplicitSize, IntegerToXmlValue(ExplicitSize));

  halfElement := element.AddElement(XmlTag_Half);
  HalfA.SaveToXml(halfElement);

  halfElement := element.AddElement(XmlTag_Half);
  HalfB.SaveToXml(halfElement);
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

class function TLayoutConfiguration.TryFileNameToName(const fileName: string;
  out Name: string): Boolean;
var
  NoExtFileName: string;
  EncodedName: string;
begin
  NoExtFileName := TPath.GetFileNameWithoutExtension(fileName);
  EncodedName := Copy(NoExtFileName, Length(SavedPrefix) + 1, MaxInt);
  Result := TCommon.TrySafeFileNameDecode(EncodedName, Name);
end;

class function TLayoutConfiguration.XmlValueToArrangement(const value: string): TArrangement;
var
  I: TArrangement;
begin
  Result := laNone;
  for I := Low(ArrangementInfos) to High(ArrangementInfos) do
  begin
    if SameText(Value, ArrangementInfos[I].XmlValue) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

class function TLayoutConfiguration.XmlValueToBoolean(const value: string): Boolean;
begin
  if not TryInvariantStrToBool(value, Result) then
  begin
    Result := False;
  end;
end;

class function TLayoutConfiguration.XmlValueToInteger(const value: string): Integer;
begin
  if not TryInvariantStrToInt(value, Result) then
  begin
    Result := -1;
  end;
end;

{ TLayoutConfiguration.THalf }

procedure TLayoutConfiguration.THalf.AddFrameTypeAndFill(frameTypeId: TLayoutableFrame.TTypeId;
                                                         fill: Boolean;
                                                         explicitSize: Integer;
                                                         slot: TFrameSlotId{;
                                                         const config: TFrameSlotConfig});
var
  Idx: Integer;
begin
  Idx := Length(FCalculatedFrameTypeAndFills);
  SetLength(FCalculatedFrameTypeAndFills, Idx+1);
  FCalculatedFrameTypeAndFills[Idx].FrameTypeId := frameTypeId;
  FCalculatedFrameTypeAndFills[Idx].Fill := fill;
  FCalculatedFrameTypeAndFills[Idx].ExplicitSize := explicitSize;
  FCalculatedFrameTypeAndFills[Idx].Slot := slot;
//  FCalculatedFrameTypeAndFills[Idx].Config := config;
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

{procedure TLayoutConfiguration.THalf.AssignFrameSlotConfigs(configs: TFrameSlotConfigs);
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
end;}

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
    AddFrameTypeAndFill(FLeftFrameTypeId, FLeftFrameFill, FLeftFrameExplicitSize, FLeftFrameSlot{, FLeftFrameConfiguration});
  end;
  if FMiddleFrameTypeId <> TLayoutableFrame.TTypeId.ftNone then
  begin
    AddFrameTypeAndFill(FMiddleFrameTypeId, FMiddleFrameFill, FMiddleFrameExplicitSize, FMiddleFrameSlot{, FMiddleFrameConfiguration});
  end;
  if FRightFrameTypeId <> TLayoutableFrame.TTypeId.ftNone then
  begin
    AddFrameTypeAndFill(FRightFrameTypeId, FRightFrameFill, FRightFrameExplicitSize, FRightFrameSlot{, FRightFrameConfiguration});
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

class constructor TLayoutConfiguration.THalf.Create;
var
  HalfId: THalfId;
begin
  for HalfId := Low(THalfId) to High(THalfId) do
  begin
    if HalfIdInfos[HalfId].HalfId <> HalfId then
    begin
      raise Exception.Create('HalfIdInfos out of order');
    end;
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
  Result := HalfIdInfos[Value].XmlValue;
end;

class function TLayoutConfiguration.THalf.LayoutableFrameTypeIdToXmlValue(typeId: TLayoutableFrame.TTypeId): string;
begin
  Result := TLayoutableFrame.TypeIdToXmlValue(TypeId);
end;

procedure TLayoutConfiguration.THalf.LoadFromXml(element: ITypedXmlElement;
                                          out LeftFrame, MiddleFrame, RightFrame: ITypedXmlElement);
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
  LeftFrame := element.FindElement(XmlTag_LeftFrameConfiguration);

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
  MiddleFrame := element.FindElement(XmlTag_MiddleFrameConfiguration);

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
  RightFrame := element.FindElement(XmlTag_RightFrameConfiguration);
end;

procedure TLayoutConfiguration.THalf.ResetExplicitSizes;
begin
  FExplicitSize := -1;
  FLeftFrameExplicitSize := -1;
  FMiddleFrameExplicitSize := -1;
  FRightFrameExplicitSize := -1;

  Check;
end;

procedure TLayoutConfiguration.THalf.SaveToXml(element: ITypedXmlElement);
begin
  element.SetAttribute(XmlTag_HalfId, HalfIdToXmlValue(Id));
  element.SetAttribute(XmlTag_Arrangement, ArrangementToXmlValue(Arrangement));
  element.SetAttribute(XmlTag_Tabbed, BooleanToXmlValue(Tabbed));
  element.SetAttribute(XmlTag_ExplicitSize, IntegerToXmlValue(ExplicitSize));

  element.SetAttribute(XmlTag_LeftFrameTypeId, LayoutableFrameTypeIdToXmlValue(LeftFrameTypeId));
  element.SetAttribute(XmlTag_LeftFrameFill, BooleanToXmlValue(LeftFrameFill));
  element.SetAttribute(XmlTag_LeftFrameExplicitSize, IntegerToXmlValue(LeftFrameExplicitSize));
//  ChildElement := element.AddElement(XmlTag_LeftFrameConfiguration);
//  LeftFrameConfiguration.SaveToXml(ChildElement);

  element.SetAttribute(XmlTag_MiddleFrameTypeId, LayoutableFrameTypeIdToXmlValue(MiddleFrameTypeId));
  element.SetAttribute(XmlTag_MiddleFrameFill, BooleanToXmlValue(MiddleFrameFill));
  element.SetAttribute(XmlTag_MiddleFrameExplicitSize, IntegerToXmlValue(MiddleFrameExplicitSize));
//  ChildElement := element.AddElement(XmlTag_MiddleFrameConfiguration);
//  MiddleFrameConfiguration.SaveToXml(ChildElement);

  element.SetAttribute(XmlTag_RightFrameTypeId, LayoutableFrameTypeIdToXmlValue(RightFrameTypeId));
  element.SetAttribute(XmlTag_RightFrameFill, BooleanToXmlValue(RightFrameFill));
  element.SetAttribute(XmlTag_RightFrameExplicitSize, IntegerToXmlValue(RightFrameExplicitSize));
//  ChildElement := element.AddElement(XmlTag_RightFrameConfiguration);
//  RightFrameConfiguration.SaveToXml(ChildElement);
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

class function TLayoutConfiguration.THalf.XmlValueToHalfId(const value: string): THalfId;
var
  Id: THalfId;
begin
  Result := lhNone;
  for Id := Low(HalfIdInfos) to High(HalfIdInfos) do
  begin
    if SameText(HalfIdInfos[Id].XmlValue, value) then
    begin
      Result := Id;
      Break;
    end;
  end;
end;

class function TLayoutConfiguration.THalf.XmlValueToLayoutableFrameTypeId(const value: string): TLayoutableFrame.TTypeId;
begin
  if not TLayoutableFrame.TryXmlValueToTypeId(Value, Result) then
  begin
    Result := ftNone;
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
    AddFrameTypeAndFill(LeftFrameTypeId, LeftFrameFill, FLeftFrameExplicitSize, FLeftFrameSlot{, FLeftFrameConfiguration});
  if FMiddleFrameTypeId = TLayoutableFrame.TTypeId.ftNone then
    Dec(DoubleSideCount)
  else
    AddFrameTypeAndFill(MiddleFrameTypeId, MiddleFrameFill, FMiddleFrameExplicitSize, FMiddleFrameSlot{, FMiddleFrameConfiguration});
  if FRightFrameTypeId = TLayoutableFrame.TTypeId.ftNone then
    Dec(SingleSideCount)
  else
    AddFrameTypeAndFill(RightFrameTypeId, RightFrameFill, FRightFrameExplicitSize, FRightFrameSlot{, FRightFrameConfiguration});
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

{function TLayoutConfigurations.CalculateUniqueName: string;
const
  BaseName = 'Layout';
var
  Suffix: Integer;
begin
  Suffix := 1;

  while True do
  begin
    Result := BaseName + IntToStr(Suffix);
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
  for I := 0 to Count - 1 do
  begin
    if SameText(Items[I].Name, name) then
    begin
      Result := Items[I];
      Break;
    end;
  end;
end;

function TLayoutConfigurations.GetConfigurations(idx: Integer): TLayoutConfiguration;
begin
  Result := TLayoutConfiguration(InnerList[idx]);
end;

procedure TLayoutConfigurations.LoadFromDefault;
begin

end;

procedure TLayoutConfigurations.LoadFromXml(element: ITypedXmlElement;
                                            out ALeftFrame, AMiddleFrame, ARightFrame: ITypedXmlElement;
                                            out BLeftFrame, BMiddleFrame, BRightFrame: ITypedXmlElement);
var
  I: Integer;
  ChildNode: IXmlNode;
  Configuration: TLayoutConfiguration;
begin
  for I := 0 to element.ChildNodes.Count - 1 do
  begin
    ChildNode := element.ChildNodes[I];
    if (ChildNode.NodeType = ntElement) and SameText(ChildNode.NodeName, XmlTag_Configuration) then
    begin
      Configuration := New;
      Configuration.LoadFromXml(ChildNode as ITypedXmlElement);
    end;
  end;
end;

function TLayoutConfigurations.New: TLayoutConfiguration;
begin
  Result := TLayoutConfiguration.Create;
  Result.Name := CalculateUniqueName;
  Add(Result);
end;

procedure TLayoutConfigurations.SaveToXml(element: ITypedXmlElement);
var
  I: Integer;
  ConfigurationElement: ITypedXmlElement;
begin
  for I := 0 to Count - 1 do
  begin
    ConfigurationElement := element.AddElement(XmlTag_Configuration);
    Items[I].Save(configurationElement);
  end;
end;}

end.
