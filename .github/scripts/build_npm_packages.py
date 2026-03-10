#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import os
import shutil
import stat
import subprocess
import sys
import tarfile
import tempfile
import zipfile
from pathlib import Path


def load_manifest(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path: Path, data: dict) -> None:
    path.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def copy_license(src: Path, dst_dir: Path) -> None:
    shutil.copy2(src, dst_dir / "LICENSE")


def render_template(template_path: Path, replacements: dict[str, str]) -> str:
    content = template_path.read_text(encoding="utf-8")
    for key, value in replacements.items():
        content = content.replace(f"{{{{{key}}}}}", value)
    return content


def find_binary_in_artifact(artifact_dir: Path, expected_name: str, extract_dir: Path) -> Path:
    zip_files = sorted(artifact_dir.rglob("*.zip"))
    tar_files = sorted(artifact_dir.rglob("*.tar.xz"))

    if zip_files:
        with zipfile.ZipFile(zip_files[0]) as archive:
            archive.extractall(extract_dir)
    elif tar_files:
        with tarfile.open(tar_files[0], mode="r:xz") as archive:
            archive.extractall(extract_dir)
    else:
        direct = list(artifact_dir.rglob(expected_name))
        if direct:
            target = extract_dir / expected_name
            shutil.copy2(direct[0], target)
            return target
        raise FileNotFoundError(f"No archive or direct binary found in {artifact_dir}")

    matches = sorted(p for p in extract_dir.rglob(expected_name) if p.is_file())
    if not matches:
        raise FileNotFoundError(f"{expected_name} not found after extracting {artifact_dir}")
    return matches[0]


def normalize_repo_url() -> str:
    return "https://github.com/fileuni/FileUni-WorkSpace.git"


def create_platform_package(args: argparse.Namespace) -> int:
    manifest = load_manifest(Path(args.manifest))
    target = args.target
    platform = next((item for item in manifest["platforms"] if item["target"] == target), None)
    if platform is None:
        raise SystemExit(f"Target not found in manifest: {target}")

    output_dir = Path(args.output).resolve()
    artifact_dir = Path(args.artifact).resolve()
    license_path = Path(args.license).resolve()
    template_path = Path(args.template).resolve()

    package_dir = output_dir / platform["package_name"].replace("/", "__")
    bin_dir = package_dir / "bin"
    package_dir.mkdir(parents=True, exist_ok=True)
    bin_dir.mkdir(parents=True, exist_ok=True)

    with tempfile.TemporaryDirectory(prefix="fileuni-npm-extract-") as tmp:
        extracted = find_binary_in_artifact(artifact_dir, platform["binary_name"], Path(tmp))
        destination_binary = bin_dir / platform["binary_name"]
        shutil.copy2(extracted, destination_binary)
        destination_binary.chmod(destination_binary.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)

    package_json = {
        "name": platform["package_name"],
        "version": args.version,
        "description": f"Prebuilt FileUni CLI binary for {target}.",
        "license": "MIT",
        "repository": {
            "type": "git",
            "url": normalize_repo_url(),
            "directory": ".github/npm",
        },
        "homepage": "https://fileuni.com",
        "bugs": {
            "url": "https://github.com/fileuni/FileUni-WorkSpace/issues",
        },
        "files": [
            "bin",
            "README.md",
            "LICENSE",
        ],
        "bin": {
            "fileuni": f"./bin/{platform['binary_name']}"
        },
        "os": [platform["os"]],
        "cpu": [platform["cpu"]],
        "publishConfig": {
            "access": "public"
        }
    }
    if platform.get("libc"):
        package_json["libc"] = [platform["libc"]]

    write_json(package_dir / "package.json", package_json)
    copy_license(license_path, package_dir)
    readme = render_template(
        template_path,
        {
            "PACKAGE_NAME": platform["package_name"],
            "TARGET": target,
        },
    )
    (package_dir / "README.md").write_text(readme, encoding="utf-8")
    return 0


