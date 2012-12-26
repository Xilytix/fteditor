// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.Binder;

interface

uses
  System.Text,
  System.Globalization,
  Borland.Vcl.Classes,
  Borland.Vcl.Variants,
  Borland.Vcl.Controls,
  Borland.Vcl.StdCtrls,
  Borland.Vcl.ComCtrls,
  Xilytix.FieldedText.BaseField,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.Configuration;

type
  TErrorCountChangeEvent = procedure of object;
  TFieldCaptionChangeEvent = procedure of object;
  TSequenceCaptionChangeEvent = procedure of object;

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
        Name: string;
        Cat: TEditEngine.TPropertyCategory;
        CatRefresh: Boolean;
        FullRefresh: Boolean;
        ForceRefresh: Boolean;
        CaptionChange: Boolean;
      end;
      TPropertyArray = array[TPropertyId] of TPropertyRec;

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

        (Id: piSubstitutionType; Cat: pcSubstitution),
        (Id: piSubstitutionToken; Cat: pcSubstitution),
        (Id: piSubstitutionValue; Cat: pcSubstitution),

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

    var
      FEditEngine: TEditEngine;

      FConfigurationChanged: Boolean;

      FErrorCount: Integer;

      FErrorCountChangeEvent: TErrorCountChangeEvent;
      FFieldCaptionChangeEvent: TFieldCaptionChangeEvent;
      FSsirCaptionChangeEvent: TSequenceCaptionChangeEvent;

    procedure ClearEditError(edit: TEdit);
    procedure SetEditError(edit: TEdit);

    function CheckRefresh(id: TPropertyId; modified: Boolean): Boolean;

    function CalculateDisplayCharEncoding: Encoding;
    function CharToDisplayHex(value: Char): string;
    function TryDisplayHexToChar(hexStr: string; out value: Char): Boolean;
    function CharToDisplayDecimal(value: Char): string;
    function TryDisplayDecimalToChar(decimalStr: string; out value: Char): Boolean;
    function IsViewableChar(value: Char): Boolean;
    function TryCalculateNonViewableCharFormat(value: string;
                                               out format: TNonViewableCharFormat;
                                               out hexDecValue: string): Boolean;
    function FormatNonViewableChar(value: Char; format: TNonViewableCharFormat): string;
    function TryParseNonViewableCharDisplay(display: string; out value: Char): Boolean;

    function TryParseCommaTextDisplay(display: string): Boolean;
    function TryParseIntegerDisplay(display: string; out value: Integer): Boolean;
    function TryParseInt64Display(display: string; out value: Int64): Boolean;
    function TryParseDoubleDisplay(display: string; out value: Double): Boolean;
    function TryParseDecimalDisplay(display: string; out value: Decimal): Boolean;

    function TryParseNumberStylesDisplay(display: string; out value: NumberStyles): Boolean;
    function TryParseDateTimeStylesDisplay(display: string; out value: DateTimeStyles): Boolean;
    function TryParseBooleanStylesDisplay(display: string; out value: TBooleanStyles): Boolean;

    function GetPropertyName(id: TPropertyId): string;
    function GetCharValue(id: TPropertyId; idx: Integer): Char;

    function GetPropertyValue(id: TPropertyId; idx: Integer): TObject; overload;
    function GetSequenceItemPropertyValue(id: TPropertyId; sequenceItem: TFieldedTextSequenceItem): TObject; overload;
    function GetRedirectPropertyValue(id: TPropertyId; redirect: TFieldedTextSequenceRedirect): TObject; overload;

    procedure SaveCharEdit(edit: TEdit; idx: Integer); overload;
    procedure SaveStringEdit(edit: TEdit; idx: Integer); overload;
    procedure SaveIntegerEdit(edit: TEdit; idx: Integer);
    procedure SaveInt64Edit(edit: TEdit; idx: Integer); overload;
    procedure SaveDoubleEdit(edit: TEdit; idx: Integer); overload;
    procedure SaveDecimalEdit(edit: TEdit; idx: Integer); overload;

    procedure SaveStringEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect); overload;
    procedure SaveInt64Edit(edit: TEdit; redirect: TFieldedTextSequenceRedirect); overload;
    procedure SaveDoubleEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect); overload;
    procedure SaveDecimalEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect); overload;

  public
    constructor Create(myEditEngine: TEditEngine);

    property ConfigurationChanged: Boolean read FConfigurationChanged write FConfigurationChanged;

    procedure ClearEdit(edit: TEdit);
    procedure SetEditWarning(edit: TEdit);
    procedure ClearEditWarning(edit: TEdit);

    function EditNumberStyles(formOwner: TComponent; asString: string; fallback, default: NumberStyles; out NewValue: string): Boolean;
    function EditDateTimeStyles(formOwner: TComponent; asString: string; fallback, default: DateTimeStyles; out NewValue: string): Boolean;
    function EditBooleanStyles(formOwner: TComponent; asString: string; fallback, default: TBooleanStyles; out NewValue: string): Boolean;

    procedure LoadStringEdit(edit: TEdit; idx: Integer);
    procedure HandleStringEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleStringEditExit(edit: TEdit; idx: Integer);

    procedure LoadCommaTextEdit(edit: TEdit; idx: Integer);
    procedure SaveCommaTextEdit(edit: TEdit; idx: Integer);
    procedure HandleCommaTextEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleCommaTextEditExit(edit: TEdit; idx: Integer);

    procedure LoadRedirectStringEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
    procedure HandleRedirectStringEditKeyPress(edit: TEdit; redirect: TFieldedTextSequenceRedirect; var key: Char);
    procedure HandleRedirectStringEditExit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);

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

    procedure LoadRedirectInt64Edit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
    procedure HandleRedirectInt64EditKeyPress(edit: TEdit; redirect: TFieldedTextSequenceRedirect; var key: Char);
    procedure HandleRedirectInt64EditExit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);

    procedure LoadDoubleEdit(edit: TEdit; idx: Integer);
    procedure HandleDoubleEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleDoubleEditExit(edit: TEdit; idx: Integer);

    procedure LoadRedirectDoubleEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
    procedure HandleRedirectDoubleEditKeyPress(edit: TEdit; redirect: TFieldedTextSequenceRedirect; var key: Char);
    procedure HandleRedirectDoubleEditExit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);

    procedure LoadDecimalEdit(edit: TEdit; idx: Integer);
    procedure HandleDecimalEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
    procedure HandleDecimalEditExit(edit: TEdit; idx: Integer);

    procedure LoadRedirectDecimalEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
    procedure HandleRedirectDecimalEditKeyPress(edit: TEdit; redirect: TFieldedTextSequenceRedirect; var key: Char);
    procedure HandleRedirectDecimalEditExit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);

    procedure LoadNumberStylesEdit(edit: TEdit; idx: Integer);
    procedure SaveNumberStylesEdit(edit: TEdit; idx: Integer; default: NumberStyles);
    procedure HandleNumberStylesEditKeyPress(edit: TEdit; idx: Integer; default: NumberStyles; var key: Char);

    procedure LoadDateTimeStylesEdit(edit: TEdit; idx: Integer);
    procedure SaveDateTimeStylesEdit(edit: TEdit; idx: Integer; default: DateTimeStyles);
    procedure HandleDateTimeStylesEditKeyPress(edit: TEdit; idx: Integer; default: DateTimeStyles; var key: Char);

    procedure LoadBooleanStylesEdit(edit: TEdit; idx: Integer);
    procedure SaveBooleanStylesEdit(edit: TEdit; idx: Integer; default: TBooleanStyles);
    procedure HandleBooleanStylesEditKeyPress(edit: TEdit; idx: Integer; default: TBooleanStyles; var key: Char);

    procedure LoadCultureEdit(edit: TEdit; idx: Integer);
    procedure SaveCultureEdit(edit: TEdit; idx: Integer);

    procedure LoadCheckBox(checkBox: TCheckBox; idx: Integer);
    procedure HandleCheckBoxClick(checkBox: TCheckBox; idx: Integer);
    procedure LoadRedirectCheckBox(checkBox: TCheckBox; redirect: TFieldedTextSequenceRedirect);
    procedure HandleRedirectCheckBoxClick(checkBox: TCheckBox; redirect: TFieldedTextSequenceRedirect);

    procedure LoadRadioButton(radioButton: TRadioButton; idx: Integer);
    procedure HandleRadioButtonClick(radioButton: TRadioButton; idx: Integer);

    procedure LoadDateTimePickers(datePicker, timePicker: TDateTimePicker; idx: Integer);
    procedure SaveDateTimePickers(datePicker, timePicker: TDateTimePicker; idx: Integer);

    procedure LoadRedirectDateTimePickers(datePicker, timePicker: TDateTimePicker; redirect: TFieldedTextSequenceRedirect);
    procedure SaveRedirectDateTimePickers(datePicker, timePicker: TDateTimePicker; redirect: TFieldedTextSequenceRedirect);

    procedure LoadComboBox(comboBox: TComboBoxEx; idx: Integer);
    procedure HandleComboBoxChange(comboBox: TComboBoxEx; idx: Integer);

    procedure LoadRedirectComboBox(comboBox: TComboBoxEx; redirect: TFieldedTextSequenceRedirect);
    procedure HandleRedirectComboBoxChange(comboBox: TComboBoxEx; redirect: TFieldedTextSequenceRedirect);

    procedure SetSequenceItemField(sequenceItem: TFieldedTextSequenceItem; value: TObject);
    procedure SetRedirectSequence(redirect: TFieldedTextSequenceRedirect; value: TObject);

    class procedure PrepareEndOfLineTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
    class procedure PrepareEndOfLineAutoWriteTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
    class procedure PrepareHeadingConstraintComboBox(comboBox: TComboBoxEx; id: TPropertyId);
    class procedure PrepareQuotedTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
    class procedure PreparePadAlignmentComboBox(comboBox: TComboBoxEx; id: TPropertyId);
    class procedure PreparePadCharTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
    class procedure PrepareTruncateTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
    class procedure PrepareMetaReferenceTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);

    class procedure PrepareRedirectInvokationDelayComboBox(comboBox: TComboBoxEx; id: TPropertyId);

    class function TagToPropertyId(value: Variant): TPropertyId;
    class function CreateControlTag(value: TPropertyId): Variant;

    function GetPropertyValue(control: TWinControl; idx: Integer): TObject; overload;
    procedure SetPropertyValue(id: TPropertyId; idx: Integer; value: TObject; out modified: Boolean);

    function GetSequenceItemPropertyValue(control: TWinControl; sequenceItem: TFieldedTextSequenceItem): TObject; overload;
    procedure SetSequenceItemPropertyValue(id: TPropertyId; sequenceItem: TFieldedTextSequenceItem; value: TObject;
                                           out modified: Boolean);

    function GetRedirectPropertyValue(control: TWinControl; redirect: TFieldedTextSequenceRedirect): TObject; overload;
    procedure SetRedirectPropertyValue(id: TPropertyId; redirect: TFieldedTextSequenceRedirect; value: TObject;
                                       out modified: Boolean);

    property ErrorCountChangeEvent: TErrorCountChangeEvent add FErrorCountChangeEvent remove FErrorCountChangeEvent;
    property FieldCaptionChangeEvent: TFieldCaptionChangeEvent add FFieldCaptionChangeEvent remove FFieldCaptionChangeEvent;
    property SsirCaptionChangeEvent: TSequenceCaptionChangeEvent add FSsirCaptionChangeEvent remove FSsirCaptionChangeEvent;
  end;

