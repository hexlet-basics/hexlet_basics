app-test:
	docker-compose run app mix test

app-build:
	docker-compose build

app:
	docker-compose up

app-locales-build:
	docker-compose run app mix gettext.extract --merge
	docker-compose run app mix gettext.merge priv/gettext --locale ru

app-down:
	docker-compose down

app-bash:
	docker-compose run app bash

app-install:
	docker-compose run app mix deps.get

app-setup: development-setup app-build app-install app-db-prepare
	docker-compose run app npm install

app-db-drop:
	docker-compose run app mix ecto.drop

app-db-prepare:
	docker-compose run app mix ecto.create
	docker-compose run app mix ecto.migrate

app-exercises-load:
	docker pull hexlet/hexlet-basics-exercises-php
	rm -rf tmp/exercises-php
	docker run --rm -v $(CURDIR)/tmp/exercises-php:/out hexlet/hexlet-basics-exercises-php bash -c "cp -r /exercises-php/* /out"
	docker-compose run --rm -v $(CURDIR)/tmp/exercises-php:/exercises-php app mix x.exercises.load php
