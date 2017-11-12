docker-infra
============

A set of infrastructure images built with Docker.

###### Special Note
> Unless otherwise specified each image is based on Alpine Linux. Especially for JVM images this could have unintended consequences and everything may break. YMMV

[zookeeper](zookeeper/)
-----------------------
A zookeeper image meant to run in a Kubernetes StatefulSet.

Heavily inspired from: [Kubernetes ZooKeeper K8SZK](https://github.com/kubernetes/contrib/tree/master/statefulsets/zookeeper)


[kafka](kafka/)
---------------
A kafka image meant to run in a Kubernetes StatefulSet.

Heavily inspired from: [Kubernetes Kafka K8SKafka](https://github.com/kubernetes/contrib/tree/master/statefulsets/kafka)


[kafka-health-check](kafka-health-check/)
-----------------------------------------
A Go application that presents a REST interface to query Kafka broker health. ([github](https://github.com/kubernetes/contrib/tree/master/statefulsets/zookeeper))
