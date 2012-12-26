// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.Configuration;

interface

uses
  System.Text,
  System.Globalization,
  System.Xml,
  System.Xml.Serialization,
  Borland.Vcl.Graphics,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.Colors;

type
  TNonViewableCharFormat = (nv0xHex, nvHashDecimal, nvHashDollarHex, nvDollarHex);
  TDisplayCharEncodingType = (deAscii, deUtf8, deFile, deNamed);
  TDisplayCultureType = (dcInvariant, dcLocal, dcFile, dcNamed);
  TSourceOnNewOpenText = (soCurrent, soReadOnly, soText, soTextLocked, soGrid, soGridLocked);

  TFontProperties = record
    [XmlAttribute]
    Name: string;
    [XmlAttribute]
    Size: Integer;
    [XmlAttribute('Color')]
    ColorAsString: string;
    [XmlAttribute]
    FontStyles: TFontStyles;
    [XmlAttribute]
    CharsetIdent: string;

    procedure ExtractFromFont(font: TFont);
    procedure AssignToFont(font: TFont);
  end;

  TConfigurationUpdatedEvent = procedure of object;

  TConfiguration = class
  private
    const
      XmlFileName = 'FTEditorConfig.xml';

    var
      FXmlElementHolder: XmlDocument;

      FActiveLayoutConfigurationName: string;
      FLayoutConfigurations: XmlElement;
      FMainWindowMaximised: Boolean;
      FMainWindowWidth: Integer;
      FMainWindowTop: Integer;
      FMainWindowHeight: Integer;
      FMainWindowLeft: Integer;

      FAutoParse: Boolean;
      FAutoGenerate: Boolean;
      FMouseOverPanelVisible: Boolean;
      FMouseOverPanelHeight: Integer;

      FDefaultNonViewableCharFormat: TNonViewableCharFormat;
      FDisplayCultureType: TDisplayCultureType;
      FNamedDisplayCulture: CultureInfo;
      FNamedDisplayCultureName: string;
      FDisplayCharEncodingType: TDisplayCharEncodingType;
      FNamedDisplayCharEncoding: Encoding;
      FNamedDisplayCharEncodingName: string;

      FTextFont: TFont;
      FTextFontProperties: TFontProperties;
      FColorText: Boolean;
      FWrapText: Boolean;
      FTextTrackCursor: Boolean;
      FTextTrackMouse: Boolean;

      FGridFont: TFont;
      FGridFontProperties: TFontProperties;
      FGridHorizontalLinesVisible: Boolean;
      FGridVerticalLinesVisible: Boolean;
      FGridShowFieldNamesIfNoFixedHeadingRows: Boolean;
      FFixedHeadingRows: Boolean;
      FGridTrackCursor: Boolean;
      FGridTrackMouse: Boolean;
      FGridRowSizeAuto: Boolean;
      FGridManualRowHeight: Integer;
      FGridNullText: string;

      FColorItems: TColorItems;
      FColors: TResolvedColors;

      FResetMetaForNewOpenText: Boolean;
      FIgnoreDeclaredMeta: Boolean;
      FMetaTextFormatting: System.Xml.Formatting;
      FMetaTextIndentation: Integer;
      FMetaTextIndentChar: Char;
      FEmbeddedMetaMargin: Integer;
      FSaveDesignOnlyMeta: Boolean;
      FSaveMetaWithExplicitIndices: Boolean;

      FSourceOnNewOpenText: TSourceOnNewOpenText;
      FDefaultTextCharEncodingName: string;
      FDefaultMetaCharEncodingName: string;
      FMaxOpenTextLines: Int64;
      FNumberFromZero: Boolean;

      FUpdatedEvent: TConfigurationUpdatedEvent;

    procedure ProcessDeserialize;
    procedure PrepareForSerialize;

    function GetMouseOverPanelHeight: Integer;

    procedure SetNamedDisplayCharEncoding(const Value: Encoding);
    procedure SetNamedDisplayCharEncodingName(const Value: string);
    procedure SetNamedDisplayCulture(const Value: CultureInfo);
    procedure SetNamedDisplayCultureName(const Value: string);

    procedure SetGridFont(const Value: TFont);
    procedure SetTextFont(const Value: TFont);

  public
    const
      MinMouseOverPanelHeight = 19;

    constructor Create;
    procedure Initialise;

    class function Load: TConfiguration;
    procedure Save;

    [XmlIgnore]
    property XmlElementHolder: XmlDocument read FXmlElementHolder;

    property ActiveLayoutConfigurationName: string read FActiveLayoutConfigurationName write FActiveLayoutConfigurationName;
    property LayoutConfigurations: XmlElement read FLayoutConfigurations write FLayoutConfigurations;
    property MainWindowMaximised: Boolean read FMainWindowMaximised write FMainWindowMaximised;
    property MainWindowTop: Integer read FMainWindowTop write FMainWindowTop;
    property MainWindowLeft: Integer read FMainWindowLeft write FMainWindowLeft;
    property MainWindowHeight: Integer read FMainWindowHeight write FMainWindowHeight;
    property MainWindowWidth: Integer read FMainWindowWidth write FMainWindowWidth;

    property AutoParse: Boolean read FAutoParse write FAutoParse;
    property AutoGenerate: Boolean read FAutoGenerate write FAutoGenerate;
    property MouseOverPanelVisible: Boolean read FMouseOverPanelVisible write FMouseOverPanelVisible;
    property MouseOverPanelHeight: Integer read GetMouseOverPanelHeight write FMouseOverPanelHeight;

    property DefaultNonViewableCharFormat: TNonViewableCharFormat read FDefaultNonViewableCharFormat write FDefaultNonViewableCharFormat;
    property DisplayCultureType: TDisplayCultureType read FDisplayCultureType write FDisplayCultureType;
    [XmlIgnore]
    property NamedDisplayCulture: CultureInfo read FNamedDisplayCulture write SetNamedDisplayCulture;
    property NamedDisplayCultureName: string read FNamedDisplayCultureName write SetNamedDisplayCultureName;
    property DisplayCharEncodingType: TDisplayCharEncodingType read FDisplayCharEncodingType write FDisplayCharEncodingType;
    [XmlIgnore]
    property NamedDisplayCharEncoding: Encoding read FNamedDisplayCharEncoding write SetNamedDisplayCharEncoding;
    property NamedDisplayCharEncodingName: string read FNamedDisplayCharEncodingName write SetNamedDisplayCharEncodingName;

    [XmlIgnore]
    property TextFont: TFont read FTextFont write SetTextFont;
    [XmlElement('TextFont')]
    property TextFontProperties: TFontProperties read FTextFontProperties write FTextFontProperties;
    property ColorText: Boolean read FColorText write FColorText;
    property WrapText: Boolean read FWrapText write FWrapText;
    property TextTrackMouse: Boolean read FTextTrackMouse write FTextTrackMouse;
    property TextTrackCursor: Boolean read FTextTrackCursor write FTextTrackCursor;

    [XmlIgnore]
    property GridFont: TFont read FGridFont write SetGridFont;
    [XmlElement('GridFont')]
    property GridFontProperties: TFontProperties read FGridFontProperties write FGridFontProperties;
    property GridHorizontalLinesVisible: Boolean read FGridHorizontalLinesVisible write FGridHorizontalLinesVisible;
    property GridVerticalLinesVisible: Boolean read FGridVerticalLinesVisible write FGridVerticalLinesVisible;
    property GridShowFieldNamesIfNoFixedHeadingRows: Boolean read FGridShowFieldNamesIfNoFixedHeadingRows write FGridShowFieldNamesIfNoFixedHeadingRows;
    property GridFixedHeadingRows: Boolean read FFixedHeadingRows write FFixedHeadingRows;
    property GridTrackMouse: Boolean read FGridTrackMouse write FGridTrackMouse;
    property GridTrackCursor: Boolean read FGridTrackCursor write FGridTrackCursor;
    property GridRowHeightAuto: Boolean read FGridRowSizeAuto write FGridRowSizeAuto;
    property GridManualRowHeight: Integer read FGridManualRowHeight write FGridManualRowHeight;
    property GridNullText: string read FGridNullText write FGridNullText;

    property ColorItems: TColorItems read FColorItems write FColorItems;
    procedure SetColorItems(const Value: TColorItems);
    [XmlIgnore]
    property Colors: TResolvedColors read FColors write FColors;

    property ResetMetaForNewOpenText: Boolean read FResetMetaForNewOpenText write FResetMetaForNewOpenText;
    property IgnoreDeclaredMeta: Boolean read FIgnoreDeclaredMeta write FIgnoreDeclaredMeta;
    property MetaTextFormatting: System.Xml.Formatting read FMetaTextFormatting write FMetaTextFormatting;
    property MetaTextIndentation: Integer read FMetaTextIndentation write FMetaTextIndentation;
    property MetaTextIndentChar: Char read FMetaTextIndentChar write FMetaTextIndentChar;
    property EmbeddedMetaMargin: Integer read FEmbeddedMetaMargin write FEmbeddedMetaMargin;

    property SaveDesignOnlyMeta: Boolean read FSaveDesignOnlyMeta write FSaveDesignOnlyMeta;
    property SaveMetaWithExplicitIndices: Boolean read FSaveMetaWithExplicitIndices write FSaveMetaWithExplicitIndices;

    property SourceOnNewOpenText: TSourceOnNewOpenText read FSourceOnNewOpenText write FSourceOnNewOpenText;
    property DefaultTextCharEncodingName: string read FDefaultTextCharEncodingName write FDefaultTextCharEncodingName;
    property DefaultMetaCharEncodingName: string read FDefaultMetaCharEncodingName write FDefaultMetaCharEncodingName;
    property MaxOpenTextLines: Int64 read FMaxOpenTextLines write FMaxOpenTextLines;
    property NumberFromZero: Boolean read FNumberFromZero write FNumberFromZero;

    procedure TriggerUpdatedEvent;

    class function CreateDefaultTextFont: TFont;
    class function CreateDefaultGridFont: TFont;

    class function GetDefaultDefaultTextCharEncodingName: string;
    class function GetDefaultDefaultMetaCharEncodingName: string;

    property UpdatedEvent: TConfigurationUpdatedEvent read FUpdatedEvent write FUpdatedEvent;
  end;

