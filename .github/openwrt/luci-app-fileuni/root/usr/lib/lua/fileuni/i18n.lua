local dispatcher = require "luci.dispatcher"
local http = require "luci.http"

local M = {}

local supported_languages = {
	{ code = "auto", label = "Auto" },
	{ code = "en", label = "English" },
	{ code = "zh_cn", label = "中文" },
	{ code = "ja", label = "日本語" },
	{ code = "es", label = "Español" },
	{ code = "de", label = "Deutsch" },
	{ code = "fr", label = "Français" },
}

local language_labels = {
	en = "English",
	zh_cn = "中文",
	ja = "日本語",
	es = "Español",
	de = "Deutsch",
	fr = "Français",
}

local language_aliases = {
	en = "en",
	en_us = "en",
	en_gb = "en",
	zh = "zh_cn",
	zh_cn = "zh_cn",
	zh_hans = "zh_cn",
	zh_sg = "zh_cn",
	ja = "ja",
	ja_jp = "ja",
	es = "es",
	es_es = "es",
	es_mx = "es",
	de = "de",
	de_de = "de",
	fr = "fr",
	fr_fr = "fr",
}

local translations = {
	page_title = {
		en = "FileUni",
		zh_cn = "FileUni",
		ja = "FileUni",
		es = "FileUni",
		de = "FileUni",
		fr = "FileUni",
	},
	page_description = {
		en = "Configure the FileUni OpenWrt service, runtime directory, backend shortcut, and built-in language switching.",
		zh_cn = "配置 FileUni 的 OpenWrt 服务、运行目录、后端快捷入口以及内置语言切换。",
		ja = "FileUni の OpenWrt サービス、ランタイムディレクトリ、バックエンドショートカット、内蔵言語切替を設定します。",
		es = "Configura el servicio OpenWrt de FileUni, el directorio de ejecucion, el acceso rapido al backend y el cambio de idioma integrado.",
		de = "Konfiguriert den OpenWrt-Dienst von FileUni, das Laufzeitverzeichnis, den Backend-Schnellzugriff und die integrierte Sprachumschaltung.",
		fr = "Configure le service OpenWrt de FileUni, le repertoire d'execution, le raccourci vers le backend et le changement de langue integre.",
	},
	language_section = {
		en = "Language",
		zh_cn = "语言",
		ja = "言语",
		es = "Idioma",
		de = "Sprache",
		fr = "Langue",
	},
	language_hint = {
		en = "This switch writes LuCI's global language setting (`luci.main.lang`) and reloads the page. `Auto` follows the browser language accepted by LuCI.",
		zh_cn = "这里的切换会写入 LuCI 全局语言设置（`luci.main.lang`）并重新加载页面；`Auto` 会跟随 LuCI 接受的浏览器语言。",
		ja = "ここでの切替は LuCI の全局言语设置（`luci.main.lang`）を書き换えてページを再読み込みします。`Auto` は LuCI が受け付けるブラウザ言语に従います。",
		es = "Este selector escribe la configuracion global de idioma de LuCI (`luci.main.lang`) y recarga la pagina. `Auto` sigue el idioma del navegador aceptado por LuCI.",
		de = "Dieser Schalter schreibt die globale LuCI-Sprachkonfiguration (`luci.main.lang`) und laedt die Seite neu. `Auto` folgt der von LuCI akzeptierten Browsersprache.",
		fr = "Ce selecteur ecrit le parametre global de langue de LuCI (`luci.main.lang`) puis recharge la page. `Auto` suit la langue du navigateur acceptee par LuCI.",
	},
	configured_language = {
		en = "Configured LuCI language",
		zh_cn = "LuCI 配置语言",
		ja = "设置された LuCI 言语",
		es = "Idioma configurado en LuCI",
		de = "Konfigurierte LuCI-Sprache",
		fr = "Langue LuCI configuree",
	},
	effective_language = {
		en = "Current page language",
		zh_cn = "当前页面语言",
		ja = "现在のページ言语",
		es = "Idioma actual de la pagina",
		de = "Aktuelle Seitensprache",
		fr = "Langue actuelle de la page",
	},
	auto_label = {
		en = "Auto",
		zh_cn = "自动",
		ja = "自动",
		es = "Auto",
		de = "Auto",
		fr = "Auto",
	},
	backend_access = {
		en = "Backend Access",
		zh_cn = "后端访问",
		ja = "バックエンドアクセス",
		es = "Acceso al backend",
		de = "Backend-Zugriff",
		fr = "Acces au backend",
	},
	service_status = {
		en = "Service status",
		zh_cn = "服务状态",
		ja = "サービス状态",
		es = "Estado del servicio",
		de = "Dienststatus",
		fr = "Etat du service",
	},
	cli_binary = {
		en = "CLI binary",
		zh_cn = "CLI 二进制",
		ja = "CLI バイナリ",
		es = "Binario CLI",
		de = "CLI-Binaerdatei",
		fr = "Binaire CLI",
	},
	config_file = {
		en = "Config file",
		zh_cn = "配置文件",
		ja = "设置ファイル",
		es = "Archivo de configuracion",
		de = "Konfigurationsdatei",
		fr = "Fichier de configuration",
	},
	detected_backend = {
		en = "Detected backend",
		zh_cn = "检测到的后端",
		ja = "検出されたバックエンド",
		es = "Backend detectado",
		de = "Erkanntes Backend",
		fr = "Backend detecte",
	},
	config_detected = {
		en = "Config detected",
		zh_cn = "检测到配置文件",
		ja = "设置検出",
		es = "Configuracion detectada",
		de = "Konfiguration erkannt",
		fr = "Configuration detectee",
	},
	config_detected_yes = {
		en = "Yes",
		zh_cn = "是",
		ja = "はい",
		es = "Si",
		de = "Ja",
		fr = "Oui",
	},
	config_detected_no = {
		en = "No, fallback port 19000 is used",
		zh_cn = "否，正在使用回退端口 19000",
		ja = "いいえ、フォールバックポート 19000 を使用しています",
		es = "No, se usa el puerto alternativo 19000",
		de = "Nein, es wird der Fallback-Port 19000 verwendet",
		fr = "Non, le port de secours 19000 est utilise",
	},
	open_backend = {
		en = "Open Backend",
		zh_cn = "打开后端",
		ja = "バックエンドを开く",
		es = "Abrir backend",
		de = "Backend oeffnen",
		fr = "Ouvrir le backend",
	},
	open_backend_hint = {
		en = "This opens the FileUni web UI in a new browser tab using the port read from config.toml.",
		zh_cn = "这会根据 `config.toml` 中读取到的端口，在新标签页打开 FileUni Web UI。",
		ja = "`config.toml` から読み取ったポートを使って、新しいタブで FileUni Web UI を开きます。",
		es = "Esto abre la interfaz web de FileUni en una pestana nueva usando el puerto leido desde `config.toml`.",
		de = "Dies oeffnet die FileUni-Weboberflaeche in einem neuen Tab mit dem aus `config.toml` gelesenen Port.",
		fr = "Cela ouvre l'interface web FileUni dans un nouvel onglet avec le port lu depuis `config.toml`.",
	},
	admin_reset_hint = {
		en = "If the admin password is lost, delete `%s/install.lock` and restart FileUni to enter the setup wizard again.",
		zh_cn = "如果管理员密码丢失，请删除 `%s/install.lock` 后重启 FileUni，重新进入设置向导。",
		ja = "管理者パスワードを失った场合は `%s/install.lock` を削除してから FileUni を再起动し、再度セットアップウィザードに入ってください。",
		es = "Si se pierde la contrasena del administrador, elimina `%s/install.lock` y reinicia FileUni para volver a entrar en el asistente de configuracion.",
		de = "Wenn das Administratorpasswort verloren geht, loesche `%s/install.lock` und starte FileUni neu, um den Einrichtungsassistenten erneut zu oeffnen.",
		fr = "Si le mot de passe administrateur est perdu, supprime `%s/install.lock` puis redemarre FileUni pour relancer l'assistant de configuration.",
	},
	running = {
		en = "Running",
		zh_cn = "运行中",
		ja = "実行中",
		es = "En ejecucion",
		de = "Laeuft",
		fr = "En cours d'execution",
	},
	stopped = {
		en = "Stopped",
		zh_cn = "已停止",
		ja = "停止中",
		es = "Detenido",
		de = "Gestoppt",
		fr = "Arrete",
	},
	installed = {
		en = "Installed",
		zh_cn = "已安装",
		ja = "インストール済み",
		es = "Instalado",
		de = "Installiert",
		fr = "Installe",
	},
	missing = {
		en = "Missing",
		zh_cn = "缺失",
		ja = "见つかりません",
		es = "No encontrado",
		de = "Fehlt",
		fr = "Absent",
	},
	service_section = {
		en = "Service",
		zh_cn = "服务",
		ja = "サービス",
		es = "Servicio",
		de = "Dienst",
		fr = "Service",
	},
	enable_on_boot = {
		en = "Enable on boot",
		zh_cn = "开机自启",
		ja = "起动时に自动开机",
		es = "Iniciar al arrancar",
		de = "Beim Start aktivieren",
		fr = "Activer au demarrage",
	},
	runtime_dir = {
		en = "Runtime directory",
		zh_cn = "运行目录",
		ja = "ランタイムディレクトリ",
		es = "Directorio de ejecucion",
		de = "Laufzeitverzeichnis",
		fr = "Repertoire d'execution",
	},
	runtime_dir_desc = {
		en = "Single runtime directory containing config.toml, install.lock, database, cache, and other runtime files.",
		zh_cn = "唯一运行目录，统一存放 `config.toml`、`install.lock`、数据库、缓存和其他运行文件。",
		ja = "`config.toml`、`install.lock`、データベース、キャッシュ、その他の実行ファイルをまとめて置く単一のランタイムディレクトリです。",
		es = "Directorio de ejecucion unico que contiene `config.toml`, `install.lock`, base de datos, cache y otros archivos de ejecucion.",
		de = "Ein einzelnes Laufzeitverzeichnis mit `config.toml`, `install.lock`, Datenbank, Cache und anderen Laufzeitdateien.",
		fr = "Repertoire d'execution unique contenant `config.toml`, `install.lock`, la base de donnees, le cache et les autres fichiers d'execution.",
	},
	work_dir = {
		en = "Working directory",
		zh_cn = "工作目录",
		ja = "作业ディレクトリ",
		es = "Directorio de trabajo",
		de = "Arbeitsverzeichnis",
		fr = "Repertoire de travail",
	},
	work_dir_desc = {
		en = "Process working directory used by procd before FileUni starts. Usually keep it the same as the runtime directory.",
		zh_cn = "procd 在启动 FileUni 前使用的进程工作目录。通常保持与运行目录一致即可。",
		ja = "procd が FileUni を起動する前に使う作業ディレクトリです。通常はランタイムディレクトリと同じで構いません。",
		es = "Directorio de trabajo del proceso usado por procd antes de iniciar FileUni. Normalmente conviene mantenerlo igual que el directorio de ejecucion.",
		de = "Arbeitsverzeichnis des Prozesses, das procd vor dem Start von FileUni verwendet. In der Regel sollte es dem Laufzeitverzeichnis entsprechen.",
		fr = "Repertoire de travail du processus utilise par procd avant le demarrage de FileUni. En general, laissez-le identique au repertoire d'execution.",
	},
	unsupported_language = {
		en = "Unsupported language",
		zh_cn = "不支持的语言",
		ja = "未対応の言语です",
		es = "Idioma no compatible",
		de = "Nicht unterstuetzte Sprache",
		fr = "Langue non prise en charge",
	},
}

