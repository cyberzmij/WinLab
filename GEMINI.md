# Intune Application & Configuration Repository - Context for Gemini

## Project Overview
This repository contains PowerShell scripts designed for automation and deployment via Microsoft Intune (Win32 Apps). All automation logic (applications and system configurations) is consolidated in the `Apps/` directory.

### Main Technologies
- **PowerShell**: Used for all automation scripts.
- **Winget**: Preferred tool for application installation and uninstallation.
- **Microsoft Intune**: The target deployment platform (Win32 Apps).

## Directory Structure
- `Apps/`: All deployment logic.
  - `_Template/`: Base template for new elements (Install, Uninstall, Detection).
  - Individual folders for applications (e.g., `Google.Chrome`) and system configurations (e.g., `Ustawienia Log AppLocker`).

## Development Conventions

### Naming Conventions
- **Folders**: 
  - For applications: Use `Vendor.ApplicationName` format (e.g., `Canva.Canva`).
  - For configurations: Use descriptive names (e.g., `Ustawienia Log AppLocker`).
- **Files**: Prefer hyphens (`-`) over underscores (`_`) (e.g., `install-app.ps1`).

### Coding Style
- **Metadata Block**: Every script MUST start with a metadata block:
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
- **Strict Mode**: All scripts MUST start with `Set-StrictMode -Version Latest`.
- **Error Handling**: Use `try/catch` blocks and `$ErrorActionPreference = "Stop"`.
- **Documentation**: Every folder MUST contain a `README.md` file with Intune deployment parameters.

### Intune Configuration Standards
- **Installer Types**:
  - **Win32**: Use for packages requiring files inside `.intunewin`.
  - **PowerShell script**: Use for script-only deployments (with `Intune-Script-Trigger.intunewin`).
- **Install Behavior**:
  - **User**: For Winget-based apps.
  - **System**: For system-wide configurations and apps.

## Key Procedures

### Adding a New Element
1. Duplicate `Apps/_Template/` to `Apps/[Name]/`.
2. Implement logic in the `.ps1` files.
3. Update `README.md` with Intune configuration (Install/Uninstall commands or scripts, detection rules).
4. Package as `.intunewin` (using `Intune-Script-Trigger.intunewin` for script-based types).

### Icon Acquisition Workflow (Verified)
When adding new applications, follow this verified method to get high-quality icons:
1.  **Priority Sources**:
    - `https://raw.githubusercontent.com/alrra/browser-logos/main/src/[app]/[app]_256x256.png` (Best for browsers).
    - `https://raw.githubusercontent.com/homarr-labs/dashboard-icons/main/png/[app].png` (Excellent for general apps).
    - `https://raw.githubusercontent.com/marwin1991/profile-technology-icons/main/icons/[app].png` (Developer-focused icons).
2.  **Fallback (Reliable)**:
    - Google Favicon Service: `https://www.google.com/s2/favicons?domain=[domain]&sz=128` (Always returns a valid PNG).
3.  **Download Protocol**:
    - Use `curl -Lk "[URL]" -o icon.png`.
    - **Crucial**: Always use `-k` or `--insecure` to bypass SSL verification errors caused by local traffic decryption.
4.  **Verification**:
    - Always run `file icon.png` after download. If output shows `HTML document`, the link returned a 404 or Error page instead of an image.
