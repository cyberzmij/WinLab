# OpenSSH Configuration on Windows Server 2019 (Linux Client)

## 1. Server Installation (Windows PowerShell Admin)
```powershell
# Installation
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start and Auto-start
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# Setting PowerShell as the default shell
# On Windows PowerShell:
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name "DefaultShell" -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
# Or from Linux Bash:
ssh Administrator@IP "powershell -Command \"New-ItemProperty -Path 'HKLM:\SOFTWARE\OpenSSH' -Name 'DefaultShell' -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -PropertyType String -Force\""
```

Accounts:
- Local:          `user@ip`                 Simplest, works with RSA keys.
- Domain (AD):    `DOMAIN\\user@ip`         Requires connectivity with the Domain Controller.
- Entra ID (SaaS): `AzureAD\\email@domain.com@ip` Requires the server to be joined to Entra ID.

## 2. Key Generation (Linux Terminal)
```bash
# Creates an RSA key with a custom name and no passphrase
ssh-keygen -t rsa -b 4096 -f ~/.ssh/windows_server_key
```

## 3. Transferring the Key to the Server (Linux Terminal)
```bash
# 1. Creates the .ssh folder on Windows
ssh Administrator@IP "powershell -Command New-Item -ItemType Directory -Force -Path \$HOME\.ssh"

# 2. Copies the public key
scp ~/.ssh/windows_server_key.pub Administrator@IP:.ssh/authorized_keys
```

## 4. Permission Configuration for Administrator (Linux Terminal)
For accounts in the Administrators group on Windows Server 2019, keys must be in the `ProgramData` folder.

```bash
ssh Administrator@IP "powershell -Command \"Move-Item -Path \$HOME\.ssh\authorized_keys -Destination C:\ProgramData\ssh\administrators_authorized_keys -Force; icacls C:\ProgramData\ssh\administrators_authorized_keys /inheritance:r; icacls C:\ProgramData\ssh\administrators_authorized_keys /grant 'NT AUTHORITY\SYSTEM:F'; icacls C:\ProgramData\ssh\administrators_authorized_keys /grant 'BUILTIN\Administrators:F'\""
```

## 5. Logging In
```bash
# Using a specific key
ssh -i ~/.ssh/windows_server_key Administrator@IP

# Alias in ~/.ssh/config for convenience
cat <<EOF >> ~/.ssh/config

Host win-srv
    HostName IP
    User Administrator
    IdentityFile ~/.ssh/windows_server_key
    LogLevel ERROR
EOF
```

## 6. Disabling Password Authentication (Hardening)
**WARNING:** Before performing this step, ensure that key-based login is working!

### Execute from Linux (automatic config file edit):
```bash
ssh -i ~/.ssh/my_key Administrator@ALIAS "powershell -Command \"(Get-Content C:\ProgramData\ssh\sshd_config) -replace '#?PasswordAuthentication yes', 'PasswordAuthentication no' | Set-Content C:\ProgramData\ssh\sshd_config; Restart-Service sshd\""
```

### Or perform manually on Windows (Notepad with Admin privileges):
1. Open `C:\ProgramData\ssh\sshd_config`.
2. Find the line `PasswordAuthentication yes`.
3. Change it to `PasswordAuthentication no` (remove `#` at the beginning if present).
4. Restart the service: `Restart-Service sshd`.

### Why is this important?
On Windows Server 2019, the `Match Group administrators` section at the end of the `sshd_config` file is active by default. It sometimes overrides global settings. If password login still works after the above change (which is a security flaw), check if there is a `PasswordAuthentication yes` entry inside the `Match` block at the very bottom of the file.
