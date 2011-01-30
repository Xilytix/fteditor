// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.EditData;

interface

uses
  Contnrs,
  Generics.Defaults,
  Generics.Collections,
  Rtti,
  Xilytix.FieldedText.Utils,
  Xilytix.FieldedText.Main,
  Xilytix.FTEditor.Common,
  Xilytix.FTEditor.Colors;

type
  TRow = class;

  TCell = class(TObject)
  strict private
    FActiveIndex: Integer;
    FValue: Variant;
    FValueAsString: string;
    FValueAsStringEmpty: Boolean;
    FSequenceItem: TFieldedText.TSequence.TItem;
    FFilePos: Int64;
    FLineNumber: Integer;
    FLinePos: Integer;
    FTextLength: Integer;
    FRichLength: Integer;
    FRow: TRow;
    FDisplayCulture: TFieldedTextLocaleSettings;
    FError: Boolean;

    FGridResolvedColorId: TResolvedColorId;
    FTextResolvedColorId: TResolvedColorId;

    function GetValueAsString: string;
  strict protected
    FRichPos: Integer;
  public
    constructor Create(myActiveIndex: Integer;
                       const myValue: Variant;
                       mySequenceItem: TFieldedText.TSequence.TItem;
                       myFilePos: Int64;
                       myRichPos: Integer;
                       myLineNumber: Integer;
                       myLinePos: Integer;
                       myTextLength: Integer;
                       myRichLength: Integer;
                       myRow: TRow;
                       myDisplayCulture: TFieldedTextLocaleSettings);
    property ActiveIndex: Integer read FActiveIndex;
    property SequenceItem: TFieldedText.TSequence.TItem read FSequenceItem;
    property FilePos: Int64 read FFilePos;
    property RichPos: Integer read FRichPos;
    property LineNumber: Integer read FLineNumber;
    property LinePos: Integer read FLinePos;
    property TextLength: Integer read FTextLength;
    property RichLength: Integer read FRichLength;
    property Value: Variant read FValue;
    property ValueAsString: string read GetValueAsString;
    property Error: Boolean read FError write FError;

    property Row: TRow read FRow;

    procedure Resolve;

    property GridResolvedColorId: TResolvedColorId read FGridResolvedColorId write FGridResolvedColorId;
    property TextResolvedColorId: TResolvedColorId read FTextResolvedColorId write FTextResolvedColorId;
  end;

  TCellCollection = TObjectList<TCell>;

  TSearchCell = class(TCell)
  public
    procedure SetRichPos(Value: Integer);
  end;

  TRow = class
  strict private
    FCells: TCellCollection;
    FHeading: Boolean;
    FNumber: Integer;
    FLineNumber: Integer;
    FTableNr: Integer;
    FNewTable: Boolean;
    FError: Boolean;

    FResolvedColorId: TResolvedColorId;

    function GetLastCell: TCell;
  public
    constructor Create(myHeading: Boolean;
                       myNumber: Integer;
                       myLineNumber: Integer;
                       myTableNr: Integer);
    procedure SetNewTable(const Value: Boolean);

    property Cells: TCellCollection read FCells;
    property LastCell: TCell read GetLastCell;

    property Heading: Boolean read FHeading;
    property Number: Integer read FNumber;
    property LineNumber: Integer read FLineNumber;
    property TableNr: Integer read FTableNr;
    property NewTable: Boolean read FNewTable write SetNewTable;
    property Error: Boolean read FError write FError;

    procedure Resolve;

    property ResolvedColorId: TResolvedColorId read FResolvedColorId write FResolvedColorId;
  end;

  TEditData = class
  strict private
    type
      TAllCellsEntry = record
        Col: Integer;
        Row: Integer;
        Cell: TCell;
        function GetRichPos: Integer;
        property RichPos: Integer read GetRichPos;
      end;

      IAllCellsEntryComparer = IComparer<TAllCellsEntry>;
      TAllCellsEntryComparer = class(TComparer<TAllCellsEntry>)
      public
        function Compare(const Left, Right: TAllCellsEntry): Integer; override;
      end;

      TAllCells = class(TList<TAllCellsEntry>)
      strict private
        class var
          FEntryComparer: IAllCellsEntryComparer;
          FSearchEntry: TAllCellsEntry;

        class constructor Create;
        class destructor Destroy;

        function GetCells(idx: Integer): TCell;
        function GetCols(idx: Integer): Integer;
        function GetRows(idx: Integer): Integer;
      public
        property Cells[idx: Integer]: TCell read GetCells; default;
        property Cols[idx: Integer]: Integer read GetCols;
        property Rows[idx: Integer]: Integer read GetRows;

        procedure Add(aCell: TCell; aCol, aRow: Integer);
        function Find(richPos: Integer; out idx: Integer): Boolean;
      end;

      TRows = class(TObjectList<TRow>)
      strict private
        function GetRows(idx: Integer): TRow;
        function GetLastRow: TRow;
      public
        property Rows[idx: Integer]: TRow read GetRows; default;
        property LastRow: TRow read GetLastRow;
        function CheckGetRow(idx: Integer): TRow;
      end;

      TLineRec = record
        FilePos: Int64;
        RichPos: Integer;
        Length: Integer;

