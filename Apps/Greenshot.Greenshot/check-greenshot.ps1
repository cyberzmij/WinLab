<#
---
name: check-greenshot.ps1
description: "Detection script to check if Greenshot is installed using winget."
risk: safe
source: local
date_added: "2026-04-21"
---
#>
Set-StrictMode -Version Latest

$AppID = "Greenshot.Greenshot"

try {
    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe"
    if (-not (Test-Path $WingetPath)) { $WingetPath = "winget.exe" }

    $installed = & $WingetPath list --id $AppID --accept-source-agreements -e
    
    if ($installed -like "*$AppID*") {
        Write-Output "Detected $AppID"
        exit 0
    } else {
        exit 1
    }
}
catch {
    exit 1
}
