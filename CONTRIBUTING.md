# Contributing Guide

Thank you for your interest in contributing to FileUni!

## Where to Submit

| Type | Location |
|------|----------|
| Bug Reports | [Issues](https://github.com/FileUni/FileUni-Project/issues/new/choose) |
| Feature Requests | [Issues](https://github.com/FileUni/FileUni-Project/issues/new/choose) |
| Security Issues | Email security@fileuni.com (do not open public issues) |

> This repository serves as the public hub for issue tracking and release workflows. Source code is published for reading, review, and security/audit purposes.

---

## Language Policy

All communications in this repository must be in English, including code, comments, documentation, commit messages, issues, and pull requests.

### Why English?

- Global Accessibility: Contributors from all regions can collaborate effectively
- Consistency: A single language keeps discussions organized and searchable
- Open Source Best Practice: Most successful open-source projects use English as the lingua franca

### Need Help with English?

If English isn't your first language, don't worry! We value your contributions regardless of perfect grammar. You can:

- Use translation tools to help compose messages
- Ask for help from other community members
- Focus on clear, simple communication rather than perfect prose

---

## Code Review Checklist

### Security & Safety

- [ ] No user data leakage risks or server security vulnerabilities
- [ ] No data loss risks (accidental deletion of data/files/code)
- [ ] No path traversal vulnerabilities - use `canonicalize` or strict filtering for all file path operations
- [ ] No sensitive data in logs (passwords, JWT tokens, private keys)
- [ ] No SQL injection - avoid string concatenation for raw SQL
- [ ] No XSS vulnerabilities in frontend code

### Rust Standards

- [ ] Zero `.unwrap()` / `.expect()` - Use `?` operator or `match` for error propagation
- [ ] Clippy compliance - `cargo clippy -- -D warnings` must pass with zero warnings
- [ ] Code formatting - `cargo fmt` must pass
- [ ] Single file < 500 lines - Files > 800 lines need splitting; > 1000 lines mandatory split
- [ ] No `mut` without justification - Prefer immutable by default
- [ ] Minimize `.clone()` - Consider references, `Cow`, `Arc` before cloning
- [ ] Use iterator chains - Prefer `map`, `filter`, `collect` over manual loops
- [ ] No blocking in async - Use `spawn_blocking` for CPU-intensive operations
- [ ] Timeout for spawn - All `tokio::spawn` tasks must include timeout (default 24h), except permanent background services

### Async & Concurrency

- [ ] Use `RwLock` for read-heavy concurrent access, `Mutex` for exclusive write
- [ ] No sync I/O or `thread::sleep` in async context
- [ ] Check for deadlock risks with locks
- [ ] Verify `Send` and `Sync` constraints are correct
- [ ] Check file descriptor and connection pool exhaustion in high-concurrency scenarios

### Database Operations

- [ ] Use SeaORM Query Builder - no `raw_sql`
- [ ] Table prefix: `yh_`
- [ ] No N+1 queries - avoid SQL in loops
- [ ] Index high-frequency query fields
- [ ] Minimize transaction scope to reduce lock contention
- [ ] Support both PostgreSQL and SQLite
- [ ] Auto-create tables if not exist on startup

### API & Web

- [ ] RESTful paths with `utoipa` annotations
- [ ] Return `Result<impl IntoResponse, AppError>`
- [ ] Admin endpoints start with `/admin/`
- [ ] DTO fields match `utoipa` schema descriptions
- [ ] Extraction order: `(Method, Header, State, Path, Query, Json)`

### Frontend (TypeScript/React/Astro)

- [ ] Zero `any` types - Use `bun run gen-api` for auto-generated types
- [ ] Type check - `bun run check` must pass with zero errors and warnings
- [ ] Format - `bun run format` must pass
- [ ] Use `openapi-fetch` from `src/lib/api.ts`
- [ ] All `t('key')` must exist in all language files
- [ ] Modals close on `Esc` key
- [ ] Minimum sizes: font ≥ 14px, button ≥ 32px height, clickable icons ≥ 24px

### Configuration

- [ ] No environment variables - All config from config files only
- [ ] Config struct 100% matches `{config-date}/config.toml`
- [ ] No hardcoded paths - use `{APPDATADIR}` placeholder
- [ ] Module business params in module's `config.rs`

### File Manager Specific

- [ ] All file operations through VFS abstraction layer
- [ ] Index refresh: single queue, user requests have highest priority
- [ ] WebDAV: RFC4918 compliant (PROPPATCH returns 403 Forbidden - acceptable)
- [ ] SFTP: Support username/password + certificate auth
- [ ] S3: AWS Signature V4 verification required

---

## Pull Request Requirements

### Description Template

```markdown
## Motivation
Why is this change needed?

## Key Changes
Main improvements and technical implementation.

## Testing
How was this tested?

## Compliance
How does it follow project conventions?
```

### Mandatory Checks

Rust:
```bash
cargo clippy -- -D warnings
cargo fmt --check
```

Frontend:
```bash
cd frontends && bun run check
```

---

## Module Architecture

| Category | Modules |
|----------|---------|
| Core | `fileuni-lib`, `yh-database`, `yh-response`, `yh-api-middlewares` |
| Config | `yh-config-aggregator`, `yh-config-infra`, `yh-config-macros`, `yh-config-mode-api` |
| File Storage | [yh-filemanager-vfs-storage-hub](https://github.com/FileUni/yh-filemanager-vfs-storage-hub) (VFS core) |
| File Protocols | `yh-file-manager-serv-api`, `serv-s3`, `serv-webdav`, `serv-ftp`, `serv-sftp` |
| User | `yh-user-center` |
| Task & Log | `yh-task-registry`, `yh-journal-log` |

---

## Questions?

Open an issue at [FileUni/FileUni-Project](https://github.com/FileUni/FileUni-Project/issues) for any questions about contributing.
