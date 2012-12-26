// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.ColorSchemaForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  ActnList, ButtonGroup, StdCtrls, ExtCtrls;

type
  TLoadSaveMode = (lsLoad, lsSave);
  TColorSchemaForm = class(TForm)
    BottomPanel: TPanel;
    LoadSaveButton: TButton;
    SelectedPanel: TPanel;
    LoadSaveAsLabel: TLabel;
    SelectedEdit: TEdit;
    DeleteButton: TButton;
    CancelButton: TButton;
    SchemaButtonGroup: TButtonGroup;
    ActionList: TActionList;
    LoadAction: TAction;
    SaveAction: TAction;
    DeleteAction: TAction;
    procedure LoadSaveActionExecute(Sender: TObject);
    procedure LoadActionUpdate(Sender: TObject);
    procedure SchemaButtonGroupButtonClicked(Sender: TObject; Index: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveDeleteActionUpdate(Sender: TObject);
    procedure DeleteActionExecute(Sender: TObject);
    procedure SchemaButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    type
      TStringObject = class
      public
        Value: string;
      end;
    var
      FMode: TLoadSaveMode;
      FOk: Boolean;

    procedure LoadSchemeNames;
    procedure ClearSchemaButtonGroupItems;

    procedure SetMode(const Value: TLoadSaveMode);
    function GetSelectedSchemeName: string;
  public
    function GetSelectedDefault: Boolean;
    { Public declarations }
    property Mode: TLoadSaveMode read FMode write SetMode;
    property SelectedSchemeName: string read GetSelectedSchemeName;
    property SelectedDefault: Boolean read GetSelectedDefault;
  end;

var
  ColorSchemaForm: TColorSchemaForm;

implementation

{$R *.dfm}

uses
  Types,
  IOUtils,
  Xilytix.FTEditor.Common,
  Xilytix.FTEditor.Colors;

{ TColorSchemaForm }

procedure TColorSchemaForm.ClearSchemaButtonGroupItems;
var
  I: Integer;
begin
  for I := 0 to SchemaButtonGroup.Items.Count-1 do
  begin
    TStringObject(SchemaButtonGroup.Items[I].Data).Free;
  end;
  SchemaButtonGroup.Items.Clear;
end;

procedure TColorSchemaForm.DeleteActionExecute(Sender: TObject);
var
  FilePath: string;
begin
  FilePath := TColorScheme.NameToFilePath(SelectedEdit.Text);
  if TFile.Exists(FilePath) then
  begin
    TFile.Delete(FilePath);
    LoadSchemeNames;
  end;
  SelectedEdit.Text := '';
end;

procedure TColorSchemaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FOk then
    ModalResult := mrOk
  else
    ModalResult := mrCancel;
end;

procedure TColorSchemaForm.FormCreate(Sender: TObject);
begin
  SelectedEdit.Text := '';
end;

procedure TColorSchemaForm.FormDestroy(Sender: TObject);
begin
  ClearSchemaButtonGroupItems;
end;

function TColorSchemaForm.GetSelectedDefault: Boolean;
begin
  Result := TColorScheme.IsDefaultName(SelectedSchemeName);
end;

function TColorSchemaForm.GetSelectedSchemeName: string;
begin
  Result := SelectedEdit.Text;
end;

procedure TColorSchemaForm.LoadSaveActionExecute(Sender: TObject);
begin
  FOk := True;
  ModalResult := mrOk;
end;

procedure TColorSchemaForm.LoadSchemeNames;
var
  ColorSchemaFolder: string;
  SchemeNames: TStringDynArray;
  I: Integer;
  Item: TGrpButtonItem;
  StringObject: TStringObject;
begin
  ClearSchemaButtonGroupItems;

  if FMode = lsLoad then
  begin
    Item := SchemaButtonGroup.Items.Add;
    Item.Caption := TColorScheme.DefaultSchemeName;
    Item.Data := nil;
  end;

  ColorSchemaFolder := TCommon.ColorSchemaFolder;
  if TDirectory.Exists(ColorSchemaFolder) then
  begin
    SchemeNames := TColorScheme.GetSchemeNames(TCommon.ColorSchemaFolder);

    SchemaButtonGroup.Items.Capacity := SchemaButtonGroup.Items.Count + Length(SchemeNames);
    for I := Low(SchemeNames) to High(SchemeNames) do
    begin
      Item := SchemaButtonGroup.Items.Add;
      Item.Caption := SchemeNames[I];
      StringObject := TStringObject.Create;
      StringObject.Value := TPath.Combine(ColorSchemaFolder, SchemeNames[I]);
      Item.Data := Pointer(StringObject);
    end;
  end;
end;

procedure TColorSchemaForm.LoadActionUpdate(Sender: TObject);
var
  SelectedName: string;
  FilePath: string;
  LoadEnabled: Boolean;
begin
  SelectedName := SelectedEdit.Text;
  if (SelectedName = '') then
    LoadEnabled := False
  else
  begin
    if SelectedDefault then
      LoadEnabled := True
    else
    begin
      FilePath := TColorScheme.NameToFilePath(SelectedName);
      LoadEnabled := TFile.Exists(FilePath);
    end;
  end;
                        ;
  LoadAction.Enabled := LoadEnabled;
end;

procedure TColorSchemaForm.SaveDeleteActionUpdate(Sender: TObject);
var
  SelectedName: string;
begin
  SelectedName := SelectedEdit.Text;
  TAction(Sender).Enabled := (SelectedName <> '') and (SelectedName <> TColorScheme.DefaultSchemeName)
end;

procedure TColorSchemaForm.SchemaButtonGroupButtonClicked(Sender: TObject; Index: Integer);
begin
  SelectedEdit.Text := SchemaButtonGroup.Items[Index].Caption;
end;

procedure TColorSchemaForm.SchemaButtonGroupKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ItemIndex: Integer;
begin
  ItemIndex := SchemaButtonGroup.ItemIndex;
  SelectedEdit.Text := SchemaButtonGroup.Items[ItemIndex].Caption;
end;

procedure TColorSchemaForm.SetMode(const Value: TLoadSaveMode);
begin
  FMode := Value;
  case FMode of
    lsLoad:
    begin
      Caption := 'Load Color Schema';
      LoadSaveAsLabel.Caption := 'Lo&ad';
      LoadSaveButton.Action := LoadAction;
    end;
    lsSave:
    begin
      Caption := 'Save Color Schema';
      LoadSaveAsLabel.Caption := 'Save &As';
      LoadSaveButton.Action := SaveAction;
    end;
    else Assert(False);
  end;
  LoadSchemeNames;
end;

end.
