// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.DateTimeStylesForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  StdCtrls,
  Xilytix.FieldedText.Utils;

type
  TDateTimeStylesForm = class(TForm)
    AllowInnerWhiteCheckBox: TCheckBox;
    OkButton: TButton;
    CancelButton: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure AllowInnerWhiteCheckBoxClick(Sender: TObject);
  private
    FValue: TCompositeDotNetDateTimeStyles;
    FLoadingControls: Boolean;
    FOk: Boolean;

    { Private declarations }

    procedure LoadControls;
    procedure SetCheckBox(checkBox: TCheckBox);

    function GetAsString: string;
  public
    { Public declarations }
    property AsString: string read GetAsString;
    procedure SetAsString(asStringValue: string; fallBack, default: TDotNetDateTimeStyles);
  end;

var
  DateTimeStylesForm: TDateTimeStylesForm;

implementation

{$R *.dfm}

{ TDateTimeStylesForm }

procedure TDateTimeStylesForm.AllowInnerWhiteCheckBoxClick(Sender: TObject);
var
  CheckBox: TCheckBox;
  StyleValue: Integer;
begin
  if not FLoadingControls then
  begin
    CheckBox := Sender as TCheckBox;
    StyleValue := CheckBox.Tag;
    if CheckBox.Checked then
      Include(FValue.Styles, TDotNetDateTimeStyle(StyleValue))
    else
      Exclude(FValue.Styles, TDotNetDateTimeStyle(StyleValue));

    LoadControls;
  end;
end;

procedure TDateTimeStylesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FOk then
    ModalResult := mrOk
  else
    ModalResult := mrCancel;
end;

procedure TDateTimeStylesForm.FormCreate(Sender: TObject);
begin
  AllowInnerWhiteCheckBox.Tag := Integer(dndsAllowInnerWhite);
end;

function TDateTimeStylesForm.GetAsString: string;
begin
  Result := Enum(FValue).ToString;
end;

procedure TDateTimeStylesForm.LoadControls;
begin
  FLoadingControls := True;
  try
    SetCheckBox(AllowInnerWhiteCheckBox);
  finally
    FLoadingControls := False;
  end;
end;

procedure TDateTimeStylesForm.OkButtonClick(Sender: TObject);
begin
  FOk := True;
end;

procedure TDateTimeStylesForm.SetAsString(asStringValue: string; fallBack, default: DateTimeStyles);
begin
  if asStringValue.Trim = '' then
    FValue := default
  else
  begin
    try
      FValue := Enum.Parse(TypeOf(DateTimeStyles), asStringValue, True) as DateTimeStyles;
    except
      on ArgumentException do
      begin
        FValue := fallBack;
      end;
    end;
  end;

  LoadControls;
end;

procedure TDateTimeStylesForm.SetCheckBox(checkBox: TCheckBox);
begin
  checkBox.Checked := (Integer(FValue) and checkBox.Tag) = checkBox.Tag;
end;

end.
