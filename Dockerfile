FROM alpine
ENV JAVA_HOME="/usr/lib/jvm/jre"
ENV PATH="${JAVA_HOME}/bin:${PATH}"
RUN \
apk update && \
apk upgrade && \
apk --no-cache add ca-certificates wget && \
wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk && \
apk add glibc-2.30-r0.apk && \
mkdir -p /usr/lib/jvm && \
cd /usr/lib/jvm && \
wget http://download.java.net/openjdk/jdk8u40/ri/openjdk-8u40-b25-linux-x64-10_feb_2015.tar.gz -O - | gunzip | tar x && \
cp -r  /usr/lib/jvm/java-se-8u40-ri/ /usr/lib/jvm/jre && \
mkdir -p $JAVA_HOME/lib/security && \
$JAVA_HOME/bin/keytool -importcert -file /etc/ssl/certs/ca-certificates.crt -keystore /usr/lib/jvm/jre/lib/security/cacerts -storepass changeit -noprompt && \
rm -rf /usr/lib/jvm/java-se-8u40-ri && \
rm -rf /var/cache/apk/*
