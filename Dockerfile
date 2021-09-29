# syntax = docker/dockerfile:1.3
FROM docker.io/elixir:1.12.3 as build
WORKDIR /build_root
ENV APP_NAME=ftx_lending_bot

COPY . /build_root
RUN export MIX_ENV=prod && \
    ( rm -Rf _build deps ; true ) && \
    mix do local.hex --force, local.rebar --force && \
    mix do clean --force, deps.clean --all && \
    mix deps.get && \
    mix release
RUN RELEASE_DIR="$(ls -d _build/prod/rel/ftx_lending_bot/)" && \
    mkdir /build_out && \
    cp -r "${RELEASE_DIR}/"* /build_out


FROM docker.io/debian:11-slim
ENV FTX_KEY=""
ENV FTX_SECRET=""
ENV FTX_SUBACCOUNT=""

WORKDIR /app
COPY --from=build /build_out/ .

#USER default
CMD ["bin/ftx_lending_bot", "start"]
