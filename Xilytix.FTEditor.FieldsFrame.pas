// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.FieldsFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ButtonGroup, CategoryButtons, StdCtrls,
  ExtCtrls, ComCtrls,
  Menus,
  Xilytix.FTEditor.LayoutableFrame,
  Xilytix.FieldedText.BaseField,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.BaseFieldPropertiesFrame,
  Xilytix.FTEditor.StringFieldPropertiesFrame,
  Xilytix.FTEditor.IntegerFieldPropertiesFrame,
  Xilytix.FTEditor.FloatFieldPropertiesFrame,
  Xilytix.FTEditor.DecimalFieldPropertiesFrame,
  Xilytix.FTEditor.DateTimeFieldPropertiesFrame,
  Xilytix.FTEditor.BooleanFieldPropertiesFrame,
  Xilytix.FTEditor.EditorFrame;

type
  TFieldsFrame = class(TEditorFrame)
    FieldsButtonGroup: TButtonGroup;
    PropertiesPanel: TPanel;
    Splitter: TSplitter;
    FieldListPanel: TPanel;
    AddFieldComboBox: TComboBoxEx;
    Label1: TLabel;
    FieldAddRemovePanel: TPanel;
    RemoveButton: TButton;
    procedure AddFieldComboBoxChange(Sender: TObject);
    procedure FieldsButtonGroupButtonClicked(Sender: TObject; Index: Integer);
    procedure RemoveButtonClick(Sender: TObject);
    procedure FieldsButtonGroupReorderButton(Sender: TObject; OldIndex, NewIndex: Integer);
    procedure FieldsButtonGroupStartDrag(Sender: TObject; var DragObject: TDragObject);
  strict private
    class constructor Create;

  private
    type
      TDataTypeInfoRec = record
        DataType: TFieldedTextFieldDataType;
        FrameClass: TBaseFieldPropertiesFrameClass;
      end;
      TDataTypeInfos = array[TFieldedTextFieldDataType] of TDataTypeInfoRec;

    const
      DataTypeInfos: TDataTypeInfos =
      (
        (DataType: ftdtCustom; FrameClass: nil),
        (DataType: ftdtString; FrameClass: TStringFieldPropertiesFrame),
        (DataType: ftdtBoolean; FrameClass: TBooleanFieldPropertiesFrame),
        (DataType: ftdtInteger; FrameClass: TIntegerFieldPropertiesFrame),
        (DataType: ftdtFloat; FrameClass: TFloatFieldPropertiesFrame),
        (DataType: ftdtDateTime; FrameClass: TDateTimeFieldPropertiesFrame),
        (DataType: ftdtDecimal; FrameClass: TDecimalFieldPropertiesFrame)
      );

    var
      FFieldPropertiesFrame: TBaseFieldPropertiesFrame;
      FSelectedCaption: string;

    { Private declarations }
    procedure HandleRefreshFieldsControlsEvent;
    procedure HandleFieldRemovedEvent(field: TFieldedTextField);
    procedure HandleNewOpenTextEvent;
    procedure HandleEditEngineParseEvent;
    procedure HandleFieldCaptionChangeEvent;

    procedure Refresh;

    procedure GetSelectedField(out field: TFieldedTextField; out buttonIdx: Integer);
    procedure SelectIndex(idx: Integer);
    procedure LoadSelectedField(idx: Integer);
    procedure LoadFieldPropertiesFrame(field: TFieldedTextField; idx: Integer);

    function CalculateCaption(field: TFieldedTextField): string;

  protected
    function GetInitialHeight: Integer; override;
    function GetInitialWidth: Integer; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder); override;
    procedure Unprepare; override;

    class function GetTypeId: TLayoutableFrame.TTypeId; override;
    class function GetTypeName: string; override;
    class function GetTypeCaption: string; override;
  end;

implementation

{$R *.dfm}

{ TFieldsFrame }

procedure TFieldsFrame.AddFieldComboBoxChange(Sender: TObject);
var
  ItemData: TObject;
  DataType: TFieldedTextFieldDataType;
  Idx: Integer;
  ButtonItem: TGrpButtonItem;
  Field: TFieldedTextField;
begin
  ItemData := AddFieldComboBox.ItemsEx[AddFieldComboBox.ItemIndex].Data;
  if Assigned(ItemData) then
  begin
    DataType := TFieldedTextFieldDataType(ItemData);
    Idx := FEditEngine.AddField(DataType);
    Field := FEditEngine.Fields[Idx];
    ButtonItem := FieldsButtonGroup.Items.Add;
    Assert(Idx = ButtonItem.Index);
    ButtonItem.Data := Field;
    ButtonItem.Caption := CalculateCaption(Field);
    SelectIndex(Idx);
  end;
  AddFieldComboBox.ItemIndex := 0;
end;

function TFieldsFrame.CalculateCaption(field: TFieldedTextField): string;
begin
  Result := IntToStr(field.Index) + '.' + FEditEngine.DataTypeAbbr[field.DataType] + ': ' + field.Name;
