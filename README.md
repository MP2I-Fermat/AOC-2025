# AOC 2025

This repository contains several several applications used for the 2025 edition
of AOC at Fermat:

- [`huitr/`](huitr/README.md) contains an implementation of the Huitr language
  used for the competition. The upstream repository can be found at
  [jd-develop/huitr](https://github.com/jd-develop/huitr).
- [`backend/`](backend/README.md) contains the implementation of the backend
  responsible for evaluating and testing candidate's submissions.
- [`frontend/`](frontend/README.md) contains the frontend project served to
  users in their browsers.
- [`common/`](common) contains definitions and serialization utilities for the
  protocol used to communicate with the backend.
- [`nsjail`](nsjail/README.md) contains Google's [nsjail](https://github.com/google/nsjail)
  project, used to "securely" execute submitted code.

Please see the README.md documents for each application for more details.

The latest build is hosted at https://aoc.mylo.moe.