//        function CompareTo(obj: TObject): Integer;
      end;
      TLines = array of TLineRec;

    var
      FText: string;
      FRows: TRows;
      FAllCells: TAllCells;
      FLines: TLines;
      FLineCount: Integer;
      FLastLineIdx: Integer;

      FHeadingCount: Integer;
      FRecordCount: Integer;
      FMaxCellsInRowCount: Integer;

      FMainHeadingRow: TRow;

      FDisplayCulture: TFieldedTextLocaleSettings;

    procedure GrowLines;

    function AddRow(heading: Boolean;
                    number: Integer;
                    tableNr: Integer): Integer;

    function GetCharCount: Int64;
    function GetRowCount: Integer;
    function GetLastRow: TRow;
    function GetLastRowIdx: Integer;
    function GetCells(aCol, aRow: Integer): TCell;
    function GetRows(aRow: Integer): TRow;
    function GetCellsInRowCount(aRow: Integer): Integer;
    function GetHeading(aCol: Integer): string;

    property LastRow: TRow read GetLastRow;
    property LastRowIdx: Integer read GetLastRowIdx;
  public
    constructor Create(myDisplayCulture: TFieldedTextLocaleSettings);
    property RowCount: Integer read GetRowCount;
    property HeadingCount: Integer read FHeadingCount;
    property Heading[aCol: Integer]: string read GetHeading;
    property MaxCellsInRowCount: Integer read FMaxCellsInRowCount;
    property CellsInRowCount[aRow: Integer]: Integer read GetCellsInRowCount;
    property Cells[aCol, aRow: Integer]: TCell read GetCells;
    property Rows[aRow: Integer]: TRow read GetRows;
    function CheckGetRow(aRow: Integer): TRow;

    property Text: string read FText write FText;

    property LineCount: Integer read FLineCount;
    property CharCount: Int64 read GetCharCount;
    property RecordCount: Integer read FRecordCount;

    procedure Reset;
    procedure ResetParsing(myDisplayCulture: TFieldedTextLocaleSettings);
    procedure Resolve;

    procedure StartLine(const filePos: Int64);
    procedure FinishLine(const filePos: Int64);

    function AddHeading(main: Boolean): Integer;
    function AddRecord(recNr, tableNr: Integer): Integer;
    procedure SetLastRecordAsNewTable;
    procedure AddCell(activeIndex: Integer; const value: Variant; sequenceItem: TFieldedText.TSequence.TItem;
                      filePos: Int64; textLength: Integer);
    procedure SetError(activeIndex: Integer);

    function CanSelectCell(ACol, ARow: Integer): Boolean;

    procedure FindCellAtRichPos(pos: Integer; out aCell: TCell; out aCol, aRow: Integer);

    property DisplayCulture: TFieldedTextLocaleSettings read FDisplayCulture write FDisplayCulture;
  end;

