+++
author = "Xing Lin"
title = "Install hotCRP at a Ubuntu 14 Machine"
description = ""
tags = [
    "hotCRP",
		"note",
]
date = "2018-04-12"
+++

0. Update packages  
        ``sudo apt-get update``
2. Install required packages
        ``sudo apt-get install git apache2 php5 php5-mysql mysql-server zip poppler-utils sendmail``  
3. Get hotCRP source code  
	``git clone https://github.com/kohler/hotcrp.git``  
4. Create the Database for hotCRP
	``lib/createdb.sh --user root --password``
5. Add the read permission for conf/options.conf
	``chmod +r conf/options.conf``	
6. Add the directory to /etc/apache2/apache2.conf
```<Directory "/w/hotcrp">
     Options Indexes Includes FollowSymLinks
     AllowOverride all
     Require all granted
</Directory>
Alias /hotcrp /w/hotcrp
```
7. Restart apache web server
	``sudo service apache2 restart``
8. The website is up and running. Visit `IP_address/hotcrp` to check it out.
9. Set `upload_max_filesize`, `post_max_size`, and `max_input_vars` in hotcrp/.htaccess file. Use default values are good enough. 
10. Increase session gc time for php in /etc/php5/apache2/php.in. 
```session.gc_maxlifetime = 86400```

### Notes ###
I tried to install php7.2 and php5.6. But the website did not seem to work. So, I stayed with php5.5.9, coming with ubuntu14 by default. 

* How to install php7?
1. Install software-properties-common package to get the add-apt-repository command.
	``sudo apt-get install software-properties-common``
2. Add php7 ppa and do an update
	``sudo add-apt-repository ppa:ondrej/php``	
	``sudo apt-get update``
3. Install php7
	``sudo apt-get install php7.2 php7.2-mysql``