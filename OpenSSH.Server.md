# Konfiguracja OpenSSH na Windows Server 2019 (Linux Client)

## 1. Instalacja serwera (Windows PowerShell Admin)
```powershell
# Instalacja
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start i Auto-start
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'

# Ustawienie PowerShell jako domyślnej powłoki
On Windows Powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name "DefaultShell" -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
or On Linux Bash
ssh Administrator@IP "powershell -Command \"New-ItemProperty -Path 'HKLM:\SOFTWARE\OpenSSH' -Name 'DefaultShell' -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' -PropertyType String -Force\""

Konta:
Lokalne:		uzytkownik@ip			Najprostsze, działa z kluczami RSA.
Domenowe (AD):		DOMENA\\uzytkownik@ip		Wymaga łączności z Kontrolerem Domeny.
Entra ID (SaaS):	AzureAD\\email@domena.pl@ip	Wymaga serwera wpiętego w Entra ID.

2. Generowanie klucza (Linux Terminal)
Bash
# Tworzy klucz o własnej nazwie bez hasła (passphrase)
ssh-keygen -t rsa -b 4096 -f ~/.ssh/windows_server_key


3. Przesłanie klucza na serwer (Linux Terminal)
Bash
# 1. Tworzy folder .ssh na Windowsie
ssh Administrator@IP "powershell -Command New-Item -ItemType Directory -Force -Path \$HOME\.ssh"

# 2. Kopiuje klucz publiczny
scp ~/.ssh/windows_server_key.pub Administrator@IP:.ssh/authorized_keys


4. Konfiguracja uprawnień dla Administratora (Linux Terminal)
Dla kont z grupy Administrators na Windows Server 2019 klucze muszą być w folderze ProgramData.

Bash
ssh Administrator@IP "powershell -Command \"Move-Item -Path \$HOME\.ssh\authorized_keys -Destination C:\ProgramData\ssh\administrators_authorized_keys -Force; icacls C:\ProgramData\ssh\administrators_authorized_keys /inheritance:r; icacls C:\ProgramData\ssh\administrators_authorized_keys /grant 'NT AUTHORITY\SYSTEM:F'; icacls C:\ProgramData\ssh\administrators_authorized_keys /grant 'BUILTIN\Administrators:F'\""


5. Logowanie
Bash
# Użycie konkretnego klucza
ssh -i ~/.ssh/windows_server_key Administrator@IP

# Alias w ~/.ssh/config dla wygody
cat <<EOF >> ~/.ssh/config

Host win-srv
    HostName IP
    User Administrator
    IdentityFile ~/.ssh/windows_server_key
    LogLevel ERROR
EOF


## 6. Wyłączenie logowania hasłem (Hardening)
**UWAGA:** Przed wykonaniem tego kroku upewnij się, że logowanie kluczem działa!
### Wykonaj z Linuxa (automatyczna edycja pliku config):
```bash
ssh -i ~/.ssh/moj_klucz Administrator@ALIAS "powershell -Command \"(Get-Content C:\ProgramData\ssh\sshd_config) -replace '#?PasswordAuthentication yes', 'PasswordAuthentication no' | Set-Content C:\ProgramData\ssh\sshd_config; Restart-Service sshd\""
Lub wykonaj ręcznie na Windowsie (Notepad z uprawnieniami Admina):
Otwórz C:\ProgramData\ssh\sshd_config.
Znajdź linię PasswordAuthentication yes.
Zmień ją na PasswordAuthentication no (usuń # na początku, jeśli jest).
Zrestartuj usługę: Restart-Service sshd.
### Dlaczego to jest ważne?
W systemie Windows Server 2019 domyślnie aktywna jest sekcja `Match Group administrators` na końcu pliku `sshd_config`. Czasami nadpisuje ona globalne ustawienia. Jeśli po powyższej zmianie logowanie hasłem nadal by działało (co jest błędem bezpieczeństwa), należy sprawdzić, czy na samym dole pliku nie ma wpisu `PasswordAuthentication yes` wewnątrz bloku `Match`.