implementation

uses
  Math,
  Variants,
  Xilytix.FTEditor.Configuration;

{ TCell }

constructor TCell.Create(myActiveIndex: Integer;
  const myValue: Variant;
  mySequenceItem: TFieldedText.TSequence.TItem;
  myFilePos: Int64;
  myRichPos: Integer;
  myLineNumber: Integer;
  myLinePos: Integer;
  myTextLength: Integer;
  myRichLength: Integer;
  myRow: TRow;
  myDisplayCulture: TFieldedTextLocaleSettings);
begin
  inherited Create;
  FActiveIndex := myActiveIndex;
  FValue := myValue;
  FSequenceItem := mySequenceItem;
  FFilePos := myFilePos;
  FRichPos := myRichPos;
  FLineNumber := myLineNumber;
  FLinePos := myLinePos;
  FTextLength := myTextLength;
  FRichLength := myRichLength;
  FRow := myRow;
  FDisplayCulture := myDisplayCulture;

  FValueAsString := '';
  FValueAsStringEmpty := True;
end;

function TCell.GetValueAsString: string;
begin
  if FValueAsStringEmpty then
  begin
    if VarIsEmpty(FValue) or VarIsNull(FValue) then
      FValueAsString := Configuration.GridNullText
    else
    begin
      FValueAsString := FValue;
      FValueAsStringEmpty := False;
    end;
  end;

  Result := FValueAsString;
end;

procedure TCell.Resolve;
var
  ModIndex: Integer;
  AltResolvedColorId: TResolvedColorId;
begin
  if FRow.Heading then
  begin
    if FError then
      FGridResolvedColorId := rcGridHeadingColumnError
    else
    begin
      ModIndex := FActiveIndex mod 4;
      case ModIndex of
        0: FGridResolvedColorId := rcGridHeadingColumnMod0;
        1: FGridResolvedColorId := rcGridHeadingColumnMod1;
        2: FGridResolvedColorId := rcGridHeadingColumnMod2;
        3: FGridResolvedColorId := rcGridHeadingColumnMod3;
        else Assert(False);
      end;
    end;
    FTextResolvedColorId := FGridResolvedColorId;
  end
  else
  begin
    if FError then
    begin
      FGridResolvedColorId := rcGridRecordCellError;
      FTextResolvedColorId := rcGridRecordCellError;
    end
    else
    begin
      ModIndex := FActiveIndex mod 4;
      case ModIndex of
        0: AltResolvedColorId := rcGridRecordColumnMod0Alt;
        1: AltResolvedColorId := rcGridRecordColumnMod1Alt;
        2: AltResolvedColorId := rcGridRecordColumnMod2Alt;
        3: AltResolvedColorId := rcGridRecordColumnMod3Alt;
        else
        begin
          AltResolvedColorId := rcGridRecordColumnMod0Alt;
          Assert(False);
        end;
      end;

      FTextResolvedColorId := AltResolvedColorId;

      if (FRow.Number mod 2) = 1 then
        FGridResolvedColorId := AltResolvedColorId
      else
      begin
        case ModIndex of
          0: FGridResolvedColorId := rcGridRecordColumnMod0;
          1: FGridResolvedColorId := rcGridRecordColumnMod1;
          2: FGridResolvedColorId := rcGridRecordColumnMod2;
          3: FGridResolvedColorId := rcGridRecordColumnMod3;
          else Assert(False);
        end;
      end;
    end;
  end;
end;

{ TEditData.TAllCells }

procedure TEditData.TAllCells.Add(aCell: TCell; aCol, aRow: Integer);
var
  Entry: TAllCellsEntry;
begin
  Entry.Cell := aCell;
  Entry.Col := aCol;
  Entry.Row := aRow;

  inherited Add(Entry);
