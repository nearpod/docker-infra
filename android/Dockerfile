FROM openjdk:8-jdk-slim

ARG ANDROID_SDK_TOOLS_VERSION=3859397
ARG ANDROID_SDK_TOOLS_SHA256=444e22ce8ca0f67353bda4b85175ed3731cae3ffa695ca18119cbacef1c1bea0

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools
ENV ANDROID_SDK_TOOLS_VERSION=$ANDROID_SDK_TOOLS_VERSION
ENV ANDROID_SDK_TOOLS_SHA256=$ANDROID_SDK_TOOLS_SHA256

RUN set -ex; \
  apt-get update ; \
  apt-get install -y curl ; \
  rm -rf /var/lib/apt/lists/* ;

RUN set -ex; \
  WORKDIR="$PWD"; \
  mkdir -p "$ANDROID_HOME" ; \
  cd "$ANDROID_HOME" ; \
  curl -q -sSLO https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_VERSION}.zip ; \
  echo "$ANDROID_SDK_TOOLS_SHA256  sdk-tools-linux-${ANDROID_SDK_TOOLS_VERSION}.zip" ; \
  unzip "sdk-tools-linux-${ANDROID_SDK_TOOLS_VERSION}.zip" ; \
  rm "sdk-tools-linux-${ANDROID_SDK_TOOLS_VERSION}.zip" ; \
  yes | sdkmanager --licenses ;
