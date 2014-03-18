#!/bin/bash

read -p "Enter the hostname of the Alfresco endpoint: " alfresco
read -p "Enter MySQL hostname: " mysql_host
read -p "Use default settings? [y/n] " defaults

port="8080"
proto="https"
if [ `echo $defaults | tr a-Z A-Z`  != "Y" ]; then
	read -p "Enter MySQL port: " mysql_port
	read -p "Enter MySQL username: " mysql_user
	read -p "Enter MySQL password: " mysql_pass
	read -p "Enter the port Alfresco number: " port
	read -p "Enter the Alfresco web protocol [http/https]: " proto
fi

sed -i "s/@@ALFRESCO_SHARE_SERVER@@/$alfresco/g" ../tomcat/alfresco-global.properties ../tomcat/share-config-custom.xml
sed -i "s/@@ALFRESCO_REPO_SERVER@@/$alfresco/g" ../tomcat/alfresco-global.properties ../tomcat/share-config-custom.xml
sed -i "s/@@ALFRESCO_SHARE_SERVER_PORT@@/$port/g" ../tomcat/alfresco-global.properties
sed -i "s/@@ALFRESCO_SHARE_SERVER_PROTOCOL@@/$proto/g" ../tomcat/alfresco-global.properties

sed -i "s/@@MYSQL_USER@@/$mysql_user/g" ../tomcat/alfresco-global.properties
sed -i "s/@@MYSQL_PASS@@/$mysql_pass/g" ../tomcat/alfresco-global.properties
sed -i "s/@@MYSQL_HOST@@/$mysql_host/g" ../tomcat/alfresco-global.properties
sed -i "s/@@MYSQL_PORT@@/$mysql_port/g" ../tomcat/alfresco-global.properties
