// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.Colors;

interface

uses
  System.Runtime.Serialization,
  System.Xml.Serialization,
  Borland.Vcl.Graphics,
  Xilytix.FTEditor.Common;

type
  TColorItemId =
  (
    ciActiveFrameHeader,
    ciSelectableFrameHeader,
    ciReadOnlyFrameHeader,
    ciControlOk,
    ciControlWarning,
    ciControlError,
    ciTextView,
    ciGridView,

    ciFieldNamesRow,
    ciHeadingRow,
    ciHeadingRowError,
    ciNewTableRecordRow,
    ciNewTableRecordRowAlt,
    ciNewTableRecordRowError,
    ciRecordRow,
    ciRecordRowAlt,
    ciRecordRowError,
    ciMouseOverRow,
    ciMouseOverRowError,

    ciFieldNamesColumn,

    ciHeadingColumnMod0,
    ciHeadingColumnMod1,
    ciHeadingColumnMod2,
    ciHeadingColumnMod3,
    ciHeadingColumnError,

    ciRecordColumnMod0,
    ciRecordColumnMod0Alt,
    ciRecordColumnMod1,
    ciRecordColumnMod1Alt,
    ciRecordColumnMod2,
    ciRecordColumnMod2Alt,
    ciRecordColumnMod3,
    ciRecordColumnMod3Alt,

    ciRecordCellError,
    ciMouseOverCell,
    ciMouseOverCellError,
    ciFocusedCell,

    ciFocusedCellError,
    ciBeyondBoundary
  );

  TResolvedColorId =
  (
    rcActiveFrameHeader,
    rcSelectableFrameHeader,
    rcReadOnlyFrameHeader,
    rcControlOk,
    rcControlWarning,
    rcControlError,
    rcTextView,
    rcGridView,

    rcGridFieldNamesRow,
    rcGridHeadingRow,
    rcGridHeadingRowError,
    rcGridNewTableRecordRow,
    rcGridNewTableRecordRowAlt,
    rcGridNewTableRecordRowError,
    rcGridRecordRow,
    rcGridRecordRowAlt,
    rcGridRecordRowError,
    rcGridMouseOverRow,
    rcGridMouseOverRowError,

    rcGridFieldNamesColumn,

    rcGridHeadingColumnMod0,
    rcGridHeadingColumnMod1,
    rcGridHeadingColumnMod2,
    rcGridHeadingColumnMod3,
    rcGridHeadingColumnError,

    rcGridRecordColumnMod0,
    rcGridRecordColumnMod1,
    rcGridRecordColumnMod2,
    rcGridRecordColumnMod3,
    rcGridRecordColumnMod0Alt,
    rcGridRecordColumnMod1Alt,
    rcGridRecordColumnMod2Alt,
    rcGridRecordColumnMod3Alt,

    rcGridRecordCellError,
    rcGridMouseOverCell,
    rcGridMouseOverCellError,
    rcGridFocusedCell,
    rcGridFocusedCellError,

    rcGridBeyondBoundary
  );

  TColorItemValue = record
    [XmlAttribute]
    Id: TColorItemId;
    [XmlIgnore]
    Background: TColor;
    [XmlAttribute]
    BackgroundAsString: string;
    [XmlIgnore]
    Font: TColor;
    [XmlAttribute]
    FontAsString: string;
    [XmlAttribute]
    FontStyles: TFontStyles;

    procedure StringsToColors;
    procedure ColorsToStrings;
  end;
  TColorItemValues = array[TColorItemId] of TColorItemValue;

  TColorScheme = class
  strict private
    FName: string;
    FValues: TColorItemValues;
  public
    const
      DefaultSchemeName = '<Default>';
      FileExtension = 'ftecs';
      FileNameFirstChar = TCommon.SafeFileNamePrefix;


    property Name: string read FName write FName;
    property Values: TColorItemValues read FValues write FValues;

    constructor Create; overload;
    constructor Create(myName: string; myValues: TColorItemValues); overload;
    class function CreateFromFile(schemeName: string): TColorScheme;
    procedure SaveToFile;

    class function IsDefaultName(value: string): Boolean;
    class function NameToFileName(value: string): string;
    class function TryFileNameToName(fileName: string; out schemeName: string): Boolean;
    class function NameToFilePath(value: string): string;
  end;


  TResolvedColor = record
    Background: TColor;
    Font: TColor;
    FontStyles: TFontStyles;
  end;
  TResolvedColors = array[TResolvedColorId] of TResolvedColor;

  TColorItems = class
  strict private
    type
      TColorItemConstant = record
        Id: TColorItemId;
        Name: string;
        Example: TResolvedColorId;
        IgnoreBackground: Boolean;
        IgnoreFont: Boolean;
      end;
      TColorItemConstants = array[TColorItemId] of TColorItemConstant;

      TSurface = (sfText, sfGrid, sfOther);

      TResolver = record
        Id: TResolvedColorId;
        Surface: TSurface;
        ItemId: TColorItemId;
      end;
      TResolvers = array[TResolvedColorId] of TResolver;

    const
      Constants: TColorItemConstants =
      (
        (Id: ciActiveFrameHeader; Name: 'Active Frame Header'; Example: rcActiveFrameHeader; IgnoreFont: True),
        (Id: ciSelectableFrameHeader; Name: 'Selectable Frame Header'; Example: rcSelectableFrameHeader; IgnoreFont: True),
        (Id: ciReadOnlyFrameHeader; Name: 'Read Only Frame Header'; Example: rcReadOnlyFrameHeader; IgnoreFont: True),
        (Id: ciControlOk; Name: 'Control Ok'; Example: rcControlOk),
        (Id: ciControlWarning; Name: 'Control Warning'; Example: rcControlWarning),
        (Id: ciControlError; Name: 'Control Error'; Example: rcControlError),
        (Id: ciTextView; Name: 'Text View'; Example: rcTextView),
        (Id: ciGridView; Name: 'Grid View'; Example: rcGridView),

        (Id: ciFieldNamesRow; Name: 'Field Names Marker'; Example: rcGridFieldNamesRow),

        (Id: ciHeadingRow; Name: 'Heading Marker'; Example: rcGridHeadingRow),
        (Id: ciHeadingRowError; Name: 'Heading Error Marker'; Example: rcGridHeadingRowError),
        (Id: ciNewTableRecordRow; Name: 'New Table Marker'; Example: rcGridNewTableRecordRow),
        (Id: ciNewTableRecordRowAlt; Name: 'New Table Alt Marker'; Example: rcGridNewTableRecordRowAlt),
        (Id: ciNewTableRecordRowError; Name: 'New Table Error Marker'; Example: rcGridNewTableRecordRowError),
        (Id: ciRecordRow; Name: 'Record Marker'; Example: rcGridRecordRow),
        (Id: ciRecordRowAlt; Name: 'Record Alt Marker'; Example: rcGridRecordRowAlt),
        (Id: ciRecordRowError; Name: 'Record Error Marker'; Example: rcGridRecordRowError),
        (Id: ciMouseOverRow; Name: 'Mouse Over Heading Marker'; Example: rcGridMouseOverRow),
        (Id: ciMouseOverRowError; Name: 'Mouse Over Heading Error Marker'; Example: rcGridMouseOverRowError),

        (Id: ciFieldNamesColumn; Name: 'Field Names Column'; Example: rcGridFieldNamesColumn),

        (Id: ciHeadingColumnMod0; Name: 'Heading Column Mod 0'; Example: rcGridHeadingColumnMod0),
        (Id: ciHeadingColumnMod1; Name: 'Heading Column Mod 1'; Example: rcGridHeadingColumnMod1),
        (Id: ciHeadingColumnMod2; Name: 'Heading Column Mod 2'; Example: rcGridHeadingColumnMod2),
        (Id: ciHeadingColumnMod3; Name: 'Heading Column Mod 3'; Example: rcGridHeadingColumnMod3),
        (Id: ciHeadingColumnError; Name: 'Heading Column Error'; Example: rcGridHeadingColumnError),

        (Id: ciRecordColumnMod0; Name: 'Record Column Mod 0'; Example: rcGridRecordColumnMod0),
        (Id: ciRecordColumnMod0Alt; Name: 'Record Column Mod 0 Alt'; Example: rcGridRecordColumnMod0Alt),
        (Id: ciRecordColumnMod1; Name: 'Record Column Mod 1'; Example: rcGridRecordColumnMod1),
        (Id: ciRecordColumnMod1Alt; Name: 'Record Column Mod 1 Alt'; Example: rcGridRecordColumnMod1Alt),
        (Id: ciRecordColumnMod2; Name: 'Record Column Mod 2'; Example: rcGridRecordColumnMod2),
        (Id: ciRecordColumnMod2Alt; Name: 'Record Column Mod 2 Alt'; Example: rcGridRecordColumnMod2Alt),
        (Id: ciRecordColumnMod3; Name: 'Record Column Mod 3'; Example: rcGridRecordColumnMod3),
        (Id: ciRecordColumnMod3Alt; Name: 'Record Column Mod 3 Alt'; Example: rcGridRecordColumnMod3Alt),

        (Id: ciRecordCellError; Name: 'Record Cell Error'; Example: rcGridRecordCellError),
        (Id: ciMouseOverCell; Name: 'Mouse Over Cell'; Example: rcGridMouseOverCell),
        (Id: ciMouseOverCellError; Name: 'Mouse Over Cell Error'; Example: rcGridMouseOverCellError),
        (Id: ciFocusedCell; Name: 'Focused Cell'; Example: rcGridFocusedCell),
        (Id: ciFocusedCellError; Name: 'Focused Cell Error'; Example: rcGridFocusedCellError),

        (Id: ciBeyondBoundary; Name: 'BeyondBoundary'; Example: rcGridBeyondBoundary)
      );

      DefaultValues: TColorItemValues =
      (
        (Id: ciActiveFrameHeader;   Background: clMoneyGreen; Font: clBlack),
        (Id: ciSelectableFrameHeader; Background: clBtnFace; Font: clBlack),
        (Id: ciReadOnlyFrameHeader; Background: $00E2ECF5; Font: clBlack),
        (Id: ciControlOk;           Background: clWhite; Font: clBlack),
        (Id: ciControlWarning;      Background: clYellow; Font: clBlack),
        (Id: ciControlError;        Background: clRed;   Font: clBlack),
        (Id: ciTextView;            Background: clWhite; Font: clBlack),
        (Id: ciGridView;            Background: clWhite; Font: clBlack),

        (Id: ciFieldNamesRow; Background: clBtnFace; Font: clDefault),

        (Id: ciHeadingRow; Background: $009FA9AE; Font: clDefault),
        (Id: ciHeadingRowError; Background: $009FA9AE; Font: clRed),
        (Id: ciNewTableRecordRow; Background: $00CFD6DA; Font: clDefault; FontStyles: [fsUnderline]),
        (Id: ciNewTableRecordRowAlt; Background: $00C2CBCF; Font: clDefault; FontStyles: [fsUnderline]),
        (Id: ciNewTableRecordRowError; Background: $00C8CDD5; Font: clRed; FontStyles: [fsUnderline]),
        (Id: ciRecordRow; Background: $00CFD6DA; Font: clDefault),
        (Id: ciRecordRowAlt; Background: $00C2CBCF; Font: clDefault),
        (Id: ciRecordRowError; Background: $00C8CDD5; Font: clRed),
        (Id: ciMouseOverRow; Background: clMedGray; Font: clWhite),
        (Id: ciMouseOverRowError; Background: clMedGray; Font: clRed),

        (Id: ciFieldNamesColumn; Background: clBtnFace; Font: clDefault),

        (Id: ciHeadingColumnMod0; Background: $009ABEBE; Font: clDefault),
        (Id: ciHeadingColumnMod1; Background: $00AAC8BA; Font: clDefault),
        (Id: ciHeadingColumnMod2; Background: $00BEC69B; Font: clDefault),
        (Id: ciHeadingColumnMod3; Background: $00BAA4CC; Font: clDefault),
        (Id: ciHeadingColumnError; Background: clRed; Font: clWhite),

        (Id: ciRecordColumnMod0; Background: $00EAFFFF; Font: clDefault),
        (Id: ciRecordColumnMod0Alt; Background: $00D9FFFF; Font: clDefault),
        (Id: ciRecordColumnMod1; Background: $00E6FFF3; Font: clDefault),
        (Id: ciRecordColumnMod1Alt; Background: $00D9FFED; Font: clDefault),
        (Id: ciRecordColumnMod2; Background: $00FDFFF4; Font: clDefault),
        (Id: ciRecordColumnMod2Alt; Background: $00FAFFE3; Font: clDefault),
        (Id: ciRecordColumnMod3; Background: $00FAF4FF; Font: clDefault),
        (Id: ciRecordColumnMod3Alt; Background: $00F2E8FF; Font: clDefault),

        (Id: ciRecordCellError; Background: clRed; Font: clWhite),
        (Id: ciMouseOverCell; Background: clSilver; Font: clWhite),
        (Id: ciMouseOverCellError; Background: clSilver; Font: clRed),
        (Id: ciFocusedCell; Background: clBlue; Font: clWhite),
        (Id: ciFocusedCellError; Background: clBlue; Font: clRed),

        (Id: ciBeyondBoundary; Background: clDkGray; Font: clDefault)
      );

      Resolvers: TResolvers =
      (
        (Id: rcActiveFrameHeader; Surface: sfOther; ItemId: ciActiveFrameHeader),
        (Id: rcSelectableFrameHeader; Surface: sfOther; ItemId: ciSelectableFrameHeader),
        (Id: rcReadOnlyFrameHeader; Surface: sfOther; ItemId: ciReadOnlyFrameHeader),
        (Id: rcControlOk; Surface: sfOther; ItemId: ciControlOk),
        (Id: rcControlWarning; Surface: sfOther; ItemId: ciControlWarning),
        (Id: rcControlError; Surface: sfOther; ItemId: ciControlError),
        (Id: rcTextView; Surface: sfOther; ItemId: ciTextView),
        (Id: rcGridView; Surface: sfOther; ItemId: ciGridView),

        (Id: rcGridFieldNamesRow; Surface: sfGrid; ItemId: ciFieldNamesRow),

        (Id: rcGridHeadingRow; Surface: sfGrid; ItemId: ciHeadingRow),
        (Id: rcGridHeadingRowError; Surface: sfGrid; ItemId: ciHeadingRowError),
        (Id: rcGridNewTableRecordRow; Surface: sfGrid; ItemId: ciNewTableRecordRow),
        (Id: rcGridNewTableRecordRowAlt; Surface: sfGrid; ItemId: ciNewTableRecordRowAlt),
        (Id: rcGridNewTableRecordRowError; Surface: sfGrid; ItemId: ciNewTableRecordRowError),
        (Id: rcGridRecordRow; Surface: sfGrid; ItemId: ciRecordRow),
        (Id: rcGridRecordRowAlt; Surface: sfGrid; ItemId: ciRecordRowAlt),
        (Id: rcGridRecordRowError; Surface: sfGrid; ItemId: ciRecordRowError),
        (Id: rcGridMouseOverRow; Surface: sfGrid; ItemId: ciMouseOverRow),
        (Id: rcGridMouseOverRowError; Surface: sfGrid; ItemId: ciMouseOverRowError),

        (Id: rcGridFieldNamesColumn; Surface: sfGrid; ItemId: ciFieldNamesColumn),

        (Id: rcGridHeadingColumnMod0; Surface: sfGrid; ItemId: ciHeadingColumnMod0),
        (Id: rcGridHeadingColumnMod1; Surface: sfGrid; ItemId: ciHeadingColumnMod1),
        (Id: rcGridHeadingColumnMod2; Surface: sfGrid; ItemId: ciHeadingColumnMod2),
        (Id: rcGridHeadingColumnMod3; Surface: sfGrid; ItemId: ciHeadingColumnMod3),
        (Id: rcGridHeadingColumnError; Surface: sfGrid; ItemId: ciHeadingColumnError),

        (Id: rcGridRecordColumnMod0; Surface: sfGrid; ItemId: ciRecordColumnMod0),
        (Id: rcGridRecordColumnMod1; Surface: sfGrid; ItemId: ciRecordColumnMod1),
        (Id: rcGridRecordColumnMod2; Surface: sfGrid; ItemId: ciRecordColumnMod2),
        (Id: rcGridRecordColumnMod3; Surface: sfGrid; ItemId: ciRecordColumnMod3),
        (Id: rcGridRecordColumnMod0Alt; Surface: sfGrid; ItemId: ciRecordColumnMod0Alt),
        (Id: rcGridRecordColumnMod1Alt; Surface: sfGrid; ItemId: ciRecordColumnMod1Alt),
        (Id: rcGridRecordColumnMod2Alt; Surface: sfGrid; ItemId: ciRecordColumnMod2Alt),
        (Id: rcGridRecordColumnMod3Alt; Surface: sfGrid; ItemId: ciRecordColumnMod3Alt),

        (Id: rcGridRecordCellError; Surface: sfGrid; ItemId: ciRecordCellError),
        (Id: rcGridMouseOverCell; Surface: sfGrid; ItemId: ciMouseOverCell),
        (Id: rcGridMouseOverCellError; Surface: sfGrid; ItemId: ciMouseOverCellError),
        (Id: rcGridFocusedCell; Surface: sfGrid; ItemId: ciFocusedCell),
        (Id: rcGridFocusedCellError; Surface: sfGrid; ItemId: ciFocusedCellError),

        (Id: rcGridBeyondBoundary; Surface: sfGrid; ItemId: ciBeyondBoundary)
      );

    var
      FValues: TColorItemValues;

    procedure ResolveColor(resolvedId: TResolvedColorId; itemId: TColorItemId;
                           defaultBackgroundColor: TColor; defaultFontColor: TColor;
                           var ResolvedColors: TResolvedColors);
    procedure ResolveGridColor(resolvedId: TResolvedColorId; itemId: TColorItemId;
                               var ResolvedColors: TResolvedColors);

    function GetIgnoreBackgrounds(id: TColorItemId): Boolean;
    function GetIgnoreFonts(id: TColorItemId): Boolean;
    function GetBackgrounds(id: TColorItemId): TColor;
    procedure SetBackgrounds(id: TColorItemId; const Value: TColor);
    function GetFonts(id: TColorItemId): TColor;
    procedure SetFonts(id: TColorItemId; const Value: TColor);
    function GetFontStyles(id: TColorItemId): TFontStyles;
    procedure SetFontStyles(id: TColorItemId; const Value: TFontStyles);
    function GetExampleResolvedColorIds(id: TColorItemId): TResolvedColorId;

    class constructor Create;

    class function GetNames(id: TColorItemId): string; static;
  public
    procedure Reset;
    procedure LoadFromScheme(scheme: TColorScheme);

    procedure PrepareForSerialize;
    procedure ProcessDeserialize;

    function Resolve: TResolvedColors;

    property Values: TColorItemValues read FValues write FValues;

    [XmlIgnore]
    property IgnoreBackgrounds[id: TColorItemId]: Boolean read GetIgnoreBackgrounds;
    [XmlIgnore]
    property IgnoreFonts[id: TColorItemId]: Boolean read GetIgnoreFonts;
    [XmlIgnore]
    property Backgrounds[id: TColorItemId]: TColor read GetBackgrounds write SetBackgrounds;
    [XmlIgnore]
    property Fonts[id: TColorItemId]: TColor read GetFonts write SetFonts;
    [XmlIgnore]
    property FontStyles[id: TColorItemId]: TFontStyles read GetFontStyles write SetFontStyles;

    [XmlIgnore]
    property ExampleResolvedColorIds[id: TColorItemId]: TResolvedColorId read GetExampleResolvedColorIds;

    class procedure CopyValues(const src: TColorItemValues; var dest: TColorItemValues);
    class procedure CopyDefaultValues(var dest: TColorItemValues);

    class property Names[id: TColorItemId]: string read GetNames;
  end;

