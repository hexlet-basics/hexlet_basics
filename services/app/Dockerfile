FROM elixir:1.8.2

ENV HOME /home/shared
WORKDIR /app

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get update && apt-get install -y inotify-tools
RUN apt-get update && apt-get install -y nodejs
RUN npm install -g npm-check-updates

# Install hex (Elixir package manager)
RUN mix local.hex --force
# Install rebar (Erlang build tool)
RUN mix local.rebar --force
RUN mix archive.install hex phx_new 1.4.8

ENV DOCKER_CHANNEL edge
ENV DOCKER_VERSION 18.09.6
RUN curl -fsSL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
  | tar -xzC /usr/local/bin --strip=1 docker/docker

COPY mix.exs mix.lock ./
RUN mix deps.get
COPY config .
RUN MIX_ENV=prod mix deps.compile

COPY assets/package.json ./assets/package.json
COPY assets/package-lock.json ./assets/package-lock.json

RUN cd assets && npm ci

COPY . .

RUN MIX_ENV=prod mix compile
RUN NODE_ENV=production npx webpack
RUN MIX_ENV=prod mix phx.digest

CMD ["mix", "phx.server"]
