compose-build:
	docker-compose build

compose:
	docker-compose up

compose-down:
	docker-compose down -v || true

compose-setup: compose-down compose-build app-install app-db-prepare
	docker-compose run app npm install


