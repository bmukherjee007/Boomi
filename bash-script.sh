#!/bin/bash

echo "boomiAuthenticationType:$1"
echo "boomiUserEmailID:$2"
echo "boomiPasswordORboomiAPIToken:$3"
echo "boomiAccountID:$4"
echo "atomName:$5"
echo "deploymentName:$6"

boomiAuthenticationType=$1
boomiUserEmailID=$2
boomiPasswordORboomiAPIToken=$3
boomiAccountID=$4
atomName=$5
deploymentName=$6

echo "$boomiAuthenticationType"
echo "$boomiUserEmailID"

echo $@

sudo apt-get update
sudo apt install openjdk-8-jre-headless -y

sudo apt-get update
sudo apt-get install wget

wget -P /usr/local/boomi https://platform.boomi.com/atom/atom_install64.sh && chmod +x /usr/local/boomi/atom_install64.sh
#chmod 777 /usr/local/boomi/atom_install64.sh

#AuthType=$(echo "${boomiAuthenticationType}" | xargs)
#AuthType=$(echo "$AuthType" | tr '[:lower:]' '[:upper:]')
if [ "$1" == "Token" ]; then
 echo "Install Atom using Token"
 sudo /usr/local/boomi/atom_install64.sh -q console -VinstallToken="$3" -VatomName="$5" -VaccountId="$4" -dir "/opt/boomi/"        
else
 echo "Install Atom using Password"
 sudo /usr/local/boomi/atom_install64.sh -q console -Vusername="$2" -Vpassword="$3" -VatomName="$5" -VaccountId="$4" -dir "/opt/boomi/"        
fi
