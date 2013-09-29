// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.TypedXml;

interface

{$WARN UNIT_PLATFORM OFF}

uses XmlIntf, XmlDoc, XMLDOM, SysUtils, Forms,
     Graphics, Classes, Controls;

type
  ITypedXmlElement = interface(IXMLNode)
    ['{903D5636-1DCC-46BB-88D3-27BE38E775AE}']
    function AddElement(const TagName: DOMString; Index: Integer = -1): ITypedXmlElement;
    function FindElement(const NodeName: DOMString): ITypedXmlElement;
    function ForceFindElement(const NodeName: DOMString): ITypedXmlElement;
    procedure Normalize;

    function GetAttributeExists(const AttrName: DOMString): Boolean;
    property AttributeExists[const AttrName: DOMString]: Boolean read GetAttributeExists;

    function TryGetStringAttr(const AttrName: DOMString; out Value: string): Boolean;
    function GetStringAttr(const AttrName: DOMString; const DefaultValue: string): string;
    procedure SetStringAttr(const AttrName: DOMString; const Value: string); overload;
    procedure SetStringAttr(const AttrName: DOMString; const Value: string; const DefaultValue: string); overload;
    property StringAttr[const AttrName: DOMString]: string write SetStringAttr;

    function TryGetGuidAttr(const AttrName: DOMString; out Value: TGuid): Boolean;
    function GetGuidAttr(const AttrName: DOMString; const DefaultValue: TGuid): TGuid;
    procedure SetGuidAttr(const AttrName: DOMString; const Value: TGuid); overload;
    procedure SetGuidAttr(const AttrName: DOMString; const Value: TGuid; const DefaultValue: TGuid); overload;
    property GuidAttr[const AttrName: DOMString]: TGuid write SetGuidAttr;

    function TryGetIntegerAttr(const AttrName: DOMString; out Value: Integer): Boolean;
    function GetIntegerAttr(const AttrName: DOMString; DefaultValue: Integer): Integer;
    procedure SetIntegerAttr(const AttrName: DOMString; const Value: Integer); overload;
    procedure SetIntegerAttr(const AttrName: DOMString; const Value: Integer; const DefaultValue: Integer); overload;
    property IntegerAttr[const AttrName: DOMString]: Integer write SetIntegerAttr;

    function TryGetInt64Attr(const AttrName: DOMString; out Value: Int64): Boolean;
    function GetInt64Attr(const AttrName: DOMString; const DefaultValue: Int64): Int64;
    procedure SetInt64Attr(const AttrName: DOMString; const Value: Int64); overload;
    procedure SetInt64Attr(const AttrName: DOMString; const Value: Int64; const DefaultValue: Int64); overload;
    property Int64Attr[const AttrName: DOMString]: Int64 write SetInt64Attr;

    function TryGetFloatAttr(const AttrName: DOMString; out Value: Double): Boolean; overload;
    function GetFloatAttr(const AttrName: DOMString; const DefaultValue: Double): Double;
    procedure SetFloatAttr(const AttrName: DOMString; const Value: Double); overload;
    procedure SetFloatAttr(const AttrName: DOMString; const Value: Double; const DefaultValue: Double); overload;
    property FloatAttr[const AttrName: DOMString]: Double write SetFloatAttr;

    function TryGetCurrencyAttr(const AttrName: DOMString; out Value: Currency): Boolean;
    function GetCurrencyAttr(const AttrName: DOMString; const DefaultValue: Currency): Currency;
    procedure SetCurrencyAttr(const AttrName: DOMString; const Value: Currency); overload;
    procedure SetCurrencyAttr(const AttrName: DOMString; const Value: Currency; const DefaultValue: Currency); overload;
    property CurrencyAttr[const AttrName: DOMString]: Currency write SetCurrencyAttr;

    function TryGetDateTimeAttr(const AttrName: DOMString; out Value: TDateTime): Boolean;
    function GetDateTimeAttr(const AttrName: DOMString; const DefaultValue: TDateTime): TDateTime;
    procedure SetDateTimeAttr(const AttrName: DOMString; const Value: TDateTime); overload;
    procedure SetDateTimeAttr(const AttrName: DOMString; const Value: TDateTime; const DefaultValue: TDateTime); overload;
    property DateTimeAttr[const AttrName: DOMString]: TDateTime write SetDateTimeAttr;

    function TryGetBooleanAttr(const AttrName: DOMString; out Value: Boolean): Boolean;
    function GetBooleanAttr(const AttrName: DOMString; DefaultValue: Boolean): Boolean;
    procedure SetBooleanAttr(const AttrName: DOMString; const Value: Boolean); overload;
    procedure SetBooleanAttr(const AttrName: DOMString; const Value: Boolean; const DefaultValue: Boolean); overload;
    property BooleanAttr[const AttrName: DOMString]: Boolean write SetBooleanAttr;

    function TryGetStreamHexCData(const CDataName: DOMString; out Value: TStream): Boolean;
    function GetStreamHexCData(const CDataName: DOMString; DefaultValue: TStream): TStream;
    procedure SetStreamHexCData(const CDataName: DOMString; const Value: TStream); overload;
    procedure SetStreamHexCData(const CDataName: DOMString; const Value: TStream; const DefaultValue: TStream); overload;
    property StreamHexCData[const CDataName: DOMString]: TStream write SetStreamHexCData;

    function TryGetColorAttr(const AttrName: DOMString; out Value: TColor): Boolean;
    function GetColorAttr(const AttrName: DOMString; DefaultValue: TColor): TColor;
    procedure SetColorAttr(const AttrName: DOMString; const Value: TColor); overload;
    procedure SetColorAttr(const AttrName: DOMString; const Value: TColor; const DefaultValue: TColor); overload;
    property ColorAttr[const AttrName: DOMString]: TColor write SetColorAttr;

    function TryGetFontStylesAttr(const AttrName: DOMString; out Value: TFontStyles): Boolean;
    function GetFontStylesAttr(const AttrName: DOMString; const DefaultValue: TFontStyles): TFontStyles;
    procedure SetFontStylesAttr(const AttrName: DOMString; const Value: TFontStyles); overload;
    procedure SetFontStylesAttr(const AttrName: DOMString; const Value: TFontStyles; const DefaultValue: TFontStyles); overload;
    property FontStylesAttr[const AttrName: DOMString]: TFontStyles write SetFontStylesAttr;

    function TryGetFontPitchAttr(const AttrName: DOMString; out Value: TFontPitch): Boolean;
    function GetFontPitchAttr(const AttrName: DOMString; DefaultValue: TFontPitch): TFontPitch;
    procedure SetFontPitchAttr(const AttrName: DOMString; const Value: TFontPitch); overload;
    procedure SetFontPitchAttr(const AttrName: DOMString; const Value: TFontPitch; const DefaultValue: TFontPitch); overload;
    property FontPitchAttr[const AttrName: DOMString]: TFontPitch write SetFontPitchAttr;

    function TryGetAlignmentAttr(const AttrName: DOMString; out Value: TAlignment): Boolean;
    function GetAlignmentAttr(const AttrName: DOMString; DefaultValue: TAlignment): TAlignment;
    procedure SetAlignmentAttr(const AttrName: DOMString; const Value: TAlignment); overload;
    procedure SetAlignmentAttr(const AttrName: DOMString; const Value: TAlignment; const DefaultValue: TAlignment); overload;
    property AlignmentAttr[const AttrName: DOMString]: TAlignment write SetAlignmentAttr;

    function TryGetBevelCutAttr(const AttrName: DOMString; out Value: TBevelCut): Boolean;
    function GetBevelCutAttr(const AttrName: DOMString; DefaultValue: TBevelCut): TBevelCut;
    procedure SetBevelCutAttr(const AttrName: DOMString; const Value: TBevelCut); overload;
    procedure SetBevelCutAttr(const AttrName: DOMString; const Value: TBevelCut; const DefaultValue: TBevelCut); overload;
    property BevelCutAttr[const AttrName: DOMString]: TBevelCut write SetBevelCutAttr;

    function TryGetPenStyleAttr(const AttrName: DOMString; out Value: TPenStyle): Boolean;
    function GetPenStyleAttr(const AttrName: DOMString; DefaultValue: TPenStyle): TPenStyle;
    procedure SetPenStyleAttr(const AttrName: DOMString; const Value: TPenStyle); overload;
    procedure SetPenStyleAttr(const AttrName: DOMString; const Value: TPenStyle; const DefaultValue: TPenStyle); overload;
    property PenStyleAttr[const AttrName: DOMString]: TPenStyle write SetPenStyleAttr;

    function TryGetPenModeAttr(const AttrName: DOMString; out Value: TPenMode): Boolean;
    function GetPenModeAttr(const AttrName: DOMString; DefaultValue: TPenMode): TPenMode;
    procedure SetPenModeAttr(const AttrName: DOMString; const Value: TPenMode); overload;
    procedure SetPenModeAttr(const AttrName: DOMString; const Value: TPenMode; const DefaultValue: TPenMode); overload;
    property PenModeAttr[const AttrName: DOMString]: TPenMode write SetPenModeAttr;

    function TryGetWindowStateAttr(const AttrName: DOMString; out Value: TWindowState): Boolean;
    function GetWindowStateAttr(const AttrName: DOMString; DefaultValue: TWindowState): TWindowState;
    procedure SetWindowStateAttr(const AttrName: DOMString; const Value: TWindowState); overload;
    procedure SetWindowStateAttr(const AttrName: DOMString; const Value: TWindowState; const DefaultValue: TWindowState); overload;
    property WindowStateAttr[const AttrName: DOMString]: TWindowState write SetWindowStateAttr;

    function TryGetPicture(const PictureName: DOMString; out Value: TPicture): Boolean;
    function GetPicture(const PictureName: DOMString; DefaultValue: TPicture): TPicture;
    procedure SetPicture(const PictureName: DOMString; const Value: TPicture); overload;
    procedure SetPicture(const PictureName: DOMString; const Value: TPicture; const DefaultValue: TPicture); overload;
    property Picture[const PictureName: DOMString]: TPicture write SetPicture;

    function TryReadFontAttr(Font: TFont): Boolean;
    procedure WriteFontAttr(Font: TFont);
  end;

  ITypedXmlDocument = interface(IXmlDocument)
    ['{E0EE9853-63FD-4DF2-BEF5-FCEDD7CDF937}']
    function GetRootElement: ITypedXmlElement;
    property RootElement: ITypedXmlElement read GetRootElement;
    function AddElement(const TagName: DOMString): ITypedXmlElement;
  end;

  TTypedXmlNode = class(TXmlNode, ITypedXmlElement)
  public
  public
    type
      EReadError = class(Exception)
      private
        FXmlNode: ITypedXmlElement;
        FAttributeName: string;
      public
        constructor Create(const Msg: string; Node: ITypedXmlElement; const AttrName: string);
        property XmlNode: ITypedXmlElement read FXmlNode;
        property AttributeName: string read FAttributeName;
      end;

    const
      XmlTag_FontName = 'FontName';
      XmlTag_FontSize = 'FontSize';
      XmlTag_FontColor = 'FontColor';
      XmlTag_FontStyles = 'FontStyles';
      XmlTag_FontCharsetIdent = 'FontCharsetIdent';
      XmlTag_FontPitch = 'FontPitch';

      NullDateTime = 0.0;

      BooleanTrue = 'T';
      BooleanFalse = 'F';

      GraphicType_Bitmap = 'B';
      GraphicType_Metafile = 'M';
      DefaultGraphicType = GraphicType_Bitmap;
      GraphicTypePrefix = 'GraphicType_';

      FontStyleStr_Bold = 'Bold';

  private
    function XmlStrToDateTime(const Value: string): TDateTime;
    function DateTimeToXmlStr(const Value: TDateTime): string;

    procedure Normalize;

  protected
    type
      TFontStyleStrings = array[TFontStyle] of string;
      TFontPitchStrings = array[TFontPitch] of string;
      TAlignmentStrings = array[TAlignment] of string;
      TBevelCutStrings = array[TBevelCut] of string;
      TPenStyleStrings = array[TPenStyle] of string;
      TPenModeStrings = array[TPenMode] of string;
      TWindowStateStrings = array[TWindowState] of string;

    class var
      FontStyleStrings: TFontStyleStrings;
      FontPitchStrings: TFontPitchStrings;
      AlignmentStrings: TAlignmentStrings;
      BevelCutStrings: TBevelCutStrings;
      PenStyleStrings: TPenStyleStrings;
      PenModeStrings: TPenModeStrings;
      WindowStateStrings: TWindowStateStrings;

    class constructor Create;

    function AddElement(const TagName: DOMString; Index: Integer = -1): ITypedXmlElement;
    function FindElement(const NodeName: DOMString): ITypedXmlElement;
    function ForceFindElement(const NodeName: DOMString): ITypedXmlElement;

    function ForceFindAttributeNode(const AttrName: DOMString): IXMLNode;
    function FindCDataNode(const CDataName: DOMString): IXMLNode;
    function ForceFindCDataNode(const CDataName: DOMString): IXMLNode;

    function GetAttributeExists(const AttrName: DOMString): Boolean;

    function TryGetStringAttr(const AttrName: DOMString; out Value: string): Boolean;
    function GetStringAttr(const AttrName: DOMString; const DefaultValue: string): string;
    procedure SetStringAttr(const AttrName: DOMString; const Value: string); overload;
    procedure SetStringAttr(const AttrName: DOMString; const Value: string; const DefaultValue: string); overload;
    property StringAttr[const AttrName: DOMString]: string write SetStringAttr;

    function TryGetGuidAttr(const AttrName: DOMString; out Value: TGuid): Boolean;
    function GetGuidAttr(const AttrName: DOMString; const DefaultValue: TGuid): TGuid;
    procedure SetGuidAttr(const AttrName: DOMString; const Value: TGuid); overload;
    procedure SetGuidAttr(const AttrName: DOMString; const Value: TGuid; const DefaultValue: TGuid); overload;
    property GuidAttr[const AttrName: DOMString]: TGuid write SetGuidAttr;

    function TryGetIntegerAttr(const AttrName: DOMString; out Value: Integer): Boolean;
    function GetIntegerAttr(const AttrName: DOMString; DefaultValue: Integer): Integer;
    procedure SetIntegerAttr(const AttrName: DOMString; const Value: Integer); overload;
    procedure SetIntegerAttr(const AttrName: DOMString; const Value: Integer; const DefaultValue: Integer); overload;
    property IntegerAttr[const AttrName: DOMString]: Integer write SetIntegerAttr;

    function TryGetInt64Attr(const AttrName: DOMString; out Value: Int64): Boolean;
    function GetInt64Attr(const AttrName: DOMString; const DefaultValue: Int64): Int64;
    procedure SetInt64Attr(const AttrName: DOMString; const Value: Int64); overload;
    procedure SetInt64Attr(const AttrName: DOMString; const Value: Int64; const DefaultValue: Int64); overload;
    property Int64Attr[const AttrName: DOMString]: Int64 write SetInt64Attr;

    function TryGetFloatAttr(const AttrName: DOMString; out Value: Double): Boolean;
    function GetFloatAttr(const AttrName: DOMString; const DefaultValue: Double): Double;
    procedure SetFloatAttr(const AttrName: DOMString; const Value: Double); overload;
    procedure SetFloatAttr(const AttrName: DOMString; const Value: Double; const DefaultValue: Double); overload;
    property FloatAttr[const AttrName: DOMString]: Double write SetFloatAttr;

    function TryGetCurrencyAttr(const AttrName: DOMString; out Value: Currency): Boolean;
    function GetCurrencyAttr(const AttrName: DOMString; const DefaultValue: Currency): Currency;
    procedure SetCurrencyAttr(const AttrName: DOMString; const Value: Currency); overload;
    procedure SetCurrencyAttr(const AttrName: DOMString; const Value: Currency; const DefaultValue: Currency); overload;
    property CurrencyAttr[const AttrName: DOMString]: Currency write SetCurrencyAttr;

    function TryGetDateTimeAttr(const AttrName: DOMString; out Value: TDateTime): Boolean;
    function GetDateTimeAttr(const AttrName: DOMString; const DefaultValue: TDateTime): TDateTime;
    procedure SetDateTimeAttr(const AttrName: DOMString; const Value: TDateTime); overload;
    procedure SetDateTimeAttr(const AttrName: DOMString; const Value: TDateTime; const DefaultValue: TDateTime); overload;
    property DateTimeAttr[const AttrName: DOMString]: TDateTime write SetDateTimeAttr;

    function TryGetBooleanAttr(const AttrName: DOMString; out Value: Boolean): Boolean;
    function GetBooleanAttr(const AttrName: DOMString; DefaultValue: Boolean): Boolean;
    procedure SetBooleanAttr(const AttrName: DOMString; const Value: Boolean); overload;
    procedure SetBooleanAttr(const AttrName: DOMString; const Value: Boolean; const DefaultValue: Boolean); overload;
    property BooleanAttr[const AttrName: DOMString]: Boolean write SetBooleanAttr;

    function TryGetStreamHexCData(const CDataName: DOMString; out Value: TStream): Boolean;
    function GetStreamHexCData(const CDataName: DOMString; DefaultValue: TStream): TStream;
    procedure SetStreamHexCData(const CDataName: DOMString; const Value: TStream); overload;
    procedure SetStreamHexCData(const CDataName: DOMString; const Value: TStream; const DefaultValue: TStream); overload;
    property StreamHexCData[const CDataName: DOMString]: TStream write SetStreamHexCData;

    function TryGetColorAttr(const AttrName: DOMString; out Value: TColor): Boolean;
    function GetColorAttr(const AttrName: DOMString; DefaultValue: TColor): TColor;
    procedure SetColorAttr(const AttrName: DOMString; const Value: TColor); overload;
    procedure SetColorAttr(const AttrName: DOMString; const Value: TColor; const DefaultValue: TColor); overload;
    property ColorAttr[const AttrName: DOMString]: TColor write SetColorAttr;

    function TryGetFontStylesAttr(const AttrName: DOMString; out Value: TFontStyles): Boolean;
    function GetFontStylesAttr(const AttrName: DOMString; const DefaultValue: TFontStyles): TFontStyles;
    procedure SetFontStylesAttr(const AttrName: DOMString; const Value: TFontStyles); overload;
    procedure SetFontStylesAttr(const AttrName: DOMString; const Value: TFontStyles; const DefaultValue: TFontStyles); overload;
    property FontStylesAttr[const AttrName: DOMString]: TFontStyles write SetFontStylesAttr;

    function TryGetFontPitchAttr(const AttrName: DOMString; out Value: TFontPitch): Boolean;
    function GetFontPitchAttr(const AttrName: DOMString; DefaultValue: TFontPitch): TFontPitch;
    procedure SetFontPitchAttr(const AttrName: DOMString; const Value: TFontPitch); overload;
    procedure SetFontPitchAttr(const AttrName: DOMString; const Value: TFontPitch; const DefaultValue: TFontPitch); overload;
    property FontPitchAttr[const AttrName: DOMString]: TFontPitch write SetFontPitchAttr;

    function TryGetAlignmentAttr(const AttrName: DOMString; out Value: TAlignment): Boolean;
    function GetAlignmentAttr(const AttrName: DOMString; DefaultValue: TAlignment): TAlignment;
    procedure SetAlignmentAttr(const AttrName: DOMString; const Value: TAlignment); overload;
    procedure SetAlignmentAttr(const AttrName: DOMString; const Value: TAlignment; const DefaultValue: TAlignment); overload;
    property AlignmentAttr[const AttrName: DOMString]: TAlignment write SetAlignmentAttr;

    function TryGetBevelCutAttr(const AttrName: DOMString; out Value: TBevelCut): Boolean;
    function GetBevelCutAttr(const AttrName: DOMString; DefaultValue: TBevelCut): TBevelCut;
    procedure SetBevelCutAttr(const AttrName: DOMString; const Value: TBevelCut); overload;
    procedure SetBevelCutAttr(const AttrName: DOMString; const Value: TBevelCut; const DefaultValue: TBevelCut); overload;
    property BevelCutAttr[const AttrName: DOMString]: TBevelCut write SetBevelCutAttr;

    function TryGetPenStyleAttr(const AttrName: DOMString; out Value: TPenStyle): Boolean;
    function GetPenStyleAttr(const AttrName: DOMString; DefaultValue: TPenStyle): TPenStyle;
    procedure SetPenStyleAttr(const AttrName: DOMString; const Value: TPenStyle); overload;
    procedure SetPenStyleAttr(const AttrName: DOMString; const Value: TPenStyle; const DefaultValue: TPenStyle); overload;
    property PenStyleAttr[const AttrName: DOMString]: TPenStyle write SetPenStyleAttr;

    function TryGetPenModeAttr(const AttrName: DOMString; out Value: TPenMode): Boolean;
    function GetPenModeAttr(const AttrName: DOMString; DefaultValue: TPenMode): TPenMode;
    procedure SetPenModeAttr(const AttrName: DOMString; const Value: TPenMode); overload;
    procedure SetPenModeAttr(const AttrName: DOMString; const Value: TPenMode; const DefaultValue: TPenMode); overload;
    property PenModeAttr[const AttrName: DOMString]: TPenMode write SetPenModeAttr;

    function TryGetWindowStateAttr(const AttrName: DOMString; out Value: TWindowState): Boolean;
    function GetWindowStateAttr(const AttrName: DOMString; DefaultValue: TWindowState): TWindowState;
    procedure SetWindowStateAttr(const AttrName: DOMString; const Value: TWindowState); overload;
    procedure SetWindowStateAttr(const AttrName: DOMString; const Value: TWindowState; const DefaultValue: TWindowState); overload;
    property WindowStateAttr[const AttrName: DOMString]: TWindowState write SetWindowStateAttr;

    function TryGetPicture(const PictureName: DOMString; out Value: TPicture): Boolean;
    function GetPicture(const PictureName: DOMString; DefaultValue: TPicture): TPicture;
    procedure SetPicture(const PictureName: DOMString; const Value: TPicture); overload;
    procedure SetPicture(const PictureName: DOMString; const Value: TPicture; const DefaultValue: TPicture); overload;
    property Picture[const PictureName: DOMString]: TPicture write SetPicture;

    function TryReadFontAttr(Font: TFont): Boolean;
    procedure WriteFontAttr(Font: TFont);
  public
    class function GenerateReadErrorText(const OperationMsg: string;
                                         const FileName: string;
                                         const Msg: string;
                                         XmlNode: IXmlNode;
                                         const AttributeName: string): string;

    class function FontStylesToString(const Value: TFontStyles): string;
    class function StringToFontStyles(const Value: string): TFontStyles;
  end;

  TTypedXmlDocument = class(TXmlDocument, ITypedXmlDocument)
  protected
    function GetRootElement: ITypedXmlElement;
    function GetChildNodeClass(const Node: IDOMNode): TXMLNodeClass; override;
  public
    property RootElement: ITypedXmlElement read GetRootElement;
    function AddElement(const TagName: DOMString): ITypedXmlElement;
  end;