var
  Configuration: TConfiguration;

implementation

uses
  System.IO,
  Borland.Vcl.StdCtrls,
  Borland.Vcl.Grids,
  Xilytix.FTEditor.Common;

{ TConfiguration }

constructor TConfiguration.Create;
begin
  inherited;

  FXmlElementHolder := XmlDocument.Create;
  FColorItems := TColorItems.Create;

  FLayoutConfigurations := FXmlElementHolder.CreateElement('LayoutConfigurations');

  FTextFont := TFont.Create;
  FGridFont := TFont.Create;
end;

class function TConfiguration.CreateDefaultGridFont: TFont;
var
  DummyGrid: TDrawGrid;
begin
  DummyGrid := TDrawGrid.Create(nil);
  Result := DummyGrid.Font;
end;

class function TConfiguration.CreateDefaultTextFont: TFont;
var
  DummyMemo: TMemo;
begin
  DummyMemo := TMemo.Create(nil);
  DummyMemo.Font.Name := 'Courier New';
  Result := DummyMemo.Font;
end;

class function TConfiguration.GetDefaultDefaultMetaCharEncodingName: string;
begin
  Result := Encoding.UTF8.WebName;
end;

class function TConfiguration.GetDefaultDefaultTextCharEncodingName: string;
begin
  Result := Encoding.UTF8.WebName;
