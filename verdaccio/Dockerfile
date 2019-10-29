from verdaccio/verdaccio:4.3.4

MAINTAINER dockerfiles@nearpod.com

ENV LANG="C.UTF-8"

USER root

RUN set -ex; \
  yarn add "verdaccio-s3-storage@^0.2.0"; \
  yarn add "verdaccio-gitlab@^2.2.0"; \

USER $VERDACCIO_USER_UID
