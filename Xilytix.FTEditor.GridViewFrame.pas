// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.GridViewFrame;

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
  ComCtrls,
  StdCtrls,
  ExtCtrls,
  Grids,
  Xilytix.FTEditor.LayoutableFrame,
  Xilytix.FTEditor.Common,
  Xilytix.FTEditor.Binder,
  Xilytix.FTEditor.EditEngine,
  Xilytix.FTEditor.EditorFrame,
  Xilytix.FTEditor.SourceFrame;

type
  TBeginDrawCellsEvent = procedure of object;

  TGridViewFrame = class(TSourceFrame)
    GenerateButton: TButton;
    Grid: TDrawGrid;
    TopSplitter: TSplitter;
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure FrameComponentClick(Sender: TObject);
    procedure GridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure GridMouseLeave(Sender: TObject);
    procedure GridMouseEnter(Sender: TObject);
    procedure GridEnter(Sender: TObject);
    procedure GridExit(Sender: TObject);
    procedure GenerateButtonClick(Sender: TObject);
  private
    { Private declarations }
    const
      WM_CellSelected = WM_USER + $400;

    var
      FHasMouse: Boolean;
      FCursorActive: Boolean;
      FSelectingCell: Boolean;
      FDataRowOffset: Integer;
      FFieldNames: TEditEngine.TStringArray;

    procedure HandleEditEngineNewOpenTextEvent;
    procedure HandleEditEngineParseEvent;
    procedure HandleEditEngineMetaChangeEvent;
    procedure HandleEditEngineTextChangeEvent(source: TFrame);
    procedure HandleMouseOverChangedEvent;
    procedure HandleCursorActiveChangedEvent(frameChanged, cellChanged: Boolean);

    procedure ProcessMousePos(X, Y: Integer);

    procedure CheckDoAutoGenerate;

    procedure ClearGrid;
    procedure UpdateGrid;
  protected
    function GetInitialHeight: Integer; override;
    function GetInitialWidth: Integer; override;

    procedure ProcessConfigurationChange; override;
    procedure SetActive(value: Boolean); override;

    procedure PopulateActiveCursorInfo(frameChanged, cellChanged: Boolean); override;

  public
    { Public declarations }

    procedure WMCellSelected(var Msg: TMessage); message WM_CellSelected;

    procedure Prepare(const myEditEngine: TEditEngine; myBinder: TBinder); override;
    procedure Unprepare; override;

    class function GetTypeId: TLayoutableFrame.TTypeId; override;
    class function GetTypeName: string; override;
    class function GetTypeCaption: string; override;

    class function CalculateGridAutoRowHeight(aFont: TFont): Integer;
  end;

implementation

{$R *.dfm}

uses
  Xilytix.FTEditor.Colors,
  Xilytix.FTEditor.Configuration,
  Xilytix.FTEditor.EditData;

{ TGridViewFrame }

class function TGridViewFrame.CalculateGridAutoRowHeight(aFont: TFont): Integer;
begin
  Result := aFont.Height;
  if Result > 0 then
    Inc(Result, 2)
  else
  begin
    Result := Result * -1;
    Inc(Result, 4);
  end;
end;

procedure TGridViewFrame.CheckDoAutoGenerate;
begin
  if not FEditEngine.Synchronising and (SourceState = ssActive) and Configuration.AutoGenerate then
  begin
    FEditEngine.Generate(Self);
  end;
end;

procedure TGridViewFrame.ClearGrid;
begin
  Grid.RowCount := 1;
end;

procedure TGridViewFrame.FrameComponentClick(Sender: TObject);
begin
  Grid.SetFocus;
end;

procedure TGridViewFrame.GenerateButtonClick(Sender: TObject);
begin
  FEditEngine.Generate(Self);
end;

function TGridViewFrame.GetInitialHeight: Integer;
begin
  Result := 150;
end;

function TGridViewFrame.GetInitialWidth: Integer;
begin
  Result := 300;
end;

class function TGridViewFrame.GetTypeCaption: string;
begin
  Result := 'Grid View';
end;

class function TGridViewFrame.GetTypeId: TLayoutableFrame.TTypeId;
begin
  Result := ftGridView;
