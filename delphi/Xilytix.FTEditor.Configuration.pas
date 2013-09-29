// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.Configuration;

interface

uses
  SysUtils,
  Graphics,
  XMLIntf,
  Xilytix.FieldedText.DotNet,
  Xilytix.FieldedText.Utils,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.TypedXml,
  Xilytix.FTEditor.Colors,
  Xilytix.FTEditor.LayoutConfiguration;

type
  TNonViewableCharFormat = (nv0xHex, nvHashDecimal, nvHashDollarHex, nvDollarHex);
  TDisplayCharEncodingType = (deAscii, deUtf8, deFile, deNamed);
  TDisplayCultureType = (dcInvariant, dcLocal, dcFile, dcNamed);
  TSourceOnNewOpenText = (soCurrent, soReadOnly, soText, soTextLocked, soGrid, soGridLocked);

  TConfiguration = class
  public
    type
      TConfigurationUpdatedEvent = procedure of object;
    const
      MinMouseOverPanelHeight = 19;
      DefaultDefaultTextCharEncodingName = TFieldedTextConst.Utf8EncodingName;
      DefaultDefaultMetaCharEncodingName = TFieldedTextConst.Utf8EncodingName;

  private
    const
      XmlFileName = 'FTEditorConfig.xml';

      XmlTag_RootElement = 'FieldedText';
      XmlTag_ActiveLayoutConfigurationName = 'ActiveLayoutConfigurationName';
      XmlTag_LayoutConfigurations = 'LayoutConfigurations';
      XmlTag_MainWindowMaximised = 'MainWindowMaximised';
      XmlTag_MainWindowTop = 'MainWindowTop';
      XmlTag_MainWindowLeft = 'MainWindowLeft';
      XmlTag_MainWindowHeight = 'MainWindowHeight';
      XmlTag_MainWindowWidth = 'MainWindowWidth';
      XmlTag_AutoParse = 'AutoParse';
      XmlTag_AutoGenerate = 'AutoGenerate';
      XmlTag_MouseOverPanelVisible = 'MouseOverPanelVisible';
      XmlTag_MouseOverPanelHeight = 'MouseOverPanelHeight';
      XmlTag_DefaultNonViewableCharFormat = 'DefaultNonViewableCharFormat';
      XmlTag_DisplayCultureType = 'DisplayCultureType';
      XmlTag_NamedDisplayCultureName = 'NamedDisplayCultureName';
      XmlTag_DisplayCharEncodingType = 'DisplayCharEncodingType';
      XmlTag_NamedDisplayCharEncodingName = 'NamedDisplayCharEncodingName';
      XmlTag_TextFont = 'TextFont';
      XmlTag_ColorText = 'ColorText';
      XmlTag_WrapText = 'WrapText';
      XmlTag_TextTrackMouse = 'TextTrackMouse';
      XmlTag_TextTrackCursor = 'TextTrackCursor';
      XmlTag_GridFont = 'GridFont';
      XmlTag_GridHorizontalLinesVisible = 'GridHorizontalLinesVisible';
      XmlTag_GridVerticalLinesVisible = 'GridVerticalLinesVisible';
      XmlTag_GridShowFieldNamesIfNoFixedHeadingRows = 'GridShowFieldNamesIfNoFixedHeadingRows';
      XmlTag_GridFixedHeadingRows = 'GridFixedHeadingRows';
      XmlTag_GridTrackMouse = 'GridTrackMouse';
      XmlTag_GridTrackCursor = 'GridTrackCursor';
      XmlTag_GridRowHeightAuto = 'GridRowHeightAuto';
      XmlTag_GridManualRowHeight = 'GridManualRowHeight';
      XmlTag_GridNullText = 'GridNullText';
      XmlTag_ResetMetaForNewOpenText = 'ResetMetaForNewOpenText';
      XmlTag_IgnoreDeclaredMeta = 'IgnoreDeclaredMeta';
      XmlTag_MetaTextFormatting = 'MetaTextFormatting';
      XmlTag_MetaTextIndentation = 'MetaTextIndentation';
      XmlTag_MetaTextIndentChar = 'MetaTextIndentChar';
      XmlTag_EmbeddedMetaMargin = 'EmbeddedMetaMargin';
      XmlTag_SaveDesignOnlyMeta = 'SaveDesignOnlyMeta';
      XmlTag_SaveMetaWithExplicitIndices = 'SaveMetaWithExplicitIndices';
      XmlTag_SourceOnNewOpenText = 'SourceOnNewOpenText';
      XmlTag_DefaultTextCharEncodingName = 'DefaultTextCharEncodingName';
      XmlTag_DefaultMetaCharEncodingName = 'DefaultMetaCharEncodingName';
      XmlTag_MaxOpenTextLines = 'MaxOpenTextLines';
      XmlTag_NumberFromZero = 'NumberFromZero';
      XmlTag_ColorItems = 'ColorItems';

      DefaultActiveLayoutConfigurationName = '<Default>';
      DefaultMainWindowMaximised = False;
      DefaultMainWindowWidth = 650;
      DefaultMainWindowTop = 40;
      DefaultMainWindowHeight = 350;
      DefaultMainWindowLeft = 40;
      DefaultAutoParse = False;
      DefaultAutoGenerate = False;
      DefaultMouseOverPanelVisible = True;
      DefaultMouseOverPanelHeight = MinMouseOverPanelHeight;
      DefaultDefaultNonViewableCharFormat = nv0xHex;
      DefaultNamedDisplayCultureName = '';
      DefaultDisplayCultureType = dcLocal;
      DefaultNamedDisplayCharEncodingName = 'UTF8';
      DefaultResetMetaForNewOpenText = True;
      DefaultIgnoreDeclaredMeta = False;
      DefaultMetaTextFormatting = TFieldedText.DefaultMetaTextIndented;
      DefaultMetaTextIndentation = TFieldedText.DefaultMetaTextIndentation;
      DefaultMetaTextIndentChar = TFieldedText.DefaultMetaTextIndentChar;
      DefaultEmbeddedMetaMargin = TFieldedText.DefaultEmbeddedMetaMargin;
      DefaultNumberFromZero = True;
      DefaultSaveDesignOnlyMeta = True;
      DefaultSaveMetaWithExplicitIndices = False;
      DefaultTextFontName = 'Courier New';
      DefaultColorText = False;
      DefaultWrapText = False;
      DefaultTextTrackCursor = True;
      DefaultTextTrackMouse = False;
      DefaultGridHorizontalLinesVisible = True;
      DefaultGridVerticalLinesVisible = True;
      DefaultGridShowFieldNamesIfNoFixedHeadingRows = True;
      DefaultFixedHeadingRows = True;
      DefaultGridTrackCursor = True;
      DefaultGridTrackMouse = True;
      DefaultGridRowSizeAuto = True;
      DefaultGridManualRowHeight = 24;
      DefaultGridNullText = '<Null>';
      DefaultMaxOpenTextLines = -1;
      DefaultSourceOnNewOpenText = soCurrent;

    var
      FActiveLayoutConfigurationName: string;
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
      FNamedDisplayCulture: TFieldedTextLocaleSettings;
      FNamedDisplayCultureName: string;
      FDisplayCharEncodingType: TDisplayCharEncodingType;
      FNamedDisplayCharEncoding: TEncoding;
      FNamedDisplayCharEncodingName: string;

      FTextFont: TFont;
      FColorText: Boolean;
      FWrapText: Boolean;
      FTextTrackCursor: Boolean;
      FTextTrackMouse: Boolean;

      FGridFont: TFont;
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
      FMetaTextFormatting: Boolean;
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

    procedure LoadFromXml(XmlNode: ITypedXmlElement{;
                          out ALeftFrame, AMiddleFrame, ARightFrame: ITypedXmlElement;
                          out BLeftFrame, BMiddleFrame, BRightFrame: ITypedXmlElement});
    procedure SaveToXml(XmlNode: ITypedXmlElement);

    function GetMouseOverPanelHeight: Integer;

    procedure SetNamedDisplayCharEncoding(const Value: TEncoding);
    procedure SetNamedDisplayCharEncodingName(const Value: string);
    procedure SetNamedDisplayCulture(const Value: TFieldedTextLocaleSettings);
    procedure SetNamedDisplayCultureName(const Value: string);

    procedure SetGridFont(const Value: TFont);
    procedure SetTextFont(const Value: TFont);

  public
    constructor Create;
    destructor Destroy; override;

    procedure LoadFromDefault;

    procedure Load;
    procedure Save;

    property ActiveLayoutConfigurationName: string read FActiveLayoutConfigurationName write FActiveLayoutConfigurationName;
