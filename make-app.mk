USER = "$(shell id -u):$(shell id -g)"

app-test:
	docker-compose run app mix test

app-locales-build:
	docker-compose run app mix gettext.extract --merge
	docker-compose run app mix gettext.merge priv/gettext --locale ru

app-bash:
	docker-compose run --user=$(USER) app bash

app-bash-root:
	docker-compose run app bash

app-install:
	docker-compose run app mix deps.get

app-db-drop:
	docker-compose run app mix ecto.drop

app-db-prepare:
	docker-compose run app mix ecto.create
	docker-compose run app mix ecto.migrate

app-exercises-load:
	docker pull hexlet/hexlet-basics-exercises-php
	rm -rf tmp/exercises-php
	docker run --rm -v $(CURDIR)/tmp/exercises-php:/out hexlet/hexlet-basics-exercises-php bash -c "cp -r /exercises-php/* /out"
	docker-compose run --rm app mix x.exercises.load php
