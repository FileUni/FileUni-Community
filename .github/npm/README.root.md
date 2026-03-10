# fileuni

FileUni CLI distributed through npm with platform-specific native binaries.

## Install

```bash
npm install fileuni
```

## Run

```bash
npx fileuni --help
```

## Explicit Platform Selection

If you want to pin a specific runtime variant, install the matching platform package directly.
The root package prefers GNU variants first when both GNU and musl packages are present.

Examples:

```bash
npm install @fileuni/fileuni-linux-x64-gnu
npm install @fileuni/fileuni-linux-x64-musl
```

## License

MIT
