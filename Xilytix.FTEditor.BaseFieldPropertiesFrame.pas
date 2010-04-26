// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.BaseFieldPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Borland.Vcl.StdCtrls, System.ComponentModel, Borland.Vcl.ComCtrls, Borland.Vcl.ExtCtrls,
  Xilytix.FieldedText.BaseField,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.EditEngine, StdCtrls, ComCtrls, ExtCtrls;

type
  TBaseFieldPropertiesFrame = class(TFrame)
    TopPanel: TPanel;
    Label1: TLabel;
    NameEdit: TEdit;
    IdEdit: TEdit;
    Label3: TLabel;
    HeadingConstraintComboBox: TComboBoxEx;
    Label2: TLabel;
    FixedWidthPanel: TPanel;
    FixedWidthPageControl: TPageControl;
    ValueTabSheet: TTabSheet;
    HeadingTabSheet: TTabSheet;
    FxiedWidthTopPanel: TPanel;
    Label9: TLabel;
    WidthEdit: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Bevel3: TBevel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Bevel4: TBevel;
    Label16: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    ValuePadAlignmentComboBox: TComboBoxEx;
    ValuePadCharTypeComboBox: TComboBoxEx;
    ValuePadEoFCharEdit: TEdit;
    ValueTruncateTypeComboBox: TComboBoxEx;
    ValuePadCharEdit: TEdit;
    ValueTruncateCharEdit: TEdit;
    ValueNullCharEdit: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Bevel1: TBevel;
    Label13: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Bevel2: TBevel;
    Label19: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    HeadingPadAlignmentComboBox: TComboBoxEx;
    HeadingPadCharTypeComboBox: TComboBoxEx;
    HeadingPadEoFCharEdit: TEdit;
    HeadingTruncateTypeComboBox: TComboBoxEx;
    HeadingPadCharEdit: TEdit;
    HeadingTruncateCharEdit: TEdit;
    NullConstantCheckBox: TCheckBox;
    ConstantCheckBox: TCheckBox;
    DataTypeLabel: TLabel;
    DelimitedPanel: TPanel;
    Label5: TLabel;
    ValueQuotedComboBox: TComboBoxEx;
    Label4: TLabel;
    HeadingQuotedComboBox: TComboBoxEx;
    ValueWritePrefixSpaceCheckBox: TCheckBox;
    ValueAlwaysWriteOptionalQuoteCheckBox: TCheckBox;
    HeadingWritePrefixSpaceCheckBox: TCheckBox;
    HeadingAlwaysWriteOptionalQuoteCheckBox: TCheckBox;
    DelimitedRadioButton: TRadioButton;
    FixedWidthRadioButton: TRadioButton;
    Bevel5: TBevel;
    DelimitedValueLabel: TLabel;
    DelimitedHeadingLabel: TLabel;
    Bevel6: TBevel;
    HeadingsEdit: TEdit;
    HeadingsLabel: TLabel;
    HeadingsButton: TButton;
    procedure CharEditExit(Sender: TObject);
    procedure CharEditKeyPress(Sender: TObject; var Key: Char);
    procedure StringEditExit(Sender: TObject);
    procedure StringEditKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxClick(Sender: TObject);
    procedure IntegerEditExit(Sender: TObject);
    procedure IntegerEditKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxChange(Sender: TObject);
    procedure FixedWidthRadioButtonClick(Sender: TObject);
    procedure DelimitedRadioButtonClick(Sender: TObject);
    procedure HeadingsButtonClick(Sender: TObject);
    procedure CommaTextEditExit(Sender: TObject);
    procedure CommaTextEditKeyPress(Sender: TObject; var Key: Char);
  strict private
    { Private declarations }

  strict protected
    var
      FEditEngine: TEditEngine;
      FBinder: TBinder;

      FLoadingControlsCount: Integer;
      FFieldIndex: Integer;

    function GetImplicitWidth: Integer; virtual;

    function GetLoadingControls: Boolean;
    property LoadingControls: Boolean read GetLoadingControls;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    property ImplicitWidth: Integer read GetImplicitWidth;

    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder; myFieldIndex: Integer); virtual;
    procedure Unprepare; virtual;

    property FieldIndex: Integer read FFieldIndex write FFieldIndex;
    procedure Refresh; virtual;
    procedure RefreshName;

    class function GetAddCaption: string; virtual;
    class function GetDataType: TFieldedTextFieldDataType; virtual;
  end;

  TBaseFieldPropertiesFrameClass = class of TBaseFieldPropertiesFrame;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.FieldHeadingsForm;

{ TBaseFieldPropertiesFrame }

procedure TBaseFieldPropertiesFrame.CharEditExit(Sender: TObject);
begin
  FBinder.HandleCharEditExit(Sender as TEdit, FFieldIndex);
end;

procedure TBaseFieldPropertiesFrame.CharEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleCharEditKeyPress(Sender as TEdit, FFieldIndex, Key);
end;

procedure TBaseFieldPropertiesFrame.CheckBoxClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    FBinder.HandleCheckBoxClick(Sender as TCheckBox, FFieldIndex);
  end;
