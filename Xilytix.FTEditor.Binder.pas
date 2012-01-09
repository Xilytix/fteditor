// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.Binder;

interface

uses
  Classes,
  Variants,
  SysUtils,
  Controls,
  StdCtrls,
  ComCtrls,
  TypInfo,
  Rtti,
  Xilytix.FieldedText.Utils,
//  Xilytix.FieldedText.BaseField,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.Configuration;

type

  TBinder = class
  public
    type
      TPropertyId =
      (
        // Main
        piCultureName,
        piDelimiterChar,
        piQuoteChar,
        piLineCommentChar,
        piEndOfLineChar,
        piSubstitutionChar,
        piHeadingPadChar,
        piHeadingTruncateChar,
        piHeadingEndOfValueChar,

        piIgnoreBlankLines,
        piAllowEndOfLineInQuotes,
        piStuffedEmbeddedQuotes,
        piIgnoreExtraChars,
        piHeadingAlwaysWriteOptionalQuote,
        piHeadingWritePrefixSpace,
        piSubstitutionsEnabled,
        piDeclared,

        piHeadingLineCount,
        piMainHeadingLineIndex,

        piNewBooleanFieldFalseText,
        piNewBooleanFieldTrueText,
        piNewIntegerFieldFormat,
        piNewFloatFieldFormat,
        piNewDateTimeFieldFormat,
        piNewDecimalFieldFormat,

        piNewBooleanFieldStyles,
        piNewIntegerFieldStyles,
        piNewFloatFieldStyles,
        piNewDateTimeFieldStyles,
        piNewDecimalFieldStyles,

        piEndOfLineType,
        piEndOfLineAutoWriteType,

        piHeadingConstraint,
        piHeadingQuotedType,
        piHeadingPadAlignment,
        piHeadingPadCharType,
        piHeadingTruncateType,

        piSubstitutionType,
        piSubstitutionToken,
        piSubstitutionValue,

        piMetaReferenceType,
        piMetaReference,

        // BaseField
        piName,
        piId,
        piFieldHeadings,
        piFieldHeadingConstraint,
        piConstant,
        piNull,
        piFixedWidth,

        piValueQuotedType,
        piValueAlwaysWriteOptionalQuote,
        piValueWritePrefixSpace,
        piFieldHeadingQuotedType,
        piFieldHeadingAlwaysWriteOptionalQuote,
        piFieldHeadingWritePrefixSpace,

        piWidth,
        piValuePadCharType,
        piValuePadAlignment,
        piValuePadChar,
        piValueEndOfValueChar,
        piValueTruncateType,
        piValueTruncateChar,
        piValueNullChar,
        piFieldHeadingPadCharType,
        piFieldHeadingPadAlignment,
        piFieldHeadingPadChar,
        piFieldHeadingEndOfValueChar,
        piFieldHeadingTruncateType,
        piFieldHeadingTruncateChar,

        // Standard Fields
        piStringValue,

        piBooleanValue,
        piFalseText,
        piTrueText,
        piBooleanStyles,

        piNumberFormat,
        piNumberStyles,
        piIntegerValue,
        piFloatValue,
        piDecimalValue,

        piDateTimeFormat,
        piDateTimeValue,
        piDateTimeStyles,

        // Sequence Fields
        piSequenceName,
        piIsRoot,

        // Sequence Item Fields
        piSequenceItemField,

        // Sequence Redirect Fields
        piRedirectSequence,
        piRedirectValue,
        piRedirectInvokationDelay
      );

      TErrorCountChangeDelegate = procedure of object;
      TFieldCaptionChangeDelegate = procedure of object;
      TSequenceCaptionChangeDelegate = procedure of object;

  strict private
    type
      TControlTag = class
      private
        FPropertyId: TPropertyId;
        FError: Boolean;
      public
        constructor Create(myPropertyId: TPropertyId);
        property PropertyId: TPropertyId read FPropertyId;
        property Error: Boolean read FError write FError;
      end;

      TPropertyRec = record
        Id: TPropertyId;
        Cat: TEditEngine.TPropertyCategory;
        Name: string;
        CatRefresh: Boolean;
        FullRefresh: Boolean;
        ForceRefresh: Boolean;
        CaptionChange: Boolean;
      end;
      TPropertyArray = array[TPropertyId] of TPropertyRec;

      TPropertyTypeInfoArray = array[TPropertyId] of PTypeInfo;

      TErrorCountChangeDelegates = array of TErrorCountChangeDelegate;
      TFieldCaptionChangeDelegates = array of TFieldCaptionChangeDelegate;
      TSequenceCaptionChangeDelegates = array of TSequenceCaptionChangeDelegate;

    const
      PropArray: TPropertyArray =
      (
        // Main
        (Id: piCultureName; Cat: pcMainMeta; FullRefresh: True),
        (Id: piDelimiterChar; Cat: pcMainMeta),
        (Id: piQuoteChar; Cat: pcMainMeta),
        (Id: piLineCommentChar; Cat: pcMainMeta),
        (Id: piEndOfLineChar; Cat: pcMainMeta),
        (Id: piSubstitutionChar; Cat: pcMainMeta),
        (Id: piHeadingPadChar; Cat: pcMainMeta; ForceRefresh: True),
        (Id: piHeadingTruncateChar; Cat: pcMainMeta; ForceRefresh: True),
        (Id: piHeadingEndOfValueChar; Cat: pcMainMeta; ForceRefresh: True),

        (Id: piIgnoreBlankLines; Cat: pcMainMeta),
        (Id: piAllowEndOfLineInQuotes; Cat: pcMainMeta),
        (Id: piStuffedEmbeddedQuotes; Cat: pcMainMeta),
        (Id: piIgnoreExtraChars; Cat: pcMainMeta),
        (Id: piHeadingAlwaysWriteOptionalQuote; Cat: pcMainMeta; ForceRefresh: True),
        (Id: piHeadingWritePrefixSpace; Cat: pcMainMeta; ForceRefresh: True),
        (Id: piSubstitutionsEnabled; Cat: pcMainMeta),
        (Id: piDeclared; Cat: pcMainText),

        (Id: piHeadingLineCount; Cat: pcMainMeta; FullRefresh: True),
        (Id: piMainHeadingLineIndex; Cat: pcMainMeta; FullRefresh: True),

        (Id: piNewBooleanFieldFalseText; Cat: pcMainMeta),
        (Id: piNewBooleanFieldTrueText; Cat: pcMainMeta),
        (Id: piNewIntegerFieldFormat; Cat: pcMainMeta),
        (Id: piNewFloatFieldFormat; Cat: pcMainMeta),
        (Id: piNewDateTimeFieldFormat; Cat: pcMainMeta),
        (Id: piNewDecimalFieldFormat; Cat: pcMainMeta),

        (Id: piNewBooleanFieldStyles; Cat: pcMainMeta),
        (Id: piNewIntegerFieldStyles; Cat: pcMainMeta),
        (Id: piNewFloatFieldStyles; Cat: pcMainMeta),
        (Id: piNewDateTimeFieldStyles; Cat: pcMainMeta),
        (Id: piNewDecimalFieldStyles; Cat: pcMainMeta),

        (Id: piEndOfLineType; Cat: pcMainMeta),
        (Id: piEndOfLineAutoWriteType; Cat: pcMainMeta),

        (Id: piHeadingConstraint; Cat: pcMainMeta; ForceRefresh: True),
        (Id: piHeadingQuotedType; Cat: pcMainMeta; ForceRefresh: True),
        (Id: piHeadingPadAlignment; Cat: pcMainMeta; ForceRefresh: True),
        (Id: piHeadingPadCharType; Cat: pcMainMeta; ForceRefresh: True),
        (Id: piHeadingTruncateType; Cat: pcMainMeta; ForceRefresh: True),

        (Id: piSubstitutionType; Cat: pcSubstitution; Name: 'SubType'),
        (Id: piSubstitutionToken; Cat: pcSubstitution; Name: 'Token'),
        (Id: piSubstitutionValue; Cat: pcSubstitution; Name: 'Value'),

        (Id: piMetaReferenceType; Cat: pcMainText; CatRefresh: True),
        (Id: piMetaReference; Cat: pcMainText),

        // Base Field
        (Id: piName; Cat: pcField; FullRefresh: True; CaptionChange: True),
        (Id: piId; Cat: pcField),
        (Id: piFieldHeadings; Cat: pcField; Name: 'HeadingsAsCommaText'),
        (Id: piFieldHeadingConstraint; Cat: pcField; Name: 'HeadingConstraint'),
        (Id: piConstant; Cat: pcField; ForceRefresh: True),
        (Id: piNull; Cat: pcField; ForceRefresh: True),
        (Id: piFixedWidth; Cat: pcField; CatRefresh: True),

        (Id: piValueQuotedType; Cat: pcField),
        (Id: piValueAlwaysWriteOptionalQuote; Cat: pcField),
        (Id: piValueWritePrefixSpace; Cat: pcField),
        (Id: piFieldHeadingQuotedType; Cat: pcField; Name: 'HeadingQuotedType'),
        (Id: piFieldHeadingAlwaysWriteOptionalQuote; Cat: pcField; Name: 'HeadingAlwaysWriteOptionalQuote'),
        (Id: piFieldHeadingWritePrefixSpace; Cat: pcField; Name: 'HeadingWritePrefixSpace'),

        (Id: piWidth; Cat: pcField),
        (Id: piValuePadCharType; Cat: pcField),
        (Id: piValuePadAlignment; Cat: pcField),
        (Id: piValuePadChar; Cat: pcField),
        (Id: piValueEndOfValueChar; Cat: pcField),
        (Id: piValueTruncateType; Cat: pcField),
        (Id: piValueTruncateChar; Cat: pcField),
        (Id: piValueNullChar; Cat: pcField),
        (Id: piFieldHeadingPadCharType; Cat: pcField; Name: 'HeadingPadCharType'),
        (Id: piFieldHeadingPadAlignment; Cat: pcField; Name: 'HeadingPadAlignment'),
        (Id: piFieldHeadingPadChar; Cat: pcField; Name: 'HeadingPadChar'),
        (Id: piFieldHeadingEndOfValueChar; Cat: pcField; Name: 'HeadingEndOfValueChar'),
        (Id: piFieldHeadingTruncateType; Cat: pcField; Name: 'HeadingTruncateType'),
        (Id: piFieldHeadingTruncateChar; Cat: pcField; Name: 'HeadingTruncateChar'),

        // Standard Fields
        (Id: piStringValue; Cat: pcField; Name: 'Value'),

        (Id: piBooleanValue; Cat: pcField; Name: 'Value'),
        (Id: piFalseText; Cat: pcField),
        (Id: piTrueText; Cat: pcField),
        (Id: piBooleanStyles; Cat: pcField; Name: 'Styles'),

        (Id: piNumberFormat; Cat: pcField; Name: 'Format'),
        (Id: piNumberStyles; Cat: pcField; Name: 'Styles'),
        (Id: piIntegerValue; Cat: pcField; Name: 'Value'),
        (Id: piFloatValue; Cat: pcField; Name: 'Value'),
        (Id: piDecimalValue; Cat: pcField; Name: 'AsObject'),

        (Id: piDateTimeFormat; Cat: pcField; Name: 'Format'),
        (Id: piDateTimeValue; Cat: pcField; Name: 'Value'),
        (Id: piDateTimeStyles; Cat: pcField; Name: 'Styles'),

        // Sequence Fields
        (Id: piSequenceName; Cat: pcSequence; Name: 'Name'; CatRefresh: True; CaptionChange: True),
        (Id: piIsRoot; Cat: pcSequence; CatRefresh: True),

        // Sequence Item Fields
        (Id: piSequenceItemField; Cat: pcSequence; Name: 'Field'; CaptionChange: True),

        // Sequence Redirect Fields
        (Id: piRedirectSequence; Cat: pcSequence; Name: 'Sequence'),
        (Id: piRedirectValue; Cat: pcSequence; Name: 'Value'),
        (Id: piRedirectInvokationDelay; Cat: pcSequence; Name: 'InvokationDelay')
      );

    class constructor Create;

    class var
      PropertyTypeInfoArray: TPropertyTypeInfoArray;

    var
      FEditEngine: TEditEngine;

      FConfigurationChanged: Boolean;

      FErrorCount: Integer;

      FErrorCountChangeDelegates: TErrorCountChangeDelegates;
      FFieldCaptionChangeDelegates: TFieldCaptionChangeDelegates;
      FSsirCaptionChangeDelegates: TSequenceCaptionChangeDelegates;

    procedure NotifyErrorCountChange;
    procedure NotifyFieldCaptionChange;
    procedure NotifySsirCaptionChange;

    procedure ClearEditError(edit: TEdit);
    procedure SetEditError(edit: TEdit);

    function CheckRefresh(id: TPropertyId; modified: Boolean): Boolean;

    function CalculateDisplayCharEncoding: TEncoding;
    function CharToDisplayHex(value: Char): string;
    function TryDisplayHexToChar(hexStr: string; out value: Char): Boolean;
    function CharToDisplayDecimal(value: Char): string;
    function TryDisplayDecimalToChar(const decimalStr: string; out value: Char): Boolean;
    function IsViewableChar(value: Char): Boolean;
    function TryCalculateNonViewableCharFormat(const value: string;
                                               out format: TNonViewableCharFormat;
                                               out hexDecValue: string): Boolean;
    function FormatNonViewableChar(value: Char; format: TNonViewableCharFormat): string;
    function TryParseNonViewableCharDisplay(const display: string; out value: Char): Boolean;

    function TryParseCommaTextDisplay(const display: string): Boolean;
    function TryParseIntegerDisplay(const display: string; out value: Integer): Boolean;
    function TryParseInt64Display(const display: string; out value: Int64): Boolean;
    function TryParseDoubleDisplay(const display: string; out value: Double): Boolean;
    function TryParseCurrencyDisplay(const display: string; out value: Currency): Boolean;

    function TryParseNumberStylesDisplay(const display: string; out value: TDotNetNumberStyles): Boolean;
    function TryParseDateTimeStylesDisplay(const display: string; out value: TDotNetDateTimeStyles): Boolean;
    function TryParseBooleanStylesDisplay(const display: string; out value: TBooleanStyles): Boolean;

    function GetPropertyName(id: TPropertyId): string;
    function GetCharValue(id: TPropertyId; idx: Integer): Char;

    function GetPropertyValue(id: TPropertyId; idx: Integer): TValue; overload;
    function GetSequenceItemPropertyValue(id: TPropertyId; sequenceItem: TFieldedText.TSequence.TItem): TValue; overload;
    function GetRedirectPropertyValue(id: TPropertyId; redirect: TFieldedText.TSequenceRedirect): TValue; overload;

    procedure SaveCharEdit(edit: TEdit; idx: Integer); overload;
    procedure SaveStringEdit(edit: TEdit; idx: Integer); overload;
    procedure SaveIntegerEdit(edit: TEdit; idx: Integer);
    procedure SaveInt64Edit(edit: TEdit; idx: Integer); overload;
    procedure SaveDoubleEdit(edit: TEdit; idx: Integer); overload;
    procedure SaveCurrencyEdit(edit: TEdit; idx: Integer); overload;

    procedure SaveStringEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect); overload;
    procedure SaveInt64Edit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect); overload;
    procedure SaveDoubleEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect); overload;
    procedure SaveDecimalEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect); overload;

  public
    constructor Create(myEditEngine: TEditEngine);

    property ConfigurationChanged: Boolean read FConfigurationChanged write FConfigurationChanged;

    procedure ClearEdit(edit: TEdit);
    procedure SetEditWarning(edit: TEdit);
    procedure ClearEditWarning(edit: TEdit);

    function EditNumberStyles(formOwner: TComponent; asString: string; fallback, default: TDotNetNumberStyles; out NewValue: string): Boolean;
    function EditDateTimeStyles(formOwner: TComponent; asString: string; fallback, default: TDotNetDateTimeStyles; out NewValue: string): Boolean;
    function EditBooleanStyles(formOwner: TComponent; asString: string; fallback, default: TBooleanStyles; out NewValue: string): Boolean;

    procedure LoadStringEdit(edit: TEdit; idx: Integer);
    procedure HandleStringEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleStringEditExit(edit: TEdit; idx: Integer);

    procedure LoadCommaTextEdit(edit: TEdit; idx: Integer);
    procedure SaveCommaTextEdit(edit: TEdit; idx: Integer);
    procedure HandleCommaTextEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleCommaTextEditExit(edit: TEdit; idx: Integer);

    procedure LoadRedirectStringEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
    procedure HandleRedirectStringEditKeyPress(edit: TEdit; redirect: TFieldedText.TSequenceRedirect; var key: Char);
    procedure HandleRedirectStringEditExit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);

    procedure LoadCharEdit(edit: TEdit; idx: Integer; value: Char); overload;
    procedure LoadCharEdit(edit: TEdit; idx: Integer); overload;
    function SaveCharEdit(edit: TEdit; out value: Char): Boolean; overload;

    procedure HandleCharEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleCharEditExit(edit: TEdit; idx: Integer);

    procedure LoadIntegerEdit(edit: TEdit; idx: Integer);
    procedure HandleIntegerEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleIntegerEditExit(edit: TEdit; idx: Integer);

    procedure LoadInt64Edit(edit: TEdit; idx: Integer);
    procedure HandleInt64EditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleInt64EditExit(edit: TEdit; idx: Integer);

    procedure LoadRedirectInt64Edit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
    procedure HandleRedirectInt64EditKeyPress(edit: TEdit; redirect: TFieldedText.TSequenceRedirect; var key: Char);
    procedure HandleRedirectInt64EditExit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);

    procedure LoadDoubleEdit(edit: TEdit; idx: Integer);
    procedure HandleDoubleEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleDoubleEditExit(edit: TEdit; idx: Integer);

    procedure LoadRedirectDoubleEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
    procedure HandleRedirectDoubleEditKeyPress(edit: TEdit; redirect: TFieldedText.TSequenceRedirect; var key: Char);
    procedure HandleRedirectDoubleEditExit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);

    procedure LoadCurrencyEdit(edit: TEdit; idx: Integer);
    procedure HandleDecimalEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleDecimalEditExit(edit: TEdit; idx: Integer);

    procedure LoadRedirectCurrencyEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
    procedure HandleRedirectDecimalEditKeyPress(edit: TEdit; redirect: TFieldedText.TSequenceRedirect; var key: Char);
    procedure HandleRedirectDecimalEditExit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);

    procedure LoadNumberStylesEdit(edit: TEdit; idx: Integer);
    procedure SaveNumberStylesEdit(edit: TEdit; idx: Integer; default: TDotNetNumberStyles);
    procedure HandleNumberStylesEditKeyPress(edit: TEdit; idx: Integer; default: TDotNetNumberStyles; var key: Char);

    procedure LoadDateTimeStylesEdit(edit: TEdit; idx: Integer);
    procedure SaveDateTimeStylesEdit(edit: TEdit; idx: Integer; default: TDotNetDateTimeStyles);
    procedure HandleDateTimeStylesEditKeyPress(edit: TEdit; idx: Integer; default: TDotNetDateTimeStyles; var key: Char);

    procedure LoadBooleanStylesEdit(edit: TEdit; idx: Integer);
    procedure SaveBooleanStylesEdit(edit: TEdit; idx: Integer; default: TBooleanStyles);
    procedure HandleBooleanStylesEditKeyPress(edit: TEdit; idx: Integer; default: TBooleanStyles; var key: Char);

    procedure LoadCultureEdit(edit: TEdit; idx: Integer);
    procedure SaveCultureEdit(edit: TEdit; idx: Integer);

    procedure LoadCheckBox(checkBox: TCheckBox; idx: Integer);
    procedure HandleCheckBoxClick(checkBox: TCheckBox; idx: Integer);
    procedure LoadRedirectCheckBox(checkBox: TCheckBox; redirect: TFieldedText.TSequenceRedirect);
    procedure HandleRedirectCheckBoxClick(checkBox: TCheckBox; redirect: TFieldedText.TSequenceRedirect);

    procedure LoadRadioButton(radioButton: TRadioButton; idx: Integer);
    procedure HandleRadioButtonClick(radioButton: TRadioButton; idx: Integer);

    procedure LoadDateTimePickers(datePicker, timePicker: TDateTimePicker; idx: Integer);
    procedure SaveDateTimePickers(datePicker, timePicker: TDateTimePicker; idx: Integer);

    procedure LoadRedirectDateTimePickers(datePicker, timePicker: TDateTimePicker; redirect: TFieldedText.TSequenceRedirect);
    procedure SaveRedirectDateTimePickers(datePicker, timePicker: TDateTimePicker; redirect: TFieldedText.TSequenceRedirect);

    procedure LoadComboBox(comboBox: TComboBox; idx: Integer);
    procedure HandleComboBoxChange(comboBox: TComboBox; idx: Integer);

    procedure LoadRedirectComboBox(comboBox: TComboBox; redirect: TFieldedText.TSequenceRedirect);
    procedure HandleRedirectComboBoxChange(comboBox: TComboBox; redirect: TFieldedText.TSequenceRedirect);

    procedure SetSequenceItemField(sequenceItem: TFieldedText.TSequence.TItem; value: TObject);
    procedure SetRedirectSequence(redirect: TFieldedText.TSequenceRedirect; value: TObject);

    class procedure PrepareEndOfLineTypeComboBox(comboBox: TComboBox; id: TPropertyId);
    class procedure PrepareEndOfLineAutoWriteTypeComboBox(comboBox: TComboBox; id: TPropertyId);
    class procedure PrepareHeadingConstraintComboBox(comboBox: TComboBox; id: TPropertyId);
    class procedure PrepareQuotedTypeComboBox(comboBox: TComboBox; id: TPropertyId);
    class procedure PreparePadAlignmentComboBox(comboBox: TComboBox; id: TPropertyId);
    class procedure PreparePadCharTypeComboBox(comboBox: TComboBox; id: TPropertyId);
    class procedure PrepareTruncateTypeComboBox(comboBox: TComboBox; id: TPropertyId);
    class procedure PrepareMetaReferenceTypeComboBox(comboBox: TComboBox; id: TPropertyId);

    class procedure PrepareRedirectInvokationDelayComboBox(comboBox: TComboBox; id: TPropertyId);

    class function TagToPropertyId(value: Integer): TPropertyId;
    class function CreateControlTag(value: TPropertyId): Integer;

    function GetPropertyValue(control: TWinControl; idx: Integer): TValue; overload;
    procedure SetPropertyValue(id: TPropertyId; idx: Integer; const value: TValue; out modified: Boolean);

    function GetSequenceItemPropertyValue(control: TWinControl; sequenceItem: TFieldedText.TSequence.TItem): TValue; overload;
    procedure SetSequenceItemPropertyValue(id: TPropertyId; sequenceItem: TFieldedText.TSequence.TItem; const value: TValue;
                                           out modified: Boolean);

    function GetRedirectPropertyValue(control: TWinControl; redirect: TFieldedText.TSequenceRedirect): TValue; overload;
    procedure SetRedirectPropertyValue(id: TPropertyId; redirect: TFieldedText.TSequenceRedirect; const value: TValue;
                                       out modified: Boolean);

    procedure SubscribeErrorCountChangeEvent(Delegate: TErrorCountChangeDelegate);
    procedure UnsubscribeErrorCountChangeEvent(Delegate: TErrorCountChangeDelegate);
    procedure SubscribeFieldCaptionChangeEvent(Delegate: TFieldCaptionChangeDelegate);
    procedure UnsubscribeFieldCaptionChangeEvent(Delegate: TFieldCaptionChangeDelegate);
    procedure SubscribeSsirCaptionChangeEvent(Delegate: TSequenceCaptionChangeDelegate);
    procedure UnsubscribeSsirCaptionChangeEvent(Delegate: TSequenceCaptionChangeDelegate);
  end;

