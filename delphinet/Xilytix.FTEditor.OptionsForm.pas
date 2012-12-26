// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.OptionsForm;

interface

uses
  System.ComponentModel,
  Borland.Vcl.Windows,
  Borland.Vcl.Messages,
  Borland.Vcl.SysUtils,
  Borland.Vcl.Variants,
  Borland.Vcl.Classes,
  Borland.Vcl.Graphics,
  Borland.Vcl.Controls,
  Borland.Vcl.Forms,
  Borland.Vcl.Dialogs,
  Borland.Vcl.StdCtrls,
  Borland.Vcl.ComCtrls,
  Borland.Vcl.ExtCtrls,
  Borland.Vcl.ActnList,
  Borland.Vcl.ButtonGroup,
  Xilytix.FTEditor.Colors,
  Xilytix.FTEditor.Configuration;

type
  TOptionsForm = class(TForm)
    BottomPanel: TPanel;
    PageControl: TPageControl;
    MetaTabSheet: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    IgnoreDeclaredMetaCheckBox: TCheckBox;
    IndentMetaXmlCheckBox: TCheckBox;
    MetaIndentationEdit: TEdit;
    EmbeddedMetaMarginEdit: TEdit;
    OkButton: TButton;
    CancelButton: TButton;
    ControlsTabSheet: TTabSheet;
    DefaultNonViewableCharacterFormatComboBox: TComboBoxEx;
    Label4: TLabel;
    Label7: TLabel;
    DisplayCultureComboBox: TComboBoxEx;
    NamedDisplayCultureEdit: TEdit;
    Label8: TLabel;
    DisplayEncodingComboBox: TComboBoxEx;
    NamedDisplayEncodingEdit: TEdit;
    SaveDesignOnlyMetaCheckBox: TCheckBox;
    SaveMetaWithExplicitIndicesCheckBox: TCheckBox;
    ResetMetaForNewOpenTextCheckBox: TCheckBox;
    ActionList: TActionList;
    OkAction: TAction;
    MetaIndentCharComboBox: TComboBoxEx;
    TextTabSheet: TTabSheet;
    GridTabSheet: TTabSheet;
    ColoursTabSheet: TTabSheet;
    ColoursButtonGroup: TButtonGroup;
    ColoursPropertyPanel: TPanel;
    ColourItemLabel: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    BackgroundColorBox: TColorBox;
    FontColorBox: TColorBox;
    Label11: TLabel;
    GridFontSelectButton: TButton;
    FontDialog: TFontDialog;
    ColourBoldFontStyleCheckBox: TCheckBox;
    ColourItalicFontStyleCheckBox: TCheckBox;
    ColourUnderlineFontStyleCheckBox: TCheckBox;
    ColourStrikeOutFontStyleCheckBox: TCheckBox;
    ColourExampleMemo: TMemo;
    ColoursLeftPanel: TPanel;
    ColoursLeftBottomPanel: TPanel;
    ColoursLoadSchemeButton: TButton;
    ColoursSaveSchemeButton: TButton;
    GridFontExampleEdit: TEdit;
    GridFontResetButton: TButton;
    FontGroupBox: TGroupBox;
    TextFontGroupBox: TGroupBox;
    TextFontSelectButton: TButton;
    TextFontResetButton: TButton;
    TextFontExampleMemo: TMemo;
    GridHorizontalLinesVisibleCheckBox: TCheckBox;
    GridVerticalLinesVisibleCheckBox: TCheckBox;
    GridShowFieldNamesIfNoFixedHeadingRowsCheckBox: TCheckBox;
    FixedHeadingRowsCheckBox: TCheckBox;
    GridRowHeightGroupBox: TGroupBox;
    GridRowHeightAutoRadioButton: TRadioButton;
    GridRowHeightManualRadioButton: TRadioButton;
    GridRowHeightEdit: TEdit;
    GridTrackMouseCheckBox: TCheckBox;
    GridTrackCursorCheckBox: TCheckBox;
    TextTrackCursorCheckBox: TCheckBox;
    TextTrackMouseCheckBox: TCheckBox;
    ColorTextCheckBox: TCheckBox;
    OtherTabSheet: TTabSheet;
    NumberFromZeroCheckBox: TCheckBox;
    SourceOnNewOpenTextGroupBox: TGroupBox;
    CurrentSourceRadioButton: TRadioButton;
    AllReadOnlySourceRadioButton: TRadioButton;
    TextSourceRadioButton: TRadioButton;
    TextSourceLatchedCheckBox: TCheckBox;
    GridSourceRadioButton: TRadioButton;
    GridSourceLatchedCheckBox: TCheckBox;
    WrapTextCheckBox: TCheckBox;
    Label5: TLabel;
    GridNullTextEdit: TEdit;
    Label6: TLabel;
    Label12: TLabel;
    DefaultCharEncodingGroupBox: TGroupBox;
    Label13: TLabel;
    TextFileDefaultCharEncodingComboBox: TComboBoxEx;
    MetaFileDefaultCharEncodingComboBox: TComboBoxEx;
    Label14: TLabel;
    procedure IntegerEditExit(Sender: TObject);
    procedure IntegerEditKeyPress(Sender: TObject; var Key: Char);
    procedure OkActionExecute(Sender: TObject);
    procedure OkActionUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure NamedDisplayCultureEditExit(Sender: TObject);
    procedure NamedDisplayCultureEditKeyPress(Sender: TObject; var Key: Char);
    procedure NamedDisplayEncodingEditExit(Sender: TObject);
    procedure NamedDisplayEncodingEditKeyPress(Sender: TObject; var Key: Char);
    procedure ColorBoxChange(Sender: TObject);
    procedure ColoursButtonGroupButtonClicked(Sender: TObject; Index: Integer);
    procedure ColoursLoadSchemeButtonClick(Sender: TObject);
    procedure ColoursSaveSchemeButtonClick(Sender: TObject);
    procedure ColoursButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TextFontSelectButtonClick(Sender: TObject);
    procedure GridFontSelectButtonClick(Sender: TObject);
    procedure TextFontResetButtonClick(Sender: TObject);
    procedure GridFontResetButtonClick(Sender: TObject);
    procedure ColorFontStyleCheckBoxClick(Sender: TObject);
    procedure CurrentSourceRadioButtonClick(Sender: TObject);
    procedure AllReadOnlySourceRadioButtonClick(Sender: TObject);
    procedure TextSourceRadioButtonClick(Sender: TObject);
    procedure GridSourceRadioButtonClick(Sender: TObject);
    procedure TextSourceLatchedCheckBoxClick(Sender: TObject);
    procedure GridSourceLatchedCheckBoxClick(Sender: TObject);
    procedure GridRowHeightEditKeyPress(Sender: TObject; var Key: Char);
    procedure GridRowHeightAutoRadioButtonClick(Sender: TObject);
    procedure GridRowHeightManualRadioButtonClick(Sender: TObject);
    procedure GridRowHeightEditExit(Sender: TObject);
    procedure GridRowHeightEditEnter(Sender: TObject);
  private
    FOk: Boolean;
    FErrorCount: Integer;

    FTextFont: TFont;
    FGridFont: TFont;
    FColorItems: TColorItems;
    FSourceOnNewOpenText: TSourceOnNewOpenText;

    FResolvedColors: TResolvedColors;
    FLoadedColorItemId: TColorItemId;
    FLoadingControlsCount: Integer;

    { Private declarations }

    procedure Initialise;

    procedure ClearErrors;

    procedure ClearControlError(control: TWinControl);
    procedure SetControlError(control: TWinControl);

    function TryStrToInteger(str: string; out value: Integer): Boolean;
    function CheckIntegerEdit(edit: TEdit; out value: Integer): Boolean; overload;
    procedure CheckIntegerEdit(edit: TEdit); overload;

    procedure CheckCultureEdit(edit: TEdit);
    procedure CheckEncodingEdit(edit: TEdit);

    procedure CalculateGridRowHeight; overload;
    function CalculateGridRowHeight(out auto: Boolean; out manualRowHeight, actualRowHeight: Integer): Boolean; overload;

    procedure LoadColor; overload;
    procedure LoadColor(id: TColorItemId); overload;
    procedure SaveColor;

    procedure SelectFont(var targetFont: TFont; exampleControl: TcustomEdit);

    procedure LoadSourceOnNewOpenText;

    procedure Load;
    procedure Save;

    function GetLoadingControls: Boolean;
    property LoadingControls: Boolean read GetLoadingControls;
  public
    { Public declarations }
  end;

