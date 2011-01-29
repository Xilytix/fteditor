// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.IntegerFieldPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  Xilytix.FTEditor.NumberFieldPropertiesFrame,
  Xilytix.FieldedText.BaseField;

type
  TIntegerFieldPropertiesFrame = class(TNumberFieldPropertiesFrame)
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
  IntegerFieldPropertiesFrame: TIntegerFieldPropertiesFrame;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.Binder;

{ TIntegerFieldPropertiesFrame }

procedure TIntegerFieldPropertiesFrame.ConstantValueEditExit(Sender: TObject);
begin
  FBinder.HandleInt64EditExit(Sender as TEdit, FFieldIndex);
end;

procedure TIntegerFieldPropertiesFrame.ConstantValueEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleInt64EditKeyPress(Sender as TEdit, FFieldIndex, Key);
end;

constructor TIntegerFieldPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;
  ConstantValueEdit.Tag := TBinder.CreateControlTag(piIntegerValue);
end;

class function TIntegerFieldPropertiesFrame.GetAddCaption: string;
begin
  Result := 'Integer';
end;

class function TIntegerFieldPropertiesFrame.GetDataType: TFieldedTextFieldDataType;
begin
  Result := ftdtInteger;
end;

procedure TIntegerFieldPropertiesFrame.Refresh;
var
  ValueIsConstant: Boolean;
begin
  inherited;

  ValueIsConstant := ConstantCheckBox.Checked and not NullConstantCheckBox.Checked;
  ConstantValueEdit.ReadOnly := not ValueIsConstant;
  if ValueIsConstant then
    FBinder.LoadInt64Edit(ConstantValueEdit, FFieldIndex)
  else
    FBinder.ClearEdit(ConstantValueEdit);
end;

end.