implementation

uses
  System.Globalization,
  System.IO;

{ TColorItems }

class procedure TColorItems.CopyValues(const src: TColorItemValues; var dest: TColorItemValues);
begin
  System.&Array.Copy(src, dest, Length(src));
end;

class procedure TColorItems.CopyDefaultValues(var dest: TColorItemValues);
begin
  CopyValues(DefaultValues, dest);
end;

class constructor TColorItems.Create;
var
  ColorItemId: TColorItemId;
  ResolvedColorId: TResolvedColorId;
begin
  for ColorItemId := Low(DefaultValues) to High(DefaultValues) do
  begin
    if ColorItemId <> DefaultValues[ColorItemId].Id then
    begin
      raise Exception.Create('Color Values our of order');
    end;
  end;

  for ColorItemId := Low(Constants) to High(Constants) do
  begin
    if ColorItemId <> Constants[ColorItemId].Id then
    begin
      raise Exception.Create('Color Constants our of order');
    end;
  end;

  for ResolvedColorId := Low(Resolvers) to High(Resolvers) do
  begin
    if ResolvedColorId <> Resolvers[ResolvedColorId].Id then
    begin
      raise Exception.Create('Surfaces our of order');
    end;
  end;
end;

function TColorItems.GetBackgrounds(id: TColorItemId): TColor;
begin
  Result := FValues[id].Background;
