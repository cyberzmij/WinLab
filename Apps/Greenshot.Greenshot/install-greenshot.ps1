<#
---
name: install-greenshot.ps1
description: "Installation script for Greenshot using winget."
risk: safe
source: local
date_added: "2026-04-21"
---
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Intune Configuration:
# Install behavior: User
# PowerShell execution policy: Bypass
# --------------------------------------------------

$AppID = "Greenshot.Greenshot"
$LogPath = Join-Path $env:ProgramData "Microsoft\IntuneManagementExtension\Logs\Install-$($AppID.Replace('.','-')).log"

Start-Transcript -Path $LogPath -Append

try {
    Write-Output "[INFO] Starting installation of $AppID"
    
    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe"
    if (-not (Test-Path $WingetPath)) {
        $WingetPath = "winget.exe"
    }

    Write-Output "[INFO] Using winget path: $WingetPath"
    
    # Install command
    & $WingetPath install --id $AppID -e --silent --force --accept-package-agreements --accept-source-agreements
    
    Write-Output "[OK] Installation finished successfully"
    Stop-Transcript
    exit 0
}
catch {
    Write-Warning "[ERROR] Installation failed: $_"
    Stop-Transcript
    exit 1
}
