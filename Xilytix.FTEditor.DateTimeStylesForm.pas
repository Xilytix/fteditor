// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.DateTimeStylesForm;

interface

uses
  System.Globalization,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  StdCtrls, System.ComponentModel;

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
    FValue: DateTimeStyles;
    FLoadingControls: Boolean;
    FOk: Boolean;

    { Private declarations }

    procedure LoadControls;
    procedure SetCheckBox(checkBox: TCheckBox);

    function GetAsString: string;
  public
    { Public declarations }
    property AsString: string read GetAsString;
    procedure SetAsString(asStringValue: string; fallBack, default: DateTimeStyles);
  end;

var
  DateTimeStylesForm: TDateTimeStylesForm;

implementation

{$R *.nfm}

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
      FValue := FValue or DateTimeStyles(StyleValue)
    else
      FValue := FValue and DateTimeStyles(not StyleValue);

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
  AllowInnerWhiteCheckBox.Tag := Integer(DateTimeStyles.AllowInnerWhite);
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
