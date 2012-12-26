// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.SequenceListFrame;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  CategoryButtons,
  ExtCtrls,
  ButtonGroup,
  Xilytix.FieldedText.Sequence,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.SequenceBasePropertiesFrame,
  Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame,
  Xilytix.FTEditor.SequenceRedirect_ExactStringPropertiesFrame,
  Xilytix.FTEditor.SequenceRedirect_CaseInsensitiveStringPropertiesFrame,
  Xilytix.FTEditor.SequenceRedirect_BooleanPropertiesFrame,
  Xilytix.FTEditor.SequenceRedirect_IntegerPropertiesFrame,
  Xilytix.FTEditor.SequenceRedirect_FloatPropertiesFrame,
  Xilytix.FTEditor.SequenceRedirect_DecimalPropertiesFrame,
  Xilytix.FTEditor.SequenceRedirect_ExactDateTimePropertiesFrame,
  Xilytix.FTEditor.SequenceRedirect_DatePropertiesFrame;

type
  TSequenceListFrame = class(TFrame)
    PropertiesPanel: TPanel;
    Buttons: TCategoryButtons;
    ButtonsPanel: TPanel;
    AddItemComboBox: TComboBox;
    AddRemovePanel: TPanel;
    RemoveButton: TButton;
    PropertyButtonsSplitter: TSplitter;
    ButtonsAndPropertyPanel: TPanel;
    procedure AddItemComboBoxChange(Sender: TObject);
    procedure AddItemComboBoxDropDown(Sender: TObject);
    procedure ButtonsSelectedItemChange(Sender: TObject; Button: TButtonItem);
    procedure RemoveButtonClick(Sender: TObject);
    procedure ButtonsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure ButtonsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ButtonsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ButtonsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  strict private
    class constructor Create;

  private
    type
      TItemTypeId = (itSequence,
                     itSequenceItem,
                     itRedirect_ExactString,
                     itRedirect_CaseInsensitiveString,
                     itRedirect_Boolean,
                     itRedirect_ExactInteger,
                     itRedirect_ExactFloat,
                     itRedirect_ExactDateTime,
                     itRedirect_Date,
                     itRedirect_ExactDecimal);

      TItemInfoRec = record
        Id: TItemTypeId;
        AddCaption: string;
      end;

      TItemInfoArray = array[TItemTypeId] of TItemInfoRec;

      TRedirectTypeInfoRec = record
        RedirectType: TFieldedTextSequenceRedirect.TType;
        Id: TItemTypeId;
        FrameClass: TSequenceRedirect_BasePropertiesFrameClass;
      end;

      TRedirectTypeInfoArray = array[TFieldedTextSequenceRedirect.TType] of TRedirectTypeInfoRec;

    const
      SequencesCategoryIndex = 0;
      SequenceItemsCategoryIndex = 1;
      RedirectsCategoryIndex = 2;

      ItemInfoArray: TItemInfoArray =
      (
        (Id: itSequence; AddCaption: 'Sequence'),
        (Id: itSequenceItem; AddCaption: 'Sequence Item'),
        (Id: itRedirect_ExactString; AddCaption: 'Redirect: String'),
        (Id: itRedirect_CaseInsensitiveString; AddCaption: 'Redirect: Case Insensitive String'),
        (Id: itRedirect_Boolean; AddCaption: 'Redirect: Boolean'),
        (Id: itRedirect_ExactInteger; AddCaption: 'Redirect: Integer'),
        (Id: itRedirect_ExactFloat; AddCaption: 'Redirect: Float'),
        (Id: itRedirect_ExactDateTime; AddCaption: 'Redirect: DateTime'),
        (Id: itRedirect_Date; AddCaption: 'Redirect: Date'),
        (Id: itRedirect_ExactDecimal; AddCaption: 'Redirect: Currency')
      );

      RedirectTypeInfoArray: TRedirectTypeInfoArray =
      (
        (RedirectType: ftrtExactString; Id: itRedirect_ExactString; FrameClass: TSequenceRedirect_ExactStringPropertiesFrame),
        (RedirectType: ftrtCaseInsensitiveString; Id: itRedirect_CaseInsensitiveString;
                                           FrameClass: TSequenceRedirect_CaseInsensitiveStringPropertiesFrame),
        (RedirectType: ftrtBoolean; Id: itRedirect_Boolean; FrameClass: TSequenceRedirect_BooleanPropertiesFrame),
        (RedirectType: ftrtExactInteger; Id: itRedirect_ExactInteger; FrameClass: TSequenceRedirect_IntegerPropertiesFrame),
        (RedirectType: ftrtExactFloat; Id: itRedirect_ExactFloat; FrameClass: TSequenceRedirect_FloatPropertiesFrame),
        (RedirectType: ftrtExactDateTime; Id: itRedirect_ExactDateTime;
                                   FrameClass: TSequenceRedirect_ExactDateTimePropertiesFrame),
        (RedirectType: ftrtDate; Id: itRedirect_Date; FrameClass: TSequenceRedirect_DatePropertiesFrame),
        (RedirectType: ftrtExactCurrency; Id: itRedirect_ExactDecimal; FrameClass: TSequenceRedirect_DecimalPropertiesFrame)
      );

    var
      FEditEngine: TEditEngine;
      FBinder: TBinder;

      FSequencesCategory: TButtonCategory;
      FSequenceItemsCategory: TButtonCategory;
      FRedirectsCategory: TButtonCategory;

      FSelectedSequence: TFieldedTextSequence;
      FSelectedSequenceCaption: string;
      FSelectedSequenceItem: TFieldedTextSequenceItem;
      FSelectedSequenceItemCaption: string;
      FSelectedRedirect: TFieldedTextSequenceRedirect;
      FSelectedRedirectCaption: string;

      FPropertiesFrame: TSequenceBasePropertiesFrame;
      FSequenceItemFieldSelectorSorted: Boolean;

      FButtonsDragButton: TButtonItem;
      FButtonsDragStartPos: TPoint;

    procedure HandleRefreshSequencesControlsEvent;
    procedure HandleNewOpenTextEvent;
    procedure HandleSsirCaptionChangeEvent;
    procedure HandleFieldCaptionChangeEvent;
    procedure HandleFieldSelectorSortedChangeEvent;

    procedure PopulateAddItemComboBox(addOnly: Boolean);

    function GetFocusedCategory: TButtonCategory;
    function GetRedirectType(id: TItemTypeId): TFieldedTextSequenceRedirect.TType;

    procedure AddSequence;
    function AddSequenceItem(field: TFieldedText.TField): Integer;
    procedure AddRedirect(Id: TItemTypeId);

    procedure ProcessFocusSequence(idx: Integer);
    procedure SelectSequence(idx: Integer; forceRefreshItems: Boolean);
    procedure UnselectSequence;
    procedure ProcessFocusSequenceItem(idx: Integer);
    procedure SelectSequenceItem(idx: Integer; forceRefreshRedirects: Boolean);
    procedure UnselectSequenceItem;
    procedure ProcessFocusRedirect(idx: Integer);
    procedure SelectRedirect(idx: Integer);
    procedure UnselectRedirect;

    procedure SetPropertiesFrame(frame: TSequenceBasePropertiesFrame);
    procedure RemovePropertiesFrame;

    procedure ClearSequenceItemsCategory;
    procedure ClearRedirectsCategory;

    procedure RefreshSequences;
    procedure RefreshSequenceItems;
    procedure RefreshRedirects;

    function CalculateSequenceCaption(sequence: TFieldedTextSequence): string;
    function CalculateSequenceItemCaption(item: TFieldedTextSequenceItem): string;
    function CalculateRedirectCaption(redirect: TFieldedTextSequenceRedirect): string;

    function IsDraggingFieldOnSequenceItem(Source: TObject; X, Y: Integer;
                                           out buttonGroup: TButtonGroup;
                                           out addToSequence: TFieldedTextSequence;
                                           out modifySequenceItem: TFieldedTextSequenceItem): Boolean;
    function IsDraggingSameCategoryButton(source: TObject; x, y: Integer;
                                          out sourceButton, targetButton: TButtonItem;
                                          out targetCategory: TButtonCategory): Boolean;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property SequenceItemFieldSelectorSorted: Boolean read FSequenceItemFieldSelectorSorted write FSequenceItemFieldSelectorSorted;

    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
    procedure Unprepare;

    procedure Refresh;
    procedure NotifyFieldRemoved(field: TFieldedText.TField);
  end;

