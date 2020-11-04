
# Basic Apache Config Setup

# https://Apache.Mrmagicpie.xyz

dir=$(pwd)
ip4=$(curl ifconfig.me)

echo "|---------------------------------------------------------|"
echo "|Welcome to the Apache2 Add Site. Please make sure        |"
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

chmod -R 755 /var/www

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