// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.EditEngine;

interface

uses
  System.Text,
  System.Globalization,
  Borland.Vcl.Forms,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.EditData;

type
  TMetaRefreshControlsEvent = procedure of object;
  TFieldRemovedEvent = procedure(field: TFieldedTextField) of object;

  TErrorEvent = procedure(errorText: string) of object;
  TSuccessEvent = procedure of object;
  TParseEvent = procedure of object;
  TGenerateEvent = procedure of object;
  TTextChangeEvent = procedure(source: TFrame) of object;
  TTextModifiedChangeEvent = procedure of object;
  TMetaChangeEvent = procedure of object;
  TMetaModifiedChangeEvent = procedure of object;
  TSynchronisedChangeEvent = procedure of object;
  TSequencesChangeEvent = procedure of object;
  TMouseOverChangedEvent = procedure of object;
  TCursorActiveChangedEvent = procedure(frameChanged, cellChanged: Boolean) of object;
  TFieldedTextFilePathSetEvent = procedure of object;
  TNewOpenTextEvent = procedure of object;

  TEditEngine = class
  public
    type
      TStringArray = array of string;

      TPropertyCategory =
      (
        pcMainText,
        pcMainMeta,
        pcField,
        pcSubstitution,
        pcSequence
      );

  strict private
    type
      TDataTypeAbbrRec = record
        &Type: TFieldedTextFieldDataType;
        Abbr: string;
      end;
      TDataTypeAbbrArray = array[TFieldedTextFieldDataType] of TDataTypeAbbrRec;
    const
      DataTypeAbbrs: TDataTypeAbbrArray =
      (
        (&Type: ftdtCustom; Abbr: 'Cus'),
        (&Type: ftdtString; Abbr: 'Str'),
        (&Type: ftdtBoolean; Abbr: 'Boo'),
        (&Type: ftdtInteger; Abbr: 'Int'),
        (&Type: ftdtFloat; Abbr: 'Flt'),
        (&Type: ftdtDateTime; Abbr: 'Dtm'),
        (&Type: ftdtDecimal; Abbr: 'Dec')
      );

    var
      FFieldedText: TFieldedText;

      FMetaModified: Boolean;
      FTextModified: Boolean;

      FEditData: TEditData;
      FSynchronised: Boolean;
      FSynchronising: Boolean;

      FDisplayCulture: CultureInfo;

      FMouseOverColIdx: Integer;
      FMouseOverCell: TCell;
      FMouseOverFrame: TFrame;
      FMouseOverRow: TRow;

      FCursorActiveColIdx: Integer;
      FCursorActiveRowIdx: Integer;
      FCursorActiveCell: TCell;
      FCursorActiveRichPos: Integer;
      FCursorActiveFrame: TFrame;

      FRefreshMainControlsEvent: TMetaRefreshControlsEvent;
      FRefreshFieldsControlsEvent: TMetaRefreshControlsEvent;
      FRefreshSequencesControlsEvent: TMetaRefreshControlsEvent;
      FFieldRemovedEvent: TFieldRemovedEvent;
      FErrorEvent: TErrorEvent;
      FSuccessEvent: TSuccessEvent;
      FParseEvent: TParseEvent;
      FGenerateEvent: TGenerateEvent;
      FTextChangeEvent: TTextChangeEvent;
      FTextModifiedChangeEvent: TTextModifiedChangeEvent;
      FMetaChangeEvent: TMetaChangeEvent;
      FMetaModifiedChangeEvent: TMetaModifiedChangeEvent;
      FSynchronisedChangeEvent: TSynchronisedChangeEvent;
      FSequencesChangeEvent: TSequencesChangeEvent;
      FMouseOverChangedEvent: TMouseOverChangedEvent;
      FCursorActiveChangedEvent: TCursorActiveChangedEvent;
      FFieldedTextFilePathSetEvent: TFieldedTextFilePathSetEvent;
      FNewOpenTextEvent: TNewOpenTextEvent;

    procedure HandleParseEvent(sender: TFieldedText; eventType: TFieldedTextParseEventType; var stop: Boolean);
    procedure HandleFieldHeadingEvent(sender: TFieldedText; field: TFieldedTextField; var stop: Boolean);
    procedure HandleRecordFieldsBeginEvent(sender: TFieldedText; var stop: Boolean);
    procedure HandleFieldValueEvent(sender: TFieldedText; field: TFieldedTextField; var stop: Boolean);
