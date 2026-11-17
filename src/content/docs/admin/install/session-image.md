---
title: The session image
description: What the session image holds, building it, and adding templates for other toolsets.
---

Every session runs the **session image**, built from `sandbox/` in the Garth
source. The template that runs it is the toolset: a sandbox cannot install
system packages, so a new tool means a new image.

## What is in it

- **Pi**, the agent, pinned to one version and driven in RPC mode by a small
  Node shim.
- **git**, **toft** (the Toft CLI, 0.10.0) and the usual command-line tools:
  ripgrep, fd, jq, yq, curl, zip, sqlite3, psql, graphviz, pdftotext, editors,
  a C toolchain and the common `-dev` libraries.
- **The language toolchains Toft deploys**, at the versions Toft gives an app
  that pins none: Python 3.15 with uv and pip, Node 26 with npm, pnpm and yarn,
  Go 1.27, and R 4.6 with renv.
- **Toft's agent skills and commands**, installed with the Toft CLI.

**Admin → Sandbox → Template** shows the image, the Pi and Toft CLI versions,
the runtime class, and the CPU, memory and workspace limits.

### Libraries

Libraries for development and data analysis are installed already, so a
session rarely needs to install anything:

| | What is there |
|---|---|
| **DuckDB** | The 2.0 command line (`duckdb`), its Python and R libraries, and the `httpfs`, `excel`, `icu` and `fts` extensions |
| **Python** | numpy, pandas, pyarrow, scipy, scikit-learn, statsmodels, matplotlib, seaborn, plotly, altair, openpyxl, requests, httpx, beautifulsoup4, sqlalchemy, psycopg, pydantic, fastapi, uvicorn, flask, streamlit, ipykernel, pytest, ruff and more |
| **Node** | typescript, tsx, vite, react, tailwindcss, express, fastify, hono, zod, better-sqlite3, pg, d3, vitest, eslint, prettier. In `/node_modules`, so they import from any directory; their commands are on `PATH` |
| **R** | dplyr, tidyr, readr, readxl, ggplot2, data.table, DBI, RSQLite, RPostgres, jsonlite, httr2, shiny, plumber, testthat |
| **Go** | A local module cache with chi, pgx, gorilla/websocket, uuid, testify, cobra, yaml.v3 and golang.org/x/sync |

The agent is told what is there, to use it rather than install, and to ask
when a package is missing. Whether it may install is
[Project dependencies](../../config/sandbox-and-network/#project-dependencies),
off by default.

### Locked down

- The session runs as uid 1000, with no sudo and no setuid programs.
- It can't write system software. The image build checks this and fails if
  the session user could.
- The root filesystem is read-only in both templates Garth ships, for one
  k3s box and for a cluster. A session writes only
  `/workspace`, `/tmp` and its home directory, `/home/node`.

## Building it

```bash
docker build -t garth-session:0.5.0 sandbox/
```

- **One k3s box:** import it with
  `docker save garth-session:0.5.0 | sudo k3s ctr images import -`.
- **A cluster:** push it to your registry and set the template's image by
  digest, so a session runs exactly the image that was built.

To roll out a new image, see [Upgrading](../../start/upgrading/#the-session-image).

:::note[Licenses]
Pi is MIT-licensed and agent-sandbox is Apache-2.0. The session image
redistributes Pi, so its notice travels with the image.
:::

## Templates

A template is a `SandboxTemplate` in the `garth` namespace. Garth reads them
from the cluster at run time; nothing is registered in Garth itself.

**Admin → Templates** lists every template labelled `garth/template`, plus the
warm pool's own template. It shows each one's image, tools, resources, warm
sandboxes, who may use it, how many projects and live sessions are on it, and
its state: **Ready**, **Pulling image** or **Can't start**.

### Adding one

Apply a `SandboxTemplate` with the label. It appears within a minute.

```yaml
apiVersion: extensions.agents.x-k8s.io/v1beta1
kind: SandboxTemplate
metadata:
  name: garth-rust
  namespace: garth
  labels: { garth/template: "true" }
  annotations:
    garth/name: "Rust"
    garth/description: "Rust stable with cargo and clippy."
    garth/tools: "Rust 1.91, cargo, clippy, toft 0.10.0, Pi 1.5.0"
spec:
  podTemplate:
    spec:
      containers:
        - name: session
          image: garth-session-rust:0.1.0
          resources: { limits: { cpu: "2", memory: 3Gi } }
```

| Annotation | Shown as |
|---|---|
| `garth/name` | The template's name |
| `garth/description` | Its description |
| `garth/tools` | The tool chips under it, comma-separated |

Build a new template from `garth-session` — its network policy, security
context, volumes and `GARTH_INIT_KEY` — and change only the image and
resources. [System](../../operate/system/) checks every template for gVisor, a
read-only root, its own nodes and the init key.

Removing a template from the cluster removes it from Garth. Projects on it
fall back to the default.

### Choosing for projects

From a template's menu on **Admin → Templates**:

- **Make the default** — new projects start on it. Only a **Ready** template
  can be the default.
- **Let everyone use it**, or **Only some groups…** — then only those groups'
  members, and administrators, can put a project on it. The default is always
  open to everyone.
