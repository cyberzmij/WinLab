<#
---
name: uninstall-DisableCodeIntegrityOperationalLog.ps1
description: "Disables the Microsoft-Windows-CodeIntegrity/Operational event log."
risk: safe
source: local
date_added: "2026-04-21"
---
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$LogName = 'Microsoft-Windows-CodeIntegrity/Operational'

try {
    Write-Output "[INFO] Disabling log: $LogName"
    $Config = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $LogName
    
    if ($Config.IsEnabled) {
        $Config.IsEnabled = $false
        $Config.SaveChanges()
        Write-Output "[OK] Log $LogName disabled"
    } else {
        Write-Output "[INFO] Log $LogName is already disabled"
    }
    exit 0
}
catch {
    Write-Warning "[ERROR] Failed: $_"
    exit 1
}