//    procedure HandleRecordFieldsEndEvent(sender: TFieldedText; var stop: Boolean);
    procedure HandleErrorEvent(sender: TFieldedText;
                               errorCode: TFieldedTextErrorCode;
                               field: TFieldedTextField);
    procedure HandleConfigurationUpdatedEvent;

    procedure TriggerRefreshMainControlsEvent;
    procedure TriggerRefreshFieldsControlsEvent;
    procedure TriggerRefreshSequencesControlsEvent;
    procedure TriggerFieldRemovedEvent(field: TFieldedTextField);

    procedure TriggerSequencesChangeEvent;

    function CalculateFieldedTextErrorText(errorCode: TFieldedTextErrorCode): string;

    function GetDataTypeAbbr(&type: TFieldedTextFieldDataType): string;

    function GetCulture: CultureInfo;
    function GetFields(idx: Integer): TFieldedTextField;
    function GetFieldCount: Integer;
    function GetHeadingLineCount: Integer;

    function GetMainProperties(name: string): TObject;
    procedure SetMainProperties(name: string; const Value: TObject);
    function GetFieldProperties(name: string; idx: Integer): TObject;
    procedure SetFieldProperties(name: string; idx: Integer; const Value: TObject);
    function GetSubstitutionProperties(name: string; idx: Integer): TObject;
    procedure SetSubstitutionProperties(name: string; idx: Integer; const Value: TObject);
    function GetSequenceProperties(name: string; idx: Integer): TObject;
    procedure SetSequenceProperties(name: string; idx: Integer; const Value: TObject);
    function GetSequenceItemProperties(name: string; sequenceItem: TFieldedTextSequenceItem): TObject;
    procedure SetSequenceItemProperties(name: string; sequenceItem: TFieldedTextSequenceItem; const Value: TObject);
    function GetRedirectProperties(name: string; redirect: TFieldedTextSequenceRedirect): TObject;
    procedure SetRedirectProperties(name: string; redirect: TFieldedTextSequenceRedirect; const Value: TObject);

    function GetSequenceCount: Integer;
    function GetSequences(idx: Integer): TFieldedTextSequence;

    function GetSubstitutionCount: Integer;
    function GetSubstitutionToken(idx: Integer): Char;
    function GetSubstitutionType(idx: Integer): TFieldedTextSubstitutionType;
    function GetSubstitutionValue(idx: Integer): string;
    function GetProperties(name: string; idx: Integer; cat: TPropertyCategory): TObject;
    function GetMetaReferenceType: TFieldedTextMetaReferenceType;
    function GetMetaReference: string;

    function GetMetaLoadErrorDescription: string;
    function GetLineNumber: Integer;
    function GetLineCount: Integer;
    function GetCharCount: Int64;
    function GetPosition: Int64;
    function GetCellsInRowCount(aRow: Integer): Integer;
    function GetLinePos: Integer;

    function GetRecordCount: Integer;
    function GetTableCount: Integer;
    function GetTableNumber: Integer;
    function GetRecordNumber: Integer;
    function GetActiveItemNumber: Integer;
    function GetCurrentField: TFieldedTextField;
    function GetCurrentSequence: TFieldedTextSequence;
    function GetCurrentSequenceItem: TFieldedTextSequenceItem;

    function GetText: string;
    function GetTextFilePath: string;
    function GetTextCharEncoding: Encoding;
    function GetTextCharEncodingName: string;
    procedure SetTextCharEncodingName(const Value: string);

    function GetMetaCharEncoding: Encoding;
    function GetMetaCharEncodingName: string;
    procedure SetMetaCharEncodingName(const Value: string);

    function GetRowCount: Integer;
    function GetHeadingCount: Integer;
    function GetHeading(aCol: Integer): string;
    function GetMaxCellsInRowCount: Integer;
    function GetCells(aCol, aRow: Integer): TCell;
    function GetRows(aRow: Integer): TRow;

    procedure SetTextModified(const Value: Boolean);
    procedure SetMetaModified(const Value: Boolean);
    procedure SetSynchronised(const Value: Boolean);

    property MainProperties[name: string]: TObject read GetMainProperties write SetMainProperties;
    property FieldProperties[name: string; idx: Integer]: TObject read GetFieldProperties write SetFieldProperties;
    property SubstitutionProperties[name: string; idx: Integer]: TObject read GetSubstitutionProperties write SetSubstitutionProperties;
    property SequenceProperties[name: string; idx: Integer]: TObject read GetSequenceProperties write SetSequenceProperties;
  public
    constructor Create;

    property DataTypeAbbr[&type: TFieldedTextFieldDataType]: string read GetDataTypeAbbr;

    function UpdateDisplayCulture: Boolean;
    property DisplayCulture: CultureInfo read FDisplayCulture;

    property Culture: CultureInfo read GetCulture;
    property Fields[idx: Integer]: TFieldedTextField read GetFields;
    property FieldCount: Integer read GetFieldCount;
    property HeadingLineCount: Integer read GetHeadingLineCount;

    property CharCount: Int64 read GetCharCount;
    property LineNumber: Integer read GetLineNumber;
    property LineCount: Integer read GetLineCount;
    property LinePos: Integer read GetLinePos;
    property Position: Int64 read GetPosition;
    property ActiveItemNumber: Integer read GetActiveItemNumber;
    property RecordNumber: Integer read GetRecordNumber;
    property RecordCount: Integer read GetRecordCount;
    property TableNumber: Integer read GetTableNumber;
    property TableCount: Integer read GetTableCount;
    property CurrentField: TFieldedTextField read GetCurrentField;
    property CurrentSequence: TFieldedTextSequence read GetCurrentSequence;
    property CurrentSequenceItem: TFieldedTextSequenceItem read GetCurrentSequenceItem;

    function AddField(dataType: TFieldedTextFieldDataType): Integer;
    procedure RemoveField(field: TFieldedTextField);
    procedure MoveField(oldIndex, newIndex: Integer);
    function IsFieldNameDuplicated(name: string): Boolean;

    property SequenceCount: Integer read GetSequenceCount;
    property Sequences[idx: Integer]: TFieldedTextSequence read GetSequences;
    function InsertSequence(idx: Integer): TFieldedTextSequence;
    function InsertSequenceItem(sequence: TFieldedTextSequence; idx: Integer; field: TFieldedTextField): TFieldedTextSequenceItem;
    function InsertRedirect(sequenceItem: TFieldedTextSequenceItem; idx: Integer;
                            redirectType: TFieldedTextSequenceRedirectType): TFieldedTextSequenceRedirect;

    procedure RemoveSequence(idx: Integer);
    procedure RemoveSequenceItem(sequence: TFieldedTextSequence; idx: Integer);
    procedure RemoveSequenceRedirect(sequenceItem: TFieldedTextSequenceItem; idx: Integer);

    procedure MoveSequence(oldIndex, newIndex: Integer);
    procedure MoveSequenceItem(sequence: TFieldedTextSequence; oldIndex, newIndex: Integer);
    procedure MoveSequenceRedirect(sequenceItem: TFieldedTextSequenceItem; oldIndex, newIndex: Integer);

    property SubstitutionCount: Integer read GetSubstitutionCount;
    property SubstitutionToken[idx: Integer]: Char read GetSubstitutionToken;
    property SubstitutionType[idx: Integer]: TFieldedTextSubstitutionType read GetSubstitutionType;
    property SubstitutionValue[idx: Integer]: string read GetSubstitutionValue;
    function AddSubstitution: Integer;
    procedure DeleteSubstitution(idx: Integer);

    property Properties[name: string; idx: Integer; cat: TPropertyCategory]: TObject read GetProperties;
    procedure SetPropertyValue(name: string; idx: Integer; cat: TPropertyCategory; const Value: TObject; out modified: Boolean);

    property SequenceItemProperties[name: string; sequenceItem: TFieldedTextSequenceItem]: TObject read GetSequenceItemProperties write SetSequenceItemProperties;
    procedure SetSequenceItemPropertyValue(name: string; sequenceItem: TFieldedTextSequenceItem; const Value: TObject; out modified: Boolean);

    property RedirectProperties[name: string; redirect: TFieldedTextSequenceRedirect]: TObject read GetRedirectProperties write SetRedirectProperties;
    procedure SetRedirectPropertyValue(name: string; redirect: TFieldedTextSequenceRedirect; const Value: TObject; out modified: Boolean);

    procedure RefreshControls; overload;
    procedure RefreshControls(cat: TPropertyCategory); overload;

    procedure SetText(source: TFrame; textValue: string);
    procedure Parse(source: TFrame; newText: string);
    procedure Generate(source: TFrame);

    property MetaReferenceType: TFieldedTextMetaReferenceType read GetMetaReferenceType;
    property MetaReference: string read GetMetaReference;
    property MetaLoadErrorDescription: string read GetMetaLoadErrorDescription;
    property MetaCharEncoding: Encoding read GetMetaCharEncoding;
    property MetaCharEncodingName: string read GetMetaCharEncodingName write SetMetaCharEncodingName;
    procedure ResetMeta;
    procedure OpenMeta(filePath: string);
    procedure OpenMetaFromUrl(url: string);
    procedure SaveMetaAs(filePath: string);

    property Text: string read GetText;
    property TextFilePath: string read GetTextFilePath;
    property TextCharEncoding: Encoding read GetTextCharEncoding;
    property TextCharEncodingName: string read GetTextCharEncodingName write SetTextCharEncodingName;
    procedure NewText;
    function OpenText(filePath: string; out errorDescription: string): Boolean;
    procedure OpenTextFromUrl(url: string);
    procedure SaveText;
    procedure SaveTextAs(filePath: string);
    procedure GenerateToFile;
    procedure GenerateAsToFile(filePath: string);

    property MetaModified: Boolean read FMetaModified write SetMetaModified;
    property TextModified: Boolean read FTextModified write SetTextModified;
    property Synchronised: Boolean read FSynchronised;
    property Synchronising: Boolean read FSynchronising;

    property RowCount: Integer read GetRowCount;
    property HeadingCount: Integer read GetHeadingCount;
    property MaxCellsInRowCount: Integer read GetMaxCellsInRowCount;
    property CellsInRowCount[aRow: Integer]: Integer read GetCellsInRowCount;
    property Cells[aCol, aRow: Integer]: TCell read GetCells;
    property Rows[aRow: Integer]: TRow read GetRows;
    property Heading[aCol: Integer]: string read GetHeading;

    function GetOrderedRootFieldNames: TStringArray;
    function CanSelectCell(ACol, ARow: Integer): Boolean;
    procedure SetMouseOverCell(overFrame: TFrame; aCol, aRow: Integer);
    procedure SetMouseOverRichPos(overFrame: TFrame; Pos: Integer);
    function IsMouseOverCell(cell: TCell): Boolean;
    function IsMouseOverRow(row: TRow): Boolean;

    property MouseOverColIdx: Integer read FMouseOverColIdx;
    property MouseOverCell: TCell read FMouseOverCell;
    property MouseOverFrame: TFrame read FMouseOverFrame;

    procedure SetCursorCell(activeFrame: TFrame; aCol, aRow: Integer);
    procedure SetCursorRichPos(activeFrame: TFrame; pos: Integer);

    property CursorActiveColIdx: Integer read FCursorActiveColIdx;
    property CursorActiveRowIdx: Integer read FCursorActiveRowIdx;
    property CursorActiveCell: TCell read FCursorActiveCell;
    property CursorActiveRichPos: Integer read FCursorActiveRichPos;
    property CursorActiveFrame: TFrame read FCursorActiveFrame;

    function IsCursorActiveCell(cell: TCell): Boolean;

    property RefreshMainControlsEvent: TMetaRefreshControlsEvent add FRefreshMainControlsEvent
                                                                 remove FRefreshMainControlsEvent;
    property RefreshFieldsControlsEvent: TMetaRefreshControlsEvent add FRefreshFieldsControlsEvent
                                                                   remove FRefreshFieldsControlsEvent;
    property RefreshSequencesControlsEvent: TMetaRefreshControlsEvent add FRefreshSequencesControlsEvent
                                                                      remove FRefreshSequencesControlsEvent;
    property FieldRemovedEvent: TFieldRemovedEvent add FFieldRemovedEvent remove FFieldRemovedEvent;

    property ErrorEvent: TErrorEvent add FErrorEvent remove FErrorEvent;
    property SuccessEvent: TSuccessEvent add FSuccessEvent remove FSuccessEvent;
    property ParseEvent: TParseEvent add FParseEvent remove FParseEvent;
    property GenerateEvent: TGenerateEvent add FGenerateEvent remove FGenerateEvent;
    property TextChangeEvent: TTextChangeEvent add FTextChangeEvent remove FTextChangeEvent;
    property TextModifiedChangeEvent: TTextModifiedChangeEvent add FTextModifiedChangeEvent remove FTextModifiedChangeEvent;
    property MetaChangeEvent: TMetaChangeEvent add FMetaChangeEvent remove FMetaChangeEvent;
    property MetaModifiedChangeEvent: TMetaModifiedChangeEvent add FMetaModifiedChangeEvent remove FMetaModifiedChangeEvent;
    property SynchronisedChangeEvent: TSynchronisedChangeEvent add FSynchronisedChangeEvent remove FSynchronisedChangeEvent;
    property SequencesChangeEvent: TSequencesChangeEvent add FSequencesChangeEvent remove FSequencesChangeEvent;
    property MouseOverChangedEvent: TMouseOverChangedEvent add FMouseOverChangedEvent remove FMouseOverChangedEvent;
    property CursorActiveChangedEvent: TCursorActiveChangedEvent add FCursorActiveChangedEvent remove FCursorActiveChangedEvent;
    property FieldedTextFilePathSetEvent: TFieldedTextFilePathSetEvent add FFieldedTextFilePathSetEvent remove FFieldedTextFilePathSetEvent;
    property NewOpenTextEvent: TNewOpenTextEvent add FNewOpenTextEvent remove FNewOpenTextEvent;

    class function CountToNumber(value: Integer): Integer;
    class function IndexToNumber(value: Integer): Integer; overload;
    class function IndexToNumber(value: Int64): Int64; overload;
  end;

