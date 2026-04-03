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

`ci-rust-integration.yml` groups smoke tests by runtime profile instead of compiling in one job per test case.

- Base suites cover HTTP, cloud, feature, website, and file-protocol smoke tests.
- PostgreSQL suites cover the database-backed and Redis-backed variants.
- Mail suites cover the SMTP/IMAP scenarios across supported backend combinations.
- The remote-mount suite isolates the `rclone` dependency.

This keeps the matrix understandable while avoiding the previous one-workflow-per-test explosion.

## Release Notes

- `release-publish.yml` is a `workflow_dispatch` workflow.
- It is typically triggered by `FileUni-WorkSpace/.github/workflows/trigger-public-project-release.yml`.
- If you use npm Trusted Publisher, update the trusted workflow path after this rename from `FileUni-release.yml` to `release-publish.yml`.

## Mirror Sync

Public mirror sync no longer lives in this repository.
It is executed directly from `FileUni-WorkSpace/.github/workflows/sync-public-mirrors.yml`.
