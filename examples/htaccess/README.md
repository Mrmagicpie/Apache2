<style>
.myButton {
	box-shadow:inset 0px 1px 0px 0px #e184f3;
	background:linear-gradient(to bottom, #c123de 5%, #a20dbd 100%);
	background-color:#c123de;
	border-radius:6px;
	border:1px solid #a511c0;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #9b14b3;
}
.myButton:hover {
	background:linear-gradient(to bottom, #a20dbd 5%, #c123de 100%);
	background-color:#a20dbd;
}
.myButton:active {
	position:relative;
	top:1px;
}
</style>

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

<a href="https://apache.mrmagicpie.xyz/examples/htaccess/HTML+PHP.htaccess" class="myButton">Download an example!</a>