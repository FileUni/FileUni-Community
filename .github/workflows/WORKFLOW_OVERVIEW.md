# FileUni Project Workflow Overview

This directory contains the public-repository workflow entrypoints.

## Workflow Files

- `ci-rust-integration.yml` - black-box Rust integration suites driven from `apps/integration-tests/`
- `ci-frontends.yml` - verifies `frontends/`
- `ci-official-site-private.yml` - verifies `OfficialSitePrivate/`
- `ci-official-site-docs.yml` - builds `OfficialSiteDocs/`
- `release-publish.yml` - builds and publishes release artifacts from `FileUni-WorkSpace`

## Execution Model

1. Workflow files live in this public repository.
2. Actual source code is checked out from `FileUni/FileUni-WorkSpace` using the `workspace_ref` input.
3. The private WorkSpace repository dispatches these workflows after deciding which scope changed.

## Rust Integration Layout

`ci-rust-integration.yml` first builds a reusable smoke-test bundle once, then fans out into one matrix job per smoke scenario.

- `prepare-smoke-bundle` builds frontend assets, the `fileuni` binary, and all integration-test executables exactly once.
- Base smoke scenarios run as individual jobs again, so the Actions UI still shows one card per test.
- PostgreSQL, Redis, mail, and `rclone` scenarios remain isolated per test case while reusing the same prebuilt bundle.

This keeps per-test visibility without repeating frontend and Rust compilation in every job.

## Release Notes

- `release-publish.yml` is a `workflow_dispatch` workflow.
- It is typically triggered by `FileUni-WorkSpace/.github/workflows/trigger-public-project-release.yml`.
- If you use npm Trusted Publisher, update the trusted workflow path after this rename from `FileUni-release.yml` to `release-publish.yml`.

## Mirror Sync

Public mirror sync no longer lives in this repository.
It is executed directly from `FileUni-WorkSpace/.github/workflows/sync-public-mirrors.yml`.
