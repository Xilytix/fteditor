// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.EditorFrame;

interface

uses
  System.Xml,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FTEditor.LayoutableFrame,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.Binder;

type
  TEditorFrame = class(TLayoutableFrame)
  private
    { Private declarations }
  protected
    FEditEngine: TEditEngine;
    FBinder: TBinder;

    procedure ProcessConfigurationChange; virtual;

  public
    { Public declarations }
    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder); virtual;
    procedure Unprepare; virtual;

    procedure NotifyConfigurationChange;

    property EditEngine: TEditEngine read FEditEngine;
    property Binder: TBinder read FBinder;
  end;

implementation

{$R *.dfm}

{ TEditorFrame }

procedure TEditorFrame.NotifyConfigurationChange;
begin
  ProcessConfigurationChange;
end;

procedure TEditorFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
begin
  if Assigned(FEditEngine)
     or
     Assigned(FBinder) then
  begin
    Unprepare;
  end;

  FEditEngine := myEditEngine;
  FBinder := myBinder;
end;

procedure TEditorFrame.ProcessConfigurationChange;
begin
  ;
end;

procedure TEditorFrame.Unprepare;
begin
  FEditEngine := nil;
  FBinder := nil;
end;

end.