implementation

uses
  System.UITypes,
  Variants,
  Xilytix.FieldedText.Utils;

{ TPcXmlNode }

function TTypedXmlNode.AddElement(const TagName: DOMString;
  Index: Integer): ITypedXmlElement;
begin
  Result := AddChild(TagName, Index) as ITypedXmlElement;
end;

class constructor TTypedXmlNode.Create;
begin
  FontStyleStrings[fsBold] := FontStyleStr_Bold;
  FontStyleStrings[fsItalic] := 'Italic';
  FontStyleStrings[fsUnderline] := 'Underline';
  FontStyleStrings[fsStrikeOut] := 'StrikeOut';

  FontPitchStrings[fpDefault] := 'Default';
  FontPitchStrings[fpVariable] := 'Variable';
  FontPitchStrings[fpFixed] := 'Fixed';

  AlignmentStrings[taLeftJustify] := 'Left';
  AlignmentStrings[taRightJustify] := 'Right';
  AlignmentStrings[taCenter] := 'Centre';

  BevelCutStrings[bvNone] := 'None';
  BevelCutStrings[bvLowered] := 'Lowered';
  BevelCutStrings[bvRaised] := 'Raised';
  BevelCutStrings[bvSpace] := 'Space';

  PenStyleStrings[psSolid] := 'Solid';
  PenStyleStrings[psDash] := 'Dash';
  PenStyleStrings[psDashDot] := 'DashDot';
  PenStyleStrings[psDashDotDot] := 'DashDotDot';
  PenStyleStrings[psClear] := 'Clear';
  PenStyleStrings[psInsideFrame] := 'InsideFrame';

  PenModeStrings[pmBlack] := 'Black';
  PenModeStrings[pmWhite] := 'White';
  PenModeStrings[pmNop] := 'Nop';
  PenModeStrings[pmNot] := 'Not';
  PenModeStrings[pmCopy] := 'Copy';
  PenModeStrings[pmNotCopy] := 'NotCopy';
  PenModeStrings[pmMergePenNot] := 'MergePenNot';
  PenModeStrings[pmMaskPenNot] := 'MaskPenNot';
  PenModeStrings[pmMergeNotPen] := 'MergeNotPen';
  PenModeStrings[pmMaskNotPen] := 'MaskNotPen';
  PenModeStrings[pmMerge] := 'Merge';
  PenModeStrings[pmNotMerge] := 'NotMerge';
  PenModeStrings[pmMask] := 'Mask';
  PenModeStrings[pmNotMask] := 'NotMask';
  PenModeStrings[pmXor] := 'Xor';
  PenModeStrings[pmNotXor] := 'NotXor';

  WindowStateStrings[wsNormal] := 'Normal';
  WindowStateStrings[wsMinimized] := 'Minimized';
  WindowStateStrings[wsMaximized] := 'Maximized';
