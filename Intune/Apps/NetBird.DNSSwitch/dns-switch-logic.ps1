<#
---
name: dns-switch-logic.ps1
description: "Logic for switching DNS registration and suffixes based on NetworkCategory (DomainAuthenticated vs others)."
risk: safe
source: local
date_added: "2026-04-19"
---
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# NetBird DNS addition

# Fill in your DNS IP
$servers = @('192.168.1.1')
# Fill in the DOMAIN
$dom = 'example.com'

$alias = 'wt0'

$cli = Get-DnsClient -InterfaceAlias $alias -ErrorAction SilentlyContinue
if ($cli) {
    Set-DnsClientServerAddress -InterfaceAlias $alias -ServerAddresses $servers -ErrorAction SilentlyContinue -WarningAction SilentlyContinue | Out-Null
}

# ============================
# Enable DNS registration + set suffix on DomainAuthenticated interfaces,
# disable and clear suffix on others
# ============================

$VerbosePreference = 'Continue'  # set to 'SilentlyContinue' if you don't want logs

# Get network connection profiles and DNS clients
$profiles = Get-NetConnectionProfile
$dns      = Get-DnsClient

# Interfaces with DomainAuthenticated profile
$corpProfiles = @(
    $profiles | Where-Object { $_.NetworkCategory -eq 'DomainAuthenticated' }
)

if (-not $corpProfiles -or $corpProfiles.Count -eq 0) {
    Write-Warning "No interface found with NetworkCategory = DomainAuthenticated. No changes made."
    return
}

# Collect indexes of domain interfaces
$corpIdx = @($corpProfiles.InterfaceIndex)

Write-Verbose ("DomainAuthenticated interfaces: " + ($corpProfiles | Select-Object InterfaceAlias, InterfaceIndex | Out-String))

# === ENABLE registration and set suffix on domain interfaces ===
foreach ($idx in $corpIdx) {
    $cli = $dns | Where-Object { $_.InterfaceIndex -eq $idx }
    if ($cli) {
        Write-Verbose ("Enabling registration on: {0} (idx {1})" -f $cli.InterfaceAlias, $cli.InterfaceIndex)
        Set-DnsClient -InterfaceIndex $cli.InterfaceIndex -RegisterThisConnectionsAddress $true

        if ($cli.ConnectionSpecificSuffix -ne $dom) {
            Write-Verbose ("Setting suffix '{0}' on: {1} (idx {2})" -f $dom, $cli.InterfaceAlias, $cli.InterfaceIndex)
            Set-DnsClient -InterfaceIndex $cli.InterfaceIndex -ConnectionSpecificSuffix $dom
        }
    }
}

# === DISABLE registration and clear suffix on other interfaces ===
foreach ($cli in $dns | Where-Object { $_.InterfaceIndex -notin $corpIdx }) {
    Write-Verbose ("Disabling registration on: {0} (idx {1})" -f $cli.InterfaceAlias, $cli.InterfaceIndex)
    Set-DnsClient -InterfaceIndex $cli.InterfaceIndex -RegisterThisConnectionsAddress $false

    if (-not [string]::IsNullOrWhiteSpace($cli.ConnectionSpecificSuffix)) {
        Write-Verbose ("Clearing suffix on: {0} (idx {1})" -f $cli.InterfaceAlias, $cli.InterfaceIndex)
        Set-DnsClient -InterfaceIndex $cli.InterfaceIndex -ConnectionSpecificSuffix ""
    }
}

# (Optional) global DNS client settings - use suffixes and interface DNS servers
Set-DnsClientGlobalSetting -UseSuffixWhenRegistering $true -RegisterDnsRecordsWithConnectionSpecificDnsServers $true

# Force immediate registration
Register-DnsClient -Verbose
