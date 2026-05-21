# Konfiguracja aplikacji Win32 w Intune - Microsoft Teams (Script-based)

Instalacja Microsoft Teams przy użyciu metody "PowerShell script" w Intune i menedżera pakietów Winget.

## 1. Przygotowanie zawartości (App package file)
*   **Plik paczki:** `Intune-Script-Trigger.intunewin`

## 2. Program (Program)
*   **Installer type:** PowerShell script
*   **Install script:** `install-teams.ps1`
*   **Uninstall script:** `uninstall-teams.ps1`
*   **Install behavior:** User
    *(Wymagane przez Winget).*

## 3. Wymagania (Requirements)
*   **Architecture:** x64
*   **Minimum OS:** Windows 10 1709

## 4. Reguły wykrywania (Detection rules)
*   **Format:** Custom detection script
*   **File:** `check-teams.ps1`
