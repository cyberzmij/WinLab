# PowerShell Windows SSH Skill

Local skill supporting Windows system administration from Linux via the SSH protocol.

## Installation (Local)
This skill is installed in the project directory. To use it, the AI agent must have access to the `SKILL.md` file in this directory.

## Main Features
- **Execution Policy Bypass:** Automatically adding the `-ExecutionPolicy Bypass` flag.
- **Script Transfer via Pipe:** Executing local `.ps1` files without leaving traces on the server.
- **UTF-8 Support:** Resolving issues with special characters.
- **Output Formatting:** Optimizing output for the Linux terminal (`Format-List`).

## Example Commands
1. "Check free disk space on the TEST-w2019 server using the powershell-windows-ssh skill"
2. "Run the local deploy.ps1 script on the remote server via pipe"

## Structure
- `SKILL.md`: Main definition and rules of operation.
- `references/`: Additional technical documentation.
- `examples/`: Ready-made code snippets and scenarios.
- `scripts/`: Local auxiliary tools.