implementation

uses
  Math,
  Character,
  Xilytix.FieldedText.CommaText,
  Xilytix.FTEditor.Common,
  Xilytix.FTEditor.Colors,
  Xilytix.FTEditor.NumberStylesForm,
  Xilytix.FTEditor.BooleanStylesForm;

{ Binder }

procedure TBinder.SaveCharEdit(edit: TEdit; idx: Integer);
var
  Id: TPropertyId;
  Value: Char;
  Modified: Boolean;
begin
  if SaveCharEdit(edit, Value) then
  begin
    Id := TagToPropertyId(edit.Tag);
    SetPropertyValue(Id, idx, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadCharEdit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveBooleanStylesEdit(edit: TEdit; idx: Integer; default: TBooleanStyles);
var
  Text: string;
  Error: Boolean;
  Id: TPropertyId;
  Styles: TBooleanStyles;
  Value: TValue;
  Modified: Boolean;
begin
  Text := edit.Text;
  if Text <> '' then
    Error := not TryParseBooleanStylesDisplay(Text, Styles)
  else
  begin
    Styles := default;
    Error := False;
  end;

  if Error then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    Value := TValue.From<TBooleanStyles>(Styles);
    SetPropertyValue(Id, idx, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadBooleanStylesEdit(edit, idx);
    end;
  end;
end;

function TBinder.SaveCharEdit(edit: TEdit; out value: Char): Boolean;
var
  DisplayValue: string;
begin
  DisplayValue := edit.Text;
  if Length(DisplayValue) = 1 then
  begin
    Value := DisplayValue[1];
    Result := True;
  end
  else
  begin
    if Length(DisplayValue) = 0 then
    begin
      Value := #0;
      Result := False;
    end
    else
    begin
      Result := TryParseNonViewableCharDisplay(DisplayValue, Value);
    end;
  end;

  if not Result then
  begin
    SetEditError(edit);
  end;
end;

procedure TBinder.SaveCommaTextEdit(edit: TEdit; idx: Integer);
var
  Id: TPropertyId;
  Value: string;
  Modified: Boolean;
begin
  Value := Edit.Text;
  if not TryParseCommaTextDisplay(Value) then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetPropertyValue(Id, idx, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadStringEdit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveCultureEdit(edit: TEdit; idx: Integer);
var
  Id: TPropertyId;
  Modified: Boolean;
begin
  Id := TagToPropertyId(edit.Tag);
  SetPropertyValue(Id, idx, edit.Text, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadCultureEdit(edit, idx);
  end;
end;

procedure TBinder.SaveDateTimePickers(datePicker, timePicker: TDateTimePicker; idx: Integer);
var
  Id: TPropertyId;
  Value: TDateTime;
  Modified: Boolean;
begin
  Id := TagToPropertyId(datePicker.Tag);
  Value := datePicker.Date + datePicker.Time;
  SetPropertyValue(Id, idx, Value, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadDateTimePickers(datePicker, timePicker, idx);
  end;
end;

procedure TBinder.SaveDateTimeStylesEdit(edit: TEdit; idx: Integer; default: TDotNetDateTimeStyles);
var
  Text: string;
  Error: Boolean;
  Id: TPropertyId;
  Styles: TDotNetDateTimeStyles;
  Value: TValue;
  Modified: Boolean;
begin
  Text := edit.Text;
  if Text <> '' then
    Error := not TryParseDateTimeStylesDisplay(Text, Styles)
  else
  begin
    Styles := default;
    Error := False;
  end;

  if Error then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    Value := TValue.From<TDotNetDateTimeStyles>(Styles);
    SetPropertyValue(Id, idx, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadDateTimeStylesEdit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveDecimalEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
var
  Id: TPropertyId;
  CurrencyValue: Currency;
  Value: TValue;
  Modified: Boolean;
begin
  if not TryParseCurrencyDisplay(edit.Text, CurrencyValue) then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    Value := TValue.From<Currency>(CurrencyValue);
    SetRedirectPropertyValue(Id, redirect, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadRedirectCurrencyEdit(edit, redirect);
    end;
  end;
end;

procedure TBinder.SaveCurrencyEdit(edit: TEdit; idx: Integer);
var
  Id: TPropertyId;
  CurrencyValue: Currency;
  Value: TValue;
  Modified: Boolean;
begin
  if not TryParseCurrencyDisplay(edit.Text, CurrencyValue) then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);

    Value := TValue.From<Currency>(CurrencyValue);
    SetPropertyValue(Id, idx, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadCurrencyEdit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveDoubleEdit(edit: TEdit; idx: Integer);
var
  Id: TPropertyId;
  Value: Double;
  Modified: Boolean;
begin
  if not TryParseDoubleDisplay(edit.Text, Value) then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetPropertyValue(Id, idx, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadDoubleEdit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveInt64Edit(edit: TEdit; idx: Integer);
var
  Id: TPropertyId;
  Value: Int64;
  Modified: Boolean;
begin
  if not TryParseInt64Display(edit.Text, Value) then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetPropertyValue(Id, idx, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadInt64Edit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveInt64Edit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
var
  Id: TPropertyId;
  Value: Int64;
  Modified: Boolean;
begin
  if not TryParseInt64Display(edit.Text, Value) then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetRedirectPropertyValue(Id, redirect, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadRedirectInt64Edit(edit, redirect);
    end;
  end;
end;

procedure TBinder.SaveIntegerEdit(edit: TEdit; idx: Integer);
var
  Id: TPropertyId;
  Value: Integer;
  Modified: Boolean;
begin
  if not TryParseIntegerDisplay(edit.Text, Value) then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetPropertyValue(Id, idx, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadIntegerEdit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveNumberStylesEdit(edit: TEdit; idx: Integer; default: TDotNetNumberStyles);
var
  Text: string;
  Error: Boolean;
  Id: TPropertyId;
  Styles: TDotNetNumberStyles;
  Value: TValue;
  Modified: Boolean;
begin
  Text := edit.Text;
  if Text <> '' then
    Error := not TryParseNumberStylesDisplay(Text, Styles)
  else
  begin
    Styles := default;
    Error := False;
  end;

  if Error then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    Value := TValue.From<TDotNetNumberStyles>(Styles);
    SetPropertyValue(Id, idx, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadNumberStylesEdit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveRedirectDateTimePickers(datePicker, timePicker: TDateTimePicker;
  redirect: TFieldedText.TSequenceRedirect);
var
  Id: TPropertyId;
  Value: TDateTime;
  Modified: Boolean;
begin
  Id := TagToPropertyId(datePicker.Tag);
  Value := datePicker.DateTime;
  SetRedirectPropertyValue(Id, redirect, Value, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadRedirectDateTimePickers(datePicker, timePicker, redirect);
  end;
end;

procedure TBinder.SaveStringEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
var
  Id: TPropertyId;
  Modified: Boolean;
begin
  Id := TagToPropertyId(edit.Tag);
  SetRedirectPropertyValue(Id, redirect, edit.Text, Modified);

  if not CheckRefresh(Id, Modified) then
  begin
    LoadRedirectStringEdit(edit, redirect);
  end;
end;

procedure TBinder.SaveStringEdit(edit: TEdit; idx: Integer);
var
  Id: TPropertyId;
  Modified: Boolean;
begin
  Id := TagToPropertyId(edit.Tag);
  SetPropertyValue(Id, idx, edit.Text, Modified);

  if not CheckRefresh(Id, Modified) then
  begin
    LoadStringEdit(edit, idx);
  end;
end;

function TBinder.CalculateDisplayCharEncoding: TEncoding;
begin
  case Configuration.DisplayCharEncodingType of
    deAscii: Result := TEncoding.ASCII;
    deUtf8: Result := TEncoding.UTF8;
    deNamed: Result := Configuration.NamedDisplayCharEncoding;
    deFile: Result := FEditEngine.TextCharEncoding;
    else
    begin
      Assert(False);
      Result := TEncoding.UTF8;
    end;
  end;
end;

class function TBinder.TagToPropertyId(value: Integer): TPropertyId;
begin
  Result := TControlTag(value).PropertyId;
end;

function TBinder.TryCalculateNonViewableCharFormat(const value: string;
                                                   out format: TNonViewableCharFormat;
                                                   out hexDecValue: string): Boolean;
begin
  Result := True;
  if Length(value) < 2 then
    Result := False
  else
  begin
    case value[1] of
      '0':
      begin
        if (Length(value) = 2) or (TCharacter.ToUpper(value[2]) <> 'X') then
          Result := False
        else
        begin
          format := nv0xHex;
          hexDecValue := Copy(value, 3, MaxInt);
        end
      end;
      '$':
      begin
        format := nvDollarHex;
        hexDecValue := Copy(value, 2, MaxInt);
      end;
      '#':
      begin
        if (Length(value) = 2) or (value[2] <> '$') then
        begin
          format := nvHashDecimal;
          hexDecValue := Copy(value, 2, MaxInt);
        end
        else
        begin
          if Length(value) < 3 then
            Result := False
          else
          begin
            format := nvHashDollarHex;
            hexDecValue := Copy(value, 3, MaxInt);
          end;
        end;
      end;
      else Result := False;
    end;
  end;
end;

function TBinder.CharToDisplayDecimal(value: Char): string;
var
  Culture: TFieldedTextLocaleSettings;
  CharEncoding: TEncoding;
  Bytes: TBytes;
  ResultDouble: Double;
  ResultInt64: Int64;
  I: Integer;
begin
  Culture := FEditEngine.DisplayCulture;
  CharEncoding := CalculateDisplayCharEncoding;
  Bytes := CharEncoding.GetBytes(value);
  ResultDouble := 0;
  for I := Low(Bytes) to High(Bytes) do
  begin
    ResultDouble := ResultDouble + ResultDouble * Math.IntPower(256.0, I);
  end;
  ResultInt64 := Round(ResultDouble);
  Result := Culture.IntToStr(ResultInt64);
end;

function TBinder.CharToDisplayHex(value: Char): string;
var
  CharEncoding: TEncoding;
  Bytes: TBytes;
  ResultBuilder: TStringBuilder;
  I: Integer;
begin
  CharEncoding := CalculateDisplayCharEncoding;
  Bytes := CharEncoding.GetBytes(value);
  ResultBuilder := TStringBuilder.Create;
  for I := Low(Bytes) to High(Bytes) do
  begin
    ResultBuilder.Append(IntToHex(Bytes[I], 2));
  end;
  Result := ResultBuilder.ToString;
end;

function TBinder.CheckRefresh(id: TPropertyId; modified: Boolean): Boolean;

  procedure CheckCaptionChange;
  begin
    if PropArray[Id].CaptionChange then
    begin
      case PropArray[Id].Cat of
        pcField: NotifyFieldCaptionChange;
        pcSequence: NotifySsirCaptionChange;
        else Assert(False);
      end;
    end;
  end;

begin
  if PropArray[Id].ForceRefresh then
  begin
    CheckCaptionChange;
    FEditEngine.RefreshControls;
    Result := True;
  end
  else
  begin
    if not modified then
      Result := False
    else
    begin
      CheckCaptionChange;

      if PropArray[Id].FullRefresh then
      begin
        FEditEngine.RefreshControls;
        Result := True;
      end
      else
      begin
        if not PropArray[Id].CatRefresh then
          Result := False
        else
        begin
          FEditEngine.RefreshControls(PropArray[Id].Cat);
          Result := True;
        end;
      end;
    end;
  end;
end;

procedure TBinder.ClearEdit(edit: TEdit);
begin
  ClearEditError(edit);
  edit.Text := '';
end;

procedure TBinder.ClearEditError(edit: TEdit);
begin
  if FConfigurationChanged or TControlTag(edit.Tag).Error then
  begin
    edit.Color := Configuration.Colors[rcControlOk].Background;
    edit.Font.Color := Configuration.Colors[rcControlOk].Font;
    edit.Font.Style := Configuration.Colors[rcControlOk].FontStyles;
    TControlTag(edit.Tag).Error := False;
    Dec(FErrorCount);
    if not FConfigurationChanged then
    begin
      NotifyErrorCountChange;
    end;
  end;
end;

procedure TBinder.ClearEditWarning(edit: TEdit);
begin
  if not TControlTag(edit.Tag).Error then
  begin
    edit.Color := Configuration.Colors[rcControlOk].Background;
    edit.Font.Color := Configuration.Colors[rcControlOk].Font;
    edit.Font.Style := Configuration.Colors[rcControlOk].FontStyles;
  end;
end;

class constructor TBinder.Create;
var
  PropId: TPropertyId;
begin
  for PropId := Low(PropArray) to High(PropArray) do
  begin
    if PropArray[PropId].Id <> PropId then
    begin
      raise Exception.Create('PropArray out of order');
    end;

    case PropId of
      piCultureName: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piDelimiterChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piQuoteChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piLineCommentChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piEndOfLineChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piSubstitutionChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piHeadingPadChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piHeadingTruncateChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piHeadingEndOfValueChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piIgnoreBlankLines: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piAllowEndOfLineInQuotes: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piStuffedEmbeddedQuotes: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piIgnoreExtraChars: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piHeadingAlwaysWriteOptionalQuote: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piHeadingWritePrefixSpace: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piSubstitutionsEnabled: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piDeclared: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piHeadingLineCount: PropertyTypeInfoArray[PropId] := TypeInfo(Integer);
      piMainHeadingLineIndex: PropertyTypeInfoArray[PropId] := TypeInfo(Integer);
      piNewBooleanFieldFalseText: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piNewBooleanFieldTrueText: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piNewIntegerFieldFormat: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piNewFloatFieldFormat: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piNewDateTimeFieldFormat: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piNewDecimalFieldFormat: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piNewBooleanFieldStyles: PropertyTypeInfoArray[PropId] := TypeInfo(TBooleanStyles);
      piNewIntegerFieldStyles: PropertyTypeInfoArray[PropId] := TypeInfo(TDotNetNumberStyles);
      piNewFloatFieldStyles: PropertyTypeInfoArray[PropId] := TypeInfo(TDotNetNumberStyles);
      piNewDateTimeFieldStyles: PropertyTypeInfoArray[PropId] := TypeInfo(TDotNetDateTimeStyles);
      piNewDecimalFieldStyles: PropertyTypeInfoArray[PropId] := TypeInfo(TDotNetNumberStyles);
      piEndOfLineType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TEndOfLineType);
      piEndOfLineAutoWriteType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TEndOfLineAutoWriteType);
      piHeadingConstraint: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.THeadingConstraint);
      piHeadingQuotedType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TQuotedType);
      piHeadingPadAlignment: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TPadAlignment);
      piHeadingPadCharType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TPadCharType);
      piHeadingTruncateType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TTruncateType);
      piSubstitutionType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedTextSubstitutionType);
      piSubstitutionToken: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piSubstitutionValue: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piMetaReferenceType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TMetaReferenceType);
      piMetaReference: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piName: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piId: PropertyTypeInfoArray[PropId] := TypeInfo(Integer);
      piFieldHeadings: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piFieldHeadingConstraint: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.THeadingConstraint);
      piConstant: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piNull: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piFixedWidth: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piValueQuotedType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TQuotedType);
      piValueAlwaysWriteOptionalQuote: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piValueWritePrefixSpace: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piFieldHeadingQuotedType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TQuotedType);
      piFieldHeadingAlwaysWriteOptionalQuote: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piFieldHeadingWritePrefixSpace: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piWidth: PropertyTypeInfoArray[PropId] := TypeInfo(Integer);
      piValuePadCharType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TPadCharType);
      piValuePadAlignment: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TPadAlignment);
      piValuePadChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piValueEndOfValueChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piValueTruncateType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TTruncateType);
      piValueTruncateChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piValueNullChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piFieldHeadingPadCharType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TPadCharType);
      piFieldHeadingPadAlignment: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TPadAlignment);
      piFieldHeadingPadChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piFieldHeadingEndOfValueChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piFieldHeadingTruncateType: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TTruncateType);
      piFieldHeadingTruncateChar: PropertyTypeInfoArray[PropId] := TypeInfo(Char);
      piStringValue: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piBooleanValue: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piFalseText: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piTrueText: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piBooleanStyles: PropertyTypeInfoArray[PropId] := TypeInfo(TBooleanStyles);
      piNumberFormat: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piNumberStyles: PropertyTypeInfoArray[PropId] := TypeInfo(TDotNetNumberStyles);
      piIntegerValue: PropertyTypeInfoArray[PropId] := TypeInfo(Integer);
      piFloatValue: PropertyTypeInfoArray[PropId] := TypeInfo(Double);
      piDecimalValue: PropertyTypeInfoArray[PropId] := TypeInfo(Currency);
      piDateTimeFormat: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piDateTimeValue: PropertyTypeInfoArray[PropId] := TypeInfo(TDateTime);
      piDateTimeStyles: PropertyTypeInfoArray[PropId] := TypeInfo(TDotNetDateTimeStyles);
      piSequenceName: PropertyTypeInfoArray[PropId] := TypeInfo(string);
      piIsRoot: PropertyTypeInfoArray[PropId] := TypeInfo(Boolean);
      piSequenceItemField: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TSequence.TItem);
      piRedirectSequence: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TSequence);
      piRedirectValue: PropertyTypeInfoArray[PropId] := nil;
      piRedirectInvokationDelay: PropertyTypeInfoArray[PropId] := TypeInfo(TFieldedText.TSequenceRedirect.TInvokationDelay);
      else raise Exception.Create('Property TypeInfo not set');
    end;
  end;
