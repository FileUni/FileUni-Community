[English](./README.md) | [简体中文](./README.zh-CN.md) | [Deutsch](./README.de.md) | [Français](./README.fr.md) | [Italiano](./README.it.md) | [日本語](./README.ja.md) | [한국어](./README.ko.md) | [हिन्दी](./README.hi.md) | [Bahasa Indonesia](./README.id.md) | [Tiếng Việt](./README.vi.md) | [ไทย](./README.th.md)

[![Website](https://img.shields.io/badge/Website-fileuni.com-blue)](https://fileuni.com/) [![Language](https://img.shields.io/badge/Language-Rust-orange)](https://www.rust-lang.org/) [![License](https://img.shields.io/badge/License-Proprietary-red)](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)

# FileUni Project

> ⚠️ 안내: 이 프로젝트는 아직 초기 단계에 있습니다. 불안정할 수 있으며 현재는 테스트 및 교육용으로만 사용하도록 의도되었습니다.

**FileUni**는 성능, 보안, 모듈형 배포를 위해 Rust로 구축된 차세대 스토리지 및 파일 관리 플랫폼입니다.

초경량 장치부터 완전한 서버까지, FileUni는 전용 하드웨어 없이 NAS급 기능을 제공하며 CLI, GUI, 웹 구성 요소 전반에 걸쳐 하나의 확장 가능한 코드베이스를 유지합니다.

## 이 저장소의 역할

이 저장소는 FileUni의 공개 프로젝트 허브입니다. 주된 용도는 다음과 같습니다.

- 자동 빌드 및 릴리스 워크플로
- 공개 이슈 및 피드백 수집
- 커뮤니티 대상 프로젝트 조율
- subtree 기반 동기화 대상

주 개발 워크스페이스는 비공개 모노레포에 있으며, 일부 구성 요소가 릴리스와 공개 협업을 위해 이곳으로 동기화됩니다.

## 왜 FileUni인가

- Rust 기반의 고성능 아키텍처
- 다양한 배포 규모를 위한 모듈형 설계
- 전용 하드웨어 없이 NAS 기능 제공
- FTP, SFTP, WebDAV, S3를 포함한 멀티 프로토콜 접근
- 스토리지 환경에 맞춘 신뢰성과 보안 중심 설계

## 관련 저장소

- [OfficialSiteDocs](https://github.com/FileUni/OfficialSiteDocs) - 문서
- [frontends](https://github.com/FileUni/frontends) - 프론트엔드 컴포넌트
- [yh-filemanager-vfs-storage-hub](https://github.com/FileUni/yh-filemanager-vfs-storage-hub) - VFS 코어
- [homebrew-fileuni](https://github.com/FileUni/homebrew-fileuni) - Homebrew tap
- [scoop-fileuni](https://github.com/FileUni/scoop-fileuni) - Scoop bucket
- [nixpkgs-fileuni](https://github.com/FileUni/nixpkgs-fileuni) - Nix package

## 소스 공개 범위

이 저장소에는 FileUni의 공개 프로젝트 레이어가 포함됩니다. 추가 모듈은 시간이 지나며 점진적으로 공개될 수 있습니다.

공개된 소스는 열람, 리뷰, 릴리스 자동화, 그리고 보안 및 감사 가시성을 위해 제공됩니다.

소스 코드 사용 및 라이선스 조건은 [LICENSE](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)를 참조하세요.

사용, 라이선스 또는 협업 관련 문의: `contact@fileuni.com`.
