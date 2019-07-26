FROM elixir:1.9

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
RUN mix archive.install hex phx_new 1.4.9

ENV DOCKER_CHANNEL edge
ENV DOCKER_VERSION 19.03.0
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

RUN SECRET_KEY_BASE=jopa MIX_ENV=prod mix compile
RUN NODE_ENV=production cd assets && npm run deploy
RUN SECRET_KEY_BASE=jopa MIX_ENV=prod mix phx.digest

CMD ["mix", "phx.server"]
