// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.SequenceRedirect_ExactDateTimePropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceRedirect_DateTimePropertiesFrame,
  ComCtrls, StdCtrls;

type
  TSequenceRedirect_ExactDateTimePropertiesFrame = class(TSequenceRedirect_DateTimePropertiesFrame)
    Label2: TLabel;
  private
    { Private declarations }
    FRedirect: TFieldedTextSequenceRedirect_ExactDateTime;
  protected
    function GetRedirect: TFieldedTextSequenceRedirect; override;
    procedure SetRedirect(value: TFieldedTextSequenceRedirect); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TSequenceRedirect_ExactDateTimePropertiesFrame }

function TSequenceRedirect_ExactDateTimePropertiesFrame.GetRedirect: TFieldedTextSequenceRedirect;
begin
  Result := FRedirect;
end;

procedure TSequenceRedirect_ExactDateTimePropertiesFrame.SetRedirect(value: TFieldedTextSequenceRedirect);
begin
  FRedirect := value as TFieldedTextSequenceRedirect_ExactDateTime;
end;

end.