end;

class constructor TEditData.TAllCells.Create;
begin
  FEntryComparer := TAllCellsEntryComparer.Create;
  FSearchEntry.Cell := TSearchCell.Create(-1, Unassigned, nil, -1, -1, -1, -1, -1, -1, nil,
                                          TFieldedTextLocaleSettings.Invariant);
end;

class destructor TEditData.TAllCells.Destroy;
begin
  FSearchEntry.Cell.Free;
end;

function TEditData.TAllCells.Find(richPos: Integer; out idx: Integer): Boolean;
var
  Cell: TCell;
begin
  if Count = 0 then
    Result := False
  else
  begin
    TSearchCell(FSearchEntry.Cell).SetRichPos(richPos);
    if BinarySearch(FSearchEntry, idx, FEntryComparer) then
      Result := True
    else
    begin
      Dec(Idx);
      if Idx < 0 then
        Result := False
      else
      begin
        Cell := Cells[Idx];
        Result := richPos < (Cell.RichPos + Cell.RichLength);
      end;
    end;
  end;
end;

function TEditData.TAllCells.GetCells(idx: Integer): TCell;
begin
  Result := Items[idx].Cell;
end;

function TEditData.TAllCells.GetCols(idx: Integer): Integer;
begin
  Result := Items[idx].Col;
end;

function TEditData.TAllCells.GetRows(idx: Integer): Integer;
begin
  Result := Items[idx].Row;
end;

{ TEditData }

procedure TEditData.AddCell(activeIndex: Integer; const value: Variant; sequenceItem: TFieldedText.TSequence.TItem; filePos: Int64;
  textLength: Integer);
var
  Cell: TCell;
  CellRow: TRow;
  LineIdx: Integer;
  LinePos: Integer;
  RichPos: Integer;
  SubsequentFilePos: Int64;
  SubsequentRichPos: Integer;
  RichLength: Integer;
  ColIdx: Integer;
  RowIdx: Integer;
begin
  RowIdx := LastRowIdx;
  CellRow := LastRow;
  SubsequentFilePos := filePos + textLength;
  SubsequentRichPos := FLines[FLastLineIdx].RichPos + (SubsequentFilePos - FLines[FLastLineIdx].FilePos);

  LineIdx := FLastLineIdx;
  repeat
    LinePos := filePos - FLines[LineIdx].FilePos;
    if LinePos < 0 then
    begin
      Dec(LineIdx);
    end;
  until LinePos >= 0;
  RichPos := FLines[LineIdx].RichPos + LinePos;
  RichLength := SubsequentRichPos - RichPos;
  Cell := TCell.Create(activeIndex, value, sequenceItem,
                       filePos, RichPos, LineIdx, LinePos,
                       textLength, RichLength, CellRow, FDisplayCulture);
  ColIdx := CellRow.Cells.Add(Cell);
  if ColIdx >= FMaxCellsInRowCount then
  begin
    FMaxCellsInRowCount := ColIdx + 1;
  end;

  FAllCells.Add(Cell, ColIdx, RowIdx);
end;

function TEditData.AddHeading(main: Boolean): Integer;
begin
  Result := AddRow(True, FHeadingCount, -1);
  Inc(FHeadingCount);
  if main then
  begin
    FMainHeadingRow := FRows[Result];
  end;
end;

function TEditData.AddRecord(recNr, tableNr: Integer): Integer;
begin
  Result := AddRow(False, recNr, tableNr);
  Inc(FRecordCount);
end;

function TEditData.AddRow(heading: Boolean;
                          number: Integer;
                          tableNr: Integer): Integer;
var
  Row: TRow;
begin
  Row := TRow.Create(heading, number, FLineCount-1, tableNr);
  Result := FRows.Add(Row);
end;

function TEditData.CanSelectCell(ACol, ARow: Integer): Boolean;
begin
  Result := (ARow < FRows.Count) and (ACol < FRows[ARow].Cells.Count);
