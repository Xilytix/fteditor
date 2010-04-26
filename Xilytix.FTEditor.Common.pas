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
  Messages;

type
  TCommon = class
  strict private
    class var
      FProgramFileName: string;
      FProgramFilePath: string;
      FProgramFileFolder: string;
      FApplicationDataFolder: string;
      FVersionString: string;
      FColorSchemaFolder: string;

    class constructor Create;

    class function IsHexDigit(value: Char): Boolean;
    class function HexToByte(const value: string; idx: Integer): Byte;
    class function ByteToHex(const Value: Byte): string;
    class function TryHexToInt(const HexStr: string; out HexInt: Integer): Boolean;
    class function TryHexCharToInt(const HexChar: Char; out IntValue: Integer): Boolean; overload;
    class function TryHexCharToInt(const HexChar: AnsiChar; out IntValue: Integer): Boolean; overload;
    class function IntToHexChar(const Value: Integer): Char;
    class function IsInvalidFileNameChar(value: Char): Boolean;
    class function ExtractEscapedFileNameChar(const fileName: string;
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
      InvalidFileNameChars: array[0..7] of Char = ('/', '\', ':', '*', '?', '<', '>', '|');
      ExplicitInvalidFileNameChars: array[0..8] of Char = ('/', '\', ':', '*', '?', '<', '>', '|', SafeFileNameEscapeChar);

    class property ProgramFileName: string read FProgramFileName;
    class property ProgramFilePath: string read FProgramFilePath;
    class property ProgramFileFolder: string read FProgramFileFolder;
    class property ApplicationDataFolder: string read FApplicationDataFolder;
    class property VersionString: string read FVersionString;
    class property ColorSchemaFolder: string read FColorSchemaFolder;

    class procedure EnsureColorSchemaFolderExists;

    class function SafeFileNameEncode(const value: string): string;
    class function TrySafeFileNameDecode(const fileName: string; out decodedValue: string): Integer;
  end;

implementation

uses
  Windows,
  SysUtils,
  Forms,
  SHFolder,
  JclFileUtils,
  PJVersionInfo;

{ TCommon }

class function TCommon.ByteToHex(const Value: Byte): string;
begin
  Result := IntToHexChar(Value div 16) + IntToHexChar(Value mod 16);
end;

class constructor TCommon.Create;
var
  VersionInfo: TPJVersionInfo;
  Path: array[0..MAX_PATH] of Char;
  PathAsString: string;
begin
  FProgramFilePath := Application.ExeName;
  FProgramFileName := ExtractFileName(FProgramFilePath);
  FProgramFileFolder := ExtractFilePath(FProgramFilePath);

  if not Succeeded(SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT, Path)) then
    raise Exception.Create('Could not obtain Application Data Folder')
  else
  begin
    PathAsString := Path;
    FApplicationDataFolder := PathAppend(PathAsString, PublisherName);
    FApplicationDataFolder := PathAppend(FApplicationDataFolder, ProgramName);
  end;

  VersionInfo := TPJVersionInfo.Create(nil);
  try
    FVersionString := VersionInfo.FileVersion;
  finally
    VersionInfo.Free;
  end;

  FColorSchemaFolder := PathAppend(FApplicationDataFolder, ColorSchemaSubFolder);
end;

class procedure TCommon.EnsureColorSchemaFolderExists;
begin
  if not DirectoryExists(FColorSchemaFolder) then
  begin
    ForceDirectories(FColorSchemaFolder);
  end;
end;

class function TCommon.ExtractEscapedFileNameChar(const fileName: string; fileNameLength: Integer; var idx: Integer;
  out escapedChar: Char): Integer;
const
  MaxEncodedByteCount = 4;
var
  I: Integer;
  HexDigitCount: Integer;
  EncodedByteCount: Integer;
  EncodedBytes: TBytes;
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
    SetLength(EncodedBytes, MaxEncodedByteCount);
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
      DecodedChars := TEncoding.UTF8.GetChars(EncodedBytes, 0, EncodedByteCount);
      if Length(DecodedChars) = 0 then
        Result := idx
      else
      begin
        EscapedChar := DecodedChars[0];

        if EncodedByteCount > 1 then
        begin
          EncodedByteCount := TEncoding.UTF8.GetByteCount(DecodedChars, 0, 1);
        end;
        Idx := Idx + (EncodedByteCount * 2) - 1; // Move Idx to last Char
        Result := 0;
      end;
    end;
  end;
end;

class function TCommon.HexToByte(const value: string; idx: Integer): Byte;
var
  ResultAsInt: Integer;
begin
  if not TryHexToInt(Copy(Value, idx, 2), ResultAsInt) then
    raise EConvertError.Create('Invalid Byte Hex in string: "' + Value + '" at position: ' + IntToStr(Idx))
  else
    Result := Byte(ResultAsInt);
end;

class function TCommon.TryHexCharToInt(const HexChar: Char; out IntValue: Integer): Boolean;
begin
  Result := TryHexCharToInt(AnsiChar(HexChar), IntValue);
end;

class function TCommon.TryHexCharToInt(const HexChar: AnsiChar; out IntValue: Integer): Boolean;
begin
  case HexChar of
    'A'..'F':
    begin
      IntValue := Ord(HexChar) - Ord('A') + 10;
      Result := True;
    end;
    'a'..'f':
    begin
      IntValue := Ord(HexChar) - Ord('a') + 10;
      Result := True;
    end;
    '0'..'9':
    begin
      IntValue := Ord(HexChar) - Ord('0');
      Result := True;
    end;
    else Result := False;
  end;
end;

class function TCommon.TryHexToInt(const HexStr: string; out HexInt: Integer): Boolean;
var
  I: Integer;
  LengthStr: Integer;
  Multiplier: Integer;
  HexDigit: Integer;
  AnsiHexStr: AnsiString;
begin
  HexInt := 0;

  AnsiHexStr := AnsiString(HexStr);
  LengthStr := Length(AnsiHexStr);
  if LengthStr > 7 then
    Result := False
  else
  begin
    Result := True;
    Multiplier := 1;
    HexDigit := 0; // avoid compiler warning
    for I := LengthStr downto 1 do
    begin
      if not TryHexCharToInt(AnsiHexStr[I], HexDigit) then
      begin
        Result := False;
        Break;
      end
      else
      begin
        HexInt := HexInt + HexDigit * Multiplier;
        Multiplier := Multiplier * 16;
      end;
    end;
  end;
end;

class function TCommon.IntToHexChar(const Value: Integer): Char;
type
  THexCharArray = array[0..15] of Char;
const
  HexCharArray: THexCharArray = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
begin
  Assert((Value >= 0) and (Value <= 15));
  Result := HexCharArray[Value];
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
  for I := Low(InvalidFileNameChars) to High(InvalidFileNameChars) - 1 do
  begin
    if Uppercase(value) = InvalidFileNameChars[I] then
    begin
      Result := True;
      Break;
    end;
  end;
end;

class function TCommon.TrySafeFileNameDecode(const fileName: string; out decodedValue: string): Integer;
var
  I: Integer;
  Bldr: TStringBuilder;
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
    Bldr := TStringBuilder.Create;

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

class function TCommon.SafeFileNameEncode(const value: string): string;
var
  I, J: Integer;
  Bldr: TStringBuilder;
  SingleCharArray: TCharArray;
  CharBytes: TBytes;
  CharHex: string;
begin
  SetLength(SingleCharArray, 1);
  Bldr := TStringBuilder.Create(512);

  Bldr.Append(SafeFileNamePrefix);
  for I := 1 to Length(value) do
  begin
    if not IsInvalidFileNameChar(Value[I]) then
      Bldr.Append(value[I])
    else
    begin
      SingleCharArray[0] := value[I];
      CharBytes := TEncoding.UTF8.GetBytes(SingleCharArray);

      Bldr.Append(SafeFileNameEscapeChar);
      for J := Low(CharBytes) to High(CharBytes) do
      begin
        CharHex := ByteToHex(CharBytes[J]);
        Bldr.Append(CharHex);
      end;
    end;
  end;

  Result := Bldr.ToString;
end;

end.
