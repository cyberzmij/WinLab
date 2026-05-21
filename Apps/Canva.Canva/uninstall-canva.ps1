<#
---
name: uninstall-canva.ps1
description: "Uninstallation script for Canva using winget."
risk: safe
source: local
date_added: "2026-04-21"
---
#>
Set-StrictMode -Version Latest
# Intune Configuration:
# Install behavior: User
# PowerShell execution policy: Bypass
# --------------------------------------------------

# Strict mode
$ErrorActionPreference = "Stop"

# Variables
$AppID = "Canva.Canva"
$LogPath = Join-Path $env:ProgramData "Microsoft\IntuneManagementExtension\Logs\Uninstall-$($AppID.Replace('.','-')).log"

Start-Transcript -Path $LogPath -Append

try {
    Write-Output "[INFO] Starting uninstallation of $AppID"
    
    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe"
    if (-not (Test-Path $WingetPath)) {
        $WingetPath = "winget.exe"
    }

    & $WingetPath uninstall --id $AppID --silent --accept-source-agreements
    
    Write-Output "[OK] Uninstallation finished"
    Stop-Transcript
    exit 0
}
catch {
    Write-Warning "[ERROR] Uninstallation failed: $_"
    Stop-Transcript
    exit 1
}