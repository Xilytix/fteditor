// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.SequenceRedirect_CaseInsensitiveStringPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceRedirect_StringPropertiesFrame,
  StdCtrls, ComCtrls;

type
  TSequenceRedirect_CaseInsensitiveStringPropertiesFrame = class(TSequenceRedirect_StringPropertiesFrame)
    Label2: TLabel;
  private
    { Private declarations }
    FRedirect: TFieldedTextSequenceRedirect_CaseInsensitiveString;
  protected
    function GetRedirect: TFieldedTextSequenceRedirect; override;
    procedure SetRedirect(value: TFieldedTextSequenceRedirect); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TSequenceRedirect_CaseInsensitiveStringPropertiesFrame }

function TSequenceRedirect_CaseInsensitiveStringPropertiesFrame.GetRedirect: TFieldedTextSequenceRedirect;
begin
  Result := FRedirect;
end;

procedure TSequenceRedirect_CaseInsensitiveStringPropertiesFrame.SetRedirect(value: TFieldedTextSequenceRedirect);
begin
  FRedirect := value as TFieldedTextSequenceRedirect_CaseInsensitiveString;
end;

end.
