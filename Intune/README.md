# Intune Application Repository

Repozytorium skryptów PowerShell do automatyzacji wdrażania aplikacji przez Microsoft Intune (Win32 Apps).

## Struktura projektu
- `Apps/`: Katalog zawierający definicje aplikacji.
  - `_Template/`: Uniwersalne szablony skryptów Winget (Install, Uninstall, Detection).
  - `Google.Antigravity/`: Skrypty dla Google Antigravity.
  - `Microsoft.Teams/`: Skrypty dla Microsoft Teams.

## Standardy i Wymagania
- **Kontekst instalacji (Intune):** Wszystkie skrypty używające Winget MUSZĄ mieć ustawione **Install behavior: User**.
- **Logowanie:** Skrypty automatycznie zapisują logi w `C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\`.
- **Narzędzia:** Skrypty preferują użycie `winget.exe`.

## Jak dodać nową aplikację?
1. Skopiuj katalog `Apps/_Template` do nowego folderu w `Apps/`.
2. Zaktualizuj zmienną `$AppID` w skryptach `.ps1`.
3. Skonfiguruj aplikację w Intune jako Win32 App.
