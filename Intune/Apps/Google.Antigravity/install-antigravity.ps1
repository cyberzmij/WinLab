<#
---
name: install-antigravity.ps1
description: "Intune installation script for Google Antigravity using winget."
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

# Paths
$AppID = "Google.Antigravity"
$LogPath = Join-Path $env:ProgramData "Microsoft\IntuneManagementExtension\Logs\Install-$($AppID.Replace('.','-')).log"

Start-Transcript -Path $LogPath -Append

try {
    Write-Output "[INFO] Starting installation of $AppID"
    
    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe"

    if (Test-Path $WingetPath) {
        Write-Output "[INFO] Found Winget at: $WingetPath"
        & $WingetPath install --id $AppID -e --silent --force --accept-package-agreements --accept-source-agreements
        Write-Output "[OK] Installation finished successfully"
    } else {
        Write-Warning "[ERROR] Winget not found in user profile. Ensure 'Install behavior: User' is set."
        exit 1
    }
    
    Stop-Transcript
    exit 0
}
catch {
    Write-Warning "[ERROR] Installation failed: $_"
    Stop-Transcript
    exit 1
}