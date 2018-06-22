from debian:stretch-slim

MAINTAINER dockerfiles@nearpod.com

WORKDIR /usr/local

ENV LANG="C.UTF-8"

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN set -ex; \
  apt-get update ; \
  apt-get install -y --no-install-recommends gnupg dirmngr ; \
  key='A4A9406876FCBD3C456770C88C718D3B5072E1F5'; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ipv4.pool.sks-keyservers.net --recv-keys "$key"; \
	gpg --export "$key" > /etc/apt/trusted.gpg.d/mysql.gpg; \
	rm -rf "$GNUPGHOME"; \
  unset GNUPGHOME; \
	apt-key list > /dev/null; \
  apt-get purge -y gnupg dirmngr ; \
  echo deb http://repo.mysql.com/apt/debian/ stretch mysql-tools >>  /etc/apt/sources.list.d/mysql.list ; \
  apt-get update ; \
  apt-get install -y --no-install-recommends mysql-router ; \
  find /var/cache/ -type f -print0 | xargs -0 rm -f ; \
  find /tmp /var/tmp -maxdepth 1 -mindepth 1 -print0 | xargs -0 rm -rf ; \
  rm -rf /usr/share/doc/* ; \
  rm -rf /var/lib/apt/lists/* ;


