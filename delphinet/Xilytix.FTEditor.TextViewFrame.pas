// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.TextViewFrame;

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
  Borland.Vcl.RichEdit,
  Borland.Vcl.StdCtrls,
  Borland.Vcl.ComCtrls,
  Borland.Vcl.ExtCtrls,
  Xilytix.FTEditor.EditData,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.LayoutableFrame,
  Xilytix.FTEditor.EditorFrame,
  Xilytix.FTEditor.SourceFrame;

type
  TTextAttributes2 = class
  strict private
    FFormat: TCharFormat2;
  public
    constructor Create;
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetFontColor(const Value: TColor);
    procedure SetFontStyles(const Value: TFontStyles);

    procedure Save(richEdit: TRichEdit);
  end;

  TTextViewFrame = class(TSourceFrame)
    TextEdit: TRichEdit;
    TopSplitter: TSplitter;
    ParseButton: TButton;
    procedure TextEditChange(Sender: TObject);
    procedure ParseButtonClick(Sender: TObject);
    procedure FrameComponentClick(Sender: TObject);
    procedure TextEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TextEditMouseEnter(Sender: TObject);
    procedure TextEditMouseLeave(Sender: TObject);
    procedure TextEditMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TextEditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TextEditEnter(Sender: TObject);
    procedure TextEditExit(Sender: TObject);
  private
    { Private declarations }
    const
      WM_CellSelected = WM_USER + $400;

    var
      FCursorActive: Boolean;
      FHasMouse: Boolean;
      FColored: Boolean;
      FColoredMouseOverCell: TCell;
      FColoredCursorActiveCell: TCell;
      FUpdating: Boolean;

    procedure HandleEditEngineNewOpenTextEvent;
    procedure HandleEditEngineTextChangeEvent(source: TFrame);
    procedure HandleEditEngineMetaChangeEvent;
    procedure HandleEditEngineSynchronisedChangeEvent;
    procedure HandleEditEngineParseEvent;
    procedure HandleMouseOverChangedEvent;
    procedure HandleCursorActiveChangedEvent(frameChanged, cellChanged: Boolean);

    procedure ProcessMousePos(X, Y: Integer);
    function CharFromPos(x, y: Integer): Integer;

    function CheckDoAutoParse(passText: Boolean): Boolean;
    procedure DoColorText(refreshColor: Boolean);

  protected
    function GetInitialHeight: Integer; override;
    function GetInitialWidth: Integer; override;

    procedure ProcessConfigurationChange; override;
    procedure SetActive(value: Boolean); override;

    procedure PopulateActiveCursorInfo(frameChanged, cellChanged: Boolean); override;

  public
    { Public declarations }
    procedure WMCellSelected(var Msg: TMessage); message WM_CellSelected;

    class function GetTypeId: TLayoutableFrame.TTypeId; override;
    class function GetTypeName: string; override;
    class function GetTypeCaption: string; override;

    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder); override;
    procedure Unprepare; override;
  end;

implementation

{$R *.nfm}

uses
  System.Runtime.InteropServices,
  Xilytix.FTEditor.Colors,
  Xilytix.FTEditor.Configuration;

{ TTextViewFrame }

function TTextViewFrame.CharFromPos(x, y: Integer): Integer;
var
  Point: TPoint;
begin
  Point.X := x;
  Point.Y := y;

  Result := TextEdit.Perform(EM_CHARFROMPOS, 0, Point);
end;

function TTextViewFrame.CheckDoAutoParse(passText: Boolean): Boolean;
var
  newText: string;
begin
  if FEditEngine.Synchronising or (SourceState <> ssActive) or not Configuration.AutoParse then
    Result := False
  else
  begin
    if passText then
      newText := TextEdit.Text
    else
      newText := nil;

    FEditEngine.Parse(Self, newText);
    Result := True;
  end;
end;