implementation

uses
  System.IO,
  System.Reflection,
  System.Net,
  Xilytix.FTEditor.Configuration;

{ TEditEngine }

function TEditEngine.AddField(dataType: TFieldedTextFieldDataType): Integer;
begin
  Result := FFieldedText.AddField(dataType);
  MetaModified := True;
end;

function TEditEngine.AddSubstitution: Integer;
begin
  Result := FFieldedText.AddSubstitution;
  MetaModified := True;
end;

class function TEditEngine.CountToNumber(value: Integer): Integer;
begin
  if Configuration.NumberFromZero then
  begin
    Dec(value);
  end;
  Result := value;
end;

function TEditEngine.CalculateFieldedTextErrorText(errorCode: TFieldedTextErrorCode): string;
begin
  Result := 'Code: ' + Enum(errorCode).ToString;
  case errorCode of
    ftecInvalidDeclaration: Result := Result + ': ' + FFieldedText.DeclarationErrorDescription;
    ftecMetaLoad: Result := Result + ': ' + FFieldedText.MetaLoadErrorDescription;
  end;
end;

function TEditEngine.CanSelectCell(ACol, ARow: Integer): Boolean;
begin
  Result := FEditData.CanSelectCell(ACol, ARow);
end;

constructor TEditEngine.Create;
begin
  inherited;

  FFieldedText := TFieldedText.Create;
  Include(FFieldedText.ParseEvent, HandleParseEvent);
