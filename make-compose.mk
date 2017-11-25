compose-build:
	docker-compose build

compose:
	docker-compose up

compose-bash:
	docker-compose run app bash

compose-setup:
	docker-compose run app mix ecto.create
	docker-compose run app bash -c "cd assets && npm install"

