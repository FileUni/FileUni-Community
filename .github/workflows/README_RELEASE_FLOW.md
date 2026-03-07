# FileUni Release Flow (Community Side)

## Purpose

This document describes the public build-and-release pipeline in `FileUni-Community`.
The pipeline is triggered manually or dispatched from `FileUni-WorkSpace`.

## Workflow

- Workflow: `NewBuildReleaesByZig.yml`
- Trigger: `workflow_dispatch` (manual or API-dispatch)
- Required secret: `FILEUNI_WORKSPACE_PAT`

## Source of Truth

- Build source repository: `FileUni/FileUni-WorkSpace`
- Source ref: input `workspace_ref` (empty = `main`)
- Release tag: input `release_tag` (used only for GitHub Release in `FileUni-Community`)

## Release Stack

The pipeline is strictly based on:

- `build.zig` + `script-new-zig` (orchestration/validation)
- `cargo-dist` (CLI artifact build)
- `tauri-action` (GUI artifact build)
- `action-gh-release` (publish assets to GitHub release)

Legacy custom packaging scripts are not supported.

## High-Level Stages

1. Resolve release metadata and mode.
2. Resolve build plan from `script-new-zig/build_matrix.jsonc`.
3. Build frontend once and reuse artifacts.
4. Build CLI artifacts with `cargo-dist` matrix.
5. Build GUI artifacts with `tauri-action` matrix.
6. Merge artifacts and publish with `action-gh-release`.
7. Write workflow summary via `zig build release-run -- ci:write-release-summary`.

## Mobile Build Gate

`ci:resolve-build-plan` auto-detects mobile scaffolding:

- Android ready if `apps/gui/src-tauri/gen/android` or `apps/gui/gen/android` exists.
- iOS ready if `apps/gui/src-tauri/gen/apple|ios` or `apps/gui/gen/apple|ios` exists.

If not ready, mobile jobs are disabled instead of failing late.
