unit Xilytix.FTEditor.SequenceRedirect_NullPropertiesFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame,
  Xilytix.FieldedText.Sequence;

type
  TSequenceRedirect_NullPropertiesFrame = class(TSequenceRedirect_BasePropertiesFrame)
    Label2: TLabel;
  private
    FRedirect: TFieldedTextSequenceRedirect_Null;
  protected
    function GetRedirect: TFieldedTextSequenceRedirect; override;
    procedure SetRedirect(value: TFieldedTextSequenceRedirect); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TSequenceRedirect_NullPropertiesFrame }

function TSequenceRedirect_NullPropertiesFrame.GetRedirect: TFieldedTextSequenceRedirect;
begin
  Result := FRedirect;
end;

procedure TSequenceRedirect_NullPropertiesFrame.SetRedirect(value: TFieldedTextSequenceRedirect);
begin
  FRedirect := value as TFieldedTextSequenceRedirect_Null;
end;

end.
