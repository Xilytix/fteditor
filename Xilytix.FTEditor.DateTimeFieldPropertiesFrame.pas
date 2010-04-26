// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.DateTimeFieldPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Xilytix.FTEditor.BaseFieldPropertiesFrame, Borland.Vcl.ComCtrls, Borland.Vcl.StdCtrls, Borland.Vcl.ExtCtrls,
  System.ComponentModel,
  Xilytix.FieldedText.BaseField, ComCtrls, StdCtrls, ExtCtrls;

type
  TDateTimeFieldPropertiesFrame = class(TBaseFieldPropertiesFrame)
    Label6: TLabel;
    FormatEdit: TEdit;
    ConstantDatePicker: TDateTimePicker;
    Label8: TLabel;
    ConstantTimePicker: TDateTimePicker;
    Label27: TLabel;
    StylesButton: TButton;
    StylesEdit: TEdit;
    Label28: TLabel;
    procedure StylesButtonClick(Sender: TObject);
    procedure StylesEditExit(Sender: TObject);
    procedure StylesEditKeyPress(Sender: TObject; var Key: Char);
    procedure ConstantDatePickerChange(Sender: TObject);
    procedure ConstantTimePickerChange(Sender: TObject);
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
  DateTimeFieldPropertiesFrame: TDateTimeFieldPropertiesFrame;

implementation

{$R *.dfm}

uses
  System.Globalization,
  Xilytix.FieldedText.StandardFields,
  Xilytix.FTEditor.Binder;

procedure TDateTimeFieldPropertiesFrame.ConstantDatePickerChange(Sender: TObject);
begin
  FBinder.SaveDateTimePickers(ConstantDatePicker, ConstantTimePicker, FFieldIndex);
end;

procedure TDateTimeFieldPropertiesFrame.ConstantTimePickerChange(Sender: TObject);
begin
  FBinder.SaveDateTimePickers(ConstantDatePicker, ConstantTimePicker, FFieldIndex);
end;

constructor TDateTimeFieldPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  FormatEdit.Tag := TBinder.CreateControlTag(piDateTimeFormat);
  StylesEdit.Tag := TBinder.CreateControlTag(piDateTimeStyles);
  ConstantDatePicker.Tag := TBinder.CreateControlTag(piDateTimeValue);
  ConstantTimePicker.Tag := TBinder.CreateControlTag(piDateTimeValue);
end;

class function TDateTimeFieldPropertiesFrame.GetAddCaption: string;
begin
  Result := 'DateTime';
end;

class function TDateTimeFieldPropertiesFrame.GetDataType: TFieldedTextFieldDataType;
begin
  Result := ftdtDateTime;
end;

procedure TDateTimeFieldPropertiesFrame.Refresh;
var
  ValueIsConstant: Boolean;
begin
  inherited;

  FBinder.LoadStringEdit(FormatEdit, FFieldIndex);
  FBinder.LoadDateTimeStylesEdit(StylesEdit, FFieldIndex);
  ValueIsConstant := ConstantCheckBox.Checked and not NullConstantCheckBox.Checked;
  ConstantDatePicker.Enabled := ValueIsConstant;
  ConstantTimePicker.Enabled := ValueIsConstant;
  if ValueIsConstant then
    FBinder.LoadDateTimePickers(ConstantDatePicker, ConstantTimePicker, FFieldIndex)
  else
  begin
    ConstantDatePicker.Date := DateTime.Create(2000, 1, 1);
    ConstantTimePicker.Time := 0.0;
  end;
end;

procedure TDateTimeFieldPropertiesFrame.StylesButtonClick(Sender: TObject);
var
  NewValue: string;
  DefaultStyles: DateTimeStyles;
begin
  DefaultStyles := TFieldedTextField_DateTime.DefaultStyles;

  if FBinder.EditDateTimeStyles(Self,
                                StylesEdit.Text,
                                FBinder.GetPropertyValue(StylesEdit, FFieldIndex) as DateTimeStyles,
                                DefaultStyles,
                                NewValue) then
  begin
    StylesEdit.Text := NewValue;
    FBinder.SaveDateTimeStylesEdit(StylesEdit, FFieldIndex, DefaultStyles);
  end;
end;

procedure TDateTimeFieldPropertiesFrame.StylesEditExit(Sender: TObject);
begin
  FBinder.SaveDateTimeStylesEdit(Sender as TEdit, FFieldIndex, TFieldedTextField_DateTime.DefaultStyles);
end;

procedure TDateTimeFieldPropertiesFrame.StylesEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleDateTimeStylesEditKeyPress(Sender as TEdit, FFieldIndex,
                                           TFieldedTextField_DateTime.DefaultStyles,
                                           Key);
end;

end.
