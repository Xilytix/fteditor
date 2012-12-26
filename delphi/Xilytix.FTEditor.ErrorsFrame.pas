// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.ErrorsFrame;

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
  ExtCtrls,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.LayoutableFrame,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.EditorFrame;

type
  TErrorsFrame = class(TEditorFrame)
    ErrorsMemo: TMemo;
    TopFlowPanel: TFlowPanel;
    LinePanel: TPanel;
    Label1: TLabel;
    LineEdit: TEdit;
    LinePosPanel: TPanel;
    Label2: TLabel;
    LinePosEdit: TEdit;
    FilePosPanel: TPanel;
    Label3: TLabel;
    FilePosEdit: TEdit;
    RecordPanel: TPanel;
    Label4: TLabel;
    RecordEdit: TEdit;
    TablePanel: TPanel;
    Label5: TLabel;
    TableEdit: TEdit;
    ActiveIndexPanel: TPanel;
    Label6: TLabel;
    ActiveIndexEdit: TEdit;
    ItemIndexPanel: TPanel;
    Label7: TLabel;
    ItemIndexEdit: TEdit;
    FieldPanel: TPanel;
    Label8: TLabel;
    FieldEdit: TEdit;
    SequencePanel: TPanel;
    Label9: TLabel;
    SequenceEdit: TEdit;
    TopSplitter: TSplitter;
  private
    FOnlyShowLastError: Boolean;
    { Private declarations }
    procedure HandleErrorEvent(errorText: string);
    procedure HandleSuccessEvent;
  protected
    function GetInitialHeight: Integer; override;
    function GetInitialWidth: Integer; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    class function GetTypeId: TLayoutableFrame.TTypeId; override;
    class function GetTypeName: string; override;
    class function GetTypeCaption: string; override;

    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder); override;
    procedure Unprepare; override;
  end;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.Configuration;

{ TErrorsFrame }

constructor TErrorsFrame.Create(AOwner: TComponent);
begin
  inherited;
  FOnlyShowLastError := True;
  ErrorsMemo.Text := '';
end;

function TErrorsFrame.GetInitialHeight: Integer;
begin
  Result := 50;
end;

function TErrorsFrame.GetInitialWidth: Integer;
begin
  Result := 300;
end;

class function TErrorsFrame.GetTypeCaption: string;
begin
  Result := 'Errors';
end;

class function TErrorsFrame.GetTypeId: TLayoutableFrame.TTypeId;
begin
  Result := ftErrors;
end;

class function TErrorsFrame.GetTypeName: string;
begin
  Result := 'Errors';
end;

procedure TErrorsFrame.HandleErrorEvent(errorText: string);
var
  Field: TFieldedText.TField;
//  Sequence: TFieldedTextSequence;
begin
  errorText := DateTimeToStr(Now) + '> ' + errorText;
  if FOnlyShowLastError then
    ErrorsMemo.Text := errorText
  else
    ErrorsMemo.Lines.Add(errorText);

  LineEdit.Text := IntToStr(FEditEngine.LineNumber);
  LinePosEdit.Text := IntToStr(FEditEngine.LinePos);
  RecordEdit.Text := IntToStr(FEditEngine.RecordNumber);
  ActiveIndexEdit.Text := IntToStr(FEditEngine.ActiveItemNumber);
  Field := FEditEngine.CurrentField;
  if Assigned(Field) then
    FieldEdit.Text := Field.Name
  else
    FieldEdit.Text := '';
{  Sequence := FEditEngine.CurrentSequence;
  SequenceEdit.Text := Sequence.Name;
  ItemIndexEdit.Text := TEditEngine.IndexToNumber(Sequence.IndexOfItem(EditEngine.CurrentSequenceItem)).ToString;
  FilePosEdit.Text := FEditEngine.Position.ToString;
  TableEdit.Text := FEditEngine.TableNumber.ToString;}
end;

procedure TErrorsFrame.HandleSuccessEvent;
begin
  if FOnlyShowLastError then
    ErrorsMemo.Text := ''
  else
    ErrorsMemo.Lines.Add(DateTimeToStr(Now) + '>  Success');

  LineEdit.Text := '';
  LinePosEdit.Text := '';
  RecordEdit.Text := '';
  ActiveIndexEdit.Text := '';
  FieldEdit.Text := '';
  SequenceEdit.Text := '';
  ItemIndexEdit.Text := '';
  FilePosEdit.Text := '';
  TableEdit.Text := '';
end;

procedure TErrorsFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
begin
  inherited;
  FEditEngine.SubscribeErrorEvent(HandleErrorEvent);
  FEditEngine.SubscribeSuccessEvent(HandleSuccessEvent);
end;

procedure TErrorsFrame.Unprepare;
begin
  FEditEngine.UnsubscribeErrorEvent(HandleErrorEvent);
  FEditEngine.UnsubscribeSuccessEvent(HandleSuccessEvent);
  inherited;
end;

end.
