compose-build:
	docker-compose build

compose:
	docker-compose up

compose-down:
	docker-compose down

compose-setup: development-setup compose-build app-install app-db-prepare
	docker-compose run app npm install