end;

constructor TBinder.Create(myEditEngine: TEditEngine);
begin
  inherited Create;
  FEditEngine := myEditEngine;
end;

function TBinder.EditBooleanStyles(formOwner: TComponent; asString: string; fallback, default: TBooleanStyles;
  out NewValue: string): Boolean;
var
  Form: TBooleanStylesForm;
begin
  Form := TBooleanStylesForm.Create(formOwner);
  try
    Form.SetAsString(asString, fallBack, default);
    Result := Form.ShowModal = mrOk;
    if Result then
    begin
      NewValue := Form.AsString;
    end;
  finally
    Form.Release;
  end;
end;

function TBinder.EditDateTimeStyles(formOwner: TComponent; asString: string; fallback, default: TDotNetDateTimeStyles;
  out NewValue: string): Boolean;
//var
//  Form: TDateTimeStylesForm;
begin
{  Form := TDateTimeStylesForm.Create(formOwner);
  try
    Form.SetAsString(asString, fallBack, default);
    Result := Form.ShowModal = mrOk;
    if Result then
    begin
      NewValue := Form.AsString;
    end;
  finally
    Form.Release;
  end;}
  Result := False;
end;

function TBinder.EditNumberStyles(formOwner: TComponent; asString: string; fallback, default: TDotNetNumberStyles;
  out NewValue: string): Boolean;