//  Include(FFieldedText.FieldHeadingEvent, HandleFieldHeadingEvent);
  Include(FFieldedText.FieldHeadingEvent, HandleFieldHeadingEvent);
  Include(FFieldedText.RecordFieldsBeginEvent, HandleRecordFieldsBeginEvent);
  Include(FFieldedText.FieldValueEvent, HandleFieldValueEvent);
//  Include(FFieldedText.RecordFieldsEndEvent, HandleRecordFieldsEndEvent);
  Include(FFieldedText.ErrorEvent, HandleErrorEvent);
  Include(Configuration.UpdatedEvent, HandleConfigurationUpdatedEvent);

  UpdateDisplayCulture;
  FEditData := TEditData.Create(FDisplayCulture);
end;

procedure TEditEngine.DeleteSubstitution(idx: Integer);
begin
  FFieldedText.DeleteSubstitution(idx);
  MetaModified := True;
end;

function TEditEngine.GetFieldProperties(name: string; idx: Integer): TObject;
var
  PropInfo: PropertyInfo;
begin
  PropInfo := TypeOf(FFieldedText.Fields[idx]).GetProperty(name);
  Result := PropInfo.GetValue(FFieldedText.Fields[idx], nil);
end;

procedure TEditEngine.Generate(source: TFrame);
var
  Writer: StringWriter;
  Success: Boolean;
begin
  FSynchronising := True;
  try
    Writer := StringWriter.Create;
    try
      Success := FFieldedText.Generate(Writer);
      SetText(nil, Writer.ToString);
    finally
      Writer.Close;
    end;

  finally
    FSynchronising := False;
  end;

  SetSynchronised(False);
//  FGenerateEvent;

  if Success then
  begin
    FSuccessEvent;
  end;
end;

procedure TEditEngine.GenerateAsToFile(filePath: string);
begin
  FSynchronising := True;
  try
    FFieldedText.Generate(filePath);
  finally
    FSynchronising := False;
  end;
end;

procedure TEditEngine.GenerateToFile;
begin
  GenerateAsToFile(FFieldedText.FilePath);
end;

function TEditEngine.GetActiveItemNumber: Integer;
begin
  Result := IndexToNumber(FFieldedText.ActiveItemIndex);
end;

function TEditEngine.GetCells(aCol, aRow: Integer): TCell;
begin
  Result := FEditData.Cells[aCol, aRow];
end;

function TEditEngine.GetCellsInRowCount(aRow: Integer): Integer;
begin
  Result := FEditData.CellsInRowCount[aRow];
end;

function TEditEngine.GetCharCount: Int64;
begin
  Result := FEditData.CharCount;
end;

function TEditEngine.GetCulture: CultureInfo;
begin
  Result := FFieldedText.Culture;
end;

function TEditEngine.GetCurrentField: TFieldedTextField;
begin
  Result := FFieldedText.CurrentField;
end;

function TEditEngine.GetCurrentSequence: TFieldedTextSequence;
begin
  Result := CurrentSequenceItem.Owner;
end;

function TEditEngine.GetCurrentSequenceItem: TFieldedTextSequenceItem;
begin
  Result := FFieldedText.CurrentSequenceItem;
end;

function TEditEngine.GetDataTypeAbbr(&type: TFieldedTextFieldDataType): string;
begin
  Result := DataTypeAbbrs[&type].Abbr;
end;

function TEditEngine.GetFieldCount: Integer;
begin
  Result := FFieldedText.FieldCount;
end;

function TEditEngine.GetFields(idx: Integer): TFieldedTextField;
begin
  Result := FFieldedText.Fields[idx];
end;

function TEditEngine.GetHeading(aCol: Integer): string;
begin
  Result := FEditData.Heading[aCol];
end;

function TEditEngine.GetHeadingCount: Integer;
begin
  Result := FEditData.HeadingCount;
end;

function TEditEngine.GetHeadingLineCount: Integer;
begin
  Result := FFieldedText.HeadingLineCount;
end;

function TEditEngine.GetLineCount: Integer;
begin
  Result := FFieldedText.LineCount;
end;

function TEditEngine.GetLineNumber: Integer;
begin
  Result := CountToNumber(FFieldedText.LineCount);
end;

function TEditEngine.GetLinePos: Integer;
begin
  Result := IndexToNumber(FFieldedText.LinePos);
end;

function TEditEngine.GetMainProperties(name: string): TObject;
var
  PropInfo: PropertyInfo;
begin
  PropInfo := TypeOf(FFieldedText).GetProperty(name);
  Result := PropInfo.GetValue(FFieldedText, nil);
end;

function TEditEngine.GetMaxCellsInRowCount: Integer;
begin
  Result := FEditData.MaxCellsInRowCount;
end;

function TEditEngine.GetMetaCharEncoding: Encoding;
begin
  Result := FFieldedText.MetaCharEncoding;
end;

function TEditEngine.GetMetaCharEncodingName: string;
begin
  Result := FFieldedText.MetaCharEncodingName;
end;

function TEditEngine.GetMetaLoadErrorDescription: string;
begin
  Result := FFieldedText.MetaLoadErrorDescription;
end;

function TEditEngine.GetMetaReference: string;
begin
  Result := FFieldedText.MetaReference;
end;

function TEditEngine.GetMetaReferenceType: TFieldedTextMetaReferenceType;
begin
  Result := FFieldedText.MetaReferenceType;
end;

function TEditEngine.GetOrderedRootFieldNames: TStringArray;
var
  I: Integer;
begin
  if not FFieldedText.SequencesActive then
  begin
    SetLength(Result, FFieldedText.FieldCount);

    for I := 0 to FFieldedText.FieldCount - 1 do
    begin
      Result[I] := FFieldedText.Fields[I].Name;
    end;
  end
  else
  begin
    SetLength(Result, FFieldedText.RootSequence.Count);

    for I := 0 to FFieldedText.RootSequence.Count - 1 do
    begin
      Result[I] := FFieldedText.RootSequence[I].Field.Name;
    end;
  end;
end;

function TEditEngine.GetPosition: Int64;
begin
  Result := IndexToNumber(FFieldedText.Position);
end;

