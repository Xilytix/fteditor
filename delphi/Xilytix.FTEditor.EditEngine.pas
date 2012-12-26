// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.EditEngine;

interface

uses
  SysUtils,
  Forms,
  Rtti,
  Xilytix.FieldedText.Utils,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.EditData;

type
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

      TMetaRefreshControlsDelegate = procedure of object;
      TFieldRemovedDelegate = procedure(field: TFieldedText.TField) of object;
      TErrorDelegate = procedure(errorText: string) of object;
      TSuccessDelegate = procedure of object;
      TParseDelegate = procedure of object;
      TGenerateDelegate = procedure of object;
      TTextChangeDelegate = procedure(source: TFrame) of object;
      TTextModifiedChangeDelegate = procedure of object;
      TMetaChangeDelegate = procedure of object;
      TMetaModifiedChangeDelegate = procedure of object;
      TSynchronisedChangeDelegate = procedure of object;
      TSequencesChangeDelegate = procedure of object;
      TMouseOverChangedDelegate = procedure of object;
      TCursorActiveChangedDelegate = procedure(frameChanged, cellChanged: Boolean) of object;
      TFieldedTextFilePathSetDelegate = procedure of object;
      TNewOpenTextDelegate = procedure of object;

  strict private
    type
      TDataTypeAbbrRec = record
        &Type: TFieldedText.TDataType;
        Abbr: string;
      end;
      TDataTypeAbbrArray = array[TFieldedText.TDataType] of TDataTypeAbbrRec;

      TMetaRefreshControlsDelegates = array of TMetaRefreshControlsDelegate;
      TFieldRemovedDelegates = array of TFieldRemovedDelegate;
      TErrorDelegates = array of TErrorDelegate;
      TSuccessDelegates = array of TSuccessDelegate;
      TParseDelegates = array of TParseDelegate;
      TGenerateDelegates = array of TGenerateDelegate;
      TTextChangeDelegates = array of TTextChangeDelegate;
      TTextModifiedChangeDelegates = array of TTextModifiedChangeDelegate;
      TMetaChangeDelegates = array of TMetaChangeDelegate;
      TMetaModifiedChangeDelegates = array of TMetaModifiedChangeDelegate;
      TSynchronisedChangeDelegates = array of TSynchronisedChangeDelegate;
      TSequencesChangeDelegates = array of TSequencesChangeDelegate;
      TMouseOverChangedDelegates = array of TMouseOverChangedDelegate;
      TCursorActiveChangedDelegates = array of TCursorActiveChangedDelegate;
      TFieldedTextFilePathSetDelegates = array of TFieldedTextFilePathSetDelegate;
      TNewOpenTextDelegates = array of TNewOpenTextDelegate;

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

      FOpenedMetaFilePath: string;
      FMetaModified: Boolean;
      FTextModified: Boolean;

      FEditData: TEditData;
      FSynchronised: Boolean;
      FSynchronising: Boolean;

      FDisplayCulture: TFieldedTextLocaleSettings;

      FMouseOverColIdx: Integer;
      FMouseOverCell: TCell;
      FMouseOverFrame: TFrame;
      FMouseOverRow: TRow;

      FCursorActiveColIdx: Integer;
      FCursorActiveRowIdx: Integer;
      FCursorActiveCell: TCell;
      FCursorActiveRichPos: Integer;
      FCursorActiveFrame: TFrame;

      FRefreshMainControlsDelegates: TMetaRefreshControlsDelegates;
      FRefreshFieldsControlsDelegates: TMetaRefreshControlsDelegates;
      FRefreshSequencesControlsDelegates: TMetaRefreshControlsDelegates;
      FFieldRemovedDelegates: TFieldRemovedDelegates;
      FErrorDelegates: TErrorDelegates;
      FSuccessDelegates: TSuccessDelegates;
      FParseDelegates: TParseDelegates;
      FGenerateDelegates: TGenerateDelegates;
      FTextChangeDelegates: TTextChangeDelegates;
      FTextModifiedChangeDelegates: TTextModifiedChangeDelegates;
      FMetaChangeDelegates: TMetaChangeDelegates;
      FMetaModifiedChangeDelegates: TMetaModifiedChangeDelegates;
      FSynchronisedChangeDelegates: TSynchronisedChangeDelegates;
      FSequencesChangeDelegates: TSequencesChangeDelegates;
      FMouseOverChangedDelegates: TMouseOverChangedDelegates;
      FCursorActiveChangedDelegates: TCursorActiveChangedDelegates;
      FFieldedTextFilePathSetDelegates: TFieldedTextFilePathSetDelegates;
      FNewOpenTextDelegates: TNewOpenTextDelegates;

    procedure HandleParseEvent(sender: TFieldedText; eventType: TFieldedText.TParseEventType; var stop: Boolean);
    procedure HandleFieldHeadingEvent(sender: TFieldedText; field: TFieldedText.TField; var stop: Boolean);
    procedure HandleRecordFieldsBeginEvent(sender: TFieldedText; var stop: Boolean);
    procedure HandleFieldValueEvent(sender: TFieldedText; field: TFieldedText.TField; var stop: Boolean);
