# Project Context: GitHub Integration

This project uses **GitHub CLI (`gh`)** for repository management, issues, and Pull Requests.

## Configuration Defaults
- **Platform:** GitHub.com
- **User:** cyb3r2mij
- **Git User Email:** 125825077+cyb3r2mij@users.noreply.github.com
- **Auth Method:** SSH (Ed25519)
- **Identity File:** `~/.ssh/github_key`
- **GH CLI Status:** Authenticated (with `repo`, `delete_repo`, `gist`, `read:org`, `admin:public_key` scopes)
- **Preferred Tooling:** Use `gh` over raw `git` for high-level operations (e.g., `gh repo`, `gh pr`, `gh issue`).

## Security & Data Privacy
- **Secret Protection:** NEVER commit or push `.env` files, `.ssh` keys, API keys, passwords, or any sensitive credentials to GitHub.
- **Data Privacy (PII):** DO NOT commit or push files containing clear-text Personally Identifiable Information (PII) such as full names, phone numbers, home addresses, or private IDs.
- **Content Scanning:** Before `git add` or `git commit`, scan the content for patterns resembling secrets (e.g., `sk_live_...`, `AIza...`) or sensitive user data. If detected, stop the operation and notify the user.
- **Gitignore Enforcement:** Always ensure a `.gitignore` file exists and includes common secret patterns (e.g., `*.env`, `node_modules/`, `dist/`, `.DS_Store`).
- **Dry Run:** Before a first push to a new repo, check for any potentially sensitive files in the staging area.
- **Credential Scanning:** If available in the environment, use `gh secret` or similar tools for managing repository secrets instead of hardcoding them.

## Workflow Instructions
1. **Repository Management:** Always check if a remote exists on GitHub before creating one. Use `gh repo view` to verify.
2. **Commit & Push:** Use conventional commits. Always ensure all recent edits (from `replace` or `write_file`) are staged with `git add` before committing. 
3. **Verification:** After pushing, verify if the remote state matches the local state (e.g., file size, line count) if the sync is critical.
4. **Authentication:** If `gh` operations fail, verify SSH connection with `ssh -T git@github.com`.

## Agent Mandate
- Prioritize using the `github` skill and `gh` CLI for all GitHub-related tasks.
- Never use HTTPS/Personal Access Tokens unless explicitly requested.
- If creating a new repository, always initialize it with `gh repo create`.
