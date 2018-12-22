compose-build:
	docker-compose build

compose:
	docker-compose up

compose-down:
	docker-compose down -v

compose-setup: compose-down development-setup compose-build app-install app-db-prepare
	docker-compose run app npm install


