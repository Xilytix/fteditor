// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.DecimalFieldPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  Xilytix.FTEditor.NumberFieldPropertiesFrame,
  Xilytix.FieldedText.BaseField;

type
  TDecimalFieldPropertiesFrame = class(TNumberFieldPropertiesFrame)
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
  DecimalFieldPropertiesFrame: TDecimalFieldPropertiesFrame;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.Binder, Xilytix.FTEditor.BaseFieldPropertiesFrame;

{ TDecimalFieldPropertiesFrame }

procedure TDecimalFieldPropertiesFrame.ConstantValueEditExit(Sender: TObject);
begin
  FBinder.HandleDecimalEditExit(Sender as TEdit, FFieldIndex);
end;

procedure TDecimalFieldPropertiesFrame.ConstantValueEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleDecimalEditKeyPress(Sender as TEdit, FFieldIndex, Key);
end;

constructor TDecimalFieldPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;
  ConstantValueEdit.Tag := TBinder.CreateControlTag(piDecimalValue);
end;

class function TDecimalFieldPropertiesFrame.GetAddCaption: string;
begin
  Result := 'Decimal';
end;

class function TDecimalFieldPropertiesFrame.GetDataType: TFieldedTextFieldDataType;
begin
  Result := ftdtDecimal;
end;

procedure TDecimalFieldPropertiesFrame.Refresh;
var
  ValueIsConstant: Boolean;
begin
  inherited;

  ValueIsConstant := ConstantCheckBox.Checked and not NullConstantCheckBox.Checked;
  ConstantValueEdit.ReadOnly := not ValueIsConstant;
  if ValueIsConstant then
    FBinder.LoadCurrencyEdit(ConstantValueEdit, FFieldIndex)
  else
    FBinder.ClearEdit(ConstantValueEdit);
end;

end.
