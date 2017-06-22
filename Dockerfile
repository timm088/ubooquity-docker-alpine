FROM alpine:3.6

ENV LANG='en_AU.UTF-8' \
    LANGUAGE='en_AU.UTF-8' \
    JAVA_HOME="/usr/lib/jvm/java-1.8-openjdk/bin/java"

RUN apk -U upgrade && \
    apk add --no-cache \
      openjdk8-jre-base \
      ca-certificates \
      openssl \
      wget \
      openjdk8-jre-lib \
      curl \
      unzip

RUN addgroup -S media && adduser -S media -G media && \
    mkdir /data /comics && \
    chown -R media:media /data /comics

RUN export UBOOQUITY_VERSIION=2.0.2 && \
    wget https://vaemendis.net/ubooquity/downloads/Ubooquity-${UBOOQUITY_VERSIION}.zip && \
    unzip /Ubooquity-${UBOOQUITY_VERSIION}.zip -d /ubooquity && \
    rm /Ubooquity-${UBOOQUITY_VERSIION}.zip && \
    chown -R media:media /ubooquity

EXPOSE 2202 2502

USER media

VOLUME ["/data", "/comics"]

CMD ["java", "-jar", "/ubooquity/Ubooquity.jar", "-workdir", "/data", "-headless", "-libraryport", "2202", "-adminport", "2502", "-remoteadmin"]
