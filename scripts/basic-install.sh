
# Basic Apache Config Setup

# https://Apache.Mrmagicpie.xyz

dir=$(pwd)
ip4=$(curl ifconfig.me)

echo "|---------------------------------------------------------|"
echo "|Welcome to the Apache2 Basic Install. Please make sure   |"
echo "|you have a fully qualified domain name, and SSL to match.|"
echo "|   Your SSL must be in $dir, in .pem, and .key files.    |"
echo "|                                                         |"
echo "|         Please configure three DNS records!             |"
echo "|                 Name:   Type:   Target:                 |"
echo "|                  @       A   $ip4                    |"
echo "|                  *       A   $ip4                    |"
echo "|                  www    CNAME     @                     |"
echo "|                                                         |"
echo "|Please type below your fully qualified domain name:      |"
echo "|         EX: mrmagicpie.xyz                              |"
echo "|---------------------------------------------------------|"

read domain

echo "|-------------------------------------------|"
echo "|Configure Apache2 with the domain: $domain?|"
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
echo "|Do you have SSL pre-generated?             |"
echo "|                                           |"
echo '|Please say "y" to continue, and "n" to stop|'
echo "|-------------------------------------------|"

read ssl_yes

if [ "$ssl_yes" = "n" ] || [ "$ssl_yes" = "no" ]; then

        echo "|----------------------------------|"
        echo "|Exiting Apache2 configuration.    |"
        echo "|You will need SSL. You can get SSL|"
	echo "|from CloudFlare or LetsEncrypt!   |"
	echo "|----------------------------------|"

        exit

fi;

echo "|------------------------------------------------|"
echo "|This Configuration requires SSL!                |"
echo "|                                                |"
echo '|Please say below what your "pem" file is called!|'
echo "|         It must be in this Directory!          |"
echo "|                                                |"
echo "| ex: mrmagicpie.xyz.pem                         |"
echo "|------------------------------------------------|"

read pem

echo "|------------------------------------------------|"
echo "|This Configuration requires SSL!                |"
echo "|                                                |"
echo '|Please say below what your "key" file is called!|'
echo "|         It must be in this Directory!          |"
echo "|                                                |"
echo "| ex: mrmagicpie.xyz.key                         |"
echo "|------------------------------------------------|"

read key

echo "|------------------------------------------------|"
echo '|Please confirm this information:                |'
echo "|                                                |"
echo "|Your pem file is located at: $dir/$pem          |"
echo "|Your key file is located at: $dir/$key          |"
echo "|                                                |"
echo '|Please say "y" to continue, and "n" to stop     |'
echo "|------------------------------------------------|"

read ssl_dir

if [ "$ssl_dir" = "n" ] || [ "$continue" = "no" ]; then

        echo "|------------------------------------------------|"
        echo "|Please confirm your SSL location, and try again.|"
        echo "|------------------------------------------------|"

        exit

fi;

echo "|-----------------------------------|"
echo "|     Install Apache2 and PHP?      |"
echo "|                                   | "
echo '|Please say "y" for yes, "n" for no.|'
echo "|-----------------------------------|"

read pkg

if [ "$pkg" = "n" ] || [ "$pkg" = "no" ]; then

        echo "|------------------------------|"
	echo "|Exiting Apache2 configuration.|"
        echo "|                              |"
        echo "|  You need Apache2 and PHP to |"
        echo "|    run an Apache2 server     |"
	echo "|------------------------------|"
        
        exit

elif [ "$pkg" != "n" ]; then

        echo "|--------------------------------|"
        echo "|   Installing Apache2 and PHP   |"
        echo "|--------------------------------|"

	sleep 1

	apt-get install apache2 php
        apt-get install php

fi;

# Config File
conf="/etc/apache2/sites-available/$domain.conf"
touch "$conf"

# Document Root
mkdir "/var/www/$domain"
mkdir "/var/www/$domain/logs"
mkdir "/var/www/$domain/website"

# SSL
mkdir "/ssl"
mv "./$pem" "/ssl/$domain.pem"
mv "./$key" "/ssl/$domain.key"

