// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.AboutForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  Xilytix.FieldedText.Main;

type
  TAboutForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    VersionLabel: TLabel;
    Label3: TLabel;
    FieldedTextLinkLabel: TLabel;
    Bevel1: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    XilytixLinkLabel: TLabel;
    Button1: TButton;
    XilytixFTEditorLinkLabel: TLabel;
    FieldedTextVersionLabel: TLabel;
    procedure FieldedTextLinkLabelClick(Sender: TObject);
    procedure XilytixFTEditorLinkLabelClick(Sender: TObject);
    procedure XilytixLinkLabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

uses
  UrlMon,
  Xilytix.FTEditor.Common;

procedure TAboutForm.FieldedTextLinkLabelClick(Sender: TObject);
begin
  HLinkNavigateString(nil, 'http://www.fieldedtext.org');
end;

procedure TAboutForm.FormCreate(Sender: TObject);
var
  FieldedTextVersion: string;
begin
  VersionLabel.Caption := 'Version: ' + TCommon.VersionString;
  FieldedTextVersion := IntToStr(TFieldedText.MyVersionMajor) + TFieldedText.VersionSeparator + IntToStr(TFieldedText.MyVersionMinor);
  FieldedTextVersionLabel.Caption := 'Fielded Text Version: ' + FieldedTextVersion;
end;

procedure TAboutForm.XilytixFTEditorLinkLabelClick(Sender: TObject);
begin
  HLinkNavigateString(nil, 'http://www.xilytix.com/fieldedtext/editor');
end;

procedure TAboutForm.XilytixLinkLabelClick(Sender: TObject);
begin
  HLinkNavigateString(nil, 'http://www.xilytix.com');
end;

end.
