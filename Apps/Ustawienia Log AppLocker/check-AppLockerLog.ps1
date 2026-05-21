<#
---
name: check-AppLockerLog.ps1
description: "Intune detection script to check if the Microsoft-Windows-AppLocker event logs are enabled and have the correct size."
risk: safe
source: local
date_added: "2026-04-19"
---
#>
Set-StrictMode -Version Latest
# Intune Detection Script

$LogName = "Microsoft-Windows-AppLocker/EXE and DLL"
$MinSize = 100MB

try {
    $Log = Get-WinEvent -ListLog $LogName -ErrorAction Stop
    
    if ($Log.IsEnabled -and ($Log.MaximumSizeInBytes -ge $MinSize)) {
        Write-Output "Detected: $LogName is enabled with correct size"
        exit 0
    } else {
        exit 1
    }
}
catch {
    exit 1
}