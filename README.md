[English](./README.md) | [简体中文](./README.zh-CN.md) | [Deutsch](./README.de.md) | [Français](./README.fr.md) | [Italiano](./README.it.md) | [日本語](./README.ja.md) | [한국어](./README.ko.md) | [हिन्दी](./README.hi.md) | [Bahasa Indonesia](./README.id.md) | [Tiếng Việt](./README.vi.md) | [ไทย](./README.th.md)

[![Website](https://img.shields.io/badge/Website-fileuni.com-blue)](https://fileuni.com/) [![Language](https://img.shields.io/badge/Language-Rust-orange)](https://www.rust-lang.org/) [![License](https://img.shields.io/badge/License-Proprietary-red)](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)

# FileUni Project

<p align="center">
  <a href="https://fileuni.com"><img src="https://img.shields.io/badge/Website-fileuni.com-blue?style=for-the-badge" alt="Website"></a>
  <a href="https://docs.fileuni.com"><img src="https://img.shields.io/badge/Docs-docs.fileuni.com-green?style=for-the-badge" alt="Documentation"></a>
  <a href="https://github.com/FileUni/FileUni-Project"><img src="https://img.shields.io/badge/GitHub-FileUni-black?style=for-the-badge&logo=github" alt="GitHub"></a>
  <a href="https://hub.docker.com/r/fileuni/fileuni"><img src="https://img.shields.io/badge/Docker-fileuni-blue?style=for-the-badge&logo=docker" alt="Docker Hub"></a>
</p>

> ⚠️ Notice: This project is in its early stages. It may be unstable and is currently intended for testing and educational use only.

**FileUni** is a next-generation storage and file management platform built with Rust for performance, security, and modular deployment.

From ultra-light devices to full servers, FileUni is designed to provide NAS-style capabilities without requiring dedicated hardware, while keeping one scalable codebase across CLI, GUI, and web-facing components.

## What This Repository Is

This repository is the public project hub for FileUni. It is mainly used for:

- Automated build and release workflows
- Public issue tracking and feedback
- Community-facing project coordination
- Subtree-based downstream sync targets

The main development workspace lives in the private monorepo and selected components are synchronized here for release and public collaboration.

## Why FileUni

- High-performance Rust architecture
- Modular design for different deployment sizes
- NAS features without dedicated hardware
- Multi-protocol access including FTP, SFTP, WebDAV, and S3
- Storage-oriented reliability and security focus

## Related Repositories

- [OfficialSiteDocs](https://github.com/FileUni/OfficialSiteDocs) - Documentation
- [frontends](https://github.com/FileUni/frontends) - Frontend components
- [yh-filemanager-vfs-storage-hub](https://github.com/FileUni/yh-filemanager-vfs-storage-hub) - VFS core
- [homebrew-fileuni](https://github.com/FileUni/homebrew-fileuni) - Homebrew tap
- [scoop-fileuni](https://github.com/FileUni/scoop-fileuni) - Scoop bucket
- [nixpkgs-fileuni](https://github.com/FileUni/nixpkgs-fileuni) - Nix package

## Source Availability

This repository contains the public project layer of FileUni. Additional modules may be opened gradually over time.

The published source is intended for reading, review, release automation, and security or audit visibility.

For source usage and licensing terms, see [LICENSE](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE).

For usage, licensing, or collaboration questions, contact email: `contact@fileuni.com`.
