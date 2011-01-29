// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.NumberStylesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  Xilytix.FieldedText.Utils;

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
    FValue: TCompositeDotNetNumberStyles;
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
    procedure SetAsString(asStringValue: string; fallBack, default: TDotNetNumberStyles);
  end;

var
  NumberStylesForm: TNumberStylesForm;

implementation

{$R *.dfm}

procedure TNumberStylesForm.OkButtonClick(Sender: TObject);
begin
  FOk := True;
end;

procedure TNumberStylesForm.CompositeClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FValue.AsInteger := (Sender as TRadioButton).Tag;

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
  AnyRadioButton.Tag := TCompositeDotNetNumberStyles.CreateAny.AsInteger;
  CurrencyRadioButton.Tag := TCompositeDotNetNumberStyles.CreateCurrency.AsInteger;
  FloatRadioButton.Tag := TCompositeDotNetNumberStyles.CreateFloat.AsInteger;
  HexNumberRadioButton.Tag := TCompositeDotNetNumberStyles.CreateHexNumber.AsInteger;
  IntegerRadioButton.Tag := TCompositeDotNetNumberStyles.CreateInteger.AsInteger;
  NoneRadioButton.Tag := TCompositeDotNetNumberStyles.CreateNone.AsInteger;
  NumberRadioButton.Tag := TCompositeDotNetNumberStyles.CreateNumber.AsInteger;

  AllowCurrencySymbolCheckBox.Tag := Integer(dnnsAllowCurrencySymbol);
  AllowDecimalPointCheckBox.Tag := Integer(dnnsAllowDecimalPoint);
  AllowExponentCheckBox.Tag := Integer(dnnsAllowExponent);
  AllowHexSpecifierCheckBox.Tag := Integer(dnnsAllowHexSpecifier);
  AllowLeadingSignCheckBox.Tag := Integer(dnnsAllowLeadingSign);
  AllowParenthesesCheckBox.Tag := Integer(dnnsAllowParentheses);
  AllowThousandsCheckBox.Tag := Integer(dnnsAllowThousands);
  AllowTrailingSignCheckBox.Tag := Integer(dnnsAllowTrailingSign);
end;

function TNumberStylesForm.GetAsString: string;
begin
  Result := FValue.AsString;
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

procedure TNumberStylesForm.SetAsString(asStringValue: string; fallBack, default: TDotNetNumberStyles);
begin
  asStringValue := Trim(asStringValue);
  if asStringValue= '' then
    FValue.Styles := default
  else
  begin
    if not TCompositeDotNetNumberStyles.TryStrToStyles(asStringValue, FValue.Styles) then
    begin
      FValue.Styles := fallBack;
    end;
  end;

  LoadControls;
end;

procedure TNumberStylesForm.SetCheckBox(checkBox: TCheckBox);
begin
  checkBox.Checked := (FValue.AsInteger and checkBox.Tag) = checkBox.Tag;
end;

procedure TNumberStylesForm.SetRadioButton(button: TRadioButton);
begin
  button.Checked := FValue.AsInteger = button.Tag;
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
      Include(FValue.Styles, TDotNetNumberStyle(StyleValue))
    else
      Exclude(FValue.Styles, TDotNetNumberStyle(StyleValue));

    LoadControls;
  end;
end;

end.
