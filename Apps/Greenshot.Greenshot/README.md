# Konfiguracja aplikacji Win32 w Intune - Greenshot (Script-based)

## 0. Informacje o aplikacji (App information)
*   **Name:** Greenshot
*   **Description:** Lekkie narzędzie do robienia zrzutów ekranu i ich edycji.
*   **Publisher:** Greenshot
*   **Logo/Icon:** `icon.png`

Instalacja Greenshot przy użyciu metody "PowerShell script" w Intune i menedżera pakietów Winget.

## 1. Przygotowanie zawartości (App package file)
*   **Plik paczki:** `Intune-Script-Trigger.intunewin`

## 2. Program (Program)
*   **Installer type:** PowerShell script
*   **Install script:** `install-greenshot.ps1`
*   **Uninstall script:** `uninstall-greenshot.ps1`
*   **Install behavior:** User
    *(Wymagane przez Winget do instalacji w profilu użytkownika).*
*   **Device restart behavior:** Determine behavior based on return codes

## 3. Wymagania (Requirements)
*   **Architecture:** x64
*   **Minimum OS:** Windows 10 1709 (wsparcie dla Winget)

## 4. Reguły wykrywania (Detection rules)
*   **Rules format:** Use a custom detection script
*   **Script file:** `check-greenshot.ps1`
*   **Run as 32-bit process on 64-bit clients:** No
*   **Enforce signature check:** No