end;

function TColorItems.GetExampleResolvedColorIds(id: TColorItemId): TResolvedColorId;
begin
  Result := Constants[id].Example;
end;

function TColorItems.GetFonts(id: TColorItemId): TColor;
begin
  Result := FValues[id].Font;
end;

function TColorItems.GetFontStyles(id: TColorItemId): TFontStyles;
begin
  Result := FValues[id].FontStyles;
end;

function TColorItems.GetIgnoreBackgrounds(id: TColorItemId): Boolean;
begin
  Result := Constants[id].IgnoreBackground;
end;

function TColorItems.GetIgnoreFonts(id: TColorItemId): Boolean;
begin
  Result := Constants[id].IgnoreFont;
end;

class function TColorItems.GetNames(id: TColorItemId): string;
begin
  Result := Constants[id].Name;
end;

procedure TColorItems.LoadFromScheme(scheme: TColorScheme);
begin
  System.&Array.Copy(scheme.Values, FValues, Length(scheme.Values));
end;

procedure TColorItems.PrepareForSerialize;
var
  I: TColorItemId;
begin
  for I := Low(FValues) to High(FValues) do
  begin
    FValues[I].ColorsToStrings;
  end;
end;

procedure TColorItems.ProcessDeserialize;
var
  I: TColorItemId;
