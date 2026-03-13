[English](./README.md) | [简体中文](./README.zh-CN.md) | [Deutsch](./README.de.md) | [Français](./README.fr.md) | [Italiano](./README.it.md) | [日本語](./README.ja.md) | [한국어](./README.ko.md) | [हिन्दी](./README.hi.md) | [Bahasa Indonesia](./README.id.md) | [Tiếng Việt](./README.vi.md) | [ไทย](./README.th.md)

[![Website](https://img.shields.io/badge/Website-fileuni.com-blue)](https://fileuni.com/) [![Language](https://img.shields.io/badge/Language-Rust-orange)](https://www.rust-lang.org/) [![License](https://img.shields.io/badge/License-Proprietary-red)](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)

# FileUni Project

<p align="center">
  <a href="https://fileuni.com"><img src="https://img.shields.io/badge/เว็บไซต์-fileuni.com-blue?style=for-the-badge" alt="เว็บไซต์"></a>
  <a href="https://docs.fileuni.com"><img src="https://img.shields.io/badge/เอกสาร-docs.fileuni.com-green?style=for-the-badge" alt="เอกสาร"></a>
  <a href="https://github.com/FileUni/FileUni-Project"><img src="https://img.shields.io/badge/GitHub-FileUni-black?style=for-the-badge&logo=github" alt="GitHub"></a>
  <a href="https://hub.docker.com/r/fileuni/fileuni"><img src="https://img.shields.io/badge/Docker-fileuni-blue?style=for-the-badge&logo=docker" alt="Docker Hub"></a>
</p>

> ⚠️ หมายเหตุ: โปรเจกต์นี้ยังอยู่ในระยะเริ่มต้น อาจยังไม่เสถียร และขณะนี้มีไว้สำหรับการทดสอบและการใช้งานเพื่อการศึกษาเท่านั้น

**FileUni** คือแพลตฟอร์มจัดการไฟล์และระบบจัดเก็บข้อมูลยุคใหม่ที่พัฒนาด้วย Rust โดยเน้นประสิทธิภาพ ความปลอดภัย และการปรับใช้แบบแยกส่วน

ตั้งแต่อุปกรณ์ขนาดเล็กมากไปจนถึงเซิร์ฟเวอร์เต็มรูปแบบ FileUni ออกแบบมาเพื่อมอบความสามารถแบบ NAS โดยไม่ต้องใช้ฮาร์ดแวร์เฉพาะทาง พร้อมคงไว้ซึ่ง codebase เดียวที่ขยายต่อได้สำหรับ CLI, GUI และส่วนประกอบเว็บ

## รีโพซิทอรีนี้คืออะไร

รีโพซิทอรีนี้เป็นศูนย์กลางโครงการสาธารณะของ FileUni โดยใช้หลัก ๆ สำหรับ:

- เวิร์กโฟลว์ build และ release แบบอัตโนมัติ
- การติดตาม issue และ feedback แบบสาธารณะ
- การประสานงานโครงการกับชุมชน
- ปลายทางการซิงก์แบบ subtree

workspace การพัฒนาหลักอยู่ใน monorepo แบบส่วนตัว และมีการซิงก์บางส่วนมายังที่นี่เพื่อใช้สำหรับ release และการทำงานร่วมกันแบบสาธารณะ

## ทำไมต้อง FileUni

- สถาปัตยกรรมประสิทธิภาพสูงบน Rust
- การออกแบบแบบโมดูลาร์สำหรับหลายขนาดการปรับใช้
- ความสามารถแบบ NAS โดยไม่ต้องใช้ฮาร์ดแวร์เฉพาะ
- การเข้าถึงหลายโปรโตคอล เช่น FTP, SFTP, WebDAV และ S3
- มุ่งเน้นความเชื่อถือได้และความปลอดภัยสำหรับงานด้าน storage

## รีโพซิทอรีที่เกี่ยวข้อง

- [OfficialSiteDocs](https://github.com/FileUni/OfficialSiteDocs) - เอกสาร
- [frontends](https://github.com/FileUni/frontends) - ส่วนประกอบ frontend
- [yh-filemanager-vfs-storage-hub](https://github.com/FileUni/yh-filemanager-vfs-storage-hub) - แกนหลัก VFS
- [homebrew-fileuni](https://github.com/FileUni/homebrew-fileuni) - Homebrew tap
- [scoop-fileuni](https://github.com/FileUni/scoop-fileuni) - Scoop bucket
- [nixpkgs-fileuni](https://github.com/FileUni/nixpkgs-fileuni) - Nix package

## การเปิดเผยซอร์สโค้ด

รีโพซิทอรีนี้มีส่วนโครงการสาธารณะของ FileUni และอาจมีการเปิดโมดูลเพิ่มเติมอย่างค่อยเป็นค่อยไปในอนาคต

ซอร์สโค้ดที่เผยแพร่มีไว้เพื่อการอ่าน การรีวิว การทำ release automation และการมองเห็นด้านความปลอดภัยหรือการตรวจสอบ

เงื่อนไขการใช้งานซอร์สโค้ดและใบอนุญาต โปรดดูที่ [LICENSE](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)

หากมีคำถามเกี่ยวกับการใช้งาน ใบอนุญาต หรือความร่วมมือ โปรดติดต่อ: `contact@fileuni.com`