//    property LayoutConfiguration: TLayoutConfiguration read FLayoutConfiguration;
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
    property NamedDisplayCulture: TFieldedTextLocaleSettings read FNamedDisplayCulture write SetNamedDisplayCulture;
    property NamedDisplayCultureName: string read FNamedDisplayCultureName write SetNamedDisplayCultureName;
    property DisplayCharEncodingType: TDisplayCharEncodingType read FDisplayCharEncodingType write FDisplayCharEncodingType;
    property NamedDisplayCharEncoding: TEncoding read FNamedDisplayCharEncoding write SetNamedDisplayCharEncoding;
    property NamedDisplayCharEncodingName: string read FNamedDisplayCharEncodingName write SetNamedDisplayCharEncodingName;

    property TextFont: TFont read FTextFont write SetTextFont;
    property ColorText: Boolean read FColorText write FColorText;
    property WrapText: Boolean read FWrapText write FWrapText;
    property TextTrackMouse: Boolean read FTextTrackMouse write FTextTrackMouse;
    property TextTrackCursor: Boolean read FTextTrackCursor write FTextTrackCursor;

    property GridFont: TFont read FGridFont write SetGridFont;
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
    property Colors: TResolvedColors read FColors write FColors;

    property ResetMetaForNewOpenText: Boolean read FResetMetaForNewOpenText write FResetMetaForNewOpenText;
    property IgnoreDeclaredMeta: Boolean read FIgnoreDeclaredMeta write FIgnoreDeclaredMeta;
    property MetaTextFormatting: Boolean read FMetaTextFormatting write FMetaTextFormatting;
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

    property UpdatedEvent: TConfigurationUpdatedEvent read FUpdatedEvent write FUpdatedEvent;
  end;