begin
  for I := Low(FValues) to High(FValues) do
  begin
    FValues[I].StringsToColors;
  end;
end;

procedure TColorItems.Reset;
begin
  CopyDefaultValues(FValues);
end;

function TColorItems.Resolve: TResolvedColors;
var
  I: TResolvedColorId;
begin
  ResolveColor(rcActiveFrameHeader, ciActiveFrameHeader, clGradientActiveCaption, clWindowText, Result);
  ResolveColor(rcSelectableFrameHeader, ciSelectableFrameHeader, clBtnFace, clWindowText, Result);
  ResolveColor(rcReadOnlyFrameHeader, ciReadOnlyFrameHeader, clBtnFace, clWindowText, Result);
  ResolveColor(rcControlOk, ciControlOk, clWindow, clWindowText, Result);
  ResolveColor(rcControlWarning, ciControlWarning, clWindow, clWindowText, Result);
  ResolveColor(rcControlError, ciControlError, clWindow, clWindowText, Result);
  ResolveColor(rcTextView, ciTextView, clWindow, clWindowText, Result);
  ResolveColor(rcGridView, ciGridView, clWindow, clWindowText, Result);

  for I := Low(Resolvers) to High(Resolvers) do
  begin
    case Resolvers[I].Surface of
      sfOther: ;
      sfGrid: ResolveGridColor(I, Resolvers[I].ItemId, Result);
      sfText: ResolveGridColor(I, Resolvers[I].ItemId, Result);
    end;
  end;


  ResolveGridColor(rcGridHeadingRow, ciHeadingRow, Result);

