FROM tomcat:9-jre8

#
# Set GeoServer version and data directory
#
ENV JAVA_OPTS="-Djava.awt.headless=true -XX:MaxPermSize=512m -XX:PermSize=256m -Xms512m -Xmx2048m -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:ParallelGCThreads=4 -Dfile.encoding=UTF8 -Duser.timezone=GMT -Djavax.servlet.request.encoding=UTF-8 -Djavax.servlet.response.encoding=UTF-8 -Duser.timezone=GMT -Dorg.geotools.shapefile.datetime=true"
ENV GEOSERVER_VERSION=2.14.2
#ENV GEOSERVER_DATA_DIR="/geoserver_data/data"

#
# Download GeoServer
#
RUN cd /usr/local/tomcat/webapps \
    && wget --no-check-certificate --progress=bar:force:noscroll \
    http://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-war.zip

#
# Install GeoServer
#
RUN cd /usr/local/tomcat/webapps \
    && unzip -q -x geoserver-${GEOSERVER_VERSION}-war.zip -d temp \
    && rm geoserver-${GEOSERVER_VERSION}-war.zip \
    && unzip -q -x temp/geoserver.war -d geoserver \
    && rm -rf temp

#    && mkdir -p $GEOSERVER_DATA_DIR

#VOLUME $GEOSERVER_DATA_DIR


# Create tempdir
RUN mkdir -p /usr/local/tomcat/tmp

WORKDIR /usr/local/tomcat/tmp