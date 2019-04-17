echo -e "\nUpdating package lists..\n"
sudo apt-get -y update

#install Ngnix
echo -e "\nInstalling Ngnix server...\n"
sudo fuser -k 80/tcp
sudo apt-get -y install nginx


#install Mysql server
echo -e "\nInstalling Mysql server...\n"
#default password is root
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server

#install Mysql server
echo -e "\nInstalling PHP-FPM and Mysql extension for PHP...\n"
sudo apt-get install python-software-properties software-properties-common
sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get -y install php7.2-fpm php-mysql
sudo apt-get install php7.2-mysql
sudo apt install php7.1-mcrypt
sudo ln -s /etc/php/7.1/mods-available/mcrypt.ini /etc/php/7.2/mods-available/
sudo phpenmod mcrypt

#Move nginx conf file to enable php support on ngnix
echo -e "\nMoving Nginx configuration file...\n"
sudo mv default /etc/nginx/sites-available

#Move php testing file
echo -e "\nMoving php testing file...\n"
sudo mv info.php /var/www/html/
#PhpMyAdmin
sudo apt install phpmyadmin

sudo systemctl restart nginx.service
sudo systemctl restart php7.2-fpm

echo -e "\n\nLemp stack installed successfully :)\n"

echo -e "\n Open following link to check installed PHP configuration your_ip/info.php"
