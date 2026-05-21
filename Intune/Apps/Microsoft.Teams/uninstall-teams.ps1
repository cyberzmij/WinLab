<#
---
name: uninstall-teams.ps1
description: "Intune uninstallation script for Microsoft Teams (AppxPackage)."
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
$AppID = "Microsoft.Teams"
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
    
    $packageName = "MSTeams"
    $processName = "ms-teams"

    $teamsProcess = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($teamsProcess) {
        Write-Output "[INFO] Closing Teams process..."
        Stop-Process -Name $processName -Force
        Start-Sleep -Seconds 2
    }

    $package = Get-AppxPackage -Name $packageName
    if ($package) {
        Remove-AppxPackage -Package $package.PackageFullName
        Write-Output "[OK] Teams uninstalled successfully"
    } else {
        Write-Output "[INFO] Teams not found, nothing to uninstall"
    }
    
    Stop-Transcript
    exit 0
}
catch {
    Write-Warning "[ERROR] Uninstallation failed: $_"
    Stop-Transcript
    exit 1
}