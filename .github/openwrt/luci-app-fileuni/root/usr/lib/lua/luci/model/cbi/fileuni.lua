local dispatcher = require "luci.dispatcher"
local fs = require "nixio.fs"
local http = require "luci.http"
local i18n = require "fileuni.i18n"
local sys = require "luci.sys"
local uci = require "luci.model.uci".cursor()

local default_runtime_dir = "/var/lib/fileuni"
local default_work_dir = "/var/lib/fileuni"
local default_port = "19000"

local configured_language = i18n.read_configured_language(uci)
local runtime_language = i18n.resolve_runtime_language(configured_language)

local function tr(key)
	return i18n.translate(runtime_language, key)
end

local function trim(value)
	return (value or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function parse_server_bind(config_path)
	if not fs.access(config_path) then
		return nil, default_port, false
	end

	local handle = io.open(config_path, "r")
	if not handle then
		return nil, default_port, false
	end

	local current_section = ""
	local main_ip = nil
	local main_port = nil

	for raw_line in handle:lines() do
		local line = trim(raw_line:gsub("%s*#.*$", ""))
		local section = line:match("^%[([^%]]+)%]$")

		if section then
			current_section = trim(section)
		elseif current_section == "server" then
			local detected_ip = line:match('^main_ip%s*=%s*"(.-)"$')
				or line:match("^main_ip%s*=%s*'(.-)'$")
			if detected_ip and trim(detected_ip) ~= "" then
				main_ip = trim(detected_ip)
			end

			local detected_port = line:match("^main_port%s*=%s*(%d+)$")
			if detected_port and trim(detected_port) ~= "" then
				main_port = trim(detected_port)
			end
		end
	end

	handle:close()
	return main_ip, main_port or default_port, true
end

local function language_buttons()
	local action_url = dispatcher.build_url("admin", "services", "fileuni", "set_lang")
	local redirect_url = dispatcher.build_url("admin", "services", "fileuni")
	local buttons = {}

	for _, item in ipairs(i18n.supported_languages()) do
		buttons[#buttons + 1] = {
			code = item.code,
			label = item.label,
			active = item.code == configured_language,
			url = string.format(
				"%s?lang=%s&redirect=%s",
				action_url,
				http.urlencode(item.code),
				http.urlencode(redirect_url)
			),
		}
	end

	return buttons
end

local function build_language_meta()
	local configured_label = configured_language == "auto"
			and tr("auto_label")
			or i18n.language_label(configured_language)

	return {
		section_title = tr("language_section"),
		hint = tr("language_hint"),
		configured_label = tr("configured_language"),
		effective_label = tr("effective_language"),
		configured_value = configured_label,
		effective_value = i18n.language_label(runtime_language),
		buttons = language_buttons(),
	}
end

local function build_backend_meta()
	local runtime_dir = uci:get("fileuni", "main", "runtime_dir")
		or uci:get("fileuni", "main", "app_data_dir")
		or uci:get("fileuni", "main", "config_dir")
		or default_runtime_dir
	local config_path = runtime_dir .. "/config.toml"
	local host, port, has_config = parse_server_bind(config_path)
	local display_host = host or "router-host"
	local normalized_host = display_host:lower()
	local use_browser_host = normalized_host == ""
		or normalized_host == "0.0.0.0"
		or normalized_host == "::"
		or normalized_host == "127.0.0.1"
		or normalized_host == "localhost"
	local running = sys.call("/etc/init.d/fileuni running >/dev/null 2>&1") == 0
	local binary_exists = fs.access("/usr/bin/fileuni")

	return {
		runtime_dir = runtime_dir,
		config_path = config_path,
		host = host or "",
		port = port,
		has_config = has_config,
		status_text = running and tr("running") or tr("stopped"),
		binary_text = binary_exists and tr("installed") or tr("missing"),
		backend_hint = use_browser_host
			and ("http://<router-ip>:" .. port .. "/ui")
			or ("http://" .. display_host .. ":" .. port .. "/ui"),
		config_detected_text = has_config and tr("config_detected_yes") or tr("config_detected_no"),
		admin_reset_hint = i18n.format(runtime_language, "admin_reset_hint", runtime_dir),
		labels = {
			section_title = tr("backend_access"),
			service_status = tr("service_status"),
			cli_binary = tr("cli_binary"),
			config_file = tr("config_file"),
			detected_backend = tr("detected_backend"),
			config_detected = tr("config_detected"),
			open_backend = tr("open_backend"),
			open_backend_hint = tr("open_backend_hint"),
		},
	}
end

local m = Map("fileuni", tr("page_title"), tr("page_description"))

local status = m:section(SimpleSection)
status.template = "fileuni/status"
status.fileuni_view = {
	language = build_language_meta(),
	backend = build_backend_meta(),
}

local s = m:section(TypedSection, "main", tr("service_section"))
s.anonymous = true
s.addremove = false

local enabled = s:option(Flag, "enabled", tr("enable_on_boot"))
enabled.rmempty = false
enabled.default = enabled.disabled

local runtime_dir = s:option(Value, "runtime_dir", tr("runtime_dir"))
runtime_dir.rmempty = false
runtime_dir.placeholder = default_runtime_dir
runtime_dir.description = tr("runtime_dir_desc")

local work_dir = s:option(Value, "work_dir", tr("work_dir"))
work_dir.rmempty = false
work_dir.placeholder = default_work_dir
work_dir.description = tr("work_dir_desc")

function m.on_after_commit(self)
	local service_script = "/etc/init.d/fileuni"
	if not fs.access(service_script) then
		return
	end

	local boot_enabled = uci:get_bool("fileuni", "main", "enabled")
	if boot_enabled then
		sys.call(service_script .. " enable >/dev/null 2>&1")
		sys.call(service_script .. " restart >/dev/null 2>&1")
	else
		sys.call(service_script .. " stop >/dev/null 2>&1")
		sys.call(service_script .. " disable >/dev/null 2>&1")
	end
end

return m