end;

function TTypedXmlNode.DateTimeToXmlStr(const Value: TDateTime): string;
var
  DateValue, TimeValue: TDateTime;
begin
  DateValue := Trunc(Value);
  if DateValue = NullDateTime then
    Result := ''
  else
    Result := FormatDateTime('YYYYMMDD', Value);

  TimeValue := Frac(Value);
  if (TimeValue <> NullDateTime) or (Result = '') then
  begin
    Result := Result + ':' + FormatDateTime('HHNNSS', Value);
  end;
end;

function TTypedXmlNode.FindCDataNode(const CDataName: DOMString): IXMLNode;
var
  Node: IXmlNode;
begin
  Result := nil;
  Node := ChildNodes.FindNode(CDataName);
  if Assigned(Node) and (Node.ChildNodes.Count > 0) and (Node.ChildNodes.Nodes[0].NodeType = ntCData) then
  begin
    Result := Node.ChildNodes.Nodes[0];
  end;
end;

function TTypedXmlNode.FindElement(const NodeName: DOMString): ITypedXmlElement;
begin
  Result := ChildNodes.FindNode(NodeName) as ITypedXmlElement;
  if Assigned(Result) and (Result.NodeType <> ntElement) then
  begin
    Result := nil;
  end;
end;

class function TTypedXmlNode.FontStylesToString(const Value: TFontStyles): string;
var
  I: TFontStyle;
  StrList: TStringList;