end;

class function TGridViewFrame.GetTypeName: string;
begin
  Result := 'GridView';
end;

procedure TGridViewFrame.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);

  procedure ShrinkRect;
  begin
    Rect.Left := Rect.Left + 1;
    Rect.Right := Rect.Right - 1;
    Rect.Top := Rect.Top + 1;
    Rect.Bottom := Rect.Bottom - 1;
  end;

var
  DataRowIdx: Integer;
  DataColIdx: Integer;
  ColorId: TResolvedColorId;
  Row: TRow;
  Cell: TCell;
  Error: Boolean;
  DisplayStr: string;
begin
  DataRowIdx := ARow - FDataRowOffset;
  DataColIdx := ACol - 1;

  if DataRowIdx >= FEditEngine.RowCount then
  begin
    ColorId := rcGridBeyondBoundary;
    ShrinkRect;
  end
  else
  begin
    if (DataRowIdx >= 0) and (DataColIdx >= FEditEngine.CellsInRowCount[DataRowIdx]) then
    begin
      ColorId := rcGridBeyondBoundary;
      ShrinkRect;
    end
    else
    begin
      if DataRowIdx < 0 then
      begin
        if ACol = 0 then
        begin
          DisplayStr := 'N';
          ColorId := rcGridFieldNamesRow;
        end
        else
        begin
          if DataColIdx < Length(FFieldNames) then
            DisplayStr := FFieldNames[DataColIdx]
          else
            DisplayStr := '';
          ColorId := rcGridFieldNamesColumn;
        end;

        ShrinkRect;
      end
      else
      begin
        Row := FEditEngine.Rows[DataRowIdx];
        Error := Row.Error;

        if ACol = 0 then
        begin
          if Row.Heading then
            DisplayStr := 'H' + IntToStr(Row.Number)
          else
            DisplayStr := IntToStr(Row.Number);

          if not FHasMouse and Configuration.GridTrackMouse and FEditEngine.IsMouseOverRow(Row) then
          begin
            if Error then
              ColorId := rcGridMouseOverRowError
            else
              ColorId := rcGridMouseOverRow;
          end
          else
          begin
            ColorId := Row.ResolvedColorId;
          end;
        end
        else
        begin
          Cell := FEditEngine.Cells[DataColIdx, DataRowIdx];
          Error := Cell.Error;

          if not FHasMouse and Configuration.GridTrackMouse and FEditEngine.IsMouseOverCell(Cell) then
          begin
            if Error then
              ColorId := rcGridMouseOverCellError
            else
              ColorId := rcGridMouseOverCell;
          end
          else
          begin
            if (
                 not FCursorActive
                 and
                 Configuration.GridTrackCursor
                 and
                 FEditEngine.IsCursorActiveCell(cell)
               )
               or
               (
                 FCursorActive
                 and
                 ((gdFocused in State) or (gdSelected in State))
               ) then
            begin
              if Cell.Error then
                ColorId := rcGridFocusedCellError
              else
                ColorId := rcGridFocusedCell;
            end
            else
            begin
              ColorId := Cell.GridResolvedColorId;
            end;
          end;

          DisplayStr := Cell.ValueAsString;
        end;
      end;
    end;
  end;

  Grid.Canvas.Brush.Color := Configuration.Colors[ColorId].Background;
  Grid.Canvas.Font.Color := Configuration.Colors[ColorId].Font;
  Grid.Canvas.Font.Style :=  Configuration.Colors[ColorId].FontStyles;

  Grid.Canvas.FillRect(Rect);
  Grid.Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, DisplayStr);

  if gdFocused in State then
  begin
    Grid.Canvas.DrawFocusRect(Rect);
  end;
end;

procedure TGridViewFrame.GridEnter(Sender: TObject);
begin
  FCursorActive := True;

  if Configuration.GridTrackCursor then
  begin
    Grid.Invalidate;
  end;
end;

procedure TGridViewFrame.GridExit(Sender: TObject);
begin
  FCursorActive := False;

  if Configuration.GridTrackCursor then
  begin
    Grid.Invalidate;
  end;
end;