function NonViewableCharFormatToXmlValue(const Value: TNonViewableCharFormat): string;
function TryXmlValueToNonViewableCharFormat(const XmlValue: string; out FormatValue: TNonViewableCharFormat): Boolean;
function DisplayCharEncodingTypeToXmlValue(const Value: TDisplayCharEncodingType): string;
function TryXmlValueToDisplayCharEncodingType(const XmlValue: string; out TypeValue: TDisplayCharEncodingType): Boolean;
function DisplayCultureTypeToXmlValue(const Value: TDisplayCultureType): string;
function TryXmlValueToDisplayCultureType(const XmlValue: string; out TypeValue: TDisplayCultureType): Boolean;
function SourceOnNewOpenTextToXmlValue(const Value: TSourceOnNewOpenText): string;
function TryXmlValueToSourceOnNewOpenText(const XmlValue: string; out SourceOnNewOpenTextValue: TSourceOnNewOpenText): Boolean;

var
  Configuration: TConfiguration;

implementation

uses
  Windows,
  Classes,
  IOUtils,
  System.UITypes,
  XmlDoc,
  XMLDom,
  StdCtrls,
  Grids,
  Dialogs,
  Xilytix.FTEditor.Common;

type
  TNonViewableCharFormatInfo = record
    Format: TNonViewableCharFormat;
    XmlValue: string;
  end;
  TNonViewableCharFormatInfos = array[TNonViewableCharFormat] of TNonViewableCharFormatInfo;

  TDisplayCharEncodingTypeInfo = record
    EncodingType: TDisplayCharEncodingType;
    XmlValue: string;
  end;
  TDisplayCharEncodingTypeInfos = array[TDisplayCharEncodingType] of TDisplayCharEncodingTypeInfo;

  TDisplayCultureTypeInfo = record
    CultureType: TDisplayCultureType;
    XmlValue: string;
  end;
  TDisplayCultureTypeInfos = array[TDisplayCultureType] of TDisplayCultureTypeInfo;

  TSourceOnNewOpenTextInfo = record
    SourceOnNewOpenText: TSourceOnNewOpenText;
    XmlValue: string;
  end;
  TSourceOnNewOpenTextInfos = array[TSourceOnNewOpenText] of TSourceOnNewOpenTextInfo;

const
  NonViewableCharFormatInfos: TNonViewableCharFormatInfos =
  (
    (Format: nv0xHex; XmlValue: '0xHex'),
    (Format: nvHashDecimal; XmlValue: 'HashDecimal'),
    (Format: nvHashDollarHex; XmlValue: 'HashDollarHex'),
    (Format: nvDollarHex; XmlValue: 'DollarHex')
  );

  DisplayCharEncodingTypeInfos: TDisplayCharEncodingTypeInfos =
  (
    (EncodingType: deAscii; XmlValue: 'Ascii'),
    (EncodingType: deUtf8; XmlValue: 'Utf8'),
    (EncodingType: deFile; XmlValue: 'File'),
    (EncodingType: deNamed; XmlValue: 'Named')
  );

  DisplayCultureTypeInfos: TDisplayCultureTypeInfos =
  (
    (CultureType: dcInvariant; XmlValue: 'Invariant'),
    (CultureType: dcLocal; XmlValue: 'Local'),
    (CultureType: dcFile; XmlValue: 'File'),
    (CultureType: dcNamed; XmlValue: 'Named')
  );

  SourceOnNewOpenTextInfos: TSourceOnNewOpenTextInfos =
  (
    (SourceOnNewOpenText: soCurrent; XmlValue: 'Current'),
    (SourceOnNewOpenText: soReadOnly; XmlValue: 'ReadOnly'),
    (SourceOnNewOpenText: soText; XmlValue: 'Text'),
    (SourceOnNewOpenText: soTextLocked; XmlValue: 'TextLocked'),
    (SourceOnNewOpenText: soGrid; XmlValue: 'Grid'),
    (SourceOnNewOpenText: soGridLocked; XmlValue: 'GridLocked')
  );

procedure InitializeUnit;
var
  Format: TNonViewableCharFormat;
  EncodingType: TDisplayCharEncodingType;
  CultureType: TDisplayCultureType;
  Text: TSourceOnNewOpenText;
begin
  for Format := Low(TNonViewableCharFormat) to High(TNonViewableCharFormat) do
  begin
    if NonViewableCharFormatInfos[Format].Format <> Format then
    begin
      raise Exception.Create('NonViewableCharFormatInfos out of order');
    end;
  end;

  for EncodingType := Low(TDisplayCharEncodingType) to High(TDisplayCharEncodingType) do
  begin
    if DisplayCharEncodingTypeInfos[EncodingType].EncodingType <> EncodingType then
    begin
      raise Exception.Create('DisplayCharEncodingTypeInfos out of order');
    end;
  end;

  for CultureType := Low(TDisplayCultureType) to High(TDisplayCultureType) do
  begin
    if DisplayCultureTypeInfos[CultureType].CultureType <> CultureType then
    begin
      raise Exception.Create('DisplayCultureTypeInfos out of order');
    end;
  end;

  for Text := Low(TSourceOnNewOpenText) to High(TSourceOnNewOpenText) do
  begin
    if SourceOnNewOpenTextInfos[Text].SourceOnNewOpenText <> Text then
    begin
      raise Exception.Create('SourceOnNewOpenTextInfos out of order');
    end;
  end;
