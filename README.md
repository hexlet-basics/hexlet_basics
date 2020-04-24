[![On Push](https://github.com/hexlet-basics/hexlet_basics/workflows/On%20Push/badge.svg?branch=master)](https://github.com/hexlet-basics/hexlet_basics/actions)

##
[![Hexlet Ltd. logo](https://raw.githubusercontent.com/Hexlet/hexletguides.github.io/master/images/hexlet_logo128.png)](https://ru.hexlet.io/pages/about?utm_source=github&utm_medium=link&utm_campaign=hexlet-basics)

This repository is created and maintained by the team and the community of Hexlet, an educational project. [Read more about Hexlet (in Russian)](https://ru.hexlet.io/pages/about?utm_source=github&utm_medium=link&utm_campaign=hexlet-basics).
##

## Development

### Requirements

* Mac / Linux
* Docker
* Docker Compose
* Node & npm

### Install

```sh
$ make project-setup
```

Add to _/etc/hosts_:

    127.0.0.1 code-basics.test ru.code-basics.test en.code-basics.test

### Load content

```sh
$ make web-exercises-load-php
```

### Run

```sh
$ make compose
```

Go to [https://ru.code-basics.test](https://ru.code-basics.test)
Go to [https://en.code-basics.test](https://en.code-basics.test)


## Kubernetes (Production)

### Requirements

* doctl
* kubectl
* [kubectx](https://github.com/ahmetb/kubectx)

### Setup

```sh
$ make cluster-setup
```
