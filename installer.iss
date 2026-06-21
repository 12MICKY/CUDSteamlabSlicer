#define MyAppName "StemlabSlicer"
#ifndef MyAppVersion
  #define MyAppVersion "latest"
#endif
#ifndef MySourceDir
  #define MySourceDir "C:\StemlabSlicer"
#endif

[Setup]
AppId={{F3A2B1C0-D4E5-4F6A-8B7C-9D0E1F2A3B4C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher=Stemlabs (CUD)
AppPublisherURL=https://github.com/12MICKY/CUDSteamlabSlicer
DefaultDirName={localappdata}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputBaseFilename=StemlabSlicer_Windows_Setup
Compression=lzma2/ultra64
SolidCompression=yes
OutputDir=.
PrivilegesRequired=lowest
SetupIconFile=icon.ico
WizardStyle=modern
UninstallDisplayIcon={app}\StemlabSlicer.exe

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "{#MySourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\StemlabSlicer.exe"
Name: "{group}\{#MyAppName}"; Filename: "{app}\StemlabSlicer.exe"
Name: "{group}\Uninstall {#MyAppName}"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\StemlabSlicer.exe"; Description: "Launch {#MyAppName}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
