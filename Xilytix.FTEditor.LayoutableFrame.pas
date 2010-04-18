// Project: FTEditor (Fielded Text Editor)
// Licence (this file): Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in

unit Xilytix.FTEditor.LayoutableFrame;

interface

uses
  System.Xml,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TLayoutableFrame = class(TFrame)
  public
    type
      TTypeId = (ftNone, ftTextView, ftGridView, ftErrors,
                         ftMainProperties, ftFields, ftSequences);
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

    procedure LoadFromXml(config: XmlElement); virtual;
    procedure SaveToXml(config: XmlElement); virtual;

    property NamePrefix: string read FNamePrefix write FNamePrefix;
    property TypeInstance: Integer read FTypeInstance write SetTypeInstance;
    property InstanceCaption: string read FInstanceCaption;

    function CalculateName(aTypeInstance: Integer): string;

    property ImplicitHeight: Integer read GetInitialHeight;
    property ImplicitWidth: Integer read GetInitialWidth;

    class function GetTypeId: TTypeId; virtual;
    class function GetTypeName: string; virtual;
    class function GetTypeCaption: string; virtual;
  end;

  TLayoutableFrameClass = class of TLayoutableFrame;
  TLayoutableFrameArray = array of TLayoutableFrame;

implementation

{$R *.nfm}

{ TLayoutableFrame }

function TLayoutableFrame.CalculateName(aTypeInstance: Integer): string;
begin
  if aTypeInstance = 1 then
    Result := NamePrefix + GetTypeName
  else
    Result := NamePrefix + GetTypeName + aTypeInstance.ToString;
end;

constructor TLayoutableFrame.Create(AOwner: TComponent);
begin
  inherited;
  FTypeInstance := 1;
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

procedure TLayoutableFrame.LoadFromXml(config: XmlElement);
begin
  ;
end;

procedure TLayoutableFrame.SaveToXml(config: XmlElement);
begin
  ;
end;

procedure TLayoutableFrame.SetNameAndInstanceCaption;
begin
  Name := CalculateName(FTypeInstance);

  if TypeInstance = 1 then
    FInstanceCaption := GetTypeCaption
  else
    FInstanceCaption := GetTypeCaption + ' ' + TypeInstance.ToString;
end;

procedure TLayoutableFrame.SetTypeInstance(const Value: Integer);
begin
  FTypeInstance := Value;
  SetNameAndInstanceCaption;
end;

end.
