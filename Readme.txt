FTEditor Readme notes

OVERVIEW

FTEditor is an editor for Fielded Text files.  Fielded Text files are text files which contain tables of information.  CSV files are examples of Fielded Text files.  For more information on Fielded Text files see "http://www.fieldedtext.org".

This editor lets you: 
- Visually and interactively create and edit the Meta for a Fielded Text file 
- Edit a Fielded Text file with a simultaneous text and grid view.


INSTALLATION

FTEditor requires Windows 2000 or higher with .NET 2 installed.
To install, run the installation program, FTEditorSetupX.X.X.exe (where X.X.X is the version number).

The installation will set up File Associations for files with extensions .ftx and .ftm.  However the installation program flags these associations as using DDE.  FTEditor does not support DDE.  To enable FTEditor to load these files when they are double clicked, use Tools | Folder Options | File Types in Windows Explorer to disable DDE from the "Open" action for extensions .ftx and .ftm.  


SUPPORT

If you find any problems or have any questions, please contact me/us via the relevant Soureforge.Net forum.


VERSION HISTORY
02 Nov 2007  1.6.0         Added support for Redirect InvokableDelay
                           Fixed bug where Meta file can be written to file with wrong encoding
14 Oct 2007  1.5.5         Redirect Field drop-down can be sorted
                           Warning if Duplicate field name used
                           Improved File Associations
                           Bug fixes in Layouts
                           Other minor bug fixes
29 Sep 2007  1.5.1         Migrated to .NET 2
20 May 2007  1.0.3 (Beta)  Uses Release 1.0.1 of TFieldedText
                           Fix to write out Field Headers
                           Some cosmetic changes 
14 May 2007  1.02  (Beta)  Text coloring and Text Mouse Over defaults changed to False.
                           Sequence Redirects now convert field data if required.
                           Always quoted now distinguishes between heading and record.
                           Save Meta now handles Headings correctly.
12 May 2007  1.01  (Beta)  Initial Release


COMPILATION

FTEditor is written in Delphi.NET.  It can be compiled with CodeGear RAD Studio 2007.  RAD Studio is available from "http://www.codegear.com/products/radstudio".

It can also be compiled with the free Turbo Delphi for .NET as it does not need any 3rd party components placed in the IDE.  Turbo Delphi for .NET can be downloaded from [not available for .NET 2 yet].

To compile FTEditor, follow the steps below:
1) Install and compile TFieldedText (Fielded Text Component).  TFieldedText can be downloaded from "http://www.xilytix.com/FieldedTextComponent.html".

2) Download and install the source files for FTEditor.exe.  These can be downloaded from "http://www.xilytix.com/FieldedTextEditor.html".  All the source files should be placed in the same folder.

3) Load the project FTEditor.dproj into Delphi.

4) Modify the reference to Xilytix.FieldedText.dll so that it points to the DLL generated in step (1) above.

5) Create a sub folder called "CompiledUnits".

6) Compile FTEditor.


LICENCE

Most of this project's source code files are released under GPL licence.  A few are released to public domain.  Check the header of each file to see which licence it is released under.

Obviously the executable is free to use and distribute.  If you distribute it, you must follow the conditions specified by the GPL licence.


DISCLAIMER

This software is provided "as is" and I/us make no representations as to its accuracy, reliability or fit for use.  Use at your own risk.