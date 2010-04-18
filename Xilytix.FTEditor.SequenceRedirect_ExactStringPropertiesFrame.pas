// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.SequenceRedirect_ExactStringPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceRedirect_StringPropertiesFrame, Borland.Vcl.StdCtrls, Borland.Vcl.ComCtrls,
  System.ComponentModel;

type
  TSequenceRedirect_ExactStringPropertiesFrame = class(TSequenceRedirect_StringPropertiesFrame)
    Label2: TLabel;
  private
    { Private declarations }
    FRedirect: TFieldedTextSequenceRedirect_ExactString;
  protected
    function GetRedirect: TFieldedTextSequenceRedirect; override;
    procedure SetRedirect(value: TFieldedTextSequenceRedirect); override;
  public
    { Public declarations }
  end;

implementation

{$R *.nfm}

{ TSequenceRedirect_ExactStringPropertiesFrame }

function TSequenceRedirect_ExactStringPropertiesFrame.GetRedirect: TFieldedTextSequenceRedirect;
begin
  Result := FRedirect;
end;

procedure TSequenceRedirect_ExactStringPropertiesFrame.SetRedirect(value: TFieldedTextSequenceRedirect);
begin
  FRedirect := value as TFieldedTextSequenceRedirect_ExactString;
end;

end.
