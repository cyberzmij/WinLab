---
name: powershell-windows-ssh
description: "Expert guidance for managing Windows via PowerShell over SSH from Linux. Handles Execution Policy, UTF-8 encoding, and Pipe-based script execution."
risk: safe
source: local
date_added: "2026-04-19"
---

# PowerShell Windows SSH

> A comprehensive set of rules and techniques for error-free remote Windows Server administration from Linux.

## Purpose
Ensuring safe and predictable execution of PowerShell commands on Windows systems via SSH. The skill resolves issues with character interpretation by Bash/SSH, execution policies, and encoding.

## Guidelines

### 1. Syntax and Interpretation Safety
- **Raw Data over Logic:** Avoid calculations and logic inside one-liners (e.g., converting bytes to GB). Retrieve raw data and format it locally or let the AI handle it.
- **Special Character Minimization:** Limit the use of `{ }`, `$`, and `$_` in commands sent directly in the command line. Every such character risks misinterpretation by Bash.
- **Quoting Strategy:** Always enclose the entire SSH command in single quotes `' '`. If you must use double quotes for PowerShell inside, use backslash escaping: `\"`.
- **Golden Rule:** If the command spans more than one line or requires braces/dollars, do not write a one-liner. Create a local `.ps1` file and send it via Pipe.

### 2. Execution and Transfer
- **Pipe Execution (Standard):** Prefer `cat script.ps1 | ssh host "powershell -ExecutionPolicy Bypass -Command -"` over copying files via SCP. This eliminates temporary files on the server.
- **Execution Policy:** Always enforce `-ExecutionPolicy Bypass` for every call to avoid system blocks.
- **Non-Interactive:** Always add `-Force -Confirm:$false` to commands that modify system state to avoid the session hanging on an interactive [Y/N] prompt.

### 3. Data and Formatting
- **Format-List (fl):** Always use `| fl` for better result readability. Tables (`ft`) are often truncated in the SSH console and are harder to parse.
- **Efficient Filtering:** Use the built-in `-Filter` parameter in cmdlets (e.g., `Get-CimInstance ... -Filter "..."`) instead of sending all objects to `Where-Object`.
- **Encoding:** Enforce UTF-8 at the beginning of scripts: `$OutputEncoding = [System.Text.Encoding]::UTF8`, to avoid character encoding errors.

### 4. Atomic Method (-EncodedCommand)
For very complex commands that cannot be sent as a file, use Base64:
```bash
B64=$(echo -n '$script' | iconv -t utf-16le | base64 -w 0)
ssh host "powershell -EncodedCommand $B64"
```

## Trigger Phrases
- "manage windows via ssh"
- "execute powershell script on windows"
- "powershell ssh encoding issues"
- "powershell syntax error via ssh"
- "how to safely send command to windows"

## Examples

### Retrieving services (Safe one-liner)
`ssh ALIAS 'powershell -Command Get-Service -Filter "Status=Running" | Select-Object Name, DisplayName | fl'`

### Executing a local script (Best practice)
`cat ./SystemHealth.ps1 | ssh ALIAS "powershell -ExecutionPolicy Bypass -Command -"`

### Safe file deletion (Non-interactive)
`ssh ALIAS 'powershell -Command Remove-Item -Path C:\Temp\* -Force -Confirm:$false'`