implementation

uses
  System.Reflection,
  Borland.Vcl.ListActns,
  Xilytix.FieldedText.CommaText,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.Colors,
  Xilytix.FTEditor.NumberStylesForm,
  Xilytix.FTEditor.DateTimeStylesForm,
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
  Value: TBooleanStyles;
  Modified: Boolean;
begin
  Text := edit.Text;
  if Text <> '' then
    Error := not TryParseBooleanStylesDisplay(Text, Value)
  else
  begin
    Value := default;
    Error := False;
  end;

  if Error then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetPropertyValue(Id, idx, Value as TObject, Modified);

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
    SetPropertyValue(Id, idx, Value as TObject, Modified);

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
  try
    Id := TagToPropertyId(edit.Tag);
    SetPropertyValue(Id, idx, edit.Text, Modified);
    if not CheckRefresh(Id, Modified) then
    begin
      LoadCultureEdit(edit, idx);
    end;
  except
    on E: TargetInvocationException do
    begin
      if E.InnerException is ArgumentException then
        SetEditError(edit)
      else
        raise;
    end;
  end;
end;

procedure TBinder.SaveDateTimePickers(datePicker, timePicker: TDateTimePicker; idx: Integer);
var
  Id: TPropertyId;
  Value: DateTime;
  Modified: Boolean;
