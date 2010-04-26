// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.BooleanStylesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, System.ComponentModel, Borland.Vcl.StdCtrls,
  Xilytix.FieldedText.BaseField, StdCtrls;

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
      FValue := FValue or TBooleanStyles(StyleValue)
    else
      FValue := FValue and TBooleanStyles(not StyleValue);

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
  IgnoreCaseCheckBox.Tag := Integer(TBooleanStyles.IgnoreCase);
  MatchFirstCharOnlyCheckBox.Tag := Integer(TBooleanStyles.MatchFirstCharOnly);
  IgnoreTrailingCharsCheckBox.Tag := Integer(TBooleanStyles.IgnoreTrailingChars);
  FalseIfNotMatchTrueCheckBox.Tag := Integer(TBooleanStyles.FalseIfNotMatchTrue);
end;

function TBooleanStylesForm.GetAsString: string;
begin
  Result := Enum(FValue).ToString;
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
  if asStringValue.Trim = '' then
    FValue := default
  else
  begin
    try
      FValue := Enum.Parse(TypeOf(TBooleanStyles), asStringValue, True) as TBooleanStyles;
    except
      on ArgumentException do
      begin
        FValue := fallBack;
      end;
    end;
  end;

  LoadControls;
end;

procedure TBooleanStylesForm.SetCheckBox(checkBox: TCheckBox);
begin
  checkBox.Checked := (Integer(FValue) and checkBox.Tag) = checkBox.Tag;
end;

end.