end;

procedure TColorItems.ResolveColor(resolvedId: TResolvedColorId; itemId: TColorItemId; defaultBackgroundColor,
  defaultFontColor: TColor; var ResolvedColors: TResolvedColors);
var
  BackgroundColor: TColor;
  FontColor: TColor;
begin
  BackgroundColor := FValues[itemId].Background;
  case BackgroundColor of
    clDefault, clNone: ResolvedColors[resolvedId].Background := defaultBackgroundColor;
    else ResolvedColors[resolvedId].Background := BackgroundColor;
  end;

  FontColor := FValues[itemId].Font;
  case FontColor of
    clDefault, clNone: ResolvedColors[resolvedId].Font := defaultFontColor;
    else ResolvedColors[resolvedId].Font := FontColor;
  end;

  ResolvedColors[resolvedId].FontStyles := FValues[itemId].FontStyles;
end;

procedure TColorItems.ResolveGridColor(resolvedId: TResolvedColorId; itemId: TColorItemId;
  var ResolvedColors: TResolvedColors);
begin
  ResolveColor(resolvedId, itemId,
               ResolvedColors[rcGridView].Background, ResolvedColors[rcGridView].Font,
               ResolvedColors);
end;

procedure TColorItems.SetBackgrounds(id: TColorItemId; const Value: TColor);
begin
  FValues[id].Background := Value;
