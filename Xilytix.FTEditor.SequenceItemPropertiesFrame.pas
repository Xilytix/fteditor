// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.SequenceItemPropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,
  Xilytix.FieldedText.Sequence,
  Xilytix.FTEditor.SequenceBasePropertiesFrame;


type
  TFieldSelectorSortedChangeEvent = procedure of object;

  TSequenceItemPropertiesFrame = class(TSequenceBasePropertiesFrame)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RedirectsCountLabel: TLabel;
    FieldComboBox: TComboBoxEx;
    SortCheckBox: TCheckBox;
    procedure FieldComboBoxChange(Sender: TObject);
    procedure FieldComboBoxDropDown(Sender: TObject);
    procedure SortCheckBoxClick(Sender: TObject);
  private
    FSequenceItem: TFieldedTextSequenceItem;
    FFieldSelectorSortedChangeEvent: TFieldSelectorSortedChangeEvent;

    procedure PopulateFieldComboBox;
    function GetFieldSelectorSorted: Boolean;
    procedure SetFieldSelectorSorted(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property FieldSelectorSorted: Boolean read GetFieldSelectorSorted write SetFieldSelectorSorted;

    property SequenceItem: TFieldedTextSequenceItem read FSequenceItem write FSequenceItem;

    procedure Refresh; override;

    property FieldSelectorSortedChangeEvent: TFieldSelectorSortedChangeEvent read FFieldSelectorSortedChangeEvent write FFieldSelectorSortedChangeEvent;
  end;

implementation

{$R *.dfm}

uses
  Borland.Vcl.ListActns,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.Binder;

{ TSequenceItemPropertiesFrame }

constructor TSequenceItemPropertiesFrame.Create(AOwner: TComponent);
begin                                                        
  inherited;

  FieldComboBox.Tag := TBinder.CreateControlTag(piSequenceItemField);
end;

procedure TSequenceItemPropertiesFrame.FieldComboBoxChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := FieldComboBox.ItemIndex;
  if ItemIndex >= 0 then
  begin
    FBinder.SetSequenceItemField(FSequenceItem, FieldComboBox.ItemsEx[ItemIndex].Data);
  end;
end;

procedure TSequenceItemPropertiesFrame.FieldComboBoxDropDown(Sender: TObject);
begin
  PopulateFieldComboBox;
end;

function TSequenceItemPropertiesFrame.GetFieldSelectorSorted: Boolean;
begin
  Result := SortCheckBox.Checked;
end;

procedure TSequenceItemPropertiesFrame.PopulateFieldComboBox;
var
  I: Integer;
  Item: TComboExItem;
  Field: TFieldedTextField;
  FoundItemIndex: Boolean;
begin
  FieldComboBox.ItemsEx.SortType := stNone;
  FieldComboBox.ItemsEx.Clear;

  for I := 0 to FEditEngine.FieldCount - 1 do
  begin
    Item := FieldComboBox.ItemsEx.Add;
    Item.Caption := FEditEngine.Fields[I].Name;
    Item.Data := FEditEngine.Fields[I];
  end;

  if SortCheckBox.Checked then
  begin
    FieldComboBox.ItemsEx.SortType := stText;
    FieldComboBox.ItemsEx.Sort;
  end;

  Field := FSequenceItem.Field;
  FieldComboBox.ItemIndex := -1;
  FoundItemIndex := False;
  for I := 0 to FieldComboBox.ItemsEx.Count - 1 do
  begin
    if FieldComboBox.ItemsEx.ComboItems[I].Data = Field then
    begin
      FoundItemIndex := True;
      if FieldComboBox.ItemIndex <> I then
      begin
        FieldComboBox.ItemIndex := I;
      end;
      Break;
    end;
  end;
  if not FoundItemIndex then
  begin
    FieldComboBox.ItemIndex := -1;
  end;
end;

procedure TSequenceItemPropertiesFrame.Refresh;
begin
  inherited;

  Inc(FLoadingControlsCount);
  try
    PopulateFieldComboBox;

    RedirectsCountLabel.Caption := FSequenceItem.RedirectCount.ToString;

  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TSequenceItemPropertiesFrame.SetFieldSelectorSorted(
  const Value: Boolean);
begin
  Inc(FLoadingControlsCount);
  try
    SortCheckBox.Checked := Value;
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TSequenceItemPropertiesFrame.SortCheckBoxClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    FFieldSelectorSortedChangeEvent;
  end;
end;

end.