implementation

uses
  Types,
  Xilytix.FTEditor.SequencePropertiesFrame,
  Xilytix.FTEditor.SequenceItemPropertiesFrame;

{$R *.dfm}

{ TSequenceListFrame }

procedure TSequenceListFrame.AddItemComboBoxChange(Sender: TObject);
var
  Data: TObject;
  Id: TItemTypeId;
begin
  Data := AddItemComboBox.Items.Objects[AddItemComboBox.ItemIndex];
  Id := TItemTypeId(NativeInt(Data));
  case Id of
    itSequence: AddSequence;
    itSequenceItem: AddSequenceItem(nil);
    else AddRedirect(Id);
  end;

  PopulateAddItemComboBox(True);
end;

procedure TSequenceListFrame.AddItemComboBoxDropDown(Sender: TObject);
begin
  PopulateAddItemComboBox(False);
end;

procedure TSequenceListFrame.ButtonsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  ButtonGroup: TButtonGroup;
  ButtonGroupIdx: Integer;
  AddToSequence: TFieldedTextSequence;
  ModifySequenceItem: TFieldedTextSequenceItem;
  Field: TFieldedText.TField;
  SequenceItemIdx: Integer;
  SourceButton, TargetButton: TButtonItem;
  TargetCategory: TButtonCategory;
  SourceSequence: TFieldedTextSequence;
  TargetSequence: TFieldedTextSequence;
  SourceSequenceItem: TFieldedTextSequenceItem;
  TargetSequenceItem: TFieldedTextSequenceItem;
  SourceRedirect: TFieldedTextSequenceRedirect;
  TargetRedirect: TFieldedTextSequenceRedirect;
