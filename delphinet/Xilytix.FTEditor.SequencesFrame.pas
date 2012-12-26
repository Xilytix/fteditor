// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.SequencesFrame;

interface

uses
  System.ComponentModel,
  System.Xml,
  Borland.Vcl.Windows,
  Borland.Vcl.Messages,
  Borland.Vcl.SysUtils,
  Borland.Vcl.Variants,
  Borland.Vcl.Classes,
  Borland.Vcl.Graphics,
  Borland.Vcl.Controls,
  Borland.Vcl.Forms,
  Borland.Vcl.Dialogs,
  Borland.Vcl.ComCtrls,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.LayoutableFrame,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.EditorFrame,
  Xilytix.FTEditor.SequenceListFrame;


type
  TSequencesFrame = class(TEditorFrame)
    PageControl: TPageControl;
    ListTabSheet: TTabSheet;
    TreeTabSheet: TTabSheet;
  private
    { Private declarations }
    const
      MetaTag_SequenceItemFieldSelectorSorted = 'SequenceItemFieldSelectorSorted';

    var
      FListFrame: TSequenceListFrame;

    procedure HandleRefreshSequencesControlsEvent;
    procedure HandleFieldRemovedEvent(field: TFieldedTextField);

  protected
    function GetInitialHeight: Integer; override;
    function GetInitialWidth: Integer; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    procedure Refresh;

    class function GetTypeId: TLayoutableFrame.TTypeId; override;
    class function GetTypeName: string; override;
    class function GetTypeCaption: string; override;

    procedure LoadFromXml(config: XmlElement); override;
    procedure SaveToXml(config: XmlElement); override;

    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder); override;
    procedure Unprepare; override;
  end;

implementation

{$R *.nfm}

uses
  Xilytix.FTEditor.LayoutConfiguration;

{ TSequencesFrame }

constructor TSequencesFrame.Create(AOwner: TComponent);
begin
  inherited;

  PageControl.ActivePage := ListTabSheet;
  PageControl.Visible := False;

  FListFrame := TSequenceListFrame.Create(Self);
  FListFrame.Parent := Self;
  FListFrame.Align := alClient;
end;

function TSequencesFrame.GetInitialHeight: Integer;
begin
  Result := 150;
end;

function TSequencesFrame.GetInitialWidth: Integer;
begin
  Result := 150;
end;

class function TSequencesFrame.GetTypeCaption: string;
begin
  Result := 'Sequences';
end;

class function TSequencesFrame.GetTypeId: TLayoutableFrame.TTypeId;
begin
  Result := ftSequences;
end;

class function TSequencesFrame.GetTypeName: string;
begin
  Result := 'Sequences';
end;

procedure TSequencesFrame.HandleFieldRemovedEvent(field: TFieldedTextField);
begin
  FListFrame.NotifyFieldRemoved(field);
end;

procedure TSequencesFrame.HandleRefreshSequencesControlsEvent;
begin
  Refresh;
end;

procedure TSequencesFrame.LoadFromXml(config: XmlElement);
var
  SelectorSorted: Boolean;
begin
  inherited;

  if config.HasAttribute(MetaTag_SequenceItemFieldSelectorSorted) then
  begin
    SelectorSorted := TLayoutConfiguration.XmlValueToBoolean(config.GetAttribute(MetaTag_SequenceItemFieldSelectorSorted));
    FListFrame.SequenceItemFieldSelectorSorted := SelectorSorted;
  end;
end;

procedure TSequencesFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
begin
  inherited;

  FListFrame.Prepare(myEditEngine, myBinder);

  Include(FEditEngine.RefreshSequencesControlsEvent, HandleRefreshSequencesControlsEvent);
  Include(FEditEngine.FieldRemovedEvent, HandleFieldRemovedEvent);
end;

procedure TSequencesFrame.Refresh;
begin
  FListFrame.Refresh;
end;

procedure TSequencesFrame.SaveToXml(config: XmlElement);
begin
  inherited;
  config.SetAttribute(MetaTag_SequenceItemFieldSelectorSorted, TLayoutConfiguration.BooleanToXmlValue(FListFrame.SequenceItemFieldSelectorSorted));
end;

procedure TSequencesFrame.Unprepare;
begin
  Exclude(FEditEngine.RefreshSequencesControlsEvent, HandleRefreshSequencesControlsEvent);
  Exclude(FEditEngine.FieldRemovedEvent, HandleFieldRemovedEvent);

  FListFrame.Unprepare;

  inherited;
end;

end.
