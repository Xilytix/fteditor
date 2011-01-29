// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceBasePropertiesFrame;

type
  TSequenceRedirect_BasePropertiesFrame = class(TSequenceBasePropertiesFrame)
    Label1: TLabel;
    SequenceComboBox: TComboBox;
    Label3: TLabel;
    InvokationDelayComboBox: TComboBox;
    InvokationDelayLabel: TLabel;
    procedure SequenceComboBoxDropDown(Sender: TObject);
    procedure SequenceComboBoxChange(Sender: TObject);
    procedure ComboBoxChange(Sender: TObject);
  private
    procedure PopulateSequenceComboBox;
  protected
    function GetRedirect: TFieldedTextSequenceRedirect; virtual; abstract;
    procedure SetRedirect(value: TFieldedTextSequenceRedirect); virtual; abstract;
    function GetRedirectIndex: Integer;

    property RedirectIndex: Integer read GetRedirectIndex;
  public
    constructor Create(AOwner: TComponent); override;

    property Redirect: TFieldedTextSequenceRedirect read GetRedirect write SetRedirect;

    procedure Refresh; override;
  end;

  TSequenceRedirect_BasePropertiesFrameClass = class of TSequenceRedirect_BasePropertiesFrame;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.Binder;

{ TSequenceRedirect_BasePropertiesFrame }

procedure TSequenceRedirect_BasePropertiesFrame.ComboBoxChange(Sender: TObject);
begin
  FBinder.HandleRedirectComboBoxChange(Sender as TComboBox, Redirect);
end;

constructor TSequenceRedirect_BasePropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  SequenceComboBox.Tag := TBinder.CreateControlTag(piRedirectSequence);
  TBinder.PrepareRedirectInvokationDelayComboBox(InvokationDelayComboBox, piRedirectInvokationDelay);
end;

function TSequenceRedirect_BasePropertiesFrame.GetRedirectIndex: Integer;
begin
  Result := Redirect.Index;
end;

procedure TSequenceRedirect_BasePropertiesFrame.PopulateSequenceComboBox;
var
  I: Integer;
begin
  for I := 0 to FEditEngine.SequenceCount - 1 do
  begin
    if I >= SequenceComboBox.Items.Count then
      SequenceComboBox.Items.AddObject(FEditEngine.Sequences[I].Name, FEditEngine.Sequences[I])
    else
    begin
      SequenceComboBox.Items[I] := FEditEngine.Sequences[I].Name;
      SequenceComboBox.Items.Objects[I] := FEditEngine.Sequences[I];
    end;
  end;

  for I := SequenceComboBox.Items.Count-1 downto FEditEngine.SequenceCount do
  begin
    SequenceComboBox.Items.Delete(I);
  end;
end;

procedure TSequenceRedirect_BasePropertiesFrame.Refresh;
begin
  inherited;

  Inc(FLoadingControlsCount);
  try
    PopulateSequenceComboBox;

    SequenceComboBox.ItemIndex := -1;
    SequenceComboBox.ItemIndex := Redirect.Sequence.Index;

    FBinder.LoadRedirectComboBox(InvokationDelayComboBox, Redirect);

  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TSequenceRedirect_BasePropertiesFrame.SequenceComboBoxChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := SequenceComboBox.ItemIndex;
  if ItemIndex >= 0 then
  begin
    FBinder.SetRedirectSequence(Redirect, SequenceComboBox.Items.Objects[ItemIndex]);
  end;
end;

procedure TSequenceRedirect_BasePropertiesFrame.SequenceComboBoxDropDown(Sender: TObject);
begin
  PopulateSequenceComboBox;
end;

end.
