// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.NumberFieldPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Xilytix.FTEditor.BaseFieldPropertiesFrame, Borland.Vcl.ComCtrls, Borland.Vcl.StdCtrls, Borland.Vcl.ExtCtrls,
  System.ComponentModel;

type
  TNumberFieldPropertiesFrame = class(TBaseFieldPropertiesFrame)
    Label6: TLabel;
    FormatEdit: TEdit;
    Label8: TLabel;
    ConstantValueEdit: TEdit;
    Label27: TLabel;
    StylesEdit: TEdit;
    StyleButton: TButton;
    procedure StylesEditExit(Sender: TObject);
    procedure StylesEditKeyPress(Sender: TObject; var Key: Char);
    procedure StyleButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Refresh; override;
  end;

var
  NumberFieldPropertiesFrame: TNumberFieldPropertiesFrame;

implementation

{$R *.nfm}

uses
  System.Globalization,
  Xilytix.FieldedText.StandardFields,
  Xilytix.FTEditor.Binder;

{ TNumberFieldPropertiesFrame }

constructor TNumberFieldPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  FormatEdit.Tag := TBinder.CreateControlTag(piNumberFormat);
  StylesEdit.Tag := TBinder.CreateControlTag(piNumberStyles);
end;

procedure TNumberFieldPropertiesFrame.Refresh;
begin
  inherited;

  FBinder.LoadStringEdit(FormatEdit, FFieldIndex);
  FBinder.LoadNumberStylesEdit(StylesEdit, FFieldIndex);
end;

procedure TNumberFieldPropertiesFrame.StyleButtonClick(Sender: TObject);
var
  NewValue: string;
  DefaultStyles: NumberStyles;
begin
  DefaultStyles := TFieldedTextField_Number(FEditEngine.Fields[FFieldIndex]).GetDefaultStyles;

  if FBinder.EditNumberStyles(Self,
                              StylesEdit.Text,
                              FBinder.GetPropertyValue(StylesEdit, FFieldIndex) as NumberStyles,
                              DefaultStyles,
                              NewValue) then
  begin
    StylesEdit.Text := NewValue;
    FBinder.SaveNumberStylesEdit(StylesEdit, FFieldIndex, DefaultStyles);
  end;
end;

procedure TNumberFieldPropertiesFrame.StylesEditExit(Sender: TObject);
begin
  FBinder.SaveNumberStylesEdit(Sender as TEdit, FFieldIndex,
                               TFieldedTextField_Number(FEditEngine.Fields[FFieldIndex]).GetDefaultStyles);
end;

procedure TNumberFieldPropertiesFrame.StylesEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleNumberStylesEditKeyPress(Sender as TEdit, FFieldIndex,
                                         TFieldedTextField_Number(FEditEngine.Fields[FFieldIndex]).GetDefaultStyles,
                                         Key);
end;

end.
