// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.SequenceRedirect_FloatPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame, Borland.Vcl.StdCtrls, Borland.Vcl.ComCtrls, System.ComponentModel;

type
  TSequenceRedirect_FloatPropertiesFrame = class(TSequenceRedirect_BasePropertiesFrame)
    Label2: TLabel;
    ValueLabel: TLabel;
    ValueEdit: TEdit;
    procedure ValueEditExit(Sender: TObject);
    procedure ValueEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FRedirect: TFieldedTextSequenceRedirect_ExactFloat;
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

{ TSequenceRedirect_FloatPropertiesFrame }

constructor TSequenceRedirect_FloatPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  ValueEdit.Tag := TBinder.CreateControlTag(piRedirectValue);
end;

function TSequenceRedirect_FloatPropertiesFrame.GetRedirect: TFieldedTextSequenceRedirect;
begin
  Result := FRedirect;
end;

procedure TSequenceRedirect_FloatPropertiesFrame.Refresh;
begin
  inherited;

  Inc(FLoadingControlsCount);
  try
    FBinder.LoadRedirectDoubleEdit(ValueEdit, Redirect);
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TSequenceRedirect_FloatPropertiesFrame.SetRedirect(value: TFieldedTextSequenceRedirect);
begin
  FRedirect := value as TFieldedTextSequenceRedirect_ExactFloat;
end;

procedure TSequenceRedirect_FloatPropertiesFrame.ValueEditExit(Sender: TObject);
begin
  FBinder.HandleRedirectDoubleEditExit(Sender as TEdit, Redirect);
end;

procedure TSequenceRedirect_FloatPropertiesFrame.ValueEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleRedirectDoubleEditKeyPress(Sender as TEdit, Redirect, Key);
end;

end.
