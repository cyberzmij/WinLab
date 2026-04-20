# Intune Application Repository

Repozytorium skryptów PowerShell do automatyzacji wdrażania aplikacji przez Microsoft Intune (Win32 Apps).

## Struktura
- `_Template/`: Uniwersalne szablony skryptów.
- `Google.Antigravity/`: Skrypty dla Google Antigravity.
- `Microsoft.Teams/`: Skrypty dla Microsoft Teams.

## Standardy
- **Kontekst:** Wszystkie aplikacje instalowane przez Winget MUSZĄ mieć ustawione **Install behavior: User** w Intune.
- Wszystkie skrypty używają Winget tam, gdzie to możliwe.
- Logowanie odbywa się do ścieżki `C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\`.
- Kodowanie plików: UTF-8 bez BOM (zalecane dla PowerShell w Intune).
