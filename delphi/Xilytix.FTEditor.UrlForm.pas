// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

unit Xilytix.FTEditor.UrlForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, StdCtrls;

type
  TUrlForm = class(TForm)
    Label1: TLabel;
    UrlEdit: TEdit;
    OkButton: TButton;
    CancelButton: TButton;
    ActionList: TActionList;
    OkAction: TAction;
    procedure OkActionUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OkActionExecute(Sender: TObject);
  private
    FInitialText: string;
    { Private declarations }
  public
    function GetUrl: string;
    { Public declarations }
    property Url: string read GetUrl; 
  end;

var
  UrlForm: TUrlForm;

implementation

{$R *.dfm}

procedure TUrlForm.FormCreate(Sender: TObject);
begin
  FInitialText := UrlEdit.Text;
end;

function TUrlForm.GetUrl: string;
begin
  Result := UrlEdit.Text;
end;

procedure TUrlForm.OkActionExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TUrlForm.OkActionUpdate(Sender: TObject);
var
  Text: string;
begin
  Text := UrlEdit.Text;
  OkAction.Enabled := (Text <> '') and (Text <> FInitialText);
end;

end.
