#!/bin/bash

ODOOVERSION=11.0
DEPTH=10
PATHBASE=~/Developments/odoo11
PATHREPOS=~/Developments/odoo11/extra-addons

# Update and install Postgresql
sudo apt-get update
sudo apt-get install -y git
sudo apt-get install postgresql -y
sudo su - postgres -c "createuser -s $USER"

mkdir ~/Developments
mkdir $PATHBASE
mkdir $PATHREPOS
cd $PATHBASE

# Download Odoo from git source
git clone https://github.com/odoo/odoo.git -b $ODOOVERSION --depth $DEPTH

# Install python3 and dependencies for Odoo
sudo apt-get install gcc python3-dev libxml2-dev libxslt1-dev \
 libevent-dev libsasl2-dev libldap2-dev libpq-dev \
 libpng-dev libjpeg-dev

sudo apt-get -y install python3 python3-pip python-pip
sudo pip3 install vobject qrcode num2words setuptools

# Install nodejs and less
sudo apt-get install -y npm
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g less

# install WKHTMLTOPDF
sudo apt-get install wkhtmltopdf

# to respect the original script (dpkg -i wkhtml*)
sudo apt-get install wkhtmltoimage

# install python requirements file (Odoo)
# sed -i '/pyldap/d' $PATHBASE/odoo/requirements.txt
sudo pip3 install -r $PATHBASE/odoo/requirements.txt
