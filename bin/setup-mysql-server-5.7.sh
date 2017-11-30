#!/bin/bash
echo "-------------------------------\n"
echo "---- MySQL 5.7 Installation ---\n"
echo "-------------------------------\n\n"

echo -e "Updating packages... "
sudo apt-get update
echo -e "Done\n"

echo -e "Setting passwords... "
DEFAULTPASS="vagrant"
sudo debconf-set-selections <<EOF
mysql-server    mysql-server/root_password password $DEFAULTPASS
mysql-server    mysql-server/root_password_again password $DEFAULTPASS
dbconfig-common dbconfig-common/mysql/app-pass password $DEFAULTPASS
dbconfig-common dbconfig-common/mysql/admin-pass password $DEFAULTPASS
dbconfig-common dbconfig-common/password-confirm password $DEFAULTPASS
dbconfig-common dbconfig-common/app-password-confirm password $DEFAULTPASS
phpmyadmin      phpmyadmin/reconfigure-webserver multiselect apache2
phpmyadmin      phpmyadmin/dbconfig-install boolean true
phpmyadmin      phpmyadmin/app-password-confirm password $DEFAULTPASS 
phpmyadmin      phpmyadmin/mysql/admin-pass     password $DEFAULTPASS
phpmyadmin      phpmyadmin/password-confirm     password $DEFAULTPASS
phpmyadmin      phpmyadmin/setup-password       password $DEFAULTPASS
phpmyadmin      phpmyadmin/mysql/app-pass       password $DEFAULTPASS
EOF
echo -e "Done\n"

echo -e "Installing MySQL... "
sudo apt-get install mysql-server-5.7 mysql-client --assume-yes --force-yes
echo -e "Done\n"

echo -e "Granting permission to the host machine... "
mysql -u root --password=vagrant -e "grant all privileges on *.* to 'root'@'%' identified by 'vagrant' with grant option;flush privileges;"
sudo cp /vagrant/mysqld.cnf /etc/mysql/mysql.conf.d/
echo -e "Done\n"

echo -e "Restarting MySQL Service... "
sudo service mysql restart
echo -e "Done\n"

echo -e "Installation complete!\n\n"