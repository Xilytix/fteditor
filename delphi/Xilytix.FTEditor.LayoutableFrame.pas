// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.LayoutableFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,
  Xilytix.FTEditor.TypedXml;

type
  TLayoutableFrame = class(TFrame)
  public
    type
      TTypeId = (ftNone, ftTextView, ftGridView, ftErrors,
                         ftMainProperties, ftFields, ftSequences);
  private
    type
      TTypeInfo = record
        Id: TTypeId;
        XmlValue: string;
      end;
      TTypeInfos = array[TTypeId] of TTypeInfo;

    const
      TypeInfos: TTypeInfos =
      (
        (Id: ftNone; XmlValue: 'None'),
        (Id: ftTextView; XmlValue: 'TextView'),
        (Id: ftGridView; XmlValue: 'GridView'),
        (Id: ftErrors; XmlValue: 'Errors'),
        (Id: ftMainProperties; XmlValue: 'MainProperties'),
        (Id: ftFields; XmlValue: 'Fields'),
        (Id: ftSequences; XmlValue: 'Sequences')
      );

    class constructor Create;

  protected
    var
      FNamePrefix: string;
      FTypeInstance: Integer;
      FInstanceCaption: string;

    function GetInitialHeight: Integer; virtual; abstract;
    function GetInitialWidth: Integer; virtual; abstract;

    procedure SetNameAndInstanceCaption;

    procedure SetTypeInstance(const Value: Integer);

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    procedure LoadFromXml(Element: ITypedXmlElement); virtual;
    procedure SaveToXml(Element: ITypedXmlElement); virtual;

    property NamePrefix: string read FNamePrefix write FNamePrefix;
    property TypeInstance: Integer read FTypeInstance write SetTypeInstance;
    property InstanceCaption: string read FInstanceCaption;

    function CalculateName(aTypeInstance: Integer): string;

    property ImplicitHeight: Integer read GetInitialHeight;
    property ImplicitWidth: Integer read GetInitialWidth;

    class function GetTypeId: TTypeId; virtual;
    class function GetTypeName: string; virtual;
    class function GetTypeCaption: string; virtual;

    class function TypeIdToXmlValue(Value: TTypeId): string;
    class function TryXmlValueToTypeId(const XmlValue: string; out TypeId: TTypeId): Boolean;
  end;

  TLayoutableFrameClass = class of TLayoutableFrame;
  TLayoutableFrameArray = array of TLayoutableFrame;

implementation

{$R *.dfm}

{ TLayoutableFrame }

function TLayoutableFrame.CalculateName(aTypeInstance: Integer): string;
begin
  if aTypeInstance = 1 then
    Result := NamePrefix + GetTypeName
  else
    Result := NamePrefix + GetTypeName + IntToStr(aTypeInstance);
end;

constructor TLayoutableFrame.Create(AOwner: TComponent);
begin
  inherited;
  FTypeInstance := 1;
end;

class constructor TLayoutableFrame.Create;
var
  Id: TTypeId;
begin
  for Id := Low(TTypeId) to High(TTypeId) do
  begin
    if TypeInfos[Id].Id <> Id then
    begin
      raise Exception.Create('TypeIdInfos out of order');
    end;
  end;
end;

class function TLayoutableFrame.GetTypeCaption: string;
begin
  Result := '';
end;

class function TLayoutableFrame.GetTypeId: TTypeId;
begin
  Result := ftNone;
end;

class function TLayoutableFrame.GetTypeName: string;
begin
  Result := '';
end;

procedure TLayoutableFrame.LoadFromXml(Element: ITypedXmlElement);
begin
  // no code
end;

procedure TLayoutableFrame.SaveToXml(Element: ITypedXmlElement);
begin
  // no code
end;

procedure TLayoutableFrame.SetNameAndInstanceCaption;
begin
  Name := CalculateName(FTypeInstance);

  if TypeInstance = 1 then
    FInstanceCaption := GetTypeCaption
  else
    FInstanceCaption := GetTypeCaption + ' ' + IntToStr(TypeInstance);
end;

procedure TLayoutableFrame.SetTypeInstance(const Value: Integer);
begin
  FTypeInstance := Value;
  SetNameAndInstanceCaption;
end;

class function TLayoutableFrame.TryXmlValueToTypeId(const XmlValue: string;
  out TypeId: TTypeId): Boolean;
var
  Id: TTypeId;
begin
  Result := False;
  for Id := Low(TypeInfos) to High(TypeInfos) do
  begin
    if SameText(XmlValue, TypeInfos[Id].XmlValue) then
    begin
      TypeId := Id;
      Result := True;
      Break;
    end;
  end;
end;

class function TLayoutableFrame.TypeIdToXmlValue(Value: TTypeId): string;
begin
  Result := TypeInfos[Value].XmlValue;
end;

end.