procedure TGridViewFrame.GridMouseEnter(Sender: TObject);
begin
  FHasMouse := True;
end;

procedure TGridViewFrame.GridMouseLeave(Sender: TObject);
begin
  FEditEngine.SetMouseOverCell(Self, -1, -1);
  FHasMouse := False;
end;

procedure TGridViewFrame.GridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  ProcessMousePos(X, Y);
end;

procedure TGridViewFrame.GridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if not FSelectingCell then
  begin
    CanSelect := FEditEngine.CanSelectCell(ACol-1, ARow-FDataRowOffset);
    if CanSelect and FEditEngine.Synchronised then
    begin
      PostMessage(Handle, WM_CellSelected, 0, 0);
    end;
  end;
end;

procedure TGridViewFrame.HandleEditEngineTextChangeEvent(source: TFrame);
begin
  UpdateGrid;
end;

procedure TGridViewFrame.HandleMouseOverChangedEvent;
begin
  if not FHasMouse and Configuration.GridTrackMouse then
  begin
    Grid.Invalidate;
  end;
end;

procedure TGridViewFrame.HandleCursorActiveChangedEvent(frameChanged, cellChanged: Boolean);
var
  GridRowIdx: Integer;
  GridColIdx: Integer;
begin
  PopulateActiveCursorInfo(frameChanged, cellChanged);

  if (frameChanged or cellChanged)
     and
     not FCursorActive
     and
     Configuration.GridTrackCursor
     and
     not FSelectingCell then
  begin
    if Assigned(FEditEngine.CursorActiveCell) then
    begin
      GridRowIdx := FEditEngine.CursorActiveRowIdx + FDataRowOffset;
      GridColIdx := FEditEngine.CursorActiveColIdx + 1;

      FSelectingCell := True;
      try
        Grid.Col := GridColIdx;

        if GridRowIdx >= Grid.FixedRows then
          Grid.Row := GridRowIdx
        else
          Grid.Row := GridRowIdx + 1;

      finally
        FSelectingCell := False;
      end;
    end;

    Grid.Invalidate;
  end;
end;

procedure TGridViewFrame.HandleEditEngineMetaChangeEvent;
begin
  CheckDoAutoGenerate;
end;

procedure TGridViewFrame.HandleEditEngineNewOpenTextEvent;
begin
  ClearGrid;
end;