end;

function TConfiguration.GetMouseOverPanelHeight: Integer;
begin
  Result := FMouseOverPanelHeight;
  if Result < MinMouseOverPanelHeight then
  begin
    Result := MinMouseOverPanelHeight;
  end;
end;

procedure TConfiguration.Initialise;
begin
  FActiveLayoutConfigurationName := '<Default>';
  FMainWindowMaximised := False;
  FMainWindowWidth := 650;
  FMainWindowTop := 40;
  FMainWindowHeight := 350;
  FMainWindowLeft := 40;

  FMouseOverPanelVisible := True;
  FMouseOverPanelHeight := MinMouseOverPanelHeight;

  DefaultNonViewableCharFormat := nv0xHex;
  NamedDisplayCulture := CultureInfo.CurrentCulture;
  DisplayCultureType := dcLocal;
  NamedDisplayCharEncoding := Encoding.UTF8;
  DisplayCharEncodingType := deUtf8;

  FResetMetaForNewOpenText := True;
  FIgnoreDeclaredMeta := False;
  FMetaTextFormatting := TFieldedText.DefaultMetaTextFormatting;
  FMetaTextIndentation := TFieldedText.DefaultMetaTextIndentation;
  FMetaTextIndentChar := TFieldedText.DefaultMetaTextIndentChar;
  FEmbeddedMetaMargin := TFieldedText.DefaultEmbeddedMetaMargin;

  FNumberFromZero := True;

  FSaveDesignOnlyMeta := True;
  FSaveMetaWithExplicitIndices := False;

  FTextFont.Assign(CreateDefaultTextFont);
  FColorText := False;
  FWrapText := False;
  FTextTrackCursor := True;
  FTextTrackMouse := False;

  FGridFont.Assign(CreateDefaultGridFont);
  FGridHorizontalLinesVisible := True;
  FGridVerticalLinesVisible := True;
  FGridShowFieldNamesIfNoFixedHeadingRows := True;
  FFixedHeadingRows := True;
  FGridTrackCursor := True;
  FGridTrackMouse := True;
  FGridRowSizeAuto := True;
  FGridManualRowHeight := 24;
  FGridNullText := '<Null>';

  FColorItems.Reset;
  FColors := FColorItems.Resolve;

  FDefaultTextCharEncodingName := GetDefaultDefaultTextCharEncodingName;
  FDefaultMetaCharEncodingName := GetDefaultDefaultMetaCharEncodingName;
  FMaxOpenTextLines := -1;
end;

class function TConfiguration.Load: TConfiguration;

  procedure CreateAndInitialise;
  begin
    Configuration := TConfiguration.Create;
    Configuration.Initialise;
  end;
