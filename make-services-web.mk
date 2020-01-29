USER = "$(shell id -u):$(shell id -g)"

web-test:
	docker-compose run web mix test

web-ci-test:
	docker-compose --file services/web/docker-compose.test.yml run test

web-console:
	docker-compose run web iex -S mix

web-lint:
	docker-compose run web npm run lint -- --ext js --ext jsx .

web-locales-build:
	docker-compose run web mix gettext.extract --merge
	docker-compose run web mix gettext.merge priv/gettext --locale ru

web-bash:
	docker-compose run --user=$(USER) web bash

web-bash-root:
	docker-compose run web bash

web-install:
	docker-compose run web mix deps.get
	docker-compose run web bash -c 'cd assets && npm install'

web-db-drop:
	docker-compose run web mix ecto.drop

web-db-prepare:
	docker-compose run web mix ecto.setup

web-exercises-load-python:
	docker pull hexletbasics/exercises-python
	rm -rf tmp/hexletbasics/exercises-python
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-python:/out hexletbasics/exercises-python bash -c "cp -r /exercises-python/* /out"
	docker-compose run --rm web mix x.exercises.load python

web-exercises-load-ruby:
	docker pull hexletbasics/exercises-ruby
	rm -rf tmp/hexletbasics/exercises-ruby
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-ruby:/out hexletbasics/exercises-ruby bash -c "cp -r /exercises-ruby/* /out"
	docker-compose run --rm web mix x.exercises.load ruby

web-exercises-load-php:
	docker pull hexletbasics/exercises-php
	rm -rf tmp/hexletbasics/exercises-php
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-php:/out hexletbasics/exercises-php bash -c "cp -r /exercises-php/* /out"
	docker-compose run --rm web mix x.exercises.load php

web-exercises-load-racket:
	docker pull hexletbasics/exercises-racket
	rm -rf tmp/hexletbasics/exercises-racket
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-racket:/out hexletbasics/exercises-racket bash -c "cp -r /exercises-racket/* /out"
	docker-compose run --rm web mix x.exercises.load racket

web-exercises-load-javascript:
	docker pull hexletbasics/exercises-javascript
	rm -rf tmp/hexletbasics/exercises-javascript
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-javascript:/out hexletbasics/exercises-javascript bash -c "cp -r /exercises-javascript/* /out"
	docker-compose run --rm web mix x.exercises.load javascript

web-exercises-load-java:
	docker pull hexletbasics/exercises-java
	rm -rf tmp/hexletbasics/exercises-java
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-java:/out hexletbasics/exercises-java bash -c "cp -r /exercises-java/* /out"
	docker-compose run --rm web mix x.exercises.load java

web-exercises-load-html:
	docker pull hexletbasics/exercises-html
	rm -rf tmp/hexletbasics/exercises-html
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-html:/out hexletbasics/exercises-html bash -c "cp -r /exercises-html/* /out"
	docker-compose run --rm web mix x.exercises.load html

web-exercises-load-css:
	docker pull hexletbasics/exercises-css
	rm -rf tmp/hexletbasics/exercises-css
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-css:/out hexletbasics/exercises-css bash -c "cp -r /exercises-css/* /out"
	docker-compose run --rm web mix x.exercises.load css

web-exercises-load-elixir:
	docker pull hexletbasics/exercises-elixir
	rm -rf tmp/hexletbasics/exercises-elixir
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-elixir:/out hexletbasics/exercises-elixir bash -c "cp -r /exercises-elixir/* /out"
	docker-compose run --rm web mix x.exercises.load elixir

web-exercises-load-go:
	docker pull hexletbasics/exercises-go
	rm -rf tmp/hexletbasics/exercises-go
	docker run --rm -v $(CURDIR)/tmp/hexletbasics/exercises-go:/out hexletbasics/exercises-go bash -c "cp -r /exercises-go/* /out"
	docker-compose run --rm web mix x.exercises.load go

caddy-docker-build-production:
	docker build --tag hexletbasics/services-web:$(VERSION) services/web

caddy-docker-push:
	docker push hexletbasics/services-caddy:$(VERSION)