end;

function TEditData.CheckGetRow(aRow: Integer): TRow;
begin
  Result := FRows.CheckGetRow(aRow);
end;

constructor TEditData.Create(myDisplayCulture: TFieldedTextLocaleSettings);
begin
  inherited Create;

  FText := '';

  FRows := TRows.Create;
  FAllCells := TAllCells.Create;

  ResetParsing(myDisplayCulture);
end;

procedure TEditData.FindCellAtRichPos(pos: Integer; out aCell: TCell;
                                      out aCol, aRow: Integer);
var
  Idx: Integer;
begin
  if not FAllCells.Find(pos, Idx) then
  begin
    aCell := nil;
    aCol := -1;
  end
  else
  begin
    aCell := FAllCells.Cells[Idx];
    aCol := FAllCells.Cols[Idx];
    aRow := FAllCells.Rows[Idx];
  end;
end;

procedure TEditData.FinishLine(const filePos: Int64);
begin
  FLines[FLastLineIdx].Length := filePos - FLines[FLastLineIdx].FilePos;
end;

function TEditData.GetCells(aCol, aRow: Integer): TCell;
begin
  if (aRow < 0) or (aRow >= FRows.Count) then
    Result := nil
  else
  begin
    if (aCol < 0) or (aCol >= FRows[aRow].Cells.Count) then
      Result := nil
    else
      Result := FRows[aRow].Cells[aCol];
  end;
end;

function TEditData.GetCellsInRowCount(aRow: Integer): Integer;
begin
  Result := FRows[aRow].Cells.Count;
end;

function TEditData.GetCharCount: Int64;
begin
  Result := Length(FText);
end;

function TEditData.GetHeading(aCol: Integer): string;
begin
  if not Assigned(FMainHeadingRow) then
    Result := ''
  else
  begin
    if aCol >= FMainHeadingRow.Cells.Count then
      Result := ''
    else
      Result := FMainHeadingRow.Cells[aCol].ValueAsString;
  end;
end;

function TEditData.GetLastRow: TRow;
begin
  if RowCount > 0 then
    Result := FRows[RowCount-1]
  else
    Result := nil;
end;

function TEditData.GetLastRowIdx: Integer;
begin
  Result := RowCount - 1;
end;

function TEditData.GetRowCount: Integer;
begin
  Result := FRows.Count;
end;

function TEditData.GetRows(aRow: Integer): TRow;
begin
  Result := FRows[aRow];
end;

procedure TEditData.GrowLines;
begin
  if FLineCount < 100 then
    SetLength(FLines, 100)
  else
  begin
    if FLineCount < 1000 then
      SetLength(FLines, 1000)
    else
    begin
      if FLineCount < 5000 then
        SetLength(FLines, 5000)
      else
        SetLength(FLines, Length(FLines) + 10000);
    end;
  end;
end;

procedure TEditData.Reset;
begin
  FText := '';
  ResetParsing(TFieldedTextLocaleSettings.Invariant);
end;

procedure TEditData.ResetParsing(myDisplayCulture: TFieldedTextLocaleSettings);
begin
  FRows.Clear;
  FAllCells.Clear;
  FHeadingCount := 0;
  FRecordCount := 0;
  FMaxCellsInRowCount := 0;
  FLines := nil;
  FLineCount := 0;
  FLastLineIdx := -1;
  FMainHeadingRow := nil;
end;

procedure TEditData.Resolve;
var
  I: Integer;
begin
  SetLength(FLines, FLineCount);

  for I := 0 to FAllCells.Count - 1 do
  begin
    FAllCells[I].Resolve;
  end;
  for I := 0 to FRows.Count - 1 do
  begin
    FRows[I].Resolve;
  end;
end;

procedure TEditData.SetError(activeIndex: Integer);
var
  TempLastRow: TRow;
  LastCell: TCell;