//    procedure HandleRecordFieldsEndEvent(sender: TFieldedText; var stop: Boolean);
    procedure HandleErrorEvent(sender: TFieldedText;
                               errorCode: TFieldedText.TErrorCode;
                               field: TFieldedText.TField);
    procedure HandleConfigurationUpdatedEvent;

    procedure NotifyRefreshMainControls;
    procedure NotifyRefreshFieldsControls;
    procedure NotifyRefreshSequencesControls;
    procedure NotifyFieldRemoved(field: TFieldedText.TField);
    procedure NotifyError(const errorText: string);
    procedure NotifySuccess;
    procedure NotifyParse;
    procedure NotifyGenerate;
    procedure NotifyTextChange(source: TFrame);
    procedure NotifyTextModifiedChange;
    procedure NotifyMetaChange;
    procedure NotifyMetaModifiedChange;
    procedure NotifySynchronisedChange;
    procedure NotifySequencesChange;
    procedure NotifyMouseOverChanged;
    procedure NotifyCursorActiveChanged(frameChanged, cellChanged: Boolean);
    procedure NotifyFieldedTextFilePathSet;
    procedure NotifyNewOpenText;

    function CalculateFieldedTextErrorText(errorCode: TFieldedText.TErrorCode): string;

    function SameValue(const Value1, Value2: TValue): Boolean;

    function GetDataTypeAbbr(&type: TFieldedText.TDataType): string;

    function GetCulture: TFieldedTextLocaleSettings;
    function GetFields(idx: Integer): TFieldedText.TField;
    function GetFieldCount: Integer;
    function GetHeadingLineCount: Integer;

    function GetMainProperties(const name: string): TValue;
    procedure SetMainProperties(const name: string; const Value: TValue);
    function GetFieldProperties(const Name: string; idx: Integer): TValue;
    procedure SetFieldProperties(const name: string; idx: Integer; const Value: TValue);
    function GetSubstitutionProperties(const name: string; idx: Integer): TValue;
    procedure SetSubstitutionProperties(const name: string; idx: Integer; const Value: TValue);
    function GetSequenceProperties(const name: string; idx: Integer): TValue;
    procedure SetSequenceProperties(const name: string; idx: Integer; const Value: TValue);
    function GetSequenceItemProperties(const name: string; sequenceItem: TFieldedText.TSequence.TItem): TValue;
    procedure SetSequenceItemProperties(const name: string; sequenceItem: TFieldedText.TSequence.TItem; const Value: TValue);
    function GetRedirectProperties(const name: string; redirect: TFieldedText.TSequenceRedirect): TValue;
    procedure SetRedirectProperties(const name: string; redirect: TFieldedText.TSequenceRedirect; const Value: TValue);

    function GetSequenceCount: Integer;
    function GetSequences(idx: Integer): TFieldedText.TSequence;

    function GetSubstitutionCount: Integer;
    function GetSubstitutionToken(idx: Integer): Char;
    function GetSubstitutionType(idx: Integer): TFieldedTextSubstitutionType;
    function GetSubstitutionValue(idx: Integer): string;
    function GetProperties(name: string; idx: Integer; cat: TPropertyCategory): TValue;
    function GetMetaReferenceType: TFieldedText.TMetaReferenceType;
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
    function GetCurrentField: TFieldedText.TField;
    function GetCurrentSequence: TFieldedText.TSequence;
    function GetCurrentSequenceItem: TFieldedText.TSequence.TItem;

    function GetText: string;
    function GetTextFilePath: string;
    function GetTextCharEncoding: TEncoding;
    function GetTextCharEncodingName: string;
    procedure SetTextCharEncodingName(const Value: string);

    function GetMetaCharEncoding: TEncoding;
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

    property MainProperties[const name: string]: TValue read GetMainProperties write SetMainProperties;
    property FieldProperties[const name: string; idx: Integer]: TValue read GetFieldProperties write SetFieldProperties;
    property SubstitutionProperties[const name: string; idx: Integer]: TValue read GetSubstitutionProperties write SetSubstitutionProperties;
    property SequenceProperties[const name: string; idx: Integer]: TValue read GetSequenceProperties write SetSequenceProperties;
  public
    constructor Create;

    property DataTypeAbbr[&type: TFieldedText.TDataType]: string read GetDataTypeAbbr;

    function UpdateDisplayCulture: Boolean;
    property DisplayCulture: TFieldedTextLocaleSettings read FDisplayCulture;

    property Culture: TFieldedTextLocaleSettings read GetCulture;
    property Fields[idx: Integer]: TFieldedText.TField read GetFields;
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
    property CurrentField: TFieldedText.TField read GetCurrentField;
    property CurrentSequence: TFieldedText.TSequence read GetCurrentSequence;
    property CurrentSequenceItem: TFieldedText.TSequence.TItem read GetCurrentSequenceItem;

    function AddField(dataType: TFieldedText.TDataType): Integer;
    procedure RemoveField(field: TFieldedText.TField);
    procedure MoveField(oldIndex, newIndex: Integer);
    function IsFieldNameDuplicated(name: string): Boolean;

    property SequenceCount: Integer read GetSequenceCount;
    property Sequences[idx: Integer]: TFieldedText.TSequence read GetSequences;
    function InsertSequence(idx: Integer): TFieldedText.TSequence;
    function InsertSequenceItem(sequence: TFieldedText.TSequence; idx: Integer; field: TFieldedText.TField): TFieldedText.TSequence.TItem;
    function InsertRedirect(sequenceItem: TFieldedText.TSequence.TItem; idx: Integer;
                            redirectType: TFieldedText.TSequenceRedirect.TType): TFieldedText.TSequenceRedirect;

    procedure RemoveSequence(idx: Integer);
    procedure RemoveSequenceItem(sequence: TFieldedText.TSequence; idx: Integer);
    procedure RemoveSequenceRedirect(sequenceItem: TFieldedText.TSequence.TItem; idx: Integer);

    procedure MoveSequence(oldIndex, newIndex: Integer);
    procedure MoveSequenceItem(sequence: TFieldedText.TSequence; oldIndex, newIndex: Integer);
    procedure MoveSequenceRedirect(sequenceItem: TFieldedText.TSequence.TItem; oldIndex, newIndex: Integer);

    property SubstitutionCount: Integer read GetSubstitutionCount;
    property SubstitutionToken[idx: Integer]: Char read GetSubstitutionToken;
    property SubstitutionType[idx: Integer]: TFieldedTextSubstitutionType read GetSubstitutionType;
    property SubstitutionValue[idx: Integer]: string read GetSubstitutionValue;
    function AddSubstitution: Integer;
    procedure DeleteSubstitution(idx: Integer);

    property Properties[name: string; idx: Integer; cat: TPropertyCategory]: TValue read GetProperties;
    procedure SetPropertyValue(name: string; idx: Integer; cat: TPropertyCategory; const Value: TValue; out modified: Boolean);

    property SequenceItemProperties[const name: string; sequenceItem: TFieldedText.TSequence.TItem]: TValue read GetSequenceItemProperties write SetSequenceItemProperties;
    procedure SetSequenceItemPropertyValue(const name: string; sequenceItem: TFieldedText.TSequence.TItem; const Value: TValue; out modified: Boolean);

    property RedirectProperties[const name: string; redirect: TFieldedText.TSequenceRedirect]: TValue read GetRedirectProperties write SetRedirectProperties;
    procedure SetRedirectPropertyValue(const name: string; redirect: TFieldedText.TSequenceRedirect; const Value: TValue; out modified: Boolean);

    procedure RefreshControls; overload;
    procedure RefreshControls(cat: TPropertyCategory); overload;

    procedure SetText(source: TFrame; textValue: string);
    procedure Parse(source: TFrame; const newText: string; KeepCurrentText: Boolean);
    procedure Generate(source: TFrame);

    property MetaReferenceType: TFieldedText.TMetaReferenceType read GetMetaReferenceType;
    property MetaReference: string read GetMetaReference;
    property MetaLoadErrorDescription: string read GetMetaLoadErrorDescription;
    property MetaCharEncoding: TEncoding read GetMetaCharEncoding;
    property MetaCharEncodingName: string read GetMetaCharEncodingName write SetMetaCharEncodingName;

    property OpenedMetaFilePath: string read FOpenedMetaFilePath;
    procedure ResetMeta;
    procedure OpenMeta(const filePath: string);
    procedure OpenMetaFromUrl(const url: string);
    procedure SaveMetaAs(const filePath: string);
    procedure SaveMeta;

    property Text: string read GetText;
    property TextFilePath: string read GetTextFilePath;
    property TextCharEncoding: TEncoding read GetTextCharEncoding;
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

    procedure SubscribeRefreshMainControlsEvent(const Delegate: TMetaRefreshControlsDelegate);
    procedure UnsubscribeRefreshMainControlsEvent(const Delegate: TMetaRefreshControlsDelegate);
    procedure SubscribeRefreshFieldsControlsEvent(const Delegate: TMetaRefreshControlsDelegate);
    procedure UnsubscribeRefreshFieldsControlsEvent(const Delegate: TMetaRefreshControlsDelegate);
    procedure SubscribeRefreshSequencesControlsEvent(const Delegate: TMetaRefreshControlsDelegate);
    procedure UnsubscribeRefreshSequencesControlsEvent(const Delegate: TMetaRefreshControlsDelegate);
    procedure SubscribeFieldRemovedEvent(const Delegate: TFieldRemovedDelegate);
    procedure UnsubscribeFieldRemovedEvent(const Delegate: TFieldRemovedDelegate);
    procedure SubscribeErrorEvent(const Delegate: TErrorDelegate);
    procedure UnsubscribeErrorEvent(const Delegate: TErrorDelegate);
    procedure SubscribeSuccessEvent(const Delegate: TSuccessDelegate);
    procedure UnsubscribeSuccessEvent(const Delegate: TSuccessDelegate);
    procedure SubscribeParseEvent(const Delegate: TParseDelegate);
    procedure UnsubscribeParseEvent(const Delegate: TParseDelegate);
    procedure SubscribeGenerateEvent(const Delegate: TGenerateDelegate);
    procedure UnsubscribeGenerateEvent(const Delegate: TGenerateDelegate);
    procedure SubscribeTextChangeEvent(const Delegate: TTextChangeDelegate);
    procedure UnsubscribeTextChangeEvent(const Delegate: TTextChangeDelegate);
    procedure SubscribeTextModifiedChangeEvent(const Delegate: TTextModifiedChangeDelegate);
    procedure UnsubscribeTextModifiedChangeEvent(const Delegate: TTextModifiedChangeDelegate);
    procedure SubscribeMetaChangeEvent(const Delegate: TMetaChangeDelegate);
    procedure UnsubscribeMetaChangeEvent(const Delegate: TMetaChangeDelegate);
    procedure SubscribeMetaModifiedChangeEvent(const Delegate: TMetaModifiedChangeDelegate);
    procedure UnsubscribeMetaModifiedChangeEvent(const Delegate: TMetaModifiedChangeDelegate);
    procedure SubscribeSynchronisedChangeEvent(const Delegate: TSynchronisedChangeDelegate);
    procedure UnsubscribeSynchronisedChangeEvent(const Delegate: TSynchronisedChangeDelegate);
    procedure SubscribeSequencesChangeEvent(const Delegate: TSequencesChangeDelegate);
    procedure UnsubscribeSequencesChangeEvent(const Delegate: TSequencesChangeDelegate);
    procedure SubscribeMouseOverChangedEvent(const Delegate: TMouseOverChangedDelegate);
    procedure UnsubscribeMouseOverChangedEvent(const Delegate: TMouseOverChangedDelegate);
    procedure SubscribeCursorActiveChangedEvent(const Delegate: TCursorActiveChangedDelegate);
    procedure UnsubscribeCursorActiveChangedEvent(const Delegate: TCursorActiveChangedDelegate);
    procedure SubscribeFieldedTextFilePathSetEvent(const Delegate: TFieldedTextFilePathSetDelegate);
    procedure UnsubscribeFieldedTextFilePathSetEvent(const Delegate: TFieldedTextFilePathSetDelegate);
    procedure SubscribeNewOpenTextEvent(const Delegate: TNewOpenTextDelegate);
    procedure UnsubscribeNewOpenTextEvent(const Delegate: TNewOpenTextDelegate);

    class function CountToNumber(value: Integer): Integer;
    class function IndexToNumber(value: Integer): Integer; overload;
    class function IndexToNumber(value: Int64): Int64; overload;
  end;

