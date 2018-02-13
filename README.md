### Requirements

* Mac / Linux
* Docker
* Docker Compose
* Ansible (installed using pip3)

### Install

```sh
$ make app-setup
```

### Load content

```sh
$ make app-exercises-load
```

### Run

```sh
$ make app
```

Go to [http://localhost:4000/](http://localhost:4000/)

### Useful

    brew install git-secrets
    git secrets --install
    git secrets --register-aws
