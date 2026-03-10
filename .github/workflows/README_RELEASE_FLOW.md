# FileUni Release Flow (Project Side)

## Workflow Files

- Upstream trigger in WorkSpace: `.github/workflows/trigger-project-release.yml`
- Downstream build/publish workflow in Project: `FileUni-release.yml`
- Required secret in Project: `FILEUNI_WORKSPACE_PAT`
- Optional publish secret in Project: `NPM_TOKEN`
- npm packaging manifest: `.github/npm/npm-packages.json`
- npm package builder: `.github/scripts/build_npm_packages.py`

## Trigger Sources

`FileUni-release.yml` is always a `workflow_dispatch` workflow, but it can be reached from three different sources:

| Source | How it is triggered | Key inputs passed to Project | Default release name |
|--------|---------------------|------------------------------|----------------------|
| App tag release | WorkSpace pushes `fileuni-v*` and dispatches Project | `workspace_ref=<tag>`, `trigger_mode=tag`, `prerelease=false` | `FileUni-v...` |
| Nightly release | WorkSpace schedule runs daily at 03:45 Asia/Shanghai (`45 19 * * *` UTC) | `workspace_ref=main`, `trigger_mode=nightly`, `prerelease=true` | `nightly_YYYYMMDD_HHMMSS` |
| Direct manual dispatch | User runs `FileUni-release.yml` manually in Project | `trigger_mode=manual` by default | `release_name` if provided, otherwise `manually_YYYYMMDD_HHMMSS` |

## Release Name Resolution

The final GitHub release `tag_name` and display `name` are resolved in this order:

1. `release_name` input, if it is non-empty
2. `trigger_mode=tag` → `FileUni-v...`
3. `trigger_mode=nightly` → `nightly_YYYYMMDD_HHMMSS`
4. `trigger_mode=manual` → `manually_YYYYMMDD_HHMMSS`

Timestamps are generated in the `Asia/Shanghai` timezone.

## Manual Inputs

Important `workflow_dispatch` inputs:

- `workspace_ref` — source ref in `FileUni-WorkSpace`
- `release_name` — optional manual override for the release name
- `trigger_mode` — `manual`, `tag`, or `nightly`
- `build_mode` — `full` or `minimal`
- `build_target` — `cli`, `gui`, or `cli+gui`
- `prerelease` — whether the GitHub release is marked as pre-release
- `enable_upx` — whether UPX-compressed copies are produced where supported

## Stages

1. **resolve-matrix** — Resolve source ref, release metadata, and build matrix
2. **build-frontends** — Build CLI and GUI frontend assets from WorkSpace
3. **build-cli** — Build CLI artifacts across cargo-dist, cross, Android, BSD, and package formats
4. **build-gui** — Build GUI artifacts across desktop Tauri, Android, and iOS paths
5. **package-npm-platforms** — Convert CLI release artifacts into platform-specific npm packages
6. **publish-npm** — Publish platform packages first, then publish the root `fileuni` npm package
7. **publish** — Collect standardized `FileUni-*` artifacts, generate release notes, and publish the GitHub Release

## Artifact Naming

- Final release assets are standardized as `FileUni-*`
- Architecture, OS, and libc naming are centralized in `.github/scripts/arch-helpers.sh`
- The publish step removes non-standard filenames before uploading release assets

## Build Coverage

The exact matrix is resolved from `.github/build_matrix.jsonc`, but the workflow currently supports:

- CLI native and cross builds
- CLI Android builds
- CLI FreeBSD builds
- Linux package builds via nFPM
- npm CLI packages for Linux `gnu` / `musl`, Windows, macOS, Android, and FreeBSD
- GUI desktop Tauri builds
- GUI Android APK builds
- GUI iOS IPA packaging

## npm Publish Rules

- npm publish is enabled only when `build_mode=full`
- npm publish requires CLI builds to be enabled
- if `NPM_TOKEN` is empty, the workflow emits a warning and skips npm publish
- platform packages are published before the root package, so `fileuni` never references unpublished platform versions
- Linux publishes both `gnu` and `musl` variants
- the root package prefers `gnu` first when both `gnu` and `musl` variants are present locally

## npm Package Layout

- Root package: `fileuni`
- Platform packages: `@fileuni/fileuni-*`
- Platform metadata, target mapping, `os` / `cpu` / `libc`, and package names are all defined in `.github/npm/npm-packages.json`
- This design is fully independent from `packages/`, so `packages/` can be removed later without affecting release publishing

## Notes

- The upstream dispatch workflow uses `ref: main` for the workflow file version, while `workspace_ref` controls which WorkSpace source ref is checked out and built.
- CLI remains friendly to cross-compilation, while GUI release jobs include platform-specific packaging steps.
