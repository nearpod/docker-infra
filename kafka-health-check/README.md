docker-infra
============

###### Special Notes
> * This image is based on Alpine Linux. Especially for JVM images this could have unintended consequences and everything may break. YMMV
> * This project uses [Zulu](https://www.azul.com/downloads/zulu/), a fully tested, compatibility verified, and trusted binary distribution of the OpenJDK 9, 8, and earlier platforms. [Zulu terms of use](https://www.azul.com/products/zulu-and-zulu-enterprise/zulu-terms-of-use/)

kafka-health-check
---------

This project contains a Docker image meant to be used as a sidecar to a [kafka
broker](https://zookeeper.apache.org/) in [Kubernetes](http://kubernetes.io/) acting as a health check endpoint.
