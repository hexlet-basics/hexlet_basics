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
	docker-compose run app bash -c 'cd assets && npm install'

app-db-drop:
	docker-compose run app mix ecto.drop

app-db-prepare:
	docker-compose run app mix ecto.create
	docker-compose run app mix ecto.migrate

app-exercises-load-python:
	docker pull hexletbasics/exercises-python
	rm -rf tmp/hexletbasics/exercises-python
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-python:/out hexletbasics/exercises-python bash -c "cp -r /exercises-python/* /out"
	docker-compose run --rm app mix x.exercises.load python

app-exercises-load-ruby:
	docker pull hexletbasics/exercises-ruby
	rm -rf tmp/hexletbasics/exercises-ruby
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-ruby:/out hexletbasics/exercises-ruby bash -c "cp -r /exercises-ruby/* /out"
	docker-compose run --rm app mix x.exercises.load ruby

app-exercises-load-php:
	docker pull hexletbasics/exercises-php
	rm -rf tmp/hexletbasics/exercises-php
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-php:/out hexletbasics/exercises-php bash -c "cp -r /exercises-php/* /out"
	docker-compose run --rm app mix x.exercises.load php

app-exercises-load-racket:
	docker pull hexletbasics/exercises-racket
	rm -rf tmp/hexletbasics/exercises-racket
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-racket:/out hexletbasics/exercises-racket bash -c "cp -r /exercises-racket/* /out"
	docker-compose run --rm app mix x.exercises.load racket

app-exercises-load-javascript:
	docker pull hexletbasics/exercises-javascript
	rm -rf tmp/hexletbasics/exercises-javascript
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-javascript:/out hexletbasics/exercises-javascript bash -c "cp -r /exercises-javascript/* /out"
	docker-compose run --rm app mix x.exercises.load javascript

app-exercises-load-java:
	docker pull hexletbasics/exercises-java
	rm -rf tmp/hexletbasics/exercises-java
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-java:/out hexletbasics/exercises-java bash -c "cp -r /exercises-java/* /out"
	docker-compose run --rm app mix x.exercises.load java

app-exercises-load-html:
	docker pull hexletbasics/exercises-html
	rm -rf tmp/hexletbasics/exercises-html
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-html:/out hexletbasics/exercises-html bash -c "cp -r /exercises-html/* /out"
	docker-compose run --rm app mix x.exercises.load html

app-exercises-load-css:
	docker pull hexletbasics/exercises-css
	rm -rf tmp/hexletbasics/exercises-css
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-css:/out hexletbasics/exercises-css bash -c "cp -r /exercises-css/* /out"
	docker-compose run --rm app mix x.exercises.load css
