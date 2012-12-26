// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.MainPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Tabs, DockTabSet,
  ButtonGroup, CategoryButtons, ExtCtrls, Grids, ValEdit,
  Xilytix.FTEditor.LayoutableFrame,
  Xilytix.FTEditor.EditorFrame,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.EditEngine;

type
  TMainPropertiesFrame = class(TEditorFrame)
    PageControl: TPageControl;
    MainTabSheet: TTabSheet;
    CultureEditLabel: TLabel;
    CultureEdit: TEdit;
    HeadingTabSheet: TTabSheet;
    DesignTabSheet: TTabSheet;
    SubstitutionsTabSheet: TTabSheet;
    FileTabSheet: TTabSheet;
    Label2: TLabel;
    DelimiterCharEdit: TEdit;
    Label3: TLabel;
    QuoteCharEdit: TEdit;
    Label4: TLabel;
    CommentCharEdit: TEdit;
    IgnoreBlankLinesCheckBox: TCheckBox;
    AllowInQuotesCheckBox: TCheckBox;
    IgnoreExtraCharsCheckBox: TCheckBox;
    Label6: TLabel;
    EndOfLineTypeComboBox: TComboBox;
    Label7: TLabel;
    EndOfLineCharEdit: TEdit;
    Label8: TLabel;
    EndOfLineAutoWriteComboBox: TComboBox;
    Bevel1: TBevel;
    Label9: TLabel;
    HeadingConstraintComboBox: TComboBox;
    HeadingQuotedTypeComboBox: TComboBox;
    HeadingPadAlignmentComboBox: TComboBox;
    HeadingPadCharTypeComboBox: TComboBox;
    HeadingPadEoFCharEdit: TEdit;
    HeadingTruncateTypeComboBox: TComboBox;
    HeadingLineCountEdit: TEdit;
    HeadingMainLineIndexEdit: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Bevel2: TBevel;
    Label12: TLabel;
    Label13: TLabel;
    StuffedEmbeddedQuotesCheckBox: TCheckBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    FileParametersValueListEditor: TValueListEditor;
    Panel1: TPanel;
    DeclaredCheckBox: TCheckBox;
    Label17: TLabel;
    MetaReferenceTypeComboBox: TComboBox;
    MetaReferenceEdit: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Bevel3: TBevel;
    Label21: TLabel;
    Label22: TLabel;
    HeadingPadCharEdit: TEdit;
    Bevel4: TBevel;
    Label23: TLabel;
    Label24: TLabel;
    HeadingTruncateCharEdit: TEdit;
    SubstitutionsTopPanel: TPanel;
    Label5: TLabel;
    SubstitutionCharEdit: TEdit;
    SubstitutionsEnabledCheckBox: TCheckBox;
    SaveDesignOnlyMetaCheckBox: TCheckBox;
    Bevel5: TBevel;
    Label25: TLabel;
    DesignNewFieldFormatIntegerEdit: TEdit;
    Label27: TLabel;
    DesignNewFieldFormatFloatEdit: TEdit;
    Label28: TLabel;
    DesignNewFieldFormatDecimalEdit: TEdit;
    Label29: TLabel;
    DesignNewFieldFormatDateTimeEdit: TEdit;
    Label30: TLabel;
    Bevel6: TBevel;
    Label31: TLabel;
    DesignNewFieldStylesIntegerEdit: TEdit;
    Label33: TLabel;
    DesignNewFieldStylesFloatEdit: TEdit;
    Label34: TLabel;
    DesignNewFieldStylesDecimalEdit: TEdit;
    Label35: TLabel;
    DesignNewFieldStylesDateTimeEdit: TEdit;
    Label36: TLabel;
    FileNoteLabel: TLabel;
    SubstitutionPropertiesPanel: TPanel;
    SubstitutionsListPanel: TPanel;
    Label38: TLabel;
    SubstitutionsSplitter: TSplitter;
    SubstitutionsButtonGroup: TButtonGroup;
    SubstitutionTypeStringRadioButton: TRadioButton;
    SubstitutionStringValueEdit: TEdit;
    SubstitutionTypeCharRadioButton: TRadioButton;
    SubstitutionCharValueEdit: TEdit;
    SubstitutionTypeAutoEndOfLineRadioButton: TRadioButton;
    SubstitutionTypeXmlCharLessThanRadioButton: TRadioButton;
    Label39: TLabel;
    SubstitutionTokenEdit: TEdit;
    Bevel7: TBevel;
    Label40: TLabel;
    SubstitutionTypeXmlCharGreaterThanRadioButton: TRadioButton;
    SubstitutionTypeXmlCharAmpersandRadioButton: TRadioButton;
    SubstitutionTypeXmlCharApostropheRadioButton: TRadioButton;
    SubstitutionTypeXmlCharQuotationMarkRadioButton: TRadioButton;
    SubstitutionsAddButton: TButton;
    SubstitutionAddRemovePanel: TPanel;
    SubstitutionsRemoveButton: TButton;
    DesignNewFieldStylesIntegerButton: TButton;
    DesignNewFieldStylesFloatButton: TButton;
    DesignNewFieldStylesDecimalButton: TButton;
    DesignNewFieldStylesDateTimeButton: TButton;
    Label32: TLabel;
    DesignNewFieldStylesBooleanEdit: TEdit;
    DesignNewFieldsStyleBooleanButton: TButton;
    Label26: TLabel;
    Label37: TLabel;
    DesignNewFieldTrueTextEdit: TEdit;
    DesignNewFieldFalseTextEdit: TEdit;
    HeadingWritePrefixSpaceCheckBox: TCheckBox;
    HeadingAlwaysWriteOptionalQuoteCheckBox: TCheckBox;
    IncompleteRecordsAllowedCheckBox: TCheckBox;
    procedure CharEditKeyPress(Sender: TObject; var Key: Char);
    procedure CharEditExit(Sender: TObject);
    procedure CultureEditExit(Sender: TObject);
    procedure CultureEditKeyPress(Sender: TObject; var Key: Char);
    procedure SubstitutionsAddButtonClick(Sender: TObject);
    procedure SubstitutionsRemoveButtonClick(Sender: TObject);
    procedure SubstitutionsButtonGroupClick(Sender: TObject);
    procedure SubstitutionTokenEditExit(Sender: TObject);
    procedure SubstitutionTokenEditKeyPress(Sender: TObject; var Key: Char);
    procedure SubstitutionCharValueEditExit(Sender: TObject);
    procedure SubstitutionCharValueEditKeyPress(Sender: TObject; var Key: Char);
    procedure SubstitutionCharValueEditEnter(Sender: TObject);
    procedure SubstitutionStringValueEditEnter(Sender: TObject);
    procedure SubstitutionTypeCharRadioButtonClick(Sender: TObject);
    procedure SubstitutionTypeStringRadioButtonClick(Sender: TObject);
    procedure SubstitutionTypeAutoEndOfLineRadioButtonClick(Sender: TObject);
    procedure SubstitutionTypeXmlCharLessThanRadioButtonClick(Sender: TObject);
    procedure SubstitutionTypeXmlCharGreaterThanRadioButtonClick(Sender: TObject);
    procedure SubstitutionTypeXmlCharAmpersandRadioButtonClick(Sender: TObject);
    procedure SubstitutionTypeXmlCharApostropheRadioButtonClick(Sender: TObject);
    procedure SubstitutionTypeXmlCharQuotationMarkRadioButtonClick(Sender: TObject);
    procedure SubstitutionStringValueEditExit(Sender: TObject);
    procedure SubstitutionStringValueEditKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxClick(Sender: TObject);
    procedure IntegerEditExit(Sender: TObject);
    procedure IntegerEditKeyPress(Sender: TObject; var Key: Char);
    procedure StringEditExit(Sender: TObject);
    procedure StringEditKeyPress(Sender: TObject; var Key: Char);
    procedure DesignNewFieldStylesDateTimeEditKeyPress(Sender: TObject; var Key: Char);
    procedure DesignNewFieldStylesDateTimeEditExit(Sender: TObject);
    procedure DesignNewFieldStylesIntegerEditExit(Sender: TObject);
    procedure DesignNewFieldStylesIntegerEditKeyPress(Sender: TObject; var Key: Char);
    procedure DesignNewFieldStylesFloatEditExit(Sender: TObject);
    procedure DesignNewFieldStylesFloatEditKeyPress(Sender: TObject; var Key: Char);
    procedure DesignNewFieldStylesDecimalEditExit(Sender: TObject);
    procedure DesignNewFieldStylesDecimalEditKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxChange(Sender: TObject);
    procedure DesignNewFieldStylesIntegerButtonClick(Sender: TObject);
    procedure DesignNewFieldStylesFloatButtonClick(Sender: TObject);
    procedure DesignNewFieldStylesDecimalButtonClick(Sender: TObject);
    procedure DesignNewFieldStylesDateTimeButtonClick(Sender: TObject);
    procedure DesignNewFieldStylesBooleanEditExit(Sender: TObject);
    procedure DesignNewFieldStylesBooleanEditKeyPress(Sender: TObject; var Key: Char);
    procedure DesignNewFieldsStyleBooleanButtonClick(Sender: TObject);
  private
    { Private declarations }
    var
      FLoadingControlsCount: Integer;
      FActiveSubstitutionIdx: Integer;

    procedure HandleRefreshMainEvent;
    procedure HandleParseEvent;

    function CalculateSubstitutionCaption(idx: Integer): string;

    procedure Refresh;
    procedure RefreshDeclaration;
    procedure RefreshSubstitutions;
    procedure RefreshActiveSubstitution(forceStringOverChar: Boolean = False);

    procedure SelectSubstitution(idx: Integer); overload;
    procedure SelectSubstitution(token: Char); overload;

    procedure SaveSubstitutionTokenEdit;
    procedure SaveSubstitutionStringValueEdit;
    procedure SaveSubstitutionCharValueEdit;

    function GetLoadingControls: Boolean;
    property LoadingControls: Boolean read GetLoadingControls;

  protected
    function GetInitialHeight: Integer; override;
    function GetInitialWidth: Integer; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    class function GetTypeId: TLayoutableFrame.TTypeId; override;
    class function GetTypeName: string; override;
    class function GetTypeCaption: string; override;

    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder); override;
    procedure Unprepare; override;
  end;

