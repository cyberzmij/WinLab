<#
---
name: install-canva.ps1
description: "Installation script for Canva using winget."
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
$LogDirectory = Join-Path $env:ProgramData "Microsoft\IntuneManagementExtension\Logs"
$LogPath = Join-Path $LogDirectory "Install-$($AppID.Replace('.','-')).log"

# Fallback if the path is not writable (e.g. running in User context without admin rights)
try {
    $TestFile = Join-Path $LogDirectory "test_write_perm.tmp"
    [System.IO.File]::WriteAllText($TestFile, "test")
    Remove-Item $TestFile -Force -ErrorAction SilentlyContinue
}
catch {
    $LogPath = Join-Path $env:TEMP "Install-$($AppID.Replace('.','-')).log"
}

Start-Transcript -Path $LogPath -Append

try {
    Write-Output "[INFO] Starting installation of $AppID"
    
    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe"
    if (-not (Test-Path $WingetPath)) {
        $WingetPath = "winget.exe" # Fallback to PATH
    }

    Write-Output "[INFO] Using winget path: $WingetPath"
    
    # Install command
    & $WingetPath install --id $AppID -e --accept-package-agreements --accept-source-agreements
    
    Write-Output "[OK] Installation finished successfully"
    Stop-Transcript
    exit 0
}
catch {
    Write-Warning "[ERROR] Installation failed: $_"
    Stop-Transcript
    exit 1
}