end;

procedure TColorItems.SetFonts(id: TColorItemId; const Value: TColor);
begin
  FValues[id].Font := Value;
end;

procedure TColorItems.SetFontStyles(id: TColorItemId; const Value: TFontStyles);
begin
  FValues[id].FontStyles := Value;
end;

{ TColorItemValue }

procedure TColorItemValue.ColorsToStrings;
begin
  BackgroundAsString := ColorToString(Background);
  FontAsString := ColorToString(Font);
end;

procedure TColorItemValue.StringsToColors;
begin
  if Assigned(BackgroundAsString) then
  begin
    Background := StringToColor(BackgroundAsString);
  end;

  if Assigned(FontAsString) then
  begin
    Font := StringToColor(FontAsString);
  end;
end;

{ TColorScheme }

constructor TColorScheme.Create(myName: string; myValues: TColorItemValues);
begin
  inherited Create;

  FName := myName;
  FValues := myValues;
end;

constructor TColorScheme.Create;
begin
  inherited Create;
end;

class function TColorScheme.CreateFromFile(schemeName: string): TColorScheme;
var
  FilePath: string;
  Serializer: XmlSerializer;
  Reader: TextReader;
begin
  FilePath := NameToFilePath(schemeName);
  if not &File.Exists(FilePath) then
    Result := nil
  else
  begin
    Serializer := XmlSerializer.Create(TypeOf(TColorScheme));
    Reader := StreamReader.Create(FilePath);
    try
      Result := Serializer.Deserialize(Reader) as TColorScheme;
    finally
      Reader.Close;
    end;
    Result.Name := schemeName;
  end;