var
  FilePath: string;
  Serializer: XmlSerializer;
  Reader: StreamReader;
begin
  FilePath := Path.Combine(TCommon.ApplicationDataFolder, XmlFileName);

  if not System.IO.&File.Exists(FilePath) then
    CreateAndInitialise
  else
  begin
    Serializer := XmlSerializer.Create(TypeOf(TConfiguration));
    try
      Reader := StreamReader.Create(FilePath);
      try
        Configuration := Serializer.Deserialize(Reader) as TConfiguration;
        Configuration.ProcessDeserialize;
      finally
        Reader.Close;
      end;
    except
      CreateAndInitialise;
    end;
  end;
  Result := Configuration;
end;

procedure TConfiguration.PrepareForSerialize;
begin
  FColorItems.PrepareForSerialize;
  FTextFontProperties.ExtractFromFont(FTextFont);
  FGridFontProperties.ExtractFromFont(FGridFont);
end;

procedure TConfiguration.ProcessDeserialize;
begin
  FXmlElementHolder := FLayoutConfigurations.OwnerDocument;
  FColorItems.ProcessDeserialize;
  FColors := FColorItems.Resolve;
  FTextFontProperties.AssignToFont(FTextFont);
  FGridFontProperties.AssignToFont(FGridFont);

  if FDefaultTextCharEncodingName = '' then
  begin
    FDefaultTextCharEncodingName := GetDefaultDefaultTextCharEncodingName;
  end;
  if FDefaultMetaCharEncodingName = '' then
  begin
    FDefaultMetaCharEncodingName := GetDefaultDefaultMetaCharEncodingName;
  end;
end;

procedure TConfiguration.Save;
var
  FilePath: string;
  Serializer: XmlSerializer;
  Writer: StreamWriter;
begin
  PrepareForSerialize;
  if not System.IO.Directory.Exists(TCommon.ApplicationDataFolder) then
  begin
    System.IO.Directory.CreateDirectory(TCommon.ApplicationDataFolder);
  end;
  FilePath := Path.Combine(TCommon.ApplicationDataFolder, XmlFileName);
  Serializer := XmlSerializer.Create(TypeOf(Self));
  Writer := StreamWriter.Create(FilePath, False);
  Serializer.Serialize(Writer, Self);
  Writer.Close;
end;

procedure TConfiguration.SetColorItems(const Value: TColorItems);
begin
  FColorItems := Value;
  FColors := FColorItems.Resolve;
end;

procedure TConfiguration.SetGridFont(const Value: TFont);
begin
  FGridFont.Assign(Value);
end;

procedure TConfiguration.SetNamedDisplayCharEncoding(const Value: Encoding);
begin
  FNamedDisplayCharEncoding := Value;
  FNamedDisplayCharEncodingName := Value.WebName;
end;

procedure TConfiguration.SetNamedDisplayCharEncodingName(const Value: string);
begin
  FNamedDisplayCharEncodingName := Value;
  FNamedDisplayCharEncoding := System.Text.Encoding.GetEncoding(FNamedDisplayCharEncodingName);
end;

procedure TConfiguration.SetNamedDisplayCulture(const Value: CultureInfo);
begin
  FNamedDisplayCulture := Value;
  FNamedDisplayCultureName := FNamedDisplayCulture.Name;
end;

procedure TConfiguration.SetNamedDisplayCultureName(const Value: string);
begin
  FNamedDisplayCultureName := Value;
  FNamedDisplayCulture := CultureInfo.Create(FNamedDisplayCultureName);
end;

procedure TConfiguration.SetTextFont(const Value: TFont);
begin
  FTextFont.Assign(Value);
end;

procedure TConfiguration.TriggerUpdatedEvent;
begin
  if Assigned(FUpdatedEvent) then
  begin
    FUpdatedEvent;
  end;
end;

{ TFontProperties }

procedure TFontProperties.AssignToFont(font: TFont);
var
  Charset: Integer;
begin
  font.Name := Name;
  font.Size := Size;
  font.Color := StringToColor(ColorAsString);
  font.Style := FontStyles;
  if IdentToCharset(CharsetIdent, Charset) then
  begin
    font.Charset := Charset;
  end;
end;

procedure TFontProperties.ExtractFromFont(font: TFont);
var
  Charset: TFontCharset;
begin
  Name := font.Name;
  Size := font.Size;
  ColorAsString := ColorToString(font.Color);
  FontStyles := font.Style;

  if not CharsetToIdent(font.Charset, CharsetIdent) then
  begin
    Charset := GetDefFontCharSet;
    if not CharsetToIdent(Charset, CharsetIdent) then
    begin
      CharsetToIdent(0, CharsetIdent); // 0 = ANSI
    end;
  end;
end;

end.