end;

constructor TFieldsFrame.Create(AOwner: TComponent);
var
  I: TFieldedTextFieldDataType;
begin
  inherited;

  AddFieldComboBox.ItemsEx.AddItem('<Add>', -1, -1, -1, 0, nil);
  for I := Low(DataTypeInfos) to High(DataTypeInfos) do
  begin
    if Assigned(DataTypeInfos[I].FrameClass) then
    begin
      AddFieldComboBox.ItemsEx.AddItem(DataTypeInfos[I].FrameClass.GetAddCaption,
                                       -1, -1, -1, 0,
                                       TObject(DataTypeInfos[I].DataType));
    end;
  end;
  AddFieldComboBox.ItemIndex := 0;
end;

class constructor TFieldsFrame.Create;
var
  DataType: TFieldedTextFieldDataType;
begin
  for DataType := Low(DataTypeInfos) to High(DataTypeInfos) do
  begin
    if DataTypeInfos[DataType].DataType <> DataType then
    begin
      raise Exception.Create('TFieldsFrame DataTypeInfos out of order');
    end;
    if Assigned(DataTypeInfos[DataType].FrameClass)
       and
       (DataTypeInfos[DataType].FrameClass.GetDataType <> DataType) then
    begin
      raise Exception.Create('TFieldsFrame DataTypeInfos Frame DataType mismatch');
    end;
  end;
end;

procedure TFieldsFrame.FieldsButtonGroupButtonClicked(Sender: TObject; Index: Integer);
begin
  SelectIndex(Index);
end;

procedure TFieldsFrame.FieldsButtonGroupReorderButton(Sender: TObject; OldIndex, NewIndex: Integer);
begin
  FEditEngine.MoveField(OldIndex, NewIndex);
  FSelectedCaption := CalculateCaption(FEditEngine.Fields[NewIndex]);
  Refresh;
end;

procedure TFieldsFrame.FieldsButtonGroupStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  MousePos: TPoint;
  GotMousePos: Boolean;
  Idx: Integer;
begin
  try
    MousePos := FieldsButtonGroup.ScreenToClient(Mouse.CursorPos);
    GotMousePos := True;
  except
    GotMousePos := False;
  end;

  if GotMousePos then
  begin
    Idx := FieldsButtonGroup.IndexOfButtonAt(MousePos.X, MousePos.Y);
    SelectIndex(Idx);
  end;

  DragCursor := crDrag;
end;

function TFieldsFrame.GetInitialHeight: Integer;
begin
  Result := 200;
end;

function TFieldsFrame.GetInitialWidth: Integer;
begin
  Result := 200;
end;

procedure TFieldsFrame.GetSelectedField(out field: TFieldedTextField; out buttonIdx: Integer);
begin
  buttonIdx := FieldsButtonGroup.ItemIndex;
  if buttonIdx < 0 then
    field := nil
  else
    field := TObject(FieldsButtonGroup.Items[buttonIdx].Data) as TFieldedTextField;
end;

class function TFieldsFrame.GetTypeCaption: string;
begin
  Result := 'Fields';
end;

class function TFieldsFrame.GetTypeId: TLayoutableFrame.TTypeId;
begin
  Result := ftFields;
end;

class function TFieldsFrame.GetTypeName: string;
begin
  Result := 'Fields';
end;

procedure TFieldsFrame.HandleEditEngineParseEvent;
var
  I: Integer;
  Field: TFieldedTextField;
begin
  for I := 0 to FieldsButtonGroup.Items.Count - 1 do
  begin
    Field := TObject(FieldsButtonGroup.Items[I].Data) as TFieldedTextField;
    if Field.HeadingConstraint = fthcNameIsMain then
    begin
      if I = FieldsButtonGroup.ItemIndex then
      begin
        FFieldPropertiesFrame.RefreshName;
      end;
      FieldsButtonGroup.Items[I].Caption := CalculateCaption(Field);
    end;
  end;
end;

procedure TFieldsFrame.HandleFieldCaptionChangeEvent;
var
  Idx: Integer;
  Field: TFieldedTextField;
begin
  if Assigned(FFieldPropertiesFrame) then
  begin
    GetSelectedField(Field, Idx);
    Assert(Idx = FFieldPropertiesFrame.FieldIndex);
    FSelectedCaption := CalculateCaption(Field);
    FieldsButtonGroup.Items[Idx].Caption := FSelectedCaption;
  end;
end;

procedure TFieldsFrame.HandleFieldRemovedEvent(field: TFieldedTextField);
begin
  Refresh;
end;

procedure TFieldsFrame.HandleNewOpenTextEvent;
begin
  SelectIndex(-1);
end;

procedure TFieldsFrame.HandleRefreshFieldsControlsEvent;
begin
  Refresh;
end;

