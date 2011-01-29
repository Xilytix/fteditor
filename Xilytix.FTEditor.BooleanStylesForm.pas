// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.BooleanStylesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  Xilytix.FieldedText.Utils,
  Xilytix.FieldedText.BaseField;

type
  TBooleanStylesForm = class(TForm)
    OkButton: TButton;
    CancelButton: TButton;
    IgnoreCaseCheckBox: TCheckBox;
    MatchFirstCharOnlyCheckBox: TCheckBox;
    IgnoreTrailingCharsCheckBox: TCheckBox;
    FalseIfNotMatchTrueCheckBox: TCheckBox;
    procedure OkButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
  private
    FValue: TCompositeBooleanStyles;
    FLoadingControls: Boolean;
    FOk: Boolean;
    { Private declarations }
    procedure LoadControls;
    procedure SetCheckBox(checkBox: TCheckBox);

    function GetAsString: string;
  public
    { Public declarations }

    property AsString: string read GetAsString;
    procedure SetAsString(asStringValue: string; fallBack, default: TBooleanStyles);
  end;

var
  BooleanStylesForm: TBooleanStylesForm;

implementation

{$R *.dfm}

{ TBooleanStylesForm }

procedure TBooleanStylesForm.CheckBoxClick(Sender: TObject);
var
  CheckBox: TCheckBox;
  StyleValue: Integer;
begin
  if not FLoadingControls then
  begin
    CheckBox := Sender as TCheckBox;
    StyleValue := CheckBox.Tag;
    if CheckBox.Checked then
      Include(FValue.Styles, TBooleanStyle(StyleValue))
    else
      Exclude(FValue.Styles, TBooleanStyle(StyleValue));

    LoadControls;
  end;
end;

procedure TBooleanStylesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FOk then
    ModalResult := mrOk
  else
    ModalResult := mrCancel;
end;

procedure TBooleanStylesForm.FormCreate(Sender: TObject);
begin
  IgnoreCaseCheckBox.Tag := Integer(bostIgnoreCase);
  MatchFirstCharOnlyCheckBox.Tag := Integer(bostMatchFirstCharOnly);
  IgnoreTrailingCharsCheckBox.Tag := Integer(bostIgnoreTrailingChars);
  FalseIfNotMatchTrueCheckBox.Tag := Integer(bostFalseIfNotMatchTrue);
end;

function TBooleanStylesForm.GetAsString: string;
begin
  Result := FValue.AsString;
end;

procedure TBooleanStylesForm.LoadControls;
begin
  FLoadingControls := True;
  try
    SetCheckBox(IgnoreCaseCheckBox);
    SetCheckBox(MatchFirstCharOnlyCheckBox);
    SetCheckBox(IgnoreTrailingCharsCheckBox);
    SetCheckBox(FalseIfNotMatchTrueCheckBox);
  finally
    FLoadingControls := False;
  end;
end;

procedure TBooleanStylesForm.OkButtonClick(Sender: TObject);
begin
  FOk := True;
end;

procedure TBooleanStylesForm.SetAsString(asStringValue: string; fallBack, default: TBooleanStyles);
begin
  asStringValue := Trim(asStringValue);
  if asStringValue= '' then
    FValue.Styles := default
  else
  begin
    if not TCompositeBooleanStyles.TryStrToStyles(asStringValue, FValue.Styles) then
    begin
      FValue.Styles := fallBack;
    end;
  end;

  LoadControls;
end;

procedure TBooleanStylesForm.SetCheckBox(checkBox: TCheckBox);
begin
  checkBox.Checked := (FValue.AsInteger and checkBox.Tag) = checkBox.Tag;
end;

end.