var
  Form: TNumberStylesForm;
begin
  Form := TNumberStylesForm.Create(formOwner);
  try
    Form.SetAsString(asString, fallBack, default);
    Result := Form.ShowModal = mrOk;
    if Result then
    begin
      NewValue := Form.AsString;
    end;
  finally
    Form.Release;
  end;
end;

function TBinder.FormatNonViewableChar(value: Char; format: TNonViewableCharFormat): string;
begin
  case format of
    nv0xHex: Result := '0x' + CharToDisplayHex(value);
    nvHashDecimal: Result := '#' + CharToDisplayDecimal(value);
    nvHashDollarHex: Result := '#$' + CharToDisplayHex(value);
    nvDollarHex: Result := '$' + CharToDisplayHex(value);
    else
    begin
      Assert(False);
      Result := FormatNonViewableChar(value, nv0xHex);
    end;
  end;
end;

function TBinder.GetCharValue(id: TPropertyId; idx: Integer): Char;
var
  Value: TValue;
begin
  Value := GetPropertyValue(id, idx);
  Result := Value.AsType<Char>;
end;

function TBinder.GetPropertyName(id: TPropertyId): string;
begin
  if PropArray[id].Name <> '' then
    Result := PropArray[id].Name
  else
  begin
    Result := GetEnumName(TypeInfo(TPropertyId), Ord(id));
    Result := Copy(Result, 3, MaxInt);
  end;
