[English](./README.md) | [简体中文](./README.zh-CN.md) | [Deutsch](./README.de.md) | [Français](./README.fr.md) | [Italiano](./README.it.md) | [日本語](./README.ja.md) | [한국어](./README.ko.md) | [हिन्दी](./README.hi.md) | [Bahasa Indonesia](./README.id.md) | [Tiếng Việt](./README.vi.md) | [ไทย](./README.th.md)

[![Website](https://img.shields.io/badge/Website-fileuni.com-blue)](https://fileuni.com/) [![Language](https://img.shields.io/badge/Language-Rust-orange)](https://www.rust-lang.org/) [![License](https://img.shields.io/badge/License-Proprietary-red)](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE)

# FileUni Project

> ⚠️ सूचना: यह प्रोजेक्ट अभी शुरुआती चरण में है। यह अस्थिर हो सकता है और फिलहाल केवल परीक्षण तथा शैक्षिक उपयोग के लिए है।

**FileUni** एक अगली पीढ़ी का स्टोरेज और फ़ाइल प्रबंधन प्लेटफ़ॉर्म है, जिसे प्रदर्शन, सुरक्षा और मॉड्यूलर डिप्लॉयमेंट के लिए Rust में बनाया गया है।

बहुत हल्के उपकरणों से लेकर पूर्ण सर्वरों तक, FileUni समर्पित हार्डवेयर के बिना NAS जैसी क्षमताएँ प्रदान करता है और CLI, GUI तथा web घटकों के लिए एक ही स्केलेबल कोडबेस बनाए रखता है।

## यह रिपॉजिटरी क्या है

यह रिपॉजिटरी FileUni का सार्वजनिक प्रोजेक्ट हब है। इसका मुख्य उपयोग है:

- स्वचालित build और release workflows
- सार्वजनिक issue tracking और feedback
- community-facing project coordination
- subtree-आधारित downstream sync targets

मुख्य development workspace निजी monorepo में है, और चुने हुए components को release तथा सार्वजनिक सहयोग के लिए यहाँ sync किया जाता है।

## FileUni क्यों

- Rust-आधारित उच्च-प्रदर्शन architecture
- अलग-अलग deployment आकारों के लिए modular design
- dedicated hardware के बिना NAS features
- FTP, SFTP, WebDAV और S3 सहित multi-protocol access
- storage workloads के लिए reliability और security पर फोकस

## संबंधित रिपॉजिटरी

- [OfficialSiteDocs](https://github.com/FileUni/OfficialSiteDocs) - डॉक्यूमेंटेशन
- [frontends](https://github.com/FileUni/frontends) - फ्रंटएंड कंपोनेंट्स
- [yh-filemanager-vfs-storage-hub](https://github.com/FileUni/yh-filemanager-vfs-storage-hub) - VFS कोर
- [homebrew-fileuni](https://github.com/FileUni/homebrew-fileuni) - Homebrew tap
- [scoop-fileuni](https://github.com/FileUni/scoop-fileuni) - Scoop bucket
- [nixpkgs-fileuni](https://github.com/FileUni/nixpkgs-fileuni) - Nix package

## स्रोत उपलब्धता

इस रिपॉजिटरी में FileUni की सार्वजनिक project layer शामिल है। समय के साथ अतिरिक्त modules धीरे-धीरे खोले जा सकते हैं।

प्रकाशित source reading, review, release automation, और security या audit visibility के लिए है।

स्रोत कोड के उपयोग और लाइसेंस शर्तों के लिए सीधे [LICENSE](https://github.com/FileUni/FileUni-Project/blob/main/LICENSE) देखें।

उपयोग, licensing, या collaboration से जुड़े प्रश्नों के लिए संपर्क करें: `contact@fileuni.com`।
