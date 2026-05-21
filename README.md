# Intune Application Repository

A repository of PowerShell scripts for automating application deployment and system configuration via Microsoft Intune (Win32 Apps).

## Project Structure
- `Apps/`: Directory containing application and configuration definitions.
  - `_Template/`: Universal Winget script templates (Install, Uninstall, Detection).
  - `[Vendor].[AppName]/`: Specific application deployment folders.
  - `[Configuration Name]/`: System configuration deployment folders (e.g., Event Log settings).

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
  - Winget-based Applications: MUST be set to **Install behavior: User**.
  - System Configurations and specialized apps: Usually require **Install behavior: System**.
- **Logging**: Scripts automatically save logs to `C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\` or utilize Intune's standard output.
- **Documentation**: Every folder in `Apps/` MUST contain a `README.md` file with detailed instructions on how to configure the Win32 App in Intune (Installer type, Install/Uninstall scripts, detection rules, behavior).

## How to add a new element?
1. **Choose method:**
   - **Full .intunewin**: If additional files (e.g. .rdp, .xml, .msi) are required.
   - **Script-based**: If logic is purely in PowerShell (e.g. Winget, Registry changes). Use `Intune-Script-Trigger.intunewin` as content.
2. Copy the `Apps/_Template` directory to a new folder in `Apps/`.
3. Update the logic in `.ps1` scripts.
4. Create/update the `README.md` file specifying the **Installer type** (Win32 or PowerShell script) and other Intune parameters.
5. Configure the application in Intune as a Win32 App.

## Automatyzacja Pozyskiwania Ikon (Dla AI i Deweloperów)

W repozytorium wypracowano standard pobierania ikon aplikacji, który omija problemy z deszyfracją ruchu SSL i zapewnia wysoką jakość assetów:

1.  **Metoda**: Użycie `curl -Lk` do ignorowania błędów certyfikatu SSL (częstych przy deszyfracji ruchu w sieciach korporacyjnych) przy jednoczesnym podążaniu za przekierowaniami.
2.  **Źródła**:
    - Repozytoria GitHub (Raw): `alrra/browser-logos`, `homarr-labs/dashboard-icons`.
    - Usługa Google Favicon: `https://www.google.com/s2/favicons?domain=[domena]&sz=128`.
3.  **Weryfikacja**: Po każdym pobraniu należy wykonać `file icon.png`, aby upewnić się, że pobrany plik nie jest dokumentem HTML (np. błędem 404).

Szczegółowy workflow techniczny dla agentów AI znajduje się w pliku [GEMINI.md](./GEMINI.md).