begin
  if IsDraggingFieldOnSequenceItem(Source, X, Y, ButtonGroup, AddToSequence, ModifySequenceItem) then
  begin
    ButtonGroupIdx := ButtonGroup.ItemIndex;
    if ButtonGroupIdx >= 0 then
    begin
      Field := TObject(ButtonGroup.Items[ButtonGroupIdx].Data) as TFieldedText.TField;

      if Assigned(ModifySequenceItem) then
      begin
        ModifySequenceItem.Field := Field;
        Buttons.SelectedItem := nil;
        Buttons.SelectedItem := FSequenceItemsCategory.Items[ModifySequenceItem.Index];
      end
      else
      begin
        if Assigned(AddToSequence) then
        begin
          SelectSequence(AddToSequence.Index, False);
          SequenceItemIdx := AddSequenceItem(Field);
          if SequenceItemIdx >= 0  then
          begin
            Buttons.SelectedItem := FSequenceItemsCategory.Items[SequenceItemIdx];
          end;
        end;
      end;
      FEditEngine.RefreshControls(pcSequence);
    end;
  end
  else
  begin
    if IsDraggingSameCategoryButton(Source, X, Y, SourceButton, TargetButton, TargetCategory) then
    begin
      Buttons.RemoveInsertionPoints;
      if TargetCategory = FSequencesCategory then
      begin
        SourceSequence := TObject(SourceButton.Data) as TFieldedTextSequence;
        TargetSequence := TObject(TargetButton.Data) as TFieldedTextSequence;
        FEditEngine.MoveSequence(SourceSequence.Index, TargetSequence.Index);
        FSelectedSequenceCaption := CalculateSequenceCaption(FSelectedSequence);
      end
      else
      begin
        if TargetCategory = FSequenceItemsCategory then
        begin
          SourceSequenceItem := TObject(SourceButton.Data) as TFieldedTextSequenceItem;
          TargetSequenceItem := TObject(TargetButton.Data) as TFieldedTextSequenceItem;
          FEditEngine.MoveSequenceItem(FSelectedSequence, SourceSequenceItem.Index, TargetSequenceItem.Index);
          FSelectedSequenceItem := SourceSequenceItem;
          FSelectedSequenceItemCaption := CalculateSequenceItemCaption(FSelectedSequenceItem);
        end
        else
        begin
          if TargetCategory = FRedirectsCategory then
          begin
            SourceRedirect := TObject(SourceButton.Data) as TFieldedTextSequenceRedirect;
            TargetRedirect := TObject(TargetButton.Data) as TFieldedTextSequenceRedirect;
            FEditEngine.MoveSequenceRedirect(FSelectedSequenceItem, SourceRedirect.Index, TargetRedirect.Index);
            FSelectedRedirect := SourceRedirect;
            FSelectedRedirectCaption := CalculateRedirectCaption(FSelectedRedirect);
          end
          else
          begin
            Assert(False);
          end;
        end;
      end;
      FEditEngine.RefreshControls(pcSequence);
      FButtonsDragButton := nil;
    end;
  end;
end;

procedure TSequenceListFrame.ButtonsDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  ButtonGroup: TButtonGroup;
  AddToSequence: TFieldedTextSequence;
  ModifySequenceItem: TFieldedTextSequenceItem;
  SourceButton, TargetButton: TButtonItem;
  TargetCategory: TButtonCategory;
begin
  if IsDraggingFieldOnSequenceItem(Source, X, Y, ButtonGroup, AddToSequence, ModifySequenceItem) then
  begin
    Accept := True;
    if Assigned(AddToSequence) then
      ButtonGroup.DragCursor := crMultiDrag
    else
      ButtonGroup.DragCursor := crDrag;
  end
  else
  begin
    if IsDraggingSameCategoryButton(Source, X, Y, SourceButton, TargetButton, TargetCategory) then
    begin
      Buttons.SetInsertionButton(TargetButton, TargetCategory);
      Accept := True;
    end
    else
    begin
      Buttons.RemoveInsertionPoints;
      Accept := False;
    end;
  end;
end;

procedure TSequenceListFrame.ButtonsMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FButtonsDragStartPos := Point(X, Y);
end;

procedure TSequenceListFrame.ButtonsMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  DragThreshold: Integer;
begin
  inherited;
  { Was the drag threshold met? }
  if Buttons.DragButton <> nil then
  begin
    DragThreshold := Mouse.DragThreshold;
    if (Abs(FButtonsDragStartPos.X - X) >= DragThreshold) or
        (Abs(FButtonsDragStartPos.Y - Y) >= DragThreshold) then
    begin
      FButtonsDragButton := Buttons.DragButton;
      Buttons.BeginDrag(True);
(*      FDragStartPos.X := X; { Used in the start of the drag }
      FDragStartPos.Y := Y;
      FDownButton := nil; { Stops repaints and clicks }
      if FHotButton <> nil then
      begin
        OldHotButton := FHotButton;
        FHotButton := nil;
        UpdateButton(OldHotButton);
        { We must have the window process the paint message before
          the drag operation starts }
        UpdateWindow(Handle);
        DoHotButton;
      end;
      Buttons.DragStarted := True;
      DoBeginDrag(True, -1);
      Exit;*)
    end;
  end;
end;

procedure TSequenceListFrame.ButtonsSelectedItemChange(Sender: TObject; Button: TButtonItem);
var
  Idx: Integer;
  Category: TButtonCategory;
begin
  if Assigned(Button) then
  begin
    Idx := Button.Index;
    Category := Button.Category;
    if Category = FSequencesCategory then
      ProcessFocusSequence(Idx)
    else
    begin
      if Category = FSequenceItemsCategory then
        ProcessFocusSequenceItem(Idx)
      else
      begin
        if Category = FRedirectsCategory then
          ProcessFocusRedirect(Idx)
        else
          Assert(False);
      end;
    end;
  end;
end;

function TSequenceListFrame.CalculateRedirectCaption(redirect: TFieldedTextSequenceRedirect): string;
var
  Abbr: string;
  Value: string;
begin
  case redirect.GetType of
    ftrtExactString:
    begin
      Abbr := 'ExStr';
      Value := (redirect as TFieldedTextSequenceRedirect_ExactString).Value;
    end;
    ftrtCaseInsensitiveString:
    begin
      Abbr := 'CiStr';
      Value := (redirect as TFieldedTextSequenceRedirect_CaseInsensitiveString).Value;
    end;
    ftrtBoolean:
    begin
      Abbr := 'Boo';
      Value := BoolToStr((redirect as TFieldedTextSequenceRedirect_Boolean).Value);
    end;
    ftrtExactInteger:
    begin
      Abbr := 'ExInt';
      Value := IntToStr((redirect as TFieldedTextSequenceRedirect_ExactInteger).Value);
    end;
    ftrtExactFloat:
    begin
      Abbr := 'ExFlt';
      Value := FloatToStr((redirect as TFieldedTextSequenceRedirect_ExactFloat).Value);
    end;
    ftrtExactDateTime:
    begin
      Abbr := 'ExDtm';
      Value := DateTimeToStr((redirect as TFieldedTextSequenceRedirect_ExactDateTime).Value);
    end;
    ftrtDate:
    begin
      Abbr := 'Date';
      Value := DateToStr((redirect as TFieldedTextSequenceRedirect_Date).Value);
    end;
    ftrtExactCurrency:
    begin
      Abbr := 'ExDec';
      Value := CurrToStr((redirect as TFieldedTextSequenceRedirect_ExactDecimal).Value);
    end
    else
    begin
      Abbr := '';
      Value := '';
      Assert(False);
    end;
  end;

  Result := IntToStr(redirect.Index) + '.' + Abbr + ': ' + Value;
