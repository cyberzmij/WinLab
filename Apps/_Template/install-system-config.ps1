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
$LogPath = Join-Path $env:ProgramData "Microsoft\IntuneManagementExtension\Logs\Config-$($ConfigName.Replace('.','-')).log"

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