procedure TTextViewFrame.DoColorText(refreshColor: Boolean);
var
  SelStart: Integer;
  SelLength: Integer;
  WasFocused: Boolean;
  Attributes: TTextAttributes2;
  MouseOverCell: TCell;
  CursorActiveCell: TCell;

  function CalcMouseOverCell: TCell;
  begin
    if FHasMouse or not Configuration.TextTrackMouse then
      Result := nil
    else
      Result := FEditEngine.MouseOverCell;
  end;

  function CalcCursorActiveCell: TCell;
  begin
    if FCursorActive
       or
       not Configuration.TextTrackCursor
       or
       (FEditEngine.CursorActiveRichPos < 0) then
      Result := nil
    else
      Result := FEditEngine.CursorActiveCell;
  end;

  procedure BeginColoring;
  begin
    FUpdating := True;
    SelStart := TextEdit.SelStart;
    SelLength := TextEdit.SelLength;
    WasFocused := Focused;
    if WasFocused then
    begin
//      LineCountEdit.SetFocus;
    end;
  end;

  procedure EndColoring;
  begin
    if WasFocused then
    begin
//      TextEdit.SetFocus;
    end;
    TextEdit.SelStart := SelStart;
    TextEdit.SelLength := SelLength;
    FUpdating := False;
  end;

  procedure RemoveColor;
  begin
    Attributes := TTextAttributes2.Create;
    Attributes.SetBackgroundColor(Configuration.Colors[rcTextView].Background);
    Attributes.SetFontColor(Configuration.Colors[rcTextView].Font);
    Attributes.SetFontStyles(Configuration.Colors[rcTextView].FontStyles);

    TextEdit.SelectAll;
    Attributes.Save(TextEdit);

    FColored := False;
    FColoredMouseOverCell := nil;
    FColoredCursorActiveCell := nil;
  end;

  procedure AddCellColor(Cell: TCell);
  var
    ColorId: TResolvedColorId;
  begin
    if Cell = MouseOverCell then
    begin
      if Cell.Error then
        ColorId := rcGridMouseOverCellError
      else
        ColorId := rcGridMouseOverCell;

      FColoredMouseOverCell := Cell;
    end
    else
    begin
      if Cell = CursorActiveCell then
      begin
        if Cell.Error then
          ColorId := rcGridFocusedCellError
        else
          ColorId := rcGridFocusedCell;

        FColoredCursorActiveCell := Cell;
      end
      else
        ColorId := Cell.TextResolvedColorId
    end;

    Attributes.SetBackgroundColor(Configuration.Colors[ColorId].Background);
    Attributes.SetFontColor(Configuration.Colors[ColorId].Font);
    Attributes.SetFontStyles(Configuration.Colors[ColorId].FontStyles);

    TextEdit.SelStart := Cell.RichPos;
    TextEdit.SelLength := Cell.RichLength;

    Attributes.Save(TextEdit);
  end;

  procedure AddRowColor(row: TRow);
  var
    I: Integer;
  begin
    for I := 0 to Row.Cells.Count - 1 do
    begin
      AddCellColor(Row.Cells[I]);
    end;
  end;

  procedure AddColor;
  var
    I: Integer;
  begin
    Attributes := TTextAttributes2.Create;
    MouseOverCell := CalcMouseOverCell;
    CursorActiveCell := CalcCursorActiveCell;

    for I := 0 to FEditEngine.RowCount - 1 do
    begin
      AddRowColor(FEditEngine.Rows[I]);
    end;
    FColored := True;
  end;

var
  MouseOverCellChanged: Boolean;
  CursorActiveCellChanged: Boolean;
