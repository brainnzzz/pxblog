#!/usr/bin/env bash
mix deps.get
cd assets && npm install && cd ..

mix phx.server
