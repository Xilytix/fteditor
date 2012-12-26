// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.BooleanStylesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  Xilytix.FieldedText.Utils;

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
    FValue: TBooleanStyles;
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
      Include(FValue, TBooleanStyle(StyleValue))
    else
      Exclude(FValue, TBooleanStyle(StyleValue));

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
  Result := TBooleanStylesInfo.ToString(FValue);
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
    FValue := default
  else
  begin
    if not TBooleanStylesInfo.TryFromString(asStringValue, FValue) then
    begin
      FValue := fallBack;
    end;
  end;

  LoadControls;
end;

procedure TBooleanStylesForm.SetCheckBox(checkBox: TCheckBox);
var
  TagStyle: TBooleanStyle;
begin
  TagStyle := TBooleanStyle(checkBox.Tag);
  checkBox.Checked := TagStyle in FValue;
end;

end.
