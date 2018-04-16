FROM       alpine:latest

LABEL maintainer "Fernando de los Rios"

RUN apk --update add openjdk8-jre bash

#FROM frolvlad/alpine-oraclejdk8:slim

ENV SCALA_VERSION=2.12.5 \
    SCALA_HOME=/usr/share/scala

ENV SBT_VERSION=1.1.1 \
    SBT_HOME=/usr/share/sbt

# NOTE: bash is used by scala/scalac scripts, and it cannot be easily replaced with ash.

RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    apk add --no-cache bash && \
    cd "/tmp" && \
    wget "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    wget "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" && \
    tar xzf "sbt-${SBT_VERSION}.tgz" && \
    mkdir "${SBT_HOME}" && \
    rm "/tmp/sbt/bin/"*.bat && \
    mv "/tmp/sbt/bin/" "/tmp/sbt/conf/" "/tmp/sbt/lib" "${SBT_HOME}" && \
    ln -s "/${SBT_HOME}/bin/"* "/usr/bin" && \
    apk del .build-dependencies && \
    rm -rf "/tmp/"*

CMD tail -f /dev/null
