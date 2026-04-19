---
name: skill-creator-gemini
description: "Optimized tool for creating Gemini CLI compatible skills. Enforces YAML frontmatter, mandatory sections, and system-specific metadata."
risk: safe
source: local
date_added: "2026-04-19"
---

# Skill Creator Gemini

> Twórz skille, które faktycznie działają w Gemini CLI.

## Purpose
Automatyzacja procesu tworzenia nowych umiejętności (skills) z gwarancją pełnej zgodności z formatem metadanych Gemini CLI. Zapobiega błędom "niewidzialnych skilli" poprzez wymuszanie poprawnego nagłówka YAML.

## Guidelines for Skill Creation
Podczas tworzenia nowego skilla, to narzędzie MUSI:
1. **Zawsze generować nagłówek YAML** zawierający: `name`, `description`, `risk`, `source` oraz `date_added`.
2. **Używać struktury:** Nagłówek -> Tytuł (#) -> Blockquote (>) -> Sekcje (## Purpose, ## Guidelines, ## Trigger Phrases, ## Examples).
3. **Instalować lokalnie:** Domyślnie sugerować ścieżkę `.gemini/skills/` w bieżącym projekcie.
4. **Weryfikować zgodność:** Przed zapisaniem pliku sprawdzić, czy `name` w YAML zgadza się z nazwą folderu.

## Mandatory Metadata Template
Każdy nowy skill musi zaczynać się od:
```yaml
---
name: [kebab-case-name]
description: "[Krótki opis w cudzysłowie]"
risk: safe
source: local
date_added: "YYYY-MM-DD"
---
```

## Trigger Phrases
- "stwórz nowy skill gemini"
- "zaprojektuj umiejętność dla gemini cli"
- "nowy lokalny skill"
- "popraw format skilla gemini"

## Examples of Usage
### Generowanie szkieletu
"Użyj skill-creator-gemini, aby stworzyć skill 'network-tools' z opisem 'Narzędzia sieciowe dla SSH'."

### Walidacja istniejącego pliku
"Sprawdź czy mój plik SKILL.md jest zgodny ze standardem skill-creator-gemini."