end;

function TBinder.GetPropertyValue(control: TWinControl; idx: Integer): TValue;
var
  Id: TPropertyId;
begin
  Id := TagToPropertyId(control.Tag);
  Result := GetPropertyValue(Id, idx);
end;

function TBinder.GetRedirectPropertyValue(control: TWinControl; redirect: TFieldedText.TSequenceRedirect): TValue;
var
  Id: TPropertyId;
begin
  Id := TagToPropertyId(control.Tag);
  Result := GetRedirectPropertyValue(Id, redirect);
end;

function TBinder.GetRedirectPropertyValue(id: TPropertyId; redirect: TFieldedText.TSequenceRedirect): TValue;
var
  Name: string;
begin
  Name := GetPropertyName(id);
  Result := FEditEngine.RedirectProperties[Name, redirect];
end;

function TBinder.GetSequenceItemPropertyValue(id: TPropertyId; sequenceItem: TFieldedText.TSequence.TItem): TValue;
var
  Name: string;
begin
  Name := GetPropertyName(id);
  Result := FEditEngine.SequenceItemProperties[Name, sequenceItem];
end;

function TBinder.GetSequenceItemPropertyValue(control: TWinControl; sequenceItem: TFieldedText.TSequence.TItem): TValue;
var
  Id: TPropertyId;
begin
  Id := TagToPropertyId(control.Tag);
  Result := GetSequenceItemPropertyValue(Id, sequenceItem);
end;

function TBinder.GetPropertyValue(id: TPropertyId; idx: Integer): TValue;
var
  Name: string;
  Cat: TEditEngine.TPropertyCategory;
begin
  Name := GetPropertyName(id);
  Cat := PropArray[id].Cat;
  Result := FEditEngine.Properties[Name, idx, Cat];
end;

procedure TBinder.HandleBooleanStylesEditKeyPress(edit: TEdit; idx: Integer; default: TBooleanStyles; var key: Char);
begin
  if Key = #13 then
  begin
    SaveBooleanStylesEdit(edit, idx, default);
    Key := #0;
  end;
end;

procedure TBinder.HandleCharEditExit(edit: TEdit; idx: Integer);
begin
  SaveCharEdit(edit, idx);
end;

procedure TBinder.HandleCharEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
begin
  if Key = #13 then
  begin
    SaveCharEdit(edit, idx);
    Key := #0;
  end;
end;

procedure TBinder.HandleCheckBoxClick(checkBox: TCheckBox; idx: Integer);
var
  Id: TPropertyId;
  Modified: Boolean;
