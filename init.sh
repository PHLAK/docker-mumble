#!/bin/bash

#take the password / welcometext from ENV, if none was delivered, replace with empty string
SERVERPASSWORD=${SERVERPASSWORD:-}
WELCOMETEXT=${WELCOMETEXT:-}
welcome_text=`cat $WELCOMETEXTFIlE`

#insert the password
sed -i.bak 's/'REPLACEME'/'$SERVERPASSWORD'/g' /etc/murmur/murmur.ini
#insert the welcometext
sed -i.bak 's;'WELCOMETEXT';'$WELCOMETEXT';g' /etc/murmur/murmur.ini
#insert welcometextfile
#sed -i.bak "/welcometext=/a\welcometextfile=$WELCOMETEXTFIlE" /etc/murmur/murmur.ini
#sed -i.bak 's;welcometext="";welcometext=\"'$WELCOMETEXTFIlE'\";g' /etc/murmur/murmur.ini
#sed -i.bak "s|welcometext=\"\"|welcometext=\"$welcome_text\"|" /etc/murmur/murmur.ini
sed -i -e '/welcometext=""/{r '$WELCOMETEXTFIlE'' -e 'd}' /etc/murmur/murmur.ini
wait
# start the server
/usr/bin/mumble-server -v -fg -ini /etc/murmur/murmur.ini
