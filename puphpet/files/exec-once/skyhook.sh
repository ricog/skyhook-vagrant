#!/bin/bash

# Clone the skyhook repo and install dependencies
cd /var/www
git clone https://github.com/projectskyhook/skyhook.git
cd skyhook
composer install
git submodule update --init --recursive

# Clear the mysql password for skyhook user
mysql -p123 -u root -e 'UPDATE user SET password=PASSWORD("") WHERE user="skyhook"; flush privileges;' mysql

# Import the skyhook database files. Purchases is imported first because of a
# foreign key constraint.
cat database/purchases.sql database/*.sql > /tmp/skyhook-db.sql
mysql -p123 -u root skyhook < /tmp/skyhook-db.sql
rm /tmp/skyhook-db.sql

# Link the USD pricing providers
if [ ! -e "includes/PricingProviders" ]; then
	ln -s Pricing/Providers/USD includes/PricingProviders
fi

# Setup tmp_disk folder. I think this allows the config to be stored temporarily
# to disk. Adding the folder gets us further.
sudo mkdir /tmp_disk;
sudo chmod 777 /tmp_disk;

# Add phplog balanceCalc folder. This is needed to get past an error during
# transaction processing. This may need something more.
sudo mkdir -p /home/pi/phplog/balanceCalc
sudo chmod 777 /home/pi/phplog/balanceCalc
