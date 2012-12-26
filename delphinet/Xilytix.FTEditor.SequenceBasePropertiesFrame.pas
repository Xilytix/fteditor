// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.SequenceBasePropertiesFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.Binder;

type
  TCaptionChangeEvent = procedure of object;

  TSequenceBasePropertiesFrame = class(TFrame)
  protected
    FBinder: TBinder;
    FEditEngine: TEditEngine;

    FLoadingControlsCount: Integer;
    function GetLoadingControls: Boolean;

    property LoadingControls: Boolean read GetLoadingControls;

  public
    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
    procedure Unprepare;

    procedure Refresh; virtual; abstract;
  end;

implementation

{$R *.nfm}

{ TSequenceBasePropertiesFrame }

function TSequenceBasePropertiesFrame.GetLoadingControls: Boolean;
begin
  Result := FLoadingControlsCount > 0;
end;

procedure TSequenceBasePropertiesFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
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

procedure TSequenceBasePropertiesFrame.Unprepare;
begin

end;

end.