end;

class function TColorScheme.IsDefaultName(value: string): Boolean;
begin
  Result := System.&String.Compare(value, DefaultSchemeName, True, CultureInfo.InvariantCulture) = 0;
end;

class function TColorScheme.NameToFileName(value: string): string;
begin
  Result := TCommon.SafeFileNameEncode(value) + '.' + FileExtension;
end;

class function TColorScheme.NameToFilePath(value: string): string;
begin
  Result := NameToFileName(value);
  Result := Path.Combine(TCommon.ColorSchemaFolder, Result);
end;

procedure TColorScheme.SaveToFile;
var
  FilePath: string;
  Serializer: XmlSerializer;
  Writer: TextWriter;
begin
  TCommon.EnsureColorSchemaFolderExists;

  FilePath := NameToFilePath(Name);
  Serializer := XmlSerializer.Create(TypeOf(TColorScheme));
  Writer := StreamWriter.Create(FilePath);
  try
    Serializer.Serialize(Writer, Self);
  finally
    Writer.Close;
  end;
end;

class function TColorScheme.TryFileNameToName(fileName: string; out schemeName: string): Boolean;
var
  NoExtFileName: string;
begin
  NoExtFileName := Path.GetFileNameWithoutExtension(fileName);
  Result := TCommon.TrySafeFileNameDecode(NoExtFileName, schemeName) = 0;
end;

end.