begin
  TempLastRow := LastRow;

  if Assigned(TempLastRow) then
  begin
    LastRow.Error := True;
    LastCell := LastRow.LastCell;
    if Assigned(LastCell) and (LastCell.ActiveIndex = activeIndex) then
    begin
      LastCell.Error := True;
    end;
  end;
end;

procedure TEditData.SetLastRecordAsNewTable;
begin
  LastRow.NewTable := True;
end;

procedure TEditData.StartLine(const filePos: Int64);
begin
  if Length(FLines) <= FLineCount then
  begin
    GrowLines;
  end;

  FLastLineIdx := FLineCount;
  Inc(FLineCount);
  FLines[FLastLineIdx].FilePos := filePos;
  if FLastLineIdx = 0 then
    FLines[FLastLineIdx].RichPos := 0
  else
    FLines[FLastLineIdx].RichPos := FLines[FLastLineIdx-1].RichPos + FLines[FLastLineIdx-1].Length + 1;
end;

{ TEditData.TRows }

function TEditData.TRows.CheckGetRow(idx: Integer): TRow;
begin
  if (idx < 0) or (idx >= Count) then
    Result := nil
  else
    Result := Rows[idx];
end;

function TEditData.TRows.GetLastRow: TRow;
begin
  Result := Rows[Count-1];
end;

function TEditData.TRows.GetRows(idx: Integer): TRow;
begin
  Result := TRow(Items[idx]);
end;

{ TCellCollection }

{function TCellCollection.GetCells(idx: Integer): TCell;
begin
  Result := TCell(Items[idx]);
end;

function TCellCollection.GetLast: TCell;
begin
  if Count = 0 then
    Result := nil
  else
    Result := Cells[Count-1];
end;}

{ TRow }

constructor TRow.Create(myheading: Boolean;
                        myNumber: Integer;
                        myLineNumber: Integer;
                        myTableNr: Integer);
begin
  inherited Create;
  FCells := TCellCollection.Create;
  FHeading := myHeading;
  FNumber := myNumber;
  FLineNumber := myLineNumber;
  FTableNr := myTableNr;
end;

function TRow.GetLastCell: TCell;
begin
  Result := FCells.Last;
end;

procedure TRow.Resolve;
begin
  if FHeading then
  begin
    if Error then
      FResolvedColorId := rcGridHeadingRowError
    else
      FResolvedColorId := rcGridHeadingRow
  end
  else
  begin
    if NewTable then
    begin
      if Error then
        FResolvedColorId := rcGridNewTableRecordRowError
      else
      begin
        if Number mod 2 = 0 then
          FResolvedColorId := rcGridNewTableRecordRow
        else
          FResolvedColorId := rcGridNewTableRecordRowAlt;
      end;
    end
    else
    begin
      if FError then
        FResolvedColorId := rcGridRecordRowError
      else
      begin
        if Number mod 2 = 0 then
          FResolvedColorId := rcGridRecordRow
        else
          FResolvedColorId := rcGridRecordRowAlt;
      end;
    end;
  end;
end;

procedure TRow.SetNewTable(const Value: Boolean);
begin
  if Value and not FNewTable then
  begin
    Inc(FTableNr);
  end;

  FNewTable := Value;
end;

{ TEditData.TLineRec }

{function TEditData.TLineRec.CompareTo(obj: TObject): Integer;
begin
  Result := RichPos.CompareTo(obj)
end;}

{ TEditData.TAllCellsRec }

function TEditData.TAllCellsEntry.GetRichPos: Integer;
begin
  Result := Cell.RichPos;
end;

{ TSearchCell }

procedure TSearchCell.SetRichPos(Value: Integer);
begin
  FRichPos := Value;
end;

{ TEditData.TAllCellsEntryComparer }

function TEditData.TAllCellsEntryComparer.Compare(const Left,
  Right: TAllCellsEntry): Integer;
begin
  Result := CompareValue(Left.Cell.RichPos, Right.Cell.RichPos);
end;

end.
