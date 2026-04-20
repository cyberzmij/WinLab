# Intune Application Script Templates

> [!IMPORTANT]
> **Konfiguracja Intune:** Podczas dodawania aplikacji Win32, w sekcji "Program", musisz ustawić **Install behavior: User**. Jest to wymagane, aby Winget działał poprawnie.

Struktura plików dla nowych aplikacji:
1. Skopiuj katalog `_Template` i zmień jego nazwę na nazwę aplikacji (np. `Slack`).
2. Edytuj zmienną `$AppID` w każdym skrypcie.
3. Dodaj plik logo (`AppName-Logo.png`).

## Skrypty (Winget)
- `install-winget.ps1`: Główny skrypt instalacyjny (używa Winget).
- `uninstall-winget.ps1`: Skrypt usuwający aplikację.
- `check-winget.ps1`: Skrypt wykrywania dla Intune.

## Logi
Skrypty zapisują logi w standardowym folderze Intune:
`C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\`
