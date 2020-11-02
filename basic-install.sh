
# Basic Apache Config Setup

# https://Apache.Mrmagicpie.xyz

if [ "$#" != "1" ]; then

	echo "|-------------------------------------------| "
	echo "|Error! Please input the required arguments!|"
	echo "|	sh basic.sh (domain)                      |"
	echo "|	example: sh basic.sh mrmagicpie.xyz       |"
	echo "|-------------------------------------------|"

	exit

fi;

echo "|-------------------------------------------|"
echo "|Configure Apache2 with the domain: $1?    |"
echo "|                                           |"
echo '|Please say "y" to continue, and "n" to stop|'
echo "|-------------------------------------------|"

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

echo "|-------------------------------------------|"
echo "|This Configuration requires SSL!           |"
echo "|Do you have SSL pregenerated?              |"
echo "|                                           |"
echo '|Please say "y" to continue, and "n" to stop|'
echo "|-------------------------------------------|"

read ssl_yes
if [ "$pem_yes" = "n" ] || [ "$pem_yes" = "no" ]; then

        echo "|----------------------------------|"
        echo "|Exiting Apache2 configuration.    |"
        echo "|You will need SSL. You can get SSL|"
	echo "|from CloudFlare or LetsEncrypt!   |"
	echo "|----------------------------------|"

        exit

elif [ "$continue" != "y" ]; then

        echo "|---------------|"
        echo "|Invalid option!|"
        echo "|---------------|"

        exit

fi;

echo "|------------------------------------------------|"
echo "|This Configuration requires SSL!                |"
echo "|                                                |"
echo '|Please say below what your "pem" file is called!|'
echo "|         It must be in this Directory!          |"
echo "|------------------------------------------------|"
read pem

echo "|------------------------------------------------|"
echo "|This Configuration requires SSL!                |"
echo "|                                                |"
echo '|Please say below what your "key" file is called!|'
echo "|         It must be in this Directory!          |"
echo "|------------------------------------------------|"
read key

dir=$(dirname "$0")

echo "|------------------------------------------------|"
echo '|Please confirm this information:                |'
echo "|                                                |"
echo '|Your pem file is located at: $dir/$pem.pem      |'
echo "|Your key file is located at: $dir/$key.key      |"
echo "|                                                |"
echo '|Please say "y" to continue, and "n" to stop     |'
echo "|------------------------------------------------|"

read ssl_dir
if [ "$ssl_dir" = "n" ] || [ "$continue" = "no" ]; then

        echo "|------------------------------------------------|"
        echo "|Please confirm your SSL location, and try again.|"
        echo "|------------------------------------------------|"

elif [ "$ssl_dir" != "y" ]; then

        echo "|--------------------------------|"
        echo "|We will confirm package installs|"
        echo "|--------------------------------|"

fi

echo "|-----------------------------------|"
echo "|Prompt to confirm package installs?|"
echo "|                                   | "
echo '|Please say "y" for yes, "n" for no.|'
echo "|-----------------------------------|"

read pkg
if [ "$pkg" = "n" ] || [ "$continue" = "no" ]; then

        echo "|------------------------------------|"
        echo "|We will not confirm package installs|"
        echo "|------------------------------------|"

	sleep 1

        #apt-get install -y apache2 php

elif [ "$pkg" != "n" ]; then

        echo "|--------------------------------|"
        echo "|We will confirm package installs|"
        echo "|--------------------------------|"

	sleep 1

	#apt-get install apache2 php

fi;

# Config File
conf="/etc/apache2/sites-available/$1.conf"
touch "$conf"

# Document Root
mkdir "/var/www/$1"
mkdir "/var/www/$1/logs"
mkdir "/var/www/$1/website"

# SSL
mkdir "/ssl"
mv "./$pem" "/ssl/$1.pem"
mv "./$key" "/ssl/$1.key"

echo "# " >> "$conf"
echo "# " >> "$conf"
echo "# $1 Apache2 Configuration File" >> "$conf"
echo "# https://Apache.Mrmagicpie.xyz" >> "$conf"
echo "# " >> "$conf"
echo "# " >> "$conf"
echo " " >> "$conf"
echo "# Root No-SSL" >> "$conf"
echo " " >> "$conf"
echo "<VirtualHost *:80>" >> "$conf"
echo " " >> "$conf"
echo "	ServerName $1 " >> "$conf"
echo "	ServerAlias www.$1" >> "$conf"
echo " " >> "$conf"
echo "	Redirect 302 / https://$1" >> "$conf"
echo "	ErrorLog /var/www/$1/logs/error.log" >> "$conf"
echo "	CustomLog /var/www/$1/logs/access.log combined" >> "$conf"
echo " " >> "$conf"
echo "</VirtualHost>" >> "$conf"
echo " " >> "$conf"
echo "# Root SSL" >> "$conf"
echo " " >> "$conf"
echo "<VirtualHost *:443>" >> "$conf"
echo " " >> "$conf"
echo "  ServerName $1 " >> "$conf"
echo "  ServerAlias www.$1" >> "$conf"
echo " " >> "$conf"
echo "  DocumentRoot /var/www/$1/website" >> "$conf"
echo "  ErrorLog /var/www/$1/logs/error.log" >> "$conf"
echo "  CustomLog /var/www/$1/logs/access.log combined" >> "$conf"
echo " " >> "$conf"
echo "	SSLEngine on" >> "$conf"
echo "	SSLCertificateFile /ssl/$1.pem" >> "$conf"
echo "	SSLCertificateKeyFile /ssl/$1.key" >> "$conf"
echo " " >> "$conf"
echo "</VirtualHost>" >> "$conf"
echo " " >> "$conf"
echo "# Wildcard" >> "$conf"
echo " " >> "$conf"
echo "<VirtualHost *:80>" >> "$conf"
echo " " >> "$conf"
echo "  ServerName wildcard.$1 " >> "$conf"
echo "  ServerAlias *.$1" >> "$conf"
echo " " >> "$conf"
echo "  Redirect 302 / https://$1" >> "$conf"
echo "  ErrorLog /var/www/$1/logs/error.log" >> "$conf"
echo "  CustomLog /var/www/$1/logs/access.log combined" >> "$conf"
echo " " >> "$conf"
echo "</VirtualHost>" >> "$conf"

# Apache Configuation
a2enmod ssl
a2enmod rewrite
a2ensite $1


