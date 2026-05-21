<#
---
name: uninstall-greenshot.ps1
description: "Uninstallation script for Greenshot using winget."
risk: safe
source: local
date_added: "2026-04-21"
---
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$AppID = "Greenshot.Greenshot"

try {
    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe"
    if (-not (Test-Path $WingetPath)) { $WingetPath = "winget.exe" }

    Write-Output "[INFO] Starting uninstallation of $AppID"
    & $WingetPath uninstall --id $AppID -e --silent --accept-source-agreements
    
    Write-Output "[OK] Uninstallation finished successfully"
    exit 0
}
catch {
    Write-Warning "[ERROR] Uninstallation failed: $_"
    exit 1
}
