FROM elixir:1.14 AS builder

WORKDIR /api
COPY . .

RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix do deps.get, deps.compile

FROM builder AS runner

EXPOSE 4000
ENTRYPOINT ["./entrypoint.sh"]
