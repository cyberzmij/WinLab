# Konfiguracja aplikacji Win32 w Intune - Example-com RDP

Ten dokument zawiera parametry wymagane do poprawnego wdrożenia skrótu RDP przez Microsoft Intune.

## 1. Przygotowanie paczki (.intunewin)
Przed wysłaniem do Intune, użyj `IntuneWinAppUtil.exe`, wskazując folder `Apps/Example-com.RDP/`.
Upewnij się, że w folderze źródłowym znajdują się:
*   `install-rdp.ps1`
*   `check-rdp.ps1`
*   `uninstall-rdp.ps1`
*   `RDP-example.com.rdp` (plik źródłowy skrótu)

## 2. Informacje o programie (Program)
*   **Install command:**
    ```powershell
    powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "install-rdp.ps1"
    ```
*   **Uninstall command:**
    ```powershell
    powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File "uninstall-rdp.ps1"
    ```
*   **Install behavior:** System
*   **Device restart behavior:** Determine behavior based on return codes

## 3. Wymagania (Requirements)
*   **Operating system architecture:** x64
*   **Minimum operating system:** Windows 10 1607 (lub nowszy)

## 4. Reguły wykrywania (Detection rules)
*   **Rules format:** Use a custom detection script
*   **Script file:** Wybierz `check-rdp.ps1`
*   **Run script as 32-bit process on 64-bit clients:** No
*   **Enforce script signature check and run script silently:** No

## 5. Kody wyjścia (Return codes)
Pozostaw domyślne (0 = Success, 3010 = Soft reboot, itd.).
