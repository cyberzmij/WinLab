<#
---
name: install-dns-switch.ps1
description: "Installs the DNS Switch LAN-VPN scheduled task and enables required network profile logs."
risk: safe
source: local
date_added: "2026-04-19"
---
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Parameters
$taskName   = "DNS Switch LAN-VPN"
$taskPath   = ".\dns-switch-task.xml"
$scriptPath = "C:\Windows\dns-switch-logic.ps1"

try {
    Write-Output "[INFO] Copying script to $scriptPath"
    Copy-Item ".\dns-switch-logic.ps1" -Destination "$scriptPath" -Force

    # Validate $scriptPath
    if (-not (Test-Path -Path $scriptPath -PathType Leaf)) {
        throw "Script not found: $scriptPath"
    }

    # Enable log channel (just in case)
    Write-Output "[INFO] Enabling NetworkProfile Operational log"
    wevtutil sl Microsoft-Windows-NetworkProfile/Operational /e:true

    # Import task
    Write-Output "[INFO] Creating scheduled task: $taskName"
    schtasks /create /TN "$taskName" /xml "$taskPath" /RU "SYSTEM" /F
    
    Write-Output "[OK] Installation completed successfully"
    exit 0
}
catch {
    Write-Error "[ERROR] Installation failed: $_"
    exit 1
}