procedure TGridViewFrame.HandleEditEngineParseEvent;
begin
  UpdateGrid;

  if FHasMouse then
  begin
    ProcessMousePos(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  end;
end;

procedure TGridViewFrame.PopulateActiveCursorInfo(frameChanged, cellChanged: Boolean);
var
  ActiveCell: TCell;
begin
  inherited;

  if FEditEngine.Synchronised then
  begin
    ActiveCell := FEditEngine.CursorActiveCell;
    if Assigned(ActiveCell) then
    begin
      LineNrEdit.Text := IntToStr(ActiveCell.LineNumber);
      LinePosEdit.Text := IntToStr(ActiveCell.LinePos);
      FilePosEdit.Text := IntToStr(ActiveCell.FilePos);
    end;
  end;
end;

procedure TGridViewFrame.Prepare(const myEditEngine: TEditEngine; myBinder: TBinder);
begin
  inherited;

  FEditEngine.SubscribeNewOpenTextEvent(HandleEditEngineNewOpenTextEvent);
  FEditEngine.SubscribeParseEvent(HandleEditEngineParseEvent);
  FEditEngine.SubscribeMetaChangeEvent(HandleEditEngineMetaChangeEvent);
  FEditEngine.SubscribeTextChangeEvent(HandleEditEngineTextChangeEvent);
  FEditEngine.SubscribeMouseOverChangedEvent(HandleMouseOverChangedEvent);
  FEditEngine.SubscribeCursorActiveChangedEvent(HandleCursorActiveChangedEvent);

  ProcessConfigurationChange;

  UpdateGrid;
end;

procedure TGridViewFrame.ProcessConfigurationChange;
begin
  inherited;

  Grid.Font := Configuration.GridFont;

  Grid.Color := Configuration.Colors[rcGridView].Background;
  Grid.Font.Color := Configuration.Colors[rcGridView].Font;
  Grid.Font.Style := Configuration.Colors[rcGridView].FontStyles;

  if not Configuration.GridRowHeightAuto then
    Grid.DefaultRowHeight := Configuration.GridManualRowHeight
  else
    Grid.DefaultRowHeight := CalculateGridAutoRowHeight(Grid.Font);

  if Configuration.GridHorizontalLinesVisible then
    Grid.Options := Grid.Options + [goFixedHorzLine, goHorzLine]
  else
    Grid.Options := Grid.Options - [goFixedHorzLine, goHorzLine];

  if Configuration.GridVerticalLinesVisible then
    Grid.Options := Grid.Options + [goFixedVertLine, goVertLine]
  else
    Grid.Options := Grid.Options - [goFixedVertLine, goVertLine];

  Grid.Invalidate;

  CheckDoAutoGenerate;
end;

procedure TGridViewFrame.ProcessMousePos(X, Y: Integer);
var
  ACol, ARow: Integer;
begin
  Grid.MouseToCell(X, Y, ACol, ARow);
  FEditEngine.SetMouseOverCell(Self, ACol-1, ARow-FDataRowOffset);
end;

procedure TGridViewFrame.SetActive(value: Boolean);
begin
//  GenerateButton.Enabled := value;
//  Grid.ReadOnly := not value;
end;

procedure TGridViewFrame.Unprepare;
begin
  FEditEngine.UnsubscribeNewOpenTextEvent(HandleEditEngineNewOpenTextEvent);
  FEditEngine.UnsubscribeParseEvent(HandleEditEngineParseEvent);
  FEditEngine.UnsubscribeMetaChangeEvent(HandleEditEngineMetaChangeEvent);
  FEditEngine.UnsubscribeTextChangeEvent(HandleEditEngineTextChangeEvent);
  FEditEngine.UnsubscribeMouseOverChangedEvent(HandleMouseOverChangedEvent);
  FEditEngine.UnsubscribeCursorActiveChangedEvent(HandleCursorActiveChangedEvent);

  inherited;
end;

procedure TGridViewFrame.UpdateGrid;
var
  FixedRows: Integer;
  RowCount: Integer;
begin
  if FEditEngine.RowCount = 0 then
    ClearGrid
  else
  begin
    if not Configuration.GridFixedHeadingRows then
      FixedRows := 0
    else
      FixedRows := FEditEngine.HeadingCount;

    FFieldNames := nil;
    if (FixedRows <> 0) or not Configuration.GridShowFieldNamesIfNoFixedHeadingRows then
      FDataRowOffset := 0
    else
    begin
      FFieldNames := FEditEngine.GetOrderedRootFieldNames;
      FDataRowOffset := 1;
      FixedRows := 1;
    end;

    if (FEditEngine.RowCount + FDataRowOffset) <= FixedRows then
      RowCount := FixedRows + 1
    else
      RowCount := FEditEngine.RowCount + FDataRowOffset;

    if Grid.RowCount <> RowCount then
    begin
      Grid.RowCount := RowCount;
    end;

    if Grid.FixedRows <> FixedRows then
    begin
      Grid.FixedRows := FixedRows;
    end;

    if FEditEngine.MaxCellsInRowCount = 0 then
    begin
      if Grid.ColCount <> 2 then
      begin
        Grid.ColCount := 2;
      end;
    end
    else
    begin
      if Grid.ColCount <> (FEditEngine.MaxCellsInRowCount + 1) then
      begin
        Grid.ColCount := FEditEngine.MaxCellsInRowCount + 1;
      end;
    end;

    if Grid.FixedCols <> 1 then
    begin
      Grid.FixedCols := 1;
    end;

    Grid.Invalidate;
  end;
end;

procedure TGridViewFrame.WMCellSelected(var Msg: TMessage);
begin
  if not FSelectingCell then
  begin
    FSelectingCell := True;
    try
      FEditEngine.SetCursorCell(Self, Grid.Col-1, Grid.Row-FDataRowOffset);
    finally
      FSelectingCell := False;
    end;
  end;
end;

end.
