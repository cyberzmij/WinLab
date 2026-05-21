# Konfiguracja aplikacji Win32 w Intune - NetBird DNS Switch (Full .intunewin)

Konfiguracja automatycznego przełączania rejestracji DNS dla NetBird/LAN.

## 1. Przygotowanie paczki (.intunewin)
Użyj `IntuneWinAppUtil.exe`, wskazując folder `Apps/NetBird.DNSSwitch/`.
W paczce muszą się znajdować:
*   `install-dns-switch.ps1`
*   `check-dns-switch.ps1`
*   `dns-switch-logic.ps1`
*   `dns-switch-task.xml`

## 2. Program (Program)
*   **Installer type:** Win32
*   **Install command:**
    ```powershell
    powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "install-dns-switch.ps1"
    ```
*   **Uninstall command:** (Brak dedykowanego skryptu, można użyć komendy usuwającej zadanie lub zostawić puste).
*   **Install behavior:** System

## 3. Reguły wykrywania (Detection rules)
*   **Format:** Custom detection script
*   **File:** `check-dns-switch.ps1`


