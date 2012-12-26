// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.SequenceRedirect_BooleanPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame, System.ComponentModel, Borland.Vcl.StdCtrls, Borland.Vcl.ComCtrls;

type
  TSequenceRedirect_BooleanPropertiesFrame = class(TSequenceRedirect_BasePropertiesFrame)
    Label2: TLabel;
    ValueCheckBox: TCheckBox;
    procedure CheckBoxClick(Sender: TObject);
  private
    { Private declarations }
    FRedirect: TFieldedTextSequenceRedirect_Boolean;
  protected
    function GetRedirect: TFieldedTextSequenceRedirect; override;
    procedure SetRedirect(value: TFieldedTextSequenceRedirect); override;
  public
    constructor Create(AOwner: TComponent); override;

    procedure Refresh; override;
  end;

implementation

{$R *.nfm}

uses
  Xilytix.FTEditor.Binder;

{ TSequenceRedirect_BooleanPropertiesFrame }

procedure TSequenceRedirect_BooleanPropertiesFrame.CheckBoxClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    FBinder.HandleRedirectCheckBoxClick(sender as TCheckBox, FRedirect);
  end;
end;

constructor TSequenceRedirect_BooleanPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  ValueCheckBox.Tag := TBinder.CreateControlTag(piRedirectValue);
end;

function TSequenceRedirect_BooleanPropertiesFrame.GetRedirect: TFieldedTextSequenceRedirect;
begin
  Result := FRedirect;
end;

procedure TSequenceRedirect_BooleanPropertiesFrame.Refresh;
begin
  inherited;

  Inc(FLoadingControlsCount);
  try
    FBinder.LoadRedirectCheckBox(ValueCheckBox, FRedirect);
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TSequenceRedirect_BooleanPropertiesFrame.SetRedirect(value: TFieldedTextSequenceRedirect);
begin
  FRedirect := value as TFieldedTextSequenceRedirect_Boolean;
end;

end.
