#!/bin/bash

boomiAuthenticationType=$1
boomiUserEmailID=$2
boomiPasswordORboomiAPIToken=$3
boomiAccountID=$4
atomName=$5
deploymentName=$6

sudo apt-get update
sudo dpkg -l | grep openjdk  
sudo apt-get remove openjdk-8-jre-headless -y
sudo apt-get install openjdk-8-jre -y
#sudo apt install openjdk-8-jre-headless -y

sudo apt-get update
sudo apt-get install wget

wget -P /usr/local/boomi https://platform.boomi.com/atom/atom_install64.sh && chmod +x /usr/local/boomi/atom_install64.sh
#chmod 777 /usr/local/boomi/atom_install64.sh

#AuthType=$(echo "${boomiAuthenticationType}" | xargs)
#AuthType=$(echo "$AuthType" | tr '[:lower:]' '[:upper:]')
if [ $1 = "Token" ]
then
 echo "Install Atom using Token"
 echo "boomiPasswordORboomiAPIToken: $boomiPasswordORboomiAPIToken"
 echo "atomName: $atomName"
 echo "boomiAccountID: ${boomiAccountID}"
 sudo /usr/local/boomi/atom_install64.sh -q console -VinstallToken="${boomiPasswordORboomiAPIToken}" -VatomName="${atomName}" -VaccountId="${boomiAccountID}" -dir "/opt/boomi/"        
else
 echo "Install Atom using Password"
 sudo /usr/local/boomi/atom_install64.sh -q console -Vusername="${boomiUserEmailID}" -Vpassword="${boomiPasswordORboomiAPIToken}" -VatomName="${atomName}" -VaccountId="${boomiAccountID}" -dir "/opt/boomi/"        
fi
