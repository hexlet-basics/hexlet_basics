### Requirements

* Mac / Linux
* Docker
* Docker Compose
* Ansible (installed using pip3)

### Install

```sh
$ make ansible-development-setup
$ make compose-build
$ make compose-setup
```

### Load content

```sh
$ make compose-exercises-load
```

### Run

```sh
$ make compose
```

### Usefull

    brew install git-secrets
    git secrets --install
    git secrets --register-aws
