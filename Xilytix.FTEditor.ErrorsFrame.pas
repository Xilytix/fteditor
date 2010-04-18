// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.ErrorsFrame;

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
  Borland.Vcl.ExtCtrls,
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

{$R *.nfm}

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
  Field: TFieldedTextField;
//  Sequence: TFieldedTextSequence;
begin
  errorText := DateTime.Now.ToString + '> ' + errorText;
  if FOnlyShowLastError then
    ErrorsMemo.Text := errorText
  else
    ErrorsMemo.Lines.Add(errorText);

  LineEdit.Text := FEditEngine.LineNumber.ToString;
  LinePosEdit.Text := FEditEngine.LinePos.ToString;
  RecordEdit.Text := FEditEngine.RecordNumber.ToString;
  ActiveIndexEdit.Text := FEditEngine.ActiveItemNumber.ToString;
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
    ErrorsMemo.Lines.Add(DateTime.Now.ToString + '>  Success');

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
  Include(FEditEngine.ErrorEvent, HandleErrorEvent);
  Include(FEditEngine.SuccessEvent, HandleSuccessEvent);
end;

procedure TErrorsFrame.Unprepare;
begin
  Exclude(FEditEngine.ErrorEvent, HandleErrorEvent);
  Exclude(FEditEngine.SuccessEvent, HandleSuccessEvent);
  inherited;
end;

end.
