// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.SequenceRedirect_DateTimePropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame,
  ComCtrls, StdCtrls;

type
  TSequenceRedirect_DateTimePropertiesFrame = class(TSequenceRedirect_BasePropertiesFrame)
    DatePicker: TDateTimePicker;
    TimePicker: TDateTimePicker;
    ValueLabel: TLabel;
    procedure DatePickerChange(Sender: TObject);
    procedure TimePickerChange(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;

    procedure Refresh; override;
  end;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.Binder;

{ TSequenceRedirect_DateTimePropertiesFrame }

constructor TSequenceRedirect_DateTimePropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  DatePicker.Tag := TBinder.CreateControlTag(piRedirectValue);
  TimePicker.Tag := TBinder.CreateControlTag(piRedirectValue);
end;

procedure TSequenceRedirect_DateTimePropertiesFrame.DatePickerChange(Sender: TObject);
begin
  FBinder.SaveRedirectDateTimePickers(DatePicker, TimePicker, Redirect);
end;

procedure TSequenceRedirect_DateTimePropertiesFrame.Refresh;
begin
  inherited;

  Inc(FLoadingControlsCount);
  try
    FBinder.LoadRedirectDateTimePickers(DatePicker, TimePicker, Redirect)
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TSequenceRedirect_DateTimePropertiesFrame.TimePickerChange(Sender: TObject);
begin
  FBinder.SaveRedirectDateTimePickers(DatePicker, TimePicker, Redirect);
end;

end.