end;

function NonViewableCharFormatToXmlValue(const Value: TNonViewableCharFormat): string;
begin
  Result := NonViewableCharFormatInfos[Value].XmlValue;
end;

function TryXmlValueToNonViewableCharFormat(const XmlValue: string; out FormatValue: TNonViewableCharFormat): Boolean;
var
  I: TNonViewableCharFormat;
begin
  Result := False;
  for I := Low(NonViewableCharFormatInfos) to High(NonViewableCharFormatInfos) do
  begin
    if SameText(NonViewableCharFormatInfos[I].XmlValue, XmlValue) then
    begin
      FormatValue := I;
      Result := True;
      Break;
    end;
  end;
end;

function DisplayCharEncodingTypeToXmlValue(const Value: TDisplayCharEncodingType): string;
begin
  Result := DisplayCharEncodingTypeInfos[Value].XmlValue;
end;

function TryXmlValueToDisplayCharEncodingType(const XmlValue: string; out TypeValue: TDisplayCharEncodingType): Boolean;
var
  I: TDisplayCharEncodingType;
begin
  Result := False;
  for I := Low(DisplayCharEncodingTypeInfos) to High(DisplayCharEncodingTypeInfos) do
  begin
    if SameText(DisplayCharEncodingTypeInfos[I].XmlValue, XmlValue) then
    begin
      TypeValue := I;
      Result := True;
      Break;
    end;
  end;
end;

function DisplayCultureTypeToXmlValue(const Value: TDisplayCultureType): string;
begin
  Result := DisplayCultureTypeInfos[Value].XmlValue;
end;

function TryXmlValueToDisplayCultureType(const XmlValue: string; out TypeValue: TDisplayCultureType): Boolean;
var
  I: TDisplayCultureType;
begin
  Result := False;
  for I := Low(DisplayCultureTypeInfos) to High(DisplayCultureTypeInfos) do
  begin
    if SameText(DisplayCultureTypeInfos[I].XmlValue, XmlValue) then
    begin
      TypeValue := I;
      Result := True;
      Break;
    end;
  end;
end;

function SourceOnNewOpenTextToXmlValue(const Value: TSourceOnNewOpenText): string;
begin
  Result := SourceOnNewOpenTextInfos[Value].XmlValue;
end;

function TryXmlValueToSourceOnNewOpenText(const XmlValue: string; out SourceOnNewOpenTextValue: TSourceOnNewOpenText): Boolean;
var
  I: TSourceOnNewOpenText;
begin
  Result := False;
  for I := Low(SourceOnNewOpenTextInfos) to High(SourceOnNewOpenTextInfos) do
  begin
    if SameText(SourceOnNewOpenTextInfos[I].XmlValue, XmlValue) then
    begin
      SourceOnNewOpenTextValue := I;
      Result := True;
      Break;
    end;
  end;
end;

{ TConfiguration }

constructor TConfiguration.Create;
begin
  inherited;

  FColorItems := TColorItems.Create;

//  FLayoutConfiguration := TLayoutConfiguration.Create;

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

destructor TConfiguration.Destroy;
begin
  FColorItems.Free;
  FTextFont.Free;
  FGridFont.Free;
//  FLayoutConfiguration.Free;
  inherited;
end;

function TConfiguration.GetMouseOverPanelHeight: Integer;
begin
  Result := FMouseOverPanelHeight;
  if Result < MinMouseOverPanelHeight then
  begin
    Result := MinMouseOverPanelHeight;
  end;
end;

