#!/bin/bash

#### Log the execution to a file ####

exec 3>&1 4>&2

trap 'exec 2>&4 1>&3' 0 1 2 3 RETURN

exec 1>/var/log/configure-bastion.log 2>&1

#sudo yum -y install java-1.8.0-openjdk
sudo apt-get update
sudo apt-get  install openjdk-8-jdk -y

#sudo yum -y install wget
sudo apt-get update
sudo apt-get install wget

wget -P /usr/local/boomi https://platform.boomi.com/atom/atom_install64.sh && chmod +x /usr/local/boomi/atom_install64.sh

AuthType=$(echo "${boomiAuthenticationType}" | xargs)
AuthType=$(echo "$AuthType" | tr '[:lower:]' '[:upper:]')
if [ $AuthType = TOKEN ]
then
 TOKEN="$(gsutil cat gs://${deploymentName}-bucket/token.txt | head -1 | base64 --decode)"
 gsutil rm gs://${deploymentName}-bucket/token.txt
 sudo /usr/local/boomi/atom_install64.sh -q console -VinstallToken=$TOKEN -VatomName=${atomName} -VaccountId=${boomiAccountID} -dir "/opt/boomi/"        
else
 Password="$(gsutil cat gs://${deploymentName}-bucket/token.txt | head -1 | base64 --decode)"
 gsutil rm gs://${deploymentName}-bucket/token.txt
 sudo /usr/local/boomi/atom_install64.sh -q console -Vusername=${boomiUserEmailID} -Vpassword=$Password -VatomName=${atomName} -VaccountId=${boomiAccountID} -dir "/opt/boomi/"        
fi
