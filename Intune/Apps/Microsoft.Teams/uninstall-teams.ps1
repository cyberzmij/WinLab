# Intune Configuration:
# Install behavior: User
# PowerShell execution policy: Bypass
# --------------------------------------------------

# Strict mode
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Paths
$AppID = "Microsoft.Teams"
$LogPath = Join-Path $env:ProgramData "Microsoft\IntuneManagementExtension\Logs\Uninstall-$($AppID.Replace('.','-')).log"

Start-Transcript -Path $LogPath -Append

try {
    Write-Output "[INFO] Starting uninstallation of $AppID"
    
    $packageName = "MSTeams"
    $processName = "ms-teams"

    $teamsProcess = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($teamsProcess) {
        Write-Output "[INFO] Closing Teams process..."
        Stop-Process -Name $processName -Force
        Start-Sleep -Seconds 2
    }

    $package = Get-AppxPackage -Name $packageName
    if ($package) {
        Remove-AppxPackage -Package $package.PackageFullName
        Write-Output "[OK] Teams uninstalled successfully"
    } else {
        Write-Output "[INFO] Teams not found, nothing to uninstall"
    }
    
    Stop-Transcript
    exit 0
}
catch {
    Write-Warning "[ERROR] Uninstallation failed: $_"
    Stop-Transcript
    exit 1
}