FROM elixir

WORKDIR /app

# Install hex (Elixir package manager)
RUN mix local.hex --force

RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

RUN apt-get update && apt-get install -y inotify-tools

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get update && apt-get install -y nodejs

ENV DOCKER_CHANNEL edge
ENV DOCKER_VERSION 17.11.0-ce
RUN curl -fsSL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
  | tar -xzC /usr/local/bin --strip=1 docker/docker

# Copy all dependencies files
COPY mix.* ./

# Install all production dependencies
RUN mix deps.get --only prod

COPY package.json ./
COPY package-lock.json ./

RUN npm install

# Compile all dependencies
RUN mix deps.compile --only prod

COPY . .

RUN npm run deploy
RUN MIX_ENV=prod mix compile --only prod
# RUN MIX_ENV=prod mix phx.digest --only prod

# RUN MIX_ENV=prod mix release.init
# RUN MIX_ENV=prod mix release

# CMD _build/prod/rel/hexlet_basics/bin/hexlet_basics foreground
CMD ["mix", "phx.server"]
