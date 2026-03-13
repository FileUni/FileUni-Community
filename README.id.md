[English](./README.md) | [简体中文](./README.zh-CN.md) | [Deutsch](./README.de.md) | [Français](./README.fr.md) | [Italiano](./README.it.md) | [日本語](./README.ja.md) | [한국어](./README.ko.md) | [हिन्दी](./README.hi.md) | [Bahasa Indonesia](./README.id.md) | [Tiếng Việt](./README.vi.md) | [ไทย](./README.th.md)

[![Website](https://img.shields.io/badge/Website-fileuni.com-blue)](https://fileuni.com/) [![Language](https://img.shields.io/badge/Language-Rust-orange)](https://www.rust-lang.org/) [![License](https://img.shields.io/badge/License-Proprietary-red)](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)

# FileUni Project

<p align="center">
  <a href="https://fileuni.com"><img src="https://img.shields.io/badge/Website-fileuni.com-blue?style=for-the-badge" alt="Website"></a>
  <a href="https://docs.fileuni.com"><img src="https://img.shields.io/badge/Dokumentasi-docs.fileuni.com-green?style=for-the-badge" alt="Dokumentasi"></a>
  <a href="https://github.com/FileUni/FileUni-Project"><img src="https://img.shields.io/badge/GitHub-FileUni-black?style=for-the-badge&logo=github" alt="GitHub"></a>
  <a href="https://hub.docker.com/r/fileuni/fileuni"><img src="https://img.shields.io/badge/Docker-fileuni-blue?style=for-the-badge&logo=docker" alt="Docker Hub"></a>
</p>

> ⚠️ Pemberitahuan: Proyek ini masih dalam tahap awal. Proyek ini mungkin belum stabil dan saat ini hanya ditujukan untuk pengujian serta penggunaan edukasi.

**FileUni** adalah platform penyimpanan dan manajemen file generasi berikutnya yang dibangun dengan Rust untuk performa, keamanan, dan deployment modular.

Dari perangkat ultra-ringan hingga server penuh, FileUni dirancang untuk menghadirkan kemampuan seperti NAS tanpa membutuhkan perangkat keras khusus, dengan satu codebase yang dapat diskalakan untuk komponen CLI, GUI, dan web.

## Tentang repositori ini

Repositori ini adalah hub proyek publik untuk FileUni. Fungsi utamanya adalah:

- Workflow build dan release otomatis
- Pelacakan issue publik dan feedback
- Koordinasi proyek yang menghadap komunitas
- Target sinkronisasi downstream berbasis subtree

Workspace pengembangan utama berada di monorepo privat, dan beberapa komponen disinkronkan ke sini untuk release dan kolaborasi publik.

## Mengapa FileUni

- Arsitektur performa tinggi berbasis Rust
- Desain modular untuk berbagai skala deployment
- Fitur NAS tanpa perangkat keras khusus
- Akses multi-protokol termasuk FTP, SFTP, WebDAV, dan S3
- Fokus pada keandalan dan keamanan untuk beban kerja storage

## Repositori terkait

- [OfficialSiteDocs](https://github.com/FileUni/OfficialSiteDocs) - Dokumentasi
- [frontends](https://github.com/FileUni/frontends) - Komponen frontend
- [yh-filemanager-vfs-storage-hub](https://github.com/FileUni/yh-filemanager-vfs-storage-hub) - Inti VFS
- [homebrew-fileuni](https://github.com/FileUni/homebrew-fileuni) - Homebrew tap
- [scoop-fileuni](https://github.com/FileUni/scoop-fileuni) - Scoop bucket
- [nixpkgs-fileuni](https://github.com/FileUni/nixpkgs-fileuni) - Paket Nix

## Ketersediaan source code

Repositori ini berisi lapisan proyek publik dari FileUni. Modul tambahan dapat dibuka secara bertahap seiring waktu.

Source yang dipublikasikan ditujukan untuk dibaca, direview, otomatisasi release, dan visibilitas keamanan atau audit.

Untuk syarat penggunaan source code dan lisensi, lihat langsung [LICENSE](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE).

Untuk pertanyaan tentang penggunaan, lisensi, atau kolaborasi, hubungi: `contact@fileuni.com`.
