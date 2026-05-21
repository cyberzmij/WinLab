# Konfiguracja aplikacji Win32 w Intune - Canva (Script-based)

Instalacja Canvy przy użyciu nowej metody "PowerShell script" w Intune i menedżera pakietów Winget.

## 1. Przygotowanie zawartości (App package file)
*   **Plik paczki:** `Intune-Script-Trigger.intunewin` (wymagany jako "wyzwalacz" dla aplikacji Win32).

## 2. Program (Program)
*   **Installer type:** PowerShell script
*   **Install script:** `install-canva.ps1`
*   **Uninstall script:** `uninstall-canva.ps1`
*   **Install behavior:** User
    *(Wymagane przez Winget do poprawnej instalacji w profilu użytkownika).*
*   **Device restart behavior:** Determine behavior based on return codes

## 3. Wymagania (Requirements)
*   **Architecture:** x64
*   **Minimum OS:** Windows 10 1709 (wsparcie dla Winget)

## 4. Reguły wykrywania (Detection rules)
*   **Rules format:** Use a custom detection script
*   **Script file:** `check-canva.ps1`
*   **Run as 32-bit process:** No
*   **Enforce signature check:** No

## 5. Zalety tej metody
Używając `Intune-Script-Trigger.intunewin` oraz funkcji **PowerShell script** w portalu Intune, możesz aktualizować samą logikę instalacji (skrypt) bez konieczności ponownego generowania paczki `.intunewin`.
