FROM elixir:1.8.1

ENV MIX_ENV prod
ENV NODE_ENV=production
ENV HOME /home/shared
WORKDIR /app

ENV VERSION 19122018
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -

RUN apt-get update \
    && apt-get install -y inotify-tools nodejs \
    && npm install -g npm-check-updates \
    # Install hex (Elixir package manager)
    && mix local.hex --force \
    # Install rebar (Erlang build tool)
    && mix local.rebar --force \
    # install phoenix 1.4.2
    && mix archive.install hex phx_new 1.4.2

ENV DOCKER_CHANNEL edge
ENV DOCKER_VERSION 18.09.3
RUN curl -fsSL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
  | tar -xzC /usr/local/bin --strip=1 docker/docker

COPY . .

# run mix tasks: download deps, compile them and compile phoenix app
RUN mix do deps.get, deps.compile, compile \
    && npm ci \
    && npx webpack \
    && mix phx.digest

CMD ["mix", "phx.server"]