begin
  if not FEditEngine.Synchronising then
  begin
    if not FEditEngine.Synchronised then
    begin
      if FColored or Assigned(FColoredMouseOverCell) or Assigned(FColoredCursorActiveCell) then
      begin
        BeginColoring;
        try
          RemoveColor;
        finally
          EndColoring;
        end;
      end;
    end
    else
    begin
      if Configuration.ColorText then
      begin
        if not FColored then
        begin
          BeginColoring;
          try
            if Assigned(FColoredMouseOverCell) or Assigned(FColoredCursorActiveCell) then
            begin
              RemoveColor;
            end;
            AddColor;
          finally
            EndColoring;
          end;
        end
        else
        begin
          if refreshColor then
          begin
            BeginColoring;
            try
              RemoveColor;
              AddColor;
            finally
              EndColoring;
            end;
          end;
        end;
      end
      else
      begin
        MouseOverCell := CalcMouseOverCell;
        MouseOverCellChanged := MouseOverCell <> FColoredMouseOverCell;
        CursorActiveCell := CalcCursorActiveCell;
        CursorActiveCellChanged := CursorActiveCell <> FColoredCursorActiveCell;

        if FColored or MouseOverCellChanged or CursorActiveCellChanged then
        begin
          BeginColoring;
          try
            RemoveColor;

            if CursorActiveCellChanged and Assigned(CursorActiveCell) then
            begin
              AddCellColor(CursorActiveCell);
            end;

            if MouseOverCellChanged and Assigned(MouseOverCell) and (MouseOverCell <> CursorActiveCell) then
            begin
              AddCellColor(MouseOverCell);
            end;

          finally
            EndColoring;
          end;
        end;
      end;
    end;
  end;
end;

procedure TTextViewFrame.FrameComponentClick(Sender: TObject);
begin
  TextEdit.SetFocus;
end;

function TTextViewFrame.GetInitialHeight: Integer;
begin
  Result := 150;
end;

function TTextViewFrame.GetInitialWidth: Integer;
begin
  Result := 300;
end;

class function TTextViewFrame.GetTypeCaption: string;
begin
  Result := 'Text View';
end;

class function TTextViewFrame.GetTypeId: TLayoutableFrame.TTypeId;
begin
  Result := ftTextView;
end;

class function TTextViewFrame.GetTypeName: string;
begin
  Result := 'TextView';
end;

procedure TTextViewFrame.HandleCursorActiveChangedEvent(frameChanged, cellChanged: Boolean);
begin
  PopulateActiveCursorInfo(frameChanged, cellChanged);

  if (frameChanged or cellChanged)
     and
     not FCursorActive
     and
     Configuration.TextTrackCursor
     and
     (FEditEngine.CursorActiveRichPos >= 0) then
  begin
    TextEdit.SelStart := FEditEngine.CursorActiveRichPos;
    DoColorText(True);
  end;
end;

procedure TTextViewFrame.HandleEditEngineMetaChangeEvent;
begin
  CheckDoAutoParse(False);
end;

procedure TTextViewFrame.HandleEditEngineNewOpenTextEvent;
begin
  FUpdating := True;
  try
    TextEdit.Text := '';
    FColored := False;
    FColoredMouseOverCell := nil;
    FColoredCursorActiveCell := nil;
  finally
    FUpdating := False;
  end;
end;

