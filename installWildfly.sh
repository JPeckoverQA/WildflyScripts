#!/bin/bash

#install wildfly

#update
sudo apt update

#install curl and wget
sudo apt-get install curl
sudo apt-get install wget

#install java
sudo apt install -y wget openjdk-8-jdk openjdk-8-jre

#install maven
sudo apt install -y maven

#create a user
sudo groupadd -r wildfly
sudo useradd -r -g wildfly -d /opt/wildfly -s /sbin/nologin wildfly

#download wildfly
WILDFLY_VERSION=10.1.0.Final
wget https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz -P /tmp

#extract tar.gz file
sudo tar xf /tmp/wildfly-$WILDFLY_VERSION.tar.gz -C /opt/

#create a symbolic link to wildfly
sudo ln -s /opt/wildfly-$WILDFLY_VERSION /opt/wildfly

#change directory ownership to wildfly
sudo chown -RH wildfly: /opt/wildfly

#configure systemd
#create directory for wildfly configuration file
sudo mkdir -p /etc/wildfly

#copy config file to /etc/wildfly
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/

#copy wildfly launch.sh to /opt/wildfly/bin/
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/

#ensure scripts in bin are executable
sudo sh -c 'chmod +x /opt/wildfly/bin/*.sh'

#copy systemd unit file to /etc/systemd/system/ directory
sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/

#reload systemd
sudo systemctl daemon-reload

#start wildfly service
sudo systemctl start wildfly

#check service status
sudo systemctl status wildfly

#enable start at boot time
sudo systemctl enable wildfly

#allow traffic on port 808
sudo ufw allow 8080/tcp







#install maven
#sudo apt install maven

#install h2 database
#curl -o h2database.jar http://central.maven.org/maven2/com/h2database/h2/1.4.197/h2-1.4.197.jar