implementation

uses
  TypInfo,
  Classes,
//  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.Configuration;

{ TEditEngine }

function TEditEngine.AddField(dataType: TFieldedText.TDataType): Integer;
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

function TEditEngine.CalculateFieldedTextErrorText(errorCode: TFieldedText.TErrorCode): string;
begin
  Result := 'Code: ' + EFieldedText.CodeToName(errorCode);
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
  FFieldedText.SubscribeParseEvent(HandleParseEvent);
//  Include(FFieldedText.FieldHeadingEvent, HandleFieldHeadingEvent);
  FFieldedText.SubscribeFieldHeadingEvent(HandleFieldHeadingEvent);
  FFieldedText.SubscribeFieldsBeginEvent(HandleRecordFieldsBeginEvent);
  FFieldedText.SubscribeFieldValueEvent(HandleFieldValueEvent);
//  Include(FFieldedText.RecordFieldsEndEvent, HandleRecordFieldsEndEvent);
  FFieldedText.SubscribeErrorEvent(HandleErrorEvent);
  Configuration.UpdatedEvent := HandleConfigurationUpdatedEvent;

  UpdateDisplayCulture;
  FEditData := TEditData.Create(FDisplayCulture);
end;

procedure TEditEngine.DeleteSubstitution(idx: Integer);
begin
  FFieldedText.DeleteSubstitution(idx);
  MetaModified := True;
end;

function TEditEngine.GetFieldProperties(const Name: string; idx: Integer): TValue;
var
  Context: TRttiContext;
  InstanceType: TRttiInstanceType;
  PropInfo: TRttiProperty;
begin
  Context := TRttiContext.Create;
  try
    InstanceType := Context.GetType(FFieldedText.Fields[idx].ClassType) as TRttiInstanceType;
    PropInfo := InstanceType.GetProperty(Name);
    Result := PropInfo.GetValue(FFieldedText.Fields[idx]);
  finally
    Context.Free;
  end;
end;

procedure TEditEngine.Generate(source: TFrame);
var
  Writer: TStringWriter;
  Success: Boolean;
begin
  FSynchronising := True;
  try
    Writer := TStringWriter.Create;
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
    NotifySuccess;
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
  Result := IndexToNumber(FFieldedText.TableItemIndex);
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

function TEditEngine.GetCulture: TFieldedTextLocaleSettings;
begin
  Result := FFieldedText.LocaleSettings;
end;

function TEditEngine.GetCurrentField: TFieldedText.TField;
begin
  Result := FFieldedText.CurrentField;
end;

function TEditEngine.GetCurrentSequence: TFieldedText.TSequence;
begin
  Result := CurrentSequenceItem.Owner;
end;

function TEditEngine.GetCurrentSequenceItem: TFieldedText.TSequence.TItem;
begin
  Result := FFieldedText.CurrentSequenceItem;
end;

function TEditEngine.GetDataTypeAbbr(&type: TFieldedText.TDataType): string;
begin
  Result := DataTypeAbbrs[&type].Abbr;
end;

function TEditEngine.GetFieldCount: Integer;
begin
  Result := FFieldedText.FieldCount;
end;

function TEditEngine.GetFields(idx: Integer): TFieldedText.TField;
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

function TEditEngine.GetMainProperties(const name: string): TValue;
var
  Context: TRttiContext;
  InstanceType: TRttiInstanceType;
  PropInfo: TRttiProperty;
begin
  Context := TRttiContext.Create;
  try
    InstanceType := Context.GetType(FFieldedText.ClassType) as TRttiInstanceType;
    PropInfo := InstanceType.GetProperty(Name);
    Result := PropInfo.GetValue(FFieldedText);
  finally
    Context.Free;
  end;
end;

function TEditEngine.GetMaxCellsInRowCount: Integer;
begin
  Result := FEditData.MaxCellsInRowCount;
end;

function TEditEngine.GetMetaCharEncoding: TEncoding;
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

function TEditEngine.GetMetaReferenceType: TFieldedText.TMetaReferenceType;
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

function TEditEngine.GetProperties(name: string; idx: Integer; cat: TPropertyCategory): TValue;
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

