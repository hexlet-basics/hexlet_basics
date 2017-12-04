compose-test:
	docker-compose run app mix test
compose-build:
	docker-compose build

compose:
	docker-compose up

compose-gettext-build:
	docker-compose run app mix gettext.extract --merge
	docker-compose run app mix gettext.merge priv/gettext --locale ru_RU

compose-kill:
	docker-compose kill

compose-bash:
	docker-compose run app bash

compose-install:
	docker-compose run app mix deps.get

compose-setup: compose-install
	docker-compose run app mix ecto.create
	docker-compose run app mix ecto.migrate
	docker-compose run app bash -c "cd assets && npm install"

