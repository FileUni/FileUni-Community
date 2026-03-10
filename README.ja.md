[English](./README.md) | [简体中文](./README.zh-CN.md) | [Deutsch](./README.de.md) | [Français](./README.fr.md) | [Italiano](./README.it.md) | [日本語](./README.ja.md) | [한국어](./README.ko.md) | [हिन्दी](./README.hi.md) | [Bahasa Indonesia](./README.id.md) | [Tiếng Việt](./README.vi.md) | [ไทย](./README.th.md)

[![Website](https://img.shields.io/badge/Website-fileuni.com-blue)](https://fileuni.com/) [![Language](https://img.shields.io/badge/Language-Rust-orange)](https://www.rust-lang.org/) [![License](https://img.shields.io/badge/License-Proprietary-red)](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)

# FileUni Project

> ⚠️ 注意: このプロジェクトはまだ初期段階です。不安定な場合があり、現在はテストおよび学習目的での利用のみを想定しています。

**FileUni** は、性能・セキュリティ・モジュール型デプロイを重視して Rust で構築された次世代のストレージおよびファイル管理プラットフォームです。

超軽量デバイスから本格的なサーバーまで、専用ハードウェアなしで NAS のような機能を提供し、CLI、GUI、Web コンポーネント全体で単一の拡張可能なコードベースを維持します。

## このリポジトリについて

このリポジトリは FileUni の公開プロジェクトハブです。主な用途は次のとおりです。

- 自動ビルドおよびリリースワークフロー
- 公開 Issue とフィードバック管理
- コミュニティ向けのプロジェクト調整
- subtree ベースの同期先

メインの開発ワークスペースはプライベートな monorepo にあり、一部コンポーネントがリリースと公開コラボレーションのためにここへ同期されます。

## FileUni の特徴

- Rust ベースの高性能アーキテクチャ
- さまざまな導入規模に対応するモジュール設計
- 専用ハードウェア不要の NAS 機能
- FTP、SFTP、WebDAV、S3 を含むマルチプロトコルアクセス
- ストレージ用途に特化した信頼性とセキュリティ重視

## 関連リポジトリ

- [OfficialSiteDocs](https://github.com/FileUni/OfficialSiteDocs) - ドキュメント
- [frontends](https://github.com/FileUni/frontends) - フロントエンドコンポーネント
- [yh-filemanager-vfs-storage-hub](https://github.com/FileUni/yh-filemanager-vfs-storage-hub) - VFS コア
- [homebrew-fileuni](https://github.com/FileUni/homebrew-fileuni) - Homebrew tap
- [scoop-fileuni](https://github.com/FileUni/scoop-fileuni) - Scoop bucket
- [nixpkgs-fileuni](https://github.com/FileUni/nixpkgs-fileuni) - Nix package

## ソース公開について

このリポジトリには FileUni の公開プロジェクト層が含まれます。今後さらに多くのモジュールが段階的に公開される可能性があります。

公開されたソースは、閲覧、レビュー、リリース自動化、およびセキュリティ・監査上の可視性のために提供されます。

ソースコードの利用条件およびライセンス条件は [LICENSE](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE) を参照してください。

利用、ライセンス、協業に関するお問い合わせ先: `contact@fileuni.com`。
