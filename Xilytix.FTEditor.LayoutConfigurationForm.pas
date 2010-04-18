// Project: FTEditor (Fielded Text Editor)
// Licence (this file): Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.LayoutConfigurationForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Borland.Vcl.StdCtrls, System.ComponentModel, Borland.Vcl.ExtCtrls, Borland.Vcl.ComCtrls,
  Xilytix.FTEditor.LayoutConfiguration,
  Xilytix.FTEditor.LayoutableFrame,
  Xilytix.FTEditor.MainPropertiesFrame,
  Xilytix.FTEditor.FieldsFrame,
  Xilytix.FTEditor.SequencesFrame,
  Xilytix.FTEditor.TextViewFrame,
  Xilytix.FTEditor.GridViewFrame,
  Xilytix.FTEditor.ErrorsFrame;

type
  TNotifyConfigurationChange = procedure of object;
  TCheckDuplicateConfigurationNameExistsEvent = function(aName: string): Boolean of object;
  TRequestNewEvent = function: TLayoutConfiguration of object;
  TRequestDeleteEvent = procedure(configurationToDelete: TLayoutConfiguration) of object;

  TLayoutConfigurationForm = class(TForm)
    HalvesTabbedCheckBox: TCheckBox;
    MetaDataGroupBox: TGroupBox;
    GroupBox2: TGroupBox;
    HalfATabbedCheckBox: TCheckBox;
    Label3: TLabel;
    HalvesLeftTopHalfComboBox: TComboBoxEx;
    HalvesRightBottomHalfComboBox: TComboBoxEx;
    Label4: TLabel;
    HalfAHorizontalRadioButton: TRadioButton;
    HalfAVerticalRadioButton: TRadioButton;
    Label7: TLabel;
    HalfALeftComboBox: TComboBoxEx;
    HalfAMiddleComboBox: TComboBoxEx;
    Label8: TLabel;
    HalfA2Left1RightRadioButton: TRadioButton;
    NameEdit: TEdit;
    Label23: TLabel;
    NewButton: TButton;
    OkButton: TButton;
    DeleteButton: TButton;
    CancelButton: TButton;
    HalfALeftFillCheckBox: TCheckBox;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    HalfARightComboBox: TComboBoxEx;
    HalfARightFillCheckBox: TCheckBox;
    HalfAMiddleFillCheckBox: TCheckBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    HalfBTabbedCheckBox: TCheckBox;
    HalfBHorizontalRadioButton: TRadioButton;
    HalfBVerticalRadioButton: TRadioButton;
    HalfBLeftComboBox: TComboBoxEx;
    HalfBMiddleComboBox: TComboBoxEx;
    HalfB2Left1RightRadioButton: TRadioButton;
    HalfBLeftFillCheckBox: TCheckBox;
    HalfBRightComboBox: TComboBoxEx;
    HalfBRightFillCheckBox: TCheckBox;
    HalfBMiddleFillCheckBox: TCheckBox;
    HalfA2Top1BottomRadioButton: TRadioButton;
    HalfB2Top1BottomRadioButton: TRadioButton;
    GroupBox1: TGroupBox;
    HalvesHorizontalRadioButton: TRadioButton;
    HalvesVerticalRadioButton: TRadioButton;
    HalvesLeftTopFillRadioButton: TRadioButton;
    HalvesRightBottomFillRadioButton: TRadioButton;
    ApplyButton: TButton;
    DuplicateOrBlankNameLabel: TLabel;
    ResetSizesCheckBox: TCheckBox;
    procedure ApplyButtonClick(Sender: TObject);
    procedure HalvesHorizontalRadioButtonClick(Sender: TObject);
    procedure HalvesVerticalRadioButtonClick(Sender: TObject);
    procedure HalvesTabbedCheckBoxClick(Sender: TObject);
    procedure NameEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure HalvesLeftTopHalfComboBoxChange(Sender: TObject);
    procedure HalvesRightBottomHalfComboBoxChange(Sender: TObject);
    procedure HalvesLeftTopFillRadioButtonClick(Sender: TObject);
    procedure HalfAHorizontalRadioButtonClick(Sender: TObject);
    procedure HalfAVerticalRadioButtonClick(Sender: TObject);
    procedure HalfA2Left1RightRadioButtonClick(Sender: TObject);
    procedure HalfA2Top1BottomRadioButtonClick(Sender: TObject);
    procedure HalfBHorizontalRadioButtonClick(Sender: TObject);
    procedure HalfBVerticalRadioButtonClick(Sender: TObject);
    procedure HalfB2Left1RightRadioButtonClick(Sender: TObject);
    procedure HalfB2Top1BottomRadioButtonClick(Sender: TObject);
    procedure HalfATabbedCheckBoxClick(Sender: TObject);
    procedure HalfBTabbedCheckBoxClick(Sender: TObject);
    procedure HalfALeftFillCheckBoxClick(Sender: TObject);
    procedure HalfAMiddleFillCheckBoxClick(Sender: TObject);
    procedure HalfARightFillCheckBoxClick(Sender: TObject);
    procedure HalfBLeftFillCheckBoxClick(Sender: TObject);
    procedure HalfBMiddleFillCheckBoxClick(Sender: TObject);
    procedure HalfBRightFillCheckBoxClick(Sender: TObject);
    procedure HalfALeftComboBoxChange(Sender: TObject);
    procedure HalfAMiddleComboBoxChange(Sender: TObject);
    procedure HalfARightComboBoxChange(Sender: TObject);
    procedure HalfBLeftComboBoxChange(Sender: TObject);
    procedure HalfBMiddleComboBoxChange(Sender: TObject);
    procedure HalfBRightComboBoxChange(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NewButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    type
      THalfId = TLayoutConfiguration.THalfId;
      TFrameTypeId = TLayoutableFrame.TTypeId;

      THalfSelection = record
        Caption: string;
        HalfId: THalfId;
      end;
      THalfSelections = array[THalfId] of THalfSelection;

      TFrameSelections = array[TFrameTypeId] of TLayoutableFrameClass;

    const
      la2Horizontal = TLayoutConfiguration.TArrangement.la2Horizontal;
      la2Vertical = TLayoutConfiguration.TArrangement.la2Vertical;
      la2Left1Right = TLayoutConfiguration.TArrangement.la2Left1Right;
      la2Top1Bottom = TLayoutConfiguration.TArrangement.la2Top1Bottom;
      la3Horizontal = TLayoutConfiguration.TArrangement.la3Horizontal;
      la3Vertical = TLayoutConfiguration.TArrangement.la3Vertical;

      lhNone = TLayoutConfiguration.THalfId.lhNone;

      ftNone = TLayoutableFrame.TTypeId.ftNone;

      HalfSelections: THalfSelections =
      (
        (Caption: '<None>'; HalfId: lhNone),
        (Caption: 'Half A'; HalfId: lhA),
        (Caption: 'Half B'; HalfId: lhB)
      );

      FrameSelections: TFrameSelections = (nil,
                                           TMainPropertiesFrame,
                                           TFieldsFrame,
                                           TSequencesFrame,
                                           TTextViewFrame,
                                           TGridViewFrame,
                                           TErrorsFrame);

    var
      FConfiguration: TLayoutConfiguration;
      FConfigurationOrigName: string;
      FExplicitSizesReset: Boolean;

      FLoadingControls: Boolean;
      FOk: Boolean;

      FConfigurationChangeEvent: TNotifyConfigurationChange;
      FCheckDuplicateConfigurationNameExistsEvent: TCheckDuplicateConfigurationNameExistsEvent;
      FRequestNewEvent: TRequestNewEvent;
      FRequestDeleteEvent: TRequestDeleteEvent;

    function GetApplyEnabled: Boolean;
    procedure SetApplyEnabled(const Value: Boolean);
    { Private declarations }
    procedure InitialiseHalfSelectComboBoxes;
    procedure InitialiseFrameSelectComboBoxes;

    function ComboBoxIndexOfHalfId(comboBox: TComboBoxEx; value: THalfId): Integer;
    function ComboBoxIndexOfFrameTypeId(comboBox: TComboBoxEx; value: TFrameTypeId): Integer;

    procedure LoadControls;

    property ApplyEnabled: Boolean read GetApplyEnabled write SetApplyEnabled;
  public
    procedure SetConfiguration(const Value: TLayoutConfiguration);
    { Public declarations }
    property Configuration: TLayoutConfiguration read FConfiguration write SetConfiguration;

    property ExplicitSizesReset: Boolean read FExplicitSizesReset;

    property ConfigurationChangeEvent: TNotifyConfigurationChange read FConfigurationChangeEvent write FConfigurationChangeEvent;
    property CheckDuplicateConfigurationNameExistsEvent: TCheckDuplicateConfigurationNameExistsEvent
                                                         read FCheckDuplicateConfigurationNameExistsEvent
                                                         write FCheckDuplicateConfigurationNameExistsEvent;
    property RequestNewEvent: TRequestNewEvent read FRequestNewEvent write FRequestNewEvent;
    property RequestDeleteEvent: TRequestDeleteEvent read FRequestDeleteEvent write FRequestDeleteEvent;
  end;

var
  LayoutConfigurationForm: TLayoutConfigurationForm;

implementation

{$R *.dfm}

procedure TLayoutConfigurationForm.ApplyButtonClick(Sender: TObject);
begin
  FConfigurationChangeEvent;
end;

procedure TLayoutConfigurationForm.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TLayoutConfigurationForm.ComboBoxIndexOfFrameTypeId(comboBox: TComboBoxEx; value: TFrameTypeId): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to comboBox.ItemsEx.Count - 1 do
  begin
    if TFrameTypeId(comboBox.ItemsEx[I].Data) = value then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TLayoutConfigurationForm.ComboBoxIndexOfHalfId(comboBox: TComboBoxEx; value: THalfId): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to comboBox.ItemsEx.Count - 1 do
  begin
    if THalfId(comboBox.ItemsEx[I].Data) = value then
    begin
      Result := I;
      Break;
    end;
  end;
end;

procedure TLayoutConfigurationForm.DeleteButtonClick(Sender: TObject);
begin
  FRequestDeleteEvent(FConfiguration);
  FConfiguration := nil;
  ModalResult := mrOk;
end;

procedure TLayoutConfigurationForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FOk then
    ModalResult := mrCancel
  else
  begin
    ModalResult := mrOk;
    if ResetSizesCheckBox.Checked then
    begin
      FConfiguration.ResetExplicitSizes;
      FExplicitSizesReset := True;
    end;
  end;
end;

procedure TLayoutConfigurationForm.FormCreate(Sender: TObject);
begin
  InitialiseHalfSelectComboBoxes;
  InitialiseFrameSelectComboBoxes;
end;

procedure TLayoutConfigurationForm.FormShow(Sender: TObject);
begin
  ResetSizesCheckBox.Checked := False;
end;

function TLayoutConfigurationForm.GetApplyEnabled: Boolean;
begin
  Result := ApplyButton.Enabled;
end;

procedure TLayoutConfigurationForm.HalfA2Left1RightRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfA.Arrangement := la2Left1Right;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfA2Top1BottomRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfA.Arrangement := la2Top1Bottom;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfAHorizontalRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfA.Arrangement := la3Horizontal;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfALeftComboBoxChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := HalfALeftComboBox.ItemIndex;
  Configuration.HalfA.LeftFrameTypeId := HalfALeftComboBox.ItemsEx[ItemIndex].Data as TFrameTypeId;

  LoadControls;
end;

procedure TLayoutConfigurationForm.HalfALeftFillCheckBoxClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfA.LeftFrameFill := HalfALeftFillCheckBox.Checked;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfAMiddleComboBoxChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := HalfAMiddleComboBox.ItemIndex;
  Configuration.HalfA.MiddleFrameTypeId := HalfAMiddleComboBox.ItemsEx[ItemIndex].Data as TFrameTypeId;

  LoadControls;
end;

procedure TLayoutConfigurationForm.HalfAMiddleFillCheckBoxClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfA.MiddleFrameFill := HalfAMiddleFillCheckBox.Checked;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfARightComboBoxChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := HalfARightComboBox.ItemIndex;
  Configuration.HalfA.RightFrameTypeId := HalfARightComboBox.ItemsEx[ItemIndex].Data as TFrameTypeId;

  LoadControls;
end;

procedure TLayoutConfigurationForm.HalfARightFillCheckBoxClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfA.RightFrameFill := HalfARightFillCheckBox.Checked;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfATabbedCheckBoxClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfA.Tabbed := HalfATabbedCheckBox.Checked;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfAVerticalRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfA.Arrangement := la3Vertical;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfBHorizontalRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfB.Arrangement := la3Horizontal;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfBLeftComboBoxChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := HalfBLeftComboBox.ItemIndex;
  Configuration.HalfB.LeftFrameTypeId := HalfBLeftComboBox.ItemsEx[ItemIndex].Data as TFrameTypeId;

  LoadControls;
end;

procedure TLayoutConfigurationForm.HalfBLeftFillCheckBoxClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfB.LeftFrameFill := HalfBLeftFillCheckBox.Checked;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfBMiddleComboBoxChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := HalfBMiddleComboBox.ItemIndex;
  Configuration.HalfB.MiddleFrameTypeId := HalfBMiddleComboBox.ItemsEx[ItemIndex].Data as TFrameTypeId;

  LoadControls;
end;

procedure TLayoutConfigurationForm.HalfBMiddleFillCheckBoxClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfB.MiddleFrameFill := HalfBMiddleFillCheckBox.Checked;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfBRightComboBoxChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := HalfBRightComboBox.ItemIndex;
  Configuration.HalfB.RightFrameTypeId := HalfBRightComboBox.ItemsEx[ItemIndex].Data as TFrameTypeId;

  LoadControls;
end;

procedure TLayoutConfigurationForm.HalfBRightFillCheckBoxClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfB.RightFrameFill := HalfBRightFillCheckBox.Checked;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfBTabbedCheckBoxClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfB.Tabbed := HalfBTabbedCheckBox.Checked;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfBVerticalRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfB.Arrangement := la3Vertical;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalvesHorizontalRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.Arrangement := la2Horizontal;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalvesLeftTopFillRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    Configuration.LeftHalfFill := True;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalvesLeftTopHalfComboBoxChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := HalvesLeftTopHalfComboBox.ItemIndex;
  Configuration.LeftHalfId := HalvesLeftTopHalfComboBox.ItemsEx[ItemIndex].Data as THalfId;

  LoadControls;
end;

procedure TLayoutConfigurationForm.HalvesRightBottomHalfComboBoxChange(Sender: TObject);
var
  ItemIndex: Integer;
begin
  ItemIndex := HalvesRightBottomHalfComboBox.ItemIndex;
  Configuration.RightHalfId := HalvesRightBottomHalfComboBox.ItemsEx[ItemIndex].Data as THalfId;

  LoadControls;
end;

procedure TLayoutConfigurationForm.HalvesTabbedCheckBoxClick(Sender: TObject);
begin
  FConfiguration.Tabbed := HalvesTabbedCheckBox.Checked;
  LoadControls;
end;

procedure TLayoutConfigurationForm.HalvesVerticalRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.Arrangement := la2Vertical;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.InitialiseFrameSelectComboBoxes;
var
  I: TFrameTypeId;
  TypeCaption: string;
  TypeId: TFrameTypeId;
begin
  for I := Low(FrameSelections) to High(FrameSelections) do
  begin
    if not Assigned(FrameSelections[I]) then
    begin
      TypeCaption := '<None>';
      TypeId := ftNone;
    end
    else
    begin
      TypeCaption := FrameSelections[I].GetTypeCaption;
      TypeId := FrameSelections[I].GetTypeId;
    end;

    HalfALeftComboBox.ItemsEx.AddItem(TypeCaption, -1, -1, -1, 0, TypeId);
    HalfAMiddleComboBox.ItemsEx.AddItem(TypeCaption, -1, -1, -1, 0, TypeId);
    HalfARightComboBox.ItemsEx.AddItem(TypeCaption, -1, -1, -1, 0, TypeId);
    HalfBLeftComboBox.ItemsEx.AddItem(TypeCaption, -1, -1, -1, 0, TypeId);
    HalfBMiddleComboBox.ItemsEx.AddItem(TypeCaption, -1, -1, -1, 0, TypeId);
    HalfBRightComboBox.ItemsEx.AddItem(TypeCaption, -1, -1, -1, 0, TypeId);
  end;
end;

procedure TLayoutConfigurationForm.InitialiseHalfSelectComboBoxes;
var
  I: THalfId;
begin
  for I := Low(HalfSelections) to High(HalfSelections) do
  begin
    HalvesLeftTopHalfComboBox.ItemsEx.AddItem(HalfSelections[I].Caption,
                                              -1, -1, -1, 0,
                                              HalfSelections[I].HalfId);
    HalvesRightBottomHalfComboBox.ItemsEx.AddItem(HalfSelections[I].Caption,
                                                  -1, -1, -1, 0,
                                                  HalfSelections[I].HalfId);
  end;
end;

procedure TLayoutConfigurationForm.LoadControls;
begin
  FLoadingControls := True;
  try
    NameEdit.Text := FConfiguration.Name;

    case FConfiguration.Arrangement of
      la2Vertical, la3Vertical, la2Top1Bottom: HalvesVerticalRadioButton.Checked := True;
      la2Horizontal, la3Horizontal, la2Left1Right: HalvesHorizontalRadioButton.Checked := True;
      else HalvesHorizontalRadioButton.Checked := True;
    end;
    HalvesTabbedCheckBox.Checked := FConfiguration.Tabbed;
    HalvesLeftTopHalfComboBox.ItemIndex := ComboBoxIndexOfHalfId(HalvesLeftTopHalfComboBox, FConfiguration.LeftHalfId);
    HalvesLeftTopFillRadioButton.Checked := FConfiguration.LeftHalfFill;
    HalvesRightBottomHalfComboBox.ItemIndex := ComboBoxIndexOfHalfId(HalvesRightBottomHalfComboBox, FConfiguration.RightHalfId);
    HalvesRightBottomFillRadioButton.Checked := not FConfiguration.LeftHalfFill;

    case FConfiguration.HalfA.Arrangement of
      la2Left1Right: HalfA2Left1RightRadioButton.Checked := True;
      la2Top1Bottom: HalfA2Top1BottomRadioButton.Checked := True;
      la3Vertical, la2Vertical: HalfAVerticalRadioButton.Checked := True;
      la3Horizontal, la2Horizontal: HalfAHorizontalRadioButton.Checked := True;
      else HalfAVerticalRadioButton.Checked := True;
    end;
    HalfATabbedCheckBox.Checked := FConfiguration.HalfA.Tabbed;
    HalfALeftComboBox.ItemIndex := ComboBoxIndexOfFrameTypeId(HalfALeftComboBox, FConfiguration.HalfA.LeftFrameTypeId);
    HalfALeftFillCheckBox.Checked := FConfiguration.HalfA.LeftFrameFill;
    HalfAMiddleComboBox.ItemIndex := ComboBoxIndexOfFrameTypeId(HalfAMiddleComboBox, FConfiguration.HalfA.MiddleFrameTypeId);
    HalfAMiddleFillCheckBox.Checked := FConfiguration.HalfA.MiddleFrameFill;
    HalfARightComboBox.ItemIndex := ComboBoxIndexOfFrameTypeId(HalfARightComboBox, FConfiguration.HalfA.RightFrameTypeId);
    HalfARightFillCheckBox.Checked := FConfiguration.HalfA.RightFrameFill;

    case FConfiguration.HalfB.Arrangement of
      la2Left1Right: HalfB2Left1RightRadioButton.Checked := True;
      la2Top1Bottom: HalfB2Top1BottomRadioButton.Checked := True;
      la3Vertical, la2Vertical: HalfBVerticalRadioButton.Checked := True;
      la3Horizontal, la2Horizontal: HalfBHorizontalRadioButton.Checked := True;
      else HalfBVerticalRadioButton.Checked := True;
    end;
    HalfBTabbedCheckBox.Checked := FConfiguration.HalfB.Tabbed;
    HalfBLeftComboBox.ItemIndex := ComboBoxIndexOfFrameTypeId(HalfBLeftComboBox, FConfiguration.HalfB.LeftFrameTypeId);
    HalfBLeftFillCheckBox.Checked := FConfiguration.HalfB.LeftFrameFill;
    HalfBMiddleComboBox.ItemIndex := ComboBoxIndexOfFrameTypeId(HalfBMiddleComboBox, FConfiguration.HalfB.MiddleFrameTypeId);
    HalfBMiddleFillCheckBox.Checked := FConfiguration.HalfB.MiddleFrameFill;
    HalfBRightComboBox.ItemIndex := ComboBoxIndexOfFrameTypeId(HalfBRightComboBox, FConfiguration.HalfB.RightFrameTypeId);
    HalfBRightFillCheckBox.Checked := FConfiguration.HalfB.RightFrameFill;
  finally
    FLoadingControls := False;
  end;
end;

procedure TLayoutConfigurationForm.NameEditChange(Sender: TObject);
begin
  Configuration.Name := NameEdit.Text;
  if Configuration.Name = '' then
    ApplyEnabled := False
  else
  begin
    if Configuration.Name = FConfigurationOrigName then
      ApplyEnabled := True
    else
    begin
      if CheckDuplicateConfigurationNameExistsEvent(NameEdit.Text) then
        ApplyEnabled := False
      else
        ApplyEnabled := True;
    end;
  end;

  DuplicateOrBlankNameLabel.Visible := not ApplyEnabled;
end;

procedure TLayoutConfigurationForm.NewButtonClick(Sender: TObject);
begin
  FConfiguration := FRequestNewEvent;
  LoadControls;
end;

procedure TLayoutConfigurationForm.OkButtonClick(Sender: TObject);
begin
  FOk := True;
  ModalResult := mrOk;
end;

procedure TLayoutConfigurationForm.HalfB2Left1RightRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfB.Arrangement := la2Left1Right;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.HalfB2Top1BottomRadioButtonClick(Sender: TObject);
begin
  if not FLoadingControls then
  begin
    FConfiguration.HalfB.Arrangement := la2Top1Bottom;
    LoadControls;
  end;
end;

procedure TLayoutConfigurationForm.SetApplyEnabled(const Value: Boolean);
begin
  ApplyButton.Enabled := Value;
  OkButton.Enabled := Value;
end;

procedure TLayoutConfigurationForm.SetConfiguration(const Value: TLayoutConfiguration);
begin
  FConfiguration := Value;
  FConfigurationOrigName := FConfiguration.Name;

  LoadControls;
end;

end.
