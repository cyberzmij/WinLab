<#
---
name: EnableDNSClientOperationalLog.ps1
description: "Intune configuration script to enable and configure the Microsoft-Windows-DNS-Client/Operational event log."
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

$ErrorActionPreference = "Stop"

$LogName = 'Microsoft-Windows-DNS-Client/Operational'
$MaxSize = 100MB

try {
    Write-Output "[INFO] Configuring log: $LogName"
    $Config = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $LogName
    $Config.IsEnabled = $true
    $Config.MaximumSizeInBytes = $MaxSize
    $Config.SaveChanges()
    
    Write-Output "[OK] Log $LogName enabled"
    exit 0
}
catch {
    Write-Warning "[ERROR] Failed: $_"
    exit 1
}