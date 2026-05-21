---
name: skill-creator-gemini
description: "Optimized tool for creating Gemini CLI compatible skills. Enforces YAML frontmatter, mandatory sections, and system-specific metadata."
risk: safe
source: local
date_added: "2026-04-19"
---

# Skill Creator Gemini

> Create skills that actually work in Gemini CLI.

## Purpose
Automating the process of creating new skills with a guarantee of full compatibility with the Gemini CLI metadata format. It prevents "invisible skills" errors by enforcing a correct YAML header.

## Guidelines for Skill Creation
When creating a new skill, this tool MUST:
1. **Always generate a YAML header** containing: `name`, `description`, `risk`, `source`, and `date_added`.
2. **Use the structure:** Header -> Title (#) -> Blockquote (>) -> Sections (## Purpose, ## Guidelines, ## Trigger Phrases, ## Examples).
3. **Install locally:** Suggest the `.gemini/skills/` path in the current project by default.
4. **Verify compatibility:** Check if the `name` in YAML matches the folder name before saving the file.

## Mandatory Metadata Template
Every new skill must start with:
```yaml
---
name: [kebab-case-name]
description: "[Short description in quotes]"
risk: safe
source: local
date_added: "YYYY-MM-DD"
---
```

## Trigger Phrases
- "create new gemini skill"
- "design skill for gemini cli"
- "new local skill"
- "fix gemini skill format"

## Examples of Usage
### Generating a skeleton
"Use skill-creator-gemini to create a 'network-tools' skill with the description 'Network tools for SSH'."

### Validating an existing file
"Check if my SKILL.md file is compliant with the skill-creator-gemini standard."
