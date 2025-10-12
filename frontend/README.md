# AOC Frontend

This is the frontend used to interact with the [backend](../backend/README.md).

## Developing

The frontend is written in [Dart](https://dart.dev) using
[Jaspr](https://jaspr.site/).

To start development, please install [Dart](https://dart.dev/get-dart) and
[Jaspr](https://docs.jaspr.site/get_started/quick_start#jaspr-cli). You may also
like to install a Dart extension for your IDE of choice, and, if you're using
VSCode, the Jaspr extension.

You can then serve a development version of the frontend with debugging support
by using `jaspr serve --launch-in-chrome` or the `frontend`/`frontend + backend`
debug configurations.

If you are also running a development version of the backend, you can pass
`--dart-define=API_HOST=<url>` to redirect API requests to that URL (this is
done automatically by the `frontend + backend` configuration).

## Building

The frontend alone can be built using `jaspr build`. Please use the `Dockerfile`
to produce an all-in-one image.
