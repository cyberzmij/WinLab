<#
---
name: install-system-config.ps1
description: "Template script for Intune system configuration."
risk: safe
source: local
date_added: "2026-04-19"
---
#>
Set-StrictMode -Version Latest
# Intune Configuration:
# Install behavior: System
# PowerShell execution policy: Bypass
# --------------------------------------------------

# Strict mode
$ErrorActionPreference = "Stop"

# Variables
$ConfigName = "System.Feature.Name"
$LogDirectory = Join-Path $env:ProgramData "Microsoft\IntuneManagementExtension\Logs"
$LogPath = Join-Path $LogDirectory "Config-$($ConfigName.Replace('.','-')).log"

# Fallback if the path is not writable (e.g. running in User context without admin rights)
try {
    $TestFile = Join-Path $LogDirectory "test_write_perm.tmp"
    [System.IO.File]::WriteAllText($TestFile, "test")
    Remove-Item $TestFile -Force -ErrorAction SilentlyContinue
}
catch {
    $LogPath = Join-Path $env:TEMP "Config-$($ConfigName.Replace('.','-')).log"
}

Start-Transcript -Path $LogPath -Append

try {
    Write-Output "[INFO] Starting configuration of $ConfigName"
    
    # --- Add your system configuration logic here ---
    # Example: Set-ItemProperty -Path "HKLM:\..." -Name "Property" -Value 1
    
    Write-Output "[OK] Configuration finished successfully"
    Stop-Transcript
    exit 0
}
catch {
    Write-Warning "[ERROR] Configuration failed: $_"
    Stop-Transcript
    exit 1
}