<link rel="stylesheet" href="https://apache.mrmagicpie.xyz/custom-assets/style.css">
<h1 align="center">Apache2 Scripts!</h1>

Hey! You found the *easy* way to use Apache2. I have made these scripts to easily let people install, and manage their own Apache2 server. I am still learning bash scripts so please bear with me. Feel free to fork this repository, make appropriate edits, and then pull request!
- Mrmagicpie

<h2>Warning:</h2>

   I am under no circumstances liable for anything that happens to your server/data/anything else that comes from the use of any of my provided **for free** materials. By using any of my materials you agree to the License located here: [Apache.Mrmagicpie.xyz/legal](https://apache.mrmagicpie.xyz/legal) or here: [GitHub.com/Mrmagicpie/Apache2/blob/main/legal/README.md](https://github.com/mrmagicpie/apache2/blob/main/legal/README.md)

<h2>FAQ</h2>

<h3>How do I use one of these scripts?</h3>

Firstly, either copy the script manually or use
```
git clone https://github.com/mrmagicpie/apache2
``` 
then you'll want to use 
```
sh (file name).sh
``` 
to run the script.

<h3>What do I need to use this?</h3>

All pre-requisits will be shown in the First message sent by the script. Most times, you will need a fully qualified domain name, and an SSL certificate to go with it! 

These scripts are currently only supported on Ubuntu. Feel free to try them on Debian, or any other Linux OS, though I give no garuntee that it will work!

SSL can be obtained for free here:
- <a href="https://cloudflare.com">https://cloudflare.com</a>
- <a href="https://letsencrypt.org">https://letsencrypt.org</a>


<h2>The scripts don't work!</h2>

Well then, most likely, you're using the script wrong. Please follow the instructions in the script. Feel free to review the script source before trying to use it to make sure you know what you're doing! 

If you really believe the script is broken please feel free to make an issue on this repository directly telling us where the issues are, and how we can reproduce them.

<h2 align="center">Currently Available Scripts:</h2>

<p align="center"><a href="https://apache.mrmagicpie.xyz/scripts/basic-install.sh" class="button">Basic Install!</a></p>
<p align="center"><a href="https://apache.mrmagicpie.xyz/scripts/basic-install-port.sh" class="button">Basic Install Port!</a></p>
<p align="center"><a href="https://apache.mrmagicpie.xyz/scripts/add-site.sh" class="button">Add a site!</a></p>
<p align="center"><a href="https://apache.mrmagicpie.xyz/scripts/add-vhost.sh" class="button">Add a VHost!</a></p>

<h2 align="center">Currently Available Scripts with descriptions:</h2>

<h3>Basic Install</h3>

The basic install script is what it says. It will do a basic install of Apache2, and PHP. It will configure your root domain(ex. mrmagicpie.xyz), a www subdomain(ex. www.mrmagicpie.xyz), and a wildcard redirect(so any other subdomain will auto redirect). You may choose to enable Apache access files, ``.htaccess``. And it will auto configure ``index.php`` files to be used first. 

<h4>Prerequisites</h4>

- SSL
- Ubuntu server with SSH sudo/root access
- Modivation to learn Apache

<h3>Basic Install Port</h3>

This script is the same as the basic install, but this one will ask you which port to use. I do not recommend using the following ports:
```
21 (FTP)
22 (SSH)
25 (SMTP)
53 (DNS)
80 (in default script)
143 (IMAP)
443 (in default script)
465 (SMTP)
587 (SMTP)
3306 (MySQL)
```
You will be prompted to confirm if you want to use one of these ports.

<h4>Prerequisites</h4>

- SSL
- Ubuntu server with SSH sudo/root access
- Modivation to learn Apache

<h3>Add a site</h3>

Add a site is a script to add a domain to your server. This is the same concept as the basic install, but this **will not** install Apache2 or PHP. 

<h4>Prerequisites</h4>

- SSL
- Ubuntu server with SSH sudo/root access
- Modivation to learn Apache

<h3>Add a VHost</h3>

A VHost is the declaration of a connection. You need a VHost for any domain you want to be able to access your server. 

<h4>Prerequisites</h4>

- SSL
- Ubuntu server with SSH sudo/root access
- Modivation to learn Apache

