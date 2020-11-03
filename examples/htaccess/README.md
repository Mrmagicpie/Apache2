<link rel="stylesheet" href="https://apache.mrmagicpie.xyz/custom-assets/style.css">
<h1 align="center">Apache2 htaccess Examples!</h1>

<h2>Removing .HTML and .PHP from a file.</h2>

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

<a href="https://apache.mrmagicpie.xyz/examples/htaccess/HTML+PHP.htaccess" class="button">Download an example!</a>