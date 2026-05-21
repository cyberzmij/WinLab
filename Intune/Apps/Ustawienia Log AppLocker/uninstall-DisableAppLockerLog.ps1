<#
---
name: uninstall-DisableAppLockerLog.ps1
description: "Disables the Microsoft-Windows-AppLocker event logs."
risk: safe
source: local
date_added: "2026-04-21"
---
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$LogsToDisable = @(
    'Microsoft-Windows-AppLocker/EXE and DLL',
    'Microsoft-Windows-AppLocker/MSI and Script',
    'Microsoft-Windows-AppLocker/Packaged app-Deployment',
    'Microsoft-Windows-AppLocker/Packaged app-Execution'
)

try {
    foreach ($LogName in $LogsToDisable) {
        Write-Output "[INFO] Disabling log: $LogName"
        $Config = New-Object System.Diagnostics.Eventing.Reader.EventLogConfiguration $LogName
        
        if ($Config.IsEnabled) {
            $Config.IsEnabled = $false
            $Config.SaveChanges()
            Write-Output "[OK] Log $LogName disabled"
        } else {
            Write-Output "[INFO] Log $LogName is already disabled"
        }
    }
    exit 0
}
catch {
    Write-Warning "[ERROR] Failed to disable logs: $_"
    exit 1
}