WRAPPER_TEMPLATE = """#!/usr/bin/env node
const fs = require('node:fs');
const path = require('node:path');
const { spawn } = require('node:child_process');

const PLATFORMS = __PLATFORMS__;

function detectLibc() {
  if (process.platform !== 'linux') {
    return null;
  }

  const report = process.report;
  if (report && typeof report.getReport === 'function') {
    const glibcVersion = report.getReport()?.header?.glibcVersionRuntime;
    if (glibcVersion) {
      return 'gnu';
    }
  }

  return 'musl';
}

function libcScore(entry, currentLibc) {
  if (!entry.libc) {
    return 2;
  }
  if (currentLibc && entry.variant === currentLibc) {
    return 0;
  }
  if (entry.variant === 'gnu') {
    return 1;
  }
  if (entry.variant === 'musl') {
    return 2;
  }
  return 3;
}

function candidates() {
  const currentLibc = detectLibc();
  return PLATFORMS
    .filter((entry) => entry.os === process.platform && entry.cpu === process.arch)
    .sort((left, right) => libcScore(left, currentLibc) - libcScore(right, currentLibc));
}

function resolveBinary(entry) {
  try {
    const packageJsonPath = require.resolve(`${entry.package_name}/package.json`);
    const packageDir = path.dirname(packageJsonPath);
    const binaryPath = path.join(packageDir, 'bin', entry.binary_name);
    if (fs.existsSync(binaryPath)) {
      return binaryPath;
    }
  } catch (error) {
    if (error && error.code !== 'MODULE_NOT_FOUND') {
      throw error;
    }
  }
  return null;
}

function installHints() {
  return candidates().map((entry) => `npm install ${entry.package_name}`).join('\\n');
}

const binary = candidates()
  .map(resolveBinary)
  .find(Boolean);

if (!binary) {
  const details = installHints() || 'npm install fileuni';
  console.error(`FileUni binary package is missing for ${process.platform}/${process.arch}.`);
  console.error(details);
  process.exit(1);
}

const child = spawn(binary, process.argv.slice(2), { stdio: 'inherit' });
child.on('exit', (code, signal) => {
  if (signal) {
    process.kill(process.pid, signal);
    return;
  }
  process.exit(code ?? 0);
});
"""


def create_root_package(args: argparse.Namespace) -> int:
    manifest = load_manifest(Path(args.manifest))
    root = manifest["root_package"]
    license_path = Path(args.license).resolve()
    template_path = Path(args.template).resolve()
    output_dir = Path(args.output).resolve()
    package_dir = output_dir / root["name"]
    bin_dir = package_dir / "bin"
    package_dir.mkdir(parents=True, exist_ok=True)
    bin_dir.mkdir(parents=True, exist_ok=True)

    optional_dependencies = {
        entry["package_name"]: args.version
        for entry in manifest["platforms"]
    }
    package_json = {
        "name": root["name"],
        "version": args.version,
        "description": root["description"],
        "license": "MIT",
        "repository": {
            "type": "git",
            "url": normalize_repo_url(),
            "directory": root["repository_directory"],
        },
        "homepage": "https://fileuni.com",
        "bugs": {
            "url": "https://github.com/fileuni/FileUni-WorkSpace/issues",
        },
        "files": [
            "bin",
            "README.md",
            "LICENSE",
        ],
        "bin": {
            "fileuni": "./bin/fileuni.js"
        },
        "optionalDependencies": optional_dependencies,
        "publishConfig": {
            "access": "public"
        },
        "engines": {
            "node": ">=18.0.0"
        }
    }
    write_json(package_dir / "package.json", package_json)
    copy_license(license_path, package_dir)
    (package_dir / "README.md").write_text(template_path.read_text(encoding="utf-8"), encoding="utf-8")

    wrapper_platforms = [
        {
            "package_name": entry["package_name"],
            "os": entry["os"],
            "cpu": entry["cpu"],
            "variant": entry.get("variant"),
            "libc": entry.get("libc"),
            "binary_name": entry["binary_name"],
        }
        for entry in manifest["platforms"]
    ]
    wrapper = WRAPPER_TEMPLATE.replace("__PLATFORMS__", json.dumps(wrapper_platforms, ensure_ascii=False))
    wrapper_path = bin_dir / "fileuni.js"
    wrapper_path.write_text(wrapper, encoding="utf-8")
    wrapper_path.chmod(wrapper_path.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)
    return 0


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Build FileUni npm packages from release artifacts")
    subparsers = parser.add_subparsers(dest="command", required=True)

    common = argparse.ArgumentParser(add_help=False)
    common.add_argument("--manifest", required=True)
    common.add_argument("--version", required=True)
    common.add_argument("--output", required=True)
    common.add_argument("--license", required=True)
    common.add_argument("--template", required=True)

    platform = subparsers.add_parser("platform", parents=[common])
    platform.add_argument("--target", required=True)
    platform.add_argument("--artifact", required=True)

    subparsers.add_parser("root", parents=[common])
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    if args.command == "platform":
        return create_platform_package(args)
    if args.command == "root":
        return create_root_package(args)
    raise SystemExit(f"Unsupported command: {args.command}")


if __name__ == "__main__":
    sys.exit(main())
