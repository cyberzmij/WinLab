---
name: powershell-windows-ssh
description: "Expert guidance for managing Windows via PowerShell over SSH from Linux. Handles Execution Policy, UTF-8 encoding, and Pipe-based script execution."
risk: safe
source: local
date_added: "2026-04-19"
---

# PowerShell Windows SSH

> Kompleksowy zestaw reguł i technik do bezbłędnej zdalnej administracji Windows Server z poziomu Linuxa.

## Purpose
Zapewnienie bezpiecznego i przewidywalnego wykonywania poleceń PowerShell na systemach Windows przez SSH. Skill rozwiązuje problemy z interpretacją znaków przez Bash/SSH, polityką wykonania oraz kodowaniem.

## Guidelines

### 1. Składnia i Bezpieczeństwo Interpretacji
- **Raw Data over Logic:** Unikaj obliczeń i logiki wewnątrz one-linerów (np. przeliczania bajtów na GB). Pobieraj surowe dane i formatuj lokalnie lub pozwól na to AI.
- **Minimalizacja znaków specjalnych:** Ograniczaj użycie `{ }`, `$` oraz `$_` w poleceniach przesyłanych bezpośrednio w linii komend. Każdy taki znak to ryzyko błędnej interpretacji przez Bash.
- **Quoting Strategy:** Zawsze zamykaj całą komendę SSH w pojedyncze cudzysłowy `' '`. Jeśli wewnątrz musisz użyć cudzysłowów dla PowerShell, używaj ucieczki backslashem: `\"`.
- **Złota Zasada:** Jeśli komenda zajmuje więcej niż jedną linię lub wymaga użycia klamer/dolarów, nie pisz one-linera. Stwórz lokalny plik `.ps1` i prześlij go przez Pipe.

### 2. Wykonywanie i Przesyłanie
- **Pipe Execution (Standard):** Preferuj `cat script.ps1 | ssh host "powershell -ExecutionPolicy Bypass -Command -"` zamiast kopiowania plików przez SCP. To eliminuje pliki tymczasowe na serwerze.
- **Execution Policy:** Zawsze wymuszaj `-ExecutionPolicy Bypass` dla każdego wywołania, aby uniknąć blokad systemowych.
- **Non-Interactive:** Zawsze dodawaj `-Force -Confirm:$false` do poleceń modyfikujących stan systemu, aby uniknąć zawieszenia sesji na interaktywnym pytaniu [Y/N].

### 3. Dane i Formatowanie
- **Format-List (fl):** Zawsze używaj `| fl` dla czytelności wyników. Tabele (`ft`) są ucinane w konsoli SSH i trudniejsze do sparsowania.
- **Efektywne Filtrowanie:** Używaj wbudowanego parametru `-Filter` w cmdletach (np. `Get-CimInstance ... -Filter "..."`) zamiast przesyłać wszystkie obiekty do `Where-Object`.
- **Encoding:** Wymuszaj UTF-8 na początku skryptów: `$OutputEncoding = [System.Text.Encoding]::UTF8`, aby uniknąć błędów w kodowaniu znaków.

### 4. Metoda "Atomowa" (-EncodedCommand)
Dla bardzo skomplikowanych komend, których nie można wysłać jako plik, użyj Base64:
```bash
B64=$(echo -n '$script' | iconv -t utf-16le | base64 -w 0)
ssh host "powershell -EncodedCommand $B64"
```

## Trigger Phrases
- "zarządzaj windows przez ssh"
- "wykonaj skrypt powershell na windows"
- "problemy z kodowaniem powershell ssh"
- "błąd składni powershell przez ssh"
- "jak bezpiecznie wysłać polecenie do windows"

## Examples

### Pobieranie usług (Bezpieczny one-liner)
`ssh ALIAS 'powershell -Command Get-Service -Filter "Status=Running" | Select-Object Name, DisplayName | fl'`

### Wykonanie lokalnego skryptu (Najlepsza praktyka)
`cat ./SystemHealth.ps1 | ssh ALIAS "powershell -ExecutionPolicy Bypass -Command -"`

### Bezpieczne usuwanie plików (Non-interactive)
`ssh ALIAS 'powershell -Command Remove-Item -Path C:\Temp\* -Force -Confirm:$false'`