function TEditEngine.GetRedirectProperties(const name: string; redirect: TFieldedText.TSequenceRedirect): TValue;
var
  Context: TRttiContext;
  InstanceType: TRttiInstanceType;
  PropInfo: TRttiProperty;
begin
  Context := TRttiContext.Create;
  try
    InstanceType := Context.GetType(redirect.ClassType) as TRttiInstanceType;
    PropInfo := InstanceType.GetProperty(Name);
    Result := PropInfo.GetValue(redirect);
  finally
    Context.Free;
  end;
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

function TEditEngine.GetSequenceItemProperties(const name: string; sequenceItem: TFieldedText.TSequence.TItem): TValue;
var
  Context: TRttiContext;
  InstanceType: TRttiInstanceType;
  PropInfo: TRttiProperty;
begin
  Context := TRttiContext.Create;
  try
    InstanceType := Context.GetType(sequenceItem.ClassType) as TRttiInstanceType;
    PropInfo := InstanceType.GetProperty(Name);
    Result := PropInfo.GetValue(sequenceItem);
  finally
    Context.Free;
  end;
end;

function TEditEngine.GetSequenceProperties(const name: string; idx: Integer): TValue;
var
  Sequence: TFieldedText.TSequence;
  Context: TRttiContext;
  InstanceType: TRttiInstanceType;
  PropInfo: TRttiProperty;
begin
  Sequence := FFieldedText.Sequences[Idx];

  Context := TRttiContext.Create;
  try
    InstanceType := Context.GetType(Sequence.ClassType) as TRttiInstanceType;
    PropInfo := InstanceType.GetProperty(Name);
    Result := PropInfo.GetValue(Sequence);
  finally
    Context.Free;
  end;
end;

function TEditEngine.GetSequences(idx: Integer): TFieldedText.TSequence;
begin
  Result := FFieldedText.Sequences[idx];
end;

function TEditEngine.GetSubstitutionCount: Integer;
begin
  Result := FFieldedText.SubstitutionCount;
end;

function TEditEngine.GetSubstitutionProperties(const name: string; idx: Integer): TValue;
var
  Substitution: TFieldedText.TSubstitution;
  Context: TRttiContext;
  RecordType: TRttiRecordType;
  FieldInfo: TRttiField;
begin
  Substitution := FFieldedText.Substitutions[Idx];
  Context := TRttiContext.Create;
  try
    RecordType := Context.GetType(TypeInfo(TFieldedText.TSubstitution)) as TRttiRecordType;
    FieldInfo := RecordType.GetField(Name);
    Result := FieldInfo.GetValue(@Substitution);
  finally
    Context.Free;
  end;
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

function TEditEngine.GetTextCharEncoding: TEncoding;
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
  FFieldedText.MetaTextIndented := Configuration.MetaTextFormatting;
  FFieldedText.MetaTextIndentation := Configuration.MetaTextIndentation;
  FFieldedText.MetaTextIndentChar := Configuration.MetaTextIndentChar;
end;

procedure TEditEngine.HandleErrorEvent(sender: TFieldedText; errorCode: TFieldedText.TErrorCode; field: TFieldedText.TField);
var
  ErrorText: string;
begin
  ErrorText := CalculateFieldedTextErrorText(errorCode);
  FEditData.SetError(FFieldedText.TableFieldIndex);
  NotifyError(ErrorText);
end;

procedure TEditEngine.HandleFieldHeadingEvent(sender: TFieldedText; field: TFieldedText.TField; var stop: Boolean);
begin
  if FFieldedText.Generating then
  begin
    try
      field.Headings[FFieldedText.HeadingLineIndex] := FEditData.Cells[FFieldedText.TableFieldIndex, FFieldedText.HeadingLineIndex].ValueAsString;
    except
      on E: EConvertError do
      begin
        NotifyError('Field Heading Format Error: ' + E.Message);
        stop := True;
      end;
    end;
  end;
end;

procedure TEditEngine.HandleFieldValueEvent(sender: TFieldedText; field: TFieldedText.TField; var stop: Boolean);
begin
  if FFieldedText.Generating then
  begin
    try
      field.AsVariant := FEditData.Cells[FFieldedText.TableFieldIndex, FEditData.HeadingCount + FFieldedText.RecordCount - 1].Value;
    except
      on E: EConvertError do
      begin
        NotifyError('Field Value Format Error: ' + E.Message);
        stop := True;
      end;
    end;
  end;
end;

