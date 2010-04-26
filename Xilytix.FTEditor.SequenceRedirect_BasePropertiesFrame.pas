// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceBasePropertiesFrame, System.ComponentModel, Borland.Vcl.StdCtrls, Borland.Vcl.ComCtrls, StdCtrls,
  ComCtrls;

type
  TSequenceRedirect_BasePropertiesFrame = class(TSequenceBasePropertiesFrame)
    Label1: TLabel;
    SequenceComboBox: TComboBoxEx;
    Label3: TLabel;
    InvokationDelayComboBox: TComboBoxEx;
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
  FBinder.HandleRedirectComboBoxChange(Sender as TComboBoxEx, Redirect);
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
  Item: TComboExItem;
begin
  for I := 0 to FEditEngine.SequenceCount - 1 do
  begin
    if I < SequenceComboBox.ItemsEx.Count then
      Item := SequenceComboBox.ItemsEx.ComboItems[I]
    else
      Item := SequenceComboBox.ItemsEx.Add;

    if Item.Caption <> FEditEngine.Sequences[I].Name then
    begin
      Item.Caption := FEditEngine.Sequences[I].Name
    end;

    if Item.Data <> FEditEngine.Sequences[I] then
    begin
      Item.Data := FEditEngine.Sequences[I];
    end;
  end;

  for I := SequenceComboBox.ItemsEx.Count-1 downto FEditEngine.SequenceCount do
  begin
    SequenceComboBox.ItemsEx.Delete(I);
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
    FBinder.SetRedirectSequence(Redirect, SequenceComboBox.ItemsEx[ItemIndex].Data);
  end;
end;

procedure TSequenceRedirect_BasePropertiesFrame.SequenceComboBoxDropDown(Sender: TObject);
begin
  PopulateSequenceComboBox;
end;

end.
