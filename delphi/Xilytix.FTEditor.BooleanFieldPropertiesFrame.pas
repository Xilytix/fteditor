// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.BooleanFieldPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  Xilytix.FTEditor.BaseFieldPropertiesFrame,
  Xilytix.FieldedText.BaseField;

type
  TBooleanFieldPropertiesFrame = class(TBaseFieldPropertiesFrame)
    Label6: TLabel;
    TrueTextEdit: TEdit;
    Label27: TLabel;
    FalseTextEdit: TEdit;
    Label28: TLabel;
    StylesEdit: TEdit;
    StylesButton: TButton;
    ConstantValueCheckBox: TCheckBox;
    procedure StylesButtonClick(Sender: TObject);
    procedure StylesEditExit(Sender: TObject);
    procedure StylesEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Refresh; override;

    class function GetAddCaption: string; override;
    class function GetDataType: TFieldedTextField.TDataType; override;
  end;

implementation

{$R *.dfm}

uses
  Rtti,
  Xilytix.FieldedText.Utils,
  Xilytix.FieldedText.StandardFields,
  Xilytix.FTEditor.Binder;

constructor TBooleanFieldPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  FalseTextEdit.Tag := TBinder.CreateControlTag(piFalseText);
  TrueTextEdit.Tag := TBinder.CreateControlTag(piTrueText);
  StylesEdit.Tag := TBinder.CreateControlTag(piBooleanStyles);
  ConstantValueCheckBox.Tag := TBinder.CreateControlTag(piBooleanValue);
end;

class function TBooleanFieldPropertiesFrame.GetAddCaption: string;
begin
  Result := 'Boolean';
end;

class function TBooleanFieldPropertiesFrame.GetDataType: TFieldedTextField.TDataType;
begin
  Result := ftdtBoolean;
end;

procedure TBooleanFieldPropertiesFrame.Refresh;
var
  ValueIsConstant: Boolean;
begin
  inherited;

  Inc(FLoadingControlsCount);
  try
    FBinder.LoadStringEdit(FalseTextEdit, FFieldIndex);
    FBinder.LoadStringEdit(TrueTextEdit, FFieldIndex);
    FBinder.LoadBooleanStylesEdit(StylesEdit, FFieldIndex);
    ValueIsConstant := ConstantCheckBox.Checked and not NullConstantCheckBox.Checked;
    ConstantValueCheckBox.Enabled := ValueIsConstant;
    if ValueIsConstant then
      FBinder.LoadCheckBox(ConstantValueCheckBox, FFieldIndex)
    else
      ConstantValueCheckBox.Checked := False;
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TBooleanFieldPropertiesFrame.StylesButtonClick(Sender: TObject);
var
  Value: TValue;
  Styles: TBooleanStyles;
  NewValue: string;
  DefaultStyles: TBooleanStyles;
begin
  DefaultStyles := TFieldedTextField_Boolean.DefaultStyles;

  Value := FBinder.GetPropertyValue(StylesEdit, FFieldIndex);
  Styles := Value.AsType<TBooleanStyles>;

  if FBinder.EditBooleanStyles(Self,
                               StylesEdit.Text,
                               Styles,
                               DefaultStyles,
                               NewValue) then
  begin
    StylesEdit.Text := NewValue;
    FBinder.SaveBooleanStylesEdit(StylesEdit, FFieldIndex, DefaultStyles);
  end;
end;

procedure TBooleanFieldPropertiesFrame.StylesEditExit(Sender: TObject);
begin
  FBinder.SaveBooleanStylesEdit(Sender as TEdit, FFieldIndex,
                                TFieldedTextField_Boolean.DefaultStyles);
end;

procedure TBooleanFieldPropertiesFrame.StylesEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleBooleanStylesEditKeyPress(Sender as TEdit, FFieldIndex,
                                          TFieldedTextField_Boolean.DefaultStyles,
                                          Key);
end;

end.
