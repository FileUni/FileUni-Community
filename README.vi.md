[English](./README.md) | [简体中文](./README.zh-CN.md) | [Deutsch](./README.de.md) | [Français](./README.fr.md) | [Italiano](./README.it.md) | [日本語](./README.ja.md) | [한국어](./README.ko.md) | [हिन्दी](./README.hi.md) | [Bahasa Indonesia](./README.id.md) | [Tiếng Việt](./README.vi.md) | [ไทย](./README.th.md)

[![Website](https://img.shields.io/badge/Website-fileuni.com-blue)](https://fileuni.com/) [![Language](https://img.shields.io/badge/Language-Rust-orange)](https://www.rust-lang.org/) [![License](https://img.shields.io/badge/License-Proprietary-red)](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)

# FileUni Project

> ⚠️ Lưu ý: Dự án này vẫn đang ở giai đoạn đầu. Nó có thể chưa ổn định và hiện chỉ dành cho mục đích thử nghiệm và giáo dục.

**FileUni** là nền tảng lưu trữ và quản lý tệp thế hệ mới được xây dựng bằng Rust, tập trung vào hiệu năng, bảo mật và triển khai theo mô-đun.

Từ thiết bị siêu nhẹ đến máy chủ đầy đủ, FileUni cung cấp khả năng kiểu NAS mà không cần phần cứng chuyên dụng, đồng thời duy trì một codebase thống nhất có thể mở rộng cho CLI, GUI và các thành phần web.

## Kho này là gì

Kho này là trung tâm dự án công khai của FileUni. Nó chủ yếu được dùng cho:

- Quy trình build và release tự động
- Theo dõi issue công khai và phản hồi
- Điều phối dự án hướng tới cộng đồng
- Các đích đồng bộ downstream dựa trên subtree

Workspace phát triển chính nằm trong monorepo riêng tư và một số thành phần được đồng bộ tới đây cho mục đích release và cộng tác công khai.

## Vì sao là FileUni

- Kiến trúc hiệu năng cao dựa trên Rust
- Thiết kế mô-đun cho nhiều quy mô triển khai
- Tính năng NAS không cần phần cứng chuyên dụng
- Truy cập đa giao thức gồm FTP, SFTP, WebDAV và S3
- Tập trung vào độ tin cậy và bảo mật cho bài toán lưu trữ

## Kho liên quan

- [OfficialSiteDocs](https://github.com/FileUni/OfficialSiteDocs) - Tài liệu
- [frontends](https://github.com/FileUni/frontends) - Thành phần frontend
- [yh-filemanager-vfs-storage-hub](https://github.com/FileUni/yh-filemanager-vfs-storage-hub) - Lõi VFS
- [homebrew-fileuni](https://github.com/FileUni/homebrew-fileuni) - Homebrew tap
- [scoop-fileuni](https://github.com/FileUni/scoop-fileuni) - Scoop bucket
- [nixpkgs-fileuni](https://github.com/FileUni/nixpkgs-fileuni) - Gói Nix

## Phạm vi công khai mã nguồn

Kho này chứa lớp dự án công khai của FileUni. Các mô-đun bổ sung có thể sẽ được mở dần theo thời gian.

Mã nguồn được công bố nhằm phục vụ việc đọc, review, tự động hóa release, và khả năng quan sát cho bảo mật hoặc audit.

Điều khoản sử dụng mã nguồn và cấp phép vui lòng xem trực tiếp tại [LICENSE](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE).

Nếu có câu hỏi về sử dụng, cấp phép hoặc hợp tác, vui lòng liên hệ: `contact@fileuni.com`.