end;

function TSequenceListFrame.CalculateSequenceCaption(sequence: TFieldedTextSequence): string;
begin
  Result := sequence.Name;
end;

function TSequenceListFrame.CalculateSequenceItemCaption(item: TFieldedTextSequenceItem): string;
var
  Field: TFieldedText.TField;
begin
  Result := IntToStr(item.Index);
  Field := item.Field;
  if Assigned(Field) then
  begin
    Result := Result + '.' + FEditEngine.DataTypeAbbr[Field.DataType] + ': ' + Field.Name;
  end;
end;

procedure TSequenceListFrame.ClearSequenceItemsCategory;
begin
  FSequenceItemsCategory.Caption := 'Items';
  FSequenceItemsCategory.Items.Clear;
end;

procedure TSequenceListFrame.ClearRedirectsCategory;
begin
  FRedirectsCategory.Caption := 'Redirects';
  FRedirectsCategory.Items.Clear;
end;

class constructor TSequenceListFrame.Create;
var
  Id: TItemTypeId;
  RedirectType: TFieldedTextSequenceRedirect.TType;
begin
  for Id := Low(TItemTypeId) to High(TItemTypeId) do
  begin
    if Id <> ItemInfoArray[Id].Id then
    begin
      raise Exception.Create('ItemInfoArray out of order');
    end;
  end;

  for RedirectType := Low(TFieldedTextSequenceRedirect.TType) to High(TFieldedTextSequenceRedirect.TType) do
  begin
    if RedirectType <> RedirectTypeInfoArray[RedirectType].RedirectType then
    begin
      raise Exception.Create('RedirectTypeInfoArray out of order');
    end;
  end;
end;

constructor TSequenceListFrame.Create(AOwner: TComponent);
begin
  inherited;

  PopulateAddItemComboBox(True);

  FSequencesCategory := Buttons.Categories[SequencesCategoryIndex];
  FSequenceItemsCategory := Buttons.Categories[SequenceItemsCategoryIndex];
  FRedirectsCategory := Buttons.Categories[RedirectsCategoryIndex];
end;

destructor TSequenceListFrame.Destroy;
begin
  if Assigned(FPropertiesFrame) then
  begin
    RemovePropertiesFrame;
  end;

  inherited;
end;

function TSequenceListFrame.GetFocusedCategory: TButtonCategory;
begin
  if not Assigned(FPropertiesFrame) then
    Result := nil
  else
  begin
    if FPropertiesFrame is TSequencePropertiesFrame then
      Result := FSequencesCategory
    else
    begin
      if FPropertiesFrame is TSequenceItemPropertiesFrame then
        Result := FSequenceItemsCategory
      else
        Result := FRedirectsCategory;
    end;
  end;
end;

function TSequenceListFrame.GetRedirectType(id: TItemTypeId): TFieldedTextSequenceRedirect.TType;
var
  I: TFieldedTextSequenceRedirect.TType;
  Found: Boolean;
begin
  Result := ftrtExactString; // avoid warning
  Found := False;
  for I := Low(RedirectTypeInfoArray) to High(RedirectTypeInfoArray) do
  begin
    if id = RedirectTypeInfoArray[I].Id then
    begin
      Found := True;
      Result := I;
      Break;
    end;
  end;

  if not Found then
  begin
    Assert(False);
  end;
end;

procedure TSequenceListFrame.HandleFieldCaptionChangeEvent;
var
  FocusedCategory: TButtonCategory;
begin
  FocusedCategory := GetFocusedCategory;

  if Assigned(FSelectedSequenceItem) then
  begin
    FSelectedSequenceItemCaption := CalculateSequenceItemCaption(FSelectedSequenceItem);
    FRedirectsCategory.Caption := 'Redirects [' + FSelectedSequenceItemCaption + ']';

    if FocusedCategory = FSequenceItemsCategory then
    begin
      FPropertiesFrame.Refresh;
      Buttons.SelectedItem.Caption := FSelectedSequenceItemCaption;
    end;
  end;
end;

procedure TSequenceListFrame.HandleFieldSelectorSortedChangeEvent;
begin
  FSequenceItemFieldSelectorSorted := (FPropertiesFrame as TSequenceItemPropertiesFrame).FieldSelectorSorted;
end;

procedure TSequenceListFrame.HandleNewOpenTextEvent;
begin
  UnselectSequence;
end;

procedure TSequenceListFrame.HandleRefreshSequencesControlsEvent;
begin
  Refresh;
end;

procedure TSequenceListFrame.HandleSsirCaptionChangeEvent;
var
  FocusedCategory: TButtonCategory;
begin
  FocusedCategory := GetFocusedCategory;

  if FocusedCategory = FSequencesCategory then
  begin
    FSelectedSequenceCaption := CalculateSequenceCaption(FSelectedSequence);
    Buttons.SelectedItem.Caption := FSelectedSequenceCaption;
  end
  else
  begin
    if FocusedCategory = FSequenceItemsCategory then
    begin
      FSelectedSequenceItemCaption := CalculateSequenceItemCaption(FSelectedSequenceItem);
      Buttons.SelectedItem.Caption := FSelectedSequenceItemCaption;
    end
    else
    begin
      if FocusedCategory = FRedirectsCategory then
      begin
        FSelectedRedirectCaption := CalculateRedirectCaption(FSelectedRedirect);
        Buttons.SelectedItem.Caption := FSelectedRedirectCaption;
      end
      else
        Assert(False);
    end;
  end;
