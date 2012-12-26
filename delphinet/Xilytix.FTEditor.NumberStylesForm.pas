// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.NumberStylesForm;

interface

uses
  System.Globalization,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Borland.Vcl.StdCtrls, System.ComponentModel;

type
  TNumberStylesForm = class(TForm)
    AllowCurrencySymbolCheckBox: TCheckBox;
    AllowThousandsCheckBox: TCheckBox;
    AllowTrailingSignCheckBox: TCheckBox;
    AnyRadioButton: TRadioButton;
    CurrencyRadioButton: TRadioButton;
    FloatRadioButton: TRadioButton;
    AllowDecimalPointCheckBox: TCheckBox;
    AllowExponentCheckBox: TCheckBox;
    AllowHexSpecifierCheckBox: TCheckBox;
    AllowLeadingSignCheckBox: TCheckBox;
    AllowParenthesesCheckBox: TCheckBox;
    HexNumberRadioButton: TRadioButton;
    IntegerRadioButton: TRadioButton;
    NumberRadioButton: TRadioButton;
    NoneRadioButton: TRadioButton;
    Label1: TLabel;
    OkButton: TButton;
    CancelButton: TButton;
    procedure CompositeClick(Sender: TObject);
    procedure StyleClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    FValue: NumberStyles;
    FLoadingControls: Boolean;
    FOk: Boolean;

    { Private declarations }

    procedure LoadControls;
    procedure SetRadioButton(button: TRadioButton);
    procedure SetCheckBox(checkBox: TCheckBox);

    function GetAsString: string;
  public
    { Public declarations }

    property AsString: string read GetAsString;
    procedure SetAsString(asStringValue: string; fallBack, default: NumberStyles);
  end;

var
  NumberStylesForm: TNumberStylesForm;

implementation

{$R *.nfm}

procedure TNumberStylesForm.OkButtonClick(Sender: TObject);
begin
  FOk := True;
end;

procedure TNumberStylesForm.CompositeClick(Sender: TObject);
var
  CompositeValue: Integer;
begin
  if not FLoadingControls then
  begin
    CompositeValue := (Sender as TRadioButton).Tag;
    FValue := NumberStyles(CompositeValue);
    LoadControls;
  end;
end;

procedure TNumberStylesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FOk then
    ModalResult := mrOk
  else
    ModalResult := mrCancel;
end;

procedure TNumberStylesForm.FormCreate(Sender: TObject);
begin
  AnyRadioButton.Tag := Integer(NumberStyles.Any);
  CurrencyRadioButton.Tag := Integer(NumberStyles.Currency);
  FloatRadioButton.Tag := Integer(NumberStyles.Float);
  HexNumberRadioButton.Tag := Integer(NumberStyles.HexNumber);
  IntegerRadioButton.Tag := Integer(NumberStyles.Integer);
  NoneRadioButton.Tag := Integer(NumberStyles.None);
  NumberRadioButton.Tag := Integer(NumberStyles.Number);

  AllowCurrencySymbolCheckBox.Tag := Integer(NumberStyles.AllowCurrencySymbol);
  AllowDecimalPointCheckBox.Tag := Integer(NumberStyles.AllowDecimalPoint);
  AllowExponentCheckBox.Tag := Integer(NumberStyles.AllowExponent);
  AllowHexSpecifierCheckBox.Tag := Integer(NumberStyles.AllowHexSpecifier);
  AllowLeadingSignCheckBox.Tag := Integer(NumberStyles.AllowLeadingSign);
  AllowParenthesesCheckBox.Tag := Integer(NumberStyles.AllowParentheses);
  AllowThousandsCheckBox.Tag := Integer(NumberStyles.AllowThousands);
  AllowTrailingSignCheckBox.Tag := Integer(NumberStyles.AllowTrailingSign);
end;

function TNumberStylesForm.GetAsString: string;
begin
  Result := Enum(FValue).ToString;
end;

procedure TNumberStylesForm.LoadControls;
begin
  FLoadingControls := True;
  try
    SetRadioButton(AnyRadioButton);
    SetRadioButton(CurrencyRadioButton);
    SetRadioButton(FloatRadioButton);
    SetRadioButton(HexNumberRadioButton);
    SetRadioButton(IntegerRadioButton);
    SetRadioButton(NoneRadioButton);
    SetRadioButton(NumberRadioButton);

    SetCheckBox(AllowCurrencySymbolCheckBox);
    SetCheckBox(AllowDecimalPointCheckBox);
    SetCheckBox(AllowExponentCheckBox);
    SetCheckBox(AllowHexSpecifierCheckBox);
    SetCheckBox(AllowLeadingSignCheckBox);
    SetCheckBox(AllowParenthesesCheckBox);
    SetCheckBox(AllowThousandsCheckBox);
    SetCheckBox(AllowTrailingSignCheckBox);
  finally
    FLoadingControls := False;
  end;
end;

procedure TNumberStylesForm.SetAsString(asStringValue: string; fallBack, default: NumberStyles);
begin
  if asStringValue.Trim = '' then
    FValue := default
  else
  begin
    try
      FValue := Enum.Parse(TypeOf(NumberStyles), asStringValue, True) as NumberStyles;
    except
      on ArgumentException do
      begin
        FValue := fallBack;
      end;
    end;
  end;

  LoadControls;
end;

procedure TNumberStylesForm.SetCheckBox(checkBox: TCheckBox);
begin
  checkBox.Checked := (Integer(FValue) and checkBox.Tag) = checkBox.Tag;
end;

procedure TNumberStylesForm.SetRadioButton(button: TRadioButton);
begin
  button.Checked := Integer(FValue) = button.Tag;
end;

procedure TNumberStylesForm.StyleClick(Sender: TObject);
var
  CheckBox: TCheckBox;
  StyleValue: Integer;
begin
  if not FLoadingControls then
  begin
    CheckBox := Sender as TCheckBox;
    StyleValue := CheckBox.Tag;
    if CheckBox.Checked then
      FValue := FValue or NumberStyles(StyleValue)
    else
      FValue := FValue and NumberStyles(not StyleValue);

    LoadControls;
  end;
end;

end.
