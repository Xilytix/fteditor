// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.FieldHeadingsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids;

type
  TFieldHeadingsForm = class(TForm)
    BottomPanel: TPanel;
    Grid: TStringGrid;
    OkButton: TButton;
    CancelButton: TButton;
    ClearButton: TButton;
    procedure OkButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
  private
    { Private declarations }
    FOk: Boolean;
    function GetCommaText: string;
    procedure SetCommaText(const Value: string);
    function GetHeadingLineCount: Integer;
    procedure SetHeadingLineCount(const Value: Integer);
  public
    { Public declarations }
    property HeadingLineCount: Integer read GetHeadingLineCount write SetHeadingLineCount;
    property CommaText: string read GetCommaText write SetCommaText;
    property Ok: Boolean read FOk;
  end;

implementation

{$R *.dfm}

uses
  Types,
  Xilytix.FieldedText.CommaText;

procedure TFieldHeadingsForm.ClearButtonClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 1 to Grid.RowCount - 1 do
  begin
    Grid.Cells[1, I] := '';
  end;
end;

procedure TFieldHeadingsForm.FormCreate(Sender: TObject);
begin
  Grid.Cells[0, 0] := 'Index';
  Grid.Cells[1, 0] := 'Heading';

  Grid.ColWidths[0] := 35;
end;

procedure TFieldHeadingsForm.FormResize(Sender: TObject);
var
  HeadingColWidth: Integer;
begin
  HeadingColWidth := Grid.Width - Grid.ColWidths[0] - 2;
  if HeadingColWidth < 0 then
  begin
    HeadingColWidth := 0;
  end;
  Grid.ColWidths[1] := HeadingColWidth;
end;

function TFieldHeadingsForm.GetCommaText: string;
var
  Strings: TStringDynArray;
  I: Integer;
begin
  SetLength(Strings, Grid.RowCount-1);
  for I := 0 to Grid.RowCount - 2 do
  begin
    Strings[I] := Grid.Cells[1, I+1];
  end;
  Result := TCommaText.From(Strings);
end;

function TFieldHeadingsForm.GetHeadingLineCount: Integer;
begin
  Result := Grid.RowCount - 1;
end;

procedure TFieldHeadingsForm.OkButtonClick(Sender: TObject);
begin
  FOk := True;
end;

procedure TFieldHeadingsForm.SetCommaText(const Value: string);
var
  Strings: TStringDynArray;
  I: Integer;
begin
  Strings := TCommaText.ToStringArray(Value);
  for I := 0 to Grid.RowCount - 2 do
  begin
    if I < Length(Strings) then
      Grid.Cells[1, I+1] := Strings[I]
    else
      Grid.Cells[1, I+1] := '';
  end;
end;

procedure TFieldHeadingsForm.SetHeadingLineCount(const Value: Integer);
var
  I: Integer;
begin
  Grid.RowCount := Value + 1;
  for I := 0 to Value - 1 do
  begin
    Grid.Cells[0, I+1] := IntToStr(I);
  end;
end;

end.