function TEditEngine.GetProperties(name: string; idx: Integer; cat: TPropertyCategory): TObject;
begin
  case cat of
    pcMainText, pcMainMeta: Result := MainProperties[name];
    pcField: Result := FieldProperties[name, idx];
    pcSubstitution: Result := SubstitutionProperties[name, idx];
    pcSequence: Result := SequenceProperties[name, idx];
    else
    begin
      Result := nil;
      Assert(False);
    end;
  end;
end;

function TEditEngine.GetRecordCount: Integer;
begin
  Result := FFieldedText.RecordCount;
end;

function TEditEngine.GetRecordNumber: Integer;
begin
  Result := CountToNumber(FFieldedText.RecordCount);
end;

function TEditEngine.GetRedirectProperties(name: string; redirect: TFieldedTextSequenceRedirect): TObject;
var
  PropInfo: PropertyInfo;
begin
  PropInfo := TypeOf(redirect).GetProperty(name);
  Result := PropInfo.GetValue(redirect, nil);
end;

function TEditEngine.GetRowCount: Integer;
begin
  Result := FEditData.RowCount;
end;

function TEditEngine.GetRows(aRow: Integer): TRow;
begin
  Result := FEditData.Rows[aRow];
end;

function TEditEngine.GetSequenceCount: Integer;
begin
  Result := FFieldedText.SequenceCount;
end;

function TEditEngine.GetSequenceItemProperties(name: string; sequenceItem: TFieldedTextSequenceItem): TObject;
var
  PropInfo: PropertyInfo;
begin
  PropInfo := TypeOf(sequenceItem).GetProperty(name);
  Result := PropInfo.GetValue(sequenceItem, nil);
end;

function TEditEngine.GetSequenceProperties(name: string; idx: Integer): TObject;
var
  PropInfo: PropertyInfo;
begin
  PropInfo := TypeOf(FFieldedText.Sequences[idx]).GetProperty(name);
  Result := PropInfo.GetValue(FFieldedText.Sequences[idx], nil);
end;

function TEditEngine.GetSequences(idx: Integer): TFieldedTextSequence;
begin
  Result := FFieldedText.Sequences[idx];
end;

function TEditEngine.GetSubstitutionCount: Integer;
begin
  Result := FFieldedText.SubstitutionCount;
end;

function TEditEngine.GetSubstitutionProperties(name: string; idx: Integer): TObject;
var
  PropInfo: PropertyInfo;
  Indices: array of TObject;
begin
  PropInfo := TypeOf(FFieldedText).GetProperty(name);
  SetLength(Indices, 1);
  Indices[0] := TObject(idx);
  Result := PropInfo.GetValue(FFieldedText, Indices);
end;

function TEditEngine.GetSubstitutionValue(idx: Integer): string;
begin
  Result := FFieldedText.SubstitutionValue[idx];
end;

function TEditEngine.GetSubstitutionToken(idx: Integer): Char;
begin
  Result := FFieldedText.SubstitutionToken[idx];
end;

function TEditEngine.GetSubstitutionType(idx: Integer): TFieldedTextSubstitutionType;
begin
  Result := FFieldedText.SubstitutionType[idx];
end;

function TEditEngine.GetTableCount: Integer;
begin
  Result := FFieldedText.TableCount;
end;

function TEditEngine.GetTableNumber: Integer;
begin
  Result := CountToNumber(FFieldedText.TableCount);
end;

function TEditEngine.GetText: string;
begin
  Result := FEditData.Text;
end;

function TEditEngine.GetTextCharEncoding: Encoding;
begin
  Result := FFieldedText.TextCharEncoding;
end;

function TEditEngine.GetTextCharEncodingName: string;
begin
  Result := FFieldedText.TextCharEncodingName;
end;

function TEditEngine.GetTextFilePath: string;
begin
  Result := FFieldedText.FilePath;
end;

procedure TEditEngine.HandleConfigurationUpdatedEvent;
begin
  FFieldedText.EmbeddedMetaMargin := Configuration.EmbeddedMetaMargin;
  FFieldedText.EmbeddedMetaIncludeDesignOnly := Configuration.SaveDesignOnlyMeta;
  FFieldedText.EmbeddedMetaExplicitIndices := Configuration.SaveMetaWithExplicitIndices;
end;

procedure TEditEngine.HandleErrorEvent(sender: TFieldedText; errorCode: TFieldedTextErrorCode; field: TFieldedTextField);
var
  ErrorText: string;
begin
  ErrorText := CalculateFieldedTextErrorText(errorCode);
  FEditData.SetError(FFieldedText.ActiveItemIndex);
  FErrorEvent(ErrorText);
end;

procedure TEditEngine.HandleFieldHeadingEvent(sender: TFieldedText; field: TFieldedTextField; var stop: Boolean);
begin
  if FFieldedText.Generating then
  begin
    try
      field.Headings[FFieldedText.HeadingLineIndex] := FEditData.Cells[FFieldedText.ActiveItemIndex, FFieldedText.HeadingLineIndex].ValueAsString;
    except
      on E: FormatException do
      begin
        FErrorEvent('Field Heading Format Error: ' + E.Message);
        stop := True;
      end;
    end;
  end;
end;

procedure TEditEngine.HandleFieldValueEvent(sender: TFieldedText; field: TFieldedTextField; var stop: Boolean);
begin
  if FFieldedText.Generating then
  begin
    try
      field.AsObject := FEditData.Cells[FFieldedText.ActiveItemIndex, FEditData.HeadingCount + FFieldedText.RecordCount - 1].Value;
    except
      on E: FormatException do
      begin
        FErrorEvent('Field Value Format Error: ' + E.Message);
        stop := True;
      end;
    end;
  end;
end;

procedure TEditEngine.HandleParseEvent(sender: TFieldedText; eventType: TFieldedTextParseEventType; var stop: Boolean);
begin
  case eventType of
    ftpeFieldParsed:
    begin
      if FFieldedText.InHeadingLine then
        FEditData.AddCell(FFieldedText.ActiveItemIndex, FFieldedText.CurrentField.Headings[FFieldedText.HeadingLineIndex],
                          FFieldedText.CurrentSequenceItem,
                          FFieldedText.CurrentFieldStartPosition, FFieldedText.CurrentFieldLength)
      else
        FEditData.AddCell(FFieldedText.ActiveItemIndex, FFieldedText.CurrentField.AsObject,
                          FFieldedText.CurrentSequenceItem,
                          FFieldedText.CurrentFieldStartPosition, FFieldedText.CurrentFieldLength);
    end;
    ftpeNewHeading:
    begin
      FEditData.AddHeading(FFieldedText.HeadingLineIndex = FFieldedText.MainHeadingLineIndex);
    end;
    ftpeNewRecord:
    begin
      FEditData.AddRecord(FFieldedText.RecordCount-1, FFieldedText.TableCount-1);
    end;
    ftpeStartLine:
    begin
      FEditData.StartLine(FFieldedText.Position);
    end;
    ftpeFinishLine:
    begin
      FEditData.FinishLine(FFieldedText.Position);
    end;
    ftpeNewTable:
    begin
      FEditData.SetLastRecordAsNewTable;
    end;
    ftpeMetaLoadFromDeclaration:
    begin
      MetaModified := False;
      UpdateDisplayCulture;
      RefreshControls;
    end;
    ftpeFinishedHeadings: ;
  end;
