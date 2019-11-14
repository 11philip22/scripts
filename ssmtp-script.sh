#!/bin/bash

set -eu
emailadres="emailadres"


if [[ $EUID -ne 0 ]]; then
   echo "Voer dit script uit met SUDO rechten" 1>&2
   exit 1
fi

while true; do
echo "Uw computer moet uptodate zijn voor het installeren van mailutils en ssmtp"    
echo ""
read -p "Is uw computer up-to-date? (y/n)" yn
  case $yn in 
	[Yy] ) break;;
	[Nn] ) echo "Uw systeem wordt geupdate." && sleep 3 &&  sudo apt update && break ;;
           * ) echo "Gelieve antoorden met y of n "
  esac
done


echo "controleren of ssmtp en mailutils geinstalleerd zijn"
while true; do
if sudo dpkg -s ssmtp | grep  "Status: install ok installed"

then read -p "ssmtp is reeds geinstalleerd. Wilt u een backup maken van de huidige configuratie? (y/n)" yn
  case $yn in
       [Yy]  ) echo "Backup maken van huidige ssmtp configuratie" && sudo mv /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.orig && break;;
       [Nn]  ) break;;
          *  ) echo "gelieve antwoorden met y of n"
  esac

else echo "ssmtp en mailutils worden gedownload" && \
	   sleep 2  && \
	   sudo apt-get install -y ssmtp mailutils  >/dev/zero &&  break
fi
done

sleep 2

echo "ssmtp configuratie"

read -p "voer uw gmail adres in : " -i "$emailadres" emailadres
while true; do
read -s -p "wachtwoord: " wachtwoord
echo
read -s -p "wachtoord opnieuw: " wachtwoord2
echo
[ "$wachtwoord" = "$wachtwoord2" ] && break
echo "wachtwoord komt niet overeen"
done 

#read -p "voer uw wachtwoord in voor email adres $emailadres : " -i "$wachtwoord" -s wachtwoord
  
echo "
# Config file for sSMTP sendmail
#
# The person who gets all mail for userids < 1000
# Make this empty to disable rewriting.
#root=postmaster
root=$emailadres
# The place where the mail goes. The actual machine name is required no
# MX records are consulted. Commonly mailhosts are named mail.domain.com
#mailhub=mail
mailhub=smtp.gmail.com:587

AuthUser=$emailadres
AuthPass=$wachtwoord
UseTLS=YES
UseSTARTTLS=YES


# Where will the mail seem to come from?
#rewriteDomain=
rewriteDomain=gmail.com

# The full hostname
#hostname=MyMediaServer.home
hostname=$HOSTNAME

# Are users allowed to set their own From: address?
# YES - Allow the user to specify their own From: address
# NO - Use the system generated From: address
FromLineOverride=YES " > /etc/ssmtp/ssmtp.conf

#verstuur mail met de volgende commando's:
echo "" 
echo "" 

#echo "Dit is de inhoud van de mail" | mail -s "onderwerp van de mail" emailadres@gmail.com 
echo "testmail wordt verzonden naar $emailadres"

echo "Dit is de inhoud van de mail" | mail -s "onderwerp van de mail" $emailadres
#echo "klaar!!"
exit

 