procedure TConfiguration.LoadFromDefault;
begin
  FActiveLayoutConfigurationName := DefaultActiveLayoutConfigurationName;
  FMainWindowMaximised := DefaultMainWindowMaximised;
  FMainWindowWidth := DefaultMainWindowWidth;
  FMainWindowTop := DefaultMainWindowTop;
  FMainWindowHeight := DefaultMainWindowHeight;
  FMainWindowLeft := DefaultMainWindowLeft;

  FMouseOverPanelVisible := DefaultMouseOverPanelVisible;
  FMouseOverPanelHeight := DefaultMouseOverPanelHeight;

  DefaultNonViewableCharFormat := DefaultDefaultNonViewableCharFormat;
  NamedDisplayCultureName := DefaultNamedDisplayCultureName;
  DisplayCultureType := DefaultDisplayCultureType;
  NamedDisplayCharEncodingName := DefaultNamedDisplayCharEncodingName;

  FResetMetaForNewOpenText := DefaultResetMetaForNewOpenText;
  FIgnoreDeclaredMeta := DefaultIgnoreDeclaredMeta;
  FMetaTextFormatting := TFieldedText.DefaultMetaTextIndented;
  FMetaTextIndentation := DefaultMetaTextIndentation;
  FMetaTextIndentChar := DefaultMetaTextIndentChar;
  FEmbeddedMetaMargin := DefaultEmbeddedMetaMargin;

  FNumberFromZero := DefaultNumberFromZero;

  FSaveDesignOnlyMeta := DefaultSaveDesignOnlyMeta;
  FSaveMetaWithExplicitIndices := DefaultSaveMetaWithExplicitIndices;

  FTextFont.Name := DefaultTextFontName;
  FColorText := DefaultColorText;
  FWrapText := DefaultWrapText;
  FTextTrackCursor := DefaultTextTrackCursor;
  FTextTrackMouse := DefaultTextTrackMouse;

  FGridHorizontalLinesVisible := DefaultGridHorizontalLinesVisible;
  FGridVerticalLinesVisible := DefaultGridVerticalLinesVisible;
  FGridShowFieldNamesIfNoFixedHeadingRows := DefaultGridShowFieldNamesIfNoFixedHeadingRows;
  FFixedHeadingRows := DefaultFixedHeadingRows;
  FGridTrackCursor := DefaultGridTrackCursor;
  FGridTrackMouse := DefaultGridTrackMouse;
  FGridRowSizeAuto := DefaultGridRowSizeAuto;
  FGridManualRowHeight := DefaultGridManualRowHeight;
  FGridNullText := DefaultGridNullText;

  FColorItems.LoadFromDefault;
  FColors := FColorItems.Resolve;

  FDefaultTextCharEncodingName := DefaultDefaultTextCharEncodingName;
  FDefaultMetaCharEncodingName := DefaultDefaultMetaCharEncodingName;
  FMaxOpenTextLines := DefaultMaxOpenTextLines;
end;

procedure TConfiguration.Load;
var
  FilePath: string;
  Strm: TFileStream;
  Doc: ITypedXmlDocument;
  LoadErrorMsg: string;
begin
  FilePath := TPath.Combine(TCommon.ApplicationDataFolder, XmlFileName);

  if not TFile.Exists(FilePath) then
    LoadFromDefault
  else
  begin
    Strm := TFileStream.Create(FilePath, fmOpenRead or fmShareDenyWrite);
    try
      LoadErrorMsg := '';
      Doc := TTypedXmlDocument.Create('');
      Doc.Options := [doNodeAutoIndent, doAttrNull];
      try
        Doc.LoadFromStream(Strm);
      except
        on E: EDOMParseError do
        begin
          LoadErrorMsg := 'Could not load Configuration File.  Parse Error'#13 +
                          'Error Code: ' + IntToStr(E.ErrorCode) + #13 +
                          'Reason: ' + E.Reason + #13 +
                          'File: ' + FilePath + #13 +
                          'FilePos: ' + IntToStr(E.FilePos) + #13 +
                          'Line Number: ' + IntToStr(E.Line) + #13 +
                          'Line Pos: ' + IntToStr(E.LinePos) + #13 +
                          'Using Default Configuration';
        end;
      end;
    finally
      Strm.Free;
    end;

    if LoadErrorMsg <> '' then
    begin
      MessageDlg(LoadErrorMsg, mtError, [mbOk], 0);
      LoadFromDefault;
    end
    else
    begin
      LoadFromXml(Doc.RootElement);
    end;
  end;
end;

procedure TConfiguration.LoadFromXml(XmlNode: ITypedXmlElement{;
                                     out ALeftFrame, AMiddleFrame, ARightFrame: ITypedXmlElement;
                                     out BLeftFrame, BMiddleFrame, BRightFrame: ITypedXmlElement});
var
  ChildElement: ITypedXmlElement;
  XmlValue: string;
