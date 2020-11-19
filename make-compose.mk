compose-build:
	docker-compose build

compose:
	docker-compose up -d

compose-down:
	docker-compose down -v || true

compose-setup: compose-down compose-build web-install web-db-prepare