end;

procedure TBaseFieldPropertiesFrame.ComboBoxChange(Sender: TObject);
begin
  FBinder.HandleComboBoxChange(Sender as TComboBoxEx, FFieldIndex);
end;

procedure TBaseFieldPropertiesFrame.CommaTextEditExit(Sender: TObject);
begin
  FBinder.HandleCommaTextEditExit(Sender as TEdit, FFieldIndex);
end;

procedure TBaseFieldPropertiesFrame.CommaTextEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleCommaTextEditKeyPress(Sender as TEdit, FFieldIndex, Key);
end;

constructor TBaseFieldPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  NameEdit.Tag := TBinder.CreateControlTag(piName);
  IdEdit.Tag := TBinder.CreateControlTag(piId);
  HeadingsEdit.Tag := TBinder.CreateControlTag(piFieldHeadings);
  TBinder.PrepareHeadingConstraintComboBox(HeadingConstraintComboBox, piFieldHeadingConstraint);
  ConstantCheckBox.Tag := TBinder.CreateControlTag(piConstant);
  NullConstantCheckBox.Tag := TBinder.CreateControlTag(piNull);
  FixedWidthRadioButton.Tag := TBinder.CreateControlTag(piFixedWidth);

  TBinder.PrepareQuotedTypeComboBox(ValueQuotedComboBox, piValueQuotedType);
  ValueAlwaysWriteOptionalQuoteCheckBox.Tag := TBinder.CreateControlTag(piValueAlwaysWriteOptionalQuote);
  ValueWritePrefixSpaceCheckBox.Tag := TBinder.CreateControlTag(piValueWritePrefixSpace);
  TBinder.PrepareQuotedTypeComboBox(HeadingQuotedComboBox, piFieldHeadingQuotedType);
  HeadingAlwaysWriteOptionalQuoteCheckBox.Tag := TBinder.CreateControlTag(piFieldHeadingAlwaysWriteOptionalQuote);
  HeadingWritePrefixSpaceCheckBox.Tag := TBinder.CreateControlTag(piFieldHeadingWritePrefixSpace);

  WidthEdit.Tag := TBinder.CreateControlTag(piWidth);
  TBinder.PreparePadCharTypeComboBox(ValuePadCharTypeComboBox, piValuePadCharType);
  TBinder.PreparePadAlignmentComboBox(ValuePadAlignmentComboBox, piValuePadAlignment);
  ValuePadCharEdit.Tag := TBinder.CreateControlTag(piValuePadChar);
  ValuePadEoFCharEdit.Tag := TBinder.CreateControlTag(piValueEndOfValueChar);
  TBinder.PrepareTruncateTypeComboBox(ValueTruncateTypeComboBox, piValueTruncateType);
  ValueTruncateCharEdit.Tag := TBinder.CreateControlTag(piValueTruncateChar);
  ValueNullCharEdit.Tag := TBinder.CreateControlTag(piValueNullChar);
  TBinder.PreparePadCharTypeComboBox(HeadingPadCharTypeComboBox, piFieldHeadingPadCharType);
  TBinder.PreparePadAlignmentComboBox(HeadingPadAlignmentComboBox, piFieldHeadingPadAlignment);
  HeadingPadCharEdit.Tag := TBinder.CreateControlTag(piFieldHeadingPadChar);
  HeadingPadEoFCharEdit.Tag := TBinder.CreateControlTag(piFieldHeadingEndOfValueChar);
  TBinder.PrepareTruncateTypeComboBox(HeadingTruncateTypeComboBox, piFieldHeadingTruncateType);
  HeadingTruncateCharEdit.Tag := TBinder.CreateControlTag(piFieldHeadingTruncateChar);
end;

procedure TBaseFieldPropertiesFrame.DelimitedRadioButtonClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    FBinder.HandleRadioButtonClick(FixedWidthRadioButton, FFieldIndex);
  end;
end;

procedure TBaseFieldPropertiesFrame.FixedWidthRadioButtonClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    FBinder.HandleRadioButtonClick(Sender as TRadioButton, FFieldIndex);
  end;
end;

class function TBaseFieldPropertiesFrame.GetAddCaption: string;
begin
  Result := '';
end;

class function TBaseFieldPropertiesFrame.GetDataType: TFieldedTextFieldDataType;
begin
  Result := ftdtCustom;
  Assert(False);
end;

function TBaseFieldPropertiesFrame.GetImplicitWidth: Integer;
begin
  Result := ValuePadEoFCharEdit.Left + ValuePadEoFCharEdit.Width + 6;
end;

function TBaseFieldPropertiesFrame.GetLoadingControls: Boolean;
begin
  Result := FLoadingControlsCount <> 0;
end;

procedure TBaseFieldPropertiesFrame.HeadingsButtonClick(Sender: TObject);
var
  Form: TFieldHeadingsForm;