end;

function TSequenceListFrame.IsDraggingFieldOnSequenceItem(Source: TObject; X, Y: Integer;
  out buttonGroup: TButtonGroup;
  out addToSequence: TFieldedTextSequence;
  out modifySequenceItem: TFieldedTextSequenceItem): Boolean;
var
  Category: TButtonCategory;
  Button: TButtonItem;
begin
  Result := False;
  addToSequence := nil;
  modifySequenceItem := nil;
  if Source is TButtonGroup then
  begin
    buttonGroup := Source as TButtonGroup;
    if buttonGroup.Name = 'FieldsButtonGroup' then
    begin
      Category := Buttons.GetCategoryAt(X, Y);
      if Assigned(Category) then
      begin
        Button := Buttons.GetButtonAt(X, Y, Category);
        if Category = FSequencesCategory then
        begin
          if Assigned(Button) then
          begin
            addToSequence := TObject(Button.Data) as TFieldedTextSequence;
            Result := True;
          end;
        end
        else
        begin
          if Category = FSequenceItemsCategory then
          begin
            Button := Buttons.GetButtonAt(X, Y, Category);
            if not Assigned(Button) then
            begin
              addToSequence := FSelectedSequence;
              Result := Assigned(addToSequence);
            end
            else
            begin
              modifySequenceItem := TObject(Button.Data) as TFieldedTextSequenceItem;
              Result := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TSequenceListFrame.IsDraggingSameCategoryButton(source: TObject; x, y: Integer;
  out sourceButton, targetButton: TButtonItem;
  out targetCategory: TButtonCategory): Boolean;
begin
  Result := False;
  if source = Buttons then
  begin
    sourceButton := FButtonsDragButton;
    if Assigned(sourceButton) then
    begin
      targetCategory := Buttons.GetCategoryAt(x, y);
      if Assigned(targetCategory) and (targetCategory = sourceButton.Category) then
      begin
        targetButton := Buttons.GetButtonAt(x, y, targetCategory);
        Result := Assigned(targetButton) and (targetButton <> sourceButton);
      end;
    end;
  end;
end;

procedure TSequenceListFrame.NotifyFieldRemoved(field: TFieldedText.TField);
var
  I: Integer;
  ButtonCount: Integer;
  ButtonItem: TButtonItem;
  SequenceItem: TFieldedTextSequenceItem;
begin
  if Assigned(FSelectedSequenceItem) and (FSelectedSequenceItem.Field = field) then
  begin
    UnselectSequenceItem;
  end;

  ButtonCount := FSequenceItemsCategory.Items.Count;
  for I := ButtonCount-1 downto 0 do
  begin
    ButtonItem := FSequenceItemsCategory.Items[I];
    SequenceItem := TObject(ButtonItem.Data) as TFieldedTextSequenceItem;
    if Assigned(SequenceItem) and (SequenceItem.Field = field) then
    begin
      FSequenceItemsCategory.Items.Delete(I);
    end;
  end;
end;

procedure TSequenceListFrame.PopulateAddItemComboBox(addOnly: Boolean);
var
  Id: TItemTypeId;
begin
  AddItemComboBox.Items.Clear;
  AddItemComboBox.Items.Add('<Add>');
  AddItemComboBox.ItemIndex := 0;
  if not addOnly then
  begin
    AddItemComboBox.Items.AddObject(ItemInfoArray[itSequence].AddCaption, TObject(NativeInt(ItemInfoArray[itSequence].Id)));

    if Assigned(FSelectedSequence) and (FEditEngine.FieldCount > 0) then
    begin
      AddItemComboBox.Items.AddObject(ItemInfoArray[itSequenceItem].AddCaption, TObject(NativeInt(ItemInfoArray[itSequenceItem].Id)))
    end;

    if Assigned(FSelectedSequenceItem) then
    begin
      for Id := Low(ItemInfoArray) to High(ItemInfoArray) do
      begin
        case Id of
          itSequence, itSequenceItem: ;
          else AddItemComboBox.Items.AddObject(ItemInfoArray[Id].AddCaption, TObject(NativeInt(ItemInfoArray[Id].Id)));
        end;
      end;
    end;
  end;
end;

procedure TSequenceListFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
begin
  FEditEngine := myEditEngine;
  FBinder := myBinder;

  FEditEngine.SubscribeRefreshSequencesControlsEvent(HandleRefreshSequencesControlsEvent);
  FEditEngine.SubscribeNewOpenTextEvent(HandleNewOpenTextEvent);
  FBinder.SubscribeFieldCaptionChangeEvent(HandleFieldCaptionChangeEvent);
  FBinder.SubscribeSsirCaptionChangeEvent(HandleSsirCaptionChangeEvent);
end;

procedure TSequenceListFrame.ProcessFocusRedirect(idx: Integer);
var
  KeepPropertiesFrame: Boolean;
  RedirectPropertiesFrame: TSequenceRedirect_BasePropertiesFrame;
  Redirect: TFieldedTextSequenceRedirect;
begin
  SelectRedirect(idx);

  RedirectPropertiesFrame := nil; // avoid warning
  Redirect := TObject(FRedirectsCategory.Items[idx].Data) as TFieldedTextSequenceRedirect;

  KeepPropertiesFrame := Assigned(FPropertiesFrame) and (FPropertiesFrame is TSequenceRedirect_BasePropertiesFrame);
  if KeepPropertiesFrame then
  begin
    RedirectPropertiesFrame := FPropertiesFrame as TSequenceRedirect_BasePropertiesFrame;
    KeepPropertiesFrame := RedirectPropertiesFrame.Redirect.GetType = Redirect.GetType;
  end;

  if not KeepPropertiesFrame then
  begin
    if Assigned(FPropertiesFrame) then
    begin
      RemovePropertiesFrame;
    end;
    RedirectPropertiesFrame := RedirectTypeInfoArray[Redirect.GetType].FrameClass.Create(Self);
    SetPropertiesFrame(RedirectPropertiesFrame);
  end;

  RedirectPropertiesFrame.Redirect := FSelectedRedirect;
  RedirectPropertiesFrame.Refresh;

  RemoveButton.Enabled := True;
