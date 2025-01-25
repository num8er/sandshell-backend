# SandshellBackend

Set of backend apps for Sandshell project.

Based on monorepo (umbrella) pattern:

1. apps located in `apps` folder
2. shared libs are in `lib`.

---

To run `apps/APP_NAME` need to execute:

```sh
mix app.start APP_NAME
```

Currently we have `sandshell_api` which can be run as:

```sh
mix app.start sandshell_api
```
