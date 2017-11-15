docker-infra
============

###### Special Notes
> * This image is based on Alpine Linux. Especially for JVM images this could have unintended consequences and everything may break. YMMV
> * This project uses [Zulu](https://www.azul.com/downloads/zulu/), a fully tested, compatibility verified, and trusted binary distribution of the OpenJDK 9, 8, and earlier platforms. [Zulu terms of use](https://www.azul.com/products/zulu-and-zulu-enterprise/zulu-terms-of-use/)
> * Jira depends on a license from Atlassian. All terms and conditions, licensing, etc that apply are specified by Atlassian on their website.

jira
----

This project contains a Docker image meant to facilitate the deployment of
[Atlassian Jira](https://jira.atlassian.com/) on [Kubernetes](http://kubernetes.io/) using
[StatefulSets](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/).


License Declaration
-------------------
The jira project is licensed with a proprietary license that requires a separate
purchase from Atlassian.

Furthermore, this project was inspired by [cptactionhank/docker-atlassian-jira](https://github.com/cptactionhank/docker-atlassian-jira) whose license follows below:

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
