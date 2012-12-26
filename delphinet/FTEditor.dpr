// Project: FTEditor (Fielded Text Editor)
// Licence: GPL
// Web Home Page: http://www.xilytix.com/FieldedTextEditor.html
// Initial Developer: Paul Klink (http://paul.klink.id.au)
// ------
// Date         Author             Comment
// 11 May 2007  Paul Klink         Initial Check-in
// 20 May 2007  Paul Klink         Fixed Reference to trunk Xilytix.FieldedText.dll

program FTEditor;



uses
  System.Reflection,
  System.Runtime.CompilerServices,
  System.Runtime.InteropServices,
  SysUtils,
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
  Xilytix.FTEditor.DateTimeStylesForm in 'Xilytix.FTEditor.DateTimeStylesForm.pas' {DateTimeStylesForm},
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
  Xilytix.FTEditor.FieldHeadingsForm in 'Xilytix.FTEditor.FieldHeadingsForm.pas' {FieldHeadingsForm};

{$R *.res}

{$REGION 'Program/Assembly Information'}
//
// General Information about an assembly is controlled through the following
// set of attributes. Change these attribute values to modify the information
// associated with an assembly.
//

[assembly: AssemblyDescription('Fielded Text Editor')]
[assembly: AssemblyConfiguration('')]
[assembly: AssemblyCompany('Xilytix')]
[assembly: AssemblyProduct('')]
[assembly: AssemblyCopyright('(c) Xilytix + Others 2007')]
[assembly: AssemblyTrademark('')]
[assembly: AssemblyCulture('')]

// The Delphi compiler controls the AssemblyTitleAttribute via the ExeDescription.
// You can set this in the IDE via the Project Options.
// Manually setting the AssemblyTitle attribute below will override the IDE
// setting.
// [assembly: AssemblyTitle('')]


//
// Version information for an assembly consists of the following four values:
//
//      Major Version
//      Minor Version
//      Build Number
//      Revision
//
// You can specify all the values or you can default the Revision and Build Numbers
// by using the '*' as shown below:

[assembly: AssemblyVersion('1.7.0.*')]

//
// In order to sign your assembly you must specify a key to use. Refer to the
// Microsoft .NET Framework documentation for more information on assembly signing.
//
// Use the attributes below to control which key is used for signing.
//
// Notes:
//   (*) If no key is specified, the assembly is not signed.
//   (*) KeyName refers to a key that has been installed in the Crypto Service
//       Provider (CSP) on your machine. KeyFile refers to a file which contains
//       a key.
//   (*) If the KeyFile and the KeyName values are both specified, the 
//       following processing occurs:
//       (1) If the KeyName can be found in the CSP, that key is used.
//       (2) If the KeyName does not exist and the KeyFile does exist, the key 
//           in the KeyFile is installed into the CSP and used.
//   (*) In order to create a KeyFile, you can use the sn.exe (Strong Name) utility.
//       When specifying the KeyFile, the location of the KeyFile should be
//       relative to the project output directory which is
//       Project Directory\bin\<configuration>. For example, if your KeyFile is
//       located in the project directory, you would specify the AssemblyKeyFile 
//       attribute as [assembly: AssemblyKeyFile('..\\..\\mykey.snk')]
//   (*) Delay Signing is an advanced option - see the Microsoft .NET Framework
//       documentation for more information on this.
//
[assembly: AssemblyDelaySign(false)]
[assembly: AssemblyKeyFile('FTEditor.StrongNameKeyPair.snk')]
[assembly: AssemblyKeyName('')]


//
// Use the attributes below to control the COM visibility of your assembly. By
// default the entire assembly is visible to COM. Setting ComVisible to false
// is the recommended default for your assembly. To then expose a class and interface
// to COM set ComVisible to true on each one. It is also recommended to add a
// Guid attribute.
//

[assembly: ComVisible(False)]
//[assembly: Guid('')]
//[assembly: TypeLibVersion(1, 0)]
{$ENDREGION}

[STAThread]
begin
  Application.Initialize;
  Application.Title := 'Fielded Text Editor';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
