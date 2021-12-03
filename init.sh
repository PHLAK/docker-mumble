#!/bin/bash

#take the password / welcometext from ENV, if none was delivered, replace with empty string
SERVERPASSWORD=${SERVERPASSWORD:-}
WELCOMETEXT=${WELCOMETEXT:-}
welcome_text=`cat $WELCOMETEXTFIlE`

#insert the password
sed -i.bak 's/'REPLACEME'/'$SERVERPASSWORD'/g' /etc/mumble/config/mumble-server.ini
#insert the welcometext
sed -i.bak 's;'WELCOMETEXT';'$WELCOMETEXT';g' /etc/mumble/config/mumble-server.ini
#insert welcometextfile
#sed -i.bak "/welcometext=/a\welcometextfile=$WELCOMETEXTFIlE" /etc/mumble/config/mumble-server.ini
#sed -i.bak 's;welcometext="";welcometext=\"'$WELCOMETEXTFIlE'\";g' /etc/mumble/config/mumble-server.ini
#sed -i.bak "s|welcometext=\"\"|welcometext=\"$welcome_text\"|" /etc/mumble/config/mumble-server.ini
sed -i -e '/welcometext=""/{r '$WELCOMETEXTFIlE'' -e 'd}' /etc/mumble/config/mumble-server.ini
wait
# start the server
/opt/mumble/murmur.x86 -fg -ini /etc/mumble/config/mumble-server.ini -supw $SUPERUSERPW
