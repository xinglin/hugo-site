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

1. Update packages  
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