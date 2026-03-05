# FileUni Two-Repo Release Flow (Community Side)

## Purpose
This workflow file documents the public build-and-release pipeline in `FileUni-Community`.
The pipeline is dispatched from `FileUni-WorkSpace` or manually triggered.

## Workflow
- Workflow: `community-build-release.yml`
- Trigger: `workflow_dispatch`
- Required secret: `FILEUNI_WORKSPACE_PAT`

## Current Design
Most logic previously implemented with shell blocks has been migrated to Go commands in `workspace/script/tools.go`.
YAML now focuses on orchestration and cache declarations.

## Step Responsibilities
1. Bootstrap checkout of `fileuni/FileUni-WorkSpace`.
2. Setup Go and run:
   - `ci:resolve-community-build` (input normalization, prerelease detection, source ref resolution)
   - `ci:checkout-workspace-ref` (checkout final resolved ref + submodules)
3. Setup Bun/Rust/Zig and restore caches.
4. Run:
   - `ci:prepare-tools` (system deps + cargo helper tools, preferring prebuilt binary path)
5. Build artifacts:
   - `release:build-all`
   - `ci:assert-artifacts`
6. Publish release:
   - `ci:publish-community-release` (create/update release, reconcile prerelease, upload assets)
7. Write summary:
   - `ci:write-release-summary`

## Caching Strategy
- `~/.cargo-tools` for installed tool binaries.
- `~/.cache/cargo-binstall` for binstall metadata.
- `~/.cargo/registry` and `~/.cargo/git` for cargo dependency caches.
- `workspace/target` keyed by mode + `Cargo.lock` hash.
- `~/.bun/install/cache` for Bun package downloads.

## Tool Installation Strategy
For `tauri-cli`, `cargo-zigbuild`, and `cargo-xwin`:
1. Prefer `cargo-binstall` / prebuilt binaries.
2. Fallback to `cargo install` only if prebuilt install is unavailable.

This reduces environment preparation time on cache hits and avoids unnecessary source builds.

## Stability Notes
- `minimal` mode now uses `x86_64-unknown-linux-gnu` by default (CLI + GUI).
- Host-native targets are built with native cargo/tauri commands (no zig runner), which avoids common OpenSSL cross-linking failures seen in GNU/musl mixed pipelines.
