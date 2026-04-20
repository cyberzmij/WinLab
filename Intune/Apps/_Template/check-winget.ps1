# Intune Detection Script
# Exit 0 if application is found
# Exit 1 (or non-zero) if application is NOT found

$AppID = "Vendor.App"

try {
    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe"
    if (-not (Test-Path $WingetPath)) { $WingetPath = "winget.exe" }

    $installed = & $WingetPath list --id $AppID --accept-source-agreements
    
    if ($installed -like "*$AppID*") {
        Write-Output "Detected $AppID"
        exit 0
    } else {
        exit 1
    }
}
catch {
    exit 1
}