end;

procedure TEditEngine.HandleRecordFieldsBeginEvent(sender: TFieldedText; var stop: Boolean);
begin
  if FFieldedText.Generating then
  begin
    if FFieldedText.RecordCount > (FEditData.RowCount - FEditData.HeadingCount) then
    begin
      stop := True;
    end;
  end;
end;

procedure TEditEngine.NewText;
begin
  FFieldedText.FilePath := '';
  FFieldedTextFilePathSetEvent;
  FEditData.Reset;
  FNewOpenTextEvent;
  SetText(nil, '');
  TextModified := False;
  UpdateDisplayCulture;
  RefreshControls;
end;

procedure TEditEngine.OpenMeta(filePath: string);
begin
  FFieldedText.LoadMeta(filePath);
  MetaModified := False;
  TriggerSequencesChangeEvent;
  UpdateDisplayCulture;
  RefreshControls;
end;

procedure TEditEngine.OpenMetaFromUrl(url: string);
begin
  FFieldedText.LoadMetaFromUrl(url);
  MetaModified := False;
  TriggerSequencesChangeEvent;
  RefreshControls;
end;

function TEditEngine.OpenText(filePath: string; out errorDescription: string): Boolean;
var
  I: Integer;
  Reader: StreamReader;
  NewText: string;
  Line: string;
  CharEncoding: Encoding;
begin
  Result := False;
  CharEncoding := nil;

  Reader := StreamReader.Create(filePath, True);
  try
    try
      if Configuration.MaxOpenTextLines <= 0 then
        NewText := Reader.ReadToEnd
      else
      begin
        NewText := '';
        for I := 1 to Configuration.MaxOpenTextLines do
        begin
          Line := Reader.ReadLine;
          if not Assigned(Line) then
            Break
          else
            NewText := NewText + FFieldedText.CrLfString + Line;
        end;
      end;

      CharEncoding := Reader.CurrentEncoding;
      Result := True;
    except
      on OutOfMemoryException do
      begin
        FEditData.Text := nil;
        errorDescription := 'Out of Memory';
      end;
    end;
  finally
    Reader.Close;
  end;

  if Result then
  begin
    FFieldedText.FilePath := filePath;
    if Assigned(CharEncoding) then
    begin
      FFieldedText.TextCharEncoding := CharEncoding;
    end;

    FFieldedTextFilePathSetEvent;
    FEditData.Reset;
    if Assigned(FNewOpenTextEvent) then
    begin
      FNewOpenTextEvent;
    end;
    SetText(nil, NewText);
    TextModified := False;
    UpdateDisplayCulture;
    RefreshControls;
  end;
end;

procedure TEditEngine.OpenTextFromUrl(url: string);
var
  OpenUri: Uri;
  Request: WebRequest;
  Response: WebResponse;
  ResponseStream: Stream;
  Reader: StreamReader;
  ResponseEncoding: System.Text.Encoding;
  DataText: string;
begin
  OpenUri := Uri.Create(url);
  Request := WebRequest.&Create(OpenUri);
  Response := Request.GetResponse;
  try
    ResponseStream := Response.GetResponseStream;
    ResponseEncoding := System.Text.Encoding.UTF8;
    Reader := StreamReader.Create(ResponseStream, ResponseEncoding);
    DataText := Reader.ReadToEnd;
  finally
    Response.Close;
  end;

  FFieldedText.FilePath := '';
  FFieldedTextFilePathSetEvent;
  FEditData.Reset;
  FNewOpenTextEvent;
  SetText(nil, DataText);
  TextModified := False;
  UpdateDisplayCulture;
  RefreshControls;
end;

class function TEditEngine.IndexToNumber(value: Integer): Integer;
begin
  if not Configuration.NumberFromZero then
  begin
    Inc(value);
  end;
  Result := value;
end;

class function TEditEngine.IndexToNumber(value: Int64): Int64;
begin
  if not Configuration.NumberFromZero then
  begin
    Inc(value);
  end;
  Result := value;
end;

function TEditEngine.InsertRedirect(sequenceItem: TFieldedTextSequenceItem; idx: Integer;
                                    redirectType: TFieldedTextSequenceRedirectType): TFieldedTextSequenceRedirect;
begin
  Result := sequenceItem.InsertRedirect(idx, redirectType);
  MetaModified := True;
end;

function TEditEngine.InsertSequence(idx: Integer): TFieldedTextSequence;
begin
  Result := FFieldedText.InsertSequence(idx);
  TriggerSequencesChangeEvent;
  MetaModified := True;
end;

function TEditEngine.InsertSequenceItem(sequence: TFieldedTextSequence; idx: Integer; field: TFieldedTextField): TFieldedTextSequenceItem;
begin
  Result := sequence.InsertField(idx, field);
  MetaModified := True;
end;

function TEditEngine.IsCursorActiveCell(cell: TCell): Boolean;
begin
  Result := Assigned(FCursorActiveCell) and (cell = FCursorActiveCell);
end;

function TEditEngine.IsFieldNameDuplicated(name: string): Boolean;
begin
  Result := FFieldedText.GetFieldNameCount(name) > 1;
end;

function TEditEngine.IsMouseOverCell(cell: TCell): Boolean;
begin
  Result := Assigned(FMouseOverCell) and (cell = FMouseOverCell);
end;

function TEditEngine.IsMouseOverRow(row: TRow): Boolean;
begin
  Result := row = FMouseOverRow;
end;

procedure TEditEngine.MoveField(oldIndex, newIndex: Integer);
begin
  FFieldedText.MoveField(oldIndex, newIndex);
  MetaModified := True;
end;

procedure TEditEngine.MoveSequence(oldIndex, newIndex: Integer);
begin
  FFieldedText.MoveSequence(oldIndex, newIndex);
  MetaModified := True;
end;

procedure TEditEngine.MoveSequenceItem(sequence: TFieldedTextSequence; oldIndex, newIndex: Integer);
begin
  sequence.MoveItem(oldIndex, NewIndex);
  MetaModified := True;
end;

