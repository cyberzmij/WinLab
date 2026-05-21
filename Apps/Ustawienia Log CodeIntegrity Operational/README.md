# Konfiguracja aplikacji Win32 w Intune - Ustawienia Log CodeIntegrity Operational

Włączanie logów CodeIntegrity (Operational) przy użyciu metody "PowerShell script" w Intune.

## 1. Przygotowanie zawartości (App package file)
*   **Plik paczki:** `Intune-Script-Trigger.intunewin`

## 2. Program (Program)
*   **Installer type:** PowerShell script
*   **Install script:** `install-EnableCodeIntegrityOperationalLog.ps1`
*   **Uninstall script:** `uninstall-DisableCodeIntegrityOperationalLog.ps1`
*   **Install behavior:** System

## 3. Reguły wykrywania (Detection rules)
*   **Rules format:** Use a custom detection script
*   **Script file:** `check-CodeIntegrityOperationalLog.ps1`
*   **Run as 32-bit process on 64-bit clients:** No
*   **Enforce signature check:** No
