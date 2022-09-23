:: Check if gcloud cli is installed.
:: If it is not installed, install it.

WHERE gcloud >nul 2>nul
IF %ERRORLEVEL% EQU 0 ECHO gcloud already installed ELSE powershell -Command "(New-Object Net.WebClient).DownloadFile(""https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe"", ""$env:Temp\GoogleCloudSDKInstaller.exe"") & $env:Temp\GoogleCloudSDKInstaller.exe"

:: download the payload from github to home directory

powershell -Command "(New-Object Net.WebClient).DownloadFile(""https://raw.githubusercontent.com/grossmanj/configuration-chrome-iap/main/payloads/start_iap_tunnel.bat"", ""$HOME\start_iap_tunnel.bat visma-fin-app 29356"")"

:: TODO: check if it is possible to add task scheduler export in github and import it programatically.