implementation

{$R *.nfm}

uses
  System.Xml,
  System.Globalization,
  System.Text,
  Xilytix.FTEditor.GridViewFrame,
  Xilytix.FTEditor.ColorSchemaForm;

procedure TOptionsForm.AllReadOnlySourceRadioButtonClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    FSourceOnNewOpenText := soReadOnly;
    LoadSourceOnNewOpenText;
  end;
end;

procedure TOptionsForm.CalculateGridRowHeight;
var
  DummyAuto: Boolean;
  DummyManualRowHeight: Integer;
  DummyActualRowHeight: Integer;
begin
  CalculateGridRowHeight(DummyAuto, DummyManualRowHeight, DummyActualRowHeight);
end;

function TOptionsForm.CalculateGridRowHeight(out auto: Boolean; out manualRowHeight, actualRowHeight: Integer): Boolean;
begin
  auto := GridRowHeightAutoRadioButton.Checked;
  Result := CheckIntegerEdit(GridRowHeightEdit, manualRowHeight);
  if auto or Result then
  begin
    if not auto then
      actualRowHeight := manualRowHeight
    else
      actualRowHeight := TGridViewFrame.CalculateGridAutoRowHeight(FGridFont);

    GridFontExampleEdit.Height := actualRowHeight;
  end;
