<#
---
name: uninstall-rdp.ps1
description: "Removes the Example-com RDP shortcut from the public desktop."
risk: safe
source: local
date_added: "2026-04-21"
---
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$fileName = "RDP-example.com.rdp"
$targetPath = Join-Path -Path $env:Public -ChildPath "Desktop\$fileName"

try {
    if (Test-Path $targetPath) {
        Write-Output "[INFO] Removing $targetPath"
        Remove-Item -Path $targetPath -Force
        Write-Output "[OK] Shortcut removed successfully"
    } else {
        Write-Output "[INFO] Shortcut not found, nothing to remove"
    }
    exit 0
}
catch {
    Write-Warning "[ERROR] Uninstallation failed: $_"
    exit 1
}
