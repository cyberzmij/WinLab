# PowerShell Windows SSH Skill

Lokalna umiejętność (skill) wspomagająca administrację systemami Windows z poziomu Linuxa przez protokół SSH.

## Instalacja (Lokalna)
Ten skill jest zainstalowany w katalogu projektu. Aby go użyć, AI agent musi mieć dostęp do pliku `SKILL.md` w tym katalogu.

## Główne Funkcje
- **Omijanie Execution Policy:** Automatyczne dodawanie flagi `-ExecutionPolicy Bypass`.
- **Przesyłanie skryptów przez Pipe:** Wykonywanie lokalnych plików `.ps1` bez tworzenia śladów na serwerze.
- **Obsługa UTF-8:** Rozwiązywanie problemów z polskimi znakami.
- **Formatowanie wyników:** Optymalizacja wyjścia pod terminal Linuxa (`Format-List`).

## Przykładowe Komendy
1. "Sprawdź wolne miejsce na dyskach serwera TEST-w2019 używając skilla powershell-windows-ssh"
2. "Uruchom lokalny skrypt deploy.ps1 na zdalnym serwerze przez pipe"

## Struktura
- `SKILL.md`: Główna definicja i zasady działania.
- `references/`: Dodatkowa dokumentacja techniczna.
- `examples/`: Gotowe fragmenty kodu i scenariusze.
- `scripts/`: Pomocnicze narzędzia lokalne.