begin
  StrList := TStringList.Create;
  try
    for I := Low(TFontStyle) to High(TFontStyle) do
    begin
      if I in Value then
      begin
        StrList.Add(FontStyleStrings[I]);
      end;
    end;

    Result := StrList.CommaText;
  finally
    StrList.Free;
  end;
end;

function TTypedXmlNode.ForceFindAttributeNode(
  const AttrName: DOMString): IXMLNode;
begin
  Result := AttributeNodes.FindNode(AttrName);
  if not Assigned(Result) then
  begin
    Result := OwnerDocument.CreateNode(AttrName, ntAttribute);
    AttributeNodes.Add(Result);
  end;
end;

function TTypedXmlNode.ForceFindCDataNode(const CDataName: DOMString): IXMLNode;
var
  Node: IXMLNode;
begin
  Node := ChildNodes.FindNode(CDataName);
  if not Assigned(Node) then
  begin
    Node := AddChild(CDataName);
  end;

  if Node.ChildNodes.Count = 0 then
  begin
    Result := OwnerDocument.CreateNode('', ntCData);
    Node.ChildNodes.Add(Result);
  end
  else
  begin
    if Node.ChildNodes[0].NodeType = ntCData then
      Result := Node.ChildNodes[0]
    else
      raise EReadError.Create('CData Node expected', Self, CDataName);
  end;