begin
  Form := TFieldHeadingsForm.Create(Self);
  try
    Form.HeadingLineCount := FEditEngine.HeadingLineCount;
    Form.CommaText := HeadingsEdit.Text;
    Form.ShowModal;
    if Form.Ok then
    begin
      HeadingsEdit.Text := Form.CommaText;
      FBinder.SaveCommaTextEdit(HeadingsEdit, FFieldIndex);
    end;
  finally
    Form.Release;
  end;
end;

procedure TBaseFieldPropertiesFrame.IntegerEditExit(Sender: TObject);
begin
  FBinder.HandleIntegerEditExit(Sender as TEdit, FFieldIndex);
end;

procedure TBaseFieldPropertiesFrame.IntegerEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleIntegerEditKeyPress(Sender as TEdit, FFieldIndex, Key);
end;

procedure TBaseFieldPropertiesFrame.StringEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleStringEditKeyPress(Sender as TEdit, FFieldIndex, Key);
end;

procedure TBaseFieldPropertiesFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder; myFieldIndex: Integer);
begin
  if Assigned(FEditEngine)
     or
     Assigned(FBinder) then
  begin
    Unprepare;
  end;

  FEditEngine := myEditEngine;
  FBinder := myBinder;
  FFieldIndex := myFieldIndex;
end;

procedure TBaseFieldPropertiesFrame.Refresh;
begin
  Inc(FLoadingControlsCount);
  try
    RefreshName;
    FBinder.LoadIntegerEdit(IdEdit, FFieldIndex);
    FBinder.LoadStringEdit(HeadingsEdit, FFieldIndex);
    HeadingsButton.Enabled := FEditEngine.HeadingLineCount > 0;
    FBinder.LoadComboBox(HeadingConstraintComboBox, FFieldIndex);
    FBinder.LoadCheckBox(ConstantCheckBox, FFieldIndex);
    NullConstantCheckBox.Enabled := ConstantCheckBox.Checked;
    if ConstantCheckBox.Checked then
      FBinder.LoadCheckBox(NullConstantCheckBox, FFieldIndex)
    else
      NullConstantCheckBox.Checked := False;
    FBinder.LoadRadioButton(FixedWidthRadioButton, FFieldIndex);
    if not FixedWidthRadioButton.Checked then
    begin
      DelimitedRadioButton.Checked := True;
    end;
    FixedWidthPanel.Visible := FixedWidthRadioButton.Checked;
    DelimitedPanel.Visible := DelimitedRadioButton.Checked;

    if DelimitedPanel.Visible then
    begin
      FBinder.LoadComboBox(ValueQuotedComboBox, FFieldIndex);
      FBinder.LoadCheckBox(ValueAlwaysWriteOptionalQuoteCheckBox, FFieldIndex);
      FBinder.LoadCheckBox(ValueWritePrefixSpaceCheckBox, FFieldIndex);
      FBinder.LoadComboBox(HeadingQuotedComboBox, FFieldIndex);
      FBinder.LoadCheckBox(HeadingAlwaysWriteOptionalQuoteCheckBox, FFieldIndex);
      FBinder.LoadCheckBox(HeadingWritePrefixSpaceCheckBox, FFieldIndex);
    end;

    if FixedWidthPanel.Visible then
    begin
      FBinder.LoadIntegerEdit(WidthEdit, FFieldIndex);
      FBinder.LoadComboBox(ValuePadCharTypeComboBox, FFieldIndex);
      FBinder.LoadComboBox(ValuePadAlignmentComboBox, FFieldIndex);
      FBinder.LoadCharEdit(ValuePadCharEdit, FFieldIndex);
      FBinder.LoadCharEdit(ValuePadEoFCharEdit, FFieldIndex);
      FBinder.LoadComboBox(ValueTruncateTypeComboBox, FFieldIndex);
      FBinder.LoadCharEdit(ValueTruncateCharEdit, FFieldIndex);
      FBinder.LoadCharEdit(ValueNullCharEdit, FFieldIndex);
      FBinder.LoadComboBox(HeadingPadCharTypeComboBox, FFieldIndex);
      FBinder.LoadComboBox(HeadingPadAlignmentComboBox, FFieldIndex);
      FBinder.LoadCharEdit(HeadingPadCharEdit, FFieldIndex);
      FBinder.LoadCharEdit(HeadingPadEoFCharEdit, FFieldIndex);
      FBinder.LoadComboBox(HeadingTruncateTypeComboBox, FFieldIndex);
      FBinder.LoadCharEdit(HeadingTruncateCharEdit, FFieldIndex);
    end;
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TBaseFieldPropertiesFrame.RefreshName;
begin
  Inc(FLoadingControlsCount);
  try
    FBinder.LoadStringEdit(NameEdit, FFieldIndex);
    if FEditEngine.IsFieldNameDuplicated(NameEdit.Text) then
      FBinder.SetEditWarning(NameEdit)
    else
      FBinder.ClearEditWarning(NameEdit);
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TBaseFieldPropertiesFrame.StringEditExit(Sender: TObject);
begin
  FBinder.HandleStringEditExit(Sender as TEdit, FFieldIndex);
end;

procedure TBaseFieldPropertiesFrame.Unprepare;
begin
  ;
end;

end.