end;

procedure TOptionsForm.CheckCultureEdit(edit: TEdit);
var
  DummyValue: CultureInfo;
  Error: Boolean;
begin
  try
    DummyValue := CultureInfo.Create(edit.Text);
    Error := False;
  except
    on ArgumentException do Error := True;
  end;

  if Error then
    SetControlError(edit)
  else
    ClearControlError(edit);
end;

procedure TOptionsForm.CheckEncodingEdit(edit: TEdit);
var
  DummyValue: Encoding;
  Error: Boolean;
begin
  try
    DummyValue := System.Text.Encoding.GetEncoding(edit.Text);
    Error := False;
  except
    on ArgumentException do Error := True;
  end;

  if Error then
    SetControlError(edit)
  else
    ClearControlError(edit);
end;

procedure TOptionsForm.CheckIntegerEdit(edit: TEdit);
var
  DummyValue: Integer;
begin
  CheckIntegerEdit(edit, DummyValue);
end;

function TOptionsForm.CheckIntegerEdit(edit: TEdit; out value: Integer): Boolean;
begin
  Result := TryStrToInteger(edit.Text, value);
  if Result then
    ClearControlError(edit)
  else
    SetControlError(edit);
end;

procedure TOptionsForm.ClearControlError(control: TWinControl);
begin
  if control.Color = Configuration.Colors[rcControlError].Background then
  begin
    Dec(FErrorCount);
  end;
  control.Color := Configuration.Colors[rcControlOk].Background;
end;

procedure TOptionsForm.ClearErrors;
begin
  ClearControlError(MetaIndentationEdit);
  ClearControlError(EmbeddedMetaMarginEdit);
  ClearControlError(NamedDisplayCultureEdit);
  ClearControlError(NamedDisplayEncodingEdit);

  FErrorCount := 0;
end;

procedure TOptionsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FOk then
  begin
    Save;
  end;
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
  Initialise;
  Load;
end;

function TOptionsForm.GetLoadingControls: Boolean;
begin
  Result := FLoadingControlsCount > 0;
end;

procedure TOptionsForm.GridFontResetButtonClick(Sender: TObject);
begin
  FGridFont.Assign(Configuration.CreateDefaultGridFont);
  GridFontExampleEdit.Font := FGridFont;
end;

procedure TOptionsForm.GridFontSelectButtonClick(Sender: TObject);
begin
  SelectFont(FGridFont, GridFontExampleEdit);
end;

procedure TOptionsForm.GridRowHeightAutoRadioButtonClick(Sender: TObject);
var
  Auto: Boolean;
  DummyManualRowHeight: Integer;
  ActualRowHeight: Integer;
begin
  if not LoadingControls then
  begin
    if CalculateGridRowHeight(Auto, DummyManualRowHeight, ActualRowHeight) then
    begin
      if Auto then
      begin
        GridRowHeightEdit.Text := ActualRowHeight.ToString;
      end;
    end;
  end;
end;

procedure TOptionsForm.GridRowHeightEditEnter(Sender: TObject);
begin
  Inc(FLoadingControlsCount);
  try
    GridRowHeightManualRadioButton.Checked := True;
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TOptionsForm.GridRowHeightEditExit(Sender: TObject);
begin
  if not LoadingControls then
  begin
    CalculateGridRowHeight;
  end;
end;

procedure TOptionsForm.GridRowHeightEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    CalculateGridRowHeight;
    Key := #0;
  end;
end;

procedure TOptionsForm.GridRowHeightManualRadioButtonClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    CalculateGridRowHeight;
    GridRowHeightEdit.SetFocus;
  end;
end;