procedure TEditEngine.HandleParseEvent(sender: TFieldedText; eventType: TFieldedText.TParseEventType; var stop: Boolean);
begin
  case eventType of
    ftpeFieldParsed:
    begin
      if FFieldedText.InHeadingLine then
        FEditData.AddCell(FFieldedText.TableFieldIndex, FFieldedText.CurrentField.Headings[FFieldedText.HeadingLineIndex],
                          FFieldedText.CurrentSequenceItem,
                          FFieldedText.CurrentFieldStartPosition, FFieldedText.CurrentFieldLength)
      else
        FEditData.AddCell(FFieldedText.TableFieldIndex, FFieldedText.CurrentField.AsVariant,
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
  NotifyFieldedTextFilePathSet;
  FEditData.Reset;
  NotifyNewOpenText;
  SetText(nil, '');
  TextModified := False;
  UpdateDisplayCulture;
  RefreshControls;
end;

procedure TEditEngine.NotifyCursorActiveChanged(frameChanged, cellChanged: Boolean);
var
  I: Integer;
  Delegates: TCursorActiveChangedDelegates;
begin
  Delegates := Copy(FCursorActiveChangedDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I](frameChanged, cellChanged);
  end;
end;

procedure TEditEngine.NotifyError(const errorText: string);
var
  I: Integer;
  Delegates: TErrorDelegates;
begin
  Delegates := Copy(FErrorDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I](errorText);
  end;
end;

procedure TEditEngine.NotifyFieldedTextFilePathSet;
var
  I: Integer;
  Delegates: TFieldedTextFilePathSetDelegates;
begin
  Delegates := Copy(FFieldedTextFilePathSetDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifyFieldRemoved(field: TFieldedText.TField);
var
  I: Integer;
  Delegates: TFieldRemovedDelegates;
begin
  Delegates := Copy(FFieldRemovedDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I](field);
  end;
end;

procedure TEditEngine.NotifyGenerate;
var
  I: Integer;
  Delegates: TGenerateDelegates;
begin
  Delegates := Copy(FGenerateDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifyMetaChange;
var
  I: Integer;
  Delegates: TMetaChangeDelegates;
begin
  Delegates := Copy(FMetaChangeDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifyMetaModifiedChange;
var
  I: Integer;
  Delegates: TMetaModifiedChangeDelegates;
begin
  Delegates := Copy(FMetaModifiedChangeDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifyMouseOverChanged;
var
  I: Integer;
  Delegates: TMouseOverChangedDelegates;
begin
  Delegates := Copy(FMouseOverChangedDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
    Delegates[I];
  end;
end;

procedure TEditEngine.NotifyNewOpenText;
var
  I: Integer;
  Delegates: TNewOpenTextDelegates;
begin
  Delegates := Copy(FNewOpenTextDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifyParse;
var
  I: Integer;
  Delegates: TParseDelegates;
begin
  Delegates := Copy(FParseDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifyRefreshFieldsControls;
var
  I: Integer;
  Delegates: TMetaRefreshControlsDelegates;
begin
  Delegates := Copy(FRefreshFieldsControlsDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifyRefreshMainControls;
var
  I: Integer;
  Delegates: TMetaRefreshControlsDelegates;
begin
  Delegates := Copy(FRefreshMainControlsDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
    Delegates[I];
  end;
end;

procedure TEditEngine.NotifyRefreshSequencesControls;
var
  I: Integer;
  Delegates: TMetaRefreshControlsDelegates;
begin
  Delegates := Copy(FRefreshSequencesControlsDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifySequencesChange;
var
  I: Integer;
  Delegates: TSequencesChangeDelegates;
begin
  Delegates := Copy(FSequencesChangeDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifySuccess;
var
  I: Integer;
  Delegates: TSuccessDelegates;
begin
  Delegates := Copy(FSuccessDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifySynchronisedChange;
var
  I: Integer;
  Delegates: TSynchronisedChangeDelegates;
begin
  Delegates := Copy(FSynchronisedChangeDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.NotifyTextChange(source: TFrame);
var
  I: Integer;
  Delegates: TTextChangeDelegates;
begin
  Delegates := Copy(FTextChangeDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I](source);
  end;
end;

procedure TEditEngine.NotifyTextModifiedChange;
var
  I: Integer;
  Delegates: TTextModifiedChangeDelegates;
begin
  Delegates := Copy(FTextModifiedChangeDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
     Delegates[I];
  end;
end;

procedure TEditEngine.OpenMeta(const filePath: string);
begin
  FOpenedMetaFilePath := filePath;
  FFieldedText.LoadMeta(filePath);
  MetaModified := False;
  NotifySequencesChange;
  UpdateDisplayCulture;
  RefreshControls;
end;

procedure TEditEngine.OpenMetaFromUrl(const url: string);
begin
  FOpenedMetaFilePath := '';
  FFieldedText.LoadMetaFromUrl(url);
  MetaModified := False;
  NotifySequencesChange;
  RefreshControls;
end;

function TEditEngine.OpenText(filePath: string; out errorDescription: string): Boolean;
var
  I: Integer;
  Reader: TStreamReader;
  NewText: string;
  Line: string;
  CharEncoding: TEncoding;
begin
  Result := False;
  CharEncoding := nil;

  Reader := TStreamReader.Create(filePath, True);
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
          if (Line = '') and Reader.EndOfStream then
            Break
          else
            NewText := NewText + FFieldedText.CrLfString + Line;
        end;
      end;

      CharEncoding := Reader.CurrentEncoding;
      Result := True;
    except
      on EOutOfMemory do
      begin
        FEditData.Text := '';
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

    NotifyFieldedTextFilePathSet;
    FEditData.Reset;
    NotifyNewOpenText;
    SetText(nil, NewText);
    TextModified := False;
    UpdateDisplayCulture;
    RefreshControls;
  end;
end;

procedure TEditEngine.OpenTextFromUrl(url: string);
{var
  OpenUri: Uri;
  Request: WebRequest;
  Response: WebResponse;
  ResponseStream: Stream;
  Reader: StreamReader;
  ResponseEncoding: System.Text.Encoding;
  DataText: string;}
begin
{  OpenUri := Uri.Create(url);
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
  RefreshControls;}
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

function TEditEngine.InsertRedirect(sequenceItem: TFieldedText.TSequence.TItem; idx: Integer;
                                    redirectType: TFieldedText.TSequenceRedirect.TType): TFieldedText.TSequenceRedirect;
begin
  Result := sequenceItem.InsertRedirect(idx, redirectType);
  MetaModified := True;
end;

function TEditEngine.InsertSequence(idx: Integer): TFieldedText.TSequence;
begin
  Result := FFieldedText.InsertSequence(idx);
  NotifySequencesChange;
  MetaModified := True;
end;

function TEditEngine.InsertSequenceItem(sequence: TFieldedText.TSequence; idx: Integer; field: TFieldedText.TField): TFieldedText.TSequence.TItem;
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

procedure TEditEngine.MoveSequenceItem(sequence: TFieldedText.TSequence; oldIndex, newIndex: Integer);
begin
  sequence.MoveItem(oldIndex, NewIndex);
  MetaModified := True;
end;

procedure TEditEngine.MoveSequenceRedirect(sequenceItem: TFieldedText.TSequence.TItem; oldIndex, newIndex: Integer);
begin
  sequenceItem.MoveRedirect(oldIndex, NewIndex);
  MetaModified := True;
end;

procedure TEditEngine.Parse(source: TFrame; const newText: string; KeepCurrentText: Boolean);
var
  Reader: TStringReader;
  Success: Boolean;
begin
  FSynchronising := True;
  try
    if not KeepCurrentText then
    begin
      SetText(source, newText);
    end;

    FEditData.ResetParsing(FDisplayCulture);

    Reader := TStringReader.Create(FEditData.Text);
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

  NotifyParse;

  if Success then
  begin
    NotifySuccess;
  end;
end;

procedure TEditEngine.RefreshControls(cat: TPropertyCategory);
begin
  case cat of
    pcMainText, pcMainMeta: NotifyRefreshMainControls;
    pcField: NotifyRefreshFieldsControls;
    pcSubstitution: ;
    pcSequence: NotifyRefreshSequencesControls;
  end;
end;

procedure TEditEngine.RemoveField(field: TFieldedText.TField);
begin
  FFieldedText.RemoveField(field);
  MetaModified := True;
  NotifyFieldRemoved(field);
end;

procedure TEditEngine.RemoveSequence(idx: Integer);
begin
  FFieldedText.RemoveSequence(idx);
  NotifyRefreshSequencesControls;
  NotifySequencesChange;
end;

procedure TEditEngine.RemoveSequenceItem(sequence: TFieldedText.TSequence; idx: Integer);
begin
  sequence.RemoveItem(idx);
  NotifyRefreshSequencesControls;
end;

procedure TEditEngine.RemoveSequenceRedirect(sequenceItem: TFieldedText.TSequence.TItem; idx: Integer);
begin
  sequenceItem.RemoveRedirect(idx);
  NotifyRefreshSequencesControls;
end;

procedure TEditEngine.RefreshControls;
begin
  NotifyRefreshMainControls;
  NotifyRefreshFieldsControls;
  NotifyRefreshSequencesControls;
end;

procedure TEditEngine.ResetMeta;
begin
  FOpenedMetaFilePath := '';
  FFieldedText.ResetMetaProperties;
  MetaModified := True;
  RefreshControls;
  NotifySequencesChange;
end;

function TEditEngine.SameValue(const Value1, Value2: TValue): Boolean;
begin
  if Value1.IsEmpty then
    Result := Value2.IsEmpty
  else
  begin
    if Value2.IsEmpty then
      Result := False
    else
    begin
{      if Value1.Kind <> Value2.Kind then
      begin
        Assert(False);
        Result := False;
      end
      else
      begin}
        case Value1.Kind of
          tkInteger: Result := Value1.AsInteger = Value2.AsInteger;
          tkEnumeration: Result := Value1.AsOrdinal = Value2.AsOrdinal;
          tkFloat: Result := Value1.AsExtended = Value2.AsExtended;
          tkString, tkUString, tkChar: Result := Value1.AsString = Value2.AsString;
          tkInt64:  Result := Value1.AsInt64 = Value2.AsInt64;
          tkUnknown,
          tkSet,
          tkClass: Result := Value1.AsObject = Value2.AsObject;
          tkMethod,
          tkWChar,
          tkLString,
          tkWString,
          tkVariant,
          tkArray,
          tkRecord,
          tkInterface,
          tkDynArray,
          tkClassRef,
          tkPointer,
          tkProcedure: raise Exception.Create('Unsupported Kind for SameValue()');
          else raise Exception.Create('Unhandled Kind for SameValue()');
        end;
//      end;
    end;
  end;
end;

procedure TEditEngine.SaveMeta;
begin
  if FOpenedMetaFilePath <> '' then
  begin
    FFieldedText.SaveMeta(FOpenedMetaFilePath, Configuration.SaveDesignOnlyMeta, Configuration.SaveMetaWithExplicitIndices);
  end;
end;

procedure TEditEngine.SaveMetaAs(const filePath: string);
begin
  FOpenedMetaFilePath := filePath;
  FFieldedText.SaveMeta(filePath, Configuration.SaveDesignOnlyMeta, Configuration.SaveMetaWithExplicitIndices);
end;

procedure TEditEngine.SaveText;
begin
  SaveTextAs(FFieldedText.FilePath);
end;

procedure TEditEngine.SaveTextAs(filePath: string);
var
  Writer: TStreamWriter;
begin
  Writer := TStreamWriter.Create(filePath, False, FFieldedText.TextCharEncoding);
  try
    Writer.Write(FEditData.Text);
    FFieldedText.FilePath := filePath;
    NotifyFieldedTextFilePathSet;
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

  NotifyCursorActiveChanged(FrameChanged, CellChanged);
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

  NotifyCursorActiveChanged(FrameChanged, CellChanged);
end;

procedure TEditEngine.SetFieldProperties(const name: string; idx: Integer; const Value: TValue);
var
  Context: TRttiContext;
  InstanceType: TRttiInstanceType;
  PropInfo: TRttiProperty;
begin
  Context := TRttiContext.Create;
  try
    InstanceType := Context.GetType(FFieldedText.Fields[idx].ClassType) as TRttiInstanceType;
    PropInfo := InstanceType.GetProperty(Name);
    PropInfo.SetValue(FFieldedText.Fields[idx], Value);
  finally
    Context.Free;
  end;
end;

procedure TEditEngine.SetMainProperties(const name: string; const Value: TValue);
var
  Context: TRttiContext;
  InstanceType: TRttiInstanceType;
  PropInfo: TRttiProperty;
begin
  Context := TRttiContext.Create;
  try
    InstanceType := Context.GetType(FFieldedText.ClassType) as TRttiInstanceType;
    PropInfo := InstanceType.GetProperty(Name);
    PropInfo.SetValue(FFieldedText, Value);
  finally
    Context.Free;
  end;
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
    NotifyMetaModifiedChange;
  end;

  if FMetaModified then
  begin
    SetSynchronised(False);
    NotifyMetaChange;
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
    NotifyMouseOverChanged;
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
    NotifyMouseOverChanged;
  end;
end;

procedure TEditEngine.SetPropertyValue(name: string; idx: Integer; cat: TPropertyCategory; const Value: TValue;
  out modified: Boolean);
var
  ExistingValue: TValue;
begin
  ExistingValue := Properties[name, idx, cat];

  case cat of
    pcMainText, pcMainMeta: MainProperties[name] := Value;
    pcField: FieldProperties[name, idx] := Value;
    pcSubstitution: SubstitutionProperties[name, idx] := Value;
    pcSequence: SequenceProperties[name, idx] := Value;
    else Assert(False);
  end;

  modified := not SameValue(value, ExistingValue);

  if modified then
  begin
    MetaModified := True;
  end;
end;

procedure TEditEngine.SetRedirectProperties(const name: string; redirect: TFieldedText.TSequenceRedirect; const Value: TValue);
var
  Context: TRttiContext;
  InstanceType: TRttiInstanceType;
  PropInfo: TRttiProperty;
begin
  Context := TRttiContext.Create;
  try
    InstanceType := Context.GetType(redirect.ClassType) as TRttiInstanceType;
    PropInfo := InstanceType.GetProperty(Name);
    PropInfo.SetValue(redirect, Value);
  finally
    Context.Free;
  end;
end;

procedure TEditEngine.SetRedirectPropertyValue(const name: string; redirect: TFieldedText.TSequenceRedirect;
                                               const Value: TValue; out modified: Boolean);
var
  ExistingValue: TValue;
begin
  ExistingValue := RedirectProperties[name, redirect];

  RedirectProperties[name, redirect] := Value;

  modified := not SameValue(ExistingValue, value);

  if modified then
  begin
    MetaModified := True;
  end;
end;

procedure TEditEngine.SetSequenceItemProperties(const name: string; sequenceItem: TFieldedText.TSequence.TItem;
  const Value: TValue);
var
  Context: TRttiContext;
  InstanceType: TRttiInstanceType;
  PropInfo: TRttiProperty;
begin
  Context := TRttiContext.Create;
  try
    InstanceType := Context.GetType(sequenceItem.ClassType) as TRttiInstanceType;
    PropInfo := InstanceType.GetProperty(Name);
    PropInfo.SetValue(sequenceItem, Value);
  finally
    Context.Free;
  end;
end;

procedure TEditEngine.SetSequenceItemPropertyValue(const name: string; sequenceItem: TFieldedText.TSequence.TItem;
                                                   const Value: TValue; out modified: Boolean);
var
  ExistingValue: TValue;
begin
  ExistingValue := SequenceItemProperties[name, sequenceItem];

  SequenceItemProperties[name, sequenceItem] := Value;

  modified := not SameValue(Value, ExistingValue);

  if modified then
  begin
    MetaModified := True;
  end;
end;

procedure TEditEngine.SetSequenceProperties(const name: string; idx: Integer; const Value: TValue);
var
  Sequence: TFieldedText.TSequence;
  Context: TRttiContext;
  InstanceType: TRttiInstanceType;
  PropInfo: TRttiProperty;
begin
  Sequence := FFieldedText.Sequences[Idx];

  Context := TRttiContext.Create;
  try
    InstanceType := Context.GetType(Sequence.ClassType) as TRttiInstanceType;
    PropInfo := InstanceType.GetProperty(Name);
    PropInfo.SetValue(Sequence, Value);
  finally
    Context.Free;
  end;
end;

procedure TEditEngine.SetSubstitutionProperties(const name: string; idx: Integer; const Value: TValue);
var
  Substitution: TFieldedText.TSubstitution;
  Context: TRttiContext;
  RecordType: TRttiRecordType;
  FieldInfo: TRttiField;
begin
  Substitution := FFieldedText.Substitutions[Idx];
  Context := TRttiContext.Create;
  try
    RecordType := Context.GetType(TypeInfo(TFieldedText.TSubstitution)) as TRttiRecordType;
    FieldInfo := RecordType.GetField(Name);
    FieldInfo.SetValue(@Substitution, Value);
  finally
    Context.Free;
  end;
  FFieldedText.Substitutions[Idx] := Substitution;
end;

procedure TEditEngine.SetSynchronised(const Value: Boolean);
begin
  if Value <> FSynchronised then
  begin
    FSynchronised := Value;
    NotifySynchronisedChange;
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
    NotifyTextChange(source);
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
    NotifyTextModifiedChange;
  end;
end;

procedure TEditEngine.SubscribeCursorActiveChangedEvent(
  const Delegate: TCursorActiveChangedDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FCursorActiveChangedDelegates);
  SetLength(FCursorActiveChangedDelegates, Idx + 1);
  FCursorActiveChangedDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeErrorEvent(const Delegate: TErrorDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FErrorDelegates);
  SetLength(FErrorDelegates, Idx + 1);
  FErrorDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeFieldedTextFilePathSetEvent(
  const Delegate: TFieldedTextFilePathSetDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FFieldedTextFilePathSetDelegates);
  SetLength(FFieldedTextFilePathSetDelegates, Idx + 1);
  FFieldedTextFilePathSetDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeFieldRemovedEvent(
  const Delegate: TFieldRemovedDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FFieldRemovedDelegates);
  SetLength(FFieldRemovedDelegates, Idx + 1);
  FFieldRemovedDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeGenerateEvent(const Delegate: TGenerateDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FGenerateDelegates);
  SetLength(FGenerateDelegates, Idx + 1);
  FGenerateDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeMetaChangeEvent(
  const Delegate: TMetaChangeDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FMetaChangeDelegates);
  SetLength(FMetaChangeDelegates, Idx + 1);
  FMetaChangeDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeMetaModifiedChangeEvent(
  const Delegate: TMetaModifiedChangeDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FMetaModifiedChangeDelegates);
  SetLength(FMetaModifiedChangeDelegates, Idx + 1);
  FMetaModifiedChangeDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeMouseOverChangedEvent(
  const Delegate: TMouseOverChangedDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FMouseOverChangedDelegates);
  SetLength(FMouseOverChangedDelegates, Idx + 1);
  FMouseOverChangedDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeNewOpenTextEvent(
  const Delegate: TNewOpenTextDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FNewOpenTextDelegates);
  SetLength(FNewOpenTextDelegates, Idx + 1);
  FNewOpenTextDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeParseEvent(const Delegate: TParseDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FParseDelegates);
  SetLength(FParseDelegates, Idx + 1);
  FParseDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeRefreshFieldsControlsEvent(
  const Delegate: TMetaRefreshControlsDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FRefreshFieldsControlsDelegates);
  SetLength(FRefreshFieldsControlsDelegates, Idx + 1);
  FRefreshFieldsControlsDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeRefreshMainControlsEvent(
  const Delegate: TMetaRefreshControlsDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FRefreshMainControlsDelegates);
  SetLength(FRefreshMainControlsDelegates, Idx + 1);
  FRefreshMainControlsDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeRefreshSequencesControlsEvent(
  const Delegate: TMetaRefreshControlsDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FRefreshSequencesControlsDelegates);
  SetLength(FRefreshSequencesControlsDelegates, Idx + 1);
  FRefreshSequencesControlsDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeSequencesChangeEvent(
  const Delegate: TSequencesChangeDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FSequencesChangeDelegates);
  SetLength(FSequencesChangeDelegates, Idx + 1);
  FSequencesChangeDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeSuccessEvent(const Delegate: TSuccessDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FSuccessDelegates);
  SetLength(FSuccessDelegates, Idx + 1);
  FSuccessDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeSynchronisedChangeEvent(
  const Delegate: TSynchronisedChangeDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FSynchronisedChangeDelegates);
  SetLength(FSynchronisedChangeDelegates, Idx + 1);
  FSynchronisedChangeDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeTextChangeEvent(
  const Delegate: TTextChangeDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FTextChangeDelegates);
  SetLength(FTextChangeDelegates, Idx + 1);
  FTextChangeDelegates[Idx] := Delegate;
end;

procedure TEditEngine.SubscribeTextModifiedChangeEvent(
  const Delegate: TTextModifiedChangeDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FTextModifiedChangeDelegates);
  SetLength(FTextModifiedChangeDelegates, Idx + 1);
  FTextModifiedChangeDelegates[Idx] := Delegate;
end;

procedure TEditEngine.UnsubscribeCursorActiveChangedEvent(
  const Delegate: TCursorActiveChangedDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TCursorActiveChangedDelegate;
begin
  Idx := -1;
  for I := Low(FCursorActiveChangedDelegates) to High(FCursorActiveChangedDelegates) do
  begin
    ExistingDelegate := FCursorActiveChangedDelegates[I];
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
    FCursorActiveChangedDelegates[Idx] := FCursorActiveChangedDelegates[High(FCursorActiveChangedDelegates)];
    SetLength(FCursorActiveChangedDelegates, Length(FCursorActiveChangedDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeErrorEvent(const Delegate: TErrorDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TErrorDelegate;
begin
  Idx := -1;
  for I := Low(FErrorDelegates) to High(FErrorDelegates) do
  begin
    ExistingDelegate := FErrorDelegates[I];
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
    FErrorDelegates[Idx] := FErrorDelegates[High(FErrorDelegates)];
    SetLength(FErrorDelegates, Length(FErrorDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeFieldedTextFilePathSetEvent(
  const Delegate: TFieldedTextFilePathSetDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TFieldedTextFilePathSetDelegate;
begin
  Idx := -1;
  for I := Low(FFieldedTextFilePathSetDelegates) to High(FFieldedTextFilePathSetDelegates) do
  begin
    ExistingDelegate := FFieldedTextFilePathSetDelegates[I];
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
    FFieldedTextFilePathSetDelegates[Idx] := FFieldedTextFilePathSetDelegates[High(FFieldedTextFilePathSetDelegates)];
    SetLength(FFieldedTextFilePathSetDelegates, Length(FFieldedTextFilePathSetDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeFieldRemovedEvent(
  const Delegate: TFieldRemovedDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TFieldRemovedDelegate;
begin
  Idx := -1;
  for I := Low(FFieldRemovedDelegates) to High(FFieldRemovedDelegates) do
  begin
    ExistingDelegate := FFieldRemovedDelegates[I];
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
    FFieldRemovedDelegates[Idx] := FFieldRemovedDelegates[High(FFieldRemovedDelegates)];
    SetLength(FFieldRemovedDelegates, Length(FFieldRemovedDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeGenerateEvent(const Delegate: TGenerateDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TGenerateDelegate;
begin
  Idx := -1;
  for I := Low(FGenerateDelegates) to High(FGenerateDelegates) do
  begin
    ExistingDelegate := FGenerateDelegates[I];
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
    FGenerateDelegates[Idx] := FGenerateDelegates[High(FGenerateDelegates)];
    SetLength(FGenerateDelegates, Length(FGenerateDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeMetaChangeEvent(
  const Delegate: TMetaChangeDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TMetaChangeDelegate;
begin
  Idx := -1;
  for I := Low(FMetaChangeDelegates) to High(FMetaChangeDelegates) do
  begin
    ExistingDelegate := FMetaChangeDelegates[I];
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
    FMetaChangeDelegates[Idx] := FMetaChangeDelegates[High(FMetaChangeDelegates)];
    SetLength(FMetaChangeDelegates, Length(FMetaChangeDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeMetaModifiedChangeEvent(
  const Delegate: TMetaModifiedChangeDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TMetaModifiedChangeDelegate;
begin
  Idx := -1;
  for I := Low(FMetaModifiedChangeDelegates) to High(FMetaModifiedChangeDelegates) do
  begin
    ExistingDelegate := FMetaModifiedChangeDelegates[I];
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
    FMetaModifiedChangeDelegates[Idx] := FMetaModifiedChangeDelegates[High(FMetaModifiedChangeDelegates)];
    SetLength(FMetaModifiedChangeDelegates, Length(FMetaModifiedChangeDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeMouseOverChangedEvent(
  const Delegate: TMouseOverChangedDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TMouseOverChangedDelegate;
begin
  Idx := -1;
  for I := Low(FMouseOverChangedDelegates) to High(FMouseOverChangedDelegates) do
  begin
    ExistingDelegate := FMouseOverChangedDelegates[I];
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
    FMouseOverChangedDelegates[Idx] := FMouseOverChangedDelegates[High(FMouseOverChangedDelegates)];
    SetLength(FMouseOverChangedDelegates, Length(FMouseOverChangedDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeNewOpenTextEvent(
  const Delegate: TNewOpenTextDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TNewOpenTextDelegate;
begin
  Idx := -1;
  for I := Low(FNewOpenTextDelegates) to High(FNewOpenTextDelegates) do
  begin
    ExistingDelegate := FNewOpenTextDelegates[I];
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
    FNewOpenTextDelegates[Idx] := FNewOpenTextDelegates[High(FNewOpenTextDelegates)];
    SetLength(FNewOpenTextDelegates, Length(FNewOpenTextDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeParseEvent(const Delegate: TParseDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TParseDelegate;
begin
  Idx := -1;
  for I := Low(FParseDelegates) to High(FParseDelegates) do
  begin
    ExistingDelegate := FParseDelegates[I];
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
    FParseDelegates[Idx] := FParseDelegates[High(FParseDelegates)];
    SetLength(FParseDelegates, Length(FParseDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeRefreshFieldsControlsEvent(
  const Delegate: TMetaRefreshControlsDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TMetaRefreshControlsDelegate;
begin
  Idx := -1;
  for I := Low(FRefreshFieldsControlsDelegates) to High(FRefreshFieldsControlsDelegates) do
  begin
    ExistingDelegate := FRefreshFieldsControlsDelegates[I];
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
    FRefreshFieldsControlsDelegates[Idx] := FRefreshFieldsControlsDelegates[High(FRefreshFieldsControlsDelegates)];
    SetLength(FRefreshFieldsControlsDelegates, Length(FRefreshFieldsControlsDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeRefreshMainControlsEvent(
  const Delegate: TMetaRefreshControlsDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TMetaRefreshControlsDelegate;
begin
  Idx := -1;
  for I := Low(FRefreshMainControlsDelegates) to High(FRefreshMainControlsDelegates) do
  begin
    ExistingDelegate := FRefreshMainControlsDelegates[I];
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
    FRefreshMainControlsDelegates[Idx] := FRefreshMainControlsDelegates[High(FRefreshMainControlsDelegates)];
    SetLength(FRefreshMainControlsDelegates, Length(FRefreshMainControlsDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeRefreshSequencesControlsEvent(
  const Delegate: TMetaRefreshControlsDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TMetaRefreshControlsDelegate;
begin
  Idx := -1;
  for I := Low(FRefreshSequencesControlsDelegates) to High(FRefreshSequencesControlsDelegates) do
  begin
    ExistingDelegate := FRefreshSequencesControlsDelegates[I];
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
    FRefreshSequencesControlsDelegates[Idx] := FRefreshSequencesControlsDelegates[High(FRefreshSequencesControlsDelegates)];
    SetLength(FRefreshSequencesControlsDelegates, Length(FRefreshSequencesControlsDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeSequencesChangeEvent(
  const Delegate: TSequencesChangeDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TSequencesChangeDelegate;
begin
  Idx := -1;
  for I := Low(FSequencesChangeDelegates) to High(FSequencesChangeDelegates) do
  begin
    ExistingDelegate := FSequencesChangeDelegates[I];
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
    FSequencesChangeDelegates[Idx] := FSequencesChangeDelegates[High(FSequencesChangeDelegates)];
    SetLength(FSequencesChangeDelegates, Length(FSequencesChangeDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeSuccessEvent(const Delegate: TSuccessDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TSuccessDelegate;
begin
  Idx := -1;
  for I := Low(FSuccessDelegates) to High(FSuccessDelegates) do
  begin
    ExistingDelegate := FSuccessDelegates[I];
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
    FSuccessDelegates[Idx] := FSuccessDelegates[High(FSuccessDelegates)];
    SetLength(FSuccessDelegates, Length(FSuccessDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeSynchronisedChangeEvent(
  const Delegate: TSynchronisedChangeDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TSynchronisedChangeDelegate;
begin
  Idx := -1;
  for I := Low(FSynchronisedChangeDelegates) to High(FSynchronisedChangeDelegates) do
  begin
    ExistingDelegate := FSynchronisedChangeDelegates[I];
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
    FSynchronisedChangeDelegates[Idx] := FSynchronisedChangeDelegates[High(FSynchronisedChangeDelegates)];
    SetLength(FSynchronisedChangeDelegates, Length(FSynchronisedChangeDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeTextChangeEvent(
  const Delegate: TTextChangeDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TTextChangeDelegate;
begin
  Idx := -1;
  for I := Low(FTextChangeDelegates) to High(FTextChangeDelegates) do
  begin
    ExistingDelegate := FTextChangeDelegates[I];
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
    FTextChangeDelegates[Idx] := FTextChangeDelegates[High(FTextChangeDelegates)];
    SetLength(FTextChangeDelegates, Length(FTextChangeDelegates)-1);
  end;
end;

procedure TEditEngine.UnsubscribeTextModifiedChangeEvent(
  const Delegate: TTextModifiedChangeDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TTextModifiedChangeDelegate;
begin
  Idx := -1;
  for I := Low(FTextModifiedChangeDelegates) to High(FTextModifiedChangeDelegates) do
  begin
    ExistingDelegate := FTextModifiedChangeDelegates[I];
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
    FTextModifiedChangeDelegates[Idx] := FTextModifiedChangeDelegates[High(FTextModifiedChangeDelegates)];
    SetLength(FTextModifiedChangeDelegates, Length(FTextModifiedChangeDelegates)-1);
  end;
end;

function TEditEngine.UpdateDisplayCulture: Boolean;
var
  NewCulture: TFieldedTextLocaleSettings;
begin
  case Configuration.DisplayCultureType of
    dcInvariant: NewCulture := TFieldedTextLocaleSettings.Invariant;
    dcLocal: NewCulture := TFieldedTextLocaleSettings.Current;
    dcNamed: NewCulture := Configuration.NamedDisplayCulture;
    dcFile: NewCulture := FDisplayCulture;
    else
    begin
      Assert(False);
      NewCulture := TFieldedTextLocaleSettings.Invariant;
    end;
  end;

  Result := FDisplayCulture.Id <> NewCulture.Id;

  if Result then
  begin
    FDisplayCulture := NewCulture;
  end;
end;

end.
