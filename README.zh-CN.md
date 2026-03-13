[English](./README.md) | [简体中文](./README.zh-CN.md) | [Deutsch](./README.de.md) | [Français](./README.fr.md) | [Italiano](./README.it.md) | [日本語](./README.ja.md) | [한국어](./README.ko.md) | [हिन्दी](./README.hi.md) | [Bahasa Indonesia](./README.id.md) | [Tiếng Việt](./README.vi.md) | [ไทย](./README.th.md)

[![Website](https://img.shields.io/badge/Website-fileuni.com-blue)](https://fileuni.com/) [![Language](https://img.shields.io/badge/Language-Rust-orange)](https://www.rust-lang.org/) [![License](https://img.shields.io/badge/License-Proprietary-red)](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)

# FileUni Project

<p align="center">
  <a href="https://fileuni.com"><img src="https://img.shields.io/badge/官网-fileuni.com-blue?style=for-the-badge" alt="官网"></a>
  <a href="https://docs.fileuni.com/zh-cn/"><img src="https://img.shields.io/badge/文档站-docs.fileuni.com-green?style=for-the-badge" alt="文档站"></a>
  <a href="https://github.com/FileUni/FileUni-Project"><img src="https://img.shields.io/badge/GitHub-FileUni-black?style=for-the-badge&logo=github" alt="GitHub"></a>
  <a href="https://hub.docker.com/r/fileuni/fileuni"><img src="https://img.shields.io/badge/Docker-fileuni-blue?style=for-the-badge&logo=docker" alt="Docker Hub"></a>
</p>

> ⚠️ 提示：本项目仍处于早期阶段，可能不稳定，目前仅面向测试和学习用途。

**FileUni** 是一个面向高性能、安全性与模块化部署的下一代 Rust 存储与文件管理平台。

从超轻量设备到完整服务器，FileUni 以统一代码库提供类 NAS 能力，不依赖专用硬件，并可覆盖 CLI、GUI 与 Web 场景。

## 这个仓库是什么

这个仓库是 FileUni 的公开项目中心，主要用于：

- 自动化构建与发布流程
- 公开 Issue 与反馈收集
- 面向社区的项目协作
- 基于 subtree 的下游同步目标

FileUni 的主要开发工作区位于私有 monorepo，本仓库会同步部分组件用于发布与公开协作。

## 为什么是 FileUni

- 基于 Rust 的高性能架构
- 面向不同部署规模的模块化设计
- 无需专用硬件即可获得 NAS 能力
- 支持 FTP、SFTP、WebDAV、S3 等多协议访问
- 面向存储场景的可靠性与安全性设计

## 相关仓库

- [OfficialSiteDocs](https://github.com/FileUni/OfficialSiteDocs) - 文档站
- [frontends](https://github.com/FileUni/frontends) - 前端组件
- [yh-filemanager-vfs-storage-hub](https://github.com/FileUni/yh-filemanager-vfs-storage-hub) - VFS 核心
- [homebrew-fileuni](https://github.com/FileUni/homebrew-fileuni) - Homebrew tap
- [scoop-fileuni](https://github.com/FileUni/scoop-fileuni) - Scoop bucket
- [nixpkgs-fileuni](https://github.com/FileUni/nixpkgs-fileuni) - Nix package

## 源码开放情况

本仓库包含 FileUni 的公开项目层内容，更多模块会视情况逐步开放。

已发布源码主要用于阅读、审查、发布自动化，以及安全与审计可见性。

源码使用与授权条款请直接参见 [LICENSE](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)。

如需咨询使用、授权或合作，联系 email：`contact@fileuni.com`。
