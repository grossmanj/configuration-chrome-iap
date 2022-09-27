# Check if gcloud cli is installed.
# If it is not installed, install it.
if (Get-Command gcloud -errorAction SilentlyContinue)
{
    write-host("gcloud exists. continuing...")
} else {
    write-host("gcloud does not exit")
    (New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe", "$env:Temp\GoogleCloudSDKInstaller.exe"); .\$env:Temp\GoogleCloudSDKInstaller.exe
}

# download the payload from github to home directory
(New-Object Net.WebClient).DownloadFile("https://raw.githubusercontent.com/grossmanj/configuration-chrome-iap/main/payloads/start_iap_tunnel.bat", "$HOME\start_iap_tunnel.bat")

# TODO: check if it is possible to add task scheduler export in github and import it programatically.