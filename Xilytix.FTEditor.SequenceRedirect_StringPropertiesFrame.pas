// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.SequenceRedirect_StringPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame,
  StdCtrls, ComCtrls;

type
  TSequenceRedirect_StringPropertiesFrame = class(TSequenceRedirect_BasePropertiesFrame)
    ValueEdit: TEdit;
    ValueLabel: TLabel;
    procedure ValueEditExit(Sender: TObject);
    procedure ValueEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function GetStringRedirect: TFieldedTextSequenceRedirect_String;
  protected
    property StringRedirect: TFieldedTextSequenceRedirect_String read GetStringRedirect;
  public
    constructor Create(AOwner: TComponent); override;

    procedure Refresh; override;
  end;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.Binder;

{ TSequenceRedirect_StringPropertiesFrame }

constructor TSequenceRedirect_StringPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  ValueEdit.Tag := TBinder.CreateControlTag(piRedirectValue);
end;

function TSequenceRedirect_StringPropertiesFrame.GetStringRedirect: TFieldedTextSequenceRedirect_String;
begin
  Result := Redirect as TFieldedTextSequenceRedirect_String;
end;

procedure TSequenceRedirect_StringPropertiesFrame.Refresh;
begin
  inherited;

  Inc(FLoadingControlsCount);
  try
    FBinder.LoadRedirectStringEdit(ValueEdit, Redirect);
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TSequenceRedirect_StringPropertiesFrame.ValueEditExit(Sender: TObject);
begin
  FBinder.HandleRedirectStringEditExit(Sender as TEdit, Redirect);
end;

procedure TSequenceRedirect_StringPropertiesFrame.ValueEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleRedirectStringEditKeyPress(Sender as TEdit, Redirect, Key);
end;

end.