end;

function TTypedXmlNode.ForceFindElement(
  const NodeName: DOMString): ITypedXmlElement;
begin
  Result := FindElement(NodeName);
  if not Assigned(Result) then
  begin
    Result := AddElement(NodeName);
  end;
end;

class function TTypedXmlNode.GenerateReadErrorText(const OperationMsg, FileName,
  Msg: string; XmlNode: IXmlNode; const AttributeName: string): string;
var
  NodePath: string;
  AttributeValue: string;
begin
  NodePath := XmlNode.NodeName;
  while Assigned(XmlNode.ParentNode) do
  begin
    XmlNode := XmlNode.ParentNode;
    NodePath := XmlNode.NodeName + '/' + NodePath;
  end;

  Result := OperationMsg + #13 +
            'Message: "' + Msg + '"'#13 +
            'File: "' + FileName + '"'#13 +
            'Node: "/' + NodePath  + '"'#13 +
            'Node Text: "' + XmlNode.Text + '"'#13;
  if AttributeName <> '' then
  begin
    if not XmlNode.HasAttribute(AttributeName) then
      AttributeValue := '<Not Exists>'
    else
      AttributeValue := XmlNode.Attributes[AttributeName];
    Result := Result + 'Attribute: "' + AttributeName + '=' + AttributeValue + '"';
  end;
end;

function TTypedXmlNode.GetAlignmentAttr(const AttrName: DOMString; DefaultValue: TAlignment): TAlignment;
begin
  if not TryGetAlignmentAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetAttributeExists(const AttrName: DOMString): Boolean;
var
  Node: IXMLNode;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
end;

function TTypedXmlNode.TryGetAlignmentAttr(const AttrName: DOMString;
  out Value: TAlignment): Boolean;
var
  Node: IXMLNode;
  NodeText: string;
  I: TAlignment;
  Found: Boolean;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    NodeText := Node.Text;
    Found := False;
    for I := Low(AlignmentStrings) to High(AlignmentStrings) do
    begin
      if AlignmentStrings[I] = NodeText then
      begin
        Found := True;
        Value := I;
        Break;
      end;
    end;

    if not Found then
    begin
      raise EReadError.Create('Alignment ' + NodeText + ' not known', Self, AttrName);
    end;
  end;
end;

{function TPcXmlNode.GetAttributeExists(const AttrName: DOMString): Boolean;
begin
  Result := get_AttributeExists(AttrName);
end;}

function TTypedXmlNode.GetBevelCutAttr(const AttrName: DOMString; DefaultValue: TBevelCut): TBevelCut;
begin
  if not TryGetBevelCutAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetBooleanAttr(const AttrName: DOMString;
  DefaultValue: Boolean): Boolean;
begin
  if not TryGetBooleanAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.TryGetBevelCutAttr(const AttrName: DOMString;
  out Value: TBevelCut): Boolean;
var
  Node: IXMLNode;
  NodeText: string;
  I: TBevelCut;
  Found: Boolean;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    NodeText := Node.Text;
    Found := False;
    for I := Low(BevelCutStrings) to High(BevelCutStrings) do
    begin
      if BevelCutStrings[I] = NodeText then
      begin
        Found := True;
        Value := I;
        Break;
      end;
    end;

    if not Found then
    begin
      raise EReadError.Create('BevelCut ' + NodeText + ' not known', Self, AttrName);
    end;
  end;
end;

function TTypedXmlNode.TryGetBooleanAttr(const AttrName: DOMString;
  out Value: Boolean): Boolean;
var
  Node: IXMLNode;
  NodeText: string;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    NodeText := Node.Text;
    if NodeText = BooleanTrue then
      Value := True
    else
    begin
      if NodeText = BooleanFalse then
        Value := False
      else
        Result := False;
    end;
  end;
end;

function TTypedXmlNode.GetColorAttr(const AttrName: DOMString; DefaultValue: TColor): TColor;
begin
  if not TryGetColorAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetCurrencyAttr(const AttrName: DOMString;
  const DefaultValue: Currency): Currency;
begin
  if not TryGetCurrencyAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetDateTimeAttr(const AttrName: DOMString;
  const DefaultValue: TDateTime): TDateTime;
begin
  if not TryGetDateTimeAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.TryGetColorAttr(const AttrName: DOMString;
  out Value: TColor): Boolean;
var
  Node: IXMLNode;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    try
      Value := StringToColor(Node.Text);
    except
      on E: EConvertError do
      begin
        raise EReadError.Create(E.Message, Self, AttrName);
      end;
    end;
  end;
end;

function TTypedXmlNode.TryGetCurrencyAttr(const AttrName: DOMString;
  out Value: Currency): Boolean;
var
  Node: IXMLNode;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    if not TryInvariantStrToCurr(Node.Text, Value) then
    begin
      Result := False;
    end;
  end;
end;

function TTypedXmlNode.TryGetDateTimeAttr(const AttrName: DOMString;
  out Value: TDateTime): Boolean;
var
  Node: IXMLNode;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    try
      Value := XmlStrToDateTime(Node.Text);
    except
      on E: EConvertError do
      begin
        Result := False;
      end;
    end;
  end;
end;

function TTypedXmlNode.TryGetFloatAttr(const AttrName: DOMString;
  out Value: Double): Boolean;
var
  Node: IXMLNode;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    if not TryInvariantStrToDouble(Node.Text, Value) then
    begin
      Result := False;
    end;
  end;
end;

function TTypedXmlNode.TryGetFontPitchAttr(const AttrName: DOMString;
  out Value: TFontPitch): Boolean;
