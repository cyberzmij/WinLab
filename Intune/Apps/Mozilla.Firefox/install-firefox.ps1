<#
---
name: install-firefox.ps1
description: "Installation script for Mozilla Firefox using winget in user scope."
risk: safe
source: local
date_added: "2026-04-22"
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
$AppID = "Mozilla.Firefox"
$LogPath = Join-Path $env:ProgramData "Microsoft\IntuneManagementExtension\Logs\Install-$($AppID.Replace('.','-')).log"

Start-Transcript -Path $LogPath -Append

try {
    Write-Output "[INFO] Starting installation of $AppID"
    
    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe"
    if (-not (Test-Path $WingetPath)) {
        $WingetPath = "winget.exe" # Fallback to PATH
    }

    Write-Output "[INFO] Using winget path: $WingetPath"
    
    # Install command
    & $WingetPath install --id $AppID -e --silent --force --accept-package-agreements --accept-source-agreements --scope user
    
    Write-Output "[OK] Installation finished successfully"
    Stop-Transcript
    exit 0
}
catch {
    Write-Warning "[ERROR] Installation failed: $_"
    Stop-Transcript
    exit 1
}