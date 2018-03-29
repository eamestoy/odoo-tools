#!/bin/bash

ODOOVERSION=10.0
DEPTH=10
PATHBASE=~/Developments/odoo10
PATHREPOS=~/Developments/odoo10/extra-addons

wk32="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-i386.deb"
wk64="https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb"

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

sudo apt-get -y install python-pip
sudo pip install qrcode setuptools

# Install nodejs and less
sudo apt-get install -y npm
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g less

# Download & install WKHTMLTOPDF
rm wkhtml*
if [ "`getconf LONG_BIT`" == "32" ];

then
	wget $wk32
else
	wget $wk64
fi

sudo dpkg --force-depends -i wkhtmltox*.deb
sudo ln -s /usr/local/bin/wkhtml* /usr/bin

# install python requirements file (Odoo)
# sed -i '/pyldap/d' $PATHBASE/odoo/requirements.txt
sudo pip install -r $PATHBASE/odoo/requirements.txt