var
  Node: IXMLNode;
  NodeText: string;
  I: TFontPitch;
  Found: Boolean;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    NodeText := Node.Text;
    Found := False;
    for I := Low(FontPitchStrings) to High(FontPitchStrings) do
    begin
      if FontPitchStrings[I] = NodeText then
      begin
        Found := True;
        Value := I;
        Break;
      end;
    end;

    if not Found then
    begin
      raise EReadError.Create('Font Pitch ' + NodeText + ' not known', Self, AttrName);
    end;
  end;
end;

function TTypedXmlNode.GetFloatAttr(const AttrName: DOMString;
  const DefaultValue: Double): Double;
begin
  if not TryGetFloatAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetFontPitchAttr(const AttrName: DOMString; DefaultValue: TFontPitch): TFontPitch;
begin
  if not TryGetFontPitchAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.TryGetFontStylesAttr(const AttrName: DOMString;
  out Value: TFontStyles): Boolean;
var
  Node: IXMLNode;
begin
  Value := [];
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    Value := StringToFontStyles(Node.Text);
  end;
end;

function TTypedXmlNode.TryGetGuidAttr(const AttrName: DOMString;
  out Value: TGuid): Boolean;
var
  AsStr: string;
begin
  Result := TryGetStringAttr(AttrName, AsStr);
  if Result then
  begin
    try
      Value := StringToGUID(AsStr);
    except
      on E: EConvertError do
      begin
        Result := False;
      end;
    end;
  end;
end;

function TTypedXmlNode.TryGetInt64Attr(const AttrName: DOMString;
  out Value: Int64): Boolean;
var
  Node: IXMLNode;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    if not TryInvariantStrToInt64(Node.Text, Value) then
    begin
      Result := False;
    end;
  end;
end;

function TTypedXmlNode.TryGetIntegerAttr(const AttrName: DOMString;
  out Value: Integer): Boolean;
var
  Node: IXMLNode;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    if not TryInvariantStrToInt(Node.Text, Value) then
    begin
      Result := False;
    end;
  end;
end;

function TTypedXmlNode.GetFontStylesAttr(const AttrName: DOMString; const DefaultValue: TFontStyles): TFontStyles;
begin
  if not TryGetFontStylesAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetGuidAttr(const AttrName: DOMString;
  const DefaultValue: TGuid): TGuid;
begin
  if not TryGetGuidAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetInt64Attr(const AttrName: DOMString;
  const DefaultValue: Int64): Int64;
begin
  if not TryGetInt64Attr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetIntegerAttr(const AttrName: DOMString;
  DefaultValue: Integer): Integer;
begin
  if not TryGetIntegerAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetPenModeAttr(const AttrName: DOMString; DefaultValue: TPenMode): TPenMode;
begin
  if not TryGetPenModeAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.TryGetPenModeAttr(const AttrName: DOMString; out Value: TPenMode): Boolean;
var
  Node: IXMLNode;
  NodeText: string;
  I: TPenMode;
  Found: Boolean;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    NodeText := Node.Text;
    Found := False;
    for I := Low(PenModeStrings) to High(PenModeStrings) do
    begin
      if PenModeStrings[I] = NodeText then
      begin
        Found := True;
        Value := I;
        Break;
      end;
    end;

    if not Found then
    begin
      raise EReadError.Create('PenMode ' + NodeText + ' not known', Self, AttrName);
    end;
  end;
end;

function TTypedXmlNode.GetPenStyleAttr(const AttrName: DOMString; DefaultValue: TPenStyle): TPenStyle;
begin
  if not TryGetPenStyleAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.TryGetPenStyleAttr(const AttrName: DOMString;
  out Value: TPenStyle): Boolean;
var
  Node: IXMLNode;
  NodeText: string;
  I: TPenStyle;
  Found: Boolean;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    NodeText := Node.Text;
    Found := False;
    for I := Low(PenStyleStrings) to High(PenStyleStrings) do
    begin
      if PenStyleStrings[I] = NodeText then
      begin
        Found := True;
        Value := I;
        Break;
      end;
    end;

    if not Found then
    begin
      raise EReadError.Create('PenStyle ' + NodeText + ' not known', Self, AttrName);
    end;
  end;
end;

function TTypedXmlNode.TryGetPicture(const PictureName: DOMString;
  out Value: TPicture): Boolean;
var
  GraphicStream: TStream;
  Graphic: TGraphic;
  GraphicType: string;
begin
  Result := TryGetStreamHexCData(PictureName, GraphicStream);
  if Result then
  begin
    if not TryGetStringAttr(GraphicTypePrefix + PictureName, GraphicType) then
    begin
      GraphicType := DefaultGraphicType;
    end;

    case GraphicType[1] of
      GraphicType_Bitmap: Graphic := TBitmap.Create;
      GraphicType_Metafile: Graphic := TMetafile.Create;
      else raise EReadError.Create('Graphic Type ' + GraphicType_Metafile + ' not known', Self, GraphicTypePrefix+PictureName);
    end;

    Graphic.LoadFromStream(GraphicStream);
    GraphicStream.Free;

    Value := TPicture.Create;
    Value.Graphic := Graphic;
    Graphic.Free;
  end;
end;

function TTypedXmlNode.TryGetStreamHexCData(const CDataName: DOMString;
  out Value: TStream): Boolean;
var
  Node: IXMLNode;
  MemStrm: TMemoryStream;
  NodeText: string;
begin
  Node := FindCDataNode(CDataName);
  Result := Assigned(Node);
  if Result then
  begin
    NodeText := Node.Text;
    MemStrm := TMemoryStream.Create;
    MemStrm.SetSize(Length(NodeText) div 2);

    if HexToBin(PChar(NodeText), MemStrm.Memory, MemStrm.Size) = MemStrm.Size then
      Value := MemStrm
    else
      Result := False;
  end;
end;

function TTypedXmlNode.TryGetStringAttr(const AttrName: DOMString;
  out Value: string): Boolean;
var
  Node: IXMLNode;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    Value := Node.Text;
  end;
end;

