// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.FloatFieldPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  Xilytix.FTEditor.NumberFieldPropertiesFrame,
  Xilytix.FieldedText.BaseField;

type
  TFloatFieldPropertiesFrame = class(TNumberFieldPropertiesFrame)
    procedure ConstantValueEditExit(Sender: TObject);
    procedure ConstantValueEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Refresh; override;

    class function GetAddCaption: string; override;
    class function GetDataType: TFieldedTextFieldDataType; override;
  end;

var
  FloatFieldPropertiesFrame: TFloatFieldPropertiesFrame;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.Binder;

{ TFloatFieldPropertiesFrame }

procedure TFloatFieldPropertiesFrame.ConstantValueEditExit(Sender: TObject);
begin
  FBinder.HandleDoubleEditExit(Sender as TEdit, FFieldIndex);
end;

procedure TFloatFieldPropertiesFrame.ConstantValueEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleDoubleEditKeyPress(Sender as TEdit, FFieldIndex, Key);
end;

constructor TFloatFieldPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;
  ConstantValueEdit.Tag := TBinder.CreateControlTag(piFloatValue);
end;

class function TFloatFieldPropertiesFrame.GetAddCaption: string;
begin
  Result := 'Float';
end;

class function TFloatFieldPropertiesFrame.GetDataType: TFieldedTextFieldDataType;
begin
  Result := ftdtFloat;
end;

procedure TFloatFieldPropertiesFrame.Refresh;
var
  ValueIsConstant: Boolean;
begin
  inherited;

  ValueIsConstant := ConstantCheckBox.Checked and not NullConstantCheckBox.Checked;
  ConstantValueEdit.ReadOnly := not ValueIsConstant;
  if ValueIsConstant then
    FBinder.LoadDoubleEdit(ConstantValueEdit, FFieldIndex)
  else
    FBinder.ClearEdit(ConstantValueEdit);
end;

end.
