<#
---
name: install-rdp.ps1
description: "Copies the Example-com RDP shortcut to the public desktop."
risk: safe
source: local
date_added: "2026-04-21"
---
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Intune Configuration:
# Install behavior: System
# PowerShell execution policy: Bypass
# --------------------------------------------------

$fileName = "RDP-example.com.rdp"
$destination = Join-Path -Path $env:Public -ChildPath "Desktop"
$targetPath = Join-Path -Path $destination -ChildPath $fileName

try {
    Write-Output "[INFO] Starting deployment of $fileName"
    
    if (-not (Test-Path $destination)) {
        Write-Error "[ERROR] Destination directory does not exist: $destination"
        exit 1
    }

    if (Test-Path ".\$fileName") {
        Write-Output "[INFO] Copying $fileName to $destination"
        Copy-Item -Path ".\$fileName" -Destination $targetPath -Force
        Write-Output "[OK] Deployment finished successfully"
        exit 0
    } else {
        Write-Error "[ERROR] Source file not found: .\$fileName"
        exit 1
    }
}
catch {
    Write-Warning "[ERROR] Deployment failed: $_"
    exit 1
}
