<#
---
name: uninstall-antigravity.ps1
description: "Intune uninstallation script for Google Antigravity using winget."
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
$LogDirectory = Join-Path $env:ProgramData "Microsoft\IntuneManagementExtension\Logs"
$LogPath = Join-Path $LogDirectory "Uninstall-$($AppID.Replace('.','-')).log"

# Fallback if the path is not writable (e.g. running in User context without admin rights)
try {
    $TestFile = Join-Path $LogDirectory "test_write_perm.tmp"
    [System.IO.File]::WriteAllText($TestFile, "test")
    Remove-Item $TestFile -Force -ErrorAction SilentlyContinue
}
catch {
    $LogPath = Join-Path $env:TEMP "Uninstall-$($AppID.Replace('.','-')).log"
}

Start-Transcript -Path $LogPath -Append

try {
    Write-Output "[INFO] Starting uninstallation of $AppID"
    
    $processName = "Antigravity"
    if (Get-Process -Name $processName -ErrorAction SilentlyContinue) {
        Write-Output "[INFO] Closing $processName process..."
        Stop-Process -Name $processName -Force
        Start-Sleep -Seconds 2
    }

    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe"
    if (Test-Path $WingetPath) {
        Write-Output "[INFO] Using Winget to uninstall..."
        & $WingetPath uninstall --id $AppID --silent --force --accept-source-agreements
        Write-Output "[OK] Uninstallation finished"
    } else {
        Write-Warning "[ERROR] Winget not found"
        exit 1
    }
    
    Stop-Transcript
    exit 0
}
catch {
    Write-Warning "[ERROR] Uninstallation failed: $_"
    Stop-Transcript
    exit 1
}