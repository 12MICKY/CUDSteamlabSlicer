$ErrorActionPreference = "Stop"

$repo    = "12MICKY/CUDSteamlabSlicer"
$baseUrl = "https://github.com/$repo/releases/latest/download"
$zipPath = "$env:TEMP\StemlabSlicer_Windows.zip"
$installDir = "$env:LOCALAPPDATA\StemlabSlicer"

Write-Host "=== StemlabSlicer Setup (Windows) ===" -ForegroundColor Cyan

Write-Host "[1/3] Downloading StemlabSlicer..."
Invoke-WebRequest -Uri "$baseUrl/StemlabSlicer_Windows.zip" -OutFile $zipPath -UseBasicParsing

Write-Host "[2/3] Extracting to $installDir..."
if (Test-Path $installDir) { Remove-Item $installDir -Recurse -Force }
Expand-Archive -Path $zipPath -DestinationPath $installDir
Remove-Item $zipPath

Write-Host "[3/3] Creating desktop shortcut..."
$exe = Get-ChildItem $installDir -Filter "*.exe" -Recurse |
  Where-Object { $_.Name -match "StemlabSlicer|OrcaSlicer" } |
  Select-Object -First 1 -ExpandProperty FullName

$shell    = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("$env:USERPROFILE\Desktop\StemlabSlicer.lnk")
$shortcut.TargetPath  = $exe
$shortcut.Description = "StemlabSlicer - OrcaSlicer Stemlabs Edition"
$shortcut.Save()

Write-Host ""
Write-Host "Done! Printer configs (U1-1 to U1-8) are built into StemlabSlicer." -ForegroundColor Green
Write-Host "Connect to VPN then launch StemlabSlicer from your desktop."
