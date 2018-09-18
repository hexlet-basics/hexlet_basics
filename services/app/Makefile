start:
	mix ecto.create
	mix ecto.migrate
	mix phx.server

update:
	mix deps.update --all
	ncu -u
	npm update

console:
	iex -S mix