procedure TEditEngine.MoveSequenceRedirect(sequenceItem: TFieldedTextSequenceItem; oldIndex, newIndex: Integer);
begin
  sequenceItem.MoveRedirect(oldIndex, NewIndex);
  MetaModified := True;
end;

procedure TEditEngine.Parse(source: TFrame; newText: string);
var
  Reader: StringReader;
  Success: Boolean;
begin
  FSynchronising := True;
  try
    if Assigned(newText) then
    begin
      SetText(source, newText);
    end;

    FEditData.ResetParsing(FDisplayCulture);

    Reader := StringReader.Create(FEditData.Text);
    try
      Success := FFieldedText.Parse(Reader);
    finally
      Reader.Close;
    end;

    FEditData.Resolve;
    SetSynchronised(True);
  finally
    FSynchronising := False;
  end;

  FParseEvent;

  if Success then
  begin
    FSuccessEvent;
  end;
end;

procedure TEditEngine.RefreshControls(cat: TPropertyCategory);
begin
  case cat of
    pcMainText, pcMainMeta: TriggerRefreshMainControlsEvent;
    pcField: TriggerRefreshFieldsControlsEvent;
    pcSubstitution: ;
    pcSequence: TriggerRefreshSequencesControlsEvent;
  end;
end;

procedure TEditEngine.RemoveField(field: TFieldedTextField);
begin
  FFieldedText.RemoveField(field);
  MetaModified := True;
  TriggerFieldRemovedEvent(field);
end;

procedure TEditEngine.RemoveSequence(idx: Integer);
begin
  FFieldedText.RemoveSequence(idx);
  TriggerRefreshSequencesControlsEvent;
  TriggerSequencesChangeEvent;
end;

procedure TEditEngine.RemoveSequenceItem(sequence: TFieldedTextSequence; idx: Integer);
begin
  sequence.RemoveItem(idx);
  TriggerRefreshSequencesControlsEvent;
end;

procedure TEditEngine.RemoveSequenceRedirect(sequenceItem: TFieldedTextSequenceItem; idx: Integer);
begin
  sequenceItem.RemoveRedirect(idx);
  TriggerRefreshSequencesControlsEvent;
end;

procedure TEditEngine.RefreshControls;
begin
  TriggerRefreshMainControlsEvent;
  TriggerRefreshFieldsControlsEvent;
  TriggerRefreshSequencesControlsEvent;
end;

procedure TEditEngine.ResetMeta;
begin
  FFieldedText.ResetMetaProperties;
  MetaModified := True;
  RefreshControls;
  TriggerSequencesChangeEvent;
end;

procedure TEditEngine.SaveMetaAs(filePath: string);
begin
  FFieldedText.SaveMeta(filePath, Configuration.SaveDesignOnlyMeta, Configuration.SaveMetaWithExplicitIndices);
end;

procedure TEditEngine.SaveText;
begin
  SaveTextAs(FFieldedText.FilePath);
end;

procedure TEditEngine.SaveTextAs(filePath: string);
var
  Writer: StreamWriter;
begin
  Writer := StreamWriter.Create(filePath, False, FFieldedText.TextCharEncoding);
  try
    Writer.Write(FEditData.Text);
    FFieldedText.FilePath := filePath;
    FFieldedTextFilePathSetEvent;
    TextModified := False;
  finally
    Writer.Close;
  end;
end;

procedure TEditEngine.SetCursorCell(activeFrame: TFrame; aCol, aRow: Integer);
var
  FrameChanged: Boolean;
  CellChanged: Boolean;
  NewCell: TCell;
begin
  if activeFrame = FCursorActiveFrame then
    FrameChanged := False
  else
  begin
    FCursorActiveFrame := activeFrame;
    FrameChanged := True;
  end;

  FCursorActiveColIdx := aCol;
  FCursorActiveRowIdx := aRow;

  NewCell := FEditData.Cells[aCol, aRow];

  if NewCell = FCursorActiveCell then
    CellChanged := False
  else
  begin
    FCursorActiveCell := NewCell;
    CellChanged := True;

    if Assigned(FCursorActiveCell) then
      FCursorActiveRichPos := FCursorActiveCell.RichPos
    else
      FCursorActiveRichPos := -1;
  end;

  FCursorActiveChangedEvent(FrameChanged, CellChanged);
end;

procedure TEditEngine.SetCursorRichPos(activeFrame: TFrame; pos: Integer);
var
  FrameChanged: Boolean;
  CellChanged: Boolean;
  NewCell: TCell;
begin
  if activeFrame = FCursorActiveFrame then
    FrameChanged := False
  else
  begin
    FCursorActiveFrame := activeFrame;
    FrameChanged := True;
  end;

  FEditData.FindCellAtRichPos(Pos, NewCell, FCursorActiveColIdx, FCursorActiveRowIdx);

  if NewCell = FCursorActiveCell then
    CellChanged := False
  else
  begin
    FCursorActiveCell := NewCell;
    CellChanged := True;
  end;

  FCursorActiveChangedEvent(FrameChanged, CellChanged);
end;

procedure TEditEngine.SetFieldProperties(name: string; idx: Integer; const Value: TObject);
var
  PropInfo: PropertyInfo;
begin
  PropInfo := TypeOf(FFieldedText.Fields[idx]).GetProperty(name);
  PropInfo.SetValue(FFieldedText.Fields[idx], value, nil);
end;

procedure TEditEngine.SetMainProperties(name: string; const Value: TObject);
var
  PropInfo: PropertyInfo;
begin
  PropInfo := TypeOf(FFieldedText).GetProperty(name);
  PropInfo.SetValue(FFieldedText, value, nil);
end;

procedure TEditEngine.SetMetaCharEncodingName(const Value: string);
begin
  FFieldedText.MetaCharEncodingName := Value;
end;

procedure TEditEngine.SetMetaModified(const Value: Boolean);
begin
  if Value <> FMetaModified then
  begin
    FMetaModified := Value;
    FMetaModifiedChangeEvent;
  end;

  if FMetaModified then
  begin
    SetSynchronised(False);
    FMetaChangeEvent;
  end;
end;

procedure TEditEngine.SetMouseOverCell(overFrame: TFrame; aCol, aRow: Integer);
var
  Changed: Boolean;
  NewCell: TCell;
begin
  if overFrame = FMouseOverFrame then
    Changed := False
  else
  begin
    FMouseOverFrame := overFrame;
    Changed := True;
  end;

  FMouseOverColIdx := aCol;

  if aRow >= 0 then
    FMouseOverRow := FEditData.CheckGetRow(aRow)
  else
    FMouseOverRow := nil;

  NewCell := FEditData.Cells[aCol, aRow];

  if NewCell <> FMouseOverCell then
  begin                                                  
    FMouseOverCell := NewCell;
    Changed := True;
  end;

  if Changed then
  begin
    FMouseOverChangedEvent;
  end;
