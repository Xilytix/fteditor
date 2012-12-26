// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.CommandLineParser;

interface

type
  TCommandLineParser = class
  strict private
    FTextFilePath: string;
    FMetaFilePath: string;
    FErrorDescription: string;

//    procedure ProcessSwitchParam(param: string);
    procedure SetTextFilePath(value: string);
    procedure SetMetaFilePath(value: string);
  public
    procedure Parse;

    property TextFilePath: string read FTextFilePath;
    property MetaFilePath: string read FMetaFilePath;

    property ErrorDescription: string read FErrorDescription;
  end;

implementation

uses
  SysUtils,
  IOUtils,
  Dialogs,
  Xilytix.FTEditor.Common;

{ TParamStrParser }

procedure TCommandLineParser.Parse;
type
  TParseState = (psNotInParam, psOptionQuote, psFilePathStartQuote, psUnquotedFilePath);
var
//  I: Integer;
  ParamLine: string;
//  State: TParseState;
  Extension: string;
begin
  if ParamCount > 0 then
  begin
    ParamLine := Copy(CmdLine, Length(ParamStr(0)) + 3, MaxInt);
    if Length(ParamLine) > 0 then
    begin
      if (Length(ParamLine) > 1) and (ParamLine[1] = '"') and (ParamLine[Length(ParamLine)] = '"') then
      begin
        ParamLine := Copy(ParamLine, 2, Length(ParamLine)-2);
      end;
    end;

    try
      Extension := TPath.GetExtension(ParamLine);
      if Length(Extension) > 0 then
      begin
        if Extension[1] = '.' then
        begin
          if Length(Extension) = 1 then
            Extension := ''
          else
            Extension := Copy(Extension, 2, MaxInt);
        end;

        if SameText(Extension, TCommon.MetaFileNameExtension) then
          SetMetaFilePath(ParamLine)
        else
          SetTextFilePath(ParamLine);
      end;
    except
      on Exception do ;
    end;

{    State := psNotInParam;
    for I := 1 to Length(ParamLine) do
    begin
      case State of
        psNotInParam:
        begin
          if System.Char.IsWhiteSpace(ParamLine[I]) then
          begin
            case ParamLine[I] of
              ':': State := psOptionQuote;
              '"': State := psFilePathStartQuote;
              else State := psUnquotedFilePath;
            end;
          end;
        end;
        psOptionQuote:
        begin
        end;
      end;
    end;}
  end;
{  Param := CmdLine;
  for I := 1 to ParamCount do
  begin
    Param := ParamStr(I);
    if Param <> '' then
    begin
      if Param[1] = '-' then
        ProcessSwitchParam(Param)
      else
      begin
        Extension := Path.GetExtension(Param);
        if Assigned(Extension) and (Extension.ToUpper = TCommon.MetaFileNameExtension.ToUpper) then
          SetMetaFilePath(Param)
        else
          SetTextFilePath(Param);
      end;
    end;

    if FErrorDescription <> '' then
    begin
      Break;
    end;
  end;}
end;

{procedure TCommandLineParser.ProcessSwitchParam(param: string);
begin
  if Length(param) <= 1 then
    FErrorDescription := 'Invalid Switch: ' + param
  else
  begin
    case param[2] of
      'M', 'm':
      begin
        if Length(param) <= 2 then
          FErrorDescription := 'Meta File Switch (-M) does not specify a file name/path'
        else
          SetMetaFilePath(param.Substring(2));
      end;
      'T', 't':
      begin
        if Length(param) <= 2 then
          FErrorDescription := 'Text File Switch (-T) does not specify a file name/path'
        else
          SetTextFilePath(param.Substring(2));
      end;
      else FErrorDescription := 'Unsupported Switch: ' + param
    end;
  end;
end;}

procedure TCommandLineParser.SetMetaFilePath(value: string);
begin
  if MetaFilePath <> '' then
    FErrorDescription := 'Can only specify one meta file'
  else
    FMetaFilePath := value;
end;

procedure TCommandLineParser.SetTextFilePath(value: string);
begin
  if TextFilePath <> '' then
    FErrorDescription := 'Can only specify one text file'
  else
    FTextFilePath := value;
end;

end.
