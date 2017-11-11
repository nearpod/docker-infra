docker-infra
============

A set of infrastructure images built with Docker.

###### Special Note
> Unless otherwise specified each image is based on Alpine Linux. Especially for JVM images this could have unintended consequences and everything may break. YMMV

[zookeeper](zookeeper/)
---------
A zookeeper image meant to run in a Kubernetes StatefulSet.

Heavily inspired from: [Kubernetes ZooKeeper K8SZK](https://github.com/kubernetes/contrib/tree/master/statefulsets/zookeeper)
