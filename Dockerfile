FROM nikom/alpine-java-base
MAINTAINER Niko Mahle "niko.mahle@googlemail.com"

RUN apk add --update curl ca-certificates

ENV TOMCAT_VERSION=7.0.59

RUN curl \
  --silent \
  --location \
  --retry 3 \
  --cacert /etc/ssl/certs/ca-certificates.crt \
  "https://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" \
    | gunzip \
    | tar x -C /usr/ \
    && mv /usr/apache-tomcat* /usr/tomcat \
    && rm -rf /usr/tomcat/webapps/examples /usr/tomcat/webapps/docs

# SET CATALINE_HOME and PATH
ENV CATALINA_HOME /usr/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

COPY tomcat-users.xml /usr/tomcat/conf/tomcat-users.xml
EXPOSE 8080
CMD ["catalina.sh", "run"]