end;

procedure TSequenceListFrame.ProcessFocusSequence(idx: Integer);
var
  KeepPropertiesFrame: Boolean;
  SequencePropertiesFrame: TSequencePropertiesFrame;
begin
  SelectSequence(idx, False);

  KeepPropertiesFrame := Assigned(FPropertiesFrame) and (FPropertiesFrame is TSequencePropertiesFrame);

  if KeepPropertiesFrame then
    SequencePropertiesFrame := FPropertiesFrame as TSequencePropertiesFrame
  else
  begin
    if Assigned(FPropertiesFrame) then
    begin
      RemovePropertiesFrame;
    end;
    SequencePropertiesFrame := TSequencePropertiesFrame.Create(Self);
    SetPropertiesFrame(SequencePropertiesFrame);
  end;

  SequencePropertiesFrame.Sequence := FSelectedSequence;
  SequencePropertiesFrame.Refresh;

  RemoveButton.Enabled := True;
end;

procedure TSequenceListFrame.ProcessFocusSequenceItem(idx: Integer);
var
  KeepPropertiesFrame: Boolean;
  SequenceItemPropertiesFrame: TSequenceItemPropertiesFrame;
begin
  SelectSequenceItem(idx, False);

  KeepPropertiesFrame := Assigned(FPropertiesFrame) and (FPropertiesFrame is TSequenceItemPropertiesFrame);

  if KeepPropertiesFrame then
    SequenceItemPropertiesFrame := FPropertiesFrame as TSequenceItemPropertiesFrame
  else
  begin
    if Assigned(FPropertiesFrame) then
    begin
      RemovePropertiesFrame;
    end;
    SequenceItemPropertiesFrame := TSequenceItemPropertiesFrame.Create(Self);
    SequenceItemPropertiesFrame.FieldSelectorSorted := FSequenceItemFieldSelectorSorted;
    SequenceItemPropertiesFrame.FieldSelectorSortedChangeEvent := HandleFieldSelectorSortedChangeEvent;
    SetPropertiesFrame(SequenceItemPropertiesFrame);
  end;

  SequenceItemPropertiesFrame.SequenceItem := FSelectedSequenceItem;
  SequenceItemPropertiesFrame.Refresh;

  RemoveButton.Enabled := True;
end;

procedure TSequenceListFrame.Refresh;
begin
  RefreshSequences;
end;

procedure TSequenceListFrame.AddRedirect(Id: TItemTypeId);
var
  Idx: Integer;
  RedirectType: TFieldedTextSequenceRedirect.TType;
  Redirect: TFieldedTextSequenceRedirect;
  ButtonItem: TButtonItem;
begin
  if Assigned(FSelectedSequenceItem) then
  begin
    ButtonItem := FRedirectsCategory.Items.Add;
    Idx := ButtonItem.Index;
    RedirectType := GetRedirectType(Id);
    Redirect := FEditEngine.InsertRedirect(FSelectedSequenceItem, Idx, RedirectType);
    Redirect.Sequence := FEditEngine.Sequences[0];
    ButtonItem.Caption := CalculateRedirectCaption(Redirect);
    ButtonItem.Data := Redirect;
    SelectRedirect(Idx);
    Buttons.SelectedItem := ButtonItem;
  end;
end;

procedure TSequenceListFrame.AddSequence;
var
  Sequence: TFieldedTextSequence;
  ButtonItem: TButtonItem;
begin
  ButtonItem := FSequencesCategory.Items.Add;
  Sequence := FEditEngine.InsertSequence(ButtonItem.Index);
  ButtonItem.Caption := CalculateSequenceCaption(Sequence);
  ButtonItem.Data := Sequence;
  SelectSequence(ButtonItem.Index, False);
  Buttons.SelectedItem := ButtonItem;
end;

function TSequenceListFrame.AddSequenceItem(field: TFieldedText.TField): Integer;
var
  SequenceItem: TFieldedTextSequenceItem;
  ButtonItem: TButtonItem;
begin
  if not Assigned(FSelectedSequence) or (FEditEngine.FieldCount = 0) then
    Result := -1
  else
  begin
    if not Assigned(field) then
    begin
      field := FEditEngine.Fields[0];
    end;
    ButtonItem := FSequenceItemsCategory.Items.Add;
    Result := ButtonItem.Index;
    SequenceItem := FEditEngine.InsertSequenceItem(FSelectedSequence, Result, field);
    ButtonItem.Caption := CalculateSequenceItemCaption(SequenceItem);
    ButtonItem.Data := SequenceItem;
    SelectSequenceItem(Result, False);
    Buttons.SelectedItem := ButtonItem;
  end;
end;

procedure TSequenceListFrame.RefreshRedirects;
var
  I: Integer;
  WasSelected: Boolean;
  WasFocused: Boolean;
  RedirectCount, ButtonCount: Integer;
  ButtonItem: TButtonItem;
  Caption: string;
  Redirect: TFieldedTextSequenceRedirect;
  SelectedRedirectIdx: Integer;
