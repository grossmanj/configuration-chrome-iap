# Automated IAP tunnel creation (on Logon)

This repository contains scrips and payloads to setup IAP tunnel for users.  
  
When a new machine is commissioned, or when a new user is onboarded, run the script corresponding to the host operating system. This script should be run in the users's account (do not run this on administrator account - it wont work for the users).  
  
This script installs the required dependencies, and downloads the payload file to the following directory.  

- Windows                       - `$HOME\start_iap_tunnel.bat`
- Unix (Linux/ChromeOS/MacOS)   - `~/.config/start_iap_tunnel.sh`

In Unix systems, in addition to downloading the payload, it also adds the execution of the payload to crontab. This ensures that the scripts are executed on every reboot.

## Unix Systems (Linux/ChromeOS/MacOS)

To setup a Unix machine,

- Sign in to the user's account.
- Run the following command  
    `wget -O - https://raw.githubusercontent.com/grossmanj/configuration-chrome-iap/main/scripts/setup_iap_tunnel.sh | bash`
- Configure RDP client to connect on the server/host `localhost:29356` along with user credentials.
- For testing, you can run the following command before connecting to the RDP  
    `bash ~/.config/start_iap_tunnel.sh visma-fin-app 29356`
- From subsequent restart, the tunnel should automatically starts during the machine startup.

## Windows

To setup a Windows machine,

- Sign in to the user's account
- Run the following command
    `powershell -Command "(New-Object Net.WebClient).DownloadFile(""https://raw.githubusercontent.com/grossmanj/configuration-chrome-iap/main/scripts/setup_iap_tunnel.bat"", ""$env:Temp\setup_iap_tunnel.bat"") & $env:Temp\setup_iap_tunnel.bat"`
- Configure RDP client to connect on the server/host `localhost:29356` along with user credentials.
- For testing, you can run the following command before connecting to the RDP
    `$HOME\start_iap_tunnel.bat visma-fin-app 29356`
- Save the RDP connection as a file. This can be used to automate the whole process.
- Create a Task in "Task Scheduler" with trigger as user logon and actions as
  - (1) Script execution (`$HOME\start_iap_tunnel.bat visma-fin-app 29356`)
  - (2) RDP connect (`<path-to-mstsc> <path-to-rdp-config-file>`)