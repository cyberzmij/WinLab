<#
---
name: check-rdp.ps1
description: "Detection script for Example-com RDP shortcut."
risk: safe
source: local
date_added: "2026-04-21"
---
#>
# Intune Detection Script
# Exit 0 if application is found
# Exit 1 (or non-zero) if application is NOT found

$fileName = "RDP-example.com.rdp"
$targetPath = Join-Path -Path $env:Public -ChildPath "Desktop\$fileName"

if (Test-Path $targetPath) {
    Write-Output "Detected: $targetPath"
    exit 0
} else {
    exit 1
}