begin
  if not XmlNode.TryGetStringAttr(XmlTag_ActiveLayoutConfigurationName, FActiveLayoutConfigurationName) then
  begin
    FActiveLayoutConfigurationName := DefaultActiveLayoutConfigurationName;
  end;
{  ChildElement := XmlNode.FindElement(XmlTag_LayoutConfigurations);
  if Assigned(ChildElement) then
    FLayoutConfiguration.LoadFromXml(ChildElement,
                                     ALeftFrame, AMiddleFrame, ARightFrame,
                                     BLeftFrame, BMiddleFrame, BRightFrame)
  else
  begin
    ALeftFrame := nil;
    AMiddleFrame := nil;
    ARightFrame := nil;
    BLeftFrame := nil;
    BMiddleFrame := nil;
    BRightFrame := nil;
  end; }
  if not XmlNode.TryGetBooleanAttr(XmlTag_MainWindowMaximised, FMainWindowMaximised) then
  begin
    FMainWindowMaximised := DefaultMainWindowMaximised;
  end;
  if not XmlNode.TryGetIntegerAttr(XmlTag_MainWindowTop, FMainWindowTop) then
  begin
    FMainWindowTop := DefaultMainWindowTop;
  end;
  if not XmlNode.TryGetIntegerAttr(XmlTag_MainWindowLeft, FMainWindowLeft) then
  begin
    FMainWindowLeft := DefaultMainWindowLeft;
  end;
  if not XmlNode.TryGetIntegerAttr(XmlTag_MainWindowHeight, FMainWindowHeight) then
  begin
    FMainWindowHeight := DefaultMainWindowHeight;
  end;
  if not XmlNode.TryGetIntegerAttr(XmlTag_MainWindowWidth, FMainWindowWidth) then
  begin
    FMainWindowWidth := DefaultMainWindowWidth;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_AutoParse, FAutoParse) then
  begin
    FAutoParse := DefaultAutoParse;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_AutoGenerate, FAutoGenerate) then
  begin
    FAutoGenerate := DefaultAutoGenerate;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_MouseOverPanelVisible, FMouseOverPanelVisible) then
  begin
    FMouseOverPanelVisible := DefaultMouseOverPanelVisible;
  end;
  if not XmlNode.TryGetIntegerAttr(XmlTag_MouseOverPanelHeight, FMouseOverPanelHeight) then
  begin
    FMouseOverPanelHeight := DefaultMouseOverPanelHeight;
  end;
  if not XmlNode.TryGetStringAttr(XmlTag_DefaultNonViewableCharFormat, XmlValue) then
    FDefaultNonViewableCharFormat := DefaultDefaultNonViewableCharFormat
  else
  begin
    if not TryXmlValueToNonViewableCharFormat(XmlValue, FDefaultNonViewableCharFormat) then
    begin
      FDefaultNonViewableCharFormat := DefaultDefaultNonViewableCharFormat
    end;
  end;
  if not XmlNode.TryGetStringAttr(XmlTag_DisplayCultureType, XmlValue) then
    FDisplayCultureType := DefaultDisplayCultureType
  else
  begin
    if not TryXmlValueToDisplayCultureType(XmlValue, FDisplayCultureType) then
    begin
      FDisplayCultureType := DefaultDisplayCultureType;
    end;
  end;
  if not XmlNode.TryGetStringAttr(XmlTag_NamedDisplayCultureName, FNamedDisplayCultureName) then
  begin
    FNamedDisplayCultureName := DefaultNamedDisplayCultureName;
  end;
  XmlNode.StringAttr[XmlTag_DisplayCharEncodingType] := DisplayCharEncodingTypeToXmlValue(DisplayCharEncodingType);
  if not XmlNode.TryGetStringAttr(XmlTag_NamedDisplayCharEncodingName, FNamedDisplayCharEncodingName) then
  begin
    FNamedDisplayCharEncodingName := DefaultNamedDisplayCharEncodingName;
  end;
  ChildElement := XmlNode.AddElement(XmlTag_TextFont);
  ChildElement.WriteFontAttr(TextFont);
  if not XmlNode.TryGetBooleanAttr(XmlTag_ColorText, FColorText) then
  begin
    FColorText := DefaultColorText;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_WrapText, FWrapText) then
  begin
    FWrapText := DefaultWrapText;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_TextTrackMouse, FTextTrackMouse) then
  begin
    FTextTrackMouse := DefaultTextTrackMouse;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_TextTrackCursor, FTextTrackCursor) then
  begin
    FTextTrackCursor := DefaultTextTrackCursor;
  end;
  ChildElement := XmlNode.AddElement(XmlTag_GridFont);
  ChildElement.WriteFontAttr(GridFont);
  if not XmlNode.TryGetBooleanAttr(XmlTag_GridHorizontalLinesVisible, FGridHorizontalLinesVisible) then
  begin
    FGridHorizontalLinesVisible := DefaultGridHorizontalLinesVisible;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_GridVerticalLinesVisible, FGridVerticalLinesVisible) then
  begin
    FGridVerticalLinesVisible := DefaultGridVerticalLinesVisible;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_GridShowFieldNamesIfNoFixedHeadingRows, FGridShowFieldNamesIfNoFixedHeadingRows) then
  begin
    FGridShowFieldNamesIfNoFixedHeadingRows := DefaultGridShowFieldNamesIfNoFixedHeadingRows;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_GridFixedHeadingRows, FFixedHeadingRows) then
  begin
    FFixedHeadingRows := DefaultFixedHeadingRows;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_GridTrackMouse, FGridTrackMouse) then
  begin
    FGridTrackMouse := DefaultGridTrackMouse;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_GridTrackCursor, FGridTrackCursor) then
  begin
    FGridTrackCursor := DefaultGridTrackCursor;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_GridRowHeightAuto, FGridRowSizeAuto) then
  begin
    FGridRowSizeAuto := DefaultGridRowSizeAuto;
  end;
  if not XmlNode.TryGetIntegerAttr(XmlTag_GridManualRowHeight, FGridManualRowHeight) then
  begin
    FGridManualRowHeight := DefaultGridManualRowHeight;
  end;
  if not XmlNode.TryGetStringAttr(XmlTag_GridNullText, FGridNullText) then
  begin
    FGridNullText := DefaultGridNullText;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_ResetMetaForNewOpenText, FResetMetaForNewOpenText) then
  begin
    FResetMetaForNewOpenText := DefaultResetMetaForNewOpenText;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_IgnoreDeclaredMeta, FIgnoreDeclaredMeta) then
  begin
    FIgnoreDeclaredMeta := DefaultIgnoreDeclaredMeta;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_MetaTextFormatting, FMetaTextFormatting) then
  begin
    FMetaTextFormatting := DefaultMetaTextFormatting;
  end;
  if not XmlNode.TryGetIntegerAttr(XmlTag_MetaTextIndentation, FMetaTextIndentation) then
  begin
    FMetaTextIndentation := DefaultMetaTextIndentation;
  end;
  if not XmlNode.TryGetStringAttr(XmlTag_MetaTextIndentChar, XmlValue) then
    FMetaTextIndentChar := DefaultMetaTextIndentChar
  else
  begin
    if Length(XmlValue) <> 1 then
      FMetaTextIndentChar := DefaultMetaTextIndentChar
    else
      FMetaTextIndentChar := XmlValue[1];
  end;
  if not XmlNode.TryGetIntegerAttr(XmlTag_EmbeddedMetaMargin, FEmbeddedMetaMargin) then
  begin
    FEmbeddedMetaMargin := DefaultEmbeddedMetaMargin;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_SaveDesignOnlyMeta, FSaveDesignOnlyMeta) then
  begin
    FSaveDesignOnlyMeta := DefaultSaveDesignOnlyMeta;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_SaveMetaWithExplicitIndices, FSaveMetaWithExplicitIndices) then
  begin
    FSaveMetaWithExplicitIndices := DefaultSaveMetaWithExplicitIndices;
  end;
  if not XmlNode.TryGetStringAttr(XmlTag_SourceOnNewOpenText, XmlValue) then
    FSourceOnNewOpenText := DefaultSourceOnNewOpenText
  else
  begin
    if not TryXmlValueToSourceOnNewOpenText(XmlValue, FSourceOnNewOpenText) then
    begin
      FSourceOnNewOpenText := DefaultSourceOnNewOpenText;
    end;
  end;
  if not XmlNode.TryGetStringAttr(XmlTag_DefaultTextCharEncodingName, FDefaultTextCharEncodingName) then
  begin
    FDefaultTextCharEncodingName := DefaultDefaultTextCharEncodingName;
  end;
  if not XmlNode.TryGetStringAttr(XmlTag_DefaultMetaCharEncodingName, FDefaultMetaCharEncodingName) then
  begin
    FDefaultMetaCharEncodingName := DefaultDefaultMetaCharEncodingName;
  end;
  if not XmlNode.TryGetInt64Attr(XmlTag_MaxOpenTextLines, FMaxOpenTextLines) then
  begin
    FMaxOpenTextLines := DefaultMaxOpenTextLines;
  end;
  if not XmlNode.TryGetBooleanAttr(XmlTag_NumberFromZero, FNumberFromZero) then
  begin
    FNumberFromZero := DefaultNumberFromZero;
  end;

  ChildElement := XmlNode.AddElement(XmlTag_ColorItems);
  FColorItems.LoadFromXml(ChildElement);
  FColors := FColorItems.Resolve;
