<#
---
name: install-EnableAppLockerLog.ps1
description: "Intune configuration script to enable and configure the Microsoft-Windows-AppLocker event logs."
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

$LogsToEnable = @(
    'Microsoft-Windows-AppLocker/EXE and DLL',
    'Microsoft-Windows-AppLocker/MSI and Script',
    'Microsoft-Windows-AppLocker/Packaged app-Deployment',
    'Microsoft-Windows-AppLocker/Packaged app-Execution'
)

$MaxSize = 100MB

try {
    foreach ($LogName in $LogsToEnable) {
        Write-Output "[INFO] Configuring log: $LogName"
        $Config = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $LogName
        
        $Config.IsEnabled = $true
        $Config.MaximumSizeInBytes = $MaxSize
        $Config.SaveChanges()
        
        Write-Output "[OK] Log $LogName enabled with size $($MaxSize/1MB)MB"
    }
    exit 0
}
catch {
    Write-Warning "[ERROR] Failed to configure logs: $_"
    exit 1
}