function TTypedXmlNode.GetPicture(const PictureName: DOMString; DefaultValue: TPicture): TPicture;
begin
  if not TryGetPicture(PictureName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetStreamHexCData(const CDataName: DOMString;
  DefaultValue: TStream): TStream;
begin
  if not TryGetStreamHexCData(CDataName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.GetStringAttr(const AttrName: DOMString;
  const DefaultValue: string): string;
begin
  if not TryGetStringAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

function TTypedXmlNode.TryGetWindowStateAttr(const AttrName: DOMString;
  out Value: TWindowState): Boolean;
var
  Node: IXMLNode;
  NodeText: string;
  I: TWindowState;
  Found: Boolean;
begin
  Node := AttributeNodes.FindNode(AttrName);
  Result := Assigned(Node);
  if Result then
  begin
    NodeText := Node.Text;
    Found := False;
    for I := Low(WindowStateStrings) to High(WindowStateStrings) do
    begin
      if WindowStateStrings[I] = NodeText then
      begin
        Found := True;
        Value := I;
        Break;
      end;
    end;

    if not Found then
    begin
      raise EReadError.Create('WindowState ' + NodeText + ' not known', Self, AttrName);
    end;
  end;
end;

function TTypedXmlNode.TryReadFontAttr(
  Font: TFont): Boolean;
var
  FontName: string;
  FontSize: Integer;
  FontColor: TColor;
  FontStyles: TFontStyles;
  FontCharsetIdent: string;
  FontCharset: Integer;
  FontPitch: TFontPitch;
begin
  Result := False;
  if TryGetStringAttr(XmlTag_FontName, FontName) then
  begin
    if TryGetIntegerAttr(XmlTag_FontSize, FontSize) then
    begin
      if TryGetColorAttr(XmlTag_FontColor, FontColor) then
      begin
        if TryGetFontStylesAttr(XmlTag_FontStyles, FontStyles) then
        begin
          if TryGetStringAttr(XmlTag_FontCharsetIdent, FontCharsetIdent)
             and
             IdentToCharset(FontCharsetIdent, FontCharset) then
          begin
            Font.Name := FontName;
            Font.Size := FontSize;
            Font.Color := FontColor;
            Font.Style := FontStyles;
            Font.Charset := FontCharset;
            if TryGetFontPitchAttr(XmlTag_FontPitch, FontPitch) then
            begin
              Font.Pitch := FontPitch; // optional for backwards compatibility
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TTypedXmlNode.GetWindowStateAttr(const AttrName: DOMString; DefaultValue: TWindowState): TWindowState;
begin
  if not TryGetWindowStateAttr(AttrName, Result) then
  begin
    Result := DefaultValue;
  end;
end;

procedure TTypedXmlNode.Normalize;
var
  I: Integer;
  ChildNode: ITypedXmlElement;
begin
  for I := ChildNodes.Count-1 downto 0 do
  begin
    if ChildNodes[I].NodeType <> ntCData then
    begin
      ChildNode := (ChildNodes[I] as ITypedXmlElement);
      ChildNode.Normalize;
      if (ChildNode.ChildNodes.Count = 0) and (ChildNode.AttributeNodes.Count = 0) then
      begin
        ChildNodes.Delete(I);
      end;
    end;
  end;
end;

procedure TTypedXmlNode.SetAlignmentAttr(const AttrName: DOMString;
  const Value: TAlignment);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := AlignmentStrings[Value];
end;

procedure TTypedXmlNode.WriteFontAttr(Font: TFont);
var
  Charset: TFontCharset;
  CharsetIdent: string;
begin
  StringAttr[XmlTag_FontName] := Font.Name;
  IntegerAttr[XmlTag_FontSize] := Font.Size;
  ColorAttr[XmlTag_FontColor] := Font.Color;
  FontStylesAttr[XmlTag_FontStyles] := Font.Style;
  FontPitchAttr[XmlTag_FontPitch] := Font.Pitch;

  if not CharsetToIdent(font.Charset, CharsetIdent) then
  begin
    Charset := GetDefFontCharSet;
    if not CharsetToIdent(Charset, CharsetIdent) then
    begin
      CharsetToIdent(0, CharsetIdent); // 0 = ANSI
    end;
  end;

  StringAttr[XmlTag_FontCharsetIdent] := CharsetIdent;
end;

function TTypedXmlNode.XmlStrToDateTime(const Value: string): TDateTime;
var
  TimeStr: string;
  FullStr: string;
  Year, Month, Day, Hour, Minute, Second: Word;
begin
  Result := NullDateTime;

  if Value[1] = ':' then
    TimeStr := Trim(Value)
  else
  begin
    FullStr := Trim(Value);
    Year := StrToInt(Copy(FullStr, 1, 4));
    Month := StrToInt(Copy(FullStr, 5, 2));
    Day := StrToInt(Copy(FullStr, 7, 2));

    Result := EncodeDate(Year, Month, Day);
    TimeStr := Copy(FullStr, 9, Length(Value));
  end;

  if TimeStr <> '' then
  begin
    if (Length(TimeStr) <> 7) or (TimeStr[1] <> ':') then
    begin
      raise Exception.Create('Invalid Time portion in DateTime string "' + Value + '"');
    end;

    Hour := StrToInt(Copy(TimeStr, 2, 2));
    Minute := StrToInt(Copy(TimeStr, 4, 2));
    Second := StrToInt(Copy(TimeStr, 6, 2));
    Result := Result + EncodeTime(Hour, Minute, Second, 0);
  end;
end;

procedure TTypedXmlNode.SetAlignmentAttr(const AttrName: DOMString;
  const Value, DefaultValue: TAlignment);
begin
  if Value <> DefaultValue then
  begin
    SetAlignmentAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetBevelCutAttr(const AttrName: DOMString;
  const Value: TBevelCut);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := BevelCutStrings[Value];
end;

procedure TTypedXmlNode.SetBevelCutAttr(const AttrName: DOMString;
  const Value, DefaultValue: TBevelCut);
begin
  if Value <> DefaultValue then
  begin
    SetBevelCutAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetBooleanAttr(const AttrName: DOMString; const Value,
  DefaultValue: Boolean);
begin
  if Value <> DefaultValue then
  begin
    SetBooleanAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetBooleanAttr(const AttrName: DOMString;
  const Value: Boolean);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  if Value then
    Node.Text := BooleanTrue
  else
    Node.Text := BooleanFalse;
end;

procedure TTypedXmlNode.SetColorAttr(const AttrName: DOMString; const Value,
  DefaultValue: TColor);
begin
  if Value <> DefaultValue then
  begin
    SetColorAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetCurrencyAttr(const AttrName: DOMString;
  const Value: Currency);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := CurrToInvariantStr(Value);
end;

procedure TTypedXmlNode.SetCurrencyAttr(const AttrName: DOMString; const Value,
  DefaultValue: Currency);
begin
  if Value <> DefaultValue then
  begin
    SetCurrencyAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetDateTimeAttr(const AttrName: DOMString; const Value,
  DefaultValue: TDateTime);
begin
  if Value <> DefaultValue then
  begin
    SetDateTimeAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetDateTimeAttr(const AttrName: DOMString;
  const Value: TDateTime);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := DateTimeToXmlStr(Value);
end;

procedure TTypedXmlNode.SetColorAttr(const AttrName: DOMString;
  const Value: TColor);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := ColorToString(Value);
end;

procedure TTypedXmlNode.SetFontPitchAttr(const AttrName: DOMString;
  const Value: TFontPitch);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := FontPitchStrings[Value];
end;

procedure TTypedXmlNode.SetFloatAttr(const AttrName: DOMString; const Value,
  DefaultValue: Double);
begin
  if Value <> DefaultValue then
  begin
    SetFloatAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetFloatAttr(const AttrName: DOMString;
  const Value: Double);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := DoubleToInvariantStr(Value);
end;

procedure TTypedXmlNode.SetFontPitchAttr(const AttrName: DOMString;
  const Value, DefaultValue: TFontPitch);
begin
  if Value <> DefaultValue then
  begin
    SetFontPitchAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetFontStylesAttr(const AttrName: DOMString;
  const Value, DefaultValue: TFontStyles);
begin
  if Value <> DefaultValue then
  begin
    SetFontStylesAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetGuidAttr(const AttrName: DOMString;
  const Value: TGuid);
begin
  SetStringAttr(AttrName, GuidToString(Value));
end;

procedure TTypedXmlNode.SetGuidAttr(const AttrName: DOMString; const Value,
  DefaultValue: TGuid);
begin
  if IsEqualGUID(Value, DefaultValue) then
  begin
    SetGuidAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetInt64Attr(const AttrName: DOMString;
  const Value: Int64);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := IntToInvariantStr(Value);
end;

procedure TTypedXmlNode.SetInt64Attr(const AttrName: DOMString; const Value,
  DefaultValue: Int64);
begin
  if Value <> DefaultValue then
  begin
    SetInt64Attr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetIntegerAttr(const AttrName: DOMString; const Value,
  DefaultValue: Integer);
begin
  if Value <> DefaultValue then
  begin
    SetIntegerAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetIntegerAttr(const AttrName: DOMString;
  const Value: Integer);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := IntToInvariantStr(Value);
end;

procedure TTypedXmlNode.SetFontStylesAttr(const AttrName: DOMString;
  const Value: TFontStyles);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := FontStylesToString(Value);
end;

procedure TTypedXmlNode.SetPenStyleAttr(const AttrName: DOMString;
  const Value: TPenStyle);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := PenStyleStrings[Value];
end;

procedure TTypedXmlNode.SetPenModeAttr(const AttrName: DOMString; const Value: TPenMode);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := PenModeStrings[Value];
end;

procedure TTypedXmlNode.SetPenModeAttr(const AttrName: DOMString; const Value, DefaultValue: TPenMode);
begin
  if Value <> DefaultValue then
  begin
    SetPenModeAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetPenStyleAttr(const AttrName: DOMString;
  const Value, DefaultValue: TPenStyle);
begin
  if Value <> DefaultValue then
  begin
    SetPenStyleAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetPicture(const PictureName: DOMString; const Value,
  DefaultValue: TPicture);
begin
  SetPicture(PictureName, Value);
end;

procedure TTypedXmlNode.SetStreamHexCData(const CDataName: DOMString;
  const Value: TStream);
var
  MemStrm: TMemoryStream;
  TextStr: string;
  Node: IXMLNode;
begin
  if Value is TMemoryStream then
    MemStrm := TMemoryStream(Value)
  else
  begin
    MemStrm := TMemoryStream.Create;
    MemStrm.CopyFrom(Value, 0);
  end;

  SetLength(TextStr, 2 * (MemStrm.Size));

  BinToHex(MemStrm.Memory, PChar(TextStr), MemStrm.Size);

  Node := ForceFindCDataNode(CDataName);
  Node.Text := TextStr;

  if MemStrm <> Value then
  begin
    MemStrm.Free;
  end;
end;

procedure TTypedXmlNode.SetStreamHexCData(const CDataName: DOMString;
  const Value, DefaultValue: TStream);
begin
  SetStreamHexCData(CDataName, Value);
end;

procedure TTypedXmlNode.SetStringAttr(const AttrName: DOMString; const Value,
  DefaultValue: string);
begin
  if Value <> DefaultValue then
  begin
    SetStringAttr(AttrName, Value);
  end;
end;

procedure TTypedXmlNode.SetStringAttr(const AttrName: DOMString;
  const Value: string);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := Value;
end;

procedure TTypedXmlNode.SetPicture(const PictureName: DOMString;
  const Value: TPicture);
var
  MemStrm: TMemoryStream;
  GraphicType: Char;
begin
  Assert((Value.Graphic is TBitmap) or (Value.Graphic is TMetafile));

  if Value.Graphic is TMetafile then
    GraphicType := GraphicType_Metafile
  else
    GraphicType := GraphicType_Bitmap;

  if GraphicType = DefaultGraphicType then
    AttributeNodes.Delete(GraphicTypePrefix + PictureName)
  else
    SetStringAttr(GraphicTypePrefix + PictureName, GraphicType);

  MemStrm := TMemoryStream.Create;
  try
    Value.Graphic.SaveToStream(MemStrm);
    SetStreamHexCData(PictureName, MemStrm);
  finally
    MemStrm.Free;
  end;
end;

procedure TTypedXmlNode.SetWindowStateAttr(const AttrName: DOMString;
  const Value: TWindowState);
var
  Node: IXMLNode;
begin
  Node := ForceFindAttributeNode(AttrName);
  Node.Text := WindowStateStrings[Value];
end;

procedure TTypedXmlNode.SetWindowStateAttr(const AttrName: DOMString;
  const Value, DefaultValue: TWindowState);
begin
  if Value <> DefaultValue then
  begin
    SetWindowStateAttr(AttrName, Value);
  end;
end;

class function TTypedXmlNode.StringToFontStyles(const Value: string): TFontStyles;
var
  StrList: TStringList;
  I: Integer;
  J, FontStyle: TFontStyle;
  Found: Boolean;
begin
  Result := [];

  StrList := TStringList.Create;
  try
    StrList.CommaText := Value;

    FontStyle := fsBold; // avoid warning
    for I := 0 to StrList.Count-1 do
    begin
      Found := False;
      for J := Low(FontStyleStrings) to High(FontStyleStrings) do
      begin
        if FontStyleStrings[J] = StrList[I] then
        begin
          Found := True;
          FontStyle := J;
          Break;
        end;
      end;

      if Found then
      begin
        Include(Result, FontStyle);
      end;
    end;

  finally
    StrList.Free;
  end;
end;

{ TTypedXmlDocument }

function TTypedXmlDocument.AddElement(const TagName: DOMString): ITypedXmlElement;
begin
  Result := AddChild(TagName) as ITypedXmlElement;
end;

function TTypedXmlDocument.GetChildNodeClass(
  const Node: IDOMNode): TXMLNodeClass;
begin
  if Node.nodeType = ELEMENT_NODE then
    Result := TTypedXmlNode
  else
    Result := nil;
end;

function TTypedXmlDocument.GetRootElement: ITypedXmlElement;
begin
  Result := DocumentElement as ITypedXmlElement;
end;

{ TTypedXmlNode.EReadError }

constructor TTypedXmlNode.EReadError.Create(const Msg: string;
  Node: ITypedXmlElement; const AttrName: string);
begin
  inherited Create(Msg);
  FXmlNode := Node;
  FAttributeName := AttrName;
end;

end.
