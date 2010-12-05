// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.SequencePropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceBasePropertiesFrame, StdCtrls;

type
  TSequencePropertiesFrame = class(TSequenceBasePropertiesFrame)
    Label1: TLabel;
    NameEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ItemsCountLabel: TLabel;
    IsRootCheckBox: TCheckBox;
    procedure NameEditExit(Sender: TObject);
    procedure NameEditKeyPress(Sender: TObject; var Key: Char);
    procedure IsRootCheckBoxClick(Sender: TObject);
  private
    FSequence: TFieldedTextSequence;
    { Private declarations }

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    property Sequence: TFieldedTextSequence read FSequence write FSequence;

    procedure Refresh; override;
  end;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.Binder;

{ TSequencePropertiesFrame }

constructor TSequencePropertiesFrame.Create(AOwner: TComponent);
begin
  inherited;

  NameEdit.Tag := TBinder.CreateControlTag(piSequenceName);
  IsRootCheckBox.Tag := TBinder.CreateControlTag(piIsRoot);
end;

procedure TSequencePropertiesFrame.IsRootCheckBoxClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    FBinder.HandleCheckBoxClick(IsRootCheckBox, FSequence.Index);
  end;
end;

procedure TSequencePropertiesFrame.NameEditExit(Sender: TObject);
begin
  FBinder.HandleStringEditExit(NameEdit, FSequence.Index);
end;

procedure TSequencePropertiesFrame.NameEditKeyPress(Sender: TObject; var Key: Char);
begin
  FBinder.HandleStringEditKeyPress(NameEdit, FSequence.Index, key);
end;

procedure TSequencePropertiesFrame.Refresh;
var
  SequenceIndex: Integer;
begin
  inherited;

  Inc(FLoadingControlsCount);
  try
    SequenceIndex := FSequence.Index;
    FBinder.LoadStringEdit(NameEdit, SequenceIndex);
    FBinder.LoadCheckBox(IsRootCheckBox, SequenceIndex);
    ItemsCountLabel.Caption := FSequence.Count.ToString;

  finally
    Dec(FLoadingControlsCount);
  end;
end;

end.
