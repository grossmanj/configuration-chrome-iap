#!/bin/bash

# function to install gcloud
function install_gcloud {
    sudo apt-get install apt-transport-https ca-certificates gnupg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt-get update && sudo apt-get install google-cloud-cli
}

# check if glcoud is installed
# if not installed, install it.
command -v gcloud >/dev/null 2>&1 || install_gcloud

# check if wget is installed, if not, install it. 
command -v wget >/dev/null 2>&1 || sudo apt update -y && sudo apt install wget -y

# check if net-tools are installed, if not install it
command -v netstat >/dev/null 2>&1 || sudo apt update -y && sudo apt install net-tools -y


# download the payload from github to home directory
mkdir -p ~/.config && (cd ~/.config && wget -O start_iap_tunnel.sh https://raw.githubusercontent.com/grossmanj/configuration-chrome-iap/main/payloads/start_iap_tunnel.sh)
chmod +x ~/.config/start_iap_tunnel.sh

# add crontab entry to run the scrip on every reboot
crontab -l > crontab_temp
echo "@reboot bash /home/$USER/.config/start_iap_tunnel.sh visma-fin-app 29356" >> crontab_temp
crontab crontab_temp
rm crontab_temp

# .bashrc only works on creating a interactive non-login shell. 
# we want the scrip to be executed on login. So, we are going with a crontab entry

# inject script into ~/.bashrc
# if mv -n ~/.bashrc ~/.bashrc-bck-$(date +"%Y-%m-%d"); then # backup .bashrc
#     echo -e "Backed up the current .bashrc to .bashrc-bck-$(date +\"%Y-%m-%d\")\n"
# fi
# echo "bash ~/.config/start_iap_tunnel.sh visma-fin-app 29356" | sudo tee -a ~/.bashrc
# 
# source ~/.bashrc
