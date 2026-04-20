<#
---
name: check-teams.ps1
description: "Intune detection script to check if Microsoft Teams (AppxPackage) is installed."
risk: safe
source: local
date_added: "2026-04-19"
---
#>
Set-StrictMode -Version Latest
# Intune Detection Script
# Exit 0 if application is found
# Exit 1 if application is NOT found

# Strict mode

$packageName = "MSTeams"

try {
    $package = Get-AppxPackage -Name $packageName
    
    if ($package) {
        Write-Output "Detected: $($package.Name)"
        exit 0
    } else {
        exit 1
    }
}
catch {
    exit 1
}