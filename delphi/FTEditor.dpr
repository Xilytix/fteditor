// Project: FTEditor (Fielded Text Editor)
// Licence: Public Domain
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)

program FTEditor;

uses
  Forms,
  Xilytix.FTEditor.MainForm in 'Xilytix.FTEditor.MainForm.pas' {MainForm},
  Xilytix.FTEditor.TextViewFrame in 'Xilytix.FTEditor.TextViewFrame.pas' {TextViewFrame: TFrame},
  Xilytix.FTEditor.GridViewFrame in 'Xilytix.FTEditor.GridViewFrame.pas' {GridViewFrame: TFrame},
  Xilytix.FTEditor.SequenceTreeFrame in 'Xilytix.FTEditor.SequenceTreeFrame.pas' {SequenceTreeFrame: TFrame},
  Xilytix.FTEditor.SequenceListFrame in 'Xilytix.FTEditor.SequenceListFrame.pas' {SequenceListFrame: TFrame},
  Xilytix.FTEditor.MainPropertiesFrame in 'Xilytix.FTEditor.MainPropertiesFrame.pas' {MainPropertiesFrame: TFrame},
  Xilytix.FTEditor.FieldsFrame in 'Xilytix.FTEditor.FieldsFrame.pas' {FieldsFrame: TFrame},
  Xilytix.FTEditor.ErrorsFrame in 'Xilytix.FTEditor.ErrorsFrame.pas' {ErrorsFrame: TFrame},
  Xilytix.FTEditor.Common in 'Xilytix.FTEditor.Common.pas',
  Xilytix.FTEditor.LayoutConfiguration in 'Xilytix.FTEditor.LayoutConfiguration.pas',
  Xilytix.FTEditor.EditEngine in 'Xilytix.FTEditor.EditEngine.pas',
  Xilytix.FTEditor.LayoutFrame in 'Xilytix.FTEditor.LayoutFrame.pas' {LayoutFrame: TFrame},
  Xilytix.FTEditor.BaseFieldPropertiesFrame in 'Xilytix.FTEditor.BaseFieldPropertiesFrame.pas' {BaseFieldPropertiesFrame: TFrame},
  Xilytix.FTEditor.StringFieldPropertiesFrame in 'Xilytix.FTEditor.StringFieldPropertiesFrame.pas' {StringFieldPropertiesFrame: TFrame},
  Xilytix.FTEditor.SequencesFrame in 'Xilytix.FTEditor.SequencesFrame.pas' {SequencesFrame: TFrame},
  Xilytix.FTEditor.SequencePropertiesFrame in 'Xilytix.FTEditor.SequencePropertiesFrame.pas' {SequencePropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceItemPropertiesFrame in 'Xilytix.FTEditor.SequenceItemPropertiesFrame.pas' {SequenceItemPropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_BasePropertiesFrame.pas' {SequenceRedirect_BasePropertiesFrame: TFrame},
  Xilytix.FTEditor.LayoutConfigurationForm in 'Xilytix.FTEditor.LayoutConfigurationForm.pas' {LayoutConfigurationForm},
  Xilytix.FTEditor.LayoutableFrame in 'Xilytix.FTEditor.LayoutableFrame.pas' {LayoutableFrame: TFrame},
  Xilytix.FTEditor.Binder in 'Xilytix.FTEditor.Binder.pas',
  Xilytix.FTEditor.Configuration in 'Xilytix.FTEditor.Configuration.pas',
  Xilytix.FTEditor.NumberStylesForm in 'Xilytix.FTEditor.NumberStylesForm.pas' {NumberStylesForm},
  Xilytix.FTEditor.BooleanStylesForm in 'Xilytix.FTEditor.BooleanStylesForm.pas' {BooleanStylesForm},
  Xilytix.FTEditor.NumberFieldPropertiesFrame in 'Xilytix.FTEditor.NumberFieldPropertiesFrame.pas' {NumberFieldPropertiesFrame: TFrame},
  Xilytix.FTEditor.DateTimeFieldPropertiesFrame in 'Xilytix.FTEditor.DateTimeFieldPropertiesFrame.pas' {DateTimeFieldPropertiesFrame: TFrame},
  Xilytix.FTEditor.IntegerFieldPropertiesFrame in 'Xilytix.FTEditor.IntegerFieldPropertiesFrame.pas' {IntegerFieldPropertiesFrame: TFrame},
  Xilytix.FTEditor.FloatFieldPropertiesFrame in 'Xilytix.FTEditor.FloatFieldPropertiesFrame.pas' {FloatFieldPropertiesFrame: TFrame},
  Xilytix.FTEditor.DecimalFieldPropertiesFrame in 'Xilytix.FTEditor.DecimalFieldPropertiesFrame.pas' {DecimalFieldPropertiesFrame: TFrame},
  Xilytix.FTEditor.BooleanFieldPropertiesFrame in 'Xilytix.FTEditor.BooleanFieldPropertiesFrame.pas' {BooleanFieldPropertiesFrame: TFrame},
  Xilytix.FTEditor.OptionsForm in 'Xilytix.FTEditor.OptionsForm.pas' {OptionsForm},
  Xilytix.FTEditor.UrlForm in 'Xilytix.FTEditor.UrlForm.pas' {UrlForm},
  Xilytix.FTEditor.EditData in 'Xilytix.FTEditor.EditData.pas',
  Xilytix.FTEditor.CommandLineParser in 'Xilytix.FTEditor.CommandLineParser.pas',
  Xilytix.FTEditor.Colors in 'Xilytix.FTEditor.Colors.pas',
  Xilytix.FTEditor.ColorSchemaForm in 'Xilytix.FTEditor.ColorSchemaForm.pas' {ColorSchemaForm},
  Xilytix.FTEditor.EditorFrame in 'Xilytix.FTEditor.EditorFrame.pas' {EditorFrame: TFrame},
  Xilytix.FTEditor.SourceFrame in 'Xilytix.FTEditor.SourceFrame.pas' {SourceFrame: TFrame},
  Xilytix.FTEditor.SequenceBasePropertiesFrame in 'Xilytix.FTEditor.SequenceBasePropertiesFrame.pas' {SequenceBasePropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_StringPropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_StringPropertiesFrame.pas' {SequenceRedirect_StringPropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_BooleanPropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_BooleanPropertiesFrame.pas' {SequenceRedirect_BooleanPropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_IntegerPropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_IntegerPropertiesFrame.pas' {SequenceRedirect_IntegerPropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_DecimalPropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_DecimalPropertiesFrame.pas' {SequenceRedirect_DecimalPropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_FloatPropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_FloatPropertiesFrame.pas' {SequenceRedirect_FloatPropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_DateTimePropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_DateTimePropertiesFrame.pas' {SequenceRedirect_DateTimePropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_DatePropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_DatePropertiesFrame.pas' {SequenceRedirect_DatePropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_CaseInsensitiveStringPropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_CaseInsensitiveStringPropertiesFrame.pas' {SequenceRedirect_CaseInsensitiveStringPropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_ExactStringPropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_ExactStringPropertiesFrame.pas' {SequenceRedirect_ExactStringPropertiesFrame: TFrame},
  Xilytix.FTEditor.SequenceRedirect_ExactDateTimePropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_ExactDateTimePropertiesFrame.pas' {SequenceRedirect_ExactDateTimePropertiesFrame: TFrame},
  Xilytix.FTEditor.AboutForm in 'Xilytix.FTEditor.AboutForm.pas' {AboutForm},
  Xilytix.FTEditor.FieldHeadingsForm in 'Xilytix.FTEditor.FieldHeadingsForm.pas' {FieldHeadingsForm},
  Xilytix.FTEditor.TypedXml in 'Xilytix.FTEditor.TypedXml.pas',
  Xilytix.FTEditor.SequenceRedirect_NullPropertiesFrame in 'Xilytix.FTEditor.SequenceRedirect_NullPropertiesFrame.pas' {SequenceRedirect_NullPropertiesFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Fielded Text Editor';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