begin
  Id := TagToPropertyId(checkBox.Tag);
  SetPropertyValue(Id, idx, checkBox.Checked, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadCheckBox(checkBox, idx);
  end;
end;

procedure TBinder.HandleDateTimeStylesEditKeyPress(edit: TEdit; idx: Integer; default: TDotNetDateTimeStyles; var key: Char);
begin
  if Key = #13 then
  begin
    SaveDateTimeStylesEdit(edit, idx, default);
    Key := #0;
  end;
end;

procedure TBinder.HandleDecimalEditExit(edit: TEdit; idx: Integer);
begin
  SaveCurrencyEdit(edit, idx);
end;

procedure TBinder.HandleDecimalEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
begin
  if Key = #13 then
  begin
    SaveCurrencyEdit(edit, idx);
    Key := #0;
  end;
end;

procedure TBinder.HandleDoubleEditExit(edit: TEdit; idx: Integer);
begin
  SaveDoubleEdit(edit, idx);
end;

procedure TBinder.HandleDoubleEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
begin
  if Key = #13 then
  begin
    SaveDoubleEdit(edit, idx);
    Key := #0;
  end;
end;

procedure TBinder.HandleComboBoxChange(comboBox: TComboBox; idx: Integer);
var
  ItemIndex: Integer;
  Id: TPropertyId;
  ComboBoxValue: TObject;
  Value: TValue;
  Modified: Boolean;
begin
  ItemIndex := comboBox.ItemIndex;
  if ItemIndex >= 0 then
  begin
    Id := TagToPropertyId(comboBox.Tag);
    ComboBoxValue := comboBox.Items.Objects[ItemIndex];
    Value := TValue.FromOrdinal(PropertyTypeInfoArray[Id], Integer(ComboBoxValue));
    SetPropertyValue(Id, idx, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadComboBox(comboBox, idx);
    end;
  end;
end;

procedure TBinder.HandleCommaTextEditExit(edit: TEdit; idx: Integer);
begin
  SaveCommaTextEdit(edit, idx);
end;

procedure TBinder.HandleCommaTextEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
begin
  if Key = #13 then
  begin
    SaveCommaTextEdit(edit, idx);
    Key := #0;
  end;
end;

procedure TBinder.HandleInt64EditExit(edit: TEdit; idx: Integer);
begin
  SaveInt64Edit(edit, idx);
end;

procedure TBinder.HandleInt64EditKeyPress(edit: TEdit; idx: Integer; var key: Char);
begin
  if Key = #13 then
  begin
    SaveInt64Edit(edit, idx);
    Key := #0;
  end;
end;

procedure TBinder.HandleIntegerEditExit(edit: TEdit; idx: Integer);
begin
  SaveIntegerEdit(edit, idx);
end;

procedure TBinder.HandleIntegerEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
begin
  if Key = #13 then
  begin
    SaveIntegerEdit(edit, idx);
    Key := #0;
  end;
end;

procedure TBinder.HandleNumberStylesEditKeyPress(edit: TEdit; idx: Integer; default: TDotNetNumberStyles; var key: Char);
begin
  if Key = #13 then
  begin
    SaveNumberStylesEdit(edit, idx, default);
    Key := #0;
  end;
end;

procedure TBinder.HandleRadioButtonClick(radioButton: TRadioButton; idx: Integer);
var
  Id: TPropertyId;
  Modified: Boolean;
begin
  Id := TagToPropertyId(radioButton.Tag);
  SetPropertyValue(Id, idx, radioButton.Checked, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadRadioButton(radioButton, idx);
  end;
end;

procedure TBinder.HandleRedirectCheckBoxClick(checkBox: TCheckBox; redirect: TFieldedText.TSequenceRedirect);
var
  Id: TPropertyId;
  Modified: Boolean;
begin
  Id := TagToPropertyId(checkBox.Tag);
  SetRedirectPropertyValue(Id, redirect, checkBox.Checked, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadRedirectCheckBox(checkBox, redirect);
  end;
end;

procedure TBinder.HandleRedirectComboBoxChange(comboBox: TComboBox;
  redirect: TFieldedText.TSequenceRedirect);
var
  ItemIndex: Integer;
  Id: TPropertyId;
  ComboBoxValue: TFieldedText.TSequenceRedirect.TInvokationDelay;
  Value: TValue;
  Modified: Boolean;
begin
  ItemIndex := comboBox.ItemIndex;
  if ItemIndex >= 0 then
  begin
    Id := TagToPropertyId(comboBox.Tag);
    ComboBoxValue := TFieldedText.TSequenceRedirect.TInvokationDelay(comboBox.Items.Objects[ItemIndex]);
    Value := TValue.FromOrdinal(PropertyTypeInfoArray[Id], Int64(ComboBoxValue));
    SetRedirectPropertyValue(Id, redirect, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadRedirectComboBox(comboBox, redirect);
    end;
  end;
end;

procedure TBinder.HandleRedirectDecimalEditExit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
begin
  SaveDecimalEdit(edit, redirect);
end;

procedure TBinder.HandleRedirectDecimalEditKeyPress(edit: TEdit; redirect: TFieldedText.TSequenceRedirect; var key: Char);
begin
  if Key = #13 then
  begin
    SaveDecimalEdit(edit, redirect);
    Key := #0;
  end;
end;

procedure TBinder.HandleRedirectDoubleEditExit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
begin
  SaveDoubleEdit(edit, redirect);
end;

procedure TBinder.HandleRedirectDoubleEditKeyPress(edit: TEdit; redirect: TFieldedText.TSequenceRedirect; var key: Char);
begin
  if Key = #13 then
  begin
    SaveDoubleEdit(edit, redirect);
    Key := #0;
  end;
end;

procedure TBinder.HandleRedirectInt64EditExit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
begin
  SaveInt64Edit(edit, redirect);
end;

procedure TBinder.HandleRedirectInt64EditKeyPress(edit: TEdit; redirect: TFieldedText.TSequenceRedirect; var key: Char);
begin
  if Key = #13 then
  begin
    SaveInt64Edit(edit, redirect);
    Key := #0;
  end;
end;

procedure TBinder.HandleRedirectStringEditExit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
begin
  SaveStringEdit(edit, redirect);
end;

procedure TBinder.HandleRedirectStringEditKeyPress(edit: TEdit; redirect: TFieldedText.TSequenceRedirect; var key: Char);
begin
  if Key = #13 then
  begin
    SaveStringEdit(edit, redirect);
    Key := #0;
  end;
end;

procedure TBinder.HandleStringEditExit(edit: TEdit; idx: Integer);
begin
  SaveStringEdit(edit, idx);
end;

procedure TBinder.HandleStringEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
begin
  if Key = #13 then
  begin
    SaveStringEdit(edit, idx);
    Key := #0;
  end;
end;

function TBinder.IsViewableChar(value: Char): Boolean;
begin
  Result := TCharacter.IsLetterOrDigit(value)
            or
            TCharacter.IsPunctuation(value)
            or
            TCharacter.IsNumber(value)
            or
            TCharacter.IsSymbol(value);
end;

procedure TBinder.LoadBooleanStylesEdit(edit: TEdit; idx: Integer);
var
  Value: TValue;
  Styles: TBooleanStyles;
  Culture: TFieldedTextLocaleSettings;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx);
  Styles := Value.AsType<TBooleanStyles>;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := TBooleanStylesInfo.ToString(Styles);
  ClearEditError(edit);
end;

procedure TBinder.LoadCharEdit(edit: TEdit; idx: Integer);
var
  Value: Char;
begin
  Value := GetCharValue(TagToPropertyId(edit.Tag), idx);
  LoadCharEdit(edit, idx, Value);
end;

procedure TBinder.LoadCharEdit(edit: TEdit; idx: Integer; value: Char);
var
  Format: TNonViewableCharFormat;
  HexDecValue: string;
begin
  if IsViewableChar(value) then
    edit.Text := value
  else
  begin
    if Length(edit.Text) < 2 then
      Format := Configuration.DefaultNonViewableCharFormat
    else
    begin
      if not TryCalculateNonViewableCharFormat(edit.Text, Format, HexDecValue) then
      begin
        Format := Configuration.DefaultNonViewableCharFormat
      end;
    end;

    edit.Text := FormatNonViewableChar(Value, Format);
  end;

  ClearEditError(edit);
end;

procedure TBinder.LoadCheckBox(checkBox: TCheckBox; idx: Integer);
var
  Value: TValue;
begin
  Value := GetPropertyValue(TagToPropertyId(checkBox.Tag), idx);
  checkBox.Checked := Value.AsBoolean;
end;

procedure TBinder.LoadCultureEdit(edit: TEdit; idx: Integer);
var
  Value: TValue;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx);
  edit.Text := Value.AsString;
  ClearEditError(edit);
end;

procedure TBinder.LoadDateTimePickers(datePicker, timePicker: TDateTimePicker; idx: Integer);
var
  Value: TValue;
begin
  Value := GetPropertyValue(TagToPropertyId(datePicker.Tag), idx);
  datePicker.DateTime := Value.AsType<TDateTime>;
end;

procedure TBinder.LoadDateTimeStylesEdit(edit: TEdit; idx: Integer);
var
  Value: TValue;
  Styles: TDotNetDateTimeStyles;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx);
  Styles := Value.AsType<TDotNetDateTimeStyles>;
  edit.Text := TDotNetDateTimeStylesInfo.ToString(Styles);
  ClearEditError(edit);
end;

procedure TBinder.LoadCurrencyEdit(edit: TEdit; idx: Integer);
var
  Value: TValue;
  CurrencyValue: Currency;
  Culture: TFieldedTextLocaleSettings;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx);
  Culture := FEditEngine.DisplayCulture;

  CurrencyValue := Value.AsCurrency;

  edit.Text := Culture.CurrToStr(CurrencyValue);
  ClearEditError(edit);
end;

procedure TBinder.LoadDoubleEdit(edit: TEdit; idx: Integer);
var
  Value: TValue;
  DoubleValue: Double;
  Culture: TFieldedTextLocaleSettings;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx);
  Culture := FEditEngine.DisplayCulture;

  DoubleValue := Value.AsType<Double>;

  edit.Text := Culture.FloatToStr(DoubleValue);
  ClearEditError(edit);
end;

procedure TBinder.LoadComboBox(comboBox: TComboBox; idx: Integer);
var
  Value: TValue;
  ValueAsInt64: Int64;
  ValueAsInt: Integer;
begin
  Value := GetPropertyValue(TagToPropertyId(comboBox.Tag), idx);
  ValueAsInt64 := Value.AsOrdinal;
  ValueAsInt := Integer(ValueAsInt64);

  comboBox.ItemIndex := comboBox.Items.IndexOfObject(TObject(ValueAsInt));
end;

procedure TBinder.LoadCommaTextEdit(edit: TEdit; idx: Integer);
begin
  LoadStringEdit(edit, idx);
end;

procedure TBinder.LoadInt64Edit(edit: TEdit; idx: Integer);
var
  Value: TValue;
  Int64Value: Int64;
  Culture: TFieldedTextLocaleSettings;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx);
  Int64Value := Value.AsType<Int64>;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Culture.IntToStr(Int64Value);
  ClearEditError(edit);
end;

