$ErrorActionPreference = "Stop"

$repo    = "12MICKY/CUDSteamlabSlicer"
$baseUrl = "https://github.com/$repo/releases/latest/download"
$installer = "$env:TEMP\StemlabSlicer_Windows_Setup.exe"

Write-Host "=== StemlabSlicer Setup (Windows) ===" -ForegroundColor Cyan

Write-Host "[1/2] Downloading installer..."
Invoke-WebRequest -Uri "$baseUrl/StemlabSlicer_Windows_Setup.exe" -OutFile $installer -UseBasicParsing

Write-Host "[2/2] Running installer..."
Start-Process -FilePath $installer -Wait
Remove-Item $installer -Force

Write-Host ""
Write-Host "Done! Printer configs (U1-1 to U1-8) are built into StemlabSlicer." -ForegroundColor Green
Write-Host "Connect to VPN then launch StemlabSlicer from your desktop."
