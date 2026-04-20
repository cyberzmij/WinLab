<#
---
name: EnableDNSClientOperationalLogCheck.ps1
description: "Intune detection script to check if the Microsoft-Windows-DNS-Client/Operational event log is enabled."
risk: safe
source: local
date_added: "2026-04-19"
---
#>
Set-StrictMode -Version Latest
# Intune Detection Script

$LogName = "Microsoft-Windows-DNS-Client/Operational"

try {
    $Log = Get-WinEvent -ListLog $LogName -ErrorAction Stop
    if ($Log.IsEnabled) {
        Write-Output "Detected: $LogName is enabled"
        exit 0
    } else {
        exit 1
    }
}
catch {
    exit 1
}