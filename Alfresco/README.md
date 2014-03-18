# Alfresco & Docker 

## Description 
This Dockerfile will set up Alfresco inside of an Ubuntu Precise (12.04) 
container running Tomcat 7.  

### Instructions 
There are a number of files in the `resources`
directory which should be configured prior to running `docker build`. These 
files are as follows:

- **resources/tomcat/share-config-custom.xml**
- **resources/tomcat/server.xml**
- **resources/tomcat/alfresco-global.properties**
- **resources/tomcat/tomcat-users.xml**
- **resources/tomcat/catalina.properties**


### File Descriptions 

#### resources/tomcat/share-config-custom.xml
This file defines the configuration of the **share** web application.  This 
webapp requires the following options configured:

- `@@ALFRESCO_REPO_SERVER@@`
- `@@ALFRESCO_SHARE_SERVER@@`

#### resources/tomcat/server.xml
This file defines the port numbers which Tomcat will listen on and the 
corresponding SSL certificates if using HTTPS. *8080* for HTTP traffic and 
*8443* for HTTPS traffic.

#### resources/tomcat/alfresco-global.properties
This file defines the configuration of the main **alfresco** web application.
This webapp requires the following options configured:

- `@@ALFRESCO_REPO_SERVER@@`
- `@@ALFRESCO_SHARE_SERVER@@`
- `@@ALFRESCO_SHARE_SERVER_PORT@@`
- `@@ALFRESCO_SHARE_SERVER_PROTOCOL@@`

#### resources/tomcat/tomcat-users.xml
This file defines the configuration of the *solr* and *repository* users
used to access the corresponding resources.
 
#### resources/tomcat/catalina.properties
This file defines the standard Java properties for the Catalina java class
expressed in [Security Policy syntax](http://tomcat.apache.org/tomcat-7.0-doc/security-manager-howto.html).  
In addition, this file also defines some string cache settings which can be
used to optimize aspects of Tomcat's performance.


### SSL Configuration
A sample keystore file is created in /root/.keystore via the command:

```
keytool -genkey -alias tomcat -keyalg RSA   -keystore /root/.keystore \
  -storepass changeit -keypass changeit 
  -dname "CN=localhost, OU=Docker, O=CoreOS, L=San Francisco, S=California, C=US"
```

If you wish you can change this command or generate your own keystore, add it
to the Dockerfile and update the `server.xml` file.
