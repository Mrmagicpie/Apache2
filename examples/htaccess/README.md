<link rel="stylesheet" href="https://apache.mrmagicpie.xyz/custom-assets/style.css">

<h1 align="center">Apache2 htaccess Examples!</h1>

This section is devoted to the Apache Access File(.htaccess)!

<h2>Removing .HTML and .PHP from a file.</h2>

To remove the .html and .php from a file name, we need to rewrite the url. In order to do this we need to enable mod_rewrite with this command:

```
a2enmod rewrite
```
and then restart Apache with
```
service apache2 restart
```
**or**
``` 
systemctl restart apache2
```

Below is an example of some code we can use to rewrite the url. Generally, I would keep this code together to always be able to rewrite html and php.

```
RewriteEngine on 
RewriteCond %{THE_REQUEST} \s/+(.*?/)?(?:index)?(.*?)\.(php|html)[\s?/] [NC]
RewriteRule ^ /%1%2 [R=302,L,NE]
RewriteCond %{REQUEST_FILENAME}   !-f 
RewriteCond %{REQUEST_FILENAME}\.php -f 
RewriteRule ^(.*) /$1.php [L]
RewriteCond %{REQUEST_FILENAME}   !-f 
RewriteCond %{REQUEST_FILENAME}\.html -f
RewriteRule ^(.*) /$1.html [L]
RewriteCond %{REQUEST_FILENAME}   !-f 
RewriteCond %{REQUEST_URI} !\/$
RewriteRule ^(.*) %{REQUEST_URI}/ [L,R=302]
```
<br> </br>
<p align="center"><a href="https://apache.mrmagicpie.xyz/examples/htaccess/HTML+PHP.htaccess" class="button">Download an example!</a></p>

<h2>Redirects!</h2>

For redirects, we don't need anything special. As long as you have htaccess files enabled, you can use a redirect. Redirects are pretty straight forward. State you want to use a redirect, tell the browser the status code <i>[here's a detailed version of HTTP status codes](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)</i>, specify the redirecting from address, and then the redirecting to address.

**Notes:**
- Redirecting from addresses must be accessable from the main url
    ex: https://hi.mrmagicpie.xyz is **not** accessable from https://mrmagicpie.xyz
    **but** https://mrmagicpie.xyz/hi is

- Redirecting to addresses can redirect anywhere, to specify somewhere not on the same hostname you must supply a protol(ex. HTTP/HTTPS)

```
# Redirecting blog.html to a blog subdomain
Redirect 301 /blog.html https://blog.mrmagicpie.xyz

# Redirecting a Directory to another location
Redirect 302 /store/ /blog/store.php
```

Notice the status codes. 
- 301 = Permanent
- 302 = Temporary

Permanent will be cached by the browser, and will not change very often. Temporary will be fetched by the browser everytime, this is best for testing redirects.
<br> </br>
<p align="center"><a href="https://apache.mrmagicpie.xyz/examples/htaccess/HTML+PHP.htaccess" class="button">Download an example!</a></p>
<br> </br>
<p align="center">Mrmagicpie (c) 2020 - <a href="https://apache.mrmagicpie.xyz">Return Home</a></p>
