// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.Common;

interface

uses
  Messages,
  Xilytix.FieldedText.DotNet,
  Xilytix.FieldedText.Utils;

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
      FLayoutConfigurationsFolder: string;

    class constructor Create;

    class function ByteToHex(const Value: Byte): string;
    class function IntToHexChar(const Value: Integer): Char;
    class function IsInvalidFileNameChar(value: Char): Boolean;
    class function ExtractEscapedFileNameChar(const fileName: string;
                                              fileNameLength: Integer;
                                              var idx: Integer;
                                              out escapedChar: Char): Boolean;
  public
    const
      PublisherName = 'Xilytix';
      ProgramName  = 'FTEditor';
      FieldedTextFileNameExtension = 'ftx';
      MetaFileNameExtension = 'ftm';
      ColorSchemaSubFolder = 'ColorSchema';
      LayoutConfigurationsSubFolder = 'LayoutConfigurations';
      SafeFileNameEscapeChar = '$';
      InvalidFileNameChars: array[0..7] of Char = ('/', '\', ':', '*', '?', '<', '>', '|');
      ExplicitInvalidFileNameChars: array[0..8] of Char = ('/', '\', ':', '*', '?', '<', '>', '|', SafeFileNameEscapeChar);

    class property ProgramFileName: string read FProgramFileName;
    class property ProgramFilePath: string read FProgramFilePath;
    class property ProgramFileFolder: string read FProgramFileFolder;
    class property ApplicationDataFolder: string read FApplicationDataFolder;
    class property VersionString: string read FVersionString;
    class property ColorSchemaFolder: string read FColorSchemaFolder;
    class property LayoutConfigurationsFolder: string read FLayoutConfigurationsFolder;

    class procedure EnsureColorSchemaFolderExists;
    class procedure EnsureLayoutConfigurationsFolderExists;

    class function SafeFileNameEncode(const value: string): string;
    class function TrySafeFileNameDecode(const fileName: string; out decodedValue: string): Boolean;

    class function DotNetNumberStylesToInteger(const Value: TDotNetNumberStyle.TIds): Integer;
    class function IntegerToDotNetNumberStyles(Value: Integer): TDotNetNumberStyle.TIds;
    class function DotNetDateTimeStylesToInteger(const Value: TDotNetDateTimeStyle.TIds): Integer;
    class function IntegerToDotNetDateTimeStyles(Value: Integer): TDotNetDateTimeStyle.TIds;
  end;

  TNonRefCountedInterfacedObject = class(TObject, IInterface)
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  end;

implementation

uses
  Windows,
  SysUtils,
  IOUtils,
  Character,
  Forms,
  SHFolder,
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

  if not Succeeded(SHGetFolderPath(0, CSIDL_APPDATA, 0, SHGFP_TYPE_CURRENT, Path)) then
    raise Exception.Create('Could not obtain Application Data Folder')
  else
  begin
    PathAsString := Path;
    FApplicationDataFolder := TPath.Combine(PathAsString, PublisherName);
    FApplicationDataFolder := TPath.Combine(FApplicationDataFolder, ProgramName);
  end;

  VersionInfo := TPJVersionInfo.Create(nil);
  try
    FVersionString := VersionInfo.FileVersion;
  finally
    VersionInfo.Free;
  end;

  FColorSchemaFolder := TPath.Combine(FApplicationDataFolder, ColorSchemaSubFolder);
  FLayoutConfigurationsFolder := TPath.Combine(FApplicationDataFolder, LayoutConfigurationsSubFolder);
end;

class function TCommon.DotNetDateTimeStylesToInteger(
  const Value: TDotNetDateTimeStyle.TIds): Integer;
begin
  Result := Int8(Value);
end;

class function TCommon.DotNetNumberStylesToInteger(
  const Value: TDotNetNumberStyle.TIds): Integer;
begin
  Result := Int16(Value);
end;

class procedure TCommon.EnsureColorSchemaFolderExists;
begin
  if not DirectoryExists(FColorSchemaFolder) then
  begin
    ForceDirectories(FColorSchemaFolder);
  end;
end;

class procedure TCommon.EnsureLayoutConfigurationsFolderExists;
begin
  if not DirectoryExists(FLayoutConfigurationsFolder) then
  begin
    ForceDirectories(FLayoutConfigurationsFolder);
  end;
end;

class function TCommon.ExtractEscapedFileNameChar(const fileName: string; fileNameLength: Integer; var idx: Integer;
  out escapedChar: Char): Boolean;
var
  I: Integer;
  EncodedByteCount: Integer;
  HexDigitCount: Integer;
  EncodedBytes: TBytes;
  EncodedByteAsInt: Integer;
  DecodedChars: TCharArray;
  HexIdx: Integer;
begin
  // Char is encoded as UTF-8 BinHex
  // That means it can take up to 8 Characters in the filename (making up 4 bytes)

  Result := False;

  if TFieldedTextLocaleSettings.TryHexCharToInt(FileName[Idx], EncodedByteCount) then
  begin
    Inc(Idx);
    if Idx < FileNameLength then
    begin
      HexDigitCount := EncodedByteCount * 2;

      if (Idx + HexDigitCount - 1) <= fileNameLength then
      begin
        EncodedByteCount := HexDigitCount div 2;

        if EncodedByteCount > 0 then
        begin
          // Convert to Byte Array while Hex Digits
          SetLength(EncodedBytes, EncodedByteCount);
          for I := 0 to EncodedByteCount - 1 do
          begin
            HexIdx := Idx + I * 2;
            if TFieldedTextLocaleSettings.TryHexToInt(Copy(fileName, HexIdx, 2), EncodedByteAsInt) then
              EncodedBytes[I] := Byte(EncodedByteAsInt)
            else
            begin
              EncodedByteCount := I + 1;
              Break;
            end;
          end;

          // Decode Bytes and work out how many were actually used
          DecodedChars := TEncoding.UTF8.GetChars(EncodedBytes, 0, EncodedByteCount);
          if Length(DecodedChars) > 0 then
          begin
            EscapedChar := DecodedChars[0];
            Idx := Idx + HexDigitCount - 1; // Move Idx to last Char
            Result := True;
          end;
        end;
      end;
    end;
  end;
end;

class function TCommon.IntegerToDotNetDateTimeStyles(
  Value: Integer): TDotNetDateTimeStyle.TIds;
var
  ValueAsInt8: Int8;
begin
  ValueAsInt8 := Int8(Value);
  Result := TDotNetDateTimeStyle.TIds(ValueAsInt8);
end;

class function TCommon.IntegerToDotNetNumberStyles(
  Value: Integer): TDotNetNumberStyle.TIds;
var
  ValueAsInt16: Int16;
begin
  ValueAsInt16 := Int16(Value);
  Result := TDotNetNumberStyle.TIds(ValueAsInt16);
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

class function TCommon.TrySafeFileNameDecode(const fileName: string; out decodedValue: string): Boolean;
var
  I: Integer;
  Bldr: TStringBuilder;
  FileNameLength: Integer;
  EscapedChar: Char;
begin
  // Result will be 0 if ok.  Will be > 0 if not ok (and index first bad char)
  FileNameLength := Length(fileName);
  Result := True;
  Bldr := TStringBuilder.Create;
  try
    I := 1;
    while I <= FileNameLength do
    begin
      if fileName[I] <> SafeFileNameEscapeChar then
        Bldr.Append(fileName[I])
      else
      begin
        Inc(I);
        if I >= FileNameLength then
          Break
        else
        begin
          Result := ExtractEscapedFileNameChar(fileName, FileNameLength, I, EscapedChar);
          if not Result then
            Break
          else
            Bldr.Append(EscapedChar);
        end;
      end;

      Inc(I);
    end;

    if Result then
    begin
      decodedValue := Bldr.ToString;
    end;
  finally
    Bldr.Free;
  end;
end;

class function TCommon.SafeFileNameEncode(const value: string): string;
var
  I, J: Integer;
  Bldr: TStringBuilder;
  SingleCharArray: TCharArray;
  CharBytes: TBytes;
  CharBytesLengthStr: string;
  CharHex: string;
begin
  SetLength(SingleCharArray, 1);
  Bldr := TStringBuilder.Create(512);
  try
    for I := 1 to Length(value) do
    begin
      if not IsInvalidFileNameChar(Value[I]) and (Value[I] <> SafeFileNameEscapeChar) then
        Bldr.Append(value[I])
      else
      begin
        SingleCharArray[0] := value[I];
        CharBytes := TEncoding.UTF8.GetBytes(SingleCharArray);
        CharBytesLengthStr := IntToHex(Length(CharBytes), 1);
        Assert(Length(CharBytesLengthStr) = 1);

        Bldr.Append(SafeFileNameEscapeChar);
        Bldr.Append(CharBytesLengthStr[1]);
        for J := Low(CharBytes) to High(CharBytes) do
        begin
          CharHex := ByteToHex(CharBytes[J]);
          Bldr.Append(CharHex);
        end;
      end;
    end;

    Result := Bldr.ToString;
  finally
    Bldr.Free;
  end;
end;

{ TNonRefCountedInterfacedObject }

function TNonRefCountedInterfacedObject.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TNonRefCountedInterfacedObject._AddRef: Integer;
begin
  Result := -1;
end;

function TNonRefCountedInterfacedObject._Release: Integer;
begin
  Result := -1;
end;

end.
