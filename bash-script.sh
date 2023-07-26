#!/bin/bash

echo "boomiAuthenticationType:$1"
echo "boomiUserEmailID:$2"
echo "boomiPasswordORboomiAPIToken:$3"
echo "boomiAccountID:$4"
echo "atomName:$5"
echo "deploymentName:$6"

sudo apt-get update
sudo apt install openjdk-8-jre-headless -y

sudo apt-get update
sudo apt-get install wget

wget -P /usr/local/boomi https://platform.boomi.com/atom/atom_install64.sh && chmod +x /usr/local/boomi/atom_install64.sh
#chmod 777 /usr/local/boomi/atom_install64.sh

#AuthType=$(echo "${boomiAuthenticationType}" | xargs)
#AuthType=$(echo "$AuthType" | tr '[:lower:]' '[:upper:]')
if [ "${boomiAuthenticationType}" -eq "Token" ]
then
 echo "Install Atom using Token"
 sudo /usr/local/boomi/atom_install64.sh -q console -VinstallToken="atom-2845082b-2167-4fe7-b9f1-f48a1be397e9" -VatomName="Test-Linux-Atom" -VaccountId="pwc-UWWBSP" -dir "/opt/boomi/"        
else
 echo "Install Atom using Password"
 sudo /usr/local/boomi/atom_install64.sh -q console -Vusername=${boomiUserEmailID} -Vpassword=${boomiPasswordORboomiAPIToken} -VatomName=${atomName} -VaccountId=${boomiAccountID} -dir "/opt/boomi/"        
fi
