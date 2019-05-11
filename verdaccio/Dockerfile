from verdaccio/verdaccio:3.11.7

MAINTAINER dockerfiles@nearpod.com

ENV LANG="C.UTF-8"

RUN set -ex; \
  yarn add "verdaccio-s3-storage@^0.0.4"; \
  yarn add "verdaccio-gitlab@^2.0.0"; \
  yarn add "verdaccio-gitlab-ci"