local function normalize_key(raw)
	return tostring(raw or "")
		:lower()
		:gsub("-", "_")
		:gsub("%.", "_")
end

local function resolve_supported_language(raw)
	local normalized = normalize_key(raw)
	if language_aliases[normalized] then
		return language_aliases[normalized]
	end

	local short = normalized:match("^([a-z][a-z])")
	if short and language_aliases[short] then
		return language_aliases[short]
	end

	return nil
end

local function parse_accept_language(header)
	for token in tostring(header or ""):gmatch("[^,]+") do
		local candidate = token:match("^%s*([^;]+)")
		local resolved = resolve_supported_language(candidate)
		if resolved then
			return resolved
		end
	end

	return "en"
end

function M.supported_languages()
	return supported_languages
end

function M.language_label(code)
	if code == "auto" then
		return "Auto"
	end

	return language_labels[resolve_supported_language(code) or "en"] or "English"
end

function M.is_supported_config_language(code)
	if code == "auto" then
		return true
	end

	return resolve_supported_language(code) ~= nil
end

function M.read_configured_language(cursor)
	local configured = cursor:get("luci", "main", "lang")
	if configured == nil or configured == "" or configured == "auto" then
		return "auto"
	end

	return resolve_supported_language(configured) or "en"
end

function M.resolve_runtime_language(configured_language)
	if configured_language and configured_language ~= "auto" then
		return resolve_supported_language(configured_language) or "en"
	end

	local context = dispatcher.context
	if type(context) == "table" and context.lang then
		local resolved = resolve_supported_language(context.lang)
		if resolved then
			return resolved
		end
	end

	return parse_accept_language(http.getenv("HTTP_ACCEPT_LANGUAGE"))
end

function M.translate(lang, key)
	local table_for_key = translations[key]
	if not table_for_key then
		return key
	end

	local resolved = resolve_supported_language(lang) or "en"
	return table_for_key[resolved] or table_for_key.en or key
end

function M.format(lang, key, ...)
	return string.format(M.translate(lang, key), ...)
end

function M.ensure_luci_languages(cursor)
	if not cursor:get("luci", "languages") then
		cursor:section("luci", "internal", "languages", {})
	end

	for _, item in ipairs(supported_languages) do
		if item.code ~= "auto" then
			cursor:set("luci", "languages", item.code, item.label)
		end
	end
end

return M
