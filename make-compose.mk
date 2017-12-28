compose-test:
	docker-compose run app mix test
compose-build:
	docker-compose build

compose:
	docker-compose up

compose-locales-build:
	docker-compose run app mix gettext.extract --merge
	docker-compose run app mix gettext.merge priv/gettext --locale ru


compose-kill:
	docker-compose kill

compose-bash:
	docker-compose run app bash

compose-install:
	docker-compose run app mix deps.get

compose-setup: compose-install compose-db-prepare
	docker-compose run app npm install

compose-db-drop:
	docker-compose run app mix ecto.drop

compose-db-prepare:
	docker-compose run app mix ecto.create
	docker-compose run app mix ecto.migrate

compose-exercises-load:
	docker pull hexlet/hexlet-basics-exercises-php
	rm -rf tmp/exercises-php
	docker run --rm -v $(CURDIR)/tmp/exercises-php:/out hexlet/hexlet-basics-exercises-php bash -c "cp -r /exercises-php/* /out"
	docker-compose run --rm -v $(CURDIR)/tmp/exercises-php:/exercises-php app mix x.exercises.load php
