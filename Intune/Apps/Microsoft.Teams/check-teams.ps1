# Intune Detection Script
# Exit 0 if application is found
# Exit 1 if application is NOT found

# Strict mode
Set-StrictMode -Version Latest

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