implementation

{$R *.dfm}

uses
  Rtti,
  Xilytix.FieldedText.Utils,
  Xilytix.FieldedText.StandardFields,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.Configuration;

{ TMainPropertiesFrame }

function TMainPropertiesFrame.CalculateSubstitutionCaption(idx: Integer): string;
var
  TypeStr: string;
begin
  Result := FEditEngine.SubstitutionToken[idx] + ' : ';
  case FEditEngine.SubstitutionType[idx] of
    ftsbString: TypeStr := '"' + FEditEngine.SubstitutionValue[idx] + '"';
    ftsbAutoEndOfLine: TypeStr := 'EoL';
    ftsbXmlCharLessThan: TypeStr := '<';
    ftsbXmlCharGreaterThan: TypeStr := '>';
    ftsbXmlCharAmpersand: TypeStr := '&&';
    ftsbXmlCharApostrophe: TypeStr := '''';
    ftsbXmlCharQuotationMark: TypeStr := '"';
    else
    begin
      TypeStr := '?';
      Assert(False);
    end;
  end;

  Result := Result + TypeStr;
end;

procedure TMainPropertiesFrame.CharEditExit(Sender: TObject);
begin
  FBinder.HandleCharEditExit(Sender as TEdit, 0);
end;

procedure TMainPropertiesFrame.CharEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleCharEditKeyPress(Sender as TEdit, 0, Key);
end;

procedure TMainPropertiesFrame.CheckBoxClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    FBinder.HandleCheckBoxClick(Sender as TCheckBox, 0);
  end;
end;

procedure TMainPropertiesFrame.ComboBoxChange(Sender: TObject);
begin
  FBinder.HandleComboBoxChange(Sender as TComboBox, 0);
end;

constructor TMainPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;
  PageControl.ActivePage := MainTabSheet;

  CultureEdit.Tag := TBinder.CreateControlTag(piCultureName);
  DelimiterCharEdit.Tag := TBinder.CreateControlTag(piDelimiterChar);
  QuoteCharEdit.Tag := TBinder.CreateControlTag(piQuoteChar);
  CommentCharEdit.Tag := TBinder.CreateControlTag(piLineCommentChar);
  EndOfLineCharEdit.Tag := TBinder.CreateControlTag(piEndOfLineChar);
  SubstitutionCharEdit.Tag := TBinder.CreateControlTag(piSubstitutionChar);
  HeadingPadCharEdit.Tag := TBinder.CreateControlTag(piHeadingPadChar);
  HeadingPadEoFCharEdit.Tag := TBinder.CreateControlTag(piHeadingEndOfValueChar);
  HeadingTruncateCharEdit.Tag := TBinder.CreateControlTag(piHeadingTruncateChar);

  IgnoreBlankLinesCheckBox.Tag := TBinder.CreateControlTag(piIgnoreBlankLines);
  AllowInQuotesCheckBox.Tag := TBinder.CreateControlTag(piAllowEndOfLineInQuotes);
  StuffedEmbeddedQuotesCheckBox.Tag := TBinder.CreateControlTag(piStuffedEmbeddedQuotes);
  IgnoreExtraCharsCheckBox.Tag := TBinder.CreateControlTag(piIgnoreExtraChars);
  IncompleteRecordsAllowedCheckBox.Tag := TBinder.CreateControlTag(piIncompleteRecordsAllowed);
  HeadingWritePrefixSpaceCheckBox.Tag := TBinder.CreateControlTag(piHeadingWritePrefixSpace);
  HeadingAlwaysWriteOptionalQuoteCheckBox.Tag := TBinder.CreateControlTag(piHeadingAlwaysWriteOptionalQuote);
  SubstitutionsEnabledCheckBox.Tag := TBinder.CreateControlTag(piSubstitutionsEnabled);
  DeclaredCheckBox.Tag := TBinder.CreateControlTag(piDeclared);

  HeadingLineCountEdit.Tag := TBinder.CreateControlTag(piHeadingLineCount);
  HeadingMainLineIndexEdit.Tag := TBinder.CreateControlTag(piMainHeadingLineIndex);

  SubstitutionCharEdit.Tag := TBinder.CreateControlTag(piSubstitutionChar);
  SubstitutionTokenEdit.Tag := TBinder.CreateControlTag(piSubstitutionToken);
  SubstitutionCharValueEdit.Tag := TBinder.CreateControlTag(piSubstitutionValue);

  DesignNewFieldFalseTextEdit.Tag := TBinder.CreateControlTag(piNewBooleanFieldFalseText);
  DesignNewFieldTrueTextEdit.Tag := TBinder.CreateControlTag(piNewBooleanFieldTrueText);
  DesignNewFieldFormatIntegerEdit.Tag := TBinder.CreateControlTag(piNewIntegerFieldFormat);
  DesignNewFieldFormatFloatEdit.Tag := TBinder.CreateControlTag(piNewFloatFieldFormat);
  DesignNewFieldFormatDecimalEdit.Tag := TBinder.CreateControlTag(piNewDecimalFieldFormat);
  DesignNewFieldFormatDateTimeEdit.Tag := TBinder.CreateControlTag(piNewDateTimeFieldFormat);

  DesignNewFieldStylesBooleanEdit.Tag := TBinder.CreateControlTag(piNewBooleanFieldStyles);
  DesignNewFieldStylesIntegerEdit.Tag := TBinder.CreateControlTag(piNewIntegerFieldStyles);
  DesignNewFieldStylesFloatEdit.Tag := TBinder.CreateControlTag(piNewFloatFieldStyles);
  DesignNewFieldStylesDecimalEdit.Tag := TBinder.CreateControlTag(piNewDecimalFieldStyles);
  DesignNewFieldStylesDateTimeEdit.Tag := TBinder.CreateControlTag(piNewDateTimeFieldStyles);

  TBinder.PrepareEndOfLineTypeComboBox(EndOfLineTypeComboBox, piEndOfLineType);
  TBinder.PrepareEndOfLineAutoWriteTypeComboBox(EndOfLineAutoWriteComboBox, piEndOfLineAutoWriteType);
  TBinder.PrepareHeadingConstraintComboBox(HeadingConstraintComboBox, piHeadingConstraint);
  TBinder.PrepareQuotedTypeComboBox(HeadingQuotedTypeComboBox, piHeadingQuotedType);
  TBinder.PreparePadAlignmentComboBox(HeadingPadAlignmentComboBox, piHeadingPadAlignment);
  TBinder.PreparePadCharTypeComboBox(HeadingPadCharTypeComboBox, piHeadingPadCharType);
  TBinder.PrepareTruncateTypeComboBox(HeadingTruncateTypeComboBox,piHeadingTruncateType);

  TBinder.PrepareMetaReferenceTypeComboBox(MetaReferenceTypeComboBox, piMetaReferenceType);
  MetaReferenceEdit.Tag := TBinder.CreateControlTag(piMetaReference);

  FActiveSubstitutionIdx := -1;
end;

procedure TMainPropertiesFrame.CultureEditExit(Sender: TObject);
begin
  FBinder.SaveCultureEdit(CultureEdit, 0);
end;

procedure TMainPropertiesFrame.CultureEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    FBinder.SaveCultureEdit(CultureEdit, 0);
    Key := #0;
  end;
end;

procedure TMainPropertiesFrame.DesignNewFieldsStyleBooleanButtonClick(Sender: TObject);
var
  Edit: TEdit;
  BooleanStylesValue: TValue;
  NewValue: string;
  DefaultStyles: TBooleanStyles;
begin
  Edit := DesignNewFieldStylesBooleanEdit;
  DefaultStyles := TFieldedTextField_Boolean.DefaultStyles;
  BooleanStylesValue := FBinder.GetPropertyValue(Edit, 0);

  if FBinder.EditBooleanStyles(Self,
                               Edit.Text,
                               BooleanStylesValue.AsType<TBooleanStyles>,
                               DefaultStyles,
                               NewValue) then
  begin
    Edit.Text := NewValue;
    FBinder.SaveBooleanStylesEdit(Edit, 0, DefaultStyles);
  end;
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesBooleanEditExit(Sender: TObject);
begin
  FBinder.SaveBooleanStylesEdit(Sender as TEdit, 0, TFieldedTextField_Boolean.DefaultStyles);
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesBooleanEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleBooleanStylesEditKeyPress(Sender as TEdit, 0, TFieldedTextField_Boolean.DefaultStyles, Key);
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesDateTimeButtonClick(Sender: TObject);
var
  Edit: TEdit;
  NewValue: string;
  StylesValue: TValue;
  DefaultStyles: TDotNetDateTimeStyles;
begin
  Edit := DesignNewFieldStylesDateTimeEdit;
  DefaultStyles := TFieldedTextField_DateTime.DefaultStyles;
  StylesValue := FBinder.GetPropertyValue(Edit, 0);

  if FBinder.EditDateTimeStyles(Self,
                                Edit.Text,
                                StylesValue.AsType<TDotNetDateTimeStyles>,
                                DefaultStyles,
                                NewValue) then
  begin
    Edit.Text := NewValue;
    FBinder.SaveDateTimeStylesEdit(Edit, 0, DefaultStyles);
  end;
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesDateTimeEditExit(Sender: TObject);
begin
  FBinder.SaveDateTimeStylesEdit(Sender as TEdit, 0, TFieldedTextField_DateTime.DefaultStyles);
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesDateTimeEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleDateTimeStylesEditKeyPress(Sender as TEdit, 0, TFieldedTextField_DateTime.DefaultStyles, Key);
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesDecimalButtonClick(Sender: TObject);
var
  Edit: TEdit;
  NewValue: string;
  StylesValue: TValue;
  DefaultStyles: TDotNetNumberStyles;
begin
  Edit := DesignNewFieldStylesDecimalEdit;
  DefaultStyles := TFieldedTextField_Decimal.DefaultStyles;
  StylesValue := FBinder.GetPropertyValue(Edit, 0);

  if FBinder.EditNumberStyles(Self,
                              Edit.Text,
                              StylesValue.AsType<TDotNetNumberStyles>,
                              DefaultStyles,
                              NewValue) then
  begin
    Edit.Text := NewValue;
    FBinder.SaveNumberStylesEdit(Edit, 0, DefaultStyles);
  end;
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesDecimalEditExit(Sender: TObject);
begin
  FBinder.SaveNumberStylesEdit(Sender as TEdit, 0, TFieldedTextField_Decimal.DefaultStyles);
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesDecimalEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleNumberStylesEditKeyPress(Sender as TEdit, 0, TFieldedTextField_Decimal.DefaultStyles, Key);
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesFloatButtonClick(Sender: TObject);
var
  Edit: TEdit;
  Value: TValue;
  Styles: TDotNetNumberStyles;
  NewValue: string;
  DefaultStyles: TDotNetNumberStyles;
begin
  Edit := DesignNewFieldStylesFloatEdit;
  DefaultStyles := TFieldedTextField_Float.DefaultStyles;

  Value := FBinder.GetPropertyValue(Edit, 0);
  Styles := Value.AsType<TDotNetNumberStyles>;

  if FBinder.EditNumberStyles(Self,
                              Edit.Text,
                              Styles,
                              DefaultStyles,
                              NewValue) then
  begin
    Edit.Text := NewValue;
    FBinder.SaveNumberStylesEdit(Edit, 0, DefaultStyles);
  end;
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesFloatEditExit(Sender: TObject);
begin
  FBinder.SaveNumberStylesEdit(Sender as TEdit, 0, TFieldedTextField_Float.DefaultStyles);
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesFloatEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleNumberStylesEditKeyPress(Sender as TEdit, 0, TFieldedTextField_Float.DefaultStyles, Key);
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesIntegerButtonClick(Sender: TObject);
var
  Edit: TEdit;
  Value: TValue;
  Styles: TDotNetNumberStyles;
  NewValue: string;
  DefaultStyles: TDotNetNumberStyles;
begin
  Edit := DesignNewFieldStylesIntegerEdit;
  DefaultStyles := TFieldedTextField_Integer.DefaultStyles;

  Value := FBinder.GetPropertyValue(Edit, 0);
  Styles := Value.AsType<TDotNetNumberStyles>;

  if FBinder.EditNumberStyles(Self,
                              Edit.Text,
                              Styles,
                              DefaultStyles,
                              NewValue) then
  begin
    Edit.Text := NewValue;
    FBinder.SaveNumberStylesEdit(Edit, 0, DefaultStyles);
  end;
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesIntegerEditExit(Sender: TObject);
begin
  FBinder.SaveNumberStylesEdit(Sender as TEdit, 0, TFieldedTextField_Integer.DefaultStyles);
end;

procedure TMainPropertiesFrame.DesignNewFieldStylesIntegerEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleNumberStylesEditKeyPress(Sender as TEdit, 0, TFieldedTextField_Integer.DefaultStyles, Key);
end;

function TMainPropertiesFrame.GetInitialHeight: Integer;
begin
  Result := PageControl.TabRect(0).Bottom + DesignNewFieldStylesBooleanEdit.Top + DesignNewFieldStylesBooleanEdit.Height + 6;
end;

function TMainPropertiesFrame.GetInitialWidth: Integer;
begin
  Result := FileNoteLabel.Left + FileNoteLabel.Width + 9;
end;

class function TMainPropertiesFrame.GetTypeCaption: string;
begin
  Result := 'Main';
end;

class function TMainPropertiesFrame.GetTypeId: TLayoutableFrame.TTypeId;
begin
  Result := ftMainProperties;
end;

class function TMainPropertiesFrame.GetTypeName: string;
begin
  Result := 'MainProperties';
end;

function TMainPropertiesFrame.GetLoadingControls: Boolean;
begin
  Result := FLoadingControlsCount <> 0;
end;

procedure TMainPropertiesFrame.HandleParseEvent;
begin
  RefreshDeclaration;
end;

procedure TMainPropertiesFrame.HandleRefreshMainEvent;
begin
  Refresh;
end;

procedure TMainPropertiesFrame.IntegerEditExit(Sender: TObject);
begin
  FBinder.HandleIntegerEditExit(Sender as TEdit, 0);
end;

procedure TMainPropertiesFrame.IntegerEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleIntegerEditKeyPress(Sender as TEdit, 0, Key);
end;

procedure TMainPropertiesFrame.Prepare;
begin
  inherited;
  FEditEngine.SubscribeRefreshMainControlsEvent(HandleRefreshMainEvent);
  FEditEngine.SubscribeParseEvent(HandleParseEvent);
end;

procedure TMainPropertiesFrame.Refresh;
begin
  Inc(FLoadingControlsCount);
  try
    Binder.LoadCultureEdit(CultureEdit, 0);
    Binder.LoadCharEdit(DelimiterCharEdit, 0);
    Binder.LoadCharEdit(QuoteCharEdit, 0);
    Binder.LoadCharEdit(CommentCharEdit, 0);
    Binder.LoadCharEdit(EndOfLineCharEdit, 0);
    Binder.LoadCharEdit(SubstitutionCharEdit, 0);
    Binder.LoadCharEdit(HeadingPadCharEdit, 0);
    Binder.LoadCharEdit(HeadingPadEoFCharEdit, 0);
    Binder.LoadCharEdit(HeadingTruncateCharEdit, 0);

    Binder.LoadCheckBox(IgnoreBlankLinesCheckBox, 0);
    Binder.LoadCheckBox(AllowInQuotesCheckBox, 0);
    Binder.LoadCheckBox(StuffedEmbeddedQuotesCheckBox, 0);
    Binder.LoadCheckBox(IgnoreExtraCharsCheckBox, 0);
    Binder.LoadCheckBox(IncompleteRecordsAllowedCheckBox, 0);
    Binder.LoadCheckBox(HeadingAlwaysWriteOptionalQuoteCheckBox, 0);
    Binder.LoadCheckBox(HeadingWritePrefixSpaceCheckBox, 0);
    Binder.LoadCheckBox(SubstitutionsEnabledCheckBox, 0);

    Binder.LoadIntegerEdit(HeadingLineCountEdit, 0);
    Binder.LoadIntegerEdit(HeadingMainLineIndexEdit, 0);

    Binder.LoadStringEdit(DesignNewFieldFalseTextEdit, 0);
    Binder.LoadStringEdit(DesignNewFieldTrueTextEdit, 0);
    Binder.LoadStringEdit(DesignNewFieldFormatIntegerEdit, 0);
    Binder.LoadStringEdit(DesignNewFieldFormatFloatEdit, 0);
    Binder.LoadStringEdit(DesignNewFieldFormatDecimalEdit, 0);
    Binder.LoadStringEdit(DesignNewFieldFormatDateTimeEdit, 0);

    Binder.LoadBooleanStylesEdit(DesignNewFieldStylesBooleanEdit, 0);
    Binder.LoadNumberStylesEdit(DesignNewFieldStylesIntegerEdit, 0);
    Binder.LoadNumberStylesEdit(DesignNewFieldStylesFloatEdit, 0);
    Binder.LoadNumberStylesEdit(DesignNewFieldStylesDecimalEdit, 0);
    Binder.LoadDateTimeStylesEdit(DesignNewFieldStylesDateTimeEdit, 0);

    Binder.LoadComboBox(EndOfLineTypeComboBox, 0);
    Binder.LoadComboBox(EndOfLineAutoWriteComboBox, 0);
    Binder.LoadComboBox(HeadingConstraintComboBox, 0);
    Binder.LoadComboBox(HeadingQuotedTypeComboBox, 0);
    Binder.LoadComboBox(HeadingPadAlignmentComboBox, 0);
    Binder.LoadComboBox(HeadingPadCharTypeComboBox, 0);
    Binder.LoadComboBox(HeadingTruncateTypeComboBox, 0);

    RefreshDeclaration;

    // Substitutions
    RefreshSubstitutions;
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TMainPropertiesFrame.RefreshActiveSubstitution(forceStringOverChar: Boolean);
var
  ControlsEnabled: Boolean;
  SubstitutionType: TFieldedTextSubstitutionType;
  SubstitutionStr: string;
begin
  ControlsEnabled := FActiveSubstitutionIdx >= 0;

  SubstitutionTokenEdit.Enabled := ControlsEnabled;
  SubstitutionCharValueEdit.Enabled := ControlsEnabled;
  SubstitutionStringValueEdit.Enabled := ControlsEnabled;
  SubstitutionTypeCharRadioButton.Enabled := ControlsEnabled;
  SubstitutionTypeStringRadioButton.Enabled := ControlsEnabled;
  SubstitutionTypeAutoEndOfLineRadioButton.Enabled := ControlsEnabled;
  SubstitutionTypeXmlCharLessThanRadioButton.Enabled := ControlsEnabled;
  SubstitutionTypeXmlCharGreaterThanRadioButton.Enabled := ControlsEnabled;
  SubstitutionTypeXmlCharAmpersandRadioButton.Enabled := ControlsEnabled;
  SubstitutionTypeXmlCharApostropheRadioButton.Enabled := ControlsEnabled;
  SubstitutionTypeXmlCharQuotationMarkRadioButton.Enabled := ControlsEnabled;

  Inc(FLoadingControlsCount);
  try
    if not ControlsEnabled then
    begin
      SubstitutionsButtonGroup.ItemIndex := -1;
      FBinder.ClearEdit(SubstitutionTokenEdit);
      FBinder.ClearEdit(SubstitutionCharValueEdit);
      SubstitutionStringValueEdit.Text := '';
      SubstitutionTypeCharRadioButton.Checked := False;
      SubstitutionTypeStringRadioButton.Checked := False;
      SubstitutionTypeAutoEndOfLineRadioButton.Checked := False;
      SubstitutionTypeXmlCharLessThanRadioButton.Checked := False;
      SubstitutionTypeXmlCharGreaterThanRadioButton.Checked := False;
      SubstitutionTypeXmlCharAmpersandRadioButton.Checked := False;
      SubstitutionTypeXmlCharApostropheRadioButton.Checked := False;
      SubstitutionTypeXmlCharQuotationMarkRadioButton.Checked := False;
    end
    else
    begin
      SubstitutionType := FEditEngine.SubstitutionType[FActiveSubstitutionIdx];
      SubstitutionStr := FEditEngine.SubstitutionValue[FActiveSubstitutionIdx];
      FBinder.LoadCharEdit(SubstitutionTokenEdit, 0, FEditEngine.SubstitutionToken[FActiveSubstitutionIdx]);
      case SubstitutionType of
        ftsbString:
        begin
          if (Length(SubstitutionStr) = 1) and not forceStringOverChar then
            SubstitutionTypeCharRadioButton.Checked := True
          else
            SubstitutionTypeStringRadioButton.Checked := True;
        end;
        ftsbAutoEndOfLine: SubstitutionTypeAutoEndOfLineRadioButton.Checked := True;
        ftsbXmlCharLessThan: SubstitutionTypeXmlCharLessThanRadioButton.Checked := True;
        ftsbXmlCharGreaterThan: SubstitutionTypeXmlCharGreaterThanRadioButton.Checked := True;
        ftsbXmlCharAmpersand: SubstitutionTypeXmlCharAmpersandRadioButton.Checked := True;
        ftsbXmlCharApostrophe: SubstitutionTypeXmlCharApostropheRadioButton.Checked := True;
        ftsbXmlCharQuotationMark: SubstitutionTypeXmlCharQuotationMarkRadioButton.Checked := True;
        else Assert(False);
      end;

      if SubstitutionType <> ftsbString then
      begin
        SubstitutionStringValueEdit.Text := '';
        FBinder.ClearEdit(SubstitutionCharValueEdit);
      end
      else
      begin
        SubstitutionStringValueEdit.Text := SubstitutionStr;

        if SubstitutionStr = '' then
          FBinder.ClearEdit(SubstitutionCharValueEdit)
        else
          FBinder.LoadCharEdit(SubstitutionCharValueEdit, 0, SubstitutionStr[1]);
      end;

      SubstitutionsButtonGroup.Items[FActiveSubstitutionIdx].Caption := CalculateSubstitutionCaption(FActiveSubstitutionIdx);
    end;

  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TMainPropertiesFrame.RefreshSubstitutions;
var
  SelectedToken: Char;
  I: Integer;
  Item: TGrpButtonItem;
begin
  if FActiveSubstitutionIdx < 0 then
    SelectedToken := #0 // avoid compiler warning
  else
    SelectedToken := FEditEngine.SubstitutionToken[FActiveSubstitutionIdx];

  for I := 0 to FEditEngine.SubstitutionCount - 1 do
  begin
    if I < SubstitutionsButtonGroup.Items.Count then
      Item := SubstitutionsButtonGroup.Items[I]
    else
      Item := SubstitutionsButtonGroup.Items.Add;

    Item.Caption := CalculateSubstitutionCaption(I);
  end;

  for I := SubstitutionsButtonGroup.Items.Count - 1 downto FEditEngine.SubstitutionCount do
  begin
    SubstitutionsButtonGroup.Items.Delete(I);
  end;

  if FActiveSubstitutionIdx < 0 then
    SelectSubstitution(-1)
  else
    SelectSubstitution(SelectedToken);
end;

procedure TMainPropertiesFrame.SelectSubstitution(idx: Integer);
begin
  SubstitutionsButtonGroup.ItemIndex := idx;
  FActiveSubstitutionIdx := idx;
  RefreshActiveSubstitution;
end;

procedure TMainPropertiesFrame.SaveSubstitutionCharValueEdit;
var
  Value: Char;
  ValueAsStr: string;
  Modified: Boolean;
begin
  if FBinder.SaveCharEdit(SubstitutionCharValueEdit, Value) then
  begin
    ValueAsStr := Value;
    FBinder.SetPropertyValue(piSubstitutionValue, FActiveSubstitutionIdx, ValueASStr, Modified);
    if Modified then
    begin
      RefreshActiveSubstitution;
    end;
  end;
end;

procedure TMainPropertiesFrame.SaveSubstitutionStringValueEdit;
var
  Modified: Boolean;
begin
  FBinder.SetPropertyValue(piSubstitutionValue, FActiveSubstitutionIdx, SubstitutionStringValueEdit.Text, Modified);
  if Modified then
  begin
    RefreshActiveSubstitution(True);
  end;
end;

procedure TMainPropertiesFrame.SaveSubstitutionTokenEdit;
var
  Value: Char;
  Modified: Boolean;
begin
  if FBinder.SaveCharEdit(SubstitutionTokenEdit, Value) then
  begin
    FBinder.SetPropertyValue(piSubstitutionToken, FActiveSubstitutionIdx, Value, Modified);
    if Modified then
    begin
      RefreshActiveSubstitution;
    end;
  end;
end;

procedure TMainPropertiesFrame.SelectSubstitution(token: Char);
var
  I: Integer;
  Idx: Integer;
begin
  Idx := -1;
  for I := 0 to FEditEngine.SubstitutionCount - 1 do
  begin
    if FEditEngine.SubstitutionToken[I] = token then
    begin
      Idx := I;
      Break;
    end;
  end;
  SelectSubstitution(Idx);
end;

procedure TMainPropertiesFrame.StringEditExit(Sender: TObject);
begin
  FBinder.HandleStringEditExit(Sender as TEdit, 0);
end;

procedure TMainPropertiesFrame.StringEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleStringEditKeyPress(Sender as TEdit, 0, Key);
end;

procedure TMainPropertiesFrame.SubstitutionCharValueEditEnter(Sender: TObject);
begin
  SubstitutionTypeCharRadioButton.Checked := True;
end;

procedure TMainPropertiesFrame.SubstitutionCharValueEditExit(Sender: TObject);
begin
  SaveSubstitutionCharValueEdit;
end;

procedure TMainPropertiesFrame.SubstitutionCharValueEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    SaveSubstitutionCharValueEdit;
    Key := #0;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionsAddButtonClick(Sender: TObject);
begin
  FActiveSubstitutionIdx := FEditEngine.AddSubstitution;
  SubstitutionsButtonGroup.Items.Add;
  SelectSubstitution(FActiveSubstitutionIdx);
end;

procedure TMainPropertiesFrame.SubstitutionsButtonGroupClick(Sender: TObject);
begin
  SelectSubstitution(SubstitutionsButtonGroup.ItemIndex);
end;

procedure TMainPropertiesFrame.SubstitutionsRemoveButtonClick(Sender: TObject);
begin
  if FActiveSubstitutionIdx >= 0 then
  begin
    FEditEngine.DeleteSubstitution(FActiveSubstitutionIdx);
    if FActiveSubstitutionIdx >= FEditEngine.SubstitutionCount then
    begin
      FActiveSubstitutionIdx := FEditEngine.SubstitutionCount - 1;
    end;
    RefreshSubstitutions;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionStringValueEditEnter(Sender: TObject);
begin
  SubstitutionTypeStringRadioButton.Checked := True;
end;

procedure TMainPropertiesFrame.SubstitutionStringValueEditExit(Sender: TObject);
begin
  SaveSubstitutionStringValueEdit;
end;

procedure TMainPropertiesFrame.SubstitutionStringValueEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    SaveSubstitutionStringValueEdit;
    Key := #0;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionTokenEditExit(Sender: TObject);
begin
  SaveSubstitutionTokenEdit;
end;

procedure TMainPropertiesFrame.SubstitutionTokenEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    SaveSubstitutionTokenEdit;
    Key := #0;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionTypeAutoEndOfLineRadioButtonClick(Sender: TObject);
var
  Modified: Boolean;
  Value: TValue;
begin
  if not LoadingControls then
  begin
    Value := TValue.From<TFieldedTextSubstitutionType>(ftsbAutoEndOfLine);
    FBinder.SetPropertyValue(piSubstitutionType, FActiveSubstitutionIdx, Value, Modified);
    if Modified then
    begin
      RefreshActiveSubstitution;
    end;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionTypeCharRadioButtonClick(Sender: TObject);
var
  StrValue: string;
  StrModified: Boolean;
  TypeModified: Boolean;
  Value: TValue;
begin
  if not LoadingControls then
  begin
    StrValue := FEditEngine.SubstitutionValue[FActiveSubstitutionIdx];
    if Length(StrValue) = 1 then
      StrModified := False
    else
    begin
      StrModified := True;

      if StrValue = '' then
        StrValue := '?'
      else
        StrValue := StrValue[1];

      FBinder.SetPropertyValue(piSubstitutionValue, FActiveSubstitutionIdx, StrValue, StrModified);
    end;

    Value := TValue.From<TFieldedTextSubstitutionType>(ftsbString);

    FBinder.SetPropertyValue(piSubstitutionType, FActiveSubstitutionIdx, Value, TypeModified);
    if StrModified or TypeModified then
    begin
      RefreshActiveSubstitution;
    end;

    SubstitutionCharValueEdit.SetFocus;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionTypeStringRadioButtonClick(Sender: TObject);
var
  Value: TValue;
  Modified: Boolean;
begin
  if not LoadingControls then
  begin
    Value := TValue.From<TFieldedTextSubstitutionType>(ftsbString);

    FBinder.SetPropertyValue(piSubstitutionType, FActiveSubstitutionIdx, Value, Modified);
    if Modified then
    begin
      RefreshActiveSubstitution(True);
    end;
    SubstitutionStringValueEdit.SetFocus;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionTypeXmlCharAmpersandRadioButtonClick(Sender: TObject);
var
  Value: TValue;
  Modified: Boolean;
begin
  if not LoadingControls then
  begin
    Value := TValue.From<TFieldedTextSubstitutionType>(ftsbXmlCharAmpersand);
    FBinder.SetPropertyValue(piSubstitutionType, FActiveSubstitutionIdx, Value, Modified);
    if Modified then
    begin
      RefreshActiveSubstitution;
    end;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionTypeXmlCharApostropheRadioButtonClick(Sender: TObject);
var
  Value: TValue;
  Modified: Boolean;
begin
  if not LoadingControls then
  begin
    Value := TValue.From<TFieldedTextSubstitutionType>(ftsbXmlCharApostrophe);
    FBinder.SetPropertyValue(piSubstitutionType, FActiveSubstitutionIdx, Value, Modified);
    if Modified then
    begin
      RefreshActiveSubstitution;
    end;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionTypeXmlCharGreaterThanRadioButtonClick(Sender: TObject);
var
  Value: TValue;
  Modified: Boolean;
begin
  if not LoadingControls then
  begin
    Value := TValue.From<TFieldedTextSubstitutionType>(ftsbXmlCharGreaterThan);
    FBinder.SetPropertyValue(piSubstitutionType, FActiveSubstitutionIdx, Value, Modified);
    if Modified then
    begin
      RefreshActiveSubstitution;
    end;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionTypeXmlCharLessThanRadioButtonClick(Sender: TObject);
var
  Value: TValue;
  Modified: Boolean;
begin
  if not LoadingControls then
  begin
    Value := TValue.From<TFieldedTextSubstitutionType>(ftsbXmlCharLessThan);
    FBinder.SetPropertyValue(piSubstitutionType, FActiveSubstitutionIdx, Value, Modified);
    if Modified then
    begin
      RefreshActiveSubstitution;
    end;
  end;
end;

procedure TMainPropertiesFrame.SubstitutionTypeXmlCharQuotationMarkRadioButtonClick(Sender: TObject);
var
  Value: TValue;
  Modified: Boolean;
begin
  if not LoadingControls then
  begin
//    Value := TValue.From<TFieldedTextSubstitution.TFieldedTextSubstitutionType>(ftsbXmlCharQuotationMark);
    FBinder.SetPropertyValue(piSubstitutionType, FActiveSubstitutionIdx, Value, Modified);
    if Modified then
    begin
      RefreshActiveSubstitution;
    end;
  end;
end;

procedure TMainPropertiesFrame.Unprepare;
begin
  FEditEngine.UnsubscribeRefreshMainControlsEvent(HandleRefreshMainEvent);
  FEditEngine.UnsubscribeParseEvent(HandleParseEvent);
  inherited;
end;

procedure TMainPropertiesFrame.RefreshDeclaration;
begin
  Binder.LoadCheckBox(DeclaredCheckBox, 0);
  Binder.LoadComboBox(MetaReferenceTypeComboBox, 0);
  Binder.LoadStringEdit(MetaReferenceEdit, 0);
end;

end.
