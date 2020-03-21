compose-build:
	docker-compose build

compose:
	docker-compose up

compose-down:
	docker-compose down -v || true

compose-setup: compose-down compose-build web-install web-db-prepare
