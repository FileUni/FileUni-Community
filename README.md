# FileUni-Community

Community-facing release repository for FileUni artifacts.

## What this repository does

- Hosts GitHub Actions workflows under `.github/workflows`
- Pulls source from private `fileuni/FileUni-WorkSpace`
- Builds CLI + GUI binaries via:

```bash
go run script/tools.go release:build-all <mode> --output-dir /tmp/FileUniRelease
```

- Publishes release assets to **this repository's Releases**

## Required configuration

### 1) Repository Secret

- Name: `FILEUNI_WORKSPACE_PAT`
- Value: a GitHub PAT that can read `fileuni/FileUni-WorkSpace`
- Minimum scope: `repo` (or fine-grained read access to that repo)

### 2) Optional Repository Variable

- Name: `BUILD_MODE`
- Value: one of `full`, `medium`, `lite`, `minimal`
- Default fallback in workflow: `minimal`

### 3) Optional Repository Variable

- Name: `WORKSPACE_DEFAULT_REF`
- Value: a stable branch for fallback (recommended: `main`)
- Usage: when push tag `v*` exists in `FileUni-Community` but same ref is missing in `fileuni/FileUni-WorkSpace`, workflow falls back to this branch

## Workflow triggers

- Push tag: `v*` (e.g. `v1.2.3`)
- Manual: `workflow_dispatch`
  - `release_tag` (required)
  - `workspace_ref` (optional, default tag on push / `WORKSPACE_DEFAULT_REF`/`main` on manual)
  - `build_mode` (optional)
  - `prerelease` (optional)

## Ref resolution behavior

1. If `workspace_ref` is provided, workflow tries it first.
2. If omitted:
   - tag push: use tag name from `FileUni-Community`
   - manual run: use `WORKSPACE_DEFAULT_REF` or `main`
3. If requested ref is missing in `fileuni/FileUni-WorkSpace`, workflow falls back to `WORKSPACE_DEFAULT_REF` (or `main`).
4. If both requested ref and fallback ref are missing, workflow fails fast.
