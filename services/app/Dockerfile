FROM elixir

WORKDIR /app

# Install hex (Elixir package manager)
RUN mix local.hex --force

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
COPY mix.exs ./
COPY mix.lock ./

# Install all production dependencies
RUN mix deps.get --only prod

# Compile all dependencies
RUN mix deps.compile

COPY package.json ./
COPY package-lock.json ./

RUN npm install

# FIXME: copy package.lock
# npm install

# Copy all application files
COPY . .

# Compile the entire project
RUN mix compile

RUN mix phx.digest

CMD mix phx.server