begin
  Id := TagToPropertyId(datePicker.Tag);
  Value := datePicker.Date + datePicker.Time;
  SetPropertyValue(Id, idx, Value as TObject, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadDateTimePickers(datePicker, timePicker, idx);
  end;
end;

procedure TBinder.SaveDateTimeStylesEdit(edit: TEdit; idx: Integer; default: DateTimeStyles);
var
  Text: string;
  Error: Boolean;
  Id: TPropertyId;
  Value: DateTimeStyles;
  Modified: Boolean;
begin
  Text := edit.Text;
  if Text <> '' then
    Error := not TryParseDateTimeStylesDisplay(Text, Value)
  else
  begin
    Value := default;
    Error := False;
  end;

  if Error then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetPropertyValue(Id, idx, Value as TObject, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadDateTimeStylesEdit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveDecimalEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
var
  Id: TPropertyId;
  Value: Decimal;
  Modified: Boolean;
begin
  if not TryParseDecimalDisplay(edit.Text, Value) then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetRedirectPropertyValue(Id, redirect, Value as TObject, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadRedirectDecimalEdit(edit, redirect);
    end;
  end;
end;

procedure TBinder.SaveDecimalEdit(edit: TEdit; idx: Integer);
var
  Id: TPropertyId;
  Value: Decimal;
  Modified: Boolean;
begin
  if not TryParseDecimalDisplay(edit.Text, Value) then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetPropertyValue(Id, idx, Value as TObject, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadDecimalEdit(edit, idx);
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
    SetPropertyValue(Id, idx, Value as TObject, Modified);

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
    SetPropertyValue(Id, idx, Value as TObject, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadInt64Edit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveInt64Edit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
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
    SetRedirectPropertyValue(Id, redirect, Value as TObject, Modified);

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
    SetPropertyValue(Id, idx, Value as TObject, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadIntegerEdit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveNumberStylesEdit(edit: TEdit; idx: Integer; default: NumberStyles);
var
  Text: string;
  Error: Boolean;
  Id: TPropertyId;
  Value: NumberStyles;
  Modified: Boolean;
begin
  Text := edit.Text;
  if Text <> '' then
    Error := not TryParseNumberStylesDisplay(Text, Value)
  else
  begin
    Value := default;
    Error := False;
  end;

  if Error then
    SetEditError(edit)
  else
  begin
    Id := TagToPropertyId(edit.Tag);
    SetPropertyValue(Id, idx, Value as TObject, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadNumberStylesEdit(edit, idx);
    end;
  end;
end;

procedure TBinder.SaveRedirectDateTimePickers(datePicker, timePicker: TDateTimePicker;
  redirect: TFieldedTextSequenceRedirect);
var
  Id: TPropertyId;
  Value: DateTime;
  Modified: Boolean;
begin
  Id := TagToPropertyId(datePicker.Tag);
  Value := datePicker.Date.Date + datePicker.Time.Time;
  SetRedirectPropertyValue(Id, redirect, Value as TObject, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadRedirectDateTimePickers(datePicker, timePicker, redirect);
  end;
end;

procedure TBinder.SaveStringEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
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

function TBinder.CalculateDisplayCharEncoding: Encoding;
begin
  case Configuration.DisplayCharEncodingType of
    deAscii: Result := Encoding.ASCII;
    deUtf8: Result := Encoding.UTF8;
    deNamed: Result := Configuration.NamedDisplayCharEncoding;
    deFile: Result := FEditEngine.TextCharEncoding;
    else
    begin
      Assert(False);
      Result := Encoding.UTF8;
    end;
  end;
end;

class function TBinder.TagToPropertyId(value: Variant): TPropertyId;
begin
  Result := TControlTag(value).PropertyId;
end;

function TBinder.TryCalculateNonViewableCharFormat(value: string;
                                                      out format: TNonViewableCharFormat;
                                                      out hexDecValue: string): Boolean;
begin
  Result := True;
  if value.Length < 2 then
    Result := False
  else
  begin
    case value[1] of
      '0':
      begin
        if (value.Length = 2) or (System.Char.ToUpper(value[2]) <> 'X') then
          Result := False
        else
        begin
          format := nv0xHex;
          hexDecValue := value.Substring(2);
        end
      end;
      '$':
      begin
        format := nvDollarHex;
        hexDecValue := value.Substring(1);
      end;
      '#':
      begin
        if (value.Length = 2) or (value[2] <> '$') then
        begin
          format := nvHashDecimal;
          hexDecValue := value.Substring(1);
        end
        else
        begin
          if value.Length < 3 then
            Result := False
          else
          begin
            format := nvHashDollarHex;
            hexDecValue := value.Substring(2);
          end;
        end;
      end;
      else Result := False;
    end;
  end;
end;

function TBinder.CharToDisplayDecimal(value: Char): string;
var
  Culture: CultureInfo;
  CharEncoding: Encoding;
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
    ResultDouble := ResultDouble + ResultDouble * Math.Pow(256, I);
  end;
  ResultInt64 := Convert.ToInt64(Math.Round(ResultDouble));
  Result := ResultInt64.ToString('D', Culture);
end;

function TBinder.CharToDisplayHex(value: Char): string;
var
  CharEncoding: Encoding;
  Bytes: TBytes;
  ResultBuilder: StringBuilder;
  I: Integer;
begin
  CharEncoding := CalculateDisplayCharEncoding;
  Bytes := CharEncoding.GetBytes(value);
  ResultBuilder := StringBuilder.Create;
  for I := Low(Bytes) to High(Bytes) do
  begin
    ResultBuilder.Append(Bytes[I].ToString('X2', CultureInfo.InvariantCulture));
  end;
  Result := ResultBuilder.ToString;
end;

function TBinder.CheckRefresh(id: TPropertyId; modified: Boolean): Boolean;

  procedure CheckCaptionChange;
  begin
    if PropArray[Id].CaptionChange then
    begin
      case PropArray[Id].Cat of
        pcField:
        begin
          if Assigned(FFieldCaptionChangeEvent) then
          begin
            FFieldCaptionChangeEvent;
          end;
        end;
        pcSequence:
        begin
          if Assigned(FSsirCaptionChangeEvent) then
          begin
            FSsirCaptionChangeEvent;
          end;
        end;
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
      FErrorCountChangeEvent;
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

function TBinder.EditDateTimeStyles(formOwner: TComponent; asString: string; fallback, default: DateTimeStyles;
  out NewValue: string): Boolean;
var
  Form: TDateTimeStylesForm;
begin
  Form := TDateTimeStylesForm.Create(formOwner);
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

function TBinder.EditNumberStyles(formOwner: TComponent; asString: string; fallback, default: NumberStyles;
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
  Value: TObject;
begin
  Value := GetPropertyValue(id, idx);
  Result := Value as Char;
end;

function TBinder.GetPropertyName(id: TPropertyId): string;
begin
  if PropArray[id].Name <> '' then
    Result := PropArray[id].Name
  else
    Result := Enum(id).ToString.Substring(2);
end;

function TBinder.GetPropertyValue(control: TWinControl; idx: Integer): TObject;
var
  Id: TPropertyId;
begin
  Id := TagToPropertyId(control.Tag);
  Result := GetPropertyValue(Id, idx);
end;

function TBinder.GetRedirectPropertyValue(control: TWinControl; redirect: TFieldedTextSequenceRedirect): TObject;
var
  Id: TPropertyId;
begin
  Id := TagToPropertyId(control.Tag);
  Result := GetRedirectPropertyValue(Id, redirect);
end;

function TBinder.GetRedirectPropertyValue(id: TPropertyId; redirect: TFieldedTextSequenceRedirect): TObject;
var
  Name: string;
begin
  Name := GetPropertyName(id);
  Result := FEditEngine.RedirectProperties[Name, redirect];
end;

function TBinder.GetSequenceItemPropertyValue(id: TPropertyId; sequenceItem: TFieldedTextSequenceItem): TObject;
var
  Name: string;
begin
  Name := GetPropertyName(id);
  Result := FEditEngine.SequenceItemProperties[Name, sequenceItem];
end;

function TBinder.GetSequenceItemPropertyValue(control: TWinControl; sequenceItem: TFieldedTextSequenceItem): TObject;
var
  Id: TPropertyId;
begin
  Id := TagToPropertyId(control.Tag);
  Result := GetSequenceItemPropertyValue(Id, sequenceItem);
end;

function TBinder.GetPropertyValue(id: TPropertyId; idx: Integer): TObject;
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
  SetPropertyValue(Id, idx, checkBox.Checked as TObject, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadCheckBox(checkBox, idx);
  end;
end;

procedure TBinder.HandleDateTimeStylesEditKeyPress(edit: TEdit; idx: Integer; default: DateTimeStyles; var key: Char);
begin
  if Key = #13 then
  begin
    SaveDateTimeStylesEdit(edit, idx, default);
    Key := #0;
  end;
end;

procedure TBinder.HandleDecimalEditExit(edit: TEdit; idx: Integer);
begin
  SaveDecimalEdit(edit, idx);
end;

procedure TBinder.HandleDecimalEditKeyPress(edit: TEdit; idx: Integer; var key: Char);
begin
  if Key = #13 then
  begin
    SaveDecimalEdit(edit, idx);
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

procedure TBinder.HandleComboBoxChange(comboBox: TComboBoxEx; idx: Integer);
var
  ItemIndex: Integer;
  Id: TPropertyId;
  Value: TObject;
  Modified: Boolean;
begin
  ItemIndex := comboBox.ItemIndex;
  if ItemIndex >= 0 then
  begin
    Id := TagToPropertyId(comboBox.Tag);
    Value := comboBox.ItemsEx[ItemIndex].Data;
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

procedure TBinder.HandleNumberStylesEditKeyPress(edit: TEdit; idx: Integer; default: NumberStyles; var key: Char);
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
  SetPropertyValue(Id, idx, radioButton.Checked as TObject, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadRadioButton(radioButton, idx);
  end;
end;

procedure TBinder.HandleRedirectCheckBoxClick(checkBox: TCheckBox; redirect: TFieldedTextSequenceRedirect);
var
  Id: TPropertyId;
  Modified: Boolean;
begin
  Id := TagToPropertyId(checkBox.Tag);
  SetRedirectPropertyValue(Id, redirect, checkBox.Checked as TObject, Modified);
  if not CheckRefresh(Id, Modified) then
  begin
    LoadRedirectCheckBox(checkBox, redirect);
  end;
end;

procedure TBinder.HandleRedirectComboBoxChange(comboBox: TComboBoxEx;
  redirect: TFieldedTextSequenceRedirect);
var
  ItemIndex: Integer;
  Id: TPropertyId;
  Value: TObject;
  Modified: Boolean;
begin
  ItemIndex := comboBox.ItemIndex;
  if ItemIndex >= 0 then
  begin
    Id := TagToPropertyId(comboBox.Tag);
    Value := comboBox.ItemsEx[ItemIndex].Data;
    SetRedirectPropertyValue(Id, redirect, Value, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadRedirectComboBox(comboBox, redirect);
    end;
  end;
end;

procedure TBinder.HandleRedirectDecimalEditExit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
begin
  SaveDecimalEdit(edit, redirect);
end;

procedure TBinder.HandleRedirectDecimalEditKeyPress(edit: TEdit; redirect: TFieldedTextSequenceRedirect; var key: Char);
begin
  if Key = #13 then
  begin
    SaveDecimalEdit(edit, redirect);
    Key := #0;
  end;
end;

procedure TBinder.HandleRedirectDoubleEditExit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
begin
  SaveDoubleEdit(edit, redirect);
end;

procedure TBinder.HandleRedirectDoubleEditKeyPress(edit: TEdit; redirect: TFieldedTextSequenceRedirect; var key: Char);
begin
  if Key = #13 then
  begin
    SaveDoubleEdit(edit, redirect);
    Key := #0;
  end;
end;

procedure TBinder.HandleRedirectInt64EditExit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
begin
  SaveInt64Edit(edit, redirect);
end;

procedure TBinder.HandleRedirectInt64EditKeyPress(edit: TEdit; redirect: TFieldedTextSequenceRedirect; var key: Char);
begin
  if Key = #13 then
  begin
    SaveInt64Edit(edit, redirect);
    Key := #0;
  end;
end;

procedure TBinder.HandleRedirectStringEditExit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
begin
  SaveStringEdit(edit, redirect);
end;

procedure TBinder.HandleRedirectStringEditKeyPress(edit: TEdit; redirect: TFieldedTextSequenceRedirect; var key: Char);
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
  Result := value.IsLetterOrDigit(value)
            or
            value.IsPunctuation(value)
            or
            value.IsNumber(value)
            or
            value.IsSymbol(value);
end;

procedure TBinder.LoadBooleanStylesEdit(edit: TEdit; idx: Integer);
var
  Value: TBooleanStyles;
  Culture: CultureInfo;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx) as TBooleanStyles;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Enum(Value).ToString;
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
  Value: TObject;
begin
  Value := GetPropertyValue(TagToPropertyId(checkBox.Tag), idx);
  checkBox.Checked := Value as Boolean;
end;

procedure TBinder.LoadCultureEdit(edit: TEdit; idx: Integer);
begin
  edit.Text := GetPropertyValue(TagToPropertyId(edit.Tag), idx) as string;
  ClearEditError(edit);
end;

procedure TBinder.LoadDateTimePickers(datePicker, timePicker: TDateTimePicker; idx: Integer);
var
  Value: DateTime;
  DateValue: TDateTime;
  TimeValue: TDateTime;
begin
  Value := GetPropertyValue(TagToPropertyId(datePicker.Tag), idx) as DateTime;
  if TDateTime.TryEncodeDate(Value.Year, Value.Month, Value.Day, DateValue) then
    datePicker.Date := DateValue
  else
    datePicker.Date := 0.0;
  if TDateTime.TryEncodeTime(Value.Hour, Value.Minute, Value.Second, Value.Millisecond, TimeValue) then
    timePicker.Time := TimeValue
  else
    timePicker.Time := 0.0;
end;

procedure TBinder.LoadDateTimeStylesEdit(edit: TEdit; idx: Integer);
var
  Value: DateTimeStyles;
  Culture: CultureInfo;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx) as DateTimeStyles;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Enum(Value).ToString;
  ClearEditError(edit);
end;

procedure TBinder.LoadDecimalEdit(edit: TEdit; idx: Integer);
var
  ValueAsObject: TObject;
  Culture: CultureInfo;
begin
  ValueAsObject := GetPropertyValue(TagToPropertyId(edit.Tag), idx);
  Culture := FEditEngine.DisplayCulture;

  if not Assigned(ValueAsObject) then
    edit.Text := ''
  else
    edit.Text := (ValueAsObject as Decimal).ToString(Culture);
  ClearEditError(edit);
end;

procedure TBinder.LoadDoubleEdit(edit: TEdit; idx: Integer);
var
  Value: Double;
  Culture: CultureInfo;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx) as Double;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Value.ToString(Culture);
  ClearEditError(edit);
end;

procedure TBinder.LoadComboBox(comboBox: TComboBoxEx; idx: Integer);
var
  Value: TObject;
begin
  Value := GetPropertyValue(TagToPropertyId(comboBox.Tag), idx);
  comboBox.ItemIndex := comboBox.Items.IndexOfObject(Value);
end;

procedure TBinder.LoadCommaTextEdit(edit: TEdit; idx: Integer);
begin
  LoadStringEdit(edit, idx);
end;

procedure TBinder.LoadInt64Edit(edit: TEdit; idx: Integer);
var
  Value: Int64;
  Culture: CultureInfo;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx) as Int64;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Value.ToString(Culture);
  ClearEditError(edit);
end;

procedure TBinder.LoadIntegerEdit(edit: TEdit; idx: Integer);
var
  Value: Integer;
  Culture: CultureInfo;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx) as Integer;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Value.ToString(Culture);
  ClearEditError(edit);
end;

procedure TBinder.LoadNumberStylesEdit(edit: TEdit; idx: Integer);
var
  Value: NumberStyles;
  Culture: CultureInfo;
begin
  Value := GetPropertyValue(TagToPropertyId(edit.Tag), idx) as NumberStyles;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Enum(Value).ToString;
  ClearEditError(edit);
end;

procedure TBinder.LoadRadioButton(radioButton: TRadioButton; idx: Integer);
var
  Value: TObject;
begin
  Value := GetPropertyValue(TagToPropertyId(radioButton.Tag), idx);
  radioButton.Checked := Value as Boolean;
end;

procedure TBinder.LoadRedirectCheckBox(checkBox: TCheckBox; redirect: TFieldedTextSequenceRedirect);
var
  Value: TObject;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(checkBox.Tag), redirect);
  checkBox.Checked := Value as Boolean;
end;

procedure TBinder.LoadRedirectComboBox(comboBox: TComboBoxEx;
  redirect: TFieldedTextSequenceRedirect);
var
  Value: TObject;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(comboBox.Tag), redirect);
  comboBox.ItemIndex := comboBox.Items.IndexOfObject(Value);
end;

procedure TBinder.LoadRedirectDateTimePickers(datePicker, timePicker: TDateTimePicker;
  redirect: TFieldedTextSequenceRedirect);
var
  Value: DateTime;
  DateValue: TDateTime;
  TimeValue: TDateTime;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(datePicker.Tag), redirect) as DateTime;
  if TDateTime.TryEncodeDate(Value.Year, Value.Month, Value.Day, DateValue) then
    datePicker.Date := DateValue
  else
    datePicker.Date := 0.0;
  if TDateTime.TryEncodeTime(Value.Hour, Value.Minute, Value.Second, Value.Millisecond, TimeValue) then
    timePicker.Time := TimeValue
  else
    timePicker.Time := 0.0;
end;

procedure TBinder.LoadRedirectDecimalEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
var
  ValueAsObject: TObject;
  Culture: CultureInfo;
begin
  ValueAsObject := GetRedirectPropertyValue(TagToPropertyId(edit.Tag), redirect);
  Culture := FEditEngine.DisplayCulture;

  if not Assigned(ValueAsObject) then
    edit.Text := ''
  else
    edit.Text := (ValueAsObject as Decimal).ToString(Culture);
  ClearEditError(edit);
end;

procedure TBinder.LoadRedirectDoubleEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
var
  Value: Double;
  Culture: CultureInfo;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(edit.Tag), redirect) as Double;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Value.ToString(Culture);
  ClearEditError(edit);
end;

procedure TBinder.LoadRedirectInt64Edit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
var
  Value: Int64;
  Culture: CultureInfo;
begin
  Value := GetRedirectPropertyValue(TagToPropertyId(edit.Tag), redirect) as Int64;
  Culture := FEditEngine.DisplayCulture;
  edit.Text := Value.ToString(Culture);
  ClearEditError(edit);
end;

procedure TBinder.LoadRedirectStringEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
begin
  edit.Text := GetRedirectPropertyValue(TagToPropertyId(edit.Tag), redirect) as string;
  ClearEditError(edit);
end;

procedure TBinder.LoadStringEdit(edit: TEdit; idx: Integer);
begin
  edit.Text := GetPropertyValue(TagToPropertyId(edit.Tag), idx) as string;
  ClearEditError(edit);
end;

class procedure TBinder.PrepareEndOfLineAutoWriteTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
begin
  comboBox.ItemsEx.Clear;
  comboBox.ItemsEx.AddItem('Local', -1, -1, -1, -1, ftewLocal);
  comboBox.ItemsEx.AddItem('CrLf', -1, -1, -1, -1, ftewCrLf);
  comboBox.ItemsEx.AddItem('Cr', -1, -1, -1, -1, ftewCr);
  comboBox.ItemsEx.AddItem('Lf', -1, -1, -1, -1, ftewLf);

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareEndOfLineTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
begin
  comboBox.ItemsEx.Clear;
  comboBox.ItemsEx.AddItem('Auto', -1, -1, -1, -1, ftetAuto);
  comboBox.ItemsEx.AddItem('Char', -1, -1, -1, -1, ftetChar);
  comboBox.ItemsEx.AddItem('CrLf', -1, -1, -1, -1, ftetCrLf);

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareHeadingConstraintComboBox(comboBox: TComboBoxEx; id: TPropertyId);
begin
  comboBox.ItemsEx.Clear;
  comboBox.ItemsEx.AddItem('None', -1, -1, -1, -1, fthcNone);
  comboBox.ItemsEx.AddItem('All Constant', -1, -1, -1, -1, fthcAllConstant);
  comboBox.ItemsEx.AddItem('Main Constant', -1, -1, -1, -1, fthcMainConstant);
  comboBox.ItemsEx.AddItem('Name Constant', -1, -1, -1, -1, fthcNameConstant);
  comboBox.ItemsEx.AddItem('Name Is Main', -1, -1, -1, -1, fthcNameIsMain);

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PreparePadAlignmentComboBox(comboBox: TComboBoxEx; id: TPropertyId);
begin
  comboBox.ItemsEx.Clear;
  comboBox.ItemsEx.AddItem('Auto', -1, -1, -1, -1, ftpaAuto);
  comboBox.ItemsEx.AddItem('Left', -1, -1, -1, -1, ftpaLeft);
  comboBox.ItemsEx.AddItem('Right', -1, -1, -1, -1, ftpaRight);

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PreparePadCharTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
begin
  comboBox.ItemsEx.Clear;
  comboBox.ItemsEx.AddItem('Auto', -1, -1, -1, -1, ftpcAuto);
  comboBox.ItemsEx.AddItem('Specified', -1, -1, -1, -1, ftpcSpecified);
  comboBox.ItemsEx.AddItem('EndOfValue', -1, -1, -1, -1, ftpcEndOfValue);

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareQuotedTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
begin
  comboBox.ItemsEx.Clear;
  comboBox.ItemsEx.AddItem('Never', -1, -1, -1, -1, ftqtNever);
  comboBox.ItemsEx.AddItem('Always', -1, -1, -1, -1, ftqtAlways);
  comboBox.ItemsEx.AddItem('Optional', -1, -1, -1, -1, ftqtOptional);

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareRedirectInvokationDelayComboBox(
  comboBox: TComboBoxEx; id: TPropertyId);
begin
  comboBox.ItemsEx.Clear;
  comboBox.ItemsEx.AddItem('After Field', -1, -1, -1, -1, ftikAfterField);
  comboBox.ItemsEx.AddItem('After Sequence', -1, -1, -1, -1, ftikAfterSequence);

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareTruncateTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
begin
  comboBox.ItemsEx.Clear;
  comboBox.ItemsEx.AddItem('Left', -1, -1, -1, -1, ftttLeft);
  comboBox.ItemsEx.AddItem('Right', -1, -1, -1, -1, ftttRight);
  comboBox.ItemsEx.AddItem('TruncateChar', -1, -1, -1, -1, ftttTruncateChar);
  comboBox.ItemsEx.AddItem('NullChar', -1, -1, -1, -1, ftttNullChar);
  comboBox.ItemsEx.AddItem('Exception', -1, -1, -1, -1, ftttException);

  comboBox.Tag := CreateControlTag(id);
end;

class procedure TBinder.PrepareMetaReferenceTypeComboBox(comboBox: TComboBoxEx; id: TPropertyId);
begin
  comboBox.ItemsEx.Clear;
  comboBox.ItemsEx.AddItem('None', -1, -1, -1, -1, ftmrNone);
  comboBox.ItemsEx.AddItem('Embedded', -1, -1, -1, -1, ftmrEmbedded);
  comboBox.ItemsEx.AddItem('File', -1, -1, -1, -1, ftmrFile);
  comboBox.ItemsEx.AddItem('Url', -1, -1, -1, -1, ftmrUrl);

  comboBox.Tag := CreateControlTag(id);
end;

class function TBinder.CreateControlTag(value: TPropertyId): Variant;
begin
  Result := Variant(TControlTag.Create(value));
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
      FErrorCountChangeEvent;
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

procedure TBinder.SetPropertyValue(id: TPropertyId; idx: Integer; value: TObject; out modified: Boolean);
var
  Name: string;
  Cat: TEditEngine.TPropertyCategory;
begin
  Cat := PropArray[id].Cat;
  Name := GetPropertyName(id);
  FEditEngine.SetPropertyValue(Name, idx, Cat, value, modified);
end;

procedure TBinder.SetRedirectPropertyValue(id: TPropertyId; redirect: TFieldedTextSequenceRedirect; value: TObject;
  out modified: Boolean);
var
  Name: string;
begin
  Name := GetPropertyName(id);
  FEditEngine.SetRedirectPropertyValue(Name, redirect, value, modified);
end;

procedure TBinder.SetRedirectSequence(redirect: TFieldedTextSequenceRedirect; value: TObject);
var
  Modified: Boolean;
begin
  SetRedirectPropertyValue(piRedirectSequence, redirect, value, Modified);
  CheckRefresh(piRedirectSequence, Modified);
end;

procedure TBinder.SetSequenceItemField(sequenceItem: TFieldedTextSequenceItem; value: TObject);
var
  Modified: Boolean;
begin
  SetSequenceItemPropertyValue(piSequenceItemField, sequenceItem, value, Modified);
  CheckRefresh(piSequenceItemField, Modified);
end;

procedure TBinder.SetSequenceItemPropertyValue(id: TPropertyId; sequenceItem: TFieldedTextSequenceItem; value: TObject;
  out modified: Boolean);
var
  Name: string;
begin
  Name := GetPropertyName(id);
  FEditEngine.SetSequenceItemPropertyValue(Name, sequenceItem, value, modified);
end;

function TBinder.TryDisplayDecimalToChar(decimalStr: string; out value: Char): Boolean;
var
  Culture: CultureInfo;
  Int64Value: Int64;
  I: Integer;
  Bytes: TBytes;
  BytesLength: Integer;
  PowerValue: Int64;
  CharEncoding: Encoding;
  CharCount: Integer;
  Chars: array of Char;
begin
  Result := True;
  Culture := FEditEngine.DisplayCulture;
  try
    Int64Value := System.Int64.Parse(decimalStr, Culture);
  except
    on FormatException do
    begin
      Int64Value := 0;
      Result := False;
    end;
    on OverflowException do
    begin
      Int64Value := 0;
      Result := False;
    end;
  end;

  if Result then
  begin
    SetLength(Bytes, 8);
    BytesLength := 1;

    for I := 7 downto 0 do
    begin
      PowerValue := Convert.ToInt64(Math.Round(Math.Pow(256, I)));
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
  Culture: CultureInfo;
  Int64Value: Int64;
  I: Integer;
  Bytes: TBytes;
  BytesLength: Integer;
  PowerValue: Int64;
  CharEncoding: Encoding;
  CharCount: Integer;
  Chars: array of Char;
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
    try
      Int64Value := System.Int64.Parse(hexStr, NumberStyles.HexNumber, Culture);
    except
      on FormatException do
      begin
        Int64Value := 0;
        Result := False;
      end;
      on OverflowException do
      begin
        Int64Value := 0;
        Result := False;
      end;
    end;

    if Result then
    begin
      SetLength(Bytes, BytesLength);
      for I := BytesLength-1 downto 0 do
      begin
        PowerValue := Convert.ToInt64(Math.Round(Math.Pow(256, I)));
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

function TBinder.TryParseBooleanStylesDisplay(display: string; out value: TBooleanStyles): Boolean;
begin
  try
    value := Enum.Parse(TypeOf(TBooleanStyles), display, True) as TBooleanStyles;
    Result := True;
  except
    on ArgumentException do
    begin
      Result := False;
    end;
  end;
end;

function TBinder.TryParseCommaTextDisplay(display: string): Boolean;
var
  ErrorDescription: string;
begin
  Result := TCommaText.StrictValidate(display, ErrorDescription);
end;

function TBinder.TryParseDateTimeStylesDisplay(display: string; out value: DateTimeStyles): Boolean;
begin
  try
    value := Enum.Parse(TypeOf(DateTimeStyles), display, True) as DateTimeStyles;
    Result := True;
  except
    on ArgumentException do
    begin
      Result := False;
    end;
  end;
end;

function TBinder.TryParseDecimalDisplay(display: string; out value: Decimal): Boolean;
var
  Culture: CultureInfo;
begin
  Culture := FEditEngine.DisplayCulture;

  try
    value := System.Decimal.Parse(display, Culture);
    Result := True;
  except
    on FormatException do Result := False;
    on OverflowException do Result := False;
  end;
end;

function TBinder.TryParseDoubleDisplay(display: string; out value: Double): Boolean;
var
  Culture: CultureInfo;
begin
  Culture := FEditEngine.DisplayCulture;

  try
    value := System.Double.Parse(display, Culture);
    Result := True;
  except
    on FormatException do Result := False;
    on OverflowException do Result := False;
  end;
end;

function TBinder.TryParseInt64Display(display: string; out value: Int64): Boolean;
var
  Culture: CultureInfo;
begin
  Culture := FEditEngine.DisplayCulture;

  try
    value := System.Int64.Parse(display, Culture);
    Result := True;
  except
    on FormatException do Result := False;
    on OverflowException do Result := False;
  end;
end;

function TBinder.TryParseIntegerDisplay(display: string; out value: Integer): Boolean;
var
  Culture: CultureInfo;
begin
  Culture := FEditEngine.DisplayCulture;

  try
    value := System.Int32.Parse(display, Culture);
    Result := True;
  except
    on FormatException do Result := False;
    on OverflowException do Result := False;
  end;
end;

function TBinder.TryParseNonViewableCharDisplay(display: string; out value: Char): Boolean;
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

function TBinder.TryParseNumberStylesDisplay(display: string; out value: NumberStyles): Boolean;
begin
  try
    value := Enum.Parse(TypeOf(NumberStyles), display, True) as NumberStyles;
    Result := True;
  except
    on ArgumentException do
    begin
      Result := False;
    end;
  end;
end;

constructor TBinder.TControlTag.Create(myPropertyId: TPropertyId);
begin
  inherited Create;
  FPropertyId := myPropertyId;
end;

procedure TBinder.SaveDoubleEdit(edit: TEdit; redirect: TFieldedTextSequenceRedirect);
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
    SetRedirectPropertyValue(Id, redirect, Value as TObject, Modified);

    if not CheckRefresh(Id, Modified) then
    begin
      LoadRedirectDoubleEdit(edit, redirect);
    end;
  end;
end;

end.