procedure TTextViewFrame.HandleEditEngineParseEvent;
begin
  DoColorText(True);

  if FHasMouse then
  begin
    ProcessMousePos(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  end;
end;

procedure TTextViewFrame.HandleEditEngineSynchronisedChangeEvent;
begin
  DoColorText(False);

  if FHasMouse and not FEditEngine.Synchronised then
  begin
    FEditEngine.SetMouseOverCell(Self, -1, -1);
  end;
end;

procedure TTextViewFrame.HandleEditEngineTextChangeEvent(source: TFrame);
begin
  if source <> Self then
  begin
    FUpdating := True;
    try
      TextEdit.Text := FEditEngine.Text;
    finally
      FUpdating := False;
    end;

    CheckDoAutoParse(False);
  end;
end;

procedure TTextViewFrame.HandleMouseOverChangedEvent;
begin
  if not FHasMouse and Configuration.TextTrackMouse then
  begin
    DoColorText(True);
  end;
end;

procedure TTextViewFrame.ParseButtonClick(Sender: TObject);
begin
  FEditEngine.Parse(Self, nil);
end;

procedure TTextViewFrame.PopulateActiveCursorInfo(frameChanged, cellChanged: Boolean);
begin
  inherited;

  if FEditEngine.Synchronised then
  begin
    LineNrEdit.Text := ''; // To be done
    LinePosEdit.Text := '';
    FilePosEdit.Text := '';
  end;
end;

procedure TTextViewFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
begin
  inherited;

  Include(FEditEngine.NewOpenTextEvent, HandleEditEngineNewOpenTextEvent);
  Include(FEditEngine.TextChangeEvent, HandleEditEngineTextChangeEvent);
  Include(FEditEngine.MetaChangeEvent, HandleEditEngineMetaChangeEvent);
  Include(FEditEngine.SynchronisedChangeEvent, HandleEditEngineSynchronisedChangeEvent);
  Include(FEditEngine.ParseEvent, HandleEditEngineParseEvent);
  Include(FEditEngine.MouseOverChangedEvent, HandleMouseOverChangedEvent);
  Include(FEditEngine.CursorActiveChangedEvent, HandleCursorActiveChangedEvent);

  FUpdating := True;
  try
    TextEdit.Text := FEditEngine.Text;
  finally
    FUpdating := False;
  end;

  ProcessConfigurationChange;
end;

procedure TTextViewFrame.ProcessConfigurationChange;
begin
  inherited;

  TextEdit.Color := Configuration.Colors[rcTextView].Background;
  TextEdit.Font := Configuration.TextFont;
  TextEdit.Font.Color := Configuration.Colors[rcTextView].Font;
  TextEdit.Font.Style := Configuration.Colors[rcTextView].FontStyles;
  TextEdit.WordWrap := Configuration.WrapText;

  if not CheckDoAutoParse(False) then
  begin
    DoColorText(False);
  end;
end;

procedure TTextViewFrame.ProcessMousePos(X, Y: Integer);
var
  Pos: Integer;
begin
  if FEditEngine.Synchronised then
  begin
    Pos := CharFromPos(X, Y);
    FEditEngine.SetMouseOverRichPos(Self, Pos);
  end;
end;

procedure TTextViewFrame.SetActive(value: Boolean);
begin
//  ParseButton.Enabled := value;
  TextEdit.ReadOnly := not value;
  if value then
  begin
    FEditEngine.SetText(Self, TextEdit.Text);
  end;
end;

procedure TTextViewFrame.TextEditChange(Sender: TObject);
begin
  if not FUpdating then
  begin
    if not CheckDoAutoParse(True) then
    begin
      FEditEngine.SetText(Self, TextEdit.Text);
    end;
  end;
end;

procedure TTextViewFrame.TextEditEnter(Sender: TObject);
begin
  FCursorActive := True;

  if Configuration.TextTrackCursor then
  begin
    DoColorText(True);
  end;
end;

procedure TTextViewFrame.TextEditExit(Sender: TObject);
begin
  FCursorActive := False;

  if Assigned(FColoredCursorActiveCell) then
  begin
    DoColorText(True);
  end;
end;

procedure TTextViewFrame.TextEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_LEFT, VK_UP, VK_DOWN, VK_RIGHT, VK_END, VK_HOME, VK_PRIOR, VK_NEXT:
    begin
      PostMessage(Handle, WM_CellSelected, 0, 0);
    end;
  end;
end;

procedure TTextViewFrame.TextEditMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Pos: Integer;
begin
  if FEditEngine.Synchronised then
  begin
    Pos := CharFromPos(X, Y);
    FEditEngine.SetCursorRichPos(Self, Pos);
  end;
end;

procedure TTextViewFrame.TextEditMouseEnter(Sender: TObject);
begin
  FHasMouse := True;
end;

procedure TTextViewFrame.TextEditMouseLeave(Sender: TObject);
begin
  FEditEngine.SetMouseOverCell(Self, -1, -1);
  FHasMouse := False;
end;

procedure TTextViewFrame.TextEditMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  ProcessMousePos(X, Y);
end;

procedure TTextViewFrame.Unprepare;
begin
  Exclude(FEditEngine.NewOpenTextEvent, HandleEditEngineNewOpenTextEvent);
  Exclude(FEditEngine.TextChangeEvent, HandleEditEngineTextChangeEvent);
  Exclude(FEditEngine.MetaChangeEvent, HandleEditEngineMetaChangeEvent);
  Exclude(FEditEngine.SynchronisedChangeEvent, HandleEditEngineSynchronisedChangeEvent);
  Exclude(FEditEngine.ParseEvent, HandleEditEngineParseEvent);
  Exclude(FEditEngine.MouseOverChangedEvent, HandleMouseOverChangedEvent);
  Exclude(FEditEngine.CursorActiveChangedEvent, HandleCursorActiveChangedEvent);

  inherited;
end;

procedure TTextViewFrame.WMCellSelected(var Msg: TMessage);
begin
  if FEditEngine.Synchronised then
  begin
    FEditEngine.SetCursorRichPos(Self, TextEdit.SelStart);
  end;
end;

{ TTextAttributes2 }

constructor TTextAttributes2.Create;
begin
  inherited Create;
  FFormat.cbSize := Marshal.SizeOf(TypeOf(TCharFormat2));
  FFormat.dwMask := CFM_COLOR or CFM_BACKCOLOR or CFM_BOLD or CFM_ITALIC or CFM_UNDERLINE or CFM_STRIKEOUT;
end;

procedure TTextAttributes2.Save(richEdit: TRichEdit);
var
  Flag: Longint;
begin
  Flag := SCF_SELECTION;
  if richEdit.HandleAllocated then
  begin
    SendStructMessage(richEdit.Handle, EM_SETCHARFORMAT, Flag, FFormat);
  end;
end;

procedure TTextAttributes2.SetBackgroundColor(const Value: TColor);
begin
  if Value = clWindow then
    FFormat.dwEffects := FFormat.dwEffects or CFE_AUTOBACKCOLOR
  else
  begin
    FFormat.dwEffects := FFormat.dwEffects and not CFE_AUTOBACKCOLOR;
    FFormat.crBackColor := ColorToRGB(Value);
  end;
end;

procedure TTextAttributes2.SetFontColor(const Value: TColor);
begin
  if Value = clWindowText then
    FFormat.dwEffects := FFormat.dwEffects or CFE_AUTOCOLOR
  else
  begin
    FFormat.dwEffects := FFormat.dwEffects and not CFE_AUTOCOLOR;
    FFormat.crTextColor := ColorToRGB(Value);
  end;
end;

procedure TTextAttributes2.SetFontStyles(const Value: TFontStyles);
begin
  if fsBold in Value then
    FFormat.dwEffects := FFormat.dwEffects or CFE_BOLD
  else
    FFormat.dwEffects := FFormat.dwEffects and not CFE_BOLD;
  if fsItalic in Value then
    FFormat.dwEffects := FFormat.dwEffects or CFE_ITALIC
  else
    FFormat.dwEffects := FFormat.dwEffects and not CFE_ITALIC;
  if fsUnderline in Value then
    FFormat.dwEffects := FFormat.dwEffects or CFE_UNDERLINE
  else
    FFormat.dwEffects := FFormat.dwEffects and not CFE_UNDERLINE;
  if fsStrikeOut in Value then
    FFormat.dwEffects := FFormat.dwEffects or CFE_STRIKEOUT
  else
    FFormat.dwEffects := FFormat.dwEffects and not CFE_STRIKEOUT;
end;

end.
