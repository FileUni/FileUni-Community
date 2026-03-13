[English](./README.md) | [简体中文](./README.zh-CN.md) | [Deutsch](./README.de.md) | [Français](./README.fr.md) | [Italiano](./README.it.md) | [日本語](./README.ja.md) | [한국어](./README.ko.md) | [हिन्दी](./README.hi.md) | [Bahasa Indonesia](./README.id.md) | [Tiếng Việt](./README.vi.md) | [ไทย](./README.th.md)

[![Website](https://img.shields.io/badge/Website-fileuni.com-blue)](https://fileuni.com/) [![Language](https://img.shields.io/badge/Language-Rust-orange)](https://www.rust-lang.org/) [![License](https://img.shields.io/badge/License-Proprietary-red)](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)

# FileUni Project

<p align="center">
  <a href="https://fileuni.com"><img src="https://img.shields.io/badge/Site_Web-fileuni.com-blue?style=for-the-badge" alt="Site Web"></a>
  <a href="https://docs.fileuni.com"><img src="https://img.shields.io/badge/Documentation-docs.fileuni.com-green?style=for-the-badge" alt="Documentation"></a>
  <a href="https://github.com/FileUni/FileUni-Project"><img src="https://img.shields.io/badge/GitHub-FileUni-black?style=for-the-badge&logo=github" alt="GitHub"></a>
  <a href="https://hub.docker.com/r/fileuni/fileuni"><img src="https://img.shields.io/badge/Docker-fileuni-blue?style=for-the-badge&logo=docker" alt="Docker Hub"></a>
</p>

> ⚠️ Remarque : Ce projet est encore à un stade précoce. Il peut être instable et est actuellement destiné uniquement aux tests et à un usage éducatif.

**FileUni** est une plateforme de stockage et de gestion de fichiers de nouvelle génération, développée en Rust pour la performance, la sécurité et le déploiement modulaire.

Des appareils très légers aux serveurs complets, FileUni fournit des capacités de type NAS sans matériel dédié, avec une base de code unique et évolutive pour les composants CLI, GUI et web.

## Ce dépôt

Ce dépôt est le hub public du projet FileUni. Il est principalement utilisé pour :

- Les workflows automatisés de build et de release
- Le suivi public des issues et des retours
- La coordination du projet côté communauté
- Les cibles de synchronisation basées sur subtree

L'espace principal de développement se trouve dans un monorepo privé, et certains composants sont synchronisés ici pour les releases et la collaboration publique.

## Pourquoi FileUni

- Architecture haute performance basée sur Rust
- Conception modulaire pour différents niveaux de déploiement
- Fonctions NAS sans coût matériel dédié
- Accès multi-protocole avec FTP, SFTP, WebDAV et S3
- Accent sur la fiabilité et la sécurité pour le stockage

## Dépôts associés

- [OfficialSiteDocs](https://github.com/FileUni/OfficialSiteDocs) - Documentation
- [frontends](https://github.com/FileUni/frontends) - Composants frontend
- [yh-filemanager-vfs-storage-hub](https://github.com/FileUni/yh-filemanager-vfs-storage-hub) - Noyau VFS
- [homebrew-fileuni](https://github.com/FileUni/homebrew-fileuni) - Homebrew tap
- [scoop-fileuni](https://github.com/FileUni/scoop-fileuni) - Scoop bucket
- [nixpkgs-fileuni](https://github.com/FileUni/nixpkgs-fileuni) - Paquet Nix

## Disponibilité du code source

Ce dépôt contient la couche publique du projet FileUni. D'autres modules pourront être ouverts progressivement.

Le code publié est destiné à la lecture, à la revue, à l'automatisation des releases et à la visibilité de sécurité ou d'audit.

Pour les conditions d'utilisation du code source et de licence, consultez directement [LICENSE](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE).

Pour toute question sur l'usage, la licence ou la collaboration, contactez : `contact@fileuni.com`.
