#!/bin/env bash

mix do ecto.create, ecto.migrate
MIX_ENV=test mix do ecto.create, ecto.migrate

mix run priv/repo/seeds.exs

mix phx.server