procedure TFieldsFrame.LoadFieldPropertiesFrame(field: TFieldedTextField; idx: Integer);

var
  DataType: TFieldedTextFieldDataType;
  FrameClass: TBaseFieldPropertiesFrameClass;

  procedure DeleteFrame;
  begin
    if Assigned(FFieldPropertiesFrame) then
    begin
      FFieldPropertiesFrame.Unprepare;
      FFieldPropertiesFrame.Free;
      FFieldPropertiesFrame := nil;
    end;
  end;

  procedure CreateFrame;
  begin
    FFieldPropertiesFrame := FrameClass.Create(Owner);
    FFieldPropertiesFrame.Parent := PropertiesPanel;
    FFieldPropertiesFrame.Align := alClient;
    PropertiesPanel.Width := FFieldPropertiesFrame.ImplicitWidth;
    FFieldPropertiesFrame.Prepare(FEditEngine, FBinder, idx);
  end;

begin
  if not Assigned(field) then
    DeleteFrame
  else
  begin
    DataType := field.DataType;
    FrameClass := DataTypeInfos[field.DataType].FrameClass;

    if not Assigned(FrameClass) then
      DeleteFrame
    else
    begin
      if not Assigned(FFieldPropertiesFrame) then
        CreateFrame
      else
      begin
        if FFieldPropertiesFrame.GetDataType <> DataType then
        begin
          DeleteFrame;
          CreateFrame;
        end;
      end;

      FFieldPropertiesFrame.FieldIndex := idx;
      FFieldPropertiesFrame.Refresh;
    end;
  end;
end;

procedure TFieldsFrame.LoadSelectedField(idx: Integer);
var
  Field: TFieldedTextField;
begin
  if idx < 0 then
    Field := nil
  else
    Field := TObject(FieldsButtonGroup.Items[Idx].Data) as TFieldedTextField;

  LoadFieldPropertiesFrame(Field, idx);
end;

procedure TFieldsFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
begin
  inherited;
  FEditEngine.SubscribeRefreshFieldsControlsEvent(HandleRefreshFieldsControlsEvent);
  FEditEngine.SubscribeFieldRemovedEvent(HandleFieldRemovedEvent);
  FEditEngine.SubscribeNewOpenTextEvent(HandleNewOpenTextEvent);
  FEditEngine.SubscribeParseEvent(HandleEditEngineParseEvent);
  FBinder.SubscribeFieldCaptionChangeEvent(HandleFieldCaptionChangeEvent);
end;

procedure TFieldsFrame.Refresh;
var
  ButtonIdx: Integer;
  I: Integer;
  Item: TGrpButtonItem;
  Field: TFieldedTextField;
  ButtonCaption: string;
begin
  ButtonIdx := -1;
  for I := 0 to FEditEngine.FieldCount - 1 do
  begin
    if I < FieldsButtonGroup.Items.Count then
      Item := FieldsButtonGroup.Items[I]
    else
      Item := FieldsButtonGroup.Items.Add;

    Field := FEditEngine.Fields[I];
    ButtonCaption := CalculateCaption(Field);
    Item.Caption := ButtonCaption;
    Item.Data := Field;
    Item.Hint := Field.DataTypeName;

    if ButtonCaption = FSelectedCaption then
    begin
      ButtonIdx := Item.Index;
    end;
  end;

  for I := FieldsButtonGroup.Items.Count - 1 downto FEditEngine.FieldCount do
  begin
    FieldsButtonGroup.Items.Delete(I);
  end;

  SelectIndex(ButtonIdx);
end;

procedure TFieldsFrame.RemoveButtonClick(Sender: TObject);
var
  ButtonIdx: Integer;
  Field: TFieldedTextField;
begin
  GetSelectedField(Field, ButtonIdx);
  FieldsButtonGroup.Items.Delete(ButtonIdx);
  FEditEngine.RemoveField(Field);
  SelectIndex(-1);
end;

procedure TFieldsFrame.SelectIndex(idx: Integer);
begin
  FieldsButtonGroup.ItemIndex := idx;
  LoadSelectedField(idx);
  if idx >= 0 then
    FSelectedCaption := FieldsButtonGroup.Items[idx].Caption
  else
    FSelectedCaption := '';

  RemoveButton.Enabled := idx >= 0;
end;

procedure TFieldsFrame.Unprepare;
begin
  LoadFieldPropertiesFrame(nil, -1);
  FEditEngine.UnsubscribeRefreshFieldsControlsEvent(HandleRefreshFieldsControlsEvent);
  FEditEngine.UnsubscribeFieldRemovedEvent(HandleFieldRemovedEvent);
  FEditEngine.UnsubscribeNewOpenTextEvent(HandleNewOpenTextEvent);
  FEditEngine.UnsubscribeParseEvent(HandleEditEngineParseEvent);
  FBinder.UnsubscribeFieldCaptionChangeEvent(HandleFieldCaptionChangeEvent);
  inherited;
end;

end.