procedure TOptionsForm.GridSourceLatchedCheckBoxClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    if GridSourceLatchedCheckBox.Checked then
      FSourceOnNewOpenText := soGridLocked
    else
    begin
      if FSourceOnNewOpenText = soGridLocked then
      begin
        FSourceOnNewOpenText := soGrid;
      end;
    end;
    LoadSourceOnNewOpenText;
  end;
end;

procedure TOptionsForm.GridSourceRadioButtonClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    case FSourceOnNewOpenText of
      soGrid, soGridLocked: ;
      else FSourceOnNewOpenText := soGrid;
    end;
    LoadSourceOnNewOpenText;
  end;
end;

procedure TOptionsForm.Initialise;

  procedure AddItem(comboBox: TComboBoxEx; caption: string; data: TObject);
  begin
    comboBox.ItemsEx.AddItem(caption, -1, -1, -1, -1, data);
  end;
var
  ColorItemId: TColorItemId;
  Item: TGrpButtonItem;
begin
  FTextFont := TFont.Create;
  FGridFont := TFont.Create;

  AddItem(MetaIndentCharComboBox, '<Space>', TObject(Char(' ')));
  AddItem(MetaIndentCharComboBox, '<Tab>', TObject(#9));

  AddItem(DefaultNonViewableCharacterFormatComboBox, '0x<Hex>', TObject(nv0xHex));
  AddItem(DefaultNonViewableCharacterFormatComboBox, '#<Decimal>', TObject(nvHashDecimal));
  AddItem(DefaultNonViewableCharacterFormatComboBox, '#$<Decimal>', TObject(nvHashDollarHex));
  AddItem(DefaultNonViewableCharacterFormatComboBox, '$<Hex>', TObject(nvDollarHex));

  AddItem(DisplayCultureComboBox, 'Local', TObject(dcLocal));
  AddItem(DisplayCultureComboBox, 'File', TObject(dcFile));
  AddItem(DisplayCultureComboBox, 'Invariant', TObject(dcInvariant));
  AddItem(DisplayCultureComboBox, 'Named', TObject(dcNamed));

  AddItem(DisplayEncodingComboBox, 'UTF8', TObject(deUtf8));
  AddItem(DisplayEncodingComboBox, 'ASCII', TObject(deAscii));
  AddItem(DisplayEncodingComboBox, 'File', TObject(deFile));
  AddItem(DisplayEncodingComboBox, 'Named', TObject(deNamed));

  AddItem(TextFileDefaultCharEncodingComboBox, Encoding.ASCII.WebName, nil);
  AddItem(TextFileDefaultCharEncodingComboBox, Encoding.UTF8.WebName, nil);
  AddItem(TextFileDefaultCharEncodingComboBox, Encoding.UTF32.WebName, nil);
  AddItem(TextFileDefaultCharEncodingComboBox, Encoding.UTF7.WebName, nil);

  AddItem(MetaFileDefaultCharEncodingComboBox, Encoding.ASCII.WebName, nil);
  AddItem(MetaFileDefaultCharEncodingComboBox, Encoding.UTF8.WebName, nil);
  AddItem(MetaFileDefaultCharEncodingComboBox, Encoding.UTF32.WebName, nil);
  AddItem(MetaFileDefaultCharEncodingComboBox, Encoding.UTF7.WebName, nil);

  for ColorItemId := Low(TColorItemId) to High(TColorItemId) do
  begin
    Item := ColoursButtonGroup.Items.Add;
    Item.Caption := TColorItems.Names[ColorItemId];
    Item.Data := ColorItemId;
  end;

  PageControl.ActivePage := ControlsTabSheet;
end;

procedure TOptionsForm.IntegerEditExit(Sender: TObject);
begin
  CheckIntegerEdit(Sender as TEdit);
end;

procedure TOptionsForm.IntegerEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    CheckIntegerEdit(Sender as TEdit);
    Key := #0;
  end;
end;

procedure TOptionsForm.Load;

  function IndexOfData(comboBox: TComboBoxEx; data: TObject): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := 0 to comboBox.ItemsEx.Count - 1 do
    begin
      if comboBox.ItemsEx[I].Data.Equals(data) then
      begin
        Result := I;
        Break;
      end;
    end;
  end;

begin
  ClearErrors;

  Inc(FLoadingControlsCount);
  try
    DefaultNonViewableCharacterFormatComboBox.ItemIndex := IndexOfData(DefaultNonViewableCharacterFormatComboBox,
                                                                       TObject(Configuration.DefaultNonViewableCharFormat));
    DisplayCultureComboBox.ItemIndex := IndexOfData(DisplayCultureComboBox, TObject(Configuration.DisplayCultureType));
    NamedDisplayCultureEdit.Text := Configuration.NamedDisplayCultureName;
    DisplayEncodingComboBox.ItemIndex := IndexOfData(DisplayEncodingComboBox, TObject(Configuration.DisplayCharEncodingType));
    NamedDisplayEncodingEdit.Text := Configuration.NamedDisplayCharEncodingName;

    FTextFont.Assign(Configuration.TextFont);
    TextFontExampleMemo.Font := FTextFont;
    ColorTextCheckBox.Checked := Configuration.ColorText;
    WrapTextCheckBox.Checked := Configuration.WrapText;
    TextTrackMouseCheckBox.Checked := Configuration.TextTrackMouse;
    TextTrackCursorCheckBox.Checked := Configuration.TextTrackCursor;

    FGridFont.Assign(Configuration.GridFont);
    GridFontExampleEdit.Font := FGridFont;
    GridHorizontalLinesVisibleCheckBox.Checked := Configuration.GridHorizontalLinesVisible;
    GridVerticalLinesVisibleCheckBox.Checked := Configuration.GridVerticalLinesVisible;
    GridShowFieldNamesIfNoFixedHeadingRowsCheckBox.Checked := Configuration.GridShowFieldNamesIfNoFixedHeadingRows;
    FixedHeadingRowsCheckBox.Checked := Configuration.GridFixedHeadingRows;
    GridTrackMouseCheckBox.Checked := Configuration.GridTrackMouse;
    GridTrackCursorCheckBox.Checked := Configuration.GridTrackCursor;
    GridRowHeightAutoRadioButton.Checked := Configuration.GridRowHeightAuto;
    GridRowHeightManualRadioButton.Checked := not Configuration.GridRowHeightAuto;
    GridRowHeightEdit.Text := Configuration.GridManualRowHeight.ToString;
    GridNullTextEdit.Text := Configuration.GridNullText;

    FColorItems := Configuration.ColorItems;
    FResolvedColors := FColorItems.Resolve;
    ColoursButtonGroup.ItemIndex := 0;
    LoadColor;

    ResetMetaForNewOpenTextCheckBox.Checked := Configuration.ResetMetaForNewOpenText;
    IgnoreDeclaredMetaCheckBox.Checked := Configuration.IgnoreDeclaredMeta;
    IndentMetaXmlCheckBox.Checked := Configuration.MetaTextFormatting = Formatting.Indented;
    MetaIndentationEdit.Text := Configuration.MetaTextIndentation.ToString;
    MetaIndentCharComboBox.ItemIndex := IndexOfData(MetaIndentCharComboBox, TObject(Configuration.MetaTextIndentChar));
    EmbeddedMetaMarginEdit.Text := Configuration.EmbeddedMetaMargin.ToString;
    SaveDesignOnlyMetaCheckBox.Checked := Configuration.SaveDesignOnlyMeta;
    SaveMetaWithExplicitIndicesCheckBox.Checked := Configuration.SaveMetaWithExplicitIndices;

    FSourceOnNewOpenText := Configuration.SourceOnNewOpenText;
    LoadSourceOnNewOpenText;
    TextFileDefaultCharEncodingComboBox.Text := Configuration.DefaultTextCharEncodingName;
    MetaFileDefaultCharEncodingComboBox.Text := Configuration.DefaultMetaCharEncodingName;
    NumberFromZeroCheckBox.Checked := Configuration.NumberFromZero;

    CalculateGridRowHeight;
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TOptionsForm.LoadColor;
var
  Idx: Integer;
begin
  Idx := ColoursButtonGroup.ItemIndex;
  LoadColor(TColorItemId(ColoursButtonGroup.Items[Idx].Data))
end;

procedure TOptionsForm.LoadColor(id: TColorItemId);
var
  FontStyles: TFontStyles;
  ExampleResolvedColorId: TResolvedColorId;
begin
  Inc(FLoadingControlsCount);
  try
    ColourItemLabel.Caption := TColorItems.Names[id];

    if FColorItems.IgnoreBackgrounds[id] then
    begin
      BackgroundColorBox.Enabled := False;
      BackgroundColorBox.Selected := clNone;
    end
    else
    begin
      BackgroundColorBox.Enabled := True;
      BackgroundColorBox.Selected := FColorItems.Backgrounds[id];
    end;

    if FColorItems.IgnoreFonts[id] then
    begin
      FontColorBox.Enabled := False;
      FontColorBox.Selected := clNone;

      ColourBoldFontStyleCheckBox.Enabled := False;
      ColourBoldFontStyleCheckBox.Checked := False;
      ColourUnderlineFontStyleCheckBox.Enabled := False;
      ColourUnderlineFontStyleCheckBox.Checked := False;
      ColourItalicFontStyleCheckBox.Enabled := False;
      ColourItalicFontStyleCheckBox.Checked := False;
      ColourStrikeOutFontStyleCheckBox.Enabled := False;
      ColourStrikeOutFontStyleCheckBox.Checked := False;

      ColourExampleMemo.Font.Color := clNone;
      ColourExampleMemo.Font.Style := [];
    end
    else
    begin
      FontColorBox.Enabled := True;
      FontColorBox.Selected := FColorItems.Fonts[id];

      FontStyles := FColorItems.FontStyles[id];
      ColourBoldFontStyleCheckBox.Enabled := True;
      ColourBoldFontStyleCheckBox.Checked := fsBold in FontStyles;
      ColourUnderlineFontStyleCheckBox.Enabled := True;
      ColourUnderlineFontStyleCheckBox.Checked := fsUnderline in FontStyles;
      ColourItalicFontStyleCheckBox.Enabled := True;
      ColourItalicFontStyleCheckBox.Checked := fsItalic in FontStyles;
      ColourStrikeOutFontStyleCheckBox.Enabled := True;
      ColourStrikeOutFontStyleCheckBox.Checked := fsStrikeOut in FontStyles;
    end;

    ExampleResolvedColorId := FColorItems.ExampleResolvedColorIds[id];

    BackgroundColorBox.DefaultColorColor := FResolvedColors[ExampleResolvedColorId].Background;
    FontColorBox.DefaultColorColor := FResolvedColors[ExampleResolvedColorId].Font;

    ColourExampleMemo.Color := FResolvedColors[ExampleResolvedColorId].Background;
    ColourExampleMemo.Font.Color := FResolvedColors[ExampleResolvedColorId].Font;
    ColourExampleMemo.Font.Style := FResolvedColors[ExampleResolvedColorId].FontStyles;

    FLoadedColorItemId := id;
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TOptionsForm.LoadSourceOnNewOpenText;
begin
  Inc(FLoadingControlsCount);
  try
    case FSourceOnNewOpenText of
      soCurrent: CurrentSourceRadioButton.Checked := True;
      soReadOnly: AllReadOnlySourceRadioButton.Checked := True;
      soText, soTextLocked: TextSourceRadioButton.Checked := True;
      soGrid, soGridLocked: GridSourceRadioButton.Checked := True;
      else Assert(False);
    end;

    TextSourceLatchedCheckBox.Checked := FSourceOnNewOpenText = soTextLocked;
    GridSourceLatchedCheckBox.Checked := FSourceOnNewOpenText = soGridLocked;
  finally
    Dec(FLoadingControlsCount);
  end;
end;

procedure TOptionsForm.NamedDisplayCultureEditExit(Sender: TObject);
begin
  CheckCultureEdit(Sender as TEdit);
end;

procedure TOptionsForm.NamedDisplayCultureEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    CheckCultureEdit(Sender as TEdit);
    Key := #0;
  end;
end;

procedure TOptionsForm.NamedDisplayEncodingEditExit(Sender: TObject);
begin
  CheckEncodingEdit(Sender as TEdit);
end;

procedure TOptionsForm.NamedDisplayEncodingEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    CheckEncodingEdit(Sender as TEdit);
    Key := #0;
  end;
end;

procedure TOptionsForm.OkActionExecute(Sender: TObject);
begin
  FOk := True;
  ModalResult := mrOk;
end;

procedure TOptionsForm.OkActionUpdate(Sender: TObject);
begin
  OkAction.Enabled := FErrorCount = 0;
end;

procedure TOptionsForm.ColorBoxChange(Sender: TObject);
begin
  if not LoadingControls then
  begin
    SaveColor;
    LoadColor;
  end;
end;

procedure TOptionsForm.ColorFontStyleCheckBoxClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    SaveColor;
    LoadColor;
  end;
end;

procedure TOptionsForm.ColoursButtonGroupButtonClicked(Sender: TObject; Index: Integer);
begin
  SaveColor;
  LoadColor(TColorItemId(ColoursButtonGroup.Items[Index].Data));
end;

procedure TOptionsForm.ColoursButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ItemIndex: Integer;
begin
  ItemIndex := ColoursButtonGroup.ItemIndex;
  if TColorItemId(ColoursButtonGroup.Items[ItemIndex].Data) <> FLoadedColorItemId then
  begin
    LoadColor;
  end;
end;

procedure TOptionsForm.ColoursLoadSchemeButtonClick(Sender: TObject);
var
  Form: TColorSchemaForm;
  Scheme: TColorScheme;
begin
  Form := TColorSchemaForm.Create(Self);
  try
    Form.Mode := lsLoad;
    if Form.ShowModal = mrOk then
    begin
      if Form.SelectedDefault then
      begin
        FColorItems.Reset;
        FResolvedColors := FColorItems.Resolve; // need to get example
        LoadColor;
      end
      else
      begin
        Scheme := TColorScheme.CreateFromFile(Form.SelectedSchemeName);
        if not Assigned(Scheme) then
          MessageDlg('Could not load Color Scheme: "' + Scheme.Name + '"', mtError, [mbOk], 0)
        else
        begin
          FColorItems.LoadFromScheme(Scheme);
          FResolvedColors := FColorItems.Resolve; // need to get example
          LoadColor;
        end;
      end;
    end;
  finally
    Form.Release;
  end;
end;

procedure TOptionsForm.ColoursSaveSchemeButtonClick(Sender: TObject);
var
  Form: TColorSchemaForm;
  Scheme: TColorScheme;
begin
  Form := TColorSchemaForm.Create(Self);
  try
    Form.Mode := lsSave;
    if Form.ShowModal = mrOk then
    begin
      if not Form.SelectedDefault then
      begin
        Scheme := TColorScheme.Create(Form.SelectedSchemeName, FColorItems.Values);
        Scheme.SaveToFile;
      end;
    end;
  finally
    Form.Release;
  end;
end;

procedure TOptionsForm.CurrentSourceRadioButtonClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    FSourceOnNewOpenText := soCurrent;
    LoadSourceOnNewOpenText;
  end;
end;

procedure TOptionsForm.Save;

  function GetSelectedData(comboBox: TComboBoxEx): TObject;
  var
    ItemIndex: Integer;
  begin
    ItemIndex := comboBox.ItemIndex;
    if ItemIndex < 0 then
      Result := nil
    else
      Result := comboBox.ItemsEx[ItemIndex].Data;
  end;

var
  DummyAutoGridRowHeight: Boolean;
  ManualGridRowHeight, DummyActualGridRowHeight: Integer;
begin
  Configuration.DefaultNonViewableCharFormat := GetSelectedData(DefaultNonViewableCharacterFormatComboBox) as TNonViewableCharFormat;
  Configuration.DisplayCultureType := GetSelectedData(DisplayCultureComboBox) as TDisplayCultureType;
  Configuration.NamedDisplayCultureName := NamedDisplayCultureEdit.Text;
  Configuration.DisplayCharEncodingType := GetSelectedData(DisplayEncodingComboBox) as TDisplayCharEncodingType;
  Configuration.NamedDisplayCharEncodingName := NamedDisplayEncodingEdit.Text;

  Configuration.TextFont := FTextFont;
  Configuration.ColorText := ColorTextCheckBox.Checked;
  Configuration.WrapText := WrapTextCheckBox.Checked;
  Configuration.TextTrackMouse := TextTrackMouseCheckBox.Checked;
  Configuration.TextTrackCursor := TextTrackCursorCheckBox.Checked;

  Configuration.GridFont := FGridFont;
  Configuration.GridHorizontalLinesVisible := GridHorizontalLinesVisibleCheckBox.Checked;
  Configuration.GridVerticalLinesVisible := GridVerticalLinesVisibleCheckBox.Checked;
  Configuration.GridShowFieldNamesIfNoFixedHeadingRows := GridShowFieldNamesIfNoFixedHeadingRowsCheckBox.Checked;
  Configuration.GridFixedHeadingRows := FixedHeadingRowsCheckBox.Checked;
  Configuration.GridTrackMouse := GridTrackMouseCheckBox.Checked;
  Configuration.GridTrackCursor := GridTrackCursorCheckBox.Checked;
  Configuration.GridRowHeightAuto := GridRowHeightAutoRadioButton.Checked;
  if CalculateGridRowHeight(DummyAutoGridRowHeight, ManualGridRowHeight, DummyActualGridRowHeight) then
  begin
    Configuration.GridManualRowHeight := ManualGridRowHeight;
  end;
  Configuration.GridNullText := GridNullTextEdit.Text;

  GridRowHeightEdit.Text := Configuration.GridManualRowHeight.ToString;

  SaveColor;
  Configuration.SetColorItems(FColorItems);

  Configuration.ResetMetaForNewOpenText := ResetMetaForNewOpenTextCheckBox.Checked;
  Configuration.IgnoreDeclaredMeta := IgnoreDeclaredMetaCheckBox.Checked;
  if IndentMetaXmlCheckBox.Checked then
    Configuration.MetaTextFormatting := Formatting.Indented
  else
    Configuration.MetaTextFormatting := Formatting.None;
  Configuration.MetaTextIndentation := System.Int32.Parse(MetaIndentationEdit.Text);
  Configuration.MetaTextIndentChar := GetSelectedData(MetaIndentCharComboBox) as Char;
  Configuration.EmbeddedMetaMargin := System.Int32.Parse(EmbeddedMetaMarginEdit.Text);
  Configuration.SaveDesignOnlyMeta := SaveDesignOnlyMetaCheckBox.Checked;
  Configuration.SaveMetaWithExplicitIndices := SaveMetaWithExplicitIndicesCheckBox.Checked;

  Configuration.SourceOnNewOpenText := FSourceOnNewOpenText;
  Configuration.DefaultTextCharEncodingName := TextFileDefaultCharEncodingComboBox.Text;
  Configuration.DefaultMetaCharEncodingName := MetaFileDefaultCharEncodingComboBox.Text;
  Configuration.NumberFromZero := NumberFromZeroCheckBox.Checked;

  Configuration.TriggerUpdatedEvent;
end;

procedure TOptionsForm.SaveColor;
var
  Id: TColorItemId;
  FontStyles: TFontStyles;
begin
  Id := FLoadedColorItemId;

  if not FColorItems.IgnoreBackgrounds[Id] then
  begin
    FColorItems.Backgrounds[Id] := BackgroundColorBox.Selected;
  end;

  if not FColorItems.IgnoreFonts[id] then
  begin
    FColorItems.Fonts[Id] := FontColorBox.Selected;

    FontStyles := [];
    if ColourBoldFontStyleCheckBox.Checked then
    begin
      Include(FontStyles, fsBold)
    end;
    if ColourUnderlineFontStyleCheckBox.Checked then
    begin
      Include(FontStyles, fsUnderline);
    end;
    if ColourItalicFontStyleCheckBox.Checked then
    begin
      Include(FontStyles, fsItalic);
    end;
    if ColourStrikeOutFontStyleCheckBox.Checked then
    begin
      Include(FontStyles, fsStrikeOut);
    end;

    FColorItems.FontStyles[Id] := FontStyles;
  end;

  FResolvedColors := FColorItems.Resolve;
end;

procedure TOptionsForm.SelectFont(var targetFont: TFont; exampleControl: TCustomEdit);
begin
  FontDialog.Font := targetFont;
  if FontDialog.Execute then
  begin
    targetFont.Assign(FontDialog.Font);
    exampleControl.Font := targetFont;
  end;
end;

procedure TOptionsForm.SetControlError(control: TWinControl);
begin
  if control.Color <> Configuration.Colors[rcControlError].Background then
  begin
    control.Color := Configuration.Colors[rcControlError].Background;
    Inc(FErrorCount);
  end;
end;

procedure TOptionsForm.TextFontResetButtonClick(Sender: TObject);
begin
  FTextFont.Assign(Configuration.CreateDefaultTextFont);
  TextFontExampleMemo.Font := FTextFont;
end;

procedure TOptionsForm.TextFontSelectButtonClick(Sender: TObject);
begin
  SelectFont(FTextFont, TextFontExampleMemo);
end;

procedure TOptionsForm.TextSourceLatchedCheckBoxClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    if TextSourceLatchedCheckBox.Checked then
      FSourceOnNewOpenText := soTextLocked
    else
    begin
      if FSourceOnNewOpenText = soTextLocked then
      begin
        FSourceOnNewOpenText := soText;
      end;
    end;
    LoadSourceOnNewOpenText;
  end;
end;

procedure TOptionsForm.TextSourceRadioButtonClick(Sender: TObject);
begin
  if not LoadingControls then
  begin
    case FSourceOnNewOpenText of
      soText, soTextLocked: ;
      else FSourceOnNewOpenText := soText;
    end;
    LoadSourceOnNewOpenText;
  end;
end;

function TOptionsForm.TryStrToInteger(str: string; out value: Integer): Boolean;
begin
  try
    value := System.Int32.Parse(str);
    Result := True;
  except
    on FormatException do Result := False;
    on OverflowException do Result := False;
  end;
end;

end.
