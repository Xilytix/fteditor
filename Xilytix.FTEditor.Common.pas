// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.Common;

interface

uses
  Borland.Vcl.Messages;

type
  TCharArray = array of Char;
  TByteArray = array of Byte;

  TCommon = class
  strict private
    class var
      FProgramFileName: string;
      FProgramFilePath: string;
      FProgramFileFolder: string;
      FApplicationDataFolder: string;
      FVersionString: string;
      FColorSchemaFolder: string;
      FInvalidFileNameChars: TCharArray;

    class constructor Create;

    class function IsHexDigit(value: Char): Boolean;
    class function HexToByte(value: string; idx: Integer): Byte;
    class function IsInvalidFileNameChar(value: Char): Boolean;
    class function ExtractEscapedFileNameChar(fileName: string;
                                              fileNameLength: Integer;
                                              var idx: Integer;
                                              out escapedChar: Char): Integer;
  public
    const
      PublisherName = 'Xilytix';
      ProgramName  = 'FTEditor';
      FieldedTextFileNameExtension = 'ftx';
      MetaFileNameExtension = 'ftm';
      ColorSchemaSubFolder = 'ColorSchema';
      SafeFileNamePrefix = '#';
      SafeFileNameEscapeChar = '$';
      ExplicitInvalidFileNameChars: array[0..8] of char = ('/', '\', ':', '*', '?', '<', '>', '|', SafeFileNameEscapeChar);

    class property ProgramFileName: string read FProgramFileName;
    class property ProgramFilePath: string read FProgramFilePath;
    class property ProgramFileFolder: string read FProgramFileFolder;
    class property ApplicationDataFolder: string read FApplicationDataFolder;
    class property VersionString: string read FVersionString;
    class property ColorSchemaFolder: string read FColorSchemaFolder;

    class procedure EnsureColorSchemaFolderExists;

    class function SafeFileNameEncode(value: string): string;
    class function TrySafeFileNameDecode(fileName: string; out decodedValue: string): Integer;
  end;

implementation

uses
  System.Text,
  System.IO,
  System.Globalization,
  System.Diagnostics,
  Borland.Vcl.Forms;

{ TCommon }

class constructor TCommon.Create;
var
  I: Integer;
  Idx: Integer;
  VersionInfo: FileVersionInfo;
begin
  FProgramFilePath := Application.ExeName;
  FProgramFileName := Path.GetFileName(FProgramFilePath);
  FProgramFileFolder := Path.GetDirectoryName(FProgramFilePath);

  FApplicationDataFolder := System.Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
  FApplicationDataFolder := Path.Combine(FApplicationDataFolder, PublisherName);
  FApplicationDataFolder := Path.Combine(FApplicationDataFolder, ProgramName);

  VersionInfo := FileVersionInfo.GetVersionInfo(FProgramFilePath);
  FVersionString := VersionInfo.FileVersion;

  FColorSchemaFolder := Path.Combine(FApplicationDataFolder, ColorSchemaSubFolder);

  FInvalidFileNameChars := Path.GetInvalidFileNameChars;
  for I := Low(FInvalidFileNameChars) to High(FInvalidFileNameChars) do
  begin
    FInvalidFileNameChars[I] := System.Char.ToUpper(FInvalidFileNameChars[I], CultureInfo.InvariantCulture);
  end;

  for I := Low(ExplicitInvalidFileNameChars) to High(ExplicitInvalidFileNameChars) do
  begin
    if not IsInvalidFileNameChar(ExplicitInvalidFileNameChars[I]) then
    begin
      Idx := Length(FInvalidFileNameChars);
      SetLength(FInvalidFileNameChars, Idx+1);
      FInvalidFileNameChars[Idx] := ExplicitInvalidFileNameChars[I];
    end;
  end;
end;

class procedure TCommon.EnsureColorSchemaFolderExists;
begin
  if not Directory.Exists(FColorSchemaFolder) then
  begin
    Directory.CreateDirectory(FColorSchemaFolder);
  end;
end;

class function TCommon.ExtractEscapedFileNameChar(fileName: string; fileNameLength: Integer; var idx: Integer;
  out escapedChar: Char): Integer;
const
  MaxEncodedByteCount = 4;
var
  I: Integer;
  HexDigitCount: Integer;
  EncodedByteCount: Integer;
  EncodedBytes: array[0..MaxEncodedByteCount-1] of Byte;
  DecodedChars: TCharArray;
  HexIdx: Integer;
begin
  // Char is encoded as UTF-8 BinHex
  // That means it can take up to 8 Characters in the filename (making up 4 bytes)

  HexDigitCount := MaxEncodedByteCount * 2;

  // Make sure we do not go beyond end of filename
  if (Idx + HexDigitCount - 1) > fileNameLength then
  begin
    HexDigitCount := fileNameLength - Idx + 1;
    if (HexDigitCount mod 2) = 1 then
    begin
      Dec(HexDigitCount);
    end;
  end;

  EncodedByteCount := HexDigitCount div 2;

  if EncodedByteCount = 0 then
    Result := idx
  else
  begin
    // Convert to Byte Array while Hex Digits
    for I := 0 to EncodedByteCount - 1 do
    begin
      HexIdx := Idx + I * 2;
      if (IsHexDigit(fileName[HexIdx]) and IsHexDigit(fileName[HexIdx+1])) then
        EncodedBytes[I] := HexToByte(fileName, HexIdx)
      else
      begin
        EncodedByteCount := I + 1;
        Break;
      end;
    end;

    if EncodedByteCount = 0 then
      Result := idx
    else
    begin
      // Decode Bytes and work out how many were actually used
      DecodedChars := Encoding.UTF8.GetChars(EncodedBytes, 0, EncodedByteCount);
      if Length(DecodedChars) = 0 then
        Result := idx
      else
      begin
        EscapedChar := DecodedChars[0];

        if EncodedByteCount > 1 then
        begin
          EncodedByteCount := Encoding.UTF8.GetByteCount(DecodedChars, 0, 1);
        end;
        Idx := Idx + (EncodedByteCount * 2) - 1; // Move Idx to last Char
        Result := 0;
      end;
    end;
  end;
end;

class function TCommon.HexToByte(value: string; idx: Integer): Byte;
begin
  Result := System.Byte.Parse(value.Substring(idx+1, 2), NumberStyles.AllowHexSpecifier, CultureInfo.InvariantCulture);
end;

class function TCommon.IsHexDigit(value: Char): Boolean;
begin
  case value of
    'a'..'f', 'A'..'F', '0'..'9': Result := True;
    else Result := False;
  end;
end;

class function TCommon.IsInvalidFileNameChar(value: Char): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(FInvalidFileNameChars) to High(FInvalidFileNameChars) - 1 do
  begin
    if System.Char.ToUpper(value, CultureInfo.InvariantCulture) = FInvalidFileNameChars[I] then
    begin
      Result := True;
      Break;
    end;
  end;
end;

class function TCommon.TrySafeFileNameDecode(fileName: string; out decodedValue: string): Integer;
var
  I: Integer;
  Bldr: StringBuilder;
  FileNameLength: Integer;
  EscapedChar: Char;
begin
  // Result will be 0 if ok.  Will be > 0 if not ok (and index first bad char)
  FileNameLength := Length(fileName);
  if (fileName = '') or (fileName[1] <> SafeFileNamePrefix) then
    Result := 1
  else
  begin
    Result := 0;
    Bldr := StringBuilder.Create;

    I := 2;
    while I <= FileNameLength do
    begin
      if fileName[I] <> SafeFileNameEscapeChar then
        Bldr.Append(fileName[I])
      else
      begin
        Result := ExtractEscapedFileNameChar(fileName, FileNameLength, I, EscapedChar);
        if Result = 0 then
          Bldr.Append(EscapedChar)
        else
          Break;
      end;

      Inc(I);
    end;

    if Result = 0 then
    begin
      decodedValue := Bldr.ToString;
    end;
  end;
end;

class function TCommon.SafeFileNameEncode(value: string): string;
var
  I, J: Integer;
  Bldr: StringBuilder;
  SingleCharArray: array[0..0] of Char;
  CharBytes: TByteArray;
  CharHex: string;
begin
  Bldr := StringBuilder.Create(512);

  Bldr.Append(SafeFileNamePrefix);
  for I := 1 to Length(value) do
  begin
    if not IsInvalidFileNameChar(Value[I]) then
      Bldr.Append(value[I])
    else
    begin
      SingleCharArray[0] := value[I];
      CharBytes := Encoding.UTF8.GetBytes(SingleCharArray);

      Bldr.Append(SafeFileNameEscapeChar);
      for J := Low(CharBytes) to High(CharBytes) do
      begin
        CharHex := CharBytes[J].ToString('X2', CultureInfo.InvariantCulture);
        Bldr.Append(CharHex);
      end;
    end;
  end;

  Result := Bldr.ToString;
end;

end.