procedure TBinder.LoadIntegerEdit(edit: TEdit; idx: Integer);
var
  Value: TValue;
  IntegerValue: Integer;
  Culture: TFieldedTextLocaleSettings;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx);
  IntegerValue := Value.AsInteger;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Culture.IntToStr(IntegerValue);
  ClearEditError(edit);
end;

procedure TBinder.LoadNumberStylesEdit(edit: TEdit; idx: Integer);
var
  Value: TValue;
  Styles: TDotNetNumberStyles;
  Culture: TFieldedTextLocaleSettings;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx);
  Styles := Value.AsType<TDotNetNumberStyles>;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := TDotNetNumberStylesInfo.ToString(Styles);
  ClearEditError(edit);
end;

procedure TBinder.LoadRadioButton(radioButton: TRadioButton; idx: Integer);
var
  Value: TValue;
begin
  Value := GetPropertyValue(TagToPropertyId(radioButton.Tag), idx);
  radioButton.Checked := Value.AsBoolean;
end;

procedure TBinder.LoadRedirectCheckBox(checkBox: TCheckBox; redirect: TFieldedText.TSequenceRedirect);
var
  Value: TValue;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(checkBox.Tag), redirect);
  checkBox.Checked := Value.AsBoolean;
end;

procedure TBinder.LoadRedirectComboBox(comboBox: TComboBox;
  redirect: TFieldedText.TSequenceRedirect);
var
  Value: TValue;
  ValueAsInt: Integer;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(comboBox.Tag), redirect);
  ValueAsInt := Value.AsOrdinal;

  comboBox.ItemIndex := comboBox.Items.IndexOfObject(TObject(ValueAsInt));
end;

procedure TBinder.LoadRedirectDateTimePickers(datePicker, timePicker: TDateTimePicker;
  redirect: TFieldedText.TSequenceRedirect);
var
  Value: TValue;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(datePicker.Tag), redirect);
  datePicker.DateTime := Value.AsType<TDateTime>;
end;

procedure TBinder.LoadRedirectCurrencyEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
var
  Value: TValue;
  CurrencyValue: Currency;
  Culture: TFieldedTextLocaleSettings;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(edit.Tag), redirect);
  CurrencyValue := Value.AsType<Currency>;
  Culture := FEditEngine.DisplayCulture;

  edit.Text := Culture.CurrToStr(CurrencyValue);
  ClearEditError(edit);
end;

procedure TBinder.LoadRedirectDoubleEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
var
  Value: TValue;
  DoubleValue: Double;
  Culture: TFieldedTextLocaleSettings;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(edit.Tag), redirect);
  DoubleValue := Value.AsType<Double>;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Culture.FloatToStr(DoubleValue);
  ClearEditError(edit);
end;

procedure TBinder.LoadRedirectInt64Edit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
var
  Value: TValue;
  Int64Value: Int64;
  Culture: TFieldedTextLocaleSettings;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(edit.Tag), redirect);
  Int64Value := Value.AsType<Int64>;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Culture.IntToStr(Int64Value);
  ClearEditError(edit);
end;

procedure TBinder.LoadRedirectStringEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
var
  Value: TValue;
  StringValue: string;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(edit.Tag), redirect);
  StringValue := Value.AsString;
  edit.Text := StringValue;
  ClearEditError(edit);
end;

procedure TBinder.LoadStringEdit(edit: TEdit; idx: Integer);
var
  Value: TValue;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx);
  edit.Text := Value.AsString;
  ClearEditError(edit);
end;

procedure TBinder.NotifyErrorCountChange;
var
  I: Integer;
  Delegates: TErrorCountChangeDelegates;
