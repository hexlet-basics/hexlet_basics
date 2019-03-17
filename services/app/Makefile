.PHONY: start
start:
	mix ecto.create
	mix ecto.migrate
	mix phx.server

.PHONY: update
update:
	mix deps.update --all
	ncu -u
	npm update

.PHONY: console
console:
	iex -S mix
