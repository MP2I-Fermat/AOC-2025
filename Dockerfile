FROM ocaml/opam:latest AS build_huitr

WORKDIR /huitr

COPY huitr/huitr.opam .

RUN opam install . --deps-only

COPY huitr/ .

RUN eval $(opam env) && dune build


FROM dart:beta AS build_frontend

RUN dart pub global activate jaspr_cli

WORKDIR /frontend

COPY frontend/pubspec.yaml frontend/pubspec.lock .

RUN dart pub get --enforce-lockfile

COPY frontend/ .

RUN dart pub get --offline --enforce-lockfile

RUN dart pub global run jaspr_cli:jaspr build


FROM dart:latest AS build_backend

WORKDIR /backend

COPY backend/pubspec.yaml backend/pubspec.lock .

RUN dart pub get --enforce-lockfile

COPY backend/ .

RUN dart pub get --offline --enforce-lockfile

RUN dart compile exe bin/server_prod.dart -o bin/server_prod

FROM debian:stable

# Use a proper init as we may potentially spawn many subprocesses.
ENV TINI_VERSION=v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

COPY --from=build_huitr /huitr/_build/default/cli/main.exe /opt/huitr/huitr
COPY --from=build_frontend /frontend/build/jaspr /opt/frontend
COPY --from=build_backend /backend/bin/server_prod /opt/backend/backend

CMD ["/opt/backend/backend", "--frontend-root=/opt/frontend"]