begin
  Delegates := Copy(FErrorCountChangeDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
    Delegates[I];
  end;
end;

procedure TBinder.NotifyFieldCaptionChange;
var
  I: Integer;
  Delegates: TFieldCaptionChangeDelegates;
begin
  Delegates := Copy(FFieldCaptionChangeDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
    Delegates[I];
  end;
end;

procedure TBinder.NotifySsirCaptionChange;
var
  I: Integer;
  Delegates: TSequenceCaptionChangeDelegates;
begin
  Delegates := Copy(FSsirCaptionChangeDelegates);
  for I := Low(Delegates) to High(Delegates) do
  begin
    Delegates[I];
  end;
end;

class procedure TBinder.PrepareEndOfLineAutoWriteTypeComboBox(comboBox: TComboBox; id: TPropertyId);
begin
  comboBox.Items.Clear;
  comboBox.Items.AddObject('Local', TObject(ftewLocal));
  comboBox.Items.AddObject('CrLf', TObject(ftewCrLf));
  comboBox.Items.AddObject('Cr', TObject(ftewCr));
  comboBox.Items.AddObject('Lf', TObject(ftewLf));

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareEndOfLineTypeComboBox(comboBox: TComboBox; id: TPropertyId);
begin
  comboBox.Items.Clear;
  comboBox.Items.AddObject('Auto', TObject(ftetAuto));
  comboBox.Items.AddObject('Char', TObject(ftetChar));
  comboBox.Items.AddObject('CrLf', TObject(ftetCrLf));

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareHeadingConstraintComboBox(comboBox: TComboBox; id: TPropertyId);
begin
  comboBox.Items.Clear;
  comboBox.Items.AddObject('None', TObject(fthcNone));
  comboBox.Items.AddObject('All Constant', TObject(fthcAllConstant));
  comboBox.Items.AddObject('Main Constant', TObject(fthcMainConstant));
  comboBox.Items.AddObject('Name Constant', TObject(fthcNameConstant));
  comboBox.Items.AddObject('Name Is Main', TObject(fthcNameIsMain));

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PreparePadAlignmentComboBox(comboBox: TComboBox; id: TPropertyId);
begin
  comboBox.Items.Clear;
  comboBox.Items.AddObject('Auto', TObject(ftpaAuto));
  comboBox.Items.AddObject('Left', TObject(ftpaLeft));
  comboBox.Items.AddObject('Right', TObject(ftpaRight));

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PreparePadCharTypeComboBox(comboBox: TComboBox; id: TPropertyId);
begin
  comboBox.Items.Clear;
  comboBox.Items.AddObject('Auto', TObject(ftpcAuto));
  comboBox.Items.AddObject('Specified', TObject(ftpcSpecified));
  comboBox.Items.AddObject('EndOfValue', TObject(ftpcEndOfValue));

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareQuotedTypeComboBox(comboBox: TComboBox; id: TPropertyId);
begin
  comboBox.Items.Clear;
  comboBox.Items.AddObject('Never', TObject(ftqtNever));
  comboBox.Items.AddObject('Always', TObject(ftqtAlways));
  comboBox.Items.AddObject('Optional', TObject(ftqtOptional));

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareRedirectInvokationDelayComboBox(
  comboBox: TComboBox; id: TPropertyId);
begin
  comboBox.Items.Clear;
  comboBox.Items.AddObject('After Field', TObject(ftikAfterField));
  comboBox.Items.AddObject('After Sequence', TObject(ftikAfterSequence));

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareTruncateTypeComboBox(comboBox: TComboBox; id: TPropertyId);
begin
  comboBox.Items.Clear;
  comboBox.Items.AddObject('Left', TObject(ftttLeft));
  comboBox.Items.AddObject('Right', TObject(ftttRight));
  comboBox.Items.AddObject('TruncateChar', TObject(ftttTruncateChar));
  comboBox.Items.AddObject('NullChar', TObject(ftttNullChar));
  comboBox.Items.AddObject('Exception', TObject(ftttException));

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareMetaReferenceTypeComboBox(comboBox: TComboBox; id: TPropertyId);
begin
  comboBox.Items.Clear;
  comboBox.Items.AddObject('None', TObject(ftmrNone));
  comboBox.Items.AddObject('Embedded', TObject(ftmrEmbedded));
  comboBox.Items.AddObject('File', TObject(ftmrFile));
  comboBox.Items.AddObject('Url', TObject(ftmrUrl));

  comboBox.Tag := CreateControlTag(id);
end;

class function TBinder.CreateControlTag(value: TPropertyId): Integer;
begin
  Result := Integer(TControlTag.Create(value));
end;

procedure TBinder.SetEditError(edit: TEdit);
begin
  if FConfigurationChanged or not TControlTag(edit.Tag).Error then
  begin
    edit.Color := Configuration.Colors[rcControlError].Background;
    edit.Font.Color := Configuration.Colors[rcControlError].Font;
    edit.Font.Style := Configuration.Colors[rcControlError].FontStyles;
    Inc(FErrorCount);
    TControlTag(edit.Tag).Error := True;
    if not FConfigurationChanged then
    begin
      NotifyErrorCountChange;
    end;
  end;
end;

procedure TBinder.SetEditWarning(edit: TEdit);
begin
  if not TControlTag(edit.Tag).Error then
  begin
    edit.Color := Configuration.Colors[rcControlWarning].Background;
    edit.Font.Color := Configuration.Colors[rcControlWarning].Font;
    edit.Font.Style := Configuration.Colors[rcControlWarning].FontStyles;
  end;
end;

procedure TBinder.SetPropertyValue(id: TPropertyId; idx: Integer; const value: TValue; out modified: Boolean);
var
  Name: string;
  Cat: TEditEngine.TPropertyCategory;
begin
  Cat := PropArray[id].Cat;
  Name := GetPropertyName(id);
  FEditEngine.SetPropertyValue(Name, idx, Cat, value, modified);
end;

procedure TBinder.SetRedirectPropertyValue(id: TPropertyId; redirect: TFieldedText.TSequenceRedirect; const value: TValue;
  out modified: Boolean);
var
  Name: string;
begin
  Name := GetPropertyName(id);
  FEditEngine.SetRedirectPropertyValue(Name, redirect, value, modified);
end;

procedure TBinder.SetRedirectSequence(redirect: TFieldedText.TSequenceRedirect; value: TObject);
var
  Modified: Boolean;
begin
  SetRedirectPropertyValue(piRedirectSequence, redirect, value, Modified);
  CheckRefresh(piRedirectSequence, Modified);
end;

procedure TBinder.SetSequenceItemField(sequenceItem: TFieldedText.TSequence.TItem; value: TObject);
var
  Modified: Boolean;
begin
  SetSequenceItemPropertyValue(piSequenceItemField, sequenceItem, value, Modified);
  CheckRefresh(piSequenceItemField, Modified);
end;

procedure TBinder.SetSequenceItemPropertyValue(id: TPropertyId; sequenceItem: TFieldedText.TSequence.TItem; const value: TValue;
  out modified: Boolean);
var
  Name: string;
begin
  Name := GetPropertyName(id);
  FEditEngine.SetSequenceItemPropertyValue(Name, sequenceItem, value, modified);
end;

procedure TBinder.SubscribeErrorCountChangeEvent(
  Delegate: TErrorCountChangeDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FErrorCountChangeDelegates);
  SetLength(FErrorCountChangeDelegates, Idx + 1);
  FErrorCountChangeDelegates[Idx] := Delegate;
end;

procedure TBinder.SubscribeFieldCaptionChangeEvent(
  Delegate: TFieldCaptionChangeDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FFieldCaptionChangeDelegates);
  SetLength(FFieldCaptionChangeDelegates, Idx + 1);
  FFieldCaptionChangeDelegates[Idx] := Delegate;
end;

procedure TBinder.SubscribeSsirCaptionChangeEvent(
  Delegate: TSequenceCaptionChangeDelegate);
var
  Idx: Integer;
begin
  Idx := Length(FSsirCaptionChangeDelegates);
  SetLength(FSsirCaptionChangeDelegates, Idx + 1);
  FSsirCaptionChangeDelegates[Idx] := Delegate;
end;

function TBinder.TryDisplayDecimalToChar(const decimalStr: string; out value: Char): Boolean;
var
  Culture: TFieldedTextLocaleSettings;
  Int64Value: Int64;
  I: Integer;
  Bytes: TBytes;
  BytesLength: Integer;
  PowerValue: Int64;
  CharEncoding: TEncoding;
  CharCount: Integer;
  Chars: TCharArray;
begin
  Culture := FEditEngine.DisplayCulture;
  Result := Culture.TryStrToInt64(decimalStr, Int64Value);

  if Result then
  begin
    SetLength(Bytes, 8);
    BytesLength := 1;

    for I := 7 downto 0 do
    begin
      PowerValue := Round(Math.Power(256, I));
      Bytes[I] := Int64Value div PowerValue;
      Int64Value := Int64Value mod PowerValue;

      if (Bytes[I] > 0) and (I >= BytesLength) then
      begin
        BytesLength := I + 1;
      end;
    end;

    SetLength(Bytes, BytesLength);

    CharEncoding := CalculateDisplayCharEncoding;
    CharCount := CharEncoding.GetCharCount(Bytes);
    if CharCount <> 1 then
      Result := False
    else
    begin
      Chars := CharEncoding.GetChars(Bytes);
      value := Chars[0];
    end;
  end;
end;

function TBinder.TryDisplayHexToChar(hexStr: string; out value: Char): Boolean;
var
  Culture: TFieldedTextLocaleSettings;
  Int64Value: UInt64;
  I: Integer;
  Bytes: TBytes;
  BytesLength: Integer;
  PowerValue: Int64;
  CharEncoding: TEncoding;
  CharCount: Integer;
  Chars: TCharArray;
begin
  Result := True;
  Culture := FEditEngine.DisplayCulture;

  BytesLength := Length(hexStr) div 2;
  if (Length(hexStr) mod 2) = 1 then
  begin
    Inc(BytesLength);
  end;

  if BytesLength > 8 then
    Result := False
  else
  begin
    if not Culture.TryHexToUInt64(HexStr, Int64Value) then
    begin
      Int64Value := 0;
      Result := False;
    end
    else
    begin
      SetLength(Bytes, BytesLength);
      for I := BytesLength-1 downto 0 do
      begin
        PowerValue := Round(Math.Power(256, I));
        Bytes[I] := Int64Value div PowerValue;
        Int64Value := Int64Value mod PowerValue;
      end;

      CharEncoding := CalculateDisplayCharEncoding;
      CharCount := CharEncoding.GetCharCount(Bytes);
      if CharCount <> 1 then
        Result := False
      else
      begin
        Chars := CharEncoding.GetChars(Bytes);
        value := Chars[0];
      end;
    end;
  end;
end;

function TBinder.TryParseBooleanStylesDisplay(const display: string; out value: TBooleanStyles): Boolean;
begin
  Result := TBooleanStylesInfo.TryFromString(display, value);
end;

function TBinder.TryParseCommaTextDisplay(const display: string): Boolean;
var
  ErrorDescription: string;
begin
  Result := TCommaText.StrictValidate(display, ErrorDescription);
end;

function TBinder.TryParseDateTimeStylesDisplay(const display: string; out value: TDotNetDateTimeStyles): Boolean;
begin
  Result := TDotNetDateTimeStylesInfo.TryFromString(display, Value);
end;

function TBinder.TryParseCurrencyDisplay(const display: string; out value: Currency): Boolean;
var
  Culture: TFieldedTextLocaleSettings;
begin
  Culture := FEditEngine.DisplayCulture;
  Result := Culture.TryStrToCurr(display, Value);
end;

function TBinder.TryParseDoubleDisplay(const display: string; out value: Double): Boolean;
var
  Culture: TFieldedTextLocaleSettings;
begin
  Culture := FEditEngine.DisplayCulture;
  Result := Culture.TryStrToFloat(display, Value);
end;

function TBinder.TryParseInt64Display(const display: string; out value: Int64): Boolean;
var
  Culture: TFieldedTextLocaleSettings;
begin
  Culture := FEditEngine.DisplayCulture;
  Result := Culture.TryStrToInt64(display, value);
end;

function TBinder.TryParseIntegerDisplay(const display: string; out value: Integer): Boolean;
var
  Culture: TFieldedTextLocaleSettings;
begin
  Culture := FEditEngine.DisplayCulture;
  Result := Culture.TryStrToInt(display, value);
end;

function TBinder.TryParseNonViewableCharDisplay(const display: string; out value: Char): Boolean;
var
  Format: TNonViewableCharFormat;
  HexDecValue: string;
begin
  Result := TryCalculateNonViewableCharFormat(display, Format, HexDecValue);
  if Result then
  begin
    case Format of
      nv0xHex, nvHashDollarHex, nvDollarHex: Result := TryDisplayHexToChar(HexDecValue, value);
      nvHashDecimal: Result := TryDisplayDecimalToChar(HexDecValue, value);
      else
      begin
        Result := False;
        Assert(False);
      end;
    end;
  end;
end;

function TBinder.TryParseNumberStylesDisplay(const display: string; out value: TDotNetNumberStyles): Boolean;
begin
  Result := TDotNetNumberStylesInfo.TryFromString(display, Value);
end;

procedure TBinder.UnsubscribeErrorCountChangeEvent(
  Delegate: TErrorCountChangeDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TErrorCountChangeDelegate;
begin
  Idx := -1;
  for I := Low(FErrorCountChangeDelegates) to High(FErrorCountChangeDelegates) do
  begin
    ExistingDelegate := FErrorCountChangeDelegates[I];
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
    FErrorCountChangeDelegates[Idx] := FErrorCountChangeDelegates[High(FErrorCountChangeDelegates)];
    SetLength(FErrorCountChangeDelegates, Length(FErrorCountChangeDelegates)-1);
  end;
end;

procedure TBinder.UnsubscribeFieldCaptionChangeEvent(
  Delegate: TFieldCaptionChangeDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TFieldCaptionChangeDelegate;
begin
  Idx := -1;
  for I := Low(FFieldCaptionChangeDelegates) to High(FFieldCaptionChangeDelegates) do
  begin
    ExistingDelegate := FFieldCaptionChangeDelegates[I];
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
    FFieldCaptionChangeDelegates[Idx] := FFieldCaptionChangeDelegates[High(FFieldCaptionChangeDelegates)];
    SetLength(FFieldCaptionChangeDelegates, Length(FFieldCaptionChangeDelegates)-1);
  end;
end;

procedure TBinder.UnsubscribeSsirCaptionChangeEvent(
  Delegate: TSequenceCaptionChangeDelegate);
var
  I, Idx: Integer;
  ExistingDelegate: TSequenceCaptionChangeDelegate;
begin
  Idx := -1;
  for I := Low(FSsirCaptionChangeDelegates) to High(FSsirCaptionChangeDelegates) do
  begin
    ExistingDelegate := FSsirCaptionChangeDelegates[I];
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
    FSsirCaptionChangeDelegates[Idx] := FSsirCaptionChangeDelegates[High(FSsirCaptionChangeDelegates)];
    SetLength(FSsirCaptionChangeDelegates, Length(FSsirCaptionChangeDelegates)-1);
  end;
end;

constructor TBinder.TControlTag.Create(myPropertyId: TPropertyId);
begin
  inherited Create;
  FPropertyId := myPropertyId;
end;

procedure TBinder.SaveDoubleEdit(edit: TEdit; redirect: TFieldedText.TSequenceRedirect);
var
  Id: TPropertyId;
  Value: Double;
  Modified: Boolean;
begin
  if not TryParseDoubleDisplay(edit.Text, Value) then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetRedirectPropertyValue(Id, redirect, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadRedirectDoubleEdit(edit, redirect);
    end;
  end;
end;

end.
