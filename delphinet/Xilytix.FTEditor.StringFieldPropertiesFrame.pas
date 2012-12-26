// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.StringFieldPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Xilytix.FTEditor.BaseFieldPropertiesFrame, Borland.Vcl.ExtCtrls, Borland.Vcl.ComCtrls, Borland.Vcl.StdCtrls,
  System.ComponentModel,
  Xilytix.FieldedText.BaseField;

type
  TStringFieldPropertiesFrame = class(TBaseFieldPropertiesFrame)
    ConstantValueEdit: TEdit;
    Label8: TLabel;
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
  StringFieldPropertiesFrame: TStringFieldPropertiesFrame;

implementation

{$R *.nfm}

uses
  Xilytix.FTEditor.Binder;

{ TStringFieldPropertiesFrame }

constructor TStringFieldPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  ConstantValueEdit.Tag := TBinder.CreateControlTag(piStringValue);
end;

class function TStringFieldPropertiesFrame.GetAddCaption: string;
begin
  Result := 'String';
end;

class function TStringFieldPropertiesFrame.GetDataType: TFieldedTextFieldDataType;
begin
  Result := ftdtString;
end;

procedure TStringFieldPropertiesFrame.Refresh;
var
  ValueIsConstant: Boolean;
begin
  inherited;

  ValueIsConstant := ConstantCheckBox.Checked and not NullConstantCheckBox.Checked;
  ConstantValueEdit.ReadOnly := not ValueIsConstant;
  if ValueIsConstant then
    FBinder.LoadStringEdit(ConstantValueEdit, FFieldIndex)
  else
    FBinder.ClearEdit(ConstantValueEdit);
end;

end.
