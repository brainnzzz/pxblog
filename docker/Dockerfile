FROM elixir:latest

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y \
  nodejs \
  inotify-tools

RUN yes | mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez

RUN mix local.hex --force
RUN mix local.rebar --force