begin
  WasSelected := Assigned(FSelectedRedirect);
  WasFocused := GetFocusedCategory = FRedirectsCategory;
  FSelectedRedirect := nil;
  SelectedRedirectIdx := -1;

  RedirectCount := FSelectedSequenceItem.RedirectCount;
  ButtonCount := FRedirectsCategory.Items.Count;

  for I := 0 to RedirectCount-1 do
  begin
    Redirect := FSelectedSequenceItem.Redirects[I];
    Caption := CalculateRedirectCaption(Redirect);

    if I >= ButtonCount then
      ButtonItem := FRedirectsCategory.Items.Add
    else
      ButtonItem := FRedirectsCategory.Items[I];

    ButtonItem.Caption := Caption;
    ButtonItem.Data := Redirect;

    if (FSelectedRedirectCaption = Caption) and not Assigned(FSelectedRedirect) then
    begin
      SelectedRedirectIdx := I;
    end;
  end;

  for I := ButtonCount - 1 downto RedirectCount do
  begin
    FRedirectsCategory.Items.Delete(I);
  end;

  if not WasSelected then
    UnselectRedirect
  else
  begin
    if SelectedRedirectIdx < 0 then
      UnselectRedirect
    else
    begin
      SelectRedirect(SelectedRedirectIdx);

      if WasFocused then
      begin
        ProcessFocusRedirect(SelectedRedirectIdx);
      end;
    end;
  end;
end;

procedure TSequenceListFrame.RefreshSequenceItems;
var
  I: Integer;
  WasSelected: Boolean;
  WasFocused: Boolean;
  SequenceItemCount, ButtonCount: Integer;
  ButtonItem: TButtonItem;
  Caption: string;
  SequenceItem: TFieldedTextSequenceItem;
  SelectedSequenceItemIdx: Integer;
begin
  WasSelected := Assigned(FSelectedSequenceItem);
  WasFocused := GetFocusedCategory = FSequenceItemsCategory;
  FSelectedSequenceItem := nil;
  SelectedSequenceItemIdx := -1;

  SequenceItemCount := FSelectedSequence.Count;
  ButtonCount := FSequenceItemsCategory.Items.Count;

  for I := 0 to SequenceItemCount-1 do
  begin
    SequenceItem := FSelectedSequence[I];
    Caption := CalculateSequenceItemCaption(SequenceItem);

    if I >= ButtonCount then
      ButtonItem := FSequenceItemsCategory.Items.Add
    else
      ButtonItem := FSequenceItemsCategory.Items[I];

    ButtonItem.Caption := Caption;
    ButtonItem.Data := SequenceItem;

    if (FSelectedSequenceItemCaption = Caption) and not Assigned(FSelectedSequenceItem) then
    begin
      selectedSequenceItemIdx := I;
      FSelectedSequenceItem := SequenceItem;
    end;
  end;

  for I := ButtonCount - 1 downto SequenceItemCount do
  begin
    FSequenceItemsCategory.Items.Delete(I);
  end;

  if not WasSelected then
    UnselectSequenceItem
  else
  begin
    if SelectedSequenceItemIdx < 0 then
      UnselectSequenceItem
    else
    begin
      SelectSequenceItem(SelectedSequenceItemIdx, True);

      if WasFocused then
      begin
        ProcessFocusSequenceItem(SelectedSequenceItemIdx);
      end;
    end;
  end;
end;

procedure TSequenceListFrame.RefreshSequences;
var
  I: Integer;
  WasSelected: Boolean;
  WasFocused: Boolean;
  SequenceCount, ButtonCount: Integer;
  ButtonItem: TButtonItem;
  Caption: string;
  Sequence: TFieldedTextSequence;
  SelectedSequenceIdx: Integer;
begin
  WasSelected := Assigned(FSelectedSequence);
  WasFocused := GetFocusedCategory = FSequencesCategory;
  FSelectedSequence := nil;
  SelectedSequenceIdx := -1;

  SequenceCount := FEditEngine.SequenceCount;
  ButtonCount := FSequencesCategory.Items.Count;

  for I := 0 to SequenceCount-1 do
  begin
    Sequence := FEditEngine.Sequences[I];
    Caption := CalculateSequenceCaption(Sequence);

    if I >= ButtonCount then
      ButtonItem := FSequencesCategory.Items.Add
    else
      ButtonItem := FSequencesCategory.Items[I];

    ButtonItem.Caption := Caption;
    ButtonItem.Data := Sequence;

    if (FSelectedSequenceCaption = Caption) and not Assigned(FSelectedSequence) then
    begin
      selectedSequenceIdx := I;
      FSelectedSequence := Sequence;
    end;
  end;

  for I := ButtonCount - 1 downto SequenceCount do
  begin
    FSequencesCategory.Items.Delete(I);
  end;

  if not WasSelected then
    UnselectSequence
  else
  begin
    if SelectedSequenceIdx < 0 then
      UnselectSequence
    else
    begin
      SelectSequence(SelectedSequenceIdx, True);

      if WasFocused then
      begin
        ProcessFocusSequence(SelectedSequenceIdx);
      end;
    end;
  end;
end;

procedure TSequenceListFrame.RemoveButtonClick(Sender: TObject);
var
  FocusedCategory: TButtonCategory;
  Idx: Integer;
begin
  FocusedCategory := GetFocusedCategory;
  if FocusedCategory = FSequencesCategory then
  begin
    Idx := FSelectedSequence.Index;
    UnselectSequence;
    FEditEngine.RemoveSequence(Idx);
  end
  else
  begin
    if FocusedCategory = FSequenceItemsCategory then
    begin
      Idx := FSelectedSequenceItem.Index;
      UnselectSequenceItem;
      FEditEngine.RemoveSequenceItem(FSelectedSequence, Idx);
    end
    else
    begin
      if FocusedCategory = FRedirectsCategory then
      begin
        Idx := FSelectedRedirect.Index;
        UnselectRedirect;
        FEditEngine.RemoveSequenceRedirect(FSelectedSequenceItem, Idx);
      end
      else
      begin
        Assert(False);
      end;
    end;
  end;

  RemoveButton.Enabled := False;
end;

