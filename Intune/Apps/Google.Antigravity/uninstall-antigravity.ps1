# Intune Configuration:
# Install behavior: User
# PowerShell execution policy: Bypass
# --------------------------------------------------

# Strict mode
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Paths
$AppID = "Google.Antigravity"
$LogPath = Join-Path $env:ProgramData "Microsoft\IntuneManagementExtension\Logs\Uninstall-$($AppID.Replace('.','-')).log"

Start-Transcript -Path $LogPath -Append

try {
    Write-Output "[INFO] Starting uninstallation of $AppID"
    
    $processName = "Antigravity"
    if (Get-Process -Name $processName -ErrorAction SilentlyContinue) {
        Write-Output "[INFO] Closing $processName process..."
        Stop-Process -Name $processName -Force
        Start-Sleep -Seconds 2
    }

    $WingetPath = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\winget.exe"
    if (Test-Path $WingetPath) {
        Write-Output "[INFO] Using Winget to uninstall..."
        & $WingetPath uninstall --id $AppID --silent --force --accept-source-agreements
        Write-Output "[OK] Uninstallation finished"
    } else {
        Write-Warning "[ERROR] Winget not found"
        exit 1
    }
    
    Stop-Transcript
    exit 0
}
catch {
    Write-Warning "[ERROR] Uninstallation failed: $_"
    Stop-Transcript
    exit 1
}