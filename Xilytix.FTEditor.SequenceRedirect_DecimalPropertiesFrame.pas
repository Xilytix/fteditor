// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.SequenceRedirect_DecimalPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame, Borland.Vcl.StdCtrls, Borland.Vcl.ComCtrls, System.ComponentModel,
  StdCtrls, ComCtrls;

type
  TSequenceRedirect_DecimalPropertiesFrame = class(TSequenceRedirect_BasePropertiesFrame)
    Label2: TLabel;
    ValueLabel: TLabel;
    ValueEdit: TEdit;
    procedure ValueEditExit(Sender: TObject);
    procedure ValueEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FRedirect: TFieldedTextSequenceRedirect_ExactDecimal;
  protected
    function GetRedirect: TFieldedTextSequenceRedirect; override;
    procedure SetRedirect(value: TFieldedTextSequenceRedirect); override;
  public
    constructor Create(AOwner: TComponent); override;

    procedure Refresh; override;
  end;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.Binder;

{ TSequenceRedirect_DecimalPropertiesFrame }

constructor TSequenceRedirect_DecimalPropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  ValueEdit.Tag := TBinder.CreateControlTag(piRedirectValue);
end;

function TSequenceRedirect_DecimalPropertiesFrame.GetRedirect: TFieldedTextSequenceRedirect;
begin
  Result := FRedirect;
end;

procedure TSequenceRedirect_DecimalPropertiesFrame.Refresh;
begin
  inherited;

  Inc(FLoadingControlsCount);
  try
    FBinder.LoadRedirectDecimalEdit(ValueEdit, Redirect);
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TSequenceRedirect_DecimalPropertiesFrame.SetRedirect(value: TFieldedTextSequenceRedirect);
begin
  FRedirect := value as TFieldedTextSequenceRedirect_ExactDecimal;
end;

procedure TSequenceRedirect_DecimalPropertiesFrame.ValueEditExit(Sender: TObject);
begin
  FBinder.HandleRedirectDecimalEditExit(Sender as TEdit, Redirect);
end;

procedure TSequenceRedirect_DecimalPropertiesFrame.ValueEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleRedirectDecimalEditKeyPress(Sender as TEdit, Redirect, Key);
end;

end.