end;

procedure TEditEngine.SetMouseOverRichPos(overFrame: TFrame; Pos: Integer);
var
  Changed: Boolean;
  NewCell: TCell;
  MouseOverRowIdx: Integer;
begin
  if overFrame = FMouseOverFrame then
    Changed := False
  else
  begin
    FMouseOverFrame := overFrame;
    Changed := True;
  end;

  FEditData.FindCellAtRichPos(Pos, NewCell, FMouseOverColIdx, MouseOverRowIdx);

  if Assigned(NewCell) then
    FMouseOverRow := NewCell.Row
  else
    FMouseOverRow := nil;

  if NewCell <> FMouseOverCell then
  begin
    FMouseOverCell := NewCell;
    Changed := True;
  end;

  if Changed then
  begin
    FMouseOverChangedEvent;
  end;
end;

procedure TEditEngine.SetPropertyValue(name: string; idx: Integer; cat: TPropertyCategory; const Value: TObject;
  out modified: Boolean);
var
  ExistingValue: TObject;
begin
  ExistingValue := Properties[name, idx, cat];

  case cat of
    pcMainText, pcMainMeta: MainProperties[name] := Value;
    pcField: FieldProperties[name, idx] := Value;
    pcSubstitution: SubstitutionProperties[name, idx] := Value;
    pcSequence: SequenceProperties[name, idx] := Value;
    else Assert(False);
  end;

  modified := not value.Equals(ExistingValue);

  if modified then
  begin
    MetaModified := True;
  end;
end;

procedure TEditEngine.SetRedirectProperties(name: string; redirect: TFieldedTextSequenceRedirect; const Value: TObject);
var
  PropInfo: PropertyInfo;
begin
  PropInfo := TypeOf(redirect).GetProperty(name);
  PropInfo.SetValue(redirect, value, nil);
end;

procedure TEditEngine.SetRedirectPropertyValue(name: string; redirect: TFieldedTextSequenceRedirect;
                                               const Value: TObject; out modified: Boolean);
var
  ExistingValue: TObject;
begin
  ExistingValue := RedirectProperties[name, redirect];

  RedirectProperties[name, redirect] := Value;

  modified := not value.Equals(ExistingValue);

  if modified then
  begin
    MetaModified := True;
  end;
end;

procedure TEditEngine.SetSequenceItemProperties(name: string; sequenceItem: TFieldedTextSequenceItem;
  const Value: TObject);
var
  PropInfo: PropertyInfo;
begin
  PropInfo := TypeOf(sequenceItem).GetProperty(name);
  PropInfo.SetValue(sequenceItem, value, nil);
end;

procedure TEditEngine.SetSequenceItemPropertyValue(name: string; sequenceItem: TFieldedTextSequenceItem;
                                                   const Value: TObject; out modified: Boolean);
var
  ExistingValue: TObject;
begin
  ExistingValue := SequenceItemProperties[name, sequenceItem];

  SequenceItemProperties[name, sequenceItem] := Value;

  modified := not value.Equals(ExistingValue);

  if modified then
  begin
    MetaModified := True;
  end;
end;

procedure TEditEngine.SetSequenceProperties(name: string; idx: Integer; const Value: TObject);
var
  PropInfo: PropertyInfo;
begin
  PropInfo := TypeOf(FFieldedText.Sequences[idx]).GetProperty(name);
  PropInfo.SetValue(FFieldedText.Sequences[idx], value, nil);
end;

procedure TEditEngine.SetSubstitutionProperties(name: string; idx: Integer; const Value: TObject);
var
  PropInfo: PropertyInfo;
  Indices: array of TObject;
begin
  PropInfo := TypeOf(FFieldedText).GetProperty(name);
  SetLength(Indices, 1);
  Indices[0] := TObject(idx);
  PropInfo.SetValue(FFieldedText, value, Indices);
end;

procedure TEditEngine.SetSynchronised(const Value: Boolean);
begin
  if Value <> FSynchronised then
  begin
    FSynchronised := Value;
    FSynchronisedChangeEvent;
  end;
end;

procedure TEditEngine.SetText(source: TFrame; textValue: string);
begin
  if FEditData.Text <> textValue then
  begin
    FEditData.Text := textValue;
    TextModified := True;
    if Assigned(source) then
    begin
      SetSynchronised(False);
    end;
    if Assigned(FTextChangeEvent) then
    begin
      FTextChangeEvent(source);
    end;
  end;
end;

procedure TEditEngine.SetTextCharEncodingName(const Value: string);
begin
  FFieldedText.TextCharEncodingName := Value;
end;

procedure TEditEngine.SetTextModified(const Value: Boolean);
begin
  if Value <> FTextModified then
  begin
    FTextModified := Value;
    FTextModifiedChangeEvent;
  end;
end;

procedure TEditEngine.TriggerFieldRemovedEvent(field: TFieldedTextField);
begin
  if Assigned(FFieldRemovedEvent) then
  begin
    FFieldRemovedEvent(field);
  end;
end;

procedure TEditEngine.TriggerRefreshFieldsControlsEvent;
begin
  if Assigned(FRefreshFieldsControlsEvent) then
  begin
    FRefreshFieldsControlsEvent;
  end;
end;

procedure TEditEngine.TriggerRefreshMainControlsEvent;
begin
  if Assigned(FRefreshMainControlsEvent) then
  begin
    FRefreshMainControlsEvent;
  end;
end;

procedure TEditEngine.TriggerRefreshSequencesControlsEvent;
begin
  if Assigned(FRefreshSequencesControlsEvent) then
  begin
    FRefreshSequencesControlsEvent;
  end;
end;

procedure TEditEngine.TriggerSequencesChangeEvent;
begin
  if Assigned(FSequencesChangeEvent) then
  begin
    FSequencesChangeEvent;
  end;
end;

function TEditEngine.UpdateDisplayCulture: Boolean;
var
  NewCulture: CultureInfo;
begin
  case Configuration.DisplayCultureType of
    dcInvariant: NewCulture := CultureInfo.InvariantCulture;
    dcLocal: NewCulture := CultureInfo.CurrentCulture;
    dcNamed: NewCulture := Configuration.NamedDisplayCulture;
    dcFile: NewCulture := Culture;
    else
    begin
      Assert(False);
      NewCulture := CultureInfo.InvariantCulture;
    end;
  end;

  Result := FDisplayCulture <> NewCulture;

  if Result then
  begin
    FDisplayCulture := NewCulture;
  end;
end;

end.