end;

procedure TConfiguration.Save;
var
  FilePath: string;
  XMLDocument: ITypedXmlDocument;
  RootElement: ITypedXmlElement;
  Strm: TFileStream;
begin
//  PrepareForSerialize;
  if not TDirectory.Exists(TCommon.ApplicationDataFolder) then
  begin
    TDirectory.CreateDirectory(TCommon.ApplicationDataFolder);
  end;
  FilePath := TPath.Combine(TCommon.ApplicationDataFolder, XmlFileName);

  XMLDocument := TTypedXmlDocument.Create('');
  XMLDocument.Active := True;
  RootElement := XMLDocument.AddElement(XmlTag_RootElement);

  SaveToXml(RootElement);


  Strm := TFileStream.Create(FilePath, fmCreate or fmShareExclusive);
  try
    XmlDocument.SaveToStream(Strm);
  finally
    Strm.Free;
  end;
end;

procedure TConfiguration.SaveToXml(XmlNode: ITypedXmlElement);
var
  ChildElement: ITypedXmlElement;
begin
  XmlNode.StringAttr[XmlTag_ActiveLayoutConfigurationName] := ActiveLayoutConfigurationName;
//  ChildElement := XmlNode.AddElement(XmlTag_LayoutConfigurations);
//  FLayoutConfigurations.SaveToXml(ChildElement);
  XmlNode.BooleanAttr[XmlTag_MainWindowMaximised] := MainWindowMaximised;
  XmlNode.IntegerAttr[XmlTag_MainWindowTop] := MainWindowTop;
  XmlNode.IntegerAttr[XmlTag_MainWindowLeft] := MainWindowLeft;
  XmlNode.IntegerAttr[XmlTag_MainWindowHeight] := MainWindowHeight;
  XmlNode.IntegerAttr[XmlTag_MainWindowWidth] := MainWindowWidth;
  XmlNode.BooleanAttr[XmlTag_AutoParse] := AutoParse;
  XmlNode.BooleanAttr[XmlTag_AutoGenerate] := AutoGenerate;
  XmlNode.BooleanAttr[XmlTag_MouseOverPanelVisible] := MouseOverPanelVisible;
  XmlNode.IntegerAttr[XmlTag_MouseOverPanelHeight] := MouseOverPanelHeight;
  XmlNode.StringAttr[XmlTag_DefaultNonViewableCharFormat] := NonViewableCharFormatToXmlValue(DefaultNonViewableCharFormat);
  XmlNode.StringAttr[XmlTag_DisplayCultureType] := DisplayCultureTypeToXmlValue(DisplayCultureType);
  XmlNode.StringAttr[XmlTag_NamedDisplayCultureName] := NamedDisplayCultureName;
  XmlNode.StringAttr[XmlTag_DisplayCharEncodingType] := DisplayCharEncodingTypeToXmlValue(DisplayCharEncodingType);
  XmlNode.StringAttr[XmlTag_NamedDisplayCharEncodingName] := NamedDisplayCharEncodingName;
  ChildElement := XmlNode.AddElement(XmlTag_TextFont);
  ChildElement.WriteFontAttr(TextFont);
  XmlNode.BooleanAttr[XmlTag_ColorText] := ColorText;
  XmlNode.BooleanAttr[XmlTag_WrapText] := WrapText;
  XmlNode.BooleanAttr[XmlTag_TextTrackMouse] := TextTrackMouse;
  XmlNode.BooleanAttr[XmlTag_TextTrackCursor] := TextTrackCursor;
  ChildElement := XmlNode.AddElement(XmlTag_GridFont);
  ChildElement.WriteFontAttr(GridFont);
  XmlNode.BooleanAttr[XmlTag_GridHorizontalLinesVisible] := GridHorizontalLinesVisible;
  XmlNode.BooleanAttr[XmlTag_GridVerticalLinesVisible] := GridVerticalLinesVisible;
  XmlNode.BooleanAttr[XmlTag_GridShowFieldNamesIfNoFixedHeadingRows] := GridShowFieldNamesIfNoFixedHeadingRows;
  XmlNode.BooleanAttr[XmlTag_GridFixedHeadingRows] := GridFixedHeadingRows;
  XmlNode.BooleanAttr[XmlTag_GridTrackMouse] := GridTrackMouse;
  XmlNode.BooleanAttr[XmlTag_GridTrackCursor] := GridTrackCursor;
  XmlNode.BooleanAttr[XmlTag_GridRowHeightAuto] := GridRowHeightAuto;
  XmlNode.IntegerAttr[XmlTag_GridManualRowHeight] := GridManualRowHeight;
  XmlNode.StringAttr[XmlTag_GridNullText] := GridNullText;
  XmlNode.BooleanAttr[XmlTag_ResetMetaForNewOpenText] := ResetMetaForNewOpenText;
  XmlNode.BooleanAttr[XmlTag_IgnoreDeclaredMeta] := IgnoreDeclaredMeta;
  XmlNode.BooleanAttr[XmlTag_MetaTextFormatting] := MetaTextFormatting;
  XmlNode.IntegerAttr[XmlTag_MetaTextIndentation] := MetaTextIndentation;
  XmlNode.StringAttr[XmlTag_MetaTextIndentChar] := MetaTextIndentChar;
  XmlNode.IntegerAttr[XmlTag_EmbeddedMetaMargin] := EmbeddedMetaMargin;
  XmlNode.BooleanAttr[XmlTag_SaveDesignOnlyMeta] := SaveDesignOnlyMeta;
  XmlNode.BooleanAttr[XmlTag_SaveMetaWithExplicitIndices] := SaveMetaWithExplicitIndices;
  XmlNode.StringAttr[XmlTag_SourceOnNewOpenText] := SourceOnNewOpenTextToXmlValue(SourceOnNewOpenText);
  XmlNode.StringAttr[XmlTag_DefaultTextCharEncodingName] := DefaultTextCharEncodingName;
  XmlNode.StringAttr[XmlTag_DefaultMetaCharEncodingName] := DefaultMetaCharEncodingName;
  XmlNode.Int64Attr[XmlTag_MaxOpenTextLines] := MaxOpenTextLines;
  XmlNode.BooleanAttr[XmlTag_NumberFromZero] := NumberFromZero;
  ChildElement := XmlNode.AddElement(XmlTag_ColorItems);
  ColorItems.SaveToXml(ChildElement);
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

procedure TConfiguration.SetNamedDisplayCharEncoding(const Value: TEncoding);
begin
  if Assigned(FNamedDisplayCharEncoding) and not TEncoding.IsStandardEncoding(FNamedDisplayCharEncoding) then
  begin
    FNamedDisplayCharEncoding.Free;
  end;

  FNamedDisplayCharEncoding := Value;
  FNamedDisplayCharEncodingName := Value.EncodingName;
end;

procedure TConfiguration.SetNamedDisplayCharEncodingName(const Value: string);
begin
  NamedDisplayCharEncoding := TEncoding.GetEncoding(Value);
end;

procedure TConfiguration.SetNamedDisplayCulture(const Value: TFieldedTextLocaleSettings);
begin
  FNamedDisplayCulture := Value;
  FNamedDisplayCultureName := FNamedDisplayCulture.Name;
end;

procedure TConfiguration.SetNamedDisplayCultureName(const Value: string);
begin
  FNamedDisplayCultureName := Value;
  FNamedDisplayCulture := TFieldedTextLocaleSettings.Create(FNamedDisplayCultureName);
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

initialization;
  InitializeUnit;

end.