echo """#
#
# $domain Apache2 Configuration File
# https://Apache.Mrmagicpie.xyz
#
#

# Root No-SSL

<VirtualHost *:80>

	ServerName $domain
	ServerAlias www.$domain

	Redirect 302 / https://$domain
	ErrorLog /var/www/$domain/logs/error.log
	CustomLog /var/www/$domain/logs/access.log combined

</VirtualHost>

# Root SSL

Listen 443

<VirtualHost *:443>

        ServerName $domain
        ServerAlias www.$domain

        DocumentRoot /var/www/$domain/website
        ErrorLog /var/www/$domain/logs/error.log
        CustomLog /var/www/$domain/logs/access.log combined

	SSLEngine on
	SSLCertificateFile /ssl/$domain.pem
	SSLCertificateKeyFile /ssl/$domain.key

</VirtualHost>

# Wildcard

<VirtualHost *:80>

        ServerName wildcard.$domain
        ServerAlias *.$domain

        Redirect 302 / https://$domain
        ErrorLog /var/www/$domain/logs/error.log
        CustomLog /var/www/$domain/logs/access.log combined

</VirtualHost>
""" >> "$conf"

# Apache Configuation
a2enmod ssl
a2enmod rewrite
a2ensite $domain

echo "|------------------------------------------------|"
echo '|Would you like Apache Access Files(.htaccess)?  |'
echo "|                                                |"
echo '|   Please say "y" for yes, and "n" to stop      |'
echo "|------------------------------------------------|"

read htaccess

if [ "$htaccess" = "n" ] || [ "$htaccess" = "no" ]; then

        echo "|--------------------------------------------------------|"
        echo "|We will not configure Apache Access Files(.htaccess)!   |"
        echo "|                                                        |"
        echo "|The Apache2 Installation is now complete. If this didn't|"
        echo "|           work for you, please let us know!!           |"
        echo "|                                                        |"
        echo "|         https://github.com/Mrmagicpie/Apache2          |"
        echo "|--------------------------------------------------------|"

	sleep 1

        exit

fi;

chmod -R 755 /var/www

a2conf="/etc/apache2/apache2.conf"
mv "$a2conf" "/etc/apache2/default-apache2.conf.txt"
touch "$a2conf"

echo '''#
#
# Main Apache2 Configuration
# https://Apache.Mrmagicpie.xyz
#
#

# Timeout

Timeout 300
KeepAlive On
MaxKeepAliveRequests 100
KeepAliveTimeout 5

# Logs

ErrorLog ${APACHE_LOG_DIR}/error.log
LogLevel warn
LogFormat "%v:%p %h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined
LogFormat "%h %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %O" common
LogFormat "%{Referer}i -> %U" referer

# Mod/Site Includes

IncludeOptional mods-enabled/*.load
IncludeOptional mods-enabled/*.conf
IncludeOptional conf-enabled/*.conf
IncludeOptional sites-enabled/*.conf
Include ports.conf

# Directory Access

<Directory /var/www/>
	Options Indexes FollowSymLinks
	AllowOverride All
	Require all granted 
</Directory>
<Directory /usr/share>
	AllowOverride None
	Require all granted
</Directory>
<Directory />
	Options FollowSymLinks
	AllowOverride None
	Require all denied
</Directory>
<FilesMatch "^\.ht">
	Require all denied
</FilesMatch>

# Other Settings

User ${APACHE_RUN_USER}
Group ${APACHE_RUN_GROUP}
HostnameLookups Off
AccessFileName .htaccess
DefaultRuntimeDir ${APACHE_RUN_DIR}
PidFile ${APACHE_PID_FILE}
DirectoryIndex index.php index.html index.htm index.xml

#                       Mrmagicpie (c) 2020
#
#                       Apache.Mrmagicpie.xyz
#
#                   GitHub.com/Mrmagicpie/Apache2''' >> "$a2conf"

service apache2 restart

echo """
|-----------------------------------------------------------|
|The Apache2 Configuration is now complete! You may have to |
|wait for DNS to update before using your site.             |
|                                                           |
|Upload your Website files to:                              |
|       /var/www/$domain/website                            |
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