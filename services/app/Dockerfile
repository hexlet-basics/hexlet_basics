FROM elixir

WORKDIR /app

# Install hex (Elixir package manager)
RUN mix local.hex --force

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

RUN apt-get update && apt-get install -y inotify-tools

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN apt-get update && apt-get install -y nodejs

# Copy all dependencies files
COPY mix.* ./

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
