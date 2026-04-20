# Intune Application Repository

A repository of PowerShell scripts for automating application deployment and system configuration via Microsoft Intune (Win32 Apps).

## Project Structure
- `Apps/`: Directory containing application definitions.
  - `_Template/`: Universal Winget script templates (Install, Uninstall, Detection).
  - `Google.Antigravity/`: Scripts for Google Antigravity.
  - `Microsoft.Teams/`: Scripts for Microsoft Teams.
  - `DNS_Switch_LAN-VPN/`: Scripts for automatic DNS registration switching.
- `Scripts/`: Configuration and utility scripts.
  - `Logs/`: Event log configurations (e.g., AppLocker, CodeIntegrity, DNS Client).

## Standards and Requirements
- **Metadata Block**: Every script MUST start with a metadata block in the following format:
  ```powershell
  <#
  ---
  name: [Script Name]
  description: "[Short description of what the script does]"
  risk: [safe|unknown|risky]
  source: local
  date_added: "YYYY-MM-DD"
  ---
  #>
  ```
- **Strict Mode**: All scripts must use `Set-StrictMode -Version Latest` immediately after the metadata block.
- **Installation Behavior (Intune)**: 
  - Winget Applications (in `Apps/`): MUST be set to **Install behavior: User**.
  - System Scripts (in `Scripts/`): Usually require **Install behavior: System**.
- **Logging**: Scripts automatically save logs to `C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\` or utilize Intune's standard output.
- **Tools**: Scripts prefer using `winget.exe` for application management.

## How to add a new application?
1. Copy the `Apps/_Template` directory to a new folder in `Apps/`.
2. Update the `$AppID` variable in the `.ps1` scripts.
3. Configure the application in Intune as a Win32 App.

## How to add a new configuration script?
1. Create a new subfolder in `Scripts/`.
2. Add the implementation script (e.g., `EnableLog.ps1`) and the detection script (e.g., `EnableLogCheck.ps1`).
3. Ensure both scripts include the required metadata block and `Set-StrictMode`.
