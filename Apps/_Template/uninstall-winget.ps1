<#
---
name: uninstall-winget.ps1
description: "Template script for Intune application uninstallation using winget."
risk: safe
source: local
date_added: "2026-04-19"
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
$AppID = "Vendor.App"
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