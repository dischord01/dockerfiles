FROM ubuntu:12.04
MAINTAINER Brian Harrington <brian.harrington@coreos.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe multiverse" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN  DEBIAN_FRONTEND=noninteractive apt-get -y install curl openjdk-7-jre-headless imagemagick unzip libpostgresql-jdbc-java libmysql-java python-software-properties tomcat7

# Install the LibreOffice Repository to ensure that the latest packages are retrieved
RUN apt-add-repository -y ppa:libreoffice/libreoffice-4-2
# Install nginx from the PPA
#RUN apt-add-repository -y ppa:nginx/stable
# Install swftools from the PPA
RUN apt-add-repository -y ppa:swftools/stable
RUN apt-get update

# Install nginx and libreoffice from the extended PPAs added previously
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libreoffice nginx

# Install the SWF toolkit
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --force-yes install swftools

# This line accepts the Microsoft End User License Agreement allowing use of
#   the MS True Type core fonts 
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install fonts-droid msttcorefonts

# Remove apps not needed
RUN rm -rf /var/lib/tomcat7/webapps/* /etc/tomcat7/server.xml /etc/tomcat7/catalina.properties && mkdir -p /var/lib/tomcat7/endorsed /var/lib/tomcat7/shared/classes/alfresco/web-extension /var/lib/tomcat7/shared/classes/alfresco/extension 

### FIX - This file needs to be populated with data
ADD ./resources/tomcat/server.xml /etc/tomcat7/server.xml 
ADD ./resources/tomcat/catalina.properties /etc/tomcat7/catalina.properties 
ADD ./resources/tomcat/alfresco.conf /etc/init/alfresco.conf 

### FIX - This file needs to be populated with data
ADD ./resources/tomcat/alfresco-global.properties /var/lib/tomcat7/shared/classes/
RUN chown -R tomcat7:tomcat7 /var/lib/tomcat7 
RUN chown -R root:tomcat7 /etc/tomcat7 

ADD http://dl.alfresco.com/release/community/build-4848/alfresco-community-4.2.e.zip /tmp/

RUN unzip -q  /tmp/alfresco-community-4.2.e.zip -d /tmp/alfrescoinstall &&  cp /tmp/alfrescoinstall/web-server/webapps/*.war  /var/lib/tomcat7/webapps/ && cp /tmp/alfrescoinstall/web-server/endorsed/*.jar /var/lib/tomcat7/endorsed/
EXPOSE 8080
EXPOSE 8443

RUN keytool -genkey -alias tomcat -keyalg RSA   -keystore /root/.keystore -storepass changeit -keypass changeit -dname "CN=localhost, OU=Docker, O=CoreOS, L=San Francisco, S=California, C=US"

# Install PostgreSQL 
#RUN add-apt-repository ppa:pitti/postgresql && apt-get update && apt-get -y install postgresql-9.2 postgresql-client-9.2 postgresql-contrib-9.2
#RUN sudo -u postgres createuser -P -d -r -s alfresco && sudo -u postgres createdb -O alfresco alfresco


