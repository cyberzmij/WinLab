<#
---
name: check-dns-switch.ps1
description: "Detection script for DNS Switch LAN-VPN scheduled task."
risk: safe
source: local
date_added: "2026-04-19"
---
#>
# Intune Detection Script
Set-StrictMode -Version Latest

# Check if a task with the given name exists
$taskName = "DNS Switch LAN-VPN"
$task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue

if ($task) {
    Write-Output "Detected: $taskName task exists"
    exit 0
} else {
    exit 1
}