procedure TSequenceListFrame.RemovePropertiesFrame;
begin
  if Assigned(FPropertiesFrame) then
  begin
    if FPropertiesFrame is TSequenceItemPropertiesFrame then
    begin
      TSequenceItemPropertiesFrame(FPropertiesFrame).FieldSelectorSortedChangeEvent := nil;
    end;
    
    FPropertiesFrame.Unprepare;
    FPropertiesFrame.Free;
    FPropertiesFrame := nil;
  end;

  RemoveButton.Enabled := False;
end;

procedure TSequenceListFrame.SelectRedirect(idx: Integer);
begin
  FSelectedRedirect := TObject(FRedirectsCategory.Items[idx].Data) as TFieldedTextSequenceRedirect;
  FSelectedRedirectCaption := CalculateRedirectCaption(FSelectedRedirect);
end;

procedure TSequenceListFrame.SelectSequence(idx: Integer; forceRefreshItems: Boolean);
var
  NewSelectedSequence: TFieldedTextSequence;
begin
  NewSelectedSequence := TObject(FSequencesCategory.Items[idx].Data) as TFieldedTextSequence;

  if NewSelectedSequence <> FSelectedSequence then
  begin
    FSelectedSequence := NewSelectedSequence;
    UnselectSequenceItem;
    RefreshSequenceItems;
  end
  else
  begin
    if forceRefreshItems then
    begin
      RefreshSequenceItems;
    end;
  end;

  FSelectedSequenceCaption := CalculateSequenceCaption(FSelectedSequence);
  FSequenceItemsCategory.Caption := 'Items [' + FSelectedSequenceCaption + ']';
end;

procedure TSequenceListFrame.SelectSequenceItem(idx: Integer; forceRefreshRedirects: Boolean);
var
  NewSelectedSequenceItem: TFieldedTextSequenceItem;
begin
  NewSelectedSequenceItem := TObject(FSequenceItemsCategory.Items[idx].Data) as TFieldedTextSequenceItem;

  if NewSelectedSequenceItem <> FSelectedSequenceItem then
  begin
    FSelectedSequenceItem := NewSelectedSequenceItem;
    UnselectRedirect;
    RefreshRedirects;
  end
  else
  begin
    if forceRefreshRedirects then
    begin
      RefreshRedirects;
    end;
  end;

  FSelectedSequenceItemCaption := CalculateSequenceItemCaption(FSelectedSequenceItem);
  FRedirectsCategory.Caption := 'Redirects [' + FSelectedSequenceItemCaption + ']';
end;

procedure TSequenceListFrame.SetPropertiesFrame(frame: TSequenceBasePropertiesFrame);
begin
  FPropertiesFrame := frame;
  FPropertiesFrame.Parent := PropertiesPanel;
  FPropertiesFrame.Align := alClient;
  FPropertiesFrame.Prepare(FEditEngine, FBinder);
end;

procedure TSequenceListFrame.Unprepare;
begin
  FEditEngine.UnsubscribeRefreshSequencesControlsEvent(HandleRefreshSequencesControlsEvent);
  FEditEngine.UnsubscribeNewOpenTextEvent(HandleNewOpenTextEvent);
  FBinder.UnsubscribeSsirCaptionChangeEvent(HandleSsirCaptionChangeEvent);
  FBinder.UnsubscribeFieldCaptionChangeEvent(HandleFieldCaptionChangeEvent);

  FEditEngine := nil;
  FBinder := nil;
end;

procedure TSequenceListFrame.UnselectRedirect;
var
  BaseItem: TBaseItem;
  ButtonItem: TButtonItem;
  Category: TButtonCategory;
begin
  BaseItem := Buttons.SelectedItem;
  if BaseItem is TButtonItem then
  begin
    ButtonItem := Buttons.SelectedItem as TButtonItem;
    if Assigned(ButtonItem) and (ButtonItem.Category = FRedirectsCategory) then
    begin
      Buttons.SelectedItem := nil;
    end;
  end
  else
  begin
    if BaseItem is TButtonCategory then
    begin
      Category := Buttons.SelectedItem as TButtonCategory;
      if Assigned(Category) and (Category = FRedirectsCategory) then
      begin
        Buttons.SelectedItem := nil;
      end;
    end;
  end;

  if GetFocusedCategory = FRedirectsCategory then
  begin
    RemovePropertiesFrame;
    Buttons.FocusedItem := nil;
  end;

  FSelectedRedirect := nil;
  FSelectedRedirectCaption := '';
end;

procedure TSequenceListFrame.UnselectSequence;
begin
  UnselectSequenceItem;

  RemovePropertiesFrame;
  Buttons.SelectedItem := nil;
  Buttons.FocusedItem := nil;

  ClearSequenceItemsCategory;
  FSelectedSequence := nil;
  FSelectedSequenceCaption := '';
end;

procedure TSequenceListFrame.UnselectSequenceItem;
var
  BaseItem: TBaseItem;
  ButtonItem: TButtonItem;
  Category: TButtonCategory;
begin
  UnselectRedirect;

  BaseItem := Buttons.SelectedItem;
  if BaseItem is TButtonItem then
  begin
    ButtonItem := Buttons.SelectedItem as TButtonItem;
    if Assigned(ButtonItem) and (ButtonItem.Category = FSequenceItemsCategory) then
    begin
      Buttons.SelectedItem := nil;
    end;
  end
  else
  begin
    if BaseItem is TButtonCategory then
    begin
      Category := Buttons.SelectedItem as TButtonCategory;
      if Assigned(Category) and (Category = FSequenceItemsCategory) then
      begin
        Buttons.SelectedItem := nil;
      end;
    end;
  end;

  if GetFocusedCategory = FSequenceItemsCategory then
  begin
    RemovePropertiesFrame;
    Buttons.FocusedItem := nil;
  end;

  ClearRedirectsCategory;
  FSelectedSequenceItem := nil;
  FSelectedSequenceItemCaption := '';
end;

end.
