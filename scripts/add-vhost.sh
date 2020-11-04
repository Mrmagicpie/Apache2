
# Basic Apache Config Setup

# https://Apache.Mrmagicpie.xyz

dir=$(pwd)
ip4=$(curl ifconfig.me)

echo "|---------------------------------------------------------|"
echo "|                                                         |"
echo "|  Attention:                                             |"
echo "|     This script is designed to work with other install  |"
echo "|                     scripts here:                       |"
echo "|         https://Apache.Mrmagicpie.xyz/scripts/          |"
echo "|                                                         |"
echo "|---------------------------------------------------------|"
echo " "
echo "|---------------------------------------------------------|"
echo "|  Welcome to the Apache2 Add VHost config. Please make   |"
echo "|      sure you have a fully qualified domain name,       |"
echo "|            and a subdomain on that domain               |"
echo "|                                                         |"
echo "|Please type below your fully qualified root domain name: |"
echo "|             Example: mrmagicpie.xyz                     |"
echo "|---------------------------------------------------------|"

read domain

echo "|---------------------------------------------------------|"
echo "| Please type below your fully qualified subdomain below: |"
echo "|                Example: apache                          |" 
echo "|---------------------------------------------------------|"

read subdomain

echo "|-----------------------------------------------------------|"
echo "|Configure Apache2 with the domain: $subdomain.$domain?|"
echo "|                                                           |"
echo '|      Please say "y" to continue, and "n" to stop          |'
echo "|-----------------------------------------------------------|"

read continue

if [ "$continue" = "n" ] || [ "$continue" = "no" ]; then

	echo "|------------------------------|"
	echo "|Exiting Apache2 configuration.|"
	echo "|------------------------------|"

	exit

elif [ "$continue" != "y" ]; then

	echo "|---------------|"
	echo "|Invalid option!|"
	echo "|---------------|"

	exit

fi;

echo "|----------------------------------------------|"
echo "| Do you already have an Apache2 Configuration |"
echo "|        file for the domain $domain?  |"
echo "|                                              |"
echo '| Please say "y" to continue, and "n" to stop  |'
echo "|----------------------------------------------|"

read qconf

if [ "$qconf" = "n" ] || [ "$qconf" = "no" ]; then

	echo "|------------------------------|"
	echo "|Exiting Apache2 configuration.|"
    echo "|                              |"
    echo "|  Please complete an Install  |"
    echo "|  script, and then continue.  |"
	echo "|------------------------------|"

	exit

elif [ "$qconf" != "y" ]; then

	echo "|---------------|"
	echo "|Invalid option!|"
	echo "|---------------|"

	exit

fi;

echo "|---------------------------------------------------------|"
echo "|                                                         |"
echo "|           Please configure this DNS record!             |"
echo "|                 Name:   Type:   Target:                 |"
echo "|           $subdomain       A   $ip4          |"
echo "|                                                         |"
echo "|---------------------------------------------------------|"

sleep 2

# Config File
conf="/etc/apache2/sites-available/$domain.conf"

# Document Root
mkdir "/var/www/$domain/$subdomain"

echo """
# $subdomain No-SSL

<VirtualHost *:80>

	ServerName $subdomain.$domain

	Redirect 302 / https://$subdomain.$domain
	ErrorLog /var/www/$domain/logs/error.log
	CustomLog /var/www/$domain/logs/access.log combined

</VirtualHost>

# $subdomain SSL

<VirtualHost *:443>

    ServerName $subdomain.$domain

    DocumentRoot /var/www/$domain/$subdomain
    ErrorLog /var/www/$domain/logs/error.log
    CustomLog /var/www/$domain/logs/access.log combined

	SSLEngine on
	SSLCertificateFile /ssl/$domain.pem
	SSLCertificateKeyFile /ssl/$domain.key

</VirtualHost>
""" >> "$conf"

chmod -R 755 /var/www

service apache2 restart

echo """
|-----------------------------------------------------------|
|The Apache2 Configuration is now complete! You may have to |
|wait for DNS to update before using your site.             |
|                                                           |
|Upload your Website files to:                              |
|       /var/www/$domain/$subdomain            |
|To begin using Apache2.                                    |
|                                                           |
| Report issues or contribute here:                         |
|         https://github.com/Mrmagicpie/Apache2             |
|-----------------------------------------------------------|
"""

sleep 3

exit

#                       Mrmagicpie (c) 2020
#
#                       Apache.Mrmagicpie.xyz
#
#                   GitHub.com/Mrmagicpie/Apache2