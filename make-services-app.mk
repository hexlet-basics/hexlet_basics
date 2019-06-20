USER = "$(shell id -u):$(shell id -g)"

app-test:
	docker-compose run app mix test

app-lint:
	docker-compose run app npm run lint -- --ext js --ext jsx .

app-locales-build:
	docker-compose run app mix gettext.extract --merge
	docker-compose run app mix gettext.merge priv/gettext --locale ru

app-bash:
	docker-compose run --user=$(USER) app bash

app-bash-root:
	docker-compose run app bash

app-install:
	docker-compose run app mix deps.get
	docker-compose run app npm install

app-db-drop:
	docker-compose run app mix ecto.drop

app-db-prepare:
	docker-compose run app mix ecto.create
	docker-compose run app mix ecto.migrate

app-exercises-load-python:
	docker pull hexletbasics/exercises-python
	rm -rf tmp/exercises-python
	docker run --rm -v $(CURDIR)/tmp/exercises-python:/out hexletbasics/exercises-python bash -c "cp -r /exercises-python/* /out"
	docker-compose run --rm app mix x.exercises.load python

app-exercises-load-ruby:
	docker pull hexletbasics/exercises-ruby
	rm -rf tmp/exercises-ruby
	docker run --rm -v $(CURDIR)/tmp/exercises-ruby:/out hexletbasics/exercises-ruby bash -c "cp -r /exercises-ruby/* /out"
	docker-compose run --rm app mix x.exercises.load ruby

app-exercises-load-php:
	docker pull hexletbasics/exercises-php
	rm -rf tmp/exercises-php
	docker run --rm -v $(CURDIR)/tmp/exercises-php:/out hexletbasics/exercises-php bash -c "cp -r /exercises-php/* /out"
	docker-compose run --rm app mix x.exercises.load php

app-exercises-load-racket:
	docker pull hexletbasics/exercises-racket
	rm -rf tmp/exercises-racket
	docker run --rm -v $(CURDIR)/tmp/exercises-racket:/out hexletbasics/exercises-racket bash -c "cp -r /exercises-racket/* /out"
	docker-compose run --rm app mix x.exercises.load racket

app-exercises-load-javascript:
	docker pull hexletbasics/exercises-javascript
	rm -rf tmp/exercises-javascript
	docker run --rm -v $(CURDIR)/tmp/exercises-javascript:/out hexletbasics/exercises-javascript bash -c "cp -r /exercises-javascript/* /out"
	docker-compose run --rm app mix x.exercises.load javascript

app-exercises-load-java:
	docker pull hexletbasics/exercises-java
	rm -rf tmp/exercises-java
	docker run --rm -v $(CURDIR)/tmp/exercises-java:/out hexletbasics/exercises-java bash -c "cp -r /exercises-java/* /out"
	docker-compose run --rm app mix x.exercises.load java

app-exercises-load-html:
	docker pull hexletbasics/exercises-html
	rm -rf tmp/exercises-html
	docker run --rm -v $(CURDIR)/tmp/exercises-html:/out hexletbasics/exercises-html bash -c "cp -r /exercises-html/* /out"
	docker-compose run --rm app mix x.